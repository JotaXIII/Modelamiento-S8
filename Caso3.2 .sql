BEGIN
  FOR j IN 1..120 LOOP
    INSERT INTO venta (fecha_venta, total_venta, cod_mpago, cod_empleado)
    SELECT
      TRUNC(SYSDATE) - TRUNC(DBMS_RANDOM.VALUE(0,120)),
      ROUND(DBMS_RANDOM.VALUE(10000,250000)),
      (SELECT id_mpago FROM (SELECT id_mpago FROM medio_pago ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM=1),
      (SELECT id_empleado FROM (
         SELECT v.id_empleado
         FROM vendedor v
         JOIN empleado e ON e.id_empleado = v.id_empleado
         WHERE e.activo='S'
         ORDER BY DBMS_RANDOM.VALUE
       ) WHERE ROWNUM=1)
    FROM dual;
  END LOOP;
END;
/
COMMIT;

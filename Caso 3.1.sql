BEGIN EXECUTE IMMEDIATE 'DELETE FROM vendedor'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DELETE FROM administrativo'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DELETE FROM empleado'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

DECLARE
  v_id     NUMBER;
  v_salud  NUMBER;
  v_afp    NUMBER;
  v_sal    NUMBER;
  v_tipo   VARCHAR2(25);
  v_base8  VARCHAR2(8);
  v_rut    VARCHAR2(10);
BEGIN
  FOR i IN 1..50 LOOP
    SELECT id_salud INTO v_salud FROM (SELECT id_salud FROM salud ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM=1;
    SELECT id_afp   INTO v_afp   FROM (SELECT id_afp   FROM afp   ORDER BY DBMS_RANDOM.VALUE) WHERE ROWNUM=1;

    v_id   := seq_empleado.NEXTVAL;
    v_sal  := 450000 + MOD(i,12)*30000;
    v_tipo := CASE WHEN MOD(i,2)=0 THEN 'VENDEDOR' ELSE 'ADMINISTRATIVO' END;

    v_base8 := LPAD(TO_CHAR(10000000 + i), 8, '0');
    v_rut   := v_base8 || '-' || TO_CHAR(MOD(i,10)); -- largo 10

    INSERT INTO empleado (
      id_empleado, rut_empleado, nombre_empleado, apellido_paterno, apellido_materno,
      fecha_contratacion, sueldo_base, bono_jefatura, activo, tipo_empleado,
      cod_empleado, cod_salud, cod_afp
    ) VALUES (
      v_id, v_rut, 'Empleado'||i, 'P'||i, 'M'||i,
      TRUNC(SYSDATE) - (i*7),
      v_sal,
      CASE WHEN MOD(i,5)=0 THEN 80000 ELSE NULL END,
      CASE WHEN MOD(i,17)=0 THEN 'N' ELSE 'S' END,
      v_tipo,
      NULL,
      v_salud,
      v_afp
    );

    IF v_tipo = 'VENDEDOR' THEN
      INSERT INTO vendedor (id_empleado, comision_venta)
      VALUES (v_id, ROUND(MOD(i,26)/100,2));
    ELSE
      INSERT INTO administrativo (id_empleado) VALUES (v_id);
    END IF;
  END LOOP;
END;
/
COMMIT;

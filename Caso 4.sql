-- INFORME 1
SELECT
  e.id_empleado                                         AS "IDENTIFICADOR",
  e.nombre_empleado || ' ' || e.apellido_paterno || ' ' ||
  e.apellido_materno                                    AS "NOMBRE COMPLETO",
  e.sueldo_base                                         AS "SALARIO",
  e.bono_jefatura                                       AS "BONIFICACION",
  (e.sueldo_base + e.bono_jefatura)                     AS "SALARIO SIMULADO"
FROM empleado e
WHERE e.activo = 'S'
  AND e.bono_jefatura IS NOT NULL
ORDER BY (e.sueldo_base + e.bono_jefatura) DESC,
         e.apellido_paterno DESC;


-- INFORME 2
SELECT
  e.nombre_empleado || ' ' || e.apellido_paterno || ' ' ||
  e.apellido_materno              AS "EMPLEADO",
  e.sueldo_base                   AS "SUELDO",
  0.08                            AS "POSIBLE AUMENTO",
  (e.sueldo_base * 1.08)          AS "SALARIO SIMULADO"
FROM empleado e
WHERE e.sueldo_base BETWEEN 550000 AND 800000
ORDER BY e.sueldo_base ASC;

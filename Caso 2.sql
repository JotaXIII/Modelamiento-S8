ALTER TABLE empleado
  ADD CONSTRAINT empleado_ck_sueldo_minimo CHECK (sueldo_base >= 400000);

ALTER TABLE vendedor
  ADD CONSTRAINT vendedor_ck_comision CHECK (comision_venta IS NULL OR (comision_venta >= 0 AND comision_venta <= 0.25));

ALTER TABLE producto
  ADD CONSTRAINT producto_ck_stock_minimo CHECK (stock_minimo >= 3);

ALTER TABLE proveedor
  ADD CONSTRAINT proveedor_un_email UNIQUE (email);

ALTER TABLE marca
  ADD CONSTRAINT marca_un_nombre UNIQUE (nombre_marca);

ALTER TABLE detalle_venta
  ADD CONSTRAINT detalle_venta_ck_cantidad_positiva CHECK (cantidad > 0);

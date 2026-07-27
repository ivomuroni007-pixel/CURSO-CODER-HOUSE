USE Ventas_Tech_DB_2;

--CONSULTA N°1-- 
SELECT 
MONTH (fecha_venta) AS mes,
SUM(cantidad*precio_unitario) AS total_facturado,
COUNT(*) AS cantidad_pedidos, 
AVG(cantidad*precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH (fecha_venta);

--CONSULTA N°2-- 
SELECT TOP 5
id_producto,
SUM(cantidad)  AS unidades_vendidas, 
SUM(cantidad*precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC; 

--CONSULTA N°3-- 
SELECT
id_cliente,
COUNT(*) AS cantidad_pedidos,
SUM (cantidad*precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*)>1;

--CONSULTA N°4-- 
SELECT
mes, total_facturado, promedio_mensual,
CASE WHEN total_facturado > promedio_mensual THEN 'Por encima'
ELSE 'Por debajo'
END AS comparacion_promedio
FROM (
SELECT 
MONTH (fecha_venta) AS mes,
SUM(cantidad*precio_unitario) AS total_facturado,
AVG(cantidad*precio_unitario) AS promedio_mensual
FROM ventas
GROUP BY MONTH(fecha_venta)
) AS resumen_mensual;

--Los 2 productos con Id : 1 y 3 ; representan el 80% del total facturado del mes. Tambien son los productos que menos unidades se vendieron. Es decir, estos productos generan alta facturacion a una tasa de venta baja--
--El producto con mayor cantidad de unidades vendidas es el que menos factura (último en el TOP 5).--
--El rendimiento del mes fue por encima del promedio mensual facturado.--

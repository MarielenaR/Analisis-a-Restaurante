--¿Cuál es el artículo menos caro y el más caro en el menú?
-- Artículo más caro
SELECT item_name, price
FROM menu_items
ORDER BY price DESC
LIMIT 1;

-- Artículo menos caro
SELECT item_name, price
FROM menu_items
ORDER BY price ASC
LIMIT 1;

--¿Cuántos platos americanos hay en el menú?

SELECT COUNT(*) AS total_american_dishes
FROM menu_items
WHERE category = 'American';


--¿Cuál es el precio promedio de los platos?

SELECT AVG(price) AS average_price
FROM menu_items;

--¿Cuántos pedidos únicos se realizaron en total?
SELECT COUNT(DISTINCT order_id) AS total_unique_orders
FROM order_details;

--¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
SELECT order_id, COUNT(order_details_id) AS total_items
FROM order_details
GROUP BY order_id
ORDER BY total_items DESC
LIMIT 5;

--¿Cuándo se realizó el primer pedido y el último pedido?
-- Primer pedido
SELECT MIN(order_date) AS first_order_date, MIN(order_time) AS first_order_time
FROM order_details;

-- Último pedido
SELECT MAX(order_date) AS last_order_date, MAX(order_time) AS last_order_time
FROM order_details;

--¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?
SELECT COUNT(DISTINCT order_id) AS orders_between_dates
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';

1.- Realizar un left join entre entre order_details y menu_items con el identificador
item_id(tabla order_details) y menu_item_id(tabla menu_items).

SELECT 
    o.order_id,
    o.order_details_id,
    o.order_date,
    o.order_time,
    m.item_name,
    m.category,
    m.price
FROM 
    order_details o
LEFT JOIN 
    menu_items m
ON 
    o.item_id = m.menu_item_id;
--Destacar los artículos más populares

SELECT 
    mi.item_name,
    COUNT(od.item_id) AS total_pedidos
FROM 
    order_details od
JOIN 
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY 
    mi.item_name
ORDER BY 
    total_pedidos DESC
LIMIT 5;  -- Los 5 artículos más populares son:

--Hamburger
--Edamame
--Korean Beef Bowl
--Cheeseburger
--French

--Producto mas costoso pero menos consumido

SELECT 
    mi.item_name,
    mi.price,
    COUNT(od.item_id) AS total_pedidos
FROM 
    order_details od
JOIN 
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY 
    mi.item_name, mi.price
ORDER BY 
    total_pedidos ASC, mi.price DESC
LIMIT 1;

Chicken Tacos, deberían considerar reemplazarlos en el menu

--Cantidad de Pedidos por categoria

SELECT 
    mi.category, 
    COUNT(od.item_id) AS cantidad_pedidos
FROM 
    order_details od
JOIN 
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY 
    mi.category
ORDER BY 
    cantidad_pedidos DESC;

La comida Asiatica es la más cosumida

--Pero al considerar el ingreso por categoría

SELECT 
    mi.category, 
    SUM(mi.price) AS ingresos_totales
FROM 
    order_details od
JOIN 
    menu_items mi ON od.item_id = mi.menu_item_id
GROUP BY 
    mi.category
ORDER BY 
    ingresos_totales DESC;

La italiana es la que más ingresos genera





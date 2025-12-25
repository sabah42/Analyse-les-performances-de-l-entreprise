-- Analyse des perfermances logistiques 
-- KPI 1: Stock total
SELECT 
    SUM(quantityInStock) AS stock_total
FROM products;
-- KPI 2: Quantité totale commandée
SELECT 
    SUM(quantityOrdered) AS total_commandes
FROM orderdetails;

-- KPI 3: le stock des 5 produits les plus commandés
SELECT 
sum(od.quantityOrdered) as quantite_commandee,
p.productName,  p.quantityInStock as stock_actuel 
FROM products p
inner join orderdetails od
ON p.productCode= od.productCode
group by productName, stock_actuel
order by quantite_commandee desc
limit 5;

 -- KPI 4: Stock des 5 produits les moins commandés
SELECT 
    p.productName,
    IFNULL(SUM(od.quantityOrdered), 0) AS quantite_commandee,
    p.quantityInStock AS stock_actuel
FROM products p
LEFT JOIN orderdetails od 
    ON p.productCode = od.productCode
GROUP BY 
    p.productName,
    p.quantityInStock
ORDER BY quantite_commandee ASC
LIMIT 5;
-- KPI 5: Ratio Demande (Stock / Commandes)
SELECT 
    p.productName,
    p.quantityInStock / SUM(od.quantityOrdered) AS ratio_demande
FROM products p
INNER JOIN orderdetails od 
    ON p.productCode = od.productCode
GROUP BY 
    p.productName,
    p.quantityInStock;
-- KPI 6: Indice de Risque Stock (Commandes / Stock)
SELECT 
    p.productName,
    SUM(od.quantityOrdered) / p.quantityInStock AS indice_risque_stock
FROM products p
INNER JOIN orderdetails od 
    ON p.productCode = od.productCode
GROUP BY 
    p.productName,
    p.quantityInStock;
-- KPI 7: Comparaison Stock disponible vs Demande cumulée
SELECT 
    DATE_FORMAT(o.orderDate, '%Y-%m') AS mois,
    SUM(od.quantityOrdered) AS commandes_mensuelles
FROM orders o
JOIN orderdetails od 
    ON o.orderNumber = od.orderNumber
GROUP BY DATE_FORMAT(o.orderDate, '%Y-%m')
ORDER BY mois;



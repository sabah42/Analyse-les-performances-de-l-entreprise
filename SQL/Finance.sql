-- Analyse la perfermance financière
-- KPI 1: Chiffre d'affaires total
SELECT 
ROUND(sum(priceEach * quantityOrdered),2) AS chiffre_affaires_total FROM orderdetails;
-- KPI 2: Nombre total de commandes
select
count(distinct(orderNumber)) AS nbre_total_commande from orders;
-- Kpi 3: Nombre de commandes en attente
SELECT
count(distinct(orderNumber)) AS commandes_en_attente FROM orders where status = "On Hold";

-- KPI 4: Montant total en attente
select sum(od.priceEach * od.quantityOrdered) as montant_en_attent from orderdetails od
join orders o on od.orderNumber=o.orderNumber where o.status = "On Hold";

-- KPI 5: Nombre de clients avec paiement en attente
SELECT COUNT(DISTINCT customerNumber) as nb_clients_en_attente
FROM orders
WHERE status = 'On Hold';
-- KPI 6: Montant restant des paiements (impayés) a voir
SELECT 
    ca.chiffre_affaires_total - p.montant_encaisse AS montant_impaye
FROM 
(
    SELECT 
        SUM(od.quantityOrdered * od.priceEach) AS chiffre_affaires_total
    FROM orders o
    JOIN orderdetails od 
        ON o.orderNumber = od.orderNumber
    WHERE o.status IN ('Shipped', 'Resolved')
) ca,
(
    SELECT 
        SUM(amount) AS montant_encaisse
    FROM payments
) p;


-- KPI 7:  Nombre de commandes annulées
SELECT 
    COUNT(*) AS nb_commandes_annulees
FROM orders
WHERE status = 'Cancelled';

-- KPI 8: Montant total annulé
SELECT 
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS montant_annule
FROM orders o
JOIN orderdetails od 
    ON o.orderNumber = od.orderNumber
WHERE o.status = 'Cancelled';

-- KPI 9: Chiffre d’affaires sur deux mois consécutifs
SELECT 
    DATE_FORMAT(o.orderDate, '%Y-%m') AS mois,
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS chiffre_affaires
FROM orders o
JOIN orderdetails od 
    ON o.orderNumber = od.orderNumber
WHERE o.status = 'Shipped'
GROUP BY mois
ORDER BY mois;





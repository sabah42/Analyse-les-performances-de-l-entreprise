-- KPI 1 – Chiffre d’affaires total
SELECT 
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS chiffre_affaires_total
FROM orders o
JOIN orderdetails od 
    ON o.orderNumber = od.orderNumber
WHERE o.status IN ('Shipped', 'Resolved');

-- KPI 2: Nombre total de commandes
SELECT 
    COUNT(*) AS total_commandes
FROM orders;

-- KPI 3: Top vendeurs les plus actifs
SELECT 
    CONCAT(e.firstName, ' ', e.lastName) AS vendeur,
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS chiffre_affaires
FROM employees e
JOIN customers c 
    ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o 
    ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
    ON o.orderNumber = od.orderNumber
WHERE o.status IN ('Shipped', 'Resolved')
GROUP BY vendeur
ORDER BY chiffre_affaires DESC;
-- KPI 4 – Top vendeurs les moins actifs
SELECT 
    CONCAT(e.firstName, ' ', e.lastName) AS vendeur,
    IFNULL(SUM(od.quantityOrdered * od.priceEach), 0) AS chiffre_affaires
FROM employees e
LEFT JOIN customers c 
    ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN orders o 
    ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails od 
    ON o.orderNumber = od.orderNumber
  WHERE o.status IN ('Shipped', 'Resolved')
GROUP BY vendeur
ORDER BY chiffre_affaires ASC;

-- KPI 5 – Chiffre d’affaires par employé
SELECT 
    CONCAT(e.firstName, ' ', e.lastName) AS employe,
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS chiffre_affaires
FROM employees e
JOIN customers c 
    ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o 
    ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
    ON o.orderNumber = od.orderNumber
WHERE o.status IN ('Shipped', 'Resolved')
GROUP BY employe;

-- KPI 6: Chiffre d’affaires par manager
SELECT 
    CONCAT(m.firstName, ' ', m.lastName) AS manager,
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS chiffre_affaires
FROM employees e
JOIN employees m 
    ON e.reportsTo = m.employeeNumber
JOIN customers c 
    ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o 
    ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
    ON o.orderNumber = od.orderNumber
WHERE o.status IN ('Shipped', 'Resolved')
GROUP BY manager;
-- KPI 7: Montants impayés par employé
WITH ca_client AS (
    SELECT 
        c.customerNumber,
        SUM(od.quantityOrdered * od.priceEach) AS ca_facture
    FROM customers c
    JOIN orders o 
        ON c.customerNumber = o.customerNumber
    JOIN orderdetails od 
        ON o.orderNumber = od.orderNumber
    WHERE o.status IN ('Shipped', 'Resolved')
    GROUP BY c.customerNumber
),

paiements_client AS (
    SELECT 
        customerNumber,
        SUM(amount) AS montant_encaisse
    FROM payments
    GROUP BY customerNumber
)

SELECT 
    CONCAT(e.firstName, ' ', e.lastName) AS employe,
    ROUND(
        SUM(ca.ca_facture - IFNULL(p.montant_encaisse, 0)),
        2
    ) AS montant_impaye
FROM employees e
JOIN customers c 
    ON e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN ca_client ca 
    ON c.customerNumber = ca.customerNumber
LEFT JOIN paiements_client p 
    ON c.customerNumber = p.customerNumber
GROUP BY employe
ORDER BY montant_impaye DESC;
-- kpi 8: CA des commandes On Hold par employé 
SELECT 
    CONCAT(e.firstName, ' ', e.lastName) AS employe,
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS ca_on_hold
FROM employees e
JOIN customers c 
    ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o 
    ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
    ON o.orderNumber = od.orderNumber
WHERE o.status = 'On Hold'
GROUP BY employe
ORDER BY ca_on_hold DESC;
-- KPI 9: CA des commandes Cancelled par employé 
SELECT 
    CONCAT(e.firstName, ' ', e.lastName) AS employe,
    ROUND(SUM(od.quantityOrdered * od.priceEach), 2) AS ca_cancelled
FROM employees e
JOIN customers c 
    ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o 
    ON c.customerNumber = o.customerNumber
JOIN orderdetails od 
    ON o.orderNumber = od.orderNumber
WHERE o.status = 'Cancelled'
GROUP BY employe
ORDER BY ca_cancelled DESC;



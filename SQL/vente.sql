-- Analyse la perfermance des ventes
WITH ventes_base AS (
    SELECT
        YEAR(o.orderDate) AS annee,
        p.productLine AS categorie,
        od.quantityOrdered,
        od.priceEach,
        p.buyPrice
    FROM orderdetails od
    JOIN orders o ON od.orderNumber = o.orderNumber
    JOIN products p ON od.productCode = p.productCode
)
-- KPI 1: Nombre total de produits vendus
SELECT sum(quantityOrdered) AS quantite_total_vendu 
FROM ventes_base;
-- KPI 2: La marge brute par catégorie
WITH ventes_base AS (
    SELECT
        YEAR(o.orderDate) AS annee,
        p.productLine AS categorie,
        od.quantityOrdered,
        od.priceEach,
        p.buyPrice
    FROM orderdetails od
    JOIN orders o ON od.orderNumber = o.orderNumber
    JOIN products p ON od.productCode = p.productCode
)
SELECT
    categorie,
    SUM((priceEach - buyPrice) * quantityOrdered) AS marge_brute
FROM ventes_base
GROUP BY categorie
ORDER BY marge_brute DESC;
-- KPI 3: Quantitées Vendus par Catégorie

WITH ventes_base AS (
    SELECT
        YEAR(o.orderDate) AS annee,
        p.productLine AS categorie,
        od.quantityOrdered,
        od.priceEach,
        p.buyPrice
    FROM orderdetails od
    JOIN orders o ON od.orderNumber = o.orderNumber
    JOIN products p ON od.productCode = p.productCode
)
SELECT
    categorie,
    SUM(quantityOrdered) AS quantite_vendu
FROM ventes_base
GROUP BY categorie
ORDER BY quantite_vendu DESC;
-- kpi 4: Quantité vendue par année
WITH ventes_base AS (
    SELECT
        YEAR(o.orderDate) AS annee,
        p.productLine AS categorie,
        od.quantityOrdered,
        od.priceEach,
        p.buyPrice
    FROM orderdetails od
    JOIN orders o ON od.orderNumber = o.orderNumber
    JOIN products p ON od.productCode = p.productCode
)
SELECT
    annee,
    SUM(quantityOrdered) AS quantite_vendue
FROM ventes_base
GROUP BY annee
ORDER BY annee;

-- kpi 5: Comparaison N/N-1
WITH ventes_base AS (
    SELECT
        od.quantityOrdered,
        YEAR(o.orderDate) AS annee
    FROM orderdetails od
    JOIN orders o 
        ON od.orderNumber = o.orderNumber
),
ventes_par_annee AS (
    SELECT
        annee,
        SUM(quantityOrdered) AS quantite_vendue
    FROM ventes_base
    GROUP BY annee
)
SELECT
    annee,
    quantite_vendue,
    quantite_vendue 
        - LAG(quantite_vendue) OVER (ORDER BY annee) AS evolution,
    CASE 
        WHEN LAG(quantite_vendue) OVER (ORDER BY annee) = 0 
             OR LAG(quantite_vendue) OVER (ORDER BY annee) IS NULL
        THEN NULL
        ELSE ROUND(
            (quantite_vendue - LAG(quantite_vendue) OVER (ORDER BY annee)) * 100.0 /
            LAG(quantite_vendue) OVER (ORDER BY annee), 2
        )
    END AS taux_evolution
FROM ventes_par_annee
ORDER BY annee;




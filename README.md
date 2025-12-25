# Analyse-les-performances-de-l-entreprise
## Table des matières
- [Description du projet](#description-du-projet)
- [Contenu du projet](#contenu-du-projet)
- [Objectifs du projet](#objectifs-du-projet)
- [Structure du projet](#structure-du-projet)
- [Étapes principales](#étapes-principales)
- [Principaux insights](#principaux-insights)
- [Recommandations](#recommandations)
- [Compétences utilisées](#compétences-utilisées)
- [Résultats](#résultats)
  
## Description du projet
Ce projet consiste à analyser les performances d’une entreprise commerciale (Classic Models) à partir d’une base de données relationnelle.
L’objectif est de transformer des données brutes en indicateurs décisionnels à l’aide de SQL (MySQL) et Power BI, afin d’aider les équipes métier à mieux piloter l’activité.
L’analyse couvre quatre axes métier :
- Ventes
- Finance
- Logistique
- Ressources Humaines
## Contenu du projet
- Analyse des données en SQL (MySQL)
- Calcul et validation des KPI
- Recalcul des indicateurs dans Power BI (DAX)
- Création de 4 pages de dashboard interactives
- Rédaction d’un document d’analyse métier (Word)
## Objectifs du projet
- Comprendre la performance globale de l’entreprise
- Identifier les produits, catégories et équipes les plus performants
- Analyser la rentabilité, les risques financiers et les impayés
- Optimiser la gestion des stocks et des flux logistiques
- Comparer les performances dans le temps (N vs N-1)
 ## Structure du projet
 Analyse-les-performances-de-l-entreprise/
│

├── sql/

  │   ├── vente.sql # KPI ventes (quantités, marges, saisonnalité, N/N-1)

│   ├── Finance.sql  # KPI financiers (CA, commandes, impayés, annulations)

│   ├── Logistique.sql # KPI stocks et flux

│   └── Ressource humain.sql  # KPI performance commerciale des employés


├──  powerbi/

│   └── analyse des ventes.pbix # Dashboard Power BI

├── images/

|   ├── vente.png  # Capture page Ventes

|   ├── finance.png  # Capture page Finance

|   ├── logistique.png  # Capture page Logistique

|   ├── rh.png  # Capture page RH

├──  documentation/

│   └── analyse_kpi.pdf  # Explication détaillée des KPI et questions métier

│
└── README.md


## Étapes principales
- Exploration et compréhension du schéma de données
- Calcul des KPI en SQL pour vérifier la cohérence des résultats
- Import des données dans Power BI
- Recalcul des KPI en DAX pour validation croisée
- Création de dashboards interactifs et orientés métier

 ## Principaux insights
- Certaines catégories génèrent un fort volume de ventes mais une faible marge
- La saisonnalité impacte fortement les performances commerciales
- Une partie du chiffre d’affaires est bloquée par des commandes On Hold
- Quelques clients et employés concentrent une part importante du risque financier
- Des produits présentent un risque de surstock ou de rupture

## Recommandations

| Prioriser les catégories à forte marge, pas uniquement à fort volume
- Renforcer le suivi des commandes On Hold et des paiements en attente
- Ajuster les stratégies commerciales selon la saisonnalité
- Optimiser les stocks pour limiter le surstock et les ruptures
- Mettre en place un suivi managérial sur les équipes les plus exposées aux risques

## Compétences utilisées

- SQL (MySQL) : jointures, agrégations, fonctions analytiques (LAG, OVER)
- Power BI : DAX, modélisation, time intelligence, visualisation
- Analyse métier et prise de décision
- Data storytelling
- Validation et cohérence des indicateurs

 ## Résultats

- 4 pages de dashboards interactifs
- Indicateurs fiables et validés
- Vision transversale de la performance de l’entreprise
- Support d’aide à la décision pour les équipes métier


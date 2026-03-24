# 🛍️ Segmentation des clients d'un site e-commerce (Olist)

![Python](https://img.shields.io/badge/Python-3.10+-3776ab?style=flat)
![SQL](https://img.shields.io/badge/SQL-Queries-4479A1?style=flat)
![Task](https://img.shields.io/badge/Task-Clustering_%7C_RFM-4caf50?style=flat)
![Library](https://img.shields.io/badge/Library-Scikit--Learn-f7931e?style=flat)

Ce dépôt contient mon travail pour le Projet 5 du parcours Data Scientist d'OpenClassrooms. L'objectif est d'accompagner Olist, une entreprise brésilienne proposant une solution de vente sur les marketplaces en ligne.

## 📝 Contexte du Projet

Dans le cadre de la constitution de la nouvelle équipe Data d'Olist, j'interviens en tant que consultant pour répondre à deux problématiques :
1. **Soutien Data Analytics (SQL) :** Aider la Lead Data Analyst (Fernanda) à implémenter des requêtes SQL urgentes pour alimenter un Dashboard au service des équipes Customer Experience.
2. **Data Science & Marketing :** Créer un modèle de segmentation (clustering) permettant de différencier les comportements clients, afin que l'équipe Marketing puisse optimiser ses campagnes de communication.

## 🎯 Objectifs

* Réaliser des requêtes d'extraction de données en SQL pour le suivi des KPIs de l'entreprise (vendeurs, localisations, etc.).
* Comprendre les différents types d’utilisateurs grâce à leur comportement d'achat et à leurs données personnelles en utilisant des méthodes non supervisées.
* Réaliser un Feature Engineering orienté métier, en créant notamment une matrice **RFM** (Récence, Fréquence, Montant).
* Proposer un **contrat de maintenance** basé sur une analyse de la stabilité des segments au cours du temps.



## 🛠️ Méthodologie

1. **Extraction (SQL) :** Requêtage de la base de données relationnelle en utilisant des clauses `WITH AS` et différentes jointures pour répondre aux besoins du service client.
2. **Préparation et Feature Engineering :** Nettoyage des données, agrégation au niveau "Client unique" et création des variables comportementales (RFM, scores de satisfaction).
3. **Modélisation (Clustering) :**
   * Standardisation des données.
   * Entraînement et comparaison de différents algorithmes d'apprentissage non supervisé (ex: K-Means).
   * Utilisation de métriques quantitatives data-driven (Score de Silhouette, méthode du coude) pour définir le nombre optimal de clusters.
4. **Analyse de Stabilité :** Entraînement du modèle sur une période initiale, puis prédiction sur des périodes successives pour mesurer la dérive des clusters (Data Drift) via le score **ARI (Adjusted Rand Index)**.

## 📂 Structure du dépôt

* `requête.sql` : Script contenant les requêtes SQL demandées pour le Dashboard Customer Experience.
* `Segmentez des clients d'un site e-commerce.ipynb` : Notebook contenant l'analyse exploratoire (EDA), le Feature Engineering et la modélisation des différents algorithmes de clustering.
* `Contrat de maintenance.ipynb` : Notebook dédié à la simulation temporelle et au calcul du score ARI pour déterminer la fréquence de mise à jour du modèle.

## 📊 Résultats obtenus

* **Dashboard CX :** Les requêtes SQL ont permis d'extraire les KPIs essentiels avec succès.
* **Segmentation Marketing :** Le clustering a permis de dégager des profils clients distincts et exploitables par le métier (ex: bons et moins bons clients), répondant au besoin de ciblage d'Olist.
* **Contrat de Maintenance :** Le suivi du score ARI a permis de formuler une recommandation précise sur la fréquence de ré-entraînement nécessaire pour que la segmentation reste pertinente au fil du temps.

## 🚀 Instructions d'Exécution

1. Clonez ce dépôt.
2. Téléchargez le jeu de données "Brazilian E-Commerce Public Dataset by Olist" sur Kaggle.
3. (Optionnel) Utilisez le fichier `requête.sql` dans votre SGBD (ex: DBeaver, Workbench).
4. Exécutez `Segmentez des clients d'un site e-commerce.ipynb` pour générer le dataset RFM et visualiser la création des clusters.
5. Exécutez `Contrat de maintenance.ipynb` pour visualiser la courbe de stabilité temporelle.

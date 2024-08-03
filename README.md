# Organize and Delete Script

Ce script bash est utilisé pour organiser des fichiers PDF dans des dossiers par ville et supprimer des dossiers non nécessaires. Il compte également le nombre de fichiers en français et en anglais, et vérifie les paires de fichiers manquants pour chaque ville.

## Fonctionnalités

1. **Organisation des fichiers PDF :**

    - Les fichiers PDF sont déplacés dans des dossiers par ville.
    - Le script vérifie si le fichier est en français ou en anglais.

2. **Suppression des dossiers inutiles :**

    - Les dossiers dont le nom correspond au motif `prenom.nom@epitech.eu` sont supprimés.

3. **Vérification des paires de fichiers :**
    - Le script vérifie si chaque fichier a son homologue en français ou en anglais et indique les fichiers manquants.

## Utilisation

### Prérequis

- Bash shell (Windows Subsystem for Linux recommandé sur Windows 10/11).
- Vos fichiers PDF doivent être dans un dossier racine.

### Étapes

1. **Clonez ou téléchargez le script :**

    - Placez le script `organize_and_delete.sh` dans le dossier contenant vos fichiers PDF.

2. **Rendre le script exécutable :**

    ```bash
    chmod +x organize_and_delete.sh
    ```

3. **Exécuter le script :**

    ```bash
    ./organize_and_delete.sh
    ```

## Explication du script

Le script effectue les actions suivantes :

1. **Définition des variables :**
   - `YEAR` et `SEMESTER` sont définis pour filtrer les fichiers par année et semestre.

2. **Organisation des fichiers :**
   - Parcourt les dossiers.
   - Déplace les fichiers PDF dans les dossiers de ville correspondants.
   - Compte le nombre de fichiers en français et en anglais pour chaque ville.

3. **Suppression des dossiers inutiles :**
   - Supprime les dossiers dont le nom correspond au motif `prenom.nom@epitech.eu`.

4. **Affichage des résultats :**
   - Affiche le nombre de fichiers en français et en anglais par ville.
   - Affiche un récapitulatif total.
   - Affiche le nombre de dossiers supprimés.

5. **Vérification des paires de fichiers :**
   - Vérifie la présence des paires de fichiers (français et anglais) pour chaque ville.
   - Affiche les fichiers manquants.

## Exemple de sortie

\```
=====================
Organisation terminée.
=====================
Résultats :
---------------------
Ville : Paris
  Fichiers en français : 115
  Fichiers en anglais : 114
---------------------
...

Récapitulatif des totaux :
  Fichiers en français : 500
  Fichiers en anglais : 495
=====================

Suppression terminée.
Nombre de dossiers en excédant supprimés : 1953

Vérification des paires de fichiers :
  hoppy.lechat@epitech.eu_2024_Paris version anglaise manquante
  prénom.nom@epitech.eu_2024_Toulouse version anglaise manquante
  ...
\```

## Remarques

- Assurez-vous de faire une sauvegarde de vos fichiers avant d'exécuter le script.
- Le script doit être exécuté dans le dossier contenant vos fichiers PDF pour fonctionner correctement.
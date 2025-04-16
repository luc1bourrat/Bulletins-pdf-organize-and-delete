#!/bin/bash

# Définir les variables pour l'année et le semestre
YEAR="2024"
SEMESTER="10"

# Assurez-vous que nous sommes dans le bon répertoire
cd "$(dirname "$0")"

# Déclarer un tableau associatif pour compter les fichiers par ville
declare -A city_counts_fr
declare -A city_counts_en

# Variables pour compter les fichiers totaux
total_fr=0
total_en=0

# Organiser les fichiers PDF dans des dossiers par ville
for dir in */ ; do
    # Vérifier si c'est un répertoire
    if [ -d "$dir" ]; then
        # Rechercher les fichiers PDF dans le répertoire
        for file in "$dir"*.pdf; do
            # Vérifier si le fichier existe
            if [ -f "$file" ]; then
                # Extraire la ville du nom de fichier
                if [[ "$file" =~ _${YEAR}_([A-Za-z]+)_Semester\ ${SEMESTER} ]]; then
                    city="${BASH_REMATCH[1]}"
                    # Créer le répertoire de la ville s'il n'existe pas
                    mkdir -p "$city"
                    # Déplacer le fichier dans le répertoire de la ville
                    mv "$file" "$city/"
                    # Vérifier si le fichier est en français ou en anglais
                    if [[ "$file" =~ _fr\.pdf$ ]]; then
                        ((city_counts_fr[$city]++))
                        ((total_fr++))
                    else
                        ((city_counts_en[$city]++))
                        ((total_en++))
                    fi
                fi
            fi
        done
    fi
done

echo -e "=====================\nOrganisation terminée.\n====================="

# Afficher les résultats
#### Collecter toutes les villes (union des clefs des deux tableaux)
declare -A all_cities
for city in "${!city_counts_fr[@]}"; do
    all_cities[$city]=1
done
for city in "${!city_counts_en[@]}"; do
    all_cities[$city]=1
done
#### Afficher les résultats pour chaque ville, même si uniquement FR ou EN
echo "Résultats :"
for city in "${!all_cities[@]}"; do
    echo "---------------------"
    echo "Ville : $city"
    echo "  Fichiers en français : ${city_counts_fr[$city]:-0}"
    echo "  Fichiers en anglais : ${city_counts_en[$city]:-0}"
done

# Afficher le récapitulatif des totaux
echo -e "\n====================="
echo "Récapitulatif des totaux :"
echo "  Fichiers en français : $total_fr"
echo "  Fichiers en anglais : $total_en"
echo -e "=====================\n"

# Compteur pour les dossiers supprimés
deleted_count=0

# Supprimer les dossiers avec des noms de la forme prenom.nom@epitech.eu
for dir in */ ; do
    # Supprimer le dernier slash pour obtenir le nom du dossier
    dir=${dir%/}
    # Vérifier si le nom du dossier correspond au motif prenom.nom@epitech.eu
    if [[ "$dir" =~ ^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        # Supprimer le répertoire et son contenu
        rm -rf "$dir"
        # Incrémenter le compteur de dossiers supprimés
        ((deleted_count++))
    fi
done

echo -e "Suppression terminée.\nNombre de dossiers en excédant supprimés : $deleted_count\n"

# Vérification des paires de fichiers
echo "Vérification des paires de fichiers :"
for city in "${!city_counts_fr[@]}"; do
    city_dir="$city"
    has_missing_files=false
    if [ -d "$city_dir" ]; then
        cd "$city_dir"
        for file in *_${YEAR}_${city}_Semester\ ${SEMESTER}.pdf; do
            if [ -f "$file" ]; then
                base_name="${file%_Semester ${SEMESTER}.pdf}"
                if [ ! -f "${base_name}_Semester ${SEMESTER}_fr.pdf" ]; then
                    if [ "$has_missing_files" = false ]; then
                        has_missing_files=true
                    fi
                    echo "  $base_name version française manquante"
                fi
            fi
        done
        for file in *_${YEAR}_${city}_Semester\ ${SEMESTER}_fr.pdf; do
            if [ -f "$file" ]; then
                base_name="${file%_Semester ${SEMESTER}_fr.pdf}"
                if [ ! -f "${base_name}_Semester ${SEMESTER}.pdf" ]; then
                    if [ "$has_missing_files" = false ]; then
                        has_missing_files=true
                    fi
                    echo "  $base_name version anglaise manquante"
                fi
            fi
        done
        cd ..
    fi
    if [ "$has_missing_files" = true ]; then
        echo ""
    fi
done

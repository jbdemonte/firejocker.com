---
layout: post
date: 2020-07-15
title: Clone Everdrive N8 et carte SD sous Mac
excerpt: Préparation de la carte SD pour le clone d'un Everdrive N8 avec un Mac
image: thumb.jpg
categories: [Divers]
tags: [Nintendo, Everdrive]
---

Aujourd'hui, j'ai reçu mon clone d'everdrive N8 acheté sur [Ali](https://fr.aliexpress.com/item/4000299659343.html).

{% image_gallery %}
    clone-everdrive-n8-nintendo-nes.jpg
{% endimage_gallery %}

La cartouche est propre et semble assez qualitative. Cependant, je ne suis pas fans de la SD qui est fournie, enfin, du moins de l'organisation de ses répertoires :

{% image_gallery %}
    N8-folders.png
    N8-games.png
{% endimage_gallery %}

{% spacer %}

J'ai donc entrepris de faire ma propre carte SD (J'ai évidement pas modifié celle fournie... au cas ou).

Voici les quelques informations que j'ai pu glaner sur le [web](http://krikzz.com/forum/index.php?topic=2554.0) concernant le format à utiliser :

- Formatter la SD en FAT32
- Pas plus de 256 éléments dans un répertoire (J'ai organisé par premiere Lettre)
- Jeux non zippé (format *.nes) 

Ce que j'ai pu tester :

- Pas de soucis avec les noms de jeu à rallonge
- Pas de soucis avec le fait que la SD ai un nom même si j'ai souvent vu qu'il n'en fallait pas

Le clone utilise les fichiers officiels de krikzz, le mien contenait [nesos-v1.23.zip](http://krikzz.com/pub/support/everdrive-n8/original-series/OS/) (j'ai vérifié les md5).

{% spacer %}

## Formater la carte SD pour le clone de l'everdrive N8 pour Nintendo NES avec le Mac

Donc, pour formater une carte SD avec un Mac (macOS Catalina) pour cet everdrive, ouvrir un invité de commande puis :
 
Identifier la carte SD avec :

    diskutil list
    
La mienne est sur */dev/disk2*, donc c'est ce que j'utiliserai dans la commande suivante

Formatter alors la carte en FAT32 avec MBR sur le Mac avec :

    diskutil eraseDisk MS-DOS N8 MBR /dev/disk2
    
J'ai nommé ma carte SD *N8*, c'est évidemment remplaçable.

## Copier l'OS sur la SD

Télécharger le dernier nesOS sur la [page de téléchargement de Krikzz](http://krikzz.com/pub/support/everdrive-n8/original-series/OS/) puis le décompresser à la racine de la carte SD

## Copier les jeux

Décompresser les jeux sur la carte SD, en respectant le fait de ne pas en mettre plus de 256 dans un répertoire

## Enjoy

Remettre la SD dans la cartouche et jouer :D

{% spacer %}

## Les commandes

### Charger un jeu

Démarrez votre Famicom / NES. Vous pouvez maintenant naviguer dans la structure des fichiers comme dans l'explorateur Windows ou le Finder de Mac.

- Utiliser "B" pour "Valider"
- Utiliser "A" pour "Revenir"
- "SELECT" affiche le menu
- "START" lance le dernier jeu chargé

### Chargement et sauvegarde des états de jeu

Pour chaque jeu, vous pouvez faire un "instantané" des progrès en cours. Pour ce faire, appuyez sur une combinaison de boutons que vous pouvez configurer vous-même 

- Démarrez votre console
- Lorsque le système d'exploitation Everdrive est chargé, appuyez sur "SELECT".
- Choisissez "Options" et appuyez sur B
- Choisissez les options de chargement et de sauvegarde des jeux
- Suivez les instructions (c'est-à-dire appuyez sur la combinaison que vous voulez utiliser pour le chargement ou la sauvegarde)



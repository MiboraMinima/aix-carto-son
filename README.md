# Ébauche d'une cartophonie interactive du paysage sonore du littoral de l'île d'Aix

Cette cartographie a été réalisée dans le cadre de l'Unité d'Enseignement Aire Marine Protégée du master Expertise et Gestion de l'Environnement Littoral (Université de Bretagne Occidentale). \
Dans le cadre de cette UE, les étudiants du master se déplacent sur un territoire géré par une AMP afin d'y réaliser des études proposées par les gestionnaires. En février 2023, les étudiants se sont rendus sur l'île d'Aix où ils ont conduit trois études proposées par le Parc naturel marin de l'estuaire de la Gironde et de la mer des Pertuis sur les paysages sous-marins.

Un des projets portait plus particulièrement sur les paysages sonores[^1]. L'étude réalisée propose plusieurs méthodologies ainsi que des résultats indicatifs permettant d'évaluer le paysage sonore de l'île d'Aix. La carte présentée ici correspond à une data visualisation (intégrant une composante phonique) des résultats d'une des méthodologies développées : la balade sonore littorale.\
L'objectif de cette balade est de rendre compte du paysage sonore que les promeneurs sont susceptibles d'entendre lorsqu'ils marchent sur le sentier littoral de l'île d'Aix et ce, à plusieurs heures de la journée.

## Méthodologie de la balade sonore

Une balade sonore a été conçue avec des prises de son de trois minutes captées simultanément tous les 100 mètres. Aucun point particulier n'a été identifié à l’avance dans la mesure où l'objectif était de rendre compte de l'ambiance sonore lors d'une promenade "typique" autour de l'île en suivant le sentier côtier. Deux points de départ ont été choisis : l’embarcadère de Fouras pour prendre en compte la traversée depuis le continent et le port de l’île (point `Z_0`). Le fait que le captage ait été réalisé avec cinq opérateur.e.s implique que les derniers enregistrements sont décalés d'environ une heure par rapport aux premiers. 

Les sons sont intimement corrélés au temps, ils varient continuellement et de manière souvent cyclique (rythme nycthéméral, cycles des marées, saisons, etc.). Dans le cadre de la réflexion conduite durant l'étude, il était nécessaire d'identifier des échelles temporelles cohérentes pour l’échantillonnage. Ainsi, une ballade a été réalisée à 14 heures et une autre à 21 heures de telle sorte à obtenir un paysage sonore diurne et un autre nocturne.

Les sons recueillis ont été qualifiés selon une typologie standard séparant les sons d'origine biologique (biophonie), atmosphérique, marine, géologique (géophonique) et anthropique (anthropophonie). Pour chaque enregistrement, les sons dominants ont également été identifiés (tableau ci-dessous).

| **Anthropophonie** |           **Biophonie**          | **Géophonie** |
|:--------------:|:----------------------------:|:---------:|
|     Travaux    |           Avifaune           | Vent      |
|     Bateau     |            Insecte           | Ressac    |
|     Voiture    |   Son de mammifères marins   | Pluie     |
|   Discussion   | Craquement de pommes de pin | Tonnerre  |
|       ...      |              ...             | ...       |

## La cartophonie interactive

La cartophonie interactive a été réalisée à l'aide du package `leaflet` de `R`. Le travail devant être conduit en quatre jours, l'utilisation de `R` permettait de produire un résultat correct en peu de temps. Si la carte devait être reproduite, l'utilisation de la bibliothèque javascript `leaflet` ainsi que d'une base de données spatiale semblerait plus pertinente, la personnalisation de l'interface serait également facilitée par l'utilisation de styles `CSS`.

Le *popup* de la cartophonie contient :
- L'identifiant du point (*e.g.* `A_0`)
- L'ambiance paysagère telle que définie par Gaëtan Jolly en 2019 (mémoire de master 2, EGEL)
- Les résultats de l'analyse :
  - La catégorie de son dominante (*e.g.* biophonie)
  - Le son dominant (*e.g.* avifaune)
- L'enregistrement

En fonction du navigateur utilisé ainsi que de sa version, la cartographie peut rencontrer des problèmes d'affichage, c'est également une des limites liées à l'utilisation de `R`.

## Limites

Il convient de mettre en avant que le travail a été réalisé en peu de temps (4 jours au total, un après-midi pour la carte) et qu'ainsi **il s'agit avant tout d'une ébauche**.

[^1]: L'étude a été réalisée par Luca Desmares, Alice Ferrari, Charlotte Guiet, Perrine Guillemenot et Antoine Le Doeuff.
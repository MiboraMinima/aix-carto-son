##//////////////////////////////////////
## AIX BALLADE SONORE
##
## CARTE INTERACTIVE
##//////////////////////////////////////

library(leaflet)
library(leaflegend)
require(sf) # pour lire les shapefile
library(tidyverse)
library(magrittr)
library(mapsf)
library(readxl)
library(htmlwidgets)

# PALETTE
my_pal <- palette(c("#9ad5e7", "#97c684", "#efc86d", "#9d9d9c"))

# LOCALISATION POINTS METHODO ----
## import and clean data ----
bal_son_ap <- read_sf("DATA/SHP/ballade_son_lab.shp")
bal_son_ap %<>% sf::st_transform('+proj=longlat +datum=WGS84')

bal_son_soir <- read_sf("DATA/SHP/ballade_son_soir.shp")
bal_son_soir %<>% sf::st_transform('+proj=longlat +datum=WGS84')

# Importer les stat
df_son_ap <- read_csv("DATA/son_aprem.csv")
bal_son_ap <- left_join(bal_son_ap, df_son_ap)
bal_son_ap %<>%
  mutate(amb_pay_lab = case_when(
    amb_pay == "plaine_vase" ~ "plaine vaseuse",
    amb_pay == "falaise" ~ "falaise",
    amb_pay == "platier" ~ "platiers rocheux",
    amb_pay == "fosse_stCa" ~ "Fosse de Sainte-Catherine",
  ))
bal_son_ap %<>%
  mutate(son_dom = case_when(
    son_dom == "Antropophonique" ~ "Anthropophonique",
    TRUE ~ son_dom
  ))


df_son_soir <- read_csv("DATA/son_soir.csv")
bal_son_soir <- left_join(bal_son_soir, df_son_soir)
bal_son_soir %<>%
  mutate(amb_pay_lab = case_when(
    amb_pay == "plaine_vase" ~ "plaine vaseuse",
    amb_pay == "falaise" ~ "falaise",
    amb_pay == "platier" ~ "platiers rocheux",
    amb_pay == "fosse_stCa" ~ "Fosse de Sainte-Catherine",
  ))
bal_son_soir %<>%
  mutate(son_dom = case_when(
    son_dom == "Antropophonique" ~ "Anthropophonique",
    TRUE ~ son_dom
  ))


# Charger les sons
bal_son_ap %<>%
  mutate(son_aprem = paste("DATA/AUDIO/BALLADE/APREM/", label, ".mp3", sep = ''))
bal_son_soir %<>%
  mutate(son_soir = paste("DATA/AUDIO/BALLADE/SOIR/", label, ".mp3", sep = ''))

# Le Popup
bal_son_ap$popup <- with(bal_son_ap,
                      paste(
                        "<div>
                           <b>Identifiant :</b> ", label,"<br>
                           <b>Ambiance paysagère :</b> ", amb_pay_lab,"<br>
                           <b>Catégorie de son dominante :</b> ", son_dom,"<br>
                           <b>Son dominant :</b> ", sous_cat,"<br>
                           <br>
                           <table><tr><td>
                           <audio controls><source src=\"",son_aprem,"\"type='audio/mpeg'></audio>
                           </td></tr></table>
                           </div>"
                        )
                      )

bal_son_soir$popup <- with(bal_son_soir,
                         paste(
                           "<div>
                           <b>Identifiant :</b> ", label,"<br>
                           <b>Ambiance paysagère :</b> ", amb_pay_lab,"<br>
                           <b>Catégorie de son dominante :</b> ", son_dom,"<br>
                           <b>Son dominant :</b> ", sous_cat,"<br>
                           <br>
                           <table><tr><td>
                           <audio controls><source src=\"",son_soir,"\"type='audio/mpeg'></audio>
                           </td></tr></table>
                           </div>"
                          )
                         )


## lealfet ----
pal <- colorFactor(
  palette = my_pal,
  domain = bal_son_soir$son_dom
)

leaf_son <- leaflet() %>% 
  addProviderTiles(providers$CartoDB.Positron, group = "Positron") %>%
  addProviderTiles(providers$CartoDB.DarkMatter, group = "DarkMatter") %>%
  addProviderTiles(providers$GeoportailFrance.orthos, group = "Orthophoto") %>%
  
  addCircleMarkers(
    data = bal_son_ap,
    popup = ~as.character(popup),
    label = ~as.character(label),
    labelOptions = labelOptions(noHide = F, direction = 'auto'),
    options = markerOptions(riseOnHover = TRUE),
    fillOpacity = 1,
    color = ~pal(son_dom),
    stroke = F, # whether to draw stroke along the path (e.g. the borders of polygons or circles)
    radius = 5,
    group = "Balade de l'après-midi (14h)"
  ) %>%
  
  addCircleMarkers(
    data = bal_son_soir,
    popup = ~as.character(popup),
    label = ~as.character(label),
    labelOptions = labelOptions(noHide = F, direction = 'auto'),
    options = markerOptions(riseOnHover = TRUE),
    # fillColor = "yellow",
    fillOpacity = 1,
    color = ~pal(son_dom),
    stroke = F, # whether to draw stroke along the path (e.g. the borders of polygons or circles)
    radius = 5,
    group = "Balade du soir (21h30)"
  ) %>%
  
  addLayersControl(
    baseGroups = c("Positron", "DarkMatter","Orthophoto"),
    overlayGroups = c("Balade de l'après-midi (14h)", "Balade du soir (21h30)"),
    options = layersControlOptions(collapsed = F)
  ) %>%
  addLegendFactor(
    pal = pal,
    title = htmltools::tags$div('Type de son dominant', style = 'font-size: 12px; margin-bottom: 5px;'),
    labelStyle = 'font-size: 12px;',
    values = bal_son_soir$son_dom,
    position = 'bottomright',
    # shape = 'triangle',
    width = 30,
    height = 15)
leaf_son
saveWidget(leaf_son, file="aix_balade_sonore.html")







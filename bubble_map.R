
# Bubble map -------------------------------------------------------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 28/05/22 ---------------------------------------------------------------------------------------------------------------------------
# Referência: The R Graph Galery -----------------------------------------------------------------------------------------------------------

# Conceito ---------------------------------------------------------------------------------------------------------------------------------

### Bubble maps são mapas com marcadores no topo. Esses marcadores podem ser círculos
### com tamanhos proporcionais aos valores numéricos, resultando é um bubble map.
### Antes de explorar essa seção, aprenda como construir o background do mapa com R.

# Bubble maps interativos com o pacote leaflet ---------------------------------------------------------------------------------------------

### O pacote leaflet do R é um invólucro da biblioteca javascript.js. Ele permite 
### construir mapas interativos com R em minutos. Os mapas podem ser exportados em
### html, ou inseridos em arquivos RMarkdown e shiny. 

# Exemplo de mapa com o pacote leaflet -----------------------------------------------------------------------------------------------------

### Os dados mostra um conjunto de terramotos e a sua intensidade no Oceano Pacífico.

### A entrada necessária para construir tal mapa é uma lista de coordenadas GPS, 
### com um valor numérico atribuído a cada local para controlar o tamanho e a cor 
### da bolha.

### Os marcadores são adicionados utilizando a função addCircleMarkers(), e a cor da 
### bolha é mapeada para uma construção à escala de cores com a função binning.

# Baixar pacote ----------------------------------------------------------------------------------------------------------------------------

library(leaflet)

# Criar dados com várias posições ----------------------------------------------------------------------------------------------------------

data_red <- data.frame(LONG = 42 + rnorm(10), LAT = 23 + rnorm(10), 
                       PLACE = paste("Red_place_",seq(1,10)))
data_blue <- data.frame(LONG = 42 + rnorm(10), LAT = 23 + rnorm(10), 
                        PLACE = paste("Blue_place_", seq(1,10)))

# Iniciando o leaflet map ------------------------------------------------------------------------------------------------------------------

m <- leaflet() %>% 
  setView(lng = 42, lat = 23, zoom = 6 ) %>%

  # Add two tiles/backgrounds
  addProviderTiles("Esri.WorldImagery", group = "background 1") %>%
  addTiles(options = providerTileOptions(noWrap = TRUE), group = "background 2") %>%

  # Add 2 marker groups
  addCircleMarkers(data = data_red, lng = ~ LONG , lat = ~ LAT, radius = 8 , 
                   color = "black",
                   fillColor = "red", stroke = TRUE, fillOpacity = 0.8, 
                   group = "Red") %>%
  addCircleMarkers(data = data_blue, lng = ~ LONG , lat = ~ LAT, radius = 8 , 
                   color = "black",
                   fillColor = "blue", stroke = TRUE, fillOpacity = 0.8, 
                   group = "Blue") %>%

  # Adicionar o widget de controle
  addLayersControl(overlayGroups = c("Red","Blue") , baseGroups = c("background 1","background 2"), 
                   options = layersControlOptions(collapsed = FALSE))

m

# Salvar arquivo ---------------------------------------------------------------------------------------------------------------------------

# save the widget in a html file if needed.
# library(htmlwidgets)
# saveWidget(m, file=paste0( getwd(), "/HtmlWidget/bubblemapControl.html"))
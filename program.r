# 鄉鎮市區界線(TWD97經緯度) https://data.gov.tw/dataset/7441
# 直轄市、縣市界線(TWD97經緯度) https://data.gov.tw/dataset/7442
library(leaflet)
library(rgdal)
library("randomcoloR")

twn <- readOGR(dsn="maps/TOWN_MOI_1081121.shp", layer="TOWN_MOI_1081121", encoding="UTF-8")
twn.taipei <- twn[which(twn@data$COUNTYNAME == "臺北市"), ]

# 測試資料
ALAND <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
twn.taipei@data$TESTDATA <- ALAND

pal <- colorBin("YlOrRd", domain = twn.taipei$TOWNID, bins = ALAND)

m = leaflet(twn.taipei) %>%  
	addPolygons(color = "#444444", 
		fillOpacity = 0.5, weight = 1, smoothFactor = 0.5, 
		fillColor = ~colorQuantile("YlOrRd", twn.taipei@data$TESTDATA)(twn.taipei@data$TESTDATA), 
		highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)) %>% 
	addLegend(pal = pal, values = twn.taipei@data$TESTDATA, opacity = 0.7, title = NULL,  position = "bottomright") %>% 
	addTiles() 
m


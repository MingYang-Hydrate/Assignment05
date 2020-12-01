
library(sp)
library(rgdal)
library(sf)
library(raster)
library(maps)
library(ggplot2)
library(fields)

#1.2
#Precipitation
# Get files name of .tif
temp_p <- list.files(path='D:/Assignment/R_Assignment05/prec',pattern="*.tif")
setwd('D:/Assignment/R_Assignment05/prec')
total_prec   <- raster(temp_p[1])
  for(i in 2:12) {
    # Open the tif files
     month_prec   <- raster(temp_p[i])
  
    # Annual long term mean
    total_prec=total_prec+month_prec
  }
  
  # Find the annual average prec for one year
  annual_prec = total_prec/12
# Look at the raster attributes
annual_prec


#Wind speed
temp_w <- list.files(path='D:/Assignment/R_Assignment05/wind',pattern="*.tif")
setwd('D:/Assignment/R_Assignment05/wind')
total_wind   <- raster(temp_w[1])
for(i in 2:12) {
  # Open the tif files
  month_wind   <- raster(temp_w[i])
  
  # Annual long term mean
  total_wind=total_wind+month_wind
}

# Find the annual average wind speed for one year
annual_wind = total_wind/12
# Look at the raster attributes
annual_wind


#Solar radiation
temp_s <- list.files(path='D:/Assignment/R_Assignment05/srad',pattern="*.tif")
setwd('D:/Assignment/R_Assignment05/srad')
total_srad   <- raster(temp_s[1])
for(i in 2:12) {
  # Open the tif files
  month_srad   <- raster(temp_s[i])
  
  # Annual long term mean
  total_srad=total_srad+month_srad
}

# Find the annual average solar radiation for one year
annual_srad = total_srad/12
# Look at the raster attributes
annual_srad

# Read china map, a shape file
China_map <- readOGR("D:/Assignment/R_Assignment05/China_map", "bou2_4p") 
# Check the attributes 
summary(China_map)

# Define the crop extent
Crop_box <- China_map

# Crop the raster
Wind_crop <- crop(annual_wind,China_map)
Wind_China <- mask(Wind_crop,China_map)

Prec_crop <- crop(annual_prec,China_map)
Prec_China <- mask(Prec_crop,China_map)

Srad_crop <- crop(annual_srad,China_map)
Srad_China <- mask(Srad_crop,China_map)
# Plot 
col_w <- terrain.colors(30)
plot(Wind_China, main="Wind speed ",col=col_w)

plot(Prec_China, main="Precipitation",col=col_w)

plot(Srad_China, main="Solar radiation ")
map('world',add=T,lwd=0.5,col="black")

#1.3
col_w <- terrain.colors(30)
plot(Wind_China, main="Wind speed ",col=col_w,zlim=c(0,6.87))
plot(Wind_China, main="Wind speed ",col="red",zlim=c(4,6.87),add=T,legend=F)

#1.4
PV <-  (Srad_China > 16000 & Prec_China <42)
plot(PV,legend=F,main="Better locations of PV farms")

#半干旱地区年降水量350ml-500ml，对应选择月平均降水量阈值42ml

























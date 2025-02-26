# rSolarDB

R Library to access SolarDB - a time series database for solar radiation and meteorological data from the Indian Ocean Solar Network (IOSnet).

This package provides functions to query and analyze data from multiple monitoring stations across South West Indian Ocean (SWIO), including:

🌞 Solar radiation measurements:
- GHI (Global Horizontal Irradiance)
- DHI (Diffuse Horizontal Irradiance)
- DNI (Direct Normal Irradiance)

🌡️ Meteorological data:
- TA (Temperature)
- RH (Relative Humidity)
- PA (atmospheric pressure)
- WS & WD (Wind speed & direction)

For more information visit <https://galilee.univ-reunion.fr> 🔍

## Installation

Please install first the `devtools` library :

```r
install.packages("devtools")
```

Then install package `rSolarDB` from Github :

```r
devtools::install_github("LE2P/rSolarDB")
```

You will also need a token to allow access data, please use the register method at
<https://solardb.univ-reunion.fr> to register and obtain a token by email.

## Login, Status and Logout

**OPTIONAL :** You can first configure the `~/.Renviron` file in your home directory
to allow `rSolarDB` package to know your authentication token. If set, the package
will automatically launch `login()` on  package load.

```env
solardb_token=YOURTOKENHERE
```

### Login

```r
sdb_login()

# OR without configure .Renviron

sdb_login(token="PUTYOURTOKENHERE")
```

### Status

```r
sdb_status()
```

### Logout

```r
sdb_logout()
```

## List of alias site, types and sensors

### Alias sites

```r
sdb_sites()
```

### Types

```r
sdb_types()
```

### Sensors ids

```r
sdb_sensors()
sdb_sensors(sites="leportbarbusse")
```

## Get data from SolarDB

Get raw data from SolarDB (date store into string):

```r
# Last 7 days on Piton des Neiges and Saint Louis Jean Joly
d <- sdb_data(sites = "saintlouisjeanjoly,pitondesneiges", start = "-7d", type = "GHI")
d$saintlouisjeanjoly$GHI_pr01_Avg$values |> plot(type='l')
d$pitondesneiges$GHI_qu01_Avg$values |> lines(type='l', col=2)
```

Get data from SolarDB using time series library Xts :

```r
d <- sdb_data(sites = "pitondesneiges", start = "-7d", type = "GHI,DHI", format = "xts")
plot(d$pitondesneiges$GHI_qu01_Avg)
lines(d$pitondesneiges$DHI_qu01_Avg, col = '2')
```

Plot Xts data using dygraph :

```r
library(dygraphs)
dd <- cbind(d$pitondesneiges$DHI_qu01_Avg, d$pitondesneiges$GHI_qu01_Avg)
dygraph(dd) |> dyRangeSelector()
```

Get data into `data.table` format :

```r
iosnet <- c("amitie", "anseboileau", "antananarivo", "diego", "hahaya", "ouani", "reservetortues", "vacoas")
d <- sdb_data(sites = iosnet, types = "GHI,DHI", format="data.table")
d
```

## Get metadata from SolarDB

### Campaigns

```r
sdb_campaigns()
sdb_campaigns(territory = "Mauritius")
```

### Measures

```r
sdb_measures()
sdb_measures(type="DHI")
sdb_measures(type="DHI", nested=TRUE)
```

### Instruments

```r
sdb_instruments()
```

### Models

```r
sdb_models()
sdb_models(type = "Meteorological")
```

## Some Shiny Apps

### Missings

Shiny app to plot a calendar with count of missing data for each day. To launch
app :

```r
sdb_shiny_missings()
```

## Deprecated functions

The following functions are deprecated and will be removed in future versions:

- `sites()` -> use `sdb_sites()` instead
- `types()` -> use `sdb_types()` instead 
- `sensors()` -> use `sdb_sensors()` instead
- `getData()` -> use `sdb_data()` instead
- `getXtsData()` -> use `sdb_data(format = "xts")` instead
- `getDtData()` -> use `sdb_data(format = "data.table")` instead
- `getDataCountByDay()` -> use `sdb_daily_counts()` instead
- `getBounds()` -> use `sdb_bounds()` instead
- `register()` -> use `sdb_register()` instead
- `login()` -> use `sdb_login()` instead
- `logout()` -> use `sdb_logout()` instead
- `instruments()` -> use `sdb_instruments()` instead
- `measures()` -> use `sdb_measures()` instead
- `models()` -> use `sdb_models()` instead
- `missings()` -> use `sdb_shiny_missings()` instead

All deprecated functions will display a warning message when used. Please update your code to use the new function names with the `sdb_` prefix.

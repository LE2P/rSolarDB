# rSolarDB

R Library to access SolarDB database

## Installation

Please install first the `devtools` library :

```R
install.packages("devtools")
```

Then install package `rSolarDB` from Github :

```R
devtools::install_github("LE2P/rSolarDB")
```

You will also need a token to allow access data, please use the register method at
<https://solardb.univ-reunion.fr> to register and obtain a token by email.

## Login, Status and Logout

**OPTIONAL :** You can first configure the `~/.Renviron` file in your home directory
to allow `rSolarDB` package to know your authentication token. If set, the package
will automatically launch `login()` on  package load.

```
solardb_token=YOURTOKENHERE
```

### Login

```R
login()

# OR without configure .Renviron

login(token="PUTYOURTOKENHERE")
```

### Status

```R
status()
```

### Logout

```R
logout()
```

## List of alias site, types and sensors

### Alias sites

```R
sites()
```

### Types

```R
types()
```

### Sensors ids

```R
sensors()
sensors(sites="leportbarbusse")
```

## Get data from SolarDB

Get raw data from SolarDB (date store into string):

```R
# Last 7 days on Piton des Neiges and Saint Louis Jean Joly
d <- getData(sites = "saintlouisjeanjoly,pitondesneiges", start = "-7d", type = "GHI")
d$saintlouisjeanjoly$GHI_pr01_Avg$values %>% plot(type='l')
d$pitondesneiges$GHI_qu01_Avg$values %>% lines(type='l', col=2)
```

Get data from SolarDB using time series library Xts :

```R
d <- getXtsData(sites = "pitondesneiges", start = "-7d", type = "GHI,DHI")
plot(d$pitondesneiges$GHI_qu01_Avg)
lines(d$pitondesneiges$DHI_qu01_Avg, col = '2')
```

Plot Xts data using dygraph :

```R
library(dygraphs)
dd <- cbind(d$pitondesneiges$DHI_qu01_Avg, d$pitondesneiges$GHI_qu01_Avg)
dygraph(dd) %>% dyRangeSelector()
```

Get data into `data.table` format : 

```R
iosnet <- c("amitie", "anseboileau", "antananarivo", "diego", "hahaya", "ouani", "reservetortues", "vacoas")
d <- getDtData(sites = iosnet, types = "GHI,DHI")
d
```

## Get metadata from SolarDB

### Campaigns

```R
campaigns()
campaigns(territory = "Mauritius")
```

### Measures

```R
measures()
measures(type="DHI")
measures(type="DHI", nested=TRUE)
```

### Instruments

```R
instruments()
```

### Models

```R
models()
models(type = "Meteorological")
```

## Some Shiny Apps

### Missings

Shiny app to plot a calendar with count of missing data for each day. To launch
app :

```R
missings()
```

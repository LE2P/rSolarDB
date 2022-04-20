# rSolarDB

R Library to access SolarDB database 

## Login, Status and Logout

OPTIONAL : Your can first configure the `~/.Renviron` file in your home directory
to allow `rSolarDB` package to know your authentication token.

See <https://solardb.univ-reunion.fr> to register and obtaint a token. 

```
solardb_token=YOURTOKENHERE
```

### Login 

```R
login()

# OR 

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

## Get metadata from SolarDB

Coming soon

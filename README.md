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

## Todo

- deal with 404 errors : trycatch on 200


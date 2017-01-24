# kokiake standalone server

kokiake is pandoc front-end application (web service).

the `Dockerfile` provides standalone server.

## run

### production environment

#### docker-compose

```
kokiake-standalone:
  build: kokiake-standalone
  environment:
    - KOKIAKE_ENV=production
  volumes:
    - /etc/localtime:/etc/localtime:ro
    - /opt/kokiake/workspace:/workspace
    - /opt/kokiake/mongodb:/data/db
  ports:
    - "8080:8080"
```

### development environment

### docker-compose

```
kokiake-standalone:
  build: kokiake-standalone
  environment:
    - KOKIAKE_ENV=development
    - MONGOD_ALL_BIND
  volumes:
    - /etc/localtime:/etc/localtime:ro
    - /opt/kokiake/workspace:/workspace
    - /opt/kokiake/mongodb:/data/db
  ports:
    - "8080:8080"
    - "27017:27017"
```

## settings

### environment

`KOKIAKE_ENV` is switcher to select kokiake environment. set either `development` or `production`.

if `MONGOD_ALL_BIND` set, bind mongod on  0.0.0.0.

### volumes

`/workspace` is kokikake program/config directory. please execute commands/operation follow.
- `git clone https://github.com/imamochi-momu/kokiake.git .`
- `cp server/config/kokikake.sample.toml server/config/kokikake.toml`
- edit `server/config/kokikake.toml`

`/data/db` is mongodb database directory.

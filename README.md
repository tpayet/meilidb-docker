# Docker for [MeiliDB](https://github.com/Kerollmops/MeiliDB)

## Usage

### Dockerfile
```bash
$> docker build . -t meilidb
$> docker run --rm -it -p 8080:8080 meilidb
```

### MeiliDB

#### Create index
```bash
$> curl -X "POST" "http://localhost:8080/create" \
        -H 'Content-Type: application/json; charset=utf-8' \
        -d $'{ "name": "simple", "schema": { "attributes": { "id": { "stored": true, "indexed": true }, "title": { "stored": true, "indexed": true }, "number": { "indexed": true } }, "identifier": "id" } }'
```

#### Index documents
```bash
$> curl -X "PUT" "http://localhost:8080/index/simple/ingest" \
        -H 'Content-Type: application/json; charset=utf-8' \
        -d $'{ "insert": [ { "id": "1", "title": "je suis une patate", "number": "3" }, { "id": "2", "title": "je suis une tulipe", "number": "3" } ] }'
```

#### Search query
```bash
$> curl "http://localhost:8080/index/simple/search?q=pata&limit=20"
```

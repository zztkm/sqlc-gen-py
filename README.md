# sqlc-gen-py

sqlc-gen-py is a plugin for [sqlc](https://sqlc.dev/) that generates an ORM (now, support SQLAlchemy only) for Python.

This softwaer forked from [sqlc-gen-python](https://github.com/sqlc-dev/sqlc-gen-python) and modified to generate ORM and MySQL support.

## Usage

get sha256 hash of wasm file

```bash
curl -sSL https://github.com/zztkm/sqlc-gen-py/releases/download/v0.0.2/sqlc-gen-py.wasm.sha256
```

add plugin to sqlc.yaml
```yaml
version: '2'
plugins:
- name: py
  wasm:
    url: https://github.com/zztkm/sqlc-gen-py/releases/download/v0.0.2/sqlc-gen-py.wasm
    sha256: <sha256 hash>
sql:
- schema: "schema.sql"
  queries: "query.sql"
  engine: mysql
  codegen:
  - out: gen/sqlc
    plugin: py
    options:
      package: .
      emit_sync_querier: true
      emit_sqlalchemy_models: false
```

## Refs

- [sqlc plugin を書こう - 薄いブログ](https://orisano.hatenablog.com/entry/2023/09/06/010926)

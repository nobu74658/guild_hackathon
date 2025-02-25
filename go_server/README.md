# go_server

## 環境構築

### Goのインストール

ここではasdfを使ったGoのインストールを紹介します。

```bash
git clone https://github.com/asdf-vm/asdf.git --branch v0.16.0
export PATH="$PATH:$(go env GOPATH)/bin"
source ~/.zshrc
```

```bash
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf install golang 1.23.2
asdf global golang 1.23.2
```

### Go関連のツールのインストール

#### godotenv

```bash
go install github.com/joho/godotenv/cmd/godotenv@latest
```

#### goose

```bash
go install github.com/pressly/goose/v3/cmd/goose@latest
```

### 環境変数

`/go_server/.env`に環境変数を設定してください

#### ローカルDB

ローカルでDBを構築し、接続する場合は以下のように設定してください

```bash
KNITTING_SERVER_CLOUDSQL_CONN_NAME=
KNITTING_SERVER_DB_HOST=127.0.0.1
KNITTING_SERVER_DB_PORT=3306
KNITTING_SERVER_DB_USER=root
KNITTING_SERVER_DB_PASSWORD=
KNITTING_SERVER_DB_NAME=knitting

GOOSE_DRIVER=mysql
GOOSE_DBSTRING="$KNITTING_SERVER_DB_USER:$KNITTING_SERVER_DB_PASSWORD@tcp($KNITTING_SERVER_DB_HOST:$KNITTING_SERVER_DB_PORT)/$KNITTING_SERVER_DB_NAME?parseTime=true"
GOOSE_MIGRATION_DIR=db/migrations
```

### ローカルDBの構築

MySQLのDockerコンテナを起動し、DBを構築します。

```bash
docker-compose up -d
```

Gooseを使ってDBのマイグレーションを実行します。

```bash
godotenv ./scripts/setup_db.sh
```

Dockerコンテナを停止し、DBを削除する場合は以下のコマンドを実行してください。

```bash
docker-compose down -v
```

### Goサーバーの起動

```bash
go run .
```

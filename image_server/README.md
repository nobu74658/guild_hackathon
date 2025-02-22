# 画像処理サーバー

## 環境構築

### Dockerを使う場合

Dockerコンテナの起動

```bash
docker compose up -d
```

Dockerコンテナの停止

```bash
docker compose down
```

### ローカルで実行する場合

パッケージのインストール

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

サーバーの起動

```bash
fastapi dev main.py
```

## APIの仕様

サーバーが起動した状態で http://localhost:8000/docs にアクセスすると、APIの仕様書が表示されます。

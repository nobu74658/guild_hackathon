# 画像処理サーバー

## 開発環境構築

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

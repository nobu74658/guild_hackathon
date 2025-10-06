<p align="center">
<img src="https://gyazo.com/c70a9f9756e0e0f9caceb0d4576c35a4.png" align="center" width="200">
</p>

<p align="center">
<a href="https://apps.apple.com/jp/app/あみぬり/id6742402884">
<img alt="App Store" src="https://img.shields.io/badge/App_Store-0D96F6?logo=app-store&logoColor=white" />
</a>
<a href="https://play.google.com/store/apps/details?id=com.yiwashita.knitting">
<img alt="Google Play Store" src="https://img.shields.io/badge/Google_Play-414141?logo=google-play&logoColor=white" />
</a>
</p>

「あみぬり」は編み物の図案をリアルなプレビューを確認しながら作成できるアプリです。

> [!NOTE]
> 「Engineer Guild Hackathon 2025 by 外資就活ドットコム」にて2位入賞、エムスリー賞を受賞しました🎉🎉🎉

「あみぬり」はMonorepoでコードを管理しています。以下のようなディレクトリ構成になっています。

```
.
├── flutter_client ... Flutterで作成したクライアントアプリ
├── image_server ... FastAPIで作成した画像処理サーバー
├── go_server ... Goで作成したAPIサーバー (廃止予定)
└── shared ... Protobufで定義したAPIのスキーマ (廃止予定)
```


## 環境構築

### miseのインストール

本プロジェクトでは、バージョン管理ツール [mise](https://mise.jdx.dev/) を使って環境の統一を図っています。
miseの[公式ドキュメント](https://mise.jdx.dev/getting-started.html#installing-mise-cli)の「1. Install `mise` CLI」と「3. Activate `mise`」を参考に、miseをインストールしてください。

### 以降の環境構築手順

以降の環境構築手順は各サービスのREADME.mdに記載しています。

- [flutter_client](./flutter_client/README.md)
- [image_server](./image_server/README.md)


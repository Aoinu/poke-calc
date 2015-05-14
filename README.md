#front-dev-server

jadeとcoffeescriptでフロントエンド開発を行うためのサーバ。

- `gulp`で起動
- Webpackを利用したフロントでのrequire()
- ファイルの変更を自動検知、ブラウザを自動更新
- `npm install`で取ってきたモジュールもrequire可能
- `/www/src`からコンパイルし，`/www`に吐き出す

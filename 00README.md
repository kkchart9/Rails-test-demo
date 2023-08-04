# Rails starter
Rails7 on docker で開発するためのスターター

## 想定開発環境
- Mac
- Docker Desktop

## 準備
スターターを解凍し、自分の作業ディレクトリ配下にコピーする。

## 構築
既に手元の docker に container がある場合は衝突しないように `compose.yml` 内の `container_name` を書き換えておく。

初期 Rails を生成する。

```
$ docker-compose run --no-deps web bundle exec rails new . --force --database=mysql --javascript=esbuild --css=bootstrap --skip-test
```

ログに従って、`package.json` に以下の項目を追加する。

```diff
     "bootstrap-icons": "^1.10.5",
     "esbuild": "^0.17.18",
     "sass": "^1.62.1"
+  },
+  "scripts": {
+    "build": "esbuild app/javascript/*.* --bundle --sourcemap --outdir=app/assets/builds --public-path=assets",
+    "build:css": "sass ./app/assets/stylesheets/application.bootstrap.scss:./app/assets/builds/application.css --no-source-map --load-path=node_modules"
   }
 }
```

`Procfile.dev` を修正する。

```diff
-web: unset PORT && bin/rails server
-js: yarn build --watch
+web: unset PORT && bin/rails server -b 0.0.0.0
+js: yarn build --watch=forever
 css: yarn build:css --watch
```

`config/database.yml` を修正する。

```diff
   adapter: mysql2
   encoding: utf8mb4
   pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
-  username: root
-  password:
-  host: localhost
+  username: <%= ENV["DB_USER"] %>
+  password: <%= ENV["DB_PASSWORD"] %>
+  host: db
 
 development:
   <<: *default
```

`bin/terminal` という docker 内の bash を起動するショートカットをつくっておく。
- `starter-web` の箇所は `compose.yml` の `container_name` を指定する。

```
$ cat << EOF > bin/terminal
#!/usr/bin/env sh
docker exec -it starter-web bash
EOF
$ chmod u+x bin/terminal
```

コンテナを立ち上げる。
```
$ docker-compose up
```

## 確認

立ち上げたコンテナのログに以下の出力がされたら、起動済である。(`HH:MM:SS` は時刻)

```
starter-web         | HH:MM:SS web.1  | * Listening on http://0.0.0.0:3000
```

別ターミナルからブラウザで表示できるか確認する。

```
$ open http://localhost:3000/
```

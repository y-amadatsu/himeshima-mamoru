## 開発環境構築
1. `docker-compose build`
2. `docker-compose run --rm web rails db:create`
3. `docker-compose run --rm web rails db:migrate`
4. `docker-compose run --rm web rails db:seed`
5. `docker-compose up -d`
6. `localhost:3001 にアクセス`


## Heroku環境

heroku config:add TZ=Asia/Tokyo
heroku config:set LANG=ja_JP.UTF-8
heroku config:set BASIC_AUTH_USER_NAME={ベーシック認証のユーザー名}
heroku config:set BASIC_AUTH_PASSWORD={ベーシック認証のパスワード}

## Heroku Addons

- Postgres
- SendGrid

SendGrid導入メモ

heroku addons:create sendgrid:starter
## .env の作成
プロジェクトルートに `.env` を作成し、任意のベーシック認証情報を記述。
```dotenv
BASIC_AUTH_USER_NAME=********
BASIC_AUTH_PASSWORD=*********
```

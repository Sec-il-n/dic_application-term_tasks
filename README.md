# DB scheme

* models:
  * User
    * columns: & data type:
      * user_name : string
      * email : string
      * password :string

  * Task
    * columns: & data type:
      * task_name : string
      * details　: string
      <!-- 以下3カラムはvalidates < GUIから選択式(←の実装が容易であれば) -->
      * ~~valid : string ?~~
      * valid_date : date
      ~~ (received by [date picker](https://diver.diveintocode.jp/curriculums/339) & needs validation of　regular expression ?)~~
      * priority : integer
       <!-- 選択肢から数値変換してdb保存 (->優先順位、終了期限を元にしてソート)-->
      * status : string  <!-- 未着手・着手・完了 -->
      ~~(use [select box](https://railsguides.jp/form_helpers.html#%E3%83%A2%E3%83%87%E3%83%AB%E3%82%92%E6%89%B1%E3%81%86%E3%82%BB%E3%83%AC%E3%82%AF%E3%83%88%E3%83%9C%E3%83%83%E3%82%AF%E3%82%B9) ?)~~
      * user_id

  * Label
    * columns: & data type:
      * label_name
      * user_id

  * Manager
    * task_id : integer
    * lable_id : integer

# How to deploy to Heroku
**Need to be done only once at firsttime deployment**
  * Setting in rails app
    * for 'AssetsPipeline'

      ~~* add `config.assets.compile = true` on to `/config/environments/development.rb`~~
      * run `rails assets:precompile RAILS_ENV=production`

  * Create app in Heroku
    * `heroku create <app_name>`

    * add `buildpacks` for compile at Heroku
      * `heroku buildpacks:set heroku/ruby`
        `heroku buildpacks:add --index 1 heroku/nodejs`
        (「1」for if you want to include this buildpack at first)

  * Migrate DB
    * (if you haven't) add `gem 'pg'` on to Gemfile.
    * run `heroku run rails db:migrate`

**Need to be done each deployment**
  * Deploy to Heroku
    * (check with`git remote -v` if remote has been set, then)<br>
    `git add <. or file_name>`<br>
    `git commit -m'<commit_messages>'`<br>
    `git push heroku master`<br>

  * The other settings
    * need to `heroku config:set <Environment variable>=<value>` if you need.

# lists of versions
  * ruby (2.6.5)
  * pg (1.2.3)
  * rails (5.2.4.4)
  * puma (3.12.6)

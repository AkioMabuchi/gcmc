# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development? or Rails.env.test?
  User.create!(
      [
          {
              permalink: "honoka",
              name: "ホノカ",
              email: "honoka@akiomabuchi.com",
              password: "akiomabuchi",
              password_confirmation: "akiomabuchi"
          },
          {
              permalink: "ayaka",
              name: "アヤカ",
              email: "ayaka@akiomabuchi.com",
              password: "akiomabuchi",
              password_confirmation: "akiomabuchi"
          },
          {
              permalink: "yuto",
              name: "ユウト",
              email: "yuto@akiomabuchi.com",
              password: "akiomabuchi",
              password_confirmation: "akiomabuchi"
          },
          {
              permalink: "suguru",
              name: "スグル",
              email: "suguru@akiomabuchi.com",
              password: "akiomabuchi",
              password_confirmation: "akiomabuchi"
          },
          {
              permalink: "hina",
              name: "ヒナ",
              email: "hina@akiomabuchi.com",
              password: "akiomabuchi",
              password_confirmation: "akiomabuchi"
          }
      ]
  )
end
Tag.create!(
    [
        {
            sort_number: 1,
            name: "Unity"
        },
        {
            sort_number: 2,
            name: "Unreal Engine"
        },
        {
            sort_number: 100,
            name: "RPG"
        },
        {
            sort_number: 101,
            name: "アクション"
        },
        {
            sort_number: 102,
            name: "アドベンチャー"
        },
        {
            sort_number: 103,
            name: "シューティング"
        },
        {
            sort_number: 104,
            name: "パズル"
        },
        {
            sort_number: 105,
            name: "シミュレーション"
        },
        {
            sort_number: 106,
            name: "音楽"
        },
        {
            sort_number: 107,
            name: "テーブル"
        },
        {
            sort_number: 200,
            name: "3D"
        },
        {
            sort_number: 201,
            name: "2D"
        },
        {
            sort_number: 202,
            name: "ドット絵"
        },
        {
            sort_number: 300,
            name: "未経験歓迎"
        },
        {
            sort_number: 301,
            name: "初心者歓迎"
        },
        {
            sort_number: 302,
            name: "上級者求む"
        },
        {
            sort_number: 400,
            name: "オンライン開発"
        }
    ]
)
Role.create!(
    [
        {
            sort_number: 1,
            name: "プロデューサー"
        },
        {
            sort_number: 2,
            name: "ディレクター"
        },
        {
            sort_number: 3,
            name: "プランナー"
        },
        {
            sort_number: 4,
            name: "デザイナー"
        },
        {
            sort_number: 5,
            name: "プログラマー"
        },
        {
            sort_number: 6,
            name: "グラフィッカー"
        },
        {
            sort_number: 7,
            name: "サウンドクリエイター"
        },
        {
            sort_number: 8,
            name: "シナリオライター"
        },
        {
            sort_number: 9,
            name: "ローカライザー"
        },
        {
            sort_number: 10,
            name: "声優"
        }
    ]
)

Position.create!(
    [
        {
            role_id: 1,
            sort_number: 100,
            name: "プロデューサー"
        },
        {
            role_id: 2,
            sort_number: 200,
            name: "ディレクター"
        },
        {
            role_id: 3,
            sort_number: 300,
            name: "プランナー"
        },
        {
            role_id: 4,
            sort_number: 400,
            name: "UI/UXデザイナー"
        },
        {
            role_id: 5,
            sort_number: 500,
            name: "プログラマー（Unity C#）"
        },
        {
            role_id: 5,
            sort_number: 501,
            name: "プログラマー（Unreal Engine C++）"
        },
        {
            role_id: 6,
            sort_number: 600,
            name: "グラフィッカー（3D）"
        },
        {
            role_id: 6,
            sort_number: 601,
            name: "グラフィッカー（2D）"
        },
        {
            role_id: 6,
            sort_number: 602,
            name: "グラフィッカー（ドット絵）"
        },
        {
            role_id: 6,
            sort_number: 603,
            name: "イラストレーター"
        },
        {
            role_id: 7,
            sort_number: 700,
            name: "サウンドクリエイター（BGM）"
        },
        {
            role_id: 7,
            sort_number: 701,
            name: "サウンドクリエイター（SE）"
        },
        {
            role_id: 8,
            sort_number: 800,
            name: "シナリオライター"
        },
        {
            role_id: 9,
            sort_number: 900,
            name: "ローカライザー（英語）"
        },
        {
            role_id: 9,
            sort_number: 901,
            name: "ローカライザー（中国語）"
        },
        {
            role_id: 9,
            sort_number: 902,
            name: "ローカライザー（韓国語）"
        },
        {
            role_id: 10,
            sort_number: 1000,
            name: "声優（男性）"
        },
        {
            role_id: 10,
            sort_number: 1001,
            name: "声優（女性）"
        }
    ]
)
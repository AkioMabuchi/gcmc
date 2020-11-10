# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
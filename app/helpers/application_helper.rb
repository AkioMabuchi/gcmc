module ApplicationHelper
  def default_meta_tags
    {
        site: "GCMC",
        title: "ゲーム開発仲間マッチングサービス",
        reverse: true,
        charset: "utf-8",
        description: "『GCMC（Game Creators Matching Center）』は、プライベートで共同開発を行いたいクリエイターのための、開発仲間マッチングサービスです。",
        keywords: %w[GCMC 開発仲間 共同開発 エンジニアとデザイナー],
        canonical: request.original_url,
        separator: "|",
        icon:[
            {
                href: image_url("favicon.ico")
            },
            {
                href: image_url("Icon.png"),
                rel: "apple-touch-icon",
                sizes: "180x180",
                type: "image/png"
            }
        ],
        og:{
            site_name: "Combine",
            title: "ゲーム開発仲間マッチングサービス『GCMC（Game Creators Matching Center）』",
            description: "『GCMC（Game Creators Matching Center）』は、プライベートで共同開発を行いたいクリエイターのための、開発仲間マッチングサービスです。",
            type: "website",
            url: request.original_url,
            image: image_url("Icon.png"),
            locale: "ja-JP"
        },
        twitter:{
            card: "summary",
            site: "@AkioMabuchi"
        },
        viewport: "width=device-width, initial-scale=0.9"
    }
  end
end

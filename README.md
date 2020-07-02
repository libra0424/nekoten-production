# ねこてん
ねこ好き専用のSNSです。たくさんの猫画像が集まって天国みたいになります。
ポートフォリオとして制作致しました。

![Screen_shot]()

# リンク
https://nekoten.site/ <br>
ログインページの下部の、簡単ログインボタンから、サンプルユーザーとしてログインできます。


# 使用技術
- Ruby 2.6.0
- Ruby on Rails 5.2.3
- MySQL 5.7.0
- RSpec
- Nginx
- AWS
  - VPC
  - EC2
  - ECS
  - ECR
  - ALB
  - RDS
  - S3
  - Route53
  - ACM
  - CloudWatch
- Docker
- CircleCI
- GitHub
- BootStrap
- SemanticUI

# クラウドアーキテクチャ
![architecture]()

- CircleCIでは、githubのpush時に、Rspecによる自動テストを実行しています。
- masterブランチへのプッシュでは、Rspecによるテストと、ECR,ECSへのデプロイが実行されます。

# Github
- 途中から、master,各種作業ブランチで分けてローカル環境ではマージせずGithub上でプルリク・マージを行いました。。

# 機能一覧、使用したgemなど
- 投稿機能
  - 画像投稿機能
- コメント機能(Ajax)
- ユーザー登録機能、ログイン機能(devise)
- ページネーション機能(kaminari)
- いいね機能(Ajax)
- フォロー機能

# テスト
- RSpec
  - 機能テスト(request spec)
  - 統合テスト(system spec)

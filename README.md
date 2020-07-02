# ねこてん
ねこ好き専用のSNSです。たくさんの猫画像が集まって天国みたいになります。
ポートフォリオとして制作致しました。

![Screen_shot](https://github.com/libra0424/nekoten-production/blob/master/app/assets/images/screenshot.png?raw=true)

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
![Screen_shot](https://user-images.githubusercontent.com/44374005/71571222-93fafe80-2b1c-11ea-9f27-3428010a3da3.png)

- CircleCIでは、githubのpush時に、Rspecによる自動テストを実行しています。
- masterブランチへのプッシュでは、Rspecによるテストと、ECR,ECSへのデプロイが実行されます。

# Github
- 途中から、master,各種作業ブランチで分けてローカル環境ではマージせず、実際の開発環境を意識してGithub上でプルリク・マージを行いました。

# 機能一覧、使用したgemなど
- 投稿機能
  - 画像投稿機能
- コメント機能(Ajax)
- ユーザー登録機能、ログイン機能(devise)
  - メール認証
- ページネーション機能(kaminari)
- いいね機能(Ajax)
- フォロー機能

# テスト
- RSpec
  - 機能テスト(request spec)
  - 統合テスト(system spec)

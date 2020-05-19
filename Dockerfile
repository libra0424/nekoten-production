FROM ruby:2.6.0

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /nekoten
WORKDIR /nekoten

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /nekoten/Gemfile
ADD Gemfile.lock /nekoten/Gemfile.lock

# bundle installの実行
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /nekoten

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets
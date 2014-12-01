docker-debian-sshd
===========

# はじめに
dockerにてdebianのsshd機能を提供するコンテナです。  
sshでログインできるのはコンテナ起動時に設定した1ユーザに限られます。
コンテナはportがぶつからない限り、任意の数起動できます。

また、コンテナ内のファイルはホスト側からは隔離されます。永続的なファイルの保存が必要な場合は-vオプションを使用してホスト側のディレクトリをマウントしてください。

使い方
------
# Installation
以下のようにdocker imageをpullします。

    docker pull sharaku/debian-sshd

Docker imageを自分で構築することもできます。

    git clone https://github.com/sharaku/docker-debian-sshd.git
    cd docker-debian-sshd
    docker build --tag="$USER/debian-sshd" .

# Quick Start
sshdのimageを実行します。

    docker run -d -e "LOGIN_USER=login_user:login_user_passwd" -p 10022:22 sharaku/debian-sshd

sshdの代わりに/bin/bashで起動することもできます。
この場合、rootユーザでのログインとなります。

    docker run -it sharaku/debian-sshd /bin/bash

## Argument

+   `-v /path/to/data:/path/to/container/data:rw` :  
    永続的に保存するデータのディレクトリを指定します。任意の数の-vオプションを使用可能です。

+   `-e "LOGIN_USER=login_user:login_user_passwd"` :  
    ログインするユーザ名、パスワードを":"で区切って指定します。  
    例：-e "LOGIN_USER=hogehoge:hogehoge-passwd"

+   -p port:22 :  
    外部公開するポートを設定します。

利用例
------
以下の条件でsshdを構築する例です。

+ ユーザ名：hogehoge
+ パスワード：hogehoge-passwd
+ ポート：10022
+ ボリューム（ホスト側）：/var/lib/sshd-volume
+ ボリューム（コンテナ側）：/var/lib/volume

　

      mkdir /var/lib/sshd-volume

      docker run -d \
        -v /var/lib/sshd-volume:/var/lib/volume:rw \
        -e "LOGIN_USER=hogehoge:hogehoge-passwd" \
        -p 10022:22 sharaku/debian-sshd



---
title: "ssh自动登陆"
date: 2020-07-03T19:36:06+08:00
draft: false
tags: ["ssh","linux","Verification Code"]
categories: ["总结", "技术"]

weight: 10
autoCollapseToc: true
---

#### 自动填写密码和google验证码的脚本复制可用
> auto-ssh-or-scp.expect
``` bash
#!/usr/bin/expect

trap { # trap sigwinch and pass it to the child we spawned
  set rows [stty rows]
  set cols [stty columns]
  stty rows $rows columns $cols < $spawn_out(slave,name)
} WINCH

set cmd [lindex $argv 0]
set password [lindex $argv 1]
set verification_code [lindex $argv 2]


set pos [string first "scp" $cmd]

if {$pos == 0 }  {
set timeout 1000
} else {
set timeout 10
}

eval spawn $cmd

expect {
    "Connection refused" exit
    "Name or service not known" exit
    "continue connecting (yes/no)?" {send "yes\r";exp_continue}
    "Verification code:" {send "$verification_code\r";exp_continue}
    "assword:" {send "$password\r"}
}


if {$pos == 0 }  {
    expect eof
    exit
} else {
    interact
}
```

#### 自动生成google 验证码的脚本

> google-authenticator.py

``` python
#!/user/bin/env python

import sys, hmac, base64, struct, hashlib, time

def get_hotp_token(secret, intervals_no):
    key = base64.b32decode(secret, True)
    msg = struct.pack(">Q", intervals_no)
    h = hmac.new(key, msg, hashlib.sha1).digest()
    o = ord(h[19]) & 15
    h = (struct.unpack(">I", h[o:o+4])[0] & 0x7fffffff) % 1000000
    return h

def get_totp_token(secret):
    return get_hotp_token(secret, intervals_no=int(time.time())//30)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print "Usage: python", sys.argv[0], "secret"
	sys.exit(1)

    print get_totp_token(sys.argv[1])
```

#### 使用

``` bash
#!/bin/bash

export LC_CTYPE=en_US

filepath=$(cd "$(dirname "$0")"; pwd)

passwd="****"
host="root@192.168.1.2"
# 不需要google验证码的可以不执行下面一行
code=`python google-authenticator.py ***`

# ${filepath}/auto-tiaoji.expect $host $vcode $passwd
echo $passwd
${filepath}/auto-ssh-or-scp.expect "ssh ${host}" $passwd $code
```

#### 
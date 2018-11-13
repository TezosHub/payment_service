# payment_service

### 表结构

```
CREATE TABLE `task` (
	`id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	`time`	INTEGER,
	`name`	TEXT,
	`address`	TEXT,
	`amount`	INTEGER,
	`fee`	INTEGER,
	`status`	INTEGER DEFAULT 'wait'
);
```

### 安装

```
apt install sqlite3 libsqlite3-dev
```

```
gem install sqlite3
```

```
git clone https://github.com/TezosHub/payment_service
```

### 配置

把config.rb 里的目录改成你Tezos的节点根目录
并完成烘焙账号的公钥、私钥配置

### 执行

启动web服务器

```
ruby app 80
```

启动任务管理

```
ruby task.rb
```

### 说明

web服务仅仅是把需要支付的提交写入sqlite3数据库，做成一个待处理的任务。并提供一个查询任务的接口。

任务管理程序（task.rb）每5秒钟检测一次数据库，如果由新的任务完成，则进行下一个任务。并根据支付情况把任务状态写入到sqlite3。

### 演示

随机地址批量转账演示

![](pay.gif)

新地址批量转账演示
![](demo.gif)
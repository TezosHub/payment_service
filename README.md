# payment_service

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

```
apt install sqlite3 libsqlite3-dev
```

```
gem install sqlite3
```
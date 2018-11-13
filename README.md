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
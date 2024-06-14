BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "todo" (
	"description"	TEXT,
	"status"	TEXT DEFAULT 'open',
	"create_date"	datetime NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime')),
	"change_date"	datetime NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime')),
	"id"	INTEGER,
	PRIMARY KEY("id")
);
CREATE TRIGGER update_change_date_Trigger
AFTER UPDATE On todo
BEGIN
   UPDATE todo SET change_date = (datetime(CURRENT_TIMESTAMP, 'localtime')) WHERE id = NEW.id;
END;
CREATE VIEW todo_closed as
select * from todo
WHERE
status not in ('open', 'work', 'wait')
order by 
change_date desc;
CREATE VIEW todo_skipped as
select * from todo
WHERE
status ='skipped'
order by 
change_date desc;
CREATE VIEW todo_wait as
select * from todo
WHERE
status ='wait'
order by 
change_date desc;
CREATE VIEW todo_work as
select * from todo
WHERE
status ='work'
order by 
change_date desc;
COMMIT;

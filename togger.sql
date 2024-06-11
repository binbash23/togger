BEGIN TRANSACTION;
drop table todo;
CREATE TABLE IF NOT EXISTS "todo" (
	"description"	TEXT,
	"status"	TEXT DEFAULT 'offen',
	"create_date"	datetime NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime')),
	"change_date"	datetime NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime')),
	"id"	INTEGER,
	PRIMARY KEY("id")
);
--INSERT INTO "todo" VALUES ('2024-06-11 23:44:21','2024-06-11 23:44:21',1,'test','offen');
CREATE TRIGGER update_change_date_Trigger
AFTER UPDATE On todo
BEGIN
   UPDATE todo SET change_date = (datetime(CURRENT_TIMESTAMP, 'localtime')) WHERE id = NEW.id;
END;
COMMIT;

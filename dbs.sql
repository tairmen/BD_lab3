CREATE TABLE campus.student (
	`sid` int(10) NOT NULL AUTO_INCREMENT,
	`sname` varchar(255) NOT NULL,
	PRIMARY KEY (`sid`)
);

CREATE TABLE campus.subject (
	`sbid` int(10) NOT NULL AUTO_INCREMENT,
	`sbname` varchar(255) NOT NULL,
	PRIMARY KEY (`sbid`)
);

CREATE TABLE campus.task (
	`tid` int(10) NOT NULL AUTO_INCREMENT,
	`tname` varchar(255) NOT NULL,
	PRIMARY KEY (`tid`)
);

CREATE TABLE campus.log (
	`lid` int(10) NOT NULL AUTO_INCREMENT,
	`tid` int(10) NOT NULL,
	`sbid` int(10) NOT NULL,
	`sid` int(10) NOT NULL,
	`ldate` date NOT NULL,
	`mark` int(10) NOT NULL,
	PRIMARY KEY (`lid`)
);

INSERT INTO campus.student (sid, sname) VALUES (1, 'Ivan');
INSERT INTO campus.student (sid, sname) VALUES (2, 'Tair');
INSERT INTO campus.student (sid, sname) VALUES (3, 'Sergey');
INSERT INTO campus.student (sid, sname) VALUES (4, 'Edem');

INSERT INTO campus.subject (sbid, sbname) VALUES (1, 'MatAn');
INSERT INTO campus.subject (sbid, sbname) VALUES (2, 'BD');
INSERT INTO campus.subject (sbid, sbname) VALUES (3, 'History');

INSERT INTO campus.task (tid, tname) VALUES (1, 'HomeWork');
INSERT INTO campus.task (tid, tname) VALUES (2, 'ClassWork');
INSERT INTO campus.task (tid, tname) VALUES (3, 'Exam');

INSERT INTO campus.log (lid, tid, sbid, sid, ldate, mark) VALUES (1, 2, 1, 2, '2017-10-10', 10);
INSERT INTO campus.log (lid, tid, sbid, sid, ldate, mark) VALUES (2, 2, 1, 1, '2017-10-10', 5);
INSERT INTO campus.log (lid, tid, sbid, sid, ldate, mark) VALUES (3, 2, 1, 3, '2017-10-10', 7);
INSERT INTO campus.log (lid, tid, sbid, sid, ldate, mark) VALUES (4, 2, 1, 4, '2017-10-05', 6);
INSERT INTO campus.log (lid, tid, sbid, sid, ldate, mark) VALUES (5, 3, 2, 2, '2017-10-10', 11);
INSERT INTO campus.log (lid, tid, sbid, sid, ldate, mark) VALUES (6, 3, 2, 1, '2017-10-10', 10);
INSERT INTO campus.log (lid, tid, sbid, sid, ldate, mark) VALUES (7, 1, 3, 2, '2017-10-08', 8);
INSERT INTO campus.log (lid, tid, sbid, sid, ldate, mark) VALUES (8, 1, 1, 2, '2017-10-17', 5);
INSERT INTO campus.log (lid, tid, sbid, sid, ldate, mark) VALUES (9, 1, 1, 2, '2017-10-18', 2);
INSERT INTO campus.log (lid, tid, sbid, sid, ldate, mark) VALUES (10, 2, 3, 1, '2017-10-12', 10);
INSERT INTO campus.log (lid, tid, sbid, sid, ldate, mark) VALUES (11, 2, 3, 3, '2017-10-10', 11);
INSERT INTO campus.log (lid, tid, sbid, sid, ldate, mark) VALUES (12, 2, 3, 2, '2017-10-11', 8);


SELECT sname, mx FROM campus.student, (SELECT MAX(mark) AS mx, sid FROM campus.log GROUP BY sid)l WHERE student.sid=l.sid;

select sbname, av from campus.subject sb, (select avg(mark) as av, sbid from campus.log where mark < 10 group by sbid having avg(mark) > 4)l where l.sbid=sb.sbid;

SELECT sname, sbname, mark FROM (campus.log left JOIN campus.student ON log.sid=student.sid) left JOIN campus.subject ON log.sbid=subject.sbid;

SELECT sname, sbname, sum(mark) as sm FROM campus.log, campus.subject, campus.student, (select sid from campus.student where sname='Tair')l where log.sid=l.sid and subject.sbid=log.sbid and student.sid=log.sid group by sbname;


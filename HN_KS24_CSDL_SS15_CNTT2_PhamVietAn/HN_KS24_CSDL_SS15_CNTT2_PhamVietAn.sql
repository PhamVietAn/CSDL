use ss15;

create table Students (
	StudentID char(5) primary key,
    FullName varchar(50) not null,
    TotalDebt decimal(10,2) default 0
);

create table Subjects (
    Subjectid char(5) primary key,
    Subjectname varchar(50) not null,
    Credits int check (Credits > 0)
);

create table Grades (
    StudentID char(5),
    SubjectID char(5),
    Score decimal(4,2) check (Score between 0 and 10),
    primary key (studentid, subjectid),
    foreign key (studentid) references students(studentid),
    foreign key (subjectid) references subjects(subjectid)
);

create table Gradelog (
    LogID int auto_increment primary key,
    StudentID char(5),
    OldScore decimal(4,2),
    NewScore decimal(4,2),
    ChangeDate datetime default current_timestamp
);

-- Insert Students
INSERT INTO Students (StudentID, FullName, TotalDebt) VALUES 
('SV01', 'Ho Khanh Linh', 5000000),
('SV03', 'Tran Thi Khanh Huyen', 0);

-- Insert Subjects
INSERT INTO Subjects (SubjectID, SubjectName, Credits) VALUES 
('SB01', 'Co so du lieu', 3),
('SB02', 'Lap trinh Java', 4),
('SB03', 'Lap trinh C', 3);

-- Insert Grades
INSERT INTO Grades (StudentID, SubjectID, Score) VALUES 
('SV01', 'SB01', 8.5), -- Passed
('SV03', 'SB02', 3.0); -- Failed


-- Phần A
-- câu 1.
delimiter //
create trigger tg_checkscore
before insert on grades
for each row
begin
    if new.score < 0 then
        set new.score = 0;
    elseif new.score > 10 then
        set new.score = 10;
    end if;
end//
delimiter ;

-- câu 2.
start transaction;

insert into students(studentid, fullname)
values ('sv02', 'ha bich ngoc');

update students
set totaldebt = 5000000
where studentid = 'sv02';

commit;

delimiter //

-- Phần B
-- câu 3
create trigger tg_loggradeupdate
after update on grades
for each row
begin
    insert into gradelog(studentid, oldscore, newscore, changedatea)
    values (old.studentid, old.score, new.score, now());
end//


-- câu 4
create procedure sp_paytuition()
begin
    declare v_newdebt decimal(10,2);

    start transaction;

    update students
    set totaldebt = totaldebt - 2000000
    where studentid = 'sv01';

    select totaldebt into v_newdebt
    from students
    where studentid = 'sv01';

    if v_newdebt < 0 then
        rollback;
    else
        commit;
    end if;
end//

-- Phần C
-- câu 5
create trigger tg_preventpassupdate
before update on grades
for each row
begin
    if old.score >= 4.0 then
        signal sqlstate '45000'
        set message_text = 'sinh vien da qua mon, khong duoc phep sua diem';
    end if;
end//


-- câu 6
create procedure sp_deletestudentgrade (
    in p_studentid char(5),
    in p_subjectid char(5)
)
begin
    declare v_score decimal(4,2);

    start transaction;

    select score into v_score
    from grades
    where studentid = p_studentid
      and subjectid = p_subjectid;

    insert into gradelog(studentid, oldscore, newscore, changedate)
    values (p_studentid, v_score, null, now());

    delete from grades
    where studentid = p_studentid
      and subjectid = p_subjectid;

    if row_count() = 0 then
        rollback;
    else
        commit;
    end if;
end//

delimiter ;


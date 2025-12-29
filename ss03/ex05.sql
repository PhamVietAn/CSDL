create table score (
    student_id int,
    subject_id int,
    mid_score decimal(4,2) check(mid_score between 0 and 10),
    final_score decimal(4,2) check(final_score between 0 and 10),

    -- mỗi sinh viên chỉ có một bảng điểm cho mỗi môn
    primary key (student_id, subject_id),

    -- khóa ngoại liên kết
    foreign key (student_id) references student(student_id),
    foreign key (subject_id) references subject(subject_id)
);

insert into score (student_id, subject_id, mid_score, final_score)
values
    (1, 101, 7.5, 8.0),
    (1, 102, 6.0, 7.0),
    (2, 103, 8.0, 9.0),
    (3, 101, 5.5, 6.5);

update score
set final_score = 8.5
where student_id = 1 and subject_id = 102;

select * from score;

select student_id, subject_id, final_score
from score
where final_score >= 8;

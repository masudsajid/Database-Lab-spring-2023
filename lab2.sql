create database LAB1;

drop table if exists Students;
create table Students(
Student_Id int NOT NULL, 
Student_Name varchar(100), 
Studaddress varchar(100),
Student_Batch varchar(5), 
deptartment varchar(5),
CGPA float
);

drop table if exists Instructors;
create table Instructors(
InstructorId int NOT NULL,
InstructorName varchar(100),
salary float,
joingdate date
); 

drop table if exists Courses;
create table Courses(
CourseId int NOT NULL,
CourseName varchar(100),
CourseCreditHours int,
InstructorId int
);

drop table if exists Registration;
create table Registration(
StudentId int NOT NULL,
CourseId int,
Grade int
);

alter table students add constraint PK_STUDENT primary key (student_Id);
alter table instructors add constraint PK_INSTRUCTOR primary key (instructorId);
alter table courses add constraint PK_COURSE primary key (courseId);
alter table Registration add constraint FK_REGISTRATION foreign key (studentId) references students(student_id);
alter table Registration add constraint FK_REGISTRATION_COURSE foreign key (courseId) references courses(courseId);
alter table registration drop constraint FK_REGISTRATION;
alter table Registration add constraint FK_REGISTRATION foreign key (studentId) references students(student_id) on delete no action on update cascade;
alter table registration drop constraint FK_REGISTRATION_COURSE;
alter table Registration add constraint FK_REGISTRATION_COURSE foreign key (courseId) references courses(courseId) on delete no action on update cascade;

insert into students values(1, 'Ali Raza Awan', '123 Model Town, Peshawar', '2019', 'CS', 3.3);
exec sp_rename 'students.student_Id', 'id', 'COLUMN';
select * from students
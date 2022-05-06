
alter session set container = pdb1;
-- connect  ORACLE/A__oTest123@pdb1;
create table Employees
   (
      id int not null,
      age int not null,
      first varchar (255),
      last varchar (255),
      site varchar (255)
   );
   

----------------------------------
---- Insert for PCA Oracle DB ----
----------------------------------
INSERT INTO Employees VALUES (101, 25, 'Mile', 'Zhu', 'pcadb');
INSERT INTO Employees VALUES (102, 30, 'Cathy', 'Xing', 'pcadb');
INSERT INTO Employees VALUES (103, 28, 'Ashish', 'Denny', 'pcadb');
INSERT INTO Employees VALUES (104, 18, 'Shashi', 'Ramachandra', 'pcadb');
INSERT INTO Employees VALUES (105, 18, 'Sri', 'krishna', 'pcadb');

select * from employees;

commit;
exit;

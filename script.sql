Account Master:

drop table AccountMaster cascade constraint;

CREATE TABLE AccountMaster ( 
Account_ID NUMBER(10) PRIMARY KEY, 
Account_Type VARCHAR2(25), 
Account_Balance NUMBER(15),
Open_Date DATE);

drop sequence seq_accnt_No;

create sequence seq_accnt_No start with 3100000000;

INSERT INTO AccountMaster VALUES( 3233459865, 'Saving', 200000, '12-NOV-2012');
INSERT INTO AccountMaster VALUES( 3226789543, 'Current', 3540000, '26-MAY-2010');
INSERT INTO AccountMaster VALUES( 5445213392, 'Saving', 500000, '03-JAN-2014');
INSERT INTO AccountMaster VALUES( 4233786321, 'Joint', 500030, '15-DEC-2013');
INSERT INTO AccountMaster VALUES( 4253459764, 'Saving', 850040, '06-APR-2015');
INSERT INTO AccountMaster VALUES( 6343459009, 'Saving', 850040, '06-APR-2015');
INSERT INTO AccountMaster VALUES( 4526700313, 'Saving', 850040, '06-APR-2015');
INSERT INTO AccountMaster VALUES( 9045211119, 'Saving', 850040, '06-APR-2015');
INSERT INTO AccountMaster VALUES( 6030063203, 'Saving', 850040, '06-APR-2015');
INSERT INTO AccountMaster VALUES( 8003349777, 'Saving', 850040, '06-APR-2015');

INSERT INTO AccountMaster VALUES( 3233459847, 'Saving', 850040, '06-APR-2015');

INSERT INTO AccountMaster VALUES( 5343459009, 'Saving', 850040, '06-APR-2015');


select * from ACCOUNTMASTER;


 CUSTOMER:
 
drop table Customer cascade constraint;


 
CREATE TABLE Customer (
Account_ID REFERENCES AccountMaster(Account_ID) , 
customer_name VARCHAR2(50), 
Email VARCHAR2(30), 
Address VARCHAR2(100), 
Pancard VARCHAR2(15),
Contact number(10)
);




INSERT INTO Customer VALUES( 3233459865, 'John', 'john123@gmail.com', 'HinjewadiPhase3,Pune', 'CRHJK4320K',9874563210);

INSERT INTO Customer VALUES( 6343459009, 'John', 'john123@gmail.com', 'HinjewadiPhase3,Pune', 'CRHJK4320K',9874563210);

INSERT INTO Customer VALUES( 3233459847, 'John', 'john123@gmail.com', 'HinjewadiPhase3,Pune', 'CRHJK4320K',9874563210);

INSERT INTO Customer VALUES( 5343459009, 'John', 'john123@gmail.com', 'HinjewadiPhase3,Pune', 'CRHJK4320K',9874563210);

INSERT INTO Customer VALUES( 3226789543, 'Smith', 'smith@gmail.com', 'Brookefield, Bangalore', 'RTHPJ9046P',8795463201);

INSERT INTO Customer VALUES( 4526700313, 'Smith', 'smith@gmail.com', 'Brookefield, Bangalore', 'RTHPJ9046P',8795463201);

INSERT INTO Customer VALUES( 5445213392, 'James', 'james@gmail.com', 'Gandhi Nagar, Kolkata', 'MNFDS8563P',7895463210);

INSERT INTO Customer VALUES( 9045211119, 'James', 'james@gmail.com', 'Gandhi Nagar, Kolkata', 'MNFDS8563P',7895463210);

INSERT INTO Customer VALUES( 4233786321, 'Johnson', 'johnson89@gmail.com', 'Wakad, Pune', 'PKINB5648L',9843201457);

INSERT INTO Customer VALUES( 6030063203, 'Johnson', 'johnson89@gmail.com', 'Wakad, Pune', 'PKINB5648L',9843201457);

INSERT INTO Customer VALUES( 4253459764, 'Peter', 'peter45@gmail.com', 'Koramangala, Bangalore', 'MEDHB6043U',7845965413);

INSERT INTO Customer VALUES( 8003349777, 'Peter', 'peter45@gmail.com', 'Koramangala, Bangalore', 'MEDHB6043U',7845965413);

select * from Customer;

Transactions:

drop table Transactions cascade constraint;

CREATE TABLE Transactions (
Transaction_ID NUMBER  PRIMARY KEY,
Tran_description VARCHAR2(100), 
DateofTransaction DATE , 
TransactionType VARCHAR2(1),
TranAmount NUMBER(15) ,
Account_No NUMBER(10) REFERENCES AccountMaster(Account_ID)
);

select * from Transactions;

insert into Transactions values(1456237894123,'Pay to self',date '2013-12-20','S',3000,3226789543);
insert into Transactions values(1456987754252,'Pay to self',date '2014-01-12','S',2500,3226789543);
insert into Transactions values(1459081727398,'Pay to Phone Bill',date '2014-01-23','S',500,3226789543);
insert into Transactions values(1460991888271,'Pay To Maintenance Bill',date '2014-01-25','C',1900,3226789543);
insert into Transactions values(1478901736635,'Pay to Electric Bill',date '2014-02-25','C',2000,3226789543);
insert into Transactions values(1490715253653,'Pay to self',date '2014-03-02','S',1000,3226789543);
insert into Transactions values(1527837712799,'Pay to Gas Bill',date '2015-12-12','C',2500,3226789543);
insert into Transactions values(1548982887381,'Pay to self',date '2016-06-10','S',450,3226789543);
insert into Transactions values(1558729888828,'Pay to Internet Bill',date '2016-08-09','S',600,3226789543);
insert into Transactions values(1569819283989,'Pay to Maintenance Bill',date '2017-07-15','C',1200,3226789543);
insert into Transactions values(1590187736655,'Pay to self',date '2017-09-19','S',2400,3226789543);



insert into Transactions values(1456237893834,'Pay to Electric Bill',date '2013-12-26','S',2000,4233786321);
insert into Transactions values(1456478392343,'Pay to self',date '2014-01-20','S',2500,4233786321);
insert into Transactions values(1454458439395,'Pay to Phone Bill',date '2014-01-29','S',2000,4233786321);
insert into Transactions values(1459094735552,'Pay to self',date '2014-02-02','C',1500,4233786321);
insert into Transactions values(1460345245654,'Pay to self',date '2014-02-15','S',500,4233786321);
insert into Transactions values(1478905676852,'Pay To Maintenance Bill',date '2014-03-25','C',600,4233786321);
insert into Transactions values(1490719846237,'Pay to Gas Bill',date '2015-06-10','S',1500,4233786321);
insert into Transactions values(1527835342343,'Pay to Internet Bill',date '2015-12-20','C',1000,4233786321);
insert into Transactions values(1548534532432,'Pay to self',date '2016-07-14','C',1400,4233786321);
insert into Transactions values(1558743576567,'Pay To Maintenance Bill',date '2016-08-08','S',500,4233786321);
insert into Transactions values(1569819283765,'Pay to Phone Bill',date '2017-09-14','C',1500,4233786321);
insert into Transactions values(1590185687234,'Pay to self',date '2017-11-05','S',1200,4233786321);


insert into Transactions values(1456235453654,'Pay to Phone Bill',date '2013-02-10','S',3000,3233459865);
insert into Transactions values(1456474567878,'Pay to self',date '2013-06-15','C',2000,3233459865);
insert into Transactions values(1454458439732,'Pay to Internet Bill',date '2014-01-29','S',2600,3233459865);
insert into Transactions values(1459094785435,'Pay To Maintenance Bill',date '2014-05-09','S',1500,3233459865);
insert into Transactions values(1460345254678,'Pay to self',date '2014-06-19','S',2500,3233459865);
insert into Transactions values(1478905768438,'Pay to self',date '2015-08-25','C',1600,3233459865);
insert into Transactions values(1490719846764,'Pay to Electric Bill',date '2015-09-20','S',500,3233459865);
insert into Transactions values(1527835342653,'Pay To Maintenance Bill',date '2015-12-15','S',600,3233459865);
insert into Transactions values(1548534578784,'Pay to self',date '2016-03-10','C',800,3233459865);
insert into Transactions values(1558743546368,'Pay to Gas Bill',date '2016-11-19','S',1200,3233459865);
insert into Transactions values(1569819278953,'Pay to self',date '2017-04-25','C',1000,3233459865);
insert into Transactions values(1590185687436,'Pay to Phone Bill',date '2017-09-15','S',1900,3233459865);


insert into Transactions values(1456235453654,'Pay to self',date '2014-02-12','S',4000,5445213392);

insert into Transactions values(1456235453676,'Pay to self',date '2014-02-12','S',4000,5445213392);
insert into Transactions values(1456474554542,'Pay to Internet Bill',date '2014-05-10','S',500,5445213392);
insert into Transactions values(1454458434532,'Pay to self',date '2015-01-26','C',600,5445213392);
insert into Transactions values(1459094785465,'Pay to self',date '2015-03-19','S',2500,5445213392);
insert into Transactions values(1460345257574,'Pay To Maintenance Bill',date '2015-08-20','S',2000,5445213392);
insert into Transactions values(1478905735753,'Pay to Electric Bill',date '2015-06-29','C',1000,5445213392);
insert into Transactions values(1490719842354,'Pay to Phone Bill',date '2015-11-02','C',1500,5445213392);
insert into Transactions values(1527835235478,'Pay to self',date '2015-12-26','S',2600,5445213392);
insert into Transactions values(1548534534587,'Pay to Gas Bill',date '2016-02-10','S',900,5445213392);
insert into Transactions values(1558743547625,'Pay To Maintenance Bill',date '2016-11-25','C',1500,5445213392);
insert into Transactions values(1569819287854,'Pay to self',date '2017-05-15','S',1200,5445213392);
insert into Transactions values(1590185682357,'Pay to Phone Bill',date '2017-11-12','S',2000,5445213392);


insert into Transactions values(1456235648543,'Pay to Electric Bill',date '2015-04-10','S',2000,4253459764);
insert into Transactions values(1456474598725,'Pay to Internet Bill',date '2015-05-15','C',1500,4253459764);
insert into Transactions values(1454459864767,'Pay to self',date '2015-09-05','S',800,4253459764);
insert into Transactions values(1459094789535,'Pay to Phone Bill',date '2015-10-15','S',500,4253459764);
insert into Transactions values(1460384764328,'Pay To Maintenance Bill',date '2015-11-19','C',1200,4253459764);
insert into Transactions values(1478905853257,'Pay to self',date '2016-01-28','S',500,4253459764);
insert into Transactions values(1490719874864,'Pay to self',date '2016-03-12','S',2000,4253459764);
insert into Transactions values(1527835387307,'Pay to Gas Bill',date '2016-04-15','C',2500,4253459764);
insert into Transactions values(1548534579754,'Pay to Phone Bill',date '2016-09-05','S',1200,4253459764);
insert into Transactions values(1558743595438,'Pay to self',date '2016-11-15','S',1900,4253459764);
insert into Transactions values(1569819536586,'Pay To Maintenance Bill',date '2017-02-26','C',2600,4253459764);
insert into Transactions values(1590185987467,'Pay to self',date '2017-06-15','S',2500,4253459764);


Service Tracker:

drop table ServiceTracker cascade constraint;

CREATE TABLE ServiceTracker (
Service_ID NUMBER PRIMARY KEY, 
Service_Description VARCHAR2(100),
Account_ID NUMBER REFERENCES AccountMaster(Account_ID), 
Service_Raised_Date DATE ,
Service_status VARCHAR2(20)
);

create sequence seq_req_id start with 15;
SELECT seq_req_id.NEXTVAL from dual;

insert into ServiceTracker values(10, 'Pay to Self', 3233459865, DATE '2017-02-21', 'Pending');
insert into ServiceTracker values(11, 'Pay to Self', 3233459865, DATE '2017-03-20', 'Accepted');
insert into ServiceTracker values(12, 'Pay to Self', 3233459865, DATE '2017-04-12', 'Accepted');
insert into ServiceTracker values(13, 'Pay to Self', 3233459865, DATE '2017-05-15', 'Pending');
insert into ServiceTracker values(14, 'Pay to Self', 3233459865, DATE '2017-06-19', 'Accepted');

select * from ServiceTracker

delete from ServiceTracker where Service_ID=20 ;

User Table:

drop table User_Account cascade constraint;

CREATE TABLE User_Account (
Account_ID NUMBER REFERENCES AccountMaster(Account_ID),
user_id NUMBER PRIMARY KEY,
password VARCHAR2(15),
secret_question VARCHAR2(50),
Transaction_password VARCHAR2(15),
lock_status VARCHAR2(1)
);

drop sequence seq_user_id;
create sequence seq_user_id start with 101;

insert into User_Account values(3233459865,12345, 'abc123','abc', 'abc123', '1');

select * from User_Account;

delete from User_Account where user_id!=123

 
Fund Transfer:

create sequence seq_fund_id start with 1000000000000;

drop table Fund_Transfer cascade constraint;

CREATE TABLE Fund_Transfer (
FundTransfer_ID NUMBER  PRIMARY KEY,
Account_ID NUMBER(10) REFERENCES AccountMaster(Account_ID),
Payee_Account_ID NUMBER(10), 
Date_Of_Transfer DATE, 
Transfer_Amount NUMBER(15)
);

select * from Fund_Transfer;

Payee Table:

drop table Payee cascade constraint;
select Payee_Account_Id from Payee where Nickname='self'
CREATE TABLE Payee (
Account_Id NUMBER REFERENCES AccountMaster(Account_ID),
Payee_Account_Id NUMBER PRIMARY KEY, 
Nickname VARCHAR2(40)
);
select * from Payee;

insert into Payee values(3233459865,6343459009,'self');
insert into Payee values(3233459865,3233459847,'self');
insert into Payee values(3233459865,5343459009,'self');
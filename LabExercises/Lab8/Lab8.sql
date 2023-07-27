DROP DATABASE IF EXISTS school_sport_clubs;
CREATE DATABASE school_sport_clubs;
USE school_sport_clubs;

CREATE TABLE school_sport_clubs.sports(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL
);

CREATE TABLE school_sport_clubs.coaches(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	egn VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE school_sport_clubs.students(
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	egn VARCHAR(10) NOT NULL UNIQUE,
	address VARCHAR(255) NOT NULL,
	phone VARCHAR(20) NULL DEFAULT NULL,
	class VARCHAR(10) NULL DEFAULT NULL
);

CREATE TABLE school_sport_clubs.sportGroups(
	id INT AUTO_INCREMENT PRIMARY KEY,
	location VARCHAR(255) NOT NULL,
	dayOfWeek ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'),
	hourOfTraining TIME NOT NULL,
	sport_id INT NULL,
	coach_id INT NULL,
	UNIQUE KEY(location,dayOfWeek,hourOfTraining),
	CONSTRAINT FOREIGN KEY(sport_id) 
		REFERENCES sports(id),
	CONSTRAINT FOREIGN KEY (coach_id) 
		REFERENCES coaches(id)
);

CREATE TABLE school_sport_clubs.student_sport(
	student_id INT NOT NULL, 
	sportGroup_id INT NOT NULL ,  
	CONSTRAINT FOREIGN KEY (student_id) 
		REFERENCES students(id),	
	CONSTRAINT FOREIGN KEY (sportGroup_id) 
		REFERENCES sportGroups(id),
	PRIMARY KEY(student_id,sportGroup_id)
);

CREATE TABLE taxesPayments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	student_id INT NOT NULL,
	group_id INT NOT NULL,
	paymentAmount DOUBLE NOT NULL,
	month TINYINT,
	year YEAR,
	dateOfPayment DATETIME NOT NULL ,
	CONSTRAINT FOREIGN KEY (student_id) 
		REFERENCES students(id),
	CONSTRAINT FOREIGN KEY (group_id) 
		REFERENCES sportgroups(id)
);

CREATE TABLE salaryPayments(
	id INT AUTO_INCREMENT PRIMARY KEY,
	coach_id INT NOT NULL,
	month TINYINT,
	year YEAR,
	salaryAmount double,
	dateOfPayment datetime not null,
	CONSTRAINT FOREIGN KEY (coach_id) 
		REFERENCES coaches(id),
	UNIQUE KEY(`coach_id`,`month`,`year`)
);

INSERT INTO sports
VALUES 	(NULL, 'Football') ,
		(NULL, 'Volleyball') ,
		(NULL, 'Tennis') ,
		(NULL, 'Karate') ,
		(NULL, 'Taekwon-do');
		
INSERT INTO coaches  
VALUES 	(NULL, 'Ivan Todorov Petkov', '7509041245') ,
		(NULL, 'georgi Ivanov Todorov', '8010091245') ,
		(NULL, 'Ilian Todorov Georgiev', '8407106352') ,
		(NULL, 'Petar Slavkov Yordanov', '7010102045') ,
		(NULL, 'Todor Ivanov Ivanov', '8302160980') , 
		(NULL, 'Slavi Petkov Petkov', '7106041278');
		
INSERT INTO students (name, egn, address, phone, class) 
VALUES 	('Iliyan Ivanov', '9401150045', 'Sofia-Mladost 1', '0893452120', '10') ,
		('Ivan Iliev Georgiev', '9510104512', 'Sofia-Liylin', '0894123456', '11') ,
		('Elena Petrova Petrova', '9505052154', 'Sofia-Mladost 3', '0897852412', '11') ,
		('Ivan Iliev Iliev', '9510104542', 'Sofia-Mladost 3', '0894123457', '11') ,
		('Maria Hristova Dimova', '9510104547', 'Sofia-Mladost 4', '0894123442', '11') ,
		('Antoaneta Ivanova Georgieva', '9411104547', 'Sofia-Krasno selo', '0874526235', '10');
		
INSERT INTO sportGroups
VALUES 	(NULL, 'Sofia-Mladost 1', 'Monday', '08:00:00', 1, 1 ) ,
		(NULL, 'Sofia-Mladost 1', 'Monday', '09:30:00', 1, 2 ) ,
		(NULL, 'Sofia-Liylin 7', 'Sunday', '08:00:00', 2, 1) ,
		(NULL, 'Sofia-Liylin 2', 'Sunday', '09:30:00', 2, 2) ,	
		(NULL, 'Sofia-Liylin 3', 'Tuesday', '09:00:00', NULL, NULL) ,			
		(NULL, 'Plovdiv', 'Monday', '12:00:00', '1', '1');
		
INSERT INTO student_sport 
VALUES 	(1, 1),
		(2, 1),
		(3, 1),
		(4, 2),
		(5, 2),
		(6, 2),
		(1, 3),
		(2, 3),
		(3, 3);
		
INSERT INTO `school_sport_clubs`.`taxespayments` 
VALUES	(NULL, '1', '1', '200', '1', 2022, now()),
		(NULL, '1', '1', '200', '2', 2022, now()),
		(NULL, '1', '1', '200', '3', 2022, now()),
		(NULL, '1', '1', '200', '4', 2022, now()),
		(NULL, '1', '1', '200', '5', 2022, now()),
		(NULL, '1', '1', '200', '6', 2022, now()),
		(NULL, '1', '1', '200', '7', 2022, now()),
		(NULL, '1', '1', '200', '8', 2022, now()),
		(NULL, '1', '1', '200', '9', 2022, now()),
		(NULL, '1', '1', '200', '10', 2022, now()),
		(NULL, '1', '1', '200', '11', 2022, now()),
		(NULL, '1', '1', '200', '12', 2022, now()),
		(NULL, '2', '1', '250', '1', 2022, now()),
		(NULL, '2', '1', '250', '2', 2022, now()),
		(NULL, '2', '1', '250', '3', 2022, now()),
		(NULL, '2', '1', '250', '4', 2022, now()),
		(NULL, '2', '1', '250', '5', 2022, now()),
		(NULL, '2', '1', '250', '6', 2022, now()),
		(NULL, '2', '1', '250', '7', 2022, now()),
		(NULL, '2', '1', '250', '8', 2022, now()),
		(NULL, '2', '1', '250', '9', 2022, now()),
		(NULL, '2', '1', '250', '10', 2022, now()),
		(NULL, '2', '1', '250', '11', 2022, now()),
		(NULL, '2', '1', '250', '12', 2022, now()),
		(NULL, '3', '1', '250', '1', 2022, now()),
		(NULL, '3', '1', '250', '2', 2022, now()),
		(NULL, '3', '1', '250', '3', 2022, now()),
		(NULL, '3', '1', '250', '4', 2022, now()),
		(NULL, '3', '1', '250', '5', 2022, now()),
		(NULL, '3', '1', '250', '6', 2022, now()),
		(NULL, '3', '1', '250', '7', 2022, now()),
		(NULL, '3', '1', '250', '8', 2022, now()),
		(NULL, '3', '1', '250', '9', 2022, now()),
		(NULL, '3', '1', '250', '10', 2022, now()),
		(NULL, '3', '1', '250', '11', 2022, now()),
		(NULL, '3', '1', '250', '12', 2022, now()),
		(NULL, '1', '2', '200', '1', 2022, now()),
		(NULL, '1', '2', '200', '2', 2022, now()),
		(NULL, '1', '2', '200', '3', 2022, now()),
		(NULL, '1', '2', '200', '4', 2022, now()),
		(NULL, '1', '2', '200', '5', 2022, now()),
		(NULL, '1', '2', '200', '6', 2022, now()),
		(NULL, '1', '2', '200', '7', 2022, now()),
		(NULL, '1', '2', '200', '8', 2022, now()),
		(NULL, '1', '2', '200', '9', 2022, now()),
		(NULL, '1', '2', '200', '10', 2022, now()),
		(NULL, '1', '2', '200', '11', 2022, now()),
		(NULL, '1', '2', '200', '12', 2022, now()),
		(NULL, '4', '2', '200', '1', 2022, now()),
		(NULL, '4', '2', '200', '2', 2022, now()),
		(NULL, '4', '2', '200', '3', 2022, now()),
		(NULL, '4', '2', '200', '4', 2022, now()),
		(NULL, '4', '2', '200', '5', 2022, now()),
		(NULL, '4', '2', '200', '6', 2022, now()),
		(NULL, '4', '2', '200', '7', 2022, now()),
		(NULL, '4', '2', '200', '8', 2022, now()),
		(NULL, '4', '2', '200', '9', 2022, now()),
		(NULL, '4', '2', '200', '10', 2022, now()),
		(NULL, '4', '2', '200', '11', 2022, now()),
		(NULL, '4', '2', '200', '12', 2022, now()),
		/**2021**/
		(NULL, '1', '1', '200', '1', 2021, now()),
		(NULL, '1', '1', '200', '2', 2021, now()),
		(NULL, '1', '1', '200', '3', 2021, now()),
		(NULL, '1', '1', '200', '4', 2021, now()),
		(NULL, '1', '1', '200', '5', 2021, now()),
		(NULL, '1', '1', '200', '6', 2021, now()),
		(NULL, '1', '1', '200', '7', 2021, now()),
		(NULL, '1', '1', '200', '8', 2021, now()),
		(NULL, '1', '1', '200', '9', 2021, now()),
		(NULL, '1', '1', '200', '10', 2021, now()),
		(NULL, '1', '1', '200', '11', 2021, now()),
		(NULL, '1', '1', '200', '12', 2021, now()),
		(NULL, '2', '1', '250', '1', 2021, now()),
		(NULL, '2', '1', '250', '2', 2021, now()),
		(NULL, '2', '1', '250', '3', 2021, now()),
		(NULL, '2', '1', '250', '4', 2021, now()),
		(NULL, '2', '1', '250', '5', 2021, now()),
		(NULL, '2', '1', '250', '6', 2021, now()),
		(NULL, '2', '1', '250', '7', 2021, now()),
		(NULL, '2', '1', '250', '8', 2021, now()),
		(NULL, '2', '1', '250', '9', 2021, now()),
		(NULL, '2', '1', '250', '10', 2021, now()),
		(NULL, '2', '1', '250', '11', 2021, now()),
		(NULL, '2', '1', '250', '12', 2021, now()),
		(NULL, '3', '1', '250', '1', 2021, now()),
		(NULL, '3', '1', '250', '2', 2021, now()),
		(NULL, '3', '1', '250', '3', 2021, now()),
		(NULL, '3', '1', '250', '4', 2021, now()),
		(NULL, '3', '1', '250', '5', 2021, now()),
		(NULL, '3', '1', '250', '6', 2021, now()),
		(NULL, '3', '1', '250', '7', 2021, now()),
		(NULL, '3', '1', '250', '8', 2021, now()),
		(NULL, '3', '1', '250', '9', 2021, now()),
		(NULL, '3', '1', '250', '10', 2021, now()),
		(NULL, '3', '1', '250', '11', 2021, now()),
		(NULL, '3', '1', '250', '12', 2021, now()),
		(NULL, '1', '2', '200', '1', 2021, now()),
		(NULL, '1', '2', '200', '2', 2021, now()),
		(NULL, '1', '2', '200', '3', 2021, now()),
		(NULL, '1', '2', '200', '4', 2021, now()),
		(NULL, '1', '2', '200', '5', 2021, now()),
		(NULL, '1', '2', '200', '6', 2021, now()),
		(NULL, '1', '2', '200', '7', 2021, now()),
		(NULL, '1', '2', '200', '8', 2021, now()),
		(NULL, '1', '2', '200', '9', 2021, now()),
		(NULL, '1', '2', '200', '10', 2021, now()),
		(NULL, '1', '2', '200', '11', 2021, now()),
		(NULL, '1', '2', '200', '12', 2021, now()),
		(NULL, '4', '2', '200', '1', 2021, now()),
		(NULL, '4', '2', '200', '2', 2021, now()),
		(NULL, '4', '2', '200', '3', 2021, now()),
		(NULL, '4', '2', '200', '4', 2021, now()),
		(NULL, '4', '2', '200', '5', 2021, now()),
		(NULL, '4', '2', '200', '6', 2021, now()),
		(NULL, '4', '2', '200', '7', 2021, now()),
		(NULL, '4', '2', '200', '8', 2021, now()),
		(NULL, '4', '2', '200', '9', 2021, now()),
		(NULL, '4', '2', '200', '10', 2021, now()),
		(NULL, '4', '2', '200', '11', 2021, now()),
		(NULL, '4', '2', '200', '12', 2021, now()),
		/**2020**/
		(NULL, '1', '1', '200', '1', 2020, now()),
		(NULL, '1', '1', '200', '2', 2020, now()),
		(NULL, '1', '1', '200', '3', 2020, now()),
		(NULL, '2', '1', '250', '1', 2020, now()),
		(NULL, '3', '1', '250', '1', 2020, now()),
		(NULL, '3', '1', '250', '2', 2020, now()),
		(NULL, '1', '2', '200', '1', 2020, now()),
		(NULL, '1', '2', '200', '2', 2020, now()),
		(NULL, '1', '2', '200', '3', 2020, now()),
		(NULL, '4', '2', '200', '1', 2020, now()),
		(NULL, '4', '2', '200', '2', 2020, now());


insert into salarypayments (coach_id, month, year, salaryAmount, dateOfPayment)
values (1, month(now()), year(now()), 1200, now()),
	(2, month(now()), year(now()), 2400, now()),
	(3, month(now()), year(now()), 3600, now());

-- 1
create view studentView
as 
select coaches.name as coachName, concat(sportgroups.id , " - " , sportgroups.location), sports.name as SportsName, year(now()), month(now()), salarypayments.salaryAmount
from coaches join sportgroups
on coaches.id  = sportgroups.coach_id
join sports
on sports.id = sportgroups.sport_id
join salarypayments
on salarypayments.coach_id = coaches.id;

-- 2
delimiter |
drop procedure if exists studentsInfo;
create procedure studentsInfo()
begin
select students.id, students.name
    from students join sportgroups
    on students.id in (
select student_id
        from student_sport
        where sportGroup_id = sportgroups.id
    )
    group by students.id
    having count(students.id) > 1;
end |
delimiter ;

-- 3
drop procedure if exists coachInfo;
delimiter |
create procedure coachInfo()
begin
select coaches.id, coaches.name
    from coaches left join sportgroups
    on coaches.id = sportgroups.coach_id
    where coaches.id not in (
select coach_id
        from sportgroups
    );
end |
delimiter ;

call coachInfo();

-- 4
delimiter |
drop procedure if exists converter;
create procedure converter(in amount double, in currency varchar(5), out returnAmount double)
begin
if (currency = "BGN")
    then
set returnAmount = amount * 0.51;
else if (currency = "EUR")
then
set returnAmount = amount * 1.94;
end if;
    end if;
end;
|
delimiter ;

-- 5
delimiter |
drop procedure if exists transactionIds;
create procedure transactionIds(in firstId int, in secondId int, in transferAmount double)
begin
declare firstCurrency varchar(5);
    declare secondCurrency varchar(5);
    
    select currency
    into firstCurrency
    from customer_accounts
    where id = firstId;
    
    select currency
    into secondCurrency
    from customer_accounts
    where id = secondId;
    
    if ((firstCurrency != 'BGN' and firstCurrency != 'EUR') and (secondCurrency != 'BGN' and secondCurrency != 'EUR'))
    then
	select "The two currency must be either 'BGN' or 'EUR'!";
		else
		if ((select amount from customer_accounts 
		where id = firstId) - transferAmount < 0)
		then
		select "Not enough money to withdraw!";
		    else
	    	    	start transaction;
			update customer_accounts
                	set amount = amount - transferAmount
                	where id = firstId;
                if (row_count() = 0)
                then
		    select "Transaction couldn't execute!";
                    rollback;
		else
		    if (firstCurrency != secondCurrency)
                    then
			set @returnAmount = 0;
			call converter(transferAmount, firstCurrency, @returnAmount);
			else
			set @returnAmount = transferAmount;
			end if;
                    update customer_accounts
                    set amount = amount + @returnAmount
                    where id = secondId;
                    
                    if (row_count() = 0)
                    then
			select "Transaction couldn't execute!";
                        rollback;
		    else
			commit;
		    end if;
	    end if;
    end if;
end if;
end |
delimiter ;

select * from customer_accounts;
call transactionIds(2, 1, 100000000000000000);
select * from customer_accounts;

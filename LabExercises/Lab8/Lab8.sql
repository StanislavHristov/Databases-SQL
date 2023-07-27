insert into salarypayments (coach_id, month, year, salaryAmount, dateOfPayment)
values (1, month(now()), year(now()), 1200, now()),
	(2, month(now()), year(now()), 2400, now()),
	(3, month(now()), year(now()), 3600, now());

-- 1
create view studentView
as 
select coaches.name as coachName, concat(sportgroups.id , " - " , sportgroups.location), sports.name as SportsName,  year(now()), month(now()), salarypayments.salaryAmount
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
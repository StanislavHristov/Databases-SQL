-- 1
use school_sport_clubs;

delimiter |
DROP procedure IF EXISTS zadacha1 |
CREATE procedure zadacha1(IN coachName VARCHAR (255))
BEGIN
SELECT sports.name, sportgroups.location, sportgroups.hourOfTraining, sportgroups.dayOfWeek, 
students.name, students.phone
FROM sportgroups
JOIN coaches ON sportgroups.coach_id = coaches.id
JOIN sports ON sportgroups.sport_id = sports.id
JOIN student_sport ON sportgroups.id = student_sport.sportgroup_id
JOIN students ON student_sport.student_id = students.id
WHERE coaches.name = coachName;
END;
|
delimiter ;
CALL zadacha1('Ivan Todorov Petkov');
 
-- 2
use school_sport_clubs;
 
delimiter |
DROP procedure IF EXISTS zadacha2 |
CREATE procedure zadacha2(IN sportId INT)
BEGIN
SELECT sports.name, students.name, coaches.name
FROM students
JOIN student_sport ON students.id = student_sport.student_id
JOIN sportgroups ON student_sport.sportgroup_id = sportgroups.id
JOIN sports ON sportgroups.sport_id = sports.id
JOIN coaches ON sportgroups.coach_id = coaches.id
WHERE sportId = sports.id;
END;
|
delimiter ;
CALL zadacha2(1);
 
-- 3
use school_sport_clubs;

delimiter |
DROP procedure IF EXISTS zadacha3 |
CREATE procedure zadacha3(IN studentName VARCHAR(255), inYear YEAR)
BEGIN
SELECT studentName, AVG(taxesPayments.paymentAmount) AS AverageTaxes
FROM students
JOIN taxespayments ON students.id = taxespayments.student_id
WHERE studentName = students.name
AND inYear = taxespayments.year;
END;
|
delimiter ;
CALL zadacha3('Iliyan Ivanov', 2022);
 
-- 4
use school_sport_clubs;
 
delimiter |
DROP procedure IF EXISTS zadacha4 |
CREATE procedure zadacha4(IN coachName VARCHAR(255))
BEGIN
DECLARE counter INT;
SELECT COUNT(sportgroups.coach_id) INTO counter
FROM coaches
JOIN sportgroups ON sportgroups.coach_id = coaches.id
WHERE coaches.name = coachName;
IF(counter = 0 OR counter = NULL)
THEN
SELECT 'No groups for the trainer!' AS RESULT;
ELSE
SELECT counter;
END IF;
END;
|
delimiter ;
CALL zadacha4('Ivan Todorov Petkov');

-- 5
DELIMITER /
DROP PROCEDURE IF EXISTS transfer_money;
CREATE PROCEDURE transfer_money(IN from_acc_id INT, IN to_acc_id INT, IN Amount DECIMAL(10,2))
BEGIN
    DECLARE from_acc_balance DECIMAL(10, 2);
    DECLARE to_acc_balance DECIMAL(10, 2);
    START TRANSACTION;
    SELECT amount INTO from_acc_balance FROM customer_accounts WHERE id = from_acc_id FOR UPDATE;
    SELECT amount INTO to_acc_balance FROM customer_accounts WHERE id = to_acc_id FOR UPDATE;

    IF from_acc_balance < Amount THEN
        SET @error_message = 'Not enough money to transfer';
    ELSE
        UPDATE customer_accounts SET amount = amount - Amount WHERE id = from_acc_id;
        IF ROW_COUNT() = 0 THEN
            SET @error_message = 'Transaction failed';
            ROLLBACK;
            SELECT @error_message;
        ELSE
            UPDATE customer_accounts SET amount = amount + Amount WHERE id = to_acc_id;
            IF ROW_COUNT() = 0 THEN
                SET @error_message = 'Transaction failed';
                ROLLBACK;
                SELECT @error_message;
            ELSE
                COMMIT;
                SELECT 'Transaction successfull';
            END IF;
        END IF;
    END IF;
END /
delimiter ;
CALL transfer_money(1, 2, 5000);

-- 6
DELIMITER %
DROP PROCEDURE IF EXISTS transfer_money;
CREATE PROCEDURE transfer_money(
    IN sender_name VARCHAR(255),
    IN recipient_name VARCHAR(255),
    IN transferAmount DOUBLE,
    IN currency VARCHAR(10)
)
BEGIN
    DECLARE sender_id, recipient_id, affected_rows INT;
    DECLARE sender_balance, recipient_balance DOUBLE;
    
    SELECT id INTO sender_id FROM customers WHERE name = sender_name;
    SELECT id INTO recipient_id FROM customers WHERE name = recipient_name;
    
    SELECT transferAmount INTO sender_balance FROM customer_accounts WHERE customer_id = sender_id AND currency = currency;
    SELECT transferAmount INTO recipient_balance FROM customer_accounts WHERE customer_id = recipient_id AND currency = currency;
    
    IF sender_balance < amount THEN
        SELECT 'Not enough funds' AS error_message;
    ELSE
        UPDATE customer_accounts SET transferAmount = sender_balance - transferAmount WHERE customer_id = sender_id AND currency = currency;
        SET affected_rows = ROW_COUNT();
        IF affected_rows = 0 THEN
            SELECT 'Transaction failed' AS error_message;
        ELSE
            UPDATE customer_accounts SET transferAmount = recipient_balance + transferAmount WHERE customer_id = recipient_id AND currency = currency;
            SET affected_rows = ROW_COUNT();
            IF affected_rows = 0 THEN
                UPDATE customer_accounts SET transferAmount = sender_balance WHERE customer_id = sender_id AND currency = currency;
                SELECT 'Transaction failed' AS error_message;
            ELSE
                SELECT 'Transaction successful' AS status_message;
            END IF;
        END IF;
    END IF;
END;

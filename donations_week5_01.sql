USE gc200395896;

DROP TABLE IF EXISTS donations;
CREATE TABLE donations (

first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
recipient VARCHAR(255) NOT NULL );

INSERT INTO donations (first_name, last_name, recipient)
VALUES ('Eric', 'Smith', 'Barrie, Liberal Party');

INSERT INTO donations (first_name, last_name, recipient)
VALUES ('Alicia', 'Jones', 'Simcoe North, Conservative Party');

INSERT INTO donations (first_name, last_name, recipient)
VALUES ('Sue', 'Wilson', 'London South, NDP');

/*View the donations table*/
SELECT * FROM donations;
/*Is this in 1NF (first normal form)?
 No, it needs a unqiue identifier (key) for each row
 Let add a column called donorID*/
 ALTER TABLE donations
 ADD donorID INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

/*Let's make the donorID the first column*/
ALTER TABLE donations
MODIFY COLUMN donorID INT FIRST;

/*Let's move the recipient column to be the 2nd column*/
ALTER TABLE donations
MODIFY COLUMN recipient VARCHAR(255) AFTER donorID;


/*The riding and political parties are currently in the same column, which is not atomic.  As such, we need to
  add 2 columns*/
  ALTER TABLE donations
  ADD riding VARCHAR(50),
  ADD party VARCHAR(50);

SELECT * FROM donations;
/*We need to populate these new fields, let's write some queries to do that*/
/*OR try substring index*/
SELECT recipient, SUBSTR(recipient,1,INSTR(recipient, ',')-1) FROM donations;

/*Now let's update the riding column with this information*/
UPDATE donations
SET riding = SUBSTR(recipient,1,INSTR(recipient, ',')-1);

/*Create a query to give us the political party*/
SELECT recipient, SUBSTR(recipient,INSTR(recipient, ',')+2) FROM donations;
/*We've tested our query, let's update the table*/
UPDATE donations
SET party = SUBSTR(recipient,INSTR(recipient, ',')+2);
/*We now need to DROP the recipient column*/
ALTER TABLE donations
DROP COLUMN recipient;
/*We are now in first normal form!  Also known as 1NF*/
SELECT * FROM donations;

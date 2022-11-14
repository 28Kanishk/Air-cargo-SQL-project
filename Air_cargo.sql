categoriescategoriescategoriescategoriescategoriescategories#--------ER Diagram---------- Q1

#---------Create Table Route_details------------ Q2

Create table Route_details (
Route_id int(11) not null,
Flight_num int(11) not null,
Origin_airport varchar(255),
Destination_airport varchar(255),
Aircraft_id varchar(11),
Distance_miles int(11) not null,
constraint chk_route_details check (distance_miles>0 and 'flight_num'),
unique (route_id)
);

#------------(customers) who have travelled in routes 01 to 25------- Q3
Select route_id from passengers_on_flights
where route_id between 1 and 25;

#------------the number of passengers and total revenue in business class------- Q4
Select sum(no_of_tickets), class_id, sum(price_per_ticket)
from ticket_details
where class_id = 'bussiness';

#------------full name of the customer by extracting the first name and last name----- Q5
Select *, 
concat(first_name,last_name) as full_name 
from customer;

#------------extract the customers who have registered and booked a ticket---------- Q6
select customer.customer_id, ticket_details.aircraft_id
from customer
inner join ticket_details on customer.customer_id = ticket_details.customer_id
order by customer.customer_id;

#----the customer’s first name and last name based on their customer ID and brand (Emirates)----- Q7
select customer.customer_id, customer.first_name, customer.last_name, ticket_details.brand
from customer
left join ticket_details on customer.customer_id = ticket_details.customer_id
where brand = 'emirates'
order by customer_id asc;

#------the customers who have travelled by Economy Plus class using Group By and Having clause----- Q8
Select count(customer_id), class_id
from passengers_on_flights
group by customer_id
having class_id = 'economy plus';

Select customer.customer_id, customer.first_name, passengers_on_flights.class_id
from customer
inner join passengers_on_flights on customer.customer_id = passengers_on_flights.customer_id
group by  customer_id
having class_id = 'economy plus';

#-------identify whether the revenue has crossed 10000 using the IF clause------- Q9
Select count(customer_id), class_id, sum(Price_per_ticket)
from ticket_details
group by class_id;

#-----query to create and grant access to a new user to perform operations on a database---- Q10
#______grant and revoke code______
grant all privileges on *.* to 'code'@'localhost';
revoke all privileges on *.* from 'code'@'localhost';

#__________ code for grant only selected databased and table____________
grant all privileges on kanishksd.* to 'code'@'localhost';
grant all privileges on kanishksd.product to 'code'@'localhost';

#__________show access has been granted or not and show users_________
select user from mysql.user;
show grants for 'code'@'localhost';

grant all on mysql.* to 'code'@'localhost' identified by 'Pass@123';

#------------find the maximum ticket price for each class using window functions---------- Q11
Select class_id, max(price_per_ticket) as each_class_price
from ticket_details
group by class_id;

#--------extract the passengers whose route ID is 4 by improving the speed and performance-------- Q12
Select customer.customer_id, customer.first_name, passengers_on_flights.route_id
from customer
left join passengers_on_flights on customer.customer_id = passengers_on_flights.customer_id
having route_id = 4;

#------For the route ID 4, write a query to view the execution plan of the passengers_on_flights table---- Q13
select customer.first_name, customer.gender, passengers_on_flights.route_id, passengers_on_flights.class_id,
ticket_details.brand, ticket_details.Price_per_ticket
from ((customer
inner join passengers_on_flights on customer.customer_id = passengers_on_flights.customer_id)
inner join ticket_details on customer.customer_id = ticket_details.customer_id)
having route_id = 4;

#-----calculate the total price of all tickets booked by a customer across different aircraft IDs using rollup function----Q14
Select aircraft_id, sum(price_per_ticket)
from ticket_details
group by (aircraft_id) with rollup;

#-------create a view with only business class customers along with the brand of airlines-------- Q15
create view business_view as
select class_id, brand
from ticket_details
where class_id = 'bussiness';

Select * from business_view;

/*--------create a stored procedure to get the details of all passengers flying between a range of routes defined in run time.
 Also, return an error message if the table doesn't exist----------- Q16 */

call Routerange;
Alter procedure routerange
comment 'return an error message if the table doesnt exist';
Drop procedure if exists routerange;

/*--------create a stored procedure that extracts all the details from the routes table where the travelled distance 
	       is more than 2000 miles---------- Q17 */

call `greter_2000`;

/*--------create a stored procedure that groups the distance travelled by each flight into three categories.
		  The categories are, short distance travel (SDT) for >=0 AND <= 2000 miles, 
          intermediate distance travel (IDT) for >2000 AND <=6500, and long-distance travel (LDT) for >6500--------- Q18 */
          
select route_id, flight_num, origin_airport, distance_miles, categories(distance_miles)
from routes;

/*--------query to extract ticket purchase date, customer ID, class ID and specify if the complimentary services 
are provided for the specific class using a stored function in stored procedure on the ticket_details table---------- Q19 */
Select customer_id, p_date, class_id, complimentary_service(class_id) 
from ticket_details
order by customer_id;

/*---query to extract the first record of the customer whose last name ends with Scott using a cursor from the customer table--- Q20 */
Select * from customer
where last_name like '%scott';

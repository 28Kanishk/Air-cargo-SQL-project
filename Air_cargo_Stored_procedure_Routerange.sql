/*--------create a stored procedure to get the details of all passengers flying between a range of routes defined in run time.
 Also, return an error message if the table doesn't exist----------- Q16 */

CREATE DEFINER=`root`@`localhost` PROCEDURE `Routerange`()
BEGIN
Select Passengers_on_flights.Customer_id, Passengers_on_flights.class_id, Passengers_on_flights.travel_date, routes.destination_airport, routes.distance_miles
from routes
right join Passengers_on_flights on Passengers_on_flights.route_id = Routes.route_id
order by customer_id;
END
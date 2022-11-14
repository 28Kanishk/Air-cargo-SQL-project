CREATE DEFINER=`root`@`localhost` PROCEDURE `Greter_2000`()
BEGIN
Select * from Routes
where distance_miles > 2000;
END
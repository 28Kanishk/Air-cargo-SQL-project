CREATE DEFINER=`root`@`localhost` FUNCTION `categories`(distance_miles int) RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
      declare categories varchar(20);
      if (distance_miles <=2000 and distance_miles >=0)  then
         set categories = 'SDT';
       elseif (distance_miles <=6500 and distance_miles >=2000) then
         set categories = 'IDT';
        elseif distance_miles >=6500 then
         set categories = 'LDT';
        end if; 
RETURN (categories);
END
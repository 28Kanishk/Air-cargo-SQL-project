CREATE DEFINER=`root`@`localhost` FUNCTION `Complimentary_service`(class_id varchar(20)) RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
       declare complimentary_service varchar(20);
       if class_id = 'bussiness' then
          set complimentary_service = 'yes';
       elseif class_id = 'Economy plus' then
		  set complimentary_service = 'yes';
       elseif class_id = 'first class'then
		  set complimentary_service = 'no';
       elseif class_id = 'Economy' then
	      set complimentary_service = 'no';
     end if;
RETURN (complimentary_service);
END
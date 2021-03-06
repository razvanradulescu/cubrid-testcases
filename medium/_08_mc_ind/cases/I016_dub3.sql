autocommit off;
SELECT MAX(attr1_int_unique_idx) + 1 TO :maxvalue FROM x_virtual_c2;
INSERT INTO x_virtual_c2 
    SELECT  attr1_int_unique_idx      + :maxvalue, 
            attr1_int_unique_noidx    + :maxvalue, 
            cast(attr1_int_unique_idx + :maxvalue as string),   
            cast(attr1_int_unique_idx + :maxvalue as string),   
            attr3_smallint_idx,       
            attr3_smallint_noidx,     
            attr4_float_idx,          
            attr4_float_noidx,        
            attr5_double_idx,         
            attr5_double_noidx,       
            attr6_longstr_idx,        
            attr6_longstr_noidx,      
            attr7_time_idx,           
            attr7_time_noidx,         
            attr8_date_idx,           
            attr8_date_noidx,         
            attr9_utime_idx,          
            attr9_utime_noidx,        
            attr10_money_idx,         
            attr10_money_noidx,       
            attr11_int_2vals_idx,     
            attr11_int_2vals_noidx,   
            attr12_int_4vals_idx,     
            attr12_int_4vals_noidx,   
            attr13_int_5vals_idx,     
            attr13_int_5vals_noidx,   
            attr14_int_10vals_idx,    
            attr14_int_10vals_noidx,  
            attr15_int_50vals_idx,    
            attr15_int_50vals_noidx,  
            attr16_dep_tag_noidx,     
            attr16_objpath            
        FROM x_virtual_c2;
COMMIT WORK;
SELECT COUNT(*) FROM x_base_c2
 	WHERE attr16_dep_tag_noidx LIKE '%INITIAL ELEMENT%'
	   OR attr16_dep_tag_noidx LIKE '%@%';
COMMIT WORK;

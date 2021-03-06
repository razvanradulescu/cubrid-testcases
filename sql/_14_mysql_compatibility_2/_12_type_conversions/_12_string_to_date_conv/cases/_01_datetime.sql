--Parsing a DATETIME from a string using CAST

-- Read full DATETIME from string directly --
SELECT CAST('2009-09-02 10:48:22.143' AS DATETIME);

-- Truncate (ignore) extra number of digits of  milliseconds precision and retain only 3 --
SELECT CAST('2009-09-02 10:48:22.14399999' AS DATETIME);

-- Ignore trailing characters (non-digits) --
SELECT CAST('2009-09-02 10:48:22.14399999asdf' AS DATETIME);
SELECT CAST('2009-09-02 10:48:22.14399999:::::' AS DATETIME);
SELECT CAST('2009-09-02 10:48:22.14399999       ' AS DATETIME);

-- Ignore leading/trailing spaces --
SELECT CAST('    2009-09-02 10:48:22.14399999     ' AS DATETIME);

-- Allow any sequence of non-alphabetic non-blank characters as field separators --
SELECT CAST('    2009@09$$02___10;48,22.143999' AS DATETIME);
SELECT CAST('    2009@@@@@$$$$$$$$$$!#¤¤%%&&/%/(*?=)++009$$02__10;48.22.143999' AS DATETIME); 

-- The number of milliseconds should be preceded by the decimal point --
SELECT CAST('    2009@09$$02___10;48,22!143999' AS DATETIME);

-- With a space separted date and time parts, year is optional --
--SELECT CAST('        9$$02_ _ _10]48[22.143999' AS DATETIME);
select if(CAST('        9$$02_ _ _10]48[22.143999' AS DATETIME)=concat(year(sysdate),'-09-02 10:48:22.143'),'ok','nok');

-- Time-date strings are also accepted --
SELECT CAST('22 2018-10-12' AS DATETIME);
SELECT CAST('11pm 2012-10-12' AS DATETIME);
SELECT CAST('11:02                                   PM                         2012-10-12' AS DATETIME);
SELECT CAST('11:::::::::02PM 2012-10-12' AS DATETIME);
SELECT CAST('11:::::::::02:10.2343PM 2012-10-12' AS DATETIME);
--SELECT CAST(':22 10-12' AS DATETIME);
select if(CAST(':22 10-12' AS DATETIME)=concat(year(sysdate),'-10-12 00:22:00.0'),'ok','nok');
--SELECT CAST(':22:10 12/10' AS DATETIME);
select if(CAST(':22:10 12/10' AS DATETIME)=concat('12:22:10.000 AM 12/10/',year(sysdate)),'ok','nok'); 

-- A two-digits year means year within century --
SELECT CAST('       01@09$$02____10~48.22.143999' AS DATETIME);

-- A one, three or four digits year means year value as given --
SELECT CAST('     001@09$$02____10^48#22.143855'  AS DATETIME);
SELECT CAST('         1@09$$02____10^48#22.143855'  AS DATETIME);

-- Forward slashes make dates in MM/DD/YY[YY] format --
--SELECT CAST('10/31 10:48:2.2' AS DATETIME);
select if(CAST('10/31 10:48:2.2' AS DATETIME)=concat('10:48:02.200 AM 10/31/',year(sysdate)),'ok','nok');
SELECT CAST('10/31/00 10:48:2.2' AS DATETIME);
SELECT CAST('10/31/00//10//48//2.2' AS DATETIME);
--SELECT CAST('10//31 10:48:2.2' AS DATETIME);
select if(CAST('10//31 10:48:2.2' AS DATETIME)=concat('10:48:02.200 AM 10/31/',year(sysdate)),'ok','nok');
SELECT CAST('10//31//09 10:48:2.2' AS DATETIME);

-- Other characters as date fields separators make --
-- dates in [YY]YY-MM-DD format --
SELECT CAST('31/10/-09 10:48:2.2' AS DATETIME);
SELECT CAST('31/-10/09 10:48:2.2' AS DATETIME);
SELECT CAST('31++10++09 10:48:2.2' AS DATETIME);

-- The English or the current locale "am"/"pm" designators may follow time component --
SELECT CAST('10:11:22:10:48.25.2pm' AS DATETIME);
--SELECT CAST('11-22 10:48:00        AM' AS DATETIME);
select if(CAST('11-22 10:48:00        AM' AS DATETIME)=concat('10:48:00.000 AM 11/22/',year(sysdate)),'ok','nok');
--SELECT CAST('11-22 10:48:00        PM1' AS DATETIME);
select if(CAST('11-22 10:48:00        PM1' AS DATETIME)=concat('10:48:00.000 PM 11/22/',year(sysdate)),'ok','nok');
--SELECT CAST('11/22 2:0:1        am%%%%' AS DATETIME);
select if(CAST('11/22 2:0:1        am%%%%' AS DATETIME)=concat('02:00:01.000 AM 11/22/',year(sysdate)),'ok','nok');

-- The "am"/"pm" designators must be somehow separated from following alphabetic characters to be recongnized --
 	-- no "PM" designator is recognized as part of the time string --
SELECT CAST('10:11:22:10.48.25.2PMMs1' AS DATETIME);
			    -- no "pm" designator recognzide here --
--SELECT CAST('11-22 10:48:00        pmw' AS DATETIME);
select if(CAST('11-22 10:48:00        pmw' AS DATETIME)=concat('10:48:00.000 AM 11/22/',year(sysdate)),'ok','nok');

--Time or trailing time components are all optional --
SELECT CAST('31-11_22@10@48*2' AS DATETIME);
--SELECT CAST('11_22@ 10@48.2' AS DATETIME);
select if(CAST('11_22@ 10@48.2' AS DATETIME)=concat(year(sysdate),'-11-22 10:48:02.0'),'ok','nok');

--SELECT CAST('11//22 10@48.2' AS DATETIME);
select if(CAST('11//22 10@48.2' AS DATETIME)=concat(year(sysdate),'-11-22 10:48:02.0'),'ok','nok');
SELECT CAST('11/22/31“10“48' AS DATETIME);
--SELECT CAST('11//22//+ /“10“48“00 pm am' AS DATETIME);
select if(CAST('11//22//+ /“10“48“00 pm am' AS DATETIME)=concat(year(sysdate),'-11-22 22:48:00.0'),'ok','nok');

SELECT CAST('11-11-22|10' AS DATETIME); 
--SELECT CAST('11-22&&&& 0pm5' AS DATETIME);
select if(CAST('11-22&&&& 0pm5' AS DATETIME)=concat('12:00:00.000 PM 11/22/',year(sysdate)),'ok','nok');

SELECT CAST('2009-10-18&&&&&' AS DATETIME);
SELECT CAST('10/18////2009a' AS DATETIME);
--SELECT CAST('11-22' AS DATETIME);
select if(CAST('11-22' AS DATETIME)=date(concat(year(sysdate),'-11-22')),'ok','nok');
--SELECT CAST('11/22' AS DATETIME);
select if(CAST('11/22' AS DATETIME)=date(concat(year(sysdate),'-11-22')),'ok','nok');
--SELECT CAST('1-2' AS DATETIME);
select if(CAST('1-2' AS DATETIME)=date(concat(year(sysdate),'-01-02')),'ok','nok');

-- any alphabetic characters will terminate the string, will be considered trailing characters and will be --
-- ignored together with the rest of the string --
SELECT CAST('2009-10-12 T 02:28:10' AS DATETIME);
SELECT CAST('2009-10-12T02:28:10' AS DATETIME);
--SELECT CAST('10/11T10:18' AS DATETIME);
select if(CAST('10/11T10:18' AS DATETIME)=date(concat(year(sysdate),'-10-11')),'ok','nok');

-- Less then two datetime fields will generate an error--
SELECT CAST('   timestamp 2009-10-20 11:28' AS DATETIME);
SELECT CAST('10' AS DATETIME);
SELECT CAST('10 1' AS DATETIME);

-- Out-of range values for otherwise properly delimited fields will generate an error  --
SELECT CAST('2009-10-20 10:48:1432.23 ' AS DATETIME);
SELECT CAST('2009-10-20 10:48:6747023958734098573490857432.2T' AS DATETIME);

SELECT CAST('10/20//2009 10:480:14.23' AS DATETIME);
SELECT CAST('10/20//2009 10:47489023457823409857234908:14.23' AS DATETIME);

SELECT CAST('10/20//2009 1043:17:14:23' AS DATETIME);
SELECT CAST('10/20//2009 1043102938470123984712309487:17:14:23' AS DATETIME);

SELECT CAST('2009-10-80 10:48:14.23' AS DATETIME);
SELECT CAST('2009-10-8054123908470239847432 10:48:14.23' AS DATETIME);

SELECT CAST('2009-14-20 10:48:14.23' AS DATETIME);
SELECT CAST('2009-141029384723098472390487-20 10:48:14.23' AS DATETIME);

-- Large enough values for year, in this case, will result in an attempt at parsing the year as a --
-- timestamp in compact format (see below) --
SELECT CAST('010202-14-20 10:48:14.23' AS DATETIME);

-- Input can also be written in compact form without separators --

      --                M DD --
--SELECT CAST(           '320.asdf' AS DATETIME);
select if(CAST(           '320.asdf' AS DATETIME)=date(concat(year(sysdate),'-03-20')),'ok','nok');
      --             MM DD --
--SELECT CAST(         '1120.asdf' AS DATETIME);
select if(CAST(           '1120.asdf' AS DATETIME)=date(concat(year(sysdate),'-11-20')),'ok','nok');
      --          Y MM DD --
SELECT CAST(       '21120.asdf' AS DATETIME);
      --        YY MM DD --
SELECT CAST(     '111120.asdf' AS DATETIME);
      --      YYY MM DD --
SELECT CAST(   '9108123.asdf' AS DATETIME);
      --    YYYY MM DD --
SELECT CAST( '19121120.asdf' AS DATETIME);

		--       YY MM DD HH    M         --
SELECT CAST('191211208'                  AS DATETIME);
        --       YY MM DD HH MM         --
SELECT CAST('1912112008'                AS DATETIME);
        --       YY MM DD HH MM   S    --
SELECT CAST('19121120086'              AS DATETIME);
        --       YY MM DD HH MM SS    --
SELECT CAST('191211200816'            AS DATETIME);
        --       YY MM DD HH MM SS.s --
SELECT CAST('1912111008161'          AS DATETIME);

        --   YYYY MM DD HH MM SS    --
SELECT CAST('19121108102245'        AS DATETIME);
        --   YYYY MM DD HH MM SS.sss --
SELECT CAST('19121108102245678'  AS DATETIME);

        --   YYYY MM DD HH MM SS.s --
SELECT CAST('191211081022456.78' AS DATETIME);
        --       YY MM DD HH MM   S.ssss... --
SELECT CAST('10121120081.6842'     AS DATETIME);
        --       YY MM DD HH MM SS.ssss... --
SELECT CAST('101211200812.6842'   AS DATETIME);

-- Compact form also understands am/pm strings --
		--       YY MM DD HH    M         --
SELECT CAST('191211108pm   '                  AS DATETIME);
        --       YY MM DD HH MM         --
SELECT CAST('1912111008 pm  '                AS DATETIME);
        --       YY MM DD HH MM   S    --
SELECT CAST('19121110086  pm '              AS DATETIME);
        --       YY MM DD HH MM SS    --
SELECT CAST('191211100816   pm'            AS DATETIME);
        --       YY MM DD HH MM SS.s --
SELECT CAST('1912111008161 pm  '          AS DATETIME);

        --      YY MM DD HH MM   S.ssss... --
SELECT CAST('10121111081.6842  PM '     AS DATETIME);
        --      YY MM DD HH MM SS.ssss... --
SELECT CAST('101211100812.6842  PM   '   AS DATETIME);
       --   YYYY MM DD HH MM SS.sss --
SELECT CAST('19121108102245678 PM'  AS DATETIME);

-- Compact/separated forms ignore "pm" strings for dates --
      --                M DD --
--SELECT CAST(           '320pm.asdf' AS DATETIME);
select if(CAST(           '320pm.asdf' AS DATETIME)=date(concat(year(sysdate),'-03-20')),'ok','nok');
      --             MM DD --
--SELECT CAST(         '1120pm.asdf' AS DATETIME);
select if(CAST(           '1120pm.asdf' AS DATETIME)=date(concat(year(sysdate),'-11-20')),'ok','nok');

      --          Y MM DD --
SELECT CAST(       '21120   pm   .asdf' AS DATETIME);
      --        YY MM DD --
SELECT CAST(     '111120PM  .asdf' AS DATETIME);
      --      YYY MM DD --
SELECT CAST(   '9108123  PM.asdf' AS DATETIME);
      --    YYYY MM DD --
SELECT CAST( '19121120 PM.asdf' AS DATETIME);

SELECT CAST('2009-10-18pm&&&&&' AS DATETIME);
SELECT CAST('10/18////2009pm.a' AS DATETIME);
--SELECT CAST('11-22 pm  ' AS DATETIME);
select if(CAST('11-22 pm  ' AS DATETIME)=date(concat(year(sysdate),'-11-22')),'ok','nok');
--SELECT CAST('11/22 Pm ' AS DATETIME);
select if(CAST('11/22 Pm  ' AS DATETIME)=date(concat(year(sysdate),'-11-22')),'ok','nok');
--SELECT CAST('1-2pM  ' AS DATETIME);
select if(CAST('1-2pM  ' AS DATETIME)=date(concat(year(sysdate),'-01-02')),'ok','nok');

-- Invalid values in compact forms also generate errors --
SELECT CAST('1802' AS DATETIME);
SELECT CAST('1140' AS DATETIME);
SELECT CAST('20091033' AS DATETIME);
SELECT CAST('20092310' AS DATETIME);
SELECT CAST('2009121062' AS DATETIME);
SELECT CAST('200912105980' AS DATETIME);
SELECT CAST('20091210596008' AS DATETIME);
SELECT CAST('20091210595980' AS DATETIME);

-- Create a table with all the above hard-coded string values --
CREATE TABLE
	DatesText
		(
			TextID SMALLINT AUTO_INCREMENT PRIMARY KEY,
			DateText VARCHAR(255),
			DateNText NCHAR VARYING(255),
			DateFText CHAR(255),
			DateFNText NCHAR(255)
		);
		
INSERT
    INTO DatesText(DateText, DateNText, DateFText, DateFNText)
    VALUES
	('2009-09-02 10:48:22.143',  N'2009-09-02 10:48:22.143', '2009-09-02 10:48:22.143', N'2009-09-02 10:48:22.143'),
	('2009-09-02 10:48:22.14399999', N'2009-09-02 10:48:22.14399999', '2009-09-02 10:48:22.14399999', N'2009-09-02 10:48:22.14399999'),
	('2009-09-02 10:48:22.14399999asdf', N'2009-09-02 10:48:22.14399999asdf', '2009-09-02 10:48:22.14399999asdf', N'2009-09-02 10:48:22.14399999asdf'),
	('2009-09-02 10:48:22.14399999:::::', N'2009-09-02 10:48:22.14399999:::::', '2009-09-02 10:48:22.14399999:::::', N'2009-09-02 10:48:22.14399999:::::'),
	('2009-09-02 10:48:22.14399999       ', N'2009-09-02 10:48:22.14399999       ', '2009-09-02 10:48:22.14399999       ', N'2009-09-02 10:48:22.14399999       '),
	('    2009-09-02 10:48:22.14399999     ', N'    2009-09-02 10:48:22.14399999     ', '    2009-09-02 10:48:22.14399999     ', N'    2009-09-02 10:48:22.14399999     '),
	('    2009@09$$02___10;48,22.143999', N'    2009@09$$02___10;48,22.143999', '    2009@09$$02___10;48,22.143999', N'    2009@09$$02___10;48,22.143999'),
	('    2009@@@@@$$$$$$$$$$!#¤¤%%&&/%/(*?=)++009$$02__10;48.22.143999', N'    2009@@@@@$$$$$$$$$$!#¤¤%%&&/%/(*?=)++009$$02__10;48.22.143999', '    2009@@@@@$$$$$$$$$$!#¤¤%%&&/%/(*?=)++009$$02__10;48.22.143999', N'    2009@@@@@$$$$$$$$$$!#¤¤%%&&/%/(*?=)++009$$02__10;48.22.143999'),
	('    2009@09$$02___10;48,22!143999', N'    2009@09$$02___10;48,22!143999', '    2009@09$$02___10;48,22!143999', N'    2009@09$$02___10;48,22!143999'),
	('22 2018-10-12', N'22 2018-10-12', '22 2018-10-12', N'22 2018-10-12'),
	('11pm 2012-10-12', N'11pm 2012-10-12', '11pm 2012-10-12', N'11pm 2012-10-12'),
	('11:02                                   PM                         2012-10-12', N'11:02                                   PM                         2012-10-12', '11:02                                   PM                         2012-10-12', N'11:02                                   PM                         2012-10-12'),
	('11:::::::::02PM 2012-10-12',  N'11:::::::::02PM 2012-10-12',  '11:::::::::02PM 2012-10-12',  N'11:::::::::02PM 2012-10-12' ),
	('11:::::::::02:10.2343PM 2012-10-12', N'11:::::::::02:10.2343PM 2012-10-12', '11:::::::::02:10.2343PM 2012-10-12', N'11:::::::::02:10.2343PM 2012-10-12'),
	(':22 10-12', N':22 10-12', ':22 10-12', N':22 10-12'),
	(':22:10 12/10', N':22:10 12/10', ':22:10 12/10', N':22:10 12/10'),
	('        9$$02_ _ _10]48[22.143999', N'        9$$02_ _ _10]48[22.143999', '        9$$02_ _ _10]48[22.143999', N'        9$$02_ _ _10]48[22.143999'),
	('       01@09$$02____10~48.22.143999', N'       01@09$$02____10~48.22.143999', '       01@09$$02____10~48.22.143999', N'       01@09$$02____10~48.22.143999'),
	('     001@09$$02____10^48#22.143855', N'     001@09$$02____10^48#22.143855', '     001@09$$02____10^48#22.143855', N'     001@09$$02____10^48#22.143855'),
	('         1@09$$02____10^48#22.143855', N'         1@09$$02____10^48#22.143855', '         1@09$$02____10^48#22.143855', N'         1@09$$02____10^48#22.143855'),
	('10/31 10:48:2.2', N'10/31 10:48:2.2', '10/31 10:48:2.2', N'10/31 10:48:2.2'),
	('10/31/00 10:48:2.2', N'10/31/00 10:48:2.2', '10/31/00 10:48:2.2', N'10/31/00 10:48:2.2'),
	('10/31/00//10//48//2.2', N'10/31/00//10//48//2.2', '10/31/00//10//48//2.2', N'10/31/00//10//48//2.2'),
	('10//31 10:48:2.2', N'10//31 10:48:2.2', '10//31 10:48:2.2', N'10//31 10:48:2.2'),
	('10//31//09 10:48:2.2', N'10//31//09 10:48:2.2', '10//31//09 10:48:2.2', N'10//31//09 10:48:2.2'),
	('31/10/-09 10:48:2.2', N'31/10/-09 10:48:2.2', '31/10/-09 10:48:2.2', N'31/10/-09 10:48:2.2'),
	('31/-10/09 10:48:2.2', N'31/-10/09 10:48:2.2', '31/-10/09 10:48:2.2', N'31/-10/09 10:48:2.2'),
	('31++10++09 10:48:2.2', N'31++10++09 10:48:2.2', '31++10++09 10:48:2.2', N'31++10++09 10:48:2.2'),
	('10:11:22:10:48.25.2pm', N'10:11:22:10:48.25.2pm', '10:11:22:10:48.25.2pm', N'10:11:22:10:48.25.2pm'),
	('11-22 10:48:00       AM', N'11-22 10:48:00        AM', '11-22 10:48:00        AM', N'11-22 10:48:00        AM'),
	('11-22 10:48:00        PM1',  N'11-22 10:48:00        PM1',  '11-22 10:48:00        PM1',  N'11-22 10:48:00        PM1' ),
	('11/22 2:0:1        am%%%%', N'11/22 2:0:1        am%%%%', '11/22 2:0:1        am%%%%', N'11/22 2:0:1        am%%%%'),
	('10:11:22:10.48.25.2PMMs1', N'10:11:22:10.48.25.2PMMs1', '10:11:22:10.48.25.2PMMs1', N'10:11:22:10.48.25.2PMMs1'),
	('11-22 10:48:00        pmw', N'11-22 10:48:00        pmw', '11-22 10:48:00        pmw', N'11-22 10:48:00        pmw'),
	('31-11_22@10@48*2', N'31-11_22@10@48*2', '31-11_22@10@48*2', N'31-11_22@10@48*2'),
	('11_22@ 10@48.2', N'11_22@ 10@48.2', '11_22@ 10@48.2', N'11_22@ 10@48.2'),
	('11//22 10@48.2', N'11//22 10@48.2', '11//22 10@48.2', N'11//22 10@48.2'),
	('11/22/31“10“48“00', N'11/22/31“10“48“00', '11/22/31“10“48“00', N'11/22/31“10“48“00'),
	('11//22//+ /“10“48“00 pm am', N'11//22//+ /“10“48“00 pm am', '11//22//+ /“10“48“00 pm am', N'11//22//+ /“10“48“00 pm am'),
	('11-11-22|10|0|0', N'11-11-22|10|0|0', '11-11-22|10|0|0', N'11-11-22|10|0|0'),
	('11-22&&&& 0pm5', N'11-22&&&& 0pm5', '11-22&&&& 0pm5', N'11-22&&&& 0pm5' ),
	('2009-10-18&&&&&', N'2009-10-18&&&&&', '2009-10-18&&&&&', N'2009-10-18&&&&&'),
	('10/18////2009a', N'10/18////2009a', '10/18////2009a', N'10/18////2009a'),
	('11-22', N'11-22', '11-22', N'11-22'),
	('11/22', N'11/22', '11/22', N'11/22' ),
	('1-2', N'1-2', '1-2', N'1-2'),
	('2009-10-12 T 02:28:10', N'2009-10-12 T 02:28:10', '2009-10-12 T 02:28:10', N'2009-10-12 T 02:28:10'),
	('2009-10-12T02:28:10', N'2009-10-12T02:28:10', '2009-10-12T02:28:10', N'2009-10-12T02:28:10'),
	('10/11T10:18', N'10/11T10:18', '10/11T10:18', N'10/11T10:18'),
	('320.asdf',  N'320.asdf',  '320.asdf',  N'320.asdf' ),
	('1120.asdf', N'1120.asdf', '1120.asdf', N'1120.asdf'),
	('21120.asdf', N'21120.asdf', '21120.asdf', N'21120.asdf'),
	('111120.asdf', N'111120.asdf', '111120.asdf', N'111120.asdf'),
	('9108123.asdf', N'9108123.asdf', '9108123.asdf', N'9108123.asdf'),
	('19121120.asdf', N'19121120.asdf', '19121120.asdf', N'19121120.asdf'),
	('191211208', N'191211208', '191211208', N'191211208'),
	('1912112008', N'1912112008', '1912112008', N'1912112008'),
	('19121120086', N'19121120086', '19121120086', N'19121120086'),
	('191211200816', N'191211200816', '191211200816', N'191211200816'),
	('1912111008161', N'1912111008161', '1912111008161', N'1912111008161'),
	('19121108102245', N'19121108102245', '19121108102245', N'19121108102245'),
	('19121108102245678', N'19121108102245678', '19121108102245678', N'19121108102245678'),
	('191211081022456.78', N'191211081022456.78', '191211081022456.78', N'191211081022456.78'),
	('10121120081.6842', N'10121120081.6842', '10121120081.6842', N'10121120081.6842'),
	('101211200812.6842', N'101211200812.6842', '101211200812.6842', N'101211200812.6842'),
	('191211108pm   ', N'191211108pm   ', '191211108pm   ', N'191211108pm   '),
	('1912111008 pm  ', N'1912111008 pm  ', '1912111008 pm  ', N'1912111008 pm  '),
	('19121110086  pm ', N'19121110086  pm ', '19121110086  pm ', N'19121110086  pm '),
	('191211100816   pm', N'191211100816   pm', '191211100816   pm', N'191211100816   pm'),
	('1912111008161 pm  ', N'1912111008161 pm  ', '1912111008161 pm  ', N'1912111008161 pm  '),
	('10121111081.6842  PM ', N'10121111081.6842  PM ', '10121111081.6842  PM ', N'10121111081.6842  PM '),
	('101211100812.6842  PM   ', N'101211100812.6842  PM   ', '101211100812.6842  PM   ', N'101211100812.6842  PM   '),
	('19121108102245678 PM', N'19121108102245678 PM', '19121108102245678 PM', N'19121108102245678 PM'),
	('320pm.asdf', N'320pm.asdf', '320pm.asdf', N'320pm.asdf'),
	('1120pm.asdf', N'1120pm.asdf', '1120pm.asdf', N'1120pm.asdf'),
	('21120   pm   .asdf', N'21120   pm   .asdf', '21120   pm   .asdf', N'21120   pm   .asdf'),
	('111120PM  .asdf', N'111120PM  .asdf', '111120PM  .asdf', N'111120PM  .asdf'),
	('9108123  PM.asdf',  N'9108123  PM.asdf', '9108123  PM.asdf', N'9108123  PM.asdf'),
	('19121120 PM.asdf', N'19121120 PM.asdf', '19121120 PM.asdf', N'19121120 PM.asdf'),
	('2009-10-18pm&&&&&', N'2009-10-18pm&&&&&', '2009-10-18pm&&&&&', N'2009-10-18pm&&&&&'),
	('10/18////2009pm.a', N'10/18////2009pm.a', '10/18////2009pm.a', N'10/18////2009pm.a'),
	('11-22 pm  ', N'11-22 pm  ',  '11-22 pm  ', N'11-22 pm  '),
	('11/22 Pm ', N'11/22 Pm ', '11/22 Pm ', N'11/22 Pm '),
	('1-2pM  ', N'1-2pM  ', '1-2pM  ', N'1-2pM  ');
	
--SELECT
--	TextID, CAST(DateText AS DATETIME), CAST(DateNText AS DATETIME), CAST(DateFText AS DATETIME),
--	CAST(DateFNText AS DATETIME)
--FROM
--	DatesText
--ORDER BY
--	TextID;

SELECT
        TextID, substring(CAST(DateText AS DATETIME),1,21), substring(CAST(DateNText AS DATETIME),1,21), substring(CAST(DateFText AS DATETIME),1,21),
        substring(CAST(DateFNText AS DATETIME),1,21)
FROM
        DatesText
ORDER BY
        TextID;


ALTER CLASS DatesText MODIFY DateText     DATETIME;
ALTER CLASS DatesText MODIFY DateNText   DATETIME;
ALTER CLASS DatesText MODIFY DateFText    DATETIME;
ALTER CLASS DatesText MODIFY DateFNText DATETIME;

--SELECT TextID, DateText, DateNText, DateFText, DateFNText
--FROM    DatesText
--ORDER BY TextID;

SELECT TextID, substring(DateText,1,21),substring(DateNText,1,21), substring(DateFText,1,21), substring(DateFNText,1,21)
FROM    DatesText
ORDER BY TextID;


DROP TABLE DatesText;

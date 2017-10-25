--
-- Set a flag on hhlds which are excluded from HBAI
--
update target_data.target_dataset set hbai_excluded = 'f';
update target_data.target_dataset set hbai_excluded = 't' where year=2012 and sernum in (88, 161, 172, 193, 316, 556, 647, 2744, 2951, 3192, 3294, 3709, 4035, 4612, 4975, 5128, 5263, 5689, 5828, 5848, 6208, 6228, 6461, 6471, 6623, 7099, 8114, 8479, 8783, 8844, 9034, 9294, 10221, 10281, 11135, 11243, 11277, 11281, 12166, 12393, 12788, 12932, 13968, 14056, 14457, 14516, 14906, 14961, 15051, 15071, 15457, 15499, 15508, 15576, 15877, 16518, 16715, 16838, 16845, 16884, 17145, 17213, 17488, 17619, 17926, 18527, 18864, 18941, 19533, 19787 );


update target_data.target_dataset set hbai_excluded = 't' where year=2013 and sernum in ( 46, 350, 440, 542, 594, 1061, 1375, 1397, 1467, 1486, 2109, 2358, 2467, 2660, 3081, 3230, 3560, 3733, 3751, 5000, 5562, 5871, 6759, 6792, 6810, 7112, 7125, 7352, 7384, 7431, 7723, 7770, 8072, 8243, 8350, 8638, 8685, 8815, 9593, 9667, 9890, 9951, 9975, 10060, 10324, 10464, 10541, 10553, 10591, 10615, 10673, 10963, 11126, 11677, 11798, 11804, 12418, 12780, 12895, 13078, 13184, 13667, 14630, 14904, 15704, 16045, 16381, 16734, 16807, 17731, 17898, 17927, 18005, 18244, 18748, 19057, 19159, 19294, 19296, 19755, 19782 ); 

update target_data.target_dataset set hbai_excluded = 't' where year=2014 and sernum in ( 582, 1010, 1324, 1781, 2191, 2449, 2561, 3229, 3232, 3690, 3858, 3937, 4042, 4142, 4560, 4991, 5002, 5005, 5218, 5365, 5414, 5419, 5649, 5699, 6079, 6193, 6400, 6747, 7232, 7262, 7466, 7627, 7732, 8012, 8121, 8374, 8660, 9096, 9611, 9673, 9744, 10226, 10500, 10919, 11267, 11609, 12252, 12409, 12434, 12516, 12722, 12978, 13138, 13880, 14742, 15535, 15736, 15922, 16127, 16252, 16373, 16708, 16896, 17492, 17532, 17575, 17825, 18397, 18952 ); 

update target_data.target_dataset set hbai_excluded = 't' where year=2015 and sernum in ( 60, 91, 183, 1236, 1373, 1610, 1794, 1874, 2011, 2363, 2800, 2883, 2900, 3603, 3962, 4376, 4556, 4994, 5032, 5045, 5534, 5873, 6081, 6275, 6522, 6757, 6842, 7328, 7483, 7940, 8057, 8235, 9027, 9618, 9828, 9941, 10319, 10324, 10689, 10955, 11056, 11460, 11967, 12119, 12200, 12521, 12732, 13018, 13725, 13787, 14025, 14213, 14299, 14326, 14695, 14898, 14915, 15075, 15368, 15606, 15640, 15641, 15802, 16594, 16606, 16769, 16913, 16966, 18349, 18567, 18664, 18693, 18918, 18977, 18998, 19108, 19109, 19132, 19223, 19253, 19261 ); 
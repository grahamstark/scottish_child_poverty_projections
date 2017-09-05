--
-- Created by ada_generator.py on 2017-09-05 20:57:19.415140
-- 
with Ukds;


with Ada.Containers.Vectors;

with Environment;

with DB_Commons; 

with GNATCOLL.SQL_Impl;
with GNATCOLL.SQL.Postgres;
with DB_Commons.PSQL;


with Ada.Exceptions;  
with Ada.Strings; 
with Ada.Strings.Wide_Fixed;
with Ada.Characters.Conversions;
with Ada.Strings.Unbounded; 
with Text_IO;
with Ada.Strings.Maps;
with Connection_Pool;
with GNATColl.Traces;


-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds.Frs.Job_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.JOB_IO" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;
   
   
   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   --
   -- generic packages to handle each possible type of decimal, if any, go here
   --

   --
   -- Select all variables; substring to be competed with output from some criteria
   --
   SELECT_PART : constant String := "select " &
         "user_id, edition, year, counter, sernum, benunit, person, jobtype, agreehrs, bonamt1," &
         "bonamt2, bonamt3, bonamt4, bonamt5, bonamt6, bontax1, bontax2, bontax3, bontax4, bontax5," &
         "bontax6, bonus, busaccts, checktax, chkincom, dedoth, deduc1, deduc2, deduc3, deduc4," &
         "deduc5, deduc6, deduc7, deduc8, dirctr, dirni, dvtothru, dvushr, empany, empown," &
         "etype, everot, ftpt, grsofar, grwage, grwagpd, hha1, hha2, hha3, hhc1," &
         "hhc2, hhc3, hohinc, inclpay1, inclpay2, inclpay3, inclpay4, inclpay5, inclpay6, inkind01," &
         "inkind02, inkind03, inkind04, inkind05, inkind06, inkind07, inkind08, inkind09, inkind10, inkind11," &
         "instype1, instype2, jobbus, likehr, mademp, matemp, matstp, mileamt, motamt, natins," &
         "nature, nidamt, nidpd, nmchc, nmper, nomor1, nomor2, nomor3, numemp, othded1," &
         "othded2, othded3, othded4, othded5, othded6, othded7, othded8, othded9, ownamt, ownotamt," &
         "ownother, ownsum, payamt, paydat, paye, paypd, payslip, payusl, pothr, prbefore," &
         "profdocs, profit1, profit2, profni, proftax, rspoth, se1, se2, seend, seincamt," &
         "seincwm, selwks, seniiamt, seniinc, senilamt, senilump, seniramt, senireg, senirpd, setax," &
         "setaxamt, smpamt, smprate, sole, sspamt, taxamt, taxdamt, taxdpd, totus1, ubonamt," &
         "uboninc, udeduc1, udeduc2, udeduc3, udeduc4, udeduc5, udeduc6, udeduc7, udeduc8, ugross," &
         "uincpay1, uincpay2, uincpay3, uincpay4, uincpay5, uincpay6, umileamt, umotamt, unett, uothded1," &
         "uothded2, uothded3, uothded4, uothded5, uothded6, uothded7, uothded8, uothded9, uothdtot, uothr," &
         "upd, usmpamt, usmprate, usspamt, usuhr, utaxamt, watdid, watprev, x_where, whynopro," &
         "whynou01, whynou02, whynou03, whynou04, whynou05, whynou06, whynou07, whynou08, whynou09, whynou10," &
         "whynou11, workacc, workmth, workyr, month, hdqhrs, jobhours, sspsmpfg, ugrspay, inclpay7," &
         "inclpay8, paperiod, ppperiod, sapamt, sppamt, uincpay7, uincpay8, usapamt, usppamt, inkind12," &
         "inkind13, salsac, chvamt, chvpd, chvsac, chvuamt, chvupd, chvusu, expben01, expben02," &
         "expben03, expben04, expben05, expben06, expben07, expben08, expben09, expben10, expben11, expben12," &
         "fuelamt, fuelbn, fuelpd, fueluamt, fuelupd, fuelusu, issue, prevmth, prevyr, spnamt," &
         "spnpd, spnsac, spnuamt, spnupd, spnusu, vchamt, vchpd, vchsac, vchuamt, vchupd," &
         "vchusu, wrkprev, caramt, carcon, carval, fueltyp, orgemp, sector, sectrnp, whynou12," &
         "whynou13, whynou14, jobsect, oremp, bontxam1, bontxam2, bontxam3, bontxam4, bontxam5, bontxam6," &
         "deduc9, emplany, empten, lthan30, numeten, othded01, othded02, othded03, othded04, othded05," &
         "othded06, othded07, othded08, othded09, othded10, udeduc9, uothde01, uothde02, uothde03, uothde04," &
         "uothde05, uothde06, uothde07, uothde08, uothde09, uothde10, yjbchang, jbchnge, hourly, hrexa," &
         "hrexb, hrexc1, hrexc2, hrexc3, hrexc4, hrexc5, hrexc6, hrexc7, hrexc8, hrrate" &
         " from frs.job " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.job (" &
         "user_id, edition, year, counter, sernum, benunit, person, jobtype, agreehrs, bonamt1," &
         "bonamt2, bonamt3, bonamt4, bonamt5, bonamt6, bontax1, bontax2, bontax3, bontax4, bontax5," &
         "bontax6, bonus, busaccts, checktax, chkincom, dedoth, deduc1, deduc2, deduc3, deduc4," &
         "deduc5, deduc6, deduc7, deduc8, dirctr, dirni, dvtothru, dvushr, empany, empown," &
         "etype, everot, ftpt, grsofar, grwage, grwagpd, hha1, hha2, hha3, hhc1," &
         "hhc2, hhc3, hohinc, inclpay1, inclpay2, inclpay3, inclpay4, inclpay5, inclpay6, inkind01," &
         "inkind02, inkind03, inkind04, inkind05, inkind06, inkind07, inkind08, inkind09, inkind10, inkind11," &
         "instype1, instype2, jobbus, likehr, mademp, matemp, matstp, mileamt, motamt, natins," &
         "nature, nidamt, nidpd, nmchc, nmper, nomor1, nomor2, nomor3, numemp, othded1," &
         "othded2, othded3, othded4, othded5, othded6, othded7, othded8, othded9, ownamt, ownotamt," &
         "ownother, ownsum, payamt, paydat, paye, paypd, payslip, payusl, pothr, prbefore," &
         "profdocs, profit1, profit2, profni, proftax, rspoth, se1, se2, seend, seincamt," &
         "seincwm, selwks, seniiamt, seniinc, senilamt, senilump, seniramt, senireg, senirpd, setax," &
         "setaxamt, smpamt, smprate, sole, sspamt, taxamt, taxdamt, taxdpd, totus1, ubonamt," &
         "uboninc, udeduc1, udeduc2, udeduc3, udeduc4, udeduc5, udeduc6, udeduc7, udeduc8, ugross," &
         "uincpay1, uincpay2, uincpay3, uincpay4, uincpay5, uincpay6, umileamt, umotamt, unett, uothded1," &
         "uothded2, uothded3, uothded4, uothded5, uothded6, uothded7, uothded8, uothded9, uothdtot, uothr," &
         "upd, usmpamt, usmprate, usspamt, usuhr, utaxamt, watdid, watprev, x_where, whynopro," &
         "whynou01, whynou02, whynou03, whynou04, whynou05, whynou06, whynou07, whynou08, whynou09, whynou10," &
         "whynou11, workacc, workmth, workyr, month, hdqhrs, jobhours, sspsmpfg, ugrspay, inclpay7," &
         "inclpay8, paperiod, ppperiod, sapamt, sppamt, uincpay7, uincpay8, usapamt, usppamt, inkind12," &
         "inkind13, salsac, chvamt, chvpd, chvsac, chvuamt, chvupd, chvusu, expben01, expben02," &
         "expben03, expben04, expben05, expben06, expben07, expben08, expben09, expben10, expben11, expben12," &
         "fuelamt, fuelbn, fuelpd, fueluamt, fuelupd, fuelusu, issue, prevmth, prevyr, spnamt," &
         "spnpd, spnsac, spnuamt, spnupd, spnusu, vchamt, vchpd, vchsac, vchuamt, vchupd," &
         "vchusu, wrkprev, caramt, carcon, carval, fueltyp, orgemp, sector, sectrnp, whynou12," &
         "whynou13, whynou14, jobsect, oremp, bontxam1, bontxam2, bontxam3, bontxam4, bontxam5, bontxam6," &
         "deduc9, emplany, empten, lthan30, numeten, othded01, othded02, othded03, othded04, othded05," &
         "othded06, othded07, othded08, othded09, othded10, udeduc9, uothde01, uothde02, uothde03, uothde04," &
         "uothde05, uothde06, uothde07, uothde08, uothde09, uothde10, yjbchang, jbchnge, hourly, hrexa," &
         "hrexb, hrexc1, hrexc2, hrexc3, hrexc4, hrexc5, hrexc6, hrexc7, hrexc8, hrrate" &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.job ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.job set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 310 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : agreehrs (Integer)
            2 => ( Parameter_Float, 0.0 ),   --  : bonamt1 (Amount)
            3 => ( Parameter_Float, 0.0 ),   --  : bonamt2 (Amount)
            4 => ( Parameter_Float, 0.0 ),   --  : bonamt3 (Amount)
            5 => ( Parameter_Float, 0.0 ),   --  : bonamt4 (Amount)
            6 => ( Parameter_Float, 0.0 ),   --  : bonamt5 (Amount)
            7 => ( Parameter_Float, 0.0 ),   --  : bonamt6 (Amount)
            8 => ( Parameter_Integer, 0 ),   --  : bontax1 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : bontax2 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : bontax3 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : bontax4 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : bontax5 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : bontax6 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : bonus (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : busaccts (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : checktax (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : chkincom (Integer)
           18 => ( Parameter_Float, 0.0 ),   --  : dedoth (Amount)
           19 => ( Parameter_Float, 0.0 ),   --  : deduc1 (Amount)
           20 => ( Parameter_Float, 0.0 ),   --  : deduc2 (Amount)
           21 => ( Parameter_Float, 0.0 ),   --  : deduc3 (Amount)
           22 => ( Parameter_Float, 0.0 ),   --  : deduc4 (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : deduc5 (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : deduc6 (Amount)
           25 => ( Parameter_Float, 0.0 ),   --  : deduc7 (Amount)
           26 => ( Parameter_Float, 0.0 ),   --  : deduc8 (Amount)
           27 => ( Parameter_Integer, 0 ),   --  : dirctr (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : dirni (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : dvtothru (Integer)
           30 => ( Parameter_Float, 0.0 ),   --  : dvushr (Amount)
           31 => ( Parameter_Integer, 0 ),   --  : empany (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : empown (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : etype (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : everot (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : ftpt (Integer)
           36 => ( Parameter_Float, 0.0 ),   --  : grsofar (Amount)
           37 => ( Parameter_Float, 0.0 ),   --  : grwage (Amount)
           38 => ( Parameter_Integer, 0 ),   --  : grwagpd (Integer)
           39 => ( Parameter_Float, 0.0 ),   --  : hha1 (Amount)
           40 => ( Parameter_Float, 0.0 ),   --  : hha2 (Amount)
           41 => ( Parameter_Float, 0.0 ),   --  : hha3 (Amount)
           42 => ( Parameter_Integer, 0 ),   --  : hhc1 (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : hhc2 (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : hhc3 (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : hohinc (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : inclpay1 (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : inclpay2 (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : inclpay3 (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : inclpay4 (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : inclpay5 (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : inclpay6 (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : inkind01 (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : inkind02 (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : inkind03 (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : inkind04 (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : inkind05 (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : inkind06 (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : inkind07 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : inkind08 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : inkind09 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : inkind10 (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : inkind11 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : instype1 (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : instype2 (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : jobbus (Integer)
           66 => ( Parameter_Integer, 0 ),   --  : likehr (Integer)
           67 => ( Parameter_Integer, 0 ),   --  : mademp (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : matemp (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : matstp (Integer)
           70 => ( Parameter_Float, 0.0 ),   --  : mileamt (Amount)
           71 => ( Parameter_Float, 0.0 ),   --  : motamt (Amount)
           72 => ( Parameter_Float, 0.0 ),   --  : natins (Amount)
           73 => ( Parameter_Integer, 0 ),   --  : nature (Integer)
           74 => ( Parameter_Float, 0.0 ),   --  : nidamt (Amount)
           75 => ( Parameter_Integer, 0 ),   --  : nidpd (Integer)
           76 => ( Parameter_Integer, 0 ),   --  : nmchc (Integer)
           77 => ( Parameter_Integer, 0 ),   --  : nmper (Integer)
           78 => ( Parameter_Integer, 0 ),   --  : nomor1 (Integer)
           79 => ( Parameter_Integer, 0 ),   --  : nomor2 (Integer)
           80 => ( Parameter_Integer, 0 ),   --  : nomor3 (Integer)
           81 => ( Parameter_Integer, 0 ),   --  : numemp (Integer)
           82 => ( Parameter_Integer, 0 ),   --  : othded1 (Integer)
           83 => ( Parameter_Integer, 0 ),   --  : othded2 (Integer)
           84 => ( Parameter_Integer, 0 ),   --  : othded3 (Integer)
           85 => ( Parameter_Integer, 0 ),   --  : othded4 (Integer)
           86 => ( Parameter_Integer, 0 ),   --  : othded5 (Integer)
           87 => ( Parameter_Integer, 0 ),   --  : othded6 (Integer)
           88 => ( Parameter_Integer, 0 ),   --  : othded7 (Integer)
           89 => ( Parameter_Integer, 0 ),   --  : othded8 (Integer)
           90 => ( Parameter_Integer, 0 ),   --  : othded9 (Integer)
           91 => ( Parameter_Float, 0.0 ),   --  : ownamt (Amount)
           92 => ( Parameter_Float, 0.0 ),   --  : ownotamt (Amount)
           93 => ( Parameter_Integer, 0 ),   --  : ownother (Integer)
           94 => ( Parameter_Integer, 0 ),   --  : ownsum (Integer)
           95 => ( Parameter_Float, 0.0 ),   --  : payamt (Amount)
           96 => ( Parameter_Date, Clock ),   --  : paydat (Ada.Calendar.Time)
           97 => ( Parameter_Float, 0.0 ),   --  : paye (Amount)
           98 => ( Parameter_Integer, 0 ),   --  : paypd (Integer)
           99 => ( Parameter_Integer, 0 ),   --  : payslip (Integer)
           100 => ( Parameter_Integer, 0 ),   --  : payusl (Integer)
           101 => ( Parameter_Float, 0.0 ),   --  : pothr (Amount)
           102 => ( Parameter_Float, 0.0 ),   --  : prbefore (Amount)
           103 => ( Parameter_Integer, 0 ),   --  : profdocs (Integer)
           104 => ( Parameter_Float, 0.0 ),   --  : profit1 (Amount)
           105 => ( Parameter_Integer, 0 ),   --  : profit2 (Integer)
           106 => ( Parameter_Integer, 0 ),   --  : profni (Integer)
           107 => ( Parameter_Integer, 0 ),   --  : proftax (Integer)
           108 => ( Parameter_Integer, 0 ),   --  : rspoth (Integer)
           109 => ( Parameter_Date, Clock ),   --  : se1 (Ada.Calendar.Time)
           110 => ( Parameter_Date, Clock ),   --  : se2 (Ada.Calendar.Time)
           111 => ( Parameter_Date, Clock ),   --  : seend (Ada.Calendar.Time)
           112 => ( Parameter_Float, 0.0 ),   --  : seincamt (Amount)
           113 => ( Parameter_Integer, 0 ),   --  : seincwm (Integer)
           114 => ( Parameter_Integer, 0 ),   --  : selwks (Integer)
           115 => ( Parameter_Float, 0.0 ),   --  : seniiamt (Amount)
           116 => ( Parameter_Integer, 0 ),   --  : seniinc (Integer)
           117 => ( Parameter_Float, 0.0 ),   --  : senilamt (Amount)
           118 => ( Parameter_Integer, 0 ),   --  : senilump (Integer)
           119 => ( Parameter_Float, 0.0 ),   --  : seniramt (Amount)
           120 => ( Parameter_Integer, 0 ),   --  : senireg (Integer)
           121 => ( Parameter_Integer, 0 ),   --  : senirpd (Integer)
           122 => ( Parameter_Integer, 0 ),   --  : setax (Integer)
           123 => ( Parameter_Float, 0.0 ),   --  : setaxamt (Amount)
           124 => ( Parameter_Float, 0.0 ),   --  : smpamt (Amount)
           125 => ( Parameter_Integer, 0 ),   --  : smprate (Integer)
           126 => ( Parameter_Integer, 0 ),   --  : sole (Integer)
           127 => ( Parameter_Float, 0.0 ),   --  : sspamt (Amount)
           128 => ( Parameter_Float, 0.0 ),   --  : taxamt (Amount)
           129 => ( Parameter_Float, 0.0 ),   --  : taxdamt (Amount)
           130 => ( Parameter_Integer, 0 ),   --  : taxdpd (Integer)
           131 => ( Parameter_Float, 0.0 ),   --  : totus1 (Amount)
           132 => ( Parameter_Float, 0.0 ),   --  : ubonamt (Amount)
           133 => ( Parameter_Integer, 0 ),   --  : uboninc (Integer)
           134 => ( Parameter_Float, 0.0 ),   --  : udeduc1 (Amount)
           135 => ( Parameter_Float, 0.0 ),   --  : udeduc2 (Amount)
           136 => ( Parameter_Float, 0.0 ),   --  : udeduc3 (Amount)
           137 => ( Parameter_Float, 0.0 ),   --  : udeduc4 (Amount)
           138 => ( Parameter_Float, 0.0 ),   --  : udeduc5 (Amount)
           139 => ( Parameter_Float, 0.0 ),   --  : udeduc6 (Amount)
           140 => ( Parameter_Float, 0.0 ),   --  : udeduc7 (Amount)
           141 => ( Parameter_Float, 0.0 ),   --  : udeduc8 (Amount)
           142 => ( Parameter_Float, 0.0 ),   --  : ugross (Amount)
           143 => ( Parameter_Integer, 0 ),   --  : uincpay1 (Integer)
           144 => ( Parameter_Integer, 0 ),   --  : uincpay2 (Integer)
           145 => ( Parameter_Integer, 0 ),   --  : uincpay3 (Integer)
           146 => ( Parameter_Integer, 0 ),   --  : uincpay4 (Integer)
           147 => ( Parameter_Integer, 0 ),   --  : uincpay5 (Integer)
           148 => ( Parameter_Integer, 0 ),   --  : uincpay6 (Integer)
           149 => ( Parameter_Float, 0.0 ),   --  : umileamt (Amount)
           150 => ( Parameter_Float, 0.0 ),   --  : umotamt (Amount)
           151 => ( Parameter_Float, 0.0 ),   --  : unett (Amount)
           152 => ( Parameter_Integer, 0 ),   --  : uothded1 (Integer)
           153 => ( Parameter_Integer, 0 ),   --  : uothded2 (Integer)
           154 => ( Parameter_Integer, 0 ),   --  : uothded3 (Integer)
           155 => ( Parameter_Integer, 0 ),   --  : uothded4 (Integer)
           156 => ( Parameter_Integer, 0 ),   --  : uothded5 (Integer)
           157 => ( Parameter_Integer, 0 ),   --  : uothded6 (Integer)
           158 => ( Parameter_Integer, 0 ),   --  : uothded7 (Integer)
           159 => ( Parameter_Integer, 0 ),   --  : uothded8 (Integer)
           160 => ( Parameter_Integer, 0 ),   --  : uothded9 (Integer)
           161 => ( Parameter_Float, 0.0 ),   --  : uothdtot (Amount)
           162 => ( Parameter_Float, 0.0 ),   --  : uothr (Amount)
           163 => ( Parameter_Integer, 0 ),   --  : upd (Integer)
           164 => ( Parameter_Float, 0.0 ),   --  : usmpamt (Amount)
           165 => ( Parameter_Integer, 0 ),   --  : usmprate (Integer)
           166 => ( Parameter_Float, 0.0 ),   --  : usspamt (Amount)
           167 => ( Parameter_Float, 0.0 ),   --  : usuhr (Amount)
           168 => ( Parameter_Float, 0.0 ),   --  : utaxamt (Amount)
           169 => ( Parameter_Integer, 0 ),   --  : watdid (Integer)
           170 => ( Parameter_Integer, 0 ),   --  : watprev (Integer)
           171 => ( Parameter_Integer, 0 ),   --  : x_where (Integer)
           172 => ( Parameter_Integer, 0 ),   --  : whynopro (Integer)
           173 => ( Parameter_Integer, 0 ),   --  : whynou01 (Integer)
           174 => ( Parameter_Integer, 0 ),   --  : whynou02 (Integer)
           175 => ( Parameter_Integer, 0 ),   --  : whynou03 (Integer)
           176 => ( Parameter_Integer, 0 ),   --  : whynou04 (Integer)
           177 => ( Parameter_Integer, 0 ),   --  : whynou05 (Integer)
           178 => ( Parameter_Integer, 0 ),   --  : whynou06 (Integer)
           179 => ( Parameter_Integer, 0 ),   --  : whynou07 (Integer)
           180 => ( Parameter_Integer, 0 ),   --  : whynou08 (Integer)
           181 => ( Parameter_Integer, 0 ),   --  : whynou09 (Integer)
           182 => ( Parameter_Integer, 0 ),   --  : whynou10 (Integer)
           183 => ( Parameter_Integer, 0 ),   --  : whynou11 (Integer)
           184 => ( Parameter_Integer, 0 ),   --  : workacc (Integer)
           185 => ( Parameter_Integer, 0 ),   --  : workmth (Integer)
           186 => ( Parameter_Integer, 0 ),   --  : workyr (Integer)
           187 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           188 => ( Parameter_Integer, 0 ),   --  : hdqhrs (Integer)
           189 => ( Parameter_Float, 0.0 ),   --  : jobhours (Amount)
           190 => ( Parameter_Integer, 0 ),   --  : sspsmpfg (Integer)
           191 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : ugrspay (Unbounded_String)
           192 => ( Parameter_Integer, 0 ),   --  : inclpay7 (Integer)
           193 => ( Parameter_Integer, 0 ),   --  : inclpay8 (Integer)
           194 => ( Parameter_Integer, 0 ),   --  : paperiod (Integer)
           195 => ( Parameter_Integer, 0 ),   --  : ppperiod (Integer)
           196 => ( Parameter_Float, 0.0 ),   --  : sapamt (Amount)
           197 => ( Parameter_Float, 0.0 ),   --  : sppamt (Amount)
           198 => ( Parameter_Integer, 0 ),   --  : uincpay7 (Integer)
           199 => ( Parameter_Integer, 0 ),   --  : uincpay8 (Integer)
           200 => ( Parameter_Integer, 0 ),   --  : usapamt (Integer)
           201 => ( Parameter_Float, 0.0 ),   --  : usppamt (Amount)
           202 => ( Parameter_Integer, 0 ),   --  : inkind12 (Integer)
           203 => ( Parameter_Integer, 0 ),   --  : inkind13 (Integer)
           204 => ( Parameter_Integer, 0 ),   --  : salsac (Integer)
           205 => ( Parameter_Float, 0.0 ),   --  : chvamt (Amount)
           206 => ( Parameter_Integer, 0 ),   --  : chvpd (Integer)
           207 => ( Parameter_Integer, 0 ),   --  : chvsac (Integer)
           208 => ( Parameter_Float, 0.0 ),   --  : chvuamt (Amount)
           209 => ( Parameter_Integer, 0 ),   --  : chvupd (Integer)
           210 => ( Parameter_Integer, 0 ),   --  : chvusu (Integer)
           211 => ( Parameter_Integer, 0 ),   --  : expben01 (Integer)
           212 => ( Parameter_Integer, 0 ),   --  : expben02 (Integer)
           213 => ( Parameter_Integer, 0 ),   --  : expben03 (Integer)
           214 => ( Parameter_Integer, 0 ),   --  : expben04 (Integer)
           215 => ( Parameter_Integer, 0 ),   --  : expben05 (Integer)
           216 => ( Parameter_Integer, 0 ),   --  : expben06 (Integer)
           217 => ( Parameter_Integer, 0 ),   --  : expben07 (Integer)
           218 => ( Parameter_Integer, 0 ),   --  : expben08 (Integer)
           219 => ( Parameter_Integer, 0 ),   --  : expben09 (Integer)
           220 => ( Parameter_Integer, 0 ),   --  : expben10 (Integer)
           221 => ( Parameter_Integer, 0 ),   --  : expben11 (Integer)
           222 => ( Parameter_Integer, 0 ),   --  : expben12 (Integer)
           223 => ( Parameter_Float, 0.0 ),   --  : fuelamt (Amount)
           224 => ( Parameter_Integer, 0 ),   --  : fuelbn (Integer)
           225 => ( Parameter_Integer, 0 ),   --  : fuelpd (Integer)
           226 => ( Parameter_Float, 0.0 ),   --  : fueluamt (Amount)
           227 => ( Parameter_Integer, 0 ),   --  : fuelupd (Integer)
           228 => ( Parameter_Integer, 0 ),   --  : fuelusu (Integer)
           229 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           230 => ( Parameter_Integer, 0 ),   --  : prevmth (Integer)
           231 => ( Parameter_Integer, 0 ),   --  : prevyr (Integer)
           232 => ( Parameter_Float, 0.0 ),   --  : spnamt (Amount)
           233 => ( Parameter_Integer, 0 ),   --  : spnpd (Integer)
           234 => ( Parameter_Integer, 0 ),   --  : spnsac (Integer)
           235 => ( Parameter_Float, 0.0 ),   --  : spnuamt (Amount)
           236 => ( Parameter_Integer, 0 ),   --  : spnupd (Integer)
           237 => ( Parameter_Integer, 0 ),   --  : spnusu (Integer)
           238 => ( Parameter_Float, 0.0 ),   --  : vchamt (Amount)
           239 => ( Parameter_Integer, 0 ),   --  : vchpd (Integer)
           240 => ( Parameter_Integer, 0 ),   --  : vchsac (Integer)
           241 => ( Parameter_Integer, 0 ),   --  : vchuamt (Integer)
           242 => ( Parameter_Integer, 0 ),   --  : vchupd (Integer)
           243 => ( Parameter_Integer, 0 ),   --  : vchusu (Integer)
           244 => ( Parameter_Integer, 0 ),   --  : wrkprev (Integer)
           245 => ( Parameter_Float, 0.0 ),   --  : caramt (Amount)
           246 => ( Parameter_Integer, 0 ),   --  : carcon (Integer)
           247 => ( Parameter_Integer, 0 ),   --  : carval (Integer)
           248 => ( Parameter_Integer, 0 ),   --  : fueltyp (Integer)
           249 => ( Parameter_Integer, 0 ),   --  : orgemp (Integer)
           250 => ( Parameter_Integer, 0 ),   --  : sector (Integer)
           251 => ( Parameter_Integer, 0 ),   --  : sectrnp (Integer)
           252 => ( Parameter_Integer, 0 ),   --  : whynou12 (Integer)
           253 => ( Parameter_Integer, 0 ),   --  : whynou13 (Integer)
           254 => ( Parameter_Integer, 0 ),   --  : whynou14 (Integer)
           255 => ( Parameter_Integer, 0 ),   --  : jobsect (Integer)
           256 => ( Parameter_Integer, 0 ),   --  : oremp (Integer)
           257 => ( Parameter_Float, 0.0 ),   --  : bontxam1 (Amount)
           258 => ( Parameter_Float, 0.0 ),   --  : bontxam2 (Amount)
           259 => ( Parameter_Float, 0.0 ),   --  : bontxam3 (Amount)
           260 => ( Parameter_Float, 0.0 ),   --  : bontxam4 (Amount)
           261 => ( Parameter_Float, 0.0 ),   --  : bontxam5 (Amount)
           262 => ( Parameter_Float, 0.0 ),   --  : bontxam6 (Amount)
           263 => ( Parameter_Float, 0.0 ),   --  : deduc9 (Amount)
           264 => ( Parameter_Integer, 0 ),   --  : emplany (Integer)
           265 => ( Parameter_Integer, 0 ),   --  : empten (Integer)
           266 => ( Parameter_Integer, 0 ),   --  : lthan30 (Integer)
           267 => ( Parameter_Integer, 0 ),   --  : numeten (Integer)
           268 => ( Parameter_Integer, 0 ),   --  : othded01 (Integer)
           269 => ( Parameter_Integer, 0 ),   --  : othded02 (Integer)
           270 => ( Parameter_Integer, 0 ),   --  : othded03 (Integer)
           271 => ( Parameter_Integer, 0 ),   --  : othded04 (Integer)
           272 => ( Parameter_Integer, 0 ),   --  : othded05 (Integer)
           273 => ( Parameter_Integer, 0 ),   --  : othded06 (Integer)
           274 => ( Parameter_Integer, 0 ),   --  : othded07 (Integer)
           275 => ( Parameter_Integer, 0 ),   --  : othded08 (Integer)
           276 => ( Parameter_Integer, 0 ),   --  : othded09 (Integer)
           277 => ( Parameter_Integer, 0 ),   --  : othded10 (Integer)
           278 => ( Parameter_Float, 0.0 ),   --  : udeduc9 (Amount)
           279 => ( Parameter_Integer, 0 ),   --  : uothde01 (Integer)
           280 => ( Parameter_Integer, 0 ),   --  : uothde02 (Integer)
           281 => ( Parameter_Integer, 0 ),   --  : uothde03 (Integer)
           282 => ( Parameter_Integer, 0 ),   --  : uothde04 (Integer)
           283 => ( Parameter_Integer, 0 ),   --  : uothde05 (Integer)
           284 => ( Parameter_Integer, 0 ),   --  : uothde06 (Integer)
           285 => ( Parameter_Integer, 0 ),   --  : uothde07 (Integer)
           286 => ( Parameter_Integer, 0 ),   --  : uothde08 (Integer)
           287 => ( Parameter_Integer, 0 ),   --  : uothde09 (Integer)
           288 => ( Parameter_Integer, 0 ),   --  : uothde10 (Integer)
           289 => ( Parameter_Integer, 0 ),   --  : yjbchang (Integer)
           290 => ( Parameter_Integer, 0 ),   --  : jbchnge (Integer)
           291 => ( Parameter_Integer, 0 ),   --  : hourly (Integer)
           292 => ( Parameter_Integer, 0 ),   --  : hrexa (Integer)
           293 => ( Parameter_Integer, 0 ),   --  : hrexb (Integer)
           294 => ( Parameter_Integer, 0 ),   --  : hrexc1 (Integer)
           295 => ( Parameter_Integer, 0 ),   --  : hrexc2 (Integer)
           296 => ( Parameter_Integer, 0 ),   --  : hrexc3 (Integer)
           297 => ( Parameter_Integer, 0 ),   --  : hrexc4 (Integer)
           298 => ( Parameter_Integer, 0 ),   --  : hrexc5 (Integer)
           299 => ( Parameter_Integer, 0 ),   --  : hrexc6 (Integer)
           300 => ( Parameter_Integer, 0 ),   --  : hrexc7 (Integer)
           301 => ( Parameter_Integer, 0 ),   --  : hrexc8 (Integer)
           302 => ( Parameter_Float, 0.0 ),   --  : hrrate (Amount)
           303 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           304 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           305 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           306 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
           307 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           308 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           309 => ( Parameter_Integer, 0 ),   --  : person (Integer)
           310 => ( Parameter_Integer, 0 )   --  : jobtype (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
            5 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            6 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : jobtype (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : agreehrs (Integer)
           10 => ( Parameter_Float, 0.0 ),   --  : bonamt1 (Amount)
           11 => ( Parameter_Float, 0.0 ),   --  : bonamt2 (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : bonamt3 (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : bonamt4 (Amount)
           14 => ( Parameter_Float, 0.0 ),   --  : bonamt5 (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : bonamt6 (Amount)
           16 => ( Parameter_Integer, 0 ),   --  : bontax1 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : bontax2 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : bontax3 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : bontax4 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : bontax5 (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : bontax6 (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : bonus (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : busaccts (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : checktax (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : chkincom (Integer)
           26 => ( Parameter_Float, 0.0 ),   --  : dedoth (Amount)
           27 => ( Parameter_Float, 0.0 ),   --  : deduc1 (Amount)
           28 => ( Parameter_Float, 0.0 ),   --  : deduc2 (Amount)
           29 => ( Parameter_Float, 0.0 ),   --  : deduc3 (Amount)
           30 => ( Parameter_Float, 0.0 ),   --  : deduc4 (Amount)
           31 => ( Parameter_Float, 0.0 ),   --  : deduc5 (Amount)
           32 => ( Parameter_Float, 0.0 ),   --  : deduc6 (Amount)
           33 => ( Parameter_Float, 0.0 ),   --  : deduc7 (Amount)
           34 => ( Parameter_Float, 0.0 ),   --  : deduc8 (Amount)
           35 => ( Parameter_Integer, 0 ),   --  : dirctr (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : dirni (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : dvtothru (Integer)
           38 => ( Parameter_Float, 0.0 ),   --  : dvushr (Amount)
           39 => ( Parameter_Integer, 0 ),   --  : empany (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : empown (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : etype (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : everot (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : ftpt (Integer)
           44 => ( Parameter_Float, 0.0 ),   --  : grsofar (Amount)
           45 => ( Parameter_Float, 0.0 ),   --  : grwage (Amount)
           46 => ( Parameter_Integer, 0 ),   --  : grwagpd (Integer)
           47 => ( Parameter_Float, 0.0 ),   --  : hha1 (Amount)
           48 => ( Parameter_Float, 0.0 ),   --  : hha2 (Amount)
           49 => ( Parameter_Float, 0.0 ),   --  : hha3 (Amount)
           50 => ( Parameter_Integer, 0 ),   --  : hhc1 (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : hhc2 (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : hhc3 (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : hohinc (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : inclpay1 (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : inclpay2 (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : inclpay3 (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : inclpay4 (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : inclpay5 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : inclpay6 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : inkind01 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : inkind02 (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : inkind03 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : inkind04 (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : inkind05 (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : inkind06 (Integer)
           66 => ( Parameter_Integer, 0 ),   --  : inkind07 (Integer)
           67 => ( Parameter_Integer, 0 ),   --  : inkind08 (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : inkind09 (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : inkind10 (Integer)
           70 => ( Parameter_Integer, 0 ),   --  : inkind11 (Integer)
           71 => ( Parameter_Integer, 0 ),   --  : instype1 (Integer)
           72 => ( Parameter_Integer, 0 ),   --  : instype2 (Integer)
           73 => ( Parameter_Integer, 0 ),   --  : jobbus (Integer)
           74 => ( Parameter_Integer, 0 ),   --  : likehr (Integer)
           75 => ( Parameter_Integer, 0 ),   --  : mademp (Integer)
           76 => ( Parameter_Integer, 0 ),   --  : matemp (Integer)
           77 => ( Parameter_Integer, 0 ),   --  : matstp (Integer)
           78 => ( Parameter_Float, 0.0 ),   --  : mileamt (Amount)
           79 => ( Parameter_Float, 0.0 ),   --  : motamt (Amount)
           80 => ( Parameter_Float, 0.0 ),   --  : natins (Amount)
           81 => ( Parameter_Integer, 0 ),   --  : nature (Integer)
           82 => ( Parameter_Float, 0.0 ),   --  : nidamt (Amount)
           83 => ( Parameter_Integer, 0 ),   --  : nidpd (Integer)
           84 => ( Parameter_Integer, 0 ),   --  : nmchc (Integer)
           85 => ( Parameter_Integer, 0 ),   --  : nmper (Integer)
           86 => ( Parameter_Integer, 0 ),   --  : nomor1 (Integer)
           87 => ( Parameter_Integer, 0 ),   --  : nomor2 (Integer)
           88 => ( Parameter_Integer, 0 ),   --  : nomor3 (Integer)
           89 => ( Parameter_Integer, 0 ),   --  : numemp (Integer)
           90 => ( Parameter_Integer, 0 ),   --  : othded1 (Integer)
           91 => ( Parameter_Integer, 0 ),   --  : othded2 (Integer)
           92 => ( Parameter_Integer, 0 ),   --  : othded3 (Integer)
           93 => ( Parameter_Integer, 0 ),   --  : othded4 (Integer)
           94 => ( Parameter_Integer, 0 ),   --  : othded5 (Integer)
           95 => ( Parameter_Integer, 0 ),   --  : othded6 (Integer)
           96 => ( Parameter_Integer, 0 ),   --  : othded7 (Integer)
           97 => ( Parameter_Integer, 0 ),   --  : othded8 (Integer)
           98 => ( Parameter_Integer, 0 ),   --  : othded9 (Integer)
           99 => ( Parameter_Float, 0.0 ),   --  : ownamt (Amount)
           100 => ( Parameter_Float, 0.0 ),   --  : ownotamt (Amount)
           101 => ( Parameter_Integer, 0 ),   --  : ownother (Integer)
           102 => ( Parameter_Integer, 0 ),   --  : ownsum (Integer)
           103 => ( Parameter_Float, 0.0 ),   --  : payamt (Amount)
           104 => ( Parameter_Date, Clock ),   --  : paydat (Ada.Calendar.Time)
           105 => ( Parameter_Float, 0.0 ),   --  : paye (Amount)
           106 => ( Parameter_Integer, 0 ),   --  : paypd (Integer)
           107 => ( Parameter_Integer, 0 ),   --  : payslip (Integer)
           108 => ( Parameter_Integer, 0 ),   --  : payusl (Integer)
           109 => ( Parameter_Float, 0.0 ),   --  : pothr (Amount)
           110 => ( Parameter_Float, 0.0 ),   --  : prbefore (Amount)
           111 => ( Parameter_Integer, 0 ),   --  : profdocs (Integer)
           112 => ( Parameter_Float, 0.0 ),   --  : profit1 (Amount)
           113 => ( Parameter_Integer, 0 ),   --  : profit2 (Integer)
           114 => ( Parameter_Integer, 0 ),   --  : profni (Integer)
           115 => ( Parameter_Integer, 0 ),   --  : proftax (Integer)
           116 => ( Parameter_Integer, 0 ),   --  : rspoth (Integer)
           117 => ( Parameter_Date, Clock ),   --  : se1 (Ada.Calendar.Time)
           118 => ( Parameter_Date, Clock ),   --  : se2 (Ada.Calendar.Time)
           119 => ( Parameter_Date, Clock ),   --  : seend (Ada.Calendar.Time)
           120 => ( Parameter_Float, 0.0 ),   --  : seincamt (Amount)
           121 => ( Parameter_Integer, 0 ),   --  : seincwm (Integer)
           122 => ( Parameter_Integer, 0 ),   --  : selwks (Integer)
           123 => ( Parameter_Float, 0.0 ),   --  : seniiamt (Amount)
           124 => ( Parameter_Integer, 0 ),   --  : seniinc (Integer)
           125 => ( Parameter_Float, 0.0 ),   --  : senilamt (Amount)
           126 => ( Parameter_Integer, 0 ),   --  : senilump (Integer)
           127 => ( Parameter_Float, 0.0 ),   --  : seniramt (Amount)
           128 => ( Parameter_Integer, 0 ),   --  : senireg (Integer)
           129 => ( Parameter_Integer, 0 ),   --  : senirpd (Integer)
           130 => ( Parameter_Integer, 0 ),   --  : setax (Integer)
           131 => ( Parameter_Float, 0.0 ),   --  : setaxamt (Amount)
           132 => ( Parameter_Float, 0.0 ),   --  : smpamt (Amount)
           133 => ( Parameter_Integer, 0 ),   --  : smprate (Integer)
           134 => ( Parameter_Integer, 0 ),   --  : sole (Integer)
           135 => ( Parameter_Float, 0.0 ),   --  : sspamt (Amount)
           136 => ( Parameter_Float, 0.0 ),   --  : taxamt (Amount)
           137 => ( Parameter_Float, 0.0 ),   --  : taxdamt (Amount)
           138 => ( Parameter_Integer, 0 ),   --  : taxdpd (Integer)
           139 => ( Parameter_Float, 0.0 ),   --  : totus1 (Amount)
           140 => ( Parameter_Float, 0.0 ),   --  : ubonamt (Amount)
           141 => ( Parameter_Integer, 0 ),   --  : uboninc (Integer)
           142 => ( Parameter_Float, 0.0 ),   --  : udeduc1 (Amount)
           143 => ( Parameter_Float, 0.0 ),   --  : udeduc2 (Amount)
           144 => ( Parameter_Float, 0.0 ),   --  : udeduc3 (Amount)
           145 => ( Parameter_Float, 0.0 ),   --  : udeduc4 (Amount)
           146 => ( Parameter_Float, 0.0 ),   --  : udeduc5 (Amount)
           147 => ( Parameter_Float, 0.0 ),   --  : udeduc6 (Amount)
           148 => ( Parameter_Float, 0.0 ),   --  : udeduc7 (Amount)
           149 => ( Parameter_Float, 0.0 ),   --  : udeduc8 (Amount)
           150 => ( Parameter_Float, 0.0 ),   --  : ugross (Amount)
           151 => ( Parameter_Integer, 0 ),   --  : uincpay1 (Integer)
           152 => ( Parameter_Integer, 0 ),   --  : uincpay2 (Integer)
           153 => ( Parameter_Integer, 0 ),   --  : uincpay3 (Integer)
           154 => ( Parameter_Integer, 0 ),   --  : uincpay4 (Integer)
           155 => ( Parameter_Integer, 0 ),   --  : uincpay5 (Integer)
           156 => ( Parameter_Integer, 0 ),   --  : uincpay6 (Integer)
           157 => ( Parameter_Float, 0.0 ),   --  : umileamt (Amount)
           158 => ( Parameter_Float, 0.0 ),   --  : umotamt (Amount)
           159 => ( Parameter_Float, 0.0 ),   --  : unett (Amount)
           160 => ( Parameter_Integer, 0 ),   --  : uothded1 (Integer)
           161 => ( Parameter_Integer, 0 ),   --  : uothded2 (Integer)
           162 => ( Parameter_Integer, 0 ),   --  : uothded3 (Integer)
           163 => ( Parameter_Integer, 0 ),   --  : uothded4 (Integer)
           164 => ( Parameter_Integer, 0 ),   --  : uothded5 (Integer)
           165 => ( Parameter_Integer, 0 ),   --  : uothded6 (Integer)
           166 => ( Parameter_Integer, 0 ),   --  : uothded7 (Integer)
           167 => ( Parameter_Integer, 0 ),   --  : uothded8 (Integer)
           168 => ( Parameter_Integer, 0 ),   --  : uothded9 (Integer)
           169 => ( Parameter_Float, 0.0 ),   --  : uothdtot (Amount)
           170 => ( Parameter_Float, 0.0 ),   --  : uothr (Amount)
           171 => ( Parameter_Integer, 0 ),   --  : upd (Integer)
           172 => ( Parameter_Float, 0.0 ),   --  : usmpamt (Amount)
           173 => ( Parameter_Integer, 0 ),   --  : usmprate (Integer)
           174 => ( Parameter_Float, 0.0 ),   --  : usspamt (Amount)
           175 => ( Parameter_Float, 0.0 ),   --  : usuhr (Amount)
           176 => ( Parameter_Float, 0.0 ),   --  : utaxamt (Amount)
           177 => ( Parameter_Integer, 0 ),   --  : watdid (Integer)
           178 => ( Parameter_Integer, 0 ),   --  : watprev (Integer)
           179 => ( Parameter_Integer, 0 ),   --  : x_where (Integer)
           180 => ( Parameter_Integer, 0 ),   --  : whynopro (Integer)
           181 => ( Parameter_Integer, 0 ),   --  : whynou01 (Integer)
           182 => ( Parameter_Integer, 0 ),   --  : whynou02 (Integer)
           183 => ( Parameter_Integer, 0 ),   --  : whynou03 (Integer)
           184 => ( Parameter_Integer, 0 ),   --  : whynou04 (Integer)
           185 => ( Parameter_Integer, 0 ),   --  : whynou05 (Integer)
           186 => ( Parameter_Integer, 0 ),   --  : whynou06 (Integer)
           187 => ( Parameter_Integer, 0 ),   --  : whynou07 (Integer)
           188 => ( Parameter_Integer, 0 ),   --  : whynou08 (Integer)
           189 => ( Parameter_Integer, 0 ),   --  : whynou09 (Integer)
           190 => ( Parameter_Integer, 0 ),   --  : whynou10 (Integer)
           191 => ( Parameter_Integer, 0 ),   --  : whynou11 (Integer)
           192 => ( Parameter_Integer, 0 ),   --  : workacc (Integer)
           193 => ( Parameter_Integer, 0 ),   --  : workmth (Integer)
           194 => ( Parameter_Integer, 0 ),   --  : workyr (Integer)
           195 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           196 => ( Parameter_Integer, 0 ),   --  : hdqhrs (Integer)
           197 => ( Parameter_Float, 0.0 ),   --  : jobhours (Amount)
           198 => ( Parameter_Integer, 0 ),   --  : sspsmpfg (Integer)
           199 => ( Parameter_Text, null, Null_Unbounded_String ),   --  : ugrspay (Unbounded_String)
           200 => ( Parameter_Integer, 0 ),   --  : inclpay7 (Integer)
           201 => ( Parameter_Integer, 0 ),   --  : inclpay8 (Integer)
           202 => ( Parameter_Integer, 0 ),   --  : paperiod (Integer)
           203 => ( Parameter_Integer, 0 ),   --  : ppperiod (Integer)
           204 => ( Parameter_Float, 0.0 ),   --  : sapamt (Amount)
           205 => ( Parameter_Float, 0.0 ),   --  : sppamt (Amount)
           206 => ( Parameter_Integer, 0 ),   --  : uincpay7 (Integer)
           207 => ( Parameter_Integer, 0 ),   --  : uincpay8 (Integer)
           208 => ( Parameter_Integer, 0 ),   --  : usapamt (Integer)
           209 => ( Parameter_Float, 0.0 ),   --  : usppamt (Amount)
           210 => ( Parameter_Integer, 0 ),   --  : inkind12 (Integer)
           211 => ( Parameter_Integer, 0 ),   --  : inkind13 (Integer)
           212 => ( Parameter_Integer, 0 ),   --  : salsac (Integer)
           213 => ( Parameter_Float, 0.0 ),   --  : chvamt (Amount)
           214 => ( Parameter_Integer, 0 ),   --  : chvpd (Integer)
           215 => ( Parameter_Integer, 0 ),   --  : chvsac (Integer)
           216 => ( Parameter_Float, 0.0 ),   --  : chvuamt (Amount)
           217 => ( Parameter_Integer, 0 ),   --  : chvupd (Integer)
           218 => ( Parameter_Integer, 0 ),   --  : chvusu (Integer)
           219 => ( Parameter_Integer, 0 ),   --  : expben01 (Integer)
           220 => ( Parameter_Integer, 0 ),   --  : expben02 (Integer)
           221 => ( Parameter_Integer, 0 ),   --  : expben03 (Integer)
           222 => ( Parameter_Integer, 0 ),   --  : expben04 (Integer)
           223 => ( Parameter_Integer, 0 ),   --  : expben05 (Integer)
           224 => ( Parameter_Integer, 0 ),   --  : expben06 (Integer)
           225 => ( Parameter_Integer, 0 ),   --  : expben07 (Integer)
           226 => ( Parameter_Integer, 0 ),   --  : expben08 (Integer)
           227 => ( Parameter_Integer, 0 ),   --  : expben09 (Integer)
           228 => ( Parameter_Integer, 0 ),   --  : expben10 (Integer)
           229 => ( Parameter_Integer, 0 ),   --  : expben11 (Integer)
           230 => ( Parameter_Integer, 0 ),   --  : expben12 (Integer)
           231 => ( Parameter_Float, 0.0 ),   --  : fuelamt (Amount)
           232 => ( Parameter_Integer, 0 ),   --  : fuelbn (Integer)
           233 => ( Parameter_Integer, 0 ),   --  : fuelpd (Integer)
           234 => ( Parameter_Float, 0.0 ),   --  : fueluamt (Amount)
           235 => ( Parameter_Integer, 0 ),   --  : fuelupd (Integer)
           236 => ( Parameter_Integer, 0 ),   --  : fuelusu (Integer)
           237 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           238 => ( Parameter_Integer, 0 ),   --  : prevmth (Integer)
           239 => ( Parameter_Integer, 0 ),   --  : prevyr (Integer)
           240 => ( Parameter_Float, 0.0 ),   --  : spnamt (Amount)
           241 => ( Parameter_Integer, 0 ),   --  : spnpd (Integer)
           242 => ( Parameter_Integer, 0 ),   --  : spnsac (Integer)
           243 => ( Parameter_Float, 0.0 ),   --  : spnuamt (Amount)
           244 => ( Parameter_Integer, 0 ),   --  : spnupd (Integer)
           245 => ( Parameter_Integer, 0 ),   --  : spnusu (Integer)
           246 => ( Parameter_Float, 0.0 ),   --  : vchamt (Amount)
           247 => ( Parameter_Integer, 0 ),   --  : vchpd (Integer)
           248 => ( Parameter_Integer, 0 ),   --  : vchsac (Integer)
           249 => ( Parameter_Integer, 0 ),   --  : vchuamt (Integer)
           250 => ( Parameter_Integer, 0 ),   --  : vchupd (Integer)
           251 => ( Parameter_Integer, 0 ),   --  : vchusu (Integer)
           252 => ( Parameter_Integer, 0 ),   --  : wrkprev (Integer)
           253 => ( Parameter_Float, 0.0 ),   --  : caramt (Amount)
           254 => ( Parameter_Integer, 0 ),   --  : carcon (Integer)
           255 => ( Parameter_Integer, 0 ),   --  : carval (Integer)
           256 => ( Parameter_Integer, 0 ),   --  : fueltyp (Integer)
           257 => ( Parameter_Integer, 0 ),   --  : orgemp (Integer)
           258 => ( Parameter_Integer, 0 ),   --  : sector (Integer)
           259 => ( Parameter_Integer, 0 ),   --  : sectrnp (Integer)
           260 => ( Parameter_Integer, 0 ),   --  : whynou12 (Integer)
           261 => ( Parameter_Integer, 0 ),   --  : whynou13 (Integer)
           262 => ( Parameter_Integer, 0 ),   --  : whynou14 (Integer)
           263 => ( Parameter_Integer, 0 ),   --  : jobsect (Integer)
           264 => ( Parameter_Integer, 0 ),   --  : oremp (Integer)
           265 => ( Parameter_Float, 0.0 ),   --  : bontxam1 (Amount)
           266 => ( Parameter_Float, 0.0 ),   --  : bontxam2 (Amount)
           267 => ( Parameter_Float, 0.0 ),   --  : bontxam3 (Amount)
           268 => ( Parameter_Float, 0.0 ),   --  : bontxam4 (Amount)
           269 => ( Parameter_Float, 0.0 ),   --  : bontxam5 (Amount)
           270 => ( Parameter_Float, 0.0 ),   --  : bontxam6 (Amount)
           271 => ( Parameter_Float, 0.0 ),   --  : deduc9 (Amount)
           272 => ( Parameter_Integer, 0 ),   --  : emplany (Integer)
           273 => ( Parameter_Integer, 0 ),   --  : empten (Integer)
           274 => ( Parameter_Integer, 0 ),   --  : lthan30 (Integer)
           275 => ( Parameter_Integer, 0 ),   --  : numeten (Integer)
           276 => ( Parameter_Integer, 0 ),   --  : othded01 (Integer)
           277 => ( Parameter_Integer, 0 ),   --  : othded02 (Integer)
           278 => ( Parameter_Integer, 0 ),   --  : othded03 (Integer)
           279 => ( Parameter_Integer, 0 ),   --  : othded04 (Integer)
           280 => ( Parameter_Integer, 0 ),   --  : othded05 (Integer)
           281 => ( Parameter_Integer, 0 ),   --  : othded06 (Integer)
           282 => ( Parameter_Integer, 0 ),   --  : othded07 (Integer)
           283 => ( Parameter_Integer, 0 ),   --  : othded08 (Integer)
           284 => ( Parameter_Integer, 0 ),   --  : othded09 (Integer)
           285 => ( Parameter_Integer, 0 ),   --  : othded10 (Integer)
           286 => ( Parameter_Float, 0.0 ),   --  : udeduc9 (Amount)
           287 => ( Parameter_Integer, 0 ),   --  : uothde01 (Integer)
           288 => ( Parameter_Integer, 0 ),   --  : uothde02 (Integer)
           289 => ( Parameter_Integer, 0 ),   --  : uothde03 (Integer)
           290 => ( Parameter_Integer, 0 ),   --  : uothde04 (Integer)
           291 => ( Parameter_Integer, 0 ),   --  : uothde05 (Integer)
           292 => ( Parameter_Integer, 0 ),   --  : uothde06 (Integer)
           293 => ( Parameter_Integer, 0 ),   --  : uothde07 (Integer)
           294 => ( Parameter_Integer, 0 ),   --  : uothde08 (Integer)
           295 => ( Parameter_Integer, 0 ),   --  : uothde09 (Integer)
           296 => ( Parameter_Integer, 0 ),   --  : uothde10 (Integer)
           297 => ( Parameter_Integer, 0 ),   --  : yjbchang (Integer)
           298 => ( Parameter_Integer, 0 ),   --  : jbchnge (Integer)
           299 => ( Parameter_Integer, 0 ),   --  : hourly (Integer)
           300 => ( Parameter_Integer, 0 ),   --  : hrexa (Integer)
           301 => ( Parameter_Integer, 0 ),   --  : hrexb (Integer)
           302 => ( Parameter_Integer, 0 ),   --  : hrexc1 (Integer)
           303 => ( Parameter_Integer, 0 ),   --  : hrexc2 (Integer)
           304 => ( Parameter_Integer, 0 ),   --  : hrexc3 (Integer)
           305 => ( Parameter_Integer, 0 ),   --  : hrexc4 (Integer)
           306 => ( Parameter_Integer, 0 ),   --  : hrexc5 (Integer)
           307 => ( Parameter_Integer, 0 ),   --  : hrexc6 (Integer)
           308 => ( Parameter_Integer, 0 ),   --  : hrexc7 (Integer)
           309 => ( Parameter_Integer, 0 ),   --  : hrexc8 (Integer)
           310 => ( Parameter_Float, 0.0 )   --  : hrrate (Amount)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $100, $101, $102, $103, $104, $105, $106, $107, $108, $109, $110, $111, $112, $113, $114, $115, $116, $117, $118, $119, $120, $121, $122, $123, $124, $125, $126, $127, $128, $129, $130, $131, $132, $133, $134, $135, $136, $137, $138, $139, $140, $141, $142, $143, $144, $145, $146, $147, $148, $149, $150, $151, $152, $153, $154, $155, $156, $157, $158, $159, $160, $161, $162, $163, $164, $165, $166, $167, $168, $169, $170, $171, $172, $173, $174, $175, $176, $177, $178, $179, $180, $181, $182, $183, $184, $185, $186, $187, $188, $189, $190, $191, $192, $193, $194, $195, $196, $197, $198, $199, $200, $201, $202, $203, $204, $205, $206, $207, $208, $209, $210, $211, $212, $213, $214, $215, $216, $217, $218, $219, $220, $221, $222, $223, $224, $225, $226, $227, $228, $229, $230, $231, $232, $233, $234, $235, $236, $237, $238, $239, $240, $241, $242, $243, $244, $245, $246, $247, $248, $249, $250, $251, $252, $253, $254, $255, $256, $257, $258, $259, $260, $261, $262, $263, $264, $265, $266, $267, $268, $269, $270, $271, $272, $273, $274, $275, $276, $277, $278, $279, $280, $281, $282, $283, $284, $285, $286, $287, $288, $289, $290, $291, $292, $293, $294, $295, $296, $297, $298, $299, $300, $301, $302, $303, $304, $305, $306, $307, $308, $309, $310 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 8 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : counter (Integer)
            5 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            6 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            8 => ( Parameter_Integer, 0 )   --  : jobtype (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and counter = $4 and sernum = $5 and benunit = $6 and person = $7 and jobtype = $8"; 
   begin 
      return Get_Prepared_Retrieve_Statement( s ); 
   end Get_Prepared_Retrieve_Statement; 

   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return gse.Prepared_Statement is 
   begin 
      return Get_Prepared_Retrieve_Statement( d.To_String( crit )); 
   end Get_Prepared_Retrieve_Statement; 

   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( SELECT_PART, SCHEMA_NAME ) & sqlstr; 
   begin 
      ps := gse.Prepare( 
        query, 
        On_Server => True ); 
      return ps; 
   end Get_Prepared_Retrieve_Statement; 


   function Get_Prepared_Update_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " agreehrs = $1, bonamt1 = $2, bonamt2 = $3, bonamt3 = $4, bonamt4 = $5, bonamt5 = $6, bonamt6 = $7, bontax1 = $8, bontax2 = $9, bontax3 = $10, bontax4 = $11, bontax5 = $12, bontax6 = $13, bonus = $14, busaccts = $15, checktax = $16, chkincom = $17, dedoth = $18, deduc1 = $19, deduc2 = $20, deduc3 = $21, deduc4 = $22, deduc5 = $23, deduc6 = $24, deduc7 = $25, deduc8 = $26, dirctr = $27, dirni = $28, dvtothru = $29, dvushr = $30, empany = $31, empown = $32, etype = $33, everot = $34, ftpt = $35, grsofar = $36, grwage = $37, grwagpd = $38, hha1 = $39, hha2 = $40, hha3 = $41, hhc1 = $42, hhc2 = $43, hhc3 = $44, hohinc = $45, inclpay1 = $46, inclpay2 = $47, inclpay3 = $48, inclpay4 = $49, inclpay5 = $50, inclpay6 = $51, inkind01 = $52, inkind02 = $53, inkind03 = $54, inkind04 = $55, inkind05 = $56, inkind06 = $57, inkind07 = $58, inkind08 = $59, inkind09 = $60, inkind10 = $61, inkind11 = $62, instype1 = $63, instype2 = $64, jobbus = $65, likehr = $66, mademp = $67, matemp = $68, matstp = $69, mileamt = $70, motamt = $71, natins = $72, nature = $73, nidamt = $74, nidpd = $75, nmchc = $76, nmper = $77, nomor1 = $78, nomor2 = $79, nomor3 = $80, numemp = $81, othded1 = $82, othded2 = $83, othded3 = $84, othded4 = $85, othded5 = $86, othded6 = $87, othded7 = $88, othded8 = $89, othded9 = $90, ownamt = $91, ownotamt = $92, ownother = $93, ownsum = $94, payamt = $95, paydat = $96, paye = $97, paypd = $98, payslip = $99, payusl = $100, pothr = $101, prbefore = $102, profdocs = $103, profit1 = $104, profit2 = $105, profni = $106, proftax = $107, rspoth = $108, se1 = $109, se2 = $110, seend = $111, seincamt = $112, seincwm = $113, selwks = $114, seniiamt = $115, seniinc = $116, senilamt = $117, senilump = $118, seniramt = $119, senireg = $120, senirpd = $121, setax = $122, setaxamt = $123, smpamt = $124, smprate = $125, sole = $126, sspamt = $127, taxamt = $128, taxdamt = $129, taxdpd = $130, totus1 = $131, ubonamt = $132, uboninc = $133, udeduc1 = $134, udeduc2 = $135, udeduc3 = $136, udeduc4 = $137, udeduc5 = $138, udeduc6 = $139, udeduc7 = $140, udeduc8 = $141, ugross = $142, uincpay1 = $143, uincpay2 = $144, uincpay3 = $145, uincpay4 = $146, uincpay5 = $147, uincpay6 = $148, umileamt = $149, umotamt = $150, unett = $151, uothded1 = $152, uothded2 = $153, uothded3 = $154, uothded4 = $155, uothded5 = $156, uothded6 = $157, uothded7 = $158, uothded8 = $159, uothded9 = $160, uothdtot = $161, uothr = $162, upd = $163, usmpamt = $164, usmprate = $165, usspamt = $166, usuhr = $167, utaxamt = $168, watdid = $169, watprev = $170, x_where = $171, whynopro = $172, whynou01 = $173, whynou02 = $174, whynou03 = $175, whynou04 = $176, whynou05 = $177, whynou06 = $178, whynou07 = $179, whynou08 = $180, whynou09 = $181, whynou10 = $182, whynou11 = $183, workacc = $184, workmth = $185, workyr = $186, month = $187, hdqhrs = $188, jobhours = $189, sspsmpfg = $190, ugrspay = $191, inclpay7 = $192, inclpay8 = $193, paperiod = $194, ppperiod = $195, sapamt = $196, sppamt = $197, uincpay7 = $198, uincpay8 = $199, usapamt = $200, usppamt = $201, inkind12 = $202, inkind13 = $203, salsac = $204, chvamt = $205, chvpd = $206, chvsac = $207, chvuamt = $208, chvupd = $209, chvusu = $210, expben01 = $211, expben02 = $212, expben03 = $213, expben04 = $214, expben05 = $215, expben06 = $216, expben07 = $217, expben08 = $218, expben09 = $219, expben10 = $220, expben11 = $221, expben12 = $222, fuelamt = $223, fuelbn = $224, fuelpd = $225, fueluamt = $226, fuelupd = $227, fuelusu = $228, issue = $229, prevmth = $230, prevyr = $231, spnamt = $232, spnpd = $233, spnsac = $234, spnuamt = $235, spnupd = $236, spnusu = $237, vchamt = $238, vchpd = $239, vchsac = $240, vchuamt = $241, vchupd = $242, vchusu = $243, wrkprev = $244, caramt = $245, carcon = $246, carval = $247, fueltyp = $248, orgemp = $249, sector = $250, sectrnp = $251, whynou12 = $252, whynou13 = $253, whynou14 = $254, jobsect = $255, oremp = $256, bontxam1 = $257, bontxam2 = $258, bontxam3 = $259, bontxam4 = $260, bontxam5 = $261, bontxam6 = $262, deduc9 = $263, emplany = $264, empten = $265, lthan30 = $266, numeten = $267, othded01 = $268, othded02 = $269, othded03 = $270, othded04 = $271, othded05 = $272, othded06 = $273, othded07 = $274, othded08 = $275, othded09 = $276, othded10 = $277, udeduc9 = $278, uothde01 = $279, uothde02 = $280, uothde03 = $281, uothde04 = $282, uothde05 = $283, uothde06 = $284, uothde07 = $285, uothde08 = $286, uothde09 = $287, uothde10 = $288, yjbchang = $289, jbchnge = $290, hourly = $291, hrexa = $292, hrexb = $293, hrexc1 = $294, hrexc2 = $295, hrexc3 = $296, hrexc4 = $297, hrexc5 = $298, hrexc6 = $299, hrexc7 = $300, hrexc8 = $301, hrrate = $302 where user_id = $303 and edition = $304 and year = $305 and counter = $306 and sernum = $307 and benunit = $308 and person = $309 and jobtype = $310"; 
   begin 
      ps := gse.Prepare( 
        query, 
        On_Server => True ); 
      return ps; 
   end Get_Prepared_Update_Statement; 


   
   
   procedure Check_Result( conn : in out gse.Database_Connection ) is
      error_msg : constant String := gse.Error( conn );
   begin
      if( error_msg /= "" )then
         Log( error_msg );
         Connection_Pool.Return_Connection( conn );
         Raise_Exception( db_commons.DB_Exception'Identity, error_msg );
      end if;
   end  Check_Result;     


   
   Next_Free_user_id_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.job", SCHEMA_NAME );
   Next_Free_user_id_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_user_id_query, On_Server => True );
   -- 
   -- Next highest avaiable value of user_id - useful for saving  
   --
   function Next_Free_user_id( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_user_id_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_user_id;


   Next_Free_edition_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.job", SCHEMA_NAME );
   Next_Free_edition_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_edition_query, On_Server => True );
   -- 
   -- Next highest avaiable value of edition - useful for saving  
   --
   function Next_Free_edition( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_edition_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_edition;


   Next_Free_year_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.job", SCHEMA_NAME );
   Next_Free_year_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_year_query, On_Server => True );
   -- 
   -- Next highest avaiable value of year - useful for saving  
   --
   function Next_Free_year( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_year_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_year;


   Next_Free_counter_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( counter ) + 1, 1 ) from frs.job", SCHEMA_NAME );
   Next_Free_counter_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_counter_query, On_Server => True );
   -- 
   -- Next highest avaiable value of counter - useful for saving  
   --
   function Next_Free_counter( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_counter_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_counter;


   Next_Free_sernum_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.job", SCHEMA_NAME );
   Next_Free_sernum_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_sernum_query, On_Server => True );
   -- 
   -- Next highest avaiable value of sernum - useful for saving  
   --
   function Next_Free_sernum( connection : Database_Connection := null) return Sernum_Value is
      cursor              : gse.Forward_Cursor;
      ai                  : Sernum_Value;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_sernum_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := Sernum_Value'Value( gse.Value( cursor, 0 ));

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_sernum;


   Next_Free_benunit_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.job", SCHEMA_NAME );
   Next_Free_benunit_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_benunit_query, On_Server => True );
   -- 
   -- Next highest avaiable value of benunit - useful for saving  
   --
   function Next_Free_benunit( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_benunit_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_benunit;


   Next_Free_person_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( person ) + 1, 1 ) from frs.job", SCHEMA_NAME );
   Next_Free_person_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_person_query, On_Server => True );
   -- 
   -- Next highest avaiable value of person - useful for saving  
   --
   function Next_Free_person( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_person_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_person;


   Next_Free_jobtype_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( jobtype ) + 1, 1 ) from frs.job", SCHEMA_NAME );
   Next_Free_jobtype_ps : gse.Prepared_Statement := 
        gse.Prepare( Next_Free_jobtype_query, On_Server => True );
   -- 
   -- Next highest avaiable value of jobtype - useful for saving  
   --
   function Next_Free_jobtype( connection : Database_Connection := null) return Integer is
      cursor              : gse.Forward_Cursor;
      ai                  : Integer;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
   begin
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      
      cursor.Fetch( local_connection, Next_Free_jobtype_ps );
      Check_Result( local_connection );
      if( gse.Has_Row( cursor ))then
         ai := gse.Integer_Value( cursor, 0, 0 );

      end if;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return ai;
   end Next_Free_jobtype;



   --
   -- returns true if the primary key parts of Ukds.Frs.Job match the defaults in Ukds.Frs.Null_Job
   --
   --
   -- Does this Ukds.Frs.Job equal the default Ukds.Frs.Null_Job ?
   --
   function Is_Null( a_job : Job ) return Boolean is
   begin
      return a_job = Ukds.Frs.Null_Job;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Job matching the primary key fields, or the Ukds.Frs.Null_Job record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; jobtype : Integer; connection : Database_Connection := null ) return Ukds.Frs.Job is
      l : Ukds.Frs.Job_List;
      a_job : Ukds.Frs.Job;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_counter( c, counter );
      Add_sernum( c, sernum );
      Add_benunit( c, benunit );
      Add_person( c, person );
      Add_jobtype( c, jobtype );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Job_List_Package.is_empty( l ) ) then
         a_job := Ukds.Frs.Job_List_Package.First_Element( l );
      else
         a_job := Ukds.Frs.Null_Job;
      end if;
      return a_job;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.job where user_id = $1 and edition = $2 and year = $3 and counter = $4 and sernum = $5 and benunit = $6 and person = $7 and jobtype = $8", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; counter : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; jobtype : Integer; connection : Database_Connection := null ) return Boolean  is
      params : gse.SQL_Parameters := Get_Configured_Retrieve_Params;
      cursor : gse.Forward_Cursor;
      local_connection : Database_Connection;
      is_local_connection : Boolean;
      found : Boolean;        
   begin 
      if( connection = null )then
         local_connection := Connection_Pool.Lease;
         is_local_connection := True;
      else
         local_connection := connection;          
         is_local_connection := False;
      end if;
      params( 1 ) := "+"( Integer'Pos( user_id ));
      params( 2 ) := "+"( Integer'Pos( edition ));
      params( 3 ) := "+"( Integer'Pos( year ));
      params( 4 ) := "+"( Integer'Pos( counter ));
      params( 5 ) := As_Bigint( sernum );
      params( 6 ) := "+"( Integer'Pos( benunit ));
      params( 7 ) := "+"( Integer'Pos( person ));
      params( 8 ) := "+"( Integer'Pos( jobtype ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Job matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Job_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Job retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Job is
      a_job : Ukds.Frs.Job;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_job.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_job.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_job.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_job.counter := gse.Integer_Value( cursor, 3 );
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_job.sernum := Sernum_Value'Value( gse.Value( cursor, 4 ));
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_job.benunit := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_job.person := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_job.jobtype := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_job.agreehrs := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_job.bonamt1:= Amount'Value( gse.Value( cursor, 9 ));
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_job.bonamt2:= Amount'Value( gse.Value( cursor, 10 ));
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_job.bonamt3:= Amount'Value( gse.Value( cursor, 11 ));
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_job.bonamt4:= Amount'Value( gse.Value( cursor, 12 ));
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_job.bonamt5:= Amount'Value( gse.Value( cursor, 13 ));
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_job.bonamt6:= Amount'Value( gse.Value( cursor, 14 ));
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_job.bontax1 := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_job.bontax2 := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_job.bontax3 := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_job.bontax4 := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_job.bontax5 := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_job.bontax6 := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_job.bonus := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_job.busaccts := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_job.checktax := gse.Integer_Value( cursor, 23 );
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_job.chkincom := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_job.dedoth:= Amount'Value( gse.Value( cursor, 25 ));
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_job.deduc1:= Amount'Value( gse.Value( cursor, 26 ));
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_job.deduc2:= Amount'Value( gse.Value( cursor, 27 ));
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_job.deduc3:= Amount'Value( gse.Value( cursor, 28 ));
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_job.deduc4:= Amount'Value( gse.Value( cursor, 29 ));
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_job.deduc5:= Amount'Value( gse.Value( cursor, 30 ));
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_job.deduc6:= Amount'Value( gse.Value( cursor, 31 ));
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_job.deduc7:= Amount'Value( gse.Value( cursor, 32 ));
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_job.deduc8:= Amount'Value( gse.Value( cursor, 33 ));
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_job.dirctr := gse.Integer_Value( cursor, 34 );
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_job.dirni := gse.Integer_Value( cursor, 35 );
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_job.dvtothru := gse.Integer_Value( cursor, 36 );
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_job.dvushr:= Amount'Value( gse.Value( cursor, 37 ));
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_job.empany := gse.Integer_Value( cursor, 38 );
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_job.empown := gse.Integer_Value( cursor, 39 );
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_job.etype := gse.Integer_Value( cursor, 40 );
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_job.everot := gse.Integer_Value( cursor, 41 );
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_job.ftpt := gse.Integer_Value( cursor, 42 );
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_job.grsofar:= Amount'Value( gse.Value( cursor, 43 ));
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_job.grwage:= Amount'Value( gse.Value( cursor, 44 ));
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_job.grwagpd := gse.Integer_Value( cursor, 45 );
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_job.hha1:= Amount'Value( gse.Value( cursor, 46 ));
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_job.hha2:= Amount'Value( gse.Value( cursor, 47 ));
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_job.hha3:= Amount'Value( gse.Value( cursor, 48 ));
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_job.hhc1 := gse.Integer_Value( cursor, 49 );
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_job.hhc2 := gse.Integer_Value( cursor, 50 );
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_job.hhc3 := gse.Integer_Value( cursor, 51 );
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_job.hohinc := gse.Integer_Value( cursor, 52 );
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_job.inclpay1 := gse.Integer_Value( cursor, 53 );
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_job.inclpay2 := gse.Integer_Value( cursor, 54 );
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_job.inclpay3 := gse.Integer_Value( cursor, 55 );
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_job.inclpay4 := gse.Integer_Value( cursor, 56 );
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_job.inclpay5 := gse.Integer_Value( cursor, 57 );
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_job.inclpay6 := gse.Integer_Value( cursor, 58 );
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_job.inkind01 := gse.Integer_Value( cursor, 59 );
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_job.inkind02 := gse.Integer_Value( cursor, 60 );
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_job.inkind03 := gse.Integer_Value( cursor, 61 );
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_job.inkind04 := gse.Integer_Value( cursor, 62 );
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_job.inkind05 := gse.Integer_Value( cursor, 63 );
      end if;
      if not gse.Is_Null( cursor, 64 )then
         a_job.inkind06 := gse.Integer_Value( cursor, 64 );
      end if;
      if not gse.Is_Null( cursor, 65 )then
         a_job.inkind07 := gse.Integer_Value( cursor, 65 );
      end if;
      if not gse.Is_Null( cursor, 66 )then
         a_job.inkind08 := gse.Integer_Value( cursor, 66 );
      end if;
      if not gse.Is_Null( cursor, 67 )then
         a_job.inkind09 := gse.Integer_Value( cursor, 67 );
      end if;
      if not gse.Is_Null( cursor, 68 )then
         a_job.inkind10 := gse.Integer_Value( cursor, 68 );
      end if;
      if not gse.Is_Null( cursor, 69 )then
         a_job.inkind11 := gse.Integer_Value( cursor, 69 );
      end if;
      if not gse.Is_Null( cursor, 70 )then
         a_job.instype1 := gse.Integer_Value( cursor, 70 );
      end if;
      if not gse.Is_Null( cursor, 71 )then
         a_job.instype2 := gse.Integer_Value( cursor, 71 );
      end if;
      if not gse.Is_Null( cursor, 72 )then
         a_job.jobbus := gse.Integer_Value( cursor, 72 );
      end if;
      if not gse.Is_Null( cursor, 73 )then
         a_job.likehr := gse.Integer_Value( cursor, 73 );
      end if;
      if not gse.Is_Null( cursor, 74 )then
         a_job.mademp := gse.Integer_Value( cursor, 74 );
      end if;
      if not gse.Is_Null( cursor, 75 )then
         a_job.matemp := gse.Integer_Value( cursor, 75 );
      end if;
      if not gse.Is_Null( cursor, 76 )then
         a_job.matstp := gse.Integer_Value( cursor, 76 );
      end if;
      if not gse.Is_Null( cursor, 77 )then
         a_job.mileamt:= Amount'Value( gse.Value( cursor, 77 ));
      end if;
      if not gse.Is_Null( cursor, 78 )then
         a_job.motamt:= Amount'Value( gse.Value( cursor, 78 ));
      end if;
      if not gse.Is_Null( cursor, 79 )then
         a_job.natins:= Amount'Value( gse.Value( cursor, 79 ));
      end if;
      if not gse.Is_Null( cursor, 80 )then
         a_job.nature := gse.Integer_Value( cursor, 80 );
      end if;
      if not gse.Is_Null( cursor, 81 )then
         a_job.nidamt:= Amount'Value( gse.Value( cursor, 81 ));
      end if;
      if not gse.Is_Null( cursor, 82 )then
         a_job.nidpd := gse.Integer_Value( cursor, 82 );
      end if;
      if not gse.Is_Null( cursor, 83 )then
         a_job.nmchc := gse.Integer_Value( cursor, 83 );
      end if;
      if not gse.Is_Null( cursor, 84 )then
         a_job.nmper := gse.Integer_Value( cursor, 84 );
      end if;
      if not gse.Is_Null( cursor, 85 )then
         a_job.nomor1 := gse.Integer_Value( cursor, 85 );
      end if;
      if not gse.Is_Null( cursor, 86 )then
         a_job.nomor2 := gse.Integer_Value( cursor, 86 );
      end if;
      if not gse.Is_Null( cursor, 87 )then
         a_job.nomor3 := gse.Integer_Value( cursor, 87 );
      end if;
      if not gse.Is_Null( cursor, 88 )then
         a_job.numemp := gse.Integer_Value( cursor, 88 );
      end if;
      if not gse.Is_Null( cursor, 89 )then
         a_job.othded1 := gse.Integer_Value( cursor, 89 );
      end if;
      if not gse.Is_Null( cursor, 90 )then
         a_job.othded2 := gse.Integer_Value( cursor, 90 );
      end if;
      if not gse.Is_Null( cursor, 91 )then
         a_job.othded3 := gse.Integer_Value( cursor, 91 );
      end if;
      if not gse.Is_Null( cursor, 92 )then
         a_job.othded4 := gse.Integer_Value( cursor, 92 );
      end if;
      if not gse.Is_Null( cursor, 93 )then
         a_job.othded5 := gse.Integer_Value( cursor, 93 );
      end if;
      if not gse.Is_Null( cursor, 94 )then
         a_job.othded6 := gse.Integer_Value( cursor, 94 );
      end if;
      if not gse.Is_Null( cursor, 95 )then
         a_job.othded7 := gse.Integer_Value( cursor, 95 );
      end if;
      if not gse.Is_Null( cursor, 96 )then
         a_job.othded8 := gse.Integer_Value( cursor, 96 );
      end if;
      if not gse.Is_Null( cursor, 97 )then
         a_job.othded9 := gse.Integer_Value( cursor, 97 );
      end if;
      if not gse.Is_Null( cursor, 98 )then
         a_job.ownamt:= Amount'Value( gse.Value( cursor, 98 ));
      end if;
      if not gse.Is_Null( cursor, 99 )then
         a_job.ownotamt:= Amount'Value( gse.Value( cursor, 99 ));
      end if;
      if not gse.Is_Null( cursor, 100 )then
         a_job.ownother := gse.Integer_Value( cursor, 100 );
      end if;
      if not gse.Is_Null( cursor, 101 )then
         a_job.ownsum := gse.Integer_Value( cursor, 101 );
      end if;
      if not gse.Is_Null( cursor, 102 )then
         a_job.payamt:= Amount'Value( gse.Value( cursor, 102 ));
      end if;
      if not gse.Is_Null( cursor, 103 )then
         a_job.paydat := gse.Time_Value( cursor, 103 );
      end if;
      if not gse.Is_Null( cursor, 104 )then
         a_job.paye:= Amount'Value( gse.Value( cursor, 104 ));
      end if;
      if not gse.Is_Null( cursor, 105 )then
         a_job.paypd := gse.Integer_Value( cursor, 105 );
      end if;
      if not gse.Is_Null( cursor, 106 )then
         a_job.payslip := gse.Integer_Value( cursor, 106 );
      end if;
      if not gse.Is_Null( cursor, 107 )then
         a_job.payusl := gse.Integer_Value( cursor, 107 );
      end if;
      if not gse.Is_Null( cursor, 108 )then
         a_job.pothr:= Amount'Value( gse.Value( cursor, 108 ));
      end if;
      if not gse.Is_Null( cursor, 109 )then
         a_job.prbefore:= Amount'Value( gse.Value( cursor, 109 ));
      end if;
      if not gse.Is_Null( cursor, 110 )then
         a_job.profdocs := gse.Integer_Value( cursor, 110 );
      end if;
      if not gse.Is_Null( cursor, 111 )then
         a_job.profit1:= Amount'Value( gse.Value( cursor, 111 ));
      end if;
      if not gse.Is_Null( cursor, 112 )then
         a_job.profit2 := gse.Integer_Value( cursor, 112 );
      end if;
      if not gse.Is_Null( cursor, 113 )then
         a_job.profni := gse.Integer_Value( cursor, 113 );
      end if;
      if not gse.Is_Null( cursor, 114 )then
         a_job.proftax := gse.Integer_Value( cursor, 114 );
      end if;
      if not gse.Is_Null( cursor, 115 )then
         a_job.rspoth := gse.Integer_Value( cursor, 115 );
      end if;
      if not gse.Is_Null( cursor, 116 )then
         a_job.se1 := gse.Time_Value( cursor, 116 );
      end if;
      if not gse.Is_Null( cursor, 117 )then
         a_job.se2 := gse.Time_Value( cursor, 117 );
      end if;
      if not gse.Is_Null( cursor, 118 )then
         a_job.seend := gse.Time_Value( cursor, 118 );
      end if;
      if not gse.Is_Null( cursor, 119 )then
         a_job.seincamt:= Amount'Value( gse.Value( cursor, 119 ));
      end if;
      if not gse.Is_Null( cursor, 120 )then
         a_job.seincwm := gse.Integer_Value( cursor, 120 );
      end if;
      if not gse.Is_Null( cursor, 121 )then
         a_job.selwks := gse.Integer_Value( cursor, 121 );
      end if;
      if not gse.Is_Null( cursor, 122 )then
         a_job.seniiamt:= Amount'Value( gse.Value( cursor, 122 ));
      end if;
      if not gse.Is_Null( cursor, 123 )then
         a_job.seniinc := gse.Integer_Value( cursor, 123 );
      end if;
      if not gse.Is_Null( cursor, 124 )then
         a_job.senilamt:= Amount'Value( gse.Value( cursor, 124 ));
      end if;
      if not gse.Is_Null( cursor, 125 )then
         a_job.senilump := gse.Integer_Value( cursor, 125 );
      end if;
      if not gse.Is_Null( cursor, 126 )then
         a_job.seniramt:= Amount'Value( gse.Value( cursor, 126 ));
      end if;
      if not gse.Is_Null( cursor, 127 )then
         a_job.senireg := gse.Integer_Value( cursor, 127 );
      end if;
      if not gse.Is_Null( cursor, 128 )then
         a_job.senirpd := gse.Integer_Value( cursor, 128 );
      end if;
      if not gse.Is_Null( cursor, 129 )then
         a_job.setax := gse.Integer_Value( cursor, 129 );
      end if;
      if not gse.Is_Null( cursor, 130 )then
         a_job.setaxamt:= Amount'Value( gse.Value( cursor, 130 ));
      end if;
      if not gse.Is_Null( cursor, 131 )then
         a_job.smpamt:= Amount'Value( gse.Value( cursor, 131 ));
      end if;
      if not gse.Is_Null( cursor, 132 )then
         a_job.smprate := gse.Integer_Value( cursor, 132 );
      end if;
      if not gse.Is_Null( cursor, 133 )then
         a_job.sole := gse.Integer_Value( cursor, 133 );
      end if;
      if not gse.Is_Null( cursor, 134 )then
         a_job.sspamt:= Amount'Value( gse.Value( cursor, 134 ));
      end if;
      if not gse.Is_Null( cursor, 135 )then
         a_job.taxamt:= Amount'Value( gse.Value( cursor, 135 ));
      end if;
      if not gse.Is_Null( cursor, 136 )then
         a_job.taxdamt:= Amount'Value( gse.Value( cursor, 136 ));
      end if;
      if not gse.Is_Null( cursor, 137 )then
         a_job.taxdpd := gse.Integer_Value( cursor, 137 );
      end if;
      if not gse.Is_Null( cursor, 138 )then
         a_job.totus1:= Amount'Value( gse.Value( cursor, 138 ));
      end if;
      if not gse.Is_Null( cursor, 139 )then
         a_job.ubonamt:= Amount'Value( gse.Value( cursor, 139 ));
      end if;
      if not gse.Is_Null( cursor, 140 )then
         a_job.uboninc := gse.Integer_Value( cursor, 140 );
      end if;
      if not gse.Is_Null( cursor, 141 )then
         a_job.udeduc1:= Amount'Value( gse.Value( cursor, 141 ));
      end if;
      if not gse.Is_Null( cursor, 142 )then
         a_job.udeduc2:= Amount'Value( gse.Value( cursor, 142 ));
      end if;
      if not gse.Is_Null( cursor, 143 )then
         a_job.udeduc3:= Amount'Value( gse.Value( cursor, 143 ));
      end if;
      if not gse.Is_Null( cursor, 144 )then
         a_job.udeduc4:= Amount'Value( gse.Value( cursor, 144 ));
      end if;
      if not gse.Is_Null( cursor, 145 )then
         a_job.udeduc5:= Amount'Value( gse.Value( cursor, 145 ));
      end if;
      if not gse.Is_Null( cursor, 146 )then
         a_job.udeduc6:= Amount'Value( gse.Value( cursor, 146 ));
      end if;
      if not gse.Is_Null( cursor, 147 )then
         a_job.udeduc7:= Amount'Value( gse.Value( cursor, 147 ));
      end if;
      if not gse.Is_Null( cursor, 148 )then
         a_job.udeduc8:= Amount'Value( gse.Value( cursor, 148 ));
      end if;
      if not gse.Is_Null( cursor, 149 )then
         a_job.ugross:= Amount'Value( gse.Value( cursor, 149 ));
      end if;
      if not gse.Is_Null( cursor, 150 )then
         a_job.uincpay1 := gse.Integer_Value( cursor, 150 );
      end if;
      if not gse.Is_Null( cursor, 151 )then
         a_job.uincpay2 := gse.Integer_Value( cursor, 151 );
      end if;
      if not gse.Is_Null( cursor, 152 )then
         a_job.uincpay3 := gse.Integer_Value( cursor, 152 );
      end if;
      if not gse.Is_Null( cursor, 153 )then
         a_job.uincpay4 := gse.Integer_Value( cursor, 153 );
      end if;
      if not gse.Is_Null( cursor, 154 )then
         a_job.uincpay5 := gse.Integer_Value( cursor, 154 );
      end if;
      if not gse.Is_Null( cursor, 155 )then
         a_job.uincpay6 := gse.Integer_Value( cursor, 155 );
      end if;
      if not gse.Is_Null( cursor, 156 )then
         a_job.umileamt:= Amount'Value( gse.Value( cursor, 156 ));
      end if;
      if not gse.Is_Null( cursor, 157 )then
         a_job.umotamt:= Amount'Value( gse.Value( cursor, 157 ));
      end if;
      if not gse.Is_Null( cursor, 158 )then
         a_job.unett:= Amount'Value( gse.Value( cursor, 158 ));
      end if;
      if not gse.Is_Null( cursor, 159 )then
         a_job.uothded1 := gse.Integer_Value( cursor, 159 );
      end if;
      if not gse.Is_Null( cursor, 160 )then
         a_job.uothded2 := gse.Integer_Value( cursor, 160 );
      end if;
      if not gse.Is_Null( cursor, 161 )then
         a_job.uothded3 := gse.Integer_Value( cursor, 161 );
      end if;
      if not gse.Is_Null( cursor, 162 )then
         a_job.uothded4 := gse.Integer_Value( cursor, 162 );
      end if;
      if not gse.Is_Null( cursor, 163 )then
         a_job.uothded5 := gse.Integer_Value( cursor, 163 );
      end if;
      if not gse.Is_Null( cursor, 164 )then
         a_job.uothded6 := gse.Integer_Value( cursor, 164 );
      end if;
      if not gse.Is_Null( cursor, 165 )then
         a_job.uothded7 := gse.Integer_Value( cursor, 165 );
      end if;
      if not gse.Is_Null( cursor, 166 )then
         a_job.uothded8 := gse.Integer_Value( cursor, 166 );
      end if;
      if not gse.Is_Null( cursor, 167 )then
         a_job.uothded9 := gse.Integer_Value( cursor, 167 );
      end if;
      if not gse.Is_Null( cursor, 168 )then
         a_job.uothdtot:= Amount'Value( gse.Value( cursor, 168 ));
      end if;
      if not gse.Is_Null( cursor, 169 )then
         a_job.uothr:= Amount'Value( gse.Value( cursor, 169 ));
      end if;
      if not gse.Is_Null( cursor, 170 )then
         a_job.upd := gse.Integer_Value( cursor, 170 );
      end if;
      if not gse.Is_Null( cursor, 171 )then
         a_job.usmpamt:= Amount'Value( gse.Value( cursor, 171 ));
      end if;
      if not gse.Is_Null( cursor, 172 )then
         a_job.usmprate := gse.Integer_Value( cursor, 172 );
      end if;
      if not gse.Is_Null( cursor, 173 )then
         a_job.usspamt:= Amount'Value( gse.Value( cursor, 173 ));
      end if;
      if not gse.Is_Null( cursor, 174 )then
         a_job.usuhr:= Amount'Value( gse.Value( cursor, 174 ));
      end if;
      if not gse.Is_Null( cursor, 175 )then
         a_job.utaxamt:= Amount'Value( gse.Value( cursor, 175 ));
      end if;
      if not gse.Is_Null( cursor, 176 )then
         a_job.watdid := gse.Integer_Value( cursor, 176 );
      end if;
      if not gse.Is_Null( cursor, 177 )then
         a_job.watprev := gse.Integer_Value( cursor, 177 );
      end if;
      if not gse.Is_Null( cursor, 178 )then
         a_job.x_where := gse.Integer_Value( cursor, 178 );
      end if;
      if not gse.Is_Null( cursor, 179 )then
         a_job.whynopro := gse.Integer_Value( cursor, 179 );
      end if;
      if not gse.Is_Null( cursor, 180 )then
         a_job.whynou01 := gse.Integer_Value( cursor, 180 );
      end if;
      if not gse.Is_Null( cursor, 181 )then
         a_job.whynou02 := gse.Integer_Value( cursor, 181 );
      end if;
      if not gse.Is_Null( cursor, 182 )then
         a_job.whynou03 := gse.Integer_Value( cursor, 182 );
      end if;
      if not gse.Is_Null( cursor, 183 )then
         a_job.whynou04 := gse.Integer_Value( cursor, 183 );
      end if;
      if not gse.Is_Null( cursor, 184 )then
         a_job.whynou05 := gse.Integer_Value( cursor, 184 );
      end if;
      if not gse.Is_Null( cursor, 185 )then
         a_job.whynou06 := gse.Integer_Value( cursor, 185 );
      end if;
      if not gse.Is_Null( cursor, 186 )then
         a_job.whynou07 := gse.Integer_Value( cursor, 186 );
      end if;
      if not gse.Is_Null( cursor, 187 )then
         a_job.whynou08 := gse.Integer_Value( cursor, 187 );
      end if;
      if not gse.Is_Null( cursor, 188 )then
         a_job.whynou09 := gse.Integer_Value( cursor, 188 );
      end if;
      if not gse.Is_Null( cursor, 189 )then
         a_job.whynou10 := gse.Integer_Value( cursor, 189 );
      end if;
      if not gse.Is_Null( cursor, 190 )then
         a_job.whynou11 := gse.Integer_Value( cursor, 190 );
      end if;
      if not gse.Is_Null( cursor, 191 )then
         a_job.workacc := gse.Integer_Value( cursor, 191 );
      end if;
      if not gse.Is_Null( cursor, 192 )then
         a_job.workmth := gse.Integer_Value( cursor, 192 );
      end if;
      if not gse.Is_Null( cursor, 193 )then
         a_job.workyr := gse.Integer_Value( cursor, 193 );
      end if;
      if not gse.Is_Null( cursor, 194 )then
         a_job.month := gse.Integer_Value( cursor, 194 );
      end if;
      if not gse.Is_Null( cursor, 195 )then
         a_job.hdqhrs := gse.Integer_Value( cursor, 195 );
      end if;
      if not gse.Is_Null( cursor, 196 )then
         a_job.jobhours:= Amount'Value( gse.Value( cursor, 196 ));
      end if;
      if not gse.Is_Null( cursor, 197 )then
         a_job.sspsmpfg := gse.Integer_Value( cursor, 197 );
      end if;
      if not gse.Is_Null( cursor, 198 )then
         a_job.ugrspay:= To_Unbounded_String( gse.Value( cursor, 198 ));
      end if;
      if not gse.Is_Null( cursor, 199 )then
         a_job.inclpay7 := gse.Integer_Value( cursor, 199 );
      end if;
      if not gse.Is_Null( cursor, 200 )then
         a_job.inclpay8 := gse.Integer_Value( cursor, 200 );
      end if;
      if not gse.Is_Null( cursor, 201 )then
         a_job.paperiod := gse.Integer_Value( cursor, 201 );
      end if;
      if not gse.Is_Null( cursor, 202 )then
         a_job.ppperiod := gse.Integer_Value( cursor, 202 );
      end if;
      if not gse.Is_Null( cursor, 203 )then
         a_job.sapamt:= Amount'Value( gse.Value( cursor, 203 ));
      end if;
      if not gse.Is_Null( cursor, 204 )then
         a_job.sppamt:= Amount'Value( gse.Value( cursor, 204 ));
      end if;
      if not gse.Is_Null( cursor, 205 )then
         a_job.uincpay7 := gse.Integer_Value( cursor, 205 );
      end if;
      if not gse.Is_Null( cursor, 206 )then
         a_job.uincpay8 := gse.Integer_Value( cursor, 206 );
      end if;
      if not gse.Is_Null( cursor, 207 )then
         a_job.usapamt := gse.Integer_Value( cursor, 207 );
      end if;
      if not gse.Is_Null( cursor, 208 )then
         a_job.usppamt:= Amount'Value( gse.Value( cursor, 208 ));
      end if;
      if not gse.Is_Null( cursor, 209 )then
         a_job.inkind12 := gse.Integer_Value( cursor, 209 );
      end if;
      if not gse.Is_Null( cursor, 210 )then
         a_job.inkind13 := gse.Integer_Value( cursor, 210 );
      end if;
      if not gse.Is_Null( cursor, 211 )then
         a_job.salsac := gse.Integer_Value( cursor, 211 );
      end if;
      if not gse.Is_Null( cursor, 212 )then
         a_job.chvamt:= Amount'Value( gse.Value( cursor, 212 ));
      end if;
      if not gse.Is_Null( cursor, 213 )then
         a_job.chvpd := gse.Integer_Value( cursor, 213 );
      end if;
      if not gse.Is_Null( cursor, 214 )then
         a_job.chvsac := gse.Integer_Value( cursor, 214 );
      end if;
      if not gse.Is_Null( cursor, 215 )then
         a_job.chvuamt:= Amount'Value( gse.Value( cursor, 215 ));
      end if;
      if not gse.Is_Null( cursor, 216 )then
         a_job.chvupd := gse.Integer_Value( cursor, 216 );
      end if;
      if not gse.Is_Null( cursor, 217 )then
         a_job.chvusu := gse.Integer_Value( cursor, 217 );
      end if;
      if not gse.Is_Null( cursor, 218 )then
         a_job.expben01 := gse.Integer_Value( cursor, 218 );
      end if;
      if not gse.Is_Null( cursor, 219 )then
         a_job.expben02 := gse.Integer_Value( cursor, 219 );
      end if;
      if not gse.Is_Null( cursor, 220 )then
         a_job.expben03 := gse.Integer_Value( cursor, 220 );
      end if;
      if not gse.Is_Null( cursor, 221 )then
         a_job.expben04 := gse.Integer_Value( cursor, 221 );
      end if;
      if not gse.Is_Null( cursor, 222 )then
         a_job.expben05 := gse.Integer_Value( cursor, 222 );
      end if;
      if not gse.Is_Null( cursor, 223 )then
         a_job.expben06 := gse.Integer_Value( cursor, 223 );
      end if;
      if not gse.Is_Null( cursor, 224 )then
         a_job.expben07 := gse.Integer_Value( cursor, 224 );
      end if;
      if not gse.Is_Null( cursor, 225 )then
         a_job.expben08 := gse.Integer_Value( cursor, 225 );
      end if;
      if not gse.Is_Null( cursor, 226 )then
         a_job.expben09 := gse.Integer_Value( cursor, 226 );
      end if;
      if not gse.Is_Null( cursor, 227 )then
         a_job.expben10 := gse.Integer_Value( cursor, 227 );
      end if;
      if not gse.Is_Null( cursor, 228 )then
         a_job.expben11 := gse.Integer_Value( cursor, 228 );
      end if;
      if not gse.Is_Null( cursor, 229 )then
         a_job.expben12 := gse.Integer_Value( cursor, 229 );
      end if;
      if not gse.Is_Null( cursor, 230 )then
         a_job.fuelamt:= Amount'Value( gse.Value( cursor, 230 ));
      end if;
      if not gse.Is_Null( cursor, 231 )then
         a_job.fuelbn := gse.Integer_Value( cursor, 231 );
      end if;
      if not gse.Is_Null( cursor, 232 )then
         a_job.fuelpd := gse.Integer_Value( cursor, 232 );
      end if;
      if not gse.Is_Null( cursor, 233 )then
         a_job.fueluamt:= Amount'Value( gse.Value( cursor, 233 ));
      end if;
      if not gse.Is_Null( cursor, 234 )then
         a_job.fuelupd := gse.Integer_Value( cursor, 234 );
      end if;
      if not gse.Is_Null( cursor, 235 )then
         a_job.fuelusu := gse.Integer_Value( cursor, 235 );
      end if;
      if not gse.Is_Null( cursor, 236 )then
         a_job.issue := gse.Integer_Value( cursor, 236 );
      end if;
      if not gse.Is_Null( cursor, 237 )then
         a_job.prevmth := gse.Integer_Value( cursor, 237 );
      end if;
      if not gse.Is_Null( cursor, 238 )then
         a_job.prevyr := gse.Integer_Value( cursor, 238 );
      end if;
      if not gse.Is_Null( cursor, 239 )then
         a_job.spnamt:= Amount'Value( gse.Value( cursor, 239 ));
      end if;
      if not gse.Is_Null( cursor, 240 )then
         a_job.spnpd := gse.Integer_Value( cursor, 240 );
      end if;
      if not gse.Is_Null( cursor, 241 )then
         a_job.spnsac := gse.Integer_Value( cursor, 241 );
      end if;
      if not gse.Is_Null( cursor, 242 )then
         a_job.spnuamt:= Amount'Value( gse.Value( cursor, 242 ));
      end if;
      if not gse.Is_Null( cursor, 243 )then
         a_job.spnupd := gse.Integer_Value( cursor, 243 );
      end if;
      if not gse.Is_Null( cursor, 244 )then
         a_job.spnusu := gse.Integer_Value( cursor, 244 );
      end if;
      if not gse.Is_Null( cursor, 245 )then
         a_job.vchamt:= Amount'Value( gse.Value( cursor, 245 ));
      end if;
      if not gse.Is_Null( cursor, 246 )then
         a_job.vchpd := gse.Integer_Value( cursor, 246 );
      end if;
      if not gse.Is_Null( cursor, 247 )then
         a_job.vchsac := gse.Integer_Value( cursor, 247 );
      end if;
      if not gse.Is_Null( cursor, 248 )then
         a_job.vchuamt := gse.Integer_Value( cursor, 248 );
      end if;
      if not gse.Is_Null( cursor, 249 )then
         a_job.vchupd := gse.Integer_Value( cursor, 249 );
      end if;
      if not gse.Is_Null( cursor, 250 )then
         a_job.vchusu := gse.Integer_Value( cursor, 250 );
      end if;
      if not gse.Is_Null( cursor, 251 )then
         a_job.wrkprev := gse.Integer_Value( cursor, 251 );
      end if;
      if not gse.Is_Null( cursor, 252 )then
         a_job.caramt:= Amount'Value( gse.Value( cursor, 252 ));
      end if;
      if not gse.Is_Null( cursor, 253 )then
         a_job.carcon := gse.Integer_Value( cursor, 253 );
      end if;
      if not gse.Is_Null( cursor, 254 )then
         a_job.carval := gse.Integer_Value( cursor, 254 );
      end if;
      if not gse.Is_Null( cursor, 255 )then
         a_job.fueltyp := gse.Integer_Value( cursor, 255 );
      end if;
      if not gse.Is_Null( cursor, 256 )then
         a_job.orgemp := gse.Integer_Value( cursor, 256 );
      end if;
      if not gse.Is_Null( cursor, 257 )then
         a_job.sector := gse.Integer_Value( cursor, 257 );
      end if;
      if not gse.Is_Null( cursor, 258 )then
         a_job.sectrnp := gse.Integer_Value( cursor, 258 );
      end if;
      if not gse.Is_Null( cursor, 259 )then
         a_job.whynou12 := gse.Integer_Value( cursor, 259 );
      end if;
      if not gse.Is_Null( cursor, 260 )then
         a_job.whynou13 := gse.Integer_Value( cursor, 260 );
      end if;
      if not gse.Is_Null( cursor, 261 )then
         a_job.whynou14 := gse.Integer_Value( cursor, 261 );
      end if;
      if not gse.Is_Null( cursor, 262 )then
         a_job.jobsect := gse.Integer_Value( cursor, 262 );
      end if;
      if not gse.Is_Null( cursor, 263 )then
         a_job.oremp := gse.Integer_Value( cursor, 263 );
      end if;
      if not gse.Is_Null( cursor, 264 )then
         a_job.bontxam1:= Amount'Value( gse.Value( cursor, 264 ));
      end if;
      if not gse.Is_Null( cursor, 265 )then
         a_job.bontxam2:= Amount'Value( gse.Value( cursor, 265 ));
      end if;
      if not gse.Is_Null( cursor, 266 )then
         a_job.bontxam3:= Amount'Value( gse.Value( cursor, 266 ));
      end if;
      if not gse.Is_Null( cursor, 267 )then
         a_job.bontxam4:= Amount'Value( gse.Value( cursor, 267 ));
      end if;
      if not gse.Is_Null( cursor, 268 )then
         a_job.bontxam5:= Amount'Value( gse.Value( cursor, 268 ));
      end if;
      if not gse.Is_Null( cursor, 269 )then
         a_job.bontxam6:= Amount'Value( gse.Value( cursor, 269 ));
      end if;
      if not gse.Is_Null( cursor, 270 )then
         a_job.deduc9:= Amount'Value( gse.Value( cursor, 270 ));
      end if;
      if not gse.Is_Null( cursor, 271 )then
         a_job.emplany := gse.Integer_Value( cursor, 271 );
      end if;
      if not gse.Is_Null( cursor, 272 )then
         a_job.empten := gse.Integer_Value( cursor, 272 );
      end if;
      if not gse.Is_Null( cursor, 273 )then
         a_job.lthan30 := gse.Integer_Value( cursor, 273 );
      end if;
      if not gse.Is_Null( cursor, 274 )then
         a_job.numeten := gse.Integer_Value( cursor, 274 );
      end if;
      if not gse.Is_Null( cursor, 275 )then
         a_job.othded01 := gse.Integer_Value( cursor, 275 );
      end if;
      if not gse.Is_Null( cursor, 276 )then
         a_job.othded02 := gse.Integer_Value( cursor, 276 );
      end if;
      if not gse.Is_Null( cursor, 277 )then
         a_job.othded03 := gse.Integer_Value( cursor, 277 );
      end if;
      if not gse.Is_Null( cursor, 278 )then
         a_job.othded04 := gse.Integer_Value( cursor, 278 );
      end if;
      if not gse.Is_Null( cursor, 279 )then
         a_job.othded05 := gse.Integer_Value( cursor, 279 );
      end if;
      if not gse.Is_Null( cursor, 280 )then
         a_job.othded06 := gse.Integer_Value( cursor, 280 );
      end if;
      if not gse.Is_Null( cursor, 281 )then
         a_job.othded07 := gse.Integer_Value( cursor, 281 );
      end if;
      if not gse.Is_Null( cursor, 282 )then
         a_job.othded08 := gse.Integer_Value( cursor, 282 );
      end if;
      if not gse.Is_Null( cursor, 283 )then
         a_job.othded09 := gse.Integer_Value( cursor, 283 );
      end if;
      if not gse.Is_Null( cursor, 284 )then
         a_job.othded10 := gse.Integer_Value( cursor, 284 );
      end if;
      if not gse.Is_Null( cursor, 285 )then
         a_job.udeduc9:= Amount'Value( gse.Value( cursor, 285 ));
      end if;
      if not gse.Is_Null( cursor, 286 )then
         a_job.uothde01 := gse.Integer_Value( cursor, 286 );
      end if;
      if not gse.Is_Null( cursor, 287 )then
         a_job.uothde02 := gse.Integer_Value( cursor, 287 );
      end if;
      if not gse.Is_Null( cursor, 288 )then
         a_job.uothde03 := gse.Integer_Value( cursor, 288 );
      end if;
      if not gse.Is_Null( cursor, 289 )then
         a_job.uothde04 := gse.Integer_Value( cursor, 289 );
      end if;
      if not gse.Is_Null( cursor, 290 )then
         a_job.uothde05 := gse.Integer_Value( cursor, 290 );
      end if;
      if not gse.Is_Null( cursor, 291 )then
         a_job.uothde06 := gse.Integer_Value( cursor, 291 );
      end if;
      if not gse.Is_Null( cursor, 292 )then
         a_job.uothde07 := gse.Integer_Value( cursor, 292 );
      end if;
      if not gse.Is_Null( cursor, 293 )then
         a_job.uothde08 := gse.Integer_Value( cursor, 293 );
      end if;
      if not gse.Is_Null( cursor, 294 )then
         a_job.uothde09 := gse.Integer_Value( cursor, 294 );
      end if;
      if not gse.Is_Null( cursor, 295 )then
         a_job.uothde10 := gse.Integer_Value( cursor, 295 );
      end if;
      if not gse.Is_Null( cursor, 296 )then
         a_job.yjbchang := gse.Integer_Value( cursor, 296 );
      end if;
      if not gse.Is_Null( cursor, 297 )then
         a_job.jbchnge := gse.Integer_Value( cursor, 297 );
      end if;
      if not gse.Is_Null( cursor, 298 )then
         a_job.hourly := gse.Integer_Value( cursor, 298 );
      end if;
      if not gse.Is_Null( cursor, 299 )then
         a_job.hrexa := gse.Integer_Value( cursor, 299 );
      end if;
      if not gse.Is_Null( cursor, 300 )then
         a_job.hrexb := gse.Integer_Value( cursor, 300 );
      end if;
      if not gse.Is_Null( cursor, 301 )then
         a_job.hrexc1 := gse.Integer_Value( cursor, 301 );
      end if;
      if not gse.Is_Null( cursor, 302 )then
         a_job.hrexc2 := gse.Integer_Value( cursor, 302 );
      end if;
      if not gse.Is_Null( cursor, 303 )then
         a_job.hrexc3 := gse.Integer_Value( cursor, 303 );
      end if;
      if not gse.Is_Null( cursor, 304 )then
         a_job.hrexc4 := gse.Integer_Value( cursor, 304 );
      end if;
      if not gse.Is_Null( cursor, 305 )then
         a_job.hrexc5 := gse.Integer_Value( cursor, 305 );
      end if;
      if not gse.Is_Null( cursor, 306 )then
         a_job.hrexc6 := gse.Integer_Value( cursor, 306 );
      end if;
      if not gse.Is_Null( cursor, 307 )then
         a_job.hrexc7 := gse.Integer_Value( cursor, 307 );
      end if;
      if not gse.Is_Null( cursor, 308 )then
         a_job.hrexc8 := gse.Integer_Value( cursor, 308 );
      end if;
      if not gse.Is_Null( cursor, 309 )then
         a_job.hrrate:= Amount'Value( gse.Value( cursor, 309 ));
      end if;
      return a_job;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Job_List is
      l : Ukds.Frs.Job_List;
      local_connection : Database_Connection;
      is_local_connection : Boolean;
      query : constant String := DB_Commons.Add_Schema_To_Query( SELECT_PART, SCHEMA_NAME ) 
         & " " & sqlstr;
      cursor   : gse.Forward_Cursor;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      Log( "retrieve made this as query " & query );
      cursor.Fetch( local_connection, query );
      Check_Result( local_connection );
      while gse.Has_Row( cursor ) loop
         declare
            a_job : Ukds.Frs.Job := Map_From_Cursor( cursor );
         begin
            l.append( a_job ); 
         end;
         gse.Next( cursor );
      end loop;
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return l;
   end Retrieve;

   
   --
   -- Update the given record 
   -- otherwise throws DB_Exception exception. 
   --

   UPDATE_PS : constant gse.Prepared_Statement := Get_Prepared_Update_Statement;
   
   procedure Update( a_job : Ukds.Frs.Job; connection : Database_Connection := null ) is
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params( Update_Order => True );
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_ugrspay : aliased String := To_String( a_job.ugrspay );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;

      params( 1 ) := "+"( Integer'Pos( a_job.agreehrs ));
      params( 2 ) := "+"( Float( a_job.bonamt1 ));
      params( 3 ) := "+"( Float( a_job.bonamt2 ));
      params( 4 ) := "+"( Float( a_job.bonamt3 ));
      params( 5 ) := "+"( Float( a_job.bonamt4 ));
      params( 6 ) := "+"( Float( a_job.bonamt5 ));
      params( 7 ) := "+"( Float( a_job.bonamt6 ));
      params( 8 ) := "+"( Integer'Pos( a_job.bontax1 ));
      params( 9 ) := "+"( Integer'Pos( a_job.bontax2 ));
      params( 10 ) := "+"( Integer'Pos( a_job.bontax3 ));
      params( 11 ) := "+"( Integer'Pos( a_job.bontax4 ));
      params( 12 ) := "+"( Integer'Pos( a_job.bontax5 ));
      params( 13 ) := "+"( Integer'Pos( a_job.bontax6 ));
      params( 14 ) := "+"( Integer'Pos( a_job.bonus ));
      params( 15 ) := "+"( Integer'Pos( a_job.busaccts ));
      params( 16 ) := "+"( Integer'Pos( a_job.checktax ));
      params( 17 ) := "+"( Integer'Pos( a_job.chkincom ));
      params( 18 ) := "+"( Float( a_job.dedoth ));
      params( 19 ) := "+"( Float( a_job.deduc1 ));
      params( 20 ) := "+"( Float( a_job.deduc2 ));
      params( 21 ) := "+"( Float( a_job.deduc3 ));
      params( 22 ) := "+"( Float( a_job.deduc4 ));
      params( 23 ) := "+"( Float( a_job.deduc5 ));
      params( 24 ) := "+"( Float( a_job.deduc6 ));
      params( 25 ) := "+"( Float( a_job.deduc7 ));
      params( 26 ) := "+"( Float( a_job.deduc8 ));
      params( 27 ) := "+"( Integer'Pos( a_job.dirctr ));
      params( 28 ) := "+"( Integer'Pos( a_job.dirni ));
      params( 29 ) := "+"( Integer'Pos( a_job.dvtothru ));
      params( 30 ) := "+"( Float( a_job.dvushr ));
      params( 31 ) := "+"( Integer'Pos( a_job.empany ));
      params( 32 ) := "+"( Integer'Pos( a_job.empown ));
      params( 33 ) := "+"( Integer'Pos( a_job.etype ));
      params( 34 ) := "+"( Integer'Pos( a_job.everot ));
      params( 35 ) := "+"( Integer'Pos( a_job.ftpt ));
      params( 36 ) := "+"( Float( a_job.grsofar ));
      params( 37 ) := "+"( Float( a_job.grwage ));
      params( 38 ) := "+"( Integer'Pos( a_job.grwagpd ));
      params( 39 ) := "+"( Float( a_job.hha1 ));
      params( 40 ) := "+"( Float( a_job.hha2 ));
      params( 41 ) := "+"( Float( a_job.hha3 ));
      params( 42 ) := "+"( Integer'Pos( a_job.hhc1 ));
      params( 43 ) := "+"( Integer'Pos( a_job.hhc2 ));
      params( 44 ) := "+"( Integer'Pos( a_job.hhc3 ));
      params( 45 ) := "+"( Integer'Pos( a_job.hohinc ));
      params( 46 ) := "+"( Integer'Pos( a_job.inclpay1 ));
      params( 47 ) := "+"( Integer'Pos( a_job.inclpay2 ));
      params( 48 ) := "+"( Integer'Pos( a_job.inclpay3 ));
      params( 49 ) := "+"( Integer'Pos( a_job.inclpay4 ));
      params( 50 ) := "+"( Integer'Pos( a_job.inclpay5 ));
      params( 51 ) := "+"( Integer'Pos( a_job.inclpay6 ));
      params( 52 ) := "+"( Integer'Pos( a_job.inkind01 ));
      params( 53 ) := "+"( Integer'Pos( a_job.inkind02 ));
      params( 54 ) := "+"( Integer'Pos( a_job.inkind03 ));
      params( 55 ) := "+"( Integer'Pos( a_job.inkind04 ));
      params( 56 ) := "+"( Integer'Pos( a_job.inkind05 ));
      params( 57 ) := "+"( Integer'Pos( a_job.inkind06 ));
      params( 58 ) := "+"( Integer'Pos( a_job.inkind07 ));
      params( 59 ) := "+"( Integer'Pos( a_job.inkind08 ));
      params( 60 ) := "+"( Integer'Pos( a_job.inkind09 ));
      params( 61 ) := "+"( Integer'Pos( a_job.inkind10 ));
      params( 62 ) := "+"( Integer'Pos( a_job.inkind11 ));
      params( 63 ) := "+"( Integer'Pos( a_job.instype1 ));
      params( 64 ) := "+"( Integer'Pos( a_job.instype2 ));
      params( 65 ) := "+"( Integer'Pos( a_job.jobbus ));
      params( 66 ) := "+"( Integer'Pos( a_job.likehr ));
      params( 67 ) := "+"( Integer'Pos( a_job.mademp ));
      params( 68 ) := "+"( Integer'Pos( a_job.matemp ));
      params( 69 ) := "+"( Integer'Pos( a_job.matstp ));
      params( 70 ) := "+"( Float( a_job.mileamt ));
      params( 71 ) := "+"( Float( a_job.motamt ));
      params( 72 ) := "+"( Float( a_job.natins ));
      params( 73 ) := "+"( Integer'Pos( a_job.nature ));
      params( 74 ) := "+"( Float( a_job.nidamt ));
      params( 75 ) := "+"( Integer'Pos( a_job.nidpd ));
      params( 76 ) := "+"( Integer'Pos( a_job.nmchc ));
      params( 77 ) := "+"( Integer'Pos( a_job.nmper ));
      params( 78 ) := "+"( Integer'Pos( a_job.nomor1 ));
      params( 79 ) := "+"( Integer'Pos( a_job.nomor2 ));
      params( 80 ) := "+"( Integer'Pos( a_job.nomor3 ));
      params( 81 ) := "+"( Integer'Pos( a_job.numemp ));
      params( 82 ) := "+"( Integer'Pos( a_job.othded1 ));
      params( 83 ) := "+"( Integer'Pos( a_job.othded2 ));
      params( 84 ) := "+"( Integer'Pos( a_job.othded3 ));
      params( 85 ) := "+"( Integer'Pos( a_job.othded4 ));
      params( 86 ) := "+"( Integer'Pos( a_job.othded5 ));
      params( 87 ) := "+"( Integer'Pos( a_job.othded6 ));
      params( 88 ) := "+"( Integer'Pos( a_job.othded7 ));
      params( 89 ) := "+"( Integer'Pos( a_job.othded8 ));
      params( 90 ) := "+"( Integer'Pos( a_job.othded9 ));
      params( 91 ) := "+"( Float( a_job.ownamt ));
      params( 92 ) := "+"( Float( a_job.ownotamt ));
      params( 93 ) := "+"( Integer'Pos( a_job.ownother ));
      params( 94 ) := "+"( Integer'Pos( a_job.ownsum ));
      params( 95 ) := "+"( Float( a_job.payamt ));
      params( 96 ) := "+"( a_job.paydat );
      params( 97 ) := "+"( Float( a_job.paye ));
      params( 98 ) := "+"( Integer'Pos( a_job.paypd ));
      params( 99 ) := "+"( Integer'Pos( a_job.payslip ));
      params( 100 ) := "+"( Integer'Pos( a_job.payusl ));
      params( 101 ) := "+"( Float( a_job.pothr ));
      params( 102 ) := "+"( Float( a_job.prbefore ));
      params( 103 ) := "+"( Integer'Pos( a_job.profdocs ));
      params( 104 ) := "+"( Float( a_job.profit1 ));
      params( 105 ) := "+"( Integer'Pos( a_job.profit2 ));
      params( 106 ) := "+"( Integer'Pos( a_job.profni ));
      params( 107 ) := "+"( Integer'Pos( a_job.proftax ));
      params( 108 ) := "+"( Integer'Pos( a_job.rspoth ));
      params( 109 ) := "+"( a_job.se1 );
      params( 110 ) := "+"( a_job.se2 );
      params( 111 ) := "+"( a_job.seend );
      params( 112 ) := "+"( Float( a_job.seincamt ));
      params( 113 ) := "+"( Integer'Pos( a_job.seincwm ));
      params( 114 ) := "+"( Integer'Pos( a_job.selwks ));
      params( 115 ) := "+"( Float( a_job.seniiamt ));
      params( 116 ) := "+"( Integer'Pos( a_job.seniinc ));
      params( 117 ) := "+"( Float( a_job.senilamt ));
      params( 118 ) := "+"( Integer'Pos( a_job.senilump ));
      params( 119 ) := "+"( Float( a_job.seniramt ));
      params( 120 ) := "+"( Integer'Pos( a_job.senireg ));
      params( 121 ) := "+"( Integer'Pos( a_job.senirpd ));
      params( 122 ) := "+"( Integer'Pos( a_job.setax ));
      params( 123 ) := "+"( Float( a_job.setaxamt ));
      params( 124 ) := "+"( Float( a_job.smpamt ));
      params( 125 ) := "+"( Integer'Pos( a_job.smprate ));
      params( 126 ) := "+"( Integer'Pos( a_job.sole ));
      params( 127 ) := "+"( Float( a_job.sspamt ));
      params( 128 ) := "+"( Float( a_job.taxamt ));
      params( 129 ) := "+"( Float( a_job.taxdamt ));
      params( 130 ) := "+"( Integer'Pos( a_job.taxdpd ));
      params( 131 ) := "+"( Float( a_job.totus1 ));
      params( 132 ) := "+"( Float( a_job.ubonamt ));
      params( 133 ) := "+"( Integer'Pos( a_job.uboninc ));
      params( 134 ) := "+"( Float( a_job.udeduc1 ));
      params( 135 ) := "+"( Float( a_job.udeduc2 ));
      params( 136 ) := "+"( Float( a_job.udeduc3 ));
      params( 137 ) := "+"( Float( a_job.udeduc4 ));
      params( 138 ) := "+"( Float( a_job.udeduc5 ));
      params( 139 ) := "+"( Float( a_job.udeduc6 ));
      params( 140 ) := "+"( Float( a_job.udeduc7 ));
      params( 141 ) := "+"( Float( a_job.udeduc8 ));
      params( 142 ) := "+"( Float( a_job.ugross ));
      params( 143 ) := "+"( Integer'Pos( a_job.uincpay1 ));
      params( 144 ) := "+"( Integer'Pos( a_job.uincpay2 ));
      params( 145 ) := "+"( Integer'Pos( a_job.uincpay3 ));
      params( 146 ) := "+"( Integer'Pos( a_job.uincpay4 ));
      params( 147 ) := "+"( Integer'Pos( a_job.uincpay5 ));
      params( 148 ) := "+"( Integer'Pos( a_job.uincpay6 ));
      params( 149 ) := "+"( Float( a_job.umileamt ));
      params( 150 ) := "+"( Float( a_job.umotamt ));
      params( 151 ) := "+"( Float( a_job.unett ));
      params( 152 ) := "+"( Integer'Pos( a_job.uothded1 ));
      params( 153 ) := "+"( Integer'Pos( a_job.uothded2 ));
      params( 154 ) := "+"( Integer'Pos( a_job.uothded3 ));
      params( 155 ) := "+"( Integer'Pos( a_job.uothded4 ));
      params( 156 ) := "+"( Integer'Pos( a_job.uothded5 ));
      params( 157 ) := "+"( Integer'Pos( a_job.uothded6 ));
      params( 158 ) := "+"( Integer'Pos( a_job.uothded7 ));
      params( 159 ) := "+"( Integer'Pos( a_job.uothded8 ));
      params( 160 ) := "+"( Integer'Pos( a_job.uothded9 ));
      params( 161 ) := "+"( Float( a_job.uothdtot ));
      params( 162 ) := "+"( Float( a_job.uothr ));
      params( 163 ) := "+"( Integer'Pos( a_job.upd ));
      params( 164 ) := "+"( Float( a_job.usmpamt ));
      params( 165 ) := "+"( Integer'Pos( a_job.usmprate ));
      params( 166 ) := "+"( Float( a_job.usspamt ));
      params( 167 ) := "+"( Float( a_job.usuhr ));
      params( 168 ) := "+"( Float( a_job.utaxamt ));
      params( 169 ) := "+"( Integer'Pos( a_job.watdid ));
      params( 170 ) := "+"( Integer'Pos( a_job.watprev ));
      params( 171 ) := "+"( Integer'Pos( a_job.x_where ));
      params( 172 ) := "+"( Integer'Pos( a_job.whynopro ));
      params( 173 ) := "+"( Integer'Pos( a_job.whynou01 ));
      params( 174 ) := "+"( Integer'Pos( a_job.whynou02 ));
      params( 175 ) := "+"( Integer'Pos( a_job.whynou03 ));
      params( 176 ) := "+"( Integer'Pos( a_job.whynou04 ));
      params( 177 ) := "+"( Integer'Pos( a_job.whynou05 ));
      params( 178 ) := "+"( Integer'Pos( a_job.whynou06 ));
      params( 179 ) := "+"( Integer'Pos( a_job.whynou07 ));
      params( 180 ) := "+"( Integer'Pos( a_job.whynou08 ));
      params( 181 ) := "+"( Integer'Pos( a_job.whynou09 ));
      params( 182 ) := "+"( Integer'Pos( a_job.whynou10 ));
      params( 183 ) := "+"( Integer'Pos( a_job.whynou11 ));
      params( 184 ) := "+"( Integer'Pos( a_job.workacc ));
      params( 185 ) := "+"( Integer'Pos( a_job.workmth ));
      params( 186 ) := "+"( Integer'Pos( a_job.workyr ));
      params( 187 ) := "+"( Integer'Pos( a_job.month ));
      params( 188 ) := "+"( Integer'Pos( a_job.hdqhrs ));
      params( 189 ) := "+"( Float( a_job.jobhours ));
      params( 190 ) := "+"( Integer'Pos( a_job.sspsmpfg ));
      params( 191 ) := "+"( aliased_ugrspay'Access );
      params( 192 ) := "+"( Integer'Pos( a_job.inclpay7 ));
      params( 193 ) := "+"( Integer'Pos( a_job.inclpay8 ));
      params( 194 ) := "+"( Integer'Pos( a_job.paperiod ));
      params( 195 ) := "+"( Integer'Pos( a_job.ppperiod ));
      params( 196 ) := "+"( Float( a_job.sapamt ));
      params( 197 ) := "+"( Float( a_job.sppamt ));
      params( 198 ) := "+"( Integer'Pos( a_job.uincpay7 ));
      params( 199 ) := "+"( Integer'Pos( a_job.uincpay8 ));
      params( 200 ) := "+"( Integer'Pos( a_job.usapamt ));
      params( 201 ) := "+"( Float( a_job.usppamt ));
      params( 202 ) := "+"( Integer'Pos( a_job.inkind12 ));
      params( 203 ) := "+"( Integer'Pos( a_job.inkind13 ));
      params( 204 ) := "+"( Integer'Pos( a_job.salsac ));
      params( 205 ) := "+"( Float( a_job.chvamt ));
      params( 206 ) := "+"( Integer'Pos( a_job.chvpd ));
      params( 207 ) := "+"( Integer'Pos( a_job.chvsac ));
      params( 208 ) := "+"( Float( a_job.chvuamt ));
      params( 209 ) := "+"( Integer'Pos( a_job.chvupd ));
      params( 210 ) := "+"( Integer'Pos( a_job.chvusu ));
      params( 211 ) := "+"( Integer'Pos( a_job.expben01 ));
      params( 212 ) := "+"( Integer'Pos( a_job.expben02 ));
      params( 213 ) := "+"( Integer'Pos( a_job.expben03 ));
      params( 214 ) := "+"( Integer'Pos( a_job.expben04 ));
      params( 215 ) := "+"( Integer'Pos( a_job.expben05 ));
      params( 216 ) := "+"( Integer'Pos( a_job.expben06 ));
      params( 217 ) := "+"( Integer'Pos( a_job.expben07 ));
      params( 218 ) := "+"( Integer'Pos( a_job.expben08 ));
      params( 219 ) := "+"( Integer'Pos( a_job.expben09 ));
      params( 220 ) := "+"( Integer'Pos( a_job.expben10 ));
      params( 221 ) := "+"( Integer'Pos( a_job.expben11 ));
      params( 222 ) := "+"( Integer'Pos( a_job.expben12 ));
      params( 223 ) := "+"( Float( a_job.fuelamt ));
      params( 224 ) := "+"( Integer'Pos( a_job.fuelbn ));
      params( 225 ) := "+"( Integer'Pos( a_job.fuelpd ));
      params( 226 ) := "+"( Float( a_job.fueluamt ));
      params( 227 ) := "+"( Integer'Pos( a_job.fuelupd ));
      params( 228 ) := "+"( Integer'Pos( a_job.fuelusu ));
      params( 229 ) := "+"( Integer'Pos( a_job.issue ));
      params( 230 ) := "+"( Integer'Pos( a_job.prevmth ));
      params( 231 ) := "+"( Integer'Pos( a_job.prevyr ));
      params( 232 ) := "+"( Float( a_job.spnamt ));
      params( 233 ) := "+"( Integer'Pos( a_job.spnpd ));
      params( 234 ) := "+"( Integer'Pos( a_job.spnsac ));
      params( 235 ) := "+"( Float( a_job.spnuamt ));
      params( 236 ) := "+"( Integer'Pos( a_job.spnupd ));
      params( 237 ) := "+"( Integer'Pos( a_job.spnusu ));
      params( 238 ) := "+"( Float( a_job.vchamt ));
      params( 239 ) := "+"( Integer'Pos( a_job.vchpd ));
      params( 240 ) := "+"( Integer'Pos( a_job.vchsac ));
      params( 241 ) := "+"( Integer'Pos( a_job.vchuamt ));
      params( 242 ) := "+"( Integer'Pos( a_job.vchupd ));
      params( 243 ) := "+"( Integer'Pos( a_job.vchusu ));
      params( 244 ) := "+"( Integer'Pos( a_job.wrkprev ));
      params( 245 ) := "+"( Float( a_job.caramt ));
      params( 246 ) := "+"( Integer'Pos( a_job.carcon ));
      params( 247 ) := "+"( Integer'Pos( a_job.carval ));
      params( 248 ) := "+"( Integer'Pos( a_job.fueltyp ));
      params( 249 ) := "+"( Integer'Pos( a_job.orgemp ));
      params( 250 ) := "+"( Integer'Pos( a_job.sector ));
      params( 251 ) := "+"( Integer'Pos( a_job.sectrnp ));
      params( 252 ) := "+"( Integer'Pos( a_job.whynou12 ));
      params( 253 ) := "+"( Integer'Pos( a_job.whynou13 ));
      params( 254 ) := "+"( Integer'Pos( a_job.whynou14 ));
      params( 255 ) := "+"( Integer'Pos( a_job.jobsect ));
      params( 256 ) := "+"( Integer'Pos( a_job.oremp ));
      params( 257 ) := "+"( Float( a_job.bontxam1 ));
      params( 258 ) := "+"( Float( a_job.bontxam2 ));
      params( 259 ) := "+"( Float( a_job.bontxam3 ));
      params( 260 ) := "+"( Float( a_job.bontxam4 ));
      params( 261 ) := "+"( Float( a_job.bontxam5 ));
      params( 262 ) := "+"( Float( a_job.bontxam6 ));
      params( 263 ) := "+"( Float( a_job.deduc9 ));
      params( 264 ) := "+"( Integer'Pos( a_job.emplany ));
      params( 265 ) := "+"( Integer'Pos( a_job.empten ));
      params( 266 ) := "+"( Integer'Pos( a_job.lthan30 ));
      params( 267 ) := "+"( Integer'Pos( a_job.numeten ));
      params( 268 ) := "+"( Integer'Pos( a_job.othded01 ));
      params( 269 ) := "+"( Integer'Pos( a_job.othded02 ));
      params( 270 ) := "+"( Integer'Pos( a_job.othded03 ));
      params( 271 ) := "+"( Integer'Pos( a_job.othded04 ));
      params( 272 ) := "+"( Integer'Pos( a_job.othded05 ));
      params( 273 ) := "+"( Integer'Pos( a_job.othded06 ));
      params( 274 ) := "+"( Integer'Pos( a_job.othded07 ));
      params( 275 ) := "+"( Integer'Pos( a_job.othded08 ));
      params( 276 ) := "+"( Integer'Pos( a_job.othded09 ));
      params( 277 ) := "+"( Integer'Pos( a_job.othded10 ));
      params( 278 ) := "+"( Float( a_job.udeduc9 ));
      params( 279 ) := "+"( Integer'Pos( a_job.uothde01 ));
      params( 280 ) := "+"( Integer'Pos( a_job.uothde02 ));
      params( 281 ) := "+"( Integer'Pos( a_job.uothde03 ));
      params( 282 ) := "+"( Integer'Pos( a_job.uothde04 ));
      params( 283 ) := "+"( Integer'Pos( a_job.uothde05 ));
      params( 284 ) := "+"( Integer'Pos( a_job.uothde06 ));
      params( 285 ) := "+"( Integer'Pos( a_job.uothde07 ));
      params( 286 ) := "+"( Integer'Pos( a_job.uothde08 ));
      params( 287 ) := "+"( Integer'Pos( a_job.uothde09 ));
      params( 288 ) := "+"( Integer'Pos( a_job.uothde10 ));
      params( 289 ) := "+"( Integer'Pos( a_job.yjbchang ));
      params( 290 ) := "+"( Integer'Pos( a_job.jbchnge ));
      params( 291 ) := "+"( Integer'Pos( a_job.hourly ));
      params( 292 ) := "+"( Integer'Pos( a_job.hrexa ));
      params( 293 ) := "+"( Integer'Pos( a_job.hrexb ));
      params( 294 ) := "+"( Integer'Pos( a_job.hrexc1 ));
      params( 295 ) := "+"( Integer'Pos( a_job.hrexc2 ));
      params( 296 ) := "+"( Integer'Pos( a_job.hrexc3 ));
      params( 297 ) := "+"( Integer'Pos( a_job.hrexc4 ));
      params( 298 ) := "+"( Integer'Pos( a_job.hrexc5 ));
      params( 299 ) := "+"( Integer'Pos( a_job.hrexc6 ));
      params( 300 ) := "+"( Integer'Pos( a_job.hrexc7 ));
      params( 301 ) := "+"( Integer'Pos( a_job.hrexc8 ));
      params( 302 ) := "+"( Float( a_job.hrrate ));
      params( 303 ) := "+"( Integer'Pos( a_job.user_id ));
      params( 304 ) := "+"( Integer'Pos( a_job.edition ));
      params( 305 ) := "+"( Integer'Pos( a_job.year ));
      params( 306 ) := "+"( Integer'Pos( a_job.counter ));
      params( 307 ) := As_Bigint( a_job.sernum );
      params( 308 ) := "+"( Integer'Pos( a_job.benunit ));
      params( 309 ) := "+"( Integer'Pos( a_job.person ));
      params( 310 ) := "+"( Integer'Pos( a_job.jobtype ));
      
      gse.Execute( local_connection, UPDATE_PS, params );
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Update;


   --
   -- Save the compelete given record 
   -- otherwise throws DB_Exception exception. 
   --
   SAVE_PS : constant gse.Prepared_Statement := Get_Prepared_Insert_Statement;      

   procedure Save( a_job : Ukds.Frs.Job; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params;
      local_connection    : Database_Connection;
      is_local_connection : Boolean;
      aliased_ugrspay : aliased String := To_String( a_job.ugrspay );
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      if overwrite and Exists( a_job.user_id, a_job.edition, a_job.year, a_job.counter, a_job.sernum, a_job.benunit, a_job.person, a_job.jobtype ) then
         Update( a_job, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_job.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_job.edition ));
      params( 3 ) := "+"( Integer'Pos( a_job.year ));
      params( 4 ) := "+"( Integer'Pos( a_job.counter ));
      params( 5 ) := As_Bigint( a_job.sernum );
      params( 6 ) := "+"( Integer'Pos( a_job.benunit ));
      params( 7 ) := "+"( Integer'Pos( a_job.person ));
      params( 8 ) := "+"( Integer'Pos( a_job.jobtype ));
      params( 9 ) := "+"( Integer'Pos( a_job.agreehrs ));
      params( 10 ) := "+"( Float( a_job.bonamt1 ));
      params( 11 ) := "+"( Float( a_job.bonamt2 ));
      params( 12 ) := "+"( Float( a_job.bonamt3 ));
      params( 13 ) := "+"( Float( a_job.bonamt4 ));
      params( 14 ) := "+"( Float( a_job.bonamt5 ));
      params( 15 ) := "+"( Float( a_job.bonamt6 ));
      params( 16 ) := "+"( Integer'Pos( a_job.bontax1 ));
      params( 17 ) := "+"( Integer'Pos( a_job.bontax2 ));
      params( 18 ) := "+"( Integer'Pos( a_job.bontax3 ));
      params( 19 ) := "+"( Integer'Pos( a_job.bontax4 ));
      params( 20 ) := "+"( Integer'Pos( a_job.bontax5 ));
      params( 21 ) := "+"( Integer'Pos( a_job.bontax6 ));
      params( 22 ) := "+"( Integer'Pos( a_job.bonus ));
      params( 23 ) := "+"( Integer'Pos( a_job.busaccts ));
      params( 24 ) := "+"( Integer'Pos( a_job.checktax ));
      params( 25 ) := "+"( Integer'Pos( a_job.chkincom ));
      params( 26 ) := "+"( Float( a_job.dedoth ));
      params( 27 ) := "+"( Float( a_job.deduc1 ));
      params( 28 ) := "+"( Float( a_job.deduc2 ));
      params( 29 ) := "+"( Float( a_job.deduc3 ));
      params( 30 ) := "+"( Float( a_job.deduc4 ));
      params( 31 ) := "+"( Float( a_job.deduc5 ));
      params( 32 ) := "+"( Float( a_job.deduc6 ));
      params( 33 ) := "+"( Float( a_job.deduc7 ));
      params( 34 ) := "+"( Float( a_job.deduc8 ));
      params( 35 ) := "+"( Integer'Pos( a_job.dirctr ));
      params( 36 ) := "+"( Integer'Pos( a_job.dirni ));
      params( 37 ) := "+"( Integer'Pos( a_job.dvtothru ));
      params( 38 ) := "+"( Float( a_job.dvushr ));
      params( 39 ) := "+"( Integer'Pos( a_job.empany ));
      params( 40 ) := "+"( Integer'Pos( a_job.empown ));
      params( 41 ) := "+"( Integer'Pos( a_job.etype ));
      params( 42 ) := "+"( Integer'Pos( a_job.everot ));
      params( 43 ) := "+"( Integer'Pos( a_job.ftpt ));
      params( 44 ) := "+"( Float( a_job.grsofar ));
      params( 45 ) := "+"( Float( a_job.grwage ));
      params( 46 ) := "+"( Integer'Pos( a_job.grwagpd ));
      params( 47 ) := "+"( Float( a_job.hha1 ));
      params( 48 ) := "+"( Float( a_job.hha2 ));
      params( 49 ) := "+"( Float( a_job.hha3 ));
      params( 50 ) := "+"( Integer'Pos( a_job.hhc1 ));
      params( 51 ) := "+"( Integer'Pos( a_job.hhc2 ));
      params( 52 ) := "+"( Integer'Pos( a_job.hhc3 ));
      params( 53 ) := "+"( Integer'Pos( a_job.hohinc ));
      params( 54 ) := "+"( Integer'Pos( a_job.inclpay1 ));
      params( 55 ) := "+"( Integer'Pos( a_job.inclpay2 ));
      params( 56 ) := "+"( Integer'Pos( a_job.inclpay3 ));
      params( 57 ) := "+"( Integer'Pos( a_job.inclpay4 ));
      params( 58 ) := "+"( Integer'Pos( a_job.inclpay5 ));
      params( 59 ) := "+"( Integer'Pos( a_job.inclpay6 ));
      params( 60 ) := "+"( Integer'Pos( a_job.inkind01 ));
      params( 61 ) := "+"( Integer'Pos( a_job.inkind02 ));
      params( 62 ) := "+"( Integer'Pos( a_job.inkind03 ));
      params( 63 ) := "+"( Integer'Pos( a_job.inkind04 ));
      params( 64 ) := "+"( Integer'Pos( a_job.inkind05 ));
      params( 65 ) := "+"( Integer'Pos( a_job.inkind06 ));
      params( 66 ) := "+"( Integer'Pos( a_job.inkind07 ));
      params( 67 ) := "+"( Integer'Pos( a_job.inkind08 ));
      params( 68 ) := "+"( Integer'Pos( a_job.inkind09 ));
      params( 69 ) := "+"( Integer'Pos( a_job.inkind10 ));
      params( 70 ) := "+"( Integer'Pos( a_job.inkind11 ));
      params( 71 ) := "+"( Integer'Pos( a_job.instype1 ));
      params( 72 ) := "+"( Integer'Pos( a_job.instype2 ));
      params( 73 ) := "+"( Integer'Pos( a_job.jobbus ));
      params( 74 ) := "+"( Integer'Pos( a_job.likehr ));
      params( 75 ) := "+"( Integer'Pos( a_job.mademp ));
      params( 76 ) := "+"( Integer'Pos( a_job.matemp ));
      params( 77 ) := "+"( Integer'Pos( a_job.matstp ));
      params( 78 ) := "+"( Float( a_job.mileamt ));
      params( 79 ) := "+"( Float( a_job.motamt ));
      params( 80 ) := "+"( Float( a_job.natins ));
      params( 81 ) := "+"( Integer'Pos( a_job.nature ));
      params( 82 ) := "+"( Float( a_job.nidamt ));
      params( 83 ) := "+"( Integer'Pos( a_job.nidpd ));
      params( 84 ) := "+"( Integer'Pos( a_job.nmchc ));
      params( 85 ) := "+"( Integer'Pos( a_job.nmper ));
      params( 86 ) := "+"( Integer'Pos( a_job.nomor1 ));
      params( 87 ) := "+"( Integer'Pos( a_job.nomor2 ));
      params( 88 ) := "+"( Integer'Pos( a_job.nomor3 ));
      params( 89 ) := "+"( Integer'Pos( a_job.numemp ));
      params( 90 ) := "+"( Integer'Pos( a_job.othded1 ));
      params( 91 ) := "+"( Integer'Pos( a_job.othded2 ));
      params( 92 ) := "+"( Integer'Pos( a_job.othded3 ));
      params( 93 ) := "+"( Integer'Pos( a_job.othded4 ));
      params( 94 ) := "+"( Integer'Pos( a_job.othded5 ));
      params( 95 ) := "+"( Integer'Pos( a_job.othded6 ));
      params( 96 ) := "+"( Integer'Pos( a_job.othded7 ));
      params( 97 ) := "+"( Integer'Pos( a_job.othded8 ));
      params( 98 ) := "+"( Integer'Pos( a_job.othded9 ));
      params( 99 ) := "+"( Float( a_job.ownamt ));
      params( 100 ) := "+"( Float( a_job.ownotamt ));
      params( 101 ) := "+"( Integer'Pos( a_job.ownother ));
      params( 102 ) := "+"( Integer'Pos( a_job.ownsum ));
      params( 103 ) := "+"( Float( a_job.payamt ));
      params( 104 ) := "+"( a_job.paydat );
      params( 105 ) := "+"( Float( a_job.paye ));
      params( 106 ) := "+"( Integer'Pos( a_job.paypd ));
      params( 107 ) := "+"( Integer'Pos( a_job.payslip ));
      params( 108 ) := "+"( Integer'Pos( a_job.payusl ));
      params( 109 ) := "+"( Float( a_job.pothr ));
      params( 110 ) := "+"( Float( a_job.prbefore ));
      params( 111 ) := "+"( Integer'Pos( a_job.profdocs ));
      params( 112 ) := "+"( Float( a_job.profit1 ));
      params( 113 ) := "+"( Integer'Pos( a_job.profit2 ));
      params( 114 ) := "+"( Integer'Pos( a_job.profni ));
      params( 115 ) := "+"( Integer'Pos( a_job.proftax ));
      params( 116 ) := "+"( Integer'Pos( a_job.rspoth ));
      params( 117 ) := "+"( a_job.se1 );
      params( 118 ) := "+"( a_job.se2 );
      params( 119 ) := "+"( a_job.seend );
      params( 120 ) := "+"( Float( a_job.seincamt ));
      params( 121 ) := "+"( Integer'Pos( a_job.seincwm ));
      params( 122 ) := "+"( Integer'Pos( a_job.selwks ));
      params( 123 ) := "+"( Float( a_job.seniiamt ));
      params( 124 ) := "+"( Integer'Pos( a_job.seniinc ));
      params( 125 ) := "+"( Float( a_job.senilamt ));
      params( 126 ) := "+"( Integer'Pos( a_job.senilump ));
      params( 127 ) := "+"( Float( a_job.seniramt ));
      params( 128 ) := "+"( Integer'Pos( a_job.senireg ));
      params( 129 ) := "+"( Integer'Pos( a_job.senirpd ));
      params( 130 ) := "+"( Integer'Pos( a_job.setax ));
      params( 131 ) := "+"( Float( a_job.setaxamt ));
      params( 132 ) := "+"( Float( a_job.smpamt ));
      params( 133 ) := "+"( Integer'Pos( a_job.smprate ));
      params( 134 ) := "+"( Integer'Pos( a_job.sole ));
      params( 135 ) := "+"( Float( a_job.sspamt ));
      params( 136 ) := "+"( Float( a_job.taxamt ));
      params( 137 ) := "+"( Float( a_job.taxdamt ));
      params( 138 ) := "+"( Integer'Pos( a_job.taxdpd ));
      params( 139 ) := "+"( Float( a_job.totus1 ));
      params( 140 ) := "+"( Float( a_job.ubonamt ));
      params( 141 ) := "+"( Integer'Pos( a_job.uboninc ));
      params( 142 ) := "+"( Float( a_job.udeduc1 ));
      params( 143 ) := "+"( Float( a_job.udeduc2 ));
      params( 144 ) := "+"( Float( a_job.udeduc3 ));
      params( 145 ) := "+"( Float( a_job.udeduc4 ));
      params( 146 ) := "+"( Float( a_job.udeduc5 ));
      params( 147 ) := "+"( Float( a_job.udeduc6 ));
      params( 148 ) := "+"( Float( a_job.udeduc7 ));
      params( 149 ) := "+"( Float( a_job.udeduc8 ));
      params( 150 ) := "+"( Float( a_job.ugross ));
      params( 151 ) := "+"( Integer'Pos( a_job.uincpay1 ));
      params( 152 ) := "+"( Integer'Pos( a_job.uincpay2 ));
      params( 153 ) := "+"( Integer'Pos( a_job.uincpay3 ));
      params( 154 ) := "+"( Integer'Pos( a_job.uincpay4 ));
      params( 155 ) := "+"( Integer'Pos( a_job.uincpay5 ));
      params( 156 ) := "+"( Integer'Pos( a_job.uincpay6 ));
      params( 157 ) := "+"( Float( a_job.umileamt ));
      params( 158 ) := "+"( Float( a_job.umotamt ));
      params( 159 ) := "+"( Float( a_job.unett ));
      params( 160 ) := "+"( Integer'Pos( a_job.uothded1 ));
      params( 161 ) := "+"( Integer'Pos( a_job.uothded2 ));
      params( 162 ) := "+"( Integer'Pos( a_job.uothded3 ));
      params( 163 ) := "+"( Integer'Pos( a_job.uothded4 ));
      params( 164 ) := "+"( Integer'Pos( a_job.uothded5 ));
      params( 165 ) := "+"( Integer'Pos( a_job.uothded6 ));
      params( 166 ) := "+"( Integer'Pos( a_job.uothded7 ));
      params( 167 ) := "+"( Integer'Pos( a_job.uothded8 ));
      params( 168 ) := "+"( Integer'Pos( a_job.uothded9 ));
      params( 169 ) := "+"( Float( a_job.uothdtot ));
      params( 170 ) := "+"( Float( a_job.uothr ));
      params( 171 ) := "+"( Integer'Pos( a_job.upd ));
      params( 172 ) := "+"( Float( a_job.usmpamt ));
      params( 173 ) := "+"( Integer'Pos( a_job.usmprate ));
      params( 174 ) := "+"( Float( a_job.usspamt ));
      params( 175 ) := "+"( Float( a_job.usuhr ));
      params( 176 ) := "+"( Float( a_job.utaxamt ));
      params( 177 ) := "+"( Integer'Pos( a_job.watdid ));
      params( 178 ) := "+"( Integer'Pos( a_job.watprev ));
      params( 179 ) := "+"( Integer'Pos( a_job.x_where ));
      params( 180 ) := "+"( Integer'Pos( a_job.whynopro ));
      params( 181 ) := "+"( Integer'Pos( a_job.whynou01 ));
      params( 182 ) := "+"( Integer'Pos( a_job.whynou02 ));
      params( 183 ) := "+"( Integer'Pos( a_job.whynou03 ));
      params( 184 ) := "+"( Integer'Pos( a_job.whynou04 ));
      params( 185 ) := "+"( Integer'Pos( a_job.whynou05 ));
      params( 186 ) := "+"( Integer'Pos( a_job.whynou06 ));
      params( 187 ) := "+"( Integer'Pos( a_job.whynou07 ));
      params( 188 ) := "+"( Integer'Pos( a_job.whynou08 ));
      params( 189 ) := "+"( Integer'Pos( a_job.whynou09 ));
      params( 190 ) := "+"( Integer'Pos( a_job.whynou10 ));
      params( 191 ) := "+"( Integer'Pos( a_job.whynou11 ));
      params( 192 ) := "+"( Integer'Pos( a_job.workacc ));
      params( 193 ) := "+"( Integer'Pos( a_job.workmth ));
      params( 194 ) := "+"( Integer'Pos( a_job.workyr ));
      params( 195 ) := "+"( Integer'Pos( a_job.month ));
      params( 196 ) := "+"( Integer'Pos( a_job.hdqhrs ));
      params( 197 ) := "+"( Float( a_job.jobhours ));
      params( 198 ) := "+"( Integer'Pos( a_job.sspsmpfg ));
      params( 199 ) := "+"( aliased_ugrspay'Access );
      params( 200 ) := "+"( Integer'Pos( a_job.inclpay7 ));
      params( 201 ) := "+"( Integer'Pos( a_job.inclpay8 ));
      params( 202 ) := "+"( Integer'Pos( a_job.paperiod ));
      params( 203 ) := "+"( Integer'Pos( a_job.ppperiod ));
      params( 204 ) := "+"( Float( a_job.sapamt ));
      params( 205 ) := "+"( Float( a_job.sppamt ));
      params( 206 ) := "+"( Integer'Pos( a_job.uincpay7 ));
      params( 207 ) := "+"( Integer'Pos( a_job.uincpay8 ));
      params( 208 ) := "+"( Integer'Pos( a_job.usapamt ));
      params( 209 ) := "+"( Float( a_job.usppamt ));
      params( 210 ) := "+"( Integer'Pos( a_job.inkind12 ));
      params( 211 ) := "+"( Integer'Pos( a_job.inkind13 ));
      params( 212 ) := "+"( Integer'Pos( a_job.salsac ));
      params( 213 ) := "+"( Float( a_job.chvamt ));
      params( 214 ) := "+"( Integer'Pos( a_job.chvpd ));
      params( 215 ) := "+"( Integer'Pos( a_job.chvsac ));
      params( 216 ) := "+"( Float( a_job.chvuamt ));
      params( 217 ) := "+"( Integer'Pos( a_job.chvupd ));
      params( 218 ) := "+"( Integer'Pos( a_job.chvusu ));
      params( 219 ) := "+"( Integer'Pos( a_job.expben01 ));
      params( 220 ) := "+"( Integer'Pos( a_job.expben02 ));
      params( 221 ) := "+"( Integer'Pos( a_job.expben03 ));
      params( 222 ) := "+"( Integer'Pos( a_job.expben04 ));
      params( 223 ) := "+"( Integer'Pos( a_job.expben05 ));
      params( 224 ) := "+"( Integer'Pos( a_job.expben06 ));
      params( 225 ) := "+"( Integer'Pos( a_job.expben07 ));
      params( 226 ) := "+"( Integer'Pos( a_job.expben08 ));
      params( 227 ) := "+"( Integer'Pos( a_job.expben09 ));
      params( 228 ) := "+"( Integer'Pos( a_job.expben10 ));
      params( 229 ) := "+"( Integer'Pos( a_job.expben11 ));
      params( 230 ) := "+"( Integer'Pos( a_job.expben12 ));
      params( 231 ) := "+"( Float( a_job.fuelamt ));
      params( 232 ) := "+"( Integer'Pos( a_job.fuelbn ));
      params( 233 ) := "+"( Integer'Pos( a_job.fuelpd ));
      params( 234 ) := "+"( Float( a_job.fueluamt ));
      params( 235 ) := "+"( Integer'Pos( a_job.fuelupd ));
      params( 236 ) := "+"( Integer'Pos( a_job.fuelusu ));
      params( 237 ) := "+"( Integer'Pos( a_job.issue ));
      params( 238 ) := "+"( Integer'Pos( a_job.prevmth ));
      params( 239 ) := "+"( Integer'Pos( a_job.prevyr ));
      params( 240 ) := "+"( Float( a_job.spnamt ));
      params( 241 ) := "+"( Integer'Pos( a_job.spnpd ));
      params( 242 ) := "+"( Integer'Pos( a_job.spnsac ));
      params( 243 ) := "+"( Float( a_job.spnuamt ));
      params( 244 ) := "+"( Integer'Pos( a_job.spnupd ));
      params( 245 ) := "+"( Integer'Pos( a_job.spnusu ));
      params( 246 ) := "+"( Float( a_job.vchamt ));
      params( 247 ) := "+"( Integer'Pos( a_job.vchpd ));
      params( 248 ) := "+"( Integer'Pos( a_job.vchsac ));
      params( 249 ) := "+"( Integer'Pos( a_job.vchuamt ));
      params( 250 ) := "+"( Integer'Pos( a_job.vchupd ));
      params( 251 ) := "+"( Integer'Pos( a_job.vchusu ));
      params( 252 ) := "+"( Integer'Pos( a_job.wrkprev ));
      params( 253 ) := "+"( Float( a_job.caramt ));
      params( 254 ) := "+"( Integer'Pos( a_job.carcon ));
      params( 255 ) := "+"( Integer'Pos( a_job.carval ));
      params( 256 ) := "+"( Integer'Pos( a_job.fueltyp ));
      params( 257 ) := "+"( Integer'Pos( a_job.orgemp ));
      params( 258 ) := "+"( Integer'Pos( a_job.sector ));
      params( 259 ) := "+"( Integer'Pos( a_job.sectrnp ));
      params( 260 ) := "+"( Integer'Pos( a_job.whynou12 ));
      params( 261 ) := "+"( Integer'Pos( a_job.whynou13 ));
      params( 262 ) := "+"( Integer'Pos( a_job.whynou14 ));
      params( 263 ) := "+"( Integer'Pos( a_job.jobsect ));
      params( 264 ) := "+"( Integer'Pos( a_job.oremp ));
      params( 265 ) := "+"( Float( a_job.bontxam1 ));
      params( 266 ) := "+"( Float( a_job.bontxam2 ));
      params( 267 ) := "+"( Float( a_job.bontxam3 ));
      params( 268 ) := "+"( Float( a_job.bontxam4 ));
      params( 269 ) := "+"( Float( a_job.bontxam5 ));
      params( 270 ) := "+"( Float( a_job.bontxam6 ));
      params( 271 ) := "+"( Float( a_job.deduc9 ));
      params( 272 ) := "+"( Integer'Pos( a_job.emplany ));
      params( 273 ) := "+"( Integer'Pos( a_job.empten ));
      params( 274 ) := "+"( Integer'Pos( a_job.lthan30 ));
      params( 275 ) := "+"( Integer'Pos( a_job.numeten ));
      params( 276 ) := "+"( Integer'Pos( a_job.othded01 ));
      params( 277 ) := "+"( Integer'Pos( a_job.othded02 ));
      params( 278 ) := "+"( Integer'Pos( a_job.othded03 ));
      params( 279 ) := "+"( Integer'Pos( a_job.othded04 ));
      params( 280 ) := "+"( Integer'Pos( a_job.othded05 ));
      params( 281 ) := "+"( Integer'Pos( a_job.othded06 ));
      params( 282 ) := "+"( Integer'Pos( a_job.othded07 ));
      params( 283 ) := "+"( Integer'Pos( a_job.othded08 ));
      params( 284 ) := "+"( Integer'Pos( a_job.othded09 ));
      params( 285 ) := "+"( Integer'Pos( a_job.othded10 ));
      params( 286 ) := "+"( Float( a_job.udeduc9 ));
      params( 287 ) := "+"( Integer'Pos( a_job.uothde01 ));
      params( 288 ) := "+"( Integer'Pos( a_job.uothde02 ));
      params( 289 ) := "+"( Integer'Pos( a_job.uothde03 ));
      params( 290 ) := "+"( Integer'Pos( a_job.uothde04 ));
      params( 291 ) := "+"( Integer'Pos( a_job.uothde05 ));
      params( 292 ) := "+"( Integer'Pos( a_job.uothde06 ));
      params( 293 ) := "+"( Integer'Pos( a_job.uothde07 ));
      params( 294 ) := "+"( Integer'Pos( a_job.uothde08 ));
      params( 295 ) := "+"( Integer'Pos( a_job.uothde09 ));
      params( 296 ) := "+"( Integer'Pos( a_job.uothde10 ));
      params( 297 ) := "+"( Integer'Pos( a_job.yjbchang ));
      params( 298 ) := "+"( Integer'Pos( a_job.jbchnge ));
      params( 299 ) := "+"( Integer'Pos( a_job.hourly ));
      params( 300 ) := "+"( Integer'Pos( a_job.hrexa ));
      params( 301 ) := "+"( Integer'Pos( a_job.hrexb ));
      params( 302 ) := "+"( Integer'Pos( a_job.hrexc1 ));
      params( 303 ) := "+"( Integer'Pos( a_job.hrexc2 ));
      params( 304 ) := "+"( Integer'Pos( a_job.hrexc3 ));
      params( 305 ) := "+"( Integer'Pos( a_job.hrexc4 ));
      params( 306 ) := "+"( Integer'Pos( a_job.hrexc5 ));
      params( 307 ) := "+"( Integer'Pos( a_job.hrexc6 ));
      params( 308 ) := "+"( Integer'Pos( a_job.hrexc7 ));
      params( 309 ) := "+"( Integer'Pos( a_job.hrexc8 ));
      params( 310 ) := "+"( Float( a_job.hrrate ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Job
   --

   procedure Delete( a_job : in out Ukds.Frs.Job; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_job.user_id );
      Add_edition( c, a_job.edition );
      Add_year( c, a_job.year );
      Add_counter( c, a_job.counter );
      Add_sernum( c, a_job.sernum );
      Add_benunit( c, a_job.benunit );
      Add_person( c, a_job.person );
      Add_jobtype( c, a_job.jobtype );
      Delete( c, connection );
      a_job := Ukds.Frs.Null_Job;
      Log( "delete record; execute query OK" );
   end Delete;


   --
   -- delete the records indentified by the criteria
   --
   procedure Delete( c : d.Criteria; connection : Database_Connection := null ) is
   begin      
      delete( d.to_string( c ), connection );
      Log( "delete criteria; execute query OK" );
   end Delete;
   
   procedure Delete( where_clause : String; connection : gse.Database_Connection := null ) is
      local_connection : gse.Database_Connection;     
      is_local_connection : Boolean;
      query : constant String := DB_Commons.Add_Schema_To_Query( DELETE_PART, SCHEMA_NAME ) & where_clause;
   begin
      if( connection = null )then
          local_connection := Connection_Pool.Lease;
          is_local_connection := True;
      else
          local_connection := connection;          
          is_local_connection := False;
      end if;
      Log( "delete; executing query" & query );
      gse.Execute( local_connection, query );
      Check_Result( local_connection );
      Log( "delete; execute query OK" );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Delete;


   --
   -- functions to retrieve records from tables with foreign keys
   -- referencing the table modelled by this package
   --

   --
   -- functions to add something to a criteria
   --
   procedure Add_user_id( c : in out d.Criteria; user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "user_id", op, join, user_id );
   begin
      d.add_to_criteria( c, elem );
   end Add_user_id;


   procedure Add_edition( c : in out d.Criteria; edition : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "edition", op, join, edition );
   begin
      d.add_to_criteria( c, elem );
   end Add_edition;


   procedure Add_year( c : in out d.Criteria; year : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "year", op, join, year );
   begin
      d.add_to_criteria( c, elem );
   end Add_year;


   procedure Add_counter( c : in out d.Criteria; counter : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "counter", op, join, counter );
   begin
      d.add_to_criteria( c, elem );
   end Add_counter;


   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sernum", op, join, Big_Int( sernum ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum;


   procedure Add_benunit( c : in out d.Criteria; benunit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "benunit", op, join, benunit );
   begin
      d.add_to_criteria( c, elem );
   end Add_benunit;


   procedure Add_person( c : in out d.Criteria; person : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "person", op, join, person );
   begin
      d.add_to_criteria( c, elem );
   end Add_person;


   procedure Add_jobtype( c : in out d.Criteria; jobtype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "jobtype", op, join, jobtype );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobtype;


   procedure Add_agreehrs( c : in out d.Criteria; agreehrs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "agreehrs", op, join, agreehrs );
   begin
      d.add_to_criteria( c, elem );
   end Add_agreehrs;


   procedure Add_bonamt1( c : in out d.Criteria; bonamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bonamt1", op, join, Long_Float( bonamt1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonamt1;


   procedure Add_bonamt2( c : in out d.Criteria; bonamt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bonamt2", op, join, Long_Float( bonamt2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonamt2;


   procedure Add_bonamt3( c : in out d.Criteria; bonamt3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bonamt3", op, join, Long_Float( bonamt3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonamt3;


   procedure Add_bonamt4( c : in out d.Criteria; bonamt4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bonamt4", op, join, Long_Float( bonamt4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonamt4;


   procedure Add_bonamt5( c : in out d.Criteria; bonamt5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bonamt5", op, join, Long_Float( bonamt5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonamt5;


   procedure Add_bonamt6( c : in out d.Criteria; bonamt6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bonamt6", op, join, Long_Float( bonamt6 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonamt6;


   procedure Add_bontax1( c : in out d.Criteria; bontax1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bontax1", op, join, bontax1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontax1;


   procedure Add_bontax2( c : in out d.Criteria; bontax2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bontax2", op, join, bontax2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontax2;


   procedure Add_bontax3( c : in out d.Criteria; bontax3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bontax3", op, join, bontax3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontax3;


   procedure Add_bontax4( c : in out d.Criteria; bontax4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bontax4", op, join, bontax4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontax4;


   procedure Add_bontax5( c : in out d.Criteria; bontax5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bontax5", op, join, bontax5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontax5;


   procedure Add_bontax6( c : in out d.Criteria; bontax6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bontax6", op, join, bontax6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontax6;


   procedure Add_bonus( c : in out d.Criteria; bonus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bonus", op, join, bonus );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonus;


   procedure Add_busaccts( c : in out d.Criteria; busaccts : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "busaccts", op, join, busaccts );
   begin
      d.add_to_criteria( c, elem );
   end Add_busaccts;


   procedure Add_checktax( c : in out d.Criteria; checktax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "checktax", op, join, checktax );
   begin
      d.add_to_criteria( c, elem );
   end Add_checktax;


   procedure Add_chkincom( c : in out d.Criteria; chkincom : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chkincom", op, join, chkincom );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkincom;


   procedure Add_dedoth( c : in out d.Criteria; dedoth : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dedoth", op, join, Long_Float( dedoth ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_dedoth;


   procedure Add_deduc1( c : in out d.Criteria; deduc1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "deduc1", op, join, Long_Float( deduc1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc1;


   procedure Add_deduc2( c : in out d.Criteria; deduc2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "deduc2", op, join, Long_Float( deduc2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc2;


   procedure Add_deduc3( c : in out d.Criteria; deduc3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "deduc3", op, join, Long_Float( deduc3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc3;


   procedure Add_deduc4( c : in out d.Criteria; deduc4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "deduc4", op, join, Long_Float( deduc4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc4;


   procedure Add_deduc5( c : in out d.Criteria; deduc5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "deduc5", op, join, Long_Float( deduc5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc5;


   procedure Add_deduc6( c : in out d.Criteria; deduc6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "deduc6", op, join, Long_Float( deduc6 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc6;


   procedure Add_deduc7( c : in out d.Criteria; deduc7 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "deduc7", op, join, Long_Float( deduc7 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc7;


   procedure Add_deduc8( c : in out d.Criteria; deduc8 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "deduc8", op, join, Long_Float( deduc8 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc8;


   procedure Add_dirctr( c : in out d.Criteria; dirctr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dirctr", op, join, dirctr );
   begin
      d.add_to_criteria( c, elem );
   end Add_dirctr;


   procedure Add_dirni( c : in out d.Criteria; dirni : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dirni", op, join, dirni );
   begin
      d.add_to_criteria( c, elem );
   end Add_dirni;


   procedure Add_dvtothru( c : in out d.Criteria; dvtothru : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dvtothru", op, join, dvtothru );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvtothru;


   procedure Add_dvushr( c : in out d.Criteria; dvushr : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dvushr", op, join, Long_Float( dvushr ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvushr;


   procedure Add_empany( c : in out d.Criteria; empany : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "empany", op, join, empany );
   begin
      d.add_to_criteria( c, elem );
   end Add_empany;


   procedure Add_empown( c : in out d.Criteria; empown : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "empown", op, join, empown );
   begin
      d.add_to_criteria( c, elem );
   end Add_empown;


   procedure Add_etype( c : in out d.Criteria; etype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "etype", op, join, etype );
   begin
      d.add_to_criteria( c, elem );
   end Add_etype;


   procedure Add_everot( c : in out d.Criteria; everot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "everot", op, join, everot );
   begin
      d.add_to_criteria( c, elem );
   end Add_everot;


   procedure Add_ftpt( c : in out d.Criteria; ftpt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ftpt", op, join, ftpt );
   begin
      d.add_to_criteria( c, elem );
   end Add_ftpt;


   procedure Add_grsofar( c : in out d.Criteria; grsofar : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grsofar", op, join, Long_Float( grsofar ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_grsofar;


   procedure Add_grwage( c : in out d.Criteria; grwage : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grwage", op, join, Long_Float( grwage ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_grwage;


   procedure Add_grwagpd( c : in out d.Criteria; grwagpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grwagpd", op, join, grwagpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_grwagpd;


   procedure Add_hha1( c : in out d.Criteria; hha1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hha1", op, join, Long_Float( hha1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hha1;


   procedure Add_hha2( c : in out d.Criteria; hha2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hha2", op, join, Long_Float( hha2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hha2;


   procedure Add_hha3( c : in out d.Criteria; hha3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hha3", op, join, Long_Float( hha3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hha3;


   procedure Add_hhc1( c : in out d.Criteria; hhc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhc1", op, join, hhc1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhc1;


   procedure Add_hhc2( c : in out d.Criteria; hhc2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhc2", op, join, hhc2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhc2;


   procedure Add_hhc3( c : in out d.Criteria; hhc3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhc3", op, join, hhc3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhc3;


   procedure Add_hohinc( c : in out d.Criteria; hohinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hohinc", op, join, hohinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_hohinc;


   procedure Add_inclpay1( c : in out d.Criteria; inclpay1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inclpay1", op, join, inclpay1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay1;


   procedure Add_inclpay2( c : in out d.Criteria; inclpay2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inclpay2", op, join, inclpay2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay2;


   procedure Add_inclpay3( c : in out d.Criteria; inclpay3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inclpay3", op, join, inclpay3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay3;


   procedure Add_inclpay4( c : in out d.Criteria; inclpay4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inclpay4", op, join, inclpay4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay4;


   procedure Add_inclpay5( c : in out d.Criteria; inclpay5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inclpay5", op, join, inclpay5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay5;


   procedure Add_inclpay6( c : in out d.Criteria; inclpay6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inclpay6", op, join, inclpay6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay6;


   procedure Add_inkind01( c : in out d.Criteria; inkind01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind01", op, join, inkind01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind01;


   procedure Add_inkind02( c : in out d.Criteria; inkind02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind02", op, join, inkind02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind02;


   procedure Add_inkind03( c : in out d.Criteria; inkind03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind03", op, join, inkind03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind03;


   procedure Add_inkind04( c : in out d.Criteria; inkind04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind04", op, join, inkind04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind04;


   procedure Add_inkind05( c : in out d.Criteria; inkind05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind05", op, join, inkind05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind05;


   procedure Add_inkind06( c : in out d.Criteria; inkind06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind06", op, join, inkind06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind06;


   procedure Add_inkind07( c : in out d.Criteria; inkind07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind07", op, join, inkind07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind07;


   procedure Add_inkind08( c : in out d.Criteria; inkind08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind08", op, join, inkind08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind08;


   procedure Add_inkind09( c : in out d.Criteria; inkind09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind09", op, join, inkind09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind09;


   procedure Add_inkind10( c : in out d.Criteria; inkind10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind10", op, join, inkind10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind10;


   procedure Add_inkind11( c : in out d.Criteria; inkind11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind11", op, join, inkind11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind11;


   procedure Add_instype1( c : in out d.Criteria; instype1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "instype1", op, join, instype1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_instype1;


   procedure Add_instype2( c : in out d.Criteria; instype2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "instype2", op, join, instype2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_instype2;


   procedure Add_jobbus( c : in out d.Criteria; jobbus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "jobbus", op, join, jobbus );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobbus;


   procedure Add_likehr( c : in out d.Criteria; likehr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "likehr", op, join, likehr );
   begin
      d.add_to_criteria( c, elem );
   end Add_likehr;


   procedure Add_mademp( c : in out d.Criteria; mademp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mademp", op, join, mademp );
   begin
      d.add_to_criteria( c, elem );
   end Add_mademp;


   procedure Add_matemp( c : in out d.Criteria; matemp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "matemp", op, join, matemp );
   begin
      d.add_to_criteria( c, elem );
   end Add_matemp;


   procedure Add_matstp( c : in out d.Criteria; matstp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "matstp", op, join, matstp );
   begin
      d.add_to_criteria( c, elem );
   end Add_matstp;


   procedure Add_mileamt( c : in out d.Criteria; mileamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mileamt", op, join, Long_Float( mileamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mileamt;


   procedure Add_motamt( c : in out d.Criteria; motamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "motamt", op, join, Long_Float( motamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_motamt;


   procedure Add_natins( c : in out d.Criteria; natins : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "natins", op, join, Long_Float( natins ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_natins;


   procedure Add_nature( c : in out d.Criteria; nature : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nature", op, join, nature );
   begin
      d.add_to_criteria( c, elem );
   end Add_nature;


   procedure Add_nidamt( c : in out d.Criteria; nidamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nidamt", op, join, Long_Float( nidamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_nidamt;


   procedure Add_nidpd( c : in out d.Criteria; nidpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nidpd", op, join, nidpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_nidpd;


   procedure Add_nmchc( c : in out d.Criteria; nmchc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nmchc", op, join, nmchc );
   begin
      d.add_to_criteria( c, elem );
   end Add_nmchc;


   procedure Add_nmper( c : in out d.Criteria; nmper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nmper", op, join, nmper );
   begin
      d.add_to_criteria( c, elem );
   end Add_nmper;


   procedure Add_nomor1( c : in out d.Criteria; nomor1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nomor1", op, join, nomor1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nomor1;


   procedure Add_nomor2( c : in out d.Criteria; nomor2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nomor2", op, join, nomor2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nomor2;


   procedure Add_nomor3( c : in out d.Criteria; nomor3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nomor3", op, join, nomor3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nomor3;


   procedure Add_numemp( c : in out d.Criteria; numemp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numemp", op, join, numemp );
   begin
      d.add_to_criteria( c, elem );
   end Add_numemp;


   procedure Add_othded1( c : in out d.Criteria; othded1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded1", op, join, othded1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded1;


   procedure Add_othded2( c : in out d.Criteria; othded2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded2", op, join, othded2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded2;


   procedure Add_othded3( c : in out d.Criteria; othded3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded3", op, join, othded3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded3;


   procedure Add_othded4( c : in out d.Criteria; othded4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded4", op, join, othded4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded4;


   procedure Add_othded5( c : in out d.Criteria; othded5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded5", op, join, othded5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded5;


   procedure Add_othded6( c : in out d.Criteria; othded6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded6", op, join, othded6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded6;


   procedure Add_othded7( c : in out d.Criteria; othded7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded7", op, join, othded7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded7;


   procedure Add_othded8( c : in out d.Criteria; othded8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded8", op, join, othded8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded8;


   procedure Add_othded9( c : in out d.Criteria; othded9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded9", op, join, othded9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded9;


   procedure Add_ownamt( c : in out d.Criteria; ownamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ownamt", op, join, Long_Float( ownamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ownamt;


   procedure Add_ownotamt( c : in out d.Criteria; ownotamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ownotamt", op, join, Long_Float( ownotamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ownotamt;


   procedure Add_ownother( c : in out d.Criteria; ownother : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ownother", op, join, ownother );
   begin
      d.add_to_criteria( c, elem );
   end Add_ownother;


   procedure Add_ownsum( c : in out d.Criteria; ownsum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ownsum", op, join, ownsum );
   begin
      d.add_to_criteria( c, elem );
   end Add_ownsum;


   procedure Add_payamt( c : in out d.Criteria; payamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "payamt", op, join, Long_Float( payamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_payamt;


   procedure Add_paydat( c : in out d.Criteria; paydat : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "paydat", op, join, Ada.Calendar.Time( paydat ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_paydat;


   procedure Add_paye( c : in out d.Criteria; paye : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "paye", op, join, Long_Float( paye ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_paye;


   procedure Add_paypd( c : in out d.Criteria; paypd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "paypd", op, join, paypd );
   begin
      d.add_to_criteria( c, elem );
   end Add_paypd;


   procedure Add_payslip( c : in out d.Criteria; payslip : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "payslip", op, join, payslip );
   begin
      d.add_to_criteria( c, elem );
   end Add_payslip;


   procedure Add_payusl( c : in out d.Criteria; payusl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "payusl", op, join, payusl );
   begin
      d.add_to_criteria( c, elem );
   end Add_payusl;


   procedure Add_pothr( c : in out d.Criteria; pothr : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pothr", op, join, Long_Float( pothr ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_pothr;


   procedure Add_prbefore( c : in out d.Criteria; prbefore : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "prbefore", op, join, Long_Float( prbefore ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_prbefore;


   procedure Add_profdocs( c : in out d.Criteria; profdocs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "profdocs", op, join, profdocs );
   begin
      d.add_to_criteria( c, elem );
   end Add_profdocs;


   procedure Add_profit1( c : in out d.Criteria; profit1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "profit1", op, join, Long_Float( profit1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_profit1;


   procedure Add_profit2( c : in out d.Criteria; profit2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "profit2", op, join, profit2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_profit2;


   procedure Add_profni( c : in out d.Criteria; profni : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "profni", op, join, profni );
   begin
      d.add_to_criteria( c, elem );
   end Add_profni;


   procedure Add_proftax( c : in out d.Criteria; proftax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "proftax", op, join, proftax );
   begin
      d.add_to_criteria( c, elem );
   end Add_proftax;


   procedure Add_rspoth( c : in out d.Criteria; rspoth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rspoth", op, join, rspoth );
   begin
      d.add_to_criteria( c, elem );
   end Add_rspoth;


   procedure Add_se1( c : in out d.Criteria; se1 : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "se1", op, join, Ada.Calendar.Time( se1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_se1;


   procedure Add_se2( c : in out d.Criteria; se2 : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "se2", op, join, Ada.Calendar.Time( se2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_se2;


   procedure Add_seend( c : in out d.Criteria; seend : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seend", op, join, Ada.Calendar.Time( seend ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_seend;


   procedure Add_seincamt( c : in out d.Criteria; seincamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seincamt", op, join, Long_Float( seincamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_seincamt;


   procedure Add_seincwm( c : in out d.Criteria; seincwm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seincwm", op, join, seincwm );
   begin
      d.add_to_criteria( c, elem );
   end Add_seincwm;


   procedure Add_selwks( c : in out d.Criteria; selwks : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "selwks", op, join, selwks );
   begin
      d.add_to_criteria( c, elem );
   end Add_selwks;


   procedure Add_seniiamt( c : in out d.Criteria; seniiamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seniiamt", op, join, Long_Float( seniiamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_seniiamt;


   procedure Add_seniinc( c : in out d.Criteria; seniinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seniinc", op, join, seniinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_seniinc;


   procedure Add_senilamt( c : in out d.Criteria; senilamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "senilamt", op, join, Long_Float( senilamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_senilamt;


   procedure Add_senilump( c : in out d.Criteria; senilump : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "senilump", op, join, senilump );
   begin
      d.add_to_criteria( c, elem );
   end Add_senilump;


   procedure Add_seniramt( c : in out d.Criteria; seniramt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seniramt", op, join, Long_Float( seniramt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_seniramt;


   procedure Add_senireg( c : in out d.Criteria; senireg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "senireg", op, join, senireg );
   begin
      d.add_to_criteria( c, elem );
   end Add_senireg;


   procedure Add_senirpd( c : in out d.Criteria; senirpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "senirpd", op, join, senirpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_senirpd;


   procedure Add_setax( c : in out d.Criteria; setax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "setax", op, join, setax );
   begin
      d.add_to_criteria( c, elem );
   end Add_setax;


   procedure Add_setaxamt( c : in out d.Criteria; setaxamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "setaxamt", op, join, Long_Float( setaxamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_setaxamt;


   procedure Add_smpamt( c : in out d.Criteria; smpamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "smpamt", op, join, Long_Float( smpamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_smpamt;


   procedure Add_smprate( c : in out d.Criteria; smprate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "smprate", op, join, smprate );
   begin
      d.add_to_criteria( c, elem );
   end Add_smprate;


   procedure Add_sole( c : in out d.Criteria; sole : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sole", op, join, sole );
   begin
      d.add_to_criteria( c, elem );
   end Add_sole;


   procedure Add_sspamt( c : in out d.Criteria; sspamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sspamt", op, join, Long_Float( sspamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sspamt;


   procedure Add_taxamt( c : in out d.Criteria; taxamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxamt", op, join, Long_Float( taxamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxamt;


   procedure Add_taxdamt( c : in out d.Criteria; taxdamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxdamt", op, join, Long_Float( taxdamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxdamt;


   procedure Add_taxdpd( c : in out d.Criteria; taxdpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxdpd", op, join, taxdpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxdpd;


   procedure Add_totus1( c : in out d.Criteria; totus1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totus1", op, join, Long_Float( totus1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_totus1;


   procedure Add_ubonamt( c : in out d.Criteria; ubonamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ubonamt", op, join, Long_Float( ubonamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ubonamt;


   procedure Add_uboninc( c : in out d.Criteria; uboninc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uboninc", op, join, uboninc );
   begin
      d.add_to_criteria( c, elem );
   end Add_uboninc;


   procedure Add_udeduc1( c : in out d.Criteria; udeduc1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "udeduc1", op, join, Long_Float( udeduc1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc1;


   procedure Add_udeduc2( c : in out d.Criteria; udeduc2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "udeduc2", op, join, Long_Float( udeduc2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc2;


   procedure Add_udeduc3( c : in out d.Criteria; udeduc3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "udeduc3", op, join, Long_Float( udeduc3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc3;


   procedure Add_udeduc4( c : in out d.Criteria; udeduc4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "udeduc4", op, join, Long_Float( udeduc4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc4;


   procedure Add_udeduc5( c : in out d.Criteria; udeduc5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "udeduc5", op, join, Long_Float( udeduc5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc5;


   procedure Add_udeduc6( c : in out d.Criteria; udeduc6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "udeduc6", op, join, Long_Float( udeduc6 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc6;


   procedure Add_udeduc7( c : in out d.Criteria; udeduc7 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "udeduc7", op, join, Long_Float( udeduc7 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc7;


   procedure Add_udeduc8( c : in out d.Criteria; udeduc8 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "udeduc8", op, join, Long_Float( udeduc8 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc8;


   procedure Add_ugross( c : in out d.Criteria; ugross : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ugross", op, join, Long_Float( ugross ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ugross;


   procedure Add_uincpay1( c : in out d.Criteria; uincpay1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uincpay1", op, join, uincpay1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay1;


   procedure Add_uincpay2( c : in out d.Criteria; uincpay2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uincpay2", op, join, uincpay2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay2;


   procedure Add_uincpay3( c : in out d.Criteria; uincpay3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uincpay3", op, join, uincpay3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay3;


   procedure Add_uincpay4( c : in out d.Criteria; uincpay4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uincpay4", op, join, uincpay4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay4;


   procedure Add_uincpay5( c : in out d.Criteria; uincpay5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uincpay5", op, join, uincpay5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay5;


   procedure Add_uincpay6( c : in out d.Criteria; uincpay6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uincpay6", op, join, uincpay6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay6;


   procedure Add_umileamt( c : in out d.Criteria; umileamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "umileamt", op, join, Long_Float( umileamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_umileamt;


   procedure Add_umotamt( c : in out d.Criteria; umotamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "umotamt", op, join, Long_Float( umotamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_umotamt;


   procedure Add_unett( c : in out d.Criteria; unett : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "unett", op, join, Long_Float( unett ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_unett;


   procedure Add_uothded1( c : in out d.Criteria; uothded1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothded1", op, join, uothded1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded1;


   procedure Add_uothded2( c : in out d.Criteria; uothded2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothded2", op, join, uothded2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded2;


   procedure Add_uothded3( c : in out d.Criteria; uothded3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothded3", op, join, uothded3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded3;


   procedure Add_uothded4( c : in out d.Criteria; uothded4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothded4", op, join, uothded4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded4;


   procedure Add_uothded5( c : in out d.Criteria; uothded5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothded5", op, join, uothded5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded5;


   procedure Add_uothded6( c : in out d.Criteria; uothded6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothded6", op, join, uothded6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded6;


   procedure Add_uothded7( c : in out d.Criteria; uothded7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothded7", op, join, uothded7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded7;


   procedure Add_uothded8( c : in out d.Criteria; uothded8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothded8", op, join, uothded8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded8;


   procedure Add_uothded9( c : in out d.Criteria; uothded9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothded9", op, join, uothded9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded9;


   procedure Add_uothdtot( c : in out d.Criteria; uothdtot : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothdtot", op, join, Long_Float( uothdtot ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothdtot;


   procedure Add_uothr( c : in out d.Criteria; uothr : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothr", op, join, Long_Float( uothr ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothr;


   procedure Add_upd( c : in out d.Criteria; upd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "upd", op, join, upd );
   begin
      d.add_to_criteria( c, elem );
   end Add_upd;


   procedure Add_usmpamt( c : in out d.Criteria; usmpamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "usmpamt", op, join, Long_Float( usmpamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_usmpamt;


   procedure Add_usmprate( c : in out d.Criteria; usmprate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "usmprate", op, join, usmprate );
   begin
      d.add_to_criteria( c, elem );
   end Add_usmprate;


   procedure Add_usspamt( c : in out d.Criteria; usspamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "usspamt", op, join, Long_Float( usspamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_usspamt;


   procedure Add_usuhr( c : in out d.Criteria; usuhr : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "usuhr", op, join, Long_Float( usuhr ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_usuhr;


   procedure Add_utaxamt( c : in out d.Criteria; utaxamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "utaxamt", op, join, Long_Float( utaxamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_utaxamt;


   procedure Add_watdid( c : in out d.Criteria; watdid : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "watdid", op, join, watdid );
   begin
      d.add_to_criteria( c, elem );
   end Add_watdid;


   procedure Add_watprev( c : in out d.Criteria; watprev : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "watprev", op, join, watprev );
   begin
      d.add_to_criteria( c, elem );
   end Add_watprev;


   procedure Add_x_where( c : in out d.Criteria; x_where : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "x_where", op, join, x_where );
   begin
      d.add_to_criteria( c, elem );
   end Add_x_where;


   procedure Add_whynopro( c : in out d.Criteria; whynopro : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynopro", op, join, whynopro );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynopro;


   procedure Add_whynou01( c : in out d.Criteria; whynou01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou01", op, join, whynou01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou01;


   procedure Add_whynou02( c : in out d.Criteria; whynou02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou02", op, join, whynou02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou02;


   procedure Add_whynou03( c : in out d.Criteria; whynou03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou03", op, join, whynou03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou03;


   procedure Add_whynou04( c : in out d.Criteria; whynou04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou04", op, join, whynou04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou04;


   procedure Add_whynou05( c : in out d.Criteria; whynou05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou05", op, join, whynou05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou05;


   procedure Add_whynou06( c : in out d.Criteria; whynou06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou06", op, join, whynou06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou06;


   procedure Add_whynou07( c : in out d.Criteria; whynou07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou07", op, join, whynou07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou07;


   procedure Add_whynou08( c : in out d.Criteria; whynou08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou08", op, join, whynou08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou08;


   procedure Add_whynou09( c : in out d.Criteria; whynou09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou09", op, join, whynou09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou09;


   procedure Add_whynou10( c : in out d.Criteria; whynou10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou10", op, join, whynou10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou10;


   procedure Add_whynou11( c : in out d.Criteria; whynou11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou11", op, join, whynou11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou11;


   procedure Add_workacc( c : in out d.Criteria; workacc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "workacc", op, join, workacc );
   begin
      d.add_to_criteria( c, elem );
   end Add_workacc;


   procedure Add_workmth( c : in out d.Criteria; workmth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "workmth", op, join, workmth );
   begin
      d.add_to_criteria( c, elem );
   end Add_workmth;


   procedure Add_workyr( c : in out d.Criteria; workyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "workyr", op, join, workyr );
   begin
      d.add_to_criteria( c, elem );
   end Add_workyr;


   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "month", op, join, month );
   begin
      d.add_to_criteria( c, elem );
   end Add_month;


   procedure Add_hdqhrs( c : in out d.Criteria; hdqhrs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hdqhrs", op, join, hdqhrs );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdqhrs;


   procedure Add_jobhours( c : in out d.Criteria; jobhours : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "jobhours", op, join, Long_Float( jobhours ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobhours;


   procedure Add_sspsmpfg( c : in out d.Criteria; sspsmpfg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sspsmpfg", op, join, sspsmpfg );
   begin
      d.add_to_criteria( c, elem );
   end Add_sspsmpfg;


   procedure Add_ugrspay( c : in out d.Criteria; ugrspay : Unbounded_String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ugrspay", op, join, To_String( ugrspay ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ugrspay;


   procedure Add_ugrspay( c : in out d.Criteria; ugrspay : String; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ugrspay", op, join, ugrspay );
   begin
      d.add_to_criteria( c, elem );
   end Add_ugrspay;


   procedure Add_inclpay7( c : in out d.Criteria; inclpay7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inclpay7", op, join, inclpay7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay7;


   procedure Add_inclpay8( c : in out d.Criteria; inclpay8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inclpay8", op, join, inclpay8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay8;


   procedure Add_paperiod( c : in out d.Criteria; paperiod : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "paperiod", op, join, paperiod );
   begin
      d.add_to_criteria( c, elem );
   end Add_paperiod;


   procedure Add_ppperiod( c : in out d.Criteria; ppperiod : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ppperiod", op, join, ppperiod );
   begin
      d.add_to_criteria( c, elem );
   end Add_ppperiod;


   procedure Add_sapamt( c : in out d.Criteria; sapamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sapamt", op, join, Long_Float( sapamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sapamt;


   procedure Add_sppamt( c : in out d.Criteria; sppamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sppamt", op, join, Long_Float( sppamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sppamt;


   procedure Add_uincpay7( c : in out d.Criteria; uincpay7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uincpay7", op, join, uincpay7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay7;


   procedure Add_uincpay8( c : in out d.Criteria; uincpay8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uincpay8", op, join, uincpay8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay8;


   procedure Add_usapamt( c : in out d.Criteria; usapamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "usapamt", op, join, usapamt );
   begin
      d.add_to_criteria( c, elem );
   end Add_usapamt;


   procedure Add_usppamt( c : in out d.Criteria; usppamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "usppamt", op, join, Long_Float( usppamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_usppamt;


   procedure Add_inkind12( c : in out d.Criteria; inkind12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind12", op, join, inkind12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind12;


   procedure Add_inkind13( c : in out d.Criteria; inkind13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inkind13", op, join, inkind13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind13;


   procedure Add_salsac( c : in out d.Criteria; salsac : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "salsac", op, join, salsac );
   begin
      d.add_to_criteria( c, elem );
   end Add_salsac;


   procedure Add_chvamt( c : in out d.Criteria; chvamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chvamt", op, join, Long_Float( chvamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chvamt;


   procedure Add_chvpd( c : in out d.Criteria; chvpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chvpd", op, join, chvpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_chvpd;


   procedure Add_chvsac( c : in out d.Criteria; chvsac : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chvsac", op, join, chvsac );
   begin
      d.add_to_criteria( c, elem );
   end Add_chvsac;


   procedure Add_chvuamt( c : in out d.Criteria; chvuamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chvuamt", op, join, Long_Float( chvuamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chvuamt;


   procedure Add_chvupd( c : in out d.Criteria; chvupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chvupd", op, join, chvupd );
   begin
      d.add_to_criteria( c, elem );
   end Add_chvupd;


   procedure Add_chvusu( c : in out d.Criteria; chvusu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chvusu", op, join, chvusu );
   begin
      d.add_to_criteria( c, elem );
   end Add_chvusu;


   procedure Add_expben01( c : in out d.Criteria; expben01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expben01", op, join, expben01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben01;


   procedure Add_expben02( c : in out d.Criteria; expben02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expben02", op, join, expben02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben02;


   procedure Add_expben03( c : in out d.Criteria; expben03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expben03", op, join, expben03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben03;


   procedure Add_expben04( c : in out d.Criteria; expben04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expben04", op, join, expben04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben04;


   procedure Add_expben05( c : in out d.Criteria; expben05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expben05", op, join, expben05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben05;


   procedure Add_expben06( c : in out d.Criteria; expben06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expben06", op, join, expben06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben06;


   procedure Add_expben07( c : in out d.Criteria; expben07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expben07", op, join, expben07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben07;


   procedure Add_expben08( c : in out d.Criteria; expben08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expben08", op, join, expben08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben08;


   procedure Add_expben09( c : in out d.Criteria; expben09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expben09", op, join, expben09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben09;


   procedure Add_expben10( c : in out d.Criteria; expben10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expben10", op, join, expben10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben10;


   procedure Add_expben11( c : in out d.Criteria; expben11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expben11", op, join, expben11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben11;


   procedure Add_expben12( c : in out d.Criteria; expben12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expben12", op, join, expben12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben12;


   procedure Add_fuelamt( c : in out d.Criteria; fuelamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fuelamt", op, join, Long_Float( fuelamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fuelamt;


   procedure Add_fuelbn( c : in out d.Criteria; fuelbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fuelbn", op, join, fuelbn );
   begin
      d.add_to_criteria( c, elem );
   end Add_fuelbn;


   procedure Add_fuelpd( c : in out d.Criteria; fuelpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fuelpd", op, join, fuelpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_fuelpd;


   procedure Add_fueluamt( c : in out d.Criteria; fueluamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fueluamt", op, join, Long_Float( fueluamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fueluamt;


   procedure Add_fuelupd( c : in out d.Criteria; fuelupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fuelupd", op, join, fuelupd );
   begin
      d.add_to_criteria( c, elem );
   end Add_fuelupd;


   procedure Add_fuelusu( c : in out d.Criteria; fuelusu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fuelusu", op, join, fuelusu );
   begin
      d.add_to_criteria( c, elem );
   end Add_fuelusu;


   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issue", op, join, issue );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue;


   procedure Add_prevmth( c : in out d.Criteria; prevmth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "prevmth", op, join, prevmth );
   begin
      d.add_to_criteria( c, elem );
   end Add_prevmth;


   procedure Add_prevyr( c : in out d.Criteria; prevyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "prevyr", op, join, prevyr );
   begin
      d.add_to_criteria( c, elem );
   end Add_prevyr;


   procedure Add_spnamt( c : in out d.Criteria; spnamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spnamt", op, join, Long_Float( spnamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnamt;


   procedure Add_spnpd( c : in out d.Criteria; spnpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spnpd", op, join, spnpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnpd;


   procedure Add_spnsac( c : in out d.Criteria; spnsac : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spnsac", op, join, spnsac );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnsac;


   procedure Add_spnuamt( c : in out d.Criteria; spnuamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spnuamt", op, join, Long_Float( spnuamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnuamt;


   procedure Add_spnupd( c : in out d.Criteria; spnupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spnupd", op, join, spnupd );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnupd;


   procedure Add_spnusu( c : in out d.Criteria; spnusu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spnusu", op, join, spnusu );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnusu;


   procedure Add_vchamt( c : in out d.Criteria; vchamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "vchamt", op, join, Long_Float( vchamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_vchamt;


   procedure Add_vchpd( c : in out d.Criteria; vchpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "vchpd", op, join, vchpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_vchpd;


   procedure Add_vchsac( c : in out d.Criteria; vchsac : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "vchsac", op, join, vchsac );
   begin
      d.add_to_criteria( c, elem );
   end Add_vchsac;


   procedure Add_vchuamt( c : in out d.Criteria; vchuamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "vchuamt", op, join, vchuamt );
   begin
      d.add_to_criteria( c, elem );
   end Add_vchuamt;


   procedure Add_vchupd( c : in out d.Criteria; vchupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "vchupd", op, join, vchupd );
   begin
      d.add_to_criteria( c, elem );
   end Add_vchupd;


   procedure Add_vchusu( c : in out d.Criteria; vchusu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "vchusu", op, join, vchusu );
   begin
      d.add_to_criteria( c, elem );
   end Add_vchusu;


   procedure Add_wrkprev( c : in out d.Criteria; wrkprev : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wrkprev", op, join, wrkprev );
   begin
      d.add_to_criteria( c, elem );
   end Add_wrkprev;


   procedure Add_caramt( c : in out d.Criteria; caramt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "caramt", op, join, Long_Float( caramt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_caramt;


   procedure Add_carcon( c : in out d.Criteria; carcon : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "carcon", op, join, carcon );
   begin
      d.add_to_criteria( c, elem );
   end Add_carcon;


   procedure Add_carval( c : in out d.Criteria; carval : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "carval", op, join, carval );
   begin
      d.add_to_criteria( c, elem );
   end Add_carval;


   procedure Add_fueltyp( c : in out d.Criteria; fueltyp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fueltyp", op, join, fueltyp );
   begin
      d.add_to_criteria( c, elem );
   end Add_fueltyp;


   procedure Add_orgemp( c : in out d.Criteria; orgemp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "orgemp", op, join, orgemp );
   begin
      d.add_to_criteria( c, elem );
   end Add_orgemp;


   procedure Add_sector( c : in out d.Criteria; sector : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sector", op, join, sector );
   begin
      d.add_to_criteria( c, elem );
   end Add_sector;


   procedure Add_sectrnp( c : in out d.Criteria; sectrnp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sectrnp", op, join, sectrnp );
   begin
      d.add_to_criteria( c, elem );
   end Add_sectrnp;


   procedure Add_whynou12( c : in out d.Criteria; whynou12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou12", op, join, whynou12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou12;


   procedure Add_whynou13( c : in out d.Criteria; whynou13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou13", op, join, whynou13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou13;


   procedure Add_whynou14( c : in out d.Criteria; whynou14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynou14", op, join, whynou14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou14;


   procedure Add_jobsect( c : in out d.Criteria; jobsect : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "jobsect", op, join, jobsect );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobsect;


   procedure Add_oremp( c : in out d.Criteria; oremp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oremp", op, join, oremp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oremp;


   procedure Add_bontxam1( c : in out d.Criteria; bontxam1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bontxam1", op, join, Long_Float( bontxam1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontxam1;


   procedure Add_bontxam2( c : in out d.Criteria; bontxam2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bontxam2", op, join, Long_Float( bontxam2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontxam2;


   procedure Add_bontxam3( c : in out d.Criteria; bontxam3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bontxam3", op, join, Long_Float( bontxam3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontxam3;


   procedure Add_bontxam4( c : in out d.Criteria; bontxam4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bontxam4", op, join, Long_Float( bontxam4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontxam4;


   procedure Add_bontxam5( c : in out d.Criteria; bontxam5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bontxam5", op, join, Long_Float( bontxam5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontxam5;


   procedure Add_bontxam6( c : in out d.Criteria; bontxam6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bontxam6", op, join, Long_Float( bontxam6 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontxam6;


   procedure Add_deduc9( c : in out d.Criteria; deduc9 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "deduc9", op, join, Long_Float( deduc9 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc9;


   procedure Add_emplany( c : in out d.Criteria; emplany : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "emplany", op, join, emplany );
   begin
      d.add_to_criteria( c, elem );
   end Add_emplany;


   procedure Add_empten( c : in out d.Criteria; empten : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "empten", op, join, empten );
   begin
      d.add_to_criteria( c, elem );
   end Add_empten;


   procedure Add_lthan30( c : in out d.Criteria; lthan30 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lthan30", op, join, lthan30 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lthan30;


   procedure Add_numeten( c : in out d.Criteria; numeten : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numeten", op, join, numeten );
   begin
      d.add_to_criteria( c, elem );
   end Add_numeten;


   procedure Add_othded01( c : in out d.Criteria; othded01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded01", op, join, othded01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded01;


   procedure Add_othded02( c : in out d.Criteria; othded02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded02", op, join, othded02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded02;


   procedure Add_othded03( c : in out d.Criteria; othded03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded03", op, join, othded03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded03;


   procedure Add_othded04( c : in out d.Criteria; othded04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded04", op, join, othded04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded04;


   procedure Add_othded05( c : in out d.Criteria; othded05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded05", op, join, othded05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded05;


   procedure Add_othded06( c : in out d.Criteria; othded06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded06", op, join, othded06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded06;


   procedure Add_othded07( c : in out d.Criteria; othded07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded07", op, join, othded07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded07;


   procedure Add_othded08( c : in out d.Criteria; othded08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded08", op, join, othded08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded08;


   procedure Add_othded09( c : in out d.Criteria; othded09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded09", op, join, othded09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded09;


   procedure Add_othded10( c : in out d.Criteria; othded10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othded10", op, join, othded10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded10;


   procedure Add_udeduc9( c : in out d.Criteria; udeduc9 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "udeduc9", op, join, Long_Float( udeduc9 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc9;


   procedure Add_uothde01( c : in out d.Criteria; uothde01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothde01", op, join, uothde01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde01;


   procedure Add_uothde02( c : in out d.Criteria; uothde02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothde02", op, join, uothde02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde02;


   procedure Add_uothde03( c : in out d.Criteria; uothde03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothde03", op, join, uothde03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde03;


   procedure Add_uothde04( c : in out d.Criteria; uothde04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothde04", op, join, uothde04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde04;


   procedure Add_uothde05( c : in out d.Criteria; uothde05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothde05", op, join, uothde05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde05;


   procedure Add_uothde06( c : in out d.Criteria; uothde06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothde06", op, join, uothde06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde06;


   procedure Add_uothde07( c : in out d.Criteria; uothde07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothde07", op, join, uothde07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde07;


   procedure Add_uothde08( c : in out d.Criteria; uothde08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothde08", op, join, uothde08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde08;


   procedure Add_uothde09( c : in out d.Criteria; uothde09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothde09", op, join, uothde09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde09;


   procedure Add_uothde10( c : in out d.Criteria; uothde10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uothde10", op, join, uothde10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde10;


   procedure Add_yjbchang( c : in out d.Criteria; yjbchang : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "yjbchang", op, join, yjbchang );
   begin
      d.add_to_criteria( c, elem );
   end Add_yjbchang;


   procedure Add_jbchnge( c : in out d.Criteria; jbchnge : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "jbchnge", op, join, jbchnge );
   begin
      d.add_to_criteria( c, elem );
   end Add_jbchnge;


   procedure Add_hourly( c : in out d.Criteria; hourly : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hourly", op, join, hourly );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourly;


   procedure Add_hrexa( c : in out d.Criteria; hrexa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrexa", op, join, hrexa );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexa;


   procedure Add_hrexb( c : in out d.Criteria; hrexb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrexb", op, join, hrexb );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexb;


   procedure Add_hrexc1( c : in out d.Criteria; hrexc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrexc1", op, join, hrexc1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc1;


   procedure Add_hrexc2( c : in out d.Criteria; hrexc2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrexc2", op, join, hrexc2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc2;


   procedure Add_hrexc3( c : in out d.Criteria; hrexc3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrexc3", op, join, hrexc3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc3;


   procedure Add_hrexc4( c : in out d.Criteria; hrexc4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrexc4", op, join, hrexc4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc4;


   procedure Add_hrexc5( c : in out d.Criteria; hrexc5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrexc5", op, join, hrexc5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc5;


   procedure Add_hrexc6( c : in out d.Criteria; hrexc6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrexc6", op, join, hrexc6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc6;


   procedure Add_hrexc7( c : in out d.Criteria; hrexc7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrexc7", op, join, hrexc7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc7;


   procedure Add_hrexc8( c : in out d.Criteria; hrexc8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrexc8", op, join, hrexc8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc8;


   procedure Add_hrrate( c : in out d.Criteria; hrrate : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrrate", op, join, Long_Float( hrrate ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrrate;


   
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "user_id", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_user_id_To_Orderings;


   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edition", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_edition_To_Orderings;


   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "year", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_year_To_Orderings;


   procedure Add_counter_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "counter", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_counter_To_Orderings;


   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sernum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum_To_Orderings;


   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benunit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benunit_To_Orderings;


   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "person", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_person_To_Orderings;


   procedure Add_jobtype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "jobtype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobtype_To_Orderings;


   procedure Add_agreehrs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "agreehrs", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_agreehrs_To_Orderings;


   procedure Add_bonamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bonamt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonamt1_To_Orderings;


   procedure Add_bonamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bonamt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonamt2_To_Orderings;


   procedure Add_bonamt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bonamt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonamt3_To_Orderings;


   procedure Add_bonamt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bonamt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonamt4_To_Orderings;


   procedure Add_bonamt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bonamt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonamt5_To_Orderings;


   procedure Add_bonamt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bonamt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonamt6_To_Orderings;


   procedure Add_bontax1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bontax1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontax1_To_Orderings;


   procedure Add_bontax2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bontax2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontax2_To_Orderings;


   procedure Add_bontax3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bontax3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontax3_To_Orderings;


   procedure Add_bontax4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bontax4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontax4_To_Orderings;


   procedure Add_bontax5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bontax5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontax5_To_Orderings;


   procedure Add_bontax6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bontax6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontax6_To_Orderings;


   procedure Add_bonus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bonus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bonus_To_Orderings;


   procedure Add_busaccts_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "busaccts", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_busaccts_To_Orderings;


   procedure Add_checktax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "checktax", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_checktax_To_Orderings;


   procedure Add_chkincom_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chkincom", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkincom_To_Orderings;


   procedure Add_dedoth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dedoth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dedoth_To_Orderings;


   procedure Add_deduc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "deduc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc1_To_Orderings;


   procedure Add_deduc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "deduc2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc2_To_Orderings;


   procedure Add_deduc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "deduc3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc3_To_Orderings;


   procedure Add_deduc4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "deduc4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc4_To_Orderings;


   procedure Add_deduc5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "deduc5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc5_To_Orderings;


   procedure Add_deduc6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "deduc6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc6_To_Orderings;


   procedure Add_deduc7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "deduc7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc7_To_Orderings;


   procedure Add_deduc8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "deduc8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc8_To_Orderings;


   procedure Add_dirctr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dirctr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dirctr_To_Orderings;


   procedure Add_dirni_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dirni", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dirni_To_Orderings;


   procedure Add_dvtothru_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dvtothru", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvtothru_To_Orderings;


   procedure Add_dvushr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dvushr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvushr_To_Orderings;


   procedure Add_empany_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "empany", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_empany_To_Orderings;


   procedure Add_empown_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "empown", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_empown_To_Orderings;


   procedure Add_etype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "etype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_etype_To_Orderings;


   procedure Add_everot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "everot", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_everot_To_Orderings;


   procedure Add_ftpt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ftpt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ftpt_To_Orderings;


   procedure Add_grsofar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grsofar", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grsofar_To_Orderings;


   procedure Add_grwage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grwage", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grwage_To_Orderings;


   procedure Add_grwagpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grwagpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grwagpd_To_Orderings;


   procedure Add_hha1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hha1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hha1_To_Orderings;


   procedure Add_hha2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hha2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hha2_To_Orderings;


   procedure Add_hha3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hha3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hha3_To_Orderings;


   procedure Add_hhc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhc1_To_Orderings;


   procedure Add_hhc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhc2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhc2_To_Orderings;


   procedure Add_hhc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhc3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhc3_To_Orderings;


   procedure Add_hohinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hohinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hohinc_To_Orderings;


   procedure Add_inclpay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inclpay1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay1_To_Orderings;


   procedure Add_inclpay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inclpay2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay2_To_Orderings;


   procedure Add_inclpay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inclpay3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay3_To_Orderings;


   procedure Add_inclpay4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inclpay4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay4_To_Orderings;


   procedure Add_inclpay5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inclpay5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay5_To_Orderings;


   procedure Add_inclpay6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inclpay6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay6_To_Orderings;


   procedure Add_inkind01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind01_To_Orderings;


   procedure Add_inkind02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind02_To_Orderings;


   procedure Add_inkind03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind03_To_Orderings;


   procedure Add_inkind04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind04_To_Orderings;


   procedure Add_inkind05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind05_To_Orderings;


   procedure Add_inkind06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind06_To_Orderings;


   procedure Add_inkind07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind07_To_Orderings;


   procedure Add_inkind08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind08_To_Orderings;


   procedure Add_inkind09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind09_To_Orderings;


   procedure Add_inkind10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind10_To_Orderings;


   procedure Add_inkind11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind11_To_Orderings;


   procedure Add_instype1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "instype1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_instype1_To_Orderings;


   procedure Add_instype2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "instype2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_instype2_To_Orderings;


   procedure Add_jobbus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "jobbus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobbus_To_Orderings;


   procedure Add_likehr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "likehr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_likehr_To_Orderings;


   procedure Add_mademp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mademp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mademp_To_Orderings;


   procedure Add_matemp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "matemp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_matemp_To_Orderings;


   procedure Add_matstp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "matstp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_matstp_To_Orderings;


   procedure Add_mileamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mileamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mileamt_To_Orderings;


   procedure Add_motamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "motamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_motamt_To_Orderings;


   procedure Add_natins_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "natins", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_natins_To_Orderings;


   procedure Add_nature_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nature", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nature_To_Orderings;


   procedure Add_nidamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nidamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nidamt_To_Orderings;


   procedure Add_nidpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nidpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nidpd_To_Orderings;


   procedure Add_nmchc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nmchc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nmchc_To_Orderings;


   procedure Add_nmper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nmper", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nmper_To_Orderings;


   procedure Add_nomor1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nomor1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nomor1_To_Orderings;


   procedure Add_nomor2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nomor2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nomor2_To_Orderings;


   procedure Add_nomor3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nomor3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nomor3_To_Orderings;


   procedure Add_numemp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numemp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numemp_To_Orderings;


   procedure Add_othded1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded1_To_Orderings;


   procedure Add_othded2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded2_To_Orderings;


   procedure Add_othded3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded3_To_Orderings;


   procedure Add_othded4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded4_To_Orderings;


   procedure Add_othded5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded5_To_Orderings;


   procedure Add_othded6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded6_To_Orderings;


   procedure Add_othded7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded7_To_Orderings;


   procedure Add_othded8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded8_To_Orderings;


   procedure Add_othded9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded9_To_Orderings;


   procedure Add_ownamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ownamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ownamt_To_Orderings;


   procedure Add_ownotamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ownotamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ownotamt_To_Orderings;


   procedure Add_ownother_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ownother", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ownother_To_Orderings;


   procedure Add_ownsum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ownsum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ownsum_To_Orderings;


   procedure Add_payamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "payamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_payamt_To_Orderings;


   procedure Add_paydat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "paydat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_paydat_To_Orderings;


   procedure Add_paye_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "paye", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_paye_To_Orderings;


   procedure Add_paypd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "paypd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_paypd_To_Orderings;


   procedure Add_payslip_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "payslip", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_payslip_To_Orderings;


   procedure Add_payusl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "payusl", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_payusl_To_Orderings;


   procedure Add_pothr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pothr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pothr_To_Orderings;


   procedure Add_prbefore_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "prbefore", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_prbefore_To_Orderings;


   procedure Add_profdocs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "profdocs", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_profdocs_To_Orderings;


   procedure Add_profit1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "profit1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_profit1_To_Orderings;


   procedure Add_profit2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "profit2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_profit2_To_Orderings;


   procedure Add_profni_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "profni", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_profni_To_Orderings;


   procedure Add_proftax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "proftax", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_proftax_To_Orderings;


   procedure Add_rspoth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rspoth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rspoth_To_Orderings;


   procedure Add_se1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "se1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_se1_To_Orderings;


   procedure Add_se2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "se2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_se2_To_Orderings;


   procedure Add_seend_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seend", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seend_To_Orderings;


   procedure Add_seincamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seincamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seincamt_To_Orderings;


   procedure Add_seincwm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seincwm", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seincwm_To_Orderings;


   procedure Add_selwks_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "selwks", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_selwks_To_Orderings;


   procedure Add_seniiamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seniiamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seniiamt_To_Orderings;


   procedure Add_seniinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seniinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seniinc_To_Orderings;


   procedure Add_senilamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "senilamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_senilamt_To_Orderings;


   procedure Add_senilump_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "senilump", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_senilump_To_Orderings;


   procedure Add_seniramt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seniramt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seniramt_To_Orderings;


   procedure Add_senireg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "senireg", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_senireg_To_Orderings;


   procedure Add_senirpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "senirpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_senirpd_To_Orderings;


   procedure Add_setax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "setax", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_setax_To_Orderings;


   procedure Add_setaxamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "setaxamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_setaxamt_To_Orderings;


   procedure Add_smpamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "smpamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_smpamt_To_Orderings;


   procedure Add_smprate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "smprate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_smprate_To_Orderings;


   procedure Add_sole_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sole", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sole_To_Orderings;


   procedure Add_sspamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sspamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sspamt_To_Orderings;


   procedure Add_taxamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxamt_To_Orderings;


   procedure Add_taxdamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxdamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxdamt_To_Orderings;


   procedure Add_taxdpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxdpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxdpd_To_Orderings;


   procedure Add_totus1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totus1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totus1_To_Orderings;


   procedure Add_ubonamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ubonamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ubonamt_To_Orderings;


   procedure Add_uboninc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uboninc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uboninc_To_Orderings;


   procedure Add_udeduc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "udeduc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc1_To_Orderings;


   procedure Add_udeduc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "udeduc2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc2_To_Orderings;


   procedure Add_udeduc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "udeduc3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc3_To_Orderings;


   procedure Add_udeduc4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "udeduc4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc4_To_Orderings;


   procedure Add_udeduc5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "udeduc5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc5_To_Orderings;


   procedure Add_udeduc6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "udeduc6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc6_To_Orderings;


   procedure Add_udeduc7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "udeduc7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc7_To_Orderings;


   procedure Add_udeduc8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "udeduc8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc8_To_Orderings;


   procedure Add_ugross_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ugross", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ugross_To_Orderings;


   procedure Add_uincpay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uincpay1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay1_To_Orderings;


   procedure Add_uincpay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uincpay2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay2_To_Orderings;


   procedure Add_uincpay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uincpay3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay3_To_Orderings;


   procedure Add_uincpay4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uincpay4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay4_To_Orderings;


   procedure Add_uincpay5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uincpay5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay5_To_Orderings;


   procedure Add_uincpay6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uincpay6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay6_To_Orderings;


   procedure Add_umileamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "umileamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_umileamt_To_Orderings;


   procedure Add_umotamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "umotamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_umotamt_To_Orderings;


   procedure Add_unett_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "unett", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_unett_To_Orderings;


   procedure Add_uothded1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothded1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded1_To_Orderings;


   procedure Add_uothded2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothded2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded2_To_Orderings;


   procedure Add_uothded3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothded3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded3_To_Orderings;


   procedure Add_uothded4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothded4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded4_To_Orderings;


   procedure Add_uothded5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothded5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded5_To_Orderings;


   procedure Add_uothded6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothded6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded6_To_Orderings;


   procedure Add_uothded7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothded7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded7_To_Orderings;


   procedure Add_uothded8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothded8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded8_To_Orderings;


   procedure Add_uothded9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothded9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothded9_To_Orderings;


   procedure Add_uothdtot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothdtot", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothdtot_To_Orderings;


   procedure Add_uothr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothr_To_Orderings;


   procedure Add_upd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "upd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_upd_To_Orderings;


   procedure Add_usmpamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "usmpamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_usmpamt_To_Orderings;


   procedure Add_usmprate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "usmprate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_usmprate_To_Orderings;


   procedure Add_usspamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "usspamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_usspamt_To_Orderings;


   procedure Add_usuhr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "usuhr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_usuhr_To_Orderings;


   procedure Add_utaxamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "utaxamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_utaxamt_To_Orderings;


   procedure Add_watdid_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "watdid", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_watdid_To_Orderings;


   procedure Add_watprev_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "watprev", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_watprev_To_Orderings;


   procedure Add_x_where_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "x_where", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_x_where_To_Orderings;


   procedure Add_whynopro_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynopro", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynopro_To_Orderings;


   procedure Add_whynou01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou01_To_Orderings;


   procedure Add_whynou02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou02_To_Orderings;


   procedure Add_whynou03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou03_To_Orderings;


   procedure Add_whynou04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou04_To_Orderings;


   procedure Add_whynou05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou05_To_Orderings;


   procedure Add_whynou06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou06_To_Orderings;


   procedure Add_whynou07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou07_To_Orderings;


   procedure Add_whynou08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou08_To_Orderings;


   procedure Add_whynou09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou09_To_Orderings;


   procedure Add_whynou10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou10_To_Orderings;


   procedure Add_whynou11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou11_To_Orderings;


   procedure Add_workacc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "workacc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_workacc_To_Orderings;


   procedure Add_workmth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "workmth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_workmth_To_Orderings;


   procedure Add_workyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "workyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_workyr_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;


   procedure Add_hdqhrs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hdqhrs", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdqhrs_To_Orderings;


   procedure Add_jobhours_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "jobhours", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobhours_To_Orderings;


   procedure Add_sspsmpfg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sspsmpfg", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sspsmpfg_To_Orderings;


   procedure Add_ugrspay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ugrspay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ugrspay_To_Orderings;


   procedure Add_inclpay7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inclpay7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay7_To_Orderings;


   procedure Add_inclpay8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inclpay8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inclpay8_To_Orderings;


   procedure Add_paperiod_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "paperiod", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_paperiod_To_Orderings;


   procedure Add_ppperiod_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ppperiod", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ppperiod_To_Orderings;


   procedure Add_sapamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sapamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sapamt_To_Orderings;


   procedure Add_sppamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sppamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sppamt_To_Orderings;


   procedure Add_uincpay7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uincpay7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay7_To_Orderings;


   procedure Add_uincpay8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uincpay8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uincpay8_To_Orderings;


   procedure Add_usapamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "usapamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_usapamt_To_Orderings;


   procedure Add_usppamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "usppamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_usppamt_To_Orderings;


   procedure Add_inkind12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind12_To_Orderings;


   procedure Add_inkind13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inkind13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inkind13_To_Orderings;


   procedure Add_salsac_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "salsac", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_salsac_To_Orderings;


   procedure Add_chvamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chvamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chvamt_To_Orderings;


   procedure Add_chvpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chvpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chvpd_To_Orderings;


   procedure Add_chvsac_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chvsac", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chvsac_To_Orderings;


   procedure Add_chvuamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chvuamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chvuamt_To_Orderings;


   procedure Add_chvupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chvupd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chvupd_To_Orderings;


   procedure Add_chvusu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chvusu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chvusu_To_Orderings;


   procedure Add_expben01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expben01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben01_To_Orderings;


   procedure Add_expben02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expben02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben02_To_Orderings;


   procedure Add_expben03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expben03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben03_To_Orderings;


   procedure Add_expben04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expben04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben04_To_Orderings;


   procedure Add_expben05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expben05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben05_To_Orderings;


   procedure Add_expben06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expben06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben06_To_Orderings;


   procedure Add_expben07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expben07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben07_To_Orderings;


   procedure Add_expben08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expben08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben08_To_Orderings;


   procedure Add_expben09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expben09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben09_To_Orderings;


   procedure Add_expben10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expben10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben10_To_Orderings;


   procedure Add_expben11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expben11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben11_To_Orderings;


   procedure Add_expben12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expben12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expben12_To_Orderings;


   procedure Add_fuelamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fuelamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fuelamt_To_Orderings;


   procedure Add_fuelbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fuelbn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fuelbn_To_Orderings;


   procedure Add_fuelpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fuelpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fuelpd_To_Orderings;


   procedure Add_fueluamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fueluamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fueluamt_To_Orderings;


   procedure Add_fuelupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fuelupd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fuelupd_To_Orderings;


   procedure Add_fuelusu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fuelusu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fuelusu_To_Orderings;


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;


   procedure Add_prevmth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "prevmth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_prevmth_To_Orderings;


   procedure Add_prevyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "prevyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_prevyr_To_Orderings;


   procedure Add_spnamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spnamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnamt_To_Orderings;


   procedure Add_spnpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spnpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnpd_To_Orderings;


   procedure Add_spnsac_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spnsac", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnsac_To_Orderings;


   procedure Add_spnuamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spnuamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnuamt_To_Orderings;


   procedure Add_spnupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spnupd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnupd_To_Orderings;


   procedure Add_spnusu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spnusu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnusu_To_Orderings;


   procedure Add_vchamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "vchamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_vchamt_To_Orderings;


   procedure Add_vchpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "vchpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_vchpd_To_Orderings;


   procedure Add_vchsac_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "vchsac", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_vchsac_To_Orderings;


   procedure Add_vchuamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "vchuamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_vchuamt_To_Orderings;


   procedure Add_vchupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "vchupd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_vchupd_To_Orderings;


   procedure Add_vchusu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "vchusu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_vchusu_To_Orderings;


   procedure Add_wrkprev_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wrkprev", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wrkprev_To_Orderings;


   procedure Add_caramt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "caramt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_caramt_To_Orderings;


   procedure Add_carcon_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "carcon", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_carcon_To_Orderings;


   procedure Add_carval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "carval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_carval_To_Orderings;


   procedure Add_fueltyp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fueltyp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fueltyp_To_Orderings;


   procedure Add_orgemp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "orgemp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_orgemp_To_Orderings;


   procedure Add_sector_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sector", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sector_To_Orderings;


   procedure Add_sectrnp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sectrnp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sectrnp_To_Orderings;


   procedure Add_whynou12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou12_To_Orderings;


   procedure Add_whynou13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou13_To_Orderings;


   procedure Add_whynou14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynou14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynou14_To_Orderings;


   procedure Add_jobsect_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "jobsect", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobsect_To_Orderings;


   procedure Add_oremp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oremp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oremp_To_Orderings;


   procedure Add_bontxam1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bontxam1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontxam1_To_Orderings;


   procedure Add_bontxam2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bontxam2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontxam2_To_Orderings;


   procedure Add_bontxam3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bontxam3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontxam3_To_Orderings;


   procedure Add_bontxam4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bontxam4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontxam4_To_Orderings;


   procedure Add_bontxam5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bontxam5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontxam5_To_Orderings;


   procedure Add_bontxam6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bontxam6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bontxam6_To_Orderings;


   procedure Add_deduc9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "deduc9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_deduc9_To_Orderings;


   procedure Add_emplany_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "emplany", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_emplany_To_Orderings;


   procedure Add_empten_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "empten", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_empten_To_Orderings;


   procedure Add_lthan30_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lthan30", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lthan30_To_Orderings;


   procedure Add_numeten_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numeten", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numeten_To_Orderings;


   procedure Add_othded01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded01_To_Orderings;


   procedure Add_othded02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded02_To_Orderings;


   procedure Add_othded03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded03_To_Orderings;


   procedure Add_othded04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded04_To_Orderings;


   procedure Add_othded05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded05_To_Orderings;


   procedure Add_othded06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded06_To_Orderings;


   procedure Add_othded07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded07_To_Orderings;


   procedure Add_othded08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded08_To_Orderings;


   procedure Add_othded09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded09_To_Orderings;


   procedure Add_othded10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othded10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othded10_To_Orderings;


   procedure Add_udeduc9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "udeduc9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_udeduc9_To_Orderings;


   procedure Add_uothde01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothde01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde01_To_Orderings;


   procedure Add_uothde02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothde02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde02_To_Orderings;


   procedure Add_uothde03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothde03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde03_To_Orderings;


   procedure Add_uothde04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothde04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde04_To_Orderings;


   procedure Add_uothde05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothde05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde05_To_Orderings;


   procedure Add_uothde06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothde06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde06_To_Orderings;


   procedure Add_uothde07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothde07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde07_To_Orderings;


   procedure Add_uothde08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothde08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde08_To_Orderings;


   procedure Add_uothde09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothde09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde09_To_Orderings;


   procedure Add_uothde10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uothde10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uothde10_To_Orderings;


   procedure Add_yjbchang_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "yjbchang", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_yjbchang_To_Orderings;


   procedure Add_jbchnge_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "jbchnge", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_jbchnge_To_Orderings;


   procedure Add_hourly_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hourly", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourly_To_Orderings;


   procedure Add_hrexa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrexa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexa_To_Orderings;


   procedure Add_hrexb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrexb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexb_To_Orderings;


   procedure Add_hrexc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrexc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc1_To_Orderings;


   procedure Add_hrexc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrexc2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc2_To_Orderings;


   procedure Add_hrexc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrexc3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc3_To_Orderings;


   procedure Add_hrexc4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrexc4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc4_To_Orderings;


   procedure Add_hrexc5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrexc5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc5_To_Orderings;


   procedure Add_hrexc6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrexc6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc6_To_Orderings;


   procedure Add_hrexc7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrexc7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc7_To_Orderings;


   procedure Add_hrexc8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrexc8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrexc8_To_Orderings;


   procedure Add_hrrate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrrate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrrate_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Job_IO;

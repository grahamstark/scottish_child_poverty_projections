--
-- Created by Ada Mill (https://github.com/grahamstark/ada_mill)
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

with Ukds.Frs.Govpay_IO;
with Ukds.Frs.Maint_IO;
with Ukds.Frs.Owner_IO;
with Ukds.Frs.Accounts_IO;
with Ukds.Frs.Nimigra_IO;
with Ukds.Frs.Pianon1516_IO;
with Ukds.Frs.Pianon1415_IO;
with Ukds.Frs.Rentcont_IO;
with Ukds.Frs.Mortgage_IO;
with Ukds.Frs.Transact_IO;
with Ukds.Frs.Nimigr_IO;
with Ukds.Frs.Pianon1314_IO;
with Ukds.Frs.Prscrptn_IO;
with Ukds.Frs.Insuranc_IO;
with Ukds.Frs.Renter_IO;
with Ukds.Frs.Vehicle_IO;
with Ukds.Frs.Oddjob_IO;
with Ukds.Frs.Penamt_IO;
with Ukds.Frs.Chldcare_IO;
with Ukds.Frs.Endowmnt_IO;
with Ukds.Frs.Penprov_IO;
with Ukds.Frs.Job_IO;
with Ukds.Frs.Pianon1213_IO;
with Ukds.Frs.Adult_IO;
with Ukds.Frs.Child_IO;
with Ukds.Frs.Benunit_IO;
with Ukds.Frs.Care_IO;
with Ukds.Frs.Pianon1011_IO;
with Ukds.Frs.Extchild_IO;
with Ukds.Frs.Benefits_IO;
with Ukds.Frs.Assets_IO;
with Ukds.Frs.Admin_IO;
with Ukds.Frs.Accouts_IO;
with Ukds.Frs.Mortcont_IO;
with Ukds.Frs.Pension_IO;
with Ukds.Frs.Childcare_IO;
with Ukds.Frs.Pianom0809_IO;
with Ukds.Frs.Pianon0910_IO;

-- === CUSTOM IMPORTS START ===
with Ada.Text_IO;use Ada.Text_IO;                                                     
with Ada.Calendar.Formatting;                                                     
-- === CUSTOM IMPORTS END ===

package body Ukds.Frs.Househol_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.HOUSEHOL_IO" );
   
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
         "user_id, edition, year, sernum, acorn, bedroom, benunits, billrate, busroom, centfuel," &
         "centheat, charge1, charge2, charge3, charge4, charge5, charge6, charge7, charge8, charge9," &
         "chins, chrgamt1, chrgamt2, chrgamt3, chrgamt4, chrgamt5, chrgamt6, chrgamt7, chrgamt8, chrgamt9," &
         "chrgpd1, chrgpd2, chrgpd3, chrgpd4, chrgpd5, chrgpd6, chrgpd7, chrgpd8, chrgpd9, contv1," &
         "contv2, covoths, csewamt, csewamt1, ct25d50d, ctamt, ctannual, ctband, ctbwait, ctcondoc," &
         "ctdisc, ctinstal, ctlvband, ctlvchk, ctreb, ctrebamt, ctrebpd, cttime, cwatamt, cwatamt1," &
         "datyrago, entry1, entry2, entry3, entry4, estrtann, floor, givehelp, gor, gvtregn," &
         "hhldr01, hhldr02, hhldr03, hhldr04, hhldr05, hhldr06, hhldr07, hhldr08, hhldr09, hhldr10," &
         "hhldr11, hhldr12, hhldr13, hhldr14, hhldr97, hhstat, hrpnum, intdate, lac, mainacc," &
         "mnthcode, modcon01, modcon02, modcon03, modcon04, modcon05, modcon06, modcon07, modcon08, modcon09," &
         "modcon10, modcon11, modcon12, modcon13, modcon14, monlive, needhelp, nicoun, ninrv, nirate," &
         "norate, onbsroom, orgsewam, orgwatam, payrate, premium, ptbsroom, rooms, roomshar, rtannual," &
         "rtcheck, rtcondoc, rtdeduc, rtinstal, rtreb, rtrebamt, rtrebpd, rttime, sampqtr, schmeal," &
         "schmilk, sewamt, sewanul, sewerpay, sewsep, sewtime, shelter, sobuy, sstrtreg, stramt1," &
         "stramt2, strcov, strmort, stroths, strpd1, strpd2, suballow, sublet, sublety, subrent," &
         "tenure, totadult, totchild, totdepdk, tvlic, typeacc, usevcl, watamt, watanul, watermet," &
         "waterpay, watrb, wattime, welfmilk, whoctb01, whoctb02, whoctb03, whoctb04, whoctb05, whoctb06," &
         "whoctb07, whoctb08, whoctb09, whoctb10, whoctb11, whoctb12, whoctb13, whoctb14, whoctbns, whoctbot," &
         "whorsp01, whorsp02, whorsp03, whorsp04, whorsp05, whorsp06, whorsp07, whorsp08, whorsp09, whorsp10," &
         "whorsp11, whorsp12, whorsp13, whorsp14, whynoct, wmintro, wsewamt, wsewanul, wsewtime, yearcode," &
         "yearlive, month, actacch, adddahh, adulth, basacth, chddahh, curacth, cwatamtd, depchldh," &
         "emp, emphrp, endowpay, equivahc, equivbhc, fsbndcth, gbhscost, gebacth, giltcth, gross2," &
         "gross3, grossct, hbeninc, hbindhh, hcband, hdhhinc, hdtax, hearns, hhagegr2, hhagegrp," &
         "hhcomp, hhcomps, hhdisben, hhethgr2, hhethgrp, hhinc, hhincbnd, hhinv, hhirben, hhkids," &
         "hhnirben, hhothben, hhrent, hhrinc, hhrpinc, hhsize, hhtvlic, hhtxcred, hothinc, hpeninc," &
         "hrband, hseinc, isacth, london, mortcost, mortint, mortpay, nddctb, nddishc, nihscost," &
         "nsbocth, otbscth, pacctype, penage, penhrp, pepscth, poaccth, prbocth, ptentyp2, sayecth," &
         "sclbcth, servpay, sick, sickhrp, sscth, struins, stshcth, tentyp2, tesscth, tuhhrent," &
         "tuwatsew, untrcth, watsewrt, acornew, crunach, enomorth, dvadulth, dvtotad, urindew, urinds," &
         "vehnumb, country, hbindhh2, pocardh, entry5, entry6, imd_e, imd_s, imd_w, numtv1," &
         "numtv2, oac, bedroom6, rooms10, brma, issue, migrq1, migrq2, hhagegr3, hhagegr4," &
         "capval, nidpnd, nochcr1, nochcr2, nochcr3, nochcr4, nochcr5, rt2rebam, rt2rebpd, rtdpa," &
         "rtdpaamt, rtdpapd, rtlpa, rtlpaamt, rtlpapd, rtothamt, rtother, rtothpd, rtrtr, rtrtramt," &
         "rtrtrpd, rttimepd, yrlvchk, gross3_x, hlthst, medpay, medwho01, medwho02, medwho03, medwho04," &
         "medwho05, medwho06, medwho07, medwho08, medwho09, medwho10, medwho11, medwho12, medwho13, medwho14," &
         "nmrmshar, roomshr, imd_ni, multi, nopay, orgid, rtene, rteneamt, rtgen, schbrk," &
         "urb, urbrur, hhethgr3, niratlia, bankse, bathshow, burden, comco, comp1sc, compsc," &
         "comwa, dwellno, elecin, elecinw, eulowest, flshtoil, grocse, gvtregno, heat, heatcen," &
         "heatfire, kitchen, knsizeft, knsizem, laua, movef, movenxt, movereas, ovsat, plum1bin," &
         "plumin, pluminw, postse, primh, pubtr, samesc, schfrt, selper, short, sizeft," &
         "sizem, tvwhy, yearwhc, dischha1, dischhc1, diswhha1, diswhhc1, gross4, lldcare, urindni," &
         "nhbeninc, nhhnirbn, nhhothbn, seramt1, seramt2, seramt3, seramt4, serpay1, serpay2, serpay3," &
         "serpay4, serper1, serper2, serper3, serper4, utility, hheth, seramt5, sercomb, serpay5," &
         "serper5, urbni " &
         " from frs.househol " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.househol (" &
         "user_id, edition, year, sernum, acorn, bedroom, benunits, billrate, busroom, centfuel," &
         "centheat, charge1, charge2, charge3, charge4, charge5, charge6, charge7, charge8, charge9," &
         "chins, chrgamt1, chrgamt2, chrgamt3, chrgamt4, chrgamt5, chrgamt6, chrgamt7, chrgamt8, chrgamt9," &
         "chrgpd1, chrgpd2, chrgpd3, chrgpd4, chrgpd5, chrgpd6, chrgpd7, chrgpd8, chrgpd9, contv1," &
         "contv2, covoths, csewamt, csewamt1, ct25d50d, ctamt, ctannual, ctband, ctbwait, ctcondoc," &
         "ctdisc, ctinstal, ctlvband, ctlvchk, ctreb, ctrebamt, ctrebpd, cttime, cwatamt, cwatamt1," &
         "datyrago, entry1, entry2, entry3, entry4, estrtann, floor, givehelp, gor, gvtregn," &
         "hhldr01, hhldr02, hhldr03, hhldr04, hhldr05, hhldr06, hhldr07, hhldr08, hhldr09, hhldr10," &
         "hhldr11, hhldr12, hhldr13, hhldr14, hhldr97, hhstat, hrpnum, intdate, lac, mainacc," &
         "mnthcode, modcon01, modcon02, modcon03, modcon04, modcon05, modcon06, modcon07, modcon08, modcon09," &
         "modcon10, modcon11, modcon12, modcon13, modcon14, monlive, needhelp, nicoun, ninrv, nirate," &
         "norate, onbsroom, orgsewam, orgwatam, payrate, premium, ptbsroom, rooms, roomshar, rtannual," &
         "rtcheck, rtcondoc, rtdeduc, rtinstal, rtreb, rtrebamt, rtrebpd, rttime, sampqtr, schmeal," &
         "schmilk, sewamt, sewanul, sewerpay, sewsep, sewtime, shelter, sobuy, sstrtreg, stramt1," &
         "stramt2, strcov, strmort, stroths, strpd1, strpd2, suballow, sublet, sublety, subrent," &
         "tenure, totadult, totchild, totdepdk, tvlic, typeacc, usevcl, watamt, watanul, watermet," &
         "waterpay, watrb, wattime, welfmilk, whoctb01, whoctb02, whoctb03, whoctb04, whoctb05, whoctb06," &
         "whoctb07, whoctb08, whoctb09, whoctb10, whoctb11, whoctb12, whoctb13, whoctb14, whoctbns, whoctbot," &
         "whorsp01, whorsp02, whorsp03, whorsp04, whorsp05, whorsp06, whorsp07, whorsp08, whorsp09, whorsp10," &
         "whorsp11, whorsp12, whorsp13, whorsp14, whynoct, wmintro, wsewamt, wsewanul, wsewtime, yearcode," &
         "yearlive, month, actacch, adddahh, adulth, basacth, chddahh, curacth, cwatamtd, depchldh," &
         "emp, emphrp, endowpay, equivahc, equivbhc, fsbndcth, gbhscost, gebacth, giltcth, gross2," &
         "gross3, grossct, hbeninc, hbindhh, hcband, hdhhinc, hdtax, hearns, hhagegr2, hhagegrp," &
         "hhcomp, hhcomps, hhdisben, hhethgr2, hhethgrp, hhinc, hhincbnd, hhinv, hhirben, hhkids," &
         "hhnirben, hhothben, hhrent, hhrinc, hhrpinc, hhsize, hhtvlic, hhtxcred, hothinc, hpeninc," &
         "hrband, hseinc, isacth, london, mortcost, mortint, mortpay, nddctb, nddishc, nihscost," &
         "nsbocth, otbscth, pacctype, penage, penhrp, pepscth, poaccth, prbocth, ptentyp2, sayecth," &
         "sclbcth, servpay, sick, sickhrp, sscth, struins, stshcth, tentyp2, tesscth, tuhhrent," &
         "tuwatsew, untrcth, watsewrt, acornew, crunach, enomorth, dvadulth, dvtotad, urindew, urinds," &
         "vehnumb, country, hbindhh2, pocardh, entry5, entry6, imd_e, imd_s, imd_w, numtv1," &
         "numtv2, oac, bedroom6, rooms10, brma, issue, migrq1, migrq2, hhagegr3, hhagegr4," &
         "capval, nidpnd, nochcr1, nochcr2, nochcr3, nochcr4, nochcr5, rt2rebam, rt2rebpd, rtdpa," &
         "rtdpaamt, rtdpapd, rtlpa, rtlpaamt, rtlpapd, rtothamt, rtother, rtothpd, rtrtr, rtrtramt," &
         "rtrtrpd, rttimepd, yrlvchk, gross3_x, hlthst, medpay, medwho01, medwho02, medwho03, medwho04," &
         "medwho05, medwho06, medwho07, medwho08, medwho09, medwho10, medwho11, medwho12, medwho13, medwho14," &
         "nmrmshar, roomshr, imd_ni, multi, nopay, orgid, rtene, rteneamt, rtgen, schbrk," &
         "urb, urbrur, hhethgr3, niratlia, bankse, bathshow, burden, comco, comp1sc, compsc," &
         "comwa, dwellno, elecin, elecinw, eulowest, flshtoil, grocse, gvtregno, heat, heatcen," &
         "heatfire, kitchen, knsizeft, knsizem, laua, movef, movenxt, movereas, ovsat, plum1bin," &
         "plumin, pluminw, postse, primh, pubtr, samesc, schfrt, selper, short, sizeft," &
         "sizem, tvwhy, yearwhc, dischha1, dischhc1, diswhha1, diswhhc1, gross4, lldcare, urindni," &
         "nhbeninc, nhhnirbn, nhhothbn, seramt1, seramt2, seramt3, seramt4, serpay1, serpay2, serpay3," &
         "serpay4, serper1, serper2, serper3, serper4, utility, hheth, seramt5, sercomb, serpay5," &
         "serper5, urbni " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.househol ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.househol set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 432 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : acorn (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : bedroom (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : benunits (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : billrate (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : busroom (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : centfuel (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : centheat (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : charge1 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : charge2 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : charge3 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : charge4 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : charge5 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : charge6 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : charge7 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : charge8 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : charge9 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : chins (Integer)
           18 => ( Parameter_Float, 0.0 ),   --  : chrgamt1 (Amount)
           19 => ( Parameter_Float, 0.0 ),   --  : chrgamt2 (Amount)
           20 => ( Parameter_Float, 0.0 ),   --  : chrgamt3 (Amount)
           21 => ( Parameter_Float, 0.0 ),   --  : chrgamt4 (Amount)
           22 => ( Parameter_Float, 0.0 ),   --  : chrgamt5 (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : chrgamt6 (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : chrgamt7 (Amount)
           25 => ( Parameter_Float, 0.0 ),   --  : chrgamt8 (Amount)
           26 => ( Parameter_Float, 0.0 ),   --  : chrgamt9 (Amount)
           27 => ( Parameter_Integer, 0 ),   --  : chrgpd1 (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : chrgpd2 (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : chrgpd3 (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : chrgpd4 (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : chrgpd5 (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : chrgpd6 (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : chrgpd7 (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : chrgpd8 (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : chrgpd9 (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : contv1 (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : contv2 (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : covoths (Integer)
           39 => ( Parameter_Float, 0.0 ),   --  : csewamt (Amount)
           40 => ( Parameter_Float, 0.0 ),   --  : csewamt1 (Amount)
           41 => ( Parameter_Integer, 0 ),   --  : ct25d50d (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : ctamt (Integer)
           43 => ( Parameter_Float, 0.0 ),   --  : ctannual (Amount)
           44 => ( Parameter_Integer, 0 ),   --  : ctband (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : ctbwait (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : ctcondoc (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : ctdisc (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : ctinstal (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : ctlvband (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : ctlvchk (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : ctreb (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : ctrebamt (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : ctrebpd (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : cttime (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : cwatamt (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : cwatamt1 (Integer)
           57 => ( Parameter_Date, Clock ),   --  : datyrago (Ada.Calendar.Time)
           58 => ( Parameter_Integer, 0 ),   --  : entry1 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : entry2 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : entry3 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : entry4 (Integer)
           62 => ( Parameter_Float, 0.0 ),   --  : estrtann (Amount)
           63 => ( Parameter_Integer, 0 ),   --  : floor (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : givehelp (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : gor (Integer)
           66 => ( Parameter_Integer, 0 ),   --  : gvtregn (Integer)
           67 => ( Parameter_Integer, 0 ),   --  : hhldr01 (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : hhldr02 (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : hhldr03 (Integer)
           70 => ( Parameter_Integer, 0 ),   --  : hhldr04 (Integer)
           71 => ( Parameter_Integer, 0 ),   --  : hhldr05 (Integer)
           72 => ( Parameter_Integer, 0 ),   --  : hhldr06 (Integer)
           73 => ( Parameter_Integer, 0 ),   --  : hhldr07 (Integer)
           74 => ( Parameter_Integer, 0 ),   --  : hhldr08 (Integer)
           75 => ( Parameter_Integer, 0 ),   --  : hhldr09 (Integer)
           76 => ( Parameter_Integer, 0 ),   --  : hhldr10 (Integer)
           77 => ( Parameter_Integer, 0 ),   --  : hhldr11 (Integer)
           78 => ( Parameter_Integer, 0 ),   --  : hhldr12 (Integer)
           79 => ( Parameter_Integer, 0 ),   --  : hhldr13 (Integer)
           80 => ( Parameter_Integer, 0 ),   --  : hhldr14 (Integer)
           81 => ( Parameter_Integer, 0 ),   --  : hhldr97 (Integer)
           82 => ( Parameter_Integer, 0 ),   --  : hhstat (Integer)
           83 => ( Parameter_Integer, 0 ),   --  : hrpnum (Integer)
           84 => ( Parameter_Date, Clock ),   --  : intdate (Ada.Calendar.Time)
           85 => ( Parameter_Integer, 0 ),   --  : lac (Integer)
           86 => ( Parameter_Integer, 0 ),   --  : mainacc (Integer)
           87 => ( Parameter_Integer, 0 ),   --  : mnthcode (Integer)
           88 => ( Parameter_Integer, 0 ),   --  : modcon01 (Integer)
           89 => ( Parameter_Integer, 0 ),   --  : modcon02 (Integer)
           90 => ( Parameter_Integer, 0 ),   --  : modcon03 (Integer)
           91 => ( Parameter_Integer, 0 ),   --  : modcon04 (Integer)
           92 => ( Parameter_Integer, 0 ),   --  : modcon05 (Integer)
           93 => ( Parameter_Integer, 0 ),   --  : modcon06 (Integer)
           94 => ( Parameter_Integer, 0 ),   --  : modcon07 (Integer)
           95 => ( Parameter_Integer, 0 ),   --  : modcon08 (Integer)
           96 => ( Parameter_Integer, 0 ),   --  : modcon09 (Integer)
           97 => ( Parameter_Integer, 0 ),   --  : modcon10 (Integer)
           98 => ( Parameter_Integer, 0 ),   --  : modcon11 (Integer)
           99 => ( Parameter_Integer, 0 ),   --  : modcon12 (Integer)
           100 => ( Parameter_Integer, 0 ),   --  : modcon13 (Integer)
           101 => ( Parameter_Integer, 0 ),   --  : modcon14 (Integer)
           102 => ( Parameter_Integer, 0 ),   --  : monlive (Integer)
           103 => ( Parameter_Integer, 0 ),   --  : needhelp (Integer)
           104 => ( Parameter_Integer, 0 ),   --  : nicoun (Integer)
           105 => ( Parameter_Float, 0.0 ),   --  : ninrv (Amount)
           106 => ( Parameter_Integer, 0 ),   --  : nirate (Integer)
           107 => ( Parameter_Integer, 0 ),   --  : norate (Integer)
           108 => ( Parameter_Integer, 0 ),   --  : onbsroom (Integer)
           109 => ( Parameter_Float, 0.0 ),   --  : orgsewam (Amount)
           110 => ( Parameter_Float, 0.0 ),   --  : orgwatam (Amount)
           111 => ( Parameter_Integer, 0 ),   --  : payrate (Integer)
           112 => ( Parameter_Integer, 0 ),   --  : premium (Integer)
           113 => ( Parameter_Integer, 0 ),   --  : ptbsroom (Integer)
           114 => ( Parameter_Integer, 0 ),   --  : rooms (Integer)
           115 => ( Parameter_Integer, 0 ),   --  : roomshar (Integer)
           116 => ( Parameter_Float, 0.0 ),   --  : rtannual (Amount)
           117 => ( Parameter_Float, 0.0 ),   --  : rtcheck (Amount)
           118 => ( Parameter_Integer, 0 ),   --  : rtcondoc (Integer)
           119 => ( Parameter_Integer, 0 ),   --  : rtdeduc (Integer)
           120 => ( Parameter_Integer, 0 ),   --  : rtinstal (Integer)
           121 => ( Parameter_Integer, 0 ),   --  : rtreb (Integer)
           122 => ( Parameter_Float, 0.0 ),   --  : rtrebamt (Amount)
           123 => ( Parameter_Integer, 0 ),   --  : rtrebpd (Integer)
           124 => ( Parameter_Integer, 0 ),   --  : rttime (Integer)
           125 => ( Parameter_Integer, 0 ),   --  : sampqtr (Integer)
           126 => ( Parameter_Integer, 0 ),   --  : schmeal (Integer)
           127 => ( Parameter_Integer, 0 ),   --  : schmilk (Integer)
           128 => ( Parameter_Float, 0.0 ),   --  : sewamt (Amount)
           129 => ( Parameter_Float, 0.0 ),   --  : sewanul (Amount)
           130 => ( Parameter_Integer, 0 ),   --  : sewerpay (Integer)
           131 => ( Parameter_Integer, 0 ),   --  : sewsep (Integer)
           132 => ( Parameter_Integer, 0 ),   --  : sewtime (Integer)
           133 => ( Parameter_Integer, 0 ),   --  : shelter (Integer)
           134 => ( Parameter_Integer, 0 ),   --  : sobuy (Integer)
           135 => ( Parameter_Integer, 0 ),   --  : sstrtreg (Integer)
           136 => ( Parameter_Float, 0.0 ),   --  : stramt1 (Amount)
           137 => ( Parameter_Float, 0.0 ),   --  : stramt2 (Amount)
           138 => ( Parameter_Integer, 0 ),   --  : strcov (Integer)
           139 => ( Parameter_Integer, 0 ),   --  : strmort (Integer)
           140 => ( Parameter_Integer, 0 ),   --  : stroths (Integer)
           141 => ( Parameter_Integer, 0 ),   --  : strpd1 (Integer)
           142 => ( Parameter_Integer, 0 ),   --  : strpd2 (Integer)
           143 => ( Parameter_Integer, 0 ),   --  : suballow (Integer)
           144 => ( Parameter_Integer, 0 ),   --  : sublet (Integer)
           145 => ( Parameter_Integer, 0 ),   --  : sublety (Integer)
           146 => ( Parameter_Float, 0.0 ),   --  : subrent (Amount)
           147 => ( Parameter_Integer, 0 ),   --  : tenure (Integer)
           148 => ( Parameter_Integer, 0 ),   --  : totadult (Integer)
           149 => ( Parameter_Integer, 0 ),   --  : totchild (Integer)
           150 => ( Parameter_Integer, 0 ),   --  : totdepdk (Integer)
           151 => ( Parameter_Integer, 0 ),   --  : tvlic (Integer)
           152 => ( Parameter_Integer, 0 ),   --  : typeacc (Integer)
           153 => ( Parameter_Integer, 0 ),   --  : usevcl (Integer)
           154 => ( Parameter_Float, 0.0 ),   --  : watamt (Amount)
           155 => ( Parameter_Float, 0.0 ),   --  : watanul (Amount)
           156 => ( Parameter_Integer, 0 ),   --  : watermet (Integer)
           157 => ( Parameter_Integer, 0 ),   --  : waterpay (Integer)
           158 => ( Parameter_Integer, 0 ),   --  : watrb (Integer)
           159 => ( Parameter_Integer, 0 ),   --  : wattime (Integer)
           160 => ( Parameter_Integer, 0 ),   --  : welfmilk (Integer)
           161 => ( Parameter_Integer, 0 ),   --  : whoctb01 (Integer)
           162 => ( Parameter_Integer, 0 ),   --  : whoctb02 (Integer)
           163 => ( Parameter_Integer, 0 ),   --  : whoctb03 (Integer)
           164 => ( Parameter_Integer, 0 ),   --  : whoctb04 (Integer)
           165 => ( Parameter_Integer, 0 ),   --  : whoctb05 (Integer)
           166 => ( Parameter_Integer, 0 ),   --  : whoctb06 (Integer)
           167 => ( Parameter_Integer, 0 ),   --  : whoctb07 (Integer)
           168 => ( Parameter_Integer, 0 ),   --  : whoctb08 (Integer)
           169 => ( Parameter_Integer, 0 ),   --  : whoctb09 (Integer)
           170 => ( Parameter_Integer, 0 ),   --  : whoctb10 (Integer)
           171 => ( Parameter_Integer, 0 ),   --  : whoctb11 (Integer)
           172 => ( Parameter_Integer, 0 ),   --  : whoctb12 (Integer)
           173 => ( Parameter_Integer, 0 ),   --  : whoctb13 (Integer)
           174 => ( Parameter_Integer, 0 ),   --  : whoctb14 (Integer)
           175 => ( Parameter_Integer, 0 ),   --  : whoctbns (Integer)
           176 => ( Parameter_Integer, 0 ),   --  : whoctbot (Integer)
           177 => ( Parameter_Integer, 0 ),   --  : whorsp01 (Integer)
           178 => ( Parameter_Integer, 0 ),   --  : whorsp02 (Integer)
           179 => ( Parameter_Integer, 0 ),   --  : whorsp03 (Integer)
           180 => ( Parameter_Integer, 0 ),   --  : whorsp04 (Integer)
           181 => ( Parameter_Integer, 0 ),   --  : whorsp05 (Integer)
           182 => ( Parameter_Integer, 0 ),   --  : whorsp06 (Integer)
           183 => ( Parameter_Integer, 0 ),   --  : whorsp07 (Integer)
           184 => ( Parameter_Integer, 0 ),   --  : whorsp08 (Integer)
           185 => ( Parameter_Integer, 0 ),   --  : whorsp09 (Integer)
           186 => ( Parameter_Integer, 0 ),   --  : whorsp10 (Integer)
           187 => ( Parameter_Integer, 0 ),   --  : whorsp11 (Integer)
           188 => ( Parameter_Integer, 0 ),   --  : whorsp12 (Integer)
           189 => ( Parameter_Integer, 0 ),   --  : whorsp13 (Integer)
           190 => ( Parameter_Integer, 0 ),   --  : whorsp14 (Integer)
           191 => ( Parameter_Integer, 0 ),   --  : whynoct (Integer)
           192 => ( Parameter_Integer, 0 ),   --  : wmintro (Integer)
           193 => ( Parameter_Float, 0.0 ),   --  : wsewamt (Amount)
           194 => ( Parameter_Float, 0.0 ),   --  : wsewanul (Amount)
           195 => ( Parameter_Integer, 0 ),   --  : wsewtime (Integer)
           196 => ( Parameter_Integer, 0 ),   --  : yearcode (Integer)
           197 => ( Parameter_Integer, 0 ),   --  : yearlive (Integer)
           198 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           199 => ( Parameter_Integer, 0 ),   --  : actacch (Integer)
           200 => ( Parameter_Integer, 0 ),   --  : adddahh (Integer)
           201 => ( Parameter_Integer, 0 ),   --  : adulth (Integer)
           202 => ( Parameter_Integer, 0 ),   --  : basacth (Integer)
           203 => ( Parameter_Integer, 0 ),   --  : chddahh (Integer)
           204 => ( Parameter_Integer, 0 ),   --  : curacth (Integer)
           205 => ( Parameter_Integer, 0 ),   --  : cwatamtd (Integer)
           206 => ( Parameter_Integer, 0 ),   --  : depchldh (Integer)
           207 => ( Parameter_Integer, 0 ),   --  : emp (Integer)
           208 => ( Parameter_Integer, 0 ),   --  : emphrp (Integer)
           209 => ( Parameter_Float, 0.0 ),   --  : endowpay (Amount)
           210 => ( Parameter_Float, 0.0 ),   --  : equivahc (Amount)
           211 => ( Parameter_Float, 0.0 ),   --  : equivbhc (Amount)
           212 => ( Parameter_Integer, 0 ),   --  : fsbndcth (Integer)
           213 => ( Parameter_Integer, 0 ),   --  : gbhscost (Integer)
           214 => ( Parameter_Integer, 0 ),   --  : gebacth (Integer)
           215 => ( Parameter_Integer, 0 ),   --  : giltcth (Integer)
           216 => ( Parameter_Integer, 0 ),   --  : gross2 (Integer)
           217 => ( Parameter_Integer, 0 ),   --  : gross3 (Integer)
           218 => ( Parameter_Integer, 0 ),   --  : grossct (Integer)
           219 => ( Parameter_Integer, 0 ),   --  : hbeninc (Integer)
           220 => ( Parameter_Integer, 0 ),   --  : hbindhh (Integer)
           221 => ( Parameter_Integer, 0 ),   --  : hcband (Integer)
           222 => ( Parameter_Integer, 0 ),   --  : hdhhinc (Integer)
           223 => ( Parameter_Integer, 0 ),   --  : hdtax (Integer)
           224 => ( Parameter_Float, 0.0 ),   --  : hearns (Amount)
           225 => ( Parameter_Integer, 0 ),   --  : hhagegr2 (Integer)
           226 => ( Parameter_Integer, 0 ),   --  : hhagegrp (Integer)
           227 => ( Parameter_Integer, 0 ),   --  : hhcomp (Integer)
           228 => ( Parameter_Integer, 0 ),   --  : hhcomps (Integer)
           229 => ( Parameter_Integer, 0 ),   --  : hhdisben (Integer)
           230 => ( Parameter_Integer, 0 ),   --  : hhethgr2 (Integer)
           231 => ( Parameter_Integer, 0 ),   --  : hhethgrp (Integer)
           232 => ( Parameter_Integer, 0 ),   --  : hhinc (Integer)
           233 => ( Parameter_Integer, 0 ),   --  : hhincbnd (Integer)
           234 => ( Parameter_Float, 0.0 ),   --  : hhinv (Amount)
           235 => ( Parameter_Integer, 0 ),   --  : hhirben (Integer)
           236 => ( Parameter_Integer, 0 ),   --  : hhkids (Integer)
           237 => ( Parameter_Integer, 0 ),   --  : hhnirben (Integer)
           238 => ( Parameter_Integer, 0 ),   --  : hhothben (Integer)
           239 => ( Parameter_Integer, 0 ),   --  : hhrent (Integer)
           240 => ( Parameter_Float, 0.0 ),   --  : hhrinc (Amount)
           241 => ( Parameter_Float, 0.0 ),   --  : hhrpinc (Amount)
           242 => ( Parameter_Integer, 0 ),   --  : hhsize (Integer)
           243 => ( Parameter_Float, 0.0 ),   --  : hhtvlic (Amount)
           244 => ( Parameter_Float, 0.0 ),   --  : hhtxcred (Amount)
           245 => ( Parameter_Float, 0.0 ),   --  : hothinc (Amount)
           246 => ( Parameter_Float, 0.0 ),   --  : hpeninc (Amount)
           247 => ( Parameter_Integer, 0 ),   --  : hrband (Integer)
           248 => ( Parameter_Float, 0.0 ),   --  : hseinc (Amount)
           249 => ( Parameter_Integer, 0 ),   --  : isacth (Integer)
           250 => ( Parameter_Integer, 0 ),   --  : london (Integer)
           251 => ( Parameter_Float, 0.0 ),   --  : mortcost (Amount)
           252 => ( Parameter_Float, 0.0 ),   --  : mortint (Amount)
           253 => ( Parameter_Float, 0.0 ),   --  : mortpay (Amount)
           254 => ( Parameter_Float, 0.0 ),   --  : nddctb (Amount)
           255 => ( Parameter_Float, 0.0 ),   --  : nddishc (Amount)
           256 => ( Parameter_Integer, 0 ),   --  : nihscost (Integer)
           257 => ( Parameter_Integer, 0 ),   --  : nsbocth (Integer)
           258 => ( Parameter_Integer, 0 ),   --  : otbscth (Integer)
           259 => ( Parameter_Integer, 0 ),   --  : pacctype (Integer)
           260 => ( Parameter_Integer, 0 ),   --  : penage (Integer)
           261 => ( Parameter_Integer, 0 ),   --  : penhrp (Integer)
           262 => ( Parameter_Integer, 0 ),   --  : pepscth (Integer)
           263 => ( Parameter_Integer, 0 ),   --  : poaccth (Integer)
           264 => ( Parameter_Integer, 0 ),   --  : prbocth (Integer)
           265 => ( Parameter_Integer, 0 ),   --  : ptentyp2 (Integer)
           266 => ( Parameter_Integer, 0 ),   --  : sayecth (Integer)
           267 => ( Parameter_Integer, 0 ),   --  : sclbcth (Integer)
           268 => ( Parameter_Float, 0.0 ),   --  : servpay (Amount)
           269 => ( Parameter_Integer, 0 ),   --  : sick (Integer)
           270 => ( Parameter_Integer, 0 ),   --  : sickhrp (Integer)
           271 => ( Parameter_Integer, 0 ),   --  : sscth (Integer)
           272 => ( Parameter_Float, 0.0 ),   --  : struins (Amount)
           273 => ( Parameter_Integer, 0 ),   --  : stshcth (Integer)
           274 => ( Parameter_Integer, 0 ),   --  : tentyp2 (Integer)
           275 => ( Parameter_Integer, 0 ),   --  : tesscth (Integer)
           276 => ( Parameter_Float, 0.0 ),   --  : tuhhrent (Amount)
           277 => ( Parameter_Float, 0.0 ),   --  : tuwatsew (Amount)
           278 => ( Parameter_Integer, 0 ),   --  : untrcth (Integer)
           279 => ( Parameter_Float, 0.0 ),   --  : watsewrt (Amount)
           280 => ( Parameter_Integer, 0 ),   --  : acornew (Integer)
           281 => ( Parameter_Integer, 0 ),   --  : crunach (Integer)
           282 => ( Parameter_Integer, 0 ),   --  : enomorth (Integer)
           283 => ( Parameter_Integer, 0 ),   --  : dvadulth (Integer)
           284 => ( Parameter_Integer, 0 ),   --  : dvtotad (Integer)
           285 => ( Parameter_Integer, 0 ),   --  : urindew (Integer)
           286 => ( Parameter_Integer, 0 ),   --  : urinds (Integer)
           287 => ( Parameter_Integer, 0 ),   --  : vehnumb (Integer)
           288 => ( Parameter_Integer, 0 ),   --  : country (Integer)
           289 => ( Parameter_Integer, 0 ),   --  : hbindhh2 (Integer)
           290 => ( Parameter_Integer, 0 ),   --  : pocardh (Integer)
           291 => ( Parameter_Integer, 0 ),   --  : entry5 (Integer)
           292 => ( Parameter_Integer, 0 ),   --  : entry6 (Integer)
           293 => ( Parameter_Integer, 0 ),   --  : imd_e (Integer)
           294 => ( Parameter_Integer, 0 ),   --  : imd_s (Integer)
           295 => ( Parameter_Integer, 0 ),   --  : imd_w (Integer)
           296 => ( Parameter_Integer, 0 ),   --  : numtv1 (Integer)
           297 => ( Parameter_Integer, 0 ),   --  : numtv2 (Integer)
           298 => ( Parameter_Integer, 0 ),   --  : oac (Integer)
           299 => ( Parameter_Integer, 0 ),   --  : bedroom6 (Integer)
           300 => ( Parameter_Integer, 0 ),   --  : rooms10 (Integer)
           301 => ( Parameter_Integer, 0 ),   --  : brma (Integer)
           302 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           303 => ( Parameter_Integer, 0 ),   --  : migrq1 (Integer)
           304 => ( Parameter_Integer, 0 ),   --  : migrq2 (Integer)
           305 => ( Parameter_Integer, 0 ),   --  : hhagegr3 (Integer)
           306 => ( Parameter_Integer, 0 ),   --  : hhagegr4 (Integer)
           307 => ( Parameter_Integer, 0 ),   --  : capval (Integer)
           308 => ( Parameter_Integer, 0 ),   --  : nidpnd (Integer)
           309 => ( Parameter_Integer, 0 ),   --  : nochcr1 (Integer)
           310 => ( Parameter_Integer, 0 ),   --  : nochcr2 (Integer)
           311 => ( Parameter_Integer, 0 ),   --  : nochcr3 (Integer)
           312 => ( Parameter_Integer, 0 ),   --  : nochcr4 (Integer)
           313 => ( Parameter_Integer, 0 ),   --  : nochcr5 (Integer)
           314 => ( Parameter_Float, 0.0 ),   --  : rt2rebam (Amount)
           315 => ( Parameter_Integer, 0 ),   --  : rt2rebpd (Integer)
           316 => ( Parameter_Integer, 0 ),   --  : rtdpa (Integer)
           317 => ( Parameter_Float, 0.0 ),   --  : rtdpaamt (Amount)
           318 => ( Parameter_Integer, 0 ),   --  : rtdpapd (Integer)
           319 => ( Parameter_Integer, 0 ),   --  : rtlpa (Integer)
           320 => ( Parameter_Float, 0.0 ),   --  : rtlpaamt (Amount)
           321 => ( Parameter_Integer, 0 ),   --  : rtlpapd (Integer)
           322 => ( Parameter_Float, 0.0 ),   --  : rtothamt (Amount)
           323 => ( Parameter_Integer, 0 ),   --  : rtother (Integer)
           324 => ( Parameter_Integer, 0 ),   --  : rtothpd (Integer)
           325 => ( Parameter_Integer, 0 ),   --  : rtrtr (Integer)
           326 => ( Parameter_Float, 0.0 ),   --  : rtrtramt (Amount)
           327 => ( Parameter_Integer, 0 ),   --  : rtrtrpd (Integer)
           328 => ( Parameter_Integer, 0 ),   --  : rttimepd (Integer)
           329 => ( Parameter_Integer, 0 ),   --  : yrlvchk (Integer)
           330 => ( Parameter_Integer, 0 ),   --  : gross3_x (Integer)
           331 => ( Parameter_Integer, 0 ),   --  : hlthst (Integer)
           332 => ( Parameter_Integer, 0 ),   --  : medpay (Integer)
           333 => ( Parameter_Integer, 0 ),   --  : medwho01 (Integer)
           334 => ( Parameter_Integer, 0 ),   --  : medwho02 (Integer)
           335 => ( Parameter_Integer, 0 ),   --  : medwho03 (Integer)
           336 => ( Parameter_Integer, 0 ),   --  : medwho04 (Integer)
           337 => ( Parameter_Integer, 0 ),   --  : medwho05 (Integer)
           338 => ( Parameter_Integer, 0 ),   --  : medwho06 (Integer)
           339 => ( Parameter_Integer, 0 ),   --  : medwho07 (Integer)
           340 => ( Parameter_Integer, 0 ),   --  : medwho08 (Integer)
           341 => ( Parameter_Integer, 0 ),   --  : medwho09 (Integer)
           342 => ( Parameter_Integer, 0 ),   --  : medwho10 (Integer)
           343 => ( Parameter_Integer, 0 ),   --  : medwho11 (Integer)
           344 => ( Parameter_Integer, 0 ),   --  : medwho12 (Integer)
           345 => ( Parameter_Integer, 0 ),   --  : medwho13 (Integer)
           346 => ( Parameter_Integer, 0 ),   --  : medwho14 (Integer)
           347 => ( Parameter_Integer, 0 ),   --  : nmrmshar (Integer)
           348 => ( Parameter_Integer, 0 ),   --  : roomshr (Integer)
           349 => ( Parameter_Integer, 0 ),   --  : imd_ni (Integer)
           350 => ( Parameter_Integer, 0 ),   --  : multi (Integer)
           351 => ( Parameter_Integer, 0 ),   --  : nopay (Integer)
           352 => ( Parameter_Integer, 0 ),   --  : orgid (Integer)
           353 => ( Parameter_Integer, 0 ),   --  : rtene (Integer)
           354 => ( Parameter_Integer, 0 ),   --  : rteneamt (Integer)
           355 => ( Parameter_Integer, 0 ),   --  : rtgen (Integer)
           356 => ( Parameter_Integer, 0 ),   --  : schbrk (Integer)
           357 => ( Parameter_Integer, 0 ),   --  : urb (Integer)
           358 => ( Parameter_Integer, 0 ),   --  : urbrur (Integer)
           359 => ( Parameter_Integer, 0 ),   --  : hhethgr3 (Integer)
           360 => ( Parameter_Float, 0.0 ),   --  : niratlia (Amount)
           361 => ( Parameter_Integer, 0 ),   --  : bankse (Integer)
           362 => ( Parameter_Integer, 0 ),   --  : bathshow (Integer)
           363 => ( Parameter_Integer, 0 ),   --  : burden (Integer)
           364 => ( Parameter_Integer, 0 ),   --  : comco (Integer)
           365 => ( Parameter_Integer, 0 ),   --  : comp1sc (Integer)
           366 => ( Parameter_Integer, 0 ),   --  : compsc (Integer)
           367 => ( Parameter_Integer, 0 ),   --  : comwa (Integer)
           368 => ( Parameter_Integer, 0 ),   --  : dwellno (Integer)
           369 => ( Parameter_Integer, 0 ),   --  : elecin (Integer)
           370 => ( Parameter_Integer, 0 ),   --  : elecinw (Integer)
           371 => ( Parameter_Float, 0.0 ),   --  : eulowest (Amount)
           372 => ( Parameter_Integer, 0 ),   --  : flshtoil (Integer)
           373 => ( Parameter_Integer, 0 ),   --  : grocse (Integer)
           374 => ( Parameter_Integer, 0 ),   --  : gvtregno (Integer)
           375 => ( Parameter_Integer, 0 ),   --  : heat (Integer)
           376 => ( Parameter_Integer, 0 ),   --  : heatcen (Integer)
           377 => ( Parameter_Integer, 0 ),   --  : heatfire (Integer)
           378 => ( Parameter_Integer, 0 ),   --  : kitchen (Integer)
           379 => ( Parameter_Integer, 0 ),   --  : knsizeft (Integer)
           380 => ( Parameter_Integer, 0 ),   --  : knsizem (Integer)
           381 => ( Parameter_Integer, 0 ),   --  : laua (Integer)
           382 => ( Parameter_Integer, 0 ),   --  : movef (Integer)
           383 => ( Parameter_Integer, 0 ),   --  : movenxt (Integer)
           384 => ( Parameter_Integer, 0 ),   --  : movereas (Integer)
           385 => ( Parameter_Integer, 0 ),   --  : ovsat (Integer)
           386 => ( Parameter_Integer, 0 ),   --  : plum1bin (Integer)
           387 => ( Parameter_Integer, 0 ),   --  : plumin (Integer)
           388 => ( Parameter_Integer, 0 ),   --  : pluminw (Integer)
           389 => ( Parameter_Integer, 0 ),   --  : postse (Integer)
           390 => ( Parameter_Integer, 0 ),   --  : primh (Integer)
           391 => ( Parameter_Integer, 0 ),   --  : pubtr (Integer)
           392 => ( Parameter_Integer, 0 ),   --  : samesc (Integer)
           393 => ( Parameter_Integer, 0 ),   --  : schfrt (Integer)
           394 => ( Parameter_Integer, 0 ),   --  : selper (Integer)
           395 => ( Parameter_Integer, 0 ),   --  : short (Integer)
           396 => ( Parameter_Integer, 0 ),   --  : sizeft (Integer)
           397 => ( Parameter_Integer, 0 ),   --  : sizem (Integer)
           398 => ( Parameter_Integer, 0 ),   --  : tvwhy (Integer)
           399 => ( Parameter_Integer, 0 ),   --  : yearwhc (Integer)
           400 => ( Parameter_Integer, 0 ),   --  : dischha1 (Integer)
           401 => ( Parameter_Integer, 0 ),   --  : dischhc1 (Integer)
           402 => ( Parameter_Integer, 0 ),   --  : diswhha1 (Integer)
           403 => ( Parameter_Integer, 0 ),   --  : diswhhc1 (Integer)
           404 => ( Parameter_Integer, 0 ),   --  : gross4 (Integer)
           405 => ( Parameter_Integer, 0 ),   --  : lldcare (Integer)
           406 => ( Parameter_Integer, 0 ),   --  : urindni (Integer)
           407 => ( Parameter_Integer, 0 ),   --  : nhbeninc (Integer)
           408 => ( Parameter_Integer, 0 ),   --  : nhhnirbn (Integer)
           409 => ( Parameter_Integer, 0 ),   --  : nhhothbn (Integer)
           410 => ( Parameter_Float, 0.0 ),   --  : seramt1 (Amount)
           411 => ( Parameter_Float, 0.0 ),   --  : seramt2 (Amount)
           412 => ( Parameter_Float, 0.0 ),   --  : seramt3 (Amount)
           413 => ( Parameter_Float, 0.0 ),   --  : seramt4 (Amount)
           414 => ( Parameter_Integer, 0 ),   --  : serpay1 (Integer)
           415 => ( Parameter_Integer, 0 ),   --  : serpay2 (Integer)
           416 => ( Parameter_Integer, 0 ),   --  : serpay3 (Integer)
           417 => ( Parameter_Integer, 0 ),   --  : serpay4 (Integer)
           418 => ( Parameter_Integer, 0 ),   --  : serper1 (Integer)
           419 => ( Parameter_Integer, 0 ),   --  : serper2 (Integer)
           420 => ( Parameter_Integer, 0 ),   --  : serper3 (Integer)
           421 => ( Parameter_Integer, 0 ),   --  : serper4 (Integer)
           422 => ( Parameter_Integer, 0 ),   --  : utility (Integer)
           423 => ( Parameter_Integer, 0 ),   --  : hheth (Integer)
           424 => ( Parameter_Float, 0.0 ),   --  : seramt5 (Amount)
           425 => ( Parameter_Integer, 0 ),   --  : sercomb (Integer)
           426 => ( Parameter_Integer, 0 ),   --  : serpay5 (Integer)
           427 => ( Parameter_Integer, 0 ),   --  : serper5 (Integer)
           428 => ( Parameter_Integer, 0 ),   --  : urbni (Integer)
           429 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           430 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           431 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           432 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : acorn (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : bedroom (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : benunits (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : billrate (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : busroom (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : centfuel (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : centheat (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : charge1 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : charge2 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : charge3 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : charge4 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : charge5 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : charge6 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : charge7 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : charge8 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : charge9 (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : chins (Integer)
           22 => ( Parameter_Float, 0.0 ),   --  : chrgamt1 (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : chrgamt2 (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : chrgamt3 (Amount)
           25 => ( Parameter_Float, 0.0 ),   --  : chrgamt4 (Amount)
           26 => ( Parameter_Float, 0.0 ),   --  : chrgamt5 (Amount)
           27 => ( Parameter_Float, 0.0 ),   --  : chrgamt6 (Amount)
           28 => ( Parameter_Float, 0.0 ),   --  : chrgamt7 (Amount)
           29 => ( Parameter_Float, 0.0 ),   --  : chrgamt8 (Amount)
           30 => ( Parameter_Float, 0.0 ),   --  : chrgamt9 (Amount)
           31 => ( Parameter_Integer, 0 ),   --  : chrgpd1 (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : chrgpd2 (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : chrgpd3 (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : chrgpd4 (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : chrgpd5 (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : chrgpd6 (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : chrgpd7 (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : chrgpd8 (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : chrgpd9 (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : contv1 (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : contv2 (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : covoths (Integer)
           43 => ( Parameter_Float, 0.0 ),   --  : csewamt (Amount)
           44 => ( Parameter_Float, 0.0 ),   --  : csewamt1 (Amount)
           45 => ( Parameter_Integer, 0 ),   --  : ct25d50d (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : ctamt (Integer)
           47 => ( Parameter_Float, 0.0 ),   --  : ctannual (Amount)
           48 => ( Parameter_Integer, 0 ),   --  : ctband (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : ctbwait (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : ctcondoc (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : ctdisc (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : ctinstal (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : ctlvband (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : ctlvchk (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : ctreb (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : ctrebamt (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : ctrebpd (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : cttime (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : cwatamt (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : cwatamt1 (Integer)
           61 => ( Parameter_Date, Clock ),   --  : datyrago (Ada.Calendar.Time)
           62 => ( Parameter_Integer, 0 ),   --  : entry1 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : entry2 (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : entry3 (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : entry4 (Integer)
           66 => ( Parameter_Float, 0.0 ),   --  : estrtann (Amount)
           67 => ( Parameter_Integer, 0 ),   --  : floor (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : givehelp (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : gor (Integer)
           70 => ( Parameter_Integer, 0 ),   --  : gvtregn (Integer)
           71 => ( Parameter_Integer, 0 ),   --  : hhldr01 (Integer)
           72 => ( Parameter_Integer, 0 ),   --  : hhldr02 (Integer)
           73 => ( Parameter_Integer, 0 ),   --  : hhldr03 (Integer)
           74 => ( Parameter_Integer, 0 ),   --  : hhldr04 (Integer)
           75 => ( Parameter_Integer, 0 ),   --  : hhldr05 (Integer)
           76 => ( Parameter_Integer, 0 ),   --  : hhldr06 (Integer)
           77 => ( Parameter_Integer, 0 ),   --  : hhldr07 (Integer)
           78 => ( Parameter_Integer, 0 ),   --  : hhldr08 (Integer)
           79 => ( Parameter_Integer, 0 ),   --  : hhldr09 (Integer)
           80 => ( Parameter_Integer, 0 ),   --  : hhldr10 (Integer)
           81 => ( Parameter_Integer, 0 ),   --  : hhldr11 (Integer)
           82 => ( Parameter_Integer, 0 ),   --  : hhldr12 (Integer)
           83 => ( Parameter_Integer, 0 ),   --  : hhldr13 (Integer)
           84 => ( Parameter_Integer, 0 ),   --  : hhldr14 (Integer)
           85 => ( Parameter_Integer, 0 ),   --  : hhldr97 (Integer)
           86 => ( Parameter_Integer, 0 ),   --  : hhstat (Integer)
           87 => ( Parameter_Integer, 0 ),   --  : hrpnum (Integer)
           88 => ( Parameter_Date, Clock ),   --  : intdate (Ada.Calendar.Time)
           89 => ( Parameter_Integer, 0 ),   --  : lac (Integer)
           90 => ( Parameter_Integer, 0 ),   --  : mainacc (Integer)
           91 => ( Parameter_Integer, 0 ),   --  : mnthcode (Integer)
           92 => ( Parameter_Integer, 0 ),   --  : modcon01 (Integer)
           93 => ( Parameter_Integer, 0 ),   --  : modcon02 (Integer)
           94 => ( Parameter_Integer, 0 ),   --  : modcon03 (Integer)
           95 => ( Parameter_Integer, 0 ),   --  : modcon04 (Integer)
           96 => ( Parameter_Integer, 0 ),   --  : modcon05 (Integer)
           97 => ( Parameter_Integer, 0 ),   --  : modcon06 (Integer)
           98 => ( Parameter_Integer, 0 ),   --  : modcon07 (Integer)
           99 => ( Parameter_Integer, 0 ),   --  : modcon08 (Integer)
           100 => ( Parameter_Integer, 0 ),   --  : modcon09 (Integer)
           101 => ( Parameter_Integer, 0 ),   --  : modcon10 (Integer)
           102 => ( Parameter_Integer, 0 ),   --  : modcon11 (Integer)
           103 => ( Parameter_Integer, 0 ),   --  : modcon12 (Integer)
           104 => ( Parameter_Integer, 0 ),   --  : modcon13 (Integer)
           105 => ( Parameter_Integer, 0 ),   --  : modcon14 (Integer)
           106 => ( Parameter_Integer, 0 ),   --  : monlive (Integer)
           107 => ( Parameter_Integer, 0 ),   --  : needhelp (Integer)
           108 => ( Parameter_Integer, 0 ),   --  : nicoun (Integer)
           109 => ( Parameter_Float, 0.0 ),   --  : ninrv (Amount)
           110 => ( Parameter_Integer, 0 ),   --  : nirate (Integer)
           111 => ( Parameter_Integer, 0 ),   --  : norate (Integer)
           112 => ( Parameter_Integer, 0 ),   --  : onbsroom (Integer)
           113 => ( Parameter_Float, 0.0 ),   --  : orgsewam (Amount)
           114 => ( Parameter_Float, 0.0 ),   --  : orgwatam (Amount)
           115 => ( Parameter_Integer, 0 ),   --  : payrate (Integer)
           116 => ( Parameter_Integer, 0 ),   --  : premium (Integer)
           117 => ( Parameter_Integer, 0 ),   --  : ptbsroom (Integer)
           118 => ( Parameter_Integer, 0 ),   --  : rooms (Integer)
           119 => ( Parameter_Integer, 0 ),   --  : roomshar (Integer)
           120 => ( Parameter_Float, 0.0 ),   --  : rtannual (Amount)
           121 => ( Parameter_Float, 0.0 ),   --  : rtcheck (Amount)
           122 => ( Parameter_Integer, 0 ),   --  : rtcondoc (Integer)
           123 => ( Parameter_Integer, 0 ),   --  : rtdeduc (Integer)
           124 => ( Parameter_Integer, 0 ),   --  : rtinstal (Integer)
           125 => ( Parameter_Integer, 0 ),   --  : rtreb (Integer)
           126 => ( Parameter_Float, 0.0 ),   --  : rtrebamt (Amount)
           127 => ( Parameter_Integer, 0 ),   --  : rtrebpd (Integer)
           128 => ( Parameter_Integer, 0 ),   --  : rttime (Integer)
           129 => ( Parameter_Integer, 0 ),   --  : sampqtr (Integer)
           130 => ( Parameter_Integer, 0 ),   --  : schmeal (Integer)
           131 => ( Parameter_Integer, 0 ),   --  : schmilk (Integer)
           132 => ( Parameter_Float, 0.0 ),   --  : sewamt (Amount)
           133 => ( Parameter_Float, 0.0 ),   --  : sewanul (Amount)
           134 => ( Parameter_Integer, 0 ),   --  : sewerpay (Integer)
           135 => ( Parameter_Integer, 0 ),   --  : sewsep (Integer)
           136 => ( Parameter_Integer, 0 ),   --  : sewtime (Integer)
           137 => ( Parameter_Integer, 0 ),   --  : shelter (Integer)
           138 => ( Parameter_Integer, 0 ),   --  : sobuy (Integer)
           139 => ( Parameter_Integer, 0 ),   --  : sstrtreg (Integer)
           140 => ( Parameter_Float, 0.0 ),   --  : stramt1 (Amount)
           141 => ( Parameter_Float, 0.0 ),   --  : stramt2 (Amount)
           142 => ( Parameter_Integer, 0 ),   --  : strcov (Integer)
           143 => ( Parameter_Integer, 0 ),   --  : strmort (Integer)
           144 => ( Parameter_Integer, 0 ),   --  : stroths (Integer)
           145 => ( Parameter_Integer, 0 ),   --  : strpd1 (Integer)
           146 => ( Parameter_Integer, 0 ),   --  : strpd2 (Integer)
           147 => ( Parameter_Integer, 0 ),   --  : suballow (Integer)
           148 => ( Parameter_Integer, 0 ),   --  : sublet (Integer)
           149 => ( Parameter_Integer, 0 ),   --  : sublety (Integer)
           150 => ( Parameter_Float, 0.0 ),   --  : subrent (Amount)
           151 => ( Parameter_Integer, 0 ),   --  : tenure (Integer)
           152 => ( Parameter_Integer, 0 ),   --  : totadult (Integer)
           153 => ( Parameter_Integer, 0 ),   --  : totchild (Integer)
           154 => ( Parameter_Integer, 0 ),   --  : totdepdk (Integer)
           155 => ( Parameter_Integer, 0 ),   --  : tvlic (Integer)
           156 => ( Parameter_Integer, 0 ),   --  : typeacc (Integer)
           157 => ( Parameter_Integer, 0 ),   --  : usevcl (Integer)
           158 => ( Parameter_Float, 0.0 ),   --  : watamt (Amount)
           159 => ( Parameter_Float, 0.0 ),   --  : watanul (Amount)
           160 => ( Parameter_Integer, 0 ),   --  : watermet (Integer)
           161 => ( Parameter_Integer, 0 ),   --  : waterpay (Integer)
           162 => ( Parameter_Integer, 0 ),   --  : watrb (Integer)
           163 => ( Parameter_Integer, 0 ),   --  : wattime (Integer)
           164 => ( Parameter_Integer, 0 ),   --  : welfmilk (Integer)
           165 => ( Parameter_Integer, 0 ),   --  : whoctb01 (Integer)
           166 => ( Parameter_Integer, 0 ),   --  : whoctb02 (Integer)
           167 => ( Parameter_Integer, 0 ),   --  : whoctb03 (Integer)
           168 => ( Parameter_Integer, 0 ),   --  : whoctb04 (Integer)
           169 => ( Parameter_Integer, 0 ),   --  : whoctb05 (Integer)
           170 => ( Parameter_Integer, 0 ),   --  : whoctb06 (Integer)
           171 => ( Parameter_Integer, 0 ),   --  : whoctb07 (Integer)
           172 => ( Parameter_Integer, 0 ),   --  : whoctb08 (Integer)
           173 => ( Parameter_Integer, 0 ),   --  : whoctb09 (Integer)
           174 => ( Parameter_Integer, 0 ),   --  : whoctb10 (Integer)
           175 => ( Parameter_Integer, 0 ),   --  : whoctb11 (Integer)
           176 => ( Parameter_Integer, 0 ),   --  : whoctb12 (Integer)
           177 => ( Parameter_Integer, 0 ),   --  : whoctb13 (Integer)
           178 => ( Parameter_Integer, 0 ),   --  : whoctb14 (Integer)
           179 => ( Parameter_Integer, 0 ),   --  : whoctbns (Integer)
           180 => ( Parameter_Integer, 0 ),   --  : whoctbot (Integer)
           181 => ( Parameter_Integer, 0 ),   --  : whorsp01 (Integer)
           182 => ( Parameter_Integer, 0 ),   --  : whorsp02 (Integer)
           183 => ( Parameter_Integer, 0 ),   --  : whorsp03 (Integer)
           184 => ( Parameter_Integer, 0 ),   --  : whorsp04 (Integer)
           185 => ( Parameter_Integer, 0 ),   --  : whorsp05 (Integer)
           186 => ( Parameter_Integer, 0 ),   --  : whorsp06 (Integer)
           187 => ( Parameter_Integer, 0 ),   --  : whorsp07 (Integer)
           188 => ( Parameter_Integer, 0 ),   --  : whorsp08 (Integer)
           189 => ( Parameter_Integer, 0 ),   --  : whorsp09 (Integer)
           190 => ( Parameter_Integer, 0 ),   --  : whorsp10 (Integer)
           191 => ( Parameter_Integer, 0 ),   --  : whorsp11 (Integer)
           192 => ( Parameter_Integer, 0 ),   --  : whorsp12 (Integer)
           193 => ( Parameter_Integer, 0 ),   --  : whorsp13 (Integer)
           194 => ( Parameter_Integer, 0 ),   --  : whorsp14 (Integer)
           195 => ( Parameter_Integer, 0 ),   --  : whynoct (Integer)
           196 => ( Parameter_Integer, 0 ),   --  : wmintro (Integer)
           197 => ( Parameter_Float, 0.0 ),   --  : wsewamt (Amount)
           198 => ( Parameter_Float, 0.0 ),   --  : wsewanul (Amount)
           199 => ( Parameter_Integer, 0 ),   --  : wsewtime (Integer)
           200 => ( Parameter_Integer, 0 ),   --  : yearcode (Integer)
           201 => ( Parameter_Integer, 0 ),   --  : yearlive (Integer)
           202 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           203 => ( Parameter_Integer, 0 ),   --  : actacch (Integer)
           204 => ( Parameter_Integer, 0 ),   --  : adddahh (Integer)
           205 => ( Parameter_Integer, 0 ),   --  : adulth (Integer)
           206 => ( Parameter_Integer, 0 ),   --  : basacth (Integer)
           207 => ( Parameter_Integer, 0 ),   --  : chddahh (Integer)
           208 => ( Parameter_Integer, 0 ),   --  : curacth (Integer)
           209 => ( Parameter_Integer, 0 ),   --  : cwatamtd (Integer)
           210 => ( Parameter_Integer, 0 ),   --  : depchldh (Integer)
           211 => ( Parameter_Integer, 0 ),   --  : emp (Integer)
           212 => ( Parameter_Integer, 0 ),   --  : emphrp (Integer)
           213 => ( Parameter_Float, 0.0 ),   --  : endowpay (Amount)
           214 => ( Parameter_Float, 0.0 ),   --  : equivahc (Amount)
           215 => ( Parameter_Float, 0.0 ),   --  : equivbhc (Amount)
           216 => ( Parameter_Integer, 0 ),   --  : fsbndcth (Integer)
           217 => ( Parameter_Integer, 0 ),   --  : gbhscost (Integer)
           218 => ( Parameter_Integer, 0 ),   --  : gebacth (Integer)
           219 => ( Parameter_Integer, 0 ),   --  : giltcth (Integer)
           220 => ( Parameter_Integer, 0 ),   --  : gross2 (Integer)
           221 => ( Parameter_Integer, 0 ),   --  : gross3 (Integer)
           222 => ( Parameter_Integer, 0 ),   --  : grossct (Integer)
           223 => ( Parameter_Integer, 0 ),   --  : hbeninc (Integer)
           224 => ( Parameter_Integer, 0 ),   --  : hbindhh (Integer)
           225 => ( Parameter_Integer, 0 ),   --  : hcband (Integer)
           226 => ( Parameter_Integer, 0 ),   --  : hdhhinc (Integer)
           227 => ( Parameter_Integer, 0 ),   --  : hdtax (Integer)
           228 => ( Parameter_Float, 0.0 ),   --  : hearns (Amount)
           229 => ( Parameter_Integer, 0 ),   --  : hhagegr2 (Integer)
           230 => ( Parameter_Integer, 0 ),   --  : hhagegrp (Integer)
           231 => ( Parameter_Integer, 0 ),   --  : hhcomp (Integer)
           232 => ( Parameter_Integer, 0 ),   --  : hhcomps (Integer)
           233 => ( Parameter_Integer, 0 ),   --  : hhdisben (Integer)
           234 => ( Parameter_Integer, 0 ),   --  : hhethgr2 (Integer)
           235 => ( Parameter_Integer, 0 ),   --  : hhethgrp (Integer)
           236 => ( Parameter_Integer, 0 ),   --  : hhinc (Integer)
           237 => ( Parameter_Integer, 0 ),   --  : hhincbnd (Integer)
           238 => ( Parameter_Float, 0.0 ),   --  : hhinv (Amount)
           239 => ( Parameter_Integer, 0 ),   --  : hhirben (Integer)
           240 => ( Parameter_Integer, 0 ),   --  : hhkids (Integer)
           241 => ( Parameter_Integer, 0 ),   --  : hhnirben (Integer)
           242 => ( Parameter_Integer, 0 ),   --  : hhothben (Integer)
           243 => ( Parameter_Integer, 0 ),   --  : hhrent (Integer)
           244 => ( Parameter_Float, 0.0 ),   --  : hhrinc (Amount)
           245 => ( Parameter_Float, 0.0 ),   --  : hhrpinc (Amount)
           246 => ( Parameter_Integer, 0 ),   --  : hhsize (Integer)
           247 => ( Parameter_Float, 0.0 ),   --  : hhtvlic (Amount)
           248 => ( Parameter_Float, 0.0 ),   --  : hhtxcred (Amount)
           249 => ( Parameter_Float, 0.0 ),   --  : hothinc (Amount)
           250 => ( Parameter_Float, 0.0 ),   --  : hpeninc (Amount)
           251 => ( Parameter_Integer, 0 ),   --  : hrband (Integer)
           252 => ( Parameter_Float, 0.0 ),   --  : hseinc (Amount)
           253 => ( Parameter_Integer, 0 ),   --  : isacth (Integer)
           254 => ( Parameter_Integer, 0 ),   --  : london (Integer)
           255 => ( Parameter_Float, 0.0 ),   --  : mortcost (Amount)
           256 => ( Parameter_Float, 0.0 ),   --  : mortint (Amount)
           257 => ( Parameter_Float, 0.0 ),   --  : mortpay (Amount)
           258 => ( Parameter_Float, 0.0 ),   --  : nddctb (Amount)
           259 => ( Parameter_Float, 0.0 ),   --  : nddishc (Amount)
           260 => ( Parameter_Integer, 0 ),   --  : nihscost (Integer)
           261 => ( Parameter_Integer, 0 ),   --  : nsbocth (Integer)
           262 => ( Parameter_Integer, 0 ),   --  : otbscth (Integer)
           263 => ( Parameter_Integer, 0 ),   --  : pacctype (Integer)
           264 => ( Parameter_Integer, 0 ),   --  : penage (Integer)
           265 => ( Parameter_Integer, 0 ),   --  : penhrp (Integer)
           266 => ( Parameter_Integer, 0 ),   --  : pepscth (Integer)
           267 => ( Parameter_Integer, 0 ),   --  : poaccth (Integer)
           268 => ( Parameter_Integer, 0 ),   --  : prbocth (Integer)
           269 => ( Parameter_Integer, 0 ),   --  : ptentyp2 (Integer)
           270 => ( Parameter_Integer, 0 ),   --  : sayecth (Integer)
           271 => ( Parameter_Integer, 0 ),   --  : sclbcth (Integer)
           272 => ( Parameter_Float, 0.0 ),   --  : servpay (Amount)
           273 => ( Parameter_Integer, 0 ),   --  : sick (Integer)
           274 => ( Parameter_Integer, 0 ),   --  : sickhrp (Integer)
           275 => ( Parameter_Integer, 0 ),   --  : sscth (Integer)
           276 => ( Parameter_Float, 0.0 ),   --  : struins (Amount)
           277 => ( Parameter_Integer, 0 ),   --  : stshcth (Integer)
           278 => ( Parameter_Integer, 0 ),   --  : tentyp2 (Integer)
           279 => ( Parameter_Integer, 0 ),   --  : tesscth (Integer)
           280 => ( Parameter_Float, 0.0 ),   --  : tuhhrent (Amount)
           281 => ( Parameter_Float, 0.0 ),   --  : tuwatsew (Amount)
           282 => ( Parameter_Integer, 0 ),   --  : untrcth (Integer)
           283 => ( Parameter_Float, 0.0 ),   --  : watsewrt (Amount)
           284 => ( Parameter_Integer, 0 ),   --  : acornew (Integer)
           285 => ( Parameter_Integer, 0 ),   --  : crunach (Integer)
           286 => ( Parameter_Integer, 0 ),   --  : enomorth (Integer)
           287 => ( Parameter_Integer, 0 ),   --  : dvadulth (Integer)
           288 => ( Parameter_Integer, 0 ),   --  : dvtotad (Integer)
           289 => ( Parameter_Integer, 0 ),   --  : urindew (Integer)
           290 => ( Parameter_Integer, 0 ),   --  : urinds (Integer)
           291 => ( Parameter_Integer, 0 ),   --  : vehnumb (Integer)
           292 => ( Parameter_Integer, 0 ),   --  : country (Integer)
           293 => ( Parameter_Integer, 0 ),   --  : hbindhh2 (Integer)
           294 => ( Parameter_Integer, 0 ),   --  : pocardh (Integer)
           295 => ( Parameter_Integer, 0 ),   --  : entry5 (Integer)
           296 => ( Parameter_Integer, 0 ),   --  : entry6 (Integer)
           297 => ( Parameter_Integer, 0 ),   --  : imd_e (Integer)
           298 => ( Parameter_Integer, 0 ),   --  : imd_s (Integer)
           299 => ( Parameter_Integer, 0 ),   --  : imd_w (Integer)
           300 => ( Parameter_Integer, 0 ),   --  : numtv1 (Integer)
           301 => ( Parameter_Integer, 0 ),   --  : numtv2 (Integer)
           302 => ( Parameter_Integer, 0 ),   --  : oac (Integer)
           303 => ( Parameter_Integer, 0 ),   --  : bedroom6 (Integer)
           304 => ( Parameter_Integer, 0 ),   --  : rooms10 (Integer)
           305 => ( Parameter_Integer, 0 ),   --  : brma (Integer)
           306 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           307 => ( Parameter_Integer, 0 ),   --  : migrq1 (Integer)
           308 => ( Parameter_Integer, 0 ),   --  : migrq2 (Integer)
           309 => ( Parameter_Integer, 0 ),   --  : hhagegr3 (Integer)
           310 => ( Parameter_Integer, 0 ),   --  : hhagegr4 (Integer)
           311 => ( Parameter_Integer, 0 ),   --  : capval (Integer)
           312 => ( Parameter_Integer, 0 ),   --  : nidpnd (Integer)
           313 => ( Parameter_Integer, 0 ),   --  : nochcr1 (Integer)
           314 => ( Parameter_Integer, 0 ),   --  : nochcr2 (Integer)
           315 => ( Parameter_Integer, 0 ),   --  : nochcr3 (Integer)
           316 => ( Parameter_Integer, 0 ),   --  : nochcr4 (Integer)
           317 => ( Parameter_Integer, 0 ),   --  : nochcr5 (Integer)
           318 => ( Parameter_Float, 0.0 ),   --  : rt2rebam (Amount)
           319 => ( Parameter_Integer, 0 ),   --  : rt2rebpd (Integer)
           320 => ( Parameter_Integer, 0 ),   --  : rtdpa (Integer)
           321 => ( Parameter_Float, 0.0 ),   --  : rtdpaamt (Amount)
           322 => ( Parameter_Integer, 0 ),   --  : rtdpapd (Integer)
           323 => ( Parameter_Integer, 0 ),   --  : rtlpa (Integer)
           324 => ( Parameter_Float, 0.0 ),   --  : rtlpaamt (Amount)
           325 => ( Parameter_Integer, 0 ),   --  : rtlpapd (Integer)
           326 => ( Parameter_Float, 0.0 ),   --  : rtothamt (Amount)
           327 => ( Parameter_Integer, 0 ),   --  : rtother (Integer)
           328 => ( Parameter_Integer, 0 ),   --  : rtothpd (Integer)
           329 => ( Parameter_Integer, 0 ),   --  : rtrtr (Integer)
           330 => ( Parameter_Float, 0.0 ),   --  : rtrtramt (Amount)
           331 => ( Parameter_Integer, 0 ),   --  : rtrtrpd (Integer)
           332 => ( Parameter_Integer, 0 ),   --  : rttimepd (Integer)
           333 => ( Parameter_Integer, 0 ),   --  : yrlvchk (Integer)
           334 => ( Parameter_Integer, 0 ),   --  : gross3_x (Integer)
           335 => ( Parameter_Integer, 0 ),   --  : hlthst (Integer)
           336 => ( Parameter_Integer, 0 ),   --  : medpay (Integer)
           337 => ( Parameter_Integer, 0 ),   --  : medwho01 (Integer)
           338 => ( Parameter_Integer, 0 ),   --  : medwho02 (Integer)
           339 => ( Parameter_Integer, 0 ),   --  : medwho03 (Integer)
           340 => ( Parameter_Integer, 0 ),   --  : medwho04 (Integer)
           341 => ( Parameter_Integer, 0 ),   --  : medwho05 (Integer)
           342 => ( Parameter_Integer, 0 ),   --  : medwho06 (Integer)
           343 => ( Parameter_Integer, 0 ),   --  : medwho07 (Integer)
           344 => ( Parameter_Integer, 0 ),   --  : medwho08 (Integer)
           345 => ( Parameter_Integer, 0 ),   --  : medwho09 (Integer)
           346 => ( Parameter_Integer, 0 ),   --  : medwho10 (Integer)
           347 => ( Parameter_Integer, 0 ),   --  : medwho11 (Integer)
           348 => ( Parameter_Integer, 0 ),   --  : medwho12 (Integer)
           349 => ( Parameter_Integer, 0 ),   --  : medwho13 (Integer)
           350 => ( Parameter_Integer, 0 ),   --  : medwho14 (Integer)
           351 => ( Parameter_Integer, 0 ),   --  : nmrmshar (Integer)
           352 => ( Parameter_Integer, 0 ),   --  : roomshr (Integer)
           353 => ( Parameter_Integer, 0 ),   --  : imd_ni (Integer)
           354 => ( Parameter_Integer, 0 ),   --  : multi (Integer)
           355 => ( Parameter_Integer, 0 ),   --  : nopay (Integer)
           356 => ( Parameter_Integer, 0 ),   --  : orgid (Integer)
           357 => ( Parameter_Integer, 0 ),   --  : rtene (Integer)
           358 => ( Parameter_Integer, 0 ),   --  : rteneamt (Integer)
           359 => ( Parameter_Integer, 0 ),   --  : rtgen (Integer)
           360 => ( Parameter_Integer, 0 ),   --  : schbrk (Integer)
           361 => ( Parameter_Integer, 0 ),   --  : urb (Integer)
           362 => ( Parameter_Integer, 0 ),   --  : urbrur (Integer)
           363 => ( Parameter_Integer, 0 ),   --  : hhethgr3 (Integer)
           364 => ( Parameter_Float, 0.0 ),   --  : niratlia (Amount)
           365 => ( Parameter_Integer, 0 ),   --  : bankse (Integer)
           366 => ( Parameter_Integer, 0 ),   --  : bathshow (Integer)
           367 => ( Parameter_Integer, 0 ),   --  : burden (Integer)
           368 => ( Parameter_Integer, 0 ),   --  : comco (Integer)
           369 => ( Parameter_Integer, 0 ),   --  : comp1sc (Integer)
           370 => ( Parameter_Integer, 0 ),   --  : compsc (Integer)
           371 => ( Parameter_Integer, 0 ),   --  : comwa (Integer)
           372 => ( Parameter_Integer, 0 ),   --  : dwellno (Integer)
           373 => ( Parameter_Integer, 0 ),   --  : elecin (Integer)
           374 => ( Parameter_Integer, 0 ),   --  : elecinw (Integer)
           375 => ( Parameter_Float, 0.0 ),   --  : eulowest (Amount)
           376 => ( Parameter_Integer, 0 ),   --  : flshtoil (Integer)
           377 => ( Parameter_Integer, 0 ),   --  : grocse (Integer)
           378 => ( Parameter_Integer, 0 ),   --  : gvtregno (Integer)
           379 => ( Parameter_Integer, 0 ),   --  : heat (Integer)
           380 => ( Parameter_Integer, 0 ),   --  : heatcen (Integer)
           381 => ( Parameter_Integer, 0 ),   --  : heatfire (Integer)
           382 => ( Parameter_Integer, 0 ),   --  : kitchen (Integer)
           383 => ( Parameter_Integer, 0 ),   --  : knsizeft (Integer)
           384 => ( Parameter_Integer, 0 ),   --  : knsizem (Integer)
           385 => ( Parameter_Integer, 0 ),   --  : laua (Integer)
           386 => ( Parameter_Integer, 0 ),   --  : movef (Integer)
           387 => ( Parameter_Integer, 0 ),   --  : movenxt (Integer)
           388 => ( Parameter_Integer, 0 ),   --  : movereas (Integer)
           389 => ( Parameter_Integer, 0 ),   --  : ovsat (Integer)
           390 => ( Parameter_Integer, 0 ),   --  : plum1bin (Integer)
           391 => ( Parameter_Integer, 0 ),   --  : plumin (Integer)
           392 => ( Parameter_Integer, 0 ),   --  : pluminw (Integer)
           393 => ( Parameter_Integer, 0 ),   --  : postse (Integer)
           394 => ( Parameter_Integer, 0 ),   --  : primh (Integer)
           395 => ( Parameter_Integer, 0 ),   --  : pubtr (Integer)
           396 => ( Parameter_Integer, 0 ),   --  : samesc (Integer)
           397 => ( Parameter_Integer, 0 ),   --  : schfrt (Integer)
           398 => ( Parameter_Integer, 0 ),   --  : selper (Integer)
           399 => ( Parameter_Integer, 0 ),   --  : short (Integer)
           400 => ( Parameter_Integer, 0 ),   --  : sizeft (Integer)
           401 => ( Parameter_Integer, 0 ),   --  : sizem (Integer)
           402 => ( Parameter_Integer, 0 ),   --  : tvwhy (Integer)
           403 => ( Parameter_Integer, 0 ),   --  : yearwhc (Integer)
           404 => ( Parameter_Integer, 0 ),   --  : dischha1 (Integer)
           405 => ( Parameter_Integer, 0 ),   --  : dischhc1 (Integer)
           406 => ( Parameter_Integer, 0 ),   --  : diswhha1 (Integer)
           407 => ( Parameter_Integer, 0 ),   --  : diswhhc1 (Integer)
           408 => ( Parameter_Integer, 0 ),   --  : gross4 (Integer)
           409 => ( Parameter_Integer, 0 ),   --  : lldcare (Integer)
           410 => ( Parameter_Integer, 0 ),   --  : urindni (Integer)
           411 => ( Parameter_Integer, 0 ),   --  : nhbeninc (Integer)
           412 => ( Parameter_Integer, 0 ),   --  : nhhnirbn (Integer)
           413 => ( Parameter_Integer, 0 ),   --  : nhhothbn (Integer)
           414 => ( Parameter_Float, 0.0 ),   --  : seramt1 (Amount)
           415 => ( Parameter_Float, 0.0 ),   --  : seramt2 (Amount)
           416 => ( Parameter_Float, 0.0 ),   --  : seramt3 (Amount)
           417 => ( Parameter_Float, 0.0 ),   --  : seramt4 (Amount)
           418 => ( Parameter_Integer, 0 ),   --  : serpay1 (Integer)
           419 => ( Parameter_Integer, 0 ),   --  : serpay2 (Integer)
           420 => ( Parameter_Integer, 0 ),   --  : serpay3 (Integer)
           421 => ( Parameter_Integer, 0 ),   --  : serpay4 (Integer)
           422 => ( Parameter_Integer, 0 ),   --  : serper1 (Integer)
           423 => ( Parameter_Integer, 0 ),   --  : serper2 (Integer)
           424 => ( Parameter_Integer, 0 ),   --  : serper3 (Integer)
           425 => ( Parameter_Integer, 0 ),   --  : serper4 (Integer)
           426 => ( Parameter_Integer, 0 ),   --  : utility (Integer)
           427 => ( Parameter_Integer, 0 ),   --  : hheth (Integer)
           428 => ( Parameter_Float, 0.0 ),   --  : seramt5 (Amount)
           429 => ( Parameter_Integer, 0 ),   --  : sercomb (Integer)
           430 => ( Parameter_Integer, 0 ),   --  : serpay5 (Integer)
           431 => ( Parameter_Integer, 0 ),   --  : serper5 (Integer)
           432 => ( Parameter_Integer, 0 )   --  : urbni (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $100, $101, $102, $103, $104, $105, $106, $107, $108, $109, $110, $111, $112, $113, $114, $115, $116, $117, $118, $119, $120, $121, $122, $123, $124, $125, $126, $127, $128, $129, $130, $131, $132, $133, $134, $135, $136, $137, $138, $139, $140, $141, $142, $143, $144, $145, $146, $147, $148, $149, $150, $151, $152, $153, $154, $155, $156, $157, $158, $159, $160, $161, $162, $163, $164, $165, $166, $167, $168, $169, $170, $171, $172, $173, $174, $175, $176, $177, $178, $179, $180, $181, $182, $183, $184, $185, $186, $187, $188, $189, $190, $191, $192, $193, $194, $195, $196, $197, $198, $199, $200, $201, $202, $203, $204, $205, $206, $207, $208, $209, $210, $211, $212, $213, $214, $215, $216, $217, $218, $219, $220, $221, $222, $223, $224, $225, $226, $227, $228, $229, $230, $231, $232, $233, $234, $235, $236, $237, $238, $239, $240, $241, $242, $243, $244, $245, $246, $247, $248, $249, $250, $251, $252, $253, $254, $255, $256, $257, $258, $259, $260, $261, $262, $263, $264, $265, $266, $267, $268, $269, $270, $271, $272, $273, $274, $275, $276, $277, $278, $279, $280, $281, $282, $283, $284, $285, $286, $287, $288, $289, $290, $291, $292, $293, $294, $295, $296, $297, $298, $299, $300, $301, $302, $303, $304, $305, $306, $307, $308, $309, $310, $311, $312, $313, $314, $315, $316, $317, $318, $319, $320, $321, $322, $323, $324, $325, $326, $327, $328, $329, $330, $331, $332, $333, $334, $335, $336, $337, $338, $339, $340, $341, $342, $343, $344, $345, $346, $347, $348, $349, $350, $351, $352, $353, $354, $355, $356, $357, $358, $359, $360, $361, $362, $363, $364, $365, $366, $367, $368, $369, $370, $371, $372, $373, $374, $375, $376, $377, $378, $379, $380, $381, $382, $383, $384, $385, $386, $387, $388, $389, $390, $391, $392, $393, $394, $395, $396, $397, $398, $399, $400, $401, $402, $403, $404, $405, $406, $407, $408, $409, $410, $411, $412, $413, $414, $415, $416, $417, $418, $419, $420, $421, $422, $423, $424, $425, $426, $427, $428, $429, $430, $431, $432 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 4 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 )   --  : sernum (Sernum_Value)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and sernum = $4"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " acorn = $1, bedroom = $2, benunits = $3, billrate = $4, busroom = $5, centfuel = $6, centheat = $7, charge1 = $8, charge2 = $9, charge3 = $10, charge4 = $11, charge5 = $12, charge6 = $13, charge7 = $14, charge8 = $15, charge9 = $16, chins = $17, chrgamt1 = $18, chrgamt2 = $19, chrgamt3 = $20, chrgamt4 = $21, chrgamt5 = $22, chrgamt6 = $23, chrgamt7 = $24, chrgamt8 = $25, chrgamt9 = $26, chrgpd1 = $27, chrgpd2 = $28, chrgpd3 = $29, chrgpd4 = $30, chrgpd5 = $31, chrgpd6 = $32, chrgpd7 = $33, chrgpd8 = $34, chrgpd9 = $35, contv1 = $36, contv2 = $37, covoths = $38, csewamt = $39, csewamt1 = $40, ct25d50d = $41, ctamt = $42, ctannual = $43, ctband = $44, ctbwait = $45, ctcondoc = $46, ctdisc = $47, ctinstal = $48, ctlvband = $49, ctlvchk = $50, ctreb = $51, ctrebamt = $52, ctrebpd = $53, cttime = $54, cwatamt = $55, cwatamt1 = $56, datyrago = $57, entry1 = $58, entry2 = $59, entry3 = $60, entry4 = $61, estrtann = $62, floor = $63, givehelp = $64, gor = $65, gvtregn = $66, hhldr01 = $67, hhldr02 = $68, hhldr03 = $69, hhldr04 = $70, hhldr05 = $71, hhldr06 = $72, hhldr07 = $73, hhldr08 = $74, hhldr09 = $75, hhldr10 = $76, hhldr11 = $77, hhldr12 = $78, hhldr13 = $79, hhldr14 = $80, hhldr97 = $81, hhstat = $82, hrpnum = $83, intdate = $84, lac = $85, mainacc = $86, mnthcode = $87, modcon01 = $88, modcon02 = $89, modcon03 = $90, modcon04 = $91, modcon05 = $92, modcon06 = $93, modcon07 = $94, modcon08 = $95, modcon09 = $96, modcon10 = $97, modcon11 = $98, modcon12 = $99, modcon13 = $100, modcon14 = $101, monlive = $102, needhelp = $103, nicoun = $104, ninrv = $105, nirate = $106, norate = $107, onbsroom = $108, orgsewam = $109, orgwatam = $110, payrate = $111, premium = $112, ptbsroom = $113, rooms = $114, roomshar = $115, rtannual = $116, rtcheck = $117, rtcondoc = $118, rtdeduc = $119, rtinstal = $120, rtreb = $121, rtrebamt = $122, rtrebpd = $123, rttime = $124, sampqtr = $125, schmeal = $126, schmilk = $127, sewamt = $128, sewanul = $129, sewerpay = $130, sewsep = $131, sewtime = $132, shelter = $133, sobuy = $134, sstrtreg = $135, stramt1 = $136, stramt2 = $137, strcov = $138, strmort = $139, stroths = $140, strpd1 = $141, strpd2 = $142, suballow = $143, sublet = $144, sublety = $145, subrent = $146, tenure = $147, totadult = $148, totchild = $149, totdepdk = $150, tvlic = $151, typeacc = $152, usevcl = $153, watamt = $154, watanul = $155, watermet = $156, waterpay = $157, watrb = $158, wattime = $159, welfmilk = $160, whoctb01 = $161, whoctb02 = $162, whoctb03 = $163, whoctb04 = $164, whoctb05 = $165, whoctb06 = $166, whoctb07 = $167, whoctb08 = $168, whoctb09 = $169, whoctb10 = $170, whoctb11 = $171, whoctb12 = $172, whoctb13 = $173, whoctb14 = $174, whoctbns = $175, whoctbot = $176, whorsp01 = $177, whorsp02 = $178, whorsp03 = $179, whorsp04 = $180, whorsp05 = $181, whorsp06 = $182, whorsp07 = $183, whorsp08 = $184, whorsp09 = $185, whorsp10 = $186, whorsp11 = $187, whorsp12 = $188, whorsp13 = $189, whorsp14 = $190, whynoct = $191, wmintro = $192, wsewamt = $193, wsewanul = $194, wsewtime = $195, yearcode = $196, yearlive = $197, month = $198, actacch = $199, adddahh = $200, adulth = $201, basacth = $202, chddahh = $203, curacth = $204, cwatamtd = $205, depchldh = $206, emp = $207, emphrp = $208, endowpay = $209, equivahc = $210, equivbhc = $211, fsbndcth = $212, gbhscost = $213, gebacth = $214, giltcth = $215, gross2 = $216, gross3 = $217, grossct = $218, hbeninc = $219, hbindhh = $220, hcband = $221, hdhhinc = $222, hdtax = $223, hearns = $224, hhagegr2 = $225, hhagegrp = $226, hhcomp = $227, hhcomps = $228, hhdisben = $229, hhethgr2 = $230, hhethgrp = $231, hhinc = $232, hhincbnd = $233, hhinv = $234, hhirben = $235, hhkids = $236, hhnirben = $237, hhothben = $238, hhrent = $239, hhrinc = $240, hhrpinc = $241, hhsize = $242, hhtvlic = $243, hhtxcred = $244, hothinc = $245, hpeninc = $246, hrband = $247, hseinc = $248, isacth = $249, london = $250, mortcost = $251, mortint = $252, mortpay = $253, nddctb = $254, nddishc = $255, nihscost = $256, nsbocth = $257, otbscth = $258, pacctype = $259, penage = $260, penhrp = $261, pepscth = $262, poaccth = $263, prbocth = $264, ptentyp2 = $265, sayecth = $266, sclbcth = $267, servpay = $268, sick = $269, sickhrp = $270, sscth = $271, struins = $272, stshcth = $273, tentyp2 = $274, tesscth = $275, tuhhrent = $276, tuwatsew = $277, untrcth = $278, watsewrt = $279, acornew = $280, crunach = $281, enomorth = $282, dvadulth = $283, dvtotad = $284, urindew = $285, urinds = $286, vehnumb = $287, country = $288, hbindhh2 = $289, pocardh = $290, entry5 = $291, entry6 = $292, imd_e = $293, imd_s = $294, imd_w = $295, numtv1 = $296, numtv2 = $297, oac = $298, bedroom6 = $299, rooms10 = $300, brma = $301, issue = $302, migrq1 = $303, migrq2 = $304, hhagegr3 = $305, hhagegr4 = $306, capval = $307, nidpnd = $308, nochcr1 = $309, nochcr2 = $310, nochcr3 = $311, nochcr4 = $312, nochcr5 = $313, rt2rebam = $314, rt2rebpd = $315, rtdpa = $316, rtdpaamt = $317, rtdpapd = $318, rtlpa = $319, rtlpaamt = $320, rtlpapd = $321, rtothamt = $322, rtother = $323, rtothpd = $324, rtrtr = $325, rtrtramt = $326, rtrtrpd = $327, rttimepd = $328, yrlvchk = $329, gross3_x = $330, hlthst = $331, medpay = $332, medwho01 = $333, medwho02 = $334, medwho03 = $335, medwho04 = $336, medwho05 = $337, medwho06 = $338, medwho07 = $339, medwho08 = $340, medwho09 = $341, medwho10 = $342, medwho11 = $343, medwho12 = $344, medwho13 = $345, medwho14 = $346, nmrmshar = $347, roomshr = $348, imd_ni = $349, multi = $350, nopay = $351, orgid = $352, rtene = $353, rteneamt = $354, rtgen = $355, schbrk = $356, urb = $357, urbrur = $358, hhethgr3 = $359, niratlia = $360, bankse = $361, bathshow = $362, burden = $363, comco = $364, comp1sc = $365, compsc = $366, comwa = $367, dwellno = $368, elecin = $369, elecinw = $370, eulowest = $371, flshtoil = $372, grocse = $373, gvtregno = $374, heat = $375, heatcen = $376, heatfire = $377, kitchen = $378, knsizeft = $379, knsizem = $380, laua = $381, movef = $382, movenxt = $383, movereas = $384, ovsat = $385, plum1bin = $386, plumin = $387, pluminw = $388, postse = $389, primh = $390, pubtr = $391, samesc = $392, schfrt = $393, selper = $394, short = $395, sizeft = $396, sizem = $397, tvwhy = $398, yearwhc = $399, dischha1 = $400, dischhc1 = $401, diswhha1 = $402, diswhhc1 = $403, gross4 = $404, lldcare = $405, urindni = $406, nhbeninc = $407, nhhnirbn = $408, nhhothbn = $409, seramt1 = $410, seramt2 = $411, seramt3 = $412, seramt4 = $413, serpay1 = $414, serpay2 = $415, serpay3 = $416, serpay4 = $417, serper1 = $418, serper2 = $419, serper3 = $420, serper4 = $421, utility = $422, hheth = $423, seramt5 = $424, sercomb = $425, serpay5 = $426, serper5 = $427, urbni = $428 where user_id = $429 and edition = $430 and year = $431 and sernum = $432"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.househol", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.househol", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.househol", SCHEMA_NAME );
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


   Next_Free_sernum_query : constant String := 
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.househol", SCHEMA_NAME );
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



   --
   -- returns true if the primary key parts of Ukds.Frs.Househol match the defaults in Ukds.Frs.Null_Househol
   --
   --
   -- Does this Ukds.Frs.Househol equal the default Ukds.Frs.Null_Househol ?
   --
   function Is_Null( a_househol : Househol ) return Boolean is
   begin
      return a_househol = Ukds.Frs.Null_Househol;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Househol matching the primary key fields, or the Ukds.Frs.Null_Househol record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Ukds.Frs.Househol is
      l : Ukds.Frs.Househol_List;
      a_househol : Ukds.Frs.Househol;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Househol_List_Package.is_empty( l ) ) then
         a_househol := Ukds.Frs.Househol_List_Package.First_Element( l );
      else
         a_househol := Ukds.Frs.Null_Househol;
      end if;
      return a_househol;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.househol where user_id = $1 and edition = $2 and year = $3 and sernum = $4", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; connection : Database_Connection := null ) return Boolean  is
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
      params( 4 ) := As_Bigint( sernum );
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Househol matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Househol_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Househol retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Househol is
      a_househol : Ukds.Frs.Househol;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_househol.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_househol.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_househol.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_househol.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_househol.acorn := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_househol.bedroom := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_househol.benunits := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_househol.billrate := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_househol.busroom := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_househol.centfuel := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_househol.centheat := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_househol.charge1 := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_househol.charge2 := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_househol.charge3 := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_househol.charge4 := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_househol.charge5 := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_househol.charge6 := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_househol.charge7 := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_househol.charge8 := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_househol.charge9 := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_househol.chins := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_househol.chrgamt1:= Amount'Value( gse.Value( cursor, 21 ));
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_househol.chrgamt2:= Amount'Value( gse.Value( cursor, 22 ));
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_househol.chrgamt3:= Amount'Value( gse.Value( cursor, 23 ));
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_househol.chrgamt4:= Amount'Value( gse.Value( cursor, 24 ));
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_househol.chrgamt5:= Amount'Value( gse.Value( cursor, 25 ));
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_househol.chrgamt6:= Amount'Value( gse.Value( cursor, 26 ));
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_househol.chrgamt7:= Amount'Value( gse.Value( cursor, 27 ));
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_househol.chrgamt8:= Amount'Value( gse.Value( cursor, 28 ));
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_househol.chrgamt9:= Amount'Value( gse.Value( cursor, 29 ));
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_househol.chrgpd1 := gse.Integer_Value( cursor, 30 );
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_househol.chrgpd2 := gse.Integer_Value( cursor, 31 );
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_househol.chrgpd3 := gse.Integer_Value( cursor, 32 );
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_househol.chrgpd4 := gse.Integer_Value( cursor, 33 );
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_househol.chrgpd5 := gse.Integer_Value( cursor, 34 );
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_househol.chrgpd6 := gse.Integer_Value( cursor, 35 );
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_househol.chrgpd7 := gse.Integer_Value( cursor, 36 );
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_househol.chrgpd8 := gse.Integer_Value( cursor, 37 );
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_househol.chrgpd9 := gse.Integer_Value( cursor, 38 );
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_househol.contv1 := gse.Integer_Value( cursor, 39 );
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_househol.contv2 := gse.Integer_Value( cursor, 40 );
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_househol.covoths := gse.Integer_Value( cursor, 41 );
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_househol.csewamt:= Amount'Value( gse.Value( cursor, 42 ));
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_househol.csewamt1:= Amount'Value( gse.Value( cursor, 43 ));
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_househol.ct25d50d := gse.Integer_Value( cursor, 44 );
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_househol.ctamt := gse.Integer_Value( cursor, 45 );
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_househol.ctannual:= Amount'Value( gse.Value( cursor, 46 ));
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_househol.ctband := gse.Integer_Value( cursor, 47 );
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_househol.ctbwait := gse.Integer_Value( cursor, 48 );
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_househol.ctcondoc := gse.Integer_Value( cursor, 49 );
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_househol.ctdisc := gse.Integer_Value( cursor, 50 );
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_househol.ctinstal := gse.Integer_Value( cursor, 51 );
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_househol.ctlvband := gse.Integer_Value( cursor, 52 );
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_househol.ctlvchk := gse.Integer_Value( cursor, 53 );
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_househol.ctreb := gse.Integer_Value( cursor, 54 );
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_househol.ctrebamt := gse.Integer_Value( cursor, 55 );
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_househol.ctrebpd := gse.Integer_Value( cursor, 56 );
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_househol.cttime := gse.Integer_Value( cursor, 57 );
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_househol.cwatamt := gse.Integer_Value( cursor, 58 );
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_househol.cwatamt1 := gse.Integer_Value( cursor, 59 );
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_househol.datyrago := gse.Time_Value( cursor, 60 );
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_househol.entry1 := gse.Integer_Value( cursor, 61 );
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_househol.entry2 := gse.Integer_Value( cursor, 62 );
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_househol.entry3 := gse.Integer_Value( cursor, 63 );
      end if;
      if not gse.Is_Null( cursor, 64 )then
         a_househol.entry4 := gse.Integer_Value( cursor, 64 );
      end if;
      if not gse.Is_Null( cursor, 65 )then
         a_househol.estrtann:= Amount'Value( gse.Value( cursor, 65 ));
      end if;
      if not gse.Is_Null( cursor, 66 )then
         a_househol.floor := gse.Integer_Value( cursor, 66 );
      end if;
      if not gse.Is_Null( cursor, 67 )then
         a_househol.givehelp := gse.Integer_Value( cursor, 67 );
      end if;
      if not gse.Is_Null( cursor, 68 )then
         a_househol.gor := gse.Integer_Value( cursor, 68 );
      end if;
      if not gse.Is_Null( cursor, 69 )then
         a_househol.gvtregn := gse.Integer_Value( cursor, 69 );
      end if;
      if not gse.Is_Null( cursor, 70 )then
         a_househol.hhldr01 := gse.Integer_Value( cursor, 70 );
      end if;
      if not gse.Is_Null( cursor, 71 )then
         a_househol.hhldr02 := gse.Integer_Value( cursor, 71 );
      end if;
      if not gse.Is_Null( cursor, 72 )then
         a_househol.hhldr03 := gse.Integer_Value( cursor, 72 );
      end if;
      if not gse.Is_Null( cursor, 73 )then
         a_househol.hhldr04 := gse.Integer_Value( cursor, 73 );
      end if;
      if not gse.Is_Null( cursor, 74 )then
         a_househol.hhldr05 := gse.Integer_Value( cursor, 74 );
      end if;
      if not gse.Is_Null( cursor, 75 )then
         a_househol.hhldr06 := gse.Integer_Value( cursor, 75 );
      end if;
      if not gse.Is_Null( cursor, 76 )then
         a_househol.hhldr07 := gse.Integer_Value( cursor, 76 );
      end if;
      if not gse.Is_Null( cursor, 77 )then
         a_househol.hhldr08 := gse.Integer_Value( cursor, 77 );
      end if;
      if not gse.Is_Null( cursor, 78 )then
         a_househol.hhldr09 := gse.Integer_Value( cursor, 78 );
      end if;
      if not gse.Is_Null( cursor, 79 )then
         a_househol.hhldr10 := gse.Integer_Value( cursor, 79 );
      end if;
      if not gse.Is_Null( cursor, 80 )then
         a_househol.hhldr11 := gse.Integer_Value( cursor, 80 );
      end if;
      if not gse.Is_Null( cursor, 81 )then
         a_househol.hhldr12 := gse.Integer_Value( cursor, 81 );
      end if;
      if not gse.Is_Null( cursor, 82 )then
         a_househol.hhldr13 := gse.Integer_Value( cursor, 82 );
      end if;
      if not gse.Is_Null( cursor, 83 )then
         a_househol.hhldr14 := gse.Integer_Value( cursor, 83 );
      end if;
      if not gse.Is_Null( cursor, 84 )then
         a_househol.hhldr97 := gse.Integer_Value( cursor, 84 );
      end if;
      if not gse.Is_Null( cursor, 85 )then
         a_househol.hhstat := gse.Integer_Value( cursor, 85 );
      end if;
      if not gse.Is_Null( cursor, 86 )then
         a_househol.hrpnum := gse.Integer_Value( cursor, 86 );
      end if;
      if not gse.Is_Null( cursor, 87 )then
         a_househol.intdate := gse.Time_Value( cursor, 87 );
      end if;
      if not gse.Is_Null( cursor, 88 )then
         a_househol.lac := gse.Integer_Value( cursor, 88 );
      end if;
      if not gse.Is_Null( cursor, 89 )then
         a_househol.mainacc := gse.Integer_Value( cursor, 89 );
      end if;
      if not gse.Is_Null( cursor, 90 )then
         a_househol.mnthcode := gse.Integer_Value( cursor, 90 );
      end if;
      if not gse.Is_Null( cursor, 91 )then
         a_househol.modcon01 := gse.Integer_Value( cursor, 91 );
      end if;
      if not gse.Is_Null( cursor, 92 )then
         a_househol.modcon02 := gse.Integer_Value( cursor, 92 );
      end if;
      if not gse.Is_Null( cursor, 93 )then
         a_househol.modcon03 := gse.Integer_Value( cursor, 93 );
      end if;
      if not gse.Is_Null( cursor, 94 )then
         a_househol.modcon04 := gse.Integer_Value( cursor, 94 );
      end if;
      if not gse.Is_Null( cursor, 95 )then
         a_househol.modcon05 := gse.Integer_Value( cursor, 95 );
      end if;
      if not gse.Is_Null( cursor, 96 )then
         a_househol.modcon06 := gse.Integer_Value( cursor, 96 );
      end if;
      if not gse.Is_Null( cursor, 97 )then
         a_househol.modcon07 := gse.Integer_Value( cursor, 97 );
      end if;
      if not gse.Is_Null( cursor, 98 )then
         a_househol.modcon08 := gse.Integer_Value( cursor, 98 );
      end if;
      if not gse.Is_Null( cursor, 99 )then
         a_househol.modcon09 := gse.Integer_Value( cursor, 99 );
      end if;
      if not gse.Is_Null( cursor, 100 )then
         a_househol.modcon10 := gse.Integer_Value( cursor, 100 );
      end if;
      if not gse.Is_Null( cursor, 101 )then
         a_househol.modcon11 := gse.Integer_Value( cursor, 101 );
      end if;
      if not gse.Is_Null( cursor, 102 )then
         a_househol.modcon12 := gse.Integer_Value( cursor, 102 );
      end if;
      if not gse.Is_Null( cursor, 103 )then
         a_househol.modcon13 := gse.Integer_Value( cursor, 103 );
      end if;
      if not gse.Is_Null( cursor, 104 )then
         a_househol.modcon14 := gse.Integer_Value( cursor, 104 );
      end if;
      if not gse.Is_Null( cursor, 105 )then
         a_househol.monlive := gse.Integer_Value( cursor, 105 );
      end if;
      if not gse.Is_Null( cursor, 106 )then
         a_househol.needhelp := gse.Integer_Value( cursor, 106 );
      end if;
      if not gse.Is_Null( cursor, 107 )then
         a_househol.nicoun := gse.Integer_Value( cursor, 107 );
      end if;
      if not gse.Is_Null( cursor, 108 )then
         a_househol.ninrv:= Amount'Value( gse.Value( cursor, 108 ));
      end if;
      if not gse.Is_Null( cursor, 109 )then
         a_househol.nirate := gse.Integer_Value( cursor, 109 );
      end if;
      if not gse.Is_Null( cursor, 110 )then
         a_househol.norate := gse.Integer_Value( cursor, 110 );
      end if;
      if not gse.Is_Null( cursor, 111 )then
         a_househol.onbsroom := gse.Integer_Value( cursor, 111 );
      end if;
      if not gse.Is_Null( cursor, 112 )then
         a_househol.orgsewam:= Amount'Value( gse.Value( cursor, 112 ));
      end if;
      if not gse.Is_Null( cursor, 113 )then
         a_househol.orgwatam:= Amount'Value( gse.Value( cursor, 113 ));
      end if;
      if not gse.Is_Null( cursor, 114 )then
         a_househol.payrate := gse.Integer_Value( cursor, 114 );
      end if;
      if not gse.Is_Null( cursor, 115 )then
         a_househol.premium := gse.Integer_Value( cursor, 115 );
      end if;
      if not gse.Is_Null( cursor, 116 )then
         a_househol.ptbsroom := gse.Integer_Value( cursor, 116 );
      end if;
      if not gse.Is_Null( cursor, 117 )then
         a_househol.rooms := gse.Integer_Value( cursor, 117 );
      end if;
      if not gse.Is_Null( cursor, 118 )then
         a_househol.roomshar := gse.Integer_Value( cursor, 118 );
      end if;
      if not gse.Is_Null( cursor, 119 )then
         a_househol.rtannual:= Amount'Value( gse.Value( cursor, 119 ));
      end if;
      if not gse.Is_Null( cursor, 120 )then
         a_househol.rtcheck:= Amount'Value( gse.Value( cursor, 120 ));
      end if;
      if not gse.Is_Null( cursor, 121 )then
         a_househol.rtcondoc := gse.Integer_Value( cursor, 121 );
      end if;
      if not gse.Is_Null( cursor, 122 )then
         a_househol.rtdeduc := gse.Integer_Value( cursor, 122 );
      end if;
      if not gse.Is_Null( cursor, 123 )then
         a_househol.rtinstal := gse.Integer_Value( cursor, 123 );
      end if;
      if not gse.Is_Null( cursor, 124 )then
         a_househol.rtreb := gse.Integer_Value( cursor, 124 );
      end if;
      if not gse.Is_Null( cursor, 125 )then
         a_househol.rtrebamt:= Amount'Value( gse.Value( cursor, 125 ));
      end if;
      if not gse.Is_Null( cursor, 126 )then
         a_househol.rtrebpd := gse.Integer_Value( cursor, 126 );
      end if;
      if not gse.Is_Null( cursor, 127 )then
         a_househol.rttime := gse.Integer_Value( cursor, 127 );
      end if;
      if not gse.Is_Null( cursor, 128 )then
         a_househol.sampqtr := gse.Integer_Value( cursor, 128 );
      end if;
      if not gse.Is_Null( cursor, 129 )then
         a_househol.schmeal := gse.Integer_Value( cursor, 129 );
      end if;
      if not gse.Is_Null( cursor, 130 )then
         a_househol.schmilk := gse.Integer_Value( cursor, 130 );
      end if;
      if not gse.Is_Null( cursor, 131 )then
         a_househol.sewamt:= Amount'Value( gse.Value( cursor, 131 ));
      end if;
      if not gse.Is_Null( cursor, 132 )then
         a_househol.sewanul:= Amount'Value( gse.Value( cursor, 132 ));
      end if;
      if not gse.Is_Null( cursor, 133 )then
         a_househol.sewerpay := gse.Integer_Value( cursor, 133 );
      end if;
      if not gse.Is_Null( cursor, 134 )then
         a_househol.sewsep := gse.Integer_Value( cursor, 134 );
      end if;
      if not gse.Is_Null( cursor, 135 )then
         a_househol.sewtime := gse.Integer_Value( cursor, 135 );
      end if;
      if not gse.Is_Null( cursor, 136 )then
         a_househol.shelter := gse.Integer_Value( cursor, 136 );
      end if;
      if not gse.Is_Null( cursor, 137 )then
         a_househol.sobuy := gse.Integer_Value( cursor, 137 );
      end if;
      if not gse.Is_Null( cursor, 138 )then
         a_househol.sstrtreg := gse.Integer_Value( cursor, 138 );
      end if;
      if not gse.Is_Null( cursor, 139 )then
         a_househol.stramt1:= Amount'Value( gse.Value( cursor, 139 ));
      end if;
      if not gse.Is_Null( cursor, 140 )then
         a_househol.stramt2:= Amount'Value( gse.Value( cursor, 140 ));
      end if;
      if not gse.Is_Null( cursor, 141 )then
         a_househol.strcov := gse.Integer_Value( cursor, 141 );
      end if;
      if not gse.Is_Null( cursor, 142 )then
         a_househol.strmort := gse.Integer_Value( cursor, 142 );
      end if;
      if not gse.Is_Null( cursor, 143 )then
         a_househol.stroths := gse.Integer_Value( cursor, 143 );
      end if;
      if not gse.Is_Null( cursor, 144 )then
         a_househol.strpd1 := gse.Integer_Value( cursor, 144 );
      end if;
      if not gse.Is_Null( cursor, 145 )then
         a_househol.strpd2 := gse.Integer_Value( cursor, 145 );
      end if;
      if not gse.Is_Null( cursor, 146 )then
         a_househol.suballow := gse.Integer_Value( cursor, 146 );
      end if;
      if not gse.Is_Null( cursor, 147 )then
         a_househol.sublet := gse.Integer_Value( cursor, 147 );
      end if;
      if not gse.Is_Null( cursor, 148 )then
         a_househol.sublety := gse.Integer_Value( cursor, 148 );
      end if;
      if not gse.Is_Null( cursor, 149 )then
         a_househol.subrent:= Amount'Value( gse.Value( cursor, 149 ));
      end if;
      if not gse.Is_Null( cursor, 150 )then
         a_househol.tenure := gse.Integer_Value( cursor, 150 );
      end if;
      if not gse.Is_Null( cursor, 151 )then
         a_househol.totadult := gse.Integer_Value( cursor, 151 );
      end if;
      if not gse.Is_Null( cursor, 152 )then
         a_househol.totchild := gse.Integer_Value( cursor, 152 );
      end if;
      if not gse.Is_Null( cursor, 153 )then
         a_househol.totdepdk := gse.Integer_Value( cursor, 153 );
      end if;
      if not gse.Is_Null( cursor, 154 )then
         a_househol.tvlic := gse.Integer_Value( cursor, 154 );
      end if;
      if not gse.Is_Null( cursor, 155 )then
         a_househol.typeacc := gse.Integer_Value( cursor, 155 );
      end if;
      if not gse.Is_Null( cursor, 156 )then
         a_househol.usevcl := gse.Integer_Value( cursor, 156 );
      end if;
      if not gse.Is_Null( cursor, 157 )then
         a_househol.watamt:= Amount'Value( gse.Value( cursor, 157 ));
      end if;
      if not gse.Is_Null( cursor, 158 )then
         a_househol.watanul:= Amount'Value( gse.Value( cursor, 158 ));
      end if;
      if not gse.Is_Null( cursor, 159 )then
         a_househol.watermet := gse.Integer_Value( cursor, 159 );
      end if;
      if not gse.Is_Null( cursor, 160 )then
         a_househol.waterpay := gse.Integer_Value( cursor, 160 );
      end if;
      if not gse.Is_Null( cursor, 161 )then
         a_househol.watrb := gse.Integer_Value( cursor, 161 );
      end if;
      if not gse.Is_Null( cursor, 162 )then
         a_househol.wattime := gse.Integer_Value( cursor, 162 );
      end if;
      if not gse.Is_Null( cursor, 163 )then
         a_househol.welfmilk := gse.Integer_Value( cursor, 163 );
      end if;
      if not gse.Is_Null( cursor, 164 )then
         a_househol.whoctb01 := gse.Integer_Value( cursor, 164 );
      end if;
      if not gse.Is_Null( cursor, 165 )then
         a_househol.whoctb02 := gse.Integer_Value( cursor, 165 );
      end if;
      if not gse.Is_Null( cursor, 166 )then
         a_househol.whoctb03 := gse.Integer_Value( cursor, 166 );
      end if;
      if not gse.Is_Null( cursor, 167 )then
         a_househol.whoctb04 := gse.Integer_Value( cursor, 167 );
      end if;
      if not gse.Is_Null( cursor, 168 )then
         a_househol.whoctb05 := gse.Integer_Value( cursor, 168 );
      end if;
      if not gse.Is_Null( cursor, 169 )then
         a_househol.whoctb06 := gse.Integer_Value( cursor, 169 );
      end if;
      if not gse.Is_Null( cursor, 170 )then
         a_househol.whoctb07 := gse.Integer_Value( cursor, 170 );
      end if;
      if not gse.Is_Null( cursor, 171 )then
         a_househol.whoctb08 := gse.Integer_Value( cursor, 171 );
      end if;
      if not gse.Is_Null( cursor, 172 )then
         a_househol.whoctb09 := gse.Integer_Value( cursor, 172 );
      end if;
      if not gse.Is_Null( cursor, 173 )then
         a_househol.whoctb10 := gse.Integer_Value( cursor, 173 );
      end if;
      if not gse.Is_Null( cursor, 174 )then
         a_househol.whoctb11 := gse.Integer_Value( cursor, 174 );
      end if;
      if not gse.Is_Null( cursor, 175 )then
         a_househol.whoctb12 := gse.Integer_Value( cursor, 175 );
      end if;
      if not gse.Is_Null( cursor, 176 )then
         a_househol.whoctb13 := gse.Integer_Value( cursor, 176 );
      end if;
      if not gse.Is_Null( cursor, 177 )then
         a_househol.whoctb14 := gse.Integer_Value( cursor, 177 );
      end if;
      if not gse.Is_Null( cursor, 178 )then
         a_househol.whoctbns := gse.Integer_Value( cursor, 178 );
      end if;
      if not gse.Is_Null( cursor, 179 )then
         a_househol.whoctbot := gse.Integer_Value( cursor, 179 );
      end if;
      if not gse.Is_Null( cursor, 180 )then
         a_househol.whorsp01 := gse.Integer_Value( cursor, 180 );
      end if;
      if not gse.Is_Null( cursor, 181 )then
         a_househol.whorsp02 := gse.Integer_Value( cursor, 181 );
      end if;
      if not gse.Is_Null( cursor, 182 )then
         a_househol.whorsp03 := gse.Integer_Value( cursor, 182 );
      end if;
      if not gse.Is_Null( cursor, 183 )then
         a_househol.whorsp04 := gse.Integer_Value( cursor, 183 );
      end if;
      if not gse.Is_Null( cursor, 184 )then
         a_househol.whorsp05 := gse.Integer_Value( cursor, 184 );
      end if;
      if not gse.Is_Null( cursor, 185 )then
         a_househol.whorsp06 := gse.Integer_Value( cursor, 185 );
      end if;
      if not gse.Is_Null( cursor, 186 )then
         a_househol.whorsp07 := gse.Integer_Value( cursor, 186 );
      end if;
      if not gse.Is_Null( cursor, 187 )then
         a_househol.whorsp08 := gse.Integer_Value( cursor, 187 );
      end if;
      if not gse.Is_Null( cursor, 188 )then
         a_househol.whorsp09 := gse.Integer_Value( cursor, 188 );
      end if;
      if not gse.Is_Null( cursor, 189 )then
         a_househol.whorsp10 := gse.Integer_Value( cursor, 189 );
      end if;
      if not gse.Is_Null( cursor, 190 )then
         a_househol.whorsp11 := gse.Integer_Value( cursor, 190 );
      end if;
      if not gse.Is_Null( cursor, 191 )then
         a_househol.whorsp12 := gse.Integer_Value( cursor, 191 );
      end if;
      if not gse.Is_Null( cursor, 192 )then
         a_househol.whorsp13 := gse.Integer_Value( cursor, 192 );
      end if;
      if not gse.Is_Null( cursor, 193 )then
         a_househol.whorsp14 := gse.Integer_Value( cursor, 193 );
      end if;
      if not gse.Is_Null( cursor, 194 )then
         a_househol.whynoct := gse.Integer_Value( cursor, 194 );
      end if;
      if not gse.Is_Null( cursor, 195 )then
         a_househol.wmintro := gse.Integer_Value( cursor, 195 );
      end if;
      if not gse.Is_Null( cursor, 196 )then
         a_househol.wsewamt:= Amount'Value( gse.Value( cursor, 196 ));
      end if;
      if not gse.Is_Null( cursor, 197 )then
         a_househol.wsewanul:= Amount'Value( gse.Value( cursor, 197 ));
      end if;
      if not gse.Is_Null( cursor, 198 )then
         a_househol.wsewtime := gse.Integer_Value( cursor, 198 );
      end if;
      if not gse.Is_Null( cursor, 199 )then
         a_househol.yearcode := gse.Integer_Value( cursor, 199 );
      end if;
      if not gse.Is_Null( cursor, 200 )then
         a_househol.yearlive := gse.Integer_Value( cursor, 200 );
      end if;
      if not gse.Is_Null( cursor, 201 )then
         a_househol.month := gse.Integer_Value( cursor, 201 );
      end if;
      if not gse.Is_Null( cursor, 202 )then
         a_househol.actacch := gse.Integer_Value( cursor, 202 );
      end if;
      if not gse.Is_Null( cursor, 203 )then
         a_househol.adddahh := gse.Integer_Value( cursor, 203 );
      end if;
      if not gse.Is_Null( cursor, 204 )then
         a_househol.adulth := gse.Integer_Value( cursor, 204 );
      end if;
      if not gse.Is_Null( cursor, 205 )then
         a_househol.basacth := gse.Integer_Value( cursor, 205 );
      end if;
      if not gse.Is_Null( cursor, 206 )then
         a_househol.chddahh := gse.Integer_Value( cursor, 206 );
      end if;
      if not gse.Is_Null( cursor, 207 )then
         a_househol.curacth := gse.Integer_Value( cursor, 207 );
      end if;
      if not gse.Is_Null( cursor, 208 )then
         a_househol.cwatamtd := gse.Integer_Value( cursor, 208 );
      end if;
      if not gse.Is_Null( cursor, 209 )then
         a_househol.depchldh := gse.Integer_Value( cursor, 209 );
      end if;
      if not gse.Is_Null( cursor, 210 )then
         a_househol.emp := gse.Integer_Value( cursor, 210 );
      end if;
      if not gse.Is_Null( cursor, 211 )then
         a_househol.emphrp := gse.Integer_Value( cursor, 211 );
      end if;
      if not gse.Is_Null( cursor, 212 )then
         a_househol.endowpay:= Amount'Value( gse.Value( cursor, 212 ));
      end if;
      if not gse.Is_Null( cursor, 213 )then
         a_househol.equivahc:= Amount'Value( gse.Value( cursor, 213 ));
      end if;
      if not gse.Is_Null( cursor, 214 )then
         a_househol.equivbhc:= Amount'Value( gse.Value( cursor, 214 ));
      end if;
      if not gse.Is_Null( cursor, 215 )then
         a_househol.fsbndcth := gse.Integer_Value( cursor, 215 );
      end if;
      if not gse.Is_Null( cursor, 216 )then
         a_househol.gbhscost := gse.Integer_Value( cursor, 216 );
      end if;
      if not gse.Is_Null( cursor, 217 )then
         a_househol.gebacth := gse.Integer_Value( cursor, 217 );
      end if;
      if not gse.Is_Null( cursor, 218 )then
         a_househol.giltcth := gse.Integer_Value( cursor, 218 );
      end if;
      if not gse.Is_Null( cursor, 219 )then
         a_househol.gross2 := gse.Integer_Value( cursor, 219 );
      end if;
      if not gse.Is_Null( cursor, 220 )then
         a_househol.gross3 := gse.Integer_Value( cursor, 220 );
      end if;
      if not gse.Is_Null( cursor, 221 )then
         a_househol.grossct := gse.Integer_Value( cursor, 221 );
      end if;
      if not gse.Is_Null( cursor, 222 )then
         a_househol.hbeninc := gse.Integer_Value( cursor, 222 );
      end if;
      if not gse.Is_Null( cursor, 223 )then
         a_househol.hbindhh := gse.Integer_Value( cursor, 223 );
      end if;
      if not gse.Is_Null( cursor, 224 )then
         a_househol.hcband := gse.Integer_Value( cursor, 224 );
      end if;
      if not gse.Is_Null( cursor, 225 )then
         a_househol.hdhhinc := gse.Integer_Value( cursor, 225 );
      end if;
      if not gse.Is_Null( cursor, 226 )then
         a_househol.hdtax := gse.Integer_Value( cursor, 226 );
      end if;
      if not gse.Is_Null( cursor, 227 )then
         a_househol.hearns:= Amount'Value( gse.Value( cursor, 227 ));
      end if;
      if not gse.Is_Null( cursor, 228 )then
         a_househol.hhagegr2 := gse.Integer_Value( cursor, 228 );
      end if;
      if not gse.Is_Null( cursor, 229 )then
         a_househol.hhagegrp := gse.Integer_Value( cursor, 229 );
      end if;
      if not gse.Is_Null( cursor, 230 )then
         a_househol.hhcomp := gse.Integer_Value( cursor, 230 );
      end if;
      if not gse.Is_Null( cursor, 231 )then
         a_househol.hhcomps := gse.Integer_Value( cursor, 231 );
      end if;
      if not gse.Is_Null( cursor, 232 )then
         a_househol.hhdisben := gse.Integer_Value( cursor, 232 );
      end if;
      if not gse.Is_Null( cursor, 233 )then
         a_househol.hhethgr2 := gse.Integer_Value( cursor, 233 );
      end if;
      if not gse.Is_Null( cursor, 234 )then
         a_househol.hhethgrp := gse.Integer_Value( cursor, 234 );
      end if;
      if not gse.Is_Null( cursor, 235 )then
         a_househol.hhinc := gse.Integer_Value( cursor, 235 );
      end if;
      if not gse.Is_Null( cursor, 236 )then
         a_househol.hhincbnd := gse.Integer_Value( cursor, 236 );
      end if;
      if not gse.Is_Null( cursor, 237 )then
         a_househol.hhinv:= Amount'Value( gse.Value( cursor, 237 ));
      end if;
      if not gse.Is_Null( cursor, 238 )then
         a_househol.hhirben := gse.Integer_Value( cursor, 238 );
      end if;
      if not gse.Is_Null( cursor, 239 )then
         a_househol.hhkids := gse.Integer_Value( cursor, 239 );
      end if;
      if not gse.Is_Null( cursor, 240 )then
         a_househol.hhnirben := gse.Integer_Value( cursor, 240 );
      end if;
      if not gse.Is_Null( cursor, 241 )then
         a_househol.hhothben := gse.Integer_Value( cursor, 241 );
      end if;
      if not gse.Is_Null( cursor, 242 )then
         a_househol.hhrent := gse.Integer_Value( cursor, 242 );
      end if;
      if not gse.Is_Null( cursor, 243 )then
         a_househol.hhrinc:= Amount'Value( gse.Value( cursor, 243 ));
      end if;
      if not gse.Is_Null( cursor, 244 )then
         a_househol.hhrpinc:= Amount'Value( gse.Value( cursor, 244 ));
      end if;
      if not gse.Is_Null( cursor, 245 )then
         a_househol.hhsize := gse.Integer_Value( cursor, 245 );
      end if;
      if not gse.Is_Null( cursor, 246 )then
         a_househol.hhtvlic:= Amount'Value( gse.Value( cursor, 246 ));
      end if;
      if not gse.Is_Null( cursor, 247 )then
         a_househol.hhtxcred:= Amount'Value( gse.Value( cursor, 247 ));
      end if;
      if not gse.Is_Null( cursor, 248 )then
         a_househol.hothinc:= Amount'Value( gse.Value( cursor, 248 ));
      end if;
      if not gse.Is_Null( cursor, 249 )then
         a_househol.hpeninc:= Amount'Value( gse.Value( cursor, 249 ));
      end if;
      if not gse.Is_Null( cursor, 250 )then
         a_househol.hrband := gse.Integer_Value( cursor, 250 );
      end if;
      if not gse.Is_Null( cursor, 251 )then
         a_househol.hseinc:= Amount'Value( gse.Value( cursor, 251 ));
      end if;
      if not gse.Is_Null( cursor, 252 )then
         a_househol.isacth := gse.Integer_Value( cursor, 252 );
      end if;
      if not gse.Is_Null( cursor, 253 )then
         a_househol.london := gse.Integer_Value( cursor, 253 );
      end if;
      if not gse.Is_Null( cursor, 254 )then
         a_househol.mortcost:= Amount'Value( gse.Value( cursor, 254 ));
      end if;
      if not gse.Is_Null( cursor, 255 )then
         a_househol.mortint:= Amount'Value( gse.Value( cursor, 255 ));
      end if;
      if not gse.Is_Null( cursor, 256 )then
         a_househol.mortpay:= Amount'Value( gse.Value( cursor, 256 ));
      end if;
      if not gse.Is_Null( cursor, 257 )then
         a_househol.nddctb:= Amount'Value( gse.Value( cursor, 257 ));
      end if;
      if not gse.Is_Null( cursor, 258 )then
         a_househol.nddishc:= Amount'Value( gse.Value( cursor, 258 ));
      end if;
      if not gse.Is_Null( cursor, 259 )then
         a_househol.nihscost := gse.Integer_Value( cursor, 259 );
      end if;
      if not gse.Is_Null( cursor, 260 )then
         a_househol.nsbocth := gse.Integer_Value( cursor, 260 );
      end if;
      if not gse.Is_Null( cursor, 261 )then
         a_househol.otbscth := gse.Integer_Value( cursor, 261 );
      end if;
      if not gse.Is_Null( cursor, 262 )then
         a_househol.pacctype := gse.Integer_Value( cursor, 262 );
      end if;
      if not gse.Is_Null( cursor, 263 )then
         a_househol.penage := gse.Integer_Value( cursor, 263 );
      end if;
      if not gse.Is_Null( cursor, 264 )then
         a_househol.penhrp := gse.Integer_Value( cursor, 264 );
      end if;
      if not gse.Is_Null( cursor, 265 )then
         a_househol.pepscth := gse.Integer_Value( cursor, 265 );
      end if;
      if not gse.Is_Null( cursor, 266 )then
         a_househol.poaccth := gse.Integer_Value( cursor, 266 );
      end if;
      if not gse.Is_Null( cursor, 267 )then
         a_househol.prbocth := gse.Integer_Value( cursor, 267 );
      end if;
      if not gse.Is_Null( cursor, 268 )then
         a_househol.ptentyp2 := gse.Integer_Value( cursor, 268 );
      end if;
      if not gse.Is_Null( cursor, 269 )then
         a_househol.sayecth := gse.Integer_Value( cursor, 269 );
      end if;
      if not gse.Is_Null( cursor, 270 )then
         a_househol.sclbcth := gse.Integer_Value( cursor, 270 );
      end if;
      if not gse.Is_Null( cursor, 271 )then
         a_househol.servpay:= Amount'Value( gse.Value( cursor, 271 ));
      end if;
      if not gse.Is_Null( cursor, 272 )then
         a_househol.sick := gse.Integer_Value( cursor, 272 );
      end if;
      if not gse.Is_Null( cursor, 273 )then
         a_househol.sickhrp := gse.Integer_Value( cursor, 273 );
      end if;
      if not gse.Is_Null( cursor, 274 )then
         a_househol.sscth := gse.Integer_Value( cursor, 274 );
      end if;
      if not gse.Is_Null( cursor, 275 )then
         a_househol.struins:= Amount'Value( gse.Value( cursor, 275 ));
      end if;
      if not gse.Is_Null( cursor, 276 )then
         a_househol.stshcth := gse.Integer_Value( cursor, 276 );
      end if;
      if not gse.Is_Null( cursor, 277 )then
         a_househol.tentyp2 := gse.Integer_Value( cursor, 277 );
      end if;
      if not gse.Is_Null( cursor, 278 )then
         a_househol.tesscth := gse.Integer_Value( cursor, 278 );
      end if;
      if not gse.Is_Null( cursor, 279 )then
         a_househol.tuhhrent:= Amount'Value( gse.Value( cursor, 279 ));
      end if;
      if not gse.Is_Null( cursor, 280 )then
         a_househol.tuwatsew:= Amount'Value( gse.Value( cursor, 280 ));
      end if;
      if not gse.Is_Null( cursor, 281 )then
         a_househol.untrcth := gse.Integer_Value( cursor, 281 );
      end if;
      if not gse.Is_Null( cursor, 282 )then
         a_househol.watsewrt:= Amount'Value( gse.Value( cursor, 282 ));
      end if;
      if not gse.Is_Null( cursor, 283 )then
         a_househol.acornew := gse.Integer_Value( cursor, 283 );
      end if;
      if not gse.Is_Null( cursor, 284 )then
         a_househol.crunach := gse.Integer_Value( cursor, 284 );
      end if;
      if not gse.Is_Null( cursor, 285 )then
         a_househol.enomorth := gse.Integer_Value( cursor, 285 );
      end if;
      if not gse.Is_Null( cursor, 286 )then
         a_househol.dvadulth := gse.Integer_Value( cursor, 286 );
      end if;
      if not gse.Is_Null( cursor, 287 )then
         a_househol.dvtotad := gse.Integer_Value( cursor, 287 );
      end if;
      if not gse.Is_Null( cursor, 288 )then
         a_househol.urindew := gse.Integer_Value( cursor, 288 );
      end if;
      if not gse.Is_Null( cursor, 289 )then
         a_househol.urinds := gse.Integer_Value( cursor, 289 );
      end if;
      if not gse.Is_Null( cursor, 290 )then
         a_househol.vehnumb := gse.Integer_Value( cursor, 290 );
      end if;
      if not gse.Is_Null( cursor, 291 )then
         a_househol.country := gse.Integer_Value( cursor, 291 );
      end if;
      if not gse.Is_Null( cursor, 292 )then
         a_househol.hbindhh2 := gse.Integer_Value( cursor, 292 );
      end if;
      if not gse.Is_Null( cursor, 293 )then
         a_househol.pocardh := gse.Integer_Value( cursor, 293 );
      end if;
      if not gse.Is_Null( cursor, 294 )then
         a_househol.entry5 := gse.Integer_Value( cursor, 294 );
      end if;
      if not gse.Is_Null( cursor, 295 )then
         a_househol.entry6 := gse.Integer_Value( cursor, 295 );
      end if;
      if not gse.Is_Null( cursor, 296 )then
         a_househol.imd_e := gse.Integer_Value( cursor, 296 );
      end if;
      if not gse.Is_Null( cursor, 297 )then
         a_househol.imd_s := gse.Integer_Value( cursor, 297 );
      end if;
      if not gse.Is_Null( cursor, 298 )then
         a_househol.imd_w := gse.Integer_Value( cursor, 298 );
      end if;
      if not gse.Is_Null( cursor, 299 )then
         a_househol.numtv1 := gse.Integer_Value( cursor, 299 );
      end if;
      if not gse.Is_Null( cursor, 300 )then
         a_househol.numtv2 := gse.Integer_Value( cursor, 300 );
      end if;
      if not gse.Is_Null( cursor, 301 )then
         a_househol.oac := gse.Integer_Value( cursor, 301 );
      end if;
      if not gse.Is_Null( cursor, 302 )then
         a_househol.bedroom6 := gse.Integer_Value( cursor, 302 );
      end if;
      if not gse.Is_Null( cursor, 303 )then
         a_househol.rooms10 := gse.Integer_Value( cursor, 303 );
      end if;
      if not gse.Is_Null( cursor, 304 )then
         a_househol.brma := gse.Integer_Value( cursor, 304 );
      end if;
      if not gse.Is_Null( cursor, 305 )then
         a_househol.issue := gse.Integer_Value( cursor, 305 );
      end if;
      if not gse.Is_Null( cursor, 306 )then
         a_househol.migrq1 := gse.Integer_Value( cursor, 306 );
      end if;
      if not gse.Is_Null( cursor, 307 )then
         a_househol.migrq2 := gse.Integer_Value( cursor, 307 );
      end if;
      if not gse.Is_Null( cursor, 308 )then
         a_househol.hhagegr3 := gse.Integer_Value( cursor, 308 );
      end if;
      if not gse.Is_Null( cursor, 309 )then
         a_househol.hhagegr4 := gse.Integer_Value( cursor, 309 );
      end if;
      if not gse.Is_Null( cursor, 310 )then
         a_househol.capval := gse.Integer_Value( cursor, 310 );
      end if;
      if not gse.Is_Null( cursor, 311 )then
         a_househol.nidpnd := gse.Integer_Value( cursor, 311 );
      end if;
      if not gse.Is_Null( cursor, 312 )then
         a_househol.nochcr1 := gse.Integer_Value( cursor, 312 );
      end if;
      if not gse.Is_Null( cursor, 313 )then
         a_househol.nochcr2 := gse.Integer_Value( cursor, 313 );
      end if;
      if not gse.Is_Null( cursor, 314 )then
         a_househol.nochcr3 := gse.Integer_Value( cursor, 314 );
      end if;
      if not gse.Is_Null( cursor, 315 )then
         a_househol.nochcr4 := gse.Integer_Value( cursor, 315 );
      end if;
      if not gse.Is_Null( cursor, 316 )then
         a_househol.nochcr5 := gse.Integer_Value( cursor, 316 );
      end if;
      if not gse.Is_Null( cursor, 317 )then
         a_househol.rt2rebam:= Amount'Value( gse.Value( cursor, 317 ));
      end if;
      if not gse.Is_Null( cursor, 318 )then
         a_househol.rt2rebpd := gse.Integer_Value( cursor, 318 );
      end if;
      if not gse.Is_Null( cursor, 319 )then
         a_househol.rtdpa := gse.Integer_Value( cursor, 319 );
      end if;
      if not gse.Is_Null( cursor, 320 )then
         a_househol.rtdpaamt:= Amount'Value( gse.Value( cursor, 320 ));
      end if;
      if not gse.Is_Null( cursor, 321 )then
         a_househol.rtdpapd := gse.Integer_Value( cursor, 321 );
      end if;
      if not gse.Is_Null( cursor, 322 )then
         a_househol.rtlpa := gse.Integer_Value( cursor, 322 );
      end if;
      if not gse.Is_Null( cursor, 323 )then
         a_househol.rtlpaamt:= Amount'Value( gse.Value( cursor, 323 ));
      end if;
      if not gse.Is_Null( cursor, 324 )then
         a_househol.rtlpapd := gse.Integer_Value( cursor, 324 );
      end if;
      if not gse.Is_Null( cursor, 325 )then
         a_househol.rtothamt:= Amount'Value( gse.Value( cursor, 325 ));
      end if;
      if not gse.Is_Null( cursor, 326 )then
         a_househol.rtother := gse.Integer_Value( cursor, 326 );
      end if;
      if not gse.Is_Null( cursor, 327 )then
         a_househol.rtothpd := gse.Integer_Value( cursor, 327 );
      end if;
      if not gse.Is_Null( cursor, 328 )then
         a_househol.rtrtr := gse.Integer_Value( cursor, 328 );
      end if;
      if not gse.Is_Null( cursor, 329 )then
         a_househol.rtrtramt:= Amount'Value( gse.Value( cursor, 329 ));
      end if;
      if not gse.Is_Null( cursor, 330 )then
         a_househol.rtrtrpd := gse.Integer_Value( cursor, 330 );
      end if;
      if not gse.Is_Null( cursor, 331 )then
         a_househol.rttimepd := gse.Integer_Value( cursor, 331 );
      end if;
      if not gse.Is_Null( cursor, 332 )then
         a_househol.yrlvchk := gse.Integer_Value( cursor, 332 );
      end if;
      if not gse.Is_Null( cursor, 333 )then
         a_househol.gross3_x := gse.Integer_Value( cursor, 333 );
      end if;
      if not gse.Is_Null( cursor, 334 )then
         a_househol.hlthst := gse.Integer_Value( cursor, 334 );
      end if;
      if not gse.Is_Null( cursor, 335 )then
         a_househol.medpay := gse.Integer_Value( cursor, 335 );
      end if;
      if not gse.Is_Null( cursor, 336 )then
         a_househol.medwho01 := gse.Integer_Value( cursor, 336 );
      end if;
      if not gse.Is_Null( cursor, 337 )then
         a_househol.medwho02 := gse.Integer_Value( cursor, 337 );
      end if;
      if not gse.Is_Null( cursor, 338 )then
         a_househol.medwho03 := gse.Integer_Value( cursor, 338 );
      end if;
      if not gse.Is_Null( cursor, 339 )then
         a_househol.medwho04 := gse.Integer_Value( cursor, 339 );
      end if;
      if not gse.Is_Null( cursor, 340 )then
         a_househol.medwho05 := gse.Integer_Value( cursor, 340 );
      end if;
      if not gse.Is_Null( cursor, 341 )then
         a_househol.medwho06 := gse.Integer_Value( cursor, 341 );
      end if;
      if not gse.Is_Null( cursor, 342 )then
         a_househol.medwho07 := gse.Integer_Value( cursor, 342 );
      end if;
      if not gse.Is_Null( cursor, 343 )then
         a_househol.medwho08 := gse.Integer_Value( cursor, 343 );
      end if;
      if not gse.Is_Null( cursor, 344 )then
         a_househol.medwho09 := gse.Integer_Value( cursor, 344 );
      end if;
      if not gse.Is_Null( cursor, 345 )then
         a_househol.medwho10 := gse.Integer_Value( cursor, 345 );
      end if;
      if not gse.Is_Null( cursor, 346 )then
         a_househol.medwho11 := gse.Integer_Value( cursor, 346 );
      end if;
      if not gse.Is_Null( cursor, 347 )then
         a_househol.medwho12 := gse.Integer_Value( cursor, 347 );
      end if;
      if not gse.Is_Null( cursor, 348 )then
         a_househol.medwho13 := gse.Integer_Value( cursor, 348 );
      end if;
      if not gse.Is_Null( cursor, 349 )then
         a_househol.medwho14 := gse.Integer_Value( cursor, 349 );
      end if;
      if not gse.Is_Null( cursor, 350 )then
         a_househol.nmrmshar := gse.Integer_Value( cursor, 350 );
      end if;
      if not gse.Is_Null( cursor, 351 )then
         a_househol.roomshr := gse.Integer_Value( cursor, 351 );
      end if;
      if not gse.Is_Null( cursor, 352 )then
         a_househol.imd_ni := gse.Integer_Value( cursor, 352 );
      end if;
      if not gse.Is_Null( cursor, 353 )then
         a_househol.multi := gse.Integer_Value( cursor, 353 );
      end if;
      if not gse.Is_Null( cursor, 354 )then
         a_househol.nopay := gse.Integer_Value( cursor, 354 );
      end if;
      if not gse.Is_Null( cursor, 355 )then
         a_househol.orgid := gse.Integer_Value( cursor, 355 );
      end if;
      if not gse.Is_Null( cursor, 356 )then
         a_househol.rtene := gse.Integer_Value( cursor, 356 );
      end if;
      if not gse.Is_Null( cursor, 357 )then
         a_househol.rteneamt := gse.Integer_Value( cursor, 357 );
      end if;
      if not gse.Is_Null( cursor, 358 )then
         a_househol.rtgen := gse.Integer_Value( cursor, 358 );
      end if;
      if not gse.Is_Null( cursor, 359 )then
         a_househol.schbrk := gse.Integer_Value( cursor, 359 );
      end if;
      if not gse.Is_Null( cursor, 360 )then
         a_househol.urb := gse.Integer_Value( cursor, 360 );
      end if;
      if not gse.Is_Null( cursor, 361 )then
         a_househol.urbrur := gse.Integer_Value( cursor, 361 );
      end if;
      if not gse.Is_Null( cursor, 362 )then
         a_househol.hhethgr3 := gse.Integer_Value( cursor, 362 );
      end if;
      if not gse.Is_Null( cursor, 363 )then
         a_househol.niratlia:= Amount'Value( gse.Value( cursor, 363 ));
      end if;
      if not gse.Is_Null( cursor, 364 )then
         a_househol.bankse := gse.Integer_Value( cursor, 364 );
      end if;
      if not gse.Is_Null( cursor, 365 )then
         a_househol.bathshow := gse.Integer_Value( cursor, 365 );
      end if;
      if not gse.Is_Null( cursor, 366 )then
         a_househol.burden := gse.Integer_Value( cursor, 366 );
      end if;
      if not gse.Is_Null( cursor, 367 )then
         a_househol.comco := gse.Integer_Value( cursor, 367 );
      end if;
      if not gse.Is_Null( cursor, 368 )then
         a_househol.comp1sc := gse.Integer_Value( cursor, 368 );
      end if;
      if not gse.Is_Null( cursor, 369 )then
         a_househol.compsc := gse.Integer_Value( cursor, 369 );
      end if;
      if not gse.Is_Null( cursor, 370 )then
         a_househol.comwa := gse.Integer_Value( cursor, 370 );
      end if;
      if not gse.Is_Null( cursor, 371 )then
         a_househol.dwellno := gse.Integer_Value( cursor, 371 );
      end if;
      if not gse.Is_Null( cursor, 372 )then
         a_househol.elecin := gse.Integer_Value( cursor, 372 );
      end if;
      if not gse.Is_Null( cursor, 373 )then
         a_househol.elecinw := gse.Integer_Value( cursor, 373 );
      end if;
      if not gse.Is_Null( cursor, 374 )then
         a_househol.eulowest:= Amount'Value( gse.Value( cursor, 374 ));
      end if;
      if not gse.Is_Null( cursor, 375 )then
         a_househol.flshtoil := gse.Integer_Value( cursor, 375 );
      end if;
      if not gse.Is_Null( cursor, 376 )then
         a_househol.grocse := gse.Integer_Value( cursor, 376 );
      end if;
      if not gse.Is_Null( cursor, 377 )then
         a_househol.gvtregno := gse.Integer_Value( cursor, 377 );
      end if;
      if not gse.Is_Null( cursor, 378 )then
         a_househol.heat := gse.Integer_Value( cursor, 378 );
      end if;
      if not gse.Is_Null( cursor, 379 )then
         a_househol.heatcen := gse.Integer_Value( cursor, 379 );
      end if;
      if not gse.Is_Null( cursor, 380 )then
         a_househol.heatfire := gse.Integer_Value( cursor, 380 );
      end if;
      if not gse.Is_Null( cursor, 381 )then
         a_househol.kitchen := gse.Integer_Value( cursor, 381 );
      end if;
      if not gse.Is_Null( cursor, 382 )then
         a_househol.knsizeft := gse.Integer_Value( cursor, 382 );
      end if;
      if not gse.Is_Null( cursor, 383 )then
         a_househol.knsizem := gse.Integer_Value( cursor, 383 );
      end if;
      if not gse.Is_Null( cursor, 384 )then
         a_househol.laua := gse.Integer_Value( cursor, 384 );
      end if;
      if not gse.Is_Null( cursor, 385 )then
         a_househol.movef := gse.Integer_Value( cursor, 385 );
      end if;
      if not gse.Is_Null( cursor, 386 )then
         a_househol.movenxt := gse.Integer_Value( cursor, 386 );
      end if;
      if not gse.Is_Null( cursor, 387 )then
         a_househol.movereas := gse.Integer_Value( cursor, 387 );
      end if;
      if not gse.Is_Null( cursor, 388 )then
         a_househol.ovsat := gse.Integer_Value( cursor, 388 );
      end if;
      if not gse.Is_Null( cursor, 389 )then
         a_househol.plum1bin := gse.Integer_Value( cursor, 389 );
      end if;
      if not gse.Is_Null( cursor, 390 )then
         a_househol.plumin := gse.Integer_Value( cursor, 390 );
      end if;
      if not gse.Is_Null( cursor, 391 )then
         a_househol.pluminw := gse.Integer_Value( cursor, 391 );
      end if;
      if not gse.Is_Null( cursor, 392 )then
         a_househol.postse := gse.Integer_Value( cursor, 392 );
      end if;
      if not gse.Is_Null( cursor, 393 )then
         a_househol.primh := gse.Integer_Value( cursor, 393 );
      end if;
      if not gse.Is_Null( cursor, 394 )then
         a_househol.pubtr := gse.Integer_Value( cursor, 394 );
      end if;
      if not gse.Is_Null( cursor, 395 )then
         a_househol.samesc := gse.Integer_Value( cursor, 395 );
      end if;
      if not gse.Is_Null( cursor, 396 )then
         a_househol.schfrt := gse.Integer_Value( cursor, 396 );
      end if;
      if not gse.Is_Null( cursor, 397 )then
         a_househol.selper := gse.Integer_Value( cursor, 397 );
      end if;
      if not gse.Is_Null( cursor, 398 )then
         a_househol.short := gse.Integer_Value( cursor, 398 );
      end if;
      if not gse.Is_Null( cursor, 399 )then
         a_househol.sizeft := gse.Integer_Value( cursor, 399 );
      end if;
      if not gse.Is_Null( cursor, 400 )then
         a_househol.sizem := gse.Integer_Value( cursor, 400 );
      end if;
      if not gse.Is_Null( cursor, 401 )then
         a_househol.tvwhy := gse.Integer_Value( cursor, 401 );
      end if;
      if not gse.Is_Null( cursor, 402 )then
         a_househol.yearwhc := gse.Integer_Value( cursor, 402 );
      end if;
      if not gse.Is_Null( cursor, 403 )then
         a_househol.dischha1 := gse.Integer_Value( cursor, 403 );
      end if;
      if not gse.Is_Null( cursor, 404 )then
         a_househol.dischhc1 := gse.Integer_Value( cursor, 404 );
      end if;
      if not gse.Is_Null( cursor, 405 )then
         a_househol.diswhha1 := gse.Integer_Value( cursor, 405 );
      end if;
      if not gse.Is_Null( cursor, 406 )then
         a_househol.diswhhc1 := gse.Integer_Value( cursor, 406 );
      end if;
      if not gse.Is_Null( cursor, 407 )then
         a_househol.gross4 := gse.Integer_Value( cursor, 407 );
      end if;
      if not gse.Is_Null( cursor, 408 )then
         a_househol.lldcare := gse.Integer_Value( cursor, 408 );
      end if;
      if not gse.Is_Null( cursor, 409 )then
         a_househol.urindni := gse.Integer_Value( cursor, 409 );
      end if;
      if not gse.Is_Null( cursor, 410 )then
         a_househol.nhbeninc := gse.Integer_Value( cursor, 410 );
      end if;
      if not gse.Is_Null( cursor, 411 )then
         a_househol.nhhnirbn := gse.Integer_Value( cursor, 411 );
      end if;
      if not gse.Is_Null( cursor, 412 )then
         a_househol.nhhothbn := gse.Integer_Value( cursor, 412 );
      end if;
      if not gse.Is_Null( cursor, 413 )then
         a_househol.seramt1:= Amount'Value( gse.Value( cursor, 413 ));
      end if;
      if not gse.Is_Null( cursor, 414 )then
         a_househol.seramt2:= Amount'Value( gse.Value( cursor, 414 ));
      end if;
      if not gse.Is_Null( cursor, 415 )then
         a_househol.seramt3:= Amount'Value( gse.Value( cursor, 415 ));
      end if;
      if not gse.Is_Null( cursor, 416 )then
         a_househol.seramt4:= Amount'Value( gse.Value( cursor, 416 ));
      end if;
      if not gse.Is_Null( cursor, 417 )then
         a_househol.serpay1 := gse.Integer_Value( cursor, 417 );
      end if;
      if not gse.Is_Null( cursor, 418 )then
         a_househol.serpay2 := gse.Integer_Value( cursor, 418 );
      end if;
      if not gse.Is_Null( cursor, 419 )then
         a_househol.serpay3 := gse.Integer_Value( cursor, 419 );
      end if;
      if not gse.Is_Null( cursor, 420 )then
         a_househol.serpay4 := gse.Integer_Value( cursor, 420 );
      end if;
      if not gse.Is_Null( cursor, 421 )then
         a_househol.serper1 := gse.Integer_Value( cursor, 421 );
      end if;
      if not gse.Is_Null( cursor, 422 )then
         a_househol.serper2 := gse.Integer_Value( cursor, 422 );
      end if;
      if not gse.Is_Null( cursor, 423 )then
         a_househol.serper3 := gse.Integer_Value( cursor, 423 );
      end if;
      if not gse.Is_Null( cursor, 424 )then
         a_househol.serper4 := gse.Integer_Value( cursor, 424 );
      end if;
      if not gse.Is_Null( cursor, 425 )then
         a_househol.utility := gse.Integer_Value( cursor, 425 );
      end if;
      if not gse.Is_Null( cursor, 426 )then
         a_househol.hheth := gse.Integer_Value( cursor, 426 );
      end if;
      if not gse.Is_Null( cursor, 427 )then
         a_househol.seramt5:= Amount'Value( gse.Value( cursor, 427 ));
      end if;
      if not gse.Is_Null( cursor, 428 )then
         a_househol.sercomb := gse.Integer_Value( cursor, 428 );
      end if;
      if not gse.Is_Null( cursor, 429 )then
         a_househol.serpay5 := gse.Integer_Value( cursor, 429 );
      end if;
      if not gse.Is_Null( cursor, 430 )then
         a_househol.serper5 := gse.Integer_Value( cursor, 430 );
      end if;
      if not gse.Is_Null( cursor, 431 )then
         a_househol.urbni := gse.Integer_Value( cursor, 431 );
      end if;
      return a_househol;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Househol_List is
      l : Ukds.Frs.Househol_List;
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
            a_househol : Ukds.Frs.Househol := Map_From_Cursor( cursor );
         begin
            l.append( a_househol ); 
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
   
   procedure Update( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) is
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params( Update_Order => True );
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

      params( 1 ) := "+"( Integer'Pos( a_househol.acorn ));
      params( 2 ) := "+"( Integer'Pos( a_househol.bedroom ));
      params( 3 ) := "+"( Integer'Pos( a_househol.benunits ));
      params( 4 ) := "+"( Integer'Pos( a_househol.billrate ));
      params( 5 ) := "+"( Integer'Pos( a_househol.busroom ));
      params( 6 ) := "+"( Integer'Pos( a_househol.centfuel ));
      params( 7 ) := "+"( Integer'Pos( a_househol.centheat ));
      params( 8 ) := "+"( Integer'Pos( a_househol.charge1 ));
      params( 9 ) := "+"( Integer'Pos( a_househol.charge2 ));
      params( 10 ) := "+"( Integer'Pos( a_househol.charge3 ));
      params( 11 ) := "+"( Integer'Pos( a_househol.charge4 ));
      params( 12 ) := "+"( Integer'Pos( a_househol.charge5 ));
      params( 13 ) := "+"( Integer'Pos( a_househol.charge6 ));
      params( 14 ) := "+"( Integer'Pos( a_househol.charge7 ));
      params( 15 ) := "+"( Integer'Pos( a_househol.charge8 ));
      params( 16 ) := "+"( Integer'Pos( a_househol.charge9 ));
      params( 17 ) := "+"( Integer'Pos( a_househol.chins ));
      params( 18 ) := "+"( Float( a_househol.chrgamt1 ));
      params( 19 ) := "+"( Float( a_househol.chrgamt2 ));
      params( 20 ) := "+"( Float( a_househol.chrgamt3 ));
      params( 21 ) := "+"( Float( a_househol.chrgamt4 ));
      params( 22 ) := "+"( Float( a_househol.chrgamt5 ));
      params( 23 ) := "+"( Float( a_househol.chrgamt6 ));
      params( 24 ) := "+"( Float( a_househol.chrgamt7 ));
      params( 25 ) := "+"( Float( a_househol.chrgamt8 ));
      params( 26 ) := "+"( Float( a_househol.chrgamt9 ));
      params( 27 ) := "+"( Integer'Pos( a_househol.chrgpd1 ));
      params( 28 ) := "+"( Integer'Pos( a_househol.chrgpd2 ));
      params( 29 ) := "+"( Integer'Pos( a_househol.chrgpd3 ));
      params( 30 ) := "+"( Integer'Pos( a_househol.chrgpd4 ));
      params( 31 ) := "+"( Integer'Pos( a_househol.chrgpd5 ));
      params( 32 ) := "+"( Integer'Pos( a_househol.chrgpd6 ));
      params( 33 ) := "+"( Integer'Pos( a_househol.chrgpd7 ));
      params( 34 ) := "+"( Integer'Pos( a_househol.chrgpd8 ));
      params( 35 ) := "+"( Integer'Pos( a_househol.chrgpd9 ));
      params( 36 ) := "+"( Integer'Pos( a_househol.contv1 ));
      params( 37 ) := "+"( Integer'Pos( a_househol.contv2 ));
      params( 38 ) := "+"( Integer'Pos( a_househol.covoths ));
      params( 39 ) := "+"( Float( a_househol.csewamt ));
      params( 40 ) := "+"( Float( a_househol.csewamt1 ));
      params( 41 ) := "+"( Integer'Pos( a_househol.ct25d50d ));
      params( 42 ) := "+"( Integer'Pos( a_househol.ctamt ));
      params( 43 ) := "+"( Float( a_househol.ctannual ));
      params( 44 ) := "+"( Integer'Pos( a_househol.ctband ));
      params( 45 ) := "+"( Integer'Pos( a_househol.ctbwait ));
      params( 46 ) := "+"( Integer'Pos( a_househol.ctcondoc ));
      params( 47 ) := "+"( Integer'Pos( a_househol.ctdisc ));
      params( 48 ) := "+"( Integer'Pos( a_househol.ctinstal ));
      params( 49 ) := "+"( Integer'Pos( a_househol.ctlvband ));
      params( 50 ) := "+"( Integer'Pos( a_househol.ctlvchk ));
      params( 51 ) := "+"( Integer'Pos( a_househol.ctreb ));
      params( 52 ) := "+"( Integer'Pos( a_househol.ctrebamt ));
      params( 53 ) := "+"( Integer'Pos( a_househol.ctrebpd ));
      params( 54 ) := "+"( Integer'Pos( a_househol.cttime ));
      params( 55 ) := "+"( Integer'Pos( a_househol.cwatamt ));
      params( 56 ) := "+"( Integer'Pos( a_househol.cwatamt1 ));
      params( 57 ) := "+"( a_househol.datyrago );
      params( 58 ) := "+"( Integer'Pos( a_househol.entry1 ));
      params( 59 ) := "+"( Integer'Pos( a_househol.entry2 ));
      params( 60 ) := "+"( Integer'Pos( a_househol.entry3 ));
      params( 61 ) := "+"( Integer'Pos( a_househol.entry4 ));
      params( 62 ) := "+"( Float( a_househol.estrtann ));
      params( 63 ) := "+"( Integer'Pos( a_househol.floor ));
      params( 64 ) := "+"( Integer'Pos( a_househol.givehelp ));
      params( 65 ) := "+"( Integer'Pos( a_househol.gor ));
      params( 66 ) := "+"( Integer'Pos( a_househol.gvtregn ));
      params( 67 ) := "+"( Integer'Pos( a_househol.hhldr01 ));
      params( 68 ) := "+"( Integer'Pos( a_househol.hhldr02 ));
      params( 69 ) := "+"( Integer'Pos( a_househol.hhldr03 ));
      params( 70 ) := "+"( Integer'Pos( a_househol.hhldr04 ));
      params( 71 ) := "+"( Integer'Pos( a_househol.hhldr05 ));
      params( 72 ) := "+"( Integer'Pos( a_househol.hhldr06 ));
      params( 73 ) := "+"( Integer'Pos( a_househol.hhldr07 ));
      params( 74 ) := "+"( Integer'Pos( a_househol.hhldr08 ));
      params( 75 ) := "+"( Integer'Pos( a_househol.hhldr09 ));
      params( 76 ) := "+"( Integer'Pos( a_househol.hhldr10 ));
      params( 77 ) := "+"( Integer'Pos( a_househol.hhldr11 ));
      params( 78 ) := "+"( Integer'Pos( a_househol.hhldr12 ));
      params( 79 ) := "+"( Integer'Pos( a_househol.hhldr13 ));
      params( 80 ) := "+"( Integer'Pos( a_househol.hhldr14 ));
      params( 81 ) := "+"( Integer'Pos( a_househol.hhldr97 ));
      params( 82 ) := "+"( Integer'Pos( a_househol.hhstat ));
      params( 83 ) := "+"( Integer'Pos( a_househol.hrpnum ));
      params( 84 ) := "+"( a_househol.intdate );
      params( 85 ) := "+"( Integer'Pos( a_househol.lac ));
      params( 86 ) := "+"( Integer'Pos( a_househol.mainacc ));
      params( 87 ) := "+"( Integer'Pos( a_househol.mnthcode ));
      params( 88 ) := "+"( Integer'Pos( a_househol.modcon01 ));
      params( 89 ) := "+"( Integer'Pos( a_househol.modcon02 ));
      params( 90 ) := "+"( Integer'Pos( a_househol.modcon03 ));
      params( 91 ) := "+"( Integer'Pos( a_househol.modcon04 ));
      params( 92 ) := "+"( Integer'Pos( a_househol.modcon05 ));
      params( 93 ) := "+"( Integer'Pos( a_househol.modcon06 ));
      params( 94 ) := "+"( Integer'Pos( a_househol.modcon07 ));
      params( 95 ) := "+"( Integer'Pos( a_househol.modcon08 ));
      params( 96 ) := "+"( Integer'Pos( a_househol.modcon09 ));
      params( 97 ) := "+"( Integer'Pos( a_househol.modcon10 ));
      params( 98 ) := "+"( Integer'Pos( a_househol.modcon11 ));
      params( 99 ) := "+"( Integer'Pos( a_househol.modcon12 ));
      params( 100 ) := "+"( Integer'Pos( a_househol.modcon13 ));
      params( 101 ) := "+"( Integer'Pos( a_househol.modcon14 ));
      params( 102 ) := "+"( Integer'Pos( a_househol.monlive ));
      params( 103 ) := "+"( Integer'Pos( a_househol.needhelp ));
      params( 104 ) := "+"( Integer'Pos( a_househol.nicoun ));
      params( 105 ) := "+"( Float( a_househol.ninrv ));
      params( 106 ) := "+"( Integer'Pos( a_househol.nirate ));
      params( 107 ) := "+"( Integer'Pos( a_househol.norate ));
      params( 108 ) := "+"( Integer'Pos( a_househol.onbsroom ));
      params( 109 ) := "+"( Float( a_househol.orgsewam ));
      params( 110 ) := "+"( Float( a_househol.orgwatam ));
      params( 111 ) := "+"( Integer'Pos( a_househol.payrate ));
      params( 112 ) := "+"( Integer'Pos( a_househol.premium ));
      params( 113 ) := "+"( Integer'Pos( a_househol.ptbsroom ));
      params( 114 ) := "+"( Integer'Pos( a_househol.rooms ));
      params( 115 ) := "+"( Integer'Pos( a_househol.roomshar ));
      params( 116 ) := "+"( Float( a_househol.rtannual ));
      params( 117 ) := "+"( Float( a_househol.rtcheck ));
      params( 118 ) := "+"( Integer'Pos( a_househol.rtcondoc ));
      params( 119 ) := "+"( Integer'Pos( a_househol.rtdeduc ));
      params( 120 ) := "+"( Integer'Pos( a_househol.rtinstal ));
      params( 121 ) := "+"( Integer'Pos( a_househol.rtreb ));
      params( 122 ) := "+"( Float( a_househol.rtrebamt ));
      params( 123 ) := "+"( Integer'Pos( a_househol.rtrebpd ));
      params( 124 ) := "+"( Integer'Pos( a_househol.rttime ));
      params( 125 ) := "+"( Integer'Pos( a_househol.sampqtr ));
      params( 126 ) := "+"( Integer'Pos( a_househol.schmeal ));
      params( 127 ) := "+"( Integer'Pos( a_househol.schmilk ));
      params( 128 ) := "+"( Float( a_househol.sewamt ));
      params( 129 ) := "+"( Float( a_househol.sewanul ));
      params( 130 ) := "+"( Integer'Pos( a_househol.sewerpay ));
      params( 131 ) := "+"( Integer'Pos( a_househol.sewsep ));
      params( 132 ) := "+"( Integer'Pos( a_househol.sewtime ));
      params( 133 ) := "+"( Integer'Pos( a_househol.shelter ));
      params( 134 ) := "+"( Integer'Pos( a_househol.sobuy ));
      params( 135 ) := "+"( Integer'Pos( a_househol.sstrtreg ));
      params( 136 ) := "+"( Float( a_househol.stramt1 ));
      params( 137 ) := "+"( Float( a_househol.stramt2 ));
      params( 138 ) := "+"( Integer'Pos( a_househol.strcov ));
      params( 139 ) := "+"( Integer'Pos( a_househol.strmort ));
      params( 140 ) := "+"( Integer'Pos( a_househol.stroths ));
      params( 141 ) := "+"( Integer'Pos( a_househol.strpd1 ));
      params( 142 ) := "+"( Integer'Pos( a_househol.strpd2 ));
      params( 143 ) := "+"( Integer'Pos( a_househol.suballow ));
      params( 144 ) := "+"( Integer'Pos( a_househol.sublet ));
      params( 145 ) := "+"( Integer'Pos( a_househol.sublety ));
      params( 146 ) := "+"( Float( a_househol.subrent ));
      params( 147 ) := "+"( Integer'Pos( a_househol.tenure ));
      params( 148 ) := "+"( Integer'Pos( a_househol.totadult ));
      params( 149 ) := "+"( Integer'Pos( a_househol.totchild ));
      params( 150 ) := "+"( Integer'Pos( a_househol.totdepdk ));
      params( 151 ) := "+"( Integer'Pos( a_househol.tvlic ));
      params( 152 ) := "+"( Integer'Pos( a_househol.typeacc ));
      params( 153 ) := "+"( Integer'Pos( a_househol.usevcl ));
      params( 154 ) := "+"( Float( a_househol.watamt ));
      params( 155 ) := "+"( Float( a_househol.watanul ));
      params( 156 ) := "+"( Integer'Pos( a_househol.watermet ));
      params( 157 ) := "+"( Integer'Pos( a_househol.waterpay ));
      params( 158 ) := "+"( Integer'Pos( a_househol.watrb ));
      params( 159 ) := "+"( Integer'Pos( a_househol.wattime ));
      params( 160 ) := "+"( Integer'Pos( a_househol.welfmilk ));
      params( 161 ) := "+"( Integer'Pos( a_househol.whoctb01 ));
      params( 162 ) := "+"( Integer'Pos( a_househol.whoctb02 ));
      params( 163 ) := "+"( Integer'Pos( a_househol.whoctb03 ));
      params( 164 ) := "+"( Integer'Pos( a_househol.whoctb04 ));
      params( 165 ) := "+"( Integer'Pos( a_househol.whoctb05 ));
      params( 166 ) := "+"( Integer'Pos( a_househol.whoctb06 ));
      params( 167 ) := "+"( Integer'Pos( a_househol.whoctb07 ));
      params( 168 ) := "+"( Integer'Pos( a_househol.whoctb08 ));
      params( 169 ) := "+"( Integer'Pos( a_househol.whoctb09 ));
      params( 170 ) := "+"( Integer'Pos( a_househol.whoctb10 ));
      params( 171 ) := "+"( Integer'Pos( a_househol.whoctb11 ));
      params( 172 ) := "+"( Integer'Pos( a_househol.whoctb12 ));
      params( 173 ) := "+"( Integer'Pos( a_househol.whoctb13 ));
      params( 174 ) := "+"( Integer'Pos( a_househol.whoctb14 ));
      params( 175 ) := "+"( Integer'Pos( a_househol.whoctbns ));
      params( 176 ) := "+"( Integer'Pos( a_househol.whoctbot ));
      params( 177 ) := "+"( Integer'Pos( a_househol.whorsp01 ));
      params( 178 ) := "+"( Integer'Pos( a_househol.whorsp02 ));
      params( 179 ) := "+"( Integer'Pos( a_househol.whorsp03 ));
      params( 180 ) := "+"( Integer'Pos( a_househol.whorsp04 ));
      params( 181 ) := "+"( Integer'Pos( a_househol.whorsp05 ));
      params( 182 ) := "+"( Integer'Pos( a_househol.whorsp06 ));
      params( 183 ) := "+"( Integer'Pos( a_househol.whorsp07 ));
      params( 184 ) := "+"( Integer'Pos( a_househol.whorsp08 ));
      params( 185 ) := "+"( Integer'Pos( a_househol.whorsp09 ));
      params( 186 ) := "+"( Integer'Pos( a_househol.whorsp10 ));
      params( 187 ) := "+"( Integer'Pos( a_househol.whorsp11 ));
      params( 188 ) := "+"( Integer'Pos( a_househol.whorsp12 ));
      params( 189 ) := "+"( Integer'Pos( a_househol.whorsp13 ));
      params( 190 ) := "+"( Integer'Pos( a_househol.whorsp14 ));
      params( 191 ) := "+"( Integer'Pos( a_househol.whynoct ));
      params( 192 ) := "+"( Integer'Pos( a_househol.wmintro ));
      params( 193 ) := "+"( Float( a_househol.wsewamt ));
      params( 194 ) := "+"( Float( a_househol.wsewanul ));
      params( 195 ) := "+"( Integer'Pos( a_househol.wsewtime ));
      params( 196 ) := "+"( Integer'Pos( a_househol.yearcode ));
      params( 197 ) := "+"( Integer'Pos( a_househol.yearlive ));
      params( 198 ) := "+"( Integer'Pos( a_househol.month ));
      params( 199 ) := "+"( Integer'Pos( a_househol.actacch ));
      params( 200 ) := "+"( Integer'Pos( a_househol.adddahh ));
      params( 201 ) := "+"( Integer'Pos( a_househol.adulth ));
      params( 202 ) := "+"( Integer'Pos( a_househol.basacth ));
      params( 203 ) := "+"( Integer'Pos( a_househol.chddahh ));
      params( 204 ) := "+"( Integer'Pos( a_househol.curacth ));
      params( 205 ) := "+"( Integer'Pos( a_househol.cwatamtd ));
      params( 206 ) := "+"( Integer'Pos( a_househol.depchldh ));
      params( 207 ) := "+"( Integer'Pos( a_househol.emp ));
      params( 208 ) := "+"( Integer'Pos( a_househol.emphrp ));
      params( 209 ) := "+"( Float( a_househol.endowpay ));
      params( 210 ) := "+"( Float( a_househol.equivahc ));
      params( 211 ) := "+"( Float( a_househol.equivbhc ));
      params( 212 ) := "+"( Integer'Pos( a_househol.fsbndcth ));
      params( 213 ) := "+"( Integer'Pos( a_househol.gbhscost ));
      params( 214 ) := "+"( Integer'Pos( a_househol.gebacth ));
      params( 215 ) := "+"( Integer'Pos( a_househol.giltcth ));
      params( 216 ) := "+"( Integer'Pos( a_househol.gross2 ));
      params( 217 ) := "+"( Integer'Pos( a_househol.gross3 ));
      params( 218 ) := "+"( Integer'Pos( a_househol.grossct ));
      params( 219 ) := "+"( Integer'Pos( a_househol.hbeninc ));
      params( 220 ) := "+"( Integer'Pos( a_househol.hbindhh ));
      params( 221 ) := "+"( Integer'Pos( a_househol.hcband ));
      params( 222 ) := "+"( Integer'Pos( a_househol.hdhhinc ));
      params( 223 ) := "+"( Integer'Pos( a_househol.hdtax ));
      params( 224 ) := "+"( Float( a_househol.hearns ));
      params( 225 ) := "+"( Integer'Pos( a_househol.hhagegr2 ));
      params( 226 ) := "+"( Integer'Pos( a_househol.hhagegrp ));
      params( 227 ) := "+"( Integer'Pos( a_househol.hhcomp ));
      params( 228 ) := "+"( Integer'Pos( a_househol.hhcomps ));
      params( 229 ) := "+"( Integer'Pos( a_househol.hhdisben ));
      params( 230 ) := "+"( Integer'Pos( a_househol.hhethgr2 ));
      params( 231 ) := "+"( Integer'Pos( a_househol.hhethgrp ));
      params( 232 ) := "+"( Integer'Pos( a_househol.hhinc ));
      params( 233 ) := "+"( Integer'Pos( a_househol.hhincbnd ));
      params( 234 ) := "+"( Float( a_househol.hhinv ));
      params( 235 ) := "+"( Integer'Pos( a_househol.hhirben ));
      params( 236 ) := "+"( Integer'Pos( a_househol.hhkids ));
      params( 237 ) := "+"( Integer'Pos( a_househol.hhnirben ));
      params( 238 ) := "+"( Integer'Pos( a_househol.hhothben ));
      params( 239 ) := "+"( Integer'Pos( a_househol.hhrent ));
      params( 240 ) := "+"( Float( a_househol.hhrinc ));
      params( 241 ) := "+"( Float( a_househol.hhrpinc ));
      params( 242 ) := "+"( Integer'Pos( a_househol.hhsize ));
      params( 243 ) := "+"( Float( a_househol.hhtvlic ));
      params( 244 ) := "+"( Float( a_househol.hhtxcred ));
      params( 245 ) := "+"( Float( a_househol.hothinc ));
      params( 246 ) := "+"( Float( a_househol.hpeninc ));
      params( 247 ) := "+"( Integer'Pos( a_househol.hrband ));
      params( 248 ) := "+"( Float( a_househol.hseinc ));
      params( 249 ) := "+"( Integer'Pos( a_househol.isacth ));
      params( 250 ) := "+"( Integer'Pos( a_househol.london ));
      params( 251 ) := "+"( Float( a_househol.mortcost ));
      params( 252 ) := "+"( Float( a_househol.mortint ));
      params( 253 ) := "+"( Float( a_househol.mortpay ));
      params( 254 ) := "+"( Float( a_househol.nddctb ));
      params( 255 ) := "+"( Float( a_househol.nddishc ));
      params( 256 ) := "+"( Integer'Pos( a_househol.nihscost ));
      params( 257 ) := "+"( Integer'Pos( a_househol.nsbocth ));
      params( 258 ) := "+"( Integer'Pos( a_househol.otbscth ));
      params( 259 ) := "+"( Integer'Pos( a_househol.pacctype ));
      params( 260 ) := "+"( Integer'Pos( a_househol.penage ));
      params( 261 ) := "+"( Integer'Pos( a_househol.penhrp ));
      params( 262 ) := "+"( Integer'Pos( a_househol.pepscth ));
      params( 263 ) := "+"( Integer'Pos( a_househol.poaccth ));
      params( 264 ) := "+"( Integer'Pos( a_househol.prbocth ));
      params( 265 ) := "+"( Integer'Pos( a_househol.ptentyp2 ));
      params( 266 ) := "+"( Integer'Pos( a_househol.sayecth ));
      params( 267 ) := "+"( Integer'Pos( a_househol.sclbcth ));
      params( 268 ) := "+"( Float( a_househol.servpay ));
      params( 269 ) := "+"( Integer'Pos( a_househol.sick ));
      params( 270 ) := "+"( Integer'Pos( a_househol.sickhrp ));
      params( 271 ) := "+"( Integer'Pos( a_househol.sscth ));
      params( 272 ) := "+"( Float( a_househol.struins ));
      params( 273 ) := "+"( Integer'Pos( a_househol.stshcth ));
      params( 274 ) := "+"( Integer'Pos( a_househol.tentyp2 ));
      params( 275 ) := "+"( Integer'Pos( a_househol.tesscth ));
      params( 276 ) := "+"( Float( a_househol.tuhhrent ));
      params( 277 ) := "+"( Float( a_househol.tuwatsew ));
      params( 278 ) := "+"( Integer'Pos( a_househol.untrcth ));
      params( 279 ) := "+"( Float( a_househol.watsewrt ));
      params( 280 ) := "+"( Integer'Pos( a_househol.acornew ));
      params( 281 ) := "+"( Integer'Pos( a_househol.crunach ));
      params( 282 ) := "+"( Integer'Pos( a_househol.enomorth ));
      params( 283 ) := "+"( Integer'Pos( a_househol.dvadulth ));
      params( 284 ) := "+"( Integer'Pos( a_househol.dvtotad ));
      params( 285 ) := "+"( Integer'Pos( a_househol.urindew ));
      params( 286 ) := "+"( Integer'Pos( a_househol.urinds ));
      params( 287 ) := "+"( Integer'Pos( a_househol.vehnumb ));
      params( 288 ) := "+"( Integer'Pos( a_househol.country ));
      params( 289 ) := "+"( Integer'Pos( a_househol.hbindhh2 ));
      params( 290 ) := "+"( Integer'Pos( a_househol.pocardh ));
      params( 291 ) := "+"( Integer'Pos( a_househol.entry5 ));
      params( 292 ) := "+"( Integer'Pos( a_househol.entry6 ));
      params( 293 ) := "+"( Integer'Pos( a_househol.imd_e ));
      params( 294 ) := "+"( Integer'Pos( a_househol.imd_s ));
      params( 295 ) := "+"( Integer'Pos( a_househol.imd_w ));
      params( 296 ) := "+"( Integer'Pos( a_househol.numtv1 ));
      params( 297 ) := "+"( Integer'Pos( a_househol.numtv2 ));
      params( 298 ) := "+"( Integer'Pos( a_househol.oac ));
      params( 299 ) := "+"( Integer'Pos( a_househol.bedroom6 ));
      params( 300 ) := "+"( Integer'Pos( a_househol.rooms10 ));
      params( 301 ) := "+"( Integer'Pos( a_househol.brma ));
      params( 302 ) := "+"( Integer'Pos( a_househol.issue ));
      params( 303 ) := "+"( Integer'Pos( a_househol.migrq1 ));
      params( 304 ) := "+"( Integer'Pos( a_househol.migrq2 ));
      params( 305 ) := "+"( Integer'Pos( a_househol.hhagegr3 ));
      params( 306 ) := "+"( Integer'Pos( a_househol.hhagegr4 ));
      params( 307 ) := "+"( Integer'Pos( a_househol.capval ));
      params( 308 ) := "+"( Integer'Pos( a_househol.nidpnd ));
      params( 309 ) := "+"( Integer'Pos( a_househol.nochcr1 ));
      params( 310 ) := "+"( Integer'Pos( a_househol.nochcr2 ));
      params( 311 ) := "+"( Integer'Pos( a_househol.nochcr3 ));
      params( 312 ) := "+"( Integer'Pos( a_househol.nochcr4 ));
      params( 313 ) := "+"( Integer'Pos( a_househol.nochcr5 ));
      params( 314 ) := "+"( Float( a_househol.rt2rebam ));
      params( 315 ) := "+"( Integer'Pos( a_househol.rt2rebpd ));
      params( 316 ) := "+"( Integer'Pos( a_househol.rtdpa ));
      params( 317 ) := "+"( Float( a_househol.rtdpaamt ));
      params( 318 ) := "+"( Integer'Pos( a_househol.rtdpapd ));
      params( 319 ) := "+"( Integer'Pos( a_househol.rtlpa ));
      params( 320 ) := "+"( Float( a_househol.rtlpaamt ));
      params( 321 ) := "+"( Integer'Pos( a_househol.rtlpapd ));
      params( 322 ) := "+"( Float( a_househol.rtothamt ));
      params( 323 ) := "+"( Integer'Pos( a_househol.rtother ));
      params( 324 ) := "+"( Integer'Pos( a_househol.rtothpd ));
      params( 325 ) := "+"( Integer'Pos( a_househol.rtrtr ));
      params( 326 ) := "+"( Float( a_househol.rtrtramt ));
      params( 327 ) := "+"( Integer'Pos( a_househol.rtrtrpd ));
      params( 328 ) := "+"( Integer'Pos( a_househol.rttimepd ));
      params( 329 ) := "+"( Integer'Pos( a_househol.yrlvchk ));
      params( 330 ) := "+"( Integer'Pos( a_househol.gross3_x ));
      params( 331 ) := "+"( Integer'Pos( a_househol.hlthst ));
      params( 332 ) := "+"( Integer'Pos( a_househol.medpay ));
      params( 333 ) := "+"( Integer'Pos( a_househol.medwho01 ));
      params( 334 ) := "+"( Integer'Pos( a_househol.medwho02 ));
      params( 335 ) := "+"( Integer'Pos( a_househol.medwho03 ));
      params( 336 ) := "+"( Integer'Pos( a_househol.medwho04 ));
      params( 337 ) := "+"( Integer'Pos( a_househol.medwho05 ));
      params( 338 ) := "+"( Integer'Pos( a_househol.medwho06 ));
      params( 339 ) := "+"( Integer'Pos( a_househol.medwho07 ));
      params( 340 ) := "+"( Integer'Pos( a_househol.medwho08 ));
      params( 341 ) := "+"( Integer'Pos( a_househol.medwho09 ));
      params( 342 ) := "+"( Integer'Pos( a_househol.medwho10 ));
      params( 343 ) := "+"( Integer'Pos( a_househol.medwho11 ));
      params( 344 ) := "+"( Integer'Pos( a_househol.medwho12 ));
      params( 345 ) := "+"( Integer'Pos( a_househol.medwho13 ));
      params( 346 ) := "+"( Integer'Pos( a_househol.medwho14 ));
      params( 347 ) := "+"( Integer'Pos( a_househol.nmrmshar ));
      params( 348 ) := "+"( Integer'Pos( a_househol.roomshr ));
      params( 349 ) := "+"( Integer'Pos( a_househol.imd_ni ));
      params( 350 ) := "+"( Integer'Pos( a_househol.multi ));
      params( 351 ) := "+"( Integer'Pos( a_househol.nopay ));
      params( 352 ) := "+"( Integer'Pos( a_househol.orgid ));
      params( 353 ) := "+"( Integer'Pos( a_househol.rtene ));
      params( 354 ) := "+"( Integer'Pos( a_househol.rteneamt ));
      params( 355 ) := "+"( Integer'Pos( a_househol.rtgen ));
      params( 356 ) := "+"( Integer'Pos( a_househol.schbrk ));
      params( 357 ) := "+"( Integer'Pos( a_househol.urb ));
      params( 358 ) := "+"( Integer'Pos( a_househol.urbrur ));
      params( 359 ) := "+"( Integer'Pos( a_househol.hhethgr3 ));
      params( 360 ) := "+"( Float( a_househol.niratlia ));
      params( 361 ) := "+"( Integer'Pos( a_househol.bankse ));
      params( 362 ) := "+"( Integer'Pos( a_househol.bathshow ));
      params( 363 ) := "+"( Integer'Pos( a_househol.burden ));
      params( 364 ) := "+"( Integer'Pos( a_househol.comco ));
      params( 365 ) := "+"( Integer'Pos( a_househol.comp1sc ));
      params( 366 ) := "+"( Integer'Pos( a_househol.compsc ));
      params( 367 ) := "+"( Integer'Pos( a_househol.comwa ));
      params( 368 ) := "+"( Integer'Pos( a_househol.dwellno ));
      params( 369 ) := "+"( Integer'Pos( a_househol.elecin ));
      params( 370 ) := "+"( Integer'Pos( a_househol.elecinw ));
      params( 371 ) := "+"( Float( a_househol.eulowest ));
      params( 372 ) := "+"( Integer'Pos( a_househol.flshtoil ));
      params( 373 ) := "+"( Integer'Pos( a_househol.grocse ));
      params( 374 ) := "+"( Integer'Pos( a_househol.gvtregno ));
      params( 375 ) := "+"( Integer'Pos( a_househol.heat ));
      params( 376 ) := "+"( Integer'Pos( a_househol.heatcen ));
      params( 377 ) := "+"( Integer'Pos( a_househol.heatfire ));
      params( 378 ) := "+"( Integer'Pos( a_househol.kitchen ));
      params( 379 ) := "+"( Integer'Pos( a_househol.knsizeft ));
      params( 380 ) := "+"( Integer'Pos( a_househol.knsizem ));
      params( 381 ) := "+"( Integer'Pos( a_househol.laua ));
      params( 382 ) := "+"( Integer'Pos( a_househol.movef ));
      params( 383 ) := "+"( Integer'Pos( a_househol.movenxt ));
      params( 384 ) := "+"( Integer'Pos( a_househol.movereas ));
      params( 385 ) := "+"( Integer'Pos( a_househol.ovsat ));
      params( 386 ) := "+"( Integer'Pos( a_househol.plum1bin ));
      params( 387 ) := "+"( Integer'Pos( a_househol.plumin ));
      params( 388 ) := "+"( Integer'Pos( a_househol.pluminw ));
      params( 389 ) := "+"( Integer'Pos( a_househol.postse ));
      params( 390 ) := "+"( Integer'Pos( a_househol.primh ));
      params( 391 ) := "+"( Integer'Pos( a_househol.pubtr ));
      params( 392 ) := "+"( Integer'Pos( a_househol.samesc ));
      params( 393 ) := "+"( Integer'Pos( a_househol.schfrt ));
      params( 394 ) := "+"( Integer'Pos( a_househol.selper ));
      params( 395 ) := "+"( Integer'Pos( a_househol.short ));
      params( 396 ) := "+"( Integer'Pos( a_househol.sizeft ));
      params( 397 ) := "+"( Integer'Pos( a_househol.sizem ));
      params( 398 ) := "+"( Integer'Pos( a_househol.tvwhy ));
      params( 399 ) := "+"( Integer'Pos( a_househol.yearwhc ));
      params( 400 ) := "+"( Integer'Pos( a_househol.dischha1 ));
      params( 401 ) := "+"( Integer'Pos( a_househol.dischhc1 ));
      params( 402 ) := "+"( Integer'Pos( a_househol.diswhha1 ));
      params( 403 ) := "+"( Integer'Pos( a_househol.diswhhc1 ));
      params( 404 ) := "+"( Integer'Pos( a_househol.gross4 ));
      params( 405 ) := "+"( Integer'Pos( a_househol.lldcare ));
      params( 406 ) := "+"( Integer'Pos( a_househol.urindni ));
      params( 407 ) := "+"( Integer'Pos( a_househol.nhbeninc ));
      params( 408 ) := "+"( Integer'Pos( a_househol.nhhnirbn ));
      params( 409 ) := "+"( Integer'Pos( a_househol.nhhothbn ));
      params( 410 ) := "+"( Float( a_househol.seramt1 ));
      params( 411 ) := "+"( Float( a_househol.seramt2 ));
      params( 412 ) := "+"( Float( a_househol.seramt3 ));
      params( 413 ) := "+"( Float( a_househol.seramt4 ));
      params( 414 ) := "+"( Integer'Pos( a_househol.serpay1 ));
      params( 415 ) := "+"( Integer'Pos( a_househol.serpay2 ));
      params( 416 ) := "+"( Integer'Pos( a_househol.serpay3 ));
      params( 417 ) := "+"( Integer'Pos( a_househol.serpay4 ));
      params( 418 ) := "+"( Integer'Pos( a_househol.serper1 ));
      params( 419 ) := "+"( Integer'Pos( a_househol.serper2 ));
      params( 420 ) := "+"( Integer'Pos( a_househol.serper3 ));
      params( 421 ) := "+"( Integer'Pos( a_househol.serper4 ));
      params( 422 ) := "+"( Integer'Pos( a_househol.utility ));
      params( 423 ) := "+"( Integer'Pos( a_househol.hheth ));
      params( 424 ) := "+"( Float( a_househol.seramt5 ));
      params( 425 ) := "+"( Integer'Pos( a_househol.sercomb ));
      params( 426 ) := "+"( Integer'Pos( a_househol.serpay5 ));
      params( 427 ) := "+"( Integer'Pos( a_househol.serper5 ));
      params( 428 ) := "+"( Integer'Pos( a_househol.urbni ));
      params( 429 ) := "+"( Integer'Pos( a_househol.user_id ));
      params( 430 ) := "+"( Integer'Pos( a_househol.edition ));
      params( 431 ) := "+"( Integer'Pos( a_househol.year ));
      params( 432 ) := As_Bigint( a_househol.sernum );
      
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

   procedure Save( a_househol : Ukds.Frs.Househol; overwrite : Boolean := True; connection : Database_Connection := null ) is   
      params              : gse.SQL_Parameters := Get_Configured_Insert_Params;
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
      if overwrite and Exists( a_househol.user_id, a_househol.edition, a_househol.year, a_househol.sernum ) then
         Update( a_househol, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_househol.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_househol.edition ));
      params( 3 ) := "+"( Integer'Pos( a_househol.year ));
      params( 4 ) := As_Bigint( a_househol.sernum );
      params( 5 ) := "+"( Integer'Pos( a_househol.acorn ));
      params( 6 ) := "+"( Integer'Pos( a_househol.bedroom ));
      params( 7 ) := "+"( Integer'Pos( a_househol.benunits ));
      params( 8 ) := "+"( Integer'Pos( a_househol.billrate ));
      params( 9 ) := "+"( Integer'Pos( a_househol.busroom ));
      params( 10 ) := "+"( Integer'Pos( a_househol.centfuel ));
      params( 11 ) := "+"( Integer'Pos( a_househol.centheat ));
      params( 12 ) := "+"( Integer'Pos( a_househol.charge1 ));
      params( 13 ) := "+"( Integer'Pos( a_househol.charge2 ));
      params( 14 ) := "+"( Integer'Pos( a_househol.charge3 ));
      params( 15 ) := "+"( Integer'Pos( a_househol.charge4 ));
      params( 16 ) := "+"( Integer'Pos( a_househol.charge5 ));
      params( 17 ) := "+"( Integer'Pos( a_househol.charge6 ));
      params( 18 ) := "+"( Integer'Pos( a_househol.charge7 ));
      params( 19 ) := "+"( Integer'Pos( a_househol.charge8 ));
      params( 20 ) := "+"( Integer'Pos( a_househol.charge9 ));
      params( 21 ) := "+"( Integer'Pos( a_househol.chins ));
      params( 22 ) := "+"( Float( a_househol.chrgamt1 ));
      params( 23 ) := "+"( Float( a_househol.chrgamt2 ));
      params( 24 ) := "+"( Float( a_househol.chrgamt3 ));
      params( 25 ) := "+"( Float( a_househol.chrgamt4 ));
      params( 26 ) := "+"( Float( a_househol.chrgamt5 ));
      params( 27 ) := "+"( Float( a_househol.chrgamt6 ));
      params( 28 ) := "+"( Float( a_househol.chrgamt7 ));
      params( 29 ) := "+"( Float( a_househol.chrgamt8 ));
      params( 30 ) := "+"( Float( a_househol.chrgamt9 ));
      params( 31 ) := "+"( Integer'Pos( a_househol.chrgpd1 ));
      params( 32 ) := "+"( Integer'Pos( a_househol.chrgpd2 ));
      params( 33 ) := "+"( Integer'Pos( a_househol.chrgpd3 ));
      params( 34 ) := "+"( Integer'Pos( a_househol.chrgpd4 ));
      params( 35 ) := "+"( Integer'Pos( a_househol.chrgpd5 ));
      params( 36 ) := "+"( Integer'Pos( a_househol.chrgpd6 ));
      params( 37 ) := "+"( Integer'Pos( a_househol.chrgpd7 ));
      params( 38 ) := "+"( Integer'Pos( a_househol.chrgpd8 ));
      params( 39 ) := "+"( Integer'Pos( a_househol.chrgpd9 ));
      params( 40 ) := "+"( Integer'Pos( a_househol.contv1 ));
      params( 41 ) := "+"( Integer'Pos( a_househol.contv2 ));
      params( 42 ) := "+"( Integer'Pos( a_househol.covoths ));
      params( 43 ) := "+"( Float( a_househol.csewamt ));
      params( 44 ) := "+"( Float( a_househol.csewamt1 ));
      params( 45 ) := "+"( Integer'Pos( a_househol.ct25d50d ));
      params( 46 ) := "+"( Integer'Pos( a_househol.ctamt ));
      params( 47 ) := "+"( Float( a_househol.ctannual ));
      params( 48 ) := "+"( Integer'Pos( a_househol.ctband ));
      params( 49 ) := "+"( Integer'Pos( a_househol.ctbwait ));
      params( 50 ) := "+"( Integer'Pos( a_househol.ctcondoc ));
      params( 51 ) := "+"( Integer'Pos( a_househol.ctdisc ));
      params( 52 ) := "+"( Integer'Pos( a_househol.ctinstal ));
      params( 53 ) := "+"( Integer'Pos( a_househol.ctlvband ));
      params( 54 ) := "+"( Integer'Pos( a_househol.ctlvchk ));
      params( 55 ) := "+"( Integer'Pos( a_househol.ctreb ));
      params( 56 ) := "+"( Integer'Pos( a_househol.ctrebamt ));
      params( 57 ) := "+"( Integer'Pos( a_househol.ctrebpd ));
      params( 58 ) := "+"( Integer'Pos( a_househol.cttime ));
      params( 59 ) := "+"( Integer'Pos( a_househol.cwatamt ));
      params( 60 ) := "+"( Integer'Pos( a_househol.cwatamt1 ));
      params( 61 ) := "+"( a_househol.datyrago );
      params( 62 ) := "+"( Integer'Pos( a_househol.entry1 ));
      params( 63 ) := "+"( Integer'Pos( a_househol.entry2 ));
      params( 64 ) := "+"( Integer'Pos( a_househol.entry3 ));
      params( 65 ) := "+"( Integer'Pos( a_househol.entry4 ));
      params( 66 ) := "+"( Float( a_househol.estrtann ));
      params( 67 ) := "+"( Integer'Pos( a_househol.floor ));
      params( 68 ) := "+"( Integer'Pos( a_househol.givehelp ));
      params( 69 ) := "+"( Integer'Pos( a_househol.gor ));
      params( 70 ) := "+"( Integer'Pos( a_househol.gvtregn ));
      params( 71 ) := "+"( Integer'Pos( a_househol.hhldr01 ));
      params( 72 ) := "+"( Integer'Pos( a_househol.hhldr02 ));
      params( 73 ) := "+"( Integer'Pos( a_househol.hhldr03 ));
      params( 74 ) := "+"( Integer'Pos( a_househol.hhldr04 ));
      params( 75 ) := "+"( Integer'Pos( a_househol.hhldr05 ));
      params( 76 ) := "+"( Integer'Pos( a_househol.hhldr06 ));
      params( 77 ) := "+"( Integer'Pos( a_househol.hhldr07 ));
      params( 78 ) := "+"( Integer'Pos( a_househol.hhldr08 ));
      params( 79 ) := "+"( Integer'Pos( a_househol.hhldr09 ));
      params( 80 ) := "+"( Integer'Pos( a_househol.hhldr10 ));
      params( 81 ) := "+"( Integer'Pos( a_househol.hhldr11 ));
      params( 82 ) := "+"( Integer'Pos( a_househol.hhldr12 ));
      params( 83 ) := "+"( Integer'Pos( a_househol.hhldr13 ));
      params( 84 ) := "+"( Integer'Pos( a_househol.hhldr14 ));
      params( 85 ) := "+"( Integer'Pos( a_househol.hhldr97 ));
      params( 86 ) := "+"( Integer'Pos( a_househol.hhstat ));
      params( 87 ) := "+"( Integer'Pos( a_househol.hrpnum ));
      params( 88 ) := "+"( a_househol.intdate );
      params( 89 ) := "+"( Integer'Pos( a_househol.lac ));
      params( 90 ) := "+"( Integer'Pos( a_househol.mainacc ));
      params( 91 ) := "+"( Integer'Pos( a_househol.mnthcode ));
      params( 92 ) := "+"( Integer'Pos( a_househol.modcon01 ));
      params( 93 ) := "+"( Integer'Pos( a_househol.modcon02 ));
      params( 94 ) := "+"( Integer'Pos( a_househol.modcon03 ));
      params( 95 ) := "+"( Integer'Pos( a_househol.modcon04 ));
      params( 96 ) := "+"( Integer'Pos( a_househol.modcon05 ));
      params( 97 ) := "+"( Integer'Pos( a_househol.modcon06 ));
      params( 98 ) := "+"( Integer'Pos( a_househol.modcon07 ));
      params( 99 ) := "+"( Integer'Pos( a_househol.modcon08 ));
      params( 100 ) := "+"( Integer'Pos( a_househol.modcon09 ));
      params( 101 ) := "+"( Integer'Pos( a_househol.modcon10 ));
      params( 102 ) := "+"( Integer'Pos( a_househol.modcon11 ));
      params( 103 ) := "+"( Integer'Pos( a_househol.modcon12 ));
      params( 104 ) := "+"( Integer'Pos( a_househol.modcon13 ));
      params( 105 ) := "+"( Integer'Pos( a_househol.modcon14 ));
      params( 106 ) := "+"( Integer'Pos( a_househol.monlive ));
      params( 107 ) := "+"( Integer'Pos( a_househol.needhelp ));
      params( 108 ) := "+"( Integer'Pos( a_househol.nicoun ));
      params( 109 ) := "+"( Float( a_househol.ninrv ));
      params( 110 ) := "+"( Integer'Pos( a_househol.nirate ));
      params( 111 ) := "+"( Integer'Pos( a_househol.norate ));
      params( 112 ) := "+"( Integer'Pos( a_househol.onbsroom ));
      params( 113 ) := "+"( Float( a_househol.orgsewam ));
      params( 114 ) := "+"( Float( a_househol.orgwatam ));
      params( 115 ) := "+"( Integer'Pos( a_househol.payrate ));
      params( 116 ) := "+"( Integer'Pos( a_househol.premium ));
      params( 117 ) := "+"( Integer'Pos( a_househol.ptbsroom ));
      params( 118 ) := "+"( Integer'Pos( a_househol.rooms ));
      params( 119 ) := "+"( Integer'Pos( a_househol.roomshar ));
      params( 120 ) := "+"( Float( a_househol.rtannual ));
      params( 121 ) := "+"( Float( a_househol.rtcheck ));
      params( 122 ) := "+"( Integer'Pos( a_househol.rtcondoc ));
      params( 123 ) := "+"( Integer'Pos( a_househol.rtdeduc ));
      params( 124 ) := "+"( Integer'Pos( a_househol.rtinstal ));
      params( 125 ) := "+"( Integer'Pos( a_househol.rtreb ));
      params( 126 ) := "+"( Float( a_househol.rtrebamt ));
      params( 127 ) := "+"( Integer'Pos( a_househol.rtrebpd ));
      params( 128 ) := "+"( Integer'Pos( a_househol.rttime ));
      params( 129 ) := "+"( Integer'Pos( a_househol.sampqtr ));
      params( 130 ) := "+"( Integer'Pos( a_househol.schmeal ));
      params( 131 ) := "+"( Integer'Pos( a_househol.schmilk ));
      params( 132 ) := "+"( Float( a_househol.sewamt ));
      params( 133 ) := "+"( Float( a_househol.sewanul ));
      params( 134 ) := "+"( Integer'Pos( a_househol.sewerpay ));
      params( 135 ) := "+"( Integer'Pos( a_househol.sewsep ));
      params( 136 ) := "+"( Integer'Pos( a_househol.sewtime ));
      params( 137 ) := "+"( Integer'Pos( a_househol.shelter ));
      params( 138 ) := "+"( Integer'Pos( a_househol.sobuy ));
      params( 139 ) := "+"( Integer'Pos( a_househol.sstrtreg ));
      params( 140 ) := "+"( Float( a_househol.stramt1 ));
      params( 141 ) := "+"( Float( a_househol.stramt2 ));
      params( 142 ) := "+"( Integer'Pos( a_househol.strcov ));
      params( 143 ) := "+"( Integer'Pos( a_househol.strmort ));
      params( 144 ) := "+"( Integer'Pos( a_househol.stroths ));
      params( 145 ) := "+"( Integer'Pos( a_househol.strpd1 ));
      params( 146 ) := "+"( Integer'Pos( a_househol.strpd2 ));
      params( 147 ) := "+"( Integer'Pos( a_househol.suballow ));
      params( 148 ) := "+"( Integer'Pos( a_househol.sublet ));
      params( 149 ) := "+"( Integer'Pos( a_househol.sublety ));
      params( 150 ) := "+"( Float( a_househol.subrent ));
      params( 151 ) := "+"( Integer'Pos( a_househol.tenure ));
      params( 152 ) := "+"( Integer'Pos( a_househol.totadult ));
      params( 153 ) := "+"( Integer'Pos( a_househol.totchild ));
      params( 154 ) := "+"( Integer'Pos( a_househol.totdepdk ));
      params( 155 ) := "+"( Integer'Pos( a_househol.tvlic ));
      params( 156 ) := "+"( Integer'Pos( a_househol.typeacc ));
      params( 157 ) := "+"( Integer'Pos( a_househol.usevcl ));
      params( 158 ) := "+"( Float( a_househol.watamt ));
      params( 159 ) := "+"( Float( a_househol.watanul ));
      params( 160 ) := "+"( Integer'Pos( a_househol.watermet ));
      params( 161 ) := "+"( Integer'Pos( a_househol.waterpay ));
      params( 162 ) := "+"( Integer'Pos( a_househol.watrb ));
      params( 163 ) := "+"( Integer'Pos( a_househol.wattime ));
      params( 164 ) := "+"( Integer'Pos( a_househol.welfmilk ));
      params( 165 ) := "+"( Integer'Pos( a_househol.whoctb01 ));
      params( 166 ) := "+"( Integer'Pos( a_househol.whoctb02 ));
      params( 167 ) := "+"( Integer'Pos( a_househol.whoctb03 ));
      params( 168 ) := "+"( Integer'Pos( a_househol.whoctb04 ));
      params( 169 ) := "+"( Integer'Pos( a_househol.whoctb05 ));
      params( 170 ) := "+"( Integer'Pos( a_househol.whoctb06 ));
      params( 171 ) := "+"( Integer'Pos( a_househol.whoctb07 ));
      params( 172 ) := "+"( Integer'Pos( a_househol.whoctb08 ));
      params( 173 ) := "+"( Integer'Pos( a_househol.whoctb09 ));
      params( 174 ) := "+"( Integer'Pos( a_househol.whoctb10 ));
      params( 175 ) := "+"( Integer'Pos( a_househol.whoctb11 ));
      params( 176 ) := "+"( Integer'Pos( a_househol.whoctb12 ));
      params( 177 ) := "+"( Integer'Pos( a_househol.whoctb13 ));
      params( 178 ) := "+"( Integer'Pos( a_househol.whoctb14 ));
      params( 179 ) := "+"( Integer'Pos( a_househol.whoctbns ));
      params( 180 ) := "+"( Integer'Pos( a_househol.whoctbot ));
      params( 181 ) := "+"( Integer'Pos( a_househol.whorsp01 ));
      params( 182 ) := "+"( Integer'Pos( a_househol.whorsp02 ));
      params( 183 ) := "+"( Integer'Pos( a_househol.whorsp03 ));
      params( 184 ) := "+"( Integer'Pos( a_househol.whorsp04 ));
      params( 185 ) := "+"( Integer'Pos( a_househol.whorsp05 ));
      params( 186 ) := "+"( Integer'Pos( a_househol.whorsp06 ));
      params( 187 ) := "+"( Integer'Pos( a_househol.whorsp07 ));
      params( 188 ) := "+"( Integer'Pos( a_househol.whorsp08 ));
      params( 189 ) := "+"( Integer'Pos( a_househol.whorsp09 ));
      params( 190 ) := "+"( Integer'Pos( a_househol.whorsp10 ));
      params( 191 ) := "+"( Integer'Pos( a_househol.whorsp11 ));
      params( 192 ) := "+"( Integer'Pos( a_househol.whorsp12 ));
      params( 193 ) := "+"( Integer'Pos( a_househol.whorsp13 ));
      params( 194 ) := "+"( Integer'Pos( a_househol.whorsp14 ));
      params( 195 ) := "+"( Integer'Pos( a_househol.whynoct ));
      params( 196 ) := "+"( Integer'Pos( a_househol.wmintro ));
      params( 197 ) := "+"( Float( a_househol.wsewamt ));
      params( 198 ) := "+"( Float( a_househol.wsewanul ));
      params( 199 ) := "+"( Integer'Pos( a_househol.wsewtime ));
      params( 200 ) := "+"( Integer'Pos( a_househol.yearcode ));
      params( 201 ) := "+"( Integer'Pos( a_househol.yearlive ));
      params( 202 ) := "+"( Integer'Pos( a_househol.month ));
      params( 203 ) := "+"( Integer'Pos( a_househol.actacch ));
      params( 204 ) := "+"( Integer'Pos( a_househol.adddahh ));
      params( 205 ) := "+"( Integer'Pos( a_househol.adulth ));
      params( 206 ) := "+"( Integer'Pos( a_househol.basacth ));
      params( 207 ) := "+"( Integer'Pos( a_househol.chddahh ));
      params( 208 ) := "+"( Integer'Pos( a_househol.curacth ));
      params( 209 ) := "+"( Integer'Pos( a_househol.cwatamtd ));
      params( 210 ) := "+"( Integer'Pos( a_househol.depchldh ));
      params( 211 ) := "+"( Integer'Pos( a_househol.emp ));
      params( 212 ) := "+"( Integer'Pos( a_househol.emphrp ));
      params( 213 ) := "+"( Float( a_househol.endowpay ));
      params( 214 ) := "+"( Float( a_househol.equivahc ));
      params( 215 ) := "+"( Float( a_househol.equivbhc ));
      params( 216 ) := "+"( Integer'Pos( a_househol.fsbndcth ));
      params( 217 ) := "+"( Integer'Pos( a_househol.gbhscost ));
      params( 218 ) := "+"( Integer'Pos( a_househol.gebacth ));
      params( 219 ) := "+"( Integer'Pos( a_househol.giltcth ));
      params( 220 ) := "+"( Integer'Pos( a_househol.gross2 ));
      params( 221 ) := "+"( Integer'Pos( a_househol.gross3 ));
      params( 222 ) := "+"( Integer'Pos( a_househol.grossct ));
      params( 223 ) := "+"( Integer'Pos( a_househol.hbeninc ));
      params( 224 ) := "+"( Integer'Pos( a_househol.hbindhh ));
      params( 225 ) := "+"( Integer'Pos( a_househol.hcband ));
      params( 226 ) := "+"( Integer'Pos( a_househol.hdhhinc ));
      params( 227 ) := "+"( Integer'Pos( a_househol.hdtax ));
      params( 228 ) := "+"( Float( a_househol.hearns ));
      params( 229 ) := "+"( Integer'Pos( a_househol.hhagegr2 ));
      params( 230 ) := "+"( Integer'Pos( a_househol.hhagegrp ));
      params( 231 ) := "+"( Integer'Pos( a_househol.hhcomp ));
      params( 232 ) := "+"( Integer'Pos( a_househol.hhcomps ));
      params( 233 ) := "+"( Integer'Pos( a_househol.hhdisben ));
      params( 234 ) := "+"( Integer'Pos( a_househol.hhethgr2 ));
      params( 235 ) := "+"( Integer'Pos( a_househol.hhethgrp ));
      params( 236 ) := "+"( Integer'Pos( a_househol.hhinc ));
      params( 237 ) := "+"( Integer'Pos( a_househol.hhincbnd ));
      params( 238 ) := "+"( Float( a_househol.hhinv ));
      params( 239 ) := "+"( Integer'Pos( a_househol.hhirben ));
      params( 240 ) := "+"( Integer'Pos( a_househol.hhkids ));
      params( 241 ) := "+"( Integer'Pos( a_househol.hhnirben ));
      params( 242 ) := "+"( Integer'Pos( a_househol.hhothben ));
      params( 243 ) := "+"( Integer'Pos( a_househol.hhrent ));
      params( 244 ) := "+"( Float( a_househol.hhrinc ));
      params( 245 ) := "+"( Float( a_househol.hhrpinc ));
      params( 246 ) := "+"( Integer'Pos( a_househol.hhsize ));
      params( 247 ) := "+"( Float( a_househol.hhtvlic ));
      params( 248 ) := "+"( Float( a_househol.hhtxcred ));
      params( 249 ) := "+"( Float( a_househol.hothinc ));
      params( 250 ) := "+"( Float( a_househol.hpeninc ));
      params( 251 ) := "+"( Integer'Pos( a_househol.hrband ));
      params( 252 ) := "+"( Float( a_househol.hseinc ));
      params( 253 ) := "+"( Integer'Pos( a_househol.isacth ));
      params( 254 ) := "+"( Integer'Pos( a_househol.london ));
      params( 255 ) := "+"( Float( a_househol.mortcost ));
      params( 256 ) := "+"( Float( a_househol.mortint ));
      params( 257 ) := "+"( Float( a_househol.mortpay ));
      params( 258 ) := "+"( Float( a_househol.nddctb ));
      params( 259 ) := "+"( Float( a_househol.nddishc ));
      params( 260 ) := "+"( Integer'Pos( a_househol.nihscost ));
      params( 261 ) := "+"( Integer'Pos( a_househol.nsbocth ));
      params( 262 ) := "+"( Integer'Pos( a_househol.otbscth ));
      params( 263 ) := "+"( Integer'Pos( a_househol.pacctype ));
      params( 264 ) := "+"( Integer'Pos( a_househol.penage ));
      params( 265 ) := "+"( Integer'Pos( a_househol.penhrp ));
      params( 266 ) := "+"( Integer'Pos( a_househol.pepscth ));
      params( 267 ) := "+"( Integer'Pos( a_househol.poaccth ));
      params( 268 ) := "+"( Integer'Pos( a_househol.prbocth ));
      params( 269 ) := "+"( Integer'Pos( a_househol.ptentyp2 ));
      params( 270 ) := "+"( Integer'Pos( a_househol.sayecth ));
      params( 271 ) := "+"( Integer'Pos( a_househol.sclbcth ));
      params( 272 ) := "+"( Float( a_househol.servpay ));
      params( 273 ) := "+"( Integer'Pos( a_househol.sick ));
      params( 274 ) := "+"( Integer'Pos( a_househol.sickhrp ));
      params( 275 ) := "+"( Integer'Pos( a_househol.sscth ));
      params( 276 ) := "+"( Float( a_househol.struins ));
      params( 277 ) := "+"( Integer'Pos( a_househol.stshcth ));
      params( 278 ) := "+"( Integer'Pos( a_househol.tentyp2 ));
      params( 279 ) := "+"( Integer'Pos( a_househol.tesscth ));
      params( 280 ) := "+"( Float( a_househol.tuhhrent ));
      params( 281 ) := "+"( Float( a_househol.tuwatsew ));
      params( 282 ) := "+"( Integer'Pos( a_househol.untrcth ));
      params( 283 ) := "+"( Float( a_househol.watsewrt ));
      params( 284 ) := "+"( Integer'Pos( a_househol.acornew ));
      params( 285 ) := "+"( Integer'Pos( a_househol.crunach ));
      params( 286 ) := "+"( Integer'Pos( a_househol.enomorth ));
      params( 287 ) := "+"( Integer'Pos( a_househol.dvadulth ));
      params( 288 ) := "+"( Integer'Pos( a_househol.dvtotad ));
      params( 289 ) := "+"( Integer'Pos( a_househol.urindew ));
      params( 290 ) := "+"( Integer'Pos( a_househol.urinds ));
      params( 291 ) := "+"( Integer'Pos( a_househol.vehnumb ));
      params( 292 ) := "+"( Integer'Pos( a_househol.country ));
      params( 293 ) := "+"( Integer'Pos( a_househol.hbindhh2 ));
      params( 294 ) := "+"( Integer'Pos( a_househol.pocardh ));
      params( 295 ) := "+"( Integer'Pos( a_househol.entry5 ));
      params( 296 ) := "+"( Integer'Pos( a_househol.entry6 ));
      params( 297 ) := "+"( Integer'Pos( a_househol.imd_e ));
      params( 298 ) := "+"( Integer'Pos( a_househol.imd_s ));
      params( 299 ) := "+"( Integer'Pos( a_househol.imd_w ));
      params( 300 ) := "+"( Integer'Pos( a_househol.numtv1 ));
      params( 301 ) := "+"( Integer'Pos( a_househol.numtv2 ));
      params( 302 ) := "+"( Integer'Pos( a_househol.oac ));
      params( 303 ) := "+"( Integer'Pos( a_househol.bedroom6 ));
      params( 304 ) := "+"( Integer'Pos( a_househol.rooms10 ));
      params( 305 ) := "+"( Integer'Pos( a_househol.brma ));
      params( 306 ) := "+"( Integer'Pos( a_househol.issue ));
      params( 307 ) := "+"( Integer'Pos( a_househol.migrq1 ));
      params( 308 ) := "+"( Integer'Pos( a_househol.migrq2 ));
      params( 309 ) := "+"( Integer'Pos( a_househol.hhagegr3 ));
      params( 310 ) := "+"( Integer'Pos( a_househol.hhagegr4 ));
      params( 311 ) := "+"( Integer'Pos( a_househol.capval ));
      params( 312 ) := "+"( Integer'Pos( a_househol.nidpnd ));
      params( 313 ) := "+"( Integer'Pos( a_househol.nochcr1 ));
      params( 314 ) := "+"( Integer'Pos( a_househol.nochcr2 ));
      params( 315 ) := "+"( Integer'Pos( a_househol.nochcr3 ));
      params( 316 ) := "+"( Integer'Pos( a_househol.nochcr4 ));
      params( 317 ) := "+"( Integer'Pos( a_househol.nochcr5 ));
      params( 318 ) := "+"( Float( a_househol.rt2rebam ));
      params( 319 ) := "+"( Integer'Pos( a_househol.rt2rebpd ));
      params( 320 ) := "+"( Integer'Pos( a_househol.rtdpa ));
      params( 321 ) := "+"( Float( a_househol.rtdpaamt ));
      params( 322 ) := "+"( Integer'Pos( a_househol.rtdpapd ));
      params( 323 ) := "+"( Integer'Pos( a_househol.rtlpa ));
      params( 324 ) := "+"( Float( a_househol.rtlpaamt ));
      params( 325 ) := "+"( Integer'Pos( a_househol.rtlpapd ));
      params( 326 ) := "+"( Float( a_househol.rtothamt ));
      params( 327 ) := "+"( Integer'Pos( a_househol.rtother ));
      params( 328 ) := "+"( Integer'Pos( a_househol.rtothpd ));
      params( 329 ) := "+"( Integer'Pos( a_househol.rtrtr ));
      params( 330 ) := "+"( Float( a_househol.rtrtramt ));
      params( 331 ) := "+"( Integer'Pos( a_househol.rtrtrpd ));
      params( 332 ) := "+"( Integer'Pos( a_househol.rttimepd ));
      params( 333 ) := "+"( Integer'Pos( a_househol.yrlvchk ));
      params( 334 ) := "+"( Integer'Pos( a_househol.gross3_x ));
      params( 335 ) := "+"( Integer'Pos( a_househol.hlthst ));
      params( 336 ) := "+"( Integer'Pos( a_househol.medpay ));
      params( 337 ) := "+"( Integer'Pos( a_househol.medwho01 ));
      params( 338 ) := "+"( Integer'Pos( a_househol.medwho02 ));
      params( 339 ) := "+"( Integer'Pos( a_househol.medwho03 ));
      params( 340 ) := "+"( Integer'Pos( a_househol.medwho04 ));
      params( 341 ) := "+"( Integer'Pos( a_househol.medwho05 ));
      params( 342 ) := "+"( Integer'Pos( a_househol.medwho06 ));
      params( 343 ) := "+"( Integer'Pos( a_househol.medwho07 ));
      params( 344 ) := "+"( Integer'Pos( a_househol.medwho08 ));
      params( 345 ) := "+"( Integer'Pos( a_househol.medwho09 ));
      params( 346 ) := "+"( Integer'Pos( a_househol.medwho10 ));
      params( 347 ) := "+"( Integer'Pos( a_househol.medwho11 ));
      params( 348 ) := "+"( Integer'Pos( a_househol.medwho12 ));
      params( 349 ) := "+"( Integer'Pos( a_househol.medwho13 ));
      params( 350 ) := "+"( Integer'Pos( a_househol.medwho14 ));
      params( 351 ) := "+"( Integer'Pos( a_househol.nmrmshar ));
      params( 352 ) := "+"( Integer'Pos( a_househol.roomshr ));
      params( 353 ) := "+"( Integer'Pos( a_househol.imd_ni ));
      params( 354 ) := "+"( Integer'Pos( a_househol.multi ));
      params( 355 ) := "+"( Integer'Pos( a_househol.nopay ));
      params( 356 ) := "+"( Integer'Pos( a_househol.orgid ));
      params( 357 ) := "+"( Integer'Pos( a_househol.rtene ));
      params( 358 ) := "+"( Integer'Pos( a_househol.rteneamt ));
      params( 359 ) := "+"( Integer'Pos( a_househol.rtgen ));
      params( 360 ) := "+"( Integer'Pos( a_househol.schbrk ));
      params( 361 ) := "+"( Integer'Pos( a_househol.urb ));
      params( 362 ) := "+"( Integer'Pos( a_househol.urbrur ));
      params( 363 ) := "+"( Integer'Pos( a_househol.hhethgr3 ));
      params( 364 ) := "+"( Float( a_househol.niratlia ));
      params( 365 ) := "+"( Integer'Pos( a_househol.bankse ));
      params( 366 ) := "+"( Integer'Pos( a_househol.bathshow ));
      params( 367 ) := "+"( Integer'Pos( a_househol.burden ));
      params( 368 ) := "+"( Integer'Pos( a_househol.comco ));
      params( 369 ) := "+"( Integer'Pos( a_househol.comp1sc ));
      params( 370 ) := "+"( Integer'Pos( a_househol.compsc ));
      params( 371 ) := "+"( Integer'Pos( a_househol.comwa ));
      params( 372 ) := "+"( Integer'Pos( a_househol.dwellno ));
      params( 373 ) := "+"( Integer'Pos( a_househol.elecin ));
      params( 374 ) := "+"( Integer'Pos( a_househol.elecinw ));
      params( 375 ) := "+"( Float( a_househol.eulowest ));
      params( 376 ) := "+"( Integer'Pos( a_househol.flshtoil ));
      params( 377 ) := "+"( Integer'Pos( a_househol.grocse ));
      params( 378 ) := "+"( Integer'Pos( a_househol.gvtregno ));
      params( 379 ) := "+"( Integer'Pos( a_househol.heat ));
      params( 380 ) := "+"( Integer'Pos( a_househol.heatcen ));
      params( 381 ) := "+"( Integer'Pos( a_househol.heatfire ));
      params( 382 ) := "+"( Integer'Pos( a_househol.kitchen ));
      params( 383 ) := "+"( Integer'Pos( a_househol.knsizeft ));
      params( 384 ) := "+"( Integer'Pos( a_househol.knsizem ));
      params( 385 ) := "+"( Integer'Pos( a_househol.laua ));
      params( 386 ) := "+"( Integer'Pos( a_househol.movef ));
      params( 387 ) := "+"( Integer'Pos( a_househol.movenxt ));
      params( 388 ) := "+"( Integer'Pos( a_househol.movereas ));
      params( 389 ) := "+"( Integer'Pos( a_househol.ovsat ));
      params( 390 ) := "+"( Integer'Pos( a_househol.plum1bin ));
      params( 391 ) := "+"( Integer'Pos( a_househol.plumin ));
      params( 392 ) := "+"( Integer'Pos( a_househol.pluminw ));
      params( 393 ) := "+"( Integer'Pos( a_househol.postse ));
      params( 394 ) := "+"( Integer'Pos( a_househol.primh ));
      params( 395 ) := "+"( Integer'Pos( a_househol.pubtr ));
      params( 396 ) := "+"( Integer'Pos( a_househol.samesc ));
      params( 397 ) := "+"( Integer'Pos( a_househol.schfrt ));
      params( 398 ) := "+"( Integer'Pos( a_househol.selper ));
      params( 399 ) := "+"( Integer'Pos( a_househol.short ));
      params( 400 ) := "+"( Integer'Pos( a_househol.sizeft ));
      params( 401 ) := "+"( Integer'Pos( a_househol.sizem ));
      params( 402 ) := "+"( Integer'Pos( a_househol.tvwhy ));
      params( 403 ) := "+"( Integer'Pos( a_househol.yearwhc ));
      params( 404 ) := "+"( Integer'Pos( a_househol.dischha1 ));
      params( 405 ) := "+"( Integer'Pos( a_househol.dischhc1 ));
      params( 406 ) := "+"( Integer'Pos( a_househol.diswhha1 ));
      params( 407 ) := "+"( Integer'Pos( a_househol.diswhhc1 ));
      params( 408 ) := "+"( Integer'Pos( a_househol.gross4 ));
      params( 409 ) := "+"( Integer'Pos( a_househol.lldcare ));
      params( 410 ) := "+"( Integer'Pos( a_househol.urindni ));
      params( 411 ) := "+"( Integer'Pos( a_househol.nhbeninc ));
      params( 412 ) := "+"( Integer'Pos( a_househol.nhhnirbn ));
      params( 413 ) := "+"( Integer'Pos( a_househol.nhhothbn ));
      params( 414 ) := "+"( Float( a_househol.seramt1 ));
      params( 415 ) := "+"( Float( a_househol.seramt2 ));
      params( 416 ) := "+"( Float( a_househol.seramt3 ));
      params( 417 ) := "+"( Float( a_househol.seramt4 ));
      params( 418 ) := "+"( Integer'Pos( a_househol.serpay1 ));
      params( 419 ) := "+"( Integer'Pos( a_househol.serpay2 ));
      params( 420 ) := "+"( Integer'Pos( a_househol.serpay3 ));
      params( 421 ) := "+"( Integer'Pos( a_househol.serpay4 ));
      params( 422 ) := "+"( Integer'Pos( a_househol.serper1 ));
      params( 423 ) := "+"( Integer'Pos( a_househol.serper2 ));
      params( 424 ) := "+"( Integer'Pos( a_househol.serper3 ));
      params( 425 ) := "+"( Integer'Pos( a_househol.serper4 ));
      params( 426 ) := "+"( Integer'Pos( a_househol.utility ));
      params( 427 ) := "+"( Integer'Pos( a_househol.hheth ));
      params( 428 ) := "+"( Float( a_househol.seramt5 ));
      params( 429 ) := "+"( Integer'Pos( a_househol.sercomb ));
      params( 430 ) := "+"( Integer'Pos( a_househol.serpay5 ));
      params( 431 ) := "+"( Integer'Pos( a_househol.serper5 ));
      params( 432 ) := "+"( Integer'Pos( a_househol.urbni ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Househol
   --

   procedure Delete( a_househol : in out Ukds.Frs.Househol; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_househol.user_id );
      Add_edition( c, a_househol.edition );
      Add_year( c, a_househol.year );
      Add_sernum( c, a_househol.sernum );
      Delete( c, connection );
      a_househol := Ukds.Frs.Null_Househol;
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
   function Retrieve_Associated_Ukds_Frs_Govpays( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Govpay_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Govpay_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Govpay_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Govpay_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Govpay_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Govpay_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Govpays;


   function Retrieve_Associated_Ukds_Frs_Maints( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Maint_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Maint_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Maint_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Maint_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Maint_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Maint_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Maints;


   function Retrieve_Associated_Ukds_Frs_Owners( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Owner_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Owner_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Owner_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Owner_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Owner_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Owner_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Owners;


   function Retrieve_Associated_Ukds_Frs_Accounts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Accounts_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Accounts_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Accounts_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Accounts_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Accounts_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Accounts_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Accounts;


   function Retrieve_Associated_Ukds_Frs_Nimigras( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Nimigra_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Nimigra_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Nimigra_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Nimigra_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Nimigra_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Nimigra_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Nimigras;


   function Retrieve_Associated_Ukds_Frs_Pianon1516s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianon1516_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Pianon1516_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Pianon1516_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Pianon1516_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Pianon1516_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Pianon1516_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Pianon1516s;


   function Retrieve_Associated_Ukds_Frs_Pianon1415s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianon1415_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Pianon1415_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Pianon1415_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Pianon1415_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Pianon1415_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Pianon1415_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Pianon1415s;


   function Retrieve_Associated_Ukds_Frs_Rentconts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Rentcont_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Rentcont_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Rentcont_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Rentcont_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Rentcont_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Rentcont_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Rentconts;


   function Retrieve_Associated_Ukds_Frs_Mortgages( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Mortgage_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Mortgage_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Mortgage_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Mortgage_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Mortgage_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Mortgage_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Mortgages;


   function Retrieve_Associated_Ukds_Frs_Transacts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Transact_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Transact_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Transact_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Transact_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Transact_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Transact_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Transacts;


   function Retrieve_Associated_Ukds_Frs_Nimigrs( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Nimigr_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Nimigr_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Nimigr_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Nimigr_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Nimigr_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Nimigr_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Nimigrs;


   function Retrieve_Associated_Ukds_Frs_Pianon1314s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianon1314_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Pianon1314_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Pianon1314_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Pianon1314_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Pianon1314_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Pianon1314_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Pianon1314s;


   function Retrieve_Associated_Ukds_Frs_Prscrptns( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Prscrptn_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Prscrptn_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Prscrptn_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Prscrptn_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Prscrptn_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Prscrptn_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Prscrptns;


   function Retrieve_Associated_Ukds_Frs_Insurancs( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Insuranc_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Insuranc_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Insuranc_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Insuranc_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Insuranc_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Insuranc_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Insurancs;


   function Retrieve_Child_Ukds_Frs_Renter( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null) return Ukds.Frs.Renter is
   begin
      return Ukds.Frs.Renter_IO.retrieve_By_PK( 
         Year => a_househol.Year,
         User_id => a_househol.User_Id,
         Edition => a_househol.Edition,
         Sernum => a_househol.Sernum,
         Connection => connection );
   end Retrieve_Child_Ukds_Frs_Renter;


   function Retrieve_Associated_Ukds_Frs_Vehicles( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Vehicle_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Vehicle_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Vehicle_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Vehicle_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Vehicle_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Vehicle_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Vehicles;


   function Retrieve_Associated_Ukds_Frs_Oddjobs( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Oddjob_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Oddjob_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Oddjob_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Oddjob_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Oddjob_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Oddjob_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Oddjobs;


   function Retrieve_Associated_Ukds_Frs_Penamts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Penamt_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Penamt_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Penamt_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Penamt_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Penamt_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Penamt_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Penamts;


   function Retrieve_Associated_Ukds_Frs_Chldcares( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Chldcare_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Chldcare_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Chldcare_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Chldcare_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Chldcare_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Chldcare_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Chldcares;


   function Retrieve_Associated_Ukds_Frs_Endowmnts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Endowmnt_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Endowmnt_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Endowmnt_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Endowmnt_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Endowmnt_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Endowmnt_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Endowmnts;


   function Retrieve_Associated_Ukds_Frs_Penprovs( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Penprov_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Penprov_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Penprov_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Penprov_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Penprov_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Penprov_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Penprovs;


   function Retrieve_Associated_Ukds_Frs_Jobs( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Job_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Job_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Job_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Job_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Job_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Job_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Jobs;


   function Retrieve_Associated_Ukds_Frs_Pianon1213s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianon1213_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Pianon1213_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Pianon1213_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Pianon1213_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Pianon1213_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Pianon1213_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Pianon1213s;


   function Retrieve_Associated_Ukds_Frs_Adults( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Adult_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Adult_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Adult_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Adult_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Adult_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Adult_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Adults;


   function Retrieve_Associated_Ukds_Frs_Childs( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Child_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Child_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Child_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Child_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Child_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Child_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Childs;


   function Retrieve_Associated_Ukds_Frs_Benunits( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Benunit_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Benunit_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Benunit_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Benunit_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Benunit_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Benunit_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Benunits;


   function Retrieve_Associated_Ukds_Frs_Cares( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Care_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Care_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Care_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Care_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Care_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Care_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Cares;


   function Retrieve_Associated_Ukds_Frs_Pianon1011s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianon1011_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Pianon1011_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Pianon1011_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Pianon1011_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Pianon1011_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Pianon1011_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Pianon1011s;


   function Retrieve_Associated_Ukds_Frs_Extchilds( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Extchild_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Extchild_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Extchild_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Extchild_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Extchild_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Extchild_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Extchilds;


   function Retrieve_Associated_Ukds_Frs_Benefits( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Benefits_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Benefits_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Benefits_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Benefits_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Benefits_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Benefits_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Benefits;


   function Retrieve_Associated_Ukds_Frs_Assets( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Assets_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Assets_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Assets_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Assets_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Assets_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Assets_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Assets;


   function Retrieve_Child_Ukds_Frs_Admin( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null) return Ukds.Frs.Admin is
   begin
      return Ukds.Frs.Admin_IO.retrieve_By_PK( 
         Year => a_househol.Year,
         User_id => a_househol.User_Id,
         Edition => a_househol.Edition,
         Sernum => a_househol.Sernum,
         Connection => connection );
   end Retrieve_Child_Ukds_Frs_Admin;


   function Retrieve_Associated_Ukds_Frs_Accouts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Accouts_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Accouts_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Accouts_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Accouts_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Accouts_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Accouts_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Accouts;


   function Retrieve_Associated_Ukds_Frs_Mortconts( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Mortcont_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Mortcont_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Mortcont_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Mortcont_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Mortcont_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Mortcont_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Mortconts;


   function Retrieve_Associated_Ukds_Frs_Pensions( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pension_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Pension_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Pension_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Pension_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Pension_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Pension_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Pensions;


   function Retrieve_Associated_Ukds_Frs_Childcares( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Childcare_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Childcare_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Childcare_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Childcare_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Childcare_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Childcare_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Childcares;


   function Retrieve_Associated_Ukds_Frs_Pianom0809s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianom0809_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Pianom0809_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Pianom0809_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Pianom0809_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Pianom0809_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Pianom0809_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Pianom0809s;


   function Retrieve_Associated_Ukds_Frs_Pianon0910s( a_househol : Ukds.Frs.Househol; connection : Database_Connection := null ) return Ukds.Frs.Pianon0910_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Pianon0910_IO.Add_Year( c, a_househol.Year );
      Ukds.Frs.Pianon0910_IO.Add_User_Id( c, a_househol.User_Id );
      Ukds.Frs.Pianon0910_IO.Add_Edition( c, a_househol.Edition );
      Ukds.Frs.Pianon0910_IO.Add_Sernum( c, a_househol.Sernum );
      return Ukds.Frs.Pianon0910_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Pianon0910s;



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


   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sernum", op, join, Big_Int( sernum ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum;


   procedure Add_acorn( c : in out d.Criteria; acorn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "acorn", op, join, acorn );
   begin
      d.add_to_criteria( c, elem );
   end Add_acorn;


   procedure Add_bedroom( c : in out d.Criteria; bedroom : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bedroom", op, join, bedroom );
   begin
      d.add_to_criteria( c, elem );
   end Add_bedroom;


   procedure Add_benunits( c : in out d.Criteria; benunits : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "benunits", op, join, benunits );
   begin
      d.add_to_criteria( c, elem );
   end Add_benunits;


   procedure Add_billrate( c : in out d.Criteria; billrate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "billrate", op, join, billrate );
   begin
      d.add_to_criteria( c, elem );
   end Add_billrate;


   procedure Add_busroom( c : in out d.Criteria; busroom : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "busroom", op, join, busroom );
   begin
      d.add_to_criteria( c, elem );
   end Add_busroom;


   procedure Add_centfuel( c : in out d.Criteria; centfuel : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "centfuel", op, join, centfuel );
   begin
      d.add_to_criteria( c, elem );
   end Add_centfuel;


   procedure Add_centheat( c : in out d.Criteria; centheat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "centheat", op, join, centheat );
   begin
      d.add_to_criteria( c, elem );
   end Add_centheat;


   procedure Add_charge1( c : in out d.Criteria; charge1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "charge1", op, join, charge1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge1;


   procedure Add_charge2( c : in out d.Criteria; charge2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "charge2", op, join, charge2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge2;


   procedure Add_charge3( c : in out d.Criteria; charge3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "charge3", op, join, charge3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge3;


   procedure Add_charge4( c : in out d.Criteria; charge4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "charge4", op, join, charge4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge4;


   procedure Add_charge5( c : in out d.Criteria; charge5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "charge5", op, join, charge5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge5;


   procedure Add_charge6( c : in out d.Criteria; charge6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "charge6", op, join, charge6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge6;


   procedure Add_charge7( c : in out d.Criteria; charge7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "charge7", op, join, charge7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge7;


   procedure Add_charge8( c : in out d.Criteria; charge8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "charge8", op, join, charge8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge8;


   procedure Add_charge9( c : in out d.Criteria; charge9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "charge9", op, join, charge9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge9;


   procedure Add_chins( c : in out d.Criteria; chins : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chins", op, join, chins );
   begin
      d.add_to_criteria( c, elem );
   end Add_chins;


   procedure Add_chrgamt1( c : in out d.Criteria; chrgamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgamt1", op, join, Long_Float( chrgamt1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt1;


   procedure Add_chrgamt2( c : in out d.Criteria; chrgamt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgamt2", op, join, Long_Float( chrgamt2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt2;


   procedure Add_chrgamt3( c : in out d.Criteria; chrgamt3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgamt3", op, join, Long_Float( chrgamt3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt3;


   procedure Add_chrgamt4( c : in out d.Criteria; chrgamt4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgamt4", op, join, Long_Float( chrgamt4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt4;


   procedure Add_chrgamt5( c : in out d.Criteria; chrgamt5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgamt5", op, join, Long_Float( chrgamt5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt5;


   procedure Add_chrgamt6( c : in out d.Criteria; chrgamt6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgamt6", op, join, Long_Float( chrgamt6 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt6;


   procedure Add_chrgamt7( c : in out d.Criteria; chrgamt7 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgamt7", op, join, Long_Float( chrgamt7 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt7;


   procedure Add_chrgamt8( c : in out d.Criteria; chrgamt8 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgamt8", op, join, Long_Float( chrgamt8 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt8;


   procedure Add_chrgamt9( c : in out d.Criteria; chrgamt9 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgamt9", op, join, Long_Float( chrgamt9 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt9;


   procedure Add_chrgpd1( c : in out d.Criteria; chrgpd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgpd1", op, join, chrgpd1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd1;


   procedure Add_chrgpd2( c : in out d.Criteria; chrgpd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgpd2", op, join, chrgpd2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd2;


   procedure Add_chrgpd3( c : in out d.Criteria; chrgpd3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgpd3", op, join, chrgpd3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd3;


   procedure Add_chrgpd4( c : in out d.Criteria; chrgpd4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgpd4", op, join, chrgpd4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd4;


   procedure Add_chrgpd5( c : in out d.Criteria; chrgpd5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgpd5", op, join, chrgpd5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd5;


   procedure Add_chrgpd6( c : in out d.Criteria; chrgpd6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgpd6", op, join, chrgpd6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd6;


   procedure Add_chrgpd7( c : in out d.Criteria; chrgpd7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgpd7", op, join, chrgpd7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd7;


   procedure Add_chrgpd8( c : in out d.Criteria; chrgpd8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgpd8", op, join, chrgpd8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd8;


   procedure Add_chrgpd9( c : in out d.Criteria; chrgpd9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrgpd9", op, join, chrgpd9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd9;


   procedure Add_contv1( c : in out d.Criteria; contv1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "contv1", op, join, contv1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_contv1;


   procedure Add_contv2( c : in out d.Criteria; contv2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "contv2", op, join, contv2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_contv2;


   procedure Add_covoths( c : in out d.Criteria; covoths : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "covoths", op, join, covoths );
   begin
      d.add_to_criteria( c, elem );
   end Add_covoths;


   procedure Add_csewamt( c : in out d.Criteria; csewamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "csewamt", op, join, Long_Float( csewamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_csewamt;


   procedure Add_csewamt1( c : in out d.Criteria; csewamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "csewamt1", op, join, Long_Float( csewamt1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_csewamt1;


   procedure Add_ct25d50d( c : in out d.Criteria; ct25d50d : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ct25d50d", op, join, ct25d50d );
   begin
      d.add_to_criteria( c, elem );
   end Add_ct25d50d;


   procedure Add_ctamt( c : in out d.Criteria; ctamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctamt", op, join, ctamt );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctamt;


   procedure Add_ctannual( c : in out d.Criteria; ctannual : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctannual", op, join, Long_Float( ctannual ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctannual;


   procedure Add_ctband( c : in out d.Criteria; ctband : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctband", op, join, ctband );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctband;


   procedure Add_ctbwait( c : in out d.Criteria; ctbwait : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctbwait", op, join, ctbwait );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctbwait;


   procedure Add_ctcondoc( c : in out d.Criteria; ctcondoc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctcondoc", op, join, ctcondoc );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctcondoc;


   procedure Add_ctdisc( c : in out d.Criteria; ctdisc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctdisc", op, join, ctdisc );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctdisc;


   procedure Add_ctinstal( c : in out d.Criteria; ctinstal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctinstal", op, join, ctinstal );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctinstal;


   procedure Add_ctlvband( c : in out d.Criteria; ctlvband : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctlvband", op, join, ctlvband );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctlvband;


   procedure Add_ctlvchk( c : in out d.Criteria; ctlvchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctlvchk", op, join, ctlvchk );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctlvchk;


   procedure Add_ctreb( c : in out d.Criteria; ctreb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctreb", op, join, ctreb );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctreb;


   procedure Add_ctrebamt( c : in out d.Criteria; ctrebamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctrebamt", op, join, ctrebamt );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctrebamt;


   procedure Add_ctrebpd( c : in out d.Criteria; ctrebpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctrebpd", op, join, ctrebpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctrebpd;


   procedure Add_cttime( c : in out d.Criteria; cttime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cttime", op, join, cttime );
   begin
      d.add_to_criteria( c, elem );
   end Add_cttime;


   procedure Add_cwatamt( c : in out d.Criteria; cwatamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cwatamt", op, join, cwatamt );
   begin
      d.add_to_criteria( c, elem );
   end Add_cwatamt;


   procedure Add_cwatamt1( c : in out d.Criteria; cwatamt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cwatamt1", op, join, cwatamt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cwatamt1;


   procedure Add_datyrago( c : in out d.Criteria; datyrago : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "datyrago", op, join, Ada.Calendar.Time( datyrago ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_datyrago;


   procedure Add_entry1( c : in out d.Criteria; entry1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "entry1", op, join, entry1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_entry1;


   procedure Add_entry2( c : in out d.Criteria; entry2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "entry2", op, join, entry2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_entry2;


   procedure Add_entry3( c : in out d.Criteria; entry3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "entry3", op, join, entry3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_entry3;


   procedure Add_entry4( c : in out d.Criteria; entry4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "entry4", op, join, entry4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_entry4;


   procedure Add_estrtann( c : in out d.Criteria; estrtann : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "estrtann", op, join, Long_Float( estrtann ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_estrtann;


   procedure Add_floor( c : in out d.Criteria; floor : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "floor", op, join, floor );
   begin
      d.add_to_criteria( c, elem );
   end Add_floor;


   procedure Add_givehelp( c : in out d.Criteria; givehelp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "givehelp", op, join, givehelp );
   begin
      d.add_to_criteria( c, elem );
   end Add_givehelp;


   procedure Add_gor( c : in out d.Criteria; gor : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gor", op, join, gor );
   begin
      d.add_to_criteria( c, elem );
   end Add_gor;


   procedure Add_gvtregn( c : in out d.Criteria; gvtregn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gvtregn", op, join, gvtregn );
   begin
      d.add_to_criteria( c, elem );
   end Add_gvtregn;


   procedure Add_hhldr01( c : in out d.Criteria; hhldr01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr01", op, join, hhldr01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr01;


   procedure Add_hhldr02( c : in out d.Criteria; hhldr02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr02", op, join, hhldr02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr02;


   procedure Add_hhldr03( c : in out d.Criteria; hhldr03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr03", op, join, hhldr03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr03;


   procedure Add_hhldr04( c : in out d.Criteria; hhldr04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr04", op, join, hhldr04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr04;


   procedure Add_hhldr05( c : in out d.Criteria; hhldr05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr05", op, join, hhldr05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr05;


   procedure Add_hhldr06( c : in out d.Criteria; hhldr06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr06", op, join, hhldr06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr06;


   procedure Add_hhldr07( c : in out d.Criteria; hhldr07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr07", op, join, hhldr07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr07;


   procedure Add_hhldr08( c : in out d.Criteria; hhldr08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr08", op, join, hhldr08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr08;


   procedure Add_hhldr09( c : in out d.Criteria; hhldr09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr09", op, join, hhldr09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr09;


   procedure Add_hhldr10( c : in out d.Criteria; hhldr10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr10", op, join, hhldr10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr10;


   procedure Add_hhldr11( c : in out d.Criteria; hhldr11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr11", op, join, hhldr11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr11;


   procedure Add_hhldr12( c : in out d.Criteria; hhldr12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr12", op, join, hhldr12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr12;


   procedure Add_hhldr13( c : in out d.Criteria; hhldr13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr13", op, join, hhldr13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr13;


   procedure Add_hhldr14( c : in out d.Criteria; hhldr14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr14", op, join, hhldr14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr14;


   procedure Add_hhldr97( c : in out d.Criteria; hhldr97 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhldr97", op, join, hhldr97 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr97;


   procedure Add_hhstat( c : in out d.Criteria; hhstat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhstat", op, join, hhstat );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhstat;


   procedure Add_hrpnum( c : in out d.Criteria; hrpnum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrpnum", op, join, hrpnum );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrpnum;


   procedure Add_intdate( c : in out d.Criteria; intdate : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intdate", op, join, Ada.Calendar.Time( intdate ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_intdate;


   procedure Add_lac( c : in out d.Criteria; lac : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lac", op, join, lac );
   begin
      d.add_to_criteria( c, elem );
   end Add_lac;


   procedure Add_mainacc( c : in out d.Criteria; mainacc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mainacc", op, join, mainacc );
   begin
      d.add_to_criteria( c, elem );
   end Add_mainacc;


   procedure Add_mnthcode( c : in out d.Criteria; mnthcode : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mnthcode", op, join, mnthcode );
   begin
      d.add_to_criteria( c, elem );
   end Add_mnthcode;


   procedure Add_modcon01( c : in out d.Criteria; modcon01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon01", op, join, modcon01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon01;


   procedure Add_modcon02( c : in out d.Criteria; modcon02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon02", op, join, modcon02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon02;


   procedure Add_modcon03( c : in out d.Criteria; modcon03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon03", op, join, modcon03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon03;


   procedure Add_modcon04( c : in out d.Criteria; modcon04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon04", op, join, modcon04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon04;


   procedure Add_modcon05( c : in out d.Criteria; modcon05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon05", op, join, modcon05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon05;


   procedure Add_modcon06( c : in out d.Criteria; modcon06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon06", op, join, modcon06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon06;


   procedure Add_modcon07( c : in out d.Criteria; modcon07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon07", op, join, modcon07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon07;


   procedure Add_modcon08( c : in out d.Criteria; modcon08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon08", op, join, modcon08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon08;


   procedure Add_modcon09( c : in out d.Criteria; modcon09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon09", op, join, modcon09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon09;


   procedure Add_modcon10( c : in out d.Criteria; modcon10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon10", op, join, modcon10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon10;


   procedure Add_modcon11( c : in out d.Criteria; modcon11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon11", op, join, modcon11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon11;


   procedure Add_modcon12( c : in out d.Criteria; modcon12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon12", op, join, modcon12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon12;


   procedure Add_modcon13( c : in out d.Criteria; modcon13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon13", op, join, modcon13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon13;


   procedure Add_modcon14( c : in out d.Criteria; modcon14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "modcon14", op, join, modcon14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon14;


   procedure Add_monlive( c : in out d.Criteria; monlive : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "monlive", op, join, monlive );
   begin
      d.add_to_criteria( c, elem );
   end Add_monlive;


   procedure Add_needhelp( c : in out d.Criteria; needhelp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "needhelp", op, join, needhelp );
   begin
      d.add_to_criteria( c, elem );
   end Add_needhelp;


   procedure Add_nicoun( c : in out d.Criteria; nicoun : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nicoun", op, join, nicoun );
   begin
      d.add_to_criteria( c, elem );
   end Add_nicoun;


   procedure Add_ninrv( c : in out d.Criteria; ninrv : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninrv", op, join, Long_Float( ninrv ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninrv;


   procedure Add_nirate( c : in out d.Criteria; nirate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nirate", op, join, nirate );
   begin
      d.add_to_criteria( c, elem );
   end Add_nirate;


   procedure Add_norate( c : in out d.Criteria; norate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "norate", op, join, norate );
   begin
      d.add_to_criteria( c, elem );
   end Add_norate;


   procedure Add_onbsroom( c : in out d.Criteria; onbsroom : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "onbsroom", op, join, onbsroom );
   begin
      d.add_to_criteria( c, elem );
   end Add_onbsroom;


   procedure Add_orgsewam( c : in out d.Criteria; orgsewam : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "orgsewam", op, join, Long_Float( orgsewam ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_orgsewam;


   procedure Add_orgwatam( c : in out d.Criteria; orgwatam : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "orgwatam", op, join, Long_Float( orgwatam ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_orgwatam;


   procedure Add_payrate( c : in out d.Criteria; payrate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "payrate", op, join, payrate );
   begin
      d.add_to_criteria( c, elem );
   end Add_payrate;


   procedure Add_premium( c : in out d.Criteria; premium : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "premium", op, join, premium );
   begin
      d.add_to_criteria( c, elem );
   end Add_premium;


   procedure Add_ptbsroom( c : in out d.Criteria; ptbsroom : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ptbsroom", op, join, ptbsroom );
   begin
      d.add_to_criteria( c, elem );
   end Add_ptbsroom;


   procedure Add_rooms( c : in out d.Criteria; rooms : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rooms", op, join, rooms );
   begin
      d.add_to_criteria( c, elem );
   end Add_rooms;


   procedure Add_roomshar( c : in out d.Criteria; roomshar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "roomshar", op, join, roomshar );
   begin
      d.add_to_criteria( c, elem );
   end Add_roomshar;


   procedure Add_rtannual( c : in out d.Criteria; rtannual : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtannual", op, join, Long_Float( rtannual ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtannual;


   procedure Add_rtcheck( c : in out d.Criteria; rtcheck : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtcheck", op, join, Long_Float( rtcheck ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtcheck;


   procedure Add_rtcondoc( c : in out d.Criteria; rtcondoc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtcondoc", op, join, rtcondoc );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtcondoc;


   procedure Add_rtdeduc( c : in out d.Criteria; rtdeduc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtdeduc", op, join, rtdeduc );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtdeduc;


   procedure Add_rtinstal( c : in out d.Criteria; rtinstal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtinstal", op, join, rtinstal );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtinstal;


   procedure Add_rtreb( c : in out d.Criteria; rtreb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtreb", op, join, rtreb );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtreb;


   procedure Add_rtrebamt( c : in out d.Criteria; rtrebamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtrebamt", op, join, Long_Float( rtrebamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtrebamt;


   procedure Add_rtrebpd( c : in out d.Criteria; rtrebpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtrebpd", op, join, rtrebpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtrebpd;


   procedure Add_rttime( c : in out d.Criteria; rttime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rttime", op, join, rttime );
   begin
      d.add_to_criteria( c, elem );
   end Add_rttime;


   procedure Add_sampqtr( c : in out d.Criteria; sampqtr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sampqtr", op, join, sampqtr );
   begin
      d.add_to_criteria( c, elem );
   end Add_sampqtr;


   procedure Add_schmeal( c : in out d.Criteria; schmeal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "schmeal", op, join, schmeal );
   begin
      d.add_to_criteria( c, elem );
   end Add_schmeal;


   procedure Add_schmilk( c : in out d.Criteria; schmilk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "schmilk", op, join, schmilk );
   begin
      d.add_to_criteria( c, elem );
   end Add_schmilk;


   procedure Add_sewamt( c : in out d.Criteria; sewamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sewamt", op, join, Long_Float( sewamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sewamt;


   procedure Add_sewanul( c : in out d.Criteria; sewanul : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sewanul", op, join, Long_Float( sewanul ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sewanul;


   procedure Add_sewerpay( c : in out d.Criteria; sewerpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sewerpay", op, join, sewerpay );
   begin
      d.add_to_criteria( c, elem );
   end Add_sewerpay;


   procedure Add_sewsep( c : in out d.Criteria; sewsep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sewsep", op, join, sewsep );
   begin
      d.add_to_criteria( c, elem );
   end Add_sewsep;


   procedure Add_sewtime( c : in out d.Criteria; sewtime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sewtime", op, join, sewtime );
   begin
      d.add_to_criteria( c, elem );
   end Add_sewtime;


   procedure Add_shelter( c : in out d.Criteria; shelter : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "shelter", op, join, shelter );
   begin
      d.add_to_criteria( c, elem );
   end Add_shelter;


   procedure Add_sobuy( c : in out d.Criteria; sobuy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sobuy", op, join, sobuy );
   begin
      d.add_to_criteria( c, elem );
   end Add_sobuy;


   procedure Add_sstrtreg( c : in out d.Criteria; sstrtreg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sstrtreg", op, join, sstrtreg );
   begin
      d.add_to_criteria( c, elem );
   end Add_sstrtreg;


   procedure Add_stramt1( c : in out d.Criteria; stramt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "stramt1", op, join, Long_Float( stramt1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_stramt1;


   procedure Add_stramt2( c : in out d.Criteria; stramt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "stramt2", op, join, Long_Float( stramt2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_stramt2;


   procedure Add_strcov( c : in out d.Criteria; strcov : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "strcov", op, join, strcov );
   begin
      d.add_to_criteria( c, elem );
   end Add_strcov;


   procedure Add_strmort( c : in out d.Criteria; strmort : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "strmort", op, join, strmort );
   begin
      d.add_to_criteria( c, elem );
   end Add_strmort;


   procedure Add_stroths( c : in out d.Criteria; stroths : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "stroths", op, join, stroths );
   begin
      d.add_to_criteria( c, elem );
   end Add_stroths;


   procedure Add_strpd1( c : in out d.Criteria; strpd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "strpd1", op, join, strpd1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_strpd1;


   procedure Add_strpd2( c : in out d.Criteria; strpd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "strpd2", op, join, strpd2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_strpd2;


   procedure Add_suballow( c : in out d.Criteria; suballow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "suballow", op, join, suballow );
   begin
      d.add_to_criteria( c, elem );
   end Add_suballow;


   procedure Add_sublet( c : in out d.Criteria; sublet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sublet", op, join, sublet );
   begin
      d.add_to_criteria( c, elem );
   end Add_sublet;


   procedure Add_sublety( c : in out d.Criteria; sublety : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sublety", op, join, sublety );
   begin
      d.add_to_criteria( c, elem );
   end Add_sublety;


   procedure Add_subrent( c : in out d.Criteria; subrent : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "subrent", op, join, Long_Float( subrent ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_subrent;


   procedure Add_tenure( c : in out d.Criteria; tenure : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tenure", op, join, tenure );
   begin
      d.add_to_criteria( c, elem );
   end Add_tenure;


   procedure Add_totadult( c : in out d.Criteria; totadult : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totadult", op, join, totadult );
   begin
      d.add_to_criteria( c, elem );
   end Add_totadult;


   procedure Add_totchild( c : in out d.Criteria; totchild : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totchild", op, join, totchild );
   begin
      d.add_to_criteria( c, elem );
   end Add_totchild;


   procedure Add_totdepdk( c : in out d.Criteria; totdepdk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totdepdk", op, join, totdepdk );
   begin
      d.add_to_criteria( c, elem );
   end Add_totdepdk;


   procedure Add_tvlic( c : in out d.Criteria; tvlic : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tvlic", op, join, tvlic );
   begin
      d.add_to_criteria( c, elem );
   end Add_tvlic;


   procedure Add_typeacc( c : in out d.Criteria; typeacc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "typeacc", op, join, typeacc );
   begin
      d.add_to_criteria( c, elem );
   end Add_typeacc;


   procedure Add_usevcl( c : in out d.Criteria; usevcl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "usevcl", op, join, usevcl );
   begin
      d.add_to_criteria( c, elem );
   end Add_usevcl;


   procedure Add_watamt( c : in out d.Criteria; watamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "watamt", op, join, Long_Float( watamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_watamt;


   procedure Add_watanul( c : in out d.Criteria; watanul : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "watanul", op, join, Long_Float( watanul ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_watanul;


   procedure Add_watermet( c : in out d.Criteria; watermet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "watermet", op, join, watermet );
   begin
      d.add_to_criteria( c, elem );
   end Add_watermet;


   procedure Add_waterpay( c : in out d.Criteria; waterpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "waterpay", op, join, waterpay );
   begin
      d.add_to_criteria( c, elem );
   end Add_waterpay;


   procedure Add_watrb( c : in out d.Criteria; watrb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "watrb", op, join, watrb );
   begin
      d.add_to_criteria( c, elem );
   end Add_watrb;


   procedure Add_wattime( c : in out d.Criteria; wattime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wattime", op, join, wattime );
   begin
      d.add_to_criteria( c, elem );
   end Add_wattime;


   procedure Add_welfmilk( c : in out d.Criteria; welfmilk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "welfmilk", op, join, welfmilk );
   begin
      d.add_to_criteria( c, elem );
   end Add_welfmilk;


   procedure Add_whoctb01( c : in out d.Criteria; whoctb01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb01", op, join, whoctb01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb01;


   procedure Add_whoctb02( c : in out d.Criteria; whoctb02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb02", op, join, whoctb02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb02;


   procedure Add_whoctb03( c : in out d.Criteria; whoctb03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb03", op, join, whoctb03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb03;


   procedure Add_whoctb04( c : in out d.Criteria; whoctb04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb04", op, join, whoctb04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb04;


   procedure Add_whoctb05( c : in out d.Criteria; whoctb05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb05", op, join, whoctb05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb05;


   procedure Add_whoctb06( c : in out d.Criteria; whoctb06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb06", op, join, whoctb06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb06;


   procedure Add_whoctb07( c : in out d.Criteria; whoctb07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb07", op, join, whoctb07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb07;


   procedure Add_whoctb08( c : in out d.Criteria; whoctb08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb08", op, join, whoctb08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb08;


   procedure Add_whoctb09( c : in out d.Criteria; whoctb09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb09", op, join, whoctb09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb09;


   procedure Add_whoctb10( c : in out d.Criteria; whoctb10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb10", op, join, whoctb10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb10;


   procedure Add_whoctb11( c : in out d.Criteria; whoctb11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb11", op, join, whoctb11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb11;


   procedure Add_whoctb12( c : in out d.Criteria; whoctb12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb12", op, join, whoctb12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb12;


   procedure Add_whoctb13( c : in out d.Criteria; whoctb13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb13", op, join, whoctb13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb13;


   procedure Add_whoctb14( c : in out d.Criteria; whoctb14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctb14", op, join, whoctb14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb14;


   procedure Add_whoctbns( c : in out d.Criteria; whoctbns : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctbns", op, join, whoctbns );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctbns;


   procedure Add_whoctbot( c : in out d.Criteria; whoctbot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoctbot", op, join, whoctbot );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctbot;


   procedure Add_whorsp01( c : in out d.Criteria; whorsp01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp01", op, join, whorsp01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp01;


   procedure Add_whorsp02( c : in out d.Criteria; whorsp02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp02", op, join, whorsp02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp02;


   procedure Add_whorsp03( c : in out d.Criteria; whorsp03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp03", op, join, whorsp03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp03;


   procedure Add_whorsp04( c : in out d.Criteria; whorsp04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp04", op, join, whorsp04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp04;


   procedure Add_whorsp05( c : in out d.Criteria; whorsp05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp05", op, join, whorsp05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp05;


   procedure Add_whorsp06( c : in out d.Criteria; whorsp06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp06", op, join, whorsp06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp06;


   procedure Add_whorsp07( c : in out d.Criteria; whorsp07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp07", op, join, whorsp07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp07;


   procedure Add_whorsp08( c : in out d.Criteria; whorsp08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp08", op, join, whorsp08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp08;


   procedure Add_whorsp09( c : in out d.Criteria; whorsp09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp09", op, join, whorsp09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp09;


   procedure Add_whorsp10( c : in out d.Criteria; whorsp10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp10", op, join, whorsp10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp10;


   procedure Add_whorsp11( c : in out d.Criteria; whorsp11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp11", op, join, whorsp11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp11;


   procedure Add_whorsp12( c : in out d.Criteria; whorsp12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp12", op, join, whorsp12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp12;


   procedure Add_whorsp13( c : in out d.Criteria; whorsp13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp13", op, join, whorsp13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp13;


   procedure Add_whorsp14( c : in out d.Criteria; whorsp14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whorsp14", op, join, whorsp14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp14;


   procedure Add_whynoct( c : in out d.Criteria; whynoct : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whynoct", op, join, whynoct );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynoct;


   procedure Add_wmintro( c : in out d.Criteria; wmintro : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wmintro", op, join, wmintro );
   begin
      d.add_to_criteria( c, elem );
   end Add_wmintro;


   procedure Add_wsewamt( c : in out d.Criteria; wsewamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wsewamt", op, join, Long_Float( wsewamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wsewamt;


   procedure Add_wsewanul( c : in out d.Criteria; wsewanul : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wsewanul", op, join, Long_Float( wsewanul ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_wsewanul;


   procedure Add_wsewtime( c : in out d.Criteria; wsewtime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wsewtime", op, join, wsewtime );
   begin
      d.add_to_criteria( c, elem );
   end Add_wsewtime;


   procedure Add_yearcode( c : in out d.Criteria; yearcode : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "yearcode", op, join, yearcode );
   begin
      d.add_to_criteria( c, elem );
   end Add_yearcode;


   procedure Add_yearlive( c : in out d.Criteria; yearlive : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "yearlive", op, join, yearlive );
   begin
      d.add_to_criteria( c, elem );
   end Add_yearlive;


   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "month", op, join, month );
   begin
      d.add_to_criteria( c, elem );
   end Add_month;


   procedure Add_actacch( c : in out d.Criteria; actacch : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "actacch", op, join, actacch );
   begin
      d.add_to_criteria( c, elem );
   end Add_actacch;


   procedure Add_adddahh( c : in out d.Criteria; adddahh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adddahh", op, join, adddahh );
   begin
      d.add_to_criteria( c, elem );
   end Add_adddahh;


   procedure Add_adulth( c : in out d.Criteria; adulth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adulth", op, join, adulth );
   begin
      d.add_to_criteria( c, elem );
   end Add_adulth;


   procedure Add_basacth( c : in out d.Criteria; basacth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "basacth", op, join, basacth );
   begin
      d.add_to_criteria( c, elem );
   end Add_basacth;


   procedure Add_chddahh( c : in out d.Criteria; chddahh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chddahh", op, join, chddahh );
   begin
      d.add_to_criteria( c, elem );
   end Add_chddahh;


   procedure Add_curacth( c : in out d.Criteria; curacth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "curacth", op, join, curacth );
   begin
      d.add_to_criteria( c, elem );
   end Add_curacth;


   procedure Add_cwatamtd( c : in out d.Criteria; cwatamtd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cwatamtd", op, join, cwatamtd );
   begin
      d.add_to_criteria( c, elem );
   end Add_cwatamtd;


   procedure Add_depchldh( c : in out d.Criteria; depchldh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "depchldh", op, join, depchldh );
   begin
      d.add_to_criteria( c, elem );
   end Add_depchldh;


   procedure Add_emp( c : in out d.Criteria; emp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "emp", op, join, emp );
   begin
      d.add_to_criteria( c, elem );
   end Add_emp;


   procedure Add_emphrp( c : in out d.Criteria; emphrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "emphrp", op, join, emphrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_emphrp;


   procedure Add_endowpay( c : in out d.Criteria; endowpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "endowpay", op, join, Long_Float( endowpay ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_endowpay;


   procedure Add_equivahc( c : in out d.Criteria; equivahc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "equivahc", op, join, Long_Float( equivahc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_equivahc;


   procedure Add_equivbhc( c : in out d.Criteria; equivbhc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "equivbhc", op, join, Long_Float( equivbhc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_equivbhc;


   procedure Add_fsbndcth( c : in out d.Criteria; fsbndcth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fsbndcth", op, join, fsbndcth );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsbndcth;


   procedure Add_gbhscost( c : in out d.Criteria; gbhscost : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gbhscost", op, join, gbhscost );
   begin
      d.add_to_criteria( c, elem );
   end Add_gbhscost;


   procedure Add_gebacth( c : in out d.Criteria; gebacth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gebacth", op, join, gebacth );
   begin
      d.add_to_criteria( c, elem );
   end Add_gebacth;


   procedure Add_giltcth( c : in out d.Criteria; giltcth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "giltcth", op, join, giltcth );
   begin
      d.add_to_criteria( c, elem );
   end Add_giltcth;


   procedure Add_gross2( c : in out d.Criteria; gross2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gross2", op, join, gross2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross2;


   procedure Add_gross3( c : in out d.Criteria; gross3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gross3", op, join, gross3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross3;


   procedure Add_grossct( c : in out d.Criteria; grossct : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grossct", op, join, grossct );
   begin
      d.add_to_criteria( c, elem );
   end Add_grossct;


   procedure Add_hbeninc( c : in out d.Criteria; hbeninc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbeninc", op, join, hbeninc );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbeninc;


   procedure Add_hbindhh( c : in out d.Criteria; hbindhh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbindhh", op, join, hbindhh );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbindhh;


   procedure Add_hcband( c : in out d.Criteria; hcband : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hcband", op, join, hcband );
   begin
      d.add_to_criteria( c, elem );
   end Add_hcband;


   procedure Add_hdhhinc( c : in out d.Criteria; hdhhinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hdhhinc", op, join, hdhhinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdhhinc;


   procedure Add_hdtax( c : in out d.Criteria; hdtax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hdtax", op, join, hdtax );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdtax;


   procedure Add_hearns( c : in out d.Criteria; hearns : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hearns", op, join, Long_Float( hearns ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hearns;


   procedure Add_hhagegr2( c : in out d.Criteria; hhagegr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhagegr2", op, join, hhagegr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhagegr2;


   procedure Add_hhagegrp( c : in out d.Criteria; hhagegrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhagegrp", op, join, hhagegrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhagegrp;


   procedure Add_hhcomp( c : in out d.Criteria; hhcomp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhcomp", op, join, hhcomp );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhcomp;


   procedure Add_hhcomps( c : in out d.Criteria; hhcomps : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhcomps", op, join, hhcomps );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhcomps;


   procedure Add_hhdisben( c : in out d.Criteria; hhdisben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhdisben", op, join, hhdisben );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhdisben;


   procedure Add_hhethgr2( c : in out d.Criteria; hhethgr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhethgr2", op, join, hhethgr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhethgr2;


   procedure Add_hhethgrp( c : in out d.Criteria; hhethgrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhethgrp", op, join, hhethgrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhethgrp;


   procedure Add_hhinc( c : in out d.Criteria; hhinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhinc", op, join, hhinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhinc;


   procedure Add_hhincbnd( c : in out d.Criteria; hhincbnd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhincbnd", op, join, hhincbnd );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhincbnd;


   procedure Add_hhinv( c : in out d.Criteria; hhinv : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhinv", op, join, Long_Float( hhinv ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhinv;


   procedure Add_hhirben( c : in out d.Criteria; hhirben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhirben", op, join, hhirben );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhirben;


   procedure Add_hhkids( c : in out d.Criteria; hhkids : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhkids", op, join, hhkids );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhkids;


   procedure Add_hhnirben( c : in out d.Criteria; hhnirben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhnirben", op, join, hhnirben );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhnirben;


   procedure Add_hhothben( c : in out d.Criteria; hhothben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhothben", op, join, hhothben );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhothben;


   procedure Add_hhrent( c : in out d.Criteria; hhrent : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhrent", op, join, hhrent );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhrent;


   procedure Add_hhrinc( c : in out d.Criteria; hhrinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhrinc", op, join, Long_Float( hhrinc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhrinc;


   procedure Add_hhrpinc( c : in out d.Criteria; hhrpinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhrpinc", op, join, Long_Float( hhrpinc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhrpinc;


   procedure Add_hhsize( c : in out d.Criteria; hhsize : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhsize", op, join, hhsize );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhsize;


   procedure Add_hhtvlic( c : in out d.Criteria; hhtvlic : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhtvlic", op, join, Long_Float( hhtvlic ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhtvlic;


   procedure Add_hhtxcred( c : in out d.Criteria; hhtxcred : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhtxcred", op, join, Long_Float( hhtxcred ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhtxcred;


   procedure Add_hothinc( c : in out d.Criteria; hothinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hothinc", op, join, Long_Float( hothinc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hothinc;


   procedure Add_hpeninc( c : in out d.Criteria; hpeninc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hpeninc", op, join, Long_Float( hpeninc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hpeninc;


   procedure Add_hrband( c : in out d.Criteria; hrband : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrband", op, join, hrband );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrband;


   procedure Add_hseinc( c : in out d.Criteria; hseinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hseinc", op, join, Long_Float( hseinc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hseinc;


   procedure Add_isacth( c : in out d.Criteria; isacth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "isacth", op, join, isacth );
   begin
      d.add_to_criteria( c, elem );
   end Add_isacth;


   procedure Add_london( c : in out d.Criteria; london : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "london", op, join, london );
   begin
      d.add_to_criteria( c, elem );
   end Add_london;


   procedure Add_mortcost( c : in out d.Criteria; mortcost : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mortcost", op, join, Long_Float( mortcost ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortcost;


   procedure Add_mortint( c : in out d.Criteria; mortint : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mortint", op, join, Long_Float( mortint ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortint;


   procedure Add_mortpay( c : in out d.Criteria; mortpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mortpay", op, join, Long_Float( mortpay ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortpay;


   procedure Add_nddctb( c : in out d.Criteria; nddctb : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nddctb", op, join, Long_Float( nddctb ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_nddctb;


   procedure Add_nddishc( c : in out d.Criteria; nddishc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nddishc", op, join, Long_Float( nddishc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_nddishc;


   procedure Add_nihscost( c : in out d.Criteria; nihscost : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nihscost", op, join, nihscost );
   begin
      d.add_to_criteria( c, elem );
   end Add_nihscost;


   procedure Add_nsbocth( c : in out d.Criteria; nsbocth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nsbocth", op, join, nsbocth );
   begin
      d.add_to_criteria( c, elem );
   end Add_nsbocth;


   procedure Add_otbscth( c : in out d.Criteria; otbscth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "otbscth", op, join, otbscth );
   begin
      d.add_to_criteria( c, elem );
   end Add_otbscth;


   procedure Add_pacctype( c : in out d.Criteria; pacctype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pacctype", op, join, pacctype );
   begin
      d.add_to_criteria( c, elem );
   end Add_pacctype;


   procedure Add_penage( c : in out d.Criteria; penage : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penage", op, join, penage );
   begin
      d.add_to_criteria( c, elem );
   end Add_penage;


   procedure Add_penhrp( c : in out d.Criteria; penhrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penhrp", op, join, penhrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_penhrp;


   procedure Add_pepscth( c : in out d.Criteria; pepscth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pepscth", op, join, pepscth );
   begin
      d.add_to_criteria( c, elem );
   end Add_pepscth;


   procedure Add_poaccth( c : in out d.Criteria; poaccth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "poaccth", op, join, poaccth );
   begin
      d.add_to_criteria( c, elem );
   end Add_poaccth;


   procedure Add_prbocth( c : in out d.Criteria; prbocth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "prbocth", op, join, prbocth );
   begin
      d.add_to_criteria( c, elem );
   end Add_prbocth;


   procedure Add_ptentyp2( c : in out d.Criteria; ptentyp2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ptentyp2", op, join, ptentyp2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ptentyp2;


   procedure Add_sayecth( c : in out d.Criteria; sayecth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sayecth", op, join, sayecth );
   begin
      d.add_to_criteria( c, elem );
   end Add_sayecth;


   procedure Add_sclbcth( c : in out d.Criteria; sclbcth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sclbcth", op, join, sclbcth );
   begin
      d.add_to_criteria( c, elem );
   end Add_sclbcth;


   procedure Add_servpay( c : in out d.Criteria; servpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "servpay", op, join, Long_Float( servpay ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_servpay;


   procedure Add_sick( c : in out d.Criteria; sick : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sick", op, join, sick );
   begin
      d.add_to_criteria( c, elem );
   end Add_sick;


   procedure Add_sickhrp( c : in out d.Criteria; sickhrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sickhrp", op, join, sickhrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_sickhrp;


   procedure Add_sscth( c : in out d.Criteria; sscth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sscth", op, join, sscth );
   begin
      d.add_to_criteria( c, elem );
   end Add_sscth;


   procedure Add_struins( c : in out d.Criteria; struins : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "struins", op, join, Long_Float( struins ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_struins;


   procedure Add_stshcth( c : in out d.Criteria; stshcth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "stshcth", op, join, stshcth );
   begin
      d.add_to_criteria( c, elem );
   end Add_stshcth;


   procedure Add_tentyp2( c : in out d.Criteria; tentyp2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tentyp2", op, join, tentyp2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_tentyp2;


   procedure Add_tesscth( c : in out d.Criteria; tesscth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tesscth", op, join, tesscth );
   begin
      d.add_to_criteria( c, elem );
   end Add_tesscth;


   procedure Add_tuhhrent( c : in out d.Criteria; tuhhrent : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tuhhrent", op, join, Long_Float( tuhhrent ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_tuhhrent;


   procedure Add_tuwatsew( c : in out d.Criteria; tuwatsew : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tuwatsew", op, join, Long_Float( tuwatsew ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_tuwatsew;


   procedure Add_untrcth( c : in out d.Criteria; untrcth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "untrcth", op, join, untrcth );
   begin
      d.add_to_criteria( c, elem );
   end Add_untrcth;


   procedure Add_watsewrt( c : in out d.Criteria; watsewrt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "watsewrt", op, join, Long_Float( watsewrt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_watsewrt;


   procedure Add_acornew( c : in out d.Criteria; acornew : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "acornew", op, join, acornew );
   begin
      d.add_to_criteria( c, elem );
   end Add_acornew;


   procedure Add_crunach( c : in out d.Criteria; crunach : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "crunach", op, join, crunach );
   begin
      d.add_to_criteria( c, elem );
   end Add_crunach;


   procedure Add_enomorth( c : in out d.Criteria; enomorth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "enomorth", op, join, enomorth );
   begin
      d.add_to_criteria( c, elem );
   end Add_enomorth;


   procedure Add_dvadulth( c : in out d.Criteria; dvadulth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dvadulth", op, join, dvadulth );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvadulth;


   procedure Add_dvtotad( c : in out d.Criteria; dvtotad : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dvtotad", op, join, dvtotad );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvtotad;


   procedure Add_urindew( c : in out d.Criteria; urindew : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "urindew", op, join, urindew );
   begin
      d.add_to_criteria( c, elem );
   end Add_urindew;


   procedure Add_urinds( c : in out d.Criteria; urinds : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "urinds", op, join, urinds );
   begin
      d.add_to_criteria( c, elem );
   end Add_urinds;


   procedure Add_vehnumb( c : in out d.Criteria; vehnumb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "vehnumb", op, join, vehnumb );
   begin
      d.add_to_criteria( c, elem );
   end Add_vehnumb;


   procedure Add_country( c : in out d.Criteria; country : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "country", op, join, country );
   begin
      d.add_to_criteria( c, elem );
   end Add_country;


   procedure Add_hbindhh2( c : in out d.Criteria; hbindhh2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbindhh2", op, join, hbindhh2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbindhh2;


   procedure Add_pocardh( c : in out d.Criteria; pocardh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pocardh", op, join, pocardh );
   begin
      d.add_to_criteria( c, elem );
   end Add_pocardh;


   procedure Add_entry5( c : in out d.Criteria; entry5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "entry5", op, join, entry5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_entry5;


   procedure Add_entry6( c : in out d.Criteria; entry6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "entry6", op, join, entry6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_entry6;


   procedure Add_imd_e( c : in out d.Criteria; imd_e : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "imd_e", op, join, imd_e );
   begin
      d.add_to_criteria( c, elem );
   end Add_imd_e;


   procedure Add_imd_s( c : in out d.Criteria; imd_s : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "imd_s", op, join, imd_s );
   begin
      d.add_to_criteria( c, elem );
   end Add_imd_s;


   procedure Add_imd_w( c : in out d.Criteria; imd_w : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "imd_w", op, join, imd_w );
   begin
      d.add_to_criteria( c, elem );
   end Add_imd_w;


   procedure Add_numtv1( c : in out d.Criteria; numtv1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numtv1", op, join, numtv1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_numtv1;


   procedure Add_numtv2( c : in out d.Criteria; numtv2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numtv2", op, join, numtv2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_numtv2;


   procedure Add_oac( c : in out d.Criteria; oac : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oac", op, join, oac );
   begin
      d.add_to_criteria( c, elem );
   end Add_oac;


   procedure Add_bedroom6( c : in out d.Criteria; bedroom6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bedroom6", op, join, bedroom6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_bedroom6;


   procedure Add_rooms10( c : in out d.Criteria; rooms10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rooms10", op, join, rooms10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_rooms10;


   procedure Add_brma( c : in out d.Criteria; brma : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "brma", op, join, brma );
   begin
      d.add_to_criteria( c, elem );
   end Add_brma;


   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issue", op, join, issue );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue;


   procedure Add_migrq1( c : in out d.Criteria; migrq1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "migrq1", op, join, migrq1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_migrq1;


   procedure Add_migrq2( c : in out d.Criteria; migrq2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "migrq2", op, join, migrq2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_migrq2;


   procedure Add_hhagegr3( c : in out d.Criteria; hhagegr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhagegr3", op, join, hhagegr3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhagegr3;


   procedure Add_hhagegr4( c : in out d.Criteria; hhagegr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhagegr4", op, join, hhagegr4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhagegr4;


   procedure Add_capval( c : in out d.Criteria; capval : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "capval", op, join, capval );
   begin
      d.add_to_criteria( c, elem );
   end Add_capval;


   procedure Add_nidpnd( c : in out d.Criteria; nidpnd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nidpnd", op, join, nidpnd );
   begin
      d.add_to_criteria( c, elem );
   end Add_nidpnd;


   procedure Add_nochcr1( c : in out d.Criteria; nochcr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nochcr1", op, join, nochcr1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nochcr1;


   procedure Add_nochcr2( c : in out d.Criteria; nochcr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nochcr2", op, join, nochcr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nochcr2;


   procedure Add_nochcr3( c : in out d.Criteria; nochcr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nochcr3", op, join, nochcr3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nochcr3;


   procedure Add_nochcr4( c : in out d.Criteria; nochcr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nochcr4", op, join, nochcr4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nochcr4;


   procedure Add_nochcr5( c : in out d.Criteria; nochcr5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nochcr5", op, join, nochcr5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nochcr5;


   procedure Add_rt2rebam( c : in out d.Criteria; rt2rebam : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rt2rebam", op, join, Long_Float( rt2rebam ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rt2rebam;


   procedure Add_rt2rebpd( c : in out d.Criteria; rt2rebpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rt2rebpd", op, join, rt2rebpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_rt2rebpd;


   procedure Add_rtdpa( c : in out d.Criteria; rtdpa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtdpa", op, join, rtdpa );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtdpa;


   procedure Add_rtdpaamt( c : in out d.Criteria; rtdpaamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtdpaamt", op, join, Long_Float( rtdpaamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtdpaamt;


   procedure Add_rtdpapd( c : in out d.Criteria; rtdpapd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtdpapd", op, join, rtdpapd );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtdpapd;


   procedure Add_rtlpa( c : in out d.Criteria; rtlpa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtlpa", op, join, rtlpa );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtlpa;


   procedure Add_rtlpaamt( c : in out d.Criteria; rtlpaamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtlpaamt", op, join, Long_Float( rtlpaamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtlpaamt;


   procedure Add_rtlpapd( c : in out d.Criteria; rtlpapd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtlpapd", op, join, rtlpapd );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtlpapd;


   procedure Add_rtothamt( c : in out d.Criteria; rtothamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtothamt", op, join, Long_Float( rtothamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtothamt;


   procedure Add_rtother( c : in out d.Criteria; rtother : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtother", op, join, rtother );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtother;


   procedure Add_rtothpd( c : in out d.Criteria; rtothpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtothpd", op, join, rtothpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtothpd;


   procedure Add_rtrtr( c : in out d.Criteria; rtrtr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtrtr", op, join, rtrtr );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtrtr;


   procedure Add_rtrtramt( c : in out d.Criteria; rtrtramt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtrtramt", op, join, Long_Float( rtrtramt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtrtramt;


   procedure Add_rtrtrpd( c : in out d.Criteria; rtrtrpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtrtrpd", op, join, rtrtrpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtrtrpd;


   procedure Add_rttimepd( c : in out d.Criteria; rttimepd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rttimepd", op, join, rttimepd );
   begin
      d.add_to_criteria( c, elem );
   end Add_rttimepd;


   procedure Add_yrlvchk( c : in out d.Criteria; yrlvchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "yrlvchk", op, join, yrlvchk );
   begin
      d.add_to_criteria( c, elem );
   end Add_yrlvchk;


   procedure Add_gross3_x( c : in out d.Criteria; gross3_x : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gross3_x", op, join, gross3_x );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross3_x;


   procedure Add_hlthst( c : in out d.Criteria; hlthst : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlthst", op, join, hlthst );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlthst;


   procedure Add_medpay( c : in out d.Criteria; medpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medpay", op, join, medpay );
   begin
      d.add_to_criteria( c, elem );
   end Add_medpay;


   procedure Add_medwho01( c : in out d.Criteria; medwho01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho01", op, join, medwho01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho01;


   procedure Add_medwho02( c : in out d.Criteria; medwho02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho02", op, join, medwho02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho02;


   procedure Add_medwho03( c : in out d.Criteria; medwho03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho03", op, join, medwho03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho03;


   procedure Add_medwho04( c : in out d.Criteria; medwho04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho04", op, join, medwho04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho04;


   procedure Add_medwho05( c : in out d.Criteria; medwho05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho05", op, join, medwho05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho05;


   procedure Add_medwho06( c : in out d.Criteria; medwho06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho06", op, join, medwho06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho06;


   procedure Add_medwho07( c : in out d.Criteria; medwho07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho07", op, join, medwho07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho07;


   procedure Add_medwho08( c : in out d.Criteria; medwho08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho08", op, join, medwho08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho08;


   procedure Add_medwho09( c : in out d.Criteria; medwho09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho09", op, join, medwho09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho09;


   procedure Add_medwho10( c : in out d.Criteria; medwho10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho10", op, join, medwho10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho10;


   procedure Add_medwho11( c : in out d.Criteria; medwho11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho11", op, join, medwho11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho11;


   procedure Add_medwho12( c : in out d.Criteria; medwho12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho12", op, join, medwho12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho12;


   procedure Add_medwho13( c : in out d.Criteria; medwho13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho13", op, join, medwho13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho13;


   procedure Add_medwho14( c : in out d.Criteria; medwho14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medwho14", op, join, medwho14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho14;


   procedure Add_nmrmshar( c : in out d.Criteria; nmrmshar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nmrmshar", op, join, nmrmshar );
   begin
      d.add_to_criteria( c, elem );
   end Add_nmrmshar;


   procedure Add_roomshr( c : in out d.Criteria; roomshr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "roomshr", op, join, roomshr );
   begin
      d.add_to_criteria( c, elem );
   end Add_roomshr;


   procedure Add_imd_ni( c : in out d.Criteria; imd_ni : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "imd_ni", op, join, imd_ni );
   begin
      d.add_to_criteria( c, elem );
   end Add_imd_ni;


   procedure Add_multi( c : in out d.Criteria; multi : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "multi", op, join, multi );
   begin
      d.add_to_criteria( c, elem );
   end Add_multi;


   procedure Add_nopay( c : in out d.Criteria; nopay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nopay", op, join, nopay );
   begin
      d.add_to_criteria( c, elem );
   end Add_nopay;


   procedure Add_orgid( c : in out d.Criteria; orgid : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "orgid", op, join, orgid );
   begin
      d.add_to_criteria( c, elem );
   end Add_orgid;


   procedure Add_rtene( c : in out d.Criteria; rtene : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtene", op, join, rtene );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtene;


   procedure Add_rteneamt( c : in out d.Criteria; rteneamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rteneamt", op, join, rteneamt );
   begin
      d.add_to_criteria( c, elem );
   end Add_rteneamt;


   procedure Add_rtgen( c : in out d.Criteria; rtgen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rtgen", op, join, rtgen );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtgen;


   procedure Add_schbrk( c : in out d.Criteria; schbrk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "schbrk", op, join, schbrk );
   begin
      d.add_to_criteria( c, elem );
   end Add_schbrk;


   procedure Add_urb( c : in out d.Criteria; urb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "urb", op, join, urb );
   begin
      d.add_to_criteria( c, elem );
   end Add_urb;


   procedure Add_urbrur( c : in out d.Criteria; urbrur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "urbrur", op, join, urbrur );
   begin
      d.add_to_criteria( c, elem );
   end Add_urbrur;


   procedure Add_hhethgr3( c : in out d.Criteria; hhethgr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hhethgr3", op, join, hhethgr3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhethgr3;


   procedure Add_niratlia( c : in out d.Criteria; niratlia : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "niratlia", op, join, Long_Float( niratlia ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_niratlia;


   procedure Add_bankse( c : in out d.Criteria; bankse : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bankse", op, join, bankse );
   begin
      d.add_to_criteria( c, elem );
   end Add_bankse;


   procedure Add_bathshow( c : in out d.Criteria; bathshow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bathshow", op, join, bathshow );
   begin
      d.add_to_criteria( c, elem );
   end Add_bathshow;


   procedure Add_burden( c : in out d.Criteria; burden : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "burden", op, join, burden );
   begin
      d.add_to_criteria( c, elem );
   end Add_burden;


   procedure Add_comco( c : in out d.Criteria; comco : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "comco", op, join, comco );
   begin
      d.add_to_criteria( c, elem );
   end Add_comco;


   procedure Add_comp1sc( c : in out d.Criteria; comp1sc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "comp1sc", op, join, comp1sc );
   begin
      d.add_to_criteria( c, elem );
   end Add_comp1sc;


   procedure Add_compsc( c : in out d.Criteria; compsc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "compsc", op, join, compsc );
   begin
      d.add_to_criteria( c, elem );
   end Add_compsc;


   procedure Add_comwa( c : in out d.Criteria; comwa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "comwa", op, join, comwa );
   begin
      d.add_to_criteria( c, elem );
   end Add_comwa;


   procedure Add_dwellno( c : in out d.Criteria; dwellno : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dwellno", op, join, dwellno );
   begin
      d.add_to_criteria( c, elem );
   end Add_dwellno;


   procedure Add_elecin( c : in out d.Criteria; elecin : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "elecin", op, join, elecin );
   begin
      d.add_to_criteria( c, elem );
   end Add_elecin;


   procedure Add_elecinw( c : in out d.Criteria; elecinw : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "elecinw", op, join, elecinw );
   begin
      d.add_to_criteria( c, elem );
   end Add_elecinw;


   procedure Add_eulowest( c : in out d.Criteria; eulowest : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eulowest", op, join, Long_Float( eulowest ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_eulowest;


   procedure Add_flshtoil( c : in out d.Criteria; flshtoil : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "flshtoil", op, join, flshtoil );
   begin
      d.add_to_criteria( c, elem );
   end Add_flshtoil;


   procedure Add_grocse( c : in out d.Criteria; grocse : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grocse", op, join, grocse );
   begin
      d.add_to_criteria( c, elem );
   end Add_grocse;


   procedure Add_gvtregno( c : in out d.Criteria; gvtregno : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gvtregno", op, join, gvtregno );
   begin
      d.add_to_criteria( c, elem );
   end Add_gvtregno;


   procedure Add_heat( c : in out d.Criteria; heat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heat", op, join, heat );
   begin
      d.add_to_criteria( c, elem );
   end Add_heat;


   procedure Add_heatcen( c : in out d.Criteria; heatcen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heatcen", op, join, heatcen );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatcen;


   procedure Add_heatfire( c : in out d.Criteria; heatfire : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heatfire", op, join, heatfire );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatfire;


   procedure Add_kitchen( c : in out d.Criteria; kitchen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kitchen", op, join, kitchen );
   begin
      d.add_to_criteria( c, elem );
   end Add_kitchen;


   procedure Add_knsizeft( c : in out d.Criteria; knsizeft : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "knsizeft", op, join, knsizeft );
   begin
      d.add_to_criteria( c, elem );
   end Add_knsizeft;


   procedure Add_knsizem( c : in out d.Criteria; knsizem : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "knsizem", op, join, knsizem );
   begin
      d.add_to_criteria( c, elem );
   end Add_knsizem;


   procedure Add_laua( c : in out d.Criteria; laua : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "laua", op, join, laua );
   begin
      d.add_to_criteria( c, elem );
   end Add_laua;


   procedure Add_movef( c : in out d.Criteria; movef : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "movef", op, join, movef );
   begin
      d.add_to_criteria( c, elem );
   end Add_movef;


   procedure Add_movenxt( c : in out d.Criteria; movenxt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "movenxt", op, join, movenxt );
   begin
      d.add_to_criteria( c, elem );
   end Add_movenxt;


   procedure Add_movereas( c : in out d.Criteria; movereas : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "movereas", op, join, movereas );
   begin
      d.add_to_criteria( c, elem );
   end Add_movereas;


   procedure Add_ovsat( c : in out d.Criteria; ovsat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ovsat", op, join, ovsat );
   begin
      d.add_to_criteria( c, elem );
   end Add_ovsat;


   procedure Add_plum1bin( c : in out d.Criteria; plum1bin : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "plum1bin", op, join, plum1bin );
   begin
      d.add_to_criteria( c, elem );
   end Add_plum1bin;


   procedure Add_plumin( c : in out d.Criteria; plumin : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "plumin", op, join, plumin );
   begin
      d.add_to_criteria( c, elem );
   end Add_plumin;


   procedure Add_pluminw( c : in out d.Criteria; pluminw : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pluminw", op, join, pluminw );
   begin
      d.add_to_criteria( c, elem );
   end Add_pluminw;


   procedure Add_postse( c : in out d.Criteria; postse : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "postse", op, join, postse );
   begin
      d.add_to_criteria( c, elem );
   end Add_postse;


   procedure Add_primh( c : in out d.Criteria; primh : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "primh", op, join, primh );
   begin
      d.add_to_criteria( c, elem );
   end Add_primh;


   procedure Add_pubtr( c : in out d.Criteria; pubtr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pubtr", op, join, pubtr );
   begin
      d.add_to_criteria( c, elem );
   end Add_pubtr;


   procedure Add_samesc( c : in out d.Criteria; samesc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "samesc", op, join, samesc );
   begin
      d.add_to_criteria( c, elem );
   end Add_samesc;


   procedure Add_schfrt( c : in out d.Criteria; schfrt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "schfrt", op, join, schfrt );
   begin
      d.add_to_criteria( c, elem );
   end Add_schfrt;


   procedure Add_selper( c : in out d.Criteria; selper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "selper", op, join, selper );
   begin
      d.add_to_criteria( c, elem );
   end Add_selper;


   procedure Add_short( c : in out d.Criteria; short : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "short", op, join, short );
   begin
      d.add_to_criteria( c, elem );
   end Add_short;


   procedure Add_sizeft( c : in out d.Criteria; sizeft : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sizeft", op, join, sizeft );
   begin
      d.add_to_criteria( c, elem );
   end Add_sizeft;


   procedure Add_sizem( c : in out d.Criteria; sizem : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sizem", op, join, sizem );
   begin
      d.add_to_criteria( c, elem );
   end Add_sizem;


   procedure Add_tvwhy( c : in out d.Criteria; tvwhy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tvwhy", op, join, tvwhy );
   begin
      d.add_to_criteria( c, elem );
   end Add_tvwhy;


   procedure Add_yearwhc( c : in out d.Criteria; yearwhc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "yearwhc", op, join, yearwhc );
   begin
      d.add_to_criteria( c, elem );
   end Add_yearwhc;


   procedure Add_dischha1( c : in out d.Criteria; dischha1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dischha1", op, join, dischha1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dischha1;


   procedure Add_dischhc1( c : in out d.Criteria; dischhc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dischhc1", op, join, dischhc1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dischhc1;


   procedure Add_diswhha1( c : in out d.Criteria; diswhha1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "diswhha1", op, join, diswhha1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_diswhha1;


   procedure Add_diswhhc1( c : in out d.Criteria; diswhhc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "diswhhc1", op, join, diswhhc1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_diswhhc1;


   procedure Add_gross4( c : in out d.Criteria; gross4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gross4", op, join, gross4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross4;


   procedure Add_lldcare( c : in out d.Criteria; lldcare : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lldcare", op, join, lldcare );
   begin
      d.add_to_criteria( c, elem );
   end Add_lldcare;


   procedure Add_urindni( c : in out d.Criteria; urindni : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "urindni", op, join, urindni );
   begin
      d.add_to_criteria( c, elem );
   end Add_urindni;


   procedure Add_nhbeninc( c : in out d.Criteria; nhbeninc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nhbeninc", op, join, nhbeninc );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhbeninc;


   procedure Add_nhhnirbn( c : in out d.Criteria; nhhnirbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nhhnirbn", op, join, nhhnirbn );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhhnirbn;


   procedure Add_nhhothbn( c : in out d.Criteria; nhhothbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nhhothbn", op, join, nhhothbn );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhhothbn;


   procedure Add_seramt1( c : in out d.Criteria; seramt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seramt1", op, join, Long_Float( seramt1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_seramt1;


   procedure Add_seramt2( c : in out d.Criteria; seramt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seramt2", op, join, Long_Float( seramt2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_seramt2;


   procedure Add_seramt3( c : in out d.Criteria; seramt3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seramt3", op, join, Long_Float( seramt3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_seramt3;


   procedure Add_seramt4( c : in out d.Criteria; seramt4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seramt4", op, join, Long_Float( seramt4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_seramt4;


   procedure Add_serpay1( c : in out d.Criteria; serpay1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serpay1", op, join, serpay1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serpay1;


   procedure Add_serpay2( c : in out d.Criteria; serpay2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serpay2", op, join, serpay2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serpay2;


   procedure Add_serpay3( c : in out d.Criteria; serpay3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serpay3", op, join, serpay3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serpay3;


   procedure Add_serpay4( c : in out d.Criteria; serpay4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serpay4", op, join, serpay4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serpay4;


   procedure Add_serper1( c : in out d.Criteria; serper1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serper1", op, join, serper1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serper1;


   procedure Add_serper2( c : in out d.Criteria; serper2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serper2", op, join, serper2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serper2;


   procedure Add_serper3( c : in out d.Criteria; serper3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serper3", op, join, serper3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serper3;


   procedure Add_serper4( c : in out d.Criteria; serper4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serper4", op, join, serper4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serper4;


   procedure Add_utility( c : in out d.Criteria; utility : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "utility", op, join, utility );
   begin
      d.add_to_criteria( c, elem );
   end Add_utility;


   procedure Add_hheth( c : in out d.Criteria; hheth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hheth", op, join, hheth );
   begin
      d.add_to_criteria( c, elem );
   end Add_hheth;


   procedure Add_seramt5( c : in out d.Criteria; seramt5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seramt5", op, join, Long_Float( seramt5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_seramt5;


   procedure Add_sercomb( c : in out d.Criteria; sercomb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sercomb", op, join, sercomb );
   begin
      d.add_to_criteria( c, elem );
   end Add_sercomb;


   procedure Add_serpay5( c : in out d.Criteria; serpay5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serpay5", op, join, serpay5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serpay5;


   procedure Add_serper5( c : in out d.Criteria; serper5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "serper5", op, join, serper5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_serper5;


   procedure Add_urbni( c : in out d.Criteria; urbni : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "urbni", op, join, urbni );
   begin
      d.add_to_criteria( c, elem );
   end Add_urbni;


   
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


   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sernum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sernum_To_Orderings;


   procedure Add_acorn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "acorn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_acorn_To_Orderings;


   procedure Add_bedroom_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bedroom", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bedroom_To_Orderings;


   procedure Add_benunits_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benunits", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benunits_To_Orderings;


   procedure Add_billrate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "billrate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_billrate_To_Orderings;


   procedure Add_busroom_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "busroom", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_busroom_To_Orderings;


   procedure Add_centfuel_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "centfuel", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_centfuel_To_Orderings;


   procedure Add_centheat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "centheat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_centheat_To_Orderings;


   procedure Add_charge1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "charge1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge1_To_Orderings;


   procedure Add_charge2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "charge2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge2_To_Orderings;


   procedure Add_charge3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "charge3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge3_To_Orderings;


   procedure Add_charge4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "charge4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge4_To_Orderings;


   procedure Add_charge5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "charge5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge5_To_Orderings;


   procedure Add_charge6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "charge6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge6_To_Orderings;


   procedure Add_charge7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "charge7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge7_To_Orderings;


   procedure Add_charge8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "charge8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge8_To_Orderings;


   procedure Add_charge9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "charge9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_charge9_To_Orderings;


   procedure Add_chins_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chins", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chins_To_Orderings;


   procedure Add_chrgamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgamt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt1_To_Orderings;


   procedure Add_chrgamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgamt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt2_To_Orderings;


   procedure Add_chrgamt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgamt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt3_To_Orderings;


   procedure Add_chrgamt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgamt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt4_To_Orderings;


   procedure Add_chrgamt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgamt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt5_To_Orderings;


   procedure Add_chrgamt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgamt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt6_To_Orderings;


   procedure Add_chrgamt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgamt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt7_To_Orderings;


   procedure Add_chrgamt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgamt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt8_To_Orderings;


   procedure Add_chrgamt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgamt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgamt9_To_Orderings;


   procedure Add_chrgpd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgpd1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd1_To_Orderings;


   procedure Add_chrgpd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgpd2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd2_To_Orderings;


   procedure Add_chrgpd3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgpd3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd3_To_Orderings;


   procedure Add_chrgpd4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgpd4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd4_To_Orderings;


   procedure Add_chrgpd5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgpd5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd5_To_Orderings;


   procedure Add_chrgpd6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgpd6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd6_To_Orderings;


   procedure Add_chrgpd7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgpd7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd7_To_Orderings;


   procedure Add_chrgpd8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgpd8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd8_To_Orderings;


   procedure Add_chrgpd9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrgpd9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrgpd9_To_Orderings;


   procedure Add_contv1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "contv1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_contv1_To_Orderings;


   procedure Add_contv2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "contv2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_contv2_To_Orderings;


   procedure Add_covoths_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "covoths", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_covoths_To_Orderings;


   procedure Add_csewamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "csewamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_csewamt_To_Orderings;


   procedure Add_csewamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "csewamt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_csewamt1_To_Orderings;


   procedure Add_ct25d50d_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ct25d50d", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ct25d50d_To_Orderings;


   procedure Add_ctamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctamt_To_Orderings;


   procedure Add_ctannual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctannual", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctannual_To_Orderings;


   procedure Add_ctband_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctband", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctband_To_Orderings;


   procedure Add_ctbwait_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctbwait", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctbwait_To_Orderings;


   procedure Add_ctcondoc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctcondoc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctcondoc_To_Orderings;


   procedure Add_ctdisc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctdisc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctdisc_To_Orderings;


   procedure Add_ctinstal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctinstal", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctinstal_To_Orderings;


   procedure Add_ctlvband_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctlvband", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctlvband_To_Orderings;


   procedure Add_ctlvchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctlvchk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctlvchk_To_Orderings;


   procedure Add_ctreb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctreb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctreb_To_Orderings;


   procedure Add_ctrebamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctrebamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctrebamt_To_Orderings;


   procedure Add_ctrebpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctrebpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctrebpd_To_Orderings;


   procedure Add_cttime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cttime", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cttime_To_Orderings;


   procedure Add_cwatamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cwatamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cwatamt_To_Orderings;


   procedure Add_cwatamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cwatamt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cwatamt1_To_Orderings;


   procedure Add_datyrago_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "datyrago", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_datyrago_To_Orderings;


   procedure Add_entry1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "entry1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_entry1_To_Orderings;


   procedure Add_entry2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "entry2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_entry2_To_Orderings;


   procedure Add_entry3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "entry3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_entry3_To_Orderings;


   procedure Add_entry4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "entry4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_entry4_To_Orderings;


   procedure Add_estrtann_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "estrtann", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_estrtann_To_Orderings;


   procedure Add_floor_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "floor", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_floor_To_Orderings;


   procedure Add_givehelp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "givehelp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_givehelp_To_Orderings;


   procedure Add_gor_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gor", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gor_To_Orderings;


   procedure Add_gvtregn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gvtregn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gvtregn_To_Orderings;


   procedure Add_hhldr01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr01_To_Orderings;


   procedure Add_hhldr02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr02_To_Orderings;


   procedure Add_hhldr03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr03_To_Orderings;


   procedure Add_hhldr04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr04_To_Orderings;


   procedure Add_hhldr05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr05_To_Orderings;


   procedure Add_hhldr06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr06_To_Orderings;


   procedure Add_hhldr07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr07_To_Orderings;


   procedure Add_hhldr08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr08_To_Orderings;


   procedure Add_hhldr09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr09_To_Orderings;


   procedure Add_hhldr10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr10_To_Orderings;


   procedure Add_hhldr11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr11_To_Orderings;


   procedure Add_hhldr12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr12_To_Orderings;


   procedure Add_hhldr13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr13_To_Orderings;


   procedure Add_hhldr14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr14_To_Orderings;


   procedure Add_hhldr97_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhldr97", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhldr97_To_Orderings;


   procedure Add_hhstat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhstat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhstat_To_Orderings;


   procedure Add_hrpnum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrpnum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrpnum_To_Orderings;


   procedure Add_intdate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intdate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intdate_To_Orderings;


   procedure Add_lac_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lac", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lac_To_Orderings;


   procedure Add_mainacc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mainacc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mainacc_To_Orderings;


   procedure Add_mnthcode_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mnthcode", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mnthcode_To_Orderings;


   procedure Add_modcon01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon01_To_Orderings;


   procedure Add_modcon02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon02_To_Orderings;


   procedure Add_modcon03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon03_To_Orderings;


   procedure Add_modcon04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon04_To_Orderings;


   procedure Add_modcon05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon05_To_Orderings;


   procedure Add_modcon06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon06_To_Orderings;


   procedure Add_modcon07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon07_To_Orderings;


   procedure Add_modcon08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon08_To_Orderings;


   procedure Add_modcon09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon09_To_Orderings;


   procedure Add_modcon10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon10_To_Orderings;


   procedure Add_modcon11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon11_To_Orderings;


   procedure Add_modcon12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon12_To_Orderings;


   procedure Add_modcon13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon13_To_Orderings;


   procedure Add_modcon14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "modcon14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_modcon14_To_Orderings;


   procedure Add_monlive_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "monlive", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_monlive_To_Orderings;


   procedure Add_needhelp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "needhelp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_needhelp_To_Orderings;


   procedure Add_nicoun_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nicoun", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nicoun_To_Orderings;


   procedure Add_ninrv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninrv", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninrv_To_Orderings;


   procedure Add_nirate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nirate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nirate_To_Orderings;


   procedure Add_norate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "norate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_norate_To_Orderings;


   procedure Add_onbsroom_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "onbsroom", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_onbsroom_To_Orderings;


   procedure Add_orgsewam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "orgsewam", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_orgsewam_To_Orderings;


   procedure Add_orgwatam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "orgwatam", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_orgwatam_To_Orderings;


   procedure Add_payrate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "payrate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_payrate_To_Orderings;


   procedure Add_premium_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "premium", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_premium_To_Orderings;


   procedure Add_ptbsroom_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ptbsroom", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ptbsroom_To_Orderings;


   procedure Add_rooms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rooms", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rooms_To_Orderings;


   procedure Add_roomshar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "roomshar", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_roomshar_To_Orderings;


   procedure Add_rtannual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtannual", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtannual_To_Orderings;


   procedure Add_rtcheck_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtcheck", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtcheck_To_Orderings;


   procedure Add_rtcondoc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtcondoc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtcondoc_To_Orderings;


   procedure Add_rtdeduc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtdeduc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtdeduc_To_Orderings;


   procedure Add_rtinstal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtinstal", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtinstal_To_Orderings;


   procedure Add_rtreb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtreb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtreb_To_Orderings;


   procedure Add_rtrebamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtrebamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtrebamt_To_Orderings;


   procedure Add_rtrebpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtrebpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtrebpd_To_Orderings;


   procedure Add_rttime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rttime", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rttime_To_Orderings;


   procedure Add_sampqtr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sampqtr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sampqtr_To_Orderings;


   procedure Add_schmeal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "schmeal", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_schmeal_To_Orderings;


   procedure Add_schmilk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "schmilk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_schmilk_To_Orderings;


   procedure Add_sewamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sewamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sewamt_To_Orderings;


   procedure Add_sewanul_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sewanul", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sewanul_To_Orderings;


   procedure Add_sewerpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sewerpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sewerpay_To_Orderings;


   procedure Add_sewsep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sewsep", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sewsep_To_Orderings;


   procedure Add_sewtime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sewtime", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sewtime_To_Orderings;


   procedure Add_shelter_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "shelter", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_shelter_To_Orderings;


   procedure Add_sobuy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sobuy", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sobuy_To_Orderings;


   procedure Add_sstrtreg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sstrtreg", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sstrtreg_To_Orderings;


   procedure Add_stramt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "stramt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_stramt1_To_Orderings;


   procedure Add_stramt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "stramt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_stramt2_To_Orderings;


   procedure Add_strcov_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "strcov", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_strcov_To_Orderings;


   procedure Add_strmort_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "strmort", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_strmort_To_Orderings;


   procedure Add_stroths_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "stroths", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_stroths_To_Orderings;


   procedure Add_strpd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "strpd1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_strpd1_To_Orderings;


   procedure Add_strpd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "strpd2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_strpd2_To_Orderings;


   procedure Add_suballow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "suballow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_suballow_To_Orderings;


   procedure Add_sublet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sublet", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sublet_To_Orderings;


   procedure Add_sublety_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sublety", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sublety_To_Orderings;


   procedure Add_subrent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "subrent", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_subrent_To_Orderings;


   procedure Add_tenure_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tenure", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tenure_To_Orderings;


   procedure Add_totadult_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totadult", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totadult_To_Orderings;


   procedure Add_totchild_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totchild", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totchild_To_Orderings;


   procedure Add_totdepdk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totdepdk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totdepdk_To_Orderings;


   procedure Add_tvlic_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tvlic", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tvlic_To_Orderings;


   procedure Add_typeacc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "typeacc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_typeacc_To_Orderings;


   procedure Add_usevcl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "usevcl", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_usevcl_To_Orderings;


   procedure Add_watamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "watamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_watamt_To_Orderings;


   procedure Add_watanul_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "watanul", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_watanul_To_Orderings;


   procedure Add_watermet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "watermet", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_watermet_To_Orderings;


   procedure Add_waterpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "waterpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_waterpay_To_Orderings;


   procedure Add_watrb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "watrb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_watrb_To_Orderings;


   procedure Add_wattime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wattime", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wattime_To_Orderings;


   procedure Add_welfmilk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "welfmilk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_welfmilk_To_Orderings;


   procedure Add_whoctb01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb01_To_Orderings;


   procedure Add_whoctb02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb02_To_Orderings;


   procedure Add_whoctb03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb03_To_Orderings;


   procedure Add_whoctb04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb04_To_Orderings;


   procedure Add_whoctb05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb05_To_Orderings;


   procedure Add_whoctb06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb06_To_Orderings;


   procedure Add_whoctb07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb07_To_Orderings;


   procedure Add_whoctb08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb08_To_Orderings;


   procedure Add_whoctb09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb09_To_Orderings;


   procedure Add_whoctb10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb10_To_Orderings;


   procedure Add_whoctb11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb11_To_Orderings;


   procedure Add_whoctb12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb12_To_Orderings;


   procedure Add_whoctb13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb13_To_Orderings;


   procedure Add_whoctb14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctb14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctb14_To_Orderings;


   procedure Add_whoctbns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctbns", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctbns_To_Orderings;


   procedure Add_whoctbot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoctbot", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoctbot_To_Orderings;


   procedure Add_whorsp01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp01_To_Orderings;


   procedure Add_whorsp02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp02_To_Orderings;


   procedure Add_whorsp03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp03_To_Orderings;


   procedure Add_whorsp04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp04_To_Orderings;


   procedure Add_whorsp05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp05_To_Orderings;


   procedure Add_whorsp06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp06_To_Orderings;


   procedure Add_whorsp07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp07_To_Orderings;


   procedure Add_whorsp08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp08_To_Orderings;


   procedure Add_whorsp09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp09_To_Orderings;


   procedure Add_whorsp10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp10_To_Orderings;


   procedure Add_whorsp11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp11_To_Orderings;


   procedure Add_whorsp12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp12_To_Orderings;


   procedure Add_whorsp13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp13_To_Orderings;


   procedure Add_whorsp14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whorsp14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whorsp14_To_Orderings;


   procedure Add_whynoct_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whynoct", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whynoct_To_Orderings;


   procedure Add_wmintro_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wmintro", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wmintro_To_Orderings;


   procedure Add_wsewamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wsewamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wsewamt_To_Orderings;


   procedure Add_wsewanul_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wsewanul", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wsewanul_To_Orderings;


   procedure Add_wsewtime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wsewtime", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wsewtime_To_Orderings;


   procedure Add_yearcode_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "yearcode", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_yearcode_To_Orderings;


   procedure Add_yearlive_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "yearlive", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_yearlive_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;


   procedure Add_actacch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "actacch", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_actacch_To_Orderings;


   procedure Add_adddahh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adddahh", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adddahh_To_Orderings;


   procedure Add_adulth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adulth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adulth_To_Orderings;


   procedure Add_basacth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "basacth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_basacth_To_Orderings;


   procedure Add_chddahh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chddahh", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chddahh_To_Orderings;


   procedure Add_curacth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "curacth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_curacth_To_Orderings;


   procedure Add_cwatamtd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cwatamtd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cwatamtd_To_Orderings;


   procedure Add_depchldh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "depchldh", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_depchldh_To_Orderings;


   procedure Add_emp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "emp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_emp_To_Orderings;


   procedure Add_emphrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "emphrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_emphrp_To_Orderings;


   procedure Add_endowpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "endowpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_endowpay_To_Orderings;


   procedure Add_equivahc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "equivahc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_equivahc_To_Orderings;


   procedure Add_equivbhc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "equivbhc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_equivbhc_To_Orderings;


   procedure Add_fsbndcth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fsbndcth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsbndcth_To_Orderings;


   procedure Add_gbhscost_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gbhscost", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gbhscost_To_Orderings;


   procedure Add_gebacth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gebacth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gebacth_To_Orderings;


   procedure Add_giltcth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "giltcth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_giltcth_To_Orderings;


   procedure Add_gross2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gross2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross2_To_Orderings;


   procedure Add_gross3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gross3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross3_To_Orderings;


   procedure Add_grossct_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grossct", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grossct_To_Orderings;


   procedure Add_hbeninc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbeninc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbeninc_To_Orderings;


   procedure Add_hbindhh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbindhh", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbindhh_To_Orderings;


   procedure Add_hcband_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hcband", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hcband_To_Orderings;


   procedure Add_hdhhinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hdhhinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdhhinc_To_Orderings;


   procedure Add_hdtax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hdtax", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdtax_To_Orderings;


   procedure Add_hearns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hearns", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hearns_To_Orderings;


   procedure Add_hhagegr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhagegr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhagegr2_To_Orderings;


   procedure Add_hhagegrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhagegrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhagegrp_To_Orderings;


   procedure Add_hhcomp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhcomp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhcomp_To_Orderings;


   procedure Add_hhcomps_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhcomps", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhcomps_To_Orderings;


   procedure Add_hhdisben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhdisben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhdisben_To_Orderings;


   procedure Add_hhethgr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhethgr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhethgr2_To_Orderings;


   procedure Add_hhethgrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhethgrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhethgrp_To_Orderings;


   procedure Add_hhinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhinc_To_Orderings;


   procedure Add_hhincbnd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhincbnd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhincbnd_To_Orderings;


   procedure Add_hhinv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhinv", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhinv_To_Orderings;


   procedure Add_hhirben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhirben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhirben_To_Orderings;


   procedure Add_hhkids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhkids", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhkids_To_Orderings;


   procedure Add_hhnirben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhnirben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhnirben_To_Orderings;


   procedure Add_hhothben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhothben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhothben_To_Orderings;


   procedure Add_hhrent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhrent", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhrent_To_Orderings;


   procedure Add_hhrinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhrinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhrinc_To_Orderings;


   procedure Add_hhrpinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhrpinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhrpinc_To_Orderings;


   procedure Add_hhsize_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhsize", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhsize_To_Orderings;


   procedure Add_hhtvlic_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhtvlic", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhtvlic_To_Orderings;


   procedure Add_hhtxcred_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhtxcred", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhtxcred_To_Orderings;


   procedure Add_hothinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hothinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hothinc_To_Orderings;


   procedure Add_hpeninc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hpeninc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hpeninc_To_Orderings;


   procedure Add_hrband_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrband", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrband_To_Orderings;


   procedure Add_hseinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hseinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hseinc_To_Orderings;


   procedure Add_isacth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "isacth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_isacth_To_Orderings;


   procedure Add_london_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "london", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_london_To_Orderings;


   procedure Add_mortcost_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mortcost", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortcost_To_Orderings;


   procedure Add_mortint_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mortint", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortint_To_Orderings;


   procedure Add_mortpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mortpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mortpay_To_Orderings;


   procedure Add_nddctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nddctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nddctb_To_Orderings;


   procedure Add_nddishc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nddishc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nddishc_To_Orderings;


   procedure Add_nihscost_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nihscost", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nihscost_To_Orderings;


   procedure Add_nsbocth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nsbocth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nsbocth_To_Orderings;


   procedure Add_otbscth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "otbscth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_otbscth_To_Orderings;


   procedure Add_pacctype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pacctype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pacctype_To_Orderings;


   procedure Add_penage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penage", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penage_To_Orderings;


   procedure Add_penhrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penhrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penhrp_To_Orderings;


   procedure Add_pepscth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pepscth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pepscth_To_Orderings;


   procedure Add_poaccth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "poaccth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_poaccth_To_Orderings;


   procedure Add_prbocth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "prbocth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_prbocth_To_Orderings;


   procedure Add_ptentyp2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ptentyp2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ptentyp2_To_Orderings;


   procedure Add_sayecth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sayecth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sayecth_To_Orderings;


   procedure Add_sclbcth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sclbcth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sclbcth_To_Orderings;


   procedure Add_servpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "servpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_servpay_To_Orderings;


   procedure Add_sick_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sick", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sick_To_Orderings;


   procedure Add_sickhrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sickhrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sickhrp_To_Orderings;


   procedure Add_sscth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sscth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sscth_To_Orderings;


   procedure Add_struins_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "struins", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_struins_To_Orderings;


   procedure Add_stshcth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "stshcth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_stshcth_To_Orderings;


   procedure Add_tentyp2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tentyp2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tentyp2_To_Orderings;


   procedure Add_tesscth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tesscth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tesscth_To_Orderings;


   procedure Add_tuhhrent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tuhhrent", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tuhhrent_To_Orderings;


   procedure Add_tuwatsew_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tuwatsew", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tuwatsew_To_Orderings;


   procedure Add_untrcth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "untrcth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_untrcth_To_Orderings;


   procedure Add_watsewrt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "watsewrt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_watsewrt_To_Orderings;


   procedure Add_acornew_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "acornew", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_acornew_To_Orderings;


   procedure Add_crunach_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "crunach", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_crunach_To_Orderings;


   procedure Add_enomorth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "enomorth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_enomorth_To_Orderings;


   procedure Add_dvadulth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dvadulth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvadulth_To_Orderings;


   procedure Add_dvtotad_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dvtotad", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvtotad_To_Orderings;


   procedure Add_urindew_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "urindew", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_urindew_To_Orderings;


   procedure Add_urinds_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "urinds", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_urinds_To_Orderings;


   procedure Add_vehnumb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "vehnumb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_vehnumb_To_Orderings;


   procedure Add_country_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "country", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_country_To_Orderings;


   procedure Add_hbindhh2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbindhh2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbindhh2_To_Orderings;


   procedure Add_pocardh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pocardh", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pocardh_To_Orderings;


   procedure Add_entry5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "entry5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_entry5_To_Orderings;


   procedure Add_entry6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "entry6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_entry6_To_Orderings;


   procedure Add_imd_e_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "imd_e", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_imd_e_To_Orderings;


   procedure Add_imd_s_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "imd_s", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_imd_s_To_Orderings;


   procedure Add_imd_w_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "imd_w", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_imd_w_To_Orderings;


   procedure Add_numtv1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numtv1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numtv1_To_Orderings;


   procedure Add_numtv2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numtv2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numtv2_To_Orderings;


   procedure Add_oac_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oac", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oac_To_Orderings;


   procedure Add_bedroom6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bedroom6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bedroom6_To_Orderings;


   procedure Add_rooms10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rooms10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rooms10_To_Orderings;


   procedure Add_brma_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "brma", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_brma_To_Orderings;


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;


   procedure Add_migrq1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "migrq1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_migrq1_To_Orderings;


   procedure Add_migrq2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "migrq2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_migrq2_To_Orderings;


   procedure Add_hhagegr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhagegr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhagegr3_To_Orderings;


   procedure Add_hhagegr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhagegr4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhagegr4_To_Orderings;


   procedure Add_capval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "capval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_capval_To_Orderings;


   procedure Add_nidpnd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nidpnd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nidpnd_To_Orderings;


   procedure Add_nochcr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nochcr1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nochcr1_To_Orderings;


   procedure Add_nochcr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nochcr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nochcr2_To_Orderings;


   procedure Add_nochcr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nochcr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nochcr3_To_Orderings;


   procedure Add_nochcr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nochcr4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nochcr4_To_Orderings;


   procedure Add_nochcr5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nochcr5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nochcr5_To_Orderings;


   procedure Add_rt2rebam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rt2rebam", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rt2rebam_To_Orderings;


   procedure Add_rt2rebpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rt2rebpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rt2rebpd_To_Orderings;


   procedure Add_rtdpa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtdpa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtdpa_To_Orderings;


   procedure Add_rtdpaamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtdpaamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtdpaamt_To_Orderings;


   procedure Add_rtdpapd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtdpapd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtdpapd_To_Orderings;


   procedure Add_rtlpa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtlpa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtlpa_To_Orderings;


   procedure Add_rtlpaamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtlpaamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtlpaamt_To_Orderings;


   procedure Add_rtlpapd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtlpapd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtlpapd_To_Orderings;


   procedure Add_rtothamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtothamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtothamt_To_Orderings;


   procedure Add_rtother_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtother", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtother_To_Orderings;


   procedure Add_rtothpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtothpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtothpd_To_Orderings;


   procedure Add_rtrtr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtrtr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtrtr_To_Orderings;


   procedure Add_rtrtramt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtrtramt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtrtramt_To_Orderings;


   procedure Add_rtrtrpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtrtrpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtrtrpd_To_Orderings;


   procedure Add_rttimepd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rttimepd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rttimepd_To_Orderings;


   procedure Add_yrlvchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "yrlvchk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_yrlvchk_To_Orderings;


   procedure Add_gross3_x_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gross3_x", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross3_x_To_Orderings;


   procedure Add_hlthst_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlthst", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlthst_To_Orderings;


   procedure Add_medpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medpay_To_Orderings;


   procedure Add_medwho01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho01_To_Orderings;


   procedure Add_medwho02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho02_To_Orderings;


   procedure Add_medwho03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho03_To_Orderings;


   procedure Add_medwho04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho04_To_Orderings;


   procedure Add_medwho05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho05_To_Orderings;


   procedure Add_medwho06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho06_To_Orderings;


   procedure Add_medwho07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho07_To_Orderings;


   procedure Add_medwho08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho08_To_Orderings;


   procedure Add_medwho09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho09_To_Orderings;


   procedure Add_medwho10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho10_To_Orderings;


   procedure Add_medwho11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho11_To_Orderings;


   procedure Add_medwho12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho12_To_Orderings;


   procedure Add_medwho13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho13_To_Orderings;


   procedure Add_medwho14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medwho14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medwho14_To_Orderings;


   procedure Add_nmrmshar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nmrmshar", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nmrmshar_To_Orderings;


   procedure Add_roomshr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "roomshr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_roomshr_To_Orderings;


   procedure Add_imd_ni_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "imd_ni", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_imd_ni_To_Orderings;


   procedure Add_multi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "multi", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_multi_To_Orderings;


   procedure Add_nopay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nopay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nopay_To_Orderings;


   procedure Add_orgid_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "orgid", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_orgid_To_Orderings;


   procedure Add_rtene_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtene", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtene_To_Orderings;


   procedure Add_rteneamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rteneamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rteneamt_To_Orderings;


   procedure Add_rtgen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rtgen", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rtgen_To_Orderings;


   procedure Add_schbrk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "schbrk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_schbrk_To_Orderings;


   procedure Add_urb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "urb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_urb_To_Orderings;


   procedure Add_urbrur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "urbrur", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_urbrur_To_Orderings;


   procedure Add_hhethgr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hhethgr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hhethgr3_To_Orderings;


   procedure Add_niratlia_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "niratlia", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_niratlia_To_Orderings;


   procedure Add_bankse_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bankse", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bankse_To_Orderings;


   procedure Add_bathshow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bathshow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bathshow_To_Orderings;


   procedure Add_burden_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "burden", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_burden_To_Orderings;


   procedure Add_comco_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "comco", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_comco_To_Orderings;


   procedure Add_comp1sc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "comp1sc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_comp1sc_To_Orderings;


   procedure Add_compsc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "compsc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_compsc_To_Orderings;


   procedure Add_comwa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "comwa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_comwa_To_Orderings;


   procedure Add_dwellno_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dwellno", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dwellno_To_Orderings;


   procedure Add_elecin_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "elecin", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_elecin_To_Orderings;


   procedure Add_elecinw_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "elecinw", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_elecinw_To_Orderings;


   procedure Add_eulowest_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eulowest", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eulowest_To_Orderings;


   procedure Add_flshtoil_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "flshtoil", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_flshtoil_To_Orderings;


   procedure Add_grocse_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grocse", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grocse_To_Orderings;


   procedure Add_gvtregno_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gvtregno", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gvtregno_To_Orderings;


   procedure Add_heat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heat_To_Orderings;


   procedure Add_heatcen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heatcen", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatcen_To_Orderings;


   procedure Add_heatfire_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heatfire", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatfire_To_Orderings;


   procedure Add_kitchen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kitchen", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kitchen_To_Orderings;


   procedure Add_knsizeft_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "knsizeft", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_knsizeft_To_Orderings;


   procedure Add_knsizem_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "knsizem", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_knsizem_To_Orderings;


   procedure Add_laua_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "laua", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_laua_To_Orderings;


   procedure Add_movef_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "movef", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_movef_To_Orderings;


   procedure Add_movenxt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "movenxt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_movenxt_To_Orderings;


   procedure Add_movereas_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "movereas", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_movereas_To_Orderings;


   procedure Add_ovsat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ovsat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ovsat_To_Orderings;


   procedure Add_plum1bin_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "plum1bin", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_plum1bin_To_Orderings;


   procedure Add_plumin_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "plumin", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_plumin_To_Orderings;


   procedure Add_pluminw_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pluminw", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pluminw_To_Orderings;


   procedure Add_postse_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "postse", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_postse_To_Orderings;


   procedure Add_primh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "primh", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_primh_To_Orderings;


   procedure Add_pubtr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pubtr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pubtr_To_Orderings;


   procedure Add_samesc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "samesc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_samesc_To_Orderings;


   procedure Add_schfrt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "schfrt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_schfrt_To_Orderings;


   procedure Add_selper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "selper", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_selper_To_Orderings;


   procedure Add_short_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "short", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_short_To_Orderings;


   procedure Add_sizeft_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sizeft", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sizeft_To_Orderings;


   procedure Add_sizem_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sizem", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sizem_To_Orderings;


   procedure Add_tvwhy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tvwhy", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tvwhy_To_Orderings;


   procedure Add_yearwhc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "yearwhc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_yearwhc_To_Orderings;


   procedure Add_dischha1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dischha1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dischha1_To_Orderings;


   procedure Add_dischhc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dischhc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dischhc1_To_Orderings;


   procedure Add_diswhha1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "diswhha1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_diswhha1_To_Orderings;


   procedure Add_diswhhc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "diswhhc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_diswhhc1_To_Orderings;


   procedure Add_gross4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gross4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross4_To_Orderings;


   procedure Add_lldcare_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lldcare", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lldcare_To_Orderings;


   procedure Add_urindni_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "urindni", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_urindni_To_Orderings;


   procedure Add_nhbeninc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nhbeninc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhbeninc_To_Orderings;


   procedure Add_nhhnirbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nhhnirbn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhhnirbn_To_Orderings;


   procedure Add_nhhothbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nhhothbn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhhothbn_To_Orderings;


   procedure Add_seramt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seramt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seramt1_To_Orderings;


   procedure Add_seramt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seramt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seramt2_To_Orderings;


   procedure Add_seramt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seramt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seramt3_To_Orderings;


   procedure Add_seramt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seramt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seramt4_To_Orderings;


   procedure Add_serpay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serpay1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serpay1_To_Orderings;


   procedure Add_serpay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serpay2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serpay2_To_Orderings;


   procedure Add_serpay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serpay3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serpay3_To_Orderings;


   procedure Add_serpay4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serpay4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serpay4_To_Orderings;


   procedure Add_serper1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serper1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serper1_To_Orderings;


   procedure Add_serper2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serper2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serper2_To_Orderings;


   procedure Add_serper3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serper3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serper3_To_Orderings;


   procedure Add_serper4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serper4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serper4_To_Orderings;


   procedure Add_utility_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "utility", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_utility_To_Orderings;


   procedure Add_hheth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hheth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hheth_To_Orderings;


   procedure Add_seramt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seramt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seramt5_To_Orderings;


   procedure Add_sercomb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sercomb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sercomb_To_Orderings;


   procedure Add_serpay5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serpay5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serpay5_To_Orderings;


   procedure Add_serper5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "serper5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_serper5_To_Orderings;


   procedure Add_urbni_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "urbni", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_urbni_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Househol_IO;

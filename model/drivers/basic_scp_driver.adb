--
-- this stuff is just to force compilation - borrowed from auto test case.
--
with Ada.Calendar;
with Ada.Exceptions;
with Ada.Strings.Unbounded; 

with GNATColl.Traces;
with GNATCOLL.SQL.Exec;

with AUnit.Assertions;             
with AUnit.Test_Cases; 

with Base_Types;
with Environment;

with DB_Commons;
with Ukds;

with Connection_Pool;

with Ukds.Frs.Househol_IO;
with Ukds.Frs.Benunit_IO;
with Ukds.Frs.Adult_IO;
with Ukds.Frs.Child_IO;
with Ukds.Frs.Accounts_IO;
with Ukds.Frs.Accouts_IO;
with Ukds.Frs.Admin_IO;
with Ukds.Frs.Assets_IO;
with Ukds.Frs.Benefits_IO;
with Ukds.Frs.Care_IO;
with Ukds.Frs.Childcare_IO;
with Ukds.Frs.Chldcare_IO;
with Ukds.Frs.Endowmnt_IO;
with Ukds.Frs.Extchild_IO;
with Ukds.Frs.Govpay_IO;
with Ukds.Frs.Insuranc_IO;
with Ukds.Frs.Job_IO;
with Ukds.Frs.Maint_IO;
with Ukds.Frs.Mortcont_IO;
with Ukds.Frs.Mortgage_IO;
with Ukds.Frs.Nimigr_IO;
with Ukds.Frs.Nimigra_IO;
with Ukds.Frs.Oddjob_IO;
with Ukds.Frs.Owner_IO;
with Ukds.Frs.Penamt_IO;
with Ukds.Frs.Penprov_IO;
with Ukds.Frs.Pension_IO;
with Ukds.Frs.Pianom0809_IO;
with Ukds.Frs.Pianon0910_IO;
with Ukds.Frs.Pianon1011_IO;
with Ukds.Frs.Pianon1213_IO;
with Ukds.Frs.Pianon1314_IO;
with Ukds.Frs.Pianon1415_IO;
with Ukds.Frs.Pianon1516_IO;
with Ukds.Frs.Prscrptn_IO;
with Ukds.Frs.Rentcont_IO;
with Ukds.Frs.Renter_IO;
with Ukds.Frs.Transact_IO;
with Ukds.Frs.Vehicle_IO;
with Ukds.frs;

with Data_Constants;
with Base_Model_Types;
with Ada.Calendar;

with Ada.Text_IO;

procedure Basic_SCP_Driver is
   
   use Ada.Exceptions;
   use Ada.Calendar;
   use Ada.Text_IO;
   use UKDS.FRS;
   use GNATCOLL.SQL.Exec;
   package d renames DB_Commons;

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
         " from frs.househol ";
   
   
   stmt : constant String := SELECT_PART & " where year >= 2007 order by year,sernum";
   
   criteria  : d.Criteria;
   startTime : Time;
   endTime   : Time;
   elapsed   : Duration;
   cursor    : GNATCOLL.SQL.Exec.Forward_Cursor;
   hh        : Househol;
   ps        : GNATCOLL.SQL.Exec.Prepared_Statement;   
   conn      : Database_Connection;
   count     : Natural := 0;
begin
   startTime := Clock;
   Put_Line( "We're making a start on this.." );
   Put_Line( stmt );
   Connection_Pool.Initialise;
   conn := Connection_Pool.Lease;
   
   cursor.Fetch( conn, stmt ); -- "select * from frs.househol where year >= 2011 order by year,sernum" );
   while Has_Row( cursor ) loop 
      count := count + 1;
      hh := Househol_IO.Map_From_Cursor( cursor );
      Put_Line( "on year " & hh.year'Img & " sernum " & hh.sernum'Img );
      Next( cursor );
   end loop;
   endTime := Clock;
   elapsed := endTime - startTime;
   Put_Line( "Time Taken " & elapsed'Img & " secs " & count'Img & " hhlds " );
end Basic_SCP_Driver;
--
-- Created by ada_generator.py on 2017-09-06 17:20:42.721720
-- 


with Ada.Calendar;
with Ada.Exceptions;
with Ada.Strings.Unbounded; 

with GNATColl.Traces;

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

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds_Test is

   RECORDS_TO_ADD     : constant integer := 100;
   RECORDS_TO_DELETE  : constant integer := 50;
   RECORDS_TO_ALTER   : constant integer := 50;
   
   package d renames DB_Commons;
   
   use Base_Types;
   use ada.strings.Unbounded;
   use Ukds;
   use Data_Constants;
   use Base_Model_Types;
   use Ada.Calendar;

   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS_TEST" );
   
   procedure Log( s : String ) is
   begin
      GNATColl.Traces.Trace( log_trace, s );
   end Log;

   
      -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   use AUnit.Test_Cases;
   use AUnit.Assertions;
   use AUnit.Test_Cases.Registration;
   
   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Calendar;
   
   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Househol_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Househol_List_Package.Cursor ) is 
      a_househol_test_item : Ukds.Frs.Househol;
      begin
         a_househol_test_item := Ukds.Frs.Househol_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_househol_test_item ));
      end print;

   
      a_househol_test_item : Ukds.Frs.Househol;
      a_househol_test_list : Ukds.Frs.Househol_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Househol_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Househol_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Househol_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_househol_test_item.user_id := Ukds.Frs.Househol_IO.Next_Free_user_id;
         a_househol_test_item.edition := Ukds.Frs.Househol_IO.Next_Free_edition;
         a_househol_test_item.year := Ukds.Frs.Househol_IO.Next_Free_year;
         a_househol_test_item.sernum := Ukds.Frs.Househol_IO.Next_Free_sernum;
         -- missing declaration for a_househol_test_item.bathshow;
         -- missing declaration for a_househol_test_item.bedroom;
         -- missing declaration for a_househol_test_item.benunits;
         -- missing declaration for a_househol_test_item.billrate;
         -- missing declaration for a_househol_test_item.brma;
         -- missing declaration for a_househol_test_item.burden;
         -- missing declaration for a_househol_test_item.busroom;
         -- missing declaration for a_househol_test_item.capval;
         -- missing declaration for a_househol_test_item.charge1;
         -- missing declaration for a_househol_test_item.charge2;
         -- missing declaration for a_househol_test_item.charge3;
         -- missing declaration for a_househol_test_item.charge4;
         -- missing declaration for a_househol_test_item.charge5;
         -- missing declaration for a_househol_test_item.charge6;
         -- missing declaration for a_househol_test_item.charge7;
         -- missing declaration for a_househol_test_item.charge8;
         -- missing declaration for a_househol_test_item.charge9;
         -- missing declaration for a_househol_test_item.chins;
         a_househol_test_item.chrgamt1 := 1010100.012 + Amount( i );
         a_househol_test_item.chrgamt2 := 1010100.012 + Amount( i );
         a_househol_test_item.chrgamt3 := 1010100.012 + Amount( i );
         a_househol_test_item.chrgamt4 := 1010100.012 + Amount( i );
         a_househol_test_item.chrgamt5 := 1010100.012 + Amount( i );
         a_househol_test_item.chrgamt6 := 1010100.012 + Amount( i );
         a_househol_test_item.chrgamt7 := 1010100.012 + Amount( i );
         a_househol_test_item.chrgamt8 := 1010100.012 + Amount( i );
         a_househol_test_item.chrgamt9 := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.chrgpd1;
         -- missing declaration for a_househol_test_item.chrgpd2;
         -- missing declaration for a_househol_test_item.chrgpd3;
         -- missing declaration for a_househol_test_item.chrgpd4;
         -- missing declaration for a_househol_test_item.chrgpd5;
         -- missing declaration for a_househol_test_item.chrgpd6;
         -- missing declaration for a_househol_test_item.chrgpd7;
         -- missing declaration for a_househol_test_item.chrgpd8;
         -- missing declaration for a_househol_test_item.chrgpd9;
         -- missing declaration for a_househol_test_item.covoths;
         a_househol_test_item.csewamt := 1010100.012 + Amount( i );
         a_househol_test_item.csewamt1 := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.ct25d50d;
         -- missing declaration for a_househol_test_item.ctamt;
         a_househol_test_item.ctannual := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.ctband;
         -- missing declaration for a_househol_test_item.ctbwait;
         -- missing declaration for a_househol_test_item.ctcondoc;
         -- missing declaration for a_househol_test_item.ctdisc;
         -- missing declaration for a_househol_test_item.ctinstal;
         -- missing declaration for a_househol_test_item.ctlvband;
         -- missing declaration for a_househol_test_item.ctlvchk;
         -- missing declaration for a_househol_test_item.ctreb;
         -- missing declaration for a_househol_test_item.ctrebamt;
         -- missing declaration for a_househol_test_item.ctrebpd;
         -- missing declaration for a_househol_test_item.cttime;
         -- missing declaration for a_househol_test_item.cwatamt;
         -- missing declaration for a_househol_test_item.cwatamt1;
         a_househol_test_item.datyrago := Ada.Calendar.Clock;
         -- missing declaration for a_househol_test_item.dvadulth;
         -- missing declaration for a_househol_test_item.dvtotad;
         -- missing declaration for a_househol_test_item.dwellno;
         -- missing declaration for a_househol_test_item.entry1;
         -- missing declaration for a_househol_test_item.entry2;
         -- missing declaration for a_househol_test_item.entry3;
         -- missing declaration for a_househol_test_item.entry4;
         -- missing declaration for a_househol_test_item.entry5;
         -- missing declaration for a_househol_test_item.entry6;
         a_househol_test_item.eulowest := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.floor;
         -- missing declaration for a_househol_test_item.flshtoil;
         -- missing declaration for a_househol_test_item.givehelp;
         -- missing declaration for a_househol_test_item.gvtregn;
         -- missing declaration for a_househol_test_item.gvtregno;
         -- missing declaration for a_househol_test_item.hhldr01;
         -- missing declaration for a_househol_test_item.hhldr02;
         -- missing declaration for a_househol_test_item.hhldr03;
         -- missing declaration for a_househol_test_item.hhldr04;
         -- missing declaration for a_househol_test_item.hhldr05;
         -- missing declaration for a_househol_test_item.hhldr06;
         -- missing declaration for a_househol_test_item.hhldr07;
         -- missing declaration for a_househol_test_item.hhldr08;
         -- missing declaration for a_househol_test_item.hhldr09;
         -- missing declaration for a_househol_test_item.hhldr10;
         -- missing declaration for a_househol_test_item.hhldr11;
         -- missing declaration for a_househol_test_item.hhldr12;
         -- missing declaration for a_househol_test_item.hhldr13;
         -- missing declaration for a_househol_test_item.hhldr14;
         -- missing declaration for a_househol_test_item.hhldr97;
         -- missing declaration for a_househol_test_item.hhstat;
         -- missing declaration for a_househol_test_item.hlthst;
         -- missing declaration for a_househol_test_item.hrpnum;
         -- missing declaration for a_househol_test_item.imd_e;
         -- missing declaration for a_househol_test_item.imd_ni;
         -- missing declaration for a_househol_test_item.imd_s;
         -- missing declaration for a_househol_test_item.imd_w;
         a_househol_test_item.intdate := Ada.Calendar.Clock;
         -- missing declaration for a_househol_test_item.issue;
         -- missing declaration for a_househol_test_item.kitchen;
         -- missing declaration for a_househol_test_item.lac;
         -- missing declaration for a_househol_test_item.laua;
         -- missing declaration for a_househol_test_item.lldcare;
         -- missing declaration for a_househol_test_item.mainacc;
         -- missing declaration for a_househol_test_item.migrq1;
         -- missing declaration for a_househol_test_item.migrq2;
         -- missing declaration for a_househol_test_item.mnthcode;
         -- missing declaration for a_househol_test_item.monlive;
         -- missing declaration for a_househol_test_item.multi;
         -- missing declaration for a_househol_test_item.needhelp;
         -- missing declaration for a_househol_test_item.nicoun;
         -- missing declaration for a_househol_test_item.nidpnd;
         -- missing declaration for a_househol_test_item.nmrmshar;
         -- missing declaration for a_househol_test_item.nopay;
         -- missing declaration for a_househol_test_item.norate;
         -- missing declaration for a_househol_test_item.numtv1;
         -- missing declaration for a_househol_test_item.numtv2;
         -- missing declaration for a_househol_test_item.oac;
         -- missing declaration for a_househol_test_item.onbsroom;
         -- missing declaration for a_househol_test_item.orgid;
         -- missing declaration for a_househol_test_item.payrate;
         -- missing declaration for a_househol_test_item.ptbsroom;
         -- missing declaration for a_househol_test_item.rooms;
         -- missing declaration for a_househol_test_item.roomshr;
         a_househol_test_item.rt2rebam := 1010100.012 + Amount( i );
         a_househol_test_item.rtannual := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.rtcondoc;
         -- missing declaration for a_househol_test_item.rtdpa;
         a_househol_test_item.rtdpaamt := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.rtene;
         -- missing declaration for a_househol_test_item.rteneamt;
         -- missing declaration for a_househol_test_item.rtgen;
         -- missing declaration for a_househol_test_item.rtinstal;
         -- missing declaration for a_househol_test_item.rtlpa;
         a_househol_test_item.rtlpaamt := 1010100.012 + Amount( i );
         a_househol_test_item.rtothamt := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.rtother;
         -- missing declaration for a_househol_test_item.rtreb;
         a_househol_test_item.rtrebamt := 1010100.012 + Amount( i );
         a_househol_test_item.rtrtramt := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.rttimepd;
         -- missing declaration for a_househol_test_item.sampqtr;
         -- missing declaration for a_househol_test_item.schbrk;
         -- missing declaration for a_househol_test_item.schfrt;
         -- missing declaration for a_househol_test_item.schmeal;
         -- missing declaration for a_househol_test_item.schmilk;
         -- missing declaration for a_househol_test_item.selper;
         a_househol_test_item.sewamt := 1010100.012 + Amount( i );
         a_househol_test_item.sewanul := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.sewerpay;
         -- missing declaration for a_househol_test_item.sewsep;
         -- missing declaration for a_househol_test_item.sewtime;
         -- missing declaration for a_househol_test_item.shelter;
         -- missing declaration for a_househol_test_item.sobuy;
         -- missing declaration for a_househol_test_item.sstrtreg;
         a_househol_test_item.stramt1 := 1010100.012 + Amount( i );
         a_househol_test_item.stramt2 := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.strcov;
         -- missing declaration for a_househol_test_item.strmort;
         -- missing declaration for a_househol_test_item.stroths;
         -- missing declaration for a_househol_test_item.strpd1;
         -- missing declaration for a_househol_test_item.strpd2;
         -- missing declaration for a_househol_test_item.suballow;
         -- missing declaration for a_househol_test_item.sublet;
         -- missing declaration for a_househol_test_item.sublety;
         a_househol_test_item.subrent := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.tenure;
         -- missing declaration for a_househol_test_item.tvlic;
         -- missing declaration for a_househol_test_item.tvwhy;
         -- missing declaration for a_househol_test_item.typeacc;
         -- missing declaration for a_househol_test_item.urb;
         -- missing declaration for a_househol_test_item.urbrur;
         -- missing declaration for a_househol_test_item.urindew;
         -- missing declaration for a_househol_test_item.urindni;
         -- missing declaration for a_househol_test_item.urinds;
         a_househol_test_item.watamt := 1010100.012 + Amount( i );
         a_househol_test_item.watanul := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.watermet;
         -- missing declaration for a_househol_test_item.waterpay;
         -- missing declaration for a_househol_test_item.watrb;
         -- missing declaration for a_househol_test_item.wattime;
         -- missing declaration for a_househol_test_item.whoctb01;
         -- missing declaration for a_househol_test_item.whoctb02;
         -- missing declaration for a_househol_test_item.whoctb03;
         -- missing declaration for a_househol_test_item.whoctb04;
         -- missing declaration for a_househol_test_item.whoctb05;
         -- missing declaration for a_househol_test_item.whoctb06;
         -- missing declaration for a_househol_test_item.whoctb07;
         -- missing declaration for a_househol_test_item.whoctb08;
         -- missing declaration for a_househol_test_item.whoctb09;
         -- missing declaration for a_househol_test_item.whoctb10;
         -- missing declaration for a_househol_test_item.whoctb11;
         -- missing declaration for a_househol_test_item.whoctb12;
         -- missing declaration for a_househol_test_item.whoctb13;
         -- missing declaration for a_househol_test_item.whoctb14;
         -- missing declaration for a_househol_test_item.whoctbot;
         -- missing declaration for a_househol_test_item.whorsp01;
         -- missing declaration for a_househol_test_item.whorsp02;
         -- missing declaration for a_househol_test_item.whorsp03;
         -- missing declaration for a_househol_test_item.whorsp04;
         -- missing declaration for a_househol_test_item.whorsp05;
         -- missing declaration for a_househol_test_item.whorsp06;
         -- missing declaration for a_househol_test_item.whorsp07;
         -- missing declaration for a_househol_test_item.whorsp08;
         -- missing declaration for a_househol_test_item.whorsp09;
         -- missing declaration for a_househol_test_item.whorsp10;
         -- missing declaration for a_househol_test_item.whorsp11;
         -- missing declaration for a_househol_test_item.whorsp12;
         -- missing declaration for a_househol_test_item.whorsp13;
         -- missing declaration for a_househol_test_item.whorsp14;
         -- missing declaration for a_househol_test_item.whynoct;
         a_househol_test_item.wsewamt := 1010100.012 + Amount( i );
         a_househol_test_item.wsewanul := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.wsewtime;
         -- missing declaration for a_househol_test_item.yearcode;
         -- missing declaration for a_househol_test_item.yearlive;
         -- missing declaration for a_househol_test_item.yearwhc;
         -- missing declaration for a_househol_test_item.month;
         -- missing declaration for a_househol_test_item.adulth;
         -- missing declaration for a_househol_test_item.bedroom6;
         -- missing declaration for a_househol_test_item.country;
         -- missing declaration for a_househol_test_item.cwatamtd;
         -- missing declaration for a_househol_test_item.depchldh;
         -- missing declaration for a_househol_test_item.dischha1;
         -- missing declaration for a_househol_test_item.dischhc1;
         -- missing declaration for a_househol_test_item.diswhha1;
         -- missing declaration for a_househol_test_item.diswhhc1;
         -- missing declaration for a_househol_test_item.emp;
         -- missing declaration for a_househol_test_item.emphrp;
         a_househol_test_item.endowpay := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.gbhscost;
         -- missing declaration for a_househol_test_item.gross4;
         -- missing declaration for a_househol_test_item.grossct;
         -- missing declaration for a_househol_test_item.hbeninc;
         -- missing declaration for a_househol_test_item.hbindhh;
         -- missing declaration for a_househol_test_item.hbindhh2;
         -- missing declaration for a_househol_test_item.hdhhinc;
         -- missing declaration for a_househol_test_item.hdtax;
         a_househol_test_item.hearns := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.hhagegr2;
         -- missing declaration for a_househol_test_item.hhagegr3;
         -- missing declaration for a_househol_test_item.hhagegr4;
         -- missing declaration for a_househol_test_item.hhagegrp;
         -- missing declaration for a_househol_test_item.hhcomps;
         -- missing declaration for a_househol_test_item.hhdisben;
         -- missing declaration for a_househol_test_item.hhethgr3;
         -- missing declaration for a_househol_test_item.hhinc;
         -- missing declaration for a_househol_test_item.hhincbnd;
         a_househol_test_item.hhinv := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.hhirben;
         -- missing declaration for a_househol_test_item.hhnirben;
         -- missing declaration for a_househol_test_item.hhothben;
         -- missing declaration for a_househol_test_item.hhrent;
         a_househol_test_item.hhrinc := 1010100.012 + Amount( i );
         a_househol_test_item.hhrpinc := 1010100.012 + Amount( i );
         a_househol_test_item.hhtvlic := 1010100.012 + Amount( i );
         a_househol_test_item.hhtxcred := 1010100.012 + Amount( i );
         a_househol_test_item.hothinc := 1010100.012 + Amount( i );
         a_househol_test_item.hpeninc := 1010100.012 + Amount( i );
         a_househol_test_item.hseinc := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.london;
         a_househol_test_item.mortcost := 1010100.012 + Amount( i );
         a_househol_test_item.mortint := 1010100.012 + Amount( i );
         a_househol_test_item.mortpay := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.nhbeninc;
         -- missing declaration for a_househol_test_item.nhhnirbn;
         -- missing declaration for a_househol_test_item.nhhothbn;
         -- missing declaration for a_househol_test_item.nihscost;
         a_househol_test_item.niratlia := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.penage;
         -- missing declaration for a_househol_test_item.penhrp;
         -- missing declaration for a_househol_test_item.ptentyp2;
         -- missing declaration for a_househol_test_item.rooms10;
         a_househol_test_item.servpay := 1010100.012 + Amount( i );
         a_househol_test_item.struins := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.tentyp2;
         a_househol_test_item.tuhhrent := 1010100.012 + Amount( i );
         a_househol_test_item.tuwatsew := 1010100.012 + Amount( i );
         a_househol_test_item.watsewrt := 1010100.012 + Amount( i );
         a_househol_test_item.seramt1 := 1010100.012 + Amount( i );
         a_househol_test_item.seramt2 := 1010100.012 + Amount( i );
         a_househol_test_item.seramt3 := 1010100.012 + Amount( i );
         a_househol_test_item.seramt4 := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.serpay1;
         -- missing declaration for a_househol_test_item.serpay2;
         -- missing declaration for a_househol_test_item.serpay3;
         -- missing declaration for a_househol_test_item.serpay4;
         -- missing declaration for a_househol_test_item.serper1;
         -- missing declaration for a_househol_test_item.serper2;
         -- missing declaration for a_househol_test_item.serper3;
         -- missing declaration for a_househol_test_item.serper4;
         -- missing declaration for a_househol_test_item.utility;
         -- missing declaration for a_househol_test_item.hheth;
         a_househol_test_item.seramt5 := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.sercomb;
         -- missing declaration for a_househol_test_item.serpay5;
         -- missing declaration for a_househol_test_item.serper5;
         -- missing declaration for a_househol_test_item.urbni;
         -- missing declaration for a_househol_test_item.acorn;
         -- missing declaration for a_househol_test_item.centfuel;
         -- missing declaration for a_househol_test_item.centheat;
         -- missing declaration for a_househol_test_item.contv1;
         -- missing declaration for a_househol_test_item.contv2;
         a_househol_test_item.estrtann := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.gor;
         -- missing declaration for a_househol_test_item.modcon01;
         -- missing declaration for a_househol_test_item.modcon02;
         -- missing declaration for a_househol_test_item.modcon03;
         -- missing declaration for a_househol_test_item.modcon04;
         -- missing declaration for a_househol_test_item.modcon05;
         -- missing declaration for a_househol_test_item.modcon06;
         -- missing declaration for a_househol_test_item.modcon07;
         -- missing declaration for a_househol_test_item.modcon08;
         -- missing declaration for a_househol_test_item.modcon09;
         -- missing declaration for a_househol_test_item.modcon10;
         -- missing declaration for a_househol_test_item.modcon11;
         -- missing declaration for a_househol_test_item.modcon12;
         -- missing declaration for a_househol_test_item.modcon13;
         -- missing declaration for a_househol_test_item.modcon14;
         a_househol_test_item.ninrv := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.nirate;
         a_househol_test_item.orgsewam := 1010100.012 + Amount( i );
         a_househol_test_item.orgwatam := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.premium;
         -- missing declaration for a_househol_test_item.roomshar;
         a_househol_test_item.rtcheck := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.rtdeduc;
         -- missing declaration for a_househol_test_item.rtrebpd;
         -- missing declaration for a_househol_test_item.rttime;
         -- missing declaration for a_househol_test_item.totadult;
         -- missing declaration for a_househol_test_item.totchild;
         -- missing declaration for a_househol_test_item.totdepdk;
         -- missing declaration for a_househol_test_item.usevcl;
         -- missing declaration for a_househol_test_item.welfmilk;
         -- missing declaration for a_househol_test_item.whoctbns;
         -- missing declaration for a_househol_test_item.wmintro;
         -- missing declaration for a_househol_test_item.actacch;
         -- missing declaration for a_househol_test_item.adddahh;
         -- missing declaration for a_househol_test_item.basacth;
         -- missing declaration for a_househol_test_item.chddahh;
         -- missing declaration for a_househol_test_item.curacth;
         a_househol_test_item.equivahc := 1010100.012 + Amount( i );
         a_househol_test_item.equivbhc := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.fsbndcth;
         -- missing declaration for a_househol_test_item.gebacth;
         -- missing declaration for a_househol_test_item.giltcth;
         -- missing declaration for a_househol_test_item.gross2;
         -- missing declaration for a_househol_test_item.gross3;
         -- missing declaration for a_househol_test_item.hcband;
         -- missing declaration for a_househol_test_item.hhcomp;
         -- missing declaration for a_househol_test_item.hhethgr2;
         -- missing declaration for a_househol_test_item.hhethgrp;
         -- missing declaration for a_househol_test_item.hhkids;
         -- missing declaration for a_househol_test_item.hhsize;
         -- missing declaration for a_househol_test_item.hrband;
         -- missing declaration for a_househol_test_item.isacth;
         a_househol_test_item.nddctb := 1010100.012 + Amount( i );
         a_househol_test_item.nddishc := 1010100.012 + Amount( i );
         -- missing declaration for a_househol_test_item.nsbocth;
         -- missing declaration for a_househol_test_item.otbscth;
         -- missing declaration for a_househol_test_item.pacctype;
         -- missing declaration for a_househol_test_item.pepscth;
         -- missing declaration for a_househol_test_item.poaccth;
         -- missing declaration for a_househol_test_item.prbocth;
         -- missing declaration for a_househol_test_item.sayecth;
         -- missing declaration for a_househol_test_item.sclbcth;
         -- missing declaration for a_househol_test_item.sick;
         -- missing declaration for a_househol_test_item.sickhrp;
         -- missing declaration for a_househol_test_item.sscth;
         -- missing declaration for a_househol_test_item.stshcth;
         -- missing declaration for a_househol_test_item.tesscth;
         -- missing declaration for a_househol_test_item.untrcth;
         -- missing declaration for a_househol_test_item.acornew;
         -- missing declaration for a_househol_test_item.crunach;
         -- missing declaration for a_househol_test_item.enomorth;
         -- missing declaration for a_househol_test_item.vehnumb;
         -- missing declaration for a_househol_test_item.pocardh;
         -- missing declaration for a_househol_test_item.nochcr1;
         -- missing declaration for a_househol_test_item.nochcr2;
         -- missing declaration for a_househol_test_item.nochcr3;
         -- missing declaration for a_househol_test_item.nochcr4;
         -- missing declaration for a_househol_test_item.nochcr5;
         -- missing declaration for a_househol_test_item.rt2rebpd;
         -- missing declaration for a_househol_test_item.rtdpapd;
         -- missing declaration for a_househol_test_item.rtlpapd;
         -- missing declaration for a_househol_test_item.rtothpd;
         -- missing declaration for a_househol_test_item.rtrtr;
         -- missing declaration for a_househol_test_item.rtrtrpd;
         -- missing declaration for a_househol_test_item.yrlvchk;
         -- missing declaration for a_househol_test_item.gross3_x;
         -- missing declaration for a_househol_test_item.medpay;
         -- missing declaration for a_househol_test_item.medwho01;
         -- missing declaration for a_househol_test_item.medwho02;
         -- missing declaration for a_househol_test_item.medwho03;
         -- missing declaration for a_househol_test_item.medwho04;
         -- missing declaration for a_househol_test_item.medwho05;
         -- missing declaration for a_househol_test_item.medwho06;
         -- missing declaration for a_househol_test_item.medwho07;
         -- missing declaration for a_househol_test_item.medwho08;
         -- missing declaration for a_househol_test_item.medwho09;
         -- missing declaration for a_househol_test_item.medwho10;
         -- missing declaration for a_househol_test_item.medwho11;
         -- missing declaration for a_househol_test_item.medwho12;
         -- missing declaration for a_househol_test_item.medwho13;
         -- missing declaration for a_househol_test_item.medwho14;
         -- missing declaration for a_househol_test_item.bankse;
         -- missing declaration for a_househol_test_item.comco;
         -- missing declaration for a_househol_test_item.comp1sc;
         -- missing declaration for a_househol_test_item.compsc;
         -- missing declaration for a_househol_test_item.comwa;
         -- missing declaration for a_househol_test_item.elecin;
         -- missing declaration for a_househol_test_item.elecinw;
         -- missing declaration for a_househol_test_item.grocse;
         -- missing declaration for a_househol_test_item.heat;
         -- missing declaration for a_househol_test_item.heatcen;
         -- missing declaration for a_househol_test_item.heatfire;
         -- missing declaration for a_househol_test_item.knsizeft;
         -- missing declaration for a_househol_test_item.knsizem;
         -- missing declaration for a_househol_test_item.movef;
         -- missing declaration for a_househol_test_item.movenxt;
         -- missing declaration for a_househol_test_item.movereas;
         -- missing declaration for a_househol_test_item.ovsat;
         -- missing declaration for a_househol_test_item.plum1bin;
         -- missing declaration for a_househol_test_item.plumin;
         -- missing declaration for a_househol_test_item.pluminw;
         -- missing declaration for a_househol_test_item.postse;
         -- missing declaration for a_househol_test_item.primh;
         -- missing declaration for a_househol_test_item.pubtr;
         -- missing declaration for a_househol_test_item.samesc;
         -- missing declaration for a_househol_test_item.short;
         -- missing declaration for a_househol_test_item.sizeft;
         -- missing declaration for a_househol_test_item.sizem;
         Ukds.Frs.Househol_IO.Save( a_househol_test_item, False );         
      end loop;
      
      a_househol_test_list := Ukds.Frs.Househol_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Househol_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_househol_test_item := Ukds.Frs.Househol_List_Package.element( a_househol_test_list, i );
         Ukds.Frs.Househol_IO.Save( a_househol_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Househol_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_househol_test_item := Ukds.Frs.Househol_List_Package.element( a_househol_test_list, i );
         Ukds.Frs.Househol_IO.Delete( a_househol_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Househol_Create_Test: retrieve all records" );
      Ukds.Frs.Househol_List_Package.iterate( a_househol_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Househol_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Househol_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Househol_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Househol_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Benunit_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Benunit_List_Package.Cursor ) is 
      a_benunit_test_item : Ukds.Frs.Benunit;
      begin
         a_benunit_test_item := Ukds.Frs.Benunit_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_benunit_test_item ));
      end print;

   
      a_benunit_test_item : Ukds.Frs.Benunit;
      a_benunit_test_list : Ukds.Frs.Benunit_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Benunit_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Benunit_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Benunit_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_benunit_test_item.user_id := Ukds.Frs.Benunit_IO.Next_Free_user_id;
         a_benunit_test_item.edition := Ukds.Frs.Benunit_IO.Next_Free_edition;
         a_benunit_test_item.year := Ukds.Frs.Benunit_IO.Next_Free_year;
         a_benunit_test_item.sernum := Ukds.Frs.Benunit_IO.Next_Free_sernum;
         a_benunit_test_item.benunit := Ukds.Frs.Benunit_IO.Next_Free_benunit;
         -- missing declaration for a_benunit_test_item.adbtbl;
         -- missing declaration for a_benunit_test_item.adddec;
         -- missing declaration for a_benunit_test_item.addhol;
         -- missing declaration for a_benunit_test_item.addholr;
         -- missing declaration for a_benunit_test_item.addins;
         -- missing declaration for a_benunit_test_item.addmon;
         -- missing declaration for a_benunit_test_item.adepfur;
         -- missing declaration for a_benunit_test_item.adles;
         -- missing declaration for a_benunit_test_item.adlesnt1;
         -- missing declaration for a_benunit_test_item.adlesnt2;
         -- missing declaration for a_benunit_test_item.adlesnt3;
         -- missing declaration for a_benunit_test_item.adlesnt4;
         -- missing declaration for a_benunit_test_item.adlesnt5;
         -- missing declaration for a_benunit_test_item.adlesnt6;
         -- missing declaration for a_benunit_test_item.adlesnt7;
         -- missing declaration for a_benunit_test_item.adlesnt8;
         -- missing declaration for a_benunit_test_item.adlesoa;
         -- missing declaration for a_benunit_test_item.af1;
         -- missing declaration for a_benunit_test_item.afdep2;
         -- missing declaration for a_benunit_test_item.billnt1;
         -- missing declaration for a_benunit_test_item.billnt2;
         -- missing declaration for a_benunit_test_item.billnt3;
         -- missing declaration for a_benunit_test_item.billnt4;
         -- missing declaration for a_benunit_test_item.billnt5;
         -- missing declaration for a_benunit_test_item.billnt6;
         -- missing declaration for a_benunit_test_item.billnt7;
         -- missing declaration for a_benunit_test_item.billnt8;
         -- missing declaration for a_benunit_test_item.billnt9;
         -- missing declaration for a_benunit_test_item.cdelply;
         -- missing declaration for a_benunit_test_item.cdepact;
         -- missing declaration for a_benunit_test_item.cdepbed;
         -- missing declaration for a_benunit_test_item.cdepcel;
         -- missing declaration for a_benunit_test_item.cdepeqp;
         -- missing declaration for a_benunit_test_item.cdephol;
         -- missing declaration for a_benunit_test_item.cdeples;
         -- missing declaration for a_benunit_test_item.cdeptea;
         -- missing declaration for a_benunit_test_item.cdeptrp;
         -- missing declaration for a_benunit_test_item.cdepveg;
         -- missing declaration for a_benunit_test_item.cdpcoat;
         -- missing declaration for a_benunit_test_item.clothes;
         -- missing declaration for a_benunit_test_item.clothnt1;
         -- missing declaration for a_benunit_test_item.clothnt2;
         -- missing declaration for a_benunit_test_item.clothnt3;
         -- missing declaration for a_benunit_test_item.clothnt4;
         -- missing declaration for a_benunit_test_item.clothnt5;
         -- missing declaration for a_benunit_test_item.clothnt6;
         -- missing declaration for a_benunit_test_item.clothnt7;
         -- missing declaration for a_benunit_test_item.clothnt8;
         -- missing declaration for a_benunit_test_item.clothsoa;
         -- missing declaration for a_benunit_test_item.coatnt1;
         -- missing declaration for a_benunit_test_item.coatnt2;
         -- missing declaration for a_benunit_test_item.coatnt3;
         -- missing declaration for a_benunit_test_item.coatnt4;
         -- missing declaration for a_benunit_test_item.coatnt5;
         -- missing declaration for a_benunit_test_item.coatnt6;
         -- missing declaration for a_benunit_test_item.coatnt7;
         -- missing declaration for a_benunit_test_item.coatnt8;
         -- missing declaration for a_benunit_test_item.coatnt9;
         -- missing declaration for a_benunit_test_item.computer;
         -- missing declaration for a_benunit_test_item.compuwhy;
         -- missing declaration for a_benunit_test_item.cooknt1;
         -- missing declaration for a_benunit_test_item.cooknt2;
         -- missing declaration for a_benunit_test_item.cooknt3;
         -- missing declaration for a_benunit_test_item.cooknt4;
         -- missing declaration for a_benunit_test_item.cooknt5;
         -- missing declaration for a_benunit_test_item.cooknt6;
         -- missing declaration for a_benunit_test_item.cooknt7;
         -- missing declaration for a_benunit_test_item.cooknt8;
         -- missing declaration for a_benunit_test_item.cooknt9;
         -- missing declaration for a_benunit_test_item.cplay;
         -- missing declaration for a_benunit_test_item.crime;
         -- missing declaration for a_benunit_test_item.damp;
         -- missing declaration for a_benunit_test_item.dampnt1;
         -- missing declaration for a_benunit_test_item.dampnt2;
         -- missing declaration for a_benunit_test_item.dampnt3;
         -- missing declaration for a_benunit_test_item.dampnt4;
         -- missing declaration for a_benunit_test_item.dampnt5;
         -- missing declaration for a_benunit_test_item.dampnt6;
         -- missing declaration for a_benunit_test_item.dampnt7;
         -- missing declaration for a_benunit_test_item.dampnt8;
         -- missing declaration for a_benunit_test_item.dampnt9;
         -- missing declaration for a_benunit_test_item.dark;
         -- missing declaration for a_benunit_test_item.debt01;
         -- missing declaration for a_benunit_test_item.debt02;
         -- missing declaration for a_benunit_test_item.debt03;
         -- missing declaration for a_benunit_test_item.debt04;
         -- missing declaration for a_benunit_test_item.debt05;
         -- missing declaration for a_benunit_test_item.debt06;
         -- missing declaration for a_benunit_test_item.debt07;
         -- missing declaration for a_benunit_test_item.debt08;
         -- missing declaration for a_benunit_test_item.debt09;
         -- missing declaration for a_benunit_test_item.debt10;
         -- missing declaration for a_benunit_test_item.debt11;
         -- missing declaration for a_benunit_test_item.debt12;
         -- missing declaration for a_benunit_test_item.debtar01;
         -- missing declaration for a_benunit_test_item.debtar02;
         -- missing declaration for a_benunit_test_item.debtar03;
         -- missing declaration for a_benunit_test_item.debtar04;
         -- missing declaration for a_benunit_test_item.debtar05;
         -- missing declaration for a_benunit_test_item.debtar06;
         -- missing declaration for a_benunit_test_item.debtar07;
         -- missing declaration for a_benunit_test_item.debtar08;
         -- missing declaration for a_benunit_test_item.debtar09;
         -- missing declaration for a_benunit_test_item.debtar10;
         -- missing declaration for a_benunit_test_item.debtar11;
         -- missing declaration for a_benunit_test_item.debtar12;
         -- missing declaration for a_benunit_test_item.debtfre1;
         -- missing declaration for a_benunit_test_item.debtfre2;
         -- missing declaration for a_benunit_test_item.debtfre3;
         -- missing declaration for a_benunit_test_item.endsmeet;
         -- missing declaration for a_benunit_test_item.eucar;
         -- missing declaration for a_benunit_test_item.eucarwhy;
         -- missing declaration for a_benunit_test_item.euexpns;
         -- missing declaration for a_benunit_test_item.eumeal;
         -- missing declaration for a_benunit_test_item.eurepay;
         -- missing declaration for a_benunit_test_item.euteleph;
         -- missing declaration for a_benunit_test_item.eutelwhy;
         -- missing declaration for a_benunit_test_item.expnsoa;
         -- missing declaration for a_benunit_test_item.frndnt1;
         -- missing declaration for a_benunit_test_item.frndnt2;
         -- missing declaration for a_benunit_test_item.frndnt3;
         -- missing declaration for a_benunit_test_item.frndnt4;
         -- missing declaration for a_benunit_test_item.frndnt5;
         -- missing declaration for a_benunit_test_item.frndnt6;
         -- missing declaration for a_benunit_test_item.frndnt7;
         -- missing declaration for a_benunit_test_item.frndnt8;
         -- missing declaration for a_benunit_test_item.frndnt9;
         -- missing declaration for a_benunit_test_item.furnt1;
         -- missing declaration for a_benunit_test_item.furnt2;
         -- missing declaration for a_benunit_test_item.furnt3;
         -- missing declaration for a_benunit_test_item.furnt4;
         -- missing declaration for a_benunit_test_item.furnt5;
         -- missing declaration for a_benunit_test_item.furnt6;
         -- missing declaration for a_benunit_test_item.furnt7;
         -- missing declaration for a_benunit_test_item.furnt8;
         -- missing declaration for a_benunit_test_item.hairnt1;
         -- missing declaration for a_benunit_test_item.hairnt2;
         -- missing declaration for a_benunit_test_item.hairnt3;
         -- missing declaration for a_benunit_test_item.hairnt4;
         -- missing declaration for a_benunit_test_item.hairnt5;
         -- missing declaration for a_benunit_test_item.hairnt6;
         -- missing declaration for a_benunit_test_item.hairnt7;
         -- missing declaration for a_benunit_test_item.hairnt8;
         -- missing declaration for a_benunit_test_item.hairnt9;
         -- missing declaration for a_benunit_test_item.hbolng;
         a_benunit_test_item.hbothamt := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.hbothbu;
         -- missing declaration for a_benunit_test_item.hbothmn;
         -- missing declaration for a_benunit_test_item.hbothpd;
         -- missing declaration for a_benunit_test_item.hbothwk;
         -- missing declaration for a_benunit_test_item.hbothyr;
         -- missing declaration for a_benunit_test_item.hbotwait;
         -- missing declaration for a_benunit_test_item.heatnt1;
         -- missing declaration for a_benunit_test_item.heatnt2;
         -- missing declaration for a_benunit_test_item.heatnt3;
         -- missing declaration for a_benunit_test_item.heatnt4;
         -- missing declaration for a_benunit_test_item.heatnt5;
         -- missing declaration for a_benunit_test_item.heatnt6;
         -- missing declaration for a_benunit_test_item.heatnt7;
         -- missing declaration for a_benunit_test_item.heatnt8;
         -- missing declaration for a_benunit_test_item.heatnt9;
         -- missing declaration for a_benunit_test_item.holnt1;
         -- missing declaration for a_benunit_test_item.holnt2;
         -- missing declaration for a_benunit_test_item.holnt3;
         -- missing declaration for a_benunit_test_item.holnt4;
         -- missing declaration for a_benunit_test_item.holnt5;
         -- missing declaration for a_benunit_test_item.holnt6;
         -- missing declaration for a_benunit_test_item.holnt7;
         -- missing declaration for a_benunit_test_item.holnt8;
         -- missing declaration for a_benunit_test_item.holnt9;
         -- missing declaration for a_benunit_test_item.homent1;
         -- missing declaration for a_benunit_test_item.homent2;
         -- missing declaration for a_benunit_test_item.homent3;
         -- missing declaration for a_benunit_test_item.homent4;
         -- missing declaration for a_benunit_test_item.homent5;
         -- missing declaration for a_benunit_test_item.homent6;
         -- missing declaration for a_benunit_test_item.homent7;
         -- missing declaration for a_benunit_test_item.homent8;
         -- missing declaration for a_benunit_test_item.homent9;
         -- missing declaration for a_benunit_test_item.houshe1;
         -- missing declaration for a_benunit_test_item.houshew;
         -- missing declaration for a_benunit_test_item.intntnt1;
         -- missing declaration for a_benunit_test_item.intntnt2;
         -- missing declaration for a_benunit_test_item.intntnt3;
         -- missing declaration for a_benunit_test_item.intntnt4;
         -- missing declaration for a_benunit_test_item.intntnt5;
         -- missing declaration for a_benunit_test_item.intntnt6;
         -- missing declaration for a_benunit_test_item.intntnt7;
         -- missing declaration for a_benunit_test_item.intntnt8;
         -- missing declaration for a_benunit_test_item.intrnet;
         -- missing declaration for a_benunit_test_item.issue;
         -- missing declaration for a_benunit_test_item.kidinc;
         -- missing declaration for a_benunit_test_item.meal;
         -- missing declaration for a_benunit_test_item.mealnt1;
         -- missing declaration for a_benunit_test_item.mealnt2;
         -- missing declaration for a_benunit_test_item.mealnt3;
         -- missing declaration for a_benunit_test_item.mealnt4;
         -- missing declaration for a_benunit_test_item.mealnt5;
         -- missing declaration for a_benunit_test_item.mealnt6;
         -- missing declaration for a_benunit_test_item.mealnt7;
         -- missing declaration for a_benunit_test_item.mealnt8;
         -- missing declaration for a_benunit_test_item.mealnt9;
         -- missing declaration for a_benunit_test_item.nhhchild;
         -- missing declaration for a_benunit_test_item.noise;
         -- missing declaration for a_benunit_test_item.oabill;
         -- missing declaration for a_benunit_test_item.oacareu1;
         -- missing declaration for a_benunit_test_item.oacareu2;
         -- missing declaration for a_benunit_test_item.oacareu3;
         -- missing declaration for a_benunit_test_item.oacareu4;
         -- missing declaration for a_benunit_test_item.oacareu5;
         -- missing declaration for a_benunit_test_item.oacareu6;
         -- missing declaration for a_benunit_test_item.oacareu7;
         -- missing declaration for a_benunit_test_item.oacareu8;
         -- missing declaration for a_benunit_test_item.oacoat;
         -- missing declaration for a_benunit_test_item.oacook;
         -- missing declaration for a_benunit_test_item.oadamp;
         -- missing declaration for a_benunit_test_item.oadep2;
         -- missing declaration for a_benunit_test_item.oadp2nt1;
         -- missing declaration for a_benunit_test_item.oadp2nt2;
         -- missing declaration for a_benunit_test_item.oadp2nt3;
         -- missing declaration for a_benunit_test_item.oadp2nt4;
         -- missing declaration for a_benunit_test_item.oadp2nt5;
         -- missing declaration for a_benunit_test_item.oadp2nt6;
         -- missing declaration for a_benunit_test_item.oadp2nt7;
         -- missing declaration for a_benunit_test_item.oadp2nt8;
         -- missing declaration for a_benunit_test_item.oaexpns;
         -- missing declaration for a_benunit_test_item.oafrnd;
         -- missing declaration for a_benunit_test_item.oafur;
         -- missing declaration for a_benunit_test_item.oahair;
         -- missing declaration for a_benunit_test_item.oaheat;
         -- missing declaration for a_benunit_test_item.oahol;
         -- missing declaration for a_benunit_test_item.oahome;
         -- missing declaration for a_benunit_test_item.oahowpy1;
         -- missing declaration for a_benunit_test_item.oahowpy2;
         -- missing declaration for a_benunit_test_item.oahowpy3;
         -- missing declaration for a_benunit_test_item.oahowpy4;
         -- missing declaration for a_benunit_test_item.oahowpy5;
         -- missing declaration for a_benunit_test_item.oahowpy6;
         -- missing declaration for a_benunit_test_item.oaintern;
         -- missing declaration for a_benunit_test_item.oameal;
         -- missing declaration for a_benunit_test_item.oaout;
         -- missing declaration for a_benunit_test_item.oaphon;
         -- missing declaration for a_benunit_test_item.oapre;
         -- missing declaration for a_benunit_test_item.oataxi;
         -- missing declaration for a_benunit_test_item.oataxieu;
         -- missing declaration for a_benunit_test_item.oatelep1;
         -- missing declaration for a_benunit_test_item.oatelep2;
         -- missing declaration for a_benunit_test_item.oatelep3;
         -- missing declaration for a_benunit_test_item.oatelep4;
         -- missing declaration for a_benunit_test_item.oatelep5;
         -- missing declaration for a_benunit_test_item.oatelep6;
         -- missing declaration for a_benunit_test_item.oatelep7;
         -- missing declaration for a_benunit_test_item.oatelep8;
         -- missing declaration for a_benunit_test_item.oateleph;
         -- missing declaration for a_benunit_test_item.oawarm;
         -- missing declaration for a_benunit_test_item.outnt1;
         -- missing declaration for a_benunit_test_item.outnt2;
         -- missing declaration for a_benunit_test_item.outnt3;
         -- missing declaration for a_benunit_test_item.outnt4;
         -- missing declaration for a_benunit_test_item.outnt5;
         -- missing declaration for a_benunit_test_item.outnt6;
         -- missing declaration for a_benunit_test_item.outnt7;
         -- missing declaration for a_benunit_test_item.outnt8;
         -- missing declaration for a_benunit_test_item.outnt9;
         -- missing declaration for a_benunit_test_item.outpay;
         a_benunit_test_item.outpyamt := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.phonnt1;
         -- missing declaration for a_benunit_test_item.phonnt2;
         -- missing declaration for a_benunit_test_item.phonnt3;
         -- missing declaration for a_benunit_test_item.phonnt4;
         -- missing declaration for a_benunit_test_item.phonnt5;
         -- missing declaration for a_benunit_test_item.phonnt6;
         -- missing declaration for a_benunit_test_item.phonnt7;
         -- missing declaration for a_benunit_test_item.phonnt8;
         -- missing declaration for a_benunit_test_item.phonnt9;
         -- missing declaration for a_benunit_test_item.pollute;
         a_benunit_test_item.regpamt := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.regularp;
         -- missing declaration for a_benunit_test_item.repaybur;
         -- missing declaration for a_benunit_test_item.shoe;
         -- missing declaration for a_benunit_test_item.shoent1;
         -- missing declaration for a_benunit_test_item.shoent2;
         -- missing declaration for a_benunit_test_item.shoent3;
         -- missing declaration for a_benunit_test_item.shoent4;
         -- missing declaration for a_benunit_test_item.shoent5;
         -- missing declaration for a_benunit_test_item.shoent6;
         -- missing declaration for a_benunit_test_item.shoent7;
         -- missing declaration for a_benunit_test_item.shoent8;
         -- missing declaration for a_benunit_test_item.shoeoa;
         -- missing declaration for a_benunit_test_item.taxint1;
         -- missing declaration for a_benunit_test_item.taxint2;
         -- missing declaration for a_benunit_test_item.taxint3;
         -- missing declaration for a_benunit_test_item.taxint4;
         -- missing declaration for a_benunit_test_item.taxint5;
         -- missing declaration for a_benunit_test_item.taxint6;
         -- missing declaration for a_benunit_test_item.taxint7;
         -- missing declaration for a_benunit_test_item.taxint8;
         -- missing declaration for a_benunit_test_item.taxint9;
         -- missing declaration for a_benunit_test_item.totsav;
         -- missing declaration for a_benunit_test_item.warmnt1;
         -- missing declaration for a_benunit_test_item.warmnt2;
         -- missing declaration for a_benunit_test_item.warmnt3;
         -- missing declaration for a_benunit_test_item.warmnt4;
         -- missing declaration for a_benunit_test_item.warmnt5;
         -- missing declaration for a_benunit_test_item.warmnt6;
         -- missing declaration for a_benunit_test_item.warmnt7;
         -- missing declaration for a_benunit_test_item.warmnt8;
         -- missing declaration for a_benunit_test_item.warmnt9;
         -- missing declaration for a_benunit_test_item.washmach;
         -- missing declaration for a_benunit_test_item.washwhy;
         -- missing declaration for a_benunit_test_item.whodepq;
         -- missing declaration for a_benunit_test_item.month;
         -- missing declaration for a_benunit_test_item.adultb;
         a_benunit_test_item.boarder := 1010100.012 + Amount( i );
         a_benunit_test_item.bpeninc := 1010100.012 + Amount( i );
         a_benunit_test_item.bseinc := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.buagegr2;
         -- missing declaration for a_benunit_test_item.buagegr3;
         -- missing declaration for a_benunit_test_item.buagegr4;
         -- missing declaration for a_benunit_test_item.buagegrp;
         -- missing declaration for a_benunit_test_item.budisben;
         a_benunit_test_item.buearns := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.buethgr3;
         -- missing declaration for a_benunit_test_item.buinc;
         a_benunit_test_item.buinv := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.buirben;
         -- missing declaration for a_benunit_test_item.bukids;
         -- missing declaration for a_benunit_test_item.bunirben;
         -- missing declaration for a_benunit_test_item.buothben;
         -- missing declaration for a_benunit_test_item.burent;
         a_benunit_test_item.burinc := 1010100.012 + Amount( i );
         a_benunit_test_item.burpinc := 1010100.012 + Amount( i );
         a_benunit_test_item.butvlic := 1010100.012 + Amount( i );
         a_benunit_test_item.butxcred := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.depchldb;
         -- missing declaration for a_benunit_test_item.discbua1;
         -- missing declaration for a_benunit_test_item.discbuc1;
         -- missing declaration for a_benunit_test_item.diswbua1;
         -- missing declaration for a_benunit_test_item.diswbuc1;
         -- missing declaration for a_benunit_test_item.ecostabu;
         -- missing declaration for a_benunit_test_item.ecstatbu;
         -- missing declaration for a_benunit_test_item.famtypb2;
         -- missing declaration for a_benunit_test_item.famtypbs;
         -- missing declaration for a_benunit_test_item.famtypbu;
         a_benunit_test_item.fsbbu := 1010100.012 + Amount( i );
         a_benunit_test_item.fsfvbu := 1010100.012 + Amount( i );
         a_benunit_test_item.fsmbu := 1010100.012 + Amount( i );
         a_benunit_test_item.fsmlkbu := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.gross4;
         -- missing declaration for a_benunit_test_item.hbindbu;
         -- missing declaration for a_benunit_test_item.hbindbu2;
         a_benunit_test_item.heartbu := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.kid04;
         -- missing declaration for a_benunit_test_item.kid1115;
         -- missing declaration for a_benunit_test_item.kid1619;
         -- missing declaration for a_benunit_test_item.kid510;
         a_benunit_test_item.lodger := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.nbunirbn;
         -- missing declaration for a_benunit_test_item.nbuothbn;
         -- missing declaration for a_benunit_test_item.newfamb2;
         -- missing declaration for a_benunit_test_item.newfambu;
         a_benunit_test_item.subltamt := 1010100.012 + Amount( i );
         a_benunit_test_item.totcapb3 := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.totsavbu;
         a_benunit_test_item.tuburent := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.youngch;
         -- missing declaration for a_benunit_test_item.debt13;
         -- missing declaration for a_benunit_test_item.debtar13;
         -- missing declaration for a_benunit_test_item.euchbook;
         -- missing declaration for a_benunit_test_item.euchclth;
         -- missing declaration for a_benunit_test_item.euchgame;
         -- missing declaration for a_benunit_test_item.euchmeat;
         -- missing declaration for a_benunit_test_item.euchshoe;
         -- missing declaration for a_benunit_test_item.eupbtran;
         -- missing declaration for a_benunit_test_item.eupbtrn1;
         -- missing declaration for a_benunit_test_item.eupbtrn2;
         -- missing declaration for a_benunit_test_item.eupbtrn3;
         -- missing declaration for a_benunit_test_item.eupbtrn4;
         -- missing declaration for a_benunit_test_item.eupbtrn5;
         -- missing declaration for a_benunit_test_item.euroast;
         -- missing declaration for a_benunit_test_item.eusmeal;
         -- missing declaration for a_benunit_test_item.eustudy;
         -- missing declaration for a_benunit_test_item.bueth;
         -- missing declaration for a_benunit_test_item.oaeusmea;
         -- missing declaration for a_benunit_test_item.oaholb;
         -- missing declaration for a_benunit_test_item.oaroast;
         -- missing declaration for a_benunit_test_item.ecostab2;
         -- missing declaration for a_benunit_test_item.incchnge;
         -- missing declaration for a_benunit_test_item.inchilow;
         -- missing declaration for a_benunit_test_item.actaccb;
         -- missing declaration for a_benunit_test_item.adddabu;
         -- missing declaration for a_benunit_test_item.basactb;
         -- missing declaration for a_benunit_test_item.buethgr2;
         -- missing declaration for a_benunit_test_item.buethgrp;
         -- missing declaration for a_benunit_test_item.chddabu;
         -- missing declaration for a_benunit_test_item.curactb;
         -- missing declaration for a_benunit_test_item.depdeds;
         -- missing declaration for a_benunit_test_item.disindhb;
         -- missing declaration for a_benunit_test_item.ecotypbu;
         -- missing declaration for a_benunit_test_item.famthbai;
         -- missing declaration for a_benunit_test_item.famtype;
         -- missing declaration for a_benunit_test_item.fsbndctb;
         a_benunit_test_item.fwmlkbu := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.gebactb;
         -- missing declaration for a_benunit_test_item.giltctb;
         -- missing declaration for a_benunit_test_item.gross2;
         -- missing declaration for a_benunit_test_item.gross3;
         -- missing declaration for a_benunit_test_item.isactb;
         -- missing declaration for a_benunit_test_item.kid1618;
         -- missing declaration for a_benunit_test_item.kidsbu0;
         -- missing declaration for a_benunit_test_item.kidsbu1;
         -- missing declaration for a_benunit_test_item.kidsbu10;
         -- missing declaration for a_benunit_test_item.kidsbu11;
         -- missing declaration for a_benunit_test_item.kidsbu12;
         -- missing declaration for a_benunit_test_item.kidsbu13;
         -- missing declaration for a_benunit_test_item.kidsbu14;
         -- missing declaration for a_benunit_test_item.kidsbu15;
         -- missing declaration for a_benunit_test_item.kidsbu16;
         -- missing declaration for a_benunit_test_item.kidsbu17;
         -- missing declaration for a_benunit_test_item.kidsbu18;
         -- missing declaration for a_benunit_test_item.kidsbu2;
         -- missing declaration for a_benunit_test_item.kidsbu3;
         -- missing declaration for a_benunit_test_item.kidsbu4;
         -- missing declaration for a_benunit_test_item.kidsbu5;
         -- missing declaration for a_benunit_test_item.kidsbu6;
         -- missing declaration for a_benunit_test_item.kidsbu7;
         -- missing declaration for a_benunit_test_item.kidsbu8;
         -- missing declaration for a_benunit_test_item.kidsbu9;
         -- missing declaration for a_benunit_test_item.lastwork;
         -- missing declaration for a_benunit_test_item.nsboctb;
         -- missing declaration for a_benunit_test_item.otbsctb;
         -- missing declaration for a_benunit_test_item.pepsctb;
         -- missing declaration for a_benunit_test_item.poacctb;
         -- missing declaration for a_benunit_test_item.prboctb;
         -- missing declaration for a_benunit_test_item.sayectb;
         -- missing declaration for a_benunit_test_item.sclbctb;
         -- missing declaration for a_benunit_test_item.ssctb;
         -- missing declaration for a_benunit_test_item.stshctb;
         -- missing declaration for a_benunit_test_item.tessctb;
         a_benunit_test_item.totcapbu := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.untrctb;
         -- missing declaration for a_benunit_test_item.addeples;
         -- missing declaration for a_benunit_test_item.addmel;
         -- missing declaration for a_benunit_test_item.addshoe;
         -- missing declaration for a_benunit_test_item.cdepsum;
         -- missing declaration for a_benunit_test_item.debt1;
         -- missing declaration for a_benunit_test_item.debt2;
         -- missing declaration for a_benunit_test_item.debt3;
         -- missing declaration for a_benunit_test_item.debt4;
         -- missing declaration for a_benunit_test_item.debt5;
         -- missing declaration for a_benunit_test_item.debt6;
         -- missing declaration for a_benunit_test_item.debt7;
         -- missing declaration for a_benunit_test_item.debt8;
         -- missing declaration for a_benunit_test_item.debt9;
         -- missing declaration for a_benunit_test_item.incold;
         -- missing declaration for a_benunit_test_item.crunacb;
         -- missing declaration for a_benunit_test_item.enomortb;
         -- missing declaration for a_benunit_test_item.pocardb;
         a_benunit_test_item.totcapb2 := 1010100.012 + Amount( i );
         -- missing declaration for a_benunit_test_item.cbaamt1;
         -- missing declaration for a_benunit_test_item.cbaamt2;
         -- missing declaration for a_benunit_test_item.helpgv01;
         -- missing declaration for a_benunit_test_item.helpgv02;
         -- missing declaration for a_benunit_test_item.helpgv03;
         -- missing declaration for a_benunit_test_item.helpgv04;
         -- missing declaration for a_benunit_test_item.helpgv05;
         -- missing declaration for a_benunit_test_item.helpgv06;
         -- missing declaration for a_benunit_test_item.helpgv07;
         -- missing declaration for a_benunit_test_item.helpgv08;
         -- missing declaration for a_benunit_test_item.helpgv09;
         -- missing declaration for a_benunit_test_item.helpgv10;
         -- missing declaration for a_benunit_test_item.helpgv11;
         -- missing declaration for a_benunit_test_item.helprc01;
         -- missing declaration for a_benunit_test_item.helprc02;
         -- missing declaration for a_benunit_test_item.helprc03;
         -- missing declaration for a_benunit_test_item.helprc04;
         -- missing declaration for a_benunit_test_item.helprc05;
         -- missing declaration for a_benunit_test_item.helprc06;
         -- missing declaration for a_benunit_test_item.helprc07;
         -- missing declaration for a_benunit_test_item.helprc08;
         -- missing declaration for a_benunit_test_item.helprc09;
         -- missing declaration for a_benunit_test_item.helprc10;
         -- missing declaration for a_benunit_test_item.helprc11;
         -- missing declaration for a_benunit_test_item.loangvn1;
         -- missing declaration for a_benunit_test_item.loangvn2;
         -- missing declaration for a_benunit_test_item.loangvn3;
         -- missing declaration for a_benunit_test_item.loanrec1;
         -- missing declaration for a_benunit_test_item.loanrec2;
         -- missing declaration for a_benunit_test_item.loanrec3;
         -- missing declaration for a_benunit_test_item.gross3_x;
         -- missing declaration for a_benunit_test_item.oabilimp;
         -- missing declaration for a_benunit_test_item.oacoaimp;
         -- missing declaration for a_benunit_test_item.oacooimp;
         -- missing declaration for a_benunit_test_item.oadamimp;
         -- missing declaration for a_benunit_test_item.oaexpimp;
         -- missing declaration for a_benunit_test_item.oafrnimp;
         -- missing declaration for a_benunit_test_item.oahaiimp;
         -- missing declaration for a_benunit_test_item.oaheaimp;
         -- missing declaration for a_benunit_test_item.oaholimp;
         -- missing declaration for a_benunit_test_item.oahomimp;
         -- missing declaration for a_benunit_test_item.oameaimp;
         -- missing declaration for a_benunit_test_item.oaoutimp;
         -- missing declaration for a_benunit_test_item.oaphoimp;
         -- missing declaration for a_benunit_test_item.oataximp;
         -- missing declaration for a_benunit_test_item.oawarimp;
         Ukds.Frs.Benunit_IO.Save( a_benunit_test_item, False );         
      end loop;
      
      a_benunit_test_list := Ukds.Frs.Benunit_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Benunit_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_benunit_test_item := Ukds.Frs.Benunit_List_Package.element( a_benunit_test_list, i );
         Ukds.Frs.Benunit_IO.Save( a_benunit_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Benunit_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_benunit_test_item := Ukds.Frs.Benunit_List_Package.element( a_benunit_test_list, i );
         Ukds.Frs.Benunit_IO.Delete( a_benunit_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Benunit_Create_Test: retrieve all records" );
      Ukds.Frs.Benunit_List_Package.iterate( a_benunit_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Benunit_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Benunit_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Benunit_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Benunit_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Adult_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Adult_List_Package.Cursor ) is 
      a_adult_test_item : Ukds.Frs.Adult;
      begin
         a_adult_test_item := Ukds.Frs.Adult_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_adult_test_item ));
      end print;

   
      a_adult_test_item : Ukds.Frs.Adult;
      a_adult_test_list : Ukds.Frs.Adult_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Adult_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Adult_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Adult_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_adult_test_item.user_id := Ukds.Frs.Adult_IO.Next_Free_user_id;
         a_adult_test_item.edition := Ukds.Frs.Adult_IO.Next_Free_edition;
         a_adult_test_item.year := Ukds.Frs.Adult_IO.Next_Free_year;
         a_adult_test_item.sernum := Ukds.Frs.Adult_IO.Next_Free_sernum;
         a_adult_test_item.benunit := Ukds.Frs.Adult_IO.Next_Free_benunit;
         a_adult_test_item.person := Ukds.Frs.Adult_IO.Next_Free_person;
         -- missing declaration for a_adult_test_item.abs1no;
         -- missing declaration for a_adult_test_item.abspar;
         -- missing declaration for a_adult_test_item.abspay;
         -- missing declaration for a_adult_test_item.abswhy;
         -- missing declaration for a_adult_test_item.abswk;
         -- missing declaration for a_adult_test_item.x_access;
         -- missing declaration for a_adult_test_item.accjb;
         -- missing declaration for a_adult_test_item.accmsat;
         -- missing declaration for a_adult_test_item.accountq;
         a_adult_test_item.accssamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.accsspd;
         -- missing declaration for a_adult_test_item.adeduc;
         -- missing declaration for a_adult_test_item.adema;
         a_adult_test_item.ademaamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.ademapd;
         -- missing declaration for a_adult_test_item.age;
         -- missing declaration for a_adult_test_item.agehqual;
         a_adult_test_item.aliamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.alimny;
         -- missing declaration for a_adult_test_item.alipd;
         -- missing declaration for a_adult_test_item.alius;
         -- missing declaration for a_adult_test_item.allow1;
         -- missing declaration for a_adult_test_item.allow2;
         -- missing declaration for a_adult_test_item.allow3;
         -- missing declaration for a_adult_test_item.allow4;
         a_adult_test_item.allpay1 := 1010100.012 + Amount( i );
         a_adult_test_item.allpay2 := 1010100.012 + Amount( i );
         a_adult_test_item.allpay3 := 1010100.012 + Amount( i );
         a_adult_test_item.allpay4 := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.allpd1;
         -- missing declaration for a_adult_test_item.allpd2;
         -- missing declaration for a_adult_test_item.allpd3;
         -- missing declaration for a_adult_test_item.allpd4;
         a_adult_test_item.aluamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.alupd;
         -- missing declaration for a_adult_test_item.anyacc;
         -- missing declaration for a_adult_test_item.anyed;
         -- missing declaration for a_adult_test_item.anymon;
         -- missing declaration for a_adult_test_item.anypen1;
         -- missing declaration for a_adult_test_item.anypen2;
         -- missing declaration for a_adult_test_item.anypen3;
         -- missing declaration for a_adult_test_item.anypen4;
         -- missing declaration for a_adult_test_item.anypen5;
         -- missing declaration for a_adult_test_item.anypen6;
         -- missing declaration for a_adult_test_item.anypen7;
         a_adult_test_item.apamt := 1010100.012 + Amount( i );
         a_adult_test_item.apdamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.apdir;
         -- missing declaration for a_adult_test_item.apdpd;
         -- missing declaration for a_adult_test_item.appd;
         -- missing declaration for a_adult_test_item.bfd;
         a_adult_test_item.bfdamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.bfdpd;
         -- missing declaration for a_adult_test_item.bfdval;
         -- missing declaration for a_adult_test_item.btec;
         -- missing declaration for a_adult_test_item.btecnow;
         -- missing declaration for a_adult_test_item.c2orign;
         -- missing declaration for a_adult_test_item.calm;
         -- missing declaration for a_adult_test_item.camemt;
         -- missing declaration for a_adult_test_item.cameyr;
         -- missing declaration for a_adult_test_item.cameyr2;
         -- missing declaration for a_adult_test_item.cbaamt2;
         -- missing declaration for a_adult_test_item.cbchk;
         -- missing declaration for a_adult_test_item.change;
         -- missing declaration for a_adult_test_item.chkctc;
         -- missing declaration for a_adult_test_item.chkdpco1;
         -- missing declaration for a_adult_test_item.chkdpco2;
         -- missing declaration for a_adult_test_item.chkdpco3;
         -- missing declaration for a_adult_test_item.chkdpn;
         -- missing declaration for a_adult_test_item.chkdsco1;
         -- missing declaration for a_adult_test_item.chkdsco2;
         -- missing declaration for a_adult_test_item.chkdsco3;
         -- missing declaration for a_adult_test_item.chknop;
         -- missing declaration for a_adult_test_item.citizen;
         -- missing declaration for a_adult_test_item.citizen2;
         -- missing declaration for a_adult_test_item.claifut1;
         -- missing declaration for a_adult_test_item.claifut2;
         -- missing declaration for a_adult_test_item.claifut3;
         -- missing declaration for a_adult_test_item.claifut4;
         -- missing declaration for a_adult_test_item.claifut5;
         -- missing declaration for a_adult_test_item.claifut6;
         -- missing declaration for a_adult_test_item.claifut7;
         -- missing declaration for a_adult_test_item.claifut8;
         -- missing declaration for a_adult_test_item.claimant;
         -- missing declaration for a_adult_test_item.cohabit;
         -- missing declaration for a_adult_test_item.combid;
         -- missing declaration for a_adult_test_item.commusat;
         -- missing declaration for a_adult_test_item.condit;
         -- missing declaration for a_adult_test_item.contuk;
         -- missing declaration for a_adult_test_item.convbl;
         -- missing declaration for a_adult_test_item.coptrust;
         -- missing declaration for a_adult_test_item.corign;
         -- missing declaration for a_adult_test_item.corigoth;
         -- missing declaration for a_adult_test_item.ctclum1;
         -- missing declaration for a_adult_test_item.ctclum2;
         -- missing declaration for a_adult_test_item.cupchk;
         -- missing declaration for a_adult_test_item.curqual;
         -- missing declaration for a_adult_test_item.cvht;
         a_adult_test_item.cvpay := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.cvpd;
         -- missing declaration for a_adult_test_item.ddaprog1;
         -- missing declaration for a_adult_test_item.ddatre1;
         -- missing declaration for a_adult_test_item.ddatrep1;
         -- missing declaration for a_adult_test_item.defrpen;
         -- missing declaration for a_adult_test_item.degree;
         -- missing declaration for a_adult_test_item.degrenow;
         -- missing declaration for a_adult_test_item.denrec;
         -- missing declaration for a_adult_test_item.depend;
         -- missing declaration for a_adult_test_item.depress;
         -- missing declaration for a_adult_test_item.disben1;
         -- missing declaration for a_adult_test_item.disben2;
         -- missing declaration for a_adult_test_item.disben3;
         -- missing declaration for a_adult_test_item.disben4;
         -- missing declaration for a_adult_test_item.disben5;
         -- missing declaration for a_adult_test_item.disben6;
         -- missing declaration for a_adult_test_item.discuss;
         -- missing declaration for a_adult_test_item.disd01;
         -- missing declaration for a_adult_test_item.disd02;
         -- missing declaration for a_adult_test_item.disd03;
         -- missing declaration for a_adult_test_item.disd04;
         -- missing declaration for a_adult_test_item.disd05;
         -- missing declaration for a_adult_test_item.disd06;
         -- missing declaration for a_adult_test_item.disd07;
         -- missing declaration for a_adult_test_item.disd08;
         -- missing declaration for a_adult_test_item.disd09;
         -- missing declaration for a_adult_test_item.disd10;
         -- missing declaration for a_adult_test_item.disdifp1;
         -- missing declaration for a_adult_test_item.dla1;
         -- missing declaration for a_adult_test_item.dla2;
         -- missing declaration for a_adult_test_item.dls;
         a_adult_test_item.dlsamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.dlspd;
         -- missing declaration for a_adult_test_item.dlsval;
         a_adult_test_item.dob := Ada.Calendar.Clock;
         -- missing declaration for a_adult_test_item.down;
         -- missing declaration for a_adult_test_item.dv09pens;
         -- missing declaration for a_adult_test_item.dvil03a;
         -- missing declaration for a_adult_test_item.dvil04a;
         -- missing declaration for a_adult_test_item.dvjb12ml;
         -- missing declaration for a_adult_test_item.dvmardf;
         a_adult_test_item.ed1amt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.ed1pd;
         -- missing declaration for a_adult_test_item.ed1sum;
         a_adult_test_item.ed2amt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.ed2pd;
         -- missing declaration for a_adult_test_item.ed2sum;
         -- missing declaration for a_adult_test_item.edatt;
         -- missing declaration for a_adult_test_item.edhr;
         -- missing declaration for a_adult_test_item.edtyp;
         -- missing declaration for a_adult_test_item.eligadlt;
         -- missing declaration for a_adult_test_item.eligchld;
         -- missing declaration for a_adult_test_item.eligschm;
         -- missing declaration for a_adult_test_item.emparr;
         -- missing declaration for a_adult_test_item.empcontr;
         -- missing declaration for a_adult_test_item.emppen;
         -- missing declaration for a_adult_test_item.empschm;
         -- missing declaration for a_adult_test_item.empstat;
         -- missing declaration for a_adult_test_item.envirsat;
         -- missing declaration for a_adult_test_item.es2000;
         -- missing declaration for a_adult_test_item.ethgrps;
         -- missing declaration for a_adult_test_item.etngrp;
         a_adult_test_item.eualiamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.eualimny;
         -- missing declaration for a_adult_test_item.eualipd;
         -- missing declaration for a_adult_test_item.euetype;
         -- missing declaration for a_adult_test_item.everwrk;
         -- missing declaration for a_adult_test_item.exthbct1;
         -- missing declaration for a_adult_test_item.followsc;
         -- missing declaration for a_adult_test_item.followup;
         -- missing declaration for a_adult_test_item.fted;
         -- missing declaration for a_adult_test_item.ftwk;
         -- missing declaration for a_adult_test_item.gpispc;
         -- missing declaration for a_adult_test_item.gpjsaesa;
         -- missing declaration for a_adult_test_item.x_grant;
         a_adult_test_item.grtamt1 := 1010100.012 + Amount( i );
         a_adult_test_item.grtamt2 := 1010100.012 + Amount( i );
         a_adult_test_item.grtdir1 := 1010100.012 + Amount( i );
         a_adult_test_item.grtdir2 := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.grtnum;
         -- missing declaration for a_adult_test_item.grtsce1;
         -- missing declaration for a_adult_test_item.grtsce2;
         a_adult_test_item.grtval1 := 1010100.012 + Amount( i );
         a_adult_test_item.grtval2 := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.gta;
         -- missing declaration for a_adult_test_item.happy;
         -- missing declaration for a_adult_test_item.health1;
         -- missing declaration for a_adult_test_item.heathad;
         -- missing declaration for a_adult_test_item.help;
         -- missing declaration for a_adult_test_item.hholder;
         -- missing declaration for a_adult_test_item.hi1qual1;
         -- missing declaration for a_adult_test_item.hi1qual2;
         -- missing declaration for a_adult_test_item.hi1qual3;
         -- missing declaration for a_adult_test_item.hi1qual4;
         -- missing declaration for a_adult_test_item.hi1qual5;
         -- missing declaration for a_adult_test_item.hi1qual6;
         -- missing declaration for a_adult_test_item.hi3qual;
         -- missing declaration for a_adult_test_item.higho;
         -- missing declaration for a_adult_test_item.highonow;
         -- missing declaration for a_adult_test_item.hrpid;
         -- missing declaration for a_adult_test_item.hsvper;
         -- missing declaration for a_adult_test_item.iclaim1;
         -- missing declaration for a_adult_test_item.iclaim2;
         -- missing declaration for a_adult_test_item.iclaim3;
         -- missing declaration for a_adult_test_item.iclaim4;
         -- missing declaration for a_adult_test_item.iclaim5;
         -- missing declaration for a_adult_test_item.iclaim6;
         -- missing declaration for a_adult_test_item.iclaim7;
         -- missing declaration for a_adult_test_item.iclaim8;
         -- missing declaration for a_adult_test_item.iclaim9;
         -- missing declaration for a_adult_test_item.incdur;
         -- missing declaration for a_adult_test_item.injlong;
         -- missing declaration for a_adult_test_item.injwk;
         -- missing declaration for a_adult_test_item.invests;
         -- missing declaration for a_adult_test_item.iout;
         -- missing declaration for a_adult_test_item.isa1type;
         -- missing declaration for a_adult_test_item.isa2type;
         -- missing declaration for a_adult_test_item.issue;
         -- missing declaration for a_adult_test_item.jobaway;
         -- missing declaration for a_adult_test_item.jobbyr;
         -- missing declaration for a_adult_test_item.jobsat;
         -- missing declaration for a_adult_test_item.kidben1;
         -- missing declaration for a_adult_test_item.kidben2;
         -- missing declaration for a_adult_test_item.kidben3;
         -- missing declaration for a_adult_test_item.lareg;
         -- missing declaration for a_adult_test_item.legltrus;
         -- missing declaration for a_adult_test_item.lifesat;
         -- missing declaration for a_adult_test_item.likewk;
         -- missing declaration for a_adult_test_item.limitl;
         -- missing declaration for a_adult_test_item.lktime;
         -- missing declaration for a_adult_test_item.lktrain;
         -- missing declaration for a_adult_test_item.lkwork;
         -- missing declaration for a_adult_test_item.lnkdwp;
         -- missing declaration for a_adult_test_item.lnkref01;
         -- missing declaration for a_adult_test_item.lnkref02;
         -- missing declaration for a_adult_test_item.lnkref03;
         -- missing declaration for a_adult_test_item.lnkref04;
         -- missing declaration for a_adult_test_item.lnkref05;
         -- missing declaration for a_adult_test_item.lnkref06;
         -- missing declaration for a_adult_test_item.lnkref07;
         -- missing declaration for a_adult_test_item.lnkref08;
         -- missing declaration for a_adult_test_item.lnkref09;
         -- missing declaration for a_adult_test_item.lnkref10;
         -- missing declaration for a_adult_test_item.lnkref11;
         -- missing declaration for a_adult_test_item.loan;
         -- missing declaration for a_adult_test_item.loannum;
         -- missing declaration for a_adult_test_item.lstwrk1;
         -- missing declaration for a_adult_test_item.lstwrk2;
         -- missing declaration for a_adult_test_item.lstyr;
         -- missing declaration for a_adult_test_item.meaning;
         -- missing declaration for a_adult_test_item.medrec;
         -- missing declaration for a_adult_test_item.memschm;
         a_adult_test_item.mntamt1 := 1010100.012 + Amount( i );
         a_adult_test_item.mntamt2 := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.mntarr1;
         -- missing declaration for a_adult_test_item.mntarr2;
         -- missing declaration for a_adult_test_item.mntarr3;
         -- missing declaration for a_adult_test_item.mntarr4;
         -- missing declaration for a_adult_test_item.mntgov1;
         -- missing declaration for a_adult_test_item.mntgov2;
         -- missing declaration for a_adult_test_item.mntnrp;
         -- missing declaration for a_adult_test_item.mntpay;
         -- missing declaration for a_adult_test_item.mntpd1;
         -- missing declaration for a_adult_test_item.mntpd2;
         -- missing declaration for a_adult_test_item.mntrec;
         -- missing declaration for a_adult_test_item.mntus1;
         -- missing declaration for a_adult_test_item.mntus2;
         a_adult_test_item.mntusam1 := 1010100.012 + Amount( i );
         a_adult_test_item.mntusam2 := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.mntuspd1;
         -- missing declaration for a_adult_test_item.mntuspd2;
         -- missing declaration for a_adult_test_item.moneysat;
         -- missing declaration for a_adult_test_item.ms;
         -- missing declaration for a_adult_test_item.nanid1;
         -- missing declaration for a_adult_test_item.nanid2;
         -- missing declaration for a_adult_test_item.nanid3;
         -- missing declaration for a_adult_test_item.nanid4;
         -- missing declaration for a_adult_test_item.nanid5;
         -- missing declaration for a_adult_test_item.nanid6;
         -- missing declaration for a_adult_test_item.nervous;
         -- missing declaration for a_adult_test_item.ni2train;
         a_adult_test_item.niamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.nietngrp;
         -- missing declaration for a_adult_test_item.niexthbb;
         -- missing declaration for a_adult_test_item.ninanid1;
         -- missing declaration for a_adult_test_item.ninanid2;
         -- missing declaration for a_adult_test_item.ninanid3;
         -- missing declaration for a_adult_test_item.ninanid4;
         -- missing declaration for a_adult_test_item.ninanid5;
         -- missing declaration for a_adult_test_item.ninanid6;
         -- missing declaration for a_adult_test_item.ninanid7;
         -- missing declaration for a_adult_test_item.nipd;
         -- missing declaration for a_adult_test_item.nireg;
         -- missing declaration for a_adult_test_item.nirelig;
         -- missing declaration for a_adult_test_item.nolk1;
         -- missing declaration for a_adult_test_item.nolk2;
         -- missing declaration for a_adult_test_item.nolk3;
         -- missing declaration for a_adult_test_item.nowant;
         a_adult_test_item.nssec := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.numjob;
         -- missing declaration for a_adult_test_item.numjob2;
         -- missing declaration for a_adult_test_item.nvqlenow;
         -- missing declaration for a_adult_test_item.nvqlev;
         -- missing declaration for a_adult_test_item.oddjob;
         -- missing declaration for a_adult_test_item.oldstud;
         -- missing declaration for a_adult_test_item.otabspar;
         a_adult_test_item.otamt := 1010100.012 + Amount( i );
         a_adult_test_item.otapamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.otappd;
         -- missing declaration for a_adult_test_item.othben1;
         -- missing declaration for a_adult_test_item.othben2;
         -- missing declaration for a_adult_test_item.othben3;
         -- missing declaration for a_adult_test_item.othben4;
         -- missing declaration for a_adult_test_item.othben5;
         -- missing declaration for a_adult_test_item.othben6;
         -- missing declaration for a_adult_test_item.othpass;
         -- missing declaration for a_adult_test_item.othqual1;
         -- missing declaration for a_adult_test_item.othqual2;
         -- missing declaration for a_adult_test_item.othqual3;
         -- missing declaration for a_adult_test_item.othtax;
         -- missing declaration for a_adult_test_item.othtrust;
         -- missing declaration for a_adult_test_item.otinva;
         a_adult_test_item.pareamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.parepd;
         -- missing declaration for a_adult_test_item.penben1;
         -- missing declaration for a_adult_test_item.penben2;
         -- missing declaration for a_adult_test_item.penben3;
         -- missing declaration for a_adult_test_item.penben4;
         -- missing declaration for a_adult_test_item.penben5;
         -- missing declaration for a_adult_test_item.penflag;
         -- missing declaration for a_adult_test_item.penlump;
         -- missing declaration for a_adult_test_item.perspen1;
         -- missing declaration for a_adult_test_item.perspen2;
         -- missing declaration for a_adult_test_item.pip1;
         -- missing declaration for a_adult_test_item.pip2;
         -- missing declaration for a_adult_test_item.pollopin;
         -- missing declaration for a_adult_test_item.polttrus;
         -- missing declaration for a_adult_test_item.ppchk1;
         -- missing declaration for a_adult_test_item.ppchk2;
         -- missing declaration for a_adult_test_item.ppchk3;
         -- missing declaration for a_adult_test_item.ppnumc;
         -- missing declaration for a_adult_test_item.ppper;
         -- missing declaration for a_adult_test_item.practice;
         -- missing declaration for a_adult_test_item.privpen;
         a_adult_test_item.proptax := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.ptwk;
         -- missing declaration for a_adult_test_item.r01;
         -- missing declaration for a_adult_test_item.r02;
         -- missing declaration for a_adult_test_item.r03;
         -- missing declaration for a_adult_test_item.r04;
         -- missing declaration for a_adult_test_item.r05;
         -- missing declaration for a_adult_test_item.r06;
         -- missing declaration for a_adult_test_item.r07;
         -- missing declaration for a_adult_test_item.r08;
         -- missing declaration for a_adult_test_item.r09;
         -- missing declaration for a_adult_test_item.r10;
         -- missing declaration for a_adult_test_item.r11;
         -- missing declaration for a_adult_test_item.r12;
         -- missing declaration for a_adult_test_item.r13;
         -- missing declaration for a_adult_test_item.r14;
         -- missing declaration for a_adult_test_item.reasden;
         -- missing declaration for a_adult_test_item.reasmed;
         -- missing declaration for a_adult_test_item.reasnhs;
         -- missing declaration for a_adult_test_item.reason;
         -- missing declaration for a_adult_test_item.recsat;
         a_adult_test_item.redamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.redany;
         -- missing declaration for a_adult_test_item.rednet;
         a_adult_test_item.redtax := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.relasat;
         -- missing declaration for a_adult_test_item.religenw;
         -- missing declaration for a_adult_test_item.religsc;
         -- missing declaration for a_adult_test_item.rentprof;
         -- missing declaration for a_adult_test_item.retire;
         -- missing declaration for a_adult_test_item.retire1;
         -- missing declaration for a_adult_test_item.retreas;
         -- missing declaration for a_adult_test_item.royal1;
         -- missing declaration for a_adult_test_item.royal2;
         -- missing declaration for a_adult_test_item.royal3;
         -- missing declaration for a_adult_test_item.royal4;
         a_adult_test_item.royyr1 := 1010100.012 + Amount( i );
         a_adult_test_item.royyr2 := 1010100.012 + Amount( i );
         a_adult_test_item.royyr3 := 1010100.012 + Amount( i );
         a_adult_test_item.royyr4 := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.rsa;
         -- missing declaration for a_adult_test_item.rsanow;
         -- missing declaration for a_adult_test_item.rstrct;
         -- missing declaration for a_adult_test_item.safe;
         -- missing declaration for a_adult_test_item.samesit;
         -- missing declaration for a_adult_test_item.schchk;
         -- missing declaration for a_adult_test_item.scotvec;
         -- missing declaration for a_adult_test_item.sctvnow;
         -- missing declaration for a_adult_test_item.sdemp01;
         -- missing declaration for a_adult_test_item.sdemp02;
         -- missing declaration for a_adult_test_item.sdemp03;
         -- missing declaration for a_adult_test_item.sdemp04;
         -- missing declaration for a_adult_test_item.sdemp05;
         -- missing declaration for a_adult_test_item.sdemp06;
         -- missing declaration for a_adult_test_item.sdemp07;
         -- missing declaration for a_adult_test_item.sdemp08;
         -- missing declaration for a_adult_test_item.sdemp09;
         -- missing declaration for a_adult_test_item.sdemp10;
         -- missing declaration for a_adult_test_item.sdemp11;
         -- missing declaration for a_adult_test_item.sdemp12;
         -- missing declaration for a_adult_test_item.selfdemp;
         -- missing declaration for a_adult_test_item.sex;
         -- missing declaration for a_adult_test_item.sflntyp1;
         -- missing declaration for a_adult_test_item.sflntyp2;
         -- missing declaration for a_adult_test_item.sftype1;
         -- missing declaration for a_adult_test_item.sftype2;
         -- missing declaration for a_adult_test_item.sic;
         -- missing declaration for a_adult_test_item.sidqn;
         a_adult_test_item.slrepamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.slrepay;
         -- missing declaration for a_adult_test_item.slreppd;
         -- missing declaration for a_adult_test_item.soc2010;
         -- missing declaration for a_adult_test_item.socfund1;
         -- missing declaration for a_adult_test_item.socfund2;
         -- missing declaration for a_adult_test_item.socfund3;
         -- missing declaration for a_adult_test_item.socfund4;
         -- missing declaration for a_adult_test_item.spcreg1;
         -- missing declaration for a_adult_test_item.spcreg2;
         -- missing declaration for a_adult_test_item.spcreg3;
         -- missing declaration for a_adult_test_item.spnumc;
         -- missing declaration for a_adult_test_item.spout;
         -- missing declaration for a_adult_test_item.spyrot;
         a_adult_test_item.srentamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.srentpd;
         -- missing declaration for a_adult_test_item.srispc;
         -- missing declaration for a_adult_test_item.srjsaesa;
         -- missing declaration for a_adult_test_item.stakep;
         -- missing declaration for a_adult_test_item.start;
         -- missing declaration for a_adult_test_item.tcever1;
         -- missing declaration for a_adult_test_item.tcever2;
         -- missing declaration for a_adult_test_item.tcrepay1;
         -- missing declaration for a_adult_test_item.tcrepay2;
         -- missing declaration for a_adult_test_item.tcrepay3;
         -- missing declaration for a_adult_test_item.tcrepay4;
         -- missing declaration for a_adult_test_item.tcrepay5;
         -- missing declaration for a_adult_test_item.tcrepay6;
         -- missing declaration for a_adult_test_item.tcthsyr1;
         -- missing declaration for a_adult_test_item.tcthsyr2;
         -- missing declaration for a_adult_test_item.tdaywrk;
         -- missing declaration for a_adult_test_item.tea;
         -- missing declaration for a_adult_test_item.tea9697;
         -- missing declaration for a_adult_test_item.tempjob;
         -- missing declaration for a_adult_test_item.timesat;
         -- missing declaration for a_adult_test_item.topupl;
         a_adult_test_item.totint := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.train2;
         -- missing declaration for a_adult_test_item.trainee;
         -- missing declaration for a_adult_test_item.trnallow;
         a_adult_test_item.ttbprx := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.tuborr;
         -- missing declaration for a_adult_test_item.typeed;
         -- missing declaration for a_adult_test_item.unpaid1;
         -- missing declaration for a_adult_test_item.unpaid2;
         -- missing declaration for a_adult_test_item.w1;
         -- missing declaration for a_adult_test_item.w2;
         -- missing declaration for a_adult_test_item.wageben1;
         -- missing declaration for a_adult_test_item.wageben2;
         -- missing declaration for a_adult_test_item.wageben3;
         -- missing declaration for a_adult_test_item.wageben4;
         -- missing declaration for a_adult_test_item.wageben5;
         -- missing declaration for a_adult_test_item.wageben6;
         -- missing declaration for a_adult_test_item.wageben7;
         -- missing declaration for a_adult_test_item.wageben8;
         -- missing declaration for a_adult_test_item.wait;
         -- missing declaration for a_adult_test_item.whoresp;
         -- missing declaration for a_adult_test_item.whosectb;
         -- missing declaration for a_adult_test_item.wintfuel;
         -- missing declaration for a_adult_test_item.working;
         -- missing declaration for a_adult_test_item.wpa;
         -- missing declaration for a_adult_test_item.wpba;
         -- missing declaration for a_adult_test_item.wtclum1;
         -- missing declaration for a_adult_test_item.wtclum2;
         -- missing declaration for a_adult_test_item.ystrtwk;
         -- missing declaration for a_adult_test_item.month;
         -- missing declaration for a_adult_test_item.able;
         -- missing declaration for a_adult_test_item.actacci;
         -- missing declaration for a_adult_test_item.age80;
         -- missing declaration for a_adult_test_item.agehq80;
         -- missing declaration for a_adult_test_item.basacti;
         -- missing declaration for a_adult_test_item.careab;
         -- missing declaration for a_adult_test_item.careah;
         -- missing declaration for a_adult_test_item.carecb;
         -- missing declaration for a_adult_test_item.carech;
         -- missing declaration for a_adult_test_item.carecl;
         -- missing declaration for a_adult_test_item.carefl;
         -- missing declaration for a_adult_test_item.carefr;
         -- missing declaration for a_adult_test_item.careot;
         -- missing declaration for a_adult_test_item.carere;
         -- missing declaration for a_adult_test_item.chbflg;
         -- missing declaration for a_adult_test_item.corignan;
         -- missing declaration for a_adult_test_item.curacti;
         -- missing declaration for a_adult_test_item.currjobm;
         -- missing declaration for a_adult_test_item.disacta1;
         -- missing declaration for a_adult_test_item.discora1;
         -- missing declaration for a_adult_test_item.dobmonth;
         -- missing declaration for a_adult_test_item.dobyear;
         a_adult_test_item.empoccp := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.empstatb;
         -- missing declaration for a_adult_test_item.empstatc;
         -- missing declaration for a_adult_test_item.empstati;
         -- missing declaration for a_adult_test_item.ethgr3;
         -- missing declaration for a_adult_test_item.gebacti;
         -- missing declaration for a_adult_test_item.giltcti;
         -- missing declaration for a_adult_test_item.gross4;
         -- missing declaration for a_adult_test_item.hdage;
         -- missing declaration for a_adult_test_item.hdben;
         -- missing declaration for a_adult_test_item.hdindinc;
         a_adult_test_item.heartval := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.hourab;
         -- missing declaration for a_adult_test_item.hourah;
         a_adult_test_item.hourcare := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.hourcb;
         -- missing declaration for a_adult_test_item.hourch;
         -- missing declaration for a_adult_test_item.hourcl;
         -- missing declaration for a_adult_test_item.hourfr;
         -- missing declaration for a_adult_test_item.hourot;
         -- missing declaration for a_adult_test_item.hourre;
         -- missing declaration for a_adult_test_item.hourtot;
         -- missing declaration for a_adult_test_item.hperson;
         -- missing declaration for a_adult_test_item.iagegr2;
         -- missing declaration for a_adult_test_item.iagegr3;
         -- missing declaration for a_adult_test_item.iagegr4;
         -- missing declaration for a_adult_test_item.iagegrp;
         a_adult_test_item.incseo2 := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.indinc;
         -- missing declaration for a_adult_test_item.indisben;
         a_adult_test_item.inearns := 1010100.012 + Amount( i );
         a_adult_test_item.ininv := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.inirben;
         -- missing declaration for a_adult_test_item.innirben;
         -- missing declaration for a_adult_test_item.inothben;
         a_adult_test_item.inpeninc := 1010100.012 + Amount( i );
         a_adult_test_item.inrinc := 1010100.012 + Amount( i );
         a_adult_test_item.inrpinc := 1010100.012 + Amount( i );
         a_adult_test_item.intvlic := 1010100.012 + Amount( i );
         a_adult_test_item.intxcred := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.isacti;
         -- missing declaration for a_adult_test_item.marital;
         -- missing declaration for a_adult_test_item.mjobsect;
         -- missing declaration for a_adult_test_item.ninanida;
         a_adult_test_item.nincseo2 := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.nindinc;
         -- missing declaration for a_adult_test_item.ninearns;
         -- missing declaration for a_adult_test_item.nininv;
         -- missing declaration for a_adult_test_item.ninnirbn;
         -- missing declaration for a_adult_test_item.ninothbn;
         -- missing declaration for a_adult_test_item.ninpenin;
         -- missing declaration for a_adult_test_item.ninrinc;
         a_adult_test_item.ninsein2 := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.nirel2;
         -- missing declaration for a_adult_test_item.occupnum;
         -- missing declaration for a_adult_test_item.pepscti;
         -- missing declaration for a_adult_test_item.poaccti;
         -- missing declaration for a_adult_test_item.pocardi;
         -- missing declaration for a_adult_test_item.prevjobm;
         -- missing declaration for a_adult_test_item.relhrp;
         a_adult_test_item.sapadj := 1010100.012 + Amount( i );
         a_adult_test_item.seincam2 := 1010100.012 + Amount( i );
         a_adult_test_item.smpadj := 1010100.012 + Amount( i );
         a_adult_test_item.sppadj := 1010100.012 + Amount( i );
         a_adult_test_item.sspadj := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.stshcti;
         -- missing declaration for a_adult_test_item.taxpayer;
         -- missing declaration for a_adult_test_item.tesscti;
         a_adult_test_item.totgrant := 1010100.012 + Amount( i );
         a_adult_test_item.tothours := 1010100.012 + Amount( i );
         a_adult_test_item.totoccp := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.typeed2;
         -- missing declaration for a_adult_test_item.untrcti;
         -- missing declaration for a_adult_test_item.uperson;
         -- missing declaration for a_adult_test_item.w45;
         a_adult_test_item.widoccp := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.xbonflag;
         -- missing declaration for a_adult_test_item.anxious;
         -- missing declaration for a_adult_test_item.candgnow;
         -- missing declaration for a_adult_test_item.curothf;
         -- missing declaration for a_adult_test_item.curothp;
         -- missing declaration for a_adult_test_item.curothwv;
         -- missing declaration for a_adult_test_item.dvhiqual;
         -- missing declaration for a_adult_test_item.gnvqnow;
         -- missing declaration for a_adult_test_item.gpuc;
         -- missing declaration for a_adult_test_item.happywb;
         -- missing declaration for a_adult_test_item.hi1qual7;
         -- missing declaration for a_adult_test_item.hi1qual8;
         -- missing declaration for a_adult_test_item.mntarr5;
         -- missing declaration for a_adult_test_item.mntnoch1;
         -- missing declaration for a_adult_test_item.mntnoch2;
         -- missing declaration for a_adult_test_item.mntnoch3;
         -- missing declaration for a_adult_test_item.mntnoch4;
         -- missing declaration for a_adult_test_item.mntnoch5;
         -- missing declaration for a_adult_test_item.mntpro1;
         -- missing declaration for a_adult_test_item.mntpro2;
         -- missing declaration for a_adult_test_item.mntpro3;
         -- missing declaration for a_adult_test_item.mnttim1;
         -- missing declaration for a_adult_test_item.mnttim2;
         -- missing declaration for a_adult_test_item.mnttim3;
         -- missing declaration for a_adult_test_item.mntwrk1;
         -- missing declaration for a_adult_test_item.mntwrk2;
         -- missing declaration for a_adult_test_item.mntwrk3;
         -- missing declaration for a_adult_test_item.mntwrk4;
         -- missing declaration for a_adult_test_item.mntwrk5;
         -- missing declaration for a_adult_test_item.ndeplnow;
         -- missing declaration for a_adult_test_item.oqualc1;
         -- missing declaration for a_adult_test_item.oqualc2;
         -- missing declaration for a_adult_test_item.oqualc3;
         -- missing declaration for a_adult_test_item.sruc;
         -- missing declaration for a_adult_test_item.webacnow;
         -- missing declaration for a_adult_test_item.indeth;
         -- missing declaration for a_adult_test_item.euactive;
         -- missing declaration for a_adult_test_item.euactno;
         -- missing declaration for a_adult_test_item.euartact;
         -- missing declaration for a_adult_test_item.euaskhlp;
         -- missing declaration for a_adult_test_item.eucinema;
         -- missing declaration for a_adult_test_item.eucultur;
         -- missing declaration for a_adult_test_item.euinvol;
         -- missing declaration for a_adult_test_item.eulivpe;
         -- missing declaration for a_adult_test_item.eumtfam;
         -- missing declaration for a_adult_test_item.eumtfrnd;
         -- missing declaration for a_adult_test_item.eusocnet;
         -- missing declaration for a_adult_test_item.eusport;
         -- missing declaration for a_adult_test_item.eutkfam;
         -- missing declaration for a_adult_test_item.eutkfrnd;
         -- missing declaration for a_adult_test_item.eutkmat;
         -- missing declaration for a_adult_test_item.euvol;
         -- missing declaration for a_adult_test_item.natscot;
         -- missing declaration for a_adult_test_item.ntsctnow;
         -- missing declaration for a_adult_test_item.penwel1;
         -- missing declaration for a_adult_test_item.penwel2;
         -- missing declaration for a_adult_test_item.penwel3;
         -- missing declaration for a_adult_test_item.penwel4;
         -- missing declaration for a_adult_test_item.penwel5;
         -- missing declaration for a_adult_test_item.penwel6;
         -- missing declaration for a_adult_test_item.skiwknow;
         -- missing declaration for a_adult_test_item.skiwrk;
         -- missing declaration for a_adult_test_item.slos;
         -- missing declaration for a_adult_test_item.yjblev;
         -- missing declaration for a_adult_test_item.abs2no;
         -- missing declaration for a_adult_test_item.accftpt;
         -- missing declaration for a_adult_test_item.b2qfut1;
         -- missing declaration for a_adult_test_item.b2qfut2;
         -- missing declaration for a_adult_test_item.b2qfut3;
         -- missing declaration for a_adult_test_item.b3qfut1;
         -- missing declaration for a_adult_test_item.b3qfut2;
         -- missing declaration for a_adult_test_item.b3qfut3;
         -- missing declaration for a_adult_test_item.b3qfut4;
         -- missing declaration for a_adult_test_item.b3qfut5;
         -- missing declaration for a_adult_test_item.b3qfut6;
         -- missing declaration for a_adult_test_item.ben1q1;
         -- missing declaration for a_adult_test_item.ben1q2;
         -- missing declaration for a_adult_test_item.ben1q3;
         -- missing declaration for a_adult_test_item.ben1q4;
         -- missing declaration for a_adult_test_item.ben1q5;
         -- missing declaration for a_adult_test_item.ben1q6;
         -- missing declaration for a_adult_test_item.ben1q7;
         -- missing declaration for a_adult_test_item.ben2q1;
         -- missing declaration for a_adult_test_item.ben2q2;
         -- missing declaration for a_adult_test_item.ben2q3;
         -- missing declaration for a_adult_test_item.ben3q1;
         -- missing declaration for a_adult_test_item.ben3q2;
         -- missing declaration for a_adult_test_item.ben3q3;
         -- missing declaration for a_adult_test_item.ben3q4;
         -- missing declaration for a_adult_test_item.ben3q5;
         -- missing declaration for a_adult_test_item.ben3q6;
         -- missing declaration for a_adult_test_item.ben4q1;
         -- missing declaration for a_adult_test_item.ben4q2;
         -- missing declaration for a_adult_test_item.ben4q3;
         -- missing declaration for a_adult_test_item.ben5q1;
         -- missing declaration for a_adult_test_item.ben5q2;
         -- missing declaration for a_adult_test_item.ben5q3;
         -- missing declaration for a_adult_test_item.ben5q4;
         -- missing declaration for a_adult_test_item.ben5q5;
         -- missing declaration for a_adult_test_item.ben5q6;
         -- missing declaration for a_adult_test_item.ben7q1;
         -- missing declaration for a_adult_test_item.ben7q2;
         -- missing declaration for a_adult_test_item.ben7q3;
         -- missing declaration for a_adult_test_item.ben7q4;
         -- missing declaration for a_adult_test_item.ben7q5;
         -- missing declaration for a_adult_test_item.ben7q6;
         -- missing declaration for a_adult_test_item.ben7q7;
         -- missing declaration for a_adult_test_item.ben7q8;
         -- missing declaration for a_adult_test_item.ben7q9;
         -- missing declaration for a_adult_test_item.btwacc;
         -- missing declaration for a_adult_test_item.dentist;
         -- missing declaration for a_adult_test_item.disdif1;
         -- missing declaration for a_adult_test_item.disdif2;
         -- missing declaration for a_adult_test_item.disdif3;
         -- missing declaration for a_adult_test_item.disdif4;
         -- missing declaration for a_adult_test_item.disdif5;
         -- missing declaration for a_adult_test_item.disdif6;
         -- missing declaration for a_adult_test_item.disdif7;
         -- missing declaration for a_adult_test_item.disdif8;
         -- missing declaration for a_adult_test_item.dptcboth;
         -- missing declaration for a_adult_test_item.dptclum;
         -- missing declaration for a_adult_test_item.ed1borr;
         -- missing declaration for a_adult_test_item.ed1int;
         a_adult_test_item.ed1monyr := Ada.Calendar.Clock;
         -- missing declaration for a_adult_test_item.ed2borr;
         -- missing declaration for a_adult_test_item.ed2int;
         a_adult_test_item.ed2monyr := Ada.Calendar.Clock;
         -- missing declaration for a_adult_test_item.edattn1;
         -- missing declaration for a_adult_test_item.edattn2;
         -- missing declaration for a_adult_test_item.edattn3;
         -- missing declaration for a_adult_test_item.edtime;
         -- missing declaration for a_adult_test_item.emppay1;
         -- missing declaration for a_adult_test_item.emppay2;
         -- missing declaration for a_adult_test_item.emppay3;
         -- missing declaration for a_adult_test_item.endyr;
         -- missing declaration for a_adult_test_item.epcur;
         -- missing declaration for a_adult_test_item.ethgrp;
         -- missing declaration for a_adult_test_item.exthbct2;
         -- missing declaration for a_adult_test_item.exthbct3;
         -- missing declaration for a_adult_test_item.eyetest;
         -- missing declaration for a_adult_test_item.follow;
         -- missing declaration for a_adult_test_item.future;
         -- missing declaration for a_adult_test_item.govpis;
         -- missing declaration for a_adult_test_item.govpjsa;
         a_adult_test_item.hbothamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.hbothbu;
         -- missing declaration for a_adult_test_item.hbothpd;
         -- missing declaration for a_adult_test_item.hbothwk;
         -- missing declaration for a_adult_test_item.hbotwait;
         -- missing declaration for a_adult_test_item.health;
         -- missing declaration for a_adult_test_item.hosp;
         -- missing declaration for a_adult_test_item.hprob;
         -- missing declaration for a_adult_test_item.isa3type;
         -- missing declaration for a_adult_test_item.ln1rpint;
         -- missing declaration for a_adult_test_item.ln2rpint;
         -- missing declaration for a_adult_test_item.look;
         -- missing declaration for a_adult_test_item.lookwk;
         -- missing declaration for a_adult_test_item.mntct;
         -- missing declaration for a_adult_test_item.mntfor1;
         -- missing declaration for a_adult_test_item.mntfor2;
         -- missing declaration for a_adult_test_item.mnttota1;
         -- missing declaration for a_adult_test_item.mnttota2;
         -- missing declaration for a_adult_test_item.natid1;
         -- missing declaration for a_adult_test_item.natid2;
         -- missing declaration for a_adult_test_item.natid3;
         -- missing declaration for a_adult_test_item.natid4;
         -- missing declaration for a_adult_test_item.natid5;
         -- missing declaration for a_adult_test_item.natid6;
         -- missing declaration for a_adult_test_item.ndeal;
         -- missing declaration for a_adult_test_item.newdtype;
         -- missing declaration for a_adult_test_item.nhs1;
         -- missing declaration for a_adult_test_item.nhs2;
         -- missing declaration for a_adult_test_item.nhs3;
         -- missing declaration for a_adult_test_item.niethgrp;
         -- missing declaration for a_adult_test_item.ninatid1;
         -- missing declaration for a_adult_test_item.ninatid2;
         -- missing declaration for a_adult_test_item.ninatid3;
         -- missing declaration for a_adult_test_item.ninatid4;
         -- missing declaration for a_adult_test_item.ninatid5;
         -- missing declaration for a_adult_test_item.ninatid6;
         -- missing declaration for a_adult_test_item.ninatid7;
         -- missing declaration for a_adult_test_item.ninatid8;
         -- missing declaration for a_adult_test_item.nirel;
         -- missing declaration for a_adult_test_item.nitrain;
         -- missing declaration for a_adult_test_item.nlper;
         -- missing declaration for a_adult_test_item.nolook;
         -- missing declaration for a_adult_test_item.ntcapp;
         -- missing declaration for a_adult_test_item.ntcdat;
         a_adult_test_item.ntcinc := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.ntcorig1;
         -- missing declaration for a_adult_test_item.ntcorig2;
         -- missing declaration for a_adult_test_item.ntcorig3;
         -- missing declaration for a_adult_test_item.ntcorig4;
         -- missing declaration for a_adult_test_item.ntcorig5;
         -- missing declaration for a_adult_test_item.prit;
         -- missing declaration for a_adult_test_item.prscrpt;
         -- missing declaration for a_adult_test_item.soc2000;
         -- missing declaration for a_adult_test_item.specs;
         -- missing declaration for a_adult_test_item.startyr;
         -- missing declaration for a_adult_test_item.taxcred1;
         -- missing declaration for a_adult_test_item.taxcred2;
         -- missing declaration for a_adult_test_item.taxcred3;
         -- missing declaration for a_adult_test_item.taxcred4;
         -- missing declaration for a_adult_test_item.taxcred5;
         -- missing declaration for a_adult_test_item.taxfut;
         -- missing declaration for a_adult_test_item.train;
         -- missing declaration for a_adult_test_item.trav;
         -- missing declaration for a_adult_test_item.voucher;
         -- missing declaration for a_adult_test_item.war1;
         -- missing declaration for a_adult_test_item.war2;
         -- missing declaration for a_adult_test_item.wftcboth;
         -- missing declaration for a_adult_test_item.wftclum;
         -- missing declaration for a_adult_test_item.whyfrde1;
         -- missing declaration for a_adult_test_item.whyfrde2;
         -- missing declaration for a_adult_test_item.whyfrde3;
         -- missing declaration for a_adult_test_item.whyfrde4;
         -- missing declaration for a_adult_test_item.whyfrde5;
         -- missing declaration for a_adult_test_item.whyfrde6;
         -- missing declaration for a_adult_test_item.whyfrey1;
         -- missing declaration for a_adult_test_item.whyfrey2;
         -- missing declaration for a_adult_test_item.whyfrey3;
         -- missing declaration for a_adult_test_item.whyfrey4;
         -- missing declaration for a_adult_test_item.whyfrey5;
         -- missing declaration for a_adult_test_item.whyfrey6;
         -- missing declaration for a_adult_test_item.whyfrpr1;
         -- missing declaration for a_adult_test_item.whyfrpr2;
         -- missing declaration for a_adult_test_item.whyfrpr3;
         -- missing declaration for a_adult_test_item.whyfrpr4;
         -- missing declaration for a_adult_test_item.whyfrpr5;
         -- missing declaration for a_adult_test_item.whyfrpr6;
         -- missing declaration for a_adult_test_item.whytrav1;
         -- missing declaration for a_adult_test_item.whytrav2;
         -- missing declaration for a_adult_test_item.whytrav3;
         -- missing declaration for a_adult_test_item.whytrav4;
         -- missing declaration for a_adult_test_item.whytrav5;
         -- missing declaration for a_adult_test_item.whytrav6;
         -- missing declaration for a_adult_test_item.wmkit;
         -- missing declaration for a_adult_test_item.wtclum3;
         -- missing declaration for a_adult_test_item.addda;
         a_adult_test_item.bntxcred := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.fsbndcti;
         a_adult_test_item.fwmlkval := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.gross2;
         -- missing declaration for a_adult_test_item.gross3;
         a_adult_test_item.hbsupran := 1010100.012 + Amount( i );
         a_adult_test_item.netocpen := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.nsbocti;
         -- missing declaration for a_adult_test_item.otbscti;
         -- missing declaration for a_adult_test_item.prbocti;
         -- missing declaration for a_adult_test_item.sayecti;
         -- missing declaration for a_adult_test_item.sclbcti;
         -- missing declaration for a_adult_test_item.sscti;
         a_adult_test_item.superan := 1010100.012 + Amount( i );
         a_adult_test_item.ttwcosts := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.ben5q7;
         -- missing declaration for a_adult_test_item.ben5q8;
         -- missing declaration for a_adult_test_item.ben5q9;
         -- missing declaration for a_adult_test_item.ddatre;
         -- missing declaration for a_adult_test_item.disdif9;
         a_adult_test_item.fare := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.nittwmod;
         -- missing declaration for a_adult_test_item.oneway;
         a_adult_test_item.pssamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.pssdate;
         -- missing declaration for a_adult_test_item.ttwcode1;
         -- missing declaration for a_adult_test_item.ttwcode2;
         -- missing declaration for a_adult_test_item.ttwcode3;
         a_adult_test_item.ttwcost := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.ttwfar;
         a_adult_test_item.ttwfrq := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.ttwmod;
         -- missing declaration for a_adult_test_item.ttwpay;
         -- missing declaration for a_adult_test_item.ttwpss;
         a_adult_test_item.ttwrec := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.crunaci;
         -- missing declaration for a_adult_test_item.enomorti;
         -- missing declaration for a_adult_test_item.ttwmode;
         -- missing declaration for a_adult_test_item.ddatrep;
         -- missing declaration for a_adult_test_item.disdifp;
         -- missing declaration for a_adult_test_item.sfrpis;
         -- missing declaration for a_adult_test_item.sfrpjsa;
         -- missing declaration for a_adult_test_item.ethgr2;
         -- missing declaration for a_adult_test_item.consent;
         -- missing declaration for a_adult_test_item.dvpens;
         -- missing declaration for a_adult_test_item.lnkref1;
         -- missing declaration for a_adult_test_item.lnkref2;
         -- missing declaration for a_adult_test_item.lnkref21;
         -- missing declaration for a_adult_test_item.lnkref22;
         -- missing declaration for a_adult_test_item.lnkref23;
         -- missing declaration for a_adult_test_item.lnkref24;
         -- missing declaration for a_adult_test_item.lnkref25;
         -- missing declaration for a_adult_test_item.lnkref3;
         -- missing declaration for a_adult_test_item.lnkref4;
         -- missing declaration for a_adult_test_item.lnkref5;
         -- missing declaration for a_adult_test_item.pconsent;
         -- missing declaration for a_adult_test_item.lnkons;
         -- missing declaration for a_adult_test_item.lnkref6;
         -- missing declaration for a_adult_test_item.lnkref7;
         -- missing declaration for a_adult_test_item.lnkref8;
         -- missing declaration for a_adult_test_item.lnkref9;
         -- missing declaration for a_adult_test_item.b3qfut7;
         -- missing declaration for a_adult_test_item.ben3q7;
         -- missing declaration for a_adult_test_item.ddaprog;
         -- missing declaration for a_adult_test_item.hbolng;
         -- missing declaration for a_adult_test_item.hi2qual;
         -- missing declaration for a_adult_test_item.hlpgvn01;
         -- missing declaration for a_adult_test_item.hlpgvn02;
         -- missing declaration for a_adult_test_item.hlpgvn03;
         -- missing declaration for a_adult_test_item.hlpgvn04;
         -- missing declaration for a_adult_test_item.hlpgvn05;
         -- missing declaration for a_adult_test_item.hlpgvn06;
         -- missing declaration for a_adult_test_item.hlpgvn07;
         -- missing declaration for a_adult_test_item.hlpgvn08;
         -- missing declaration for a_adult_test_item.hlpgvn09;
         -- missing declaration for a_adult_test_item.hlpgvn10;
         -- missing declaration for a_adult_test_item.hlpgvn11;
         -- missing declaration for a_adult_test_item.hlprec01;
         -- missing declaration for a_adult_test_item.hlprec02;
         -- missing declaration for a_adult_test_item.hlprec03;
         -- missing declaration for a_adult_test_item.hlprec04;
         -- missing declaration for a_adult_test_item.hlprec05;
         -- missing declaration for a_adult_test_item.hlprec06;
         -- missing declaration for a_adult_test_item.hlprec07;
         -- missing declaration for a_adult_test_item.hlprec08;
         -- missing declaration for a_adult_test_item.hlprec09;
         -- missing declaration for a_adult_test_item.hlprec10;
         -- missing declaration for a_adult_test_item.hlprec11;
         -- missing declaration for a_adult_test_item.loangvn1;
         -- missing declaration for a_adult_test_item.loangvn2;
         -- missing declaration for a_adult_test_item.loangvn3;
         -- missing declaration for a_adult_test_item.loanrec1;
         -- missing declaration for a_adult_test_item.loanrec2;
         -- missing declaration for a_adult_test_item.loanrec3;
         -- missing declaration for a_adult_test_item.alg;
         a_adult_test_item.algamt := 1010100.012 + Amount( i );
         -- missing declaration for a_adult_test_item.algpd;
         -- missing declaration for a_adult_test_item.ben4q4;
         -- missing declaration for a_adult_test_item.disdifad;
         -- missing declaration for a_adult_test_item.gross3_x;
         -- missing declaration for a_adult_test_item.cbaamt;
         -- missing declaration for a_adult_test_item.mednum;
         -- missing declaration for a_adult_test_item.medprpd;
         -- missing declaration for a_adult_test_item.medprpy;
         -- missing declaration for a_adult_test_item.medpay;
         -- missing declaration for a_adult_test_item.medrep;
         -- missing declaration for a_adult_test_item.medrpnm;
         Ukds.Frs.Adult_IO.Save( a_adult_test_item, False );         
      end loop;
      
      a_adult_test_list := Ukds.Frs.Adult_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Adult_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_adult_test_item := Ukds.Frs.Adult_List_Package.element( a_adult_test_list, i );
         Ukds.Frs.Adult_IO.Save( a_adult_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Adult_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_adult_test_item := Ukds.Frs.Adult_List_Package.element( a_adult_test_list, i );
         Ukds.Frs.Adult_IO.Delete( a_adult_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Adult_Create_Test: retrieve all records" );
      Ukds.Frs.Adult_List_Package.iterate( a_adult_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Adult_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Adult_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Adult_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Adult_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Child_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Child_List_Package.Cursor ) is 
      a_child_test_item : Ukds.Frs.Child;
      begin
         a_child_test_item := Ukds.Frs.Child_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_child_test_item ));
      end print;

   
      a_child_test_item : Ukds.Frs.Child;
      a_child_test_list : Ukds.Frs.Child_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Child_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Child_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Child_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_child_test_item.user_id := Ukds.Frs.Child_IO.Next_Free_user_id;
         a_child_test_item.edition := Ukds.Frs.Child_IO.Next_Free_edition;
         a_child_test_item.year := Ukds.Frs.Child_IO.Next_Free_year;
         a_child_test_item.sernum := Ukds.Frs.Child_IO.Next_Free_sernum;
         a_child_test_item.benunit := Ukds.Frs.Child_IO.Next_Free_benunit;
         a_child_test_item.person := Ukds.Frs.Child_IO.Next_Free_person;
         -- missing declaration for a_child_test_item.age;
         -- missing declaration for a_child_test_item.btecnow;
         -- missing declaration for a_child_test_item.c2orign;
         -- missing declaration for a_child_test_item.cameyr;
         -- missing declaration for a_child_test_item.care;
         -- missing declaration for a_child_test_item.cdaprog1;
         -- missing declaration for a_child_test_item.cdatre1;
         -- missing declaration for a_child_test_item.cdatrep1;
         -- missing declaration for a_child_test_item.cdisd01;
         -- missing declaration for a_child_test_item.cdisd02;
         -- missing declaration for a_child_test_item.cdisd03;
         -- missing declaration for a_child_test_item.cdisd04;
         -- missing declaration for a_child_test_item.cdisd05;
         -- missing declaration for a_child_test_item.cdisd06;
         -- missing declaration for a_child_test_item.cdisd07;
         -- missing declaration for a_child_test_item.cdisd08;
         -- missing declaration for a_child_test_item.cdisd09;
         -- missing declaration for a_child_test_item.cdisd10;
         -- missing declaration for a_child_test_item.cdisdifp;
         a_child_test_item.chamtern := 1010100.012 + Amount( i );
         a_child_test_item.chamttst := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.chbfd;
         a_child_test_item.chbfdamt := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.chbfdpd;
         -- missing declaration for a_child_test_item.chbfdval;
         -- missing declaration for a_child_test_item.chca;
         -- missing declaration for a_child_test_item.chcond;
         -- missing declaration for a_child_test_item.chdla1;
         -- missing declaration for a_child_test_item.chdla2;
         -- missing declaration for a_child_test_item.chealth1;
         -- missing declaration for a_child_test_item.chearns1;
         -- missing declaration for a_child_test_item.chearns2;
         -- missing declaration for a_child_test_item.chearns3;
         -- missing declaration for a_child_test_item.chema;
         a_child_test_item.chemaamt := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.chemapd;
         -- missing declaration for a_child_test_item.chlimitl;
         -- missing declaration for a_child_test_item.chpdern;
         -- missing declaration for a_child_test_item.chpdtst;
         -- missing declaration for a_child_test_item.chsave;
         a_child_test_item.chtrnamt := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.chtrnpd;
         -- missing declaration for a_child_test_item.citizen;
         -- missing declaration for a_child_test_item.citizen2;
         -- missing declaration for a_child_test_item.cohabit;
         -- missing declaration for a_child_test_item.contuk;
         -- missing declaration for a_child_test_item.convbl;
         -- missing declaration for a_child_test_item.corign;
         -- missing declaration for a_child_test_item.corigoth;
         -- missing declaration for a_child_test_item.curqual;
         -- missing declaration for a_child_test_item.cvht;
         -- missing declaration for a_child_test_item.cvpay;
         -- missing declaration for a_child_test_item.cvpd;
         -- missing declaration for a_child_test_item.degrenow;
         -- missing declaration for a_child_test_item.denrec;
         -- missing declaration for a_child_test_item.depend;
         a_child_test_item.dob := Ada.Calendar.Clock;
         -- missing declaration for a_child_test_item.dvmardf;
         -- missing declaration for a_child_test_item.eligadlt;
         -- missing declaration for a_child_test_item.eligchld;
         -- missing declaration for a_child_test_item.fted;
         -- missing declaration for a_child_test_item.x_grant;
         a_child_test_item.grtamt1 := 1010100.012 + Amount( i );
         a_child_test_item.grtamt2 := 1010100.012 + Amount( i );
         a_child_test_item.grtdir1 := 1010100.012 + Amount( i );
         a_child_test_item.grtdir2 := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.grtnum;
         -- missing declaration for a_child_test_item.grtsce1;
         -- missing declaration for a_child_test_item.grtsce2;
         a_child_test_item.grtval1 := 1010100.012 + Amount( i );
         a_child_test_item.grtval2 := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.heathch;
         -- missing declaration for a_child_test_item.hholder;
         -- missing declaration for a_child_test_item.highonow;
         -- missing declaration for a_child_test_item.hrsed;
         -- missing declaration for a_child_test_item.hsvper;
         -- missing declaration for a_child_test_item.issue;
         -- missing declaration for a_child_test_item.lareg;
         -- missing declaration for a_child_test_item.medrec;
         -- missing declaration for a_child_test_item.ms;
         -- missing declaration for a_child_test_item.nvqlenow;
         -- missing declaration for a_child_test_item.othpass;
         -- missing declaration for a_child_test_item.parent1;
         -- missing declaration for a_child_test_item.parent2;
         -- missing declaration for a_child_test_item.prox1619;
         -- missing declaration for a_child_test_item.r01;
         -- missing declaration for a_child_test_item.r02;
         -- missing declaration for a_child_test_item.r03;
         -- missing declaration for a_child_test_item.r04;
         -- missing declaration for a_child_test_item.r05;
         -- missing declaration for a_child_test_item.r06;
         -- missing declaration for a_child_test_item.r07;
         -- missing declaration for a_child_test_item.r08;
         -- missing declaration for a_child_test_item.r09;
         -- missing declaration for a_child_test_item.r10;
         -- missing declaration for a_child_test_item.r11;
         -- missing declaration for a_child_test_item.r12;
         -- missing declaration for a_child_test_item.r13;
         -- missing declaration for a_child_test_item.r14;
         -- missing declaration for a_child_test_item.reasden;
         -- missing declaration for a_child_test_item.reasmed;
         -- missing declaration for a_child_test_item.reasnhs;
         -- missing declaration for a_child_test_item.rsanow;
         -- missing declaration for a_child_test_item.sbkit;
         -- missing declaration for a_child_test_item.schchk;
         -- missing declaration for a_child_test_item.sctvnow;
         -- missing declaration for a_child_test_item.sex;
         -- missing declaration for a_child_test_item.sfvit;
         -- missing declaration for a_child_test_item.smkit;
         -- missing declaration for a_child_test_item.smlit;
         -- missing declaration for a_child_test_item.spcreg1;
         -- missing declaration for a_child_test_item.spcreg2;
         -- missing declaration for a_child_test_item.spcreg3;
         -- missing declaration for a_child_test_item.spout;
         -- missing declaration for a_child_test_item.srentamt;
         -- missing declaration for a_child_test_item.srentpd;
         -- missing declaration for a_child_test_item.totsave;
         -- missing declaration for a_child_test_item.trainee;
         -- missing declaration for a_child_test_item.typeed;
         -- missing declaration for a_child_test_item.month;
         -- missing declaration for a_child_test_item.careab;
         -- missing declaration for a_child_test_item.careah;
         -- missing declaration for a_child_test_item.carecb;
         -- missing declaration for a_child_test_item.carech;
         -- missing declaration for a_child_test_item.carecl;
         -- missing declaration for a_child_test_item.carefl;
         -- missing declaration for a_child_test_item.carefr;
         -- missing declaration for a_child_test_item.careot;
         -- missing declaration for a_child_test_item.carere;
         a_child_test_item.chearns := 1010100.012 + Amount( i );
         a_child_test_item.chincdv := 1010100.012 + Amount( i );
         a_child_test_item.chrinc := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.disactc1;
         -- missing declaration for a_child_test_item.discorc1;
         -- missing declaration for a_child_test_item.dobmonth;
         -- missing declaration for a_child_test_item.dobyear;
         a_child_test_item.fsbval := 1010100.012 + Amount( i );
         a_child_test_item.fsfvval := 1010100.012 + Amount( i );
         a_child_test_item.fsmlkval := 1010100.012 + Amount( i );
         a_child_test_item.fsmval := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.hdagech;
         a_child_test_item.heartval := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.hourab;
         -- missing declaration for a_child_test_item.hourah;
         -- missing declaration for a_child_test_item.hourcb;
         -- missing declaration for a_child_test_item.hourch;
         -- missing declaration for a_child_test_item.hourcl;
         -- missing declaration for a_child_test_item.hourfr;
         -- missing declaration for a_child_test_item.hourot;
         -- missing declaration for a_child_test_item.hourre;
         -- missing declaration for a_child_test_item.hourtot;
         -- missing declaration for a_child_test_item.hperson;
         -- missing declaration for a_child_test_item.iagegr2;
         -- missing declaration for a_child_test_item.iagegrp;
         -- missing declaration for a_child_test_item.relhrp;
         a_child_test_item.totgntch := 1010100.012 + Amount( i );
         a_child_test_item.tuacam := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.typeed2;
         -- missing declaration for a_child_test_item.uperson;
         -- missing declaration for a_child_test_item.xbonflag;
         -- missing declaration for a_child_test_item.candgnow;
         -- missing declaration for a_child_test_item.curothf;
         -- missing declaration for a_child_test_item.curothp;
         -- missing declaration for a_child_test_item.curothwv;
         -- missing declaration for a_child_test_item.gnvqnow;
         -- missing declaration for a_child_test_item.ndeplnow;
         -- missing declaration for a_child_test_item.oqualc1;
         -- missing declaration for a_child_test_item.oqualc2;
         -- missing declaration for a_child_test_item.oqualc3;
         -- missing declaration for a_child_test_item.webacnow;
         -- missing declaration for a_child_test_item.ntsctnow;
         -- missing declaration for a_child_test_item.skiwknow;
         -- missing declaration for a_child_test_item.adeduc;
         -- missing declaration for a_child_test_item.benccdis;
         -- missing declaration for a_child_test_item.cdisdif1;
         -- missing declaration for a_child_test_item.cdisdif2;
         -- missing declaration for a_child_test_item.cdisdif3;
         -- missing declaration for a_child_test_item.cdisdif4;
         -- missing declaration for a_child_test_item.cdisdif5;
         -- missing declaration for a_child_test_item.cdisdif6;
         -- missing declaration for a_child_test_item.cdisdif7;
         -- missing declaration for a_child_test_item.cdisdif8;
         a_child_test_item.chamt1 := 1010100.012 + Amount( i );
         a_child_test_item.chamt2 := 1010100.012 + Amount( i );
         a_child_test_item.chamt3 := 1010100.012 + Amount( i );
         a_child_test_item.chamt4 := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.chealth;
         -- missing declaration for a_child_test_item.chfar;
         -- missing declaration for a_child_test_item.chhr1;
         -- missing declaration for a_child_test_item.chhr2;
         -- missing declaration for a_child_test_item.chlook01;
         -- missing declaration for a_child_test_item.chlook02;
         -- missing declaration for a_child_test_item.chlook03;
         -- missing declaration for a_child_test_item.chlook04;
         -- missing declaration for a_child_test_item.chlook05;
         -- missing declaration for a_child_test_item.chlook06;
         -- missing declaration for a_child_test_item.chlook07;
         -- missing declaration for a_child_test_item.chlook08;
         -- missing declaration for a_child_test_item.chlook09;
         -- missing declaration for a_child_test_item.chlook10;
         -- missing declaration for a_child_test_item.chpay1;
         -- missing declaration for a_child_test_item.chpay2;
         -- missing declaration for a_child_test_item.chpay3;
         -- missing declaration for a_child_test_item.chprob;
         -- missing declaration for a_child_test_item.chwkern;
         -- missing declaration for a_child_test_item.chwktst;
         -- missing declaration for a_child_test_item.chyrern;
         -- missing declaration for a_child_test_item.chyrtst;
         -- missing declaration for a_child_test_item.clone;
         -- missing declaration for a_child_test_item.cost;
         -- missing declaration for a_child_test_item.dentist;
         -- missing declaration for a_child_test_item.endyr;
         -- missing declaration for a_child_test_item.eyetest;
         -- missing declaration for a_child_test_item.hosp;
         -- missing declaration for a_child_test_item.legdep;
         -- missing declaration for a_child_test_item.nhs1;
         -- missing declaration for a_child_test_item.nhs2;
         -- missing declaration for a_child_test_item.nhs3;
         -- missing declaration for a_child_test_item.prit;
         -- missing declaration for a_child_test_item.prscrpt;
         -- missing declaration for a_child_test_item.registr1;
         -- missing declaration for a_child_test_item.registr2;
         -- missing declaration for a_child_test_item.registr3;
         -- missing declaration for a_child_test_item.registr4;
         -- missing declaration for a_child_test_item.registr5;
         -- missing declaration for a_child_test_item.specs;
         -- missing declaration for a_child_test_item.startyr;
         -- missing declaration for a_child_test_item.trav;
         -- missing declaration for a_child_test_item.voucher;
         -- missing declaration for a_child_test_item.whytrav1;
         -- missing declaration for a_child_test_item.whytrav2;
         -- missing declaration for a_child_test_item.whytrav3;
         -- missing declaration for a_child_test_item.whytrav4;
         -- missing declaration for a_child_test_item.whytrav5;
         -- missing declaration for a_child_test_item.whytrav6;
         -- missing declaration for a_child_test_item.wmkit;
         -- missing declaration for a_child_test_item.chdda;
         a_child_test_item.fwmlkval := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.cddatre;
         -- missing declaration for a_child_test_item.cdisdif9;
         -- missing declaration for a_child_test_item.cddatrep;
         -- missing declaration for a_child_test_item.cfund;
         a_child_test_item.cfundh := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.cfundtp;
         a_child_test_item.fundamt1 := 1010100.012 + Amount( i );
         a_child_test_item.fundamt2 := 1010100.012 + Amount( i );
         a_child_test_item.fundamt3 := 1010100.012 + Amount( i );
         a_child_test_item.fundamt4 := 1010100.012 + Amount( i );
         a_child_test_item.fundamt5 := 1010100.012 + Amount( i );
         a_child_test_item.fundamt6 := 1010100.012 + Amount( i );
         -- missing declaration for a_child_test_item.givcfnd1;
         -- missing declaration for a_child_test_item.givcfnd2;
         -- missing declaration for a_child_test_item.givcfnd3;
         -- missing declaration for a_child_test_item.givcfnd4;
         -- missing declaration for a_child_test_item.givcfnd5;
         -- missing declaration for a_child_test_item.givcfnd6;
         -- missing declaration for a_child_test_item.cddaprg;
         -- missing declaration for a_child_test_item.disdifch;
         -- missing declaration for a_child_test_item.mednum;
         -- missing declaration for a_child_test_item.medprpd;
         -- missing declaration for a_child_test_item.medprpy;
         -- missing declaration for a_child_test_item.marital;
         Ukds.Frs.Child_IO.Save( a_child_test_item, False );         
      end loop;
      
      a_child_test_list := Ukds.Frs.Child_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Child_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_child_test_item := Ukds.Frs.Child_List_Package.element( a_child_test_list, i );
         Ukds.Frs.Child_IO.Save( a_child_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Child_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_child_test_item := Ukds.Frs.Child_List_Package.element( a_child_test_list, i );
         Ukds.Frs.Child_IO.Delete( a_child_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Child_Create_Test: retrieve all records" );
      Ukds.Frs.Child_List_Package.iterate( a_child_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Child_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Child_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Child_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Child_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Accounts_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Accounts_List_Package.Cursor ) is 
      a_accounts_test_item : Ukds.Frs.Accounts;
      begin
         a_accounts_test_item := Ukds.Frs.Accounts_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_accounts_test_item ));
      end print;

   
      a_accounts_test_item : Ukds.Frs.Accounts;
      a_accounts_test_list : Ukds.Frs.Accounts_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Accounts_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Accounts_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Accounts_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_accounts_test_item.user_id := Ukds.Frs.Accounts_IO.Next_Free_user_id;
         a_accounts_test_item.edition := Ukds.Frs.Accounts_IO.Next_Free_edition;
         a_accounts_test_item.year := Ukds.Frs.Accounts_IO.Next_Free_year;
         a_accounts_test_item.sernum := Ukds.Frs.Accounts_IO.Next_Free_sernum;
         a_accounts_test_item.benunit := Ukds.Frs.Accounts_IO.Next_Free_benunit;
         a_accounts_test_item.person := Ukds.Frs.Accounts_IO.Next_Free_person;
         a_accounts_test_item.account := Ukds.Frs.Accounts_IO.Next_Free_account;
         a_accounts_test_item.accint := 1010100.012 + Amount( i );
         -- missing declaration for a_accounts_test_item.acctax;
         -- missing declaration for a_accounts_test_item.invtax;
         -- missing declaration for a_accounts_test_item.nsamt;
         -- missing declaration for a_accounts_test_item.month;
         -- missing declaration for a_accounts_test_item.issue;
         -- missing declaration for a_accounts_test_item.gtwtot;
         Ukds.Frs.Accounts_IO.Save( a_accounts_test_item, False );         
      end loop;
      
      a_accounts_test_list := Ukds.Frs.Accounts_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Accounts_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_accounts_test_item := Ukds.Frs.Accounts_List_Package.element( a_accounts_test_list, i );
         Ukds.Frs.Accounts_IO.Save( a_accounts_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Accounts_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_accounts_test_item := Ukds.Frs.Accounts_List_Package.element( a_accounts_test_list, i );
         Ukds.Frs.Accounts_IO.Delete( a_accounts_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Accounts_Create_Test: retrieve all records" );
      Ukds.Frs.Accounts_List_Package.iterate( a_accounts_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Accounts_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Accounts_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Accounts_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Accounts_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Accouts_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Accouts_List_Package.Cursor ) is 
      a_accouts_test_item : Ukds.Frs.Accouts;
      begin
         a_accouts_test_item := Ukds.Frs.Accouts_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_accouts_test_item ));
      end print;

   
      a_accouts_test_item : Ukds.Frs.Accouts;
      a_accouts_test_list : Ukds.Frs.Accouts_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Accouts_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Accouts_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Accouts_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_accouts_test_item.user_id := Ukds.Frs.Accouts_IO.Next_Free_user_id;
         a_accouts_test_item.edition := Ukds.Frs.Accouts_IO.Next_Free_edition;
         a_accouts_test_item.year := Ukds.Frs.Accouts_IO.Next_Free_year;
         a_accouts_test_item.sernum := Ukds.Frs.Accouts_IO.Next_Free_sernum;
         a_accouts_test_item.benunit := Ukds.Frs.Accouts_IO.Next_Free_benunit;
         a_accouts_test_item.person := Ukds.Frs.Accouts_IO.Next_Free_person;
         a_accouts_test_item.account := Ukds.Frs.Accouts_IO.Next_Free_account;
         a_accouts_test_item.accint := 1010100.012 + Amount( i );
         -- missing declaration for a_accouts_test_item.acctax;
         -- missing declaration for a_accouts_test_item.invtax;
         -- missing declaration for a_accouts_test_item.issue;
         -- missing declaration for a_accouts_test_item.nsamt;
         -- missing declaration for a_accouts_test_item.month;
         Ukds.Frs.Accouts_IO.Save( a_accouts_test_item, False );         
      end loop;
      
      a_accouts_test_list := Ukds.Frs.Accouts_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Accouts_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_accouts_test_item := Ukds.Frs.Accouts_List_Package.element( a_accouts_test_list, i );
         Ukds.Frs.Accouts_IO.Save( a_accouts_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Accouts_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_accouts_test_item := Ukds.Frs.Accouts_List_Package.element( a_accouts_test_list, i );
         Ukds.Frs.Accouts_IO.Delete( a_accouts_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Accouts_Create_Test: retrieve all records" );
      Ukds.Frs.Accouts_List_Package.iterate( a_accouts_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Accouts_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Accouts_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Accouts_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Accouts_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Admin_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Admin_List_Package.Cursor ) is 
      a_admin_test_item : Ukds.Frs.Admin;
      begin
         a_admin_test_item := Ukds.Frs.Admin_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_admin_test_item ));
      end print;

   
      a_admin_test_item : Ukds.Frs.Admin;
      a_admin_test_list : Ukds.Frs.Admin_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Admin_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Admin_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Admin_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_admin_test_item.user_id := Ukds.Frs.Admin_IO.Next_Free_user_id;
         a_admin_test_item.edition := Ukds.Frs.Admin_IO.Next_Free_edition;
         a_admin_test_item.year := Ukds.Frs.Admin_IO.Next_Free_year;
         a_admin_test_item.sernum := Ukds.Frs.Admin_IO.Next_Free_sernum;
         -- missing declaration for a_admin_test_item.findhh;
         -- missing declaration for a_admin_test_item.hhsel;
         -- missing declaration for a_admin_test_item.hout;
         -- missing declaration for a_admin_test_item.ncr1;
         -- missing declaration for a_admin_test_item.ncr2;
         -- missing declaration for a_admin_test_item.ncr3;
         -- missing declaration for a_admin_test_item.ncr4;
         -- missing declaration for a_admin_test_item.ncr5;
         -- missing declaration for a_admin_test_item.ncr6;
         -- missing declaration for a_admin_test_item.ncr7;
         -- missing declaration for a_admin_test_item.refr01;
         -- missing declaration for a_admin_test_item.refr02;
         -- missing declaration for a_admin_test_item.refr03;
         -- missing declaration for a_admin_test_item.refr04;
         -- missing declaration for a_admin_test_item.refr05;
         -- missing declaration for a_admin_test_item.refr06;
         -- missing declaration for a_admin_test_item.refr07;
         -- missing declaration for a_admin_test_item.refr08;
         -- missing declaration for a_admin_test_item.refr09;
         -- missing declaration for a_admin_test_item.refr10;
         -- missing declaration for a_admin_test_item.refr11;
         -- missing declaration for a_admin_test_item.refr12;
         -- missing declaration for a_admin_test_item.refr13;
         -- missing declaration for a_admin_test_item.refr14;
         -- missing declaration for a_admin_test_item.refr15;
         -- missing declaration for a_admin_test_item.refr16;
         -- missing declaration for a_admin_test_item.refr17;
         -- missing declaration for a_admin_test_item.refr18;
         -- missing declaration for a_admin_test_item.tnc;
         -- missing declaration for a_admin_test_item.version;
         -- missing declaration for a_admin_test_item.month;
         -- missing declaration for a_admin_test_item.issue;
         -- missing declaration for a_admin_test_item.lngdf01;
         -- missing declaration for a_admin_test_item.lngdf02;
         -- missing declaration for a_admin_test_item.lngdf03;
         -- missing declaration for a_admin_test_item.lngdf04;
         -- missing declaration for a_admin_test_item.lngdf05;
         -- missing declaration for a_admin_test_item.lngdf06;
         -- missing declaration for a_admin_test_item.lngdf07;
         -- missing declaration for a_admin_test_item.lngdf08;
         -- missing declaration for a_admin_test_item.lngdf09;
         -- missing declaration for a_admin_test_item.lngdf10;
         -- missing declaration for a_admin_test_item.nmtrans;
         -- missing declaration for a_admin_test_item.noneng;
         -- missing declaration for a_admin_test_item.whlang01;
         -- missing declaration for a_admin_test_item.whlang02;
         -- missing declaration for a_admin_test_item.whlang03;
         -- missing declaration for a_admin_test_item.whlang04;
         -- missing declaration for a_admin_test_item.whlang05;
         -- missing declaration for a_admin_test_item.whlang06;
         -- missing declaration for a_admin_test_item.whlang07;
         -- missing declaration for a_admin_test_item.whlang08;
         -- missing declaration for a_admin_test_item.whlang09;
         -- missing declaration for a_admin_test_item.whlang10;
         -- missing declaration for a_admin_test_item.whotran1;
         -- missing declaration for a_admin_test_item.whotran2;
         -- missing declaration for a_admin_test_item.whotran3;
         -- missing declaration for a_admin_test_item.whotran4;
         -- missing declaration for a_admin_test_item.whotran5;
         -- missing declaration for a_admin_test_item.lngdf11;
         -- missing declaration for a_admin_test_item.whlang11;
         Ukds.Frs.Admin_IO.Save( a_admin_test_item, False );         
      end loop;
      
      a_admin_test_list := Ukds.Frs.Admin_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Admin_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_admin_test_item := Ukds.Frs.Admin_List_Package.element( a_admin_test_list, i );
         Ukds.Frs.Admin_IO.Save( a_admin_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Admin_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_admin_test_item := Ukds.Frs.Admin_List_Package.element( a_admin_test_list, i );
         Ukds.Frs.Admin_IO.Delete( a_admin_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Admin_Create_Test: retrieve all records" );
      Ukds.Frs.Admin_List_Package.iterate( a_admin_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Admin_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Admin_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Admin_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Admin_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Assets_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Assets_List_Package.Cursor ) is 
      a_assets_test_item : Ukds.Frs.Assets;
      begin
         a_assets_test_item := Ukds.Frs.Assets_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_assets_test_item ));
      end print;

   
      a_assets_test_item : Ukds.Frs.Assets;
      a_assets_test_list : Ukds.Frs.Assets_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Assets_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Assets_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Assets_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_assets_test_item.user_id := Ukds.Frs.Assets_IO.Next_Free_user_id;
         a_assets_test_item.edition := Ukds.Frs.Assets_IO.Next_Free_edition;
         a_assets_test_item.year := Ukds.Frs.Assets_IO.Next_Free_year;
         a_assets_test_item.sernum := Ukds.Frs.Assets_IO.Next_Free_sernum;
         a_assets_test_item.benunit := Ukds.Frs.Assets_IO.Next_Free_benunit;
         a_assets_test_item.person := Ukds.Frs.Assets_IO.Next_Free_person;
         a_assets_test_item.assetype := Ukds.Frs.Assets_IO.Next_Free_assetype;
         a_assets_test_item.seq := Ukds.Frs.Assets_IO.Next_Free_seq;
         -- missing declaration for a_assets_test_item.accname;
         a_assets_test_item.x_amount := 1010100.012 + Amount( i );
         -- missing declaration for a_assets_test_item.anymon;
         -- missing declaration for a_assets_test_item.howmany;
         a_assets_test_item.howmuch := 1010100.012 + Amount( i );
         -- missing declaration for a_assets_test_item.howmuche;
         -- missing declaration for a_assets_test_item.intro;
         a_assets_test_item.issdate := Ada.Calendar.Clock;
         a_assets_test_item.issval := 1010100.012 + Amount( i );
         -- missing declaration for a_assets_test_item.pd;
         -- missing declaration for a_assets_test_item.month;
         -- missing declaration for a_assets_test_item.issue;
         Ukds.Frs.Assets_IO.Save( a_assets_test_item, False );         
      end loop;
      
      a_assets_test_list := Ukds.Frs.Assets_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Assets_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_assets_test_item := Ukds.Frs.Assets_List_Package.element( a_assets_test_list, i );
         Ukds.Frs.Assets_IO.Save( a_assets_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Assets_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_assets_test_item := Ukds.Frs.Assets_List_Package.element( a_assets_test_list, i );
         Ukds.Frs.Assets_IO.Delete( a_assets_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Assets_Create_Test: retrieve all records" );
      Ukds.Frs.Assets_List_Package.iterate( a_assets_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Assets_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Assets_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Assets_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Assets_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Benefits_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Benefits_List_Package.Cursor ) is 
      a_benefits_test_item : Ukds.Frs.Benefits;
      begin
         a_benefits_test_item := Ukds.Frs.Benefits_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_benefits_test_item ));
      end print;

   
      a_benefits_test_item : Ukds.Frs.Benefits;
      a_benefits_test_list : Ukds.Frs.Benefits_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Benefits_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Benefits_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Benefits_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_benefits_test_item.user_id := Ukds.Frs.Benefits_IO.Next_Free_user_id;
         a_benefits_test_item.edition := Ukds.Frs.Benefits_IO.Next_Free_edition;
         a_benefits_test_item.year := Ukds.Frs.Benefits_IO.Next_Free_year;
         a_benefits_test_item.counter := Ukds.Frs.Benefits_IO.Next_Free_counter;
         a_benefits_test_item.sernum := Ukds.Frs.Benefits_IO.Next_Free_sernum;
         a_benefits_test_item.benunit := Ukds.Frs.Benefits_IO.Next_Free_benunit;
         a_benefits_test_item.person := Ukds.Frs.Benefits_IO.Next_Free_person;
         a_benefits_test_item.benefit := Ukds.Frs.Benefits_IO.Next_Free_benefit;
         -- missing declaration for a_benefits_test_item.bankstmt;
         a_benefits_test_item.benamt := 1010100.012 + Amount( i );
         -- missing declaration for a_benefits_test_item.benamtdk;
         -- missing declaration for a_benefits_test_item.benlettr;
         -- missing declaration for a_benefits_test_item.benpd;
         -- missing declaration for a_benefits_test_item.bookcard;
         -- missing declaration for a_benefits_test_item.cctc;
         a_benefits_test_item.combamt := 1010100.012 + Amount( i );
         -- missing declaration for a_benefits_test_item.combbk;
         -- missing declaration for a_benefits_test_item.combpd;
         -- missing declaration for a_benefits_test_item.howben;
         a_benefits_test_item.notusamt := 1010100.012 + Amount( i );
         -- missing declaration for a_benefits_test_item.notuspd;
         -- missing declaration for a_benefits_test_item.numweeks;
         -- missing declaration for a_benefits_test_item.ordbkno;
         -- missing declaration for a_benefits_test_item.payslipb;
         -- missing declaration for a_benefits_test_item.pres;
         -- missing declaration for a_benefits_test_item.usual;
         -- missing declaration for a_benefits_test_item.var1;
         -- missing declaration for a_benefits_test_item.var2;
         -- missing declaration for a_benefits_test_item.var3;
         -- missing declaration for a_benefits_test_item.whorec1;
         -- missing declaration for a_benefits_test_item.whorec2;
         -- missing declaration for a_benefits_test_item.whorec3;
         -- missing declaration for a_benefits_test_item.whorec4;
         -- missing declaration for a_benefits_test_item.whorec5;
         -- missing declaration for a_benefits_test_item.month;
         -- missing declaration for a_benefits_test_item.issue;
         -- missing declaration for a_benefits_test_item.numyears;
         a_benefits_test_item.ttbprx := 1010100.012 + Amount( i );
         -- missing declaration for a_benefits_test_item.var4;
         -- missing declaration for a_benefits_test_item.var5;
         -- missing declaration for a_benefits_test_item.gtanet;
         a_benefits_test_item.gtatax := 1010100.012 + Amount( i );
         -- missing declaration for a_benefits_test_item.cbpaye;
         -- missing declaration for a_benefits_test_item.cbtax;
         a_benefits_test_item.cbtaxamt := 1010100.012 + Amount( i );
         -- missing declaration for a_benefits_test_item.cbtaxpd;
         Ukds.Frs.Benefits_IO.Save( a_benefits_test_item, False );         
      end loop;
      
      a_benefits_test_list := Ukds.Frs.Benefits_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Benefits_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_benefits_test_item := Ukds.Frs.Benefits_List_Package.element( a_benefits_test_list, i );
         Ukds.Frs.Benefits_IO.Save( a_benefits_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Benefits_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_benefits_test_item := Ukds.Frs.Benefits_List_Package.element( a_benefits_test_list, i );
         Ukds.Frs.Benefits_IO.Delete( a_benefits_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Benefits_Create_Test: retrieve all records" );
      Ukds.Frs.Benefits_List_Package.iterate( a_benefits_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Benefits_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Benefits_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Benefits_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Benefits_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Care_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Care_List_Package.Cursor ) is 
      a_care_test_item : Ukds.Frs.Care;
      begin
         a_care_test_item := Ukds.Frs.Care_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_care_test_item ));
      end print;

   
      a_care_test_item : Ukds.Frs.Care;
      a_care_test_list : Ukds.Frs.Care_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Care_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Care_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Care_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_care_test_item.user_id := Ukds.Frs.Care_IO.Next_Free_user_id;
         a_care_test_item.edition := Ukds.Frs.Care_IO.Next_Free_edition;
         a_care_test_item.year := Ukds.Frs.Care_IO.Next_Free_year;
         a_care_test_item.counter := Ukds.Frs.Care_IO.Next_Free_counter;
         a_care_test_item.sernum := Ukds.Frs.Care_IO.Next_Free_sernum;
         a_care_test_item.benunit := Ukds.Frs.Care_IO.Next_Free_benunit;
         -- missing declaration for a_care_test_item.needper;
         -- missing declaration for a_care_test_item.daynight;
         -- missing declaration for a_care_test_item.freq;
         -- missing declaration for a_care_test_item.hour01;
         -- missing declaration for a_care_test_item.hour02;
         -- missing declaration for a_care_test_item.hour03;
         -- missing declaration for a_care_test_item.hour04;
         -- missing declaration for a_care_test_item.hour05;
         -- missing declaration for a_care_test_item.hour06;
         -- missing declaration for a_care_test_item.hour07;
         -- missing declaration for a_care_test_item.hour08;
         -- missing declaration for a_care_test_item.hour09;
         -- missing declaration for a_care_test_item.hour10;
         -- missing declaration for a_care_test_item.hour11;
         -- missing declaration for a_care_test_item.hour12;
         -- missing declaration for a_care_test_item.hour13;
         -- missing declaration for a_care_test_item.hour14;
         -- missing declaration for a_care_test_item.hour15;
         -- missing declaration for a_care_test_item.hour16;
         -- missing declaration for a_care_test_item.hour17;
         -- missing declaration for a_care_test_item.hour18;
         -- missing declaration for a_care_test_item.hour19;
         -- missing declaration for a_care_test_item.hour20;
         -- missing declaration for a_care_test_item.wholoo01;
         -- missing declaration for a_care_test_item.wholoo02;
         -- missing declaration for a_care_test_item.wholoo03;
         -- missing declaration for a_care_test_item.wholoo04;
         -- missing declaration for a_care_test_item.wholoo05;
         -- missing declaration for a_care_test_item.wholoo06;
         -- missing declaration for a_care_test_item.wholoo07;
         -- missing declaration for a_care_test_item.wholoo08;
         -- missing declaration for a_care_test_item.wholoo09;
         -- missing declaration for a_care_test_item.wholoo10;
         -- missing declaration for a_care_test_item.wholoo11;
         -- missing declaration for a_care_test_item.wholoo12;
         -- missing declaration for a_care_test_item.wholoo13;
         -- missing declaration for a_care_test_item.wholoo14;
         -- missing declaration for a_care_test_item.wholoo15;
         -- missing declaration for a_care_test_item.wholoo16;
         -- missing declaration for a_care_test_item.wholoo17;
         -- missing declaration for a_care_test_item.wholoo18;
         -- missing declaration for a_care_test_item.wholoo19;
         -- missing declaration for a_care_test_item.wholoo20;
         -- missing declaration for a_care_test_item.month;
         -- missing declaration for a_care_test_item.howlng01;
         -- missing declaration for a_care_test_item.howlng02;
         -- missing declaration for a_care_test_item.howlng03;
         -- missing declaration for a_care_test_item.howlng04;
         -- missing declaration for a_care_test_item.howlng05;
         -- missing declaration for a_care_test_item.howlng06;
         -- missing declaration for a_care_test_item.howlng07;
         -- missing declaration for a_care_test_item.howlng08;
         -- missing declaration for a_care_test_item.howlng09;
         -- missing declaration for a_care_test_item.howlng10;
         -- missing declaration for a_care_test_item.howlng11;
         -- missing declaration for a_care_test_item.howlng12;
         -- missing declaration for a_care_test_item.howlng13;
         -- missing declaration for a_care_test_item.howlng14;
         -- missing declaration for a_care_test_item.howlng15;
         -- missing declaration for a_care_test_item.howlng16;
         -- missing declaration for a_care_test_item.howlng17;
         -- missing declaration for a_care_test_item.howlng18;
         -- missing declaration for a_care_test_item.howlng19;
         -- missing declaration for a_care_test_item.howlng20;
         -- missing declaration for a_care_test_item.issue;
         Ukds.Frs.Care_IO.Save( a_care_test_item, False );         
      end loop;
      
      a_care_test_list := Ukds.Frs.Care_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Care_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_care_test_item := Ukds.Frs.Care_List_Package.element( a_care_test_list, i );
         Ukds.Frs.Care_IO.Save( a_care_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Care_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_care_test_item := Ukds.Frs.Care_List_Package.element( a_care_test_list, i );
         Ukds.Frs.Care_IO.Delete( a_care_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Care_Create_Test: retrieve all records" );
      Ukds.Frs.Care_List_Package.iterate( a_care_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Care_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Care_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Care_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Care_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Childcare_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Childcare_List_Package.Cursor ) is 
      a_childcare_test_item : Ukds.Frs.Childcare;
      begin
         a_childcare_test_item := Ukds.Frs.Childcare_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_childcare_test_item ));
      end print;

   
      a_childcare_test_item : Ukds.Frs.Childcare;
      a_childcare_test_list : Ukds.Frs.Childcare_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Childcare_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Childcare_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Childcare_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_childcare_test_item.user_id := Ukds.Frs.Childcare_IO.Next_Free_user_id;
         a_childcare_test_item.edition := Ukds.Frs.Childcare_IO.Next_Free_edition;
         a_childcare_test_item.year := Ukds.Frs.Childcare_IO.Next_Free_year;
         a_childcare_test_item.sernum := Ukds.Frs.Childcare_IO.Next_Free_sernum;
         a_childcare_test_item.benunit := Ukds.Frs.Childcare_IO.Next_Free_benunit;
         a_childcare_test_item.person := Ukds.Frs.Childcare_IO.Next_Free_person;
         a_childcare_test_item.chlook := Ukds.Frs.Childcare_IO.Next_Free_chlook;
         a_childcare_test_item.chamt := 1010100.012 + Amount( i );
         -- missing declaration for a_childcare_test_item.chhr;
         -- missing declaration for a_childcare_test_item.chpd;
         -- missing declaration for a_childcare_test_item.cost;
         -- missing declaration for a_childcare_test_item.emplprov;
         -- missing declaration for a_childcare_test_item.issue;
         -- missing declaration for a_childcare_test_item.registrd;
         -- missing declaration for a_childcare_test_item.month;
         Ukds.Frs.Childcare_IO.Save( a_childcare_test_item, False );         
      end loop;
      
      a_childcare_test_list := Ukds.Frs.Childcare_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Childcare_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_childcare_test_item := Ukds.Frs.Childcare_List_Package.element( a_childcare_test_list, i );
         Ukds.Frs.Childcare_IO.Save( a_childcare_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Childcare_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_childcare_test_item := Ukds.Frs.Childcare_List_Package.element( a_childcare_test_list, i );
         Ukds.Frs.Childcare_IO.Delete( a_childcare_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Childcare_Create_Test: retrieve all records" );
      Ukds.Frs.Childcare_List_Package.iterate( a_childcare_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Childcare_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Childcare_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Childcare_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Childcare_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Chldcare_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Chldcare_List_Package.Cursor ) is 
      a_chldcare_test_item : Ukds.Frs.Chldcare;
      begin
         a_chldcare_test_item := Ukds.Frs.Chldcare_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_chldcare_test_item ));
      end print;

   
      a_chldcare_test_item : Ukds.Frs.Chldcare;
      a_chldcare_test_list : Ukds.Frs.Chldcare_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Chldcare_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Chldcare_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Chldcare_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_chldcare_test_item.user_id := Ukds.Frs.Chldcare_IO.Next_Free_user_id;
         a_chldcare_test_item.edition := Ukds.Frs.Chldcare_IO.Next_Free_edition;
         a_chldcare_test_item.year := Ukds.Frs.Chldcare_IO.Next_Free_year;
         a_chldcare_test_item.sernum := Ukds.Frs.Chldcare_IO.Next_Free_sernum;
         a_chldcare_test_item.benunit := Ukds.Frs.Chldcare_IO.Next_Free_benunit;
         a_chldcare_test_item.person := Ukds.Frs.Chldcare_IO.Next_Free_person;
         a_chldcare_test_item.chlook := Ukds.Frs.Chldcare_IO.Next_Free_chlook;
         -- missing declaration for a_chldcare_test_item.benccdis;
         a_chldcare_test_item.chamt := 1010100.012 + Amount( i );
         -- missing declaration for a_chldcare_test_item.chfar;
         -- missing declaration for a_chldcare_test_item.chhr;
         -- missing declaration for a_chldcare_test_item.chinknd1;
         -- missing declaration for a_chldcare_test_item.chinknd2;
         -- missing declaration for a_chldcare_test_item.chinknd3;
         -- missing declaration for a_chldcare_test_item.chinknd4;
         -- missing declaration for a_chldcare_test_item.chinknd5;
         -- missing declaration for a_chldcare_test_item.chpd;
         -- missing declaration for a_chldcare_test_item.cost;
         -- missing declaration for a_chldcare_test_item.ctrm;
         -- missing declaration for a_chldcare_test_item.emplprov;
         -- missing declaration for a_chldcare_test_item.registrd;
         -- missing declaration for a_chldcare_test_item.month;
         -- missing declaration for a_chldcare_test_item.pmchk;
         -- missing declaration for a_chldcare_test_item.issue;
         -- missing declaration for a_chldcare_test_item.hourly;
         -- missing declaration for a_chldcare_test_item.freecc;
         -- missing declaration for a_chldcare_test_item.freccty1;
         -- missing declaration for a_chldcare_test_item.freccty2;
         -- missing declaration for a_chldcare_test_item.freccty3;
         -- missing declaration for a_chldcare_test_item.freccty4;
         -- missing declaration for a_chldcare_test_item.freccty5;
         -- missing declaration for a_chldcare_test_item.freccty6;
         Ukds.Frs.Chldcare_IO.Save( a_chldcare_test_item, False );         
      end loop;
      
      a_chldcare_test_list := Ukds.Frs.Chldcare_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Chldcare_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_chldcare_test_item := Ukds.Frs.Chldcare_List_Package.element( a_chldcare_test_list, i );
         Ukds.Frs.Chldcare_IO.Save( a_chldcare_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Chldcare_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_chldcare_test_item := Ukds.Frs.Chldcare_List_Package.element( a_chldcare_test_list, i );
         Ukds.Frs.Chldcare_IO.Delete( a_chldcare_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Chldcare_Create_Test: retrieve all records" );
      Ukds.Frs.Chldcare_List_Package.iterate( a_chldcare_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Chldcare_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Chldcare_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Chldcare_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Chldcare_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Endowmnt_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Endowmnt_List_Package.Cursor ) is 
      a_endowmnt_test_item : Ukds.Frs.Endowmnt;
      begin
         a_endowmnt_test_item := Ukds.Frs.Endowmnt_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_endowmnt_test_item ));
      end print;

   
      a_endowmnt_test_item : Ukds.Frs.Endowmnt;
      a_endowmnt_test_list : Ukds.Frs.Endowmnt_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Endowmnt_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Endowmnt_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Endowmnt_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_endowmnt_test_item.user_id := Ukds.Frs.Endowmnt_IO.Next_Free_user_id;
         a_endowmnt_test_item.edition := Ukds.Frs.Endowmnt_IO.Next_Free_edition;
         a_endowmnt_test_item.year := Ukds.Frs.Endowmnt_IO.Next_Free_year;
         a_endowmnt_test_item.sernum := Ukds.Frs.Endowmnt_IO.Next_Free_sernum;
         a_endowmnt_test_item.mortseq := Ukds.Frs.Endowmnt_IO.Next_Free_mortseq;
         a_endowmnt_test_item.endowseq := Ukds.Frs.Endowmnt_IO.Next_Free_endowseq;
         -- missing declaration for a_endowmnt_test_item.incinint;
         a_endowmnt_test_item.menpolam := 1010100.012 + Amount( i );
         -- missing declaration for a_endowmnt_test_item.menpolpd;
         -- missing declaration for a_endowmnt_test_item.menstyr;
         -- missing declaration for a_endowmnt_test_item.month;
         -- missing declaration for a_endowmnt_test_item.issue;
         Ukds.Frs.Endowmnt_IO.Save( a_endowmnt_test_item, False );         
      end loop;
      
      a_endowmnt_test_list := Ukds.Frs.Endowmnt_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Endowmnt_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_endowmnt_test_item := Ukds.Frs.Endowmnt_List_Package.element( a_endowmnt_test_list, i );
         Ukds.Frs.Endowmnt_IO.Save( a_endowmnt_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Endowmnt_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_endowmnt_test_item := Ukds.Frs.Endowmnt_List_Package.element( a_endowmnt_test_list, i );
         Ukds.Frs.Endowmnt_IO.Delete( a_endowmnt_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Endowmnt_Create_Test: retrieve all records" );
      Ukds.Frs.Endowmnt_List_Package.iterate( a_endowmnt_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Endowmnt_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Endowmnt_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Endowmnt_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Endowmnt_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Extchild_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Extchild_List_Package.Cursor ) is 
      a_extchild_test_item : Ukds.Frs.Extchild;
      begin
         a_extchild_test_item := Ukds.Frs.Extchild_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_extchild_test_item ));
      end print;

   
      a_extchild_test_item : Ukds.Frs.Extchild;
      a_extchild_test_list : Ukds.Frs.Extchild_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Extchild_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Extchild_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Extchild_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_extchild_test_item.user_id := Ukds.Frs.Extchild_IO.Next_Free_user_id;
         a_extchild_test_item.edition := Ukds.Frs.Extchild_IO.Next_Free_edition;
         a_extchild_test_item.year := Ukds.Frs.Extchild_IO.Next_Free_year;
         a_extchild_test_item.sernum := Ukds.Frs.Extchild_IO.Next_Free_sernum;
         a_extchild_test_item.benunit := Ukds.Frs.Extchild_IO.Next_Free_benunit;
         a_extchild_test_item.extseq := Ukds.Frs.Extchild_IO.Next_Free_extseq;
         a_extchild_test_item.nhhamt := 1010100.012 + Amount( i );
         -- missing declaration for a_extchild_test_item.nhhfee;
         -- missing declaration for a_extchild_test_item.nhhintro;
         -- missing declaration for a_extchild_test_item.nhhpd;
         -- missing declaration for a_extchild_test_item.month;
         -- missing declaration for a_extchild_test_item.issue;
         Ukds.Frs.Extchild_IO.Save( a_extchild_test_item, False );         
      end loop;
      
      a_extchild_test_list := Ukds.Frs.Extchild_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Extchild_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_extchild_test_item := Ukds.Frs.Extchild_List_Package.element( a_extchild_test_list, i );
         Ukds.Frs.Extchild_IO.Save( a_extchild_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Extchild_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_extchild_test_item := Ukds.Frs.Extchild_List_Package.element( a_extchild_test_list, i );
         Ukds.Frs.Extchild_IO.Delete( a_extchild_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Extchild_Create_Test: retrieve all records" );
      Ukds.Frs.Extchild_List_Package.iterate( a_extchild_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Extchild_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Extchild_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Extchild_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Extchild_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Govpay_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Govpay_List_Package.Cursor ) is 
      a_govpay_test_item : Ukds.Frs.Govpay;
      begin
         a_govpay_test_item := Ukds.Frs.Govpay_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_govpay_test_item ));
      end print;

   
      a_govpay_test_item : Ukds.Frs.Govpay;
      a_govpay_test_list : Ukds.Frs.Govpay_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Govpay_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Govpay_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Govpay_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_govpay_test_item.user_id := Ukds.Frs.Govpay_IO.Next_Free_user_id;
         a_govpay_test_item.edition := Ukds.Frs.Govpay_IO.Next_Free_edition;
         a_govpay_test_item.year := Ukds.Frs.Govpay_IO.Next_Free_year;
         a_govpay_test_item.counter := Ukds.Frs.Govpay_IO.Next_Free_counter;
         a_govpay_test_item.sernum := Ukds.Frs.Govpay_IO.Next_Free_sernum;
         a_govpay_test_item.benunit := Ukds.Frs.Govpay_IO.Next_Free_benunit;
         a_govpay_test_item.person := Ukds.Frs.Govpay_IO.Next_Free_person;
         a_govpay_test_item.benefit := Ukds.Frs.Govpay_IO.Next_Free_benefit;
         -- missing declaration for a_govpay_test_item.govpay;
         -- missing declaration for a_govpay_test_item.month;
         -- missing declaration for a_govpay_test_item.issue;
         Ukds.Frs.Govpay_IO.Save( a_govpay_test_item, False );         
      end loop;
      
      a_govpay_test_list := Ukds.Frs.Govpay_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Govpay_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_govpay_test_item := Ukds.Frs.Govpay_List_Package.element( a_govpay_test_list, i );
         Ukds.Frs.Govpay_IO.Save( a_govpay_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Govpay_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_govpay_test_item := Ukds.Frs.Govpay_List_Package.element( a_govpay_test_list, i );
         Ukds.Frs.Govpay_IO.Delete( a_govpay_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Govpay_Create_Test: retrieve all records" );
      Ukds.Frs.Govpay_List_Package.iterate( a_govpay_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Govpay_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Govpay_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Govpay_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Govpay_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Insuranc_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Insuranc_List_Package.Cursor ) is 
      a_insuranc_test_item : Ukds.Frs.Insuranc;
      begin
         a_insuranc_test_item := Ukds.Frs.Insuranc_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_insuranc_test_item ));
      end print;

   
      a_insuranc_test_item : Ukds.Frs.Insuranc;
      a_insuranc_test_list : Ukds.Frs.Insuranc_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Insuranc_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Insuranc_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Insuranc_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_insuranc_test_item.user_id := Ukds.Frs.Insuranc_IO.Next_Free_user_id;
         a_insuranc_test_item.edition := Ukds.Frs.Insuranc_IO.Next_Free_edition;
         a_insuranc_test_item.year := Ukds.Frs.Insuranc_IO.Next_Free_year;
         a_insuranc_test_item.sernum := Ukds.Frs.Insuranc_IO.Next_Free_sernum;
         a_insuranc_test_item.insseq := Ukds.Frs.Insuranc_IO.Next_Free_insseq;
         -- missing declaration for a_insuranc_test_item.numpols1;
         -- missing declaration for a_insuranc_test_item.numpols2;
         -- missing declaration for a_insuranc_test_item.numpols3;
         -- missing declaration for a_insuranc_test_item.numpols4;
         -- missing declaration for a_insuranc_test_item.numpols5;
         -- missing declaration for a_insuranc_test_item.numpols6;
         -- missing declaration for a_insuranc_test_item.numpols7;
         -- missing declaration for a_insuranc_test_item.numpols8;
         -- missing declaration for a_insuranc_test_item.numpols9;
         a_insuranc_test_item.polamt := 1010100.012 + Amount( i );
         -- missing declaration for a_insuranc_test_item.polmore;
         -- missing declaration for a_insuranc_test_item.polpay;
         -- missing declaration for a_insuranc_test_item.polpd;
         -- missing declaration for a_insuranc_test_item.month;
         Ukds.Frs.Insuranc_IO.Save( a_insuranc_test_item, False );         
      end loop;
      
      a_insuranc_test_list := Ukds.Frs.Insuranc_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Insuranc_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_insuranc_test_item := Ukds.Frs.Insuranc_List_Package.element( a_insuranc_test_list, i );
         Ukds.Frs.Insuranc_IO.Save( a_insuranc_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Insuranc_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_insuranc_test_item := Ukds.Frs.Insuranc_List_Package.element( a_insuranc_test_list, i );
         Ukds.Frs.Insuranc_IO.Delete( a_insuranc_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Insuranc_Create_Test: retrieve all records" );
      Ukds.Frs.Insuranc_List_Package.iterate( a_insuranc_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Insuranc_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Insuranc_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Insuranc_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Insuranc_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Job_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Job_List_Package.Cursor ) is 
      a_job_test_item : Ukds.Frs.Job;
      begin
         a_job_test_item := Ukds.Frs.Job_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_job_test_item ));
      end print;

   
      a_job_test_item : Ukds.Frs.Job;
      a_job_test_list : Ukds.Frs.Job_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Job_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Job_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Job_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_job_test_item.user_id := Ukds.Frs.Job_IO.Next_Free_user_id;
         a_job_test_item.edition := Ukds.Frs.Job_IO.Next_Free_edition;
         a_job_test_item.year := Ukds.Frs.Job_IO.Next_Free_year;
         a_job_test_item.counter := Ukds.Frs.Job_IO.Next_Free_counter;
         a_job_test_item.sernum := Ukds.Frs.Job_IO.Next_Free_sernum;
         a_job_test_item.benunit := Ukds.Frs.Job_IO.Next_Free_benunit;
         a_job_test_item.person := Ukds.Frs.Job_IO.Next_Free_person;
         a_job_test_item.jobtype := Ukds.Frs.Job_IO.Next_Free_jobtype;
         -- missing declaration for a_job_test_item.agreehrs;
         a_job_test_item.bonamt1 := 1010100.012 + Amount( i );
         a_job_test_item.bonamt2 := 1010100.012 + Amount( i );
         a_job_test_item.bonamt3 := 1010100.012 + Amount( i );
         a_job_test_item.bonamt4 := 1010100.012 + Amount( i );
         a_job_test_item.bonamt5 := 1010100.012 + Amount( i );
         a_job_test_item.bonamt6 := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.bontax1;
         -- missing declaration for a_job_test_item.bontax2;
         -- missing declaration for a_job_test_item.bontax3;
         -- missing declaration for a_job_test_item.bontax4;
         -- missing declaration for a_job_test_item.bontax5;
         -- missing declaration for a_job_test_item.bontax6;
         -- missing declaration for a_job_test_item.bonus;
         -- missing declaration for a_job_test_item.busaccts;
         -- missing declaration for a_job_test_item.checktax;
         -- missing declaration for a_job_test_item.chkincom;
         a_job_test_item.dedoth := 1010100.012 + Amount( i );
         a_job_test_item.deduc1 := 1010100.012 + Amount( i );
         a_job_test_item.deduc2 := 1010100.012 + Amount( i );
         a_job_test_item.deduc3 := 1010100.012 + Amount( i );
         a_job_test_item.deduc4 := 1010100.012 + Amount( i );
         a_job_test_item.deduc5 := 1010100.012 + Amount( i );
         a_job_test_item.deduc6 := 1010100.012 + Amount( i );
         a_job_test_item.deduc7 := 1010100.012 + Amount( i );
         a_job_test_item.deduc8 := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.dirctr;
         -- missing declaration for a_job_test_item.dirni;
         -- missing declaration for a_job_test_item.dvtothru;
         a_job_test_item.dvushr := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.empany;
         -- missing declaration for a_job_test_item.empown;
         -- missing declaration for a_job_test_item.etype;
         -- missing declaration for a_job_test_item.everot;
         -- missing declaration for a_job_test_item.ftpt;
         a_job_test_item.grsofar := 1010100.012 + Amount( i );
         a_job_test_item.grwage := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.grwagpd;
         a_job_test_item.hha1 := 1010100.012 + Amount( i );
         a_job_test_item.hha2 := 1010100.012 + Amount( i );
         a_job_test_item.hha3 := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.hhc1;
         -- missing declaration for a_job_test_item.hhc2;
         -- missing declaration for a_job_test_item.hhc3;
         -- missing declaration for a_job_test_item.hohinc;
         -- missing declaration for a_job_test_item.inclpay1;
         -- missing declaration for a_job_test_item.inclpay2;
         -- missing declaration for a_job_test_item.inclpay3;
         -- missing declaration for a_job_test_item.inclpay4;
         -- missing declaration for a_job_test_item.inclpay5;
         -- missing declaration for a_job_test_item.inclpay6;
         -- missing declaration for a_job_test_item.inkind01;
         -- missing declaration for a_job_test_item.inkind02;
         -- missing declaration for a_job_test_item.inkind03;
         -- missing declaration for a_job_test_item.inkind04;
         -- missing declaration for a_job_test_item.inkind05;
         -- missing declaration for a_job_test_item.inkind06;
         -- missing declaration for a_job_test_item.inkind07;
         -- missing declaration for a_job_test_item.inkind08;
         -- missing declaration for a_job_test_item.inkind09;
         -- missing declaration for a_job_test_item.inkind10;
         -- missing declaration for a_job_test_item.inkind11;
         -- missing declaration for a_job_test_item.instype1;
         -- missing declaration for a_job_test_item.instype2;
         -- missing declaration for a_job_test_item.jobbus;
         -- missing declaration for a_job_test_item.likehr;
         -- missing declaration for a_job_test_item.mademp;
         -- missing declaration for a_job_test_item.matemp;
         -- missing declaration for a_job_test_item.matstp;
         a_job_test_item.mileamt := 1010100.012 + Amount( i );
         a_job_test_item.motamt := 1010100.012 + Amount( i );
         a_job_test_item.natins := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.nature;
         a_job_test_item.nidamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.nidpd;
         -- missing declaration for a_job_test_item.nmchc;
         -- missing declaration for a_job_test_item.nmper;
         -- missing declaration for a_job_test_item.nomor1;
         -- missing declaration for a_job_test_item.nomor2;
         -- missing declaration for a_job_test_item.nomor3;
         -- missing declaration for a_job_test_item.numemp;
         -- missing declaration for a_job_test_item.othded1;
         -- missing declaration for a_job_test_item.othded2;
         -- missing declaration for a_job_test_item.othded3;
         -- missing declaration for a_job_test_item.othded4;
         -- missing declaration for a_job_test_item.othded5;
         -- missing declaration for a_job_test_item.othded6;
         -- missing declaration for a_job_test_item.othded7;
         -- missing declaration for a_job_test_item.othded8;
         -- missing declaration for a_job_test_item.othded9;
         a_job_test_item.ownamt := 1010100.012 + Amount( i );
         a_job_test_item.ownotamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.ownother;
         -- missing declaration for a_job_test_item.ownsum;
         a_job_test_item.payamt := 1010100.012 + Amount( i );
         a_job_test_item.paydat := Ada.Calendar.Clock;
         a_job_test_item.paye := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.paypd;
         -- missing declaration for a_job_test_item.payslip;
         -- missing declaration for a_job_test_item.payusl;
         a_job_test_item.pothr := 1010100.012 + Amount( i );
         a_job_test_item.prbefore := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.profdocs;
         a_job_test_item.profit1 := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.profit2;
         -- missing declaration for a_job_test_item.profni;
         -- missing declaration for a_job_test_item.proftax;
         -- missing declaration for a_job_test_item.rspoth;
         a_job_test_item.se1 := Ada.Calendar.Clock;
         a_job_test_item.se2 := Ada.Calendar.Clock;
         a_job_test_item.seend := Ada.Calendar.Clock;
         a_job_test_item.seincamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.seincwm;
         -- missing declaration for a_job_test_item.selwks;
         a_job_test_item.seniiamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.seniinc;
         a_job_test_item.senilamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.senilump;
         a_job_test_item.seniramt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.senireg;
         -- missing declaration for a_job_test_item.senirpd;
         -- missing declaration for a_job_test_item.setax;
         a_job_test_item.setaxamt := 1010100.012 + Amount( i );
         a_job_test_item.smpamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.smprate;
         -- missing declaration for a_job_test_item.sole;
         a_job_test_item.sspamt := 1010100.012 + Amount( i );
         a_job_test_item.taxamt := 1010100.012 + Amount( i );
         a_job_test_item.taxdamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.taxdpd;
         a_job_test_item.totus1 := 1010100.012 + Amount( i );
         a_job_test_item.ubonamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.uboninc;
         a_job_test_item.udeduc1 := 1010100.012 + Amount( i );
         a_job_test_item.udeduc2 := 1010100.012 + Amount( i );
         a_job_test_item.udeduc3 := 1010100.012 + Amount( i );
         a_job_test_item.udeduc4 := 1010100.012 + Amount( i );
         a_job_test_item.udeduc5 := 1010100.012 + Amount( i );
         a_job_test_item.udeduc6 := 1010100.012 + Amount( i );
         a_job_test_item.udeduc7 := 1010100.012 + Amount( i );
         a_job_test_item.udeduc8 := 1010100.012 + Amount( i );
         a_job_test_item.ugross := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.uincpay1;
         -- missing declaration for a_job_test_item.uincpay2;
         -- missing declaration for a_job_test_item.uincpay3;
         -- missing declaration for a_job_test_item.uincpay4;
         -- missing declaration for a_job_test_item.uincpay5;
         -- missing declaration for a_job_test_item.uincpay6;
         a_job_test_item.umileamt := 1010100.012 + Amount( i );
         a_job_test_item.umotamt := 1010100.012 + Amount( i );
         a_job_test_item.unett := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.uothded1;
         -- missing declaration for a_job_test_item.uothded2;
         -- missing declaration for a_job_test_item.uothded3;
         -- missing declaration for a_job_test_item.uothded4;
         -- missing declaration for a_job_test_item.uothded5;
         -- missing declaration for a_job_test_item.uothded6;
         -- missing declaration for a_job_test_item.uothded7;
         -- missing declaration for a_job_test_item.uothded8;
         -- missing declaration for a_job_test_item.uothded9;
         a_job_test_item.uothdtot := 1010100.012 + Amount( i );
         a_job_test_item.uothr := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.upd;
         a_job_test_item.usmpamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.usmprate;
         a_job_test_item.usspamt := 1010100.012 + Amount( i );
         a_job_test_item.usuhr := 1010100.012 + Amount( i );
         a_job_test_item.utaxamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.watdid;
         -- missing declaration for a_job_test_item.watprev;
         -- missing declaration for a_job_test_item.x_where;
         -- missing declaration for a_job_test_item.whynopro;
         -- missing declaration for a_job_test_item.whynou01;
         -- missing declaration for a_job_test_item.whynou02;
         -- missing declaration for a_job_test_item.whynou03;
         -- missing declaration for a_job_test_item.whynou04;
         -- missing declaration for a_job_test_item.whynou05;
         -- missing declaration for a_job_test_item.whynou06;
         -- missing declaration for a_job_test_item.whynou07;
         -- missing declaration for a_job_test_item.whynou08;
         -- missing declaration for a_job_test_item.whynou09;
         -- missing declaration for a_job_test_item.whynou10;
         -- missing declaration for a_job_test_item.whynou11;
         -- missing declaration for a_job_test_item.workacc;
         -- missing declaration for a_job_test_item.workmth;
         -- missing declaration for a_job_test_item.workyr;
         -- missing declaration for a_job_test_item.month;
         -- missing declaration for a_job_test_item.hdqhrs;
         a_job_test_item.jobhours := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.sspsmpfg;
         a_job_test_item.ugrspay := To_Unbounded_String("dat forugrspay" & i'Img );
         -- missing declaration for a_job_test_item.inclpay7;
         -- missing declaration for a_job_test_item.inclpay8;
         -- missing declaration for a_job_test_item.paperiod;
         -- missing declaration for a_job_test_item.ppperiod;
         a_job_test_item.sapamt := 1010100.012 + Amount( i );
         a_job_test_item.sppamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.uincpay7;
         -- missing declaration for a_job_test_item.uincpay8;
         -- missing declaration for a_job_test_item.usapamt;
         a_job_test_item.usppamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.inkind12;
         -- missing declaration for a_job_test_item.inkind13;
         -- missing declaration for a_job_test_item.salsac;
         a_job_test_item.chvamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.chvpd;
         -- missing declaration for a_job_test_item.chvsac;
         a_job_test_item.chvuamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.chvupd;
         -- missing declaration for a_job_test_item.chvusu;
         -- missing declaration for a_job_test_item.expben01;
         -- missing declaration for a_job_test_item.expben02;
         -- missing declaration for a_job_test_item.expben03;
         -- missing declaration for a_job_test_item.expben04;
         -- missing declaration for a_job_test_item.expben05;
         -- missing declaration for a_job_test_item.expben06;
         -- missing declaration for a_job_test_item.expben07;
         -- missing declaration for a_job_test_item.expben08;
         -- missing declaration for a_job_test_item.expben09;
         -- missing declaration for a_job_test_item.expben10;
         -- missing declaration for a_job_test_item.expben11;
         -- missing declaration for a_job_test_item.expben12;
         a_job_test_item.fuelamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.fuelbn;
         -- missing declaration for a_job_test_item.fuelpd;
         a_job_test_item.fueluamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.fuelupd;
         -- missing declaration for a_job_test_item.fuelusu;
         -- missing declaration for a_job_test_item.issue;
         -- missing declaration for a_job_test_item.prevmth;
         -- missing declaration for a_job_test_item.prevyr;
         a_job_test_item.spnamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.spnpd;
         -- missing declaration for a_job_test_item.spnsac;
         a_job_test_item.spnuamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.spnupd;
         -- missing declaration for a_job_test_item.spnusu;
         a_job_test_item.vchamt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.vchpd;
         -- missing declaration for a_job_test_item.vchsac;
         -- missing declaration for a_job_test_item.vchuamt;
         -- missing declaration for a_job_test_item.vchupd;
         -- missing declaration for a_job_test_item.vchusu;
         -- missing declaration for a_job_test_item.wrkprev;
         a_job_test_item.caramt := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.carcon;
         -- missing declaration for a_job_test_item.carval;
         -- missing declaration for a_job_test_item.fueltyp;
         -- missing declaration for a_job_test_item.orgemp;
         -- missing declaration for a_job_test_item.sector;
         -- missing declaration for a_job_test_item.sectrnp;
         -- missing declaration for a_job_test_item.whynou12;
         -- missing declaration for a_job_test_item.whynou13;
         -- missing declaration for a_job_test_item.whynou14;
         -- missing declaration for a_job_test_item.jobsect;
         -- missing declaration for a_job_test_item.oremp;
         a_job_test_item.bontxam1 := 1010100.012 + Amount( i );
         a_job_test_item.bontxam2 := 1010100.012 + Amount( i );
         a_job_test_item.bontxam3 := 1010100.012 + Amount( i );
         a_job_test_item.bontxam4 := 1010100.012 + Amount( i );
         a_job_test_item.bontxam5 := 1010100.012 + Amount( i );
         a_job_test_item.bontxam6 := 1010100.012 + Amount( i );
         a_job_test_item.deduc9 := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.emplany;
         -- missing declaration for a_job_test_item.empten;
         -- missing declaration for a_job_test_item.lthan30;
         -- missing declaration for a_job_test_item.numeten;
         -- missing declaration for a_job_test_item.othded01;
         -- missing declaration for a_job_test_item.othded02;
         -- missing declaration for a_job_test_item.othded03;
         -- missing declaration for a_job_test_item.othded04;
         -- missing declaration for a_job_test_item.othded05;
         -- missing declaration for a_job_test_item.othded06;
         -- missing declaration for a_job_test_item.othded07;
         -- missing declaration for a_job_test_item.othded08;
         -- missing declaration for a_job_test_item.othded09;
         -- missing declaration for a_job_test_item.othded10;
         a_job_test_item.udeduc9 := 1010100.012 + Amount( i );
         -- missing declaration for a_job_test_item.uothde01;
         -- missing declaration for a_job_test_item.uothde02;
         -- missing declaration for a_job_test_item.uothde03;
         -- missing declaration for a_job_test_item.uothde04;
         -- missing declaration for a_job_test_item.uothde05;
         -- missing declaration for a_job_test_item.uothde06;
         -- missing declaration for a_job_test_item.uothde07;
         -- missing declaration for a_job_test_item.uothde08;
         -- missing declaration for a_job_test_item.uothde09;
         -- missing declaration for a_job_test_item.uothde10;
         -- missing declaration for a_job_test_item.yjbchang;
         -- missing declaration for a_job_test_item.jbchnge;
         -- missing declaration for a_job_test_item.hourly;
         -- missing declaration for a_job_test_item.hrexa;
         -- missing declaration for a_job_test_item.hrexb;
         -- missing declaration for a_job_test_item.hrexc1;
         -- missing declaration for a_job_test_item.hrexc2;
         -- missing declaration for a_job_test_item.hrexc3;
         -- missing declaration for a_job_test_item.hrexc4;
         -- missing declaration for a_job_test_item.hrexc5;
         -- missing declaration for a_job_test_item.hrexc6;
         -- missing declaration for a_job_test_item.hrexc7;
         -- missing declaration for a_job_test_item.hrexc8;
         a_job_test_item.hrrate := 1010100.012 + Amount( i );
         Ukds.Frs.Job_IO.Save( a_job_test_item, False );         
      end loop;
      
      a_job_test_list := Ukds.Frs.Job_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Job_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_job_test_item := Ukds.Frs.Job_List_Package.element( a_job_test_list, i );
         a_job_test_item.ugrspay := To_Unbounded_String("Altered::dat forugrspay" & i'Img);
         Ukds.Frs.Job_IO.Save( a_job_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Job_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_job_test_item := Ukds.Frs.Job_List_Package.element( a_job_test_list, i );
         Ukds.Frs.Job_IO.Delete( a_job_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Job_Create_Test: retrieve all records" );
      Ukds.Frs.Job_List_Package.iterate( a_job_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Job_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Job_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Job_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Job_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Maint_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Maint_List_Package.Cursor ) is 
      a_maint_test_item : Ukds.Frs.Maint;
      begin
         a_maint_test_item := Ukds.Frs.Maint_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_maint_test_item ));
      end print;

   
      a_maint_test_item : Ukds.Frs.Maint;
      a_maint_test_list : Ukds.Frs.Maint_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Maint_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Maint_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Maint_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_maint_test_item.user_id := Ukds.Frs.Maint_IO.Next_Free_user_id;
         a_maint_test_item.edition := Ukds.Frs.Maint_IO.Next_Free_edition;
         a_maint_test_item.year := Ukds.Frs.Maint_IO.Next_Free_year;
         a_maint_test_item.sernum := Ukds.Frs.Maint_IO.Next_Free_sernum;
         a_maint_test_item.benunit := Ukds.Frs.Maint_IO.Next_Free_benunit;
         a_maint_test_item.person := Ukds.Frs.Maint_IO.Next_Free_person;
         a_maint_test_item.maintseq := Ukds.Frs.Maint_IO.Next_Free_maintseq;
         -- missing declaration for a_maint_test_item.m;
         -- missing declaration for a_maint_test_item.mrage;
         a_maint_test_item.mramt := 1010100.012 + Amount( i );
         -- missing declaration for a_maint_test_item.mrchwhy1;
         -- missing declaration for a_maint_test_item.mrchwhy2;
         -- missing declaration for a_maint_test_item.mrchwhy3;
         -- missing declaration for a_maint_test_item.mrchwhy4;
         -- missing declaration for a_maint_test_item.mrchwhy5;
         -- missing declaration for a_maint_test_item.mrchwhy6;
         -- missing declaration for a_maint_test_item.mrchwhy7;
         -- missing declaration for a_maint_test_item.mrchwhy8;
         -- missing declaration for a_maint_test_item.mrchwhy9;
         -- missing declaration for a_maint_test_item.mrct;
         -- missing declaration for a_maint_test_item.mrkid;
         -- missing declaration for a_maint_test_item.mrpd;
         -- missing declaration for a_maint_test_item.mrr;
         a_maint_test_item.mruamt := 1010100.012 + Amount( i );
         -- missing declaration for a_maint_test_item.mrupd;
         -- missing declaration for a_maint_test_item.mrus;
         -- missing declaration for a_maint_test_item.mrv;
         -- missing declaration for a_maint_test_item.month;
         -- missing declaration for a_maint_test_item.issue;
         -- missing declaration for a_maint_test_item.mrarr1;
         -- missing declaration for a_maint_test_item.mrarr2;
         -- missing declaration for a_maint_test_item.mrarr3;
         -- missing declaration for a_maint_test_item.mrarr4;
         -- missing declaration for a_maint_test_item.mrarr5;
         Ukds.Frs.Maint_IO.Save( a_maint_test_item, False );         
      end loop;
      
      a_maint_test_list := Ukds.Frs.Maint_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Maint_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_maint_test_item := Ukds.Frs.Maint_List_Package.element( a_maint_test_list, i );
         Ukds.Frs.Maint_IO.Save( a_maint_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Maint_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_maint_test_item := Ukds.Frs.Maint_List_Package.element( a_maint_test_list, i );
         Ukds.Frs.Maint_IO.Delete( a_maint_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Maint_Create_Test: retrieve all records" );
      Ukds.Frs.Maint_List_Package.iterate( a_maint_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Maint_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Maint_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Maint_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Maint_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Mortcont_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Mortcont_List_Package.Cursor ) is 
      a_mortcont_test_item : Ukds.Frs.Mortcont;
      begin
         a_mortcont_test_item := Ukds.Frs.Mortcont_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_mortcont_test_item ));
      end print;

   
      a_mortcont_test_item : Ukds.Frs.Mortcont;
      a_mortcont_test_list : Ukds.Frs.Mortcont_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Mortcont_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Mortcont_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Mortcont_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_mortcont_test_item.user_id := Ukds.Frs.Mortcont_IO.Next_Free_user_id;
         a_mortcont_test_item.edition := Ukds.Frs.Mortcont_IO.Next_Free_edition;
         a_mortcont_test_item.year := Ukds.Frs.Mortcont_IO.Next_Free_year;
         a_mortcont_test_item.sernum := Ukds.Frs.Mortcont_IO.Next_Free_sernum;
         a_mortcont_test_item.mortseq := Ukds.Frs.Mortcont_IO.Next_Free_mortseq;
         a_mortcont_test_item.contseq := Ukds.Frs.Mortcont_IO.Next_Free_contseq;
         a_mortcont_test_item.outsamt := 1010100.012 + Amount( i );
         -- missing declaration for a_mortcont_test_item.outsincl;
         -- missing declaration for a_mortcont_test_item.outspay;
         -- missing declaration for a_mortcont_test_item.outspd;
         -- missing declaration for a_mortcont_test_item.month;
         -- missing declaration for a_mortcont_test_item.issue;
         Ukds.Frs.Mortcont_IO.Save( a_mortcont_test_item, False );         
      end loop;
      
      a_mortcont_test_list := Ukds.Frs.Mortcont_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Mortcont_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_mortcont_test_item := Ukds.Frs.Mortcont_List_Package.element( a_mortcont_test_list, i );
         Ukds.Frs.Mortcont_IO.Save( a_mortcont_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Mortcont_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_mortcont_test_item := Ukds.Frs.Mortcont_List_Package.element( a_mortcont_test_list, i );
         Ukds.Frs.Mortcont_IO.Delete( a_mortcont_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Mortcont_Create_Test: retrieve all records" );
      Ukds.Frs.Mortcont_List_Package.iterate( a_mortcont_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Mortcont_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Mortcont_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Mortcont_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Mortcont_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Mortgage_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Mortgage_List_Package.Cursor ) is 
      a_mortgage_test_item : Ukds.Frs.Mortgage;
      begin
         a_mortgage_test_item := Ukds.Frs.Mortgage_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_mortgage_test_item ));
      end print;

   
      a_mortgage_test_item : Ukds.Frs.Mortgage;
      a_mortgage_test_list : Ukds.Frs.Mortgage_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Mortgage_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Mortgage_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Mortgage_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_mortgage_test_item.user_id := Ukds.Frs.Mortgage_IO.Next_Free_user_id;
         a_mortgage_test_item.edition := Ukds.Frs.Mortgage_IO.Next_Free_edition;
         a_mortgage_test_item.year := Ukds.Frs.Mortgage_IO.Next_Free_year;
         a_mortgage_test_item.sernum := Ukds.Frs.Mortgage_IO.Next_Free_sernum;
         a_mortgage_test_item.mortseq := Ukds.Frs.Mortgage_IO.Next_Free_mortseq;
         -- missing declaration for a_mortgage_test_item.boramtdk;
         a_mortgage_test_item.borramt := 1010100.012 + Amount( i );
         -- missing declaration for a_mortgage_test_item.endwpri1;
         -- missing declaration for a_mortgage_test_item.endwpri2;
         -- missing declaration for a_mortgage_test_item.endwpri3;
         -- missing declaration for a_mortgage_test_item.endwpri4;
         -- missing declaration for a_mortgage_test_item.exrent;
         -- missing declaration for a_mortgage_test_item.incminc1;
         -- missing declaration for a_mortgage_test_item.incminc2;
         -- missing declaration for a_mortgage_test_item.incminc3;
         -- missing declaration for a_mortgage_test_item.incmp1;
         -- missing declaration for a_mortgage_test_item.incmp2;
         -- missing declaration for a_mortgage_test_item.incmp3;
         a_mortgage_test_item.incmpam1 := 1010100.012 + Amount( i );
         a_mortgage_test_item.incmpam2 := 1010100.012 + Amount( i );
         a_mortgage_test_item.incmpam3 := 1010100.012 + Amount( i );
         -- missing declaration for a_mortgage_test_item.incmppd1;
         -- missing declaration for a_mortgage_test_item.incmppd2;
         -- missing declaration for a_mortgage_test_item.incmppd3;
         -- missing declaration for a_mortgage_test_item.incmsty1;
         -- missing declaration for a_mortgage_test_item.incmsty2;
         -- missing declaration for a_mortgage_test_item.incmsty3;
         a_mortgage_test_item.intprpay := 1010100.012 + Amount( i );
         -- missing declaration for a_mortgage_test_item.intprpd;
         a_mortgage_test_item.intru := 1010100.012 + Amount( i );
         -- missing declaration for a_mortgage_test_item.intrupd;
         -- missing declaration for a_mortgage_test_item.intrus;
         -- missing declaration for a_mortgage_test_item.loan2y;
         -- missing declaration for a_mortgage_test_item.loanyear;
         -- missing declaration for a_mortgage_test_item.menpol;
         -- missing declaration for a_mortgage_test_item.morall;
         -- missing declaration for a_mortgage_test_item.morflc;
         a_mortgage_test_item.morinpay := 1010100.012 + Amount( i );
         -- missing declaration for a_mortgage_test_item.morinpd;
         -- missing declaration for a_mortgage_test_item.morinus;
         -- missing declaration for a_mortgage_test_item.mortend;
         a_mortgage_test_item.mortleft := 1010100.012 + Amount( i );
         -- missing declaration for a_mortgage_test_item.mortprot;
         -- missing declaration for a_mortgage_test_item.morttype;
         -- missing declaration for a_mortgage_test_item.morupd;
         a_mortgage_test_item.morus := 1010100.012 + Amount( i );
         -- missing declaration for a_mortgage_test_item.mpcover1;
         -- missing declaration for a_mortgage_test_item.mpcover2;
         -- missing declaration for a_mortgage_test_item.mpcover3;
         -- missing declaration for a_mortgage_test_item.mpolno;
         -- missing declaration for a_mortgage_test_item.outsmort;
         -- missing declaration for a_mortgage_test_item.rentfrom;
         a_mortgage_test_item.rmamt := 1010100.012 + Amount( i );
         -- missing declaration for a_mortgage_test_item.rmort;
         -- missing declaration for a_mortgage_test_item.rmortyr;
         -- missing declaration for a_mortgage_test_item.rmpur001;
         -- missing declaration for a_mortgage_test_item.rmpur002;
         -- missing declaration for a_mortgage_test_item.rmpur003;
         -- missing declaration for a_mortgage_test_item.rmpur004;
         -- missing declaration for a_mortgage_test_item.rmpur005;
         -- missing declaration for a_mortgage_test_item.rmpur006;
         -- missing declaration for a_mortgage_test_item.rmpur007;
         -- missing declaration for a_mortgage_test_item.rmpur008;
         -- missing declaration for a_mortgage_test_item.month;
         -- missing declaration for a_mortgage_test_item.endwpri5;
         -- missing declaration for a_mortgage_test_item.issue;
         Ukds.Frs.Mortgage_IO.Save( a_mortgage_test_item, False );         
      end loop;
      
      a_mortgage_test_list := Ukds.Frs.Mortgage_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Mortgage_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_mortgage_test_item := Ukds.Frs.Mortgage_List_Package.element( a_mortgage_test_list, i );
         Ukds.Frs.Mortgage_IO.Save( a_mortgage_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Mortgage_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_mortgage_test_item := Ukds.Frs.Mortgage_List_Package.element( a_mortgage_test_list, i );
         Ukds.Frs.Mortgage_IO.Delete( a_mortgage_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Mortgage_Create_Test: retrieve all records" );
      Ukds.Frs.Mortgage_List_Package.iterate( a_mortgage_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Mortgage_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Mortgage_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Mortgage_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Mortgage_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Nimigr_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Nimigr_List_Package.Cursor ) is 
      a_nimigr_test_item : Ukds.Frs.Nimigr;
      begin
         a_nimigr_test_item := Ukds.Frs.Nimigr_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_nimigr_test_item ));
      end print;

   
      a_nimigr_test_item : Ukds.Frs.Nimigr;
      a_nimigr_test_list : Ukds.Frs.Nimigr_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Nimigr_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Nimigr_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Nimigr_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_nimigr_test_item.user_id := Ukds.Frs.Nimigr_IO.Next_Free_user_id;
         a_nimigr_test_item.edition := Ukds.Frs.Nimigr_IO.Next_Free_edition;
         a_nimigr_test_item.year := Ukds.Frs.Nimigr_IO.Next_Free_year;
         a_nimigr_test_item.counter := Ukds.Frs.Nimigr_IO.Next_Free_counter;
         a_nimigr_test_item.sernum := Ukds.Frs.Nimigr_IO.Next_Free_sernum;
         a_nimigr_test_item.miper := Ukds.Frs.Nimigr_IO.Next_Free_miper;
         -- missing declaration for a_nimigr_test_item.issue;
         -- missing declaration for a_nimigr_test_item.miage;
         -- missing declaration for a_nimigr_test_item.misex;
         -- missing declaration for a_nimigr_test_item.mnthleft;
         -- missing declaration for a_nimigr_test_item.more1yr;
         -- missing declaration for a_nimigr_test_item.wherenow;
         -- missing declaration for a_nimigr_test_item.month;
         -- missing declaration for a_nimigr_test_item.miagegr;
         Ukds.Frs.Nimigr_IO.Save( a_nimigr_test_item, False );         
      end loop;
      
      a_nimigr_test_list := Ukds.Frs.Nimigr_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Nimigr_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_nimigr_test_item := Ukds.Frs.Nimigr_List_Package.element( a_nimigr_test_list, i );
         Ukds.Frs.Nimigr_IO.Save( a_nimigr_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Nimigr_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_nimigr_test_item := Ukds.Frs.Nimigr_List_Package.element( a_nimigr_test_list, i );
         Ukds.Frs.Nimigr_IO.Delete( a_nimigr_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Nimigr_Create_Test: retrieve all records" );
      Ukds.Frs.Nimigr_List_Package.iterate( a_nimigr_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Nimigr_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Nimigr_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Nimigr_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Nimigr_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Nimigra_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Nimigra_List_Package.Cursor ) is 
      a_nimigra_test_item : Ukds.Frs.Nimigra;
      begin
         a_nimigra_test_item := Ukds.Frs.Nimigra_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_nimigra_test_item ));
      end print;

   
      a_nimigra_test_item : Ukds.Frs.Nimigra;
      a_nimigra_test_list : Ukds.Frs.Nimigra_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Nimigra_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Nimigra_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Nimigra_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_nimigra_test_item.user_id := Ukds.Frs.Nimigra_IO.Next_Free_user_id;
         a_nimigra_test_item.edition := Ukds.Frs.Nimigra_IO.Next_Free_edition;
         a_nimigra_test_item.year := Ukds.Frs.Nimigra_IO.Next_Free_year;
         a_nimigra_test_item.sernum := Ukds.Frs.Nimigra_IO.Next_Free_sernum;
         -- missing declaration for a_nimigra_test_item.miper;
         -- missing declaration for a_nimigra_test_item.issue;
         -- missing declaration for a_nimigra_test_item.miage;
         -- missing declaration for a_nimigra_test_item.misex;
         -- missing declaration for a_nimigra_test_item.mnthleft;
         -- missing declaration for a_nimigra_test_item.more1yr;
         -- missing declaration for a_nimigra_test_item.wherenow;
         -- missing declaration for a_nimigra_test_item.month;
         -- missing declaration for a_nimigra_test_item.miagegr;
         Ukds.Frs.Nimigra_IO.Save( a_nimigra_test_item, False );         
      end loop;
      
      a_nimigra_test_list := Ukds.Frs.Nimigra_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Nimigra_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_nimigra_test_item := Ukds.Frs.Nimigra_List_Package.element( a_nimigra_test_list, i );
         Ukds.Frs.Nimigra_IO.Save( a_nimigra_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Nimigra_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_nimigra_test_item := Ukds.Frs.Nimigra_List_Package.element( a_nimigra_test_list, i );
         Ukds.Frs.Nimigra_IO.Delete( a_nimigra_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Nimigra_Create_Test: retrieve all records" );
      Ukds.Frs.Nimigra_List_Package.iterate( a_nimigra_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Nimigra_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Nimigra_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Nimigra_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Nimigra_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Oddjob_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Oddjob_List_Package.Cursor ) is 
      a_oddjob_test_item : Ukds.Frs.Oddjob;
      begin
         a_oddjob_test_item := Ukds.Frs.Oddjob_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_oddjob_test_item ));
      end print;

   
      a_oddjob_test_item : Ukds.Frs.Oddjob;
      a_oddjob_test_list : Ukds.Frs.Oddjob_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Oddjob_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Oddjob_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Oddjob_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_oddjob_test_item.user_id := Ukds.Frs.Oddjob_IO.Next_Free_user_id;
         a_oddjob_test_item.edition := Ukds.Frs.Oddjob_IO.Next_Free_edition;
         a_oddjob_test_item.year := Ukds.Frs.Oddjob_IO.Next_Free_year;
         a_oddjob_test_item.counter := Ukds.Frs.Oddjob_IO.Next_Free_counter;
         a_oddjob_test_item.sernum := Ukds.Frs.Oddjob_IO.Next_Free_sernum;
         a_oddjob_test_item.benunit := Ukds.Frs.Oddjob_IO.Next_Free_benunit;
         a_oddjob_test_item.person := Ukds.Frs.Oddjob_IO.Next_Free_person;
         a_oddjob_test_item.oddseq := Ukds.Frs.Oddjob_IO.Next_Free_oddseq;
         -- missing declaration for a_oddjob_test_item.oddtype;
         a_oddjob_test_item.ojamt := 1010100.012 + Amount( i );
         -- missing declaration for a_oddjob_test_item.ojnow;
         -- missing declaration for a_oddjob_test_item.ojreg;
         -- missing declaration for a_oddjob_test_item.month;
         -- missing declaration for a_oddjob_test_item.issue;
         -- missing declaration for a_oddjob_test_item.jobstat;
         Ukds.Frs.Oddjob_IO.Save( a_oddjob_test_item, False );         
      end loop;
      
      a_oddjob_test_list := Ukds.Frs.Oddjob_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Oddjob_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_oddjob_test_item := Ukds.Frs.Oddjob_List_Package.element( a_oddjob_test_list, i );
         Ukds.Frs.Oddjob_IO.Save( a_oddjob_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Oddjob_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_oddjob_test_item := Ukds.Frs.Oddjob_List_Package.element( a_oddjob_test_list, i );
         Ukds.Frs.Oddjob_IO.Delete( a_oddjob_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Oddjob_Create_Test: retrieve all records" );
      Ukds.Frs.Oddjob_List_Package.iterate( a_oddjob_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Oddjob_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Oddjob_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Oddjob_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Oddjob_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Owner_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Owner_List_Package.Cursor ) is 
      a_owner_test_item : Ukds.Frs.Owner;
      begin
         a_owner_test_item := Ukds.Frs.Owner_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_owner_test_item ));
      end print;

   
      a_owner_test_item : Ukds.Frs.Owner;
      a_owner_test_list : Ukds.Frs.Owner_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Owner_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Owner_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Owner_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_owner_test_item.user_id := Ukds.Frs.Owner_IO.Next_Free_user_id;
         a_owner_test_item.edition := Ukds.Frs.Owner_IO.Next_Free_edition;
         a_owner_test_item.year := Ukds.Frs.Owner_IO.Next_Free_year;
         a_owner_test_item.counter := Ukds.Frs.Owner_IO.Next_Free_counter;
         a_owner_test_item.sernum := Ukds.Frs.Owner_IO.Next_Free_sernum;
         -- missing declaration for a_owner_test_item.buyyear;
         -- missing declaration for a_owner_test_item.othmort1;
         -- missing declaration for a_owner_test_item.othmort2;
         -- missing declaration for a_owner_test_item.othmort3;
         -- missing declaration for a_owner_test_item.othpur1;
         -- missing declaration for a_owner_test_item.othpur2;
         -- missing declaration for a_owner_test_item.othpur3;
         -- missing declaration for a_owner_test_item.othpur31;
         -- missing declaration for a_owner_test_item.othpur32;
         -- missing declaration for a_owner_test_item.othpur33;
         -- missing declaration for a_owner_test_item.othpur34;
         -- missing declaration for a_owner_test_item.othpur35;
         -- missing declaration for a_owner_test_item.othpur36;
         -- missing declaration for a_owner_test_item.othpur37;
         -- missing declaration for a_owner_test_item.othpur4;
         -- missing declaration for a_owner_test_item.othpur5;
         -- missing declaration for a_owner_test_item.othpur6;
         -- missing declaration for a_owner_test_item.othpur7;
         a_owner_test_item.purcamt := 1010100.012 + Amount( i );
         -- missing declaration for a_owner_test_item.purcloan;
         -- missing declaration for a_owner_test_item.month;
         -- missing declaration for a_owner_test_item.issue;
         Ukds.Frs.Owner_IO.Save( a_owner_test_item, False );         
      end loop;
      
      a_owner_test_list := Ukds.Frs.Owner_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Owner_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_owner_test_item := Ukds.Frs.Owner_List_Package.element( a_owner_test_list, i );
         Ukds.Frs.Owner_IO.Save( a_owner_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Owner_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_owner_test_item := Ukds.Frs.Owner_List_Package.element( a_owner_test_list, i );
         Ukds.Frs.Owner_IO.Delete( a_owner_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Owner_Create_Test: retrieve all records" );
      Ukds.Frs.Owner_List_Package.iterate( a_owner_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Owner_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Owner_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Owner_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Owner_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Penamt_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Penamt_List_Package.Cursor ) is 
      a_penamt_test_item : Ukds.Frs.Penamt;
      begin
         a_penamt_test_item := Ukds.Frs.Penamt_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_penamt_test_item ));
      end print;

   
      a_penamt_test_item : Ukds.Frs.Penamt;
      a_penamt_test_list : Ukds.Frs.Penamt_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Penamt_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Penamt_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Penamt_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_penamt_test_item.user_id := Ukds.Frs.Penamt_IO.Next_Free_user_id;
         a_penamt_test_item.edition := Ukds.Frs.Penamt_IO.Next_Free_edition;
         a_penamt_test_item.year := Ukds.Frs.Penamt_IO.Next_Free_year;
         a_penamt_test_item.counter := Ukds.Frs.Penamt_IO.Next_Free_counter;
         a_penamt_test_item.sernum := Ukds.Frs.Penamt_IO.Next_Free_sernum;
         a_penamt_test_item.benunit := Ukds.Frs.Penamt_IO.Next_Free_benunit;
         a_penamt_test_item.person := Ukds.Frs.Penamt_IO.Next_Free_person;
         a_penamt_test_item.benefit := Ukds.Frs.Penamt_IO.Next_Free_benefit;
         -- missing declaration for a_penamt_test_item.amttype;
         a_penamt_test_item.penq := 1010100.012 + Amount( i );
         -- missing declaration for a_penamt_test_item.month;
         -- missing declaration for a_penamt_test_item.issue;
         Ukds.Frs.Penamt_IO.Save( a_penamt_test_item, False );         
      end loop;
      
      a_penamt_test_list := Ukds.Frs.Penamt_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Penamt_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_penamt_test_item := Ukds.Frs.Penamt_List_Package.element( a_penamt_test_list, i );
         Ukds.Frs.Penamt_IO.Save( a_penamt_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Penamt_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_penamt_test_item := Ukds.Frs.Penamt_List_Package.element( a_penamt_test_list, i );
         Ukds.Frs.Penamt_IO.Delete( a_penamt_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Penamt_Create_Test: retrieve all records" );
      Ukds.Frs.Penamt_List_Package.iterate( a_penamt_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Penamt_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Penamt_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Penamt_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Penamt_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Penprov_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Penprov_List_Package.Cursor ) is 
      a_penprov_test_item : Ukds.Frs.Penprov;
      begin
         a_penprov_test_item := Ukds.Frs.Penprov_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_penprov_test_item ));
      end print;

   
      a_penprov_test_item : Ukds.Frs.Penprov;
      a_penprov_test_list : Ukds.Frs.Penprov_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Penprov_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Penprov_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Penprov_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_penprov_test_item.user_id := Ukds.Frs.Penprov_IO.Next_Free_user_id;
         a_penprov_test_item.edition := Ukds.Frs.Penprov_IO.Next_Free_edition;
         a_penprov_test_item.year := Ukds.Frs.Penprov_IO.Next_Free_year;
         a_penprov_test_item.counter := Ukds.Frs.Penprov_IO.Next_Free_counter;
         a_penprov_test_item.sernum := Ukds.Frs.Penprov_IO.Next_Free_sernum;
         a_penprov_test_item.benunit := Ukds.Frs.Penprov_IO.Next_Free_benunit;
         a_penprov_test_item.person := Ukds.Frs.Penprov_IO.Next_Free_person;
         a_penprov_test_item.provseq := Ukds.Frs.Penprov_IO.Next_Free_provseq;
         -- missing declaration for a_penprov_test_item.stemppay;
         -- missing declaration for a_penprov_test_item.eplong;
         -- missing declaration for a_penprov_test_item.eptype;
         -- missing declaration for a_penprov_test_item.keeppen;
         -- missing declaration for a_penprov_test_item.opgov;
         a_penprov_test_item.penamt := 1010100.012 + Amount( i );
         -- missing declaration for a_penprov_test_item.penamtpd;
         -- missing declaration for a_penprov_test_item.pencon;
         -- missing declaration for a_penprov_test_item.pendat;
         -- missing declaration for a_penprov_test_item.pengov;
         -- missing declaration for a_penprov_test_item.penhelp;
         -- missing declaration for a_penprov_test_item.penmort;
         -- missing declaration for a_penprov_test_item.spwho;
         -- missing declaration for a_penprov_test_item.month;
         -- missing declaration for a_penprov_test_item.stemppen;
         -- missing declaration for a_penprov_test_item.penreb;
         -- missing declaration for a_penprov_test_item.rebgov;
         -- missing declaration for a_penprov_test_item.issue;
         a_penprov_test_item.penamtdt := Ada.Calendar.Clock;
         -- missing declaration for a_penprov_test_item.penchk;
         Ukds.Frs.Penprov_IO.Save( a_penprov_test_item, False );         
      end loop;
      
      a_penprov_test_list := Ukds.Frs.Penprov_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Penprov_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_penprov_test_item := Ukds.Frs.Penprov_List_Package.element( a_penprov_test_list, i );
         Ukds.Frs.Penprov_IO.Save( a_penprov_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Penprov_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_penprov_test_item := Ukds.Frs.Penprov_List_Package.element( a_penprov_test_list, i );
         Ukds.Frs.Penprov_IO.Delete( a_penprov_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Penprov_Create_Test: retrieve all records" );
      Ukds.Frs.Penprov_List_Package.iterate( a_penprov_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Penprov_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Penprov_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Penprov_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Penprov_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Pension_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Pension_List_Package.Cursor ) is 
      a_pension_test_item : Ukds.Frs.Pension;
      begin
         a_pension_test_item := Ukds.Frs.Pension_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_pension_test_item ));
      end print;

   
      a_pension_test_item : Ukds.Frs.Pension;
      a_pension_test_list : Ukds.Frs.Pension_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Pension_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Pension_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Pension_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_pension_test_item.user_id := Ukds.Frs.Pension_IO.Next_Free_user_id;
         a_pension_test_item.edition := Ukds.Frs.Pension_IO.Next_Free_edition;
         a_pension_test_item.year := Ukds.Frs.Pension_IO.Next_Free_year;
         a_pension_test_item.sernum := Ukds.Frs.Pension_IO.Next_Free_sernum;
         a_pension_test_item.benunit := Ukds.Frs.Pension_IO.Next_Free_benunit;
         a_pension_test_item.person := Ukds.Frs.Pension_IO.Next_Free_person;
         a_pension_test_item.penseq := Ukds.Frs.Pension_IO.Next_Free_penseq;
         -- missing declaration for a_pension_test_item.another;
         -- missing declaration for a_pension_test_item.penoth;
         a_pension_test_item.penpay := 1010100.012 + Amount( i );
         -- missing declaration for a_pension_test_item.penpd;
         -- missing declaration for a_pension_test_item.pentax;
         -- missing declaration for a_pension_test_item.pentype;
         a_pension_test_item.poamt := 1010100.012 + Amount( i );
         -- missing declaration for a_pension_test_item.poinc;
         -- missing declaration for a_pension_test_item.posour;
         a_pension_test_item.ptamt := 1010100.012 + Amount( i );
         -- missing declaration for a_pension_test_item.ptinc;
         -- missing declaration for a_pension_test_item.trights;
         -- missing declaration for a_pension_test_item.month;
         -- missing declaration for a_pension_test_item.issue;
         -- missing declaration for a_pension_test_item.penpd1;
         -- missing declaration for a_pension_test_item.penpd2;
         Ukds.Frs.Pension_IO.Save( a_pension_test_item, False );         
      end loop;
      
      a_pension_test_list := Ukds.Frs.Pension_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Pension_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_pension_test_item := Ukds.Frs.Pension_List_Package.element( a_pension_test_list, i );
         Ukds.Frs.Pension_IO.Save( a_pension_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pension_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_pension_test_item := Ukds.Frs.Pension_List_Package.element( a_pension_test_list, i );
         Ukds.Frs.Pension_IO.Delete( a_pension_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pension_Create_Test: retrieve all records" );
      Ukds.Frs.Pension_List_Package.iterate( a_pension_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Pension_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Pension_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Pension_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Pension_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Pianom0809_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Pianom0809_List_Package.Cursor ) is 
      a_pianom0809_test_item : Ukds.Frs.Pianom0809;
      begin
         a_pianom0809_test_item := Ukds.Frs.Pianom0809_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_pianom0809_test_item ));
      end print;

   
      a_pianom0809_test_item : Ukds.Frs.Pianom0809;
      a_pianom0809_test_list : Ukds.Frs.Pianom0809_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Pianom0809_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Pianom0809_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Pianom0809_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_pianom0809_test_item.user_id := Ukds.Frs.Pianom0809_IO.Next_Free_user_id;
         a_pianom0809_test_item.edition := Ukds.Frs.Pianom0809_IO.Next_Free_edition;
         a_pianom0809_test_item.year := Ukds.Frs.Pianom0809_IO.Next_Free_year;
         a_pianom0809_test_item.benunit := Ukds.Frs.Pianom0809_IO.Next_Free_benunit;
         a_pianom0809_test_item.sernum := Ukds.Frs.Pianom0809_IO.Next_Free_sernum;
         -- missing declaration for a_pianom0809_test_item.gvtregn;
         -- missing declaration for a_pianom0809_test_item.fambu;
         -- missing declaration for a_pianom0809_test_item.newfambu;
         -- missing declaration for a_pianom0809_test_item.sexhd;
         -- missing declaration for a_pianom0809_test_item.london;
         -- missing declaration for a_pianom0809_test_item.adultb;
         -- missing declaration for a_pianom0809_test_item.ethgrphh;
         -- missing declaration for a_pianom0809_test_item.gs_newbu;
         -- missing declaration for a_pianom0809_test_item.gs_newpp;
         -- missing declaration for a_pianom0809_test_item.mbhcdec;
         -- missing declaration for a_pianom0809_test_item.obhcdec;
         -- missing declaration for a_pianom0809_test_item.mahcdec;
         -- missing declaration for a_pianom0809_test_item.oahcdec;
         -- missing declaration for a_pianom0809_test_item.sexsp;
         a_pianom0809_test_item.pidefbhc := 1010100.012 + Amount( i );
         a_pianom0809_test_item.pidefahc := 1010100.012 + Amount( i );
         -- missing declaration for a_pianom0809_test_item.pigrosbu;
         -- missing declaration for a_pianom0809_test_item.pinincbu;
         -- missing declaration for a_pianom0809_test_item.pigoccbu;
         -- missing declaration for a_pianom0809_test_item.pippenbu;
         -- missing declaration for a_pianom0809_test_item.piginvbu;
         -- missing declaration for a_pianom0809_test_item.pigernbu;
         -- missing declaration for a_pianom0809_test_item.pibenibu;
         -- missing declaration for a_pianom0809_test_item.piothibu;
         -- missing declaration for a_pianom0809_test_item.pinahcbu;
         -- missing declaration for a_pianom0809_test_item.piirbbu;
         -- missing declaration for a_pianom0809_test_item.pidisben;
         -- missing declaration for a_pianom0809_test_item.piretben;
         -- missing declaration for a_pianom0809_test_item.pripenbu;
         -- missing declaration for a_pianom0809_test_item.nonben2bu;
         -- missing declaration for a_pianom0809_test_item.perbenbu;
         -- missing declaration for a_pianom0809_test_item.perbenbu2;
         -- missing declaration for a_pianom0809_test_item.rrpen;
         -- missing declaration for a_pianom0809_test_item.newfambu2;
         -- missing declaration for a_pianom0809_test_item.dummy;
         a_pianom0809_test_item.coup_q1 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.coup_q2 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.coup_q3 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.coup_q4 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.coup_q5 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.acou_q1 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.acou_q2 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.acou_q3 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.acou_q4 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.acou_q5 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.sing_q1 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.sing_q2 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.sing_q3 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.sing_q4 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.sing_q5 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.asin_q1 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.asin_q2 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.asin_q3 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.asin_q4 := 1010100.012 + Amount( i );
         a_pianom0809_test_item.asin_q5 := 1010100.012 + Amount( i );
         -- missing declaration for a_pianom0809_test_item.clust;
         -- missing declaration for a_pianom0809_test_item.strat;
         -- missing declaration for a_pianom0809_test_item.agehd80;
         -- missing declaration for a_pianom0809_test_item.agesp80;
         Ukds.Frs.Pianom0809_IO.Save( a_pianom0809_test_item, False );         
      end loop;
      
      a_pianom0809_test_list := Ukds.Frs.Pianom0809_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Pianom0809_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_pianom0809_test_item := Ukds.Frs.Pianom0809_List_Package.element( a_pianom0809_test_list, i );
         Ukds.Frs.Pianom0809_IO.Save( a_pianom0809_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianom0809_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_pianom0809_test_item := Ukds.Frs.Pianom0809_List_Package.element( a_pianom0809_test_list, i );
         Ukds.Frs.Pianom0809_IO.Delete( a_pianom0809_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianom0809_Create_Test: retrieve all records" );
      Ukds.Frs.Pianom0809_List_Package.iterate( a_pianom0809_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Pianom0809_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Pianom0809_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Pianom0809_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Pianom0809_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Pianon0910_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Pianon0910_List_Package.Cursor ) is 
      a_pianon0910_test_item : Ukds.Frs.Pianon0910;
      begin
         a_pianon0910_test_item := Ukds.Frs.Pianon0910_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_pianon0910_test_item ));
      end print;

   
      a_pianon0910_test_item : Ukds.Frs.Pianon0910;
      a_pianon0910_test_list : Ukds.Frs.Pianon0910_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Pianon0910_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Pianon0910_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Pianon0910_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_pianon0910_test_item.user_id := Ukds.Frs.Pianon0910_IO.Next_Free_user_id;
         a_pianon0910_test_item.edition := Ukds.Frs.Pianon0910_IO.Next_Free_edition;
         a_pianon0910_test_item.year := Ukds.Frs.Pianon0910_IO.Next_Free_year;
         a_pianon0910_test_item.benunit := Ukds.Frs.Pianon0910_IO.Next_Free_benunit;
         a_pianon0910_test_item.sernum := Ukds.Frs.Pianon0910_IO.Next_Free_sernum;
         -- missing declaration for a_pianon0910_test_item.gvtregn;
         -- missing declaration for a_pianon0910_test_item.fambu;
         -- missing declaration for a_pianon0910_test_item.newfambu;
         -- missing declaration for a_pianon0910_test_item.sexhd;
         -- missing declaration for a_pianon0910_test_item.adultb;
         -- missing declaration for a_pianon0910_test_item.ethgrphh;
         -- missing declaration for a_pianon0910_test_item.gs_newbu;
         -- missing declaration for a_pianon0910_test_item.gs_newpp;
         -- missing declaration for a_pianon0910_test_item.mbhcdec;
         -- missing declaration for a_pianon0910_test_item.obhcdec;
         -- missing declaration for a_pianon0910_test_item.mahcdec;
         -- missing declaration for a_pianon0910_test_item.oahcdec;
         -- missing declaration for a_pianon0910_test_item.sexsp;
         a_pianon0910_test_item.pidefbhc := 1010100.012 + Amount( i );
         a_pianon0910_test_item.pidefahc := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon0910_test_item.pigrosbu;
         -- missing declaration for a_pianon0910_test_item.pinincbu;
         -- missing declaration for a_pianon0910_test_item.pigoccbu;
         -- missing declaration for a_pianon0910_test_item.pippenbu;
         -- missing declaration for a_pianon0910_test_item.piginvbu;
         -- missing declaration for a_pianon0910_test_item.pigernbu;
         -- missing declaration for a_pianon0910_test_item.pibenibu;
         -- missing declaration for a_pianon0910_test_item.piothibu;
         -- missing declaration for a_pianon0910_test_item.pinahcbu;
         -- missing declaration for a_pianon0910_test_item.piirbbu;
         -- missing declaration for a_pianon0910_test_item.pidisben;
         -- missing declaration for a_pianon0910_test_item.piretben;
         -- missing declaration for a_pianon0910_test_item.pripenbu;
         -- missing declaration for a_pianon0910_test_item.nonben2bu;
         -- missing declaration for a_pianon0910_test_item.perbenbu;
         -- missing declaration for a_pianon0910_test_item.perbenbu2;
         -- missing declaration for a_pianon0910_test_item.rrpen;
         -- missing declaration for a_pianon0910_test_item.newfambu2;
         -- missing declaration for a_pianon0910_test_item.newfamb2;
         -- missing declaration for a_pianon0910_test_item.dummy;
         a_pianon0910_test_item.coup_q1 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.coup_q2 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.coup_q3 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.coup_q4 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.coup_q5 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.acou_q1 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.acou_q2 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.acou_q3 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.acou_q4 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.acou_q5 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.sing_q1 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.sing_q2 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.sing_q3 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.sing_q4 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.sing_q5 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.asin_q1 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.asin_q2 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.asin_q3 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.asin_q4 := 1010100.012 + Amount( i );
         a_pianon0910_test_item.asin_q5 := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon0910_test_item.clust;
         -- missing declaration for a_pianon0910_test_item.strat;
         -- missing declaration for a_pianon0910_test_item.agehd80;
         -- missing declaration for a_pianon0910_test_item.agesp80;
         Ukds.Frs.Pianon0910_IO.Save( a_pianon0910_test_item, False );         
      end loop;
      
      a_pianon0910_test_list := Ukds.Frs.Pianon0910_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Pianon0910_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_pianon0910_test_item := Ukds.Frs.Pianon0910_List_Package.element( a_pianon0910_test_list, i );
         Ukds.Frs.Pianon0910_IO.Save( a_pianon0910_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianon0910_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_pianon0910_test_item := Ukds.Frs.Pianon0910_List_Package.element( a_pianon0910_test_list, i );
         Ukds.Frs.Pianon0910_IO.Delete( a_pianon0910_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianon0910_Create_Test: retrieve all records" );
      Ukds.Frs.Pianon0910_List_Package.iterate( a_pianon0910_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Pianon0910_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Pianon0910_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Pianon0910_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Pianon0910_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Pianon1011_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Pianon1011_List_Package.Cursor ) is 
      a_pianon1011_test_item : Ukds.Frs.Pianon1011;
      begin
         a_pianon1011_test_item := Ukds.Frs.Pianon1011_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_pianon1011_test_item ));
      end print;

   
      a_pianon1011_test_item : Ukds.Frs.Pianon1011;
      a_pianon1011_test_list : Ukds.Frs.Pianon1011_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Pianon1011_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Pianon1011_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Pianon1011_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_pianon1011_test_item.user_id := Ukds.Frs.Pianon1011_IO.Next_Free_user_id;
         a_pianon1011_test_item.edition := Ukds.Frs.Pianon1011_IO.Next_Free_edition;
         a_pianon1011_test_item.year := Ukds.Frs.Pianon1011_IO.Next_Free_year;
         a_pianon1011_test_item.benunit := Ukds.Frs.Pianon1011_IO.Next_Free_benunit;
         a_pianon1011_test_item.sernum := Ukds.Frs.Pianon1011_IO.Next_Free_sernum;
         -- missing declaration for a_pianon1011_test_item.gvtregn;
         -- missing declaration for a_pianon1011_test_item.fambu;
         -- missing declaration for a_pianon1011_test_item.newfambu;
         -- missing declaration for a_pianon1011_test_item.sexhd;
         -- missing declaration for a_pianon1011_test_item.adultb;
         -- missing declaration for a_pianon1011_test_item.ethgrphh;
         -- missing declaration for a_pianon1011_test_item.gs_newbu;
         -- missing declaration for a_pianon1011_test_item.gs_newpp;
         -- missing declaration for a_pianon1011_test_item.mbhcdec;
         -- missing declaration for a_pianon1011_test_item.obhcdec;
         -- missing declaration for a_pianon1011_test_item.mahcdec;
         -- missing declaration for a_pianon1011_test_item.oahcdec;
         -- missing declaration for a_pianon1011_test_item.sexsp;
         -- missing declaration for a_pianon1011_test_item.newfamb2;
         a_pianon1011_test_item.pidefbhc := 1010100.012 + Amount( i );
         a_pianon1011_test_item.pidefahc := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1011_test_item.pigrosbu;
         -- missing declaration for a_pianon1011_test_item.pinincbu;
         -- missing declaration for a_pianon1011_test_item.pigoccbu;
         -- missing declaration for a_pianon1011_test_item.pippenbu;
         -- missing declaration for a_pianon1011_test_item.piginvbu;
         -- missing declaration for a_pianon1011_test_item.pigernbu;
         -- missing declaration for a_pianon1011_test_item.pibenibu;
         -- missing declaration for a_pianon1011_test_item.piothibu;
         -- missing declaration for a_pianon1011_test_item.pinahcbu;
         -- missing declaration for a_pianon1011_test_item.piirbbu;
         -- missing declaration for a_pianon1011_test_item.pidisben;
         -- missing declaration for a_pianon1011_test_item.piretben;
         -- missing declaration for a_pianon1011_test_item.pripenbu;
         -- missing declaration for a_pianon1011_test_item.nonben2bu;
         -- missing declaration for a_pianon1011_test_item.perbenbu;
         -- missing declaration for a_pianon1011_test_item.perbenbu2;
         -- missing declaration for a_pianon1011_test_item.rrpen;
         -- missing declaration for a_pianon1011_test_item.newfambu2;
         -- missing declaration for a_pianon1011_test_item.dummy;
         a_pianon1011_test_item.coup_q1 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.coup_q2 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.coup_q3 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.coup_q4 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.coup_q5 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.acou_q1 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.acou_q2 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.acou_q3 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.acou_q4 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.acou_q5 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.sing_q1 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.sing_q2 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.sing_q3 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.sing_q4 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.sing_q5 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.asin_q1 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.asin_q2 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.asin_q3 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.asin_q4 := 1010100.012 + Amount( i );
         a_pianon1011_test_item.asin_q5 := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1011_test_item.clust;
         -- missing declaration for a_pianon1011_test_item.strat;
         -- missing declaration for a_pianon1011_test_item.agehd80;
         -- missing declaration for a_pianon1011_test_item.agesp80;
         Ukds.Frs.Pianon1011_IO.Save( a_pianon1011_test_item, False );         
      end loop;
      
      a_pianon1011_test_list := Ukds.Frs.Pianon1011_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Pianon1011_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_pianon1011_test_item := Ukds.Frs.Pianon1011_List_Package.element( a_pianon1011_test_list, i );
         Ukds.Frs.Pianon1011_IO.Save( a_pianon1011_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianon1011_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_pianon1011_test_item := Ukds.Frs.Pianon1011_List_Package.element( a_pianon1011_test_list, i );
         Ukds.Frs.Pianon1011_IO.Delete( a_pianon1011_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianon1011_Create_Test: retrieve all records" );
      Ukds.Frs.Pianon1011_List_Package.iterate( a_pianon1011_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Pianon1011_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Pianon1011_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Pianon1011_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Pianon1011_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Pianon1213_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Pianon1213_List_Package.Cursor ) is 
      a_pianon1213_test_item : Ukds.Frs.Pianon1213;
      begin
         a_pianon1213_test_item := Ukds.Frs.Pianon1213_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_pianon1213_test_item ));
      end print;

   
      a_pianon1213_test_item : Ukds.Frs.Pianon1213;
      a_pianon1213_test_list : Ukds.Frs.Pianon1213_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Pianon1213_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Pianon1213_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Pianon1213_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_pianon1213_test_item.user_id := Ukds.Frs.Pianon1213_IO.Next_Free_user_id;
         a_pianon1213_test_item.edition := Ukds.Frs.Pianon1213_IO.Next_Free_edition;
         a_pianon1213_test_item.year := Ukds.Frs.Pianon1213_IO.Next_Free_year;
         a_pianon1213_test_item.benunit := Ukds.Frs.Pianon1213_IO.Next_Free_benunit;
         a_pianon1213_test_item.sernum := Ukds.Frs.Pianon1213_IO.Next_Free_sernum;
         -- missing declaration for a_pianon1213_test_item.gvtregn;
         -- missing declaration for a_pianon1213_test_item.fambu;
         -- missing declaration for a_pianon1213_test_item.newfambu;
         -- missing declaration for a_pianon1213_test_item.sexhd;
         -- missing declaration for a_pianon1213_test_item.adultb;
         -- missing declaration for a_pianon1213_test_item.ethgrphh;
         -- missing declaration for a_pianon1213_test_item.gs_newbu;
         -- missing declaration for a_pianon1213_test_item.gs_newpp;
         -- missing declaration for a_pianon1213_test_item.mbhcdec;
         -- missing declaration for a_pianon1213_test_item.obhcdec;
         -- missing declaration for a_pianon1213_test_item.mahcdec;
         -- missing declaration for a_pianon1213_test_item.oahcdec;
         -- missing declaration for a_pianon1213_test_item.sexsp;
         -- missing declaration for a_pianon1213_test_item.newfamb2;
         a_pianon1213_test_item.pidefbhc := 1010100.012 + Amount( i );
         a_pianon1213_test_item.pidefahc := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1213_test_item.pigrosbu;
         -- missing declaration for a_pianon1213_test_item.pinincbu;
         -- missing declaration for a_pianon1213_test_item.pigoccbu;
         -- missing declaration for a_pianon1213_test_item.pippenbu;
         -- missing declaration for a_pianon1213_test_item.piginvbu;
         -- missing declaration for a_pianon1213_test_item.pigernbu;
         -- missing declaration for a_pianon1213_test_item.pibenibu;
         -- missing declaration for a_pianon1213_test_item.piothibu;
         -- missing declaration for a_pianon1213_test_item.pinahcbu;
         -- missing declaration for a_pianon1213_test_item.piirbbu;
         -- missing declaration for a_pianon1213_test_item.pidisben;
         -- missing declaration for a_pianon1213_test_item.piretben;
         -- missing declaration for a_pianon1213_test_item.pripenbu;
         -- missing declaration for a_pianon1213_test_item.nonben2bu;
         -- missing declaration for a_pianon1213_test_item.perbenbu;
         -- missing declaration for a_pianon1213_test_item.perbenbu2;
         -- missing declaration for a_pianon1213_test_item.rrpen;
         -- missing declaration for a_pianon1213_test_item.newfambu2;
         -- missing declaration for a_pianon1213_test_item.dummy;
         a_pianon1213_test_item.coup_q1 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.coup_q2 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.coup_q3 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.coup_q4 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.coup_q5 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.acou_q1 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.acou_q2 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.acou_q3 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.acou_q4 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.acou_q5 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.sing_q1 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.sing_q2 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.sing_q3 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.sing_q4 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.sing_q5 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.asin_q1 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.asin_q2 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.asin_q3 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.asin_q4 := 1010100.012 + Amount( i );
         a_pianon1213_test_item.asin_q5 := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1213_test_item.clust;
         -- missing declaration for a_pianon1213_test_item.strat;
         -- missing declaration for a_pianon1213_test_item.agehd80;
         -- missing declaration for a_pianon1213_test_item.agesp80;
         Ukds.Frs.Pianon1213_IO.Save( a_pianon1213_test_item, False );         
      end loop;
      
      a_pianon1213_test_list := Ukds.Frs.Pianon1213_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Pianon1213_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_pianon1213_test_item := Ukds.Frs.Pianon1213_List_Package.element( a_pianon1213_test_list, i );
         Ukds.Frs.Pianon1213_IO.Save( a_pianon1213_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianon1213_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_pianon1213_test_item := Ukds.Frs.Pianon1213_List_Package.element( a_pianon1213_test_list, i );
         Ukds.Frs.Pianon1213_IO.Delete( a_pianon1213_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianon1213_Create_Test: retrieve all records" );
      Ukds.Frs.Pianon1213_List_Package.iterate( a_pianon1213_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Pianon1213_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Pianon1213_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Pianon1213_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Pianon1213_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Pianon1314_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Pianon1314_List_Package.Cursor ) is 
      a_pianon1314_test_item : Ukds.Frs.Pianon1314;
      begin
         a_pianon1314_test_item := Ukds.Frs.Pianon1314_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_pianon1314_test_item ));
      end print;

   
      a_pianon1314_test_item : Ukds.Frs.Pianon1314;
      a_pianon1314_test_list : Ukds.Frs.Pianon1314_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Pianon1314_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Pianon1314_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Pianon1314_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_pianon1314_test_item.user_id := Ukds.Frs.Pianon1314_IO.Next_Free_user_id;
         a_pianon1314_test_item.edition := Ukds.Frs.Pianon1314_IO.Next_Free_edition;
         a_pianon1314_test_item.year := Ukds.Frs.Pianon1314_IO.Next_Free_year;
         a_pianon1314_test_item.benunit := Ukds.Frs.Pianon1314_IO.Next_Free_benunit;
         a_pianon1314_test_item.sernum := Ukds.Frs.Pianon1314_IO.Next_Free_sernum;
         -- missing declaration for a_pianon1314_test_item.gvtregn;
         -- missing declaration for a_pianon1314_test_item.fambu;
         -- missing declaration for a_pianon1314_test_item.newfambu;
         -- missing declaration for a_pianon1314_test_item.sexhd;
         -- missing declaration for a_pianon1314_test_item.adultb;
         -- missing declaration for a_pianon1314_test_item.ethgrphh;
         -- missing declaration for a_pianon1314_test_item.gs_newbu;
         -- missing declaration for a_pianon1314_test_item.gs_newpp;
         -- missing declaration for a_pianon1314_test_item.mbhcdec;
         -- missing declaration for a_pianon1314_test_item.obhcdec;
         -- missing declaration for a_pianon1314_test_item.mahcdec;
         -- missing declaration for a_pianon1314_test_item.oahcdec;
         -- missing declaration for a_pianon1314_test_item.sexsp;
         -- missing declaration for a_pianon1314_test_item.newfamb2;
         a_pianon1314_test_item.pidefbhc := 1010100.012 + Amount( i );
         a_pianon1314_test_item.pidefahc := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1314_test_item.pigrosbu;
         -- missing declaration for a_pianon1314_test_item.pinincbu;
         -- missing declaration for a_pianon1314_test_item.pigoccbu;
         -- missing declaration for a_pianon1314_test_item.pippenbu;
         -- missing declaration for a_pianon1314_test_item.piginvbu;
         -- missing declaration for a_pianon1314_test_item.pigernbu;
         -- missing declaration for a_pianon1314_test_item.pibenibu;
         -- missing declaration for a_pianon1314_test_item.piothibu;
         -- missing declaration for a_pianon1314_test_item.pinahcbu;
         -- missing declaration for a_pianon1314_test_item.piirbbu;
         -- missing declaration for a_pianon1314_test_item.pidisben;
         -- missing declaration for a_pianon1314_test_item.piretben;
         -- missing declaration for a_pianon1314_test_item.pripenbu;
         -- missing declaration for a_pianon1314_test_item.nonben2bu;
         -- missing declaration for a_pianon1314_test_item.perbenbu;
         -- missing declaration for a_pianon1314_test_item.perbenbu2;
         -- missing declaration for a_pianon1314_test_item.rrpen;
         -- missing declaration for a_pianon1314_test_item.newfambu2;
         -- missing declaration for a_pianon1314_test_item.dummy;
         a_pianon1314_test_item.coup_q1 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.coup_q2 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.coup_q3 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.coup_q4 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.coup_q5 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.acou_q1 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.acou_q2 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.acou_q3 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.acou_q4 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.acou_q5 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.sing_q1 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.sing_q2 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.sing_q3 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.sing_q4 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.sing_q5 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.asin_q1 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.asin_q2 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.asin_q3 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.asin_q4 := 1010100.012 + Amount( i );
         a_pianon1314_test_item.asin_q5 := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1314_test_item.clust;
         -- missing declaration for a_pianon1314_test_item.strat;
         -- missing declaration for a_pianon1314_test_item.agehd80;
         -- missing declaration for a_pianon1314_test_item.agesp80;
         Ukds.Frs.Pianon1314_IO.Save( a_pianon1314_test_item, False );         
      end loop;
      
      a_pianon1314_test_list := Ukds.Frs.Pianon1314_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Pianon1314_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_pianon1314_test_item := Ukds.Frs.Pianon1314_List_Package.element( a_pianon1314_test_list, i );
         Ukds.Frs.Pianon1314_IO.Save( a_pianon1314_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianon1314_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_pianon1314_test_item := Ukds.Frs.Pianon1314_List_Package.element( a_pianon1314_test_list, i );
         Ukds.Frs.Pianon1314_IO.Delete( a_pianon1314_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianon1314_Create_Test: retrieve all records" );
      Ukds.Frs.Pianon1314_List_Package.iterate( a_pianon1314_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Pianon1314_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Pianon1314_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Pianon1314_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Pianon1314_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Pianon1415_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Pianon1415_List_Package.Cursor ) is 
      a_pianon1415_test_item : Ukds.Frs.Pianon1415;
      begin
         a_pianon1415_test_item := Ukds.Frs.Pianon1415_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_pianon1415_test_item ));
      end print;

   
      a_pianon1415_test_item : Ukds.Frs.Pianon1415;
      a_pianon1415_test_list : Ukds.Frs.Pianon1415_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Pianon1415_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Pianon1415_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Pianon1415_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_pianon1415_test_item.user_id := Ukds.Frs.Pianon1415_IO.Next_Free_user_id;
         a_pianon1415_test_item.edition := Ukds.Frs.Pianon1415_IO.Next_Free_edition;
         a_pianon1415_test_item.year := Ukds.Frs.Pianon1415_IO.Next_Free_year;
         a_pianon1415_test_item.benunit := Ukds.Frs.Pianon1415_IO.Next_Free_benunit;
         a_pianon1415_test_item.sernum := Ukds.Frs.Pianon1415_IO.Next_Free_sernum;
         -- missing declaration for a_pianon1415_test_item.gvtregn;
         -- missing declaration for a_pianon1415_test_item.fambu;
         -- missing declaration for a_pianon1415_test_item.newfambu;
         -- missing declaration for a_pianon1415_test_item.sexhd;
         -- missing declaration for a_pianon1415_test_item.adultb;
         -- missing declaration for a_pianon1415_test_item.ethgrphh;
         a_pianon1415_test_item.winpaybu := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1415_test_item.gs_newbu;
         -- missing declaration for a_pianon1415_test_item.gs_newpp;
         -- missing declaration for a_pianon1415_test_item.mbhcdec;
         -- missing declaration for a_pianon1415_test_item.obhcdec;
         -- missing declaration for a_pianon1415_test_item.mahcdec;
         -- missing declaration for a_pianon1415_test_item.oahcdec;
         -- missing declaration for a_pianon1415_test_item.sexsp;
         -- missing declaration for a_pianon1415_test_item.newfamb2;
         a_pianon1415_test_item.pidefbhc := 1010100.012 + Amount( i );
         a_pianon1415_test_item.pidefahc := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1415_test_item.pigrosbu;
         -- missing declaration for a_pianon1415_test_item.pinincbu;
         -- missing declaration for a_pianon1415_test_item.pigoccbu;
         -- missing declaration for a_pianon1415_test_item.pippenbu;
         -- missing declaration for a_pianon1415_test_item.piginvbu;
         -- missing declaration for a_pianon1415_test_item.pigernbu;
         -- missing declaration for a_pianon1415_test_item.pibenibu;
         -- missing declaration for a_pianon1415_test_item.piothibu;
         -- missing declaration for a_pianon1415_test_item.pinahcbu;
         -- missing declaration for a_pianon1415_test_item.pinannbu;
         -- missing declaration for a_pianon1415_test_item.piirbbu;
         -- missing declaration for a_pianon1415_test_item.pidisben;
         -- missing declaration for a_pianon1415_test_item.piretben;
         -- missing declaration for a_pianon1415_test_item.pripenbu;
         a_pianon1415_test_item.tvpaybu := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1415_test_item.nonben2bu;
         -- missing declaration for a_pianon1415_test_item.perbenbu;
         -- missing declaration for a_pianon1415_test_item.perbenbu2;
         -- missing declaration for a_pianon1415_test_item.rrpen;
         -- missing declaration for a_pianon1415_test_item.newfambu2;
         -- missing declaration for a_pianon1415_test_item.dummy;
         a_pianon1415_test_item.coup_q1 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.coup_q2 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.coup_q3 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.coup_q4 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.coup_q5 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.acou_q1 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.acou_q2 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.acou_q3 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.acou_q4 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.acou_q5 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.sing_q1 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.sing_q2 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.sing_q3 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.sing_q4 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.sing_q5 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.asin_q1 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.asin_q2 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.asin_q3 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.asin_q4 := 1010100.012 + Amount( i );
         a_pianon1415_test_item.asin_q5 := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1415_test_item.clust;
         -- missing declaration for a_pianon1415_test_item.strat;
         -- missing declaration for a_pianon1415_test_item.agehd80;
         -- missing declaration for a_pianon1415_test_item.agesp80;
         Ukds.Frs.Pianon1415_IO.Save( a_pianon1415_test_item, False );         
      end loop;
      
      a_pianon1415_test_list := Ukds.Frs.Pianon1415_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Pianon1415_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_pianon1415_test_item := Ukds.Frs.Pianon1415_List_Package.element( a_pianon1415_test_list, i );
         Ukds.Frs.Pianon1415_IO.Save( a_pianon1415_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianon1415_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_pianon1415_test_item := Ukds.Frs.Pianon1415_List_Package.element( a_pianon1415_test_list, i );
         Ukds.Frs.Pianon1415_IO.Delete( a_pianon1415_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianon1415_Create_Test: retrieve all records" );
      Ukds.Frs.Pianon1415_List_Package.iterate( a_pianon1415_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Pianon1415_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Pianon1415_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Pianon1415_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Pianon1415_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Pianon1516_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Pianon1516_List_Package.Cursor ) is 
      a_pianon1516_test_item : Ukds.Frs.Pianon1516;
      begin
         a_pianon1516_test_item := Ukds.Frs.Pianon1516_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_pianon1516_test_item ));
      end print;

   
      a_pianon1516_test_item : Ukds.Frs.Pianon1516;
      a_pianon1516_test_list : Ukds.Frs.Pianon1516_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Pianon1516_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Pianon1516_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Pianon1516_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_pianon1516_test_item.user_id := Ukds.Frs.Pianon1516_IO.Next_Free_user_id;
         a_pianon1516_test_item.edition := Ukds.Frs.Pianon1516_IO.Next_Free_edition;
         a_pianon1516_test_item.year := Ukds.Frs.Pianon1516_IO.Next_Free_year;
         a_pianon1516_test_item.benunit := Ukds.Frs.Pianon1516_IO.Next_Free_benunit;
         a_pianon1516_test_item.sernum := Ukds.Frs.Pianon1516_IO.Next_Free_sernum;
         -- missing declaration for a_pianon1516_test_item.gvtregn;
         -- missing declaration for a_pianon1516_test_item.fambu;
         -- missing declaration for a_pianon1516_test_item.newfambu;
         -- missing declaration for a_pianon1516_test_item.sexhd;
         -- missing declaration for a_pianon1516_test_item.adultb;
         -- missing declaration for a_pianon1516_test_item.ethgrphh;
         -- missing declaration for a_pianon1516_test_item.chbenbu;
         a_pianon1516_test_item.winpaybu := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1516_test_item.gs_newbu;
         -- missing declaration for a_pianon1516_test_item.gs_newpp;
         -- missing declaration for a_pianon1516_test_item.mbhcdec;
         -- missing declaration for a_pianon1516_test_item.obhcdec;
         -- missing declaration for a_pianon1516_test_item.mahcdec;
         -- missing declaration for a_pianon1516_test_item.oahcdec;
         -- missing declaration for a_pianon1516_test_item.sexsp;
         -- missing declaration for a_pianon1516_test_item.newfamb2;
         a_pianon1516_test_item.pidefbhc := 1010100.012 + Amount( i );
         a_pianon1516_test_item.pidefahc := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1516_test_item.pigrosbu;
         -- missing declaration for a_pianon1516_test_item.pinincbu;
         -- missing declaration for a_pianon1516_test_item.pigoccbu;
         -- missing declaration for a_pianon1516_test_item.pippenbu;
         -- missing declaration for a_pianon1516_test_item.piginvbu;
         -- missing declaration for a_pianon1516_test_item.pigernbu;
         -- missing declaration for a_pianon1516_test_item.pibenibu;
         -- missing declaration for a_pianon1516_test_item.piothibu;
         -- missing declaration for a_pianon1516_test_item.pinahcbu;
         -- missing declaration for a_pianon1516_test_item.piirbbu;
         -- missing declaration for a_pianon1516_test_item.pidisben;
         -- missing declaration for a_pianon1516_test_item.piretben;
         -- missing declaration for a_pianon1516_test_item.pripenbu;
         a_pianon1516_test_item.tvpaybu := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1516_test_item.nonben2bu;
         -- missing declaration for a_pianon1516_test_item.perbenbu;
         -- missing declaration for a_pianon1516_test_item.perbenbu2;
         -- missing declaration for a_pianon1516_test_item.rrpen;
         -- missing declaration for a_pianon1516_test_item.newfambu2;
         -- missing declaration for a_pianon1516_test_item.dummy;
         a_pianon1516_test_item.coup_q1 := 1010100.012 + Amount( i );
         a_pianon1516_test_item.coup_q2 := 1010100.012 + Amount( i );
         a_pianon1516_test_item.coup_q3 := 1010100.012 + Amount( i );
         a_pianon1516_test_item.coup_q4 := 1010100.012 + Amount( i );
         a_pianon1516_test_item.coup_q5 := 1010100.012 + Amount( i );
         a_pianon1516_test_item.acou_q1 := 1010100.012 + Amount( i );
         a_pianon1516_test_item.acou_q2 := 1010100.012 + Amount( i );
         a_pianon1516_test_item.acou_q3 := 1010100.012 + Amount( i );
         a_pianon1516_test_item.acou_q4 := 1010100.012 + Amount( i );
         a_pianon1516_test_item.acou_q5 := 1010100.012 + Amount( i );
         -- missing declaration for a_pianon1516_test_item.sing_q1;
         -- missing declaration for a_pianon1516_test_item.sing_q2;
         -- missing declaration for a_pianon1516_test_item.sing_q3;
         -- missing declaration for a_pianon1516_test_item.sing_q4;
         -- missing declaration for a_pianon1516_test_item.sing_q5;
         -- missing declaration for a_pianon1516_test_item.asin_q1;
         -- missing declaration for a_pianon1516_test_item.asin_q2;
         -- missing declaration for a_pianon1516_test_item.asin_q3;
         -- missing declaration for a_pianon1516_test_item.asin_q4;
         -- missing declaration for a_pianon1516_test_item.asin_q5;
         -- missing declaration for a_pianon1516_test_item.clust;
         -- missing declaration for a_pianon1516_test_item.strat;
         -- missing declaration for a_pianon1516_test_item.agehd80;
         -- missing declaration for a_pianon1516_test_item.agesp80;
         Ukds.Frs.Pianon1516_IO.Save( a_pianon1516_test_item, False );         
      end loop;
      
      a_pianon1516_test_list := Ukds.Frs.Pianon1516_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Pianon1516_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_pianon1516_test_item := Ukds.Frs.Pianon1516_List_Package.element( a_pianon1516_test_list, i );
         Ukds.Frs.Pianon1516_IO.Save( a_pianon1516_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianon1516_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_pianon1516_test_item := Ukds.Frs.Pianon1516_List_Package.element( a_pianon1516_test_list, i );
         Ukds.Frs.Pianon1516_IO.Delete( a_pianon1516_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Pianon1516_Create_Test: retrieve all records" );
      Ukds.Frs.Pianon1516_List_Package.iterate( a_pianon1516_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Pianon1516_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Pianon1516_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Pianon1516_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Pianon1516_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Prscrptn_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Prscrptn_List_Package.Cursor ) is 
      a_prscrptn_test_item : Ukds.Frs.Prscrptn;
      begin
         a_prscrptn_test_item := Ukds.Frs.Prscrptn_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_prscrptn_test_item ));
      end print;

   
      a_prscrptn_test_item : Ukds.Frs.Prscrptn;
      a_prscrptn_test_list : Ukds.Frs.Prscrptn_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Prscrptn_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Prscrptn_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Prscrptn_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_prscrptn_test_item.user_id := Ukds.Frs.Prscrptn_IO.Next_Free_user_id;
         a_prscrptn_test_item.edition := Ukds.Frs.Prscrptn_IO.Next_Free_edition;
         a_prscrptn_test_item.year := Ukds.Frs.Prscrptn_IO.Next_Free_year;
         a_prscrptn_test_item.sernum := Ukds.Frs.Prscrptn_IO.Next_Free_sernum;
         a_prscrptn_test_item.benunit := Ukds.Frs.Prscrptn_IO.Next_Free_benunit;
         a_prscrptn_test_item.person := Ukds.Frs.Prscrptn_IO.Next_Free_person;
         -- missing declaration for a_prscrptn_test_item.issue;
         -- missing declaration for a_prscrptn_test_item.med12m01;
         -- missing declaration for a_prscrptn_test_item.med12m02;
         -- missing declaration for a_prscrptn_test_item.med12m03;
         -- missing declaration for a_prscrptn_test_item.med12m04;
         -- missing declaration for a_prscrptn_test_item.med12m05;
         -- missing declaration for a_prscrptn_test_item.med12m06;
         -- missing declaration for a_prscrptn_test_item.med12m07;
         -- missing declaration for a_prscrptn_test_item.med12m08;
         -- missing declaration for a_prscrptn_test_item.med12m09;
         -- missing declaration for a_prscrptn_test_item.med12m10;
         -- missing declaration for a_prscrptn_test_item.med12m11;
         -- missing declaration for a_prscrptn_test_item.med12m12;
         -- missing declaration for a_prscrptn_test_item.med12m13;
         -- missing declaration for a_prscrptn_test_item.medrep;
         -- missing declaration for a_prscrptn_test_item.medrpnm;
         -- missing declaration for a_prscrptn_test_item.month;
         Ukds.Frs.Prscrptn_IO.Save( a_prscrptn_test_item, False );         
      end loop;
      
      a_prscrptn_test_list := Ukds.Frs.Prscrptn_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Prscrptn_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_prscrptn_test_item := Ukds.Frs.Prscrptn_List_Package.element( a_prscrptn_test_list, i );
         Ukds.Frs.Prscrptn_IO.Save( a_prscrptn_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Prscrptn_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_prscrptn_test_item := Ukds.Frs.Prscrptn_List_Package.element( a_prscrptn_test_list, i );
         Ukds.Frs.Prscrptn_IO.Delete( a_prscrptn_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Prscrptn_Create_Test: retrieve all records" );
      Ukds.Frs.Prscrptn_List_Package.iterate( a_prscrptn_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Prscrptn_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Prscrptn_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Prscrptn_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Prscrptn_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Rentcont_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Rentcont_List_Package.Cursor ) is 
      a_rentcont_test_item : Ukds.Frs.Rentcont;
      begin
         a_rentcont_test_item := Ukds.Frs.Rentcont_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_rentcont_test_item ));
      end print;

   
      a_rentcont_test_item : Ukds.Frs.Rentcont;
      a_rentcont_test_list : Ukds.Frs.Rentcont_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Rentcont_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Rentcont_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Rentcont_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_rentcont_test_item.user_id := Ukds.Frs.Rentcont_IO.Next_Free_user_id;
         a_rentcont_test_item.edition := Ukds.Frs.Rentcont_IO.Next_Free_edition;
         a_rentcont_test_item.year := Ukds.Frs.Rentcont_IO.Next_Free_year;
         a_rentcont_test_item.sernum := Ukds.Frs.Rentcont_IO.Next_Free_sernum;
         a_rentcont_test_item.rentseq := Ukds.Frs.Rentcont_IO.Next_Free_rentseq;
         a_rentcont_test_item.accamt := 1010100.012 + Amount( i );
         -- missing declaration for a_rentcont_test_item.accchk;
         -- missing declaration for a_rentcont_test_item.accpay;
         -- missing declaration for a_rentcont_test_item.accpd;
         -- missing declaration for a_rentcont_test_item.month;
         -- missing declaration for a_rentcont_test_item.issue;
         Ukds.Frs.Rentcont_IO.Save( a_rentcont_test_item, False );         
      end loop;
      
      a_rentcont_test_list := Ukds.Frs.Rentcont_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Rentcont_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_rentcont_test_item := Ukds.Frs.Rentcont_List_Package.element( a_rentcont_test_list, i );
         Ukds.Frs.Rentcont_IO.Save( a_rentcont_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Rentcont_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_rentcont_test_item := Ukds.Frs.Rentcont_List_Package.element( a_rentcont_test_list, i );
         Ukds.Frs.Rentcont_IO.Delete( a_rentcont_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Rentcont_Create_Test: retrieve all records" );
      Ukds.Frs.Rentcont_List_Package.iterate( a_rentcont_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Rentcont_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Rentcont_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Rentcont_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Rentcont_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Renter_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Renter_List_Package.Cursor ) is 
      a_renter_test_item : Ukds.Frs.Renter;
      begin
         a_renter_test_item := Ukds.Frs.Renter_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_renter_test_item ));
      end print;

   
      a_renter_test_item : Ukds.Frs.Renter;
      a_renter_test_list : Ukds.Frs.Renter_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Renter_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Renter_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Renter_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_renter_test_item.user_id := Ukds.Frs.Renter_IO.Next_Free_user_id;
         a_renter_test_item.edition := Ukds.Frs.Renter_IO.Next_Free_edition;
         a_renter_test_item.year := Ukds.Frs.Renter_IO.Next_Free_year;
         a_renter_test_item.sernum := Ukds.Frs.Renter_IO.Next_Free_sernum;
         -- missing declaration for a_renter_test_item.accjbp01;
         -- missing declaration for a_renter_test_item.accjbp02;
         -- missing declaration for a_renter_test_item.accjbp03;
         -- missing declaration for a_renter_test_item.accjbp04;
         -- missing declaration for a_renter_test_item.accjbp05;
         -- missing declaration for a_renter_test_item.accjbp06;
         -- missing declaration for a_renter_test_item.accjbp07;
         -- missing declaration for a_renter_test_item.accjbp08;
         -- missing declaration for a_renter_test_item.accjbp09;
         -- missing declaration for a_renter_test_item.accjbp10;
         -- missing declaration for a_renter_test_item.accjbp11;
         -- missing declaration for a_renter_test_item.accjbp12;
         -- missing declaration for a_renter_test_item.accjbp13;
         -- missing declaration for a_renter_test_item.accjbp14;
         -- missing declaration for a_renter_test_item.accjob;
         -- missing declaration for a_renter_test_item.accnonhh;
         -- missing declaration for a_renter_test_item.ctract;
         a_renter_test_item.eligamt := 1010100.012 + Amount( i );
         -- missing declaration for a_renter_test_item.eligpd;
         -- missing declaration for a_renter_test_item.fairrent;
         -- missing declaration for a_renter_test_item.furnish;
         a_renter_test_item.hbenamt := 1010100.012 + Amount( i );
         -- missing declaration for a_renter_test_item.hbenchk;
         -- missing declaration for a_renter_test_item.hbenefit;
         -- missing declaration for a_renter_test_item.hbenpd;
         -- missing declaration for a_renter_test_item.hbenwait;
         -- missing declaration for a_renter_test_item.hbweeks;
         -- missing declaration for a_renter_test_item.landlord;
         -- missing declaration for a_renter_test_item.niystart;
         -- missing declaration for a_renter_test_item.othway;
         -- missing declaration for a_renter_test_item.rebate;
         a_renter_test_item.rent := 1010100.012 + Amount( i );
         -- missing declaration for a_renter_test_item.rentdk;
         -- missing declaration for a_renter_test_item.rentdoc;
         a_renter_test_item.rentfull := 1010100.012 + Amount( i );
         -- missing declaration for a_renter_test_item.renthol;
         -- missing declaration for a_renter_test_item.rentpd;
         -- missing declaration for a_renter_test_item.resll;
         -- missing declaration for a_renter_test_item.resll2;
         -- missing declaration for a_renter_test_item.serinc1;
         -- missing declaration for a_renter_test_item.serinc2;
         -- missing declaration for a_renter_test_item.serinc3;
         -- missing declaration for a_renter_test_item.serinc4;
         -- missing declaration for a_renter_test_item.serinc5;
         -- missing declaration for a_renter_test_item.short1;
         -- missing declaration for a_renter_test_item.short2;
         -- missing declaration for a_renter_test_item.weekhol;
         -- missing declaration for a_renter_test_item.wsinc;
         a_renter_test_item.wsincamt := 1010100.012 + Amount( i );
         -- missing declaration for a_renter_test_item.ystartr;
         -- missing declaration for a_renter_test_item.month;
         -- missing declaration for a_renter_test_item.hbyears;
         -- missing declaration for a_renter_test_item.lowshort;
         -- missing declaration for a_renter_test_item.othtype;
         -- missing declaration for a_renter_test_item.tentype;
         -- missing declaration for a_renter_test_item.hbmnth;
         -- missing declaration for a_renter_test_item.hbyear;
         -- missing declaration for a_renter_test_item.issue;
         -- missing declaration for a_renter_test_item.hbrecp;
         -- missing declaration for a_renter_test_item.lhaexs;
         -- missing declaration for a_renter_test_item.lhalss;
         -- missing declaration for a_renter_test_item.rentpd1;
         -- missing declaration for a_renter_test_item.rentpd2;
         -- missing declaration for a_renter_test_item.serinc6;
         -- missing declaration for a_renter_test_item.serinc7;
         -- missing declaration for a_renter_test_item.serinc8;
         -- missing declaration for a_renter_test_item.serincam;
         Ukds.Frs.Renter_IO.Save( a_renter_test_item, False );         
      end loop;
      
      a_renter_test_list := Ukds.Frs.Renter_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Renter_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_renter_test_item := Ukds.Frs.Renter_List_Package.element( a_renter_test_list, i );
         Ukds.Frs.Renter_IO.Save( a_renter_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Renter_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_renter_test_item := Ukds.Frs.Renter_List_Package.element( a_renter_test_list, i );
         Ukds.Frs.Renter_IO.Delete( a_renter_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Renter_Create_Test: retrieve all records" );
      Ukds.Frs.Renter_List_Package.iterate( a_renter_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Renter_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Renter_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Renter_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Renter_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Transact_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Transact_List_Package.Cursor ) is 
      a_transact_test_item : Ukds.Frs.Transact;
      begin
         a_transact_test_item := Ukds.Frs.Transact_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_transact_test_item ));
      end print;

   
      a_transact_test_item : Ukds.Frs.Transact;
      a_transact_test_list : Ukds.Frs.Transact_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Transact_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Transact_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Transact_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_transact_test_item.user_id := Ukds.Frs.Transact_IO.Next_Free_user_id;
         a_transact_test_item.edition := Ukds.Frs.Transact_IO.Next_Free_edition;
         a_transact_test_item.year := Ukds.Frs.Transact_IO.Next_Free_year;
         a_transact_test_item.sernum := Ukds.Frs.Transact_IO.Next_Free_sernum;
         a_transact_test_item.rowid := Ukds.Frs.Transact_IO.Next_Free_rowid;
         -- missing declaration for a_transact_test_item.key1;
         -- missing declaration for a_transact_test_item.key2;
         -- missing declaration for a_transact_test_item.key3;
         -- missing declaration for a_transact_test_item.key4;
         -- missing declaration for a_transact_test_item.key5;
         a_transact_test_item.frstable := To_Unbounded_String("dat forfrstable" & i'Img );
         a_transact_test_item.frsvar := To_Unbounded_String("dat forfrsvar" & i'Img );
         a_transact_test_item.old_val := 1010100.012 + Amount( i );
         a_transact_test_item.new_val := 1010100.012 + Amount( i );
         a_transact_test_item.datetime := Ada.Calendar.Clock;
         a_transact_test_item.appldate := Ada.Calendar.Clock;
         -- missing declaration for a_transact_test_item.batch;
         a_transact_test_item.trantype := To_Unbounded_String("dat fortrantype" & i'Img );
         -- missing declaration for a_transact_test_item.reason;
         Ukds.Frs.Transact_IO.Save( a_transact_test_item, False );         
      end loop;
      
      a_transact_test_list := Ukds.Frs.Transact_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Transact_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_transact_test_item := Ukds.Frs.Transact_List_Package.element( a_transact_test_list, i );
         a_transact_test_item.frstable := To_Unbounded_String("Altered::dat forfrstable" & i'Img);
         a_transact_test_item.frsvar := To_Unbounded_String("Altered::dat forfrsvar" & i'Img);
         a_transact_test_item.trantype := To_Unbounded_String("Altered::dat fortrantype" & i'Img);
         Ukds.Frs.Transact_IO.Save( a_transact_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Transact_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_transact_test_item := Ukds.Frs.Transact_List_Package.element( a_transact_test_list, i );
         Ukds.Frs.Transact_IO.Delete( a_transact_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Transact_Create_Test: retrieve all records" );
      Ukds.Frs.Transact_List_Package.iterate( a_transact_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Transact_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Transact_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Transact_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Transact_Create_Test;

   
--
-- test creating and deleting records  
--
--
   procedure Ukds_Frs_Vehicle_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Vehicle_List_Package.Cursor ) is 
      a_vehicle_test_item : Ukds.Frs.Vehicle;
      begin
         a_vehicle_test_item := Ukds.Frs.Vehicle_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_vehicle_test_item ));
      end print;

   
      a_vehicle_test_item : Ukds.Frs.Vehicle;
      a_vehicle_test_list : Ukds.Frs.Vehicle_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Vehicle_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Vehicle_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Vehicle_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_vehicle_test_item.user_id := Ukds.Frs.Vehicle_IO.Next_Free_user_id;
         a_vehicle_test_item.edition := Ukds.Frs.Vehicle_IO.Next_Free_edition;
         a_vehicle_test_item.year := Ukds.Frs.Vehicle_IO.Next_Free_year;
         a_vehicle_test_item.sernum := Ukds.Frs.Vehicle_IO.Next_Free_sernum;
         a_vehicle_test_item.vehseq := Ukds.Frs.Vehicle_IO.Next_Free_vehseq;
         -- missing declaration for a_vehicle_test_item.vehic;
         -- missing declaration for a_vehicle_test_item.vehown;
         -- missing declaration for a_vehicle_test_item.month;
         Ukds.Frs.Vehicle_IO.Save( a_vehicle_test_item, False );         
      end loop;
      
      a_vehicle_test_list := Ukds.Frs.Vehicle_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Vehicle_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_vehicle_test_item := Ukds.Frs.Vehicle_List_Package.element( a_vehicle_test_list, i );
         Ukds.Frs.Vehicle_IO.Save( a_vehicle_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Vehicle_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_vehicle_test_item := Ukds.Frs.Vehicle_List_Package.element( a_vehicle_test_list, i );
         Ukds.Frs.Vehicle_IO.Delete( a_vehicle_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Vehicle_Create_Test: retrieve all records" );
      Ukds.Frs.Vehicle_List_Package.iterate( a_vehicle_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Vehicle_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Vehicle_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Vehicle_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Vehicle_Create_Test;

   
   
   
   
   
   
   procedure Register_Tests (T : in out Test_Case) is
   begin
      --
      -- Tests of record creation/deletion
      --
      Register_Routine (T, Ukds_Frs_Househol_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Househol" );
      Register_Routine (T, Ukds_Frs_Benunit_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Benunit" );
      Register_Routine (T, Ukds_Frs_Adult_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Adult" );
      Register_Routine (T, Ukds_Frs_Child_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Child" );
      Register_Routine (T, Ukds_Frs_Accounts_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Accounts" );
      Register_Routine (T, Ukds_Frs_Accouts_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Accouts" );
      Register_Routine (T, Ukds_Frs_Admin_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Admin" );
      Register_Routine (T, Ukds_Frs_Assets_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Assets" );
      Register_Routine (T, Ukds_Frs_Benefits_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Benefits" );
      Register_Routine (T, Ukds_Frs_Care_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Care" );
      Register_Routine (T, Ukds_Frs_Childcare_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Childcare" );
      Register_Routine (T, Ukds_Frs_Chldcare_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Chldcare" );
      Register_Routine (T, Ukds_Frs_Endowmnt_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Endowmnt" );
      Register_Routine (T, Ukds_Frs_Extchild_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Extchild" );
      Register_Routine (T, Ukds_Frs_Govpay_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Govpay" );
      Register_Routine (T, Ukds_Frs_Insuranc_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Insuranc" );
      Register_Routine (T, Ukds_Frs_Job_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Job" );
      Register_Routine (T, Ukds_Frs_Maint_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Maint" );
      Register_Routine (T, Ukds_Frs_Mortcont_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Mortcont" );
      Register_Routine (T, Ukds_Frs_Mortgage_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Mortgage" );
      Register_Routine (T, Ukds_Frs_Nimigr_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Nimigr" );
      Register_Routine (T, Ukds_Frs_Nimigra_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Nimigra" );
      Register_Routine (T, Ukds_Frs_Oddjob_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Oddjob" );
      Register_Routine (T, Ukds_Frs_Owner_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Owner" );
      Register_Routine (T, Ukds_Frs_Penamt_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Penamt" );
      Register_Routine (T, Ukds_Frs_Penprov_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Penprov" );
      Register_Routine (T, Ukds_Frs_Pension_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Pension" );
      Register_Routine (T, Ukds_Frs_Pianom0809_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Pianom0809" );
      Register_Routine (T, Ukds_Frs_Pianon0910_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Pianon0910" );
      Register_Routine (T, Ukds_Frs_Pianon1011_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Pianon1011" );
      Register_Routine (T, Ukds_Frs_Pianon1213_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Pianon1213" );
      Register_Routine (T, Ukds_Frs_Pianon1314_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Pianon1314" );
      Register_Routine (T, Ukds_Frs_Pianon1415_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Pianon1415" );
      Register_Routine (T, Ukds_Frs_Pianon1516_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Pianon1516" );
      Register_Routine (T, Ukds_Frs_Prscrptn_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Prscrptn" );
      Register_Routine (T, Ukds_Frs_Rentcont_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Rentcont" );
      Register_Routine (T, Ukds_Frs_Renter_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Renter" );
      Register_Routine (T, Ukds_Frs_Transact_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Transact" );
      Register_Routine (T, Ukds_Frs_Vehicle_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Vehicle" );
      --
      -- Tests of foreign key relationships
      --
      --  not implemented yet Register_Routine (T, Ukds_Frs_Househol_Child_Retrieve_Test'Access, "Test of Finding Children of Ukds.Frs.Househol" );
      --  not implemented yet Register_Routine (T, Ukds_Frs_Benunit_Child_Retrieve_Test'Access, "Test of Finding Children of Ukds.Frs.Benunit" );
      --  not implemented yet Register_Routine (T, Ukds_Frs_Adult_Child_Retrieve_Test'Access, "Test of Finding Children of Ukds.Frs.Adult" );
   end Register_Tests;
   
   --  Register routines to be run
   
   
   function Name ( t : Test_Case ) return Message_String is
   begin
      return Format( "Ukds_Test Test Suite" );
   end Name;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===
   
   --  Preparation performed before each routine:
   procedure Set_Up( t : in out Test_Case ) is
   begin
      Connection_Pool.Initialise( 10 ); 
      GNATColl.Traces.Parse_Config_File( "./etc/logging_config_file.txt" );
   end Set_Up;
   
   --  Preparation performed after each routine:
   procedure Shut_Down( t : in out Test_Case ) is
   begin
      Connection_Pool.Shutdown;
   end Shut_Down;
   
   
begin
   null;
end Ukds_Test;

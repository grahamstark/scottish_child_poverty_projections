--
-- Created by ada_generator.py on 2017-09-05 20:57:19.998282
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
with Ukds.Frs.Frs1516_IO;
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
         -- missing declaration for a_childcare_test_item.chamt;
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
   procedure Ukds_Frs_Frs1516_Create_Test( T : in out AUnit.Test_Cases.Test_Case'Class ) is
   
   
      --
      -- local print iteration routine
      --
      procedure Print( pos : Ukds.Frs.Frs1516_List_Package.Cursor ) is 
      a_frs1516_test_item : Ukds.Frs.Frs1516;
      begin
         a_frs1516_test_item := Ukds.Frs.Frs1516_List_Package.Element( pos );
         Log( Ukds.frs.To_String( a_frs1516_test_item ));
      end print;

   
      a_frs1516_test_item : Ukds.Frs.Frs1516;
      a_frs1516_test_list : Ukds.Frs.Frs1516_List;
      criteria  : d.Criteria;
      startTime : Time;
      endTime   : Time;
      elapsed   : Duration;
   begin
      startTime := Clock;
      Log( "Starting test Ukds_Frs_Frs1516_Create_Test" );
      
      Log( "Clearing out the table" );
      Ukds.Frs.Frs1516_IO.Delete( criteria );
      
      Log( "Ukds_Frs_Frs1516_Create_Test: create tests" );
      for i in 1 .. RECORDS_TO_ADD loop
         a_frs1516_test_item.user_id := Ukds.Frs.Frs1516_IO.Next_Free_user_id;
         a_frs1516_test_item.edition := Ukds.Frs.Frs1516_IO.Next_Free_edition;
         a_frs1516_test_item.year := Ukds.Frs.Frs1516_IO.Next_Free_year;
         a_frs1516_test_item.sernum := Ukds.Frs.Frs1516_IO.Next_Free_sernum;
         a_frs1516_test_item.benunit := Ukds.Frs.Frs1516_IO.Next_Free_benunit;
         a_frs1516_test_item.int1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.int2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.int3hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.int4hd;
         a_frs1516_test_item.int5hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.int6hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.int7hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.int8hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.int9hd;
         -- missing declaration for a_frs1516_test_item.int10hd;
         -- missing declaration for a_frs1516_test_item.int11hd;
         -- missing declaration for a_frs1516_test_item.int12hd;
         -- missing declaration for a_frs1516_test_item.int13hd;
         -- missing declaration for a_frs1516_test_item.int14hd;
         -- missing declaration for a_frs1516_test_item.int15hd;
         -- missing declaration for a_frs1516_test_item.int16hd;
         -- missing declaration for a_frs1516_test_item.int17hd;
         -- missing declaration for a_frs1516_test_item.int18hd;
         -- missing declaration for a_frs1516_test_item.int19hd;
         a_frs1516_test_item.int21hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.int22hd;
         -- missing declaration for a_frs1516_test_item.int23hd;
         a_frs1516_test_item.int24hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.int25hd;
         -- missing declaration for a_frs1516_test_item.int26hd;
         a_frs1516_test_item.int27hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.int28hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.int29hd;
         -- missing declaration for a_frs1516_test_item.int30hd;
         a_frs1516_test_item.int1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.int2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.int3sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.int4sp;
         a_frs1516_test_item.int5sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.int6sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.int7sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.int8sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.int9sp;
         -- missing declaration for a_frs1516_test_item.int10sp;
         -- missing declaration for a_frs1516_test_item.int11sp;
         -- missing declaration for a_frs1516_test_item.int12sp;
         -- missing declaration for a_frs1516_test_item.int13sp;
         -- missing declaration for a_frs1516_test_item.int14sp;
         -- missing declaration for a_frs1516_test_item.int15sp;
         -- missing declaration for a_frs1516_test_item.int16sp;
         -- missing declaration for a_frs1516_test_item.int17sp;
         -- missing declaration for a_frs1516_test_item.int18sp;
         -- missing declaration for a_frs1516_test_item.int19sp;
         a_frs1516_test_item.int21sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.int22sp;
         -- missing declaration for a_frs1516_test_item.int23sp;
         a_frs1516_test_item.int24sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.int25sp;
         -- missing declaration for a_frs1516_test_item.int26sp;
         a_frs1516_test_item.int27sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.int28sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.int29sp;
         -- missing declaration for a_frs1516_test_item.int30sp;
         -- missing declaration for a_frs1516_test_item.intx1hd;
         -- missing declaration for a_frs1516_test_item.intx2hd;
         -- missing declaration for a_frs1516_test_item.intx3hd;
         -- missing declaration for a_frs1516_test_item.intx4hd;
         -- missing declaration for a_frs1516_test_item.intx5hd;
         -- missing declaration for a_frs1516_test_item.intx6hd;
         -- missing declaration for a_frs1516_test_item.intx7hd;
         -- missing declaration for a_frs1516_test_item.intx8hd;
         -- missing declaration for a_frs1516_test_item.intx9hd;
         -- missing declaration for a_frs1516_test_item.intx10hd;
         -- missing declaration for a_frs1516_test_item.intx11hd;
         -- missing declaration for a_frs1516_test_item.intx12hd;
         -- missing declaration for a_frs1516_test_item.intx13hd;
         -- missing declaration for a_frs1516_test_item.intx14hd;
         -- missing declaration for a_frs1516_test_item.intx15hd;
         -- missing declaration for a_frs1516_test_item.intx16hd;
         -- missing declaration for a_frs1516_test_item.intx17hd;
         -- missing declaration for a_frs1516_test_item.intx18hd;
         -- missing declaration for a_frs1516_test_item.intx19hd;
         -- missing declaration for a_frs1516_test_item.intx21hd;
         -- missing declaration for a_frs1516_test_item.intx22hd;
         -- missing declaration for a_frs1516_test_item.intx23hd;
         -- missing declaration for a_frs1516_test_item.intx24hd;
         -- missing declaration for a_frs1516_test_item.intx25hd;
         -- missing declaration for a_frs1516_test_item.intx26hd;
         -- missing declaration for a_frs1516_test_item.intx27hd;
         -- missing declaration for a_frs1516_test_item.intx28hd;
         -- missing declaration for a_frs1516_test_item.intx29hd;
         -- missing declaration for a_frs1516_test_item.intx30hd;
         -- missing declaration for a_frs1516_test_item.intx1sp;
         -- missing declaration for a_frs1516_test_item.intx2sp;
         -- missing declaration for a_frs1516_test_item.intx3sp;
         -- missing declaration for a_frs1516_test_item.intx4sp;
         -- missing declaration for a_frs1516_test_item.intx5sp;
         -- missing declaration for a_frs1516_test_item.intx6sp;
         -- missing declaration for a_frs1516_test_item.intx7sp;
         -- missing declaration for a_frs1516_test_item.intx8sp;
         -- missing declaration for a_frs1516_test_item.intx9sp;
         -- missing declaration for a_frs1516_test_item.intx10sp;
         -- missing declaration for a_frs1516_test_item.intx11sp;
         -- missing declaration for a_frs1516_test_item.intx12sp;
         -- missing declaration for a_frs1516_test_item.intx13sp;
         -- missing declaration for a_frs1516_test_item.intx14sp;
         -- missing declaration for a_frs1516_test_item.intx15sp;
         -- missing declaration for a_frs1516_test_item.intx16sp;
         -- missing declaration for a_frs1516_test_item.intx17sp;
         -- missing declaration for a_frs1516_test_item.intx18sp;
         -- missing declaration for a_frs1516_test_item.intx19sp;
         -- missing declaration for a_frs1516_test_item.intx21sp;
         -- missing declaration for a_frs1516_test_item.intx22sp;
         -- missing declaration for a_frs1516_test_item.intx23sp;
         -- missing declaration for a_frs1516_test_item.intx24sp;
         -- missing declaration for a_frs1516_test_item.intx25sp;
         -- missing declaration for a_frs1516_test_item.intx26sp;
         -- missing declaration for a_frs1516_test_item.intx27sp;
         -- missing declaration for a_frs1516_test_item.intx28sp;
         -- missing declaration for a_frs1516_test_item.intx29sp;
         -- missing declaration for a_frs1516_test_item.intx30sp;
         -- missing declaration for a_frs1516_test_item.invt1hd;
         -- missing declaration for a_frs1516_test_item.invt2hd;
         -- missing declaration for a_frs1516_test_item.invt3hd;
         -- missing declaration for a_frs1516_test_item.invt4hd;
         -- missing declaration for a_frs1516_test_item.invt5hd;
         -- missing declaration for a_frs1516_test_item.invt6hd;
         -- missing declaration for a_frs1516_test_item.invt7hd;
         -- missing declaration for a_frs1516_test_item.invt8hd;
         -- missing declaration for a_frs1516_test_item.invt9hd;
         -- missing declaration for a_frs1516_test_item.invt10hd;
         -- missing declaration for a_frs1516_test_item.invt11hd;
         -- missing declaration for a_frs1516_test_item.invt12hd;
         -- missing declaration for a_frs1516_test_item.invt13hd;
         -- missing declaration for a_frs1516_test_item.invt14hd;
         -- missing declaration for a_frs1516_test_item.invt15hd;
         -- missing declaration for a_frs1516_test_item.invt16hd;
         -- missing declaration for a_frs1516_test_item.invt17hd;
         -- missing declaration for a_frs1516_test_item.invt18hd;
         -- missing declaration for a_frs1516_test_item.invt19hd;
         -- missing declaration for a_frs1516_test_item.invt21hd;
         -- missing declaration for a_frs1516_test_item.invt22hd;
         -- missing declaration for a_frs1516_test_item.invt23hd;
         -- missing declaration for a_frs1516_test_item.invt24hd;
         -- missing declaration for a_frs1516_test_item.invt25hd;
         -- missing declaration for a_frs1516_test_item.invt26hd;
         -- missing declaration for a_frs1516_test_item.invt27hd;
         -- missing declaration for a_frs1516_test_item.invt28hd;
         -- missing declaration for a_frs1516_test_item.invt29hd;
         -- missing declaration for a_frs1516_test_item.invt30hd;
         -- missing declaration for a_frs1516_test_item.invt1sp;
         -- missing declaration for a_frs1516_test_item.invt2sp;
         -- missing declaration for a_frs1516_test_item.invt3sp;
         -- missing declaration for a_frs1516_test_item.invt4sp;
         -- missing declaration for a_frs1516_test_item.invt5sp;
         -- missing declaration for a_frs1516_test_item.invt6sp;
         -- missing declaration for a_frs1516_test_item.invt7sp;
         -- missing declaration for a_frs1516_test_item.invt8sp;
         -- missing declaration for a_frs1516_test_item.invt9sp;
         -- missing declaration for a_frs1516_test_item.invt10sp;
         -- missing declaration for a_frs1516_test_item.invt11sp;
         -- missing declaration for a_frs1516_test_item.invt12sp;
         -- missing declaration for a_frs1516_test_item.invt13sp;
         -- missing declaration for a_frs1516_test_item.invt14sp;
         -- missing declaration for a_frs1516_test_item.invt15sp;
         -- missing declaration for a_frs1516_test_item.invt16sp;
         -- missing declaration for a_frs1516_test_item.invt17sp;
         -- missing declaration for a_frs1516_test_item.invt18sp;
         -- missing declaration for a_frs1516_test_item.invt19sp;
         -- missing declaration for a_frs1516_test_item.invt21sp;
         -- missing declaration for a_frs1516_test_item.invt22sp;
         -- missing declaration for a_frs1516_test_item.invt23sp;
         -- missing declaration for a_frs1516_test_item.invt24sp;
         -- missing declaration for a_frs1516_test_item.invt25sp;
         -- missing declaration for a_frs1516_test_item.invt26sp;
         -- missing declaration for a_frs1516_test_item.invt27sp;
         -- missing declaration for a_frs1516_test_item.invt28sp;
         -- missing declaration for a_frs1516_test_item.invt29sp;
         -- missing declaration for a_frs1516_test_item.invt30sp;
         -- missing declaration for a_frs1516_test_item.nsa1hd;
         -- missing declaration for a_frs1516_test_item.nsa2hd;
         -- missing declaration for a_frs1516_test_item.nsa3hd;
         -- missing declaration for a_frs1516_test_item.nsa4hd;
         -- missing declaration for a_frs1516_test_item.nsa5hd;
         -- missing declaration for a_frs1516_test_item.nsa6hd;
         -- missing declaration for a_frs1516_test_item.nsa7hd;
         -- missing declaration for a_frs1516_test_item.nsa8hd;
         -- missing declaration for a_frs1516_test_item.nsa9hd;
         -- missing declaration for a_frs1516_test_item.nsa10hd;
         -- missing declaration for a_frs1516_test_item.nsa11hd;
         -- missing declaration for a_frs1516_test_item.nsa12hd;
         -- missing declaration for a_frs1516_test_item.nsa13hd;
         -- missing declaration for a_frs1516_test_item.nsa14hd;
         -- missing declaration for a_frs1516_test_item.nsa15hd;
         -- missing declaration for a_frs1516_test_item.nsa16hd;
         -- missing declaration for a_frs1516_test_item.nsa17hd;
         -- missing declaration for a_frs1516_test_item.nsa18hd;
         -- missing declaration for a_frs1516_test_item.nsa19hd;
         -- missing declaration for a_frs1516_test_item.nsa21hd;
         -- missing declaration for a_frs1516_test_item.nsa22hd;
         -- missing declaration for a_frs1516_test_item.nsa23hd;
         -- missing declaration for a_frs1516_test_item.nsa24hd;
         -- missing declaration for a_frs1516_test_item.nsa25hd;
         -- missing declaration for a_frs1516_test_item.nsa26hd;
         -- missing declaration for a_frs1516_test_item.nsa27hd;
         -- missing declaration for a_frs1516_test_item.nsa28hd;
         -- missing declaration for a_frs1516_test_item.nsa29hd;
         -- missing declaration for a_frs1516_test_item.nsa30hd;
         -- missing declaration for a_frs1516_test_item.nsa1sp;
         -- missing declaration for a_frs1516_test_item.nsa2sp;
         -- missing declaration for a_frs1516_test_item.nsa3sp;
         -- missing declaration for a_frs1516_test_item.nsa4sp;
         -- missing declaration for a_frs1516_test_item.nsa5sp;
         -- missing declaration for a_frs1516_test_item.nsa6sp;
         -- missing declaration for a_frs1516_test_item.nsa7sp;
         -- missing declaration for a_frs1516_test_item.nsa8sp;
         -- missing declaration for a_frs1516_test_item.nsa9sp;
         -- missing declaration for a_frs1516_test_item.nsa10sp;
         -- missing declaration for a_frs1516_test_item.nsa11sp;
         -- missing declaration for a_frs1516_test_item.nsa12sp;
         -- missing declaration for a_frs1516_test_item.nsa13sp;
         -- missing declaration for a_frs1516_test_item.nsa14sp;
         -- missing declaration for a_frs1516_test_item.nsa15sp;
         -- missing declaration for a_frs1516_test_item.nsa16sp;
         -- missing declaration for a_frs1516_test_item.nsa17sp;
         -- missing declaration for a_frs1516_test_item.nsa18sp;
         -- missing declaration for a_frs1516_test_item.nsa19sp;
         -- missing declaration for a_frs1516_test_item.nsa21sp;
         -- missing declaration for a_frs1516_test_item.nsa22sp;
         -- missing declaration for a_frs1516_test_item.nsa23sp;
         -- missing declaration for a_frs1516_test_item.nsa24sp;
         -- missing declaration for a_frs1516_test_item.nsa25sp;
         -- missing declaration for a_frs1516_test_item.nsa26sp;
         -- missing declaration for a_frs1516_test_item.nsa27sp;
         -- missing declaration for a_frs1516_test_item.nsa28sp;
         -- missing declaration for a_frs1516_test_item.nsa29sp;
         -- missing declaration for a_frs1516_test_item.nsa30sp;
         -- missing declaration for a_frs1516_test_item.ablehd;
         -- missing declaration for a_frs1516_test_item.ablesp;
         -- missing declaration for a_frs1516_test_item.abs1pdhd;
         -- missing declaration for a_frs1516_test_item.abs1pdsp;
         -- missing declaration for a_frs1516_test_item.absparhd;
         -- missing declaration for a_frs1516_test_item.absparsp;
         -- missing declaration for a_frs1516_test_item.abspayhd;
         -- missing declaration for a_frs1516_test_item.abspaysp;
         -- missing declaration for a_frs1516_test_item.abswhyhd;
         -- missing declaration for a_frs1516_test_item.abswhysp;
         -- missing declaration for a_frs1516_test_item.abswkhd;
         -- missing declaration for a_frs1516_test_item.abswksp;
         -- missing declaration for a_frs1516_test_item.acshd;
         -- missing declaration for a_frs1516_test_item.acssp;
         -- missing declaration for a_frs1516_test_item.acctqhd;
         -- missing declaration for a_frs1516_test_item.acctqsp;
         a_frs1516_test_item.acsamthd := 1010100.012 + Amount( i );
         a_frs1516_test_item.acsamtsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.acspdhd;
         -- missing declaration for a_frs1516_test_item.acspdsp;
         -- missing declaration for a_frs1516_test_item.actacihd;
         -- missing declaration for a_frs1516_test_item.actacisp;
         -- missing declaration for a_frs1516_test_item.emahd;
         -- missing declaration for a_frs1516_test_item.emasp;
         a_frs1516_test_item.emaamthd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.emaamtsp;
         -- missing declaration for a_frs1516_test_item.emapdhd;
         -- missing declaration for a_frs1516_test_item.emapdsp;
         -- missing declaration for a_frs1516_test_item.agehd;
         -- missing declaration for a_frs1516_test_item.agesp;
         -- missing declaration for a_frs1516_test_item.agehqhd;
         -- missing declaration for a_frs1516_test_item.agehqsp;
         a_frs1516_test_item.aliamthd := 1010100.012 + Amount( i );
         a_frs1516_test_item.aliamtsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.alimnyhd;
         -- missing declaration for a_frs1516_test_item.alimnysp;
         -- missing declaration for a_frs1516_test_item.alipdhd;
         -- missing declaration for a_frs1516_test_item.alipdsp;
         -- missing declaration for a_frs1516_test_item.aliushd;
         -- missing declaration for a_frs1516_test_item.aliussp;
         a_frs1516_test_item.absallhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.absallsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.organhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.organsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.fosterhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.fostersp := 1010100.012 + Amount( i );
         a_frs1516_test_item.adopthd := 1010100.012 + Amount( i );
         a_frs1516_test_item.adoptsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.pasbalhd;
         -- missing declaration for a_frs1516_test_item.pasbalsp;
         -- missing declaration for a_frs1516_test_item.porganhd;
         -- missing declaration for a_frs1516_test_item.porgansp;
         -- missing declaration for a_frs1516_test_item.pfostehd;
         -- missing declaration for a_frs1516_test_item.pfostesp;
         -- missing declaration for a_frs1516_test_item.padopthd;
         -- missing declaration for a_frs1516_test_item.padoptsp;
         -- missing declaration for a_frs1516_test_item.aluamthd;
         -- missing declaration for a_frs1516_test_item.aluamtsp;
         -- missing declaration for a_frs1516_test_item.alupdhd;
         -- missing declaration for a_frs1516_test_item.alupdsp;
         -- missing declaration for a_frs1516_test_item.anyacchd;
         -- missing declaration for a_frs1516_test_item.anyaccsp;
         -- missing declaration for a_frs1516_test_item.anyedhd;
         -- missing declaration for a_frs1516_test_item.anyedsp;
         -- missing declaration for a_frs1516_test_item.anymonhd;
         -- missing declaration for a_frs1516_test_item.anymonsp;
         -- missing declaration for a_frs1516_test_item.anype1hd;
         -- missing declaration for a_frs1516_test_item.anype1sp;
         -- missing declaration for a_frs1516_test_item.anype2hd;
         -- missing declaration for a_frs1516_test_item.anype2sp;
         -- missing declaration for a_frs1516_test_item.anype3hd;
         -- missing declaration for a_frs1516_test_item.anype3sp;
         -- missing declaration for a_frs1516_test_item.anype4hd;
         -- missing declaration for a_frs1516_test_item.anype4sp;
         -- missing declaration for a_frs1516_test_item.anype5hd;
         -- missing declaration for a_frs1516_test_item.anype5sp;
         -- missing declaration for a_frs1516_test_item.anype6hd;
         -- missing declaration for a_frs1516_test_item.anype6sp;
         -- missing declaration for a_frs1516_test_item.anype7hd;
         -- missing declaration for a_frs1516_test_item.anype7sp;
         a_frs1516_test_item.abspamhd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.abspamsp;
         a_frs1516_test_item.abspexhd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.abspexsp;
         -- missing declaration for a_frs1516_test_item.apdpdhd;
         -- missing declaration for a_frs1516_test_item.apdpdsp;
         -- missing declaration for a_frs1516_test_item.pabspahd;
         -- missing declaration for a_frs1516_test_item.pabspasp;
         -- missing declaration for a_frs1516_test_item.basacthd;
         -- missing declaration for a_frs1516_test_item.basactsp;
         -- missing declaration for a_frs1516_test_item.bfdhd;
         -- missing declaration for a_frs1516_test_item.bfdsp;
         a_frs1516_test_item.bfdamthd := 1010100.012 + Amount( i );
         a_frs1516_test_item.bfdamtsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.pbfdhd;
         -- missing declaration for a_frs1516_test_item.pbfdsp;
         -- missing declaration for a_frs1516_test_item.bfdvalhd;
         -- missing declaration for a_frs1516_test_item.bfdvalsp;
         -- missing declaration for a_frs1516_test_item.careabhd;
         -- missing declaration for a_frs1516_test_item.careabsp;
         -- missing declaration for a_frs1516_test_item.careahhd;
         -- missing declaration for a_frs1516_test_item.careahsp;
         -- missing declaration for a_frs1516_test_item.carecbhd;
         -- missing declaration for a_frs1516_test_item.carecbsp;
         -- missing declaration for a_frs1516_test_item.carechhd;
         -- missing declaration for a_frs1516_test_item.carechsp;
         -- missing declaration for a_frs1516_test_item.careclhd;
         -- missing declaration for a_frs1516_test_item.careclsp;
         -- missing declaration for a_frs1516_test_item.careflhd;
         -- missing declaration for a_frs1516_test_item.careflsp;
         -- missing declaration for a_frs1516_test_item.carefrhd;
         -- missing declaration for a_frs1516_test_item.carefrsp;
         -- missing declaration for a_frs1516_test_item.careothd;
         -- missing declaration for a_frs1516_test_item.careotsp;
         -- missing declaration for a_frs1516_test_item.carerhd;
         -- missing declaration for a_frs1516_test_item.carersp;
         -- missing declaration for a_frs1516_test_item.cbaamthd;
         -- missing declaration for a_frs1516_test_item.cbaamtsp;
         -- missing declaration for a_frs1516_test_item.cbchkhd;
         -- missing declaration for a_frs1516_test_item.cbchksp;
         -- missing declaration for a_frs1516_test_item.changehd;
         -- missing declaration for a_frs1516_test_item.changesp;
         -- missing declaration for a_frs1516_test_item.chbflghd;
         -- missing declaration for a_frs1516_test_item.chbflgsp;
         -- missing declaration for a_frs1516_test_item.chknophd;
         -- missing declaration for a_frs1516_test_item.chknopsp;
         -- missing declaration for a_frs1516_test_item.fpchd;
         -- missing declaration for a_frs1516_test_item.fpcsp;
         -- missing declaration for a_frs1516_test_item.fuchd;
         -- missing declaration for a_frs1516_test_item.fucsp;
         -- missing declaration for a_frs1516_test_item.fhbhd;
         -- missing declaration for a_frs1516_test_item.fhbsp;
         -- missing declaration for a_frs1516_test_item.fwtchd;
         -- missing declaration for a_frs1516_test_item.fwtcsp;
         -- missing declaration for a_frs1516_test_item.fctchd;
         -- missing declaration for a_frs1516_test_item.fctcsp;
         -- missing declaration for a_frs1516_test_item.fishd;
         -- missing declaration for a_frs1516_test_item.fissp;
         -- missing declaration for a_frs1516_test_item.fjsahd;
         -- missing declaration for a_frs1516_test_item.fjsasp;
         -- missing declaration for a_frs1516_test_item.fesahd;
         -- missing declaration for a_frs1516_test_item.fesasp;
         -- missing declaration for a_frs1516_test_item.claimahd;
         -- missing declaration for a_frs1516_test_item.claimasp;
         -- missing declaration for a_frs1516_test_item.cohabhd;
         -- missing declaration for a_frs1516_test_item.cohabsp;
         -- missing declaration for a_frs1516_test_item.condithd;
         -- missing declaration for a_frs1516_test_item.conditsp;
         -- missing declaration for a_frs1516_test_item.blodgehd;
         -- missing declaration for a_frs1516_test_item.blodgesp;
         -- missing declaration for a_frs1516_test_item.ctclm1hd;
         -- missing declaration for a_frs1516_test_item.ctclm1sp;
         -- missing declaration for a_frs1516_test_item.ctclm2hd;
         -- missing declaration for a_frs1516_test_item.ctclm2sp;
         -- missing declaration for a_frs1516_test_item.cupchkhd;
         -- missing declaration for a_frs1516_test_item.cupchksp;
         -- missing declaration for a_frs1516_test_item.curacthd;
         -- missing declaration for a_frs1516_test_item.curactsp;
         -- missing declaration for a_frs1516_test_item.curqulhd;
         -- missing declaration for a_frs1516_test_item.curqulsp;
         -- missing declaration for a_frs1516_test_item.blheadhd;
         -- missing declaration for a_frs1516_test_item.blheadsp;
         a_frs1516_test_item.blrenthd := 1010100.012 + Amount( i );
         a_frs1516_test_item.blrentsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.pblrenhd;
         -- missing declaration for a_frs1516_test_item.pblrensp;
         -- missing declaration for a_frs1516_test_item.ddaprghd;
         -- missing declaration for a_frs1516_test_item.ddaprgsp;
         -- missing declaration for a_frs1516_test_item.ddatrehd;
         -- missing declaration for a_frs1516_test_item.ddatresp;
         -- missing declaration for a_frs1516_test_item.ddatrphd;
         -- missing declaration for a_frs1516_test_item.ddatrpsp;
         -- missing declaration for a_frs1516_test_item.defrpnhd;
         -- missing declaration for a_frs1516_test_item.defrpnsp;
         -- missing declaration for a_frs1516_test_item.dependhd;
         -- missing declaration for a_frs1516_test_item.dependsp;
         -- missing declaration for a_frs1516_test_item.disacahd;
         -- missing declaration for a_frs1516_test_item.disacasp;
         -- missing declaration for a_frs1516_test_item.qpiphd;
         -- missing declaration for a_frs1516_test_item.qpipsp;
         -- missing declaration for a_frs1516_test_item.qdlahd;
         -- missing declaration for a_frs1516_test_item.qdlasp;
         -- missing declaration for a_frs1516_test_item.qaahd;
         -- missing declaration for a_frs1516_test_item.qaasp;
         -- missing declaration for a_frs1516_test_item.qsdahd;
         -- missing declaration for a_frs1516_test_item.qsdasp;
         -- missing declaration for a_frs1516_test_item.qibhd;
         -- missing declaration for a_frs1516_test_item.qibsp;
         -- missing declaration for a_frs1516_test_item.qiidbhd;
         -- missing declaration for a_frs1516_test_item.qiidbsp;
         -- missing declaration for a_frs1516_test_item.discoahd;
         -- missing declaration for a_frs1516_test_item.discoasp;
         -- missing declaration for a_frs1516_test_item.disd01hd;
         -- missing declaration for a_frs1516_test_item.disd01sp;
         -- missing declaration for a_frs1516_test_item.disd02hd;
         -- missing declaration for a_frs1516_test_item.disd02sp;
         -- missing declaration for a_frs1516_test_item.disd03hd;
         -- missing declaration for a_frs1516_test_item.disd03sp;
         -- missing declaration for a_frs1516_test_item.disd04hd;
         -- missing declaration for a_frs1516_test_item.disd04sp;
         -- missing declaration for a_frs1516_test_item.disd05hd;
         -- missing declaration for a_frs1516_test_item.disd05sp;
         -- missing declaration for a_frs1516_test_item.disd06hd;
         -- missing declaration for a_frs1516_test_item.disd06sp;
         -- missing declaration for a_frs1516_test_item.disd07hd;
         -- missing declaration for a_frs1516_test_item.disd07sp;
         -- missing declaration for a_frs1516_test_item.disd08hd;
         -- missing declaration for a_frs1516_test_item.disd08sp;
         -- missing declaration for a_frs1516_test_item.disd09hd;
         -- missing declaration for a_frs1516_test_item.disd09sp;
         -- missing declaration for a_frs1516_test_item.disd10hd;
         -- missing declaration for a_frs1516_test_item.disd10sp;
         -- missing declaration for a_frs1516_test_item.disdifhd;
         -- missing declaration for a_frs1516_test_item.disdifsp;
         -- missing declaration for a_frs1516_test_item.dlachd;
         -- missing declaration for a_frs1516_test_item.dlacsp;
         -- missing declaration for a_frs1516_test_item.dlamhd;
         -- missing declaration for a_frs1516_test_item.dlamsp;
         -- missing declaration for a_frs1516_test_item.dlshd;
         -- missing declaration for a_frs1516_test_item.dlssp;
         a_frs1516_test_item.dlsamthd := 1010100.012 + Amount( i );
         a_frs1516_test_item.dlsamtsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.pdlshd;
         -- missing declaration for a_frs1516_test_item.pdlssp;
         -- missing declaration for a_frs1516_test_item.dlsvalhd;
         -- missing declaration for a_frs1516_test_item.dlsvalsp;
         -- missing declaration for a_frs1516_test_item.dobhd;
         -- missing declaration for a_frs1516_test_item.dobsp;
         -- missing declaration for a_frs1516_test_item.h3qualhd;
         -- missing declaration for a_frs1516_test_item.h3qualsp;
         -- missing declaration for a_frs1516_test_item.dvil3ahd;
         -- missing declaration for a_frs1516_test_item.dvil3asp;
         -- missing declaration for a_frs1516_test_item.dvil4ahd;
         -- missing declaration for a_frs1516_test_item.dvil4asp;
         -- missing declaration for a_frs1516_test_item.dvjb12hd;
         -- missing declaration for a_frs1516_test_item.dvjb12sp;
         -- missing declaration for a_frs1516_test_item.dvmarhd;
         -- missing declaration for a_frs1516_test_item.dvmarsp;
         -- missing declaration for a_frs1516_test_item.edl1ahd;
         -- missing declaration for a_frs1516_test_item.edl1asp;
         -- missing declaration for a_frs1516_test_item.pedl1ahd;
         -- missing declaration for a_frs1516_test_item.pedl1asp;
         -- missing declaration for a_frs1516_test_item.edl1obhd;
         -- missing declaration for a_frs1516_test_item.edl1obsp;
         -- missing declaration for a_frs1516_test_item.edl2ahd;
         -- missing declaration for a_frs1516_test_item.edl2asp;
         -- missing declaration for a_frs1516_test_item.pedl2ahd;
         -- missing declaration for a_frs1516_test_item.pedl2asp;
         -- missing declaration for a_frs1516_test_item.edl2obhd;
         -- missing declaration for a_frs1516_test_item.edl2obsp;
         -- missing declaration for a_frs1516_test_item.edatthd;
         -- missing declaration for a_frs1516_test_item.edattsp;
         -- missing declaration for a_frs1516_test_item.edhrhd;
         -- missing declaration for a_frs1516_test_item.edhrsp;
         -- missing declaration for a_frs1516_test_item.edtyphd;
         -- missing declaration for a_frs1516_test_item.edtypsp;
         -- missing declaration for a_frs1516_test_item.empconhd;
         -- missing declaration for a_frs1516_test_item.empconsp;
         a_frs1516_test_item.empocchd := 1010100.012 + Amount( i );
         a_frs1516_test_item.empoccsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.empshd;
         -- missing declaration for a_frs1516_test_item.empssp;
         -- missing declaration for a_frs1516_test_item.empbhd;
         -- missing declaration for a_frs1516_test_item.empbsp;
         -- missing declaration for a_frs1516_test_item.empchd;
         -- missing declaration for a_frs1516_test_item.empcsp;
         -- missing declaration for a_frs1516_test_item.empilohd;
         -- missing declaration for a_frs1516_test_item.empilosp;
         -- missing declaration for a_frs1516_test_item.es2000hd;
         -- missing declaration for a_frs1516_test_item.es2000sp;
         -- missing declaration for a_frs1516_test_item.ethgr3hd;
         -- missing declaration for a_frs1516_test_item.ethgr3sp;
         -- missing declaration for a_frs1516_test_item.ethgpshd;
         -- missing declaration for a_frs1516_test_item.ethgpssp;
         -- missing declaration for a_frs1516_test_item.etngrphd;
         -- missing declaration for a_frs1516_test_item.etngrpsp;
         a_frs1516_test_item.eualamhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.eualamsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.eualmnhd;
         -- missing declaration for a_frs1516_test_item.eualmnsp;
         -- missing declaration for a_frs1516_test_item.peualihd;
         -- missing declaration for a_frs1516_test_item.peualisp;
         -- missing declaration for a_frs1516_test_item.euetyphd;
         -- missing declaration for a_frs1516_test_item.euetypsp;
         -- missing declaration for a_frs1516_test_item.everwkhd;
         -- missing declaration for a_frs1516_test_item.everwksp;
         -- missing declaration for a_frs1516_test_item.ehbct1hd;
         -- missing declaration for a_frs1516_test_item.ehbct1sp;
         -- missing declaration for a_frs1516_test_item.fllwphd;
         -- missing declaration for a_frs1516_test_item.fllwpsp;
         -- missing declaration for a_frs1516_test_item.ftedhd;
         -- missing declaration for a_frs1516_test_item.ftedsp;
         -- missing declaration for a_frs1516_test_item.ftwkyrhd;
         -- missing declaration for a_frs1516_test_item.ftwkyrsp;
         -- missing declaration for a_frs1516_test_item.gebacthd;
         -- missing declaration for a_frs1516_test_item.gebactsp;
         -- missing declaration for a_frs1516_test_item.giltcthd;
         -- missing declaration for a_frs1516_test_item.giltctsp;
         -- missing declaration for a_frs1516_test_item.gpispchd;
         -- missing declaration for a_frs1516_test_item.gpispcsp;
         -- missing declaration for a_frs1516_test_item.gpjesahd;
         -- missing declaration for a_frs1516_test_item.gpjesasp;
         -- missing declaration for a_frs1516_test_item.gpuchd;
         -- missing declaration for a_frs1516_test_item.gpucsp;
         -- missing declaration for a_frs1516_test_item.granthd;
         -- missing declaration for a_frs1516_test_item.grantsp;
         -- missing declaration for a_frs1516_test_item.gt1valhd;
         a_frs1516_test_item.gt1valsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.gt2valhd;
         -- missing declaration for a_frs1516_test_item.gt2valsp;
         -- missing declaration for a_frs1516_test_item.gt1dirhd;
         a_frs1516_test_item.gt1dirsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.gt2dirhd;
         -- missing declaration for a_frs1516_test_item.gt2dirsp;
         -- missing declaration for a_frs1516_test_item.grtnumhd;
         -- missing declaration for a_frs1516_test_item.grtnumsp;
         -- missing declaration for a_frs1516_test_item.gt1scehd;
         -- missing declaration for a_frs1516_test_item.gt1scesp;
         -- missing declaration for a_frs1516_test_item.gt2scehd;
         -- missing declaration for a_frs1516_test_item.gt2scesp;
         -- missing declaration for a_frs1516_test_item.gt1oshd;
         -- missing declaration for a_frs1516_test_item.gt1ossp;
         -- missing declaration for a_frs1516_test_item.gt2oshd;
         -- missing declaration for a_frs1516_test_item.gt2ossp;
         -- missing declaration for a_frs1516_test_item.gtahd;
         -- missing declaration for a_frs1516_test_item.gtasp;
         -- missing declaration for a_frs1516_test_item.healthhd;
         -- missing declaration for a_frs1516_test_item.healthsp;
         a_frs1516_test_item.heartvhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.heartvsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.heatadhd;
         -- missing declaration for a_frs1516_test_item.heatadsp;
         -- missing declaration for a_frs1516_test_item.hholdrhd;
         -- missing declaration for a_frs1516_test_item.hholdrsp;
         -- missing declaration for a_frs1516_test_item.hourabhd;
         -- missing declaration for a_frs1516_test_item.hourabsp;
         -- missing declaration for a_frs1516_test_item.hourahhd;
         -- missing declaration for a_frs1516_test_item.hourahsp;
         a_frs1516_test_item.hrcarehd := 1010100.012 + Amount( i );
         a_frs1516_test_item.hrcaresp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.hourcbhd;
         -- missing declaration for a_frs1516_test_item.hourcbsp;
         -- missing declaration for a_frs1516_test_item.hourchhd;
         -- missing declaration for a_frs1516_test_item.hourchsp;
         -- missing declaration for a_frs1516_test_item.hourclhd;
         -- missing declaration for a_frs1516_test_item.hourclsp;
         -- missing declaration for a_frs1516_test_item.hourfrhd;
         -- missing declaration for a_frs1516_test_item.hourfrsp;
         -- missing declaration for a_frs1516_test_item.hourothd;
         -- missing declaration for a_frs1516_test_item.hourotsp;
         -- missing declaration for a_frs1516_test_item.hourrehd;
         -- missing declaration for a_frs1516_test_item.hourresp;
         -- missing declaration for a_frs1516_test_item.hourtthd;
         -- missing declaration for a_frs1516_test_item.hourttsp;
         -- missing declaration for a_frs1516_test_item.hpersohd;
         -- missing declaration for a_frs1516_test_item.hpersosp;
         -- missing declaration for a_frs1516_test_item.hrpidhd;
         -- missing declaration for a_frs1516_test_item.hrpidsp;
         -- missing declaration for a_frs1516_test_item.hsvperhd;
         -- missing declaration for a_frs1516_test_item.hsvpersp;
         -- missing declaration for a_frs1516_test_item.agegp2hd;
         -- missing declaration for a_frs1516_test_item.agegp2sp;
         -- missing declaration for a_frs1516_test_item.agegphd;
         -- missing declaration for a_frs1516_test_item.agegpsp;
         -- missing declaration for a_frs1516_test_item.quninshd;
         -- missing declaration for a_frs1516_test_item.quninssp;
         -- missing declaration for a_frs1516_test_item.qtubenhd;
         -- missing declaration for a_frs1516_test_item.qtubensp;
         -- missing declaration for a_frs1516_test_item.qsicinhd;
         -- missing declaration for a_frs1516_test_item.qsicinsp;
         -- missing declaration for a_frs1516_test_item.qaccinhd;
         -- missing declaration for a_frs1516_test_item.qaccinsp;
         -- missing declaration for a_frs1516_test_item.qpehinhd;
         -- missing declaration for a_frs1516_test_item.qpehinsp;
         -- missing declaration for a_frs1516_test_item.qhosinhd;
         -- missing declaration for a_frs1516_test_item.qhosinsp;
         -- missing declaration for a_frs1516_test_item.qfsbenhd;
         -- missing declaration for a_frs1516_test_item.qfsbensp;
         -- missing declaration for a_frs1516_test_item.qcichd;
         -- missing declaration for a_frs1516_test_item.qcicsp;
         -- missing declaration for a_frs1516_test_item.qotbenhd;
         -- missing declaration for a_frs1516_test_item.qotbensp;
         -- missing declaration for a_frs1516_test_item.incdurhd;
         -- missing declaration for a_frs1516_test_item.incdursp;
         -- missing declaration for a_frs1516_test_item.incsehd;
         -- missing declaration for a_frs1516_test_item.incsesp;
         -- missing declaration for a_frs1516_test_item.indinchd;
         -- missing declaration for a_frs1516_test_item.indincsp;
         -- missing declaration for a_frs1516_test_item.indisbhd;
         -- missing declaration for a_frs1516_test_item.indisbsp;
         -- missing declaration for a_frs1516_test_item.inearnhd;
         -- missing declaration for a_frs1516_test_item.inearnsp;
         -- missing declaration for a_frs1516_test_item.ininvhd;
         -- missing declaration for a_frs1516_test_item.ininvsp;
         -- missing declaration for a_frs1516_test_item.inirbehd;
         -- missing declaration for a_frs1516_test_item.inirbesp;
         -- missing declaration for a_frs1516_test_item.injlonhd;
         -- missing declaration for a_frs1516_test_item.injlonsp;
         -- missing declaration for a_frs1516_test_item.injhrshd;
         -- missing declaration for a_frs1516_test_item.injhrssp;
         -- missing declaration for a_frs1516_test_item.innirbhd;
         -- missing declaration for a_frs1516_test_item.innirbsp;
         -- missing declaration for a_frs1516_test_item.inothbhd;
         -- missing declaration for a_frs1516_test_item.inothbsp;
         -- missing declaration for a_frs1516_test_item.inpenihd;
         -- missing declaration for a_frs1516_test_item.inpenisp;
         -- missing declaration for a_frs1516_test_item.inrinchd;
         -- missing declaration for a_frs1516_test_item.inrincsp;
         -- missing declaration for a_frs1516_test_item.inrpinhd;
         -- missing declaration for a_frs1516_test_item.inrpinsp;
         a_frs1516_test_item.itvlichd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.itvlicsp;
         -- missing declaration for a_frs1516_test_item.intxcdhd;
         -- missing declaration for a_frs1516_test_item.intxcdsp;
         -- missing declaration for a_frs1516_test_item.investhd;
         -- missing declaration for a_frs1516_test_item.investsp;
         -- missing declaration for a_frs1516_test_item.isa1tyhd;
         -- missing declaration for a_frs1516_test_item.isa1tysp;
         -- missing declaration for a_frs1516_test_item.isa2tyhd;
         -- missing declaration for a_frs1516_test_item.isa2tysp;
         -- missing declaration for a_frs1516_test_item.isactihd;
         -- missing declaration for a_frs1516_test_item.isactisp;
         -- missing declaration for a_frs1516_test_item.jobawahd;
         -- missing declaration for a_frs1516_test_item.jobawasp;
         -- missing declaration for a_frs1516_test_item.jobbyrhd;
         -- missing declaration for a_frs1516_test_item.jobbyrsp;
         -- missing declaration for a_frs1516_test_item.qcbhd;
         -- missing declaration for a_frs1516_test_item.qcbsp;
         -- missing declaration for a_frs1516_test_item.qgahd;
         -- missing declaration for a_frs1516_test_item.qgasp;
         -- missing declaration for a_frs1516_test_item.qmahd;
         -- missing declaration for a_frs1516_test_item.qmasp;
         -- missing declaration for a_frs1516_test_item.lareghd;
         -- missing declaration for a_frs1516_test_item.laregsp;
         -- missing declaration for a_frs1516_test_item.likewkhd;
         -- missing declaration for a_frs1516_test_item.likewksp;
         -- missing declaration for a_frs1516_test_item.limitlhd;
         -- missing declaration for a_frs1516_test_item.limitlsp;
         -- missing declaration for a_frs1516_test_item.lktimehd;
         -- missing declaration for a_frs1516_test_item.lktimesp;
         -- missing declaration for a_frs1516_test_item.lktrnhd;
         -- missing declaration for a_frs1516_test_item.lktrnsp;
         -- missing declaration for a_frs1516_test_item.lkworkhd;
         -- missing declaration for a_frs1516_test_item.lkworksp;
         -- missing declaration for a_frs1516_test_item.loanhd;
         -- missing declaration for a_frs1516_test_item.loansp;
         -- missing declaration for a_frs1516_test_item.loannuhd;
         -- missing declaration for a_frs1516_test_item.loannusp;
         -- missing declaration for a_frs1516_test_item.lstwkmhd;
         -- missing declaration for a_frs1516_test_item.lstwkmsp;
         -- missing declaration for a_frs1516_test_item.lstwkyhd;
         -- missing declaration for a_frs1516_test_item.lstwkysp;
         -- missing declaration for a_frs1516_test_item.wkswkdhd;
         -- missing declaration for a_frs1516_test_item.wkswkdsp;
         -- missing declaration for a_frs1516_test_item.marithd;
         -- missing declaration for a_frs1516_test_item.maritsp;
         a_frs1516_test_item.mr1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.mr1sp;
         a_frs1516_test_item.mr2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.mr2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.mntar1hd;
         -- missing declaration for a_frs1516_test_item.mntar1sp;
         -- missing declaration for a_frs1516_test_item.mntar2hd;
         -- missing declaration for a_frs1516_test_item.mntar2sp;
         -- missing declaration for a_frs1516_test_item.mntar3hd;
         -- missing declaration for a_frs1516_test_item.mntar3sp;
         -- missing declaration for a_frs1516_test_item.mntar4hd;
         -- missing declaration for a_frs1516_test_item.mntar4sp;
         -- missing declaration for a_frs1516_test_item.mntar5hd;
         -- missing declaration for a_frs1516_test_item.mntar5sp;
         -- missing declaration for a_frs1516_test_item.mntnc1hd;
         -- missing declaration for a_frs1516_test_item.mntnc1sp;
         -- missing declaration for a_frs1516_test_item.mntnc2hd;
         -- missing declaration for a_frs1516_test_item.mntnc2sp;
         -- missing declaration for a_frs1516_test_item.mntnc3hd;
         -- missing declaration for a_frs1516_test_item.mntnc3sp;
         -- missing declaration for a_frs1516_test_item.mntnc4hd;
         -- missing declaration for a_frs1516_test_item.mntnc4sp;
         -- missing declaration for a_frs1516_test_item.mntnc5hd;
         -- missing declaration for a_frs1516_test_item.mntnc5sp;
         -- missing declaration for a_frs1516_test_item.mntpayhd;
         -- missing declaration for a_frs1516_test_item.mntpaysp;
         -- missing declaration for a_frs1516_test_item.pmr1hd;
         -- missing declaration for a_frs1516_test_item.pmr1sp;
         -- missing declaration for a_frs1516_test_item.pmr2hd;
         -- missing declaration for a_frs1516_test_item.pmr2sp;
         -- missing declaration for a_frs1516_test_item.mntpr1hd;
         -- missing declaration for a_frs1516_test_item.mntpr1sp;
         -- missing declaration for a_frs1516_test_item.mntpr2hd;
         -- missing declaration for a_frs1516_test_item.mntpr2sp;
         -- missing declaration for a_frs1516_test_item.mntpr3hd;
         -- missing declaration for a_frs1516_test_item.mntpr3sp;
         -- missing declaration for a_frs1516_test_item.mr12mhd;
         -- missing declaration for a_frs1516_test_item.mr12msp;
         -- missing declaration for a_frs1516_test_item.mntt1hd;
         -- missing declaration for a_frs1516_test_item.mntt1sp;
         -- missing declaration for a_frs1516_test_item.mntt2hd;
         -- missing declaration for a_frs1516_test_item.mntt2sp;
         -- missing declaration for a_frs1516_test_item.mntt3hd;
         -- missing declaration for a_frs1516_test_item.mntt3sp;
         -- missing declaration for a_frs1516_test_item.mntus1hd;
         -- missing declaration for a_frs1516_test_item.mntus1sp;
         -- missing declaration for a_frs1516_test_item.mntus2hd;
         -- missing declaration for a_frs1516_test_item.mntus2sp;
         a_frs1516_test_item.umr1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.umr1sp;
         a_frs1516_test_item.umr2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.umr2sp;
         -- missing declaration for a_frs1516_test_item.pumr1hd;
         -- missing declaration for a_frs1516_test_item.pumr1sp;
         -- missing declaration for a_frs1516_test_item.pumr2hd;
         -- missing declaration for a_frs1516_test_item.pumr2sp;
         -- missing declaration for a_frs1516_test_item.mntw1hd;
         -- missing declaration for a_frs1516_test_item.mntw1sp;
         -- missing declaration for a_frs1516_test_item.mntw2hd;
         -- missing declaration for a_frs1516_test_item.mntw2sp;
         -- missing declaration for a_frs1516_test_item.mntw3hd;
         -- missing declaration for a_frs1516_test_item.mntw3sp;
         -- missing declaration for a_frs1516_test_item.mntw4hd;
         -- missing declaration for a_frs1516_test_item.mntw4sp;
         -- missing declaration for a_frs1516_test_item.mntw5hd;
         -- missing declaration for a_frs1516_test_item.mntw5sp;
         -- missing declaration for a_frs1516_test_item.mshd;
         -- missing declaration for a_frs1516_test_item.mssp;
         -- missing declaration for a_frs1516_test_item.nanid1hd;
         -- missing declaration for a_frs1516_test_item.nanid1sp;
         -- missing declaration for a_frs1516_test_item.nanid2hd;
         -- missing declaration for a_frs1516_test_item.nanid2sp;
         -- missing declaration for a_frs1516_test_item.nanid3hd;
         -- missing declaration for a_frs1516_test_item.nanid3sp;
         -- missing declaration for a_frs1516_test_item.nanid4hd;
         -- missing declaration for a_frs1516_test_item.nanid4sp;
         -- missing declaration for a_frs1516_test_item.nanid5hd;
         -- missing declaration for a_frs1516_test_item.nanid5sp;
         -- missing declaration for a_frs1516_test_item.nanid6hd;
         -- missing declaration for a_frs1516_test_item.nanid6sp;
         -- missing declaration for a_frs1516_test_item.nitrnhd;
         -- missing declaration for a_frs1516_test_item.nitrnsp;
         a_frs1516_test_item.niamthd := 1010100.012 + Amount( i );
         a_frs1516_test_item.niamtsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.niethghd;
         -- missing declaration for a_frs1516_test_item.niethgsp;
         -- missing declaration for a_frs1516_test_item.nixhbbhd;
         -- missing declaration for a_frs1516_test_item.nixhbbsp;
         -- missing declaration for a_frs1516_test_item.ninid1hd;
         -- missing declaration for a_frs1516_test_item.ninid1sp;
         -- missing declaration for a_frs1516_test_item.ninid2hd;
         -- missing declaration for a_frs1516_test_item.ninid2sp;
         -- missing declaration for a_frs1516_test_item.ninid3hd;
         -- missing declaration for a_frs1516_test_item.ninid3sp;
         -- missing declaration for a_frs1516_test_item.ninid4hd;
         -- missing declaration for a_frs1516_test_item.ninid4sp;
         -- missing declaration for a_frs1516_test_item.ninid5hd;
         -- missing declaration for a_frs1516_test_item.ninid5sp;
         -- missing declaration for a_frs1516_test_item.ninid6hd;
         -- missing declaration for a_frs1516_test_item.ninid6sp;
         -- missing declaration for a_frs1516_test_item.ninid7hd;
         -- missing declaration for a_frs1516_test_item.ninid7sp;
         -- missing declaration for a_frs1516_test_item.nincs2hd;
         -- missing declaration for a_frs1516_test_item.nincs2sp;
         -- missing declaration for a_frs1516_test_item.nininchd;
         -- missing declaration for a_frs1516_test_item.ninincsp;
         -- missing declaration for a_frs1516_test_item.ninearhd;
         -- missing declaration for a_frs1516_test_item.ninearsp;
         -- missing declaration for a_frs1516_test_item.nininvhd;
         -- missing declaration for a_frs1516_test_item.nininvsp;
         -- missing declaration for a_frs1516_test_item.ninpenhd;
         -- missing declaration for a_frs1516_test_item.ninpensp;
         -- missing declaration for a_frs1516_test_item.ninrinhd;
         -- missing declaration for a_frs1516_test_item.ninrinsp;
         -- missing declaration for a_frs1516_test_item.ninseihd;
         -- missing declaration for a_frs1516_test_item.ninseisp;
         -- missing declaration for a_frs1516_test_item.pniamthd;
         -- missing declaration for a_frs1516_test_item.pniamtsp;
         -- missing declaration for a_frs1516_test_item.nireghd;
         -- missing declaration for a_frs1516_test_item.niregsp;
         -- missing declaration for a_frs1516_test_item.nirelghd;
         -- missing declaration for a_frs1516_test_item.nirelgsp;
         -- missing declaration for a_frs1516_test_item.nolk1hd;
         -- missing declaration for a_frs1516_test_item.nolk1sp;
         -- missing declaration for a_frs1516_test_item.nolk2hd;
         -- missing declaration for a_frs1516_test_item.nolk2sp;
         -- missing declaration for a_frs1516_test_item.nolk3hd;
         -- missing declaration for a_frs1516_test_item.nolk3sp;
         -- missing declaration for a_frs1516_test_item.nowanthd;
         -- missing declaration for a_frs1516_test_item.nowantsp;
         a_frs1516_test_item.nssechd := 1010100.012 + Amount( i );
         a_frs1516_test_item.nssecsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.numjobhd;
         -- missing declaration for a_frs1516_test_item.numjobsp;
         -- missing declaration for a_frs1516_test_item.numj2hd;
         -- missing declaration for a_frs1516_test_item.numj2sp;
         -- missing declaration for a_frs1516_test_item.ocnumhd;
         -- missing declaration for a_frs1516_test_item.ocnumsp;
         -- missing declaration for a_frs1516_test_item.oddjobhd;
         -- missing declaration for a_frs1516_test_item.oddjobsp;
         -- missing declaration for a_frs1516_test_item.oldstdhd;
         -- missing declaration for a_frs1516_test_item.oldstdsp;
         -- missing declaration for a_frs1516_test_item.oabparhd;
         -- missing declaration for a_frs1516_test_item.oabparsp;
         a_frs1516_test_item.otamthd := 1010100.012 + Amount( i );
         a_frs1516_test_item.otamtsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.otpamthd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.otpamtsp;
         -- missing declaration for a_frs1516_test_item.otappdhd;
         -- missing declaration for a_frs1516_test_item.otappdsp;
         -- missing declaration for a_frs1516_test_item.qehbtbhd;
         -- missing declaration for a_frs1516_test_item.qehbtbsp;
         -- missing declaration for a_frs1516_test_item.qwidplhd;
         -- missing declaration for a_frs1516_test_item.qwidplsp;
         -- missing declaration for a_frs1516_test_item.qinwkchd;
         -- missing declaration for a_frs1516_test_item.qinwkcsp;
         -- missing declaration for a_frs1516_test_item.qrtwkchd;
         -- missing declaration for a_frs1516_test_item.qrtwkcsp;
         -- missing declaration for a_frs1516_test_item.qothbehd;
         -- missing declaration for a_frs1516_test_item.qothbesp;
         -- missing declaration for a_frs1516_test_item.othtaxhd;
         -- missing declaration for a_frs1516_test_item.othtaxsp;
         -- missing declaration for a_frs1516_test_item.otinvahd;
         -- missing declaration for a_frs1516_test_item.otinvasp;
         a_frs1516_test_item.pareamhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.pareamsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.qpchd;
         -- missing declaration for a_frs1516_test_item.qpcsp;
         -- missing declaration for a_frs1516_test_item.qrphd;
         -- missing declaration for a_frs1516_test_item.qrpsp;
         -- missing declaration for a_frs1516_test_item.qbbhd;
         -- missing declaration for a_frs1516_test_item.qbbsp;
         -- missing declaration for a_frs1516_test_item.qafcshd;
         -- missing declaration for a_frs1516_test_item.qafcssp;
         -- missing declaration for a_frs1516_test_item.qwwphd;
         -- missing declaration for a_frs1516_test_item.qwwpsp;
         -- missing declaration for a_frs1516_test_item.penflghd;
         -- missing declaration for a_frs1516_test_item.penflgsp;
         -- missing declaration for a_frs1516_test_item.penwl1hd;
         -- missing declaration for a_frs1516_test_item.penwl1sp;
         -- missing declaration for a_frs1516_test_item.penwl2hd;
         -- missing declaration for a_frs1516_test_item.penwl2sp;
         -- missing declaration for a_frs1516_test_item.penwl3hd;
         -- missing declaration for a_frs1516_test_item.penwl3sp;
         -- missing declaration for a_frs1516_test_item.penwl4hd;
         -- missing declaration for a_frs1516_test_item.penwl4sp;
         -- missing declaration for a_frs1516_test_item.penwl5hd;
         -- missing declaration for a_frs1516_test_item.penwl5sp;
         -- missing declaration for a_frs1516_test_item.penwl6hd;
         -- missing declaration for a_frs1516_test_item.penwl6sp;
         -- missing declaration for a_frs1516_test_item.pepscthd;
         -- missing declaration for a_frs1516_test_item.pepsctsp;
         -- missing declaration for a_frs1516_test_item.personhd;
         -- missing declaration for a_frs1516_test_item.personsp;
         -- missing declaration for a_frs1516_test_item.qpipdhd;
         -- missing declaration for a_frs1516_test_item.qpipdsp;
         -- missing declaration for a_frs1516_test_item.qpipmhd;
         -- missing declaration for a_frs1516_test_item.qpipmsp;
         -- missing declaration for a_frs1516_test_item.poaccthd;
         -- missing declaration for a_frs1516_test_item.poacctsp;
         -- missing declaration for a_frs1516_test_item.pocardhd;
         -- missing declaration for a_frs1516_test_item.pocardsp;
         -- missing declaration for a_frs1516_test_item.ppnumchd;
         -- missing declaration for a_frs1516_test_item.ppnumcsp;
         a_frs1516_test_item.proptxhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.proptxsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ptwkyrhd;
         -- missing declaration for a_frs1516_test_item.ptwkyrsp;
         -- missing declaration for a_frs1516_test_item.relp1hd;
         -- missing declaration for a_frs1516_test_item.relp1sp;
         -- missing declaration for a_frs1516_test_item.relp2hd;
         -- missing declaration for a_frs1516_test_item.relp2sp;
         -- missing declaration for a_frs1516_test_item.relp3hd;
         -- missing declaration for a_frs1516_test_item.relp3sp;
         -- missing declaration for a_frs1516_test_item.relp4hd;
         -- missing declaration for a_frs1516_test_item.relp4sp;
         -- missing declaration for a_frs1516_test_item.relp5hd;
         -- missing declaration for a_frs1516_test_item.relp5sp;
         -- missing declaration for a_frs1516_test_item.relp6hd;
         -- missing declaration for a_frs1516_test_item.relp6sp;
         -- missing declaration for a_frs1516_test_item.relp7hd;
         -- missing declaration for a_frs1516_test_item.relp7sp;
         -- missing declaration for a_frs1516_test_item.relp8hd;
         -- missing declaration for a_frs1516_test_item.relp8sp;
         -- missing declaration for a_frs1516_test_item.relp9hd;
         -- missing declaration for a_frs1516_test_item.relp9sp;
         -- missing declaration for a_frs1516_test_item.relp10hd;
         -- missing declaration for a_frs1516_test_item.relp10sp;
         -- missing declaration for a_frs1516_test_item.relp11hd;
         -- missing declaration for a_frs1516_test_item.relp11sp;
         -- missing declaration for a_frs1516_test_item.relp12hd;
         -- missing declaration for a_frs1516_test_item.relp12sp;
         -- missing declaration for a_frs1516_test_item.relp13hd;
         -- missing declaration for a_frs1516_test_item.relp13sp;
         -- missing declaration for a_frs1516_test_item.relp14hd;
         -- missing declaration for a_frs1516_test_item.relp14sp;
         -- missing declaration for a_frs1516_test_item.reasonhd;
         -- missing declaration for a_frs1516_test_item.reasonsp;
         a_frs1516_test_item.redamthd := 1010100.012 + Amount( i );
         a_frs1516_test_item.redamtsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.redundhd;
         -- missing declaration for a_frs1516_test_item.redundsp;
         -- missing declaration for a_frs1516_test_item.rednethd;
         -- missing declaration for a_frs1516_test_item.rednetsp;
         -- missing declaration for a_frs1516_test_item.redtaxhd;
         -- missing declaration for a_frs1516_test_item.redtaxsp;
         -- missing declaration for a_frs1516_test_item.relhrphd;
         -- missing declaration for a_frs1516_test_item.relhrpsp;
         -- missing declaration for a_frs1516_test_item.relgewhd;
         -- missing declaration for a_frs1516_test_item.relgewsp;
         -- missing declaration for a_frs1516_test_item.relgschd;
         -- missing declaration for a_frs1516_test_item.relgscsp;
         -- missing declaration for a_frs1516_test_item.rprofhd;
         -- missing declaration for a_frs1516_test_item.rprofsp;
         -- missing declaration for a_frs1516_test_item.retirehd;
         -- missing declaration for a_frs1516_test_item.retiresp;
         -- missing declaration for a_frs1516_test_item.retir1hd;
         -- missing declaration for a_frs1516_test_item.retir1sp;
         -- missing declaration for a_frs1516_test_item.retreshd;
         -- missing declaration for a_frs1516_test_item.retressp;
         a_frs1516_test_item.renthd := 1010100.012 + Amount( i );
         a_frs1516_test_item.rentsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.royalhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.royalsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.sleephd := 1010100.012 + Amount( i );
         a_frs1516_test_item.sleepsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.forpenhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.forpensp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.restrchd;
         -- missing declaration for a_frs1516_test_item.restrcsp;
         -- missing declaration for a_frs1516_test_item.sapadjhd;
         -- missing declaration for a_frs1516_test_item.sapadjsp;
         -- missing declaration for a_frs1516_test_item.sdem01hd;
         -- missing declaration for a_frs1516_test_item.sdem01sp;
         -- missing declaration for a_frs1516_test_item.sdem02hd;
         -- missing declaration for a_frs1516_test_item.sdem02sp;
         -- missing declaration for a_frs1516_test_item.sdem03hd;
         -- missing declaration for a_frs1516_test_item.sdem03sp;
         -- missing declaration for a_frs1516_test_item.sdem04hd;
         -- missing declaration for a_frs1516_test_item.sdem04sp;
         -- missing declaration for a_frs1516_test_item.sdem05hd;
         -- missing declaration for a_frs1516_test_item.sdem05sp;
         -- missing declaration for a_frs1516_test_item.sdem06hd;
         -- missing declaration for a_frs1516_test_item.sdem06sp;
         -- missing declaration for a_frs1516_test_item.sdem07hd;
         -- missing declaration for a_frs1516_test_item.sdem07sp;
         -- missing declaration for a_frs1516_test_item.sdem08hd;
         -- missing declaration for a_frs1516_test_item.sdem08sp;
         -- missing declaration for a_frs1516_test_item.sdem09hd;
         -- missing declaration for a_frs1516_test_item.sdem09sp;
         -- missing declaration for a_frs1516_test_item.sdem10hd;
         -- missing declaration for a_frs1516_test_item.sdem10sp;
         -- missing declaration for a_frs1516_test_item.sdem11hd;
         -- missing declaration for a_frs1516_test_item.sdem11sp;
         -- missing declaration for a_frs1516_test_item.sdem12hd;
         -- missing declaration for a_frs1516_test_item.sdem12sp;
         -- missing declaration for a_frs1516_test_item.inseinhd;
         -- missing declaration for a_frs1516_test_item.inseinsp;
         -- missing declaration for a_frs1516_test_item.sdemphd;
         -- missing declaration for a_frs1516_test_item.sdempsp;
         -- missing declaration for a_frs1516_test_item.sexhd;
         -- missing declaration for a_frs1516_test_item.sexsp;
         -- missing declaration for a_frs1516_test_item.sichd;
         -- missing declaration for a_frs1516_test_item.sicsp;
         -- missing declaration for a_frs1516_test_item.sidqnhd;
         -- missing declaration for a_frs1516_test_item.sidqnsp;
         -- missing declaration for a_frs1516_test_item.sloshd;
         -- missing declaration for a_frs1516_test_item.slossp;
         a_frs1516_test_item.slramthd := 1010100.012 + Amount( i );
         a_frs1516_test_item.slramtsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.slrppdhd;
         -- missing declaration for a_frs1516_test_item.slrppdsp;
         a_frs1516_test_item.smpajhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.smpajsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.sc2010hd;
         -- missing declaration for a_frs1516_test_item.sc2010sp;
         -- missing declaration for a_frs1516_test_item.qsfgrhd;
         -- missing declaration for a_frs1516_test_item.qsfgrsp;
         -- missing declaration for a_frs1516_test_item.qssmthd;
         -- missing declaration for a_frs1516_test_item.qssmtsp;
         -- missing declaration for a_frs1516_test_item.qlgdwphd;
         -- missing declaration for a_frs1516_test_item.qlgdwpsp;
         -- missing declaration for a_frs1516_test_item.qlglahd;
         -- missing declaration for a_frs1516_test_item.qlglasp;
         -- missing declaration for a_frs1516_test_item.blindhd;
         -- missing declaration for a_frs1516_test_item.blindsp;
         -- missing declaration for a_frs1516_test_item.parsihd;
         -- missing declaration for a_frs1516_test_item.parsisp;
         -- missing declaration for a_frs1516_test_item.deafhd;
         -- missing declaration for a_frs1516_test_item.deafsp;
         -- missing declaration for a_frs1516_test_item.spouthd;
         -- missing declaration for a_frs1516_test_item.spoutsp;
         a_frs1516_test_item.sppadjhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.sppadjsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.spyrothd;
         -- missing declaration for a_frs1516_test_item.spyrotsp;
         a_frs1516_test_item.srentahd := 1010100.012 + Amount( i );
         a_frs1516_test_item.srentasp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.psrenthd;
         -- missing declaration for a_frs1516_test_item.psrentsp;
         -- missing declaration for a_frs1516_test_item.sfispchd;
         -- missing declaration for a_frs1516_test_item.sfispcsp;
         -- missing declaration for a_frs1516_test_item.sfjesahd;
         -- missing declaration for a_frs1516_test_item.sfjesasp;
         -- missing declaration for a_frs1516_test_item.sruchd;
         -- missing declaration for a_frs1516_test_item.srucsp;
         a_frs1516_test_item.sspajhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.sspajsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.gtsavahd;
         -- missing declaration for a_frs1516_test_item.gtsavasp;
         -- missing declaration for a_frs1516_test_item.stshcthd;
         -- missing declaration for a_frs1516_test_item.stshctsp;
         -- missing declaration for a_frs1516_test_item.tdaywkhd;
         -- missing declaration for a_frs1516_test_item.tdaywksp;
         -- missing declaration for a_frs1516_test_item.agefedhd;
         -- missing declaration for a_frs1516_test_item.agefedsp;
         -- missing declaration for a_frs1516_test_item.tmpjobhd;
         -- missing declaration for a_frs1516_test_item.tmpjobsp;
         -- missing declaration for a_frs1516_test_item.tesscthd;
         -- missing declaration for a_frs1516_test_item.tessctsp;
         -- missing declaration for a_frs1516_test_item.totgrahd;
         a_frs1516_test_item.totgrasp := 1010100.012 + Amount( i );
         a_frs1516_test_item.tothouhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.tothousp := 1010100.012 + Amount( i );
         a_frs1516_test_item.totinthd := 1010100.012 + Amount( i );
         a_frs1516_test_item.totintsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.totocchd := 1010100.012 + Amount( i );
         a_frs1516_test_item.totoccsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.trainhd;
         -- missing declaration for a_frs1516_test_item.trainsp;
         -- missing declaration for a_frs1516_test_item.trnallhd;
         -- missing declaration for a_frs1516_test_item.trnallsp;
         a_frs1516_test_item.ttbprxhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ttbprxsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.tuborrhd;
         -- missing declaration for a_frs1516_test_item.tuborrsp;
         -- missing declaration for a_frs1516_test_item.typeedhd;
         -- missing declaration for a_frs1516_test_item.typeedsp;
         -- missing declaration for a_frs1516_test_item.unpd1hd;
         -- missing declaration for a_frs1516_test_item.unpd1sp;
         -- missing declaration for a_frs1516_test_item.unpd2hd;
         -- missing declaration for a_frs1516_test_item.unpd2sp;
         -- missing declaration for a_frs1516_test_item.untrcthd;
         -- missing declaration for a_frs1516_test_item.untrctsp;
         -- missing declaration for a_frs1516_test_item.upersohd;
         -- missing declaration for a_frs1516_test_item.upersosp;
         -- missing declaration for a_frs1516_test_item.agewidhd;
         -- missing declaration for a_frs1516_test_item.agewidsp;
         -- missing declaration for a_frs1516_test_item.kidwidhd;
         -- missing declaration for a_frs1516_test_item.kidwidsp;
         -- missing declaration for a_frs1516_test_item.quchd;
         -- missing declaration for a_frs1516_test_item.qucsp;
         -- missing declaration for a_frs1516_test_item.qhbhd;
         -- missing declaration for a_frs1516_test_item.qhbsp;
         -- missing declaration for a_frs1516_test_item.qwtchd;
         -- missing declaration for a_frs1516_test_item.qwtcsp;
         -- missing declaration for a_frs1516_test_item.qctchd;
         -- missing declaration for a_frs1516_test_item.qctcsp;
         -- missing declaration for a_frs1516_test_item.qishd;
         -- missing declaration for a_frs1516_test_item.qissp;
         -- missing declaration for a_frs1516_test_item.qjsahd;
         -- missing declaration for a_frs1516_test_item.qjsasp;
         -- missing declaration for a_frs1516_test_item.qesahd;
         -- missing declaration for a_frs1516_test_item.qesasp;
         -- missing declaration for a_frs1516_test_item.qcahd;
         -- missing declaration for a_frs1516_test_item.qcasp;
         -- missing declaration for a_frs1516_test_item.waithd;
         -- missing declaration for a_frs1516_test_item.waitsp;
         -- missing declaration for a_frs1516_test_item.whresphd;
         -- missing declaration for a_frs1516_test_item.whrespsp;
         -- missing declaration for a_frs1516_test_item.whoctbhd;
         -- missing declaration for a_frs1516_test_item.whoctbsp;
         a_frs1516_test_item.widocchd := 1010100.012 + Amount( i );
         a_frs1516_test_item.widoccsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.wintflhd;
         -- missing declaration for a_frs1516_test_item.wintflsp;
         -- missing declaration for a_frs1516_test_item.workinhd;
         -- missing declaration for a_frs1516_test_item.workinsp;
         -- missing declaration for a_frs1516_test_item.wpahd;
         -- missing declaration for a_frs1516_test_item.wpasp;
         -- missing declaration for a_frs1516_test_item.wpbahd;
         -- missing declaration for a_frs1516_test_item.wpbasp;
         -- missing declaration for a_frs1516_test_item.wtclm1hd;
         -- missing declaration for a_frs1516_test_item.wtclm1sp;
         -- missing declaration for a_frs1516_test_item.wtclm2hd;
         -- missing declaration for a_frs1516_test_item.wtclm2sp;
         -- missing declaration for a_frs1516_test_item.yjblevhd;
         -- missing declaration for a_frs1516_test_item.yjblevsp;
         -- missing declaration for a_frs1516_test_item.ystwkhd;
         -- missing declaration for a_frs1516_test_item.ystwksp;
         a_frs1516_test_item.as011hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.as012hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.as013hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.as014hd;
         a_frs1516_test_item.as011sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.as012sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.as013sp;
         -- missing declaration for a_frs1516_test_item.as014sp;
         -- missing declaration for a_frs1516_test_item.as021hd;
         -- missing declaration for a_frs1516_test_item.as022hd;
         a_frs1516_test_item.as021sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.as022sp;
         -- missing declaration for a_frs1516_test_item.as031hd;
         -- missing declaration for a_frs1516_test_item.as031sp;
         a_frs1516_test_item.as051hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.as052hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.as053hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.as054hd;
         -- missing declaration for a_frs1516_test_item.as055hd;
         -- missing declaration for a_frs1516_test_item.as056hd;
         -- missing declaration for a_frs1516_test_item.as057hd;
         a_frs1516_test_item.as051sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.as052sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.as053sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.as054sp;
         -- missing declaration for a_frs1516_test_item.as055sp;
         -- missing declaration for a_frs1516_test_item.as056sp;
         -- missing declaration for a_frs1516_test_item.as057sp;
         -- missing declaration for a_frs1516_test_item.as061hd;
         -- missing declaration for a_frs1516_test_item.as061sp;
         -- missing declaration for a_frs1516_test_item.as071hd;
         -- missing declaration for a_frs1516_test_item.as071sp;
         a_frs1516_test_item.as081hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.as082hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.as083hd;
         -- missing declaration for a_frs1516_test_item.as084hd;
         -- missing declaration for a_frs1516_test_item.as085hd;
         a_frs1516_test_item.as081sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.as082sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.as083sp;
         -- missing declaration for a_frs1516_test_item.as084sp;
         -- missing declaration for a_frs1516_test_item.as085sp;
         -- missing declaration for a_frs1516_test_item.as101hd;
         -- missing declaration for a_frs1516_test_item.as101sp;
         -- missing declaration for a_frs1516_test_item.as111hd;
         -- missing declaration for a_frs1516_test_item.as111sp;
         -- missing declaration for a_frs1516_test_item.as121hd;
         -- missing declaration for a_frs1516_test_item.as121sp;
         -- missing declaration for a_frs1516_test_item.as131hd;
         -- missing declaration for a_frs1516_test_item.as131sp;
         -- missing declaration for a_frs1516_test_item.as141hd;
         -- missing declaration for a_frs1516_test_item.as142hd;
         -- missing declaration for a_frs1516_test_item.as143hd;
         -- missing declaration for a_frs1516_test_item.as141sp;
         -- missing declaration for a_frs1516_test_item.as142sp;
         -- missing declaration for a_frs1516_test_item.as143sp;
         a_frs1516_test_item.as151hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.as151sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.as161hd;
         -- missing declaration for a_frs1516_test_item.as161sp;
         -- missing declaration for a_frs1516_test_item.as191hd;
         -- missing declaration for a_frs1516_test_item.as191sp;
         a_frs1516_test_item.as211hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.as212hd;
         -- missing declaration for a_frs1516_test_item.as213hd;
         -- missing declaration for a_frs1516_test_item.as214hd;
         a_frs1516_test_item.as211sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.as212sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.as213sp;
         -- missing declaration for a_frs1516_test_item.as214sp;
         -- missing declaration for a_frs1516_test_item.as261hd;
         -- missing declaration for a_frs1516_test_item.as261sp;
         a_frs1516_test_item.as271hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.as272hd;
         -- missing declaration for a_frs1516_test_item.as271sp;
         -- missing declaration for a_frs1516_test_item.as272sp;
         -- missing declaration for a_frs1516_test_item.as281hd;
         a_frs1516_test_item.as281sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.as291hd;
         -- missing declaration for a_frs1516_test_item.as292hd;
         -- missing declaration for a_frs1516_test_item.as293hd;
         -- missing declaration for a_frs1516_test_item.as291sp;
         -- missing declaration for a_frs1516_test_item.as292sp;
         -- missing declaration for a_frs1516_test_item.as293sp;
         -- missing declaration for a_frs1516_test_item.stdlachd;
         -- missing declaration for a_frs1516_test_item.stdlamhd;
         -- missing declaration for a_frs1516_test_item.stcbhd;
         -- missing declaration for a_frs1516_test_item.stpenchd;
         -- missing declaration for a_frs1516_test_item.strphd;
         -- missing declaration for a_frs1516_test_item.stwphd;
         -- missing declaration for a_frs1516_test_item.stwdphd;
         -- missing declaration for a_frs1516_test_item.stwwphd;
         -- missing declaration for a_frs1516_test_item.stsdahd;
         -- missing declaration for a_frs1516_test_item.staahd;
         -- missing declaration for a_frs1516_test_item.sticahd;
         -- missing declaration for a_frs1516_test_item.stjsahd;
         -- missing declaration for a_frs1516_test_item.stiidbhd;
         -- missing declaration for a_frs1516_test_item.stesahd;
         -- missing declaration for a_frs1516_test_item.stibhd;
         -- missing declaration for a_frs1516_test_item.stishd;
         -- missing declaration for a_frs1516_test_item.stmahd;
         -- missing declaration for a_frs1516_test_item.stshhd;
         -- missing declaration for a_frs1516_test_item.stgahd;
         -- missing declaration for a_frs1516_test_item.stwtchd;
         -- missing declaration for a_frs1516_test_item.stctchd;
         -- missing declaration for a_frs1516_test_item.stwtclhd;
         -- missing declaration for a_frs1516_test_item.stctclhd;
         -- missing declaration for a_frs1516_test_item.stuchd;
         -- missing declaration for a_frs1516_test_item.stpipdhd;
         -- missing declaration for a_frs1516_test_item.stpipmhd;
         -- missing declaration for a_frs1516_test_item.stdlacsp;
         -- missing declaration for a_frs1516_test_item.stdlamsp;
         -- missing declaration for a_frs1516_test_item.stcbsp;
         -- missing declaration for a_frs1516_test_item.stpencsp;
         -- missing declaration for a_frs1516_test_item.strpsp;
         -- missing declaration for a_frs1516_test_item.stwpsp;
         -- missing declaration for a_frs1516_test_item.stwdpsp;
         -- missing declaration for a_frs1516_test_item.stwwpsp;
         -- missing declaration for a_frs1516_test_item.stsdasp;
         -- missing declaration for a_frs1516_test_item.staasp;
         -- missing declaration for a_frs1516_test_item.sticasp;
         -- missing declaration for a_frs1516_test_item.stjsasp;
         -- missing declaration for a_frs1516_test_item.stiidbsp;
         -- missing declaration for a_frs1516_test_item.stesasp;
         -- missing declaration for a_frs1516_test_item.stibsp;
         -- missing declaration for a_frs1516_test_item.stissp;
         -- missing declaration for a_frs1516_test_item.stmasp;
         -- missing declaration for a_frs1516_test_item.stshsp;
         -- missing declaration for a_frs1516_test_item.stgasp;
         -- missing declaration for a_frs1516_test_item.stwtcsp;
         -- missing declaration for a_frs1516_test_item.stctcsp;
         -- missing declaration for a_frs1516_test_item.stwtclsp;
         -- missing declaration for a_frs1516_test_item.stctclsp;
         -- missing declaration for a_frs1516_test_item.stucsp;
         -- missing declaration for a_frs1516_test_item.stpipdsp;
         -- missing declaration for a_frs1516_test_item.stpipmsp;
         a_frs1516_test_item.dlacahd := 1010100.012 + Amount( i );
         a_frs1516_test_item.dlamohd := 1010100.012 + Amount( i );
         a_frs1516_test_item.cbhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.lpencrhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.rphd := 1010100.012 + Amount( i );
         a_frs1516_test_item.wphd := 1010100.012 + Amount( i );
         a_frs1516_test_item.wdphd := 1010100.012 + Amount( i );
         a_frs1516_test_item.wwphd := 1010100.012 + Amount( i );
         a_frs1516_test_item.sdahd := 1010100.012 + Amount( i );
         a_frs1516_test_item.aahd := 1010100.012 + Amount( i );
         a_frs1516_test_item.icahd := 1010100.012 + Amount( i );
         a_frs1516_test_item.jsahd := 1010100.012 + Amount( i );
         a_frs1516_test_item.iidbhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.esahd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ibhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ishd := 1010100.012 + Amount( i );
         a_frs1516_test_item.mahd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.sfmghd;
         a_frs1516_test_item.sffghd := 1010100.012 + Amount( i );
         a_frs1516_test_item.othbenhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.tubenhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsbenhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.sicinhd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.accinhd;
         a_frs1516_test_item.hosinhd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.gtshd;
         a_frs1516_test_item.gahd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.iwchd;
         -- missing declaration for a_frs1516_test_item.r2wchd;
         -- missing declaration for a_frs1516_test_item.widplhd;
         a_frs1516_test_item.uninshd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.wfamthd;
         a_frs1516_test_item.dssdpihd := 1010100.012 + Amount( i );
         a_frs1516_test_item.dssdpjhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.sfrpaihd := 1010100.012 + Amount( i );
         a_frs1516_test_item.sfrpajhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.exhbhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.perhinhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.otsiinhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.cichd := 1010100.012 + Amount( i );
         a_frs1516_test_item.bowtchd := 1010100.012 + Amount( i );
         a_frs1516_test_item.boctchd := 1010100.012 + Amount( i );
         a_frs1516_test_item.bowtclhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.boctclhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.hbhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.uchd := 1010100.012 + Amount( i );
         a_frs1516_test_item.pipdhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.pipmhd := 1010100.012 + Amount( i );
         a_frs1516_test_item.lndwphd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.lnlahd;
         a_frs1516_test_item.dwpauchd := 1010100.012 + Amount( i );
         a_frs1516_test_item.sfrpuchd := 1010100.012 + Amount( i );
         a_frs1516_test_item.dlacasp := 1010100.012 + Amount( i );
         a_frs1516_test_item.dlamosp := 1010100.012 + Amount( i );
         a_frs1516_test_item.cbsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.lpencrsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.rpsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.wpsp;
         a_frs1516_test_item.wdpsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.wwpsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.sdasp := 1010100.012 + Amount( i );
         a_frs1516_test_item.aasp := 1010100.012 + Amount( i );
         a_frs1516_test_item.icasp := 1010100.012 + Amount( i );
         a_frs1516_test_item.jsasp := 1010100.012 + Amount( i );
         a_frs1516_test_item.iidbsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.esasp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ibsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.issp := 1010100.012 + Amount( i );
         a_frs1516_test_item.masp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.sfmgsp;
         -- missing declaration for a_frs1516_test_item.sffgsp;
         -- missing declaration for a_frs1516_test_item.othbensp;
         -- missing declaration for a_frs1516_test_item.tubensp;
         -- missing declaration for a_frs1516_test_item.fsbensp;
         a_frs1516_test_item.sicinsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.accinsp;
         a_frs1516_test_item.hosinsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.gtssp;
         -- missing declaration for a_frs1516_test_item.gasp;
         -- missing declaration for a_frs1516_test_item.iwcsp;
         -- missing declaration for a_frs1516_test_item.r2wcsp;
         -- missing declaration for a_frs1516_test_item.widplsp;
         a_frs1516_test_item.uninssp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.wfamtsp;
         a_frs1516_test_item.dssdpisp := 1010100.012 + Amount( i );
         a_frs1516_test_item.dssdpjsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.sfrpaisp := 1010100.012 + Amount( i );
         a_frs1516_test_item.sfrpajsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.exhbsp;
         a_frs1516_test_item.perhinsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.otsiinsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.cicsp;
         a_frs1516_test_item.bowtcsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.boctcsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.bowtclsp;
         a_frs1516_test_item.boctclsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.hbsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ucsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.pipdsp := 1010100.012 + Amount( i );
         a_frs1516_test_item.pipmsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.lndwpsp;
         -- missing declaration for a_frs1516_test_item.lnlasp;
         -- missing declaration for a_frs1516_test_item.dwpaucsp;
         a_frs1516_test_item.sfrpucsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ltdlachd;
         -- missing declaration for a_frs1516_test_item.ltdlamhd;
         -- missing declaration for a_frs1516_test_item.ltcbhd;
         -- missing declaration for a_frs1516_test_item.bopenchd;
         -- missing declaration for a_frs1516_test_item.ltrphd;
         -- missing declaration for a_frs1516_test_item.ltwphd;
         -- missing declaration for a_frs1516_test_item.ltwdphd;
         -- missing declaration for a_frs1516_test_item.ltwwphd;
         -- missing declaration for a_frs1516_test_item.ltsdahd;
         -- missing declaration for a_frs1516_test_item.ltaahd;
         -- missing declaration for a_frs1516_test_item.lticahd;
         -- missing declaration for a_frs1516_test_item.ltjsahd;
         -- missing declaration for a_frs1516_test_item.ltiidbhd;
         -- missing declaration for a_frs1516_test_item.ltesahd;
         -- missing declaration for a_frs1516_test_item.ltibhd;
         -- missing declaration for a_frs1516_test_item.ltishd;
         -- missing declaration for a_frs1516_test_item.ltmahd;
         -- missing declaration for a_frs1516_test_item.ltshhd;
         -- missing declaration for a_frs1516_test_item.ltgahd;
         -- missing declaration for a_frs1516_test_item.hwtchd;
         -- missing declaration for a_frs1516_test_item.hctchd;
         -- missing declaration for a_frs1516_test_item.hwtclhd;
         -- missing declaration for a_frs1516_test_item.hctclhd;
         -- missing declaration for a_frs1516_test_item.ltuchd;
         -- missing declaration for a_frs1516_test_item.ltpipdhd;
         -- missing declaration for a_frs1516_test_item.ltpipmhd;
         -- missing declaration for a_frs1516_test_item.ltdlacsp;
         -- missing declaration for a_frs1516_test_item.ltdlamsp;
         -- missing declaration for a_frs1516_test_item.ltcbsp;
         -- missing declaration for a_frs1516_test_item.bopencsp;
         -- missing declaration for a_frs1516_test_item.ltrpsp;
         -- missing declaration for a_frs1516_test_item.ltwpsp;
         -- missing declaration for a_frs1516_test_item.ltwdpsp;
         -- missing declaration for a_frs1516_test_item.ltwwpsp;
         -- missing declaration for a_frs1516_test_item.ltsdasp;
         -- missing declaration for a_frs1516_test_item.ltaasp;
         -- missing declaration for a_frs1516_test_item.lticasp;
         -- missing declaration for a_frs1516_test_item.ltjsasp;
         -- missing declaration for a_frs1516_test_item.ltiidbsp;
         -- missing declaration for a_frs1516_test_item.ltesasp;
         -- missing declaration for a_frs1516_test_item.ltibsp;
         -- missing declaration for a_frs1516_test_item.ltissp;
         -- missing declaration for a_frs1516_test_item.ltmasp;
         -- missing declaration for a_frs1516_test_item.ltshsp;
         -- missing declaration for a_frs1516_test_item.ltgasp;
         -- missing declaration for a_frs1516_test_item.hwtcsp;
         -- missing declaration for a_frs1516_test_item.hctcsp;
         -- missing declaration for a_frs1516_test_item.hwtclsp;
         -- missing declaration for a_frs1516_test_item.hctclsp;
         -- missing declaration for a_frs1516_test_item.ltucsp;
         -- missing declaration for a_frs1516_test_item.ltpipdsp;
         -- missing declaration for a_frs1516_test_item.ltpipmsp;
         -- missing declaration for a_frs1516_test_item.pdlacahd;
         -- missing declaration for a_frs1516_test_item.pdlamohd;
         -- missing declaration for a_frs1516_test_item.pcbhd;
         -- missing declaration for a_frs1516_test_item.hpenchd;
         -- missing declaration for a_frs1516_test_item.prphd;
         -- missing declaration for a_frs1516_test_item.pwphd;
         -- missing declaration for a_frs1516_test_item.pwdphd;
         -- missing declaration for a_frs1516_test_item.pwwphd;
         -- missing declaration for a_frs1516_test_item.psdahd;
         -- missing declaration for a_frs1516_test_item.paahd;
         -- missing declaration for a_frs1516_test_item.picahd;
         -- missing declaration for a_frs1516_test_item.pjsahd;
         -- missing declaration for a_frs1516_test_item.piidbhd;
         -- missing declaration for a_frs1516_test_item.pesahd;
         -- missing declaration for a_frs1516_test_item.pibhd;
         -- missing declaration for a_frs1516_test_item.pishd;
         -- missing declaration for a_frs1516_test_item.pmahd;
         -- missing declaration for a_frs1516_test_item.pothbehd;
         -- missing declaration for a_frs1516_test_item.ptubenhd;
         -- missing declaration for a_frs1516_test_item.pfsbenhd;
         -- missing declaration for a_frs1516_test_item.psicinhd;
         -- missing declaration for a_frs1516_test_item.paccinhd;
         -- missing declaration for a_frs1516_test_item.phosinhd;
         -- missing declaration for a_frs1516_test_item.pgtshd;
         -- missing declaration for a_frs1516_test_item.pgahd;
         -- missing declaration for a_frs1516_test_item.iwcpdhd;
         -- missing declaration for a_frs1516_test_item.r2wcpdhd;
         -- missing declaration for a_frs1516_test_item.puninshd;
         -- missing declaration for a_frs1516_test_item.pdsspihd;
         -- missing declaration for a_frs1516_test_item.pdsspjhd;
         -- missing declaration for a_frs1516_test_item.pexhbhd;
         -- missing declaration for a_frs1516_test_item.ppehinhd;
         -- missing declaration for a_frs1516_test_item.potsinhd;
         -- missing declaration for a_frs1516_test_item.pdcichd;
         -- missing declaration for a_frs1516_test_item.wwtchd;
         -- missing declaration for a_frs1516_test_item.wctchd;
         -- missing declaration for a_frs1516_test_item.wwtclhd;
         -- missing declaration for a_frs1516_test_item.wctclhd;
         -- missing declaration for a_frs1516_test_item.phbhd;
         -- missing declaration for a_frs1516_test_item.puchd;
         -- missing declaration for a_frs1516_test_item.ppipdhd;
         -- missing declaration for a_frs1516_test_item.ppipmhd;
         -- missing declaration for a_frs1516_test_item.pdwpuchd;
         -- missing declaration for a_frs1516_test_item.pdlacasp;
         -- missing declaration for a_frs1516_test_item.pdlamosp;
         -- missing declaration for a_frs1516_test_item.pcbsp;
         -- missing declaration for a_frs1516_test_item.hpencsp;
         -- missing declaration for a_frs1516_test_item.prpsp;
         -- missing declaration for a_frs1516_test_item.pwpsp;
         -- missing declaration for a_frs1516_test_item.pwdpsp;
         -- missing declaration for a_frs1516_test_item.pwwpsp;
         -- missing declaration for a_frs1516_test_item.psdasp;
         -- missing declaration for a_frs1516_test_item.paasp;
         -- missing declaration for a_frs1516_test_item.picasp;
         -- missing declaration for a_frs1516_test_item.pjsasp;
         -- missing declaration for a_frs1516_test_item.piidbsp;
         -- missing declaration for a_frs1516_test_item.pesasp;
         -- missing declaration for a_frs1516_test_item.pibsp;
         -- missing declaration for a_frs1516_test_item.pissp;
         -- missing declaration for a_frs1516_test_item.pmasp;
         -- missing declaration for a_frs1516_test_item.pothbesp;
         -- missing declaration for a_frs1516_test_item.ptubensp;
         -- missing declaration for a_frs1516_test_item.pfsbensp;
         -- missing declaration for a_frs1516_test_item.psicinsp;
         -- missing declaration for a_frs1516_test_item.paccinsp;
         -- missing declaration for a_frs1516_test_item.phosinsp;
         -- missing declaration for a_frs1516_test_item.pgtssp;
         -- missing declaration for a_frs1516_test_item.pgasp;
         -- missing declaration for a_frs1516_test_item.iwcpdsp;
         -- missing declaration for a_frs1516_test_item.r2wcpdsp;
         -- missing declaration for a_frs1516_test_item.puninssp;
         -- missing declaration for a_frs1516_test_item.pdsspisp;
         -- missing declaration for a_frs1516_test_item.pdsspjsp;
         -- missing declaration for a_frs1516_test_item.pexhbsp;
         -- missing declaration for a_frs1516_test_item.ppehinsp;
         -- missing declaration for a_frs1516_test_item.potsinsp;
         -- missing declaration for a_frs1516_test_item.pdcicsp;
         -- missing declaration for a_frs1516_test_item.wwtcsp;
         -- missing declaration for a_frs1516_test_item.wctcsp;
         -- missing declaration for a_frs1516_test_item.wwtclsp;
         -- missing declaration for a_frs1516_test_item.wctclsp;
         -- missing declaration for a_frs1516_test_item.phbsp;
         -- missing declaration for a_frs1516_test_item.pucsp;
         -- missing declaration for a_frs1516_test_item.ppipdsp;
         -- missing declaration for a_frs1516_test_item.ppipmsp;
         -- missing declaration for a_frs1516_test_item.pdwpucsp;
         -- missing declaration for a_frs1516_test_item.cbpayehd;
         -- missing declaration for a_frs1516_test_item.cbpayesp;
         -- missing declaration for a_frs1516_test_item.cbtaxhd;
         -- missing declaration for a_frs1516_test_item.cbtaxsp;
         -- missing declaration for a_frs1516_test_item.pwtchd;
         -- missing declaration for a_frs1516_test_item.pctchd;
         -- missing declaration for a_frs1516_test_item.pwtcsp;
         -- missing declaration for a_frs1516_test_item.pctcsp;
         -- missing declaration for a_frs1516_test_item.npcamthd;
         a_frs1516_test_item.urphd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uwphd;
         a_frs1516_test_item.uesahd := 1010100.012 + Amount( i );
         a_frs1516_test_item.uishd := 1010100.012 + Amount( i );
         a_frs1516_test_item.uwtchd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uctchd;
         -- missing declaration for a_frs1516_test_item.npcamtsp;
         a_frs1516_test_item.urpsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uwpsp;
         a_frs1516_test_item.uesasp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uissp;
         a_frs1516_test_item.uwtcsp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uctcsp;
         -- missing declaration for a_frs1516_test_item.dmpenchd;
         -- missing declaration for a_frs1516_test_item.purphd;
         -- missing declaration for a_frs1516_test_item.puwphd;
         -- missing declaration for a_frs1516_test_item.nupesahd;
         -- missing declaration for a_frs1516_test_item.puishd;
         -- missing declaration for a_frs1516_test_item.dmpencsp;
         -- missing declaration for a_frs1516_test_item.purpsp;
         -- missing declaration for a_frs1516_test_item.puwpsp;
         -- missing declaration for a_frs1516_test_item.nupesasp;
         -- missing declaration for a_frs1516_test_item.puissp;
         -- missing declaration for a_frs1516_test_item.wjsahd;
         -- missing declaration for a_frs1516_test_item.wesahd;
         -- missing declaration for a_frs1516_test_item.wishd;
         -- missing declaration for a_frs1516_test_item.wothbehd;
         -- missing declaration for a_frs1516_test_item.wtubenhd;
         -- missing declaration for a_frs1516_test_item.wfsbenhd;
         -- missing declaration for a_frs1516_test_item.wsicinhd;
         -- missing declaration for a_frs1516_test_item.waccinhd;
         -- missing declaration for a_frs1516_test_item.whosinhd;
         -- missing declaration for a_frs1516_test_item.wkiwchd;
         -- missing declaration for a_frs1516_test_item.wkr2whd;
         -- missing declaration for a_frs1516_test_item.wuninshd;
         -- missing declaration for a_frs1516_test_item.wpehinhd;
         -- missing declaration for a_frs1516_test_item.wotsinhd;
         -- missing declaration for a_frs1516_test_item.wocichd;
         -- missing declaration for a_frs1516_test_item.whbhd;
         -- missing declaration for a_frs1516_test_item.wjsasp;
         -- missing declaration for a_frs1516_test_item.wesasp;
         -- missing declaration for a_frs1516_test_item.wissp;
         -- missing declaration for a_frs1516_test_item.wothbesp;
         -- missing declaration for a_frs1516_test_item.wtubensp;
         -- missing declaration for a_frs1516_test_item.wfsbensp;
         -- missing declaration for a_frs1516_test_item.wsicinsp;
         -- missing declaration for a_frs1516_test_item.waccinsp;
         -- missing declaration for a_frs1516_test_item.whosinsp;
         -- missing declaration for a_frs1516_test_item.wkiwcsp;
         -- missing declaration for a_frs1516_test_item.wkr2wsp;
         -- missing declaration for a_frs1516_test_item.wuninssp;
         -- missing declaration for a_frs1516_test_item.wpehinsp;
         -- missing declaration for a_frs1516_test_item.wotsinsp;
         -- missing declaration for a_frs1516_test_item.wocicsp;
         -- missing declaration for a_frs1516_test_item.whbsp;
         -- missing declaration for a_frs1516_test_item.yjsahd;
         -- missing declaration for a_frs1516_test_item.yesahd;
         -- missing declaration for a_frs1516_test_item.yishd;
         -- missing declaration for a_frs1516_test_item.yhbhd;
         -- missing declaration for a_frs1516_test_item.yjsasp;
         -- missing declaration for a_frs1516_test_item.yesasp;
         -- missing declaration for a_frs1516_test_item.yissp;
         -- missing declaration for a_frs1516_test_item.yhbsp;
         -- missing declaration for a_frs1516_test_item.prothbhd;
         -- missing declaration for a_frs1516_test_item.prtubehd;
         -- missing declaration for a_frs1516_test_item.prfsbehd;
         -- missing declaration for a_frs1516_test_item.prsicihd;
         -- missing declaration for a_frs1516_test_item.praccihd;
         -- missing declaration for a_frs1516_test_item.prhosihd;
         -- missing declaration for a_frs1516_test_item.pruninhd;
         -- missing declaration for a_frs1516_test_item.prphinhd;
         -- missing declaration for a_frs1516_test_item.prosinhd;
         -- missing declaration for a_frs1516_test_item.prcichd;
         -- missing declaration for a_frs1516_test_item.prothbsp;
         -- missing declaration for a_frs1516_test_item.prtubesp;
         -- missing declaration for a_frs1516_test_item.prfsbesp;
         -- missing declaration for a_frs1516_test_item.prsicisp;
         -- missing declaration for a_frs1516_test_item.praccisp;
         -- missing declaration for a_frs1516_test_item.prhosisp;
         -- missing declaration for a_frs1516_test_item.pruninsp;
         -- missing declaration for a_frs1516_test_item.prphinsp;
         -- missing declaration for a_frs1516_test_item.prosinsp;
         -- missing declaration for a_frs1516_test_item.prcicsp;
         -- missing declaration for a_frs1516_test_item.uspenchd;
         -- missing declaration for a_frs1516_test_item.usrphd;
         -- missing declaration for a_frs1516_test_item.uswphd;
         -- missing declaration for a_frs1516_test_item.usjsahd;
         -- missing declaration for a_frs1516_test_item.usishd;
         -- missing declaration for a_frs1516_test_item.uspencsp;
         -- missing declaration for a_frs1516_test_item.usrpsp;
         -- missing declaration for a_frs1516_test_item.uswpsp;
         -- missing declaration for a_frs1516_test_item.usjsasp;
         -- missing declaration for a_frs1516_test_item.usissp;
         -- missing declaration for a_frs1516_test_item.gicacahd;
         -- missing declaration for a_frs1516_test_item.pencrdhd;
         -- missing declaration for a_frs1516_test_item.gicaahd;
         -- missing declaration for a_frs1516_test_item.muibwhd;
         -- missing declaration for a_frs1516_test_item.wfuelhd;
         -- missing declaration for a_frs1516_test_item.exhbtyhd;
         -- missing declaration for a_frs1516_test_item.lnodwphd;
         -- missing declaration for a_frs1516_test_item.lnolahd;
         -- missing declaration for a_frs1516_test_item.gicacasp;
         -- missing declaration for a_frs1516_test_item.pencrdsp;
         -- missing declaration for a_frs1516_test_item.gicaasp;
         -- missing declaration for a_frs1516_test_item.muibwsp;
         -- missing declaration for a_frs1516_test_item.wfuelsp;
         -- missing declaration for a_frs1516_test_item.exhbtysp;
         -- missing declaration for a_frs1516_test_item.lnodwpsp;
         -- missing declaration for a_frs1516_test_item.lnolasp;
         -- missing declaration for a_frs1516_test_item.dcpayhd;
         -- missing declaration for a_frs1516_test_item.dmpayhd;
         -- missing declaration for a_frs1516_test_item.ecpenchd;
         -- missing declaration for a_frs1516_test_item.wporbahd;
         -- missing declaration for a_frs1516_test_item.aapayhd;
         -- missing declaration for a_frs1516_test_item.jsatyphd;
         -- missing declaration for a_frs1516_test_item.esatyphd;
         -- missing declaration for a_frs1516_test_item.mupibhd;
         -- missing declaration for a_frs1516_test_item.dssishd;
         -- missing declaration for a_frs1516_test_item.dssjsahd;
         -- missing declaration for a_frs1516_test_item.sfincihd;
         -- missing declaration for a_frs1516_test_item.sfincjhd;
         -- missing declaration for a_frs1516_test_item.pdlpayhd;
         -- missing declaration for a_frs1516_test_item.pmpayhd;
         -- missing declaration for a_frs1516_test_item.dwpuchd;
         -- missing declaration for a_frs1516_test_item.sfinuchd;
         -- missing declaration for a_frs1516_test_item.dcpaysp;
         -- missing declaration for a_frs1516_test_item.dmpaysp;
         -- missing declaration for a_frs1516_test_item.ecpencsp;
         -- missing declaration for a_frs1516_test_item.wporbasp;
         -- missing declaration for a_frs1516_test_item.aapaysp;
         -- missing declaration for a_frs1516_test_item.jsatypsp;
         -- missing declaration for a_frs1516_test_item.esatypsp;
         -- missing declaration for a_frs1516_test_item.mupibsp;
         -- missing declaration for a_frs1516_test_item.dssissp;
         -- missing declaration for a_frs1516_test_item.dssjsasp;
         -- missing declaration for a_frs1516_test_item.sfincisp;
         -- missing declaration for a_frs1516_test_item.sfincjsp;
         -- missing declaration for a_frs1516_test_item.pdlpaysp;
         -- missing declaration for a_frs1516_test_item.pmpaysp;
         -- missing declaration for a_frs1516_test_item.dwpucsp;
         -- missing declaration for a_frs1516_test_item.sfinucsp;
         -- missing declaration for a_frs1516_test_item.icaperhd;
         -- missing declaration for a_frs1516_test_item.pmuibhd;
         -- missing declaration for a_frs1516_test_item.pipmothd;
         -- missing declaration for a_frs1516_test_item.icapersp;
         -- missing declaration for a_frs1516_test_item.pmuibsp;
         -- missing declaration for a_frs1516_test_item.pipmotsp;
         -- missing declaration for a_frs1516_test_item.r1dlchd;
         -- missing declaration for a_frs1516_test_item.r1dlmhd;
         -- missing declaration for a_frs1516_test_item.r1aahd;
         -- missing declaration for a_frs1516_test_item.r1hbhd;
         -- missing declaration for a_frs1516_test_item.r1pipdhd;
         -- missing declaration for a_frs1516_test_item.r1pipmhd;
         -- missing declaration for a_frs1516_test_item.r1dlcsp;
         -- missing declaration for a_frs1516_test_item.r1dlmsp;
         -- missing declaration for a_frs1516_test_item.r1aasp;
         -- missing declaration for a_frs1516_test_item.r1hbsp;
         -- missing declaration for a_frs1516_test_item.r1pipdsp;
         -- missing declaration for a_frs1516_test_item.r1pipmsp;
         -- missing declaration for a_frs1516_test_item.r2dlchd;
         -- missing declaration for a_frs1516_test_item.r2dlmhd;
         -- missing declaration for a_frs1516_test_item.r2aahd;
         -- missing declaration for a_frs1516_test_item.r2hbhd;
         -- missing declaration for a_frs1516_test_item.r2pipdhd;
         -- missing declaration for a_frs1516_test_item.r2pipmhd;
         -- missing declaration for a_frs1516_test_item.r2dlcsp;
         -- missing declaration for a_frs1516_test_item.r2dlmsp;
         -- missing declaration for a_frs1516_test_item.r2aasp;
         -- missing declaration for a_frs1516_test_item.r2hbsp;
         -- missing declaration for a_frs1516_test_item.r2pipdsp;
         -- missing declaration for a_frs1516_test_item.r2pipmsp;
         -- missing declaration for a_frs1516_test_item.r3dlchd;
         -- missing declaration for a_frs1516_test_item.r3dlmhd;
         -- missing declaration for a_frs1516_test_item.r3aahd;
         -- missing declaration for a_frs1516_test_item.r3hbhd;
         -- missing declaration for a_frs1516_test_item.r3pipdhd;
         -- missing declaration for a_frs1516_test_item.r3pipmhd;
         -- missing declaration for a_frs1516_test_item.r3dlcsp;
         -- missing declaration for a_frs1516_test_item.r3dlmsp;
         -- missing declaration for a_frs1516_test_item.r3aasp;
         -- missing declaration for a_frs1516_test_item.r3hbsp;
         -- missing declaration for a_frs1516_test_item.r3pipdsp;
         -- missing declaration for a_frs1516_test_item.r3pipmsp;
         -- missing declaration for a_frs1516_test_item.r4dlchd;
         -- missing declaration for a_frs1516_test_item.r4dlmhd;
         -- missing declaration for a_frs1516_test_item.r4aahd;
         -- missing declaration for a_frs1516_test_item.r4hbhd;
         -- missing declaration for a_frs1516_test_item.r4pipdhd;
         -- missing declaration for a_frs1516_test_item.r4pipmhd;
         -- missing declaration for a_frs1516_test_item.r4dlcsp;
         -- missing declaration for a_frs1516_test_item.r4dlmsp;
         -- missing declaration for a_frs1516_test_item.r4aasp;
         -- missing declaration for a_frs1516_test_item.r4hbsp;
         -- missing declaration for a_frs1516_test_item.r4pipdsp;
         -- missing declaration for a_frs1516_test_item.r4pipmsp;
         -- missing declaration for a_frs1516_test_item.r5dlchd;
         -- missing declaration for a_frs1516_test_item.r5dlmhd;
         -- missing declaration for a_frs1516_test_item.r5aahd;
         -- missing declaration for a_frs1516_test_item.r5hbhd;
         -- missing declaration for a_frs1516_test_item.r5pipdhd;
         -- missing declaration for a_frs1516_test_item.r5pipmhd;
         -- missing declaration for a_frs1516_test_item.r5dlcsp;
         -- missing declaration for a_frs1516_test_item.r5dlmsp;
         -- missing declaration for a_frs1516_test_item.r5aasp;
         -- missing declaration for a_frs1516_test_item.r5hbsp;
         -- missing declaration for a_frs1516_test_item.r5pipdsp;
         -- missing declaration for a_frs1516_test_item.r5pipmsp;
         -- missing declaration for a_frs1516_test_item.stdlacc1;
         -- missing declaration for a_frs1516_test_item.stdlamc1;
         -- missing declaration for a_frs1516_test_item.stdlacc2;
         -- missing declaration for a_frs1516_test_item.stdlamc2;
         -- missing declaration for a_frs1516_test_item.stdlacc3;
         -- missing declaration for a_frs1516_test_item.stdlamc3;
         -- missing declaration for a_frs1516_test_item.stdlacc4;
         -- missing declaration for a_frs1516_test_item.stdlamc4;
         -- missing declaration for a_frs1516_test_item.stdlacc5;
         -- missing declaration for a_frs1516_test_item.stdlamc5;
         -- missing declaration for a_frs1516_test_item.stdlacc6;
         -- missing declaration for a_frs1516_test_item.stdlamc6;
         -- missing declaration for a_frs1516_test_item.stdlacc7;
         -- missing declaration for a_frs1516_test_item.stdlamc7;
         -- missing declaration for a_frs1516_test_item.stdlacc8;
         -- missing declaration for a_frs1516_test_item.stdlamc8;
         -- missing declaration for a_frs1516_test_item.stdlacc9;
         -- missing declaration for a_frs1516_test_item.stdlamc9;
         a_frs1516_test_item.dlacac1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.dlamoc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.dlacac2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.dlamoc2 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dlacac3;
         -- missing declaration for a_frs1516_test_item.dlamoc3;
         -- missing declaration for a_frs1516_test_item.dlacac4;
         -- missing declaration for a_frs1516_test_item.dlamoc4;
         -- missing declaration for a_frs1516_test_item.dlacac5;
         -- missing declaration for a_frs1516_test_item.dlamoc5;
         -- missing declaration for a_frs1516_test_item.dlacac6;
         -- missing declaration for a_frs1516_test_item.dlamoc6;
         -- missing declaration for a_frs1516_test_item.dlacac7;
         -- missing declaration for a_frs1516_test_item.dlamoc7;
         -- missing declaration for a_frs1516_test_item.dlacac8;
         -- missing declaration for a_frs1516_test_item.dlamoc8;
         -- missing declaration for a_frs1516_test_item.dlacac9;
         -- missing declaration for a_frs1516_test_item.dlamoc9;
         -- missing declaration for a_frs1516_test_item.ltdlacc1;
         -- missing declaration for a_frs1516_test_item.ltdlamc1;
         -- missing declaration for a_frs1516_test_item.ltdlacc2;
         -- missing declaration for a_frs1516_test_item.ltdlamc2;
         -- missing declaration for a_frs1516_test_item.ltdlacc3;
         -- missing declaration for a_frs1516_test_item.ltdlamc3;
         -- missing declaration for a_frs1516_test_item.ltdlacc4;
         -- missing declaration for a_frs1516_test_item.ltdlamc4;
         -- missing declaration for a_frs1516_test_item.ltdlacc5;
         -- missing declaration for a_frs1516_test_item.ltdlamc5;
         -- missing declaration for a_frs1516_test_item.ltdlacc6;
         -- missing declaration for a_frs1516_test_item.ltdlamc6;
         -- missing declaration for a_frs1516_test_item.ltdlacc7;
         -- missing declaration for a_frs1516_test_item.ltdlamc7;
         -- missing declaration for a_frs1516_test_item.ltdlacc8;
         -- missing declaration for a_frs1516_test_item.ltdlamc8;
         -- missing declaration for a_frs1516_test_item.ltdlacc9;
         -- missing declaration for a_frs1516_test_item.ltdlamc9;
         -- missing declaration for a_frs1516_test_item.pdlacac1;
         -- missing declaration for a_frs1516_test_item.pdlamoc1;
         -- missing declaration for a_frs1516_test_item.pdlacac2;
         -- missing declaration for a_frs1516_test_item.pdlamoc2;
         -- missing declaration for a_frs1516_test_item.pdlacac3;
         -- missing declaration for a_frs1516_test_item.pdlamoc3;
         -- missing declaration for a_frs1516_test_item.pdlacac4;
         -- missing declaration for a_frs1516_test_item.pdlamoc4;
         -- missing declaration for a_frs1516_test_item.pdlacac5;
         -- missing declaration for a_frs1516_test_item.pdlamoc5;
         -- missing declaration for a_frs1516_test_item.pdlacac6;
         -- missing declaration for a_frs1516_test_item.pdlamoc6;
         -- missing declaration for a_frs1516_test_item.pdlacac7;
         -- missing declaration for a_frs1516_test_item.pdlamoc7;
         -- missing declaration for a_frs1516_test_item.pdlacac8;
         -- missing declaration for a_frs1516_test_item.pdlamoc8;
         -- missing declaration for a_frs1516_test_item.pdlacac9;
         -- missing declaration for a_frs1516_test_item.pdlamoc9;
         -- missing declaration for a_frs1516_test_item.dcpayc1;
         -- missing declaration for a_frs1516_test_item.dmpayc1;
         -- missing declaration for a_frs1516_test_item.dcpayc2;
         -- missing declaration for a_frs1516_test_item.dmpayc2;
         -- missing declaration for a_frs1516_test_item.dcpayc3;
         -- missing declaration for a_frs1516_test_item.dmpayc3;
         -- missing declaration for a_frs1516_test_item.dcpayc4;
         -- missing declaration for a_frs1516_test_item.dmpayc4;
         -- missing declaration for a_frs1516_test_item.dcpayc5;
         -- missing declaration for a_frs1516_test_item.dmpayc5;
         -- missing declaration for a_frs1516_test_item.dcpayc6;
         -- missing declaration for a_frs1516_test_item.dmpayc6;
         -- missing declaration for a_frs1516_test_item.dcpayc7;
         -- missing declaration for a_frs1516_test_item.dmpayc7;
         -- missing declaration for a_frs1516_test_item.dcpayc8;
         -- missing declaration for a_frs1516_test_item.dmpayc8;
         -- missing declaration for a_frs1516_test_item.dcpayc9;
         -- missing declaration for a_frs1516_test_item.dmpayc9;
         -- missing declaration for a_frs1516_test_item.r1dlcc1;
         -- missing declaration for a_frs1516_test_item.r1dlmc1;
         -- missing declaration for a_frs1516_test_item.r1dlcc2;
         -- missing declaration for a_frs1516_test_item.r1dlmc2;
         -- missing declaration for a_frs1516_test_item.r1dlcc3;
         -- missing declaration for a_frs1516_test_item.r1dlmc3;
         -- missing declaration for a_frs1516_test_item.r1dlcc4;
         -- missing declaration for a_frs1516_test_item.r1dlmc4;
         -- missing declaration for a_frs1516_test_item.r1dlcc5;
         -- missing declaration for a_frs1516_test_item.r1dlmc5;
         -- missing declaration for a_frs1516_test_item.r1dlcc6;
         -- missing declaration for a_frs1516_test_item.r1dlmc6;
         -- missing declaration for a_frs1516_test_item.r1dlcc7;
         -- missing declaration for a_frs1516_test_item.r1dlmc7;
         -- missing declaration for a_frs1516_test_item.r1dlcc8;
         -- missing declaration for a_frs1516_test_item.r1dlmc8;
         -- missing declaration for a_frs1516_test_item.r1dlcc9;
         -- missing declaration for a_frs1516_test_item.r1dlmc9;
         -- missing declaration for a_frs1516_test_item.r2dlcc1;
         -- missing declaration for a_frs1516_test_item.r2dlmc1;
         -- missing declaration for a_frs1516_test_item.r2dlcc2;
         -- missing declaration for a_frs1516_test_item.r2dlmc2;
         -- missing declaration for a_frs1516_test_item.r2dlcc3;
         -- missing declaration for a_frs1516_test_item.r2dlmc3;
         -- missing declaration for a_frs1516_test_item.r2dlcc4;
         -- missing declaration for a_frs1516_test_item.r2dlmc4;
         -- missing declaration for a_frs1516_test_item.r2dlcc5;
         -- missing declaration for a_frs1516_test_item.r2dlmc5;
         -- missing declaration for a_frs1516_test_item.r2dlcc6;
         -- missing declaration for a_frs1516_test_item.r2dlmc6;
         -- missing declaration for a_frs1516_test_item.r2dlcc7;
         -- missing declaration for a_frs1516_test_item.r2dlmc7;
         -- missing declaration for a_frs1516_test_item.r2dlcc8;
         -- missing declaration for a_frs1516_test_item.r2dlmc8;
         -- missing declaration for a_frs1516_test_item.r2dlcc9;
         -- missing declaration for a_frs1516_test_item.r2dlmc9;
         -- missing declaration for a_frs1516_test_item.r3dlcc1;
         -- missing declaration for a_frs1516_test_item.r3dlmc1;
         -- missing declaration for a_frs1516_test_item.r3dlcc2;
         -- missing declaration for a_frs1516_test_item.r3dlmc2;
         -- missing declaration for a_frs1516_test_item.r3dlcc3;
         -- missing declaration for a_frs1516_test_item.r3dlmc3;
         -- missing declaration for a_frs1516_test_item.r3dlcc4;
         -- missing declaration for a_frs1516_test_item.r3dlmc4;
         -- missing declaration for a_frs1516_test_item.r3dlcc5;
         -- missing declaration for a_frs1516_test_item.r3dlmc5;
         -- missing declaration for a_frs1516_test_item.r3dlcc6;
         -- missing declaration for a_frs1516_test_item.r3dlmc6;
         -- missing declaration for a_frs1516_test_item.r3dlcc7;
         -- missing declaration for a_frs1516_test_item.r3dlmc7;
         -- missing declaration for a_frs1516_test_item.r3dlcc8;
         -- missing declaration for a_frs1516_test_item.r3dlmc8;
         -- missing declaration for a_frs1516_test_item.r3dlcc9;
         -- missing declaration for a_frs1516_test_item.r3dlmc9;
         -- missing declaration for a_frs1516_test_item.r4dlcc1;
         -- missing declaration for a_frs1516_test_item.r4dlmc1;
         -- missing declaration for a_frs1516_test_item.r4dlcc2;
         -- missing declaration for a_frs1516_test_item.r4dlmc2;
         -- missing declaration for a_frs1516_test_item.r4dlcc3;
         -- missing declaration for a_frs1516_test_item.r4dlmc3;
         -- missing declaration for a_frs1516_test_item.r4dlcc4;
         -- missing declaration for a_frs1516_test_item.r4dlmc4;
         -- missing declaration for a_frs1516_test_item.r4dlcc5;
         -- missing declaration for a_frs1516_test_item.r4dlmc5;
         -- missing declaration for a_frs1516_test_item.r4dlcc6;
         -- missing declaration for a_frs1516_test_item.r4dlmc6;
         -- missing declaration for a_frs1516_test_item.r4dlcc7;
         -- missing declaration for a_frs1516_test_item.r4dlmc7;
         -- missing declaration for a_frs1516_test_item.r4dlcc8;
         -- missing declaration for a_frs1516_test_item.r4dlmc8;
         -- missing declaration for a_frs1516_test_item.r4dlcc9;
         -- missing declaration for a_frs1516_test_item.r4dlmc9;
         -- missing declaration for a_frs1516_test_item.r5dlcc1;
         -- missing declaration for a_frs1516_test_item.r5dlmc1;
         -- missing declaration for a_frs1516_test_item.r5dlcc2;
         -- missing declaration for a_frs1516_test_item.r5dlmc2;
         -- missing declaration for a_frs1516_test_item.r5dlcc3;
         -- missing declaration for a_frs1516_test_item.r5dlmc3;
         -- missing declaration for a_frs1516_test_item.r5dlcc4;
         -- missing declaration for a_frs1516_test_item.r5dlmc4;
         -- missing declaration for a_frs1516_test_item.r5dlcc5;
         -- missing declaration for a_frs1516_test_item.r5dlmc5;
         -- missing declaration for a_frs1516_test_item.r5dlcc6;
         -- missing declaration for a_frs1516_test_item.r5dlmc6;
         -- missing declaration for a_frs1516_test_item.r5dlcc7;
         -- missing declaration for a_frs1516_test_item.r5dlmc7;
         -- missing declaration for a_frs1516_test_item.r5dlcc8;
         -- missing declaration for a_frs1516_test_item.r5dlmc8;
         -- missing declaration for a_frs1516_test_item.r5dlcc9;
         -- missing declaration for a_frs1516_test_item.r5dlmc9;
         -- missing declaration for a_frs1516_test_item.adbtbl;
         -- missing declaration for a_frs1516_test_item.adddec;
         -- missing declaration for a_frs1516_test_item.addhol;
         -- missing declaration for a_frs1516_test_item.addholr;
         -- missing declaration for a_frs1516_test_item.addins;
         -- missing declaration for a_frs1516_test_item.addmon;
         -- missing declaration for a_frs1516_test_item.adepfur;
         -- missing declaration for a_frs1516_test_item.adles;
         -- missing declaration for a_frs1516_test_item.adlesoa;
         -- missing declaration for a_frs1516_test_item.af1;
         -- missing declaration for a_frs1516_test_item.afdep2;
         -- missing declaration for a_frs1516_test_item.cdelply;
         -- missing declaration for a_frs1516_test_item.cdepact;
         -- missing declaration for a_frs1516_test_item.cdepbed;
         -- missing declaration for a_frs1516_test_item.cdepcel;
         -- missing declaration for a_frs1516_test_item.cdepeqp;
         -- missing declaration for a_frs1516_test_item.cdephol;
         -- missing declaration for a_frs1516_test_item.cdeples;
         -- missing declaration for a_frs1516_test_item.cdeptea;
         -- missing declaration for a_frs1516_test_item.cdeptrp;
         -- missing declaration for a_frs1516_test_item.cdepveg;
         -- missing declaration for a_frs1516_test_item.cdpcoat;
         -- missing declaration for a_frs1516_test_item.clothes;
         -- missing declaration for a_frs1516_test_item.cplay;
         -- missing declaration for a_frs1516_test_item.debt10;
         -- missing declaration for a_frs1516_test_item.debt11;
         -- missing declaration for a_frs1516_test_item.debt12;
         -- missing declaration for a_frs1516_test_item.debt13;
         -- missing declaration for a_frs1516_test_item.debtar01;
         -- missing declaration for a_frs1516_test_item.debtar02;
         -- missing declaration for a_frs1516_test_item.debtar03;
         -- missing declaration for a_frs1516_test_item.debtar04;
         -- missing declaration for a_frs1516_test_item.debtar05;
         -- missing declaration for a_frs1516_test_item.debtar06;
         -- missing declaration for a_frs1516_test_item.debtar07;
         -- missing declaration for a_frs1516_test_item.debtar08;
         -- missing declaration for a_frs1516_test_item.debtar09;
         -- missing declaration for a_frs1516_test_item.debtar10;
         -- missing declaration for a_frs1516_test_item.debtar11;
         -- missing declaration for a_frs1516_test_item.debtar12;
         -- missing declaration for a_frs1516_test_item.debtar13;
         -- missing declaration for a_frs1516_test_item.debtfre1;
         -- missing declaration for a_frs1516_test_item.debtfre2;
         -- missing declaration for a_frs1516_test_item.debtfre3;
         -- missing declaration for a_frs1516_test_item.hbolng;
         -- missing declaration for a_frs1516_test_item.houshe1;
         -- missing declaration for a_frs1516_test_item.kidinc;
         -- missing declaration for a_frs1516_test_item.meal;
         -- missing declaration for a_frs1516_test_item.nhhchild;
         -- missing declaration for a_frs1516_test_item.oafur;
         -- missing declaration for a_frs1516_test_item.oapre;
         -- missing declaration for a_frs1516_test_item.outpay;
         a_frs1516_test_item.outpyamt := 1010100.012 + Amount( i );
         a_frs1516_test_item.regpamt := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.regularp;
         -- missing declaration for a_frs1516_test_item.shoeoa;
         -- missing declaration for a_frs1516_test_item.totsav;
         -- missing declaration for a_frs1516_test_item.adultb;
         a_frs1516_test_item.boarder := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.bpeninc;
         -- missing declaration for a_frs1516_test_item.bseinc;
         -- missing declaration for a_frs1516_test_item.budisben;
         -- missing declaration for a_frs1516_test_item.buearns;
         -- missing declaration for a_frs1516_test_item.buethgr3;
         -- missing declaration for a_frs1516_test_item.buinc;
         -- missing declaration for a_frs1516_test_item.buinv;
         -- missing declaration for a_frs1516_test_item.buirben;
         -- missing declaration for a_frs1516_test_item.bukids;
         -- missing declaration for a_frs1516_test_item.bunirben;
         -- missing declaration for a_frs1516_test_item.buothben;
         -- missing declaration for a_frs1516_test_item.burent;
         -- missing declaration for a_frs1516_test_item.burinc;
         -- missing declaration for a_frs1516_test_item.burpinc;
         a_frs1516_test_item.butvlic := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.butxcred;
         -- missing declaration for a_frs1516_test_item.depchldb;
         -- missing declaration for a_frs1516_test_item.diswbua1;
         -- missing declaration for a_frs1516_test_item.diswbuc1;
         -- missing declaration for a_frs1516_test_item.ecstatbu;
         -- missing declaration for a_frs1516_test_item.famtypb2;
         -- missing declaration for a_frs1516_test_item.famtypbs;
         -- missing declaration for a_frs1516_test_item.famtypbu;
         a_frs1516_test_item.fsfvbu := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsmbu := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsmlkbu := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.gross4;
         -- missing declaration for a_frs1516_test_item.hbindbu;
         -- missing declaration for a_frs1516_test_item.hbindbu2;
         a_frs1516_test_item.heartbu := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.kid04;
         -- missing declaration for a_frs1516_test_item.kid1115;
         -- missing declaration for a_frs1516_test_item.kid1619;
         -- missing declaration for a_frs1516_test_item.kid510;
         a_frs1516_test_item.lodger := 1010100.012 + Amount( i );
         a_frs1516_test_item.subltamt := 1010100.012 + Amount( i );
         a_frs1516_test_item.totcapb3 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.totsavbu;
         -- missing declaration for a_frs1516_test_item.tuburent;
         -- missing declaration for a_frs1516_test_item.youngch;
         -- missing declaration for a_frs1516_test_item.clthsoa;
         -- missing declaration for a_frs1516_test_item.debt1;
         -- missing declaration for a_frs1516_test_item.debt2;
         -- missing declaration for a_frs1516_test_item.debt3;
         -- missing declaration for a_frs1516_test_item.debt4;
         -- missing declaration for a_frs1516_test_item.debt5;
         -- missing declaration for a_frs1516_test_item.debt6;
         -- missing declaration for a_frs1516_test_item.debt7;
         -- missing declaration for a_frs1516_test_item.debt8;
         -- missing declaration for a_frs1516_test_item.debt9;
         -- missing declaration for a_frs1516_test_item.discbua;
         -- missing declaration for a_frs1516_test_item.discbuc;
         a_frs1516_test_item.hbtham := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.hbthbu;
         -- missing declaration for a_frs1516_test_item.hbthmn;
         -- missing declaration for a_frs1516_test_item.hbthpd;
         -- missing declaration for a_frs1516_test_item.hbthwk;
         -- missing declaration for a_frs1516_test_item.hbthyr;
         -- missing declaration for a_frs1516_test_item.hbwait;
         -- missing declaration for a_frs1516_test_item.intrnt;
         -- missing declaration for a_frs1516_test_item.oadep;
         -- missing declaration for a_frs1516_test_item.oanet;
         -- missing declaration for a_frs1516_test_item.dynhthd;
         -- missing declaration for a_frs1516_test_item.dynhtsp;
         -- missing declaration for a_frs1516_test_item.freqhd;
         -- missing declaration for a_frs1516_test_item.freqsp;
         -- missing declaration for a_frs1516_test_item.hur01hd;
         -- missing declaration for a_frs1516_test_item.hur01sp;
         -- missing declaration for a_frs1516_test_item.hur02hd;
         -- missing declaration for a_frs1516_test_item.hur02sp;
         -- missing declaration for a_frs1516_test_item.hur03hd;
         -- missing declaration for a_frs1516_test_item.hur03sp;
         -- missing declaration for a_frs1516_test_item.hur04hd;
         -- missing declaration for a_frs1516_test_item.hur04sp;
         -- missing declaration for a_frs1516_test_item.hur05hd;
         -- missing declaration for a_frs1516_test_item.hur05sp;
         -- missing declaration for a_frs1516_test_item.hur06hd;
         -- missing declaration for a_frs1516_test_item.hur06sp;
         -- missing declaration for a_frs1516_test_item.hur07hd;
         -- missing declaration for a_frs1516_test_item.hur07sp;
         -- missing declaration for a_frs1516_test_item.hur08hd;
         -- missing declaration for a_frs1516_test_item.hur08sp;
         -- missing declaration for a_frs1516_test_item.hur09hd;
         -- missing declaration for a_frs1516_test_item.hur09sp;
         -- missing declaration for a_frs1516_test_item.hur10hd;
         -- missing declaration for a_frs1516_test_item.hur10sp;
         -- missing declaration for a_frs1516_test_item.hur11hd;
         -- missing declaration for a_frs1516_test_item.hur11sp;
         -- missing declaration for a_frs1516_test_item.hur12hd;
         -- missing declaration for a_frs1516_test_item.hur12sp;
         -- missing declaration for a_frs1516_test_item.hur13hd;
         -- missing declaration for a_frs1516_test_item.hur13sp;
         -- missing declaration for a_frs1516_test_item.hur14hd;
         -- missing declaration for a_frs1516_test_item.hur14sp;
         -- missing declaration for a_frs1516_test_item.hur15hd;
         -- missing declaration for a_frs1516_test_item.hur15sp;
         -- missing declaration for a_frs1516_test_item.hur16hd;
         -- missing declaration for a_frs1516_test_item.hur16sp;
         -- missing declaration for a_frs1516_test_item.hur17hd;
         -- missing declaration for a_frs1516_test_item.hur17sp;
         -- missing declaration for a_frs1516_test_item.hur18hd;
         -- missing declaration for a_frs1516_test_item.hur18sp;
         -- missing declaration for a_frs1516_test_item.hur19hd;
         -- missing declaration for a_frs1516_test_item.hur19sp;
         -- missing declaration for a_frs1516_test_item.hur20hd;
         -- missing declaration for a_frs1516_test_item.hur20sp;
         -- missing declaration for a_frs1516_test_item.whl01hd;
         -- missing declaration for a_frs1516_test_item.whl01sp;
         -- missing declaration for a_frs1516_test_item.whl02hd;
         -- missing declaration for a_frs1516_test_item.whl02sp;
         -- missing declaration for a_frs1516_test_item.whl03hd;
         -- missing declaration for a_frs1516_test_item.whl03sp;
         -- missing declaration for a_frs1516_test_item.whl04hd;
         -- missing declaration for a_frs1516_test_item.whl04sp;
         -- missing declaration for a_frs1516_test_item.whl05hd;
         -- missing declaration for a_frs1516_test_item.whl05sp;
         -- missing declaration for a_frs1516_test_item.whl06hd;
         -- missing declaration for a_frs1516_test_item.whl06sp;
         -- missing declaration for a_frs1516_test_item.whl07hd;
         -- missing declaration for a_frs1516_test_item.whl07sp;
         -- missing declaration for a_frs1516_test_item.whl08hd;
         -- missing declaration for a_frs1516_test_item.whl08sp;
         -- missing declaration for a_frs1516_test_item.whl09hd;
         -- missing declaration for a_frs1516_test_item.whl09sp;
         -- missing declaration for a_frs1516_test_item.whl10hd;
         -- missing declaration for a_frs1516_test_item.whl10sp;
         -- missing declaration for a_frs1516_test_item.whl11hd;
         -- missing declaration for a_frs1516_test_item.whl11sp;
         -- missing declaration for a_frs1516_test_item.whl12hd;
         -- missing declaration for a_frs1516_test_item.whl12sp;
         -- missing declaration for a_frs1516_test_item.whl13hd;
         -- missing declaration for a_frs1516_test_item.whl13sp;
         -- missing declaration for a_frs1516_test_item.whl14hd;
         -- missing declaration for a_frs1516_test_item.whl14sp;
         -- missing declaration for a_frs1516_test_item.whl15hd;
         -- missing declaration for a_frs1516_test_item.whl15sp;
         -- missing declaration for a_frs1516_test_item.whl16hd;
         -- missing declaration for a_frs1516_test_item.whl16sp;
         -- missing declaration for a_frs1516_test_item.whl17hd;
         -- missing declaration for a_frs1516_test_item.whl17sp;
         -- missing declaration for a_frs1516_test_item.whl18hd;
         -- missing declaration for a_frs1516_test_item.whl18sp;
         -- missing declaration for a_frs1516_test_item.whl19hd;
         -- missing declaration for a_frs1516_test_item.whl19sp;
         -- missing declaration for a_frs1516_test_item.whl20hd;
         -- missing declaration for a_frs1516_test_item.whl20sp;
         -- missing declaration for a_frs1516_test_item.dynhtc1;
         -- missing declaration for a_frs1516_test_item.dynhtc2;
         -- missing declaration for a_frs1516_test_item.dynhtc3;
         -- missing declaration for a_frs1516_test_item.dynhtc4;
         -- missing declaration for a_frs1516_test_item.dynhtc5;
         -- missing declaration for a_frs1516_test_item.dynhtc6;
         -- missing declaration for a_frs1516_test_item.dynhtc7;
         -- missing declaration for a_frs1516_test_item.dynhtc8;
         -- missing declaration for a_frs1516_test_item.dynhtc9;
         -- missing declaration for a_frs1516_test_item.freqc1;
         -- missing declaration for a_frs1516_test_item.freqc2;
         -- missing declaration for a_frs1516_test_item.freqc3;
         -- missing declaration for a_frs1516_test_item.freqc4;
         -- missing declaration for a_frs1516_test_item.freqc5;
         -- missing declaration for a_frs1516_test_item.freqc6;
         -- missing declaration for a_frs1516_test_item.freqc7;
         -- missing declaration for a_frs1516_test_item.freqc8;
         -- missing declaration for a_frs1516_test_item.freqc9;
         -- missing declaration for a_frs1516_test_item.hur01c1;
         -- missing declaration for a_frs1516_test_item.hur01c2;
         -- missing declaration for a_frs1516_test_item.hur01c3;
         -- missing declaration for a_frs1516_test_item.hur01c4;
         -- missing declaration for a_frs1516_test_item.hur01c5;
         -- missing declaration for a_frs1516_test_item.hur01c6;
         -- missing declaration for a_frs1516_test_item.hur01c7;
         -- missing declaration for a_frs1516_test_item.hur01c8;
         -- missing declaration for a_frs1516_test_item.hur01c9;
         -- missing declaration for a_frs1516_test_item.hur02c1;
         -- missing declaration for a_frs1516_test_item.hur02c2;
         -- missing declaration for a_frs1516_test_item.hur02c3;
         -- missing declaration for a_frs1516_test_item.hur02c4;
         -- missing declaration for a_frs1516_test_item.hur02c5;
         -- missing declaration for a_frs1516_test_item.hur02c6;
         -- missing declaration for a_frs1516_test_item.hur02c7;
         -- missing declaration for a_frs1516_test_item.hur02c8;
         -- missing declaration for a_frs1516_test_item.hur02c9;
         -- missing declaration for a_frs1516_test_item.hur03c1;
         -- missing declaration for a_frs1516_test_item.hur03c2;
         -- missing declaration for a_frs1516_test_item.hur03c3;
         -- missing declaration for a_frs1516_test_item.hur03c4;
         -- missing declaration for a_frs1516_test_item.hur03c5;
         -- missing declaration for a_frs1516_test_item.hur03c6;
         -- missing declaration for a_frs1516_test_item.hur03c7;
         -- missing declaration for a_frs1516_test_item.hur03c8;
         -- missing declaration for a_frs1516_test_item.hur03c9;
         -- missing declaration for a_frs1516_test_item.hur04c1;
         -- missing declaration for a_frs1516_test_item.hur04c2;
         -- missing declaration for a_frs1516_test_item.hur04c3;
         -- missing declaration for a_frs1516_test_item.hur04c4;
         -- missing declaration for a_frs1516_test_item.hur04c5;
         -- missing declaration for a_frs1516_test_item.hur04c6;
         -- missing declaration for a_frs1516_test_item.hur04c7;
         -- missing declaration for a_frs1516_test_item.hur04c8;
         -- missing declaration for a_frs1516_test_item.hur04c9;
         -- missing declaration for a_frs1516_test_item.hur05c1;
         -- missing declaration for a_frs1516_test_item.hur05c2;
         -- missing declaration for a_frs1516_test_item.hur05c3;
         -- missing declaration for a_frs1516_test_item.hur05c4;
         -- missing declaration for a_frs1516_test_item.hur05c5;
         -- missing declaration for a_frs1516_test_item.hur05c6;
         -- missing declaration for a_frs1516_test_item.hur05c7;
         -- missing declaration for a_frs1516_test_item.hur05c8;
         -- missing declaration for a_frs1516_test_item.hur05c9;
         -- missing declaration for a_frs1516_test_item.hur06c1;
         -- missing declaration for a_frs1516_test_item.hur06c2;
         -- missing declaration for a_frs1516_test_item.hur06c3;
         -- missing declaration for a_frs1516_test_item.hur06c4;
         -- missing declaration for a_frs1516_test_item.hur06c5;
         -- missing declaration for a_frs1516_test_item.hur06c6;
         -- missing declaration for a_frs1516_test_item.hur06c7;
         -- missing declaration for a_frs1516_test_item.hur06c8;
         -- missing declaration for a_frs1516_test_item.hur06c9;
         -- missing declaration for a_frs1516_test_item.hur07c1;
         -- missing declaration for a_frs1516_test_item.hur07c2;
         -- missing declaration for a_frs1516_test_item.hur07c3;
         -- missing declaration for a_frs1516_test_item.hur07c4;
         -- missing declaration for a_frs1516_test_item.hur07c5;
         -- missing declaration for a_frs1516_test_item.hur07c6;
         -- missing declaration for a_frs1516_test_item.hur07c7;
         -- missing declaration for a_frs1516_test_item.hur07c8;
         -- missing declaration for a_frs1516_test_item.hur07c9;
         -- missing declaration for a_frs1516_test_item.hur08c1;
         -- missing declaration for a_frs1516_test_item.hur08c2;
         -- missing declaration for a_frs1516_test_item.hur08c3;
         -- missing declaration for a_frs1516_test_item.hur08c4;
         -- missing declaration for a_frs1516_test_item.hur08c5;
         -- missing declaration for a_frs1516_test_item.hur08c6;
         -- missing declaration for a_frs1516_test_item.hur08c7;
         -- missing declaration for a_frs1516_test_item.hur08c8;
         -- missing declaration for a_frs1516_test_item.hur08c9;
         -- missing declaration for a_frs1516_test_item.hur09c1;
         -- missing declaration for a_frs1516_test_item.hur09c2;
         -- missing declaration for a_frs1516_test_item.hur09c3;
         -- missing declaration for a_frs1516_test_item.hur09c4;
         -- missing declaration for a_frs1516_test_item.hur09c5;
         -- missing declaration for a_frs1516_test_item.hur09c6;
         -- missing declaration for a_frs1516_test_item.hur09c7;
         -- missing declaration for a_frs1516_test_item.hur09c8;
         -- missing declaration for a_frs1516_test_item.hur09c9;
         -- missing declaration for a_frs1516_test_item.hur10c1;
         -- missing declaration for a_frs1516_test_item.hur10c2;
         -- missing declaration for a_frs1516_test_item.hur10c3;
         -- missing declaration for a_frs1516_test_item.hur10c4;
         -- missing declaration for a_frs1516_test_item.hur10c5;
         -- missing declaration for a_frs1516_test_item.hur10c6;
         -- missing declaration for a_frs1516_test_item.hur10c7;
         -- missing declaration for a_frs1516_test_item.hur10c8;
         -- missing declaration for a_frs1516_test_item.hur10c9;
         -- missing declaration for a_frs1516_test_item.hur11c1;
         -- missing declaration for a_frs1516_test_item.hur11c2;
         -- missing declaration for a_frs1516_test_item.hur11c3;
         -- missing declaration for a_frs1516_test_item.hur11c4;
         -- missing declaration for a_frs1516_test_item.hur11c5;
         -- missing declaration for a_frs1516_test_item.hur11c6;
         -- missing declaration for a_frs1516_test_item.hur11c7;
         -- missing declaration for a_frs1516_test_item.hur11c8;
         -- missing declaration for a_frs1516_test_item.hur11c9;
         -- missing declaration for a_frs1516_test_item.hur12c1;
         -- missing declaration for a_frs1516_test_item.hur12c2;
         -- missing declaration for a_frs1516_test_item.hur12c3;
         -- missing declaration for a_frs1516_test_item.hur12c4;
         -- missing declaration for a_frs1516_test_item.hur12c5;
         -- missing declaration for a_frs1516_test_item.hur12c6;
         -- missing declaration for a_frs1516_test_item.hur12c7;
         -- missing declaration for a_frs1516_test_item.hur12c8;
         -- missing declaration for a_frs1516_test_item.hur12c9;
         -- missing declaration for a_frs1516_test_item.hur13c1;
         -- missing declaration for a_frs1516_test_item.hur13c2;
         -- missing declaration for a_frs1516_test_item.hur13c3;
         -- missing declaration for a_frs1516_test_item.hur13c4;
         -- missing declaration for a_frs1516_test_item.hur13c5;
         -- missing declaration for a_frs1516_test_item.hur13c6;
         -- missing declaration for a_frs1516_test_item.hur13c7;
         -- missing declaration for a_frs1516_test_item.hur13c8;
         -- missing declaration for a_frs1516_test_item.hur13c9;
         -- missing declaration for a_frs1516_test_item.hur14c1;
         -- missing declaration for a_frs1516_test_item.hur14c2;
         -- missing declaration for a_frs1516_test_item.hur14c3;
         -- missing declaration for a_frs1516_test_item.hur14c4;
         -- missing declaration for a_frs1516_test_item.hur14c5;
         -- missing declaration for a_frs1516_test_item.hur14c6;
         -- missing declaration for a_frs1516_test_item.hur14c7;
         -- missing declaration for a_frs1516_test_item.hur14c8;
         -- missing declaration for a_frs1516_test_item.hur14c9;
         -- missing declaration for a_frs1516_test_item.hur15c1;
         -- missing declaration for a_frs1516_test_item.hur15c2;
         -- missing declaration for a_frs1516_test_item.hur15c3;
         -- missing declaration for a_frs1516_test_item.hur15c4;
         -- missing declaration for a_frs1516_test_item.hur15c5;
         -- missing declaration for a_frs1516_test_item.hur15c6;
         -- missing declaration for a_frs1516_test_item.hur15c7;
         -- missing declaration for a_frs1516_test_item.hur15c8;
         -- missing declaration for a_frs1516_test_item.hur15c9;
         -- missing declaration for a_frs1516_test_item.hur16c1;
         -- missing declaration for a_frs1516_test_item.hur16c2;
         -- missing declaration for a_frs1516_test_item.hur16c3;
         -- missing declaration for a_frs1516_test_item.hur16c4;
         -- missing declaration for a_frs1516_test_item.hur16c5;
         -- missing declaration for a_frs1516_test_item.hur16c6;
         -- missing declaration for a_frs1516_test_item.hur16c7;
         -- missing declaration for a_frs1516_test_item.hur16c8;
         -- missing declaration for a_frs1516_test_item.hur16c9;
         -- missing declaration for a_frs1516_test_item.hur17c1;
         -- missing declaration for a_frs1516_test_item.hur17c2;
         -- missing declaration for a_frs1516_test_item.hur17c3;
         -- missing declaration for a_frs1516_test_item.hur17c4;
         -- missing declaration for a_frs1516_test_item.hur17c5;
         -- missing declaration for a_frs1516_test_item.hur17c6;
         -- missing declaration for a_frs1516_test_item.hur17c7;
         -- missing declaration for a_frs1516_test_item.hur17c8;
         -- missing declaration for a_frs1516_test_item.hur17c9;
         -- missing declaration for a_frs1516_test_item.hur18c1;
         -- missing declaration for a_frs1516_test_item.hur18c2;
         -- missing declaration for a_frs1516_test_item.hur18c3;
         -- missing declaration for a_frs1516_test_item.hur18c4;
         -- missing declaration for a_frs1516_test_item.hur18c5;
         -- missing declaration for a_frs1516_test_item.hur18c6;
         -- missing declaration for a_frs1516_test_item.hur18c7;
         -- missing declaration for a_frs1516_test_item.hur18c8;
         -- missing declaration for a_frs1516_test_item.hur18c9;
         -- missing declaration for a_frs1516_test_item.hur19c1;
         -- missing declaration for a_frs1516_test_item.hur19c2;
         -- missing declaration for a_frs1516_test_item.hur19c3;
         -- missing declaration for a_frs1516_test_item.hur19c4;
         -- missing declaration for a_frs1516_test_item.hur19c5;
         -- missing declaration for a_frs1516_test_item.hur19c6;
         -- missing declaration for a_frs1516_test_item.hur19c7;
         -- missing declaration for a_frs1516_test_item.hur19c8;
         -- missing declaration for a_frs1516_test_item.hur19c9;
         -- missing declaration for a_frs1516_test_item.hur20c1;
         -- missing declaration for a_frs1516_test_item.hur20c2;
         -- missing declaration for a_frs1516_test_item.hur20c3;
         -- missing declaration for a_frs1516_test_item.hur20c4;
         -- missing declaration for a_frs1516_test_item.hur20c5;
         -- missing declaration for a_frs1516_test_item.hur20c6;
         -- missing declaration for a_frs1516_test_item.hur20c7;
         -- missing declaration for a_frs1516_test_item.hur20c8;
         -- missing declaration for a_frs1516_test_item.hur20c9;
         -- missing declaration for a_frs1516_test_item.whl01c1;
         -- missing declaration for a_frs1516_test_item.whl01c2;
         -- missing declaration for a_frs1516_test_item.whl01c3;
         -- missing declaration for a_frs1516_test_item.whl01c4;
         -- missing declaration for a_frs1516_test_item.whl01c5;
         -- missing declaration for a_frs1516_test_item.whl01c6;
         -- missing declaration for a_frs1516_test_item.whl01c7;
         -- missing declaration for a_frs1516_test_item.whl01c8;
         -- missing declaration for a_frs1516_test_item.whl01c9;
         -- missing declaration for a_frs1516_test_item.whl02c1;
         -- missing declaration for a_frs1516_test_item.whl02c2;
         -- missing declaration for a_frs1516_test_item.whl02c3;
         -- missing declaration for a_frs1516_test_item.whl02c4;
         -- missing declaration for a_frs1516_test_item.whl02c5;
         -- missing declaration for a_frs1516_test_item.whl02c6;
         -- missing declaration for a_frs1516_test_item.whl02c7;
         -- missing declaration for a_frs1516_test_item.whl02c8;
         -- missing declaration for a_frs1516_test_item.whl02c9;
         -- missing declaration for a_frs1516_test_item.whl03c1;
         -- missing declaration for a_frs1516_test_item.whl03c2;
         -- missing declaration for a_frs1516_test_item.whl03c3;
         -- missing declaration for a_frs1516_test_item.whl03c4;
         -- missing declaration for a_frs1516_test_item.whl03c5;
         -- missing declaration for a_frs1516_test_item.whl03c6;
         -- missing declaration for a_frs1516_test_item.whl03c7;
         -- missing declaration for a_frs1516_test_item.whl03c8;
         -- missing declaration for a_frs1516_test_item.whl03c9;
         -- missing declaration for a_frs1516_test_item.whl04c1;
         -- missing declaration for a_frs1516_test_item.whl04c2;
         -- missing declaration for a_frs1516_test_item.whl04c3;
         -- missing declaration for a_frs1516_test_item.whl04c4;
         -- missing declaration for a_frs1516_test_item.whl04c5;
         -- missing declaration for a_frs1516_test_item.whl04c6;
         -- missing declaration for a_frs1516_test_item.whl04c7;
         -- missing declaration for a_frs1516_test_item.whl04c8;
         -- missing declaration for a_frs1516_test_item.whl04c9;
         -- missing declaration for a_frs1516_test_item.whl05c1;
         -- missing declaration for a_frs1516_test_item.whl05c2;
         -- missing declaration for a_frs1516_test_item.whl05c3;
         -- missing declaration for a_frs1516_test_item.whl05c4;
         -- missing declaration for a_frs1516_test_item.whl05c5;
         -- missing declaration for a_frs1516_test_item.whl05c6;
         -- missing declaration for a_frs1516_test_item.whl05c7;
         -- missing declaration for a_frs1516_test_item.whl05c8;
         -- missing declaration for a_frs1516_test_item.whl05c9;
         -- missing declaration for a_frs1516_test_item.whl06c1;
         -- missing declaration for a_frs1516_test_item.whl06c2;
         -- missing declaration for a_frs1516_test_item.whl06c3;
         -- missing declaration for a_frs1516_test_item.whl06c4;
         -- missing declaration for a_frs1516_test_item.whl06c5;
         -- missing declaration for a_frs1516_test_item.whl06c6;
         -- missing declaration for a_frs1516_test_item.whl06c7;
         -- missing declaration for a_frs1516_test_item.whl06c8;
         -- missing declaration for a_frs1516_test_item.whl06c9;
         -- missing declaration for a_frs1516_test_item.whl07c1;
         -- missing declaration for a_frs1516_test_item.whl07c2;
         -- missing declaration for a_frs1516_test_item.whl07c3;
         -- missing declaration for a_frs1516_test_item.whl07c4;
         -- missing declaration for a_frs1516_test_item.whl07c5;
         -- missing declaration for a_frs1516_test_item.whl07c6;
         -- missing declaration for a_frs1516_test_item.whl07c7;
         -- missing declaration for a_frs1516_test_item.whl07c8;
         -- missing declaration for a_frs1516_test_item.whl07c9;
         -- missing declaration for a_frs1516_test_item.whl08c1;
         -- missing declaration for a_frs1516_test_item.whl08c2;
         -- missing declaration for a_frs1516_test_item.whl08c3;
         -- missing declaration for a_frs1516_test_item.whl08c4;
         -- missing declaration for a_frs1516_test_item.whl08c5;
         -- missing declaration for a_frs1516_test_item.whl08c6;
         -- missing declaration for a_frs1516_test_item.whl08c7;
         -- missing declaration for a_frs1516_test_item.whl08c8;
         -- missing declaration for a_frs1516_test_item.whl08c9;
         -- missing declaration for a_frs1516_test_item.whl09c1;
         -- missing declaration for a_frs1516_test_item.whl09c2;
         -- missing declaration for a_frs1516_test_item.whl09c3;
         -- missing declaration for a_frs1516_test_item.whl09c4;
         -- missing declaration for a_frs1516_test_item.whl09c5;
         -- missing declaration for a_frs1516_test_item.whl09c6;
         -- missing declaration for a_frs1516_test_item.whl09c7;
         -- missing declaration for a_frs1516_test_item.whl09c8;
         -- missing declaration for a_frs1516_test_item.whl09c9;
         -- missing declaration for a_frs1516_test_item.whl10c1;
         -- missing declaration for a_frs1516_test_item.whl10c2;
         -- missing declaration for a_frs1516_test_item.whl10c3;
         -- missing declaration for a_frs1516_test_item.whl10c4;
         -- missing declaration for a_frs1516_test_item.whl10c5;
         -- missing declaration for a_frs1516_test_item.whl10c6;
         -- missing declaration for a_frs1516_test_item.whl10c7;
         -- missing declaration for a_frs1516_test_item.whl10c8;
         -- missing declaration for a_frs1516_test_item.whl10c9;
         -- missing declaration for a_frs1516_test_item.whl11c1;
         -- missing declaration for a_frs1516_test_item.whl11c2;
         -- missing declaration for a_frs1516_test_item.whl11c3;
         -- missing declaration for a_frs1516_test_item.whl11c4;
         -- missing declaration for a_frs1516_test_item.whl11c5;
         -- missing declaration for a_frs1516_test_item.whl11c6;
         -- missing declaration for a_frs1516_test_item.whl11c7;
         -- missing declaration for a_frs1516_test_item.whl11c8;
         -- missing declaration for a_frs1516_test_item.whl11c9;
         -- missing declaration for a_frs1516_test_item.whl12c1;
         -- missing declaration for a_frs1516_test_item.whl12c2;
         -- missing declaration for a_frs1516_test_item.whl12c3;
         -- missing declaration for a_frs1516_test_item.whl12c4;
         -- missing declaration for a_frs1516_test_item.whl12c5;
         -- missing declaration for a_frs1516_test_item.whl12c6;
         -- missing declaration for a_frs1516_test_item.whl12c7;
         -- missing declaration for a_frs1516_test_item.whl12c8;
         -- missing declaration for a_frs1516_test_item.whl12c9;
         -- missing declaration for a_frs1516_test_item.whl13c1;
         -- missing declaration for a_frs1516_test_item.whl13c2;
         -- missing declaration for a_frs1516_test_item.whl13c3;
         -- missing declaration for a_frs1516_test_item.whl13c4;
         -- missing declaration for a_frs1516_test_item.whl13c5;
         -- missing declaration for a_frs1516_test_item.whl13c6;
         -- missing declaration for a_frs1516_test_item.whl13c7;
         -- missing declaration for a_frs1516_test_item.whl13c8;
         -- missing declaration for a_frs1516_test_item.whl13c9;
         -- missing declaration for a_frs1516_test_item.whl14c1;
         -- missing declaration for a_frs1516_test_item.whl14c2;
         -- missing declaration for a_frs1516_test_item.whl14c3;
         -- missing declaration for a_frs1516_test_item.whl14c4;
         -- missing declaration for a_frs1516_test_item.whl14c5;
         -- missing declaration for a_frs1516_test_item.whl14c6;
         -- missing declaration for a_frs1516_test_item.whl14c7;
         -- missing declaration for a_frs1516_test_item.whl14c8;
         -- missing declaration for a_frs1516_test_item.whl14c9;
         -- missing declaration for a_frs1516_test_item.whl15c1;
         -- missing declaration for a_frs1516_test_item.whl15c2;
         -- missing declaration for a_frs1516_test_item.whl15c3;
         -- missing declaration for a_frs1516_test_item.whl15c4;
         -- missing declaration for a_frs1516_test_item.whl15c5;
         -- missing declaration for a_frs1516_test_item.whl15c6;
         -- missing declaration for a_frs1516_test_item.whl15c7;
         -- missing declaration for a_frs1516_test_item.whl15c8;
         -- missing declaration for a_frs1516_test_item.whl15c9;
         -- missing declaration for a_frs1516_test_item.whl16c1;
         -- missing declaration for a_frs1516_test_item.whl16c2;
         -- missing declaration for a_frs1516_test_item.whl16c3;
         -- missing declaration for a_frs1516_test_item.whl16c4;
         -- missing declaration for a_frs1516_test_item.whl16c5;
         -- missing declaration for a_frs1516_test_item.whl16c6;
         -- missing declaration for a_frs1516_test_item.whl16c7;
         -- missing declaration for a_frs1516_test_item.whl16c8;
         -- missing declaration for a_frs1516_test_item.whl16c9;
         -- missing declaration for a_frs1516_test_item.whl17c1;
         -- missing declaration for a_frs1516_test_item.whl17c2;
         -- missing declaration for a_frs1516_test_item.whl17c3;
         -- missing declaration for a_frs1516_test_item.whl17c4;
         -- missing declaration for a_frs1516_test_item.whl17c5;
         -- missing declaration for a_frs1516_test_item.whl17c6;
         -- missing declaration for a_frs1516_test_item.whl17c7;
         -- missing declaration for a_frs1516_test_item.whl17c8;
         -- missing declaration for a_frs1516_test_item.whl17c9;
         -- missing declaration for a_frs1516_test_item.whl18c1;
         -- missing declaration for a_frs1516_test_item.whl18c2;
         -- missing declaration for a_frs1516_test_item.whl18c3;
         -- missing declaration for a_frs1516_test_item.whl18c4;
         -- missing declaration for a_frs1516_test_item.whl18c5;
         -- missing declaration for a_frs1516_test_item.whl18c6;
         -- missing declaration for a_frs1516_test_item.whl18c7;
         -- missing declaration for a_frs1516_test_item.whl18c8;
         -- missing declaration for a_frs1516_test_item.whl18c9;
         -- missing declaration for a_frs1516_test_item.whl19c1;
         -- missing declaration for a_frs1516_test_item.whl19c2;
         -- missing declaration for a_frs1516_test_item.whl19c3;
         -- missing declaration for a_frs1516_test_item.whl19c4;
         -- missing declaration for a_frs1516_test_item.whl19c5;
         -- missing declaration for a_frs1516_test_item.whl19c6;
         -- missing declaration for a_frs1516_test_item.whl19c7;
         -- missing declaration for a_frs1516_test_item.whl19c8;
         -- missing declaration for a_frs1516_test_item.whl19c9;
         -- missing declaration for a_frs1516_test_item.whl20c1;
         -- missing declaration for a_frs1516_test_item.whl20c2;
         -- missing declaration for a_frs1516_test_item.whl20c3;
         -- missing declaration for a_frs1516_test_item.whl20c4;
         -- missing declaration for a_frs1516_test_item.whl20c5;
         -- missing declaration for a_frs1516_test_item.whl20c6;
         -- missing declaration for a_frs1516_test_item.whl20c7;
         -- missing declaration for a_frs1516_test_item.whl20c8;
         -- missing declaration for a_frs1516_test_item.whl20c9;
         -- missing declaration for a_frs1516_test_item.agec1;
         -- missing declaration for a_frs1516_test_item.agec2;
         -- missing declaration for a_frs1516_test_item.agec3;
         -- missing declaration for a_frs1516_test_item.agec4;
         -- missing declaration for a_frs1516_test_item.agec5;
         -- missing declaration for a_frs1516_test_item.agec6;
         -- missing declaration for a_frs1516_test_item.agec7;
         -- missing declaration for a_frs1516_test_item.agec8;
         -- missing declaration for a_frs1516_test_item.cameyrc1;
         -- missing declaration for a_frs1516_test_item.cameyrc2;
         -- missing declaration for a_frs1516_test_item.cameyrc3;
         -- missing declaration for a_frs1516_test_item.cameyrc4;
         -- missing declaration for a_frs1516_test_item.cameyrc5;
         -- missing declaration for a_frs1516_test_item.cameyrc6;
         -- missing declaration for a_frs1516_test_item.cameyrc7;
         -- missing declaration for a_frs1516_test_item.cameyrc8;
         -- missing declaration for a_frs1516_test_item.chcrec1;
         -- missing declaration for a_frs1516_test_item.chcrec2;
         -- missing declaration for a_frs1516_test_item.chcrec3;
         -- missing declaration for a_frs1516_test_item.chcrec4;
         -- missing declaration for a_frs1516_test_item.chcrec5;
         -- missing declaration for a_frs1516_test_item.chcrec6;
         -- missing declaration for a_frs1516_test_item.chcrec7;
         -- missing declaration for a_frs1516_test_item.chcrec8;
         -- missing declaration for a_frs1516_test_item.creabc1;
         -- missing declaration for a_frs1516_test_item.creabc2;
         -- missing declaration for a_frs1516_test_item.creabc3;
         -- missing declaration for a_frs1516_test_item.creabc4;
         -- missing declaration for a_frs1516_test_item.creabc5;
         -- missing declaration for a_frs1516_test_item.creabc6;
         -- missing declaration for a_frs1516_test_item.creabc7;
         -- missing declaration for a_frs1516_test_item.creabc8;
         -- missing declaration for a_frs1516_test_item.creahc1;
         -- missing declaration for a_frs1516_test_item.creahc2;
         -- missing declaration for a_frs1516_test_item.creahc3;
         -- missing declaration for a_frs1516_test_item.creahc4;
         -- missing declaration for a_frs1516_test_item.creahc5;
         -- missing declaration for a_frs1516_test_item.creahc6;
         -- missing declaration for a_frs1516_test_item.creahc7;
         -- missing declaration for a_frs1516_test_item.creahc8;
         -- missing declaration for a_frs1516_test_item.crecbc1;
         -- missing declaration for a_frs1516_test_item.crecbc2;
         -- missing declaration for a_frs1516_test_item.crecbc3;
         -- missing declaration for a_frs1516_test_item.crecbc4;
         -- missing declaration for a_frs1516_test_item.crecbc5;
         -- missing declaration for a_frs1516_test_item.crecbc6;
         -- missing declaration for a_frs1516_test_item.crecbc7;
         -- missing declaration for a_frs1516_test_item.crecbc8;
         -- missing declaration for a_frs1516_test_item.crechc1;
         -- missing declaration for a_frs1516_test_item.crechc2;
         -- missing declaration for a_frs1516_test_item.crechc3;
         -- missing declaration for a_frs1516_test_item.crechc4;
         -- missing declaration for a_frs1516_test_item.crechc5;
         -- missing declaration for a_frs1516_test_item.crechc6;
         -- missing declaration for a_frs1516_test_item.crechc7;
         -- missing declaration for a_frs1516_test_item.crechc8;
         -- missing declaration for a_frs1516_test_item.creclc1;
         -- missing declaration for a_frs1516_test_item.creclc2;
         -- missing declaration for a_frs1516_test_item.creclc3;
         -- missing declaration for a_frs1516_test_item.creclc4;
         -- missing declaration for a_frs1516_test_item.creclc5;
         -- missing declaration for a_frs1516_test_item.creclc6;
         -- missing declaration for a_frs1516_test_item.creclc7;
         -- missing declaration for a_frs1516_test_item.creclc8;
         -- missing declaration for a_frs1516_test_item.crefrc1;
         -- missing declaration for a_frs1516_test_item.crefrc2;
         -- missing declaration for a_frs1516_test_item.crefrc3;
         -- missing declaration for a_frs1516_test_item.crefrc4;
         -- missing declaration for a_frs1516_test_item.crefrc5;
         -- missing declaration for a_frs1516_test_item.crefrc6;
         -- missing declaration for a_frs1516_test_item.crefrc7;
         -- missing declaration for a_frs1516_test_item.crefrc8;
         -- missing declaration for a_frs1516_test_item.creotc1;
         -- missing declaration for a_frs1516_test_item.creotc2;
         -- missing declaration for a_frs1516_test_item.creotc3;
         -- missing declaration for a_frs1516_test_item.creotc4;
         -- missing declaration for a_frs1516_test_item.creotc5;
         -- missing declaration for a_frs1516_test_item.creotc6;
         -- missing declaration for a_frs1516_test_item.creotc7;
         -- missing declaration for a_frs1516_test_item.creotc8;
         -- missing declaration for a_frs1516_test_item.carerc1;
         -- missing declaration for a_frs1516_test_item.carerc2;
         -- missing declaration for a_frs1516_test_item.carerc3;
         -- missing declaration for a_frs1516_test_item.carerc4;
         -- missing declaration for a_frs1516_test_item.carerc5;
         -- missing declaration for a_frs1516_test_item.carerc6;
         -- missing declaration for a_frs1516_test_item.carerc7;
         -- missing declaration for a_frs1516_test_item.carerc8;
         -- missing declaration for a_frs1516_test_item.cdatrec1;
         -- missing declaration for a_frs1516_test_item.cdatrec2;
         -- missing declaration for a_frs1516_test_item.cdatrec3;
         -- missing declaration for a_frs1516_test_item.cdatrec4;
         -- missing declaration for a_frs1516_test_item.cdatrec5;
         -- missing declaration for a_frs1516_test_item.cdatrec6;
         -- missing declaration for a_frs1516_test_item.cdatrec7;
         -- missing declaration for a_frs1516_test_item.cdatrec8;
         -- missing declaration for a_frs1516_test_item.cdtrepc1;
         -- missing declaration for a_frs1516_test_item.cdtrepc2;
         -- missing declaration for a_frs1516_test_item.cdtrepc3;
         -- missing declaration for a_frs1516_test_item.cdtrepc4;
         -- missing declaration for a_frs1516_test_item.cdtrepc5;
         -- missing declaration for a_frs1516_test_item.cdtrepc6;
         -- missing declaration for a_frs1516_test_item.cdtrepc7;
         -- missing declaration for a_frs1516_test_item.cdtrepc8;
         -- missing declaration for a_frs1516_test_item.cdis1c1;
         -- missing declaration for a_frs1516_test_item.cdis1c2;
         -- missing declaration for a_frs1516_test_item.cdis1c3;
         -- missing declaration for a_frs1516_test_item.cdis1c4;
         -- missing declaration for a_frs1516_test_item.cdis1c5;
         -- missing declaration for a_frs1516_test_item.cdis1c6;
         -- missing declaration for a_frs1516_test_item.cdis1c7;
         -- missing declaration for a_frs1516_test_item.cdis1c8;
         -- missing declaration for a_frs1516_test_item.cdis2c1;
         -- missing declaration for a_frs1516_test_item.cdis2c2;
         -- missing declaration for a_frs1516_test_item.cdis2c3;
         -- missing declaration for a_frs1516_test_item.cdis2c4;
         -- missing declaration for a_frs1516_test_item.cdis2c5;
         -- missing declaration for a_frs1516_test_item.cdis2c6;
         -- missing declaration for a_frs1516_test_item.cdis2c7;
         -- missing declaration for a_frs1516_test_item.cdis2c8;
         -- missing declaration for a_frs1516_test_item.cdis3c1;
         -- missing declaration for a_frs1516_test_item.cdis3c2;
         -- missing declaration for a_frs1516_test_item.cdis3c3;
         -- missing declaration for a_frs1516_test_item.cdis3c4;
         -- missing declaration for a_frs1516_test_item.cdis3c5;
         -- missing declaration for a_frs1516_test_item.cdis3c6;
         -- missing declaration for a_frs1516_test_item.cdis3c7;
         -- missing declaration for a_frs1516_test_item.cdis3c8;
         -- missing declaration for a_frs1516_test_item.cdis4c1;
         -- missing declaration for a_frs1516_test_item.cdis4c2;
         -- missing declaration for a_frs1516_test_item.cdis4c3;
         -- missing declaration for a_frs1516_test_item.cdis4c4;
         -- missing declaration for a_frs1516_test_item.cdis4c5;
         -- missing declaration for a_frs1516_test_item.cdis4c6;
         -- missing declaration for a_frs1516_test_item.cdis4c7;
         -- missing declaration for a_frs1516_test_item.cdis4c8;
         -- missing declaration for a_frs1516_test_item.cdis5c1;
         -- missing declaration for a_frs1516_test_item.cdis5c2;
         -- missing declaration for a_frs1516_test_item.cdis5c3;
         -- missing declaration for a_frs1516_test_item.cdis5c4;
         -- missing declaration for a_frs1516_test_item.cdis5c5;
         -- missing declaration for a_frs1516_test_item.cdis5c6;
         -- missing declaration for a_frs1516_test_item.cdis5c7;
         -- missing declaration for a_frs1516_test_item.cdis5c8;
         -- missing declaration for a_frs1516_test_item.cdis6c1;
         -- missing declaration for a_frs1516_test_item.cdis6c2;
         -- missing declaration for a_frs1516_test_item.cdis6c3;
         -- missing declaration for a_frs1516_test_item.cdis6c4;
         -- missing declaration for a_frs1516_test_item.cdis6c5;
         -- missing declaration for a_frs1516_test_item.cdis6c6;
         -- missing declaration for a_frs1516_test_item.cdis6c7;
         -- missing declaration for a_frs1516_test_item.cdis6c8;
         -- missing declaration for a_frs1516_test_item.cdis7c1;
         -- missing declaration for a_frs1516_test_item.cdis7c2;
         -- missing declaration for a_frs1516_test_item.cdis7c3;
         -- missing declaration for a_frs1516_test_item.cdis7c4;
         -- missing declaration for a_frs1516_test_item.cdis7c5;
         -- missing declaration for a_frs1516_test_item.cdis7c6;
         -- missing declaration for a_frs1516_test_item.cdis7c7;
         -- missing declaration for a_frs1516_test_item.cdis7c8;
         -- missing declaration for a_frs1516_test_item.cdis8c1;
         -- missing declaration for a_frs1516_test_item.cdis8c2;
         -- missing declaration for a_frs1516_test_item.cdis8c3;
         -- missing declaration for a_frs1516_test_item.cdis8c4;
         -- missing declaration for a_frs1516_test_item.cdis8c5;
         -- missing declaration for a_frs1516_test_item.cdis8c6;
         -- missing declaration for a_frs1516_test_item.cdis8c7;
         -- missing declaration for a_frs1516_test_item.cdis8c8;
         -- missing declaration for a_frs1516_test_item.cdis9c1;
         -- missing declaration for a_frs1516_test_item.cdis9c2;
         -- missing declaration for a_frs1516_test_item.cdis9c3;
         -- missing declaration for a_frs1516_test_item.cdis9c4;
         -- missing declaration for a_frs1516_test_item.cdis9c5;
         -- missing declaration for a_frs1516_test_item.cdis9c6;
         -- missing declaration for a_frs1516_test_item.cdis9c7;
         -- missing declaration for a_frs1516_test_item.cdis9c8;
         -- missing declaration for a_frs1516_test_item.cdis10c1;
         -- missing declaration for a_frs1516_test_item.cdis10c2;
         -- missing declaration for a_frs1516_test_item.cdis10c3;
         -- missing declaration for a_frs1516_test_item.cdis10c4;
         -- missing declaration for a_frs1516_test_item.cdis10c5;
         -- missing declaration for a_frs1516_test_item.cdis10c6;
         -- missing declaration for a_frs1516_test_item.cdis10c7;
         -- missing declaration for a_frs1516_test_item.cdis10c8;
         -- missing declaration for a_frs1516_test_item.cdifc1;
         -- missing declaration for a_frs1516_test_item.cdifc2;
         -- missing declaration for a_frs1516_test_item.cdifc3;
         -- missing declaration for a_frs1516_test_item.cdifc4;
         -- missing declaration for a_frs1516_test_item.cdifc5;
         -- missing declaration for a_frs1516_test_item.cdifc6;
         -- missing declaration for a_frs1516_test_item.cdifc7;
         -- missing declaration for a_frs1516_test_item.cdifc8;
         a_frs1516_test_item.ernamc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.ernamc2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.ernamc3 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ernamc4;
         -- missing declaration for a_frs1516_test_item.ernamc5;
         -- missing declaration for a_frs1516_test_item.ernamc6;
         -- missing declaration for a_frs1516_test_item.ernamc7;
         -- missing declaration for a_frs1516_test_item.ernamc8;
         a_frs1516_test_item.trustc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.trustc2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.trustc3 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.trustc4;
         -- missing declaration for a_frs1516_test_item.trustc5;
         -- missing declaration for a_frs1516_test_item.trustc6;
         -- missing declaration for a_frs1516_test_item.trustc7;
         -- missing declaration for a_frs1516_test_item.trustc8;
         -- missing declaration for a_frs1516_test_item.chbfdc1;
         -- missing declaration for a_frs1516_test_item.chbfdc2;
         -- missing declaration for a_frs1516_test_item.chbfdc3;
         -- missing declaration for a_frs1516_test_item.chbfdc4;
         -- missing declaration for a_frs1516_test_item.chbfdc5;
         -- missing declaration for a_frs1516_test_item.chbfdc6;
         -- missing declaration for a_frs1516_test_item.chbfdc7;
         -- missing declaration for a_frs1516_test_item.chbfdc8;
         a_frs1516_test_item.cbfamtc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.cbfamtc2 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.cbfamtc3;
         -- missing declaration for a_frs1516_test_item.cbfamtc4;
         -- missing declaration for a_frs1516_test_item.cbfamtc5;
         -- missing declaration for a_frs1516_test_item.cbfamtc6;
         -- missing declaration for a_frs1516_test_item.cbfamtc7;
         -- missing declaration for a_frs1516_test_item.cbfamtc8;
         -- missing declaration for a_frs1516_test_item.pbfamtc1;
         -- missing declaration for a_frs1516_test_item.pbfamtc2;
         -- missing declaration for a_frs1516_test_item.pbfamtc3;
         -- missing declaration for a_frs1516_test_item.pbfamtc4;
         -- missing declaration for a_frs1516_test_item.pbfamtc5;
         -- missing declaration for a_frs1516_test_item.pbfamtc6;
         -- missing declaration for a_frs1516_test_item.pbfamtc7;
         -- missing declaration for a_frs1516_test_item.pbfamtc8;
         -- missing declaration for a_frs1516_test_item.cbfvalc1;
         -- missing declaration for a_frs1516_test_item.cbfvalc2;
         -- missing declaration for a_frs1516_test_item.cbfvalc3;
         -- missing declaration for a_frs1516_test_item.cbfvalc4;
         -- missing declaration for a_frs1516_test_item.cbfvalc5;
         -- missing declaration for a_frs1516_test_item.cbfvalc6;
         -- missing declaration for a_frs1516_test_item.cbfvalc7;
         -- missing declaration for a_frs1516_test_item.cbfvalc8;
         -- missing declaration for a_frs1516_test_item.chcondc1;
         -- missing declaration for a_frs1516_test_item.chcondc2;
         -- missing declaration for a_frs1516_test_item.chcondc3;
         -- missing declaration for a_frs1516_test_item.chcondc4;
         -- missing declaration for a_frs1516_test_item.chcondc5;
         -- missing declaration for a_frs1516_test_item.chcondc6;
         -- missing declaration for a_frs1516_test_item.chcondc7;
         -- missing declaration for a_frs1516_test_item.chcondc8;
         -- missing declaration for a_frs1516_test_item.cdla1c1;
         -- missing declaration for a_frs1516_test_item.cdla1c2;
         -- missing declaration for a_frs1516_test_item.cdla1c3;
         -- missing declaration for a_frs1516_test_item.cdla1c4;
         -- missing declaration for a_frs1516_test_item.cdla1c5;
         -- missing declaration for a_frs1516_test_item.cdla1c6;
         -- missing declaration for a_frs1516_test_item.cdla1c7;
         -- missing declaration for a_frs1516_test_item.cdla1c8;
         -- missing declaration for a_frs1516_test_item.cdla2c1;
         -- missing declaration for a_frs1516_test_item.cdla2c2;
         -- missing declaration for a_frs1516_test_item.cdla2c3;
         -- missing declaration for a_frs1516_test_item.cdla2c4;
         -- missing declaration for a_frs1516_test_item.cdla2c5;
         -- missing declaration for a_frs1516_test_item.cdla2c6;
         -- missing declaration for a_frs1516_test_item.cdla2c7;
         -- missing declaration for a_frs1516_test_item.cdla2c8;
         -- missing declaration for a_frs1516_test_item.chelfc1;
         -- missing declaration for a_frs1516_test_item.chelfc2;
         -- missing declaration for a_frs1516_test_item.chelfc3;
         -- missing declaration for a_frs1516_test_item.chelfc4;
         -- missing declaration for a_frs1516_test_item.chelfc5;
         -- missing declaration for a_frs1516_test_item.chelfc6;
         -- missing declaration for a_frs1516_test_item.chelfc7;
         -- missing declaration for a_frs1516_test_item.chelfc8;
         a_frs1516_test_item.chernc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.chernc2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.chernc3 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.chernc4;
         -- missing declaration for a_frs1516_test_item.chernc5;
         -- missing declaration for a_frs1516_test_item.chernc6;
         -- missing declaration for a_frs1516_test_item.chernc7;
         -- missing declaration for a_frs1516_test_item.chernc8;
         -- missing declaration for a_frs1516_test_item.crns1c1;
         -- missing declaration for a_frs1516_test_item.crns1c2;
         -- missing declaration for a_frs1516_test_item.crns1c3;
         -- missing declaration for a_frs1516_test_item.crns1c4;
         -- missing declaration for a_frs1516_test_item.crns1c5;
         -- missing declaration for a_frs1516_test_item.crns1c6;
         -- missing declaration for a_frs1516_test_item.crns1c7;
         -- missing declaration for a_frs1516_test_item.crns1c8;
         -- missing declaration for a_frs1516_test_item.crns2c1;
         -- missing declaration for a_frs1516_test_item.crns2c2;
         -- missing declaration for a_frs1516_test_item.crns2c3;
         -- missing declaration for a_frs1516_test_item.crns2c4;
         -- missing declaration for a_frs1516_test_item.crns2c5;
         -- missing declaration for a_frs1516_test_item.crns2c6;
         -- missing declaration for a_frs1516_test_item.crns2c7;
         -- missing declaration for a_frs1516_test_item.crns2c8;
         -- missing declaration for a_frs1516_test_item.crns3c1;
         -- missing declaration for a_frs1516_test_item.crns3c2;
         -- missing declaration for a_frs1516_test_item.crns3c3;
         -- missing declaration for a_frs1516_test_item.crns3c4;
         -- missing declaration for a_frs1516_test_item.crns3c5;
         -- missing declaration for a_frs1516_test_item.crns3c6;
         -- missing declaration for a_frs1516_test_item.crns3c7;
         -- missing declaration for a_frs1516_test_item.crns3c8;
         -- missing declaration for a_frs1516_test_item.chemac1;
         -- missing declaration for a_frs1516_test_item.chemac2;
         -- missing declaration for a_frs1516_test_item.chemac3;
         -- missing declaration for a_frs1516_test_item.chemac4;
         -- missing declaration for a_frs1516_test_item.chemac5;
         -- missing declaration for a_frs1516_test_item.chemac6;
         -- missing declaration for a_frs1516_test_item.chemac7;
         -- missing declaration for a_frs1516_test_item.chemac8;
         a_frs1516_test_item.emamtc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.emamtc2 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.emamtc3;
         -- missing declaration for a_frs1516_test_item.emamtc4;
         -- missing declaration for a_frs1516_test_item.emamtc5;
         -- missing declaration for a_frs1516_test_item.emamtc6;
         -- missing declaration for a_frs1516_test_item.emamtc7;
         -- missing declaration for a_frs1516_test_item.emamtc8;
         -- missing declaration for a_frs1516_test_item.emapdc1;
         -- missing declaration for a_frs1516_test_item.emapdc2;
         -- missing declaration for a_frs1516_test_item.emapdc3;
         -- missing declaration for a_frs1516_test_item.emapdc4;
         -- missing declaration for a_frs1516_test_item.emapdc5;
         -- missing declaration for a_frs1516_test_item.emapdc6;
         -- missing declaration for a_frs1516_test_item.emapdc7;
         -- missing declaration for a_frs1516_test_item.emapdc8;
         a_frs1516_test_item.chidvc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.chidvc2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.chidvc3 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.chidvc4;
         -- missing declaration for a_frs1516_test_item.chidvc5;
         -- missing declaration for a_frs1516_test_item.chidvc6;
         -- missing declaration for a_frs1516_test_item.chidvc7;
         -- missing declaration for a_frs1516_test_item.chidvc8;
         -- missing declaration for a_frs1516_test_item.climitc1;
         -- missing declaration for a_frs1516_test_item.climitc2;
         -- missing declaration for a_frs1516_test_item.climitc3;
         -- missing declaration for a_frs1516_test_item.climitc4;
         -- missing declaration for a_frs1516_test_item.climitc5;
         -- missing declaration for a_frs1516_test_item.climitc6;
         -- missing declaration for a_frs1516_test_item.climitc7;
         -- missing declaration for a_frs1516_test_item.climitc8;
         -- missing declaration for a_frs1516_test_item.pearnc1;
         -- missing declaration for a_frs1516_test_item.pearnc2;
         -- missing declaration for a_frs1516_test_item.pearnc3;
         -- missing declaration for a_frs1516_test_item.pearnc4;
         -- missing declaration for a_frs1516_test_item.pearnc5;
         -- missing declaration for a_frs1516_test_item.pearnc6;
         -- missing declaration for a_frs1516_test_item.pearnc7;
         -- missing declaration for a_frs1516_test_item.pearnc8;
         -- missing declaration for a_frs1516_test_item.ptrusc1;
         -- missing declaration for a_frs1516_test_item.ptrusc2;
         -- missing declaration for a_frs1516_test_item.ptrusc3;
         -- missing declaration for a_frs1516_test_item.ptrusc4;
         -- missing declaration for a_frs1516_test_item.ptrusc5;
         -- missing declaration for a_frs1516_test_item.ptrusc6;
         -- missing declaration for a_frs1516_test_item.ptrusc7;
         -- missing declaration for a_frs1516_test_item.ptrusc8;
         a_frs1516_test_item.chrinc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.chrinc2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.chrinc3 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.chrinc4;
         -- missing declaration for a_frs1516_test_item.chrinc5;
         -- missing declaration for a_frs1516_test_item.chrinc6;
         -- missing declaration for a_frs1516_test_item.chrinc7;
         -- missing declaration for a_frs1516_test_item.chrinc8;
         -- missing declaration for a_frs1516_test_item.csavec1;
         -- missing declaration for a_frs1516_test_item.csavec2;
         -- missing declaration for a_frs1516_test_item.csavec3;
         -- missing declaration for a_frs1516_test_item.csavec4;
         -- missing declaration for a_frs1516_test_item.csavec5;
         -- missing declaration for a_frs1516_test_item.csavec6;
         -- missing declaration for a_frs1516_test_item.csavec7;
         -- missing declaration for a_frs1516_test_item.csavec8;
         a_frs1516_test_item.tramtc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.tramtc2 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.tramtc3;
         -- missing declaration for a_frs1516_test_item.tramtc4;
         -- missing declaration for a_frs1516_test_item.tramtc5;
         -- missing declaration for a_frs1516_test_item.tramtc6;
         -- missing declaration for a_frs1516_test_item.tramtc7;
         -- missing declaration for a_frs1516_test_item.tramtc8;
         -- missing declaration for a_frs1516_test_item.trnpdc1;
         -- missing declaration for a_frs1516_test_item.trnpdc2;
         -- missing declaration for a_frs1516_test_item.trnpdc3;
         -- missing declaration for a_frs1516_test_item.trnpdc4;
         -- missing declaration for a_frs1516_test_item.trnpdc5;
         -- missing declaration for a_frs1516_test_item.trnpdc6;
         -- missing declaration for a_frs1516_test_item.trnpdc7;
         -- missing declaration for a_frs1516_test_item.trnpdc8;
         -- missing declaration for a_frs1516_test_item.cohabc1;
         -- missing declaration for a_frs1516_test_item.cohabc2;
         -- missing declaration for a_frs1516_test_item.cohabc3;
         -- missing declaration for a_frs1516_test_item.cohabc4;
         -- missing declaration for a_frs1516_test_item.cohabc5;
         -- missing declaration for a_frs1516_test_item.cohabc6;
         -- missing declaration for a_frs1516_test_item.cohabc7;
         -- missing declaration for a_frs1516_test_item.cohabc8;
         -- missing declaration for a_frs1516_test_item.curqulc1;
         -- missing declaration for a_frs1516_test_item.curqulc2;
         -- missing declaration for a_frs1516_test_item.curqulc3;
         -- missing declaration for a_frs1516_test_item.curqulc4;
         -- missing declaration for a_frs1516_test_item.curqulc5;
         -- missing declaration for a_frs1516_test_item.curqulc6;
         -- missing declaration for a_frs1516_test_item.curqulc7;
         -- missing declaration for a_frs1516_test_item.curqulc8;
         -- missing declaration for a_frs1516_test_item.disacc1;
         -- missing declaration for a_frs1516_test_item.disacc2;
         -- missing declaration for a_frs1516_test_item.disacc3;
         -- missing declaration for a_frs1516_test_item.disacc4;
         -- missing declaration for a_frs1516_test_item.disacc5;
         -- missing declaration for a_frs1516_test_item.disacc6;
         -- missing declaration for a_frs1516_test_item.disacc7;
         -- missing declaration for a_frs1516_test_item.disacc8;
         -- missing declaration for a_frs1516_test_item.discoc1;
         -- missing declaration for a_frs1516_test_item.discoc2;
         -- missing declaration for a_frs1516_test_item.discoc3;
         -- missing declaration for a_frs1516_test_item.discoc4;
         -- missing declaration for a_frs1516_test_item.discoc5;
         -- missing declaration for a_frs1516_test_item.discoc6;
         -- missing declaration for a_frs1516_test_item.discoc7;
         -- missing declaration for a_frs1516_test_item.discoc8;
         -- missing declaration for a_frs1516_test_item.dobc1;
         -- missing declaration for a_frs1516_test_item.dobc2;
         -- missing declaration for a_frs1516_test_item.dobc3;
         -- missing declaration for a_frs1516_test_item.dobc4;
         -- missing declaration for a_frs1516_test_item.dobc5;
         -- missing declaration for a_frs1516_test_item.dobc6;
         -- missing declaration for a_frs1516_test_item.dobc7;
         -- missing declaration for a_frs1516_test_item.dobc8;
         -- missing declaration for a_frs1516_test_item.dvmarc1;
         -- missing declaration for a_frs1516_test_item.dvmarc2;
         -- missing declaration for a_frs1516_test_item.dvmarc3;
         -- missing declaration for a_frs1516_test_item.dvmarc4;
         -- missing declaration for a_frs1516_test_item.dvmarc5;
         -- missing declaration for a_frs1516_test_item.dvmarc6;
         -- missing declaration for a_frs1516_test_item.dvmarc7;
         -- missing declaration for a_frs1516_test_item.dvmarc8;
         a_frs1516_test_item.fsvvlc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsvvlc2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsvvlc3 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsvvlc4 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsvvlc5 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsvvlc6 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.fsvvlc7;
         -- missing declaration for a_frs1516_test_item.fsvvlc8;
         a_frs1516_test_item.fsmkvc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsmkvc2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsmkvc3 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsmkvc4 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsmkvc5 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.fsmkvc6;
         -- missing declaration for a_frs1516_test_item.fsmkvc7;
         -- missing declaration for a_frs1516_test_item.fsmkvc8;
         a_frs1516_test_item.fsmlvc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsmlvc2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsmlvc3 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsmlvc4 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsmlvc5 := 1010100.012 + Amount( i );
         a_frs1516_test_item.fsmlvc6 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.fsmlvc7;
         -- missing declaration for a_frs1516_test_item.fsmlvc8;
         -- missing declaration for a_frs1516_test_item.ftedc1;
         -- missing declaration for a_frs1516_test_item.ftedc2;
         -- missing declaration for a_frs1516_test_item.ftedc3;
         -- missing declaration for a_frs1516_test_item.ftedc4;
         -- missing declaration for a_frs1516_test_item.ftedc5;
         -- missing declaration for a_frs1516_test_item.ftedc6;
         -- missing declaration for a_frs1516_test_item.ftedc7;
         -- missing declaration for a_frs1516_test_item.ftedc8;
         -- missing declaration for a_frs1516_test_item.g1valc1;
         -- missing declaration for a_frs1516_test_item.g1valc2;
         -- missing declaration for a_frs1516_test_item.g1valc3;
         -- missing declaration for a_frs1516_test_item.g1valc4;
         -- missing declaration for a_frs1516_test_item.g1valc5;
         -- missing declaration for a_frs1516_test_item.g1valc6;
         -- missing declaration for a_frs1516_test_item.g1valc7;
         -- missing declaration for a_frs1516_test_item.g1valc8;
         -- missing declaration for a_frs1516_test_item.g2valc1;
         -- missing declaration for a_frs1516_test_item.g2valc2;
         -- missing declaration for a_frs1516_test_item.g2valc3;
         -- missing declaration for a_frs1516_test_item.g2valc4;
         -- missing declaration for a_frs1516_test_item.g2valc5;
         -- missing declaration for a_frs1516_test_item.g2valc6;
         -- missing declaration for a_frs1516_test_item.g2valc7;
         -- missing declaration for a_frs1516_test_item.g2valc8;
         -- missing declaration for a_frs1516_test_item.g1dirc1;
         -- missing declaration for a_frs1516_test_item.g1dirc2;
         -- missing declaration for a_frs1516_test_item.g1dirc3;
         -- missing declaration for a_frs1516_test_item.g1dirc4;
         -- missing declaration for a_frs1516_test_item.g1dirc5;
         -- missing declaration for a_frs1516_test_item.g1dirc6;
         -- missing declaration for a_frs1516_test_item.g1dirc7;
         -- missing declaration for a_frs1516_test_item.g1dirc8;
         -- missing declaration for a_frs1516_test_item.g2dirc1;
         -- missing declaration for a_frs1516_test_item.g2dirc2;
         -- missing declaration for a_frs1516_test_item.g2dirc3;
         -- missing declaration for a_frs1516_test_item.g2dirc4;
         -- missing declaration for a_frs1516_test_item.g2dirc5;
         -- missing declaration for a_frs1516_test_item.g2dirc6;
         -- missing declaration for a_frs1516_test_item.g2dirc7;
         -- missing declaration for a_frs1516_test_item.g2dirc8;
         -- missing declaration for a_frs1516_test_item.gtnumc1;
         -- missing declaration for a_frs1516_test_item.gtnumc2;
         -- missing declaration for a_frs1516_test_item.gtnumc3;
         -- missing declaration for a_frs1516_test_item.gtnumc4;
         -- missing declaration for a_frs1516_test_item.gtnumc5;
         -- missing declaration for a_frs1516_test_item.gtnumc6;
         -- missing declaration for a_frs1516_test_item.gtnumc7;
         -- missing declaration for a_frs1516_test_item.gtnumc8;
         -- missing declaration for a_frs1516_test_item.gt1scc1;
         -- missing declaration for a_frs1516_test_item.gt1scc2;
         -- missing declaration for a_frs1516_test_item.gt1scc3;
         -- missing declaration for a_frs1516_test_item.gt1scc4;
         -- missing declaration for a_frs1516_test_item.gt1scc5;
         -- missing declaration for a_frs1516_test_item.gt1scc6;
         -- missing declaration for a_frs1516_test_item.gt1scc7;
         -- missing declaration for a_frs1516_test_item.gt1scc8;
         -- missing declaration for a_frs1516_test_item.gt2scc1;
         -- missing declaration for a_frs1516_test_item.gt2scc2;
         -- missing declaration for a_frs1516_test_item.gt2scc3;
         -- missing declaration for a_frs1516_test_item.gt2scc4;
         -- missing declaration for a_frs1516_test_item.gt2scc5;
         -- missing declaration for a_frs1516_test_item.gt2scc6;
         -- missing declaration for a_frs1516_test_item.gt2scc7;
         -- missing declaration for a_frs1516_test_item.gt2scc8;
         a_frs1516_test_item.gt10sc1 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.gt10sc2;
         -- missing declaration for a_frs1516_test_item.gt10sc3;
         -- missing declaration for a_frs1516_test_item.gt10sc4;
         -- missing declaration for a_frs1516_test_item.gt10sc5;
         -- missing declaration for a_frs1516_test_item.gt10sc6;
         -- missing declaration for a_frs1516_test_item.gt10sc7;
         -- missing declaration for a_frs1516_test_item.gt10sc8;
         -- missing declaration for a_frs1516_test_item.gt20sc1;
         -- missing declaration for a_frs1516_test_item.gt20sc2;
         -- missing declaration for a_frs1516_test_item.gt20sc3;
         -- missing declaration for a_frs1516_test_item.gt20sc4;
         -- missing declaration for a_frs1516_test_item.gt20sc5;
         -- missing declaration for a_frs1516_test_item.gt20sc6;
         -- missing declaration for a_frs1516_test_item.gt20sc7;
         -- missing declaration for a_frs1516_test_item.gt20sc8;
         -- missing declaration for a_frs1516_test_item.hartvc1;
         -- missing declaration for a_frs1516_test_item.hartvc2;
         -- missing declaration for a_frs1516_test_item.hartvc3;
         -- missing declaration for a_frs1516_test_item.hartvc4;
         -- missing declaration for a_frs1516_test_item.hartvc5;
         -- missing declaration for a_frs1516_test_item.hartvc6;
         -- missing declaration for a_frs1516_test_item.hartvc7;
         -- missing declaration for a_frs1516_test_item.hartvc8;
         -- missing declaration for a_frs1516_test_item.heatchc1;
         -- missing declaration for a_frs1516_test_item.heatchc2;
         -- missing declaration for a_frs1516_test_item.heatchc3;
         -- missing declaration for a_frs1516_test_item.heatchc4;
         -- missing declaration for a_frs1516_test_item.heatchc5;
         -- missing declaration for a_frs1516_test_item.heatchc6;
         -- missing declaration for a_frs1516_test_item.heatchc7;
         -- missing declaration for a_frs1516_test_item.heatchc8;
         -- missing declaration for a_frs1516_test_item.hhldrc1;
         -- missing declaration for a_frs1516_test_item.hhldrc2;
         -- missing declaration for a_frs1516_test_item.hhldrc3;
         -- missing declaration for a_frs1516_test_item.hhldrc4;
         -- missing declaration for a_frs1516_test_item.hhldrc5;
         -- missing declaration for a_frs1516_test_item.hhldrc6;
         -- missing declaration for a_frs1516_test_item.hhldrc7;
         -- missing declaration for a_frs1516_test_item.hhldrc8;
         -- missing declaration for a_frs1516_test_item.hurabc1;
         -- missing declaration for a_frs1516_test_item.hurabc2;
         -- missing declaration for a_frs1516_test_item.hurabc3;
         -- missing declaration for a_frs1516_test_item.hurabc4;
         -- missing declaration for a_frs1516_test_item.hurabc5;
         -- missing declaration for a_frs1516_test_item.hurabc6;
         -- missing declaration for a_frs1516_test_item.hurabc7;
         -- missing declaration for a_frs1516_test_item.hurabc8;
         -- missing declaration for a_frs1516_test_item.hurahc1;
         -- missing declaration for a_frs1516_test_item.hurahc2;
         -- missing declaration for a_frs1516_test_item.hurahc3;
         -- missing declaration for a_frs1516_test_item.hurahc4;
         -- missing declaration for a_frs1516_test_item.hurahc5;
         -- missing declaration for a_frs1516_test_item.hurahc6;
         -- missing declaration for a_frs1516_test_item.hurahc7;
         -- missing declaration for a_frs1516_test_item.hurahc8;
         -- missing declaration for a_frs1516_test_item.hurcbc1;
         -- missing declaration for a_frs1516_test_item.hurcbc2;
         -- missing declaration for a_frs1516_test_item.hurcbc3;
         -- missing declaration for a_frs1516_test_item.hurcbc4;
         -- missing declaration for a_frs1516_test_item.hurcbc5;
         -- missing declaration for a_frs1516_test_item.hurcbc6;
         -- missing declaration for a_frs1516_test_item.hurcbc7;
         -- missing declaration for a_frs1516_test_item.hurcbc8;
         -- missing declaration for a_frs1516_test_item.hurchc1;
         -- missing declaration for a_frs1516_test_item.hurchc2;
         -- missing declaration for a_frs1516_test_item.hurchc3;
         -- missing declaration for a_frs1516_test_item.hurchc4;
         -- missing declaration for a_frs1516_test_item.hurchc5;
         -- missing declaration for a_frs1516_test_item.hurchc6;
         -- missing declaration for a_frs1516_test_item.hurchc7;
         -- missing declaration for a_frs1516_test_item.hurchc8;
         -- missing declaration for a_frs1516_test_item.hurclc1;
         -- missing declaration for a_frs1516_test_item.hurclc2;
         -- missing declaration for a_frs1516_test_item.hurclc3;
         -- missing declaration for a_frs1516_test_item.hurclc4;
         -- missing declaration for a_frs1516_test_item.hurclc5;
         -- missing declaration for a_frs1516_test_item.hurclc6;
         -- missing declaration for a_frs1516_test_item.hurclc7;
         -- missing declaration for a_frs1516_test_item.hurclc8;
         -- missing declaration for a_frs1516_test_item.hurfrc1;
         -- missing declaration for a_frs1516_test_item.hurfrc2;
         -- missing declaration for a_frs1516_test_item.hurfrc3;
         -- missing declaration for a_frs1516_test_item.hurfrc4;
         -- missing declaration for a_frs1516_test_item.hurfrc5;
         -- missing declaration for a_frs1516_test_item.hurfrc6;
         -- missing declaration for a_frs1516_test_item.hurfrc7;
         -- missing declaration for a_frs1516_test_item.hurfrc8;
         -- missing declaration for a_frs1516_test_item.hurotc1;
         -- missing declaration for a_frs1516_test_item.hurotc2;
         -- missing declaration for a_frs1516_test_item.hurotc3;
         -- missing declaration for a_frs1516_test_item.hurotc4;
         -- missing declaration for a_frs1516_test_item.hurotc5;
         -- missing declaration for a_frs1516_test_item.hurotc6;
         -- missing declaration for a_frs1516_test_item.hurotc7;
         -- missing declaration for a_frs1516_test_item.hurotc8;
         -- missing declaration for a_frs1516_test_item.hurrec1;
         -- missing declaration for a_frs1516_test_item.hurrec2;
         -- missing declaration for a_frs1516_test_item.hurrec3;
         -- missing declaration for a_frs1516_test_item.hurrec4;
         -- missing declaration for a_frs1516_test_item.hurrec5;
         -- missing declaration for a_frs1516_test_item.hurrec6;
         -- missing declaration for a_frs1516_test_item.hurrec7;
         -- missing declaration for a_frs1516_test_item.hurrec8;
         -- missing declaration for a_frs1516_test_item.hpersc1;
         -- missing declaration for a_frs1516_test_item.hpersc2;
         -- missing declaration for a_frs1516_test_item.hpersc3;
         -- missing declaration for a_frs1516_test_item.hpersc4;
         -- missing declaration for a_frs1516_test_item.hpersc5;
         -- missing declaration for a_frs1516_test_item.hpersc6;
         -- missing declaration for a_frs1516_test_item.hpersc7;
         -- missing declaration for a_frs1516_test_item.hpersc8;
         -- missing declaration for a_frs1516_test_item.hrsedc1;
         -- missing declaration for a_frs1516_test_item.hrsedc2;
         -- missing declaration for a_frs1516_test_item.hrsedc3;
         -- missing declaration for a_frs1516_test_item.hrsedc4;
         -- missing declaration for a_frs1516_test_item.hrsedc5;
         -- missing declaration for a_frs1516_test_item.hrsedc6;
         -- missing declaration for a_frs1516_test_item.hrsedc7;
         -- missing declaration for a_frs1516_test_item.hrsedc8;
         -- missing declaration for a_frs1516_test_item.hsvprc1;
         -- missing declaration for a_frs1516_test_item.hsvprc2;
         -- missing declaration for a_frs1516_test_item.hsvprc3;
         -- missing declaration for a_frs1516_test_item.hsvprc4;
         -- missing declaration for a_frs1516_test_item.hsvprc5;
         -- missing declaration for a_frs1516_test_item.hsvprc6;
         -- missing declaration for a_frs1516_test_item.hsvprc7;
         -- missing declaration for a_frs1516_test_item.hsvprc8;
         -- missing declaration for a_frs1516_test_item.laregc1;
         -- missing declaration for a_frs1516_test_item.laregc2;
         -- missing declaration for a_frs1516_test_item.laregc3;
         -- missing declaration for a_frs1516_test_item.laregc4;
         -- missing declaration for a_frs1516_test_item.laregc5;
         -- missing declaration for a_frs1516_test_item.laregc6;
         -- missing declaration for a_frs1516_test_item.laregc7;
         -- missing declaration for a_frs1516_test_item.laregc8;
         -- missing declaration for a_frs1516_test_item.msc1;
         -- missing declaration for a_frs1516_test_item.msc2;
         -- missing declaration for a_frs1516_test_item.msc3;
         -- missing declaration for a_frs1516_test_item.msc4;
         -- missing declaration for a_frs1516_test_item.msc5;
         -- missing declaration for a_frs1516_test_item.msc6;
         -- missing declaration for a_frs1516_test_item.msc7;
         -- missing declaration for a_frs1516_test_item.msc8;
         -- missing declaration for a_frs1516_test_item.prsonc1;
         -- missing declaration for a_frs1516_test_item.prsonc2;
         -- missing declaration for a_frs1516_test_item.prsonc3;
         -- missing declaration for a_frs1516_test_item.prsonc4;
         -- missing declaration for a_frs1516_test_item.prsonc5;
         -- missing declaration for a_frs1516_test_item.prsonc6;
         -- missing declaration for a_frs1516_test_item.prsonc7;
         -- missing declaration for a_frs1516_test_item.prsonc8;
         -- missing declaration for a_frs1516_test_item.rlp1c1;
         -- missing declaration for a_frs1516_test_item.rlp1c2;
         -- missing declaration for a_frs1516_test_item.rlp1c3;
         -- missing declaration for a_frs1516_test_item.rlp1c4;
         -- missing declaration for a_frs1516_test_item.rlp1c5;
         -- missing declaration for a_frs1516_test_item.rlp1c6;
         -- missing declaration for a_frs1516_test_item.rlp1c7;
         -- missing declaration for a_frs1516_test_item.rlp1c8;
         -- missing declaration for a_frs1516_test_item.rlp2c1;
         -- missing declaration for a_frs1516_test_item.rlp2c2;
         -- missing declaration for a_frs1516_test_item.rlp2c3;
         -- missing declaration for a_frs1516_test_item.rlp2c4;
         -- missing declaration for a_frs1516_test_item.rlp2c5;
         -- missing declaration for a_frs1516_test_item.rlp2c6;
         -- missing declaration for a_frs1516_test_item.rlp2c7;
         -- missing declaration for a_frs1516_test_item.rlp2c8;
         -- missing declaration for a_frs1516_test_item.rlp3c1;
         -- missing declaration for a_frs1516_test_item.rlp3c2;
         -- missing declaration for a_frs1516_test_item.rlp3c3;
         -- missing declaration for a_frs1516_test_item.rlp3c4;
         -- missing declaration for a_frs1516_test_item.rlp3c5;
         -- missing declaration for a_frs1516_test_item.rlp3c6;
         -- missing declaration for a_frs1516_test_item.rlp3c7;
         -- missing declaration for a_frs1516_test_item.rlp3c8;
         -- missing declaration for a_frs1516_test_item.rlp4c1;
         -- missing declaration for a_frs1516_test_item.rlp4c2;
         -- missing declaration for a_frs1516_test_item.rlp4c3;
         -- missing declaration for a_frs1516_test_item.rlp4c4;
         -- missing declaration for a_frs1516_test_item.rlp4c5;
         -- missing declaration for a_frs1516_test_item.rlp4c6;
         -- missing declaration for a_frs1516_test_item.rlp4c7;
         -- missing declaration for a_frs1516_test_item.rlp4c8;
         -- missing declaration for a_frs1516_test_item.rlp5c1;
         -- missing declaration for a_frs1516_test_item.rlp5c2;
         -- missing declaration for a_frs1516_test_item.rlp5c3;
         -- missing declaration for a_frs1516_test_item.rlp5c4;
         -- missing declaration for a_frs1516_test_item.rlp5c5;
         -- missing declaration for a_frs1516_test_item.rlp5c6;
         -- missing declaration for a_frs1516_test_item.rlp5c7;
         -- missing declaration for a_frs1516_test_item.rlp5c8;
         -- missing declaration for a_frs1516_test_item.rlp6c1;
         -- missing declaration for a_frs1516_test_item.rlp6c2;
         -- missing declaration for a_frs1516_test_item.rlp6c3;
         -- missing declaration for a_frs1516_test_item.rlp6c4;
         -- missing declaration for a_frs1516_test_item.rlp6c5;
         -- missing declaration for a_frs1516_test_item.rlp6c6;
         -- missing declaration for a_frs1516_test_item.rlp6c7;
         -- missing declaration for a_frs1516_test_item.rlp6c8;
         -- missing declaration for a_frs1516_test_item.rlp7c1;
         -- missing declaration for a_frs1516_test_item.rlp7c2;
         -- missing declaration for a_frs1516_test_item.rlp7c3;
         -- missing declaration for a_frs1516_test_item.rlp7c4;
         -- missing declaration for a_frs1516_test_item.rlp7c5;
         -- missing declaration for a_frs1516_test_item.rlp7c6;
         -- missing declaration for a_frs1516_test_item.rlp7c7;
         -- missing declaration for a_frs1516_test_item.rlp7c8;
         -- missing declaration for a_frs1516_test_item.rlp8c1;
         -- missing declaration for a_frs1516_test_item.rlp8c2;
         -- missing declaration for a_frs1516_test_item.rlp8c3;
         -- missing declaration for a_frs1516_test_item.rlp8c4;
         -- missing declaration for a_frs1516_test_item.rlp8c5;
         -- missing declaration for a_frs1516_test_item.rlp8c6;
         -- missing declaration for a_frs1516_test_item.rlp8c7;
         -- missing declaration for a_frs1516_test_item.rlp8c8;
         -- missing declaration for a_frs1516_test_item.rlp9c1;
         -- missing declaration for a_frs1516_test_item.rlp9c2;
         -- missing declaration for a_frs1516_test_item.rlp9c3;
         -- missing declaration for a_frs1516_test_item.rlp9c4;
         -- missing declaration for a_frs1516_test_item.rlp9c5;
         -- missing declaration for a_frs1516_test_item.rlp9c6;
         -- missing declaration for a_frs1516_test_item.rlp9c7;
         -- missing declaration for a_frs1516_test_item.rlp9c8;
         -- missing declaration for a_frs1516_test_item.rlp10c1;
         -- missing declaration for a_frs1516_test_item.rlp10c2;
         -- missing declaration for a_frs1516_test_item.rlp10c3;
         -- missing declaration for a_frs1516_test_item.rlp10c4;
         -- missing declaration for a_frs1516_test_item.rlp10c5;
         -- missing declaration for a_frs1516_test_item.rlp10c6;
         -- missing declaration for a_frs1516_test_item.rlp10c7;
         -- missing declaration for a_frs1516_test_item.rlp10c8;
         -- missing declaration for a_frs1516_test_item.rlp11c1;
         -- missing declaration for a_frs1516_test_item.rlp11c2;
         -- missing declaration for a_frs1516_test_item.rlp11c3;
         -- missing declaration for a_frs1516_test_item.rlp11c4;
         -- missing declaration for a_frs1516_test_item.rlp11c5;
         -- missing declaration for a_frs1516_test_item.rlp11c6;
         -- missing declaration for a_frs1516_test_item.rlp11c7;
         -- missing declaration for a_frs1516_test_item.rlp11c8;
         -- missing declaration for a_frs1516_test_item.rlp12c1;
         -- missing declaration for a_frs1516_test_item.rlp12c2;
         -- missing declaration for a_frs1516_test_item.rlp12c3;
         -- missing declaration for a_frs1516_test_item.rlp12c4;
         -- missing declaration for a_frs1516_test_item.rlp12c5;
         -- missing declaration for a_frs1516_test_item.rlp12c6;
         -- missing declaration for a_frs1516_test_item.rlp12c7;
         -- missing declaration for a_frs1516_test_item.rlp12c8;
         -- missing declaration for a_frs1516_test_item.rlp13c1;
         -- missing declaration for a_frs1516_test_item.rlp13c2;
         -- missing declaration for a_frs1516_test_item.rlp13c3;
         -- missing declaration for a_frs1516_test_item.rlp13c4;
         -- missing declaration for a_frs1516_test_item.rlp13c5;
         -- missing declaration for a_frs1516_test_item.rlp13c6;
         -- missing declaration for a_frs1516_test_item.rlp13c7;
         -- missing declaration for a_frs1516_test_item.rlp13c8;
         -- missing declaration for a_frs1516_test_item.rlp14c1;
         -- missing declaration for a_frs1516_test_item.rlp14c2;
         -- missing declaration for a_frs1516_test_item.rlp14c3;
         -- missing declaration for a_frs1516_test_item.rlp14c4;
         -- missing declaration for a_frs1516_test_item.rlp14c5;
         -- missing declaration for a_frs1516_test_item.rlp14c6;
         -- missing declaration for a_frs1516_test_item.rlp14c7;
         -- missing declaration for a_frs1516_test_item.rlp14c8;
         -- missing declaration for a_frs1516_test_item.rhrpcc1;
         -- missing declaration for a_frs1516_test_item.rhrpcc2;
         -- missing declaration for a_frs1516_test_item.rhrpcc3;
         -- missing declaration for a_frs1516_test_item.rhrpcc4;
         -- missing declaration for a_frs1516_test_item.rhrpcc5;
         -- missing declaration for a_frs1516_test_item.rhrpcc6;
         -- missing declaration for a_frs1516_test_item.rhrpcc7;
         -- missing declaration for a_frs1516_test_item.rhrpcc8;
         -- missing declaration for a_frs1516_test_item.sbkitc1;
         -- missing declaration for a_frs1516_test_item.sbkitc2;
         -- missing declaration for a_frs1516_test_item.sbkitc3;
         -- missing declaration for a_frs1516_test_item.sbkitc4;
         -- missing declaration for a_frs1516_test_item.sbkitc5;
         -- missing declaration for a_frs1516_test_item.sbkitc6;
         -- missing declaration for a_frs1516_test_item.sbkitc7;
         -- missing declaration for a_frs1516_test_item.sbkitc8;
         -- missing declaration for a_frs1516_test_item.sexc1;
         -- missing declaration for a_frs1516_test_item.sexc2;
         -- missing declaration for a_frs1516_test_item.sexc3;
         -- missing declaration for a_frs1516_test_item.sexc4;
         -- missing declaration for a_frs1516_test_item.sexc5;
         -- missing declaration for a_frs1516_test_item.sexc6;
         -- missing declaration for a_frs1516_test_item.sexc7;
         -- missing declaration for a_frs1516_test_item.sexc8;
         -- missing declaration for a_frs1516_test_item.sfvitc1;
         -- missing declaration for a_frs1516_test_item.sfvitc2;
         -- missing declaration for a_frs1516_test_item.sfvitc3;
         -- missing declaration for a_frs1516_test_item.sfvitc4;
         -- missing declaration for a_frs1516_test_item.sfvitc5;
         -- missing declaration for a_frs1516_test_item.sfvitc6;
         -- missing declaration for a_frs1516_test_item.sfvitc7;
         -- missing declaration for a_frs1516_test_item.sfvitc8;
         -- missing declaration for a_frs1516_test_item.fmctsc1;
         -- missing declaration for a_frs1516_test_item.fmctsc2;
         -- missing declaration for a_frs1516_test_item.fmctsc3;
         -- missing declaration for a_frs1516_test_item.fmctsc4;
         -- missing declaration for a_frs1516_test_item.fmctsc5;
         -- missing declaration for a_frs1516_test_item.fmctsc6;
         -- missing declaration for a_frs1516_test_item.fmctsc7;
         -- missing declaration for a_frs1516_test_item.fmctsc8;
         -- missing declaration for a_frs1516_test_item.fmealc1;
         -- missing declaration for a_frs1516_test_item.fmealc2;
         -- missing declaration for a_frs1516_test_item.fmealc3;
         -- missing declaration for a_frs1516_test_item.fmealc4;
         -- missing declaration for a_frs1516_test_item.fmealc5;
         -- missing declaration for a_frs1516_test_item.fmealc6;
         -- missing declaration for a_frs1516_test_item.fmealc7;
         -- missing declaration for a_frs1516_test_item.fmealc8;
         -- missing declaration for a_frs1516_test_item.cblndc1;
         -- missing declaration for a_frs1516_test_item.cblndc2;
         -- missing declaration for a_frs1516_test_item.cblndc3;
         -- missing declaration for a_frs1516_test_item.cblndc4;
         -- missing declaration for a_frs1516_test_item.cblndc5;
         -- missing declaration for a_frs1516_test_item.cblndc6;
         -- missing declaration for a_frs1516_test_item.cblndc7;
         -- missing declaration for a_frs1516_test_item.cblndc8;
         -- missing declaration for a_frs1516_test_item.cparsc1;
         -- missing declaration for a_frs1516_test_item.cparsc2;
         -- missing declaration for a_frs1516_test_item.cparsc3;
         -- missing declaration for a_frs1516_test_item.cparsc4;
         -- missing declaration for a_frs1516_test_item.cparsc5;
         -- missing declaration for a_frs1516_test_item.cparsc6;
         -- missing declaration for a_frs1516_test_item.cparsc7;
         -- missing declaration for a_frs1516_test_item.cparsc8;
         -- missing declaration for a_frs1516_test_item.cdeafc1;
         -- missing declaration for a_frs1516_test_item.cdeafc2;
         -- missing declaration for a_frs1516_test_item.cdeafc3;
         -- missing declaration for a_frs1516_test_item.cdeafc4;
         -- missing declaration for a_frs1516_test_item.cdeafc5;
         -- missing declaration for a_frs1516_test_item.cdeafc6;
         -- missing declaration for a_frs1516_test_item.cdeafc7;
         -- missing declaration for a_frs1516_test_item.cdeafc8;
         -- missing declaration for a_frs1516_test_item.totgtc1;
         -- missing declaration for a_frs1516_test_item.totgtc2;
         -- missing declaration for a_frs1516_test_item.totgtc3;
         -- missing declaration for a_frs1516_test_item.totgtc4;
         -- missing declaration for a_frs1516_test_item.totgtc5;
         -- missing declaration for a_frs1516_test_item.totgtc6;
         -- missing declaration for a_frs1516_test_item.totgtc7;
         -- missing declaration for a_frs1516_test_item.totgtc8;
         -- missing declaration for a_frs1516_test_item.totsvc1;
         -- missing declaration for a_frs1516_test_item.totsvc2;
         -- missing declaration for a_frs1516_test_item.totsvc3;
         -- missing declaration for a_frs1516_test_item.totsvc4;
         -- missing declaration for a_frs1516_test_item.totsvc5;
         -- missing declaration for a_frs1516_test_item.totsvc6;
         -- missing declaration for a_frs1516_test_item.totsvc7;
         -- missing declaration for a_frs1516_test_item.totsvc8;
         a_frs1516_test_item.tacamc1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.tacamc2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.tacamc3 := 1010100.012 + Amount( i );
         a_frs1516_test_item.tacamc4 := 1010100.012 + Amount( i );
         a_frs1516_test_item.tacamc5 := 1010100.012 + Amount( i );
         a_frs1516_test_item.tacamc6 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.tacamc7;
         -- missing declaration for a_frs1516_test_item.tacamc8;
         -- missing declaration for a_frs1516_test_item.tpeedc1;
         -- missing declaration for a_frs1516_test_item.tpeedc2;
         -- missing declaration for a_frs1516_test_item.tpeedc3;
         -- missing declaration for a_frs1516_test_item.tpeedc4;
         -- missing declaration for a_frs1516_test_item.tpeedc5;
         -- missing declaration for a_frs1516_test_item.tpeedc6;
         -- missing declaration for a_frs1516_test_item.tpeedc7;
         -- missing declaration for a_frs1516_test_item.tpeedc8;
         -- missing declaration for a_frs1516_test_item.uprsoc1;
         -- missing declaration for a_frs1516_test_item.uprsoc2;
         -- missing declaration for a_frs1516_test_item.uprsoc3;
         -- missing declaration for a_frs1516_test_item.uprsoc4;
         -- missing declaration for a_frs1516_test_item.uprsoc5;
         -- missing declaration for a_frs1516_test_item.uprsoc6;
         -- missing declaration for a_frs1516_test_item.uprsoc7;
         -- missing declaration for a_frs1516_test_item.uprsoc8;
         -- missing declaration for a_frs1516_test_item.govpy1hd;
         -- missing declaration for a_frs1516_test_item.govpy2hd;
         -- missing declaration for a_frs1516_test_item.govpy3hd;
         -- missing declaration for a_frs1516_test_item.govpy4hd;
         -- missing declaration for a_frs1516_test_item.govpy5hd;
         -- missing declaration for a_frs1516_test_item.govpy6hd;
         -- missing declaration for a_frs1516_test_item.govpy7hd;
         -- missing declaration for a_frs1516_test_item.govpy8hd;
         -- missing declaration for a_frs1516_test_item.govpy9hd;
         -- missing declaration for a_frs1516_test_item.gvpy10hd;
         -- missing declaration for a_frs1516_test_item.gvpy11hd;
         -- missing declaration for a_frs1516_test_item.govpy1sp;
         -- missing declaration for a_frs1516_test_item.govpy2sp;
         -- missing declaration for a_frs1516_test_item.govpy3sp;
         -- missing declaration for a_frs1516_test_item.govpy4sp;
         -- missing declaration for a_frs1516_test_item.govpy5sp;
         -- missing declaration for a_frs1516_test_item.govpy6sp;
         -- missing declaration for a_frs1516_test_item.govpy7sp;
         -- missing declaration for a_frs1516_test_item.govpy8sp;
         -- missing declaration for a_frs1516_test_item.govpy9sp;
         -- missing declaration for a_frs1516_test_item.gvpy10sp;
         -- missing declaration for a_frs1516_test_item.gvpy11sp;
         a_frs1516_test_item.nhhamt1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.nhhamt2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.nhhamt3 := 1010100.012 + Amount( i );
         a_frs1516_test_item.nhhamt4 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.nhhfee1;
         -- missing declaration for a_frs1516_test_item.nhhfee2;
         -- missing declaration for a_frs1516_test_item.nhhfee3;
         -- missing declaration for a_frs1516_test_item.nhhfee4;
         -- missing declaration for a_frs1516_test_item.pnhhamt1;
         -- missing declaration for a_frs1516_test_item.pnhhamt2;
         -- missing declaration for a_frs1516_test_item.pnhhamt3;
         -- missing declaration for a_frs1516_test_item.pnhhamt4;
         a_frs1516_test_item.bona11hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.bona12hd;
         -- missing declaration for a_frs1516_test_item.bona13hd;
         a_frs1516_test_item.bona11sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.bona12sp;
         -- missing declaration for a_frs1516_test_item.bona13sp;
         a_frs1516_test_item.bona21hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.bona22hd;
         -- missing declaration for a_frs1516_test_item.bona23hd;
         -- missing declaration for a_frs1516_test_item.bona21sp;
         -- missing declaration for a_frs1516_test_item.bona22sp;
         -- missing declaration for a_frs1516_test_item.bona23sp;
         a_frs1516_test_item.bona31hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.bona32hd;
         -- missing declaration for a_frs1516_test_item.bona33hd;
         -- missing declaration for a_frs1516_test_item.bona31sp;
         -- missing declaration for a_frs1516_test_item.bona32sp;
         -- missing declaration for a_frs1516_test_item.bona33sp;
         a_frs1516_test_item.bona41hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.bona42hd;
         -- missing declaration for a_frs1516_test_item.bona43hd;
         -- missing declaration for a_frs1516_test_item.bona41sp;
         -- missing declaration for a_frs1516_test_item.bona42sp;
         -- missing declaration for a_frs1516_test_item.bona43sp;
         a_frs1516_test_item.bona51hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.bona52hd;
         -- missing declaration for a_frs1516_test_item.bona53hd;
         -- missing declaration for a_frs1516_test_item.bona51sp;
         -- missing declaration for a_frs1516_test_item.bona52sp;
         -- missing declaration for a_frs1516_test_item.bona53sp;
         a_frs1516_test_item.bona61hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.bona62hd;
         -- missing declaration for a_frs1516_test_item.bona63hd;
         -- missing declaration for a_frs1516_test_item.bona61sp;
         -- missing declaration for a_frs1516_test_item.bona62sp;
         -- missing declaration for a_frs1516_test_item.bona63sp;
         -- missing declaration for a_frs1516_test_item.bont11hd;
         -- missing declaration for a_frs1516_test_item.bont12hd;
         -- missing declaration for a_frs1516_test_item.bont13hd;
         -- missing declaration for a_frs1516_test_item.bont11sp;
         -- missing declaration for a_frs1516_test_item.bont12sp;
         -- missing declaration for a_frs1516_test_item.bont13sp;
         -- missing declaration for a_frs1516_test_item.bont21hd;
         -- missing declaration for a_frs1516_test_item.bont22hd;
         -- missing declaration for a_frs1516_test_item.bont23hd;
         -- missing declaration for a_frs1516_test_item.bont21sp;
         -- missing declaration for a_frs1516_test_item.bont22sp;
         -- missing declaration for a_frs1516_test_item.bont23sp;
         -- missing declaration for a_frs1516_test_item.bont31hd;
         -- missing declaration for a_frs1516_test_item.bont32hd;
         -- missing declaration for a_frs1516_test_item.bont33hd;
         -- missing declaration for a_frs1516_test_item.bont31sp;
         -- missing declaration for a_frs1516_test_item.bont32sp;
         -- missing declaration for a_frs1516_test_item.bont33sp;
         -- missing declaration for a_frs1516_test_item.bont41hd;
         -- missing declaration for a_frs1516_test_item.bont42hd;
         -- missing declaration for a_frs1516_test_item.bont43hd;
         -- missing declaration for a_frs1516_test_item.bont41sp;
         -- missing declaration for a_frs1516_test_item.bont42sp;
         -- missing declaration for a_frs1516_test_item.bont43sp;
         -- missing declaration for a_frs1516_test_item.bont51hd;
         -- missing declaration for a_frs1516_test_item.bont52hd;
         -- missing declaration for a_frs1516_test_item.bont53hd;
         -- missing declaration for a_frs1516_test_item.bont51sp;
         -- missing declaration for a_frs1516_test_item.bont52sp;
         -- missing declaration for a_frs1516_test_item.bont53sp;
         -- missing declaration for a_frs1516_test_item.bont61hd;
         -- missing declaration for a_frs1516_test_item.bont62hd;
         -- missing declaration for a_frs1516_test_item.bont63hd;
         -- missing declaration for a_frs1516_test_item.bont61sp;
         -- missing declaration for a_frs1516_test_item.bont62sp;
         -- missing declaration for a_frs1516_test_item.bont63sp;
         a_frs1516_test_item.btax11hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.btax12hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.btax13hd;
         a_frs1516_test_item.btax11sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.btax12sp;
         -- missing declaration for a_frs1516_test_item.btax13sp;
         a_frs1516_test_item.btax21hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.btax22hd;
         -- missing declaration for a_frs1516_test_item.btax23hd;
         a_frs1516_test_item.btax21sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.btax22sp;
         -- missing declaration for a_frs1516_test_item.btax23sp;
         a_frs1516_test_item.btax31hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.btax32hd;
         -- missing declaration for a_frs1516_test_item.btax33hd;
         a_frs1516_test_item.btax31sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.btax32sp;
         -- missing declaration for a_frs1516_test_item.btax33sp;
         a_frs1516_test_item.btax41hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.btax42hd;
         -- missing declaration for a_frs1516_test_item.btax43hd;
         a_frs1516_test_item.btax41sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.btax42sp;
         -- missing declaration for a_frs1516_test_item.btax43sp;
         a_frs1516_test_item.btax51hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.btax52hd;
         -- missing declaration for a_frs1516_test_item.btax53hd;
         a_frs1516_test_item.btax51sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.btax52sp;
         -- missing declaration for a_frs1516_test_item.btax53sp;
         a_frs1516_test_item.btax61hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.btax62hd;
         -- missing declaration for a_frs1516_test_item.btax63hd;
         -- missing declaration for a_frs1516_test_item.btax61sp;
         -- missing declaration for a_frs1516_test_item.btax62sp;
         -- missing declaration for a_frs1516_test_item.btax63sp;
         -- missing declaration for a_frs1516_test_item.busac1hd;
         -- missing declaration for a_frs1516_test_item.busac2hd;
         -- missing declaration for a_frs1516_test_item.busac3hd;
         -- missing declaration for a_frs1516_test_item.busac1sp;
         -- missing declaration for a_frs1516_test_item.busac2sp;
         -- missing declaration for a_frs1516_test_item.busac3sp;
         a_frs1516_test_item.caram1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.caram2hd;
         -- missing declaration for a_frs1516_test_item.caram3hd;
         a_frs1516_test_item.caram1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.caram2sp;
         -- missing declaration for a_frs1516_test_item.caram3sp;
         -- missing declaration for a_frs1516_test_item.carcn1hd;
         -- missing declaration for a_frs1516_test_item.carcn2hd;
         -- missing declaration for a_frs1516_test_item.carcn3hd;
         -- missing declaration for a_frs1516_test_item.carcn1sp;
         -- missing declaration for a_frs1516_test_item.carcn2sp;
         -- missing declaration for a_frs1516_test_item.carcn3sp;
         -- missing declaration for a_frs1516_test_item.carvl1hd;
         -- missing declaration for a_frs1516_test_item.carvl2hd;
         -- missing declaration for a_frs1516_test_item.carvl3hd;
         -- missing declaration for a_frs1516_test_item.carvl1sp;
         -- missing declaration for a_frs1516_test_item.carvl2sp;
         -- missing declaration for a_frs1516_test_item.carvl3sp;
         -- missing declaration for a_frs1516_test_item.chktx1hd;
         -- missing declaration for a_frs1516_test_item.chktx2hd;
         -- missing declaration for a_frs1516_test_item.chktx3hd;
         -- missing declaration for a_frs1516_test_item.chktx1sp;
         -- missing declaration for a_frs1516_test_item.chktx2sp;
         -- missing declaration for a_frs1516_test_item.chktx3sp;
         -- missing declaration for a_frs1516_test_item.chcom1hd;
         -- missing declaration for a_frs1516_test_item.chcom2hd;
         -- missing declaration for a_frs1516_test_item.chcom3hd;
         -- missing declaration for a_frs1516_test_item.chcom1sp;
         -- missing declaration for a_frs1516_test_item.chcom2sp;
         -- missing declaration for a_frs1516_test_item.chcom3sp;
         a_frs1516_test_item.chvam1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.chvam2hd;
         -- missing declaration for a_frs1516_test_item.chvam3hd;
         a_frs1516_test_item.chvam1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.chvam2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.chvam3sp;
         -- missing declaration for a_frs1516_test_item.chvpd1hd;
         -- missing declaration for a_frs1516_test_item.chvpd2hd;
         -- missing declaration for a_frs1516_test_item.chvpd3hd;
         -- missing declaration for a_frs1516_test_item.chvpd1sp;
         -- missing declaration for a_frs1516_test_item.chvpd2sp;
         -- missing declaration for a_frs1516_test_item.chvpd3sp;
         -- missing declaration for a_frs1516_test_item.chsac1hd;
         -- missing declaration for a_frs1516_test_item.chsac2hd;
         -- missing declaration for a_frs1516_test_item.chsac3hd;
         -- missing declaration for a_frs1516_test_item.chsac1sp;
         -- missing declaration for a_frs1516_test_item.chsac2sp;
         -- missing declaration for a_frs1516_test_item.chsac3sp;
         -- missing declaration for a_frs1516_test_item.chuam1hd;
         -- missing declaration for a_frs1516_test_item.chuam2hd;
         -- missing declaration for a_frs1516_test_item.chuam3hd;
         -- missing declaration for a_frs1516_test_item.chuam1sp;
         -- missing declaration for a_frs1516_test_item.chuam2sp;
         -- missing declaration for a_frs1516_test_item.chuam3sp;
         -- missing declaration for a_frs1516_test_item.chupd1hd;
         -- missing declaration for a_frs1516_test_item.chupd2hd;
         -- missing declaration for a_frs1516_test_item.chupd3hd;
         -- missing declaration for a_frs1516_test_item.chupd1sp;
         -- missing declaration for a_frs1516_test_item.chupd2sp;
         -- missing declaration for a_frs1516_test_item.chupd3sp;
         -- missing declaration for a_frs1516_test_item.chusu1hd;
         -- missing declaration for a_frs1516_test_item.chusu2hd;
         -- missing declaration for a_frs1516_test_item.chusu3hd;
         -- missing declaration for a_frs1516_test_item.chusu1sp;
         -- missing declaration for a_frs1516_test_item.chusu2sp;
         -- missing declaration for a_frs1516_test_item.chusu3sp;
         a_frs1516_test_item.doth1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.doth2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.doth3hd;
         a_frs1516_test_item.doth1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.doth2sp;
         -- missing declaration for a_frs1516_test_item.doth3sp;
         a_frs1516_test_item.dpen1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.dpen2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dpen3hd;
         a_frs1516_test_item.dpen1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.dpen2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dpen3sp;
         a_frs1516_test_item.davc1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.davc2hd;
         -- missing declaration for a_frs1516_test_item.davc3hd;
         a_frs1516_test_item.davc1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.davc2sp;
         -- missing declaration for a_frs1516_test_item.davc3sp;
         a_frs1516_test_item.dtuf1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.dtuf2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dtuf3hd;
         a_frs1516_test_item.dtuf1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.dtuf2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dtuf3sp;
         a_frs1516_test_item.dfrso1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dfrso2hd;
         -- missing declaration for a_frs1516_test_item.dfrso3hd;
         a_frs1516_test_item.dfrso1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dfrso2sp;
         -- missing declaration for a_frs1516_test_item.dfrso3sp;
         a_frs1516_test_item.dspor1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dspor2hd;
         -- missing declaration for a_frs1516_test_item.dspor3hd;
         a_frs1516_test_item.dspor1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dspor2sp;
         -- missing declaration for a_frs1516_test_item.dspor3sp;
         a_frs1516_test_item.drepl1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.drepl2hd;
         -- missing declaration for a_frs1516_test_item.drepl3hd;
         a_frs1516_test_item.drepl1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.drepl2sp;
         -- missing declaration for a_frs1516_test_item.drepl3sp;
         a_frs1516_test_item.dmed1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dmed2hd;
         -- missing declaration for a_frs1516_test_item.dmed3hd;
         a_frs1516_test_item.dmed1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dmed2sp;
         -- missing declaration for a_frs1516_test_item.dmed3sp;
         a_frs1516_test_item.dchar1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.dchar2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dchar3hd;
         a_frs1516_test_item.dchar1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dchar2sp;
         -- missing declaration for a_frs1516_test_item.dchar3sp;
         a_frs1516_test_item.dslrp1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dslrp2hd;
         -- missing declaration for a_frs1516_test_item.dslrp3hd;
         a_frs1516_test_item.dslrp1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dslrp2sp;
         -- missing declaration for a_frs1516_test_item.dslrp3sp;
         -- missing declaration for a_frs1516_test_item.dirni1hd;
         -- missing declaration for a_frs1516_test_item.dirni2hd;
         -- missing declaration for a_frs1516_test_item.dirni3hd;
         -- missing declaration for a_frs1516_test_item.dirni1sp;
         -- missing declaration for a_frs1516_test_item.dirni2sp;
         -- missing declaration for a_frs1516_test_item.dirni3sp;
         -- missing declaration for a_frs1516_test_item.totov1hd;
         -- missing declaration for a_frs1516_test_item.totov2hd;
         -- missing declaration for a_frs1516_test_item.totov3hd;
         -- missing declaration for a_frs1516_test_item.totov1sp;
         -- missing declaration for a_frs1516_test_item.totov2sp;
         -- missing declaration for a_frs1516_test_item.totov3sp;
         a_frs1516_test_item.dvuhr1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.dvuhr2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.dvuhr3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.dvuhr1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.dvuhr2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.dvuhr3sp;
         -- missing declaration for a_frs1516_test_item.empan1hd;
         -- missing declaration for a_frs1516_test_item.empan2hd;
         -- missing declaration for a_frs1516_test_item.empan3hd;
         -- missing declaration for a_frs1516_test_item.empan1sp;
         -- missing declaration for a_frs1516_test_item.empan2sp;
         -- missing declaration for a_frs1516_test_item.empan3sp;
         -- missing declaration for a_frs1516_test_item.empen1hd;
         -- missing declaration for a_frs1516_test_item.empen2hd;
         -- missing declaration for a_frs1516_test_item.empen3hd;
         -- missing declaration for a_frs1516_test_item.empen1sp;
         -- missing declaration for a_frs1516_test_item.empen2sp;
         -- missing declaration for a_frs1516_test_item.empen3sp;
         -- missing declaration for a_frs1516_test_item.etype1hd;
         -- missing declaration for a_frs1516_test_item.etype2hd;
         -- missing declaration for a_frs1516_test_item.etype3hd;
         -- missing declaration for a_frs1516_test_item.etype1sp;
         -- missing declaration for a_frs1516_test_item.etype2sp;
         -- missing declaration for a_frs1516_test_item.etype3sp;
         -- missing declaration for a_frs1516_test_item.evrot1hd;
         -- missing declaration for a_frs1516_test_item.evrot2hd;
         -- missing declaration for a_frs1516_test_item.evrot3hd;
         -- missing declaration for a_frs1516_test_item.evrot1sp;
         -- missing declaration for a_frs1516_test_item.evrot2sp;
         -- missing declaration for a_frs1516_test_item.evrot3sp;
         -- missing declaration for a_frs1516_test_item.exb011hd;
         -- missing declaration for a_frs1516_test_item.exb012hd;
         -- missing declaration for a_frs1516_test_item.exb013hd;
         -- missing declaration for a_frs1516_test_item.exb011sp;
         -- missing declaration for a_frs1516_test_item.exb012sp;
         -- missing declaration for a_frs1516_test_item.exb013sp;
         -- missing declaration for a_frs1516_test_item.exb021hd;
         -- missing declaration for a_frs1516_test_item.exb022hd;
         -- missing declaration for a_frs1516_test_item.exb023hd;
         -- missing declaration for a_frs1516_test_item.exb021sp;
         -- missing declaration for a_frs1516_test_item.exb022sp;
         -- missing declaration for a_frs1516_test_item.exb023sp;
         -- missing declaration for a_frs1516_test_item.exb031hd;
         -- missing declaration for a_frs1516_test_item.exb032hd;
         -- missing declaration for a_frs1516_test_item.exb033hd;
         -- missing declaration for a_frs1516_test_item.exb031sp;
         -- missing declaration for a_frs1516_test_item.exb032sp;
         -- missing declaration for a_frs1516_test_item.exb033sp;
         -- missing declaration for a_frs1516_test_item.exb041hd;
         -- missing declaration for a_frs1516_test_item.exb042hd;
         -- missing declaration for a_frs1516_test_item.exb043hd;
         -- missing declaration for a_frs1516_test_item.exb041sp;
         -- missing declaration for a_frs1516_test_item.exb042sp;
         -- missing declaration for a_frs1516_test_item.exb043sp;
         -- missing declaration for a_frs1516_test_item.exb051hd;
         -- missing declaration for a_frs1516_test_item.exb052hd;
         -- missing declaration for a_frs1516_test_item.exb053hd;
         -- missing declaration for a_frs1516_test_item.exb051sp;
         -- missing declaration for a_frs1516_test_item.exb052sp;
         -- missing declaration for a_frs1516_test_item.exb053sp;
         -- missing declaration for a_frs1516_test_item.exb061hd;
         -- missing declaration for a_frs1516_test_item.exb062hd;
         -- missing declaration for a_frs1516_test_item.exb063hd;
         -- missing declaration for a_frs1516_test_item.exb061sp;
         -- missing declaration for a_frs1516_test_item.exb062sp;
         -- missing declaration for a_frs1516_test_item.exb063sp;
         -- missing declaration for a_frs1516_test_item.exb071hd;
         -- missing declaration for a_frs1516_test_item.exb072hd;
         -- missing declaration for a_frs1516_test_item.exb073hd;
         -- missing declaration for a_frs1516_test_item.exb071sp;
         -- missing declaration for a_frs1516_test_item.exb072sp;
         -- missing declaration for a_frs1516_test_item.exb073sp;
         -- missing declaration for a_frs1516_test_item.exb081hd;
         -- missing declaration for a_frs1516_test_item.exb082hd;
         -- missing declaration for a_frs1516_test_item.exb083hd;
         -- missing declaration for a_frs1516_test_item.exb081sp;
         -- missing declaration for a_frs1516_test_item.exb082sp;
         -- missing declaration for a_frs1516_test_item.exb083sp;
         -- missing declaration for a_frs1516_test_item.exb091hd;
         -- missing declaration for a_frs1516_test_item.exb092hd;
         -- missing declaration for a_frs1516_test_item.exb093hd;
         -- missing declaration for a_frs1516_test_item.exb091sp;
         -- missing declaration for a_frs1516_test_item.exb092sp;
         -- missing declaration for a_frs1516_test_item.exb093sp;
         -- missing declaration for a_frs1516_test_item.exb101hd;
         -- missing declaration for a_frs1516_test_item.exb102hd;
         -- missing declaration for a_frs1516_test_item.exb103hd;
         -- missing declaration for a_frs1516_test_item.exb101sp;
         -- missing declaration for a_frs1516_test_item.exb102sp;
         -- missing declaration for a_frs1516_test_item.exb103sp;
         -- missing declaration for a_frs1516_test_item.exb111hd;
         -- missing declaration for a_frs1516_test_item.exb112hd;
         -- missing declaration for a_frs1516_test_item.exb113hd;
         -- missing declaration for a_frs1516_test_item.exb111sp;
         -- missing declaration for a_frs1516_test_item.exb112sp;
         -- missing declaration for a_frs1516_test_item.exb113sp;
         -- missing declaration for a_frs1516_test_item.exb121hd;
         -- missing declaration for a_frs1516_test_item.exb122hd;
         -- missing declaration for a_frs1516_test_item.exb123hd;
         -- missing declaration for a_frs1516_test_item.exb121sp;
         -- missing declaration for a_frs1516_test_item.exb122sp;
         -- missing declaration for a_frs1516_test_item.exb123sp;
         -- missing declaration for a_frs1516_test_item.ftpt1hd;
         -- missing declaration for a_frs1516_test_item.ftpt2hd;
         -- missing declaration for a_frs1516_test_item.ftpt3hd;
         -- missing declaration for a_frs1516_test_item.ftpt1sp;
         -- missing declaration for a_frs1516_test_item.ftpt2sp;
         -- missing declaration for a_frs1516_test_item.ftpt3sp;
         a_frs1516_test_item.fulam1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.fulam2hd;
         -- missing declaration for a_frs1516_test_item.fulam3hd;
         a_frs1516_test_item.fulam1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.fulam2sp;
         -- missing declaration for a_frs1516_test_item.fulam3sp;
         -- missing declaration for a_frs1516_test_item.fulbn1hd;
         -- missing declaration for a_frs1516_test_item.fulbn2hd;
         -- missing declaration for a_frs1516_test_item.fulbn3hd;
         -- missing declaration for a_frs1516_test_item.fulbn1sp;
         -- missing declaration for a_frs1516_test_item.fulbn2sp;
         -- missing declaration for a_frs1516_test_item.fulbn3sp;
         -- missing declaration for a_frs1516_test_item.fulpd1hd;
         -- missing declaration for a_frs1516_test_item.fulpd2hd;
         -- missing declaration for a_frs1516_test_item.fulpd3hd;
         -- missing declaration for a_frs1516_test_item.fulpd1sp;
         -- missing declaration for a_frs1516_test_item.fulpd2sp;
         -- missing declaration for a_frs1516_test_item.fulpd3sp;
         -- missing declaration for a_frs1516_test_item.fulty1hd;
         -- missing declaration for a_frs1516_test_item.fulty2hd;
         -- missing declaration for a_frs1516_test_item.fulty3hd;
         -- missing declaration for a_frs1516_test_item.fulty1sp;
         -- missing declaration for a_frs1516_test_item.fulty2sp;
         -- missing declaration for a_frs1516_test_item.fulty3sp;
         -- missing declaration for a_frs1516_test_item.fluam1hd;
         -- missing declaration for a_frs1516_test_item.fluam2hd;
         -- missing declaration for a_frs1516_test_item.fluam3hd;
         -- missing declaration for a_frs1516_test_item.fluam1sp;
         -- missing declaration for a_frs1516_test_item.fluam2sp;
         -- missing declaration for a_frs1516_test_item.fluam3sp;
         -- missing declaration for a_frs1516_test_item.flupd1hd;
         -- missing declaration for a_frs1516_test_item.flupd2hd;
         -- missing declaration for a_frs1516_test_item.flupd3hd;
         -- missing declaration for a_frs1516_test_item.flupd1sp;
         -- missing declaration for a_frs1516_test_item.flupd2sp;
         -- missing declaration for a_frs1516_test_item.flupd3sp;
         -- missing declaration for a_frs1516_test_item.flusu1hd;
         -- missing declaration for a_frs1516_test_item.flusu2hd;
         -- missing declaration for a_frs1516_test_item.flusu3hd;
         -- missing declaration for a_frs1516_test_item.flusu1sp;
         -- missing declaration for a_frs1516_test_item.flusu2sp;
         -- missing declaration for a_frs1516_test_item.flusu3sp;
         a_frs1516_test_item.grwag1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.grwag2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.grwag3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.grwag1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.grwag2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.grwag3sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.grwap1hd;
         -- missing declaration for a_frs1516_test_item.grwap2hd;
         -- missing declaration for a_frs1516_test_item.grwap3hd;
         -- missing declaration for a_frs1516_test_item.grwap1sp;
         -- missing declaration for a_frs1516_test_item.grwap2sp;
         -- missing declaration for a_frs1516_test_item.grwap3sp;
         a_frs1516_test_item.hha11hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.hha12hd;
         a_frs1516_test_item.hha13hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.hha11sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.hha12sp;
         -- missing declaration for a_frs1516_test_item.hha13sp;
         a_frs1516_test_item.hha21hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.hha22hd;
         a_frs1516_test_item.hha23hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.hha21sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.hha22sp;
         -- missing declaration for a_frs1516_test_item.hha23sp;
         -- missing declaration for a_frs1516_test_item.hha31hd;
         -- missing declaration for a_frs1516_test_item.hha32hd;
         -- missing declaration for a_frs1516_test_item.hha33hd;
         -- missing declaration for a_frs1516_test_item.hha31sp;
         -- missing declaration for a_frs1516_test_item.hha32sp;
         -- missing declaration for a_frs1516_test_item.hha33sp;
         -- missing declaration for a_frs1516_test_item.hour1hd;
         -- missing declaration for a_frs1516_test_item.hour2hd;
         -- missing declaration for a_frs1516_test_item.hour3hd;
         -- missing declaration for a_frs1516_test_item.hour1sp;
         -- missing declaration for a_frs1516_test_item.hour2sp;
         -- missing declaration for a_frs1516_test_item.hour3sp;
         a_frs1516_test_item.hrrte1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.hrrte2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.hrrte3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.hrrte1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.hrrte2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.hrrte3sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ipay11hd;
         -- missing declaration for a_frs1516_test_item.ipay12hd;
         -- missing declaration for a_frs1516_test_item.ipay13hd;
         -- missing declaration for a_frs1516_test_item.ipay11sp;
         -- missing declaration for a_frs1516_test_item.ipay12sp;
         -- missing declaration for a_frs1516_test_item.ipay13sp;
         -- missing declaration for a_frs1516_test_item.ipay21hd;
         -- missing declaration for a_frs1516_test_item.ipay22hd;
         -- missing declaration for a_frs1516_test_item.ipay23hd;
         -- missing declaration for a_frs1516_test_item.ipay21sp;
         -- missing declaration for a_frs1516_test_item.ipay22sp;
         -- missing declaration for a_frs1516_test_item.ipay23sp;
         -- missing declaration for a_frs1516_test_item.ipay31hd;
         -- missing declaration for a_frs1516_test_item.ipay32hd;
         -- missing declaration for a_frs1516_test_item.ipay33hd;
         -- missing declaration for a_frs1516_test_item.ipay31sp;
         -- missing declaration for a_frs1516_test_item.ipay32sp;
         -- missing declaration for a_frs1516_test_item.ipay33sp;
         -- missing declaration for a_frs1516_test_item.ipay41hd;
         -- missing declaration for a_frs1516_test_item.ipay42hd;
         -- missing declaration for a_frs1516_test_item.ipay43hd;
         -- missing declaration for a_frs1516_test_item.ipay41sp;
         -- missing declaration for a_frs1516_test_item.ipay42sp;
         -- missing declaration for a_frs1516_test_item.ipay43sp;
         -- missing declaration for a_frs1516_test_item.ipay51hd;
         -- missing declaration for a_frs1516_test_item.ipay52hd;
         -- missing declaration for a_frs1516_test_item.ipay53hd;
         -- missing declaration for a_frs1516_test_item.ipay51sp;
         -- missing declaration for a_frs1516_test_item.ipay52sp;
         -- missing declaration for a_frs1516_test_item.ipay53sp;
         -- missing declaration for a_frs1516_test_item.ipay61hd;
         -- missing declaration for a_frs1516_test_item.ipay62hd;
         -- missing declaration for a_frs1516_test_item.ipay63hd;
         -- missing declaration for a_frs1516_test_item.ipay61sp;
         -- missing declaration for a_frs1516_test_item.ipay62sp;
         -- missing declaration for a_frs1516_test_item.ipay63sp;
         -- missing declaration for a_frs1516_test_item.ipay71hd;
         -- missing declaration for a_frs1516_test_item.ipay72hd;
         -- missing declaration for a_frs1516_test_item.ipay73hd;
         -- missing declaration for a_frs1516_test_item.ipay71sp;
         -- missing declaration for a_frs1516_test_item.ipay72sp;
         -- missing declaration for a_frs1516_test_item.ipay73sp;
         -- missing declaration for a_frs1516_test_item.jbchg1hd;
         -- missing declaration for a_frs1516_test_item.jbchg2hd;
         -- missing declaration for a_frs1516_test_item.jbchg3hd;
         -- missing declaration for a_frs1516_test_item.jbchg1sp;
         -- missing declaration for a_frs1516_test_item.jbchg2sp;
         -- missing declaration for a_frs1516_test_item.jbchg3sp;
         -- missing declaration for a_frs1516_test_item.jobus1hd;
         -- missing declaration for a_frs1516_test_item.jobus2hd;
         -- missing declaration for a_frs1516_test_item.jobus3hd;
         -- missing declaration for a_frs1516_test_item.jobus1sp;
         -- missing declaration for a_frs1516_test_item.jobus2sp;
         -- missing declaration for a_frs1516_test_item.jobus3sp;
         a_frs1516_test_item.jbhrs1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.jbhrs2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.jbhrs3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.jbhrs1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.jbhrs2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.jbhrs3sp;
         -- missing declaration for a_frs1516_test_item.lt301hd;
         -- missing declaration for a_frs1516_test_item.lt302hd;
         -- missing declaration for a_frs1516_test_item.lt303hd;
         -- missing declaration for a_frs1516_test_item.lt301sp;
         -- missing declaration for a_frs1516_test_item.lt302sp;
         -- missing declaration for a_frs1516_test_item.lt303sp;
         -- missing declaration for a_frs1516_test_item.madem1hd;
         -- missing declaration for a_frs1516_test_item.madem2hd;
         -- missing declaration for a_frs1516_test_item.madem3hd;
         -- missing declaration for a_frs1516_test_item.madem1sp;
         -- missing declaration for a_frs1516_test_item.madem2sp;
         -- missing declaration for a_frs1516_test_item.madem3sp;
         a_frs1516_test_item.mile1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.mile2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.mile3hd;
         a_frs1516_test_item.mile1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.mile2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.mile3sp;
         a_frs1516_test_item.moref1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.moref2hd;
         -- missing declaration for a_frs1516_test_item.moref3hd;
         a_frs1516_test_item.moref1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.moref2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.moref3sp;
         a_frs1516_test_item.nic1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.nic2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.nic3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.nic1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.nic2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.nic3sp;
         a_frs1516_test_item.nidam1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.nidam2hd;
         -- missing declaration for a_frs1516_test_item.nidam3hd;
         a_frs1516_test_item.nidam1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.nidam2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.nidam3sp;
         -- missing declaration for a_frs1516_test_item.nipd1hd;
         -- missing declaration for a_frs1516_test_item.nipd2hd;
         -- missing declaration for a_frs1516_test_item.nipd3hd;
         -- missing declaration for a_frs1516_test_item.nipd1sp;
         -- missing declaration for a_frs1516_test_item.nipd2sp;
         -- missing declaration for a_frs1516_test_item.nipd3sp;
         -- missing declaration for a_frs1516_test_item.noemp1hd;
         -- missing declaration for a_frs1516_test_item.noemp2hd;
         -- missing declaration for a_frs1516_test_item.noemp3hd;
         -- missing declaration for a_frs1516_test_item.noemp1sp;
         -- missing declaration for a_frs1516_test_item.noemp2sp;
         -- missing declaration for a_frs1516_test_item.noemp3sp;
         -- missing declaration for a_frs1516_test_item.oremp1hd;
         -- missing declaration for a_frs1516_test_item.oremp2hd;
         -- missing declaration for a_frs1516_test_item.oremp3hd;
         -- missing declaration for a_frs1516_test_item.oremp1sp;
         -- missing declaration for a_frs1516_test_item.oremp2sp;
         -- missing declaration for a_frs1516_test_item.oremp3sp;
         -- missing declaration for a_frs1516_test_item.othd11hd;
         -- missing declaration for a_frs1516_test_item.othd12hd;
         -- missing declaration for a_frs1516_test_item.othd13hd;
         -- missing declaration for a_frs1516_test_item.othd11sp;
         -- missing declaration for a_frs1516_test_item.othd12sp;
         -- missing declaration for a_frs1516_test_item.othd13sp;
         -- missing declaration for a_frs1516_test_item.othd21hd;
         -- missing declaration for a_frs1516_test_item.othd22hd;
         -- missing declaration for a_frs1516_test_item.othd23hd;
         -- missing declaration for a_frs1516_test_item.othd21sp;
         -- missing declaration for a_frs1516_test_item.othd22sp;
         -- missing declaration for a_frs1516_test_item.othd23sp;
         -- missing declaration for a_frs1516_test_item.othd31hd;
         -- missing declaration for a_frs1516_test_item.othd32hd;
         -- missing declaration for a_frs1516_test_item.othd33hd;
         -- missing declaration for a_frs1516_test_item.othd31sp;
         -- missing declaration for a_frs1516_test_item.othd32sp;
         -- missing declaration for a_frs1516_test_item.othd33sp;
         -- missing declaration for a_frs1516_test_item.othd41hd;
         -- missing declaration for a_frs1516_test_item.othd42hd;
         -- missing declaration for a_frs1516_test_item.othd43hd;
         -- missing declaration for a_frs1516_test_item.othd41sp;
         -- missing declaration for a_frs1516_test_item.othd42sp;
         -- missing declaration for a_frs1516_test_item.othd43sp;
         -- missing declaration for a_frs1516_test_item.othd51hd;
         -- missing declaration for a_frs1516_test_item.othd52hd;
         -- missing declaration for a_frs1516_test_item.othd53hd;
         -- missing declaration for a_frs1516_test_item.othd51sp;
         -- missing declaration for a_frs1516_test_item.othd52sp;
         -- missing declaration for a_frs1516_test_item.othd53sp;
         -- missing declaration for a_frs1516_test_item.othd61hd;
         -- missing declaration for a_frs1516_test_item.othd62hd;
         -- missing declaration for a_frs1516_test_item.othd63hd;
         -- missing declaration for a_frs1516_test_item.othd61sp;
         -- missing declaration for a_frs1516_test_item.othd62sp;
         -- missing declaration for a_frs1516_test_item.othd63sp;
         -- missing declaration for a_frs1516_test_item.othd71hd;
         -- missing declaration for a_frs1516_test_item.othd72hd;
         -- missing declaration for a_frs1516_test_item.othd73hd;
         -- missing declaration for a_frs1516_test_item.othd71sp;
         -- missing declaration for a_frs1516_test_item.othd72sp;
         -- missing declaration for a_frs1516_test_item.othd73sp;
         -- missing declaration for a_frs1516_test_item.othd81hd;
         -- missing declaration for a_frs1516_test_item.othd82hd;
         -- missing declaration for a_frs1516_test_item.othd83hd;
         -- missing declaration for a_frs1516_test_item.othd81sp;
         -- missing declaration for a_frs1516_test_item.othd82sp;
         -- missing declaration for a_frs1516_test_item.othd83sp;
         -- missing declaration for a_frs1516_test_item.othd91hd;
         -- missing declaration for a_frs1516_test_item.othd92hd;
         -- missing declaration for a_frs1516_test_item.othd93hd;
         -- missing declaration for a_frs1516_test_item.othd91sp;
         -- missing declaration for a_frs1516_test_item.othd92sp;
         -- missing declaration for a_frs1516_test_item.othd93sp;
         -- missing declaration for a_frs1516_test_item.otd101hd;
         -- missing declaration for a_frs1516_test_item.otd102hd;
         -- missing declaration for a_frs1516_test_item.otd103hd;
         -- missing declaration for a_frs1516_test_item.otd101sp;
         -- missing declaration for a_frs1516_test_item.otd102sp;
         -- missing declaration for a_frs1516_test_item.otd103sp;
         a_frs1516_test_item.ownam1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ownam2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ownam3hd;
         a_frs1516_test_item.ownam1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ownam2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ownam3sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ownoa1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ownoa2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ownoa3hd;
         a_frs1516_test_item.ownoa1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ownoa2sp;
         -- missing declaration for a_frs1516_test_item.ownoa3sp;
         -- missing declaration for a_frs1516_test_item.ownot1hd;
         -- missing declaration for a_frs1516_test_item.ownot2hd;
         -- missing declaration for a_frs1516_test_item.ownot3hd;
         -- missing declaration for a_frs1516_test_item.ownot1sp;
         -- missing declaration for a_frs1516_test_item.ownot2sp;
         -- missing declaration for a_frs1516_test_item.ownot3sp;
         -- missing declaration for a_frs1516_test_item.ownsm1hd;
         -- missing declaration for a_frs1516_test_item.ownsm2hd;
         -- missing declaration for a_frs1516_test_item.ownsm3hd;
         -- missing declaration for a_frs1516_test_item.ownsm1sp;
         -- missing declaration for a_frs1516_test_item.ownsm2sp;
         -- missing declaration for a_frs1516_test_item.ownsm3sp;
         -- missing declaration for a_frs1516_test_item.pappd1hd;
         -- missing declaration for a_frs1516_test_item.pappd2hd;
         -- missing declaration for a_frs1516_test_item.pappd3hd;
         -- missing declaration for a_frs1516_test_item.pappd1sp;
         -- missing declaration for a_frs1516_test_item.pappd2sp;
         -- missing declaration for a_frs1516_test_item.pappd3sp;
         a_frs1516_test_item.payam1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.payam2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.payam3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.payam1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.payam2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.payam3sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.pdate1hd;
         -- missing declaration for a_frs1516_test_item.pdate2hd;
         -- missing declaration for a_frs1516_test_item.pdate3hd;
         -- missing declaration for a_frs1516_test_item.pdate1sp;
         -- missing declaration for a_frs1516_test_item.pdate2sp;
         -- missing declaration for a_frs1516_test_item.pdate3sp;
         a_frs1516_test_item.paye1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.paye2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.paye3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.paye1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.paye2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.paye3sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.paype1hd;
         -- missing declaration for a_frs1516_test_item.paype2hd;
         -- missing declaration for a_frs1516_test_item.paype3hd;
         -- missing declaration for a_frs1516_test_item.paype1sp;
         -- missing declaration for a_frs1516_test_item.paype2sp;
         -- missing declaration for a_frs1516_test_item.paype3sp;
         -- missing declaration for a_frs1516_test_item.paysl1hd;
         -- missing declaration for a_frs1516_test_item.paysl2hd;
         -- missing declaration for a_frs1516_test_item.paysl3hd;
         -- missing declaration for a_frs1516_test_item.paysl1sp;
         -- missing declaration for a_frs1516_test_item.paysl2sp;
         -- missing declaration for a_frs1516_test_item.paysl3sp;
         -- missing declaration for a_frs1516_test_item.payus1hd;
         -- missing declaration for a_frs1516_test_item.payus2hd;
         -- missing declaration for a_frs1516_test_item.payus3hd;
         -- missing declaration for a_frs1516_test_item.payus1sp;
         -- missing declaration for a_frs1516_test_item.payus2sp;
         -- missing declaration for a_frs1516_test_item.payus3sp;
         a_frs1516_test_item.pothr1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.pothr2hd;
         -- missing declaration for a_frs1516_test_item.pothr3hd;
         a_frs1516_test_item.pothr1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.pothr2sp;
         -- missing declaration for a_frs1516_test_item.pothr3sp;
         -- missing declaration for a_frs1516_test_item.ppppd1hd;
         -- missing declaration for a_frs1516_test_item.ppppd2hd;
         -- missing declaration for a_frs1516_test_item.ppppd3hd;
         -- missing declaration for a_frs1516_test_item.ppppd1sp;
         -- missing declaration for a_frs1516_test_item.ppppd2sp;
         -- missing declaration for a_frs1516_test_item.ppppd3sp;
         a_frs1516_test_item.prbef1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.prbef2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.prbef3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.prbef1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.prbef2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.prbef3sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.prdoc1hd;
         -- missing declaration for a_frs1516_test_item.prdoc2hd;
         -- missing declaration for a_frs1516_test_item.prdoc3hd;
         -- missing declaration for a_frs1516_test_item.prdoc1sp;
         -- missing declaration for a_frs1516_test_item.prdoc2sp;
         -- missing declaration for a_frs1516_test_item.prdoc3sp;
         a_frs1516_test_item.sepro1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.sepro2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.sepro3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.sepro1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.sepro2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.sepro3sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.prolo1hd;
         -- missing declaration for a_frs1516_test_item.prolo2hd;
         -- missing declaration for a_frs1516_test_item.prolo3hd;
         -- missing declaration for a_frs1516_test_item.prolo1sp;
         -- missing declaration for a_frs1516_test_item.prolo2sp;
         -- missing declaration for a_frs1516_test_item.prolo3sp;
         -- missing declaration for a_frs1516_test_item.profn1hd;
         -- missing declaration for a_frs1516_test_item.profn2hd;
         -- missing declaration for a_frs1516_test_item.profn3hd;
         -- missing declaration for a_frs1516_test_item.profn1sp;
         -- missing declaration for a_frs1516_test_item.profn2sp;
         -- missing declaration for a_frs1516_test_item.profn3sp;
         -- missing declaration for a_frs1516_test_item.protx1hd;
         -- missing declaration for a_frs1516_test_item.protx2hd;
         -- missing declaration for a_frs1516_test_item.protx3hd;
         -- missing declaration for a_frs1516_test_item.protx1sp;
         -- missing declaration for a_frs1516_test_item.protx2sp;
         -- missing declaration for a_frs1516_test_item.protx3sp;
         -- missing declaration for a_frs1516_test_item.rspvr1hd;
         -- missing declaration for a_frs1516_test_item.rspvr2hd;
         -- missing declaration for a_frs1516_test_item.rspvr3hd;
         -- missing declaration for a_frs1516_test_item.rspvr1sp;
         -- missing declaration for a_frs1516_test_item.rspvr2sp;
         -- missing declaration for a_frs1516_test_item.rspvr3sp;
         -- missing declaration for a_frs1516_test_item.apamt1hd;
         -- missing declaration for a_frs1516_test_item.apamt2hd;
         -- missing declaration for a_frs1516_test_item.apamt3hd;
         -- missing declaration for a_frs1516_test_item.apamt1sp;
         -- missing declaration for a_frs1516_test_item.apamt2sp;
         -- missing declaration for a_frs1516_test_item.apamt3sp;
         -- missing declaration for a_frs1516_test_item.sebeg1hd;
         -- missing declaration for a_frs1516_test_item.sebeg2hd;
         -- missing declaration for a_frs1516_test_item.sebeg3hd;
         -- missing declaration for a_frs1516_test_item.sebeg1sp;
         -- missing declaration for a_frs1516_test_item.sebeg2sp;
         -- missing declaration for a_frs1516_test_item.sebeg3sp;
         -- missing declaration for a_frs1516_test_item.seend1hd;
         -- missing declaration for a_frs1516_test_item.seend2hd;
         -- missing declaration for a_frs1516_test_item.seend3hd;
         -- missing declaration for a_frs1516_test_item.seend1sp;
         -- missing declaration for a_frs1516_test_item.seend2sp;
         -- missing declaration for a_frs1516_test_item.seend3sp;
         -- missing declaration for a_frs1516_test_item.sectr1hd;
         -- missing declaration for a_frs1516_test_item.sectr2hd;
         -- missing declaration for a_frs1516_test_item.sectr3hd;
         -- missing declaration for a_frs1516_test_item.sectr1sp;
         -- missing declaration for a_frs1516_test_item.sectr2sp;
         -- missing declaration for a_frs1516_test_item.sectr3sp;
         -- missing declaration for a_frs1516_test_item.sectt1hd;
         -- missing declaration for a_frs1516_test_item.sectt2hd;
         -- missing declaration for a_frs1516_test_item.sectt3hd;
         -- missing declaration for a_frs1516_test_item.sectt1sp;
         -- missing declaration for a_frs1516_test_item.sectt2sp;
         -- missing declaration for a_frs1516_test_item.sectt3sp;
         -- missing declaration for a_frs1516_test_item.sefin1hd;
         -- missing declaration for a_frs1516_test_item.sefin2hd;
         -- missing declaration for a_frs1516_test_item.sefin3hd;
         -- missing declaration for a_frs1516_test_item.sefin1sp;
         -- missing declaration for a_frs1516_test_item.sefin2sp;
         -- missing declaration for a_frs1516_test_item.sefin3sp;
         a_frs1516_test_item.secam1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.secam2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.secam3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.secam1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.secam2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.secam3sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.seciw1hd;
         -- missing declaration for a_frs1516_test_item.seciw2hd;
         -- missing declaration for a_frs1516_test_item.seciw3hd;
         -- missing declaration for a_frs1516_test_item.seciw1sp;
         -- missing declaration for a_frs1516_test_item.seciw2sp;
         -- missing declaration for a_frs1516_test_item.seciw3sp;
         -- missing declaration for a_frs1516_test_item.sewks1hd;
         -- missing declaration for a_frs1516_test_item.sewks2hd;
         -- missing declaration for a_frs1516_test_item.sewks3hd;
         -- missing declaration for a_frs1516_test_item.sewks1sp;
         -- missing declaration for a_frs1516_test_item.sewks2sp;
         -- missing declaration for a_frs1516_test_item.sewks3sp;
         a_frs1516_test_item.senam1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.senam2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.senam3hd;
         a_frs1516_test_item.senam1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.senam2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.senam3sp;
         -- missing declaration for a_frs1516_test_item.seiin1hd;
         -- missing declaration for a_frs1516_test_item.seiin2hd;
         -- missing declaration for a_frs1516_test_item.seiin3hd;
         -- missing declaration for a_frs1516_test_item.seiin1sp;
         -- missing declaration for a_frs1516_test_item.seiin2sp;
         -- missing declaration for a_frs1516_test_item.seiin3sp;
         a_frs1516_test_item.senil1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.senil2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.senil3hd;
         a_frs1516_test_item.senil1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.senil2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.senil3sp;
         a_frs1516_test_item.senir1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.senir2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.senir3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.senir1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.senir2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.senir3sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.psenr1hd;
         -- missing declaration for a_frs1516_test_item.psenr2hd;
         -- missing declaration for a_frs1516_test_item.psenr3hd;
         -- missing declaration for a_frs1516_test_item.psenr1sp;
         -- missing declaration for a_frs1516_test_item.psenr2sp;
         -- missing declaration for a_frs1516_test_item.psenr3sp;
         a_frs1516_test_item.setax1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.setax2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.setax3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.setax1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.setax2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.setax3sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.smpam1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.smpam2hd;
         -- missing declaration for a_frs1516_test_item.smpam3hd;
         a_frs1516_test_item.smpam1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.smpam2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.smpam3sp;
         -- missing declaration for a_frs1516_test_item.smprt1hd;
         -- missing declaration for a_frs1516_test_item.smprt2hd;
         -- missing declaration for a_frs1516_test_item.smprt3hd;
         -- missing declaration for a_frs1516_test_item.smprt1sp;
         -- missing declaration for a_frs1516_test_item.smprt2sp;
         -- missing declaration for a_frs1516_test_item.smprt3sp;
         -- missing declaration for a_frs1516_test_item.sole1hd;
         -- missing declaration for a_frs1516_test_item.sole2hd;
         -- missing declaration for a_frs1516_test_item.sole3hd;
         -- missing declaration for a_frs1516_test_item.sole1sp;
         -- missing declaration for a_frs1516_test_item.sole2sp;
         -- missing declaration for a_frs1516_test_item.sole3sp;
         a_frs1516_test_item.spamt1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.spamt2hd;
         -- missing declaration for a_frs1516_test_item.spamt3hd;
         a_frs1516_test_item.spamt1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.spamt2sp;
         -- missing declaration for a_frs1516_test_item.spamt3sp;
         -- missing declaration for a_frs1516_test_item.sppd1hd;
         -- missing declaration for a_frs1516_test_item.sppd2hd;
         -- missing declaration for a_frs1516_test_item.sppd3hd;
         -- missing declaration for a_frs1516_test_item.sppd1sp;
         -- missing declaration for a_frs1516_test_item.sppd2sp;
         -- missing declaration for a_frs1516_test_item.sppd3sp;
         -- missing declaration for a_frs1516_test_item.spsac1hd;
         -- missing declaration for a_frs1516_test_item.spsac2hd;
         -- missing declaration for a_frs1516_test_item.spsac3hd;
         -- missing declaration for a_frs1516_test_item.spsac1sp;
         -- missing declaration for a_frs1516_test_item.spsac2sp;
         -- missing declaration for a_frs1516_test_item.spsac3sp;
         a_frs1516_test_item.spuam1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.spuam2hd;
         -- missing declaration for a_frs1516_test_item.spuam3hd;
         -- missing declaration for a_frs1516_test_item.spuam1sp;
         -- missing declaration for a_frs1516_test_item.spuam2sp;
         -- missing declaration for a_frs1516_test_item.spuam3sp;
         -- missing declaration for a_frs1516_test_item.spupd1hd;
         -- missing declaration for a_frs1516_test_item.spupd2hd;
         -- missing declaration for a_frs1516_test_item.spupd3hd;
         -- missing declaration for a_frs1516_test_item.spupd1sp;
         -- missing declaration for a_frs1516_test_item.spupd2sp;
         -- missing declaration for a_frs1516_test_item.spupd3sp;
         -- missing declaration for a_frs1516_test_item.spusu1hd;
         -- missing declaration for a_frs1516_test_item.spusu2hd;
         -- missing declaration for a_frs1516_test_item.spusu3hd;
         -- missing declaration for a_frs1516_test_item.spusu1sp;
         -- missing declaration for a_frs1516_test_item.spusu2sp;
         -- missing declaration for a_frs1516_test_item.spusu3sp;
         a_frs1516_test_item.ppamt1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ppamt2hd;
         -- missing declaration for a_frs1516_test_item.ppamt3hd;
         a_frs1516_test_item.ppamt1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ppamt2sp;
         -- missing declaration for a_frs1516_test_item.ppamt3sp;
         a_frs1516_test_item.sspam1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.sspam2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.sspam3hd;
         a_frs1516_test_item.sspam1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.sspam2sp;
         -- missing declaration for a_frs1516_test_item.sspam3sp;
         -- missing declaration for a_frs1516_test_item.spsmp1hd;
         -- missing declaration for a_frs1516_test_item.spsmp2hd;
         -- missing declaration for a_frs1516_test_item.spsmp3hd;
         -- missing declaration for a_frs1516_test_item.spsmp1sp;
         -- missing declaration for a_frs1516_test_item.spsmp2sp;
         -- missing declaration for a_frs1516_test_item.spsmp3sp;
         a_frs1516_test_item.taxam1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.taxam2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.taxam3hd;
         a_frs1516_test_item.taxam1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.taxam2sp;
         -- missing declaration for a_frs1516_test_item.taxam3sp;
         a_frs1516_test_item.taxda1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.taxda2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.taxda3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.taxda1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.taxda2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.taxda3sp;
         -- missing declaration for a_frs1516_test_item.taxpd1hd;
         -- missing declaration for a_frs1516_test_item.taxpd2hd;
         -- missing declaration for a_frs1516_test_item.taxpd3hd;
         -- missing declaration for a_frs1516_test_item.taxpd1sp;
         -- missing declaration for a_frs1516_test_item.taxpd2sp;
         -- missing declaration for a_frs1516_test_item.taxpd3sp;
         a_frs1516_test_item.to1hr1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.to1hr2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.to1hr3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.to1hr1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.to1hr2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.to1hr3sp;
         a_frs1516_test_item.boinu1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.boinu2hd;
         -- missing declaration for a_frs1516_test_item.boinu3hd;
         a_frs1516_test_item.boinu1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.boinu2sp;
         -- missing declaration for a_frs1516_test_item.boinu3sp;
         -- missing declaration for a_frs1516_test_item.uincb1hd;
         -- missing declaration for a_frs1516_test_item.uincb2hd;
         -- missing declaration for a_frs1516_test_item.uincb3hd;
         -- missing declaration for a_frs1516_test_item.uincb1sp;
         -- missing declaration for a_frs1516_test_item.uincb2sp;
         -- missing declaration for a_frs1516_test_item.uincb3sp;
         a_frs1516_test_item.uded11hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uded12hd;
         -- missing declaration for a_frs1516_test_item.uded13hd;
         a_frs1516_test_item.uded11sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uded12sp;
         -- missing declaration for a_frs1516_test_item.uded13sp;
         -- missing declaration for a_frs1516_test_item.uded21hd;
         -- missing declaration for a_frs1516_test_item.uded22hd;
         -- missing declaration for a_frs1516_test_item.uded23hd;
         -- missing declaration for a_frs1516_test_item.uded21sp;
         -- missing declaration for a_frs1516_test_item.uded22sp;
         -- missing declaration for a_frs1516_test_item.uded23sp;
         a_frs1516_test_item.uded31hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uded32hd;
         -- missing declaration for a_frs1516_test_item.uded33hd;
         -- missing declaration for a_frs1516_test_item.uded31sp;
         -- missing declaration for a_frs1516_test_item.uded32sp;
         -- missing declaration for a_frs1516_test_item.uded33sp;
         -- missing declaration for a_frs1516_test_item.uded41hd;
         -- missing declaration for a_frs1516_test_item.uded42hd;
         -- missing declaration for a_frs1516_test_item.uded43hd;
         -- missing declaration for a_frs1516_test_item.uded41sp;
         -- missing declaration for a_frs1516_test_item.uded42sp;
         -- missing declaration for a_frs1516_test_item.uded43sp;
         a_frs1516_test_item.uded51hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uded52hd;
         -- missing declaration for a_frs1516_test_item.uded53hd;
         a_frs1516_test_item.uded51sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uded52sp;
         -- missing declaration for a_frs1516_test_item.uded53sp;
         -- missing declaration for a_frs1516_test_item.uded61hd;
         -- missing declaration for a_frs1516_test_item.uded62hd;
         -- missing declaration for a_frs1516_test_item.uded63hd;
         -- missing declaration for a_frs1516_test_item.uded61sp;
         -- missing declaration for a_frs1516_test_item.uded62sp;
         -- missing declaration for a_frs1516_test_item.uded63sp;
         -- missing declaration for a_frs1516_test_item.uded71hd;
         -- missing declaration for a_frs1516_test_item.uded72hd;
         -- missing declaration for a_frs1516_test_item.uded73hd;
         -- missing declaration for a_frs1516_test_item.uded71sp;
         -- missing declaration for a_frs1516_test_item.uded72sp;
         -- missing declaration for a_frs1516_test_item.uded73sp;
         -- missing declaration for a_frs1516_test_item.uded81hd;
         -- missing declaration for a_frs1516_test_item.uded82hd;
         -- missing declaration for a_frs1516_test_item.uded83hd;
         -- missing declaration for a_frs1516_test_item.uded81sp;
         -- missing declaration for a_frs1516_test_item.uded82sp;
         -- missing declaration for a_frs1516_test_item.uded83sp;
         a_frs1516_test_item.uded91hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uded92hd;
         -- missing declaration for a_frs1516_test_item.uded93hd;
         -- missing declaration for a_frs1516_test_item.uded91sp;
         -- missing declaration for a_frs1516_test_item.uded92sp;
         -- missing declaration for a_frs1516_test_item.uded93sp;
         a_frs1516_test_item.ugros1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ugros2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ugros3hd;
         a_frs1516_test_item.ugros1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ugros2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ugros3sp;
         a_frs1516_test_item.ugrsp1hd := To_Unbounded_String("dat forugrsp1hd" & i'Img );
         a_frs1516_test_item.ugrsp2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ugrsp3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ugrsp1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ugrsp2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ugrsp3sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uinc11hd;
         -- missing declaration for a_frs1516_test_item.uinc12hd;
         -- missing declaration for a_frs1516_test_item.uinc13hd;
         -- missing declaration for a_frs1516_test_item.uinc11sp;
         -- missing declaration for a_frs1516_test_item.uinc12sp;
         -- missing declaration for a_frs1516_test_item.uinc13sp;
         -- missing declaration for a_frs1516_test_item.uinc21hd;
         -- missing declaration for a_frs1516_test_item.uinc22hd;
         -- missing declaration for a_frs1516_test_item.uinc23hd;
         -- missing declaration for a_frs1516_test_item.uinc21sp;
         -- missing declaration for a_frs1516_test_item.uinc22sp;
         -- missing declaration for a_frs1516_test_item.uinc23sp;
         -- missing declaration for a_frs1516_test_item.uinc31hd;
         -- missing declaration for a_frs1516_test_item.uinc32hd;
         -- missing declaration for a_frs1516_test_item.uinc33hd;
         -- missing declaration for a_frs1516_test_item.uinc31sp;
         -- missing declaration for a_frs1516_test_item.uinc32sp;
         -- missing declaration for a_frs1516_test_item.uinc33sp;
         -- missing declaration for a_frs1516_test_item.uinc41hd;
         -- missing declaration for a_frs1516_test_item.uinc42hd;
         -- missing declaration for a_frs1516_test_item.uinc43hd;
         -- missing declaration for a_frs1516_test_item.uinc41sp;
         -- missing declaration for a_frs1516_test_item.uinc42sp;
         -- missing declaration for a_frs1516_test_item.uinc43sp;
         -- missing declaration for a_frs1516_test_item.uinc51hd;
         -- missing declaration for a_frs1516_test_item.uinc52hd;
         -- missing declaration for a_frs1516_test_item.uinc53hd;
         -- missing declaration for a_frs1516_test_item.uinc51sp;
         -- missing declaration for a_frs1516_test_item.uinc52sp;
         -- missing declaration for a_frs1516_test_item.uinc53sp;
         -- missing declaration for a_frs1516_test_item.uinc61hd;
         -- missing declaration for a_frs1516_test_item.uinc62hd;
         -- missing declaration for a_frs1516_test_item.uinc63hd;
         -- missing declaration for a_frs1516_test_item.uinc61sp;
         -- missing declaration for a_frs1516_test_item.uinc62sp;
         -- missing declaration for a_frs1516_test_item.uinc63sp;
         -- missing declaration for a_frs1516_test_item.uinc71hd;
         -- missing declaration for a_frs1516_test_item.uinc72hd;
         -- missing declaration for a_frs1516_test_item.uinc73hd;
         -- missing declaration for a_frs1516_test_item.uinc71sp;
         -- missing declaration for a_frs1516_test_item.uinc72sp;
         -- missing declaration for a_frs1516_test_item.uinc73sp;
         a_frs1516_test_item.umile1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.umile2hd;
         -- missing declaration for a_frs1516_test_item.umile3hd;
         a_frs1516_test_item.umile1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.umile2sp;
         -- missing declaration for a_frs1516_test_item.umile3sp;
         a_frs1516_test_item.umot1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.umot2hd;
         -- missing declaration for a_frs1516_test_item.umot3hd;
         a_frs1516_test_item.umot1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.umot2sp;
         -- missing declaration for a_frs1516_test_item.umot3sp;
         a_frs1516_test_item.unett1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.unett2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.unett3hd;
         a_frs1516_test_item.unett1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.unett2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.unett3sp;
         -- missing declaration for a_frs1516_test_item.uoth11hd;
         -- missing declaration for a_frs1516_test_item.uoth12hd;
         -- missing declaration for a_frs1516_test_item.uoth13hd;
         -- missing declaration for a_frs1516_test_item.uoth11sp;
         -- missing declaration for a_frs1516_test_item.uoth12sp;
         -- missing declaration for a_frs1516_test_item.uoth13sp;
         -- missing declaration for a_frs1516_test_item.uoth21hd;
         -- missing declaration for a_frs1516_test_item.uoth22hd;
         -- missing declaration for a_frs1516_test_item.uoth23hd;
         -- missing declaration for a_frs1516_test_item.uoth21sp;
         -- missing declaration for a_frs1516_test_item.uoth22sp;
         -- missing declaration for a_frs1516_test_item.uoth23sp;
         -- missing declaration for a_frs1516_test_item.uoth31hd;
         -- missing declaration for a_frs1516_test_item.uoth32hd;
         -- missing declaration for a_frs1516_test_item.uoth33hd;
         -- missing declaration for a_frs1516_test_item.uoth31sp;
         -- missing declaration for a_frs1516_test_item.uoth32sp;
         -- missing declaration for a_frs1516_test_item.uoth33sp;
         -- missing declaration for a_frs1516_test_item.uoth41hd;
         -- missing declaration for a_frs1516_test_item.uoth42hd;
         -- missing declaration for a_frs1516_test_item.uoth43hd;
         -- missing declaration for a_frs1516_test_item.uoth41sp;
         -- missing declaration for a_frs1516_test_item.uoth42sp;
         -- missing declaration for a_frs1516_test_item.uoth43sp;
         -- missing declaration for a_frs1516_test_item.uoth51hd;
         -- missing declaration for a_frs1516_test_item.uoth52hd;
         -- missing declaration for a_frs1516_test_item.uoth53hd;
         -- missing declaration for a_frs1516_test_item.uoth51sp;
         -- missing declaration for a_frs1516_test_item.uoth52sp;
         -- missing declaration for a_frs1516_test_item.uoth53sp;
         -- missing declaration for a_frs1516_test_item.uoth61hd;
         -- missing declaration for a_frs1516_test_item.uoth62hd;
         -- missing declaration for a_frs1516_test_item.uoth63hd;
         -- missing declaration for a_frs1516_test_item.uoth61sp;
         -- missing declaration for a_frs1516_test_item.uoth62sp;
         -- missing declaration for a_frs1516_test_item.uoth63sp;
         -- missing declaration for a_frs1516_test_item.uoth71hd;
         -- missing declaration for a_frs1516_test_item.uoth72hd;
         -- missing declaration for a_frs1516_test_item.uoth73hd;
         -- missing declaration for a_frs1516_test_item.uoth71sp;
         -- missing declaration for a_frs1516_test_item.uoth72sp;
         -- missing declaration for a_frs1516_test_item.uoth73sp;
         -- missing declaration for a_frs1516_test_item.uoth81hd;
         -- missing declaration for a_frs1516_test_item.uoth82hd;
         -- missing declaration for a_frs1516_test_item.uoth83hd;
         -- missing declaration for a_frs1516_test_item.uoth81sp;
         -- missing declaration for a_frs1516_test_item.uoth82sp;
         -- missing declaration for a_frs1516_test_item.uoth83sp;
         -- missing declaration for a_frs1516_test_item.uoth91hd;
         -- missing declaration for a_frs1516_test_item.uoth92hd;
         -- missing declaration for a_frs1516_test_item.uoth93hd;
         -- missing declaration for a_frs1516_test_item.uoth91sp;
         -- missing declaration for a_frs1516_test_item.uoth92sp;
         -- missing declaration for a_frs1516_test_item.uoth93sp;
         -- missing declaration for a_frs1516_test_item.uot101hd;
         -- missing declaration for a_frs1516_test_item.uot102hd;
         -- missing declaration for a_frs1516_test_item.uot103hd;
         -- missing declaration for a_frs1516_test_item.uot101sp;
         -- missing declaration for a_frs1516_test_item.uot102sp;
         -- missing declaration for a_frs1516_test_item.uot103sp;
         a_frs1516_test_item.uotht1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uotht2hd;
         -- missing declaration for a_frs1516_test_item.uotht3hd;
         -- missing declaration for a_frs1516_test_item.uotht1sp;
         -- missing declaration for a_frs1516_test_item.uotht2sp;
         -- missing declaration for a_frs1516_test_item.uotht3sp;
         a_frs1516_test_item.uothr1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.uothr2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uothr3hd;
         a_frs1516_test_item.uothr1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.uothr2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uothr3sp;
         -- missing declaration for a_frs1516_test_item.upay1hd;
         -- missing declaration for a_frs1516_test_item.upay2hd;
         -- missing declaration for a_frs1516_test_item.upay3hd;
         -- missing declaration for a_frs1516_test_item.upay1sp;
         -- missing declaration for a_frs1516_test_item.upay2sp;
         -- missing declaration for a_frs1516_test_item.upay3sp;
         -- missing declaration for a_frs1516_test_item.usapa1hd;
         -- missing declaration for a_frs1516_test_item.usapa2hd;
         -- missing declaration for a_frs1516_test_item.usapa3hd;
         -- missing declaration for a_frs1516_test_item.usapa1sp;
         -- missing declaration for a_frs1516_test_item.usapa2sp;
         -- missing declaration for a_frs1516_test_item.usapa3sp;
         a_frs1516_test_item.uspam1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uspam2hd;
         -- missing declaration for a_frs1516_test_item.uspam3hd;
         a_frs1516_test_item.uspam1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.uspam2sp;
         -- missing declaration for a_frs1516_test_item.uspam3sp;
         -- missing declaration for a_frs1516_test_item.uspra1hd;
         -- missing declaration for a_frs1516_test_item.uspra2hd;
         -- missing declaration for a_frs1516_test_item.uspra3hd;
         -- missing declaration for a_frs1516_test_item.uspra1sp;
         -- missing declaration for a_frs1516_test_item.uspra2sp;
         -- missing declaration for a_frs1516_test_item.uspra3sp;
         -- missing declaration for a_frs1516_test_item.uppam1hd;
         -- missing declaration for a_frs1516_test_item.uppam2hd;
         -- missing declaration for a_frs1516_test_item.uppam3hd;
         -- missing declaration for a_frs1516_test_item.uppam1sp;
         -- missing declaration for a_frs1516_test_item.uppam2sp;
         -- missing declaration for a_frs1516_test_item.uppam3sp;
         a_frs1516_test_item.usspa1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.usspa2hd;
         -- missing declaration for a_frs1516_test_item.usspa3hd;
         -- missing declaration for a_frs1516_test_item.usspa1sp;
         -- missing declaration for a_frs1516_test_item.usspa2sp;
         -- missing declaration for a_frs1516_test_item.usspa3sp;
         a_frs1516_test_item.to2hr1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.to2hr2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.to2hr3hd;
         a_frs1516_test_item.to2hr1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.to2hr2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.to2hr3sp;
         a_frs1516_test_item.utaxa1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.utaxa2hd;
         -- missing declaration for a_frs1516_test_item.utaxa3hd;
         a_frs1516_test_item.utaxa1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.utaxa2sp;
         -- missing declaration for a_frs1516_test_item.utaxa3sp;
         a_frs1516_test_item.vcamt1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.vcamt2hd;
         -- missing declaration for a_frs1516_test_item.vcamt3hd;
         a_frs1516_test_item.vcamt1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.vcamt2sp;
         -- missing declaration for a_frs1516_test_item.vcamt3sp;
         -- missing declaration for a_frs1516_test_item.vcpd1hd;
         -- missing declaration for a_frs1516_test_item.vcpd2hd;
         -- missing declaration for a_frs1516_test_item.vcpd3hd;
         -- missing declaration for a_frs1516_test_item.vcpd1sp;
         -- missing declaration for a_frs1516_test_item.vcpd2sp;
         -- missing declaration for a_frs1516_test_item.vcpd3sp;
         -- missing declaration for a_frs1516_test_item.vcsac1hd;
         -- missing declaration for a_frs1516_test_item.vcsac2hd;
         -- missing declaration for a_frs1516_test_item.vcsac3hd;
         -- missing declaration for a_frs1516_test_item.vcsac1sp;
         -- missing declaration for a_frs1516_test_item.vcsac2sp;
         -- missing declaration for a_frs1516_test_item.vcsac3sp;
         -- missing declaration for a_frs1516_test_item.vcuam1hd;
         -- missing declaration for a_frs1516_test_item.vcuam2hd;
         -- missing declaration for a_frs1516_test_item.vcuam3hd;
         -- missing declaration for a_frs1516_test_item.vcuam1sp;
         -- missing declaration for a_frs1516_test_item.vcuam2sp;
         -- missing declaration for a_frs1516_test_item.vcuam3sp;
         -- missing declaration for a_frs1516_test_item.vcupd1hd;
         -- missing declaration for a_frs1516_test_item.vcupd2hd;
         -- missing declaration for a_frs1516_test_item.vcupd3hd;
         -- missing declaration for a_frs1516_test_item.vcupd1sp;
         -- missing declaration for a_frs1516_test_item.vcupd2sp;
         -- missing declaration for a_frs1516_test_item.vcupd3sp;
         -- missing declaration for a_frs1516_test_item.vcusu1hd;
         -- missing declaration for a_frs1516_test_item.vcusu2hd;
         -- missing declaration for a_frs1516_test_item.vcusu3hd;
         -- missing declaration for a_frs1516_test_item.vcusu1sp;
         -- missing declaration for a_frs1516_test_item.vcusu2sp;
         -- missing declaration for a_frs1516_test_item.vcusu3sp;
         -- missing declaration for a_frs1516_test_item.nou011hd;
         -- missing declaration for a_frs1516_test_item.nou012hd;
         -- missing declaration for a_frs1516_test_item.nou013hd;
         -- missing declaration for a_frs1516_test_item.nou011sp;
         -- missing declaration for a_frs1516_test_item.nou012sp;
         -- missing declaration for a_frs1516_test_item.nou013sp;
         -- missing declaration for a_frs1516_test_item.nou021hd;
         -- missing declaration for a_frs1516_test_item.nou022hd;
         -- missing declaration for a_frs1516_test_item.nou023hd;
         -- missing declaration for a_frs1516_test_item.nou021sp;
         -- missing declaration for a_frs1516_test_item.nou022sp;
         -- missing declaration for a_frs1516_test_item.nou023sp;
         -- missing declaration for a_frs1516_test_item.nou031hd;
         -- missing declaration for a_frs1516_test_item.nou032hd;
         -- missing declaration for a_frs1516_test_item.nou033hd;
         -- missing declaration for a_frs1516_test_item.nou031sp;
         -- missing declaration for a_frs1516_test_item.nou032sp;
         -- missing declaration for a_frs1516_test_item.nou033sp;
         -- missing declaration for a_frs1516_test_item.nou041hd;
         -- missing declaration for a_frs1516_test_item.nou042hd;
         -- missing declaration for a_frs1516_test_item.nou043hd;
         -- missing declaration for a_frs1516_test_item.nou041sp;
         -- missing declaration for a_frs1516_test_item.nou042sp;
         -- missing declaration for a_frs1516_test_item.nou043sp;
         -- missing declaration for a_frs1516_test_item.nou051hd;
         -- missing declaration for a_frs1516_test_item.nou052hd;
         -- missing declaration for a_frs1516_test_item.nou053hd;
         -- missing declaration for a_frs1516_test_item.nou051sp;
         -- missing declaration for a_frs1516_test_item.nou052sp;
         -- missing declaration for a_frs1516_test_item.nou053sp;
         -- missing declaration for a_frs1516_test_item.nou061hd;
         -- missing declaration for a_frs1516_test_item.nou062hd;
         -- missing declaration for a_frs1516_test_item.nou063hd;
         -- missing declaration for a_frs1516_test_item.nou061sp;
         -- missing declaration for a_frs1516_test_item.nou062sp;
         -- missing declaration for a_frs1516_test_item.nou063sp;
         -- missing declaration for a_frs1516_test_item.nou071hd;
         -- missing declaration for a_frs1516_test_item.nou072hd;
         -- missing declaration for a_frs1516_test_item.nou073hd;
         -- missing declaration for a_frs1516_test_item.nou071sp;
         -- missing declaration for a_frs1516_test_item.nou072sp;
         -- missing declaration for a_frs1516_test_item.nou073sp;
         -- missing declaration for a_frs1516_test_item.nou081hd;
         -- missing declaration for a_frs1516_test_item.nou082hd;
         -- missing declaration for a_frs1516_test_item.nou083hd;
         -- missing declaration for a_frs1516_test_item.nou081sp;
         -- missing declaration for a_frs1516_test_item.nou082sp;
         -- missing declaration for a_frs1516_test_item.nou083sp;
         -- missing declaration for a_frs1516_test_item.nou091hd;
         -- missing declaration for a_frs1516_test_item.nou092hd;
         -- missing declaration for a_frs1516_test_item.nou093hd;
         -- missing declaration for a_frs1516_test_item.nou091sp;
         -- missing declaration for a_frs1516_test_item.nou092sp;
         -- missing declaration for a_frs1516_test_item.nou093sp;
         -- missing declaration for a_frs1516_test_item.nou101hd;
         -- missing declaration for a_frs1516_test_item.nou102hd;
         -- missing declaration for a_frs1516_test_item.nou103hd;
         -- missing declaration for a_frs1516_test_item.nou101sp;
         -- missing declaration for a_frs1516_test_item.nou102sp;
         -- missing declaration for a_frs1516_test_item.nou103sp;
         -- missing declaration for a_frs1516_test_item.nou111hd;
         -- missing declaration for a_frs1516_test_item.nou112hd;
         -- missing declaration for a_frs1516_test_item.nou113hd;
         -- missing declaration for a_frs1516_test_item.nou111sp;
         -- missing declaration for a_frs1516_test_item.nou112sp;
         -- missing declaration for a_frs1516_test_item.nou113sp;
         -- missing declaration for a_frs1516_test_item.nou121hd;
         -- missing declaration for a_frs1516_test_item.nou122hd;
         -- missing declaration for a_frs1516_test_item.nou123hd;
         -- missing declaration for a_frs1516_test_item.nou121sp;
         -- missing declaration for a_frs1516_test_item.nou122sp;
         -- missing declaration for a_frs1516_test_item.nou123sp;
         -- missing declaration for a_frs1516_test_item.nou131hd;
         -- missing declaration for a_frs1516_test_item.nou132hd;
         -- missing declaration for a_frs1516_test_item.nou133hd;
         -- missing declaration for a_frs1516_test_item.nou131sp;
         -- missing declaration for a_frs1516_test_item.nou132sp;
         -- missing declaration for a_frs1516_test_item.nou133sp;
         -- missing declaration for a_frs1516_test_item.nou141hd;
         -- missing declaration for a_frs1516_test_item.nou142hd;
         -- missing declaration for a_frs1516_test_item.nou143hd;
         -- missing declaration for a_frs1516_test_item.nou141sp;
         -- missing declaration for a_frs1516_test_item.nou142sp;
         -- missing declaration for a_frs1516_test_item.nou143sp;
         -- missing declaration for a_frs1516_test_item.worka1hd;
         -- missing declaration for a_frs1516_test_item.worka2hd;
         -- missing declaration for a_frs1516_test_item.worka3hd;
         -- missing declaration for a_frs1516_test_item.worka1sp;
         -- missing declaration for a_frs1516_test_item.worka2sp;
         -- missing declaration for a_frs1516_test_item.worka3sp;
         -- missing declaration for a_frs1516_test_item.workm1hd;
         -- missing declaration for a_frs1516_test_item.workm2hd;
         -- missing declaration for a_frs1516_test_item.workm3hd;
         -- missing declaration for a_frs1516_test_item.workm1sp;
         -- missing declaration for a_frs1516_test_item.workm2sp;
         -- missing declaration for a_frs1516_test_item.workm3sp;
         -- missing declaration for a_frs1516_test_item.worky1hd;
         -- missing declaration for a_frs1516_test_item.worky2hd;
         -- missing declaration for a_frs1516_test_item.worky3hd;
         -- missing declaration for a_frs1516_test_item.worky1sp;
         -- missing declaration for a_frs1516_test_item.worky2sp;
         -- missing declaration for a_frs1516_test_item.worky3sp;
         -- missing declaration for a_frs1516_test_item.yjchg1hd;
         -- missing declaration for a_frs1516_test_item.yjchg2hd;
         -- missing declaration for a_frs1516_test_item.yjchg3hd;
         -- missing declaration for a_frs1516_test_item.yjchg1sp;
         -- missing declaration for a_frs1516_test_item.yjchg2sp;
         -- missing declaration for a_frs1516_test_item.yjchg3sp;
         a_frs1516_test_item.mp1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.mp2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.mp3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.mp1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.mp2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.mp3sp;
         -- missing declaration for a_frs1516_test_item.mrar11hd;
         -- missing declaration for a_frs1516_test_item.mrar12hd;
         -- missing declaration for a_frs1516_test_item.mrar13hd;
         -- missing declaration for a_frs1516_test_item.mrar11sp;
         -- missing declaration for a_frs1516_test_item.mrar12sp;
         -- missing declaration for a_frs1516_test_item.mrar13sp;
         -- missing declaration for a_frs1516_test_item.mrar21hd;
         -- missing declaration for a_frs1516_test_item.mrar22hd;
         -- missing declaration for a_frs1516_test_item.mrar23hd;
         -- missing declaration for a_frs1516_test_item.mrar21sp;
         -- missing declaration for a_frs1516_test_item.mrar22sp;
         -- missing declaration for a_frs1516_test_item.mrar23sp;
         -- missing declaration for a_frs1516_test_item.mrar31hd;
         -- missing declaration for a_frs1516_test_item.mrar32hd;
         -- missing declaration for a_frs1516_test_item.mrar33hd;
         -- missing declaration for a_frs1516_test_item.mrar31sp;
         -- missing declaration for a_frs1516_test_item.mrar32sp;
         -- missing declaration for a_frs1516_test_item.mrar33sp;
         -- missing declaration for a_frs1516_test_item.mrar41hd;
         -- missing declaration for a_frs1516_test_item.mrar42hd;
         -- missing declaration for a_frs1516_test_item.mrar43hd;
         -- missing declaration for a_frs1516_test_item.mrar41sp;
         -- missing declaration for a_frs1516_test_item.mrar42sp;
         -- missing declaration for a_frs1516_test_item.mrar43sp;
         -- missing declaration for a_frs1516_test_item.mrar51hd;
         -- missing declaration for a_frs1516_test_item.mrar52hd;
         -- missing declaration for a_frs1516_test_item.mrar53hd;
         -- missing declaration for a_frs1516_test_item.mrar51sp;
         -- missing declaration for a_frs1516_test_item.mrar52sp;
         -- missing declaration for a_frs1516_test_item.mrar53sp;
         -- missing declaration for a_frs1516_test_item.mpnch1hd;
         -- missing declaration for a_frs1516_test_item.mpnch2hd;
         -- missing declaration for a_frs1516_test_item.mpnch3hd;
         -- missing declaration for a_frs1516_test_item.mpnch1sp;
         -- missing declaration for a_frs1516_test_item.mpnch2sp;
         -- missing declaration for a_frs1516_test_item.mpnch3sp;
         -- missing declaration for a_frs1516_test_item.pmp1hd;
         -- missing declaration for a_frs1516_test_item.pmp2hd;
         -- missing declaration for a_frs1516_test_item.pmp3hd;
         -- missing declaration for a_frs1516_test_item.pmp1sp;
         -- missing declaration for a_frs1516_test_item.pmp2sp;
         -- missing declaration for a_frs1516_test_item.pmp3sp;
         a_frs1516_test_item.ump1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ump2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ump3hd;
         a_frs1516_test_item.ump1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ump2sp;
         -- missing declaration for a_frs1516_test_item.ump3sp;
         -- missing declaration for a_frs1516_test_item.pump1hd;
         -- missing declaration for a_frs1516_test_item.pump2hd;
         -- missing declaration for a_frs1516_test_item.pump3hd;
         -- missing declaration for a_frs1516_test_item.pump1sp;
         -- missing declaration for a_frs1516_test_item.pump2sp;
         -- missing declaration for a_frs1516_test_item.pump3sp;
         -- missing declaration for a_frs1516_test_item.isump1hd;
         -- missing declaration for a_frs1516_test_item.isump2hd;
         -- missing declaration for a_frs1516_test_item.isump3hd;
         -- missing declaration for a_frs1516_test_item.isump1sp;
         -- missing declaration for a_frs1516_test_item.isump2sp;
         -- missing declaration for a_frs1516_test_item.isump3sp;
         -- missing declaration for a_frs1516_test_item.jobst1hd;
         -- missing declaration for a_frs1516_test_item.jobst2hd;
         -- missing declaration for a_frs1516_test_item.jobst1sp;
         -- missing declaration for a_frs1516_test_item.jobst2sp;
         -- missing declaration for a_frs1516_test_item.oddtp1hd;
         -- missing declaration for a_frs1516_test_item.oddtp2hd;
         -- missing declaration for a_frs1516_test_item.oddtp1sp;
         -- missing declaration for a_frs1516_test_item.oddtp2sp;
         a_frs1516_test_item.oddjb1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.oddjb2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.oddjb1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.oddjb2sp;
         -- missing declaration for a_frs1516_test_item.oddjn1hd;
         -- missing declaration for a_frs1516_test_item.oddjn2hd;
         -- missing declaration for a_frs1516_test_item.oddjn1sp;
         -- missing declaration for a_frs1516_test_item.oddjn2sp;
         -- missing declaration for a_frs1516_test_item.poth1hd;
         -- missing declaration for a_frs1516_test_item.poth2hd;
         -- missing declaration for a_frs1516_test_item.poth3hd;
         -- missing declaration for a_frs1516_test_item.poth4hd;
         -- missing declaration for a_frs1516_test_item.poth5hd;
         -- missing declaration for a_frs1516_test_item.poth6hd;
         -- missing declaration for a_frs1516_test_item.poth7hd;
         -- missing declaration for a_frs1516_test_item.poth8hd;
         -- missing declaration for a_frs1516_test_item.poth9hd;
         -- missing declaration for a_frs1516_test_item.poth10hd;
         -- missing declaration for a_frs1516_test_item.poth11hd;
         -- missing declaration for a_frs1516_test_item.poth12hd;
         -- missing declaration for a_frs1516_test_item.poth13hd;
         -- missing declaration for a_frs1516_test_item.poth14hd;
         -- missing declaration for a_frs1516_test_item.poth15hd;
         -- missing declaration for a_frs1516_test_item.poth16hd;
         -- missing declaration for a_frs1516_test_item.poth17hd;
         -- missing declaration for a_frs1516_test_item.poth18hd;
         -- missing declaration for a_frs1516_test_item.poth19hd;
         -- missing declaration for a_frs1516_test_item.poth1sp;
         -- missing declaration for a_frs1516_test_item.poth2sp;
         -- missing declaration for a_frs1516_test_item.poth3sp;
         -- missing declaration for a_frs1516_test_item.poth4sp;
         -- missing declaration for a_frs1516_test_item.poth5sp;
         -- missing declaration for a_frs1516_test_item.poth6sp;
         -- missing declaration for a_frs1516_test_item.poth7sp;
         -- missing declaration for a_frs1516_test_item.poth8sp;
         -- missing declaration for a_frs1516_test_item.poth9sp;
         -- missing declaration for a_frs1516_test_item.poth10sp;
         -- missing declaration for a_frs1516_test_item.poth11sp;
         -- missing declaration for a_frs1516_test_item.poth12sp;
         -- missing declaration for a_frs1516_test_item.poth13sp;
         -- missing declaration for a_frs1516_test_item.poth14sp;
         -- missing declaration for a_frs1516_test_item.poth15sp;
         -- missing declaration for a_frs1516_test_item.poth16sp;
         -- missing declaration for a_frs1516_test_item.poth17sp;
         -- missing declaration for a_frs1516_test_item.poth18sp;
         -- missing declaration for a_frs1516_test_item.poth19sp;
         a_frs1516_test_item.ocpen1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ocpen2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ocpen3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ocpen4hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.wpen1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.wpen2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.wpen3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ppen1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ppen2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ppen3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.tupen1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.tupen2hd;
         a_frs1516_test_item.anpen1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.anpen2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.anpen3hd;
         a_frs1516_test_item.trust1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.trust2hd;
         a_frs1516_test_item.expen1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.expen2hd;
         a_frs1516_test_item.ocpen1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ocpen2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ocpen3sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ocpen4sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.wpen1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.wpen2sp;
         -- missing declaration for a_frs1516_test_item.wpen3sp;
         a_frs1516_test_item.ppen1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ppen2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ppen3sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.tupen1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.tupen2sp;
         a_frs1516_test_item.anpen1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.anpen2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.anpen3sp;
         a_frs1516_test_item.trust1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.trust2sp;
         a_frs1516_test_item.expen1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.expen2sp;
         -- missing declaration for a_frs1516_test_item.pcpen1hd;
         -- missing declaration for a_frs1516_test_item.pcpen2hd;
         -- missing declaration for a_frs1516_test_item.pcpen3hd;
         -- missing declaration for a_frs1516_test_item.pcpen4hd;
         -- missing declaration for a_frs1516_test_item.pwpen1hd;
         -- missing declaration for a_frs1516_test_item.pwpen2hd;
         -- missing declaration for a_frs1516_test_item.pwpen3hd;
         -- missing declaration for a_frs1516_test_item.pppen1hd;
         -- missing declaration for a_frs1516_test_item.pppen2hd;
         -- missing declaration for a_frs1516_test_item.pppen3hd;
         -- missing declaration for a_frs1516_test_item.ptupn1hd;
         -- missing declaration for a_frs1516_test_item.ptupn2hd;
         -- missing declaration for a_frs1516_test_item.panpn1hd;
         -- missing declaration for a_frs1516_test_item.panpn2hd;
         -- missing declaration for a_frs1516_test_item.panpn3hd;
         -- missing declaration for a_frs1516_test_item.ptrst1hd;
         -- missing declaration for a_frs1516_test_item.ptrst2hd;
         -- missing declaration for a_frs1516_test_item.pxpen1hd;
         -- missing declaration for a_frs1516_test_item.pxpen2hd;
         -- missing declaration for a_frs1516_test_item.pcpen1sp;
         -- missing declaration for a_frs1516_test_item.pcpen2sp;
         -- missing declaration for a_frs1516_test_item.pcpen3sp;
         -- missing declaration for a_frs1516_test_item.pcpen4sp;
         -- missing declaration for a_frs1516_test_item.pwpen1sp;
         -- missing declaration for a_frs1516_test_item.pwpen2sp;
         -- missing declaration for a_frs1516_test_item.pwpen3sp;
         -- missing declaration for a_frs1516_test_item.pppen1sp;
         -- missing declaration for a_frs1516_test_item.pppen2sp;
         -- missing declaration for a_frs1516_test_item.pppen3sp;
         -- missing declaration for a_frs1516_test_item.ptupn1sp;
         -- missing declaration for a_frs1516_test_item.ptupn2sp;
         -- missing declaration for a_frs1516_test_item.panpn1sp;
         -- missing declaration for a_frs1516_test_item.panpn2sp;
         -- missing declaration for a_frs1516_test_item.panpn3sp;
         -- missing declaration for a_frs1516_test_item.ptrst1sp;
         -- missing declaration for a_frs1516_test_item.ptrst2sp;
         -- missing declaration for a_frs1516_test_item.pxpen1sp;
         -- missing declaration for a_frs1516_test_item.pxpen2sp;
         -- missing declaration for a_frs1516_test_item.ocptd1hd;
         -- missing declaration for a_frs1516_test_item.ocptd2hd;
         -- missing declaration for a_frs1516_test_item.ocptd3hd;
         -- missing declaration for a_frs1516_test_item.ocptd4hd;
         -- missing declaration for a_frs1516_test_item.wpptd1hd;
         -- missing declaration for a_frs1516_test_item.wpptd2hd;
         -- missing declaration for a_frs1516_test_item.wpptd3hd;
         -- missing declaration for a_frs1516_test_item.ppetd1hd;
         -- missing declaration for a_frs1516_test_item.ppetd2hd;
         -- missing declaration for a_frs1516_test_item.ppetd3hd;
         -- missing declaration for a_frs1516_test_item.tuptd1hd;
         -- missing declaration for a_frs1516_test_item.tuptd2hd;
         -- missing declaration for a_frs1516_test_item.aptd1hd;
         -- missing declaration for a_frs1516_test_item.aptd2hd;
         -- missing declaration for a_frs1516_test_item.aptd3hd;
         -- missing declaration for a_frs1516_test_item.trutd1hd;
         -- missing declaration for a_frs1516_test_item.trutd2hd;
         -- missing declaration for a_frs1516_test_item.exptd1hd;
         -- missing declaration for a_frs1516_test_item.exptd2hd;
         -- missing declaration for a_frs1516_test_item.ocptd1sp;
         -- missing declaration for a_frs1516_test_item.ocptd2sp;
         -- missing declaration for a_frs1516_test_item.ocptd3sp;
         -- missing declaration for a_frs1516_test_item.ocptd4sp;
         -- missing declaration for a_frs1516_test_item.wpptd1sp;
         -- missing declaration for a_frs1516_test_item.wpptd2sp;
         -- missing declaration for a_frs1516_test_item.wpptd3sp;
         -- missing declaration for a_frs1516_test_item.ppetd1sp;
         -- missing declaration for a_frs1516_test_item.ppetd2sp;
         -- missing declaration for a_frs1516_test_item.ppetd3sp;
         -- missing declaration for a_frs1516_test_item.tuptd1sp;
         -- missing declaration for a_frs1516_test_item.tuptd2sp;
         -- missing declaration for a_frs1516_test_item.aptd1sp;
         -- missing declaration for a_frs1516_test_item.aptd2sp;
         -- missing declaration for a_frs1516_test_item.aptd3sp;
         -- missing declaration for a_frs1516_test_item.trutd1sp;
         -- missing declaration for a_frs1516_test_item.trutd2sp;
         -- missing declaration for a_frs1516_test_item.exptd1sp;
         -- missing declaration for a_frs1516_test_item.exptd2sp;
         -- missing declaration for a_frs1516_test_item.ocpid1hd;
         -- missing declaration for a_frs1516_test_item.ocpid2hd;
         -- missing declaration for a_frs1516_test_item.ocpid3hd;
         -- missing declaration for a_frs1516_test_item.ocpid4hd;
         -- missing declaration for a_frs1516_test_item.wwpid1hd;
         -- missing declaration for a_frs1516_test_item.wwpid2hd;
         -- missing declaration for a_frs1516_test_item.wwpid3hd;
         -- missing declaration for a_frs1516_test_item.ppeid1hd;
         -- missing declaration for a_frs1516_test_item.ppeid2hd;
         -- missing declaration for a_frs1516_test_item.ppeid3hd;
         -- missing declaration for a_frs1516_test_item.tupid1hd;
         -- missing declaration for a_frs1516_test_item.tupid2hd;
         -- missing declaration for a_frs1516_test_item.apid1hd;
         -- missing declaration for a_frs1516_test_item.apid2hd;
         -- missing declaration for a_frs1516_test_item.apid3hd;
         -- missing declaration for a_frs1516_test_item.truid1hd;
         -- missing declaration for a_frs1516_test_item.truid2hd;
         -- missing declaration for a_frs1516_test_item.expid1hd;
         -- missing declaration for a_frs1516_test_item.expid2hd;
         -- missing declaration for a_frs1516_test_item.ocpid1sp;
         -- missing declaration for a_frs1516_test_item.ocpid2sp;
         -- missing declaration for a_frs1516_test_item.ocpid3sp;
         -- missing declaration for a_frs1516_test_item.ocpid4sp;
         -- missing declaration for a_frs1516_test_item.wwpid1sp;
         -- missing declaration for a_frs1516_test_item.wwpid2sp;
         -- missing declaration for a_frs1516_test_item.wwpid3sp;
         -- missing declaration for a_frs1516_test_item.ppeid1sp;
         -- missing declaration for a_frs1516_test_item.ppeid2sp;
         -- missing declaration for a_frs1516_test_item.ppeid3sp;
         -- missing declaration for a_frs1516_test_item.tupid1sp;
         -- missing declaration for a_frs1516_test_item.tupid2sp;
         -- missing declaration for a_frs1516_test_item.apid1sp;
         -- missing declaration for a_frs1516_test_item.apid2sp;
         -- missing declaration for a_frs1516_test_item.apid3sp;
         -- missing declaration for a_frs1516_test_item.truid1sp;
         -- missing declaration for a_frs1516_test_item.truid2sp;
         -- missing declaration for a_frs1516_test_item.expid1sp;
         -- missing declaration for a_frs1516_test_item.expid2sp;
         -- missing declaration for a_frs1516_test_item.ocptx1hd;
         -- missing declaration for a_frs1516_test_item.ocptx2hd;
         -- missing declaration for a_frs1516_test_item.ocptx3hd;
         -- missing declaration for a_frs1516_test_item.ocptx4hd;
         -- missing declaration for a_frs1516_test_item.wptx1hd;
         -- missing declaration for a_frs1516_test_item.wpptx2hd;
         -- missing declaration for a_frs1516_test_item.wpptx3hd;
         -- missing declaration for a_frs1516_test_item.ppetx1hd;
         -- missing declaration for a_frs1516_test_item.ppetx2hd;
         -- missing declaration for a_frs1516_test_item.ppetx3hd;
         -- missing declaration for a_frs1516_test_item.tuptx1hd;
         -- missing declaration for a_frs1516_test_item.tuptx2hd;
         -- missing declaration for a_frs1516_test_item.aptx1hd;
         -- missing declaration for a_frs1516_test_item.aptx2hd;
         -- missing declaration for a_frs1516_test_item.aptx3hd;
         -- missing declaration for a_frs1516_test_item.ttrtx1hd;
         -- missing declaration for a_frs1516_test_item.ttrtx2hd;
         -- missing declaration for a_frs1516_test_item.exptx1hd;
         -- missing declaration for a_frs1516_test_item.exptx2hd;
         -- missing declaration for a_frs1516_test_item.ocptx1sp;
         -- missing declaration for a_frs1516_test_item.ocptx2sp;
         -- missing declaration for a_frs1516_test_item.ocptx3sp;
         -- missing declaration for a_frs1516_test_item.ocptx4sp;
         -- missing declaration for a_frs1516_test_item.wptx1sp;
         -- missing declaration for a_frs1516_test_item.wpptx2sp;
         -- missing declaration for a_frs1516_test_item.wpptx3sp;
         -- missing declaration for a_frs1516_test_item.ppetx1sp;
         -- missing declaration for a_frs1516_test_item.ppetx2sp;
         -- missing declaration for a_frs1516_test_item.ppetx3sp;
         -- missing declaration for a_frs1516_test_item.tuptx1sp;
         -- missing declaration for a_frs1516_test_item.tuptx2sp;
         -- missing declaration for a_frs1516_test_item.aptx1sp;
         -- missing declaration for a_frs1516_test_item.aptx2sp;
         -- missing declaration for a_frs1516_test_item.aptx3sp;
         -- missing declaration for a_frs1516_test_item.ttrtx1sp;
         -- missing declaration for a_frs1516_test_item.ttrtx2sp;
         -- missing declaration for a_frs1516_test_item.exptx1sp;
         -- missing declaration for a_frs1516_test_item.exptx2sp;
         a_frs1516_test_item.ocpoa1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ocpoa2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ocpoa3hd;
         -- missing declaration for a_frs1516_test_item.ocpoa4hd;
         a_frs1516_test_item.wpoa1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.wwpoa2hd;
         -- missing declaration for a_frs1516_test_item.wwpoa3hd;
         -- missing declaration for a_frs1516_test_item.ppeoa1hd;
         -- missing declaration for a_frs1516_test_item.ppeoa2hd;
         -- missing declaration for a_frs1516_test_item.ppeoa3hd;
         -- missing declaration for a_frs1516_test_item.tupoa1hd;
         -- missing declaration for a_frs1516_test_item.tupoa2hd;
         -- missing declaration for a_frs1516_test_item.apoa1hd;
         -- missing declaration for a_frs1516_test_item.apoa2hd;
         -- missing declaration for a_frs1516_test_item.apoa3hd;
         -- missing declaration for a_frs1516_test_item.truoa1hd;
         -- missing declaration for a_frs1516_test_item.truoa2hd;
         -- missing declaration for a_frs1516_test_item.expoa1hd;
         -- missing declaration for a_frs1516_test_item.expoa2hd;
         a_frs1516_test_item.ocpoa1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ocpoa2sp;
         -- missing declaration for a_frs1516_test_item.ocpoa3sp;
         -- missing declaration for a_frs1516_test_item.ocpoa4sp;
         a_frs1516_test_item.wpoa1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.wwpoa2sp;
         -- missing declaration for a_frs1516_test_item.wwpoa3sp;
         -- missing declaration for a_frs1516_test_item.ppeoa1sp;
         -- missing declaration for a_frs1516_test_item.ppeoa2sp;
         -- missing declaration for a_frs1516_test_item.ppeoa3sp;
         -- missing declaration for a_frs1516_test_item.tupoa1sp;
         -- missing declaration for a_frs1516_test_item.tupoa2sp;
         -- missing declaration for a_frs1516_test_item.apoa1sp;
         -- missing declaration for a_frs1516_test_item.apoa2sp;
         -- missing declaration for a_frs1516_test_item.apoa3sp;
         -- missing declaration for a_frs1516_test_item.truoa1sp;
         -- missing declaration for a_frs1516_test_item.truoa2sp;
         -- missing declaration for a_frs1516_test_item.expoa1sp;
         -- missing declaration for a_frs1516_test_item.expoa2sp;
         -- missing declaration for a_frs1516_test_item.ocpoi1hd;
         -- missing declaration for a_frs1516_test_item.ocpoi2hd;
         -- missing declaration for a_frs1516_test_item.ocpoi3hd;
         -- missing declaration for a_frs1516_test_item.ocpoi4hd;
         -- missing declaration for a_frs1516_test_item.wpoi1hd;
         -- missing declaration for a_frs1516_test_item.wwpoi2hd;
         -- missing declaration for a_frs1516_test_item.wwpoi3hd;
         -- missing declaration for a_frs1516_test_item.ppeoi1hd;
         -- missing declaration for a_frs1516_test_item.ppeoi2hd;
         -- missing declaration for a_frs1516_test_item.ppeoi3hd;
         -- missing declaration for a_frs1516_test_item.tupoi1hd;
         -- missing declaration for a_frs1516_test_item.tupoi2hd;
         -- missing declaration for a_frs1516_test_item.apoi1hd;
         -- missing declaration for a_frs1516_test_item.apoi2hd;
         -- missing declaration for a_frs1516_test_item.apoi3hd;
         -- missing declaration for a_frs1516_test_item.truoi1hd;
         -- missing declaration for a_frs1516_test_item.truoi2hd;
         -- missing declaration for a_frs1516_test_item.expoi1hd;
         -- missing declaration for a_frs1516_test_item.expoi2hd;
         -- missing declaration for a_frs1516_test_item.ocpoi1sp;
         -- missing declaration for a_frs1516_test_item.ocpoi2sp;
         -- missing declaration for a_frs1516_test_item.ocpoi3sp;
         -- missing declaration for a_frs1516_test_item.ocpoi4sp;
         -- missing declaration for a_frs1516_test_item.wpoi1sp;
         -- missing declaration for a_frs1516_test_item.wwpoi2sp;
         -- missing declaration for a_frs1516_test_item.wwpoi3sp;
         -- missing declaration for a_frs1516_test_item.ppeoi1sp;
         -- missing declaration for a_frs1516_test_item.ppeoi2sp;
         -- missing declaration for a_frs1516_test_item.ppeoi3sp;
         -- missing declaration for a_frs1516_test_item.tupoi1sp;
         -- missing declaration for a_frs1516_test_item.tupoi2sp;
         -- missing declaration for a_frs1516_test_item.apoi1sp;
         -- missing declaration for a_frs1516_test_item.apoi2sp;
         -- missing declaration for a_frs1516_test_item.apoi3sp;
         -- missing declaration for a_frs1516_test_item.truoi1sp;
         -- missing declaration for a_frs1516_test_item.truoi2sp;
         -- missing declaration for a_frs1516_test_item.expoi1sp;
         -- missing declaration for a_frs1516_test_item.expoi2sp;
         a_frs1516_test_item.ocpta1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ocpta2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ocpta3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ocpta4hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.wpta1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.wppta2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.wppta3hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ppeta1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ppeta2hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.ppeta3hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.tupta1hd;
         -- missing declaration for a_frs1516_test_item.tupta2hd;
         a_frs1516_test_item.apta1hd := 1010100.012 + Amount( i );
         a_frs1516_test_item.apta2hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.apta3hd;
         a_frs1516_test_item.truta1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.truta2hd;
         a_frs1516_test_item.expta1hd := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.expta2hd;
         a_frs1516_test_item.ocpta1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ocpta2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ocpta3sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ocpta4sp;
         a_frs1516_test_item.wpta1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.wppta2sp;
         -- missing declaration for a_frs1516_test_item.wppta3sp;
         a_frs1516_test_item.ppeta1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ppeta2sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.ppeta3sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.tupta1sp;
         -- missing declaration for a_frs1516_test_item.tupta2sp;
         a_frs1516_test_item.apta1sp := 1010100.012 + Amount( i );
         a_frs1516_test_item.apta2sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.apta3sp;
         a_frs1516_test_item.truta1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.truta2sp;
         a_frs1516_test_item.expta1sp := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.expta2sp;
         -- missing declaration for a_frs1516_test_item.ocpti1hd;
         -- missing declaration for a_frs1516_test_item.ocpti2hd;
         -- missing declaration for a_frs1516_test_item.ocpti3hd;
         -- missing declaration for a_frs1516_test_item.ocpti4hd;
         -- missing declaration for a_frs1516_test_item.wpti1hd;
         -- missing declaration for a_frs1516_test_item.wppti2hd;
         -- missing declaration for a_frs1516_test_item.wppti3hd;
         -- missing declaration for a_frs1516_test_item.ppeti1hd;
         -- missing declaration for a_frs1516_test_item.ppeti2hd;
         -- missing declaration for a_frs1516_test_item.ppeti3hd;
         -- missing declaration for a_frs1516_test_item.tupti1hd;
         -- missing declaration for a_frs1516_test_item.tupti2hd;
         -- missing declaration for a_frs1516_test_item.apti1hd;
         -- missing declaration for a_frs1516_test_item.apti2hd;
         -- missing declaration for a_frs1516_test_item.apti3hd;
         -- missing declaration for a_frs1516_test_item.truti1hd;
         -- missing declaration for a_frs1516_test_item.truti2hd;
         -- missing declaration for a_frs1516_test_item.expti1hd;
         -- missing declaration for a_frs1516_test_item.expti2hd;
         -- missing declaration for a_frs1516_test_item.ocpti1sp;
         -- missing declaration for a_frs1516_test_item.ocpti2sp;
         -- missing declaration for a_frs1516_test_item.ocpti3sp;
         -- missing declaration for a_frs1516_test_item.ocpti4sp;
         -- missing declaration for a_frs1516_test_item.wpti1sp;
         -- missing declaration for a_frs1516_test_item.wppti2sp;
         -- missing declaration for a_frs1516_test_item.wppti3sp;
         -- missing declaration for a_frs1516_test_item.ppeti1sp;
         -- missing declaration for a_frs1516_test_item.ppeti2sp;
         -- missing declaration for a_frs1516_test_item.ppeti3sp;
         -- missing declaration for a_frs1516_test_item.tupti1sp;
         -- missing declaration for a_frs1516_test_item.tupti2sp;
         -- missing declaration for a_frs1516_test_item.apti1sp;
         -- missing declaration for a_frs1516_test_item.apti2sp;
         -- missing declaration for a_frs1516_test_item.apti3sp;
         -- missing declaration for a_frs1516_test_item.truti1sp;
         -- missing declaration for a_frs1516_test_item.truti2sp;
         -- missing declaration for a_frs1516_test_item.expti1sp;
         -- missing declaration for a_frs1516_test_item.expti2sp;
         -- missing declaration for a_frs1516_test_item.menpin11;
         -- missing declaration for a_frs1516_test_item.menpin12;
         -- missing declaration for a_frs1516_test_item.menpin13;
         -- missing declaration for a_frs1516_test_item.menpin21;
         -- missing declaration for a_frs1516_test_item.menpin22;
         -- missing declaration for a_frs1516_test_item.menpin23;
         -- missing declaration for a_frs1516_test_item.menpin31;
         -- missing declaration for a_frs1516_test_item.menpin32;
         -- missing declaration for a_frs1516_test_item.menpin33;
         a_frs1516_test_item.menpol11 := 1010100.012 + Amount( i );
         a_frs1516_test_item.menpol12 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.menpol13;
         a_frs1516_test_item.menpol21 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.menpol22;
         -- missing declaration for a_frs1516_test_item.menpol23;
         -- missing declaration for a_frs1516_test_item.menpol31;
         -- missing declaration for a_frs1516_test_item.menpol32;
         -- missing declaration for a_frs1516_test_item.menpol33;
         -- missing declaration for a_frs1516_test_item.pmenpo11;
         -- missing declaration for a_frs1516_test_item.pmenpo12;
         -- missing declaration for a_frs1516_test_item.pmenpo13;
         -- missing declaration for a_frs1516_test_item.pmenpo21;
         -- missing declaration for a_frs1516_test_item.pmenpo22;
         -- missing declaration for a_frs1516_test_item.pmenpo23;
         -- missing declaration for a_frs1516_test_item.pmenpo31;
         -- missing declaration for a_frs1516_test_item.pmenpo32;
         -- missing declaration for a_frs1516_test_item.pmenpo33;
         -- missing declaration for a_frs1516_test_item.bedroom;
         -- missing declaration for a_frs1516_test_item.benunits;
         -- missing declaration for a_frs1516_test_item.billrate;
         -- missing declaration for a_frs1516_test_item.brma;
         -- missing declaration for a_frs1516_test_item.burden;
         -- missing declaration for a_frs1516_test_item.busroom;
         -- missing declaration for a_frs1516_test_item.capval;
         -- missing declaration for a_frs1516_test_item.charge1;
         -- missing declaration for a_frs1516_test_item.charge2;
         -- missing declaration for a_frs1516_test_item.charge3;
         -- missing declaration for a_frs1516_test_item.charge4;
         -- missing declaration for a_frs1516_test_item.charge5;
         -- missing declaration for a_frs1516_test_item.charge6;
         -- missing declaration for a_frs1516_test_item.charge7;
         -- missing declaration for a_frs1516_test_item.charge8;
         -- missing declaration for a_frs1516_test_item.charge9;
         -- missing declaration for a_frs1516_test_item.chins;
         -- missing declaration for a_frs1516_test_item.chrgpd1;
         -- missing declaration for a_frs1516_test_item.chrgpd2;
         -- missing declaration for a_frs1516_test_item.chrgpd3;
         -- missing declaration for a_frs1516_test_item.chrgpd4;
         -- missing declaration for a_frs1516_test_item.chrgpd5;
         -- missing declaration for a_frs1516_test_item.chrgpd6;
         -- missing declaration for a_frs1516_test_item.chrgpd7;
         -- missing declaration for a_frs1516_test_item.chrgpd8;
         -- missing declaration for a_frs1516_test_item.chrgpd9;
         -- missing declaration for a_frs1516_test_item.covoths;
         a_frs1516_test_item.csewamt := 1010100.012 + Amount( i );
         a_frs1516_test_item.csewamt1 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ct25d50d;
         -- missing declaration for a_frs1516_test_item.ctamt;
         -- missing declaration for a_frs1516_test_item.ctannual;
         -- missing declaration for a_frs1516_test_item.ctband;
         -- missing declaration for a_frs1516_test_item.ctbwait;
         -- missing declaration for a_frs1516_test_item.ctcondoc;
         -- missing declaration for a_frs1516_test_item.ctdisc;
         -- missing declaration for a_frs1516_test_item.ctinstal;
         -- missing declaration for a_frs1516_test_item.ctlvband;
         -- missing declaration for a_frs1516_test_item.ctlvchk;
         -- missing declaration for a_frs1516_test_item.ctreb;
         -- missing declaration for a_frs1516_test_item.ctrebamt;
         -- missing declaration for a_frs1516_test_item.ctrebpd;
         -- missing declaration for a_frs1516_test_item.cttime;
         -- missing declaration for a_frs1516_test_item.cwatamt;
         -- missing declaration for a_frs1516_test_item.cwatamt1;
         -- missing declaration for a_frs1516_test_item.entry1;
         -- missing declaration for a_frs1516_test_item.entry2;
         -- missing declaration for a_frs1516_test_item.entry3;
         -- missing declaration for a_frs1516_test_item.entry4;
         -- missing declaration for a_frs1516_test_item.gvtregn;
         -- missing declaration for a_frs1516_test_item.gvtregno;
         -- missing declaration for a_frs1516_test_item.hhldr01;
         -- missing declaration for a_frs1516_test_item.hhldr02;
         -- missing declaration for a_frs1516_test_item.hhldr03;
         -- missing declaration for a_frs1516_test_item.hhldr04;
         -- missing declaration for a_frs1516_test_item.hhldr05;
         -- missing declaration for a_frs1516_test_item.hhldr06;
         -- missing declaration for a_frs1516_test_item.hhldr07;
         -- missing declaration for a_frs1516_test_item.hhldr08;
         -- missing declaration for a_frs1516_test_item.hhldr09;
         -- missing declaration for a_frs1516_test_item.hhldr10;
         -- missing declaration for a_frs1516_test_item.hhldr11;
         -- missing declaration for a_frs1516_test_item.hhldr12;
         -- missing declaration for a_frs1516_test_item.hhldr13;
         -- missing declaration for a_frs1516_test_item.hhldr14;
         -- missing declaration for a_frs1516_test_item.hhldr97;
         -- missing declaration for a_frs1516_test_item.hhstat;
         -- missing declaration for a_frs1516_test_item.hlthst;
         a_frs1516_test_item.intdate := Ada.Calendar.Clock;
         -- missing declaration for a_frs1516_test_item.mainacc;
         -- missing declaration for a_frs1516_test_item.mnthcode;
         -- missing declaration for a_frs1516_test_item.monlive;
         -- missing declaration for a_frs1516_test_item.multi;
         -- missing declaration for a_frs1516_test_item.nicoun;
         -- missing declaration for a_frs1516_test_item.nidpnd;
         -- missing declaration for a_frs1516_test_item.nmrmshar;
         -- missing declaration for a_frs1516_test_item.nopay;
         -- missing declaration for a_frs1516_test_item.norate;
         -- missing declaration for a_frs1516_test_item.onbsroom;
         -- missing declaration for a_frs1516_test_item.orgid;
         -- missing declaration for a_frs1516_test_item.payrate;
         -- missing declaration for a_frs1516_test_item.ptbsroom;
         -- missing declaration for a_frs1516_test_item.rooms;
         -- missing declaration for a_frs1516_test_item.roomshr;
         a_frs1516_test_item.rt2rebam := 1010100.012 + Amount( i );
         a_frs1516_test_item.rtannual := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.rtcondoc;
         -- missing declaration for a_frs1516_test_item.rtdpa;
         a_frs1516_test_item.rtdpaamt := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.rtene;
         -- missing declaration for a_frs1516_test_item.rteneamt;
         -- missing declaration for a_frs1516_test_item.rtgen;
         -- missing declaration for a_frs1516_test_item.rtinstal;
         -- missing declaration for a_frs1516_test_item.rtlpa;
         a_frs1516_test_item.rtlpaamt := 1010100.012 + Amount( i );
         a_frs1516_test_item.rtothamt := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.rtother;
         -- missing declaration for a_frs1516_test_item.rtreb;
         a_frs1516_test_item.rtrebamt := 1010100.012 + Amount( i );
         a_frs1516_test_item.rtrtramt := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.rttimepd;
         -- missing declaration for a_frs1516_test_item.schbrk;
         -- missing declaration for a_frs1516_test_item.schfrt;
         -- missing declaration for a_frs1516_test_item.schmeal;
         -- missing declaration for a_frs1516_test_item.schmilk;
         a_frs1516_test_item.seramt1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.seramt2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.seramt3 := 1010100.012 + Amount( i );
         a_frs1516_test_item.seramt4 := 1010100.012 + Amount( i );
         a_frs1516_test_item.seramt5 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.sercomb;
         -- missing declaration for a_frs1516_test_item.serpay1;
         -- missing declaration for a_frs1516_test_item.serpay2;
         -- missing declaration for a_frs1516_test_item.serpay3;
         -- missing declaration for a_frs1516_test_item.serpay4;
         -- missing declaration for a_frs1516_test_item.serpay5;
         a_frs1516_test_item.sewamt := 1010100.012 + Amount( i );
         a_frs1516_test_item.sewanul := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.sewerpay;
         -- missing declaration for a_frs1516_test_item.sewsep;
         -- missing declaration for a_frs1516_test_item.sewtime;
         -- missing declaration for a_frs1516_test_item.shelter;
         -- missing declaration for a_frs1516_test_item.sobuy;
         a_frs1516_test_item.stramt1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.stramt2 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.strcov;
         -- missing declaration for a_frs1516_test_item.strmort;
         -- missing declaration for a_frs1516_test_item.stroths;
         -- missing declaration for a_frs1516_test_item.strpd1;
         -- missing declaration for a_frs1516_test_item.strpd2;
         -- missing declaration for a_frs1516_test_item.suballow;
         -- missing declaration for a_frs1516_test_item.sublet;
         -- missing declaration for a_frs1516_test_item.sublety;
         a_frs1516_test_item.subrent := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.tenure;
         -- missing declaration for a_frs1516_test_item.tvlic;
         -- missing declaration for a_frs1516_test_item.typeacc;
         -- missing declaration for a_frs1516_test_item.urb;
         -- missing declaration for a_frs1516_test_item.urbrur;
         -- missing declaration for a_frs1516_test_item.urindew;
         -- missing declaration for a_frs1516_test_item.urinds;
         a_frs1516_test_item.watamt := 1010100.012 + Amount( i );
         a_frs1516_test_item.watanul := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.watermet;
         -- missing declaration for a_frs1516_test_item.waterpay;
         -- missing declaration for a_frs1516_test_item.watrb;
         -- missing declaration for a_frs1516_test_item.wattime;
         -- missing declaration for a_frs1516_test_item.whoctbot;
         -- missing declaration for a_frs1516_test_item.whorsp01;
         -- missing declaration for a_frs1516_test_item.whorsp02;
         -- missing declaration for a_frs1516_test_item.whorsp03;
         -- missing declaration for a_frs1516_test_item.whorsp04;
         -- missing declaration for a_frs1516_test_item.whorsp05;
         -- missing declaration for a_frs1516_test_item.whorsp06;
         -- missing declaration for a_frs1516_test_item.whorsp07;
         -- missing declaration for a_frs1516_test_item.whorsp08;
         -- missing declaration for a_frs1516_test_item.whorsp09;
         -- missing declaration for a_frs1516_test_item.whorsp10;
         -- missing declaration for a_frs1516_test_item.whorsp11;
         -- missing declaration for a_frs1516_test_item.whorsp12;
         -- missing declaration for a_frs1516_test_item.whorsp13;
         -- missing declaration for a_frs1516_test_item.whorsp14;
         -- missing declaration for a_frs1516_test_item.whynoct;
         a_frs1516_test_item.wsewamt := 1010100.012 + Amount( i );
         a_frs1516_test_item.wsewanul := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.wsewtime;
         -- missing declaration for a_frs1516_test_item.yearlive;
         -- missing declaration for a_frs1516_test_item.yearwhc;
         -- missing declaration for a_frs1516_test_item.adulth;
         -- missing declaration for a_frs1516_test_item.cwatamtd;
         -- missing declaration for a_frs1516_test_item.depchldh;
         -- missing declaration for a_frs1516_test_item.dischha1;
         -- missing declaration for a_frs1516_test_item.dischhc1;
         -- missing declaration for a_frs1516_test_item.diswhha1;
         -- missing declaration for a_frs1516_test_item.diswhhc1;
         a_frs1516_test_item.endowpay := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.gbhscost;
         -- missing declaration for a_frs1516_test_item.grossct;
         -- missing declaration for a_frs1516_test_item.hbeninc;
         -- missing declaration for a_frs1516_test_item.hbindhh;
         -- missing declaration for a_frs1516_test_item.hbindhh2;
         -- missing declaration for a_frs1516_test_item.hearns;
         -- missing declaration for a_frs1516_test_item.hhdisben;
         -- missing declaration for a_frs1516_test_item.hhinc;
         -- missing declaration for a_frs1516_test_item.hhinv;
         -- missing declaration for a_frs1516_test_item.hhirben;
         -- missing declaration for a_frs1516_test_item.hhnirben;
         -- missing declaration for a_frs1516_test_item.hhothben;
         -- missing declaration for a_frs1516_test_item.hhrent;
         -- missing declaration for a_frs1516_test_item.hhrinc;
         -- missing declaration for a_frs1516_test_item.hhrpinc;
         a_frs1516_test_item.hhtvlic := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.hhtxcred;
         -- missing declaration for a_frs1516_test_item.hothinc;
         -- missing declaration for a_frs1516_test_item.hpeninc;
         -- missing declaration for a_frs1516_test_item.hseinc;
         -- missing declaration for a_frs1516_test_item.london;
         a_frs1516_test_item.mortint := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.nihscost;
         -- missing declaration for a_frs1516_test_item.penage;
         -- missing declaration for a_frs1516_test_item.penhrp;
         -- missing declaration for a_frs1516_test_item.ptentyp2;
         a_frs1516_test_item.servpay := 1010100.012 + Amount( i );
         a_frs1516_test_item.struins := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.tentyp2;
         -- missing declaration for a_frs1516_test_item.tuhhrent;
         a_frs1516_test_item.tuwatsew := 1010100.012 + Amount( i );
         a_frs1516_test_item.watsewrt := 1010100.012 + Amount( i );
         a_frs1516_test_item.hcgrent := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.hcfeudut;
         a_frs1516_test_item.hcchrent := 1010100.012 + Amount( i );
         a_frs1516_test_item.hcservch := 1010100.012 + Amount( i );
         a_frs1516_test_item.hcmaint := 1010100.012 + Amount( i );
         a_frs1516_test_item.hcsirent := 1010100.012 + Amount( i );
         a_frs1516_test_item.hcfactor := 1010100.012 + Amount( i );
         a_frs1516_test_item.hcother := 1010100.012 + Amount( i );
         a_frs1516_test_item.hcpcomb := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.gvhelp;
         -- missing declaration for a_frs1516_test_item.lacode;
         -- missing declaration for a_frs1516_test_item.lauacode;
         -- missing declaration for a_frs1516_test_item.llcare;
         -- missing declaration for a_frs1516_test_item.needcare;
         -- missing declaration for a_frs1516_test_item.colourtv;
         -- missing declaration for a_frs1516_test_item.bwtv;
         -- missing declaration for a_frs1516_test_item.serpd1;
         -- missing declaration for a_frs1516_test_item.serpd2;
         -- missing declaration for a_frs1516_test_item.serpd3;
         -- missing declaration for a_frs1516_test_item.serpd4;
         -- missing declaration for a_frs1516_test_item.serpd5;
         a_frs1516_test_item.outsam11 := 1010100.012 + Amount( i );
         a_frs1516_test_item.outsam12 := 1010100.012 + Amount( i );
         a_frs1516_test_item.outsam21 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.outsam22;
         -- missing declaration for a_frs1516_test_item.outsam31;
         -- missing declaration for a_frs1516_test_item.outsam32;
         -- missing declaration for a_frs1516_test_item.outsin11;
         -- missing declaration for a_frs1516_test_item.outsin12;
         -- missing declaration for a_frs1516_test_item.outsin21;
         -- missing declaration for a_frs1516_test_item.outsin22;
         -- missing declaration for a_frs1516_test_item.outsin31;
         -- missing declaration for a_frs1516_test_item.outsin32;
         -- missing declaration for a_frs1516_test_item.outspa11;
         -- missing declaration for a_frs1516_test_item.outspa12;
         -- missing declaration for a_frs1516_test_item.outspa21;
         -- missing declaration for a_frs1516_test_item.outspa22;
         -- missing declaration for a_frs1516_test_item.outspa31;
         -- missing declaration for a_frs1516_test_item.outspa32;
         -- missing declaration for a_frs1516_test_item.outspd11;
         -- missing declaration for a_frs1516_test_item.outspd12;
         -- missing declaration for a_frs1516_test_item.outspd21;
         -- missing declaration for a_frs1516_test_item.outspd22;
         -- missing declaration for a_frs1516_test_item.outspd31;
         -- missing declaration for a_frs1516_test_item.outspd32;
         a_frs1516_test_item.borramt1 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.borramt2;
         -- missing declaration for a_frs1516_test_item.borramt3;
         -- missing declaration for a_frs1516_test_item.endwp11;
         -- missing declaration for a_frs1516_test_item.endwp12;
         -- missing declaration for a_frs1516_test_item.endwp13;
         -- missing declaration for a_frs1516_test_item.endwp21;
         -- missing declaration for a_frs1516_test_item.endwp22;
         -- missing declaration for a_frs1516_test_item.endwp23;
         -- missing declaration for a_frs1516_test_item.endwp31;
         -- missing declaration for a_frs1516_test_item.endwp32;
         -- missing declaration for a_frs1516_test_item.endwp33;
         -- missing declaration for a_frs1516_test_item.endwp41;
         -- missing declaration for a_frs1516_test_item.endwp42;
         -- missing declaration for a_frs1516_test_item.endwp43;
         -- missing declaration for a_frs1516_test_item.endwp51;
         -- missing declaration for a_frs1516_test_item.endwp52;
         -- missing declaration for a_frs1516_test_item.endwp53;
         -- missing declaration for a_frs1516_test_item.incmin11;
         -- missing declaration for a_frs1516_test_item.incmin12;
         -- missing declaration for a_frs1516_test_item.incmin13;
         -- missing declaration for a_frs1516_test_item.incmin21;
         -- missing declaration for a_frs1516_test_item.incmin22;
         -- missing declaration for a_frs1516_test_item.incmin23;
         -- missing declaration for a_frs1516_test_item.incmin31;
         -- missing declaration for a_frs1516_test_item.incmin32;
         -- missing declaration for a_frs1516_test_item.incmin33;
         -- missing declaration for a_frs1516_test_item.incmp11;
         -- missing declaration for a_frs1516_test_item.incmp12;
         -- missing declaration for a_frs1516_test_item.incmp13;
         -- missing declaration for a_frs1516_test_item.incmp21;
         -- missing declaration for a_frs1516_test_item.incmp22;
         -- missing declaration for a_frs1516_test_item.incmp23;
         -- missing declaration for a_frs1516_test_item.incmp31;
         -- missing declaration for a_frs1516_test_item.incmp32;
         -- missing declaration for a_frs1516_test_item.incmp33;
         a_frs1516_test_item.incmpa11 := 1010100.012 + Amount( i );
         a_frs1516_test_item.incmpa12 := 1010100.012 + Amount( i );
         a_frs1516_test_item.incmpa13 := 1010100.012 + Amount( i );
         a_frs1516_test_item.incmpa21 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.incmpa22;
         -- missing declaration for a_frs1516_test_item.incmpa23;
         a_frs1516_test_item.incmpa31 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.incmpa32;
         -- missing declaration for a_frs1516_test_item.incmpa33;
         -- missing declaration for a_frs1516_test_item.pincmp11;
         -- missing declaration for a_frs1516_test_item.pincmp12;
         -- missing declaration for a_frs1516_test_item.pincmp13;
         -- missing declaration for a_frs1516_test_item.pincmp21;
         -- missing declaration for a_frs1516_test_item.pincmp22;
         -- missing declaration for a_frs1516_test_item.pincmp23;
         -- missing declaration for a_frs1516_test_item.pincmp31;
         -- missing declaration for a_frs1516_test_item.pincmp32;
         -- missing declaration for a_frs1516_test_item.pincmp33;
         a_frs1516_test_item.intpri1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.intpri2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.intpri3 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.pintrpi1;
         -- missing declaration for a_frs1516_test_item.pintrpi2;
         -- missing declaration for a_frs1516_test_item.pintrpi3;
         -- missing declaration for a_frs1516_test_item.loanyr1;
         -- missing declaration for a_frs1516_test_item.loanyr2;
         -- missing declaration for a_frs1516_test_item.loanyr3;
         -- missing declaration for a_frs1516_test_item.menpol1;
         -- missing declaration for a_frs1516_test_item.menpol2;
         -- missing declaration for a_frs1516_test_item.menpol3;
         -- missing declaration for a_frs1516_test_item.morall1;
         -- missing declaration for a_frs1516_test_item.morall2;
         -- missing declaration for a_frs1516_test_item.morall3;
         -- missing declaration for a_frs1516_test_item.morflc1;
         -- missing declaration for a_frs1516_test_item.morflc2;
         -- missing declaration for a_frs1516_test_item.morflc3;
         a_frs1516_test_item.morinp1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.morinp2 := 1010100.012 + Amount( i );
         a_frs1516_test_item.morinp3 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.pmorinp1;
         -- missing declaration for a_frs1516_test_item.pmorinp2;
         -- missing declaration for a_frs1516_test_item.pmorinp3;
         -- missing declaration for a_frs1516_test_item.morinus1;
         -- missing declaration for a_frs1516_test_item.morinus2;
         -- missing declaration for a_frs1516_test_item.morinus3;
         -- missing declaration for a_frs1516_test_item.mortend1;
         -- missing declaration for a_frs1516_test_item.mortend2;
         -- missing declaration for a_frs1516_test_item.mortend3;
         a_frs1516_test_item.mortlef1 := 1010100.012 + Amount( i );
         a_frs1516_test_item.mortlef2 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.mortlef3;
         -- missing declaration for a_frs1516_test_item.mortpro1;
         -- missing declaration for a_frs1516_test_item.mortpro2;
         -- missing declaration for a_frs1516_test_item.mortpro3;
         -- missing declaration for a_frs1516_test_item.morttyp1;
         -- missing declaration for a_frs1516_test_item.morttyp2;
         -- missing declaration for a_frs1516_test_item.morttyp3;
         -- missing declaration for a_frs1516_test_item.morupd1;
         -- missing declaration for a_frs1516_test_item.morupd2;
         -- missing declaration for a_frs1516_test_item.morupd3;
         a_frs1516_test_item.morus1 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.morus2;
         -- missing declaration for a_frs1516_test_item.morus3;
         -- missing declaration for a_frs1516_test_item.mpcove11;
         -- missing declaration for a_frs1516_test_item.mpcove12;
         -- missing declaration for a_frs1516_test_item.mpcove13;
         -- missing declaration for a_frs1516_test_item.mpcove21;
         -- missing declaration for a_frs1516_test_item.mpcove22;
         -- missing declaration for a_frs1516_test_item.mpcove23;
         -- missing declaration for a_frs1516_test_item.mpcove31;
         -- missing declaration for a_frs1516_test_item.mpcove32;
         -- missing declaration for a_frs1516_test_item.mpcove33;
         -- missing declaration for a_frs1516_test_item.outsmor1;
         -- missing declaration for a_frs1516_test_item.outsmor2;
         -- missing declaration for a_frs1516_test_item.outsmor3;
         a_frs1516_test_item.rmamt1 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.rmamt2;
         -- missing declaration for a_frs1516_test_item.rmamt3;
         -- missing declaration for a_frs1516_test_item.rmort1;
         -- missing declaration for a_frs1516_test_item.rmort2;
         -- missing declaration for a_frs1516_test_item.rmort3;
         -- missing declaration for a_frs1516_test_item.rmortyr1;
         -- missing declaration for a_frs1516_test_item.rmortyr2;
         -- missing declaration for a_frs1516_test_item.rmortyr3;
         -- missing declaration for a_frs1516_test_item.rmpur011;
         -- missing declaration for a_frs1516_test_item.rmpur012;
         -- missing declaration for a_frs1516_test_item.rmpur013;
         -- missing declaration for a_frs1516_test_item.rmpur021;
         -- missing declaration for a_frs1516_test_item.rmpur022;
         -- missing declaration for a_frs1516_test_item.rmpur023;
         -- missing declaration for a_frs1516_test_item.rmpur031;
         -- missing declaration for a_frs1516_test_item.rmpur032;
         -- missing declaration for a_frs1516_test_item.rmpur033;
         -- missing declaration for a_frs1516_test_item.rmpur041;
         -- missing declaration for a_frs1516_test_item.rmpur042;
         -- missing declaration for a_frs1516_test_item.rmpur043;
         -- missing declaration for a_frs1516_test_item.rmpur051;
         -- missing declaration for a_frs1516_test_item.rmpur052;
         -- missing declaration for a_frs1516_test_item.rmpur053;
         -- missing declaration for a_frs1516_test_item.rmpur061;
         -- missing declaration for a_frs1516_test_item.rmpur062;
         -- missing declaration for a_frs1516_test_item.rmpur063;
         -- missing declaration for a_frs1516_test_item.rmpur071;
         -- missing declaration for a_frs1516_test_item.rmpur072;
         -- missing declaration for a_frs1516_test_item.rmpur073;
         -- missing declaration for a_frs1516_test_item.rmpur081;
         -- missing declaration for a_frs1516_test_item.rmpur082;
         -- missing declaration for a_frs1516_test_item.rmpur083;
         -- missing declaration for a_frs1516_test_item.buyyear;
         a_frs1516_test_item.purcamt := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.purcloan;
         -- missing declaration for a_frs1516_test_item.secmpur3;
         -- missing declaration for a_frs1516_test_item.secmpur4;
         -- missing declaration for a_frs1516_test_item.secmpur1;
         -- missing declaration for a_frs1516_test_item.secmpur5;
         -- missing declaration for a_frs1516_test_item.secmpur6;
         -- missing declaration for a_frs1516_test_item.secmpur2;
         -- missing declaration for a_frs1516_test_item.secmpur7;
         a_frs1516_test_item.rexhham1 := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.accchk1;
         -- missing declaration for a_frs1516_test_item.rexhhwh1;
         -- missing declaration for a_frs1516_test_item.prexhha1;
         -- missing declaration for a_frs1516_test_item.accjbp10;
         -- missing declaration for a_frs1516_test_item.accjbp11;
         -- missing declaration for a_frs1516_test_item.accjbp12;
         -- missing declaration for a_frs1516_test_item.accjbp13;
         -- missing declaration for a_frs1516_test_item.accjbp14;
         -- missing declaration for a_frs1516_test_item.accjob;
         -- missing declaration for a_frs1516_test_item.ctract;
         a_frs1516_test_item.eligamt := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.eligpd;
         -- missing declaration for a_frs1516_test_item.fairrent;
         -- missing declaration for a_frs1516_test_item.furnish;
         a_frs1516_test_item.hbenamt := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.hbenchk;
         -- missing declaration for a_frs1516_test_item.hbenefit;
         -- missing declaration for a_frs1516_test_item.hbenpd;
         -- missing declaration for a_frs1516_test_item.hbenwait;
         -- missing declaration for a_frs1516_test_item.hbmnth;
         -- missing declaration for a_frs1516_test_item.hbrecp;
         -- missing declaration for a_frs1516_test_item.hbweeks;
         -- missing declaration for a_frs1516_test_item.hbyear;
         -- missing declaration for a_frs1516_test_item.hbyears;
         -- missing declaration for a_frs1516_test_item.landlord;
         -- missing declaration for a_frs1516_test_item.niystart;
         -- missing declaration for a_frs1516_test_item.othtype;
         -- missing declaration for a_frs1516_test_item.rebate;
         a_frs1516_test_item.rent := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.rentdoc;
         -- missing declaration for a_frs1516_test_item.renthol;
         -- missing declaration for a_frs1516_test_item.rentpd;
         -- missing declaration for a_frs1516_test_item.rentpd1;
         -- missing declaration for a_frs1516_test_item.rentpd2;
         -- missing declaration for a_frs1516_test_item.resll;
         -- missing declaration for a_frs1516_test_item.resll2;
         -- missing declaration for a_frs1516_test_item.serincam;
         -- missing declaration for a_frs1516_test_item.tentype;
         -- missing declaration for a_frs1516_test_item.weekhol;
         -- missing declaration for a_frs1516_test_item.wsinc;
         a_frs1516_test_item.wsincamt := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.ystartr;
         -- missing declaration for a_frs1516_test_item.accjbp1;
         -- missing declaration for a_frs1516_test_item.accjbp2;
         -- missing declaration for a_frs1516_test_item.accjbp3;
         -- missing declaration for a_frs1516_test_item.accjbp4;
         -- missing declaration for a_frs1516_test_item.accjbp5;
         -- missing declaration for a_frs1516_test_item.accjbp6;
         -- missing declaration for a_frs1516_test_item.accjbp7;
         -- missing declaration for a_frs1516_test_item.accjbp8;
         -- missing declaration for a_frs1516_test_item.accjbp9;
         -- missing declaration for a_frs1516_test_item.rexhh;
         a_frs1516_test_item.rntfull := 1010100.012 + Amount( i );
         -- missing declaration for a_frs1516_test_item.lighting;
         -- missing declaration for a_frs1516_test_item.heating;
         -- missing declaration for a_frs1516_test_item.hotwater;
         -- missing declaration for a_frs1516_test_item.fuelcook;
         -- missing declaration for a_frs1516_test_item.tvlice;
         -- missing declaration for a_frs1516_test_item.elec;
         -- missing declaration for a_frs1516_test_item.gas;
         -- missing declaration for a_frs1516_test_item.lsf;
         Ukds.Frs.Frs1516_IO.Save( a_frs1516_test_item, False );         
      end loop;
      
      a_frs1516_test_list := Ukds.Frs.Frs1516_IO.Retrieve( criteria );
      
      Log( "Ukds_Frs_Frs1516_Create_Test: alter tests" );
      for i in 1 .. RECORDS_TO_ALTER loop
         a_frs1516_test_item := Ukds.Frs.Frs1516_List_Package.element( a_frs1516_test_list, i );
         a_frs1516_test_item.ugrsp1hd := To_Unbounded_String("Altered::dat forugrsp1hd" & i'Img);
         Ukds.Frs.Frs1516_IO.Save( a_frs1516_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Frs1516_Create_Test: delete tests" );
      for i in RECORDS_TO_DELETE .. RECORDS_TO_ADD loop
         a_frs1516_test_item := Ukds.Frs.Frs1516_List_Package.element( a_frs1516_test_list, i );
         Ukds.Frs.Frs1516_IO.Delete( a_frs1516_test_item );         
      end loop;
      
      Log( "Ukds_Frs_Frs1516_Create_Test: retrieve all records" );
      Ukds.Frs.Frs1516_List_Package.iterate( a_frs1516_test_list, print'Access );
      endTime := Clock;
      elapsed := endTime - startTime;
      Log( "Ending test Ukds_Frs_Frs1516_Create_Test. Time taken = " & elapsed'Img );

   exception 
      when Error : others =>
         Log( "Ukds_Frs_Frs1516_Create_Test execute query failed with message " & Exception_Information(Error) );
         assert( False,  
            "Ukds_Frs_Frs1516_Create_Test : exception thrown " & Exception_Information(Error) );
   end Ukds_Frs_Frs1516_Create_Test;

   
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
         -- missing declaration for a_pianon1314_test_item.pidefbhc;
         -- missing declaration for a_pianon1314_test_item.pidefahc;
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
         -- missing declaration for a_pianon1314_test_item.coup_q1;
         -- missing declaration for a_pianon1314_test_item.coup_q2;
         -- missing declaration for a_pianon1314_test_item.coup_q3;
         -- missing declaration for a_pianon1314_test_item.coup_q4;
         -- missing declaration for a_pianon1314_test_item.coup_q5;
         -- missing declaration for a_pianon1314_test_item.acou_q1;
         -- missing declaration for a_pianon1314_test_item.acou_q2;
         -- missing declaration for a_pianon1314_test_item.acou_q3;
         -- missing declaration for a_pianon1314_test_item.acou_q4;
         -- missing declaration for a_pianon1314_test_item.acou_q5;
         -- missing declaration for a_pianon1314_test_item.sing_q1;
         -- missing declaration for a_pianon1314_test_item.sing_q2;
         -- missing declaration for a_pianon1314_test_item.sing_q3;
         -- missing declaration for a_pianon1314_test_item.sing_q4;
         -- missing declaration for a_pianon1314_test_item.sing_q5;
         -- missing declaration for a_pianon1314_test_item.asin_q1;
         -- missing declaration for a_pianon1314_test_item.asin_q2;
         -- missing declaration for a_pianon1314_test_item.asin_q3;
         -- missing declaration for a_pianon1314_test_item.asin_q4;
         -- missing declaration for a_pianon1314_test_item.asin_q5;
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
      Register_Routine (T, Ukds_Frs_Frs1516_Create_Test'Access, "Test of Creation and deletion of Ukds.Frs.Frs1516" );
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

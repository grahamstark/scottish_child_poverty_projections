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
with Ukds.Frs.Accounts_IO;
with Ukds.Frs.Pianon1516_IO;
with Ukds.Frs.Pianon1415_IO;
with Ukds.Frs.Pianon1314_IO;
with Ukds.Frs.Prscrptn_IO;
with Ukds.Frs.Chldcare_IO;
with Ukds.Frs.Accouts_IO;
with Ukds.Frs.Oddjob_IO;
with Ukds.Frs.Penamt_IO;
with Ukds.Frs.Penprov_IO;
with Ukds.Frs.Job_IO;
with Ukds.Frs.Pianon1213_IO;
with Ukds.Frs.Adult_IO;
with Ukds.Frs.Child_IO;
with Ukds.Frs.Care_IO;
with Ukds.Frs.Pianon1011_IO;
with Ukds.Frs.Extchild_IO;
with Ukds.Frs.Benefits_IO;
with Ukds.Frs.Assets_IO;
with Ukds.Frs.Pension_IO;
with Ukds.Frs.Childcare_IO;
with Ukds.Frs.Pianom0809_IO;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds.Frs.Benunit_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.BENUNIT_IO" );
   
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
         "user_id, edition, year, sernum, benunit, incchnge, inchilow, kidinc, nhhchild, totsav," &
         "month, actaccb, adddabu, adultb, basactb, boarder, bpeninc, bseinc, buagegr2, buagegrp," &
         "budisben, buearns, buethgr2, buethgrp, buinc, buinv, buirben, bukids, bunirben, buothben," &
         "burent, burinc, burpinc, butvlic, butxcred, chddabu, curactb, depchldb, depdeds, disindhb," &
         "ecotypbu, ecstatbu, famthbai, famtypbs, famtypbu, famtype, fsbndctb, fsmbu, fsmlkbu, fwmlkbu," &
         "gebactb, giltctb, gross2, gross3, hbindbu, isactb, kid04, kid1115, kid1618, kid510," &
         "kidsbu0, kidsbu1, kidsbu10, kidsbu11, kidsbu12, kidsbu13, kidsbu14, kidsbu15, kidsbu16, kidsbu17," &
         "kidsbu18, kidsbu2, kidsbu3, kidsbu4, kidsbu5, kidsbu6, kidsbu7, kidsbu8, kidsbu9, lastwork," &
         "lodger, nsboctb, otbsctb, pepsctb, poacctb, prboctb, sayectb, sclbctb, ssctb, stshctb," &
         "subltamt, tessctb, totcapbu, totsavbu, tuburent, untrctb, youngch, adddec, addeples, addhol," &
         "addins, addmel, addmon, addshoe, adepfur, af1, afdep2, cdelply, cdepbed, cdepcel," &
         "cdepeqp, cdephol, cdeples, cdepsum, cdeptea, cdeptrp, cplay, debt1, debt2, debt3," &
         "debt4, debt5, debt6, debt7, debt8, debt9, houshe1, incold, crunacb, enomortb," &
         "hbindbu2, pocardb, kid1619, totcapb2, billnt1, billnt2, billnt3, billnt4, billnt5, billnt6," &
         "billnt7, billnt8, coatnt1, coatnt2, coatnt3, coatnt4, coatnt5, coatnt6, coatnt7, coatnt8," &
         "cooknt1, cooknt2, cooknt3, cooknt4, cooknt5, cooknt6, cooknt7, cooknt8, dampnt1, dampnt2," &
         "dampnt3, dampnt4, dampnt5, dampnt6, dampnt7, dampnt8, frndnt1, frndnt2, frndnt3, frndnt4," &
         "frndnt5, frndnt6, frndnt7, frndnt8, hairnt1, hairnt2, hairnt3, hairnt4, hairnt5, hairnt6," &
         "hairnt7, hairnt8, heatnt1, heatnt2, heatnt3, heatnt4, heatnt5, heatnt6, heatnt7, heatnt8," &
         "holnt1, holnt2, holnt3, holnt4, holnt5, holnt6, holnt7, holnt8, homent1, homent2," &
         "homent3, homent4, homent5, homent6, homent7, homent8, issue, mealnt1, mealnt2, mealnt3," &
         "mealnt4, mealnt5, mealnt6, mealnt7, mealnt8, oabill, oacoat, oacook, oadamp, oaexpns," &
         "oafrnd, oahair, oaheat, oahol, oahome, oahowpy1, oahowpy2, oahowpy3, oahowpy4, oahowpy5," &
         "oahowpy6, oameal, oaout, oaphon, oataxi, oawarm, outnt1, outnt2, outnt3, outnt4," &
         "outnt5, outnt6, outnt7, outnt8, phonnt1, phonnt2, phonnt3, phonnt4, phonnt5, phonnt6," &
         "phonnt7, phonnt8, taxint1, taxint2, taxint3, taxint4, taxint5, taxint6, taxint7, taxint8," &
         "warmnt1, warmnt2, warmnt3, warmnt4, warmnt5, warmnt6, warmnt7, warmnt8, buagegr3, buagegr4," &
         "heartbu, newfambu, billnt9, cbaamt1, cbaamt2, coatnt9, cooknt9, dampnt9, frndnt9, hairnt9," &
         "hbolng, hbothamt, hbothbu, hbothmn, hbothpd, hbothwk, hbothyr, hbotwait, heatnt9, helpgv01," &
         "helpgv02, helpgv03, helpgv04, helpgv05, helpgv06, helpgv07, helpgv08, helpgv09, helpgv10, helpgv11," &
         "helprc01, helprc02, helprc03, helprc04, helprc05, helprc06, helprc07, helprc08, helprc09, helprc10," &
         "helprc11, holnt9, homent9, loangvn1, loangvn2, loangvn3, loanrec1, loanrec2, loanrec3, mealnt9," &
         "outnt9, phonnt9, taxint9, warmnt9, ecostabu, famtypb2, gross3_x, newfamb2, oabilimp, oacoaimp," &
         "oacooimp, oadamimp, oaexpimp, oafrnimp, oahaiimp, oaheaimp, oaholimp, oahomimp, oameaimp, oaoutimp," &
         "oaphoimp, oataximp, oawarimp, totcapb3, adbtbl, cdepact, cdepveg, cdpcoat, oapre, buethgr3," &
         "fsbbu, addholr, computer, compuwhy, crime, damp, dark, debt01, debt02, debt03," &
         "debt04, debt05, debt06, debt07, debt08, debt09, debt10, debt11, debt12, debtar01," &
         "debtar02, debtar03, debtar04, debtar05, debtar06, debtar07, debtar08, debtar09, debtar10, debtar11," &
         "debtar12, debtfre1, debtfre2, debtfre3, endsmeet, eucar, eucarwhy, euexpns, eumeal, eurepay," &
         "euteleph, eutelwhy, expnsoa, houshew, noise, oacareu1, oacareu2, oacareu3, oacareu4, oacareu5," &
         "oacareu6, oacareu7, oacareu8, oataxieu, oatelep1, oatelep2, oatelep3, oatelep4, oatelep5, oatelep6," &
         "oatelep7, oatelep8, oateleph, outpay, outpyamt, pollute, regpamt, regularp, repaybur, washmach," &
         "washwhy, whodepq, discbua1, discbuc1, diswbua1, diswbuc1, fsfvbu, gross4, adles, adlesnt1," &
         "adlesnt2, adlesnt3, adlesnt4, adlesnt5, adlesnt6, adlesnt7, adlesnt8, adlesoa, clothes, clothnt1," &
         "clothnt2, clothnt3, clothnt4, clothnt5, clothnt6, clothnt7, clothnt8, clothsoa, furnt1, furnt2," &
         "furnt3, furnt4, furnt5, furnt6, furnt7, furnt8, intntnt1, intntnt2, intntnt3, intntnt4," &
         "intntnt5, intntnt6, intntnt7, intntnt8, intrnet, meal, oadep2, oadp2nt1, oadp2nt2, oadp2nt3," &
         "oadp2nt4, oadp2nt5, oadp2nt6, oadp2nt7, oadp2nt8, oafur, oaintern, shoe, shoent1, shoent2," &
         "shoent3, shoent4, shoent5, shoent6, shoent7, shoent8, shoeoa, nbunirbn, nbuothbn, debt13," &
         "debtar13, euchbook, euchclth, euchgame, euchmeat, euchshoe, eupbtran, eupbtrn1, eupbtrn2, eupbtrn3," &
         "eupbtrn4, eupbtrn5, euroast, eusmeal, eustudy, bueth, oaeusmea, oaholb, oaroast, ecostab2" &
         " from frs.benunit " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.benunit (" &
         "user_id, edition, year, sernum, benunit, incchnge, inchilow, kidinc, nhhchild, totsav," &
         "month, actaccb, adddabu, adultb, basactb, boarder, bpeninc, bseinc, buagegr2, buagegrp," &
         "budisben, buearns, buethgr2, buethgrp, buinc, buinv, buirben, bukids, bunirben, buothben," &
         "burent, burinc, burpinc, butvlic, butxcred, chddabu, curactb, depchldb, depdeds, disindhb," &
         "ecotypbu, ecstatbu, famthbai, famtypbs, famtypbu, famtype, fsbndctb, fsmbu, fsmlkbu, fwmlkbu," &
         "gebactb, giltctb, gross2, gross3, hbindbu, isactb, kid04, kid1115, kid1618, kid510," &
         "kidsbu0, kidsbu1, kidsbu10, kidsbu11, kidsbu12, kidsbu13, kidsbu14, kidsbu15, kidsbu16, kidsbu17," &
         "kidsbu18, kidsbu2, kidsbu3, kidsbu4, kidsbu5, kidsbu6, kidsbu7, kidsbu8, kidsbu9, lastwork," &
         "lodger, nsboctb, otbsctb, pepsctb, poacctb, prboctb, sayectb, sclbctb, ssctb, stshctb," &
         "subltamt, tessctb, totcapbu, totsavbu, tuburent, untrctb, youngch, adddec, addeples, addhol," &
         "addins, addmel, addmon, addshoe, adepfur, af1, afdep2, cdelply, cdepbed, cdepcel," &
         "cdepeqp, cdephol, cdeples, cdepsum, cdeptea, cdeptrp, cplay, debt1, debt2, debt3," &
         "debt4, debt5, debt6, debt7, debt8, debt9, houshe1, incold, crunacb, enomortb," &
         "hbindbu2, pocardb, kid1619, totcapb2, billnt1, billnt2, billnt3, billnt4, billnt5, billnt6," &
         "billnt7, billnt8, coatnt1, coatnt2, coatnt3, coatnt4, coatnt5, coatnt6, coatnt7, coatnt8," &
         "cooknt1, cooknt2, cooknt3, cooknt4, cooknt5, cooknt6, cooknt7, cooknt8, dampnt1, dampnt2," &
         "dampnt3, dampnt4, dampnt5, dampnt6, dampnt7, dampnt8, frndnt1, frndnt2, frndnt3, frndnt4," &
         "frndnt5, frndnt6, frndnt7, frndnt8, hairnt1, hairnt2, hairnt3, hairnt4, hairnt5, hairnt6," &
         "hairnt7, hairnt8, heatnt1, heatnt2, heatnt3, heatnt4, heatnt5, heatnt6, heatnt7, heatnt8," &
         "holnt1, holnt2, holnt3, holnt4, holnt5, holnt6, holnt7, holnt8, homent1, homent2," &
         "homent3, homent4, homent5, homent6, homent7, homent8, issue, mealnt1, mealnt2, mealnt3," &
         "mealnt4, mealnt5, mealnt6, mealnt7, mealnt8, oabill, oacoat, oacook, oadamp, oaexpns," &
         "oafrnd, oahair, oaheat, oahol, oahome, oahowpy1, oahowpy2, oahowpy3, oahowpy4, oahowpy5," &
         "oahowpy6, oameal, oaout, oaphon, oataxi, oawarm, outnt1, outnt2, outnt3, outnt4," &
         "outnt5, outnt6, outnt7, outnt8, phonnt1, phonnt2, phonnt3, phonnt4, phonnt5, phonnt6," &
         "phonnt7, phonnt8, taxint1, taxint2, taxint3, taxint4, taxint5, taxint6, taxint7, taxint8," &
         "warmnt1, warmnt2, warmnt3, warmnt4, warmnt5, warmnt6, warmnt7, warmnt8, buagegr3, buagegr4," &
         "heartbu, newfambu, billnt9, cbaamt1, cbaamt2, coatnt9, cooknt9, dampnt9, frndnt9, hairnt9," &
         "hbolng, hbothamt, hbothbu, hbothmn, hbothpd, hbothwk, hbothyr, hbotwait, heatnt9, helpgv01," &
         "helpgv02, helpgv03, helpgv04, helpgv05, helpgv06, helpgv07, helpgv08, helpgv09, helpgv10, helpgv11," &
         "helprc01, helprc02, helprc03, helprc04, helprc05, helprc06, helprc07, helprc08, helprc09, helprc10," &
         "helprc11, holnt9, homent9, loangvn1, loangvn2, loangvn3, loanrec1, loanrec2, loanrec3, mealnt9," &
         "outnt9, phonnt9, taxint9, warmnt9, ecostabu, famtypb2, gross3_x, newfamb2, oabilimp, oacoaimp," &
         "oacooimp, oadamimp, oaexpimp, oafrnimp, oahaiimp, oaheaimp, oaholimp, oahomimp, oameaimp, oaoutimp," &
         "oaphoimp, oataximp, oawarimp, totcapb3, adbtbl, cdepact, cdepveg, cdpcoat, oapre, buethgr3," &
         "fsbbu, addholr, computer, compuwhy, crime, damp, dark, debt01, debt02, debt03," &
         "debt04, debt05, debt06, debt07, debt08, debt09, debt10, debt11, debt12, debtar01," &
         "debtar02, debtar03, debtar04, debtar05, debtar06, debtar07, debtar08, debtar09, debtar10, debtar11," &
         "debtar12, debtfre1, debtfre2, debtfre3, endsmeet, eucar, eucarwhy, euexpns, eumeal, eurepay," &
         "euteleph, eutelwhy, expnsoa, houshew, noise, oacareu1, oacareu2, oacareu3, oacareu4, oacareu5," &
         "oacareu6, oacareu7, oacareu8, oataxieu, oatelep1, oatelep2, oatelep3, oatelep4, oatelep5, oatelep6," &
         "oatelep7, oatelep8, oateleph, outpay, outpyamt, pollute, regpamt, regularp, repaybur, washmach," &
         "washwhy, whodepq, discbua1, discbuc1, diswbua1, diswbuc1, fsfvbu, gross4, adles, adlesnt1," &
         "adlesnt2, adlesnt3, adlesnt4, adlesnt5, adlesnt6, adlesnt7, adlesnt8, adlesoa, clothes, clothnt1," &
         "clothnt2, clothnt3, clothnt4, clothnt5, clothnt6, clothnt7, clothnt8, clothsoa, furnt1, furnt2," &
         "furnt3, furnt4, furnt5, furnt6, furnt7, furnt8, intntnt1, intntnt2, intntnt3, intntnt4," &
         "intntnt5, intntnt6, intntnt7, intntnt8, intrnet, meal, oadep2, oadp2nt1, oadp2nt2, oadp2nt3," &
         "oadp2nt4, oadp2nt5, oadp2nt6, oadp2nt7, oadp2nt8, oafur, oaintern, shoe, shoent1, shoent2," &
         "shoent3, shoent4, shoent5, shoent6, shoent7, shoent8, shoeoa, nbunirbn, nbuothbn, debt13," &
         "debtar13, euchbook, euchclth, euchgame, euchmeat, euchshoe, eupbtran, eupbtrn1, eupbtrn2, eupbtrn3," &
         "eupbtrn4, eupbtrn5, euroast, eusmeal, eustudy, bueth, oaeusmea, oaholb, oaroast, ecostab2" &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.benunit ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.benunit set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 510 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : incchnge (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : inchilow (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : kidinc (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : nhhchild (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : totsav (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : month (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : actaccb (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : adddabu (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : adultb (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : basactb (Integer)
           11 => ( Parameter_Float, 0.0 ),   --  : boarder (Amount)
           12 => ( Parameter_Float, 0.0 ),   --  : bpeninc (Amount)
           13 => ( Parameter_Float, 0.0 ),   --  : bseinc (Amount)
           14 => ( Parameter_Integer, 0 ),   --  : buagegr2 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : buagegrp (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : budisben (Integer)
           17 => ( Parameter_Float, 0.0 ),   --  : buearns (Amount)
           18 => ( Parameter_Integer, 0 ),   --  : buethgr2 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : buethgrp (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : buinc (Integer)
           21 => ( Parameter_Float, 0.0 ),   --  : buinv (Amount)
           22 => ( Parameter_Integer, 0 ),   --  : buirben (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : bukids (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : bunirben (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : buothben (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : burent (Integer)
           27 => ( Parameter_Float, 0.0 ),   --  : burinc (Amount)
           28 => ( Parameter_Float, 0.0 ),   --  : burpinc (Amount)
           29 => ( Parameter_Float, 0.0 ),   --  : butvlic (Amount)
           30 => ( Parameter_Float, 0.0 ),   --  : butxcred (Amount)
           31 => ( Parameter_Integer, 0 ),   --  : chddabu (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : curactb (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : depchldb (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : depdeds (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : disindhb (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : ecotypbu (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : ecstatbu (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : famthbai (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : famtypbs (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : famtypbu (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : famtype (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : fsbndctb (Integer)
           43 => ( Parameter_Float, 0.0 ),   --  : fsmbu (Amount)
           44 => ( Parameter_Float, 0.0 ),   --  : fsmlkbu (Amount)
           45 => ( Parameter_Float, 0.0 ),   --  : fwmlkbu (Amount)
           46 => ( Parameter_Integer, 0 ),   --  : gebactb (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : giltctb (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : gross2 (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : gross3 (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : hbindbu (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : isactb (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : kid04 (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : kid1115 (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : kid1618 (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : kid510 (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : kidsbu0 (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : kidsbu1 (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : kidsbu10 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : kidsbu11 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : kidsbu12 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : kidsbu13 (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : kidsbu14 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : kidsbu15 (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : kidsbu16 (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : kidsbu17 (Integer)
           66 => ( Parameter_Integer, 0 ),   --  : kidsbu18 (Integer)
           67 => ( Parameter_Integer, 0 ),   --  : kidsbu2 (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : kidsbu3 (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : kidsbu4 (Integer)
           70 => ( Parameter_Integer, 0 ),   --  : kidsbu5 (Integer)
           71 => ( Parameter_Integer, 0 ),   --  : kidsbu6 (Integer)
           72 => ( Parameter_Integer, 0 ),   --  : kidsbu7 (Integer)
           73 => ( Parameter_Integer, 0 ),   --  : kidsbu8 (Integer)
           74 => ( Parameter_Integer, 0 ),   --  : kidsbu9 (Integer)
           75 => ( Parameter_Integer, 0 ),   --  : lastwork (Integer)
           76 => ( Parameter_Float, 0.0 ),   --  : lodger (Amount)
           77 => ( Parameter_Integer, 0 ),   --  : nsboctb (Integer)
           78 => ( Parameter_Integer, 0 ),   --  : otbsctb (Integer)
           79 => ( Parameter_Integer, 0 ),   --  : pepsctb (Integer)
           80 => ( Parameter_Integer, 0 ),   --  : poacctb (Integer)
           81 => ( Parameter_Integer, 0 ),   --  : prboctb (Integer)
           82 => ( Parameter_Integer, 0 ),   --  : sayectb (Integer)
           83 => ( Parameter_Integer, 0 ),   --  : sclbctb (Integer)
           84 => ( Parameter_Integer, 0 ),   --  : ssctb (Integer)
           85 => ( Parameter_Integer, 0 ),   --  : stshctb (Integer)
           86 => ( Parameter_Float, 0.0 ),   --  : subltamt (Amount)
           87 => ( Parameter_Integer, 0 ),   --  : tessctb (Integer)
           88 => ( Parameter_Float, 0.0 ),   --  : totcapbu (Amount)
           89 => ( Parameter_Integer, 0 ),   --  : totsavbu (Integer)
           90 => ( Parameter_Float, 0.0 ),   --  : tuburent (Amount)
           91 => ( Parameter_Integer, 0 ),   --  : untrctb (Integer)
           92 => ( Parameter_Integer, 0 ),   --  : youngch (Integer)
           93 => ( Parameter_Integer, 0 ),   --  : adddec (Integer)
           94 => ( Parameter_Integer, 0 ),   --  : addeples (Integer)
           95 => ( Parameter_Integer, 0 ),   --  : addhol (Integer)
           96 => ( Parameter_Integer, 0 ),   --  : addins (Integer)
           97 => ( Parameter_Integer, 0 ),   --  : addmel (Integer)
           98 => ( Parameter_Integer, 0 ),   --  : addmon (Integer)
           99 => ( Parameter_Integer, 0 ),   --  : addshoe (Integer)
           100 => ( Parameter_Integer, 0 ),   --  : adepfur (Integer)
           101 => ( Parameter_Integer, 0 ),   --  : af1 (Integer)
           102 => ( Parameter_Integer, 0 ),   --  : afdep2 (Integer)
           103 => ( Parameter_Integer, 0 ),   --  : cdelply (Integer)
           104 => ( Parameter_Integer, 0 ),   --  : cdepbed (Integer)
           105 => ( Parameter_Integer, 0 ),   --  : cdepcel (Integer)
           106 => ( Parameter_Integer, 0 ),   --  : cdepeqp (Integer)
           107 => ( Parameter_Integer, 0 ),   --  : cdephol (Integer)
           108 => ( Parameter_Integer, 0 ),   --  : cdeples (Integer)
           109 => ( Parameter_Integer, 0 ),   --  : cdepsum (Integer)
           110 => ( Parameter_Integer, 0 ),   --  : cdeptea (Integer)
           111 => ( Parameter_Integer, 0 ),   --  : cdeptrp (Integer)
           112 => ( Parameter_Integer, 0 ),   --  : cplay (Integer)
           113 => ( Parameter_Integer, 0 ),   --  : debt1 (Integer)
           114 => ( Parameter_Integer, 0 ),   --  : debt2 (Integer)
           115 => ( Parameter_Integer, 0 ),   --  : debt3 (Integer)
           116 => ( Parameter_Integer, 0 ),   --  : debt4 (Integer)
           117 => ( Parameter_Integer, 0 ),   --  : debt5 (Integer)
           118 => ( Parameter_Integer, 0 ),   --  : debt6 (Integer)
           119 => ( Parameter_Integer, 0 ),   --  : debt7 (Integer)
           120 => ( Parameter_Integer, 0 ),   --  : debt8 (Integer)
           121 => ( Parameter_Integer, 0 ),   --  : debt9 (Integer)
           122 => ( Parameter_Integer, 0 ),   --  : houshe1 (Integer)
           123 => ( Parameter_Integer, 0 ),   --  : incold (Integer)
           124 => ( Parameter_Integer, 0 ),   --  : crunacb (Integer)
           125 => ( Parameter_Integer, 0 ),   --  : enomortb (Integer)
           126 => ( Parameter_Integer, 0 ),   --  : hbindbu2 (Integer)
           127 => ( Parameter_Integer, 0 ),   --  : pocardb (Integer)
           128 => ( Parameter_Integer, 0 ),   --  : kid1619 (Integer)
           129 => ( Parameter_Float, 0.0 ),   --  : totcapb2 (Amount)
           130 => ( Parameter_Integer, 0 ),   --  : billnt1 (Integer)
           131 => ( Parameter_Integer, 0 ),   --  : billnt2 (Integer)
           132 => ( Parameter_Integer, 0 ),   --  : billnt3 (Integer)
           133 => ( Parameter_Integer, 0 ),   --  : billnt4 (Integer)
           134 => ( Parameter_Integer, 0 ),   --  : billnt5 (Integer)
           135 => ( Parameter_Integer, 0 ),   --  : billnt6 (Integer)
           136 => ( Parameter_Integer, 0 ),   --  : billnt7 (Integer)
           137 => ( Parameter_Integer, 0 ),   --  : billnt8 (Integer)
           138 => ( Parameter_Integer, 0 ),   --  : coatnt1 (Integer)
           139 => ( Parameter_Integer, 0 ),   --  : coatnt2 (Integer)
           140 => ( Parameter_Integer, 0 ),   --  : coatnt3 (Integer)
           141 => ( Parameter_Integer, 0 ),   --  : coatnt4 (Integer)
           142 => ( Parameter_Integer, 0 ),   --  : coatnt5 (Integer)
           143 => ( Parameter_Integer, 0 ),   --  : coatnt6 (Integer)
           144 => ( Parameter_Integer, 0 ),   --  : coatnt7 (Integer)
           145 => ( Parameter_Integer, 0 ),   --  : coatnt8 (Integer)
           146 => ( Parameter_Integer, 0 ),   --  : cooknt1 (Integer)
           147 => ( Parameter_Integer, 0 ),   --  : cooknt2 (Integer)
           148 => ( Parameter_Integer, 0 ),   --  : cooknt3 (Integer)
           149 => ( Parameter_Integer, 0 ),   --  : cooknt4 (Integer)
           150 => ( Parameter_Integer, 0 ),   --  : cooknt5 (Integer)
           151 => ( Parameter_Integer, 0 ),   --  : cooknt6 (Integer)
           152 => ( Parameter_Integer, 0 ),   --  : cooknt7 (Integer)
           153 => ( Parameter_Integer, 0 ),   --  : cooknt8 (Integer)
           154 => ( Parameter_Integer, 0 ),   --  : dampnt1 (Integer)
           155 => ( Parameter_Integer, 0 ),   --  : dampnt2 (Integer)
           156 => ( Parameter_Integer, 0 ),   --  : dampnt3 (Integer)
           157 => ( Parameter_Integer, 0 ),   --  : dampnt4 (Integer)
           158 => ( Parameter_Integer, 0 ),   --  : dampnt5 (Integer)
           159 => ( Parameter_Integer, 0 ),   --  : dampnt6 (Integer)
           160 => ( Parameter_Integer, 0 ),   --  : dampnt7 (Integer)
           161 => ( Parameter_Integer, 0 ),   --  : dampnt8 (Integer)
           162 => ( Parameter_Integer, 0 ),   --  : frndnt1 (Integer)
           163 => ( Parameter_Integer, 0 ),   --  : frndnt2 (Integer)
           164 => ( Parameter_Integer, 0 ),   --  : frndnt3 (Integer)
           165 => ( Parameter_Integer, 0 ),   --  : frndnt4 (Integer)
           166 => ( Parameter_Integer, 0 ),   --  : frndnt5 (Integer)
           167 => ( Parameter_Integer, 0 ),   --  : frndnt6 (Integer)
           168 => ( Parameter_Integer, 0 ),   --  : frndnt7 (Integer)
           169 => ( Parameter_Integer, 0 ),   --  : frndnt8 (Integer)
           170 => ( Parameter_Integer, 0 ),   --  : hairnt1 (Integer)
           171 => ( Parameter_Integer, 0 ),   --  : hairnt2 (Integer)
           172 => ( Parameter_Integer, 0 ),   --  : hairnt3 (Integer)
           173 => ( Parameter_Integer, 0 ),   --  : hairnt4 (Integer)
           174 => ( Parameter_Integer, 0 ),   --  : hairnt5 (Integer)
           175 => ( Parameter_Integer, 0 ),   --  : hairnt6 (Integer)
           176 => ( Parameter_Integer, 0 ),   --  : hairnt7 (Integer)
           177 => ( Parameter_Integer, 0 ),   --  : hairnt8 (Integer)
           178 => ( Parameter_Integer, 0 ),   --  : heatnt1 (Integer)
           179 => ( Parameter_Integer, 0 ),   --  : heatnt2 (Integer)
           180 => ( Parameter_Integer, 0 ),   --  : heatnt3 (Integer)
           181 => ( Parameter_Integer, 0 ),   --  : heatnt4 (Integer)
           182 => ( Parameter_Integer, 0 ),   --  : heatnt5 (Integer)
           183 => ( Parameter_Integer, 0 ),   --  : heatnt6 (Integer)
           184 => ( Parameter_Integer, 0 ),   --  : heatnt7 (Integer)
           185 => ( Parameter_Integer, 0 ),   --  : heatnt8 (Integer)
           186 => ( Parameter_Integer, 0 ),   --  : holnt1 (Integer)
           187 => ( Parameter_Integer, 0 ),   --  : holnt2 (Integer)
           188 => ( Parameter_Integer, 0 ),   --  : holnt3 (Integer)
           189 => ( Parameter_Integer, 0 ),   --  : holnt4 (Integer)
           190 => ( Parameter_Integer, 0 ),   --  : holnt5 (Integer)
           191 => ( Parameter_Integer, 0 ),   --  : holnt6 (Integer)
           192 => ( Parameter_Integer, 0 ),   --  : holnt7 (Integer)
           193 => ( Parameter_Integer, 0 ),   --  : holnt8 (Integer)
           194 => ( Parameter_Integer, 0 ),   --  : homent1 (Integer)
           195 => ( Parameter_Integer, 0 ),   --  : homent2 (Integer)
           196 => ( Parameter_Integer, 0 ),   --  : homent3 (Integer)
           197 => ( Parameter_Integer, 0 ),   --  : homent4 (Integer)
           198 => ( Parameter_Integer, 0 ),   --  : homent5 (Integer)
           199 => ( Parameter_Integer, 0 ),   --  : homent6 (Integer)
           200 => ( Parameter_Integer, 0 ),   --  : homent7 (Integer)
           201 => ( Parameter_Integer, 0 ),   --  : homent8 (Integer)
           202 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           203 => ( Parameter_Integer, 0 ),   --  : mealnt1 (Integer)
           204 => ( Parameter_Integer, 0 ),   --  : mealnt2 (Integer)
           205 => ( Parameter_Integer, 0 ),   --  : mealnt3 (Integer)
           206 => ( Parameter_Integer, 0 ),   --  : mealnt4 (Integer)
           207 => ( Parameter_Integer, 0 ),   --  : mealnt5 (Integer)
           208 => ( Parameter_Integer, 0 ),   --  : mealnt6 (Integer)
           209 => ( Parameter_Integer, 0 ),   --  : mealnt7 (Integer)
           210 => ( Parameter_Integer, 0 ),   --  : mealnt8 (Integer)
           211 => ( Parameter_Integer, 0 ),   --  : oabill (Integer)
           212 => ( Parameter_Integer, 0 ),   --  : oacoat (Integer)
           213 => ( Parameter_Integer, 0 ),   --  : oacook (Integer)
           214 => ( Parameter_Integer, 0 ),   --  : oadamp (Integer)
           215 => ( Parameter_Integer, 0 ),   --  : oaexpns (Integer)
           216 => ( Parameter_Integer, 0 ),   --  : oafrnd (Integer)
           217 => ( Parameter_Integer, 0 ),   --  : oahair (Integer)
           218 => ( Parameter_Integer, 0 ),   --  : oaheat (Integer)
           219 => ( Parameter_Integer, 0 ),   --  : oahol (Integer)
           220 => ( Parameter_Integer, 0 ),   --  : oahome (Integer)
           221 => ( Parameter_Integer, 0 ),   --  : oahowpy1 (Integer)
           222 => ( Parameter_Integer, 0 ),   --  : oahowpy2 (Integer)
           223 => ( Parameter_Integer, 0 ),   --  : oahowpy3 (Integer)
           224 => ( Parameter_Integer, 0 ),   --  : oahowpy4 (Integer)
           225 => ( Parameter_Integer, 0 ),   --  : oahowpy5 (Integer)
           226 => ( Parameter_Integer, 0 ),   --  : oahowpy6 (Integer)
           227 => ( Parameter_Integer, 0 ),   --  : oameal (Integer)
           228 => ( Parameter_Integer, 0 ),   --  : oaout (Integer)
           229 => ( Parameter_Integer, 0 ),   --  : oaphon (Integer)
           230 => ( Parameter_Integer, 0 ),   --  : oataxi (Integer)
           231 => ( Parameter_Integer, 0 ),   --  : oawarm (Integer)
           232 => ( Parameter_Integer, 0 ),   --  : outnt1 (Integer)
           233 => ( Parameter_Integer, 0 ),   --  : outnt2 (Integer)
           234 => ( Parameter_Integer, 0 ),   --  : outnt3 (Integer)
           235 => ( Parameter_Integer, 0 ),   --  : outnt4 (Integer)
           236 => ( Parameter_Integer, 0 ),   --  : outnt5 (Integer)
           237 => ( Parameter_Integer, 0 ),   --  : outnt6 (Integer)
           238 => ( Parameter_Integer, 0 ),   --  : outnt7 (Integer)
           239 => ( Parameter_Integer, 0 ),   --  : outnt8 (Integer)
           240 => ( Parameter_Integer, 0 ),   --  : phonnt1 (Integer)
           241 => ( Parameter_Integer, 0 ),   --  : phonnt2 (Integer)
           242 => ( Parameter_Integer, 0 ),   --  : phonnt3 (Integer)
           243 => ( Parameter_Integer, 0 ),   --  : phonnt4 (Integer)
           244 => ( Parameter_Integer, 0 ),   --  : phonnt5 (Integer)
           245 => ( Parameter_Integer, 0 ),   --  : phonnt6 (Integer)
           246 => ( Parameter_Integer, 0 ),   --  : phonnt7 (Integer)
           247 => ( Parameter_Integer, 0 ),   --  : phonnt8 (Integer)
           248 => ( Parameter_Integer, 0 ),   --  : taxint1 (Integer)
           249 => ( Parameter_Integer, 0 ),   --  : taxint2 (Integer)
           250 => ( Parameter_Integer, 0 ),   --  : taxint3 (Integer)
           251 => ( Parameter_Integer, 0 ),   --  : taxint4 (Integer)
           252 => ( Parameter_Integer, 0 ),   --  : taxint5 (Integer)
           253 => ( Parameter_Integer, 0 ),   --  : taxint6 (Integer)
           254 => ( Parameter_Integer, 0 ),   --  : taxint7 (Integer)
           255 => ( Parameter_Integer, 0 ),   --  : taxint8 (Integer)
           256 => ( Parameter_Integer, 0 ),   --  : warmnt1 (Integer)
           257 => ( Parameter_Integer, 0 ),   --  : warmnt2 (Integer)
           258 => ( Parameter_Integer, 0 ),   --  : warmnt3 (Integer)
           259 => ( Parameter_Integer, 0 ),   --  : warmnt4 (Integer)
           260 => ( Parameter_Integer, 0 ),   --  : warmnt5 (Integer)
           261 => ( Parameter_Integer, 0 ),   --  : warmnt6 (Integer)
           262 => ( Parameter_Integer, 0 ),   --  : warmnt7 (Integer)
           263 => ( Parameter_Integer, 0 ),   --  : warmnt8 (Integer)
           264 => ( Parameter_Integer, 0 ),   --  : buagegr3 (Integer)
           265 => ( Parameter_Integer, 0 ),   --  : buagegr4 (Integer)
           266 => ( Parameter_Float, 0.0 ),   --  : heartbu (Amount)
           267 => ( Parameter_Integer, 0 ),   --  : newfambu (Integer)
           268 => ( Parameter_Integer, 0 ),   --  : billnt9 (Integer)
           269 => ( Parameter_Integer, 0 ),   --  : cbaamt1 (Integer)
           270 => ( Parameter_Integer, 0 ),   --  : cbaamt2 (Integer)
           271 => ( Parameter_Integer, 0 ),   --  : coatnt9 (Integer)
           272 => ( Parameter_Integer, 0 ),   --  : cooknt9 (Integer)
           273 => ( Parameter_Integer, 0 ),   --  : dampnt9 (Integer)
           274 => ( Parameter_Integer, 0 ),   --  : frndnt9 (Integer)
           275 => ( Parameter_Integer, 0 ),   --  : hairnt9 (Integer)
           276 => ( Parameter_Integer, 0 ),   --  : hbolng (Integer)
           277 => ( Parameter_Float, 0.0 ),   --  : hbothamt (Amount)
           278 => ( Parameter_Integer, 0 ),   --  : hbothbu (Integer)
           279 => ( Parameter_Integer, 0 ),   --  : hbothmn (Integer)
           280 => ( Parameter_Integer, 0 ),   --  : hbothpd (Integer)
           281 => ( Parameter_Integer, 0 ),   --  : hbothwk (Integer)
           282 => ( Parameter_Integer, 0 ),   --  : hbothyr (Integer)
           283 => ( Parameter_Integer, 0 ),   --  : hbotwait (Integer)
           284 => ( Parameter_Integer, 0 ),   --  : heatnt9 (Integer)
           285 => ( Parameter_Integer, 0 ),   --  : helpgv01 (Integer)
           286 => ( Parameter_Integer, 0 ),   --  : helpgv02 (Integer)
           287 => ( Parameter_Integer, 0 ),   --  : helpgv03 (Integer)
           288 => ( Parameter_Integer, 0 ),   --  : helpgv04 (Integer)
           289 => ( Parameter_Integer, 0 ),   --  : helpgv05 (Integer)
           290 => ( Parameter_Integer, 0 ),   --  : helpgv06 (Integer)
           291 => ( Parameter_Integer, 0 ),   --  : helpgv07 (Integer)
           292 => ( Parameter_Integer, 0 ),   --  : helpgv08 (Integer)
           293 => ( Parameter_Integer, 0 ),   --  : helpgv09 (Integer)
           294 => ( Parameter_Integer, 0 ),   --  : helpgv10 (Integer)
           295 => ( Parameter_Integer, 0 ),   --  : helpgv11 (Integer)
           296 => ( Parameter_Integer, 0 ),   --  : helprc01 (Integer)
           297 => ( Parameter_Integer, 0 ),   --  : helprc02 (Integer)
           298 => ( Parameter_Integer, 0 ),   --  : helprc03 (Integer)
           299 => ( Parameter_Integer, 0 ),   --  : helprc04 (Integer)
           300 => ( Parameter_Integer, 0 ),   --  : helprc05 (Integer)
           301 => ( Parameter_Integer, 0 ),   --  : helprc06 (Integer)
           302 => ( Parameter_Integer, 0 ),   --  : helprc07 (Integer)
           303 => ( Parameter_Integer, 0 ),   --  : helprc08 (Integer)
           304 => ( Parameter_Integer, 0 ),   --  : helprc09 (Integer)
           305 => ( Parameter_Integer, 0 ),   --  : helprc10 (Integer)
           306 => ( Parameter_Integer, 0 ),   --  : helprc11 (Integer)
           307 => ( Parameter_Integer, 0 ),   --  : holnt9 (Integer)
           308 => ( Parameter_Integer, 0 ),   --  : homent9 (Integer)
           309 => ( Parameter_Integer, 0 ),   --  : loangvn1 (Integer)
           310 => ( Parameter_Integer, 0 ),   --  : loangvn2 (Integer)
           311 => ( Parameter_Integer, 0 ),   --  : loangvn3 (Integer)
           312 => ( Parameter_Integer, 0 ),   --  : loanrec1 (Integer)
           313 => ( Parameter_Integer, 0 ),   --  : loanrec2 (Integer)
           314 => ( Parameter_Integer, 0 ),   --  : loanrec3 (Integer)
           315 => ( Parameter_Integer, 0 ),   --  : mealnt9 (Integer)
           316 => ( Parameter_Integer, 0 ),   --  : outnt9 (Integer)
           317 => ( Parameter_Integer, 0 ),   --  : phonnt9 (Integer)
           318 => ( Parameter_Integer, 0 ),   --  : taxint9 (Integer)
           319 => ( Parameter_Integer, 0 ),   --  : warmnt9 (Integer)
           320 => ( Parameter_Integer, 0 ),   --  : ecostabu (Integer)
           321 => ( Parameter_Integer, 0 ),   --  : famtypb2 (Integer)
           322 => ( Parameter_Integer, 0 ),   --  : gross3_x (Integer)
           323 => ( Parameter_Integer, 0 ),   --  : newfamb2 (Integer)
           324 => ( Parameter_Integer, 0 ),   --  : oabilimp (Integer)
           325 => ( Parameter_Integer, 0 ),   --  : oacoaimp (Integer)
           326 => ( Parameter_Integer, 0 ),   --  : oacooimp (Integer)
           327 => ( Parameter_Integer, 0 ),   --  : oadamimp (Integer)
           328 => ( Parameter_Integer, 0 ),   --  : oaexpimp (Integer)
           329 => ( Parameter_Integer, 0 ),   --  : oafrnimp (Integer)
           330 => ( Parameter_Integer, 0 ),   --  : oahaiimp (Integer)
           331 => ( Parameter_Integer, 0 ),   --  : oaheaimp (Integer)
           332 => ( Parameter_Integer, 0 ),   --  : oaholimp (Integer)
           333 => ( Parameter_Integer, 0 ),   --  : oahomimp (Integer)
           334 => ( Parameter_Integer, 0 ),   --  : oameaimp (Integer)
           335 => ( Parameter_Integer, 0 ),   --  : oaoutimp (Integer)
           336 => ( Parameter_Integer, 0 ),   --  : oaphoimp (Integer)
           337 => ( Parameter_Integer, 0 ),   --  : oataximp (Integer)
           338 => ( Parameter_Integer, 0 ),   --  : oawarimp (Integer)
           339 => ( Parameter_Float, 0.0 ),   --  : totcapb3 (Amount)
           340 => ( Parameter_Integer, 0 ),   --  : adbtbl (Integer)
           341 => ( Parameter_Integer, 0 ),   --  : cdepact (Integer)
           342 => ( Parameter_Integer, 0 ),   --  : cdepveg (Integer)
           343 => ( Parameter_Integer, 0 ),   --  : cdpcoat (Integer)
           344 => ( Parameter_Integer, 0 ),   --  : oapre (Integer)
           345 => ( Parameter_Integer, 0 ),   --  : buethgr3 (Integer)
           346 => ( Parameter_Float, 0.0 ),   --  : fsbbu (Amount)
           347 => ( Parameter_Integer, 0 ),   --  : addholr (Integer)
           348 => ( Parameter_Integer, 0 ),   --  : computer (Integer)
           349 => ( Parameter_Integer, 0 ),   --  : compuwhy (Integer)
           350 => ( Parameter_Integer, 0 ),   --  : crime (Integer)
           351 => ( Parameter_Integer, 0 ),   --  : damp (Integer)
           352 => ( Parameter_Integer, 0 ),   --  : dark (Integer)
           353 => ( Parameter_Integer, 0 ),   --  : debt01 (Integer)
           354 => ( Parameter_Integer, 0 ),   --  : debt02 (Integer)
           355 => ( Parameter_Integer, 0 ),   --  : debt03 (Integer)
           356 => ( Parameter_Integer, 0 ),   --  : debt04 (Integer)
           357 => ( Parameter_Integer, 0 ),   --  : debt05 (Integer)
           358 => ( Parameter_Integer, 0 ),   --  : debt06 (Integer)
           359 => ( Parameter_Integer, 0 ),   --  : debt07 (Integer)
           360 => ( Parameter_Integer, 0 ),   --  : debt08 (Integer)
           361 => ( Parameter_Integer, 0 ),   --  : debt09 (Integer)
           362 => ( Parameter_Integer, 0 ),   --  : debt10 (Integer)
           363 => ( Parameter_Integer, 0 ),   --  : debt11 (Integer)
           364 => ( Parameter_Integer, 0 ),   --  : debt12 (Integer)
           365 => ( Parameter_Integer, 0 ),   --  : debtar01 (Integer)
           366 => ( Parameter_Integer, 0 ),   --  : debtar02 (Integer)
           367 => ( Parameter_Integer, 0 ),   --  : debtar03 (Integer)
           368 => ( Parameter_Integer, 0 ),   --  : debtar04 (Integer)
           369 => ( Parameter_Integer, 0 ),   --  : debtar05 (Integer)
           370 => ( Parameter_Integer, 0 ),   --  : debtar06 (Integer)
           371 => ( Parameter_Integer, 0 ),   --  : debtar07 (Integer)
           372 => ( Parameter_Integer, 0 ),   --  : debtar08 (Integer)
           373 => ( Parameter_Integer, 0 ),   --  : debtar09 (Integer)
           374 => ( Parameter_Integer, 0 ),   --  : debtar10 (Integer)
           375 => ( Parameter_Integer, 0 ),   --  : debtar11 (Integer)
           376 => ( Parameter_Integer, 0 ),   --  : debtar12 (Integer)
           377 => ( Parameter_Integer, 0 ),   --  : debtfre1 (Integer)
           378 => ( Parameter_Integer, 0 ),   --  : debtfre2 (Integer)
           379 => ( Parameter_Integer, 0 ),   --  : debtfre3 (Integer)
           380 => ( Parameter_Integer, 0 ),   --  : endsmeet (Integer)
           381 => ( Parameter_Integer, 0 ),   --  : eucar (Integer)
           382 => ( Parameter_Integer, 0 ),   --  : eucarwhy (Integer)
           383 => ( Parameter_Integer, 0 ),   --  : euexpns (Integer)
           384 => ( Parameter_Integer, 0 ),   --  : eumeal (Integer)
           385 => ( Parameter_Integer, 0 ),   --  : eurepay (Integer)
           386 => ( Parameter_Integer, 0 ),   --  : euteleph (Integer)
           387 => ( Parameter_Integer, 0 ),   --  : eutelwhy (Integer)
           388 => ( Parameter_Integer, 0 ),   --  : expnsoa (Integer)
           389 => ( Parameter_Integer, 0 ),   --  : houshew (Integer)
           390 => ( Parameter_Integer, 0 ),   --  : noise (Integer)
           391 => ( Parameter_Integer, 0 ),   --  : oacareu1 (Integer)
           392 => ( Parameter_Integer, 0 ),   --  : oacareu2 (Integer)
           393 => ( Parameter_Integer, 0 ),   --  : oacareu3 (Integer)
           394 => ( Parameter_Integer, 0 ),   --  : oacareu4 (Integer)
           395 => ( Parameter_Integer, 0 ),   --  : oacareu5 (Integer)
           396 => ( Parameter_Integer, 0 ),   --  : oacareu6 (Integer)
           397 => ( Parameter_Integer, 0 ),   --  : oacareu7 (Integer)
           398 => ( Parameter_Integer, 0 ),   --  : oacareu8 (Integer)
           399 => ( Parameter_Integer, 0 ),   --  : oataxieu (Integer)
           400 => ( Parameter_Integer, 0 ),   --  : oatelep1 (Integer)
           401 => ( Parameter_Integer, 0 ),   --  : oatelep2 (Integer)
           402 => ( Parameter_Integer, 0 ),   --  : oatelep3 (Integer)
           403 => ( Parameter_Integer, 0 ),   --  : oatelep4 (Integer)
           404 => ( Parameter_Integer, 0 ),   --  : oatelep5 (Integer)
           405 => ( Parameter_Integer, 0 ),   --  : oatelep6 (Integer)
           406 => ( Parameter_Integer, 0 ),   --  : oatelep7 (Integer)
           407 => ( Parameter_Integer, 0 ),   --  : oatelep8 (Integer)
           408 => ( Parameter_Integer, 0 ),   --  : oateleph (Integer)
           409 => ( Parameter_Integer, 0 ),   --  : outpay (Integer)
           410 => ( Parameter_Float, 0.0 ),   --  : outpyamt (Amount)
           411 => ( Parameter_Integer, 0 ),   --  : pollute (Integer)
           412 => ( Parameter_Float, 0.0 ),   --  : regpamt (Amount)
           413 => ( Parameter_Integer, 0 ),   --  : regularp (Integer)
           414 => ( Parameter_Integer, 0 ),   --  : repaybur (Integer)
           415 => ( Parameter_Integer, 0 ),   --  : washmach (Integer)
           416 => ( Parameter_Integer, 0 ),   --  : washwhy (Integer)
           417 => ( Parameter_Integer, 0 ),   --  : whodepq (Integer)
           418 => ( Parameter_Integer, 0 ),   --  : discbua1 (Integer)
           419 => ( Parameter_Integer, 0 ),   --  : discbuc1 (Integer)
           420 => ( Parameter_Integer, 0 ),   --  : diswbua1 (Integer)
           421 => ( Parameter_Integer, 0 ),   --  : diswbuc1 (Integer)
           422 => ( Parameter_Float, 0.0 ),   --  : fsfvbu (Amount)
           423 => ( Parameter_Integer, 0 ),   --  : gross4 (Integer)
           424 => ( Parameter_Integer, 0 ),   --  : adles (Integer)
           425 => ( Parameter_Integer, 0 ),   --  : adlesnt1 (Integer)
           426 => ( Parameter_Integer, 0 ),   --  : adlesnt2 (Integer)
           427 => ( Parameter_Integer, 0 ),   --  : adlesnt3 (Integer)
           428 => ( Parameter_Integer, 0 ),   --  : adlesnt4 (Integer)
           429 => ( Parameter_Integer, 0 ),   --  : adlesnt5 (Integer)
           430 => ( Parameter_Integer, 0 ),   --  : adlesnt6 (Integer)
           431 => ( Parameter_Integer, 0 ),   --  : adlesnt7 (Integer)
           432 => ( Parameter_Integer, 0 ),   --  : adlesnt8 (Integer)
           433 => ( Parameter_Integer, 0 ),   --  : adlesoa (Integer)
           434 => ( Parameter_Integer, 0 ),   --  : clothes (Integer)
           435 => ( Parameter_Integer, 0 ),   --  : clothnt1 (Integer)
           436 => ( Parameter_Integer, 0 ),   --  : clothnt2 (Integer)
           437 => ( Parameter_Integer, 0 ),   --  : clothnt3 (Integer)
           438 => ( Parameter_Integer, 0 ),   --  : clothnt4 (Integer)
           439 => ( Parameter_Integer, 0 ),   --  : clothnt5 (Integer)
           440 => ( Parameter_Integer, 0 ),   --  : clothnt6 (Integer)
           441 => ( Parameter_Integer, 0 ),   --  : clothnt7 (Integer)
           442 => ( Parameter_Integer, 0 ),   --  : clothnt8 (Integer)
           443 => ( Parameter_Integer, 0 ),   --  : clothsoa (Integer)
           444 => ( Parameter_Integer, 0 ),   --  : furnt1 (Integer)
           445 => ( Parameter_Integer, 0 ),   --  : furnt2 (Integer)
           446 => ( Parameter_Integer, 0 ),   --  : furnt3 (Integer)
           447 => ( Parameter_Integer, 0 ),   --  : furnt4 (Integer)
           448 => ( Parameter_Integer, 0 ),   --  : furnt5 (Integer)
           449 => ( Parameter_Integer, 0 ),   --  : furnt6 (Integer)
           450 => ( Parameter_Integer, 0 ),   --  : furnt7 (Integer)
           451 => ( Parameter_Integer, 0 ),   --  : furnt8 (Integer)
           452 => ( Parameter_Integer, 0 ),   --  : intntnt1 (Integer)
           453 => ( Parameter_Integer, 0 ),   --  : intntnt2 (Integer)
           454 => ( Parameter_Integer, 0 ),   --  : intntnt3 (Integer)
           455 => ( Parameter_Integer, 0 ),   --  : intntnt4 (Integer)
           456 => ( Parameter_Integer, 0 ),   --  : intntnt5 (Integer)
           457 => ( Parameter_Integer, 0 ),   --  : intntnt6 (Integer)
           458 => ( Parameter_Integer, 0 ),   --  : intntnt7 (Integer)
           459 => ( Parameter_Integer, 0 ),   --  : intntnt8 (Integer)
           460 => ( Parameter_Integer, 0 ),   --  : intrnet (Integer)
           461 => ( Parameter_Integer, 0 ),   --  : meal (Integer)
           462 => ( Parameter_Integer, 0 ),   --  : oadep2 (Integer)
           463 => ( Parameter_Integer, 0 ),   --  : oadp2nt1 (Integer)
           464 => ( Parameter_Integer, 0 ),   --  : oadp2nt2 (Integer)
           465 => ( Parameter_Integer, 0 ),   --  : oadp2nt3 (Integer)
           466 => ( Parameter_Integer, 0 ),   --  : oadp2nt4 (Integer)
           467 => ( Parameter_Integer, 0 ),   --  : oadp2nt5 (Integer)
           468 => ( Parameter_Integer, 0 ),   --  : oadp2nt6 (Integer)
           469 => ( Parameter_Integer, 0 ),   --  : oadp2nt7 (Integer)
           470 => ( Parameter_Integer, 0 ),   --  : oadp2nt8 (Integer)
           471 => ( Parameter_Integer, 0 ),   --  : oafur (Integer)
           472 => ( Parameter_Integer, 0 ),   --  : oaintern (Integer)
           473 => ( Parameter_Integer, 0 ),   --  : shoe (Integer)
           474 => ( Parameter_Integer, 0 ),   --  : shoent1 (Integer)
           475 => ( Parameter_Integer, 0 ),   --  : shoent2 (Integer)
           476 => ( Parameter_Integer, 0 ),   --  : shoent3 (Integer)
           477 => ( Parameter_Integer, 0 ),   --  : shoent4 (Integer)
           478 => ( Parameter_Integer, 0 ),   --  : shoent5 (Integer)
           479 => ( Parameter_Integer, 0 ),   --  : shoent6 (Integer)
           480 => ( Parameter_Integer, 0 ),   --  : shoent7 (Integer)
           481 => ( Parameter_Integer, 0 ),   --  : shoent8 (Integer)
           482 => ( Parameter_Integer, 0 ),   --  : shoeoa (Integer)
           483 => ( Parameter_Integer, 0 ),   --  : nbunirbn (Integer)
           484 => ( Parameter_Integer, 0 ),   --  : nbuothbn (Integer)
           485 => ( Parameter_Integer, 0 ),   --  : debt13 (Integer)
           486 => ( Parameter_Integer, 0 ),   --  : debtar13 (Integer)
           487 => ( Parameter_Integer, 0 ),   --  : euchbook (Integer)
           488 => ( Parameter_Integer, 0 ),   --  : euchclth (Integer)
           489 => ( Parameter_Integer, 0 ),   --  : euchgame (Integer)
           490 => ( Parameter_Integer, 0 ),   --  : euchmeat (Integer)
           491 => ( Parameter_Integer, 0 ),   --  : euchshoe (Integer)
           492 => ( Parameter_Integer, 0 ),   --  : eupbtran (Integer)
           493 => ( Parameter_Integer, 0 ),   --  : eupbtrn1 (Integer)
           494 => ( Parameter_Integer, 0 ),   --  : eupbtrn2 (Integer)
           495 => ( Parameter_Integer, 0 ),   --  : eupbtrn3 (Integer)
           496 => ( Parameter_Integer, 0 ),   --  : eupbtrn4 (Integer)
           497 => ( Parameter_Integer, 0 ),   --  : eupbtrn5 (Integer)
           498 => ( Parameter_Integer, 0 ),   --  : euroast (Integer)
           499 => ( Parameter_Integer, 0 ),   --  : eusmeal (Integer)
           500 => ( Parameter_Integer, 0 ),   --  : eustudy (Integer)
           501 => ( Parameter_Integer, 0 ),   --  : bueth (Integer)
           502 => ( Parameter_Integer, 0 ),   --  : oaeusmea (Integer)
           503 => ( Parameter_Integer, 0 ),   --  : oaholb (Integer)
           504 => ( Parameter_Integer, 0 ),   --  : oaroast (Integer)
           505 => ( Parameter_Integer, 0 ),   --  : ecostab2 (Integer)
           506 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           507 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           508 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           509 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           510 => ( Parameter_Integer, 0 )   --  : benunit (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : incchnge (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : inchilow (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : kidinc (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : nhhchild (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : totsav (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : actaccb (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : adddabu (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : adultb (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : basactb (Integer)
           16 => ( Parameter_Float, 0.0 ),   --  : boarder (Amount)
           17 => ( Parameter_Float, 0.0 ),   --  : bpeninc (Amount)
           18 => ( Parameter_Float, 0.0 ),   --  : bseinc (Amount)
           19 => ( Parameter_Integer, 0 ),   --  : buagegr2 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : buagegrp (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : budisben (Integer)
           22 => ( Parameter_Float, 0.0 ),   --  : buearns (Amount)
           23 => ( Parameter_Integer, 0 ),   --  : buethgr2 (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : buethgrp (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : buinc (Integer)
           26 => ( Parameter_Float, 0.0 ),   --  : buinv (Amount)
           27 => ( Parameter_Integer, 0 ),   --  : buirben (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : bukids (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : bunirben (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : buothben (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : burent (Integer)
           32 => ( Parameter_Float, 0.0 ),   --  : burinc (Amount)
           33 => ( Parameter_Float, 0.0 ),   --  : burpinc (Amount)
           34 => ( Parameter_Float, 0.0 ),   --  : butvlic (Amount)
           35 => ( Parameter_Float, 0.0 ),   --  : butxcred (Amount)
           36 => ( Parameter_Integer, 0 ),   --  : chddabu (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : curactb (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : depchldb (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : depdeds (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : disindhb (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : ecotypbu (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : ecstatbu (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : famthbai (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : famtypbs (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : famtypbu (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : famtype (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : fsbndctb (Integer)
           48 => ( Parameter_Float, 0.0 ),   --  : fsmbu (Amount)
           49 => ( Parameter_Float, 0.0 ),   --  : fsmlkbu (Amount)
           50 => ( Parameter_Float, 0.0 ),   --  : fwmlkbu (Amount)
           51 => ( Parameter_Integer, 0 ),   --  : gebactb (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : giltctb (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : gross2 (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : gross3 (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : hbindbu (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : isactb (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : kid04 (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : kid1115 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : kid1618 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : kid510 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : kidsbu0 (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : kidsbu1 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : kidsbu10 (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : kidsbu11 (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : kidsbu12 (Integer)
           66 => ( Parameter_Integer, 0 ),   --  : kidsbu13 (Integer)
           67 => ( Parameter_Integer, 0 ),   --  : kidsbu14 (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : kidsbu15 (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : kidsbu16 (Integer)
           70 => ( Parameter_Integer, 0 ),   --  : kidsbu17 (Integer)
           71 => ( Parameter_Integer, 0 ),   --  : kidsbu18 (Integer)
           72 => ( Parameter_Integer, 0 ),   --  : kidsbu2 (Integer)
           73 => ( Parameter_Integer, 0 ),   --  : kidsbu3 (Integer)
           74 => ( Parameter_Integer, 0 ),   --  : kidsbu4 (Integer)
           75 => ( Parameter_Integer, 0 ),   --  : kidsbu5 (Integer)
           76 => ( Parameter_Integer, 0 ),   --  : kidsbu6 (Integer)
           77 => ( Parameter_Integer, 0 ),   --  : kidsbu7 (Integer)
           78 => ( Parameter_Integer, 0 ),   --  : kidsbu8 (Integer)
           79 => ( Parameter_Integer, 0 ),   --  : kidsbu9 (Integer)
           80 => ( Parameter_Integer, 0 ),   --  : lastwork (Integer)
           81 => ( Parameter_Float, 0.0 ),   --  : lodger (Amount)
           82 => ( Parameter_Integer, 0 ),   --  : nsboctb (Integer)
           83 => ( Parameter_Integer, 0 ),   --  : otbsctb (Integer)
           84 => ( Parameter_Integer, 0 ),   --  : pepsctb (Integer)
           85 => ( Parameter_Integer, 0 ),   --  : poacctb (Integer)
           86 => ( Parameter_Integer, 0 ),   --  : prboctb (Integer)
           87 => ( Parameter_Integer, 0 ),   --  : sayectb (Integer)
           88 => ( Parameter_Integer, 0 ),   --  : sclbctb (Integer)
           89 => ( Parameter_Integer, 0 ),   --  : ssctb (Integer)
           90 => ( Parameter_Integer, 0 ),   --  : stshctb (Integer)
           91 => ( Parameter_Float, 0.0 ),   --  : subltamt (Amount)
           92 => ( Parameter_Integer, 0 ),   --  : tessctb (Integer)
           93 => ( Parameter_Float, 0.0 ),   --  : totcapbu (Amount)
           94 => ( Parameter_Integer, 0 ),   --  : totsavbu (Integer)
           95 => ( Parameter_Float, 0.0 ),   --  : tuburent (Amount)
           96 => ( Parameter_Integer, 0 ),   --  : untrctb (Integer)
           97 => ( Parameter_Integer, 0 ),   --  : youngch (Integer)
           98 => ( Parameter_Integer, 0 ),   --  : adddec (Integer)
           99 => ( Parameter_Integer, 0 ),   --  : addeples (Integer)
           100 => ( Parameter_Integer, 0 ),   --  : addhol (Integer)
           101 => ( Parameter_Integer, 0 ),   --  : addins (Integer)
           102 => ( Parameter_Integer, 0 ),   --  : addmel (Integer)
           103 => ( Parameter_Integer, 0 ),   --  : addmon (Integer)
           104 => ( Parameter_Integer, 0 ),   --  : addshoe (Integer)
           105 => ( Parameter_Integer, 0 ),   --  : adepfur (Integer)
           106 => ( Parameter_Integer, 0 ),   --  : af1 (Integer)
           107 => ( Parameter_Integer, 0 ),   --  : afdep2 (Integer)
           108 => ( Parameter_Integer, 0 ),   --  : cdelply (Integer)
           109 => ( Parameter_Integer, 0 ),   --  : cdepbed (Integer)
           110 => ( Parameter_Integer, 0 ),   --  : cdepcel (Integer)
           111 => ( Parameter_Integer, 0 ),   --  : cdepeqp (Integer)
           112 => ( Parameter_Integer, 0 ),   --  : cdephol (Integer)
           113 => ( Parameter_Integer, 0 ),   --  : cdeples (Integer)
           114 => ( Parameter_Integer, 0 ),   --  : cdepsum (Integer)
           115 => ( Parameter_Integer, 0 ),   --  : cdeptea (Integer)
           116 => ( Parameter_Integer, 0 ),   --  : cdeptrp (Integer)
           117 => ( Parameter_Integer, 0 ),   --  : cplay (Integer)
           118 => ( Parameter_Integer, 0 ),   --  : debt1 (Integer)
           119 => ( Parameter_Integer, 0 ),   --  : debt2 (Integer)
           120 => ( Parameter_Integer, 0 ),   --  : debt3 (Integer)
           121 => ( Parameter_Integer, 0 ),   --  : debt4 (Integer)
           122 => ( Parameter_Integer, 0 ),   --  : debt5 (Integer)
           123 => ( Parameter_Integer, 0 ),   --  : debt6 (Integer)
           124 => ( Parameter_Integer, 0 ),   --  : debt7 (Integer)
           125 => ( Parameter_Integer, 0 ),   --  : debt8 (Integer)
           126 => ( Parameter_Integer, 0 ),   --  : debt9 (Integer)
           127 => ( Parameter_Integer, 0 ),   --  : houshe1 (Integer)
           128 => ( Parameter_Integer, 0 ),   --  : incold (Integer)
           129 => ( Parameter_Integer, 0 ),   --  : crunacb (Integer)
           130 => ( Parameter_Integer, 0 ),   --  : enomortb (Integer)
           131 => ( Parameter_Integer, 0 ),   --  : hbindbu2 (Integer)
           132 => ( Parameter_Integer, 0 ),   --  : pocardb (Integer)
           133 => ( Parameter_Integer, 0 ),   --  : kid1619 (Integer)
           134 => ( Parameter_Float, 0.0 ),   --  : totcapb2 (Amount)
           135 => ( Parameter_Integer, 0 ),   --  : billnt1 (Integer)
           136 => ( Parameter_Integer, 0 ),   --  : billnt2 (Integer)
           137 => ( Parameter_Integer, 0 ),   --  : billnt3 (Integer)
           138 => ( Parameter_Integer, 0 ),   --  : billnt4 (Integer)
           139 => ( Parameter_Integer, 0 ),   --  : billnt5 (Integer)
           140 => ( Parameter_Integer, 0 ),   --  : billnt6 (Integer)
           141 => ( Parameter_Integer, 0 ),   --  : billnt7 (Integer)
           142 => ( Parameter_Integer, 0 ),   --  : billnt8 (Integer)
           143 => ( Parameter_Integer, 0 ),   --  : coatnt1 (Integer)
           144 => ( Parameter_Integer, 0 ),   --  : coatnt2 (Integer)
           145 => ( Parameter_Integer, 0 ),   --  : coatnt3 (Integer)
           146 => ( Parameter_Integer, 0 ),   --  : coatnt4 (Integer)
           147 => ( Parameter_Integer, 0 ),   --  : coatnt5 (Integer)
           148 => ( Parameter_Integer, 0 ),   --  : coatnt6 (Integer)
           149 => ( Parameter_Integer, 0 ),   --  : coatnt7 (Integer)
           150 => ( Parameter_Integer, 0 ),   --  : coatnt8 (Integer)
           151 => ( Parameter_Integer, 0 ),   --  : cooknt1 (Integer)
           152 => ( Parameter_Integer, 0 ),   --  : cooknt2 (Integer)
           153 => ( Parameter_Integer, 0 ),   --  : cooknt3 (Integer)
           154 => ( Parameter_Integer, 0 ),   --  : cooknt4 (Integer)
           155 => ( Parameter_Integer, 0 ),   --  : cooknt5 (Integer)
           156 => ( Parameter_Integer, 0 ),   --  : cooknt6 (Integer)
           157 => ( Parameter_Integer, 0 ),   --  : cooknt7 (Integer)
           158 => ( Parameter_Integer, 0 ),   --  : cooknt8 (Integer)
           159 => ( Parameter_Integer, 0 ),   --  : dampnt1 (Integer)
           160 => ( Parameter_Integer, 0 ),   --  : dampnt2 (Integer)
           161 => ( Parameter_Integer, 0 ),   --  : dampnt3 (Integer)
           162 => ( Parameter_Integer, 0 ),   --  : dampnt4 (Integer)
           163 => ( Parameter_Integer, 0 ),   --  : dampnt5 (Integer)
           164 => ( Parameter_Integer, 0 ),   --  : dampnt6 (Integer)
           165 => ( Parameter_Integer, 0 ),   --  : dampnt7 (Integer)
           166 => ( Parameter_Integer, 0 ),   --  : dampnt8 (Integer)
           167 => ( Parameter_Integer, 0 ),   --  : frndnt1 (Integer)
           168 => ( Parameter_Integer, 0 ),   --  : frndnt2 (Integer)
           169 => ( Parameter_Integer, 0 ),   --  : frndnt3 (Integer)
           170 => ( Parameter_Integer, 0 ),   --  : frndnt4 (Integer)
           171 => ( Parameter_Integer, 0 ),   --  : frndnt5 (Integer)
           172 => ( Parameter_Integer, 0 ),   --  : frndnt6 (Integer)
           173 => ( Parameter_Integer, 0 ),   --  : frndnt7 (Integer)
           174 => ( Parameter_Integer, 0 ),   --  : frndnt8 (Integer)
           175 => ( Parameter_Integer, 0 ),   --  : hairnt1 (Integer)
           176 => ( Parameter_Integer, 0 ),   --  : hairnt2 (Integer)
           177 => ( Parameter_Integer, 0 ),   --  : hairnt3 (Integer)
           178 => ( Parameter_Integer, 0 ),   --  : hairnt4 (Integer)
           179 => ( Parameter_Integer, 0 ),   --  : hairnt5 (Integer)
           180 => ( Parameter_Integer, 0 ),   --  : hairnt6 (Integer)
           181 => ( Parameter_Integer, 0 ),   --  : hairnt7 (Integer)
           182 => ( Parameter_Integer, 0 ),   --  : hairnt8 (Integer)
           183 => ( Parameter_Integer, 0 ),   --  : heatnt1 (Integer)
           184 => ( Parameter_Integer, 0 ),   --  : heatnt2 (Integer)
           185 => ( Parameter_Integer, 0 ),   --  : heatnt3 (Integer)
           186 => ( Parameter_Integer, 0 ),   --  : heatnt4 (Integer)
           187 => ( Parameter_Integer, 0 ),   --  : heatnt5 (Integer)
           188 => ( Parameter_Integer, 0 ),   --  : heatnt6 (Integer)
           189 => ( Parameter_Integer, 0 ),   --  : heatnt7 (Integer)
           190 => ( Parameter_Integer, 0 ),   --  : heatnt8 (Integer)
           191 => ( Parameter_Integer, 0 ),   --  : holnt1 (Integer)
           192 => ( Parameter_Integer, 0 ),   --  : holnt2 (Integer)
           193 => ( Parameter_Integer, 0 ),   --  : holnt3 (Integer)
           194 => ( Parameter_Integer, 0 ),   --  : holnt4 (Integer)
           195 => ( Parameter_Integer, 0 ),   --  : holnt5 (Integer)
           196 => ( Parameter_Integer, 0 ),   --  : holnt6 (Integer)
           197 => ( Parameter_Integer, 0 ),   --  : holnt7 (Integer)
           198 => ( Parameter_Integer, 0 ),   --  : holnt8 (Integer)
           199 => ( Parameter_Integer, 0 ),   --  : homent1 (Integer)
           200 => ( Parameter_Integer, 0 ),   --  : homent2 (Integer)
           201 => ( Parameter_Integer, 0 ),   --  : homent3 (Integer)
           202 => ( Parameter_Integer, 0 ),   --  : homent4 (Integer)
           203 => ( Parameter_Integer, 0 ),   --  : homent5 (Integer)
           204 => ( Parameter_Integer, 0 ),   --  : homent6 (Integer)
           205 => ( Parameter_Integer, 0 ),   --  : homent7 (Integer)
           206 => ( Parameter_Integer, 0 ),   --  : homent8 (Integer)
           207 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           208 => ( Parameter_Integer, 0 ),   --  : mealnt1 (Integer)
           209 => ( Parameter_Integer, 0 ),   --  : mealnt2 (Integer)
           210 => ( Parameter_Integer, 0 ),   --  : mealnt3 (Integer)
           211 => ( Parameter_Integer, 0 ),   --  : mealnt4 (Integer)
           212 => ( Parameter_Integer, 0 ),   --  : mealnt5 (Integer)
           213 => ( Parameter_Integer, 0 ),   --  : mealnt6 (Integer)
           214 => ( Parameter_Integer, 0 ),   --  : mealnt7 (Integer)
           215 => ( Parameter_Integer, 0 ),   --  : mealnt8 (Integer)
           216 => ( Parameter_Integer, 0 ),   --  : oabill (Integer)
           217 => ( Parameter_Integer, 0 ),   --  : oacoat (Integer)
           218 => ( Parameter_Integer, 0 ),   --  : oacook (Integer)
           219 => ( Parameter_Integer, 0 ),   --  : oadamp (Integer)
           220 => ( Parameter_Integer, 0 ),   --  : oaexpns (Integer)
           221 => ( Parameter_Integer, 0 ),   --  : oafrnd (Integer)
           222 => ( Parameter_Integer, 0 ),   --  : oahair (Integer)
           223 => ( Parameter_Integer, 0 ),   --  : oaheat (Integer)
           224 => ( Parameter_Integer, 0 ),   --  : oahol (Integer)
           225 => ( Parameter_Integer, 0 ),   --  : oahome (Integer)
           226 => ( Parameter_Integer, 0 ),   --  : oahowpy1 (Integer)
           227 => ( Parameter_Integer, 0 ),   --  : oahowpy2 (Integer)
           228 => ( Parameter_Integer, 0 ),   --  : oahowpy3 (Integer)
           229 => ( Parameter_Integer, 0 ),   --  : oahowpy4 (Integer)
           230 => ( Parameter_Integer, 0 ),   --  : oahowpy5 (Integer)
           231 => ( Parameter_Integer, 0 ),   --  : oahowpy6 (Integer)
           232 => ( Parameter_Integer, 0 ),   --  : oameal (Integer)
           233 => ( Parameter_Integer, 0 ),   --  : oaout (Integer)
           234 => ( Parameter_Integer, 0 ),   --  : oaphon (Integer)
           235 => ( Parameter_Integer, 0 ),   --  : oataxi (Integer)
           236 => ( Parameter_Integer, 0 ),   --  : oawarm (Integer)
           237 => ( Parameter_Integer, 0 ),   --  : outnt1 (Integer)
           238 => ( Parameter_Integer, 0 ),   --  : outnt2 (Integer)
           239 => ( Parameter_Integer, 0 ),   --  : outnt3 (Integer)
           240 => ( Parameter_Integer, 0 ),   --  : outnt4 (Integer)
           241 => ( Parameter_Integer, 0 ),   --  : outnt5 (Integer)
           242 => ( Parameter_Integer, 0 ),   --  : outnt6 (Integer)
           243 => ( Parameter_Integer, 0 ),   --  : outnt7 (Integer)
           244 => ( Parameter_Integer, 0 ),   --  : outnt8 (Integer)
           245 => ( Parameter_Integer, 0 ),   --  : phonnt1 (Integer)
           246 => ( Parameter_Integer, 0 ),   --  : phonnt2 (Integer)
           247 => ( Parameter_Integer, 0 ),   --  : phonnt3 (Integer)
           248 => ( Parameter_Integer, 0 ),   --  : phonnt4 (Integer)
           249 => ( Parameter_Integer, 0 ),   --  : phonnt5 (Integer)
           250 => ( Parameter_Integer, 0 ),   --  : phonnt6 (Integer)
           251 => ( Parameter_Integer, 0 ),   --  : phonnt7 (Integer)
           252 => ( Parameter_Integer, 0 ),   --  : phonnt8 (Integer)
           253 => ( Parameter_Integer, 0 ),   --  : taxint1 (Integer)
           254 => ( Parameter_Integer, 0 ),   --  : taxint2 (Integer)
           255 => ( Parameter_Integer, 0 ),   --  : taxint3 (Integer)
           256 => ( Parameter_Integer, 0 ),   --  : taxint4 (Integer)
           257 => ( Parameter_Integer, 0 ),   --  : taxint5 (Integer)
           258 => ( Parameter_Integer, 0 ),   --  : taxint6 (Integer)
           259 => ( Parameter_Integer, 0 ),   --  : taxint7 (Integer)
           260 => ( Parameter_Integer, 0 ),   --  : taxint8 (Integer)
           261 => ( Parameter_Integer, 0 ),   --  : warmnt1 (Integer)
           262 => ( Parameter_Integer, 0 ),   --  : warmnt2 (Integer)
           263 => ( Parameter_Integer, 0 ),   --  : warmnt3 (Integer)
           264 => ( Parameter_Integer, 0 ),   --  : warmnt4 (Integer)
           265 => ( Parameter_Integer, 0 ),   --  : warmnt5 (Integer)
           266 => ( Parameter_Integer, 0 ),   --  : warmnt6 (Integer)
           267 => ( Parameter_Integer, 0 ),   --  : warmnt7 (Integer)
           268 => ( Parameter_Integer, 0 ),   --  : warmnt8 (Integer)
           269 => ( Parameter_Integer, 0 ),   --  : buagegr3 (Integer)
           270 => ( Parameter_Integer, 0 ),   --  : buagegr4 (Integer)
           271 => ( Parameter_Float, 0.0 ),   --  : heartbu (Amount)
           272 => ( Parameter_Integer, 0 ),   --  : newfambu (Integer)
           273 => ( Parameter_Integer, 0 ),   --  : billnt9 (Integer)
           274 => ( Parameter_Integer, 0 ),   --  : cbaamt1 (Integer)
           275 => ( Parameter_Integer, 0 ),   --  : cbaamt2 (Integer)
           276 => ( Parameter_Integer, 0 ),   --  : coatnt9 (Integer)
           277 => ( Parameter_Integer, 0 ),   --  : cooknt9 (Integer)
           278 => ( Parameter_Integer, 0 ),   --  : dampnt9 (Integer)
           279 => ( Parameter_Integer, 0 ),   --  : frndnt9 (Integer)
           280 => ( Parameter_Integer, 0 ),   --  : hairnt9 (Integer)
           281 => ( Parameter_Integer, 0 ),   --  : hbolng (Integer)
           282 => ( Parameter_Float, 0.0 ),   --  : hbothamt (Amount)
           283 => ( Parameter_Integer, 0 ),   --  : hbothbu (Integer)
           284 => ( Parameter_Integer, 0 ),   --  : hbothmn (Integer)
           285 => ( Parameter_Integer, 0 ),   --  : hbothpd (Integer)
           286 => ( Parameter_Integer, 0 ),   --  : hbothwk (Integer)
           287 => ( Parameter_Integer, 0 ),   --  : hbothyr (Integer)
           288 => ( Parameter_Integer, 0 ),   --  : hbotwait (Integer)
           289 => ( Parameter_Integer, 0 ),   --  : heatnt9 (Integer)
           290 => ( Parameter_Integer, 0 ),   --  : helpgv01 (Integer)
           291 => ( Parameter_Integer, 0 ),   --  : helpgv02 (Integer)
           292 => ( Parameter_Integer, 0 ),   --  : helpgv03 (Integer)
           293 => ( Parameter_Integer, 0 ),   --  : helpgv04 (Integer)
           294 => ( Parameter_Integer, 0 ),   --  : helpgv05 (Integer)
           295 => ( Parameter_Integer, 0 ),   --  : helpgv06 (Integer)
           296 => ( Parameter_Integer, 0 ),   --  : helpgv07 (Integer)
           297 => ( Parameter_Integer, 0 ),   --  : helpgv08 (Integer)
           298 => ( Parameter_Integer, 0 ),   --  : helpgv09 (Integer)
           299 => ( Parameter_Integer, 0 ),   --  : helpgv10 (Integer)
           300 => ( Parameter_Integer, 0 ),   --  : helpgv11 (Integer)
           301 => ( Parameter_Integer, 0 ),   --  : helprc01 (Integer)
           302 => ( Parameter_Integer, 0 ),   --  : helprc02 (Integer)
           303 => ( Parameter_Integer, 0 ),   --  : helprc03 (Integer)
           304 => ( Parameter_Integer, 0 ),   --  : helprc04 (Integer)
           305 => ( Parameter_Integer, 0 ),   --  : helprc05 (Integer)
           306 => ( Parameter_Integer, 0 ),   --  : helprc06 (Integer)
           307 => ( Parameter_Integer, 0 ),   --  : helprc07 (Integer)
           308 => ( Parameter_Integer, 0 ),   --  : helprc08 (Integer)
           309 => ( Parameter_Integer, 0 ),   --  : helprc09 (Integer)
           310 => ( Parameter_Integer, 0 ),   --  : helprc10 (Integer)
           311 => ( Parameter_Integer, 0 ),   --  : helprc11 (Integer)
           312 => ( Parameter_Integer, 0 ),   --  : holnt9 (Integer)
           313 => ( Parameter_Integer, 0 ),   --  : homent9 (Integer)
           314 => ( Parameter_Integer, 0 ),   --  : loangvn1 (Integer)
           315 => ( Parameter_Integer, 0 ),   --  : loangvn2 (Integer)
           316 => ( Parameter_Integer, 0 ),   --  : loangvn3 (Integer)
           317 => ( Parameter_Integer, 0 ),   --  : loanrec1 (Integer)
           318 => ( Parameter_Integer, 0 ),   --  : loanrec2 (Integer)
           319 => ( Parameter_Integer, 0 ),   --  : loanrec3 (Integer)
           320 => ( Parameter_Integer, 0 ),   --  : mealnt9 (Integer)
           321 => ( Parameter_Integer, 0 ),   --  : outnt9 (Integer)
           322 => ( Parameter_Integer, 0 ),   --  : phonnt9 (Integer)
           323 => ( Parameter_Integer, 0 ),   --  : taxint9 (Integer)
           324 => ( Parameter_Integer, 0 ),   --  : warmnt9 (Integer)
           325 => ( Parameter_Integer, 0 ),   --  : ecostabu (Integer)
           326 => ( Parameter_Integer, 0 ),   --  : famtypb2 (Integer)
           327 => ( Parameter_Integer, 0 ),   --  : gross3_x (Integer)
           328 => ( Parameter_Integer, 0 ),   --  : newfamb2 (Integer)
           329 => ( Parameter_Integer, 0 ),   --  : oabilimp (Integer)
           330 => ( Parameter_Integer, 0 ),   --  : oacoaimp (Integer)
           331 => ( Parameter_Integer, 0 ),   --  : oacooimp (Integer)
           332 => ( Parameter_Integer, 0 ),   --  : oadamimp (Integer)
           333 => ( Parameter_Integer, 0 ),   --  : oaexpimp (Integer)
           334 => ( Parameter_Integer, 0 ),   --  : oafrnimp (Integer)
           335 => ( Parameter_Integer, 0 ),   --  : oahaiimp (Integer)
           336 => ( Parameter_Integer, 0 ),   --  : oaheaimp (Integer)
           337 => ( Parameter_Integer, 0 ),   --  : oaholimp (Integer)
           338 => ( Parameter_Integer, 0 ),   --  : oahomimp (Integer)
           339 => ( Parameter_Integer, 0 ),   --  : oameaimp (Integer)
           340 => ( Parameter_Integer, 0 ),   --  : oaoutimp (Integer)
           341 => ( Parameter_Integer, 0 ),   --  : oaphoimp (Integer)
           342 => ( Parameter_Integer, 0 ),   --  : oataximp (Integer)
           343 => ( Parameter_Integer, 0 ),   --  : oawarimp (Integer)
           344 => ( Parameter_Float, 0.0 ),   --  : totcapb3 (Amount)
           345 => ( Parameter_Integer, 0 ),   --  : adbtbl (Integer)
           346 => ( Parameter_Integer, 0 ),   --  : cdepact (Integer)
           347 => ( Parameter_Integer, 0 ),   --  : cdepveg (Integer)
           348 => ( Parameter_Integer, 0 ),   --  : cdpcoat (Integer)
           349 => ( Parameter_Integer, 0 ),   --  : oapre (Integer)
           350 => ( Parameter_Integer, 0 ),   --  : buethgr3 (Integer)
           351 => ( Parameter_Float, 0.0 ),   --  : fsbbu (Amount)
           352 => ( Parameter_Integer, 0 ),   --  : addholr (Integer)
           353 => ( Parameter_Integer, 0 ),   --  : computer (Integer)
           354 => ( Parameter_Integer, 0 ),   --  : compuwhy (Integer)
           355 => ( Parameter_Integer, 0 ),   --  : crime (Integer)
           356 => ( Parameter_Integer, 0 ),   --  : damp (Integer)
           357 => ( Parameter_Integer, 0 ),   --  : dark (Integer)
           358 => ( Parameter_Integer, 0 ),   --  : debt01 (Integer)
           359 => ( Parameter_Integer, 0 ),   --  : debt02 (Integer)
           360 => ( Parameter_Integer, 0 ),   --  : debt03 (Integer)
           361 => ( Parameter_Integer, 0 ),   --  : debt04 (Integer)
           362 => ( Parameter_Integer, 0 ),   --  : debt05 (Integer)
           363 => ( Parameter_Integer, 0 ),   --  : debt06 (Integer)
           364 => ( Parameter_Integer, 0 ),   --  : debt07 (Integer)
           365 => ( Parameter_Integer, 0 ),   --  : debt08 (Integer)
           366 => ( Parameter_Integer, 0 ),   --  : debt09 (Integer)
           367 => ( Parameter_Integer, 0 ),   --  : debt10 (Integer)
           368 => ( Parameter_Integer, 0 ),   --  : debt11 (Integer)
           369 => ( Parameter_Integer, 0 ),   --  : debt12 (Integer)
           370 => ( Parameter_Integer, 0 ),   --  : debtar01 (Integer)
           371 => ( Parameter_Integer, 0 ),   --  : debtar02 (Integer)
           372 => ( Parameter_Integer, 0 ),   --  : debtar03 (Integer)
           373 => ( Parameter_Integer, 0 ),   --  : debtar04 (Integer)
           374 => ( Parameter_Integer, 0 ),   --  : debtar05 (Integer)
           375 => ( Parameter_Integer, 0 ),   --  : debtar06 (Integer)
           376 => ( Parameter_Integer, 0 ),   --  : debtar07 (Integer)
           377 => ( Parameter_Integer, 0 ),   --  : debtar08 (Integer)
           378 => ( Parameter_Integer, 0 ),   --  : debtar09 (Integer)
           379 => ( Parameter_Integer, 0 ),   --  : debtar10 (Integer)
           380 => ( Parameter_Integer, 0 ),   --  : debtar11 (Integer)
           381 => ( Parameter_Integer, 0 ),   --  : debtar12 (Integer)
           382 => ( Parameter_Integer, 0 ),   --  : debtfre1 (Integer)
           383 => ( Parameter_Integer, 0 ),   --  : debtfre2 (Integer)
           384 => ( Parameter_Integer, 0 ),   --  : debtfre3 (Integer)
           385 => ( Parameter_Integer, 0 ),   --  : endsmeet (Integer)
           386 => ( Parameter_Integer, 0 ),   --  : eucar (Integer)
           387 => ( Parameter_Integer, 0 ),   --  : eucarwhy (Integer)
           388 => ( Parameter_Integer, 0 ),   --  : euexpns (Integer)
           389 => ( Parameter_Integer, 0 ),   --  : eumeal (Integer)
           390 => ( Parameter_Integer, 0 ),   --  : eurepay (Integer)
           391 => ( Parameter_Integer, 0 ),   --  : euteleph (Integer)
           392 => ( Parameter_Integer, 0 ),   --  : eutelwhy (Integer)
           393 => ( Parameter_Integer, 0 ),   --  : expnsoa (Integer)
           394 => ( Parameter_Integer, 0 ),   --  : houshew (Integer)
           395 => ( Parameter_Integer, 0 ),   --  : noise (Integer)
           396 => ( Parameter_Integer, 0 ),   --  : oacareu1 (Integer)
           397 => ( Parameter_Integer, 0 ),   --  : oacareu2 (Integer)
           398 => ( Parameter_Integer, 0 ),   --  : oacareu3 (Integer)
           399 => ( Parameter_Integer, 0 ),   --  : oacareu4 (Integer)
           400 => ( Parameter_Integer, 0 ),   --  : oacareu5 (Integer)
           401 => ( Parameter_Integer, 0 ),   --  : oacareu6 (Integer)
           402 => ( Parameter_Integer, 0 ),   --  : oacareu7 (Integer)
           403 => ( Parameter_Integer, 0 ),   --  : oacareu8 (Integer)
           404 => ( Parameter_Integer, 0 ),   --  : oataxieu (Integer)
           405 => ( Parameter_Integer, 0 ),   --  : oatelep1 (Integer)
           406 => ( Parameter_Integer, 0 ),   --  : oatelep2 (Integer)
           407 => ( Parameter_Integer, 0 ),   --  : oatelep3 (Integer)
           408 => ( Parameter_Integer, 0 ),   --  : oatelep4 (Integer)
           409 => ( Parameter_Integer, 0 ),   --  : oatelep5 (Integer)
           410 => ( Parameter_Integer, 0 ),   --  : oatelep6 (Integer)
           411 => ( Parameter_Integer, 0 ),   --  : oatelep7 (Integer)
           412 => ( Parameter_Integer, 0 ),   --  : oatelep8 (Integer)
           413 => ( Parameter_Integer, 0 ),   --  : oateleph (Integer)
           414 => ( Parameter_Integer, 0 ),   --  : outpay (Integer)
           415 => ( Parameter_Float, 0.0 ),   --  : outpyamt (Amount)
           416 => ( Parameter_Integer, 0 ),   --  : pollute (Integer)
           417 => ( Parameter_Float, 0.0 ),   --  : regpamt (Amount)
           418 => ( Parameter_Integer, 0 ),   --  : regularp (Integer)
           419 => ( Parameter_Integer, 0 ),   --  : repaybur (Integer)
           420 => ( Parameter_Integer, 0 ),   --  : washmach (Integer)
           421 => ( Parameter_Integer, 0 ),   --  : washwhy (Integer)
           422 => ( Parameter_Integer, 0 ),   --  : whodepq (Integer)
           423 => ( Parameter_Integer, 0 ),   --  : discbua1 (Integer)
           424 => ( Parameter_Integer, 0 ),   --  : discbuc1 (Integer)
           425 => ( Parameter_Integer, 0 ),   --  : diswbua1 (Integer)
           426 => ( Parameter_Integer, 0 ),   --  : diswbuc1 (Integer)
           427 => ( Parameter_Float, 0.0 ),   --  : fsfvbu (Amount)
           428 => ( Parameter_Integer, 0 ),   --  : gross4 (Integer)
           429 => ( Parameter_Integer, 0 ),   --  : adles (Integer)
           430 => ( Parameter_Integer, 0 ),   --  : adlesnt1 (Integer)
           431 => ( Parameter_Integer, 0 ),   --  : adlesnt2 (Integer)
           432 => ( Parameter_Integer, 0 ),   --  : adlesnt3 (Integer)
           433 => ( Parameter_Integer, 0 ),   --  : adlesnt4 (Integer)
           434 => ( Parameter_Integer, 0 ),   --  : adlesnt5 (Integer)
           435 => ( Parameter_Integer, 0 ),   --  : adlesnt6 (Integer)
           436 => ( Parameter_Integer, 0 ),   --  : adlesnt7 (Integer)
           437 => ( Parameter_Integer, 0 ),   --  : adlesnt8 (Integer)
           438 => ( Parameter_Integer, 0 ),   --  : adlesoa (Integer)
           439 => ( Parameter_Integer, 0 ),   --  : clothes (Integer)
           440 => ( Parameter_Integer, 0 ),   --  : clothnt1 (Integer)
           441 => ( Parameter_Integer, 0 ),   --  : clothnt2 (Integer)
           442 => ( Parameter_Integer, 0 ),   --  : clothnt3 (Integer)
           443 => ( Parameter_Integer, 0 ),   --  : clothnt4 (Integer)
           444 => ( Parameter_Integer, 0 ),   --  : clothnt5 (Integer)
           445 => ( Parameter_Integer, 0 ),   --  : clothnt6 (Integer)
           446 => ( Parameter_Integer, 0 ),   --  : clothnt7 (Integer)
           447 => ( Parameter_Integer, 0 ),   --  : clothnt8 (Integer)
           448 => ( Parameter_Integer, 0 ),   --  : clothsoa (Integer)
           449 => ( Parameter_Integer, 0 ),   --  : furnt1 (Integer)
           450 => ( Parameter_Integer, 0 ),   --  : furnt2 (Integer)
           451 => ( Parameter_Integer, 0 ),   --  : furnt3 (Integer)
           452 => ( Parameter_Integer, 0 ),   --  : furnt4 (Integer)
           453 => ( Parameter_Integer, 0 ),   --  : furnt5 (Integer)
           454 => ( Parameter_Integer, 0 ),   --  : furnt6 (Integer)
           455 => ( Parameter_Integer, 0 ),   --  : furnt7 (Integer)
           456 => ( Parameter_Integer, 0 ),   --  : furnt8 (Integer)
           457 => ( Parameter_Integer, 0 ),   --  : intntnt1 (Integer)
           458 => ( Parameter_Integer, 0 ),   --  : intntnt2 (Integer)
           459 => ( Parameter_Integer, 0 ),   --  : intntnt3 (Integer)
           460 => ( Parameter_Integer, 0 ),   --  : intntnt4 (Integer)
           461 => ( Parameter_Integer, 0 ),   --  : intntnt5 (Integer)
           462 => ( Parameter_Integer, 0 ),   --  : intntnt6 (Integer)
           463 => ( Parameter_Integer, 0 ),   --  : intntnt7 (Integer)
           464 => ( Parameter_Integer, 0 ),   --  : intntnt8 (Integer)
           465 => ( Parameter_Integer, 0 ),   --  : intrnet (Integer)
           466 => ( Parameter_Integer, 0 ),   --  : meal (Integer)
           467 => ( Parameter_Integer, 0 ),   --  : oadep2 (Integer)
           468 => ( Parameter_Integer, 0 ),   --  : oadp2nt1 (Integer)
           469 => ( Parameter_Integer, 0 ),   --  : oadp2nt2 (Integer)
           470 => ( Parameter_Integer, 0 ),   --  : oadp2nt3 (Integer)
           471 => ( Parameter_Integer, 0 ),   --  : oadp2nt4 (Integer)
           472 => ( Parameter_Integer, 0 ),   --  : oadp2nt5 (Integer)
           473 => ( Parameter_Integer, 0 ),   --  : oadp2nt6 (Integer)
           474 => ( Parameter_Integer, 0 ),   --  : oadp2nt7 (Integer)
           475 => ( Parameter_Integer, 0 ),   --  : oadp2nt8 (Integer)
           476 => ( Parameter_Integer, 0 ),   --  : oafur (Integer)
           477 => ( Parameter_Integer, 0 ),   --  : oaintern (Integer)
           478 => ( Parameter_Integer, 0 ),   --  : shoe (Integer)
           479 => ( Parameter_Integer, 0 ),   --  : shoent1 (Integer)
           480 => ( Parameter_Integer, 0 ),   --  : shoent2 (Integer)
           481 => ( Parameter_Integer, 0 ),   --  : shoent3 (Integer)
           482 => ( Parameter_Integer, 0 ),   --  : shoent4 (Integer)
           483 => ( Parameter_Integer, 0 ),   --  : shoent5 (Integer)
           484 => ( Parameter_Integer, 0 ),   --  : shoent6 (Integer)
           485 => ( Parameter_Integer, 0 ),   --  : shoent7 (Integer)
           486 => ( Parameter_Integer, 0 ),   --  : shoent8 (Integer)
           487 => ( Parameter_Integer, 0 ),   --  : shoeoa (Integer)
           488 => ( Parameter_Integer, 0 ),   --  : nbunirbn (Integer)
           489 => ( Parameter_Integer, 0 ),   --  : nbuothbn (Integer)
           490 => ( Parameter_Integer, 0 ),   --  : debt13 (Integer)
           491 => ( Parameter_Integer, 0 ),   --  : debtar13 (Integer)
           492 => ( Parameter_Integer, 0 ),   --  : euchbook (Integer)
           493 => ( Parameter_Integer, 0 ),   --  : euchclth (Integer)
           494 => ( Parameter_Integer, 0 ),   --  : euchgame (Integer)
           495 => ( Parameter_Integer, 0 ),   --  : euchmeat (Integer)
           496 => ( Parameter_Integer, 0 ),   --  : euchshoe (Integer)
           497 => ( Parameter_Integer, 0 ),   --  : eupbtran (Integer)
           498 => ( Parameter_Integer, 0 ),   --  : eupbtrn1 (Integer)
           499 => ( Parameter_Integer, 0 ),   --  : eupbtrn2 (Integer)
           500 => ( Parameter_Integer, 0 ),   --  : eupbtrn3 (Integer)
           501 => ( Parameter_Integer, 0 ),   --  : eupbtrn4 (Integer)
           502 => ( Parameter_Integer, 0 ),   --  : eupbtrn5 (Integer)
           503 => ( Parameter_Integer, 0 ),   --  : euroast (Integer)
           504 => ( Parameter_Integer, 0 ),   --  : eusmeal (Integer)
           505 => ( Parameter_Integer, 0 ),   --  : eustudy (Integer)
           506 => ( Parameter_Integer, 0 ),   --  : bueth (Integer)
           507 => ( Parameter_Integer, 0 ),   --  : oaeusmea (Integer)
           508 => ( Parameter_Integer, 0 ),   --  : oaholb (Integer)
           509 => ( Parameter_Integer, 0 ),   --  : oaroast (Integer)
           510 => ( Parameter_Integer, 0 )   --  : ecostab2 (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $100, $101, $102, $103, $104, $105, $106, $107, $108, $109, $110, $111, $112, $113, $114, $115, $116, $117, $118, $119, $120, $121, $122, $123, $124, $125, $126, $127, $128, $129, $130, $131, $132, $133, $134, $135, $136, $137, $138, $139, $140, $141, $142, $143, $144, $145, $146, $147, $148, $149, $150, $151, $152, $153, $154, $155, $156, $157, $158, $159, $160, $161, $162, $163, $164, $165, $166, $167, $168, $169, $170, $171, $172, $173, $174, $175, $176, $177, $178, $179, $180, $181, $182, $183, $184, $185, $186, $187, $188, $189, $190, $191, $192, $193, $194, $195, $196, $197, $198, $199, $200, $201, $202, $203, $204, $205, $206, $207, $208, $209, $210, $211, $212, $213, $214, $215, $216, $217, $218, $219, $220, $221, $222, $223, $224, $225, $226, $227, $228, $229, $230, $231, $232, $233, $234, $235, $236, $237, $238, $239, $240, $241, $242, $243, $244, $245, $246, $247, $248, $249, $250, $251, $252, $253, $254, $255, $256, $257, $258, $259, $260, $261, $262, $263, $264, $265, $266, $267, $268, $269, $270, $271, $272, $273, $274, $275, $276, $277, $278, $279, $280, $281, $282, $283, $284, $285, $286, $287, $288, $289, $290, $291, $292, $293, $294, $295, $296, $297, $298, $299, $300, $301, $302, $303, $304, $305, $306, $307, $308, $309, $310, $311, $312, $313, $314, $315, $316, $317, $318, $319, $320, $321, $322, $323, $324, $325, $326, $327, $328, $329, $330, $331, $332, $333, $334, $335, $336, $337, $338, $339, $340, $341, $342, $343, $344, $345, $346, $347, $348, $349, $350, $351, $352, $353, $354, $355, $356, $357, $358, $359, $360, $361, $362, $363, $364, $365, $366, $367, $368, $369, $370, $371, $372, $373, $374, $375, $376, $377, $378, $379, $380, $381, $382, $383, $384, $385, $386, $387, $388, $389, $390, $391, $392, $393, $394, $395, $396, $397, $398, $399, $400, $401, $402, $403, $404, $405, $406, $407, $408, $409, $410, $411, $412, $413, $414, $415, $416, $417, $418, $419, $420, $421, $422, $423, $424, $425, $426, $427, $428, $429, $430, $431, $432, $433, $434, $435, $436, $437, $438, $439, $440, $441, $442, $443, $444, $445, $446, $447, $448, $449, $450, $451, $452, $453, $454, $455, $456, $457, $458, $459, $460, $461, $462, $463, $464, $465, $466, $467, $468, $469, $470, $471, $472, $473, $474, $475, $476, $477, $478, $479, $480, $481, $482, $483, $484, $485, $486, $487, $488, $489, $490, $491, $492, $493, $494, $495, $496, $497, $498, $499, $500, $501, $502, $503, $504, $505, $506, $507, $508, $509, $510 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 5 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 )   --  : benunit (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " incchnge = $1, inchilow = $2, kidinc = $3, nhhchild = $4, totsav = $5, month = $6, actaccb = $7, adddabu = $8, adultb = $9, basactb = $10, boarder = $11, bpeninc = $12, bseinc = $13, buagegr2 = $14, buagegrp = $15, budisben = $16, buearns = $17, buethgr2 = $18, buethgrp = $19, buinc = $20, buinv = $21, buirben = $22, bukids = $23, bunirben = $24, buothben = $25, burent = $26, burinc = $27, burpinc = $28, butvlic = $29, butxcred = $30, chddabu = $31, curactb = $32, depchldb = $33, depdeds = $34, disindhb = $35, ecotypbu = $36, ecstatbu = $37, famthbai = $38, famtypbs = $39, famtypbu = $40, famtype = $41, fsbndctb = $42, fsmbu = $43, fsmlkbu = $44, fwmlkbu = $45, gebactb = $46, giltctb = $47, gross2 = $48, gross3 = $49, hbindbu = $50, isactb = $51, kid04 = $52, kid1115 = $53, kid1618 = $54, kid510 = $55, kidsbu0 = $56, kidsbu1 = $57, kidsbu10 = $58, kidsbu11 = $59, kidsbu12 = $60, kidsbu13 = $61, kidsbu14 = $62, kidsbu15 = $63, kidsbu16 = $64, kidsbu17 = $65, kidsbu18 = $66, kidsbu2 = $67, kidsbu3 = $68, kidsbu4 = $69, kidsbu5 = $70, kidsbu6 = $71, kidsbu7 = $72, kidsbu8 = $73, kidsbu9 = $74, lastwork = $75, lodger = $76, nsboctb = $77, otbsctb = $78, pepsctb = $79, poacctb = $80, prboctb = $81, sayectb = $82, sclbctb = $83, ssctb = $84, stshctb = $85, subltamt = $86, tessctb = $87, totcapbu = $88, totsavbu = $89, tuburent = $90, untrctb = $91, youngch = $92, adddec = $93, addeples = $94, addhol = $95, addins = $96, addmel = $97, addmon = $98, addshoe = $99, adepfur = $100, af1 = $101, afdep2 = $102, cdelply = $103, cdepbed = $104, cdepcel = $105, cdepeqp = $106, cdephol = $107, cdeples = $108, cdepsum = $109, cdeptea = $110, cdeptrp = $111, cplay = $112, debt1 = $113, debt2 = $114, debt3 = $115, debt4 = $116, debt5 = $117, debt6 = $118, debt7 = $119, debt8 = $120, debt9 = $121, houshe1 = $122, incold = $123, crunacb = $124, enomortb = $125, hbindbu2 = $126, pocardb = $127, kid1619 = $128, totcapb2 = $129, billnt1 = $130, billnt2 = $131, billnt3 = $132, billnt4 = $133, billnt5 = $134, billnt6 = $135, billnt7 = $136, billnt8 = $137, coatnt1 = $138, coatnt2 = $139, coatnt3 = $140, coatnt4 = $141, coatnt5 = $142, coatnt6 = $143, coatnt7 = $144, coatnt8 = $145, cooknt1 = $146, cooknt2 = $147, cooknt3 = $148, cooknt4 = $149, cooknt5 = $150, cooknt6 = $151, cooknt7 = $152, cooknt8 = $153, dampnt1 = $154, dampnt2 = $155, dampnt3 = $156, dampnt4 = $157, dampnt5 = $158, dampnt6 = $159, dampnt7 = $160, dampnt8 = $161, frndnt1 = $162, frndnt2 = $163, frndnt3 = $164, frndnt4 = $165, frndnt5 = $166, frndnt6 = $167, frndnt7 = $168, frndnt8 = $169, hairnt1 = $170, hairnt2 = $171, hairnt3 = $172, hairnt4 = $173, hairnt5 = $174, hairnt6 = $175, hairnt7 = $176, hairnt8 = $177, heatnt1 = $178, heatnt2 = $179, heatnt3 = $180, heatnt4 = $181, heatnt5 = $182, heatnt6 = $183, heatnt7 = $184, heatnt8 = $185, holnt1 = $186, holnt2 = $187, holnt3 = $188, holnt4 = $189, holnt5 = $190, holnt6 = $191, holnt7 = $192, holnt8 = $193, homent1 = $194, homent2 = $195, homent3 = $196, homent4 = $197, homent5 = $198, homent6 = $199, homent7 = $200, homent8 = $201, issue = $202, mealnt1 = $203, mealnt2 = $204, mealnt3 = $205, mealnt4 = $206, mealnt5 = $207, mealnt6 = $208, mealnt7 = $209, mealnt8 = $210, oabill = $211, oacoat = $212, oacook = $213, oadamp = $214, oaexpns = $215, oafrnd = $216, oahair = $217, oaheat = $218, oahol = $219, oahome = $220, oahowpy1 = $221, oahowpy2 = $222, oahowpy3 = $223, oahowpy4 = $224, oahowpy5 = $225, oahowpy6 = $226, oameal = $227, oaout = $228, oaphon = $229, oataxi = $230, oawarm = $231, outnt1 = $232, outnt2 = $233, outnt3 = $234, outnt4 = $235, outnt5 = $236, outnt6 = $237, outnt7 = $238, outnt8 = $239, phonnt1 = $240, phonnt2 = $241, phonnt3 = $242, phonnt4 = $243, phonnt5 = $244, phonnt6 = $245, phonnt7 = $246, phonnt8 = $247, taxint1 = $248, taxint2 = $249, taxint3 = $250, taxint4 = $251, taxint5 = $252, taxint6 = $253, taxint7 = $254, taxint8 = $255, warmnt1 = $256, warmnt2 = $257, warmnt3 = $258, warmnt4 = $259, warmnt5 = $260, warmnt6 = $261, warmnt7 = $262, warmnt8 = $263, buagegr3 = $264, buagegr4 = $265, heartbu = $266, newfambu = $267, billnt9 = $268, cbaamt1 = $269, cbaamt2 = $270, coatnt9 = $271, cooknt9 = $272, dampnt9 = $273, frndnt9 = $274, hairnt9 = $275, hbolng = $276, hbothamt = $277, hbothbu = $278, hbothmn = $279, hbothpd = $280, hbothwk = $281, hbothyr = $282, hbotwait = $283, heatnt9 = $284, helpgv01 = $285, helpgv02 = $286, helpgv03 = $287, helpgv04 = $288, helpgv05 = $289, helpgv06 = $290, helpgv07 = $291, helpgv08 = $292, helpgv09 = $293, helpgv10 = $294, helpgv11 = $295, helprc01 = $296, helprc02 = $297, helprc03 = $298, helprc04 = $299, helprc05 = $300, helprc06 = $301, helprc07 = $302, helprc08 = $303, helprc09 = $304, helprc10 = $305, helprc11 = $306, holnt9 = $307, homent9 = $308, loangvn1 = $309, loangvn2 = $310, loangvn3 = $311, loanrec1 = $312, loanrec2 = $313, loanrec3 = $314, mealnt9 = $315, outnt9 = $316, phonnt9 = $317, taxint9 = $318, warmnt9 = $319, ecostabu = $320, famtypb2 = $321, gross3_x = $322, newfamb2 = $323, oabilimp = $324, oacoaimp = $325, oacooimp = $326, oadamimp = $327, oaexpimp = $328, oafrnimp = $329, oahaiimp = $330, oaheaimp = $331, oaholimp = $332, oahomimp = $333, oameaimp = $334, oaoutimp = $335, oaphoimp = $336, oataximp = $337, oawarimp = $338, totcapb3 = $339, adbtbl = $340, cdepact = $341, cdepveg = $342, cdpcoat = $343, oapre = $344, buethgr3 = $345, fsbbu = $346, addholr = $347, computer = $348, compuwhy = $349, crime = $350, damp = $351, dark = $352, debt01 = $353, debt02 = $354, debt03 = $355, debt04 = $356, debt05 = $357, debt06 = $358, debt07 = $359, debt08 = $360, debt09 = $361, debt10 = $362, debt11 = $363, debt12 = $364, debtar01 = $365, debtar02 = $366, debtar03 = $367, debtar04 = $368, debtar05 = $369, debtar06 = $370, debtar07 = $371, debtar08 = $372, debtar09 = $373, debtar10 = $374, debtar11 = $375, debtar12 = $376, debtfre1 = $377, debtfre2 = $378, debtfre3 = $379, endsmeet = $380, eucar = $381, eucarwhy = $382, euexpns = $383, eumeal = $384, eurepay = $385, euteleph = $386, eutelwhy = $387, expnsoa = $388, houshew = $389, noise = $390, oacareu1 = $391, oacareu2 = $392, oacareu3 = $393, oacareu4 = $394, oacareu5 = $395, oacareu6 = $396, oacareu7 = $397, oacareu8 = $398, oataxieu = $399, oatelep1 = $400, oatelep2 = $401, oatelep3 = $402, oatelep4 = $403, oatelep5 = $404, oatelep6 = $405, oatelep7 = $406, oatelep8 = $407, oateleph = $408, outpay = $409, outpyamt = $410, pollute = $411, regpamt = $412, regularp = $413, repaybur = $414, washmach = $415, washwhy = $416, whodepq = $417, discbua1 = $418, discbuc1 = $419, diswbua1 = $420, diswbuc1 = $421, fsfvbu = $422, gross4 = $423, adles = $424, adlesnt1 = $425, adlesnt2 = $426, adlesnt3 = $427, adlesnt4 = $428, adlesnt5 = $429, adlesnt6 = $430, adlesnt7 = $431, adlesnt8 = $432, adlesoa = $433, clothes = $434, clothnt1 = $435, clothnt2 = $436, clothnt3 = $437, clothnt4 = $438, clothnt5 = $439, clothnt6 = $440, clothnt7 = $441, clothnt8 = $442, clothsoa = $443, furnt1 = $444, furnt2 = $445, furnt3 = $446, furnt4 = $447, furnt5 = $448, furnt6 = $449, furnt7 = $450, furnt8 = $451, intntnt1 = $452, intntnt2 = $453, intntnt3 = $454, intntnt4 = $455, intntnt5 = $456, intntnt6 = $457, intntnt7 = $458, intntnt8 = $459, intrnet = $460, meal = $461, oadep2 = $462, oadp2nt1 = $463, oadp2nt2 = $464, oadp2nt3 = $465, oadp2nt4 = $466, oadp2nt5 = $467, oadp2nt6 = $468, oadp2nt7 = $469, oadp2nt8 = $470, oafur = $471, oaintern = $472, shoe = $473, shoent1 = $474, shoent2 = $475, shoent3 = $476, shoent4 = $477, shoent5 = $478, shoent6 = $479, shoent7 = $480, shoent8 = $481, shoeoa = $482, nbunirbn = $483, nbuothbn = $484, debt13 = $485, debtar13 = $486, euchbook = $487, euchclth = $488, euchgame = $489, euchmeat = $490, euchshoe = $491, eupbtran = $492, eupbtrn1 = $493, eupbtrn2 = $494, eupbtrn3 = $495, eupbtrn4 = $496, eupbtrn5 = $497, euroast = $498, eusmeal = $499, eustudy = $500, bueth = $501, oaeusmea = $502, oaholb = $503, oaroast = $504, ecostab2 = $505 where user_id = $506 and edition = $507 and year = $508 and sernum = $509 and benunit = $510"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.benunit", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.benunit", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.benunit", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.benunit", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.benunit", SCHEMA_NAME );
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



   --
   -- returns true if the primary key parts of Ukds.Frs.Benunit match the defaults in Ukds.Frs.Null_Benunit
   --
   --
   -- Does this Ukds.Frs.Benunit equal the default Ukds.Frs.Null_Benunit ?
   --
   function Is_Null( a_benunit : Benunit ) return Boolean is
   begin
      return a_benunit = Ukds.Frs.Null_Benunit;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Benunit matching the primary key fields, or the Ukds.Frs.Null_Benunit record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; connection : Database_Connection := null ) return Ukds.Frs.Benunit is
      l : Ukds.Frs.Benunit_List;
      a_benunit : Ukds.Frs.Benunit;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      Add_benunit( c, benunit );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Benunit_List_Package.is_empty( l ) ) then
         a_benunit := Ukds.Frs.Benunit_List_Package.First_Element( l );
      else
         a_benunit := Ukds.Frs.Null_Benunit;
      end if;
      return a_benunit;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.benunit where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; connection : Database_Connection := null ) return Boolean  is
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
      params( 5 ) := "+"( Integer'Pos( benunit ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Benunit matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Benunit_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Benunit retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Benunit is
      a_benunit : Ukds.Frs.Benunit;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_benunit.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_benunit.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_benunit.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_benunit.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_benunit.benunit := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_benunit.incchnge := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_benunit.inchilow := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_benunit.kidinc := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_benunit.nhhchild := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_benunit.totsav := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_benunit.month := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_benunit.actaccb := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_benunit.adddabu := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_benunit.adultb := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_benunit.basactb := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_benunit.boarder:= Amount'Value( gse.Value( cursor, 15 ));
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_benunit.bpeninc:= Amount'Value( gse.Value( cursor, 16 ));
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_benunit.bseinc:= Amount'Value( gse.Value( cursor, 17 ));
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_benunit.buagegr2 := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_benunit.buagegrp := gse.Integer_Value( cursor, 19 );
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_benunit.budisben := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_benunit.buearns:= Amount'Value( gse.Value( cursor, 21 ));
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_benunit.buethgr2 := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_benunit.buethgrp := gse.Integer_Value( cursor, 23 );
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_benunit.buinc := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_benunit.buinv:= Amount'Value( gse.Value( cursor, 25 ));
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_benunit.buirben := gse.Integer_Value( cursor, 26 );
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_benunit.bukids := gse.Integer_Value( cursor, 27 );
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_benunit.bunirben := gse.Integer_Value( cursor, 28 );
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_benunit.buothben := gse.Integer_Value( cursor, 29 );
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_benunit.burent := gse.Integer_Value( cursor, 30 );
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_benunit.burinc:= Amount'Value( gse.Value( cursor, 31 ));
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_benunit.burpinc:= Amount'Value( gse.Value( cursor, 32 ));
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_benunit.butvlic:= Amount'Value( gse.Value( cursor, 33 ));
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_benunit.butxcred:= Amount'Value( gse.Value( cursor, 34 ));
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_benunit.chddabu := gse.Integer_Value( cursor, 35 );
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_benunit.curactb := gse.Integer_Value( cursor, 36 );
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_benunit.depchldb := gse.Integer_Value( cursor, 37 );
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_benunit.depdeds := gse.Integer_Value( cursor, 38 );
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_benunit.disindhb := gse.Integer_Value( cursor, 39 );
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_benunit.ecotypbu := gse.Integer_Value( cursor, 40 );
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_benunit.ecstatbu := gse.Integer_Value( cursor, 41 );
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_benunit.famthbai := gse.Integer_Value( cursor, 42 );
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_benunit.famtypbs := gse.Integer_Value( cursor, 43 );
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_benunit.famtypbu := gse.Integer_Value( cursor, 44 );
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_benunit.famtype := gse.Integer_Value( cursor, 45 );
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_benunit.fsbndctb := gse.Integer_Value( cursor, 46 );
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_benunit.fsmbu:= Amount'Value( gse.Value( cursor, 47 ));
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_benunit.fsmlkbu:= Amount'Value( gse.Value( cursor, 48 ));
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_benunit.fwmlkbu:= Amount'Value( gse.Value( cursor, 49 ));
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_benunit.gebactb := gse.Integer_Value( cursor, 50 );
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_benunit.giltctb := gse.Integer_Value( cursor, 51 );
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_benunit.gross2 := gse.Integer_Value( cursor, 52 );
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_benunit.gross3 := gse.Integer_Value( cursor, 53 );
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_benunit.hbindbu := gse.Integer_Value( cursor, 54 );
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_benunit.isactb := gse.Integer_Value( cursor, 55 );
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_benunit.kid04 := gse.Integer_Value( cursor, 56 );
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_benunit.kid1115 := gse.Integer_Value( cursor, 57 );
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_benunit.kid1618 := gse.Integer_Value( cursor, 58 );
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_benunit.kid510 := gse.Integer_Value( cursor, 59 );
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_benunit.kidsbu0 := gse.Integer_Value( cursor, 60 );
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_benunit.kidsbu1 := gse.Integer_Value( cursor, 61 );
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_benunit.kidsbu10 := gse.Integer_Value( cursor, 62 );
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_benunit.kidsbu11 := gse.Integer_Value( cursor, 63 );
      end if;
      if not gse.Is_Null( cursor, 64 )then
         a_benunit.kidsbu12 := gse.Integer_Value( cursor, 64 );
      end if;
      if not gse.Is_Null( cursor, 65 )then
         a_benunit.kidsbu13 := gse.Integer_Value( cursor, 65 );
      end if;
      if not gse.Is_Null( cursor, 66 )then
         a_benunit.kidsbu14 := gse.Integer_Value( cursor, 66 );
      end if;
      if not gse.Is_Null( cursor, 67 )then
         a_benunit.kidsbu15 := gse.Integer_Value( cursor, 67 );
      end if;
      if not gse.Is_Null( cursor, 68 )then
         a_benunit.kidsbu16 := gse.Integer_Value( cursor, 68 );
      end if;
      if not gse.Is_Null( cursor, 69 )then
         a_benunit.kidsbu17 := gse.Integer_Value( cursor, 69 );
      end if;
      if not gse.Is_Null( cursor, 70 )then
         a_benunit.kidsbu18 := gse.Integer_Value( cursor, 70 );
      end if;
      if not gse.Is_Null( cursor, 71 )then
         a_benunit.kidsbu2 := gse.Integer_Value( cursor, 71 );
      end if;
      if not gse.Is_Null( cursor, 72 )then
         a_benunit.kidsbu3 := gse.Integer_Value( cursor, 72 );
      end if;
      if not gse.Is_Null( cursor, 73 )then
         a_benunit.kidsbu4 := gse.Integer_Value( cursor, 73 );
      end if;
      if not gse.Is_Null( cursor, 74 )then
         a_benunit.kidsbu5 := gse.Integer_Value( cursor, 74 );
      end if;
      if not gse.Is_Null( cursor, 75 )then
         a_benunit.kidsbu6 := gse.Integer_Value( cursor, 75 );
      end if;
      if not gse.Is_Null( cursor, 76 )then
         a_benunit.kidsbu7 := gse.Integer_Value( cursor, 76 );
      end if;
      if not gse.Is_Null( cursor, 77 )then
         a_benunit.kidsbu8 := gse.Integer_Value( cursor, 77 );
      end if;
      if not gse.Is_Null( cursor, 78 )then
         a_benunit.kidsbu9 := gse.Integer_Value( cursor, 78 );
      end if;
      if not gse.Is_Null( cursor, 79 )then
         a_benunit.lastwork := gse.Integer_Value( cursor, 79 );
      end if;
      if not gse.Is_Null( cursor, 80 )then
         a_benunit.lodger:= Amount'Value( gse.Value( cursor, 80 ));
      end if;
      if not gse.Is_Null( cursor, 81 )then
         a_benunit.nsboctb := gse.Integer_Value( cursor, 81 );
      end if;
      if not gse.Is_Null( cursor, 82 )then
         a_benunit.otbsctb := gse.Integer_Value( cursor, 82 );
      end if;
      if not gse.Is_Null( cursor, 83 )then
         a_benunit.pepsctb := gse.Integer_Value( cursor, 83 );
      end if;
      if not gse.Is_Null( cursor, 84 )then
         a_benunit.poacctb := gse.Integer_Value( cursor, 84 );
      end if;
      if not gse.Is_Null( cursor, 85 )then
         a_benunit.prboctb := gse.Integer_Value( cursor, 85 );
      end if;
      if not gse.Is_Null( cursor, 86 )then
         a_benunit.sayectb := gse.Integer_Value( cursor, 86 );
      end if;
      if not gse.Is_Null( cursor, 87 )then
         a_benunit.sclbctb := gse.Integer_Value( cursor, 87 );
      end if;
      if not gse.Is_Null( cursor, 88 )then
         a_benunit.ssctb := gse.Integer_Value( cursor, 88 );
      end if;
      if not gse.Is_Null( cursor, 89 )then
         a_benunit.stshctb := gse.Integer_Value( cursor, 89 );
      end if;
      if not gse.Is_Null( cursor, 90 )then
         a_benunit.subltamt:= Amount'Value( gse.Value( cursor, 90 ));
      end if;
      if not gse.Is_Null( cursor, 91 )then
         a_benunit.tessctb := gse.Integer_Value( cursor, 91 );
      end if;
      if not gse.Is_Null( cursor, 92 )then
         a_benunit.totcapbu:= Amount'Value( gse.Value( cursor, 92 ));
      end if;
      if not gse.Is_Null( cursor, 93 )then
         a_benunit.totsavbu := gse.Integer_Value( cursor, 93 );
      end if;
      if not gse.Is_Null( cursor, 94 )then
         a_benunit.tuburent:= Amount'Value( gse.Value( cursor, 94 ));
      end if;
      if not gse.Is_Null( cursor, 95 )then
         a_benunit.untrctb := gse.Integer_Value( cursor, 95 );
      end if;
      if not gse.Is_Null( cursor, 96 )then
         a_benunit.youngch := gse.Integer_Value( cursor, 96 );
      end if;
      if not gse.Is_Null( cursor, 97 )then
         a_benunit.adddec := gse.Integer_Value( cursor, 97 );
      end if;
      if not gse.Is_Null( cursor, 98 )then
         a_benunit.addeples := gse.Integer_Value( cursor, 98 );
      end if;
      if not gse.Is_Null( cursor, 99 )then
         a_benunit.addhol := gse.Integer_Value( cursor, 99 );
      end if;
      if not gse.Is_Null( cursor, 100 )then
         a_benunit.addins := gse.Integer_Value( cursor, 100 );
      end if;
      if not gse.Is_Null( cursor, 101 )then
         a_benunit.addmel := gse.Integer_Value( cursor, 101 );
      end if;
      if not gse.Is_Null( cursor, 102 )then
         a_benunit.addmon := gse.Integer_Value( cursor, 102 );
      end if;
      if not gse.Is_Null( cursor, 103 )then
         a_benunit.addshoe := gse.Integer_Value( cursor, 103 );
      end if;
      if not gse.Is_Null( cursor, 104 )then
         a_benunit.adepfur := gse.Integer_Value( cursor, 104 );
      end if;
      if not gse.Is_Null( cursor, 105 )then
         a_benunit.af1 := gse.Integer_Value( cursor, 105 );
      end if;
      if not gse.Is_Null( cursor, 106 )then
         a_benunit.afdep2 := gse.Integer_Value( cursor, 106 );
      end if;
      if not gse.Is_Null( cursor, 107 )then
         a_benunit.cdelply := gse.Integer_Value( cursor, 107 );
      end if;
      if not gse.Is_Null( cursor, 108 )then
         a_benunit.cdepbed := gse.Integer_Value( cursor, 108 );
      end if;
      if not gse.Is_Null( cursor, 109 )then
         a_benunit.cdepcel := gse.Integer_Value( cursor, 109 );
      end if;
      if not gse.Is_Null( cursor, 110 )then
         a_benunit.cdepeqp := gse.Integer_Value( cursor, 110 );
      end if;
      if not gse.Is_Null( cursor, 111 )then
         a_benunit.cdephol := gse.Integer_Value( cursor, 111 );
      end if;
      if not gse.Is_Null( cursor, 112 )then
         a_benunit.cdeples := gse.Integer_Value( cursor, 112 );
      end if;
      if not gse.Is_Null( cursor, 113 )then
         a_benunit.cdepsum := gse.Integer_Value( cursor, 113 );
      end if;
      if not gse.Is_Null( cursor, 114 )then
         a_benunit.cdeptea := gse.Integer_Value( cursor, 114 );
      end if;
      if not gse.Is_Null( cursor, 115 )then
         a_benunit.cdeptrp := gse.Integer_Value( cursor, 115 );
      end if;
      if not gse.Is_Null( cursor, 116 )then
         a_benunit.cplay := gse.Integer_Value( cursor, 116 );
      end if;
      if not gse.Is_Null( cursor, 117 )then
         a_benunit.debt1 := gse.Integer_Value( cursor, 117 );
      end if;
      if not gse.Is_Null( cursor, 118 )then
         a_benunit.debt2 := gse.Integer_Value( cursor, 118 );
      end if;
      if not gse.Is_Null( cursor, 119 )then
         a_benunit.debt3 := gse.Integer_Value( cursor, 119 );
      end if;
      if not gse.Is_Null( cursor, 120 )then
         a_benunit.debt4 := gse.Integer_Value( cursor, 120 );
      end if;
      if not gse.Is_Null( cursor, 121 )then
         a_benunit.debt5 := gse.Integer_Value( cursor, 121 );
      end if;
      if not gse.Is_Null( cursor, 122 )then
         a_benunit.debt6 := gse.Integer_Value( cursor, 122 );
      end if;
      if not gse.Is_Null( cursor, 123 )then
         a_benunit.debt7 := gse.Integer_Value( cursor, 123 );
      end if;
      if not gse.Is_Null( cursor, 124 )then
         a_benunit.debt8 := gse.Integer_Value( cursor, 124 );
      end if;
      if not gse.Is_Null( cursor, 125 )then
         a_benunit.debt9 := gse.Integer_Value( cursor, 125 );
      end if;
      if not gse.Is_Null( cursor, 126 )then
         a_benunit.houshe1 := gse.Integer_Value( cursor, 126 );
      end if;
      if not gse.Is_Null( cursor, 127 )then
         a_benunit.incold := gse.Integer_Value( cursor, 127 );
      end if;
      if not gse.Is_Null( cursor, 128 )then
         a_benunit.crunacb := gse.Integer_Value( cursor, 128 );
      end if;
      if not gse.Is_Null( cursor, 129 )then
         a_benunit.enomortb := gse.Integer_Value( cursor, 129 );
      end if;
      if not gse.Is_Null( cursor, 130 )then
         a_benunit.hbindbu2 := gse.Integer_Value( cursor, 130 );
      end if;
      if not gse.Is_Null( cursor, 131 )then
         a_benunit.pocardb := gse.Integer_Value( cursor, 131 );
      end if;
      if not gse.Is_Null( cursor, 132 )then
         a_benunit.kid1619 := gse.Integer_Value( cursor, 132 );
      end if;
      if not gse.Is_Null( cursor, 133 )then
         a_benunit.totcapb2:= Amount'Value( gse.Value( cursor, 133 ));
      end if;
      if not gse.Is_Null( cursor, 134 )then
         a_benunit.billnt1 := gse.Integer_Value( cursor, 134 );
      end if;
      if not gse.Is_Null( cursor, 135 )then
         a_benunit.billnt2 := gse.Integer_Value( cursor, 135 );
      end if;
      if not gse.Is_Null( cursor, 136 )then
         a_benunit.billnt3 := gse.Integer_Value( cursor, 136 );
      end if;
      if not gse.Is_Null( cursor, 137 )then
         a_benunit.billnt4 := gse.Integer_Value( cursor, 137 );
      end if;
      if not gse.Is_Null( cursor, 138 )then
         a_benunit.billnt5 := gse.Integer_Value( cursor, 138 );
      end if;
      if not gse.Is_Null( cursor, 139 )then
         a_benunit.billnt6 := gse.Integer_Value( cursor, 139 );
      end if;
      if not gse.Is_Null( cursor, 140 )then
         a_benunit.billnt7 := gse.Integer_Value( cursor, 140 );
      end if;
      if not gse.Is_Null( cursor, 141 )then
         a_benunit.billnt8 := gse.Integer_Value( cursor, 141 );
      end if;
      if not gse.Is_Null( cursor, 142 )then
         a_benunit.coatnt1 := gse.Integer_Value( cursor, 142 );
      end if;
      if not gse.Is_Null( cursor, 143 )then
         a_benunit.coatnt2 := gse.Integer_Value( cursor, 143 );
      end if;
      if not gse.Is_Null( cursor, 144 )then
         a_benunit.coatnt3 := gse.Integer_Value( cursor, 144 );
      end if;
      if not gse.Is_Null( cursor, 145 )then
         a_benunit.coatnt4 := gse.Integer_Value( cursor, 145 );
      end if;
      if not gse.Is_Null( cursor, 146 )then
         a_benunit.coatnt5 := gse.Integer_Value( cursor, 146 );
      end if;
      if not gse.Is_Null( cursor, 147 )then
         a_benunit.coatnt6 := gse.Integer_Value( cursor, 147 );
      end if;
      if not gse.Is_Null( cursor, 148 )then
         a_benunit.coatnt7 := gse.Integer_Value( cursor, 148 );
      end if;
      if not gse.Is_Null( cursor, 149 )then
         a_benunit.coatnt8 := gse.Integer_Value( cursor, 149 );
      end if;
      if not gse.Is_Null( cursor, 150 )then
         a_benunit.cooknt1 := gse.Integer_Value( cursor, 150 );
      end if;
      if not gse.Is_Null( cursor, 151 )then
         a_benunit.cooknt2 := gse.Integer_Value( cursor, 151 );
      end if;
      if not gse.Is_Null( cursor, 152 )then
         a_benunit.cooknt3 := gse.Integer_Value( cursor, 152 );
      end if;
      if not gse.Is_Null( cursor, 153 )then
         a_benunit.cooknt4 := gse.Integer_Value( cursor, 153 );
      end if;
      if not gse.Is_Null( cursor, 154 )then
         a_benunit.cooknt5 := gse.Integer_Value( cursor, 154 );
      end if;
      if not gse.Is_Null( cursor, 155 )then
         a_benunit.cooknt6 := gse.Integer_Value( cursor, 155 );
      end if;
      if not gse.Is_Null( cursor, 156 )then
         a_benunit.cooknt7 := gse.Integer_Value( cursor, 156 );
      end if;
      if not gse.Is_Null( cursor, 157 )then
         a_benunit.cooknt8 := gse.Integer_Value( cursor, 157 );
      end if;
      if not gse.Is_Null( cursor, 158 )then
         a_benunit.dampnt1 := gse.Integer_Value( cursor, 158 );
      end if;
      if not gse.Is_Null( cursor, 159 )then
         a_benunit.dampnt2 := gse.Integer_Value( cursor, 159 );
      end if;
      if not gse.Is_Null( cursor, 160 )then
         a_benunit.dampnt3 := gse.Integer_Value( cursor, 160 );
      end if;
      if not gse.Is_Null( cursor, 161 )then
         a_benunit.dampnt4 := gse.Integer_Value( cursor, 161 );
      end if;
      if not gse.Is_Null( cursor, 162 )then
         a_benunit.dampnt5 := gse.Integer_Value( cursor, 162 );
      end if;
      if not gse.Is_Null( cursor, 163 )then
         a_benunit.dampnt6 := gse.Integer_Value( cursor, 163 );
      end if;
      if not gse.Is_Null( cursor, 164 )then
         a_benunit.dampnt7 := gse.Integer_Value( cursor, 164 );
      end if;
      if not gse.Is_Null( cursor, 165 )then
         a_benunit.dampnt8 := gse.Integer_Value( cursor, 165 );
      end if;
      if not gse.Is_Null( cursor, 166 )then
         a_benunit.frndnt1 := gse.Integer_Value( cursor, 166 );
      end if;
      if not gse.Is_Null( cursor, 167 )then
         a_benunit.frndnt2 := gse.Integer_Value( cursor, 167 );
      end if;
      if not gse.Is_Null( cursor, 168 )then
         a_benunit.frndnt3 := gse.Integer_Value( cursor, 168 );
      end if;
      if not gse.Is_Null( cursor, 169 )then
         a_benunit.frndnt4 := gse.Integer_Value( cursor, 169 );
      end if;
      if not gse.Is_Null( cursor, 170 )then
         a_benunit.frndnt5 := gse.Integer_Value( cursor, 170 );
      end if;
      if not gse.Is_Null( cursor, 171 )then
         a_benunit.frndnt6 := gse.Integer_Value( cursor, 171 );
      end if;
      if not gse.Is_Null( cursor, 172 )then
         a_benunit.frndnt7 := gse.Integer_Value( cursor, 172 );
      end if;
      if not gse.Is_Null( cursor, 173 )then
         a_benunit.frndnt8 := gse.Integer_Value( cursor, 173 );
      end if;
      if not gse.Is_Null( cursor, 174 )then
         a_benunit.hairnt1 := gse.Integer_Value( cursor, 174 );
      end if;
      if not gse.Is_Null( cursor, 175 )then
         a_benunit.hairnt2 := gse.Integer_Value( cursor, 175 );
      end if;
      if not gse.Is_Null( cursor, 176 )then
         a_benunit.hairnt3 := gse.Integer_Value( cursor, 176 );
      end if;
      if not gse.Is_Null( cursor, 177 )then
         a_benunit.hairnt4 := gse.Integer_Value( cursor, 177 );
      end if;
      if not gse.Is_Null( cursor, 178 )then
         a_benunit.hairnt5 := gse.Integer_Value( cursor, 178 );
      end if;
      if not gse.Is_Null( cursor, 179 )then
         a_benunit.hairnt6 := gse.Integer_Value( cursor, 179 );
      end if;
      if not gse.Is_Null( cursor, 180 )then
         a_benunit.hairnt7 := gse.Integer_Value( cursor, 180 );
      end if;
      if not gse.Is_Null( cursor, 181 )then
         a_benunit.hairnt8 := gse.Integer_Value( cursor, 181 );
      end if;
      if not gse.Is_Null( cursor, 182 )then
         a_benunit.heatnt1 := gse.Integer_Value( cursor, 182 );
      end if;
      if not gse.Is_Null( cursor, 183 )then
         a_benunit.heatnt2 := gse.Integer_Value( cursor, 183 );
      end if;
      if not gse.Is_Null( cursor, 184 )then
         a_benunit.heatnt3 := gse.Integer_Value( cursor, 184 );
      end if;
      if not gse.Is_Null( cursor, 185 )then
         a_benunit.heatnt4 := gse.Integer_Value( cursor, 185 );
      end if;
      if not gse.Is_Null( cursor, 186 )then
         a_benunit.heatnt5 := gse.Integer_Value( cursor, 186 );
      end if;
      if not gse.Is_Null( cursor, 187 )then
         a_benunit.heatnt6 := gse.Integer_Value( cursor, 187 );
      end if;
      if not gse.Is_Null( cursor, 188 )then
         a_benunit.heatnt7 := gse.Integer_Value( cursor, 188 );
      end if;
      if not gse.Is_Null( cursor, 189 )then
         a_benunit.heatnt8 := gse.Integer_Value( cursor, 189 );
      end if;
      if not gse.Is_Null( cursor, 190 )then
         a_benunit.holnt1 := gse.Integer_Value( cursor, 190 );
      end if;
      if not gse.Is_Null( cursor, 191 )then
         a_benunit.holnt2 := gse.Integer_Value( cursor, 191 );
      end if;
      if not gse.Is_Null( cursor, 192 )then
         a_benunit.holnt3 := gse.Integer_Value( cursor, 192 );
      end if;
      if not gse.Is_Null( cursor, 193 )then
         a_benunit.holnt4 := gse.Integer_Value( cursor, 193 );
      end if;
      if not gse.Is_Null( cursor, 194 )then
         a_benunit.holnt5 := gse.Integer_Value( cursor, 194 );
      end if;
      if not gse.Is_Null( cursor, 195 )then
         a_benunit.holnt6 := gse.Integer_Value( cursor, 195 );
      end if;
      if not gse.Is_Null( cursor, 196 )then
         a_benunit.holnt7 := gse.Integer_Value( cursor, 196 );
      end if;
      if not gse.Is_Null( cursor, 197 )then
         a_benunit.holnt8 := gse.Integer_Value( cursor, 197 );
      end if;
      if not gse.Is_Null( cursor, 198 )then
         a_benunit.homent1 := gse.Integer_Value( cursor, 198 );
      end if;
      if not gse.Is_Null( cursor, 199 )then
         a_benunit.homent2 := gse.Integer_Value( cursor, 199 );
      end if;
      if not gse.Is_Null( cursor, 200 )then
         a_benunit.homent3 := gse.Integer_Value( cursor, 200 );
      end if;
      if not gse.Is_Null( cursor, 201 )then
         a_benunit.homent4 := gse.Integer_Value( cursor, 201 );
      end if;
      if not gse.Is_Null( cursor, 202 )then
         a_benunit.homent5 := gse.Integer_Value( cursor, 202 );
      end if;
      if not gse.Is_Null( cursor, 203 )then
         a_benunit.homent6 := gse.Integer_Value( cursor, 203 );
      end if;
      if not gse.Is_Null( cursor, 204 )then
         a_benunit.homent7 := gse.Integer_Value( cursor, 204 );
      end if;
      if not gse.Is_Null( cursor, 205 )then
         a_benunit.homent8 := gse.Integer_Value( cursor, 205 );
      end if;
      if not gse.Is_Null( cursor, 206 )then
         a_benunit.issue := gse.Integer_Value( cursor, 206 );
      end if;
      if not gse.Is_Null( cursor, 207 )then
         a_benunit.mealnt1 := gse.Integer_Value( cursor, 207 );
      end if;
      if not gse.Is_Null( cursor, 208 )then
         a_benunit.mealnt2 := gse.Integer_Value( cursor, 208 );
      end if;
      if not gse.Is_Null( cursor, 209 )then
         a_benunit.mealnt3 := gse.Integer_Value( cursor, 209 );
      end if;
      if not gse.Is_Null( cursor, 210 )then
         a_benunit.mealnt4 := gse.Integer_Value( cursor, 210 );
      end if;
      if not gse.Is_Null( cursor, 211 )then
         a_benunit.mealnt5 := gse.Integer_Value( cursor, 211 );
      end if;
      if not gse.Is_Null( cursor, 212 )then
         a_benunit.mealnt6 := gse.Integer_Value( cursor, 212 );
      end if;
      if not gse.Is_Null( cursor, 213 )then
         a_benunit.mealnt7 := gse.Integer_Value( cursor, 213 );
      end if;
      if not gse.Is_Null( cursor, 214 )then
         a_benunit.mealnt8 := gse.Integer_Value( cursor, 214 );
      end if;
      if not gse.Is_Null( cursor, 215 )then
         a_benunit.oabill := gse.Integer_Value( cursor, 215 );
      end if;
      if not gse.Is_Null( cursor, 216 )then
         a_benunit.oacoat := gse.Integer_Value( cursor, 216 );
      end if;
      if not gse.Is_Null( cursor, 217 )then
         a_benunit.oacook := gse.Integer_Value( cursor, 217 );
      end if;
      if not gse.Is_Null( cursor, 218 )then
         a_benunit.oadamp := gse.Integer_Value( cursor, 218 );
      end if;
      if not gse.Is_Null( cursor, 219 )then
         a_benunit.oaexpns := gse.Integer_Value( cursor, 219 );
      end if;
      if not gse.Is_Null( cursor, 220 )then
         a_benunit.oafrnd := gse.Integer_Value( cursor, 220 );
      end if;
      if not gse.Is_Null( cursor, 221 )then
         a_benunit.oahair := gse.Integer_Value( cursor, 221 );
      end if;
      if not gse.Is_Null( cursor, 222 )then
         a_benunit.oaheat := gse.Integer_Value( cursor, 222 );
      end if;
      if not gse.Is_Null( cursor, 223 )then
         a_benunit.oahol := gse.Integer_Value( cursor, 223 );
      end if;
      if not gse.Is_Null( cursor, 224 )then
         a_benunit.oahome := gse.Integer_Value( cursor, 224 );
      end if;
      if not gse.Is_Null( cursor, 225 )then
         a_benunit.oahowpy1 := gse.Integer_Value( cursor, 225 );
      end if;
      if not gse.Is_Null( cursor, 226 )then
         a_benunit.oahowpy2 := gse.Integer_Value( cursor, 226 );
      end if;
      if not gse.Is_Null( cursor, 227 )then
         a_benunit.oahowpy3 := gse.Integer_Value( cursor, 227 );
      end if;
      if not gse.Is_Null( cursor, 228 )then
         a_benunit.oahowpy4 := gse.Integer_Value( cursor, 228 );
      end if;
      if not gse.Is_Null( cursor, 229 )then
         a_benunit.oahowpy5 := gse.Integer_Value( cursor, 229 );
      end if;
      if not gse.Is_Null( cursor, 230 )then
         a_benunit.oahowpy6 := gse.Integer_Value( cursor, 230 );
      end if;
      if not gse.Is_Null( cursor, 231 )then
         a_benunit.oameal := gse.Integer_Value( cursor, 231 );
      end if;
      if not gse.Is_Null( cursor, 232 )then
         a_benunit.oaout := gse.Integer_Value( cursor, 232 );
      end if;
      if not gse.Is_Null( cursor, 233 )then
         a_benunit.oaphon := gse.Integer_Value( cursor, 233 );
      end if;
      if not gse.Is_Null( cursor, 234 )then
         a_benunit.oataxi := gse.Integer_Value( cursor, 234 );
      end if;
      if not gse.Is_Null( cursor, 235 )then
         a_benunit.oawarm := gse.Integer_Value( cursor, 235 );
      end if;
      if not gse.Is_Null( cursor, 236 )then
         a_benunit.outnt1 := gse.Integer_Value( cursor, 236 );
      end if;
      if not gse.Is_Null( cursor, 237 )then
         a_benunit.outnt2 := gse.Integer_Value( cursor, 237 );
      end if;
      if not gse.Is_Null( cursor, 238 )then
         a_benunit.outnt3 := gse.Integer_Value( cursor, 238 );
      end if;
      if not gse.Is_Null( cursor, 239 )then
         a_benunit.outnt4 := gse.Integer_Value( cursor, 239 );
      end if;
      if not gse.Is_Null( cursor, 240 )then
         a_benunit.outnt5 := gse.Integer_Value( cursor, 240 );
      end if;
      if not gse.Is_Null( cursor, 241 )then
         a_benunit.outnt6 := gse.Integer_Value( cursor, 241 );
      end if;
      if not gse.Is_Null( cursor, 242 )then
         a_benunit.outnt7 := gse.Integer_Value( cursor, 242 );
      end if;
      if not gse.Is_Null( cursor, 243 )then
         a_benunit.outnt8 := gse.Integer_Value( cursor, 243 );
      end if;
      if not gse.Is_Null( cursor, 244 )then
         a_benunit.phonnt1 := gse.Integer_Value( cursor, 244 );
      end if;
      if not gse.Is_Null( cursor, 245 )then
         a_benunit.phonnt2 := gse.Integer_Value( cursor, 245 );
      end if;
      if not gse.Is_Null( cursor, 246 )then
         a_benunit.phonnt3 := gse.Integer_Value( cursor, 246 );
      end if;
      if not gse.Is_Null( cursor, 247 )then
         a_benunit.phonnt4 := gse.Integer_Value( cursor, 247 );
      end if;
      if not gse.Is_Null( cursor, 248 )then
         a_benunit.phonnt5 := gse.Integer_Value( cursor, 248 );
      end if;
      if not gse.Is_Null( cursor, 249 )then
         a_benunit.phonnt6 := gse.Integer_Value( cursor, 249 );
      end if;
      if not gse.Is_Null( cursor, 250 )then
         a_benunit.phonnt7 := gse.Integer_Value( cursor, 250 );
      end if;
      if not gse.Is_Null( cursor, 251 )then
         a_benunit.phonnt8 := gse.Integer_Value( cursor, 251 );
      end if;
      if not gse.Is_Null( cursor, 252 )then
         a_benunit.taxint1 := gse.Integer_Value( cursor, 252 );
      end if;
      if not gse.Is_Null( cursor, 253 )then
         a_benunit.taxint2 := gse.Integer_Value( cursor, 253 );
      end if;
      if not gse.Is_Null( cursor, 254 )then
         a_benunit.taxint3 := gse.Integer_Value( cursor, 254 );
      end if;
      if not gse.Is_Null( cursor, 255 )then
         a_benunit.taxint4 := gse.Integer_Value( cursor, 255 );
      end if;
      if not gse.Is_Null( cursor, 256 )then
         a_benunit.taxint5 := gse.Integer_Value( cursor, 256 );
      end if;
      if not gse.Is_Null( cursor, 257 )then
         a_benunit.taxint6 := gse.Integer_Value( cursor, 257 );
      end if;
      if not gse.Is_Null( cursor, 258 )then
         a_benunit.taxint7 := gse.Integer_Value( cursor, 258 );
      end if;
      if not gse.Is_Null( cursor, 259 )then
         a_benunit.taxint8 := gse.Integer_Value( cursor, 259 );
      end if;
      if not gse.Is_Null( cursor, 260 )then
         a_benunit.warmnt1 := gse.Integer_Value( cursor, 260 );
      end if;
      if not gse.Is_Null( cursor, 261 )then
         a_benunit.warmnt2 := gse.Integer_Value( cursor, 261 );
      end if;
      if not gse.Is_Null( cursor, 262 )then
         a_benunit.warmnt3 := gse.Integer_Value( cursor, 262 );
      end if;
      if not gse.Is_Null( cursor, 263 )then
         a_benunit.warmnt4 := gse.Integer_Value( cursor, 263 );
      end if;
      if not gse.Is_Null( cursor, 264 )then
         a_benunit.warmnt5 := gse.Integer_Value( cursor, 264 );
      end if;
      if not gse.Is_Null( cursor, 265 )then
         a_benunit.warmnt6 := gse.Integer_Value( cursor, 265 );
      end if;
      if not gse.Is_Null( cursor, 266 )then
         a_benunit.warmnt7 := gse.Integer_Value( cursor, 266 );
      end if;
      if not gse.Is_Null( cursor, 267 )then
         a_benunit.warmnt8 := gse.Integer_Value( cursor, 267 );
      end if;
      if not gse.Is_Null( cursor, 268 )then
         a_benunit.buagegr3 := gse.Integer_Value( cursor, 268 );
      end if;
      if not gse.Is_Null( cursor, 269 )then
         a_benunit.buagegr4 := gse.Integer_Value( cursor, 269 );
      end if;
      if not gse.Is_Null( cursor, 270 )then
         a_benunit.heartbu:= Amount'Value( gse.Value( cursor, 270 ));
      end if;
      if not gse.Is_Null( cursor, 271 )then
         a_benunit.newfambu := gse.Integer_Value( cursor, 271 );
      end if;
      if not gse.Is_Null( cursor, 272 )then
         a_benunit.billnt9 := gse.Integer_Value( cursor, 272 );
      end if;
      if not gse.Is_Null( cursor, 273 )then
         a_benunit.cbaamt1 := gse.Integer_Value( cursor, 273 );
      end if;
      if not gse.Is_Null( cursor, 274 )then
         a_benunit.cbaamt2 := gse.Integer_Value( cursor, 274 );
      end if;
      if not gse.Is_Null( cursor, 275 )then
         a_benunit.coatnt9 := gse.Integer_Value( cursor, 275 );
      end if;
      if not gse.Is_Null( cursor, 276 )then
         a_benunit.cooknt9 := gse.Integer_Value( cursor, 276 );
      end if;
      if not gse.Is_Null( cursor, 277 )then
         a_benunit.dampnt9 := gse.Integer_Value( cursor, 277 );
      end if;
      if not gse.Is_Null( cursor, 278 )then
         a_benunit.frndnt9 := gse.Integer_Value( cursor, 278 );
      end if;
      if not gse.Is_Null( cursor, 279 )then
         a_benunit.hairnt9 := gse.Integer_Value( cursor, 279 );
      end if;
      if not gse.Is_Null( cursor, 280 )then
         a_benunit.hbolng := gse.Integer_Value( cursor, 280 );
      end if;
      if not gse.Is_Null( cursor, 281 )then
         a_benunit.hbothamt:= Amount'Value( gse.Value( cursor, 281 ));
      end if;
      if not gse.Is_Null( cursor, 282 )then
         a_benunit.hbothbu := gse.Integer_Value( cursor, 282 );
      end if;
      if not gse.Is_Null( cursor, 283 )then
         a_benunit.hbothmn := gse.Integer_Value( cursor, 283 );
      end if;
      if not gse.Is_Null( cursor, 284 )then
         a_benunit.hbothpd := gse.Integer_Value( cursor, 284 );
      end if;
      if not gse.Is_Null( cursor, 285 )then
         a_benunit.hbothwk := gse.Integer_Value( cursor, 285 );
      end if;
      if not gse.Is_Null( cursor, 286 )then
         a_benunit.hbothyr := gse.Integer_Value( cursor, 286 );
      end if;
      if not gse.Is_Null( cursor, 287 )then
         a_benunit.hbotwait := gse.Integer_Value( cursor, 287 );
      end if;
      if not gse.Is_Null( cursor, 288 )then
         a_benunit.heatnt9 := gse.Integer_Value( cursor, 288 );
      end if;
      if not gse.Is_Null( cursor, 289 )then
         a_benunit.helpgv01 := gse.Integer_Value( cursor, 289 );
      end if;
      if not gse.Is_Null( cursor, 290 )then
         a_benunit.helpgv02 := gse.Integer_Value( cursor, 290 );
      end if;
      if not gse.Is_Null( cursor, 291 )then
         a_benunit.helpgv03 := gse.Integer_Value( cursor, 291 );
      end if;
      if not gse.Is_Null( cursor, 292 )then
         a_benunit.helpgv04 := gse.Integer_Value( cursor, 292 );
      end if;
      if not gse.Is_Null( cursor, 293 )then
         a_benunit.helpgv05 := gse.Integer_Value( cursor, 293 );
      end if;
      if not gse.Is_Null( cursor, 294 )then
         a_benunit.helpgv06 := gse.Integer_Value( cursor, 294 );
      end if;
      if not gse.Is_Null( cursor, 295 )then
         a_benunit.helpgv07 := gse.Integer_Value( cursor, 295 );
      end if;
      if not gse.Is_Null( cursor, 296 )then
         a_benunit.helpgv08 := gse.Integer_Value( cursor, 296 );
      end if;
      if not gse.Is_Null( cursor, 297 )then
         a_benunit.helpgv09 := gse.Integer_Value( cursor, 297 );
      end if;
      if not gse.Is_Null( cursor, 298 )then
         a_benunit.helpgv10 := gse.Integer_Value( cursor, 298 );
      end if;
      if not gse.Is_Null( cursor, 299 )then
         a_benunit.helpgv11 := gse.Integer_Value( cursor, 299 );
      end if;
      if not gse.Is_Null( cursor, 300 )then
         a_benunit.helprc01 := gse.Integer_Value( cursor, 300 );
      end if;
      if not gse.Is_Null( cursor, 301 )then
         a_benunit.helprc02 := gse.Integer_Value( cursor, 301 );
      end if;
      if not gse.Is_Null( cursor, 302 )then
         a_benunit.helprc03 := gse.Integer_Value( cursor, 302 );
      end if;
      if not gse.Is_Null( cursor, 303 )then
         a_benunit.helprc04 := gse.Integer_Value( cursor, 303 );
      end if;
      if not gse.Is_Null( cursor, 304 )then
         a_benunit.helprc05 := gse.Integer_Value( cursor, 304 );
      end if;
      if not gse.Is_Null( cursor, 305 )then
         a_benunit.helprc06 := gse.Integer_Value( cursor, 305 );
      end if;
      if not gse.Is_Null( cursor, 306 )then
         a_benunit.helprc07 := gse.Integer_Value( cursor, 306 );
      end if;
      if not gse.Is_Null( cursor, 307 )then
         a_benunit.helprc08 := gse.Integer_Value( cursor, 307 );
      end if;
      if not gse.Is_Null( cursor, 308 )then
         a_benunit.helprc09 := gse.Integer_Value( cursor, 308 );
      end if;
      if not gse.Is_Null( cursor, 309 )then
         a_benunit.helprc10 := gse.Integer_Value( cursor, 309 );
      end if;
      if not gse.Is_Null( cursor, 310 )then
         a_benunit.helprc11 := gse.Integer_Value( cursor, 310 );
      end if;
      if not gse.Is_Null( cursor, 311 )then
         a_benunit.holnt9 := gse.Integer_Value( cursor, 311 );
      end if;
      if not gse.Is_Null( cursor, 312 )then
         a_benunit.homent9 := gse.Integer_Value( cursor, 312 );
      end if;
      if not gse.Is_Null( cursor, 313 )then
         a_benunit.loangvn1 := gse.Integer_Value( cursor, 313 );
      end if;
      if not gse.Is_Null( cursor, 314 )then
         a_benunit.loangvn2 := gse.Integer_Value( cursor, 314 );
      end if;
      if not gse.Is_Null( cursor, 315 )then
         a_benunit.loangvn3 := gse.Integer_Value( cursor, 315 );
      end if;
      if not gse.Is_Null( cursor, 316 )then
         a_benunit.loanrec1 := gse.Integer_Value( cursor, 316 );
      end if;
      if not gse.Is_Null( cursor, 317 )then
         a_benunit.loanrec2 := gse.Integer_Value( cursor, 317 );
      end if;
      if not gse.Is_Null( cursor, 318 )then
         a_benunit.loanrec3 := gse.Integer_Value( cursor, 318 );
      end if;
      if not gse.Is_Null( cursor, 319 )then
         a_benunit.mealnt9 := gse.Integer_Value( cursor, 319 );
      end if;
      if not gse.Is_Null( cursor, 320 )then
         a_benunit.outnt9 := gse.Integer_Value( cursor, 320 );
      end if;
      if not gse.Is_Null( cursor, 321 )then
         a_benunit.phonnt9 := gse.Integer_Value( cursor, 321 );
      end if;
      if not gse.Is_Null( cursor, 322 )then
         a_benunit.taxint9 := gse.Integer_Value( cursor, 322 );
      end if;
      if not gse.Is_Null( cursor, 323 )then
         a_benunit.warmnt9 := gse.Integer_Value( cursor, 323 );
      end if;
      if not gse.Is_Null( cursor, 324 )then
         a_benunit.ecostabu := gse.Integer_Value( cursor, 324 );
      end if;
      if not gse.Is_Null( cursor, 325 )then
         a_benunit.famtypb2 := gse.Integer_Value( cursor, 325 );
      end if;
      if not gse.Is_Null( cursor, 326 )then
         a_benunit.gross3_x := gse.Integer_Value( cursor, 326 );
      end if;
      if not gse.Is_Null( cursor, 327 )then
         a_benunit.newfamb2 := gse.Integer_Value( cursor, 327 );
      end if;
      if not gse.Is_Null( cursor, 328 )then
         a_benunit.oabilimp := gse.Integer_Value( cursor, 328 );
      end if;
      if not gse.Is_Null( cursor, 329 )then
         a_benunit.oacoaimp := gse.Integer_Value( cursor, 329 );
      end if;
      if not gse.Is_Null( cursor, 330 )then
         a_benunit.oacooimp := gse.Integer_Value( cursor, 330 );
      end if;
      if not gse.Is_Null( cursor, 331 )then
         a_benunit.oadamimp := gse.Integer_Value( cursor, 331 );
      end if;
      if not gse.Is_Null( cursor, 332 )then
         a_benunit.oaexpimp := gse.Integer_Value( cursor, 332 );
      end if;
      if not gse.Is_Null( cursor, 333 )then
         a_benunit.oafrnimp := gse.Integer_Value( cursor, 333 );
      end if;
      if not gse.Is_Null( cursor, 334 )then
         a_benunit.oahaiimp := gse.Integer_Value( cursor, 334 );
      end if;
      if not gse.Is_Null( cursor, 335 )then
         a_benunit.oaheaimp := gse.Integer_Value( cursor, 335 );
      end if;
      if not gse.Is_Null( cursor, 336 )then
         a_benunit.oaholimp := gse.Integer_Value( cursor, 336 );
      end if;
      if not gse.Is_Null( cursor, 337 )then
         a_benunit.oahomimp := gse.Integer_Value( cursor, 337 );
      end if;
      if not gse.Is_Null( cursor, 338 )then
         a_benunit.oameaimp := gse.Integer_Value( cursor, 338 );
      end if;
      if not gse.Is_Null( cursor, 339 )then
         a_benunit.oaoutimp := gse.Integer_Value( cursor, 339 );
      end if;
      if not gse.Is_Null( cursor, 340 )then
         a_benunit.oaphoimp := gse.Integer_Value( cursor, 340 );
      end if;
      if not gse.Is_Null( cursor, 341 )then
         a_benunit.oataximp := gse.Integer_Value( cursor, 341 );
      end if;
      if not gse.Is_Null( cursor, 342 )then
         a_benunit.oawarimp := gse.Integer_Value( cursor, 342 );
      end if;
      if not gse.Is_Null( cursor, 343 )then
         a_benunit.totcapb3:= Amount'Value( gse.Value( cursor, 343 ));
      end if;
      if not gse.Is_Null( cursor, 344 )then
         a_benunit.adbtbl := gse.Integer_Value( cursor, 344 );
      end if;
      if not gse.Is_Null( cursor, 345 )then
         a_benunit.cdepact := gse.Integer_Value( cursor, 345 );
      end if;
      if not gse.Is_Null( cursor, 346 )then
         a_benunit.cdepveg := gse.Integer_Value( cursor, 346 );
      end if;
      if not gse.Is_Null( cursor, 347 )then
         a_benunit.cdpcoat := gse.Integer_Value( cursor, 347 );
      end if;
      if not gse.Is_Null( cursor, 348 )then
         a_benunit.oapre := gse.Integer_Value( cursor, 348 );
      end if;
      if not gse.Is_Null( cursor, 349 )then
         a_benunit.buethgr3 := gse.Integer_Value( cursor, 349 );
      end if;
      if not gse.Is_Null( cursor, 350 )then
         a_benunit.fsbbu:= Amount'Value( gse.Value( cursor, 350 ));
      end if;
      if not gse.Is_Null( cursor, 351 )then
         a_benunit.addholr := gse.Integer_Value( cursor, 351 );
      end if;
      if not gse.Is_Null( cursor, 352 )then
         a_benunit.computer := gse.Integer_Value( cursor, 352 );
      end if;
      if not gse.Is_Null( cursor, 353 )then
         a_benunit.compuwhy := gse.Integer_Value( cursor, 353 );
      end if;
      if not gse.Is_Null( cursor, 354 )then
         a_benunit.crime := gse.Integer_Value( cursor, 354 );
      end if;
      if not gse.Is_Null( cursor, 355 )then
         a_benunit.damp := gse.Integer_Value( cursor, 355 );
      end if;
      if not gse.Is_Null( cursor, 356 )then
         a_benunit.dark := gse.Integer_Value( cursor, 356 );
      end if;
      if not gse.Is_Null( cursor, 357 )then
         a_benunit.debt01 := gse.Integer_Value( cursor, 357 );
      end if;
      if not gse.Is_Null( cursor, 358 )then
         a_benunit.debt02 := gse.Integer_Value( cursor, 358 );
      end if;
      if not gse.Is_Null( cursor, 359 )then
         a_benunit.debt03 := gse.Integer_Value( cursor, 359 );
      end if;
      if not gse.Is_Null( cursor, 360 )then
         a_benunit.debt04 := gse.Integer_Value( cursor, 360 );
      end if;
      if not gse.Is_Null( cursor, 361 )then
         a_benunit.debt05 := gse.Integer_Value( cursor, 361 );
      end if;
      if not gse.Is_Null( cursor, 362 )then
         a_benunit.debt06 := gse.Integer_Value( cursor, 362 );
      end if;
      if not gse.Is_Null( cursor, 363 )then
         a_benunit.debt07 := gse.Integer_Value( cursor, 363 );
      end if;
      if not gse.Is_Null( cursor, 364 )then
         a_benunit.debt08 := gse.Integer_Value( cursor, 364 );
      end if;
      if not gse.Is_Null( cursor, 365 )then
         a_benunit.debt09 := gse.Integer_Value( cursor, 365 );
      end if;
      if not gse.Is_Null( cursor, 366 )then
         a_benunit.debt10 := gse.Integer_Value( cursor, 366 );
      end if;
      if not gse.Is_Null( cursor, 367 )then
         a_benunit.debt11 := gse.Integer_Value( cursor, 367 );
      end if;
      if not gse.Is_Null( cursor, 368 )then
         a_benunit.debt12 := gse.Integer_Value( cursor, 368 );
      end if;
      if not gse.Is_Null( cursor, 369 )then
         a_benunit.debtar01 := gse.Integer_Value( cursor, 369 );
      end if;
      if not gse.Is_Null( cursor, 370 )then
         a_benunit.debtar02 := gse.Integer_Value( cursor, 370 );
      end if;
      if not gse.Is_Null( cursor, 371 )then
         a_benunit.debtar03 := gse.Integer_Value( cursor, 371 );
      end if;
      if not gse.Is_Null( cursor, 372 )then
         a_benunit.debtar04 := gse.Integer_Value( cursor, 372 );
      end if;
      if not gse.Is_Null( cursor, 373 )then
         a_benunit.debtar05 := gse.Integer_Value( cursor, 373 );
      end if;
      if not gse.Is_Null( cursor, 374 )then
         a_benunit.debtar06 := gse.Integer_Value( cursor, 374 );
      end if;
      if not gse.Is_Null( cursor, 375 )then
         a_benunit.debtar07 := gse.Integer_Value( cursor, 375 );
      end if;
      if not gse.Is_Null( cursor, 376 )then
         a_benunit.debtar08 := gse.Integer_Value( cursor, 376 );
      end if;
      if not gse.Is_Null( cursor, 377 )then
         a_benunit.debtar09 := gse.Integer_Value( cursor, 377 );
      end if;
      if not gse.Is_Null( cursor, 378 )then
         a_benunit.debtar10 := gse.Integer_Value( cursor, 378 );
      end if;
      if not gse.Is_Null( cursor, 379 )then
         a_benunit.debtar11 := gse.Integer_Value( cursor, 379 );
      end if;
      if not gse.Is_Null( cursor, 380 )then
         a_benunit.debtar12 := gse.Integer_Value( cursor, 380 );
      end if;
      if not gse.Is_Null( cursor, 381 )then
         a_benunit.debtfre1 := gse.Integer_Value( cursor, 381 );
      end if;
      if not gse.Is_Null( cursor, 382 )then
         a_benunit.debtfre2 := gse.Integer_Value( cursor, 382 );
      end if;
      if not gse.Is_Null( cursor, 383 )then
         a_benunit.debtfre3 := gse.Integer_Value( cursor, 383 );
      end if;
      if not gse.Is_Null( cursor, 384 )then
         a_benunit.endsmeet := gse.Integer_Value( cursor, 384 );
      end if;
      if not gse.Is_Null( cursor, 385 )then
         a_benunit.eucar := gse.Integer_Value( cursor, 385 );
      end if;
      if not gse.Is_Null( cursor, 386 )then
         a_benunit.eucarwhy := gse.Integer_Value( cursor, 386 );
      end if;
      if not gse.Is_Null( cursor, 387 )then
         a_benunit.euexpns := gse.Integer_Value( cursor, 387 );
      end if;
      if not gse.Is_Null( cursor, 388 )then
         a_benunit.eumeal := gse.Integer_Value( cursor, 388 );
      end if;
      if not gse.Is_Null( cursor, 389 )then
         a_benunit.eurepay := gse.Integer_Value( cursor, 389 );
      end if;
      if not gse.Is_Null( cursor, 390 )then
         a_benunit.euteleph := gse.Integer_Value( cursor, 390 );
      end if;
      if not gse.Is_Null( cursor, 391 )then
         a_benunit.eutelwhy := gse.Integer_Value( cursor, 391 );
      end if;
      if not gse.Is_Null( cursor, 392 )then
         a_benunit.expnsoa := gse.Integer_Value( cursor, 392 );
      end if;
      if not gse.Is_Null( cursor, 393 )then
         a_benunit.houshew := gse.Integer_Value( cursor, 393 );
      end if;
      if not gse.Is_Null( cursor, 394 )then
         a_benunit.noise := gse.Integer_Value( cursor, 394 );
      end if;
      if not gse.Is_Null( cursor, 395 )then
         a_benunit.oacareu1 := gse.Integer_Value( cursor, 395 );
      end if;
      if not gse.Is_Null( cursor, 396 )then
         a_benunit.oacareu2 := gse.Integer_Value( cursor, 396 );
      end if;
      if not gse.Is_Null( cursor, 397 )then
         a_benunit.oacareu3 := gse.Integer_Value( cursor, 397 );
      end if;
      if not gse.Is_Null( cursor, 398 )then
         a_benunit.oacareu4 := gse.Integer_Value( cursor, 398 );
      end if;
      if not gse.Is_Null( cursor, 399 )then
         a_benunit.oacareu5 := gse.Integer_Value( cursor, 399 );
      end if;
      if not gse.Is_Null( cursor, 400 )then
         a_benunit.oacareu6 := gse.Integer_Value( cursor, 400 );
      end if;
      if not gse.Is_Null( cursor, 401 )then
         a_benunit.oacareu7 := gse.Integer_Value( cursor, 401 );
      end if;
      if not gse.Is_Null( cursor, 402 )then
         a_benunit.oacareu8 := gse.Integer_Value( cursor, 402 );
      end if;
      if not gse.Is_Null( cursor, 403 )then
         a_benunit.oataxieu := gse.Integer_Value( cursor, 403 );
      end if;
      if not gse.Is_Null( cursor, 404 )then
         a_benunit.oatelep1 := gse.Integer_Value( cursor, 404 );
      end if;
      if not gse.Is_Null( cursor, 405 )then
         a_benunit.oatelep2 := gse.Integer_Value( cursor, 405 );
      end if;
      if not gse.Is_Null( cursor, 406 )then
         a_benunit.oatelep3 := gse.Integer_Value( cursor, 406 );
      end if;
      if not gse.Is_Null( cursor, 407 )then
         a_benunit.oatelep4 := gse.Integer_Value( cursor, 407 );
      end if;
      if not gse.Is_Null( cursor, 408 )then
         a_benunit.oatelep5 := gse.Integer_Value( cursor, 408 );
      end if;
      if not gse.Is_Null( cursor, 409 )then
         a_benunit.oatelep6 := gse.Integer_Value( cursor, 409 );
      end if;
      if not gse.Is_Null( cursor, 410 )then
         a_benunit.oatelep7 := gse.Integer_Value( cursor, 410 );
      end if;
      if not gse.Is_Null( cursor, 411 )then
         a_benunit.oatelep8 := gse.Integer_Value( cursor, 411 );
      end if;
      if not gse.Is_Null( cursor, 412 )then
         a_benunit.oateleph := gse.Integer_Value( cursor, 412 );
      end if;
      if not gse.Is_Null( cursor, 413 )then
         a_benunit.outpay := gse.Integer_Value( cursor, 413 );
      end if;
      if not gse.Is_Null( cursor, 414 )then
         a_benunit.outpyamt:= Amount'Value( gse.Value( cursor, 414 ));
      end if;
      if not gse.Is_Null( cursor, 415 )then
         a_benunit.pollute := gse.Integer_Value( cursor, 415 );
      end if;
      if not gse.Is_Null( cursor, 416 )then
         a_benunit.regpamt:= Amount'Value( gse.Value( cursor, 416 ));
      end if;
      if not gse.Is_Null( cursor, 417 )then
         a_benunit.regularp := gse.Integer_Value( cursor, 417 );
      end if;
      if not gse.Is_Null( cursor, 418 )then
         a_benunit.repaybur := gse.Integer_Value( cursor, 418 );
      end if;
      if not gse.Is_Null( cursor, 419 )then
         a_benunit.washmach := gse.Integer_Value( cursor, 419 );
      end if;
      if not gse.Is_Null( cursor, 420 )then
         a_benunit.washwhy := gse.Integer_Value( cursor, 420 );
      end if;
      if not gse.Is_Null( cursor, 421 )then
         a_benunit.whodepq := gse.Integer_Value( cursor, 421 );
      end if;
      if not gse.Is_Null( cursor, 422 )then
         a_benunit.discbua1 := gse.Integer_Value( cursor, 422 );
      end if;
      if not gse.Is_Null( cursor, 423 )then
         a_benunit.discbuc1 := gse.Integer_Value( cursor, 423 );
      end if;
      if not gse.Is_Null( cursor, 424 )then
         a_benunit.diswbua1 := gse.Integer_Value( cursor, 424 );
      end if;
      if not gse.Is_Null( cursor, 425 )then
         a_benunit.diswbuc1 := gse.Integer_Value( cursor, 425 );
      end if;
      if not gse.Is_Null( cursor, 426 )then
         a_benunit.fsfvbu:= Amount'Value( gse.Value( cursor, 426 ));
      end if;
      if not gse.Is_Null( cursor, 427 )then
         a_benunit.gross4 := gse.Integer_Value( cursor, 427 );
      end if;
      if not gse.Is_Null( cursor, 428 )then
         a_benunit.adles := gse.Integer_Value( cursor, 428 );
      end if;
      if not gse.Is_Null( cursor, 429 )then
         a_benunit.adlesnt1 := gse.Integer_Value( cursor, 429 );
      end if;
      if not gse.Is_Null( cursor, 430 )then
         a_benunit.adlesnt2 := gse.Integer_Value( cursor, 430 );
      end if;
      if not gse.Is_Null( cursor, 431 )then
         a_benunit.adlesnt3 := gse.Integer_Value( cursor, 431 );
      end if;
      if not gse.Is_Null( cursor, 432 )then
         a_benunit.adlesnt4 := gse.Integer_Value( cursor, 432 );
      end if;
      if not gse.Is_Null( cursor, 433 )then
         a_benunit.adlesnt5 := gse.Integer_Value( cursor, 433 );
      end if;
      if not gse.Is_Null( cursor, 434 )then
         a_benunit.adlesnt6 := gse.Integer_Value( cursor, 434 );
      end if;
      if not gse.Is_Null( cursor, 435 )then
         a_benunit.adlesnt7 := gse.Integer_Value( cursor, 435 );
      end if;
      if not gse.Is_Null( cursor, 436 )then
         a_benunit.adlesnt8 := gse.Integer_Value( cursor, 436 );
      end if;
      if not gse.Is_Null( cursor, 437 )then
         a_benunit.adlesoa := gse.Integer_Value( cursor, 437 );
      end if;
      if not gse.Is_Null( cursor, 438 )then
         a_benunit.clothes := gse.Integer_Value( cursor, 438 );
      end if;
      if not gse.Is_Null( cursor, 439 )then
         a_benunit.clothnt1 := gse.Integer_Value( cursor, 439 );
      end if;
      if not gse.Is_Null( cursor, 440 )then
         a_benunit.clothnt2 := gse.Integer_Value( cursor, 440 );
      end if;
      if not gse.Is_Null( cursor, 441 )then
         a_benunit.clothnt3 := gse.Integer_Value( cursor, 441 );
      end if;
      if not gse.Is_Null( cursor, 442 )then
         a_benunit.clothnt4 := gse.Integer_Value( cursor, 442 );
      end if;
      if not gse.Is_Null( cursor, 443 )then
         a_benunit.clothnt5 := gse.Integer_Value( cursor, 443 );
      end if;
      if not gse.Is_Null( cursor, 444 )then
         a_benunit.clothnt6 := gse.Integer_Value( cursor, 444 );
      end if;
      if not gse.Is_Null( cursor, 445 )then
         a_benunit.clothnt7 := gse.Integer_Value( cursor, 445 );
      end if;
      if not gse.Is_Null( cursor, 446 )then
         a_benunit.clothnt8 := gse.Integer_Value( cursor, 446 );
      end if;
      if not gse.Is_Null( cursor, 447 )then
         a_benunit.clothsoa := gse.Integer_Value( cursor, 447 );
      end if;
      if not gse.Is_Null( cursor, 448 )then
         a_benunit.furnt1 := gse.Integer_Value( cursor, 448 );
      end if;
      if not gse.Is_Null( cursor, 449 )then
         a_benunit.furnt2 := gse.Integer_Value( cursor, 449 );
      end if;
      if not gse.Is_Null( cursor, 450 )then
         a_benunit.furnt3 := gse.Integer_Value( cursor, 450 );
      end if;
      if not gse.Is_Null( cursor, 451 )then
         a_benunit.furnt4 := gse.Integer_Value( cursor, 451 );
      end if;
      if not gse.Is_Null( cursor, 452 )then
         a_benunit.furnt5 := gse.Integer_Value( cursor, 452 );
      end if;
      if not gse.Is_Null( cursor, 453 )then
         a_benunit.furnt6 := gse.Integer_Value( cursor, 453 );
      end if;
      if not gse.Is_Null( cursor, 454 )then
         a_benunit.furnt7 := gse.Integer_Value( cursor, 454 );
      end if;
      if not gse.Is_Null( cursor, 455 )then
         a_benunit.furnt8 := gse.Integer_Value( cursor, 455 );
      end if;
      if not gse.Is_Null( cursor, 456 )then
         a_benunit.intntnt1 := gse.Integer_Value( cursor, 456 );
      end if;
      if not gse.Is_Null( cursor, 457 )then
         a_benunit.intntnt2 := gse.Integer_Value( cursor, 457 );
      end if;
      if not gse.Is_Null( cursor, 458 )then
         a_benunit.intntnt3 := gse.Integer_Value( cursor, 458 );
      end if;
      if not gse.Is_Null( cursor, 459 )then
         a_benunit.intntnt4 := gse.Integer_Value( cursor, 459 );
      end if;
      if not gse.Is_Null( cursor, 460 )then
         a_benunit.intntnt5 := gse.Integer_Value( cursor, 460 );
      end if;
      if not gse.Is_Null( cursor, 461 )then
         a_benunit.intntnt6 := gse.Integer_Value( cursor, 461 );
      end if;
      if not gse.Is_Null( cursor, 462 )then
         a_benunit.intntnt7 := gse.Integer_Value( cursor, 462 );
      end if;
      if not gse.Is_Null( cursor, 463 )then
         a_benunit.intntnt8 := gse.Integer_Value( cursor, 463 );
      end if;
      if not gse.Is_Null( cursor, 464 )then
         a_benunit.intrnet := gse.Integer_Value( cursor, 464 );
      end if;
      if not gse.Is_Null( cursor, 465 )then
         a_benunit.meal := gse.Integer_Value( cursor, 465 );
      end if;
      if not gse.Is_Null( cursor, 466 )then
         a_benunit.oadep2 := gse.Integer_Value( cursor, 466 );
      end if;
      if not gse.Is_Null( cursor, 467 )then
         a_benunit.oadp2nt1 := gse.Integer_Value( cursor, 467 );
      end if;
      if not gse.Is_Null( cursor, 468 )then
         a_benunit.oadp2nt2 := gse.Integer_Value( cursor, 468 );
      end if;
      if not gse.Is_Null( cursor, 469 )then
         a_benunit.oadp2nt3 := gse.Integer_Value( cursor, 469 );
      end if;
      if not gse.Is_Null( cursor, 470 )then
         a_benunit.oadp2nt4 := gse.Integer_Value( cursor, 470 );
      end if;
      if not gse.Is_Null( cursor, 471 )then
         a_benunit.oadp2nt5 := gse.Integer_Value( cursor, 471 );
      end if;
      if not gse.Is_Null( cursor, 472 )then
         a_benunit.oadp2nt6 := gse.Integer_Value( cursor, 472 );
      end if;
      if not gse.Is_Null( cursor, 473 )then
         a_benunit.oadp2nt7 := gse.Integer_Value( cursor, 473 );
      end if;
      if not gse.Is_Null( cursor, 474 )then
         a_benunit.oadp2nt8 := gse.Integer_Value( cursor, 474 );
      end if;
      if not gse.Is_Null( cursor, 475 )then
         a_benunit.oafur := gse.Integer_Value( cursor, 475 );
      end if;
      if not gse.Is_Null( cursor, 476 )then
         a_benunit.oaintern := gse.Integer_Value( cursor, 476 );
      end if;
      if not gse.Is_Null( cursor, 477 )then
         a_benunit.shoe := gse.Integer_Value( cursor, 477 );
      end if;
      if not gse.Is_Null( cursor, 478 )then
         a_benunit.shoent1 := gse.Integer_Value( cursor, 478 );
      end if;
      if not gse.Is_Null( cursor, 479 )then
         a_benunit.shoent2 := gse.Integer_Value( cursor, 479 );
      end if;
      if not gse.Is_Null( cursor, 480 )then
         a_benunit.shoent3 := gse.Integer_Value( cursor, 480 );
      end if;
      if not gse.Is_Null( cursor, 481 )then
         a_benunit.shoent4 := gse.Integer_Value( cursor, 481 );
      end if;
      if not gse.Is_Null( cursor, 482 )then
         a_benunit.shoent5 := gse.Integer_Value( cursor, 482 );
      end if;
      if not gse.Is_Null( cursor, 483 )then
         a_benunit.shoent6 := gse.Integer_Value( cursor, 483 );
      end if;
      if not gse.Is_Null( cursor, 484 )then
         a_benunit.shoent7 := gse.Integer_Value( cursor, 484 );
      end if;
      if not gse.Is_Null( cursor, 485 )then
         a_benunit.shoent8 := gse.Integer_Value( cursor, 485 );
      end if;
      if not gse.Is_Null( cursor, 486 )then
         a_benunit.shoeoa := gse.Integer_Value( cursor, 486 );
      end if;
      if not gse.Is_Null( cursor, 487 )then
         a_benunit.nbunirbn := gse.Integer_Value( cursor, 487 );
      end if;
      if not gse.Is_Null( cursor, 488 )then
         a_benunit.nbuothbn := gse.Integer_Value( cursor, 488 );
      end if;
      if not gse.Is_Null( cursor, 489 )then
         a_benunit.debt13 := gse.Integer_Value( cursor, 489 );
      end if;
      if not gse.Is_Null( cursor, 490 )then
         a_benunit.debtar13 := gse.Integer_Value( cursor, 490 );
      end if;
      if not gse.Is_Null( cursor, 491 )then
         a_benunit.euchbook := gse.Integer_Value( cursor, 491 );
      end if;
      if not gse.Is_Null( cursor, 492 )then
         a_benunit.euchclth := gse.Integer_Value( cursor, 492 );
      end if;
      if not gse.Is_Null( cursor, 493 )then
         a_benunit.euchgame := gse.Integer_Value( cursor, 493 );
      end if;
      if not gse.Is_Null( cursor, 494 )then
         a_benunit.euchmeat := gse.Integer_Value( cursor, 494 );
      end if;
      if not gse.Is_Null( cursor, 495 )then
         a_benunit.euchshoe := gse.Integer_Value( cursor, 495 );
      end if;
      if not gse.Is_Null( cursor, 496 )then
         a_benunit.eupbtran := gse.Integer_Value( cursor, 496 );
      end if;
      if not gse.Is_Null( cursor, 497 )then
         a_benunit.eupbtrn1 := gse.Integer_Value( cursor, 497 );
      end if;
      if not gse.Is_Null( cursor, 498 )then
         a_benunit.eupbtrn2 := gse.Integer_Value( cursor, 498 );
      end if;
      if not gse.Is_Null( cursor, 499 )then
         a_benunit.eupbtrn3 := gse.Integer_Value( cursor, 499 );
      end if;
      if not gse.Is_Null( cursor, 500 )then
         a_benunit.eupbtrn4 := gse.Integer_Value( cursor, 500 );
      end if;
      if not gse.Is_Null( cursor, 501 )then
         a_benunit.eupbtrn5 := gse.Integer_Value( cursor, 501 );
      end if;
      if not gse.Is_Null( cursor, 502 )then
         a_benunit.euroast := gse.Integer_Value( cursor, 502 );
      end if;
      if not gse.Is_Null( cursor, 503 )then
         a_benunit.eusmeal := gse.Integer_Value( cursor, 503 );
      end if;
      if not gse.Is_Null( cursor, 504 )then
         a_benunit.eustudy := gse.Integer_Value( cursor, 504 );
      end if;
      if not gse.Is_Null( cursor, 505 )then
         a_benunit.bueth := gse.Integer_Value( cursor, 505 );
      end if;
      if not gse.Is_Null( cursor, 506 )then
         a_benunit.oaeusmea := gse.Integer_Value( cursor, 506 );
      end if;
      if not gse.Is_Null( cursor, 507 )then
         a_benunit.oaholb := gse.Integer_Value( cursor, 507 );
      end if;
      if not gse.Is_Null( cursor, 508 )then
         a_benunit.oaroast := gse.Integer_Value( cursor, 508 );
      end if;
      if not gse.Is_Null( cursor, 509 )then
         a_benunit.ecostab2 := gse.Integer_Value( cursor, 509 );
      end if;
      return a_benunit;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Benunit_List is
      l : Ukds.Frs.Benunit_List;
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
            a_benunit : Ukds.Frs.Benunit := Map_From_Cursor( cursor );
         begin
            l.append( a_benunit ); 
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
   
   procedure Update( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_benunit.incchnge ));
      params( 2 ) := "+"( Integer'Pos( a_benunit.inchilow ));
      params( 3 ) := "+"( Integer'Pos( a_benunit.kidinc ));
      params( 4 ) := "+"( Integer'Pos( a_benunit.nhhchild ));
      params( 5 ) := "+"( Integer'Pos( a_benunit.totsav ));
      params( 6 ) := "+"( Integer'Pos( a_benunit.month ));
      params( 7 ) := "+"( Integer'Pos( a_benunit.actaccb ));
      params( 8 ) := "+"( Integer'Pos( a_benunit.adddabu ));
      params( 9 ) := "+"( Integer'Pos( a_benunit.adultb ));
      params( 10 ) := "+"( Integer'Pos( a_benunit.basactb ));
      params( 11 ) := "+"( Float( a_benunit.boarder ));
      params( 12 ) := "+"( Float( a_benunit.bpeninc ));
      params( 13 ) := "+"( Float( a_benunit.bseinc ));
      params( 14 ) := "+"( Integer'Pos( a_benunit.buagegr2 ));
      params( 15 ) := "+"( Integer'Pos( a_benunit.buagegrp ));
      params( 16 ) := "+"( Integer'Pos( a_benunit.budisben ));
      params( 17 ) := "+"( Float( a_benunit.buearns ));
      params( 18 ) := "+"( Integer'Pos( a_benunit.buethgr2 ));
      params( 19 ) := "+"( Integer'Pos( a_benunit.buethgrp ));
      params( 20 ) := "+"( Integer'Pos( a_benunit.buinc ));
      params( 21 ) := "+"( Float( a_benunit.buinv ));
      params( 22 ) := "+"( Integer'Pos( a_benunit.buirben ));
      params( 23 ) := "+"( Integer'Pos( a_benunit.bukids ));
      params( 24 ) := "+"( Integer'Pos( a_benunit.bunirben ));
      params( 25 ) := "+"( Integer'Pos( a_benunit.buothben ));
      params( 26 ) := "+"( Integer'Pos( a_benunit.burent ));
      params( 27 ) := "+"( Float( a_benunit.burinc ));
      params( 28 ) := "+"( Float( a_benunit.burpinc ));
      params( 29 ) := "+"( Float( a_benunit.butvlic ));
      params( 30 ) := "+"( Float( a_benunit.butxcred ));
      params( 31 ) := "+"( Integer'Pos( a_benunit.chddabu ));
      params( 32 ) := "+"( Integer'Pos( a_benunit.curactb ));
      params( 33 ) := "+"( Integer'Pos( a_benunit.depchldb ));
      params( 34 ) := "+"( Integer'Pos( a_benunit.depdeds ));
      params( 35 ) := "+"( Integer'Pos( a_benunit.disindhb ));
      params( 36 ) := "+"( Integer'Pos( a_benunit.ecotypbu ));
      params( 37 ) := "+"( Integer'Pos( a_benunit.ecstatbu ));
      params( 38 ) := "+"( Integer'Pos( a_benunit.famthbai ));
      params( 39 ) := "+"( Integer'Pos( a_benunit.famtypbs ));
      params( 40 ) := "+"( Integer'Pos( a_benunit.famtypbu ));
      params( 41 ) := "+"( Integer'Pos( a_benunit.famtype ));
      params( 42 ) := "+"( Integer'Pos( a_benunit.fsbndctb ));
      params( 43 ) := "+"( Float( a_benunit.fsmbu ));
      params( 44 ) := "+"( Float( a_benunit.fsmlkbu ));
      params( 45 ) := "+"( Float( a_benunit.fwmlkbu ));
      params( 46 ) := "+"( Integer'Pos( a_benunit.gebactb ));
      params( 47 ) := "+"( Integer'Pos( a_benunit.giltctb ));
      params( 48 ) := "+"( Integer'Pos( a_benunit.gross2 ));
      params( 49 ) := "+"( Integer'Pos( a_benunit.gross3 ));
      params( 50 ) := "+"( Integer'Pos( a_benunit.hbindbu ));
      params( 51 ) := "+"( Integer'Pos( a_benunit.isactb ));
      params( 52 ) := "+"( Integer'Pos( a_benunit.kid04 ));
      params( 53 ) := "+"( Integer'Pos( a_benunit.kid1115 ));
      params( 54 ) := "+"( Integer'Pos( a_benunit.kid1618 ));
      params( 55 ) := "+"( Integer'Pos( a_benunit.kid510 ));
      params( 56 ) := "+"( Integer'Pos( a_benunit.kidsbu0 ));
      params( 57 ) := "+"( Integer'Pos( a_benunit.kidsbu1 ));
      params( 58 ) := "+"( Integer'Pos( a_benunit.kidsbu10 ));
      params( 59 ) := "+"( Integer'Pos( a_benunit.kidsbu11 ));
      params( 60 ) := "+"( Integer'Pos( a_benunit.kidsbu12 ));
      params( 61 ) := "+"( Integer'Pos( a_benunit.kidsbu13 ));
      params( 62 ) := "+"( Integer'Pos( a_benunit.kidsbu14 ));
      params( 63 ) := "+"( Integer'Pos( a_benunit.kidsbu15 ));
      params( 64 ) := "+"( Integer'Pos( a_benunit.kidsbu16 ));
      params( 65 ) := "+"( Integer'Pos( a_benunit.kidsbu17 ));
      params( 66 ) := "+"( Integer'Pos( a_benunit.kidsbu18 ));
      params( 67 ) := "+"( Integer'Pos( a_benunit.kidsbu2 ));
      params( 68 ) := "+"( Integer'Pos( a_benunit.kidsbu3 ));
      params( 69 ) := "+"( Integer'Pos( a_benunit.kidsbu4 ));
      params( 70 ) := "+"( Integer'Pos( a_benunit.kidsbu5 ));
      params( 71 ) := "+"( Integer'Pos( a_benunit.kidsbu6 ));
      params( 72 ) := "+"( Integer'Pos( a_benunit.kidsbu7 ));
      params( 73 ) := "+"( Integer'Pos( a_benunit.kidsbu8 ));
      params( 74 ) := "+"( Integer'Pos( a_benunit.kidsbu9 ));
      params( 75 ) := "+"( Integer'Pos( a_benunit.lastwork ));
      params( 76 ) := "+"( Float( a_benunit.lodger ));
      params( 77 ) := "+"( Integer'Pos( a_benunit.nsboctb ));
      params( 78 ) := "+"( Integer'Pos( a_benunit.otbsctb ));
      params( 79 ) := "+"( Integer'Pos( a_benunit.pepsctb ));
      params( 80 ) := "+"( Integer'Pos( a_benunit.poacctb ));
      params( 81 ) := "+"( Integer'Pos( a_benunit.prboctb ));
      params( 82 ) := "+"( Integer'Pos( a_benunit.sayectb ));
      params( 83 ) := "+"( Integer'Pos( a_benunit.sclbctb ));
      params( 84 ) := "+"( Integer'Pos( a_benunit.ssctb ));
      params( 85 ) := "+"( Integer'Pos( a_benunit.stshctb ));
      params( 86 ) := "+"( Float( a_benunit.subltamt ));
      params( 87 ) := "+"( Integer'Pos( a_benunit.tessctb ));
      params( 88 ) := "+"( Float( a_benunit.totcapbu ));
      params( 89 ) := "+"( Integer'Pos( a_benunit.totsavbu ));
      params( 90 ) := "+"( Float( a_benunit.tuburent ));
      params( 91 ) := "+"( Integer'Pos( a_benunit.untrctb ));
      params( 92 ) := "+"( Integer'Pos( a_benunit.youngch ));
      params( 93 ) := "+"( Integer'Pos( a_benunit.adddec ));
      params( 94 ) := "+"( Integer'Pos( a_benunit.addeples ));
      params( 95 ) := "+"( Integer'Pos( a_benunit.addhol ));
      params( 96 ) := "+"( Integer'Pos( a_benunit.addins ));
      params( 97 ) := "+"( Integer'Pos( a_benunit.addmel ));
      params( 98 ) := "+"( Integer'Pos( a_benunit.addmon ));
      params( 99 ) := "+"( Integer'Pos( a_benunit.addshoe ));
      params( 100 ) := "+"( Integer'Pos( a_benunit.adepfur ));
      params( 101 ) := "+"( Integer'Pos( a_benunit.af1 ));
      params( 102 ) := "+"( Integer'Pos( a_benunit.afdep2 ));
      params( 103 ) := "+"( Integer'Pos( a_benunit.cdelply ));
      params( 104 ) := "+"( Integer'Pos( a_benunit.cdepbed ));
      params( 105 ) := "+"( Integer'Pos( a_benunit.cdepcel ));
      params( 106 ) := "+"( Integer'Pos( a_benunit.cdepeqp ));
      params( 107 ) := "+"( Integer'Pos( a_benunit.cdephol ));
      params( 108 ) := "+"( Integer'Pos( a_benunit.cdeples ));
      params( 109 ) := "+"( Integer'Pos( a_benunit.cdepsum ));
      params( 110 ) := "+"( Integer'Pos( a_benunit.cdeptea ));
      params( 111 ) := "+"( Integer'Pos( a_benunit.cdeptrp ));
      params( 112 ) := "+"( Integer'Pos( a_benunit.cplay ));
      params( 113 ) := "+"( Integer'Pos( a_benunit.debt1 ));
      params( 114 ) := "+"( Integer'Pos( a_benunit.debt2 ));
      params( 115 ) := "+"( Integer'Pos( a_benunit.debt3 ));
      params( 116 ) := "+"( Integer'Pos( a_benunit.debt4 ));
      params( 117 ) := "+"( Integer'Pos( a_benunit.debt5 ));
      params( 118 ) := "+"( Integer'Pos( a_benunit.debt6 ));
      params( 119 ) := "+"( Integer'Pos( a_benunit.debt7 ));
      params( 120 ) := "+"( Integer'Pos( a_benunit.debt8 ));
      params( 121 ) := "+"( Integer'Pos( a_benunit.debt9 ));
      params( 122 ) := "+"( Integer'Pos( a_benunit.houshe1 ));
      params( 123 ) := "+"( Integer'Pos( a_benunit.incold ));
      params( 124 ) := "+"( Integer'Pos( a_benunit.crunacb ));
      params( 125 ) := "+"( Integer'Pos( a_benunit.enomortb ));
      params( 126 ) := "+"( Integer'Pos( a_benunit.hbindbu2 ));
      params( 127 ) := "+"( Integer'Pos( a_benunit.pocardb ));
      params( 128 ) := "+"( Integer'Pos( a_benunit.kid1619 ));
      params( 129 ) := "+"( Float( a_benunit.totcapb2 ));
      params( 130 ) := "+"( Integer'Pos( a_benunit.billnt1 ));
      params( 131 ) := "+"( Integer'Pos( a_benunit.billnt2 ));
      params( 132 ) := "+"( Integer'Pos( a_benunit.billnt3 ));
      params( 133 ) := "+"( Integer'Pos( a_benunit.billnt4 ));
      params( 134 ) := "+"( Integer'Pos( a_benunit.billnt5 ));
      params( 135 ) := "+"( Integer'Pos( a_benunit.billnt6 ));
      params( 136 ) := "+"( Integer'Pos( a_benunit.billnt7 ));
      params( 137 ) := "+"( Integer'Pos( a_benunit.billnt8 ));
      params( 138 ) := "+"( Integer'Pos( a_benunit.coatnt1 ));
      params( 139 ) := "+"( Integer'Pos( a_benunit.coatnt2 ));
      params( 140 ) := "+"( Integer'Pos( a_benunit.coatnt3 ));
      params( 141 ) := "+"( Integer'Pos( a_benunit.coatnt4 ));
      params( 142 ) := "+"( Integer'Pos( a_benunit.coatnt5 ));
      params( 143 ) := "+"( Integer'Pos( a_benunit.coatnt6 ));
      params( 144 ) := "+"( Integer'Pos( a_benunit.coatnt7 ));
      params( 145 ) := "+"( Integer'Pos( a_benunit.coatnt8 ));
      params( 146 ) := "+"( Integer'Pos( a_benunit.cooknt1 ));
      params( 147 ) := "+"( Integer'Pos( a_benunit.cooknt2 ));
      params( 148 ) := "+"( Integer'Pos( a_benunit.cooknt3 ));
      params( 149 ) := "+"( Integer'Pos( a_benunit.cooknt4 ));
      params( 150 ) := "+"( Integer'Pos( a_benunit.cooknt5 ));
      params( 151 ) := "+"( Integer'Pos( a_benunit.cooknt6 ));
      params( 152 ) := "+"( Integer'Pos( a_benunit.cooknt7 ));
      params( 153 ) := "+"( Integer'Pos( a_benunit.cooknt8 ));
      params( 154 ) := "+"( Integer'Pos( a_benunit.dampnt1 ));
      params( 155 ) := "+"( Integer'Pos( a_benunit.dampnt2 ));
      params( 156 ) := "+"( Integer'Pos( a_benunit.dampnt3 ));
      params( 157 ) := "+"( Integer'Pos( a_benunit.dampnt4 ));
      params( 158 ) := "+"( Integer'Pos( a_benunit.dampnt5 ));
      params( 159 ) := "+"( Integer'Pos( a_benunit.dampnt6 ));
      params( 160 ) := "+"( Integer'Pos( a_benunit.dampnt7 ));
      params( 161 ) := "+"( Integer'Pos( a_benunit.dampnt8 ));
      params( 162 ) := "+"( Integer'Pos( a_benunit.frndnt1 ));
      params( 163 ) := "+"( Integer'Pos( a_benunit.frndnt2 ));
      params( 164 ) := "+"( Integer'Pos( a_benunit.frndnt3 ));
      params( 165 ) := "+"( Integer'Pos( a_benunit.frndnt4 ));
      params( 166 ) := "+"( Integer'Pos( a_benunit.frndnt5 ));
      params( 167 ) := "+"( Integer'Pos( a_benunit.frndnt6 ));
      params( 168 ) := "+"( Integer'Pos( a_benunit.frndnt7 ));
      params( 169 ) := "+"( Integer'Pos( a_benunit.frndnt8 ));
      params( 170 ) := "+"( Integer'Pos( a_benunit.hairnt1 ));
      params( 171 ) := "+"( Integer'Pos( a_benunit.hairnt2 ));
      params( 172 ) := "+"( Integer'Pos( a_benunit.hairnt3 ));
      params( 173 ) := "+"( Integer'Pos( a_benunit.hairnt4 ));
      params( 174 ) := "+"( Integer'Pos( a_benunit.hairnt5 ));
      params( 175 ) := "+"( Integer'Pos( a_benunit.hairnt6 ));
      params( 176 ) := "+"( Integer'Pos( a_benunit.hairnt7 ));
      params( 177 ) := "+"( Integer'Pos( a_benunit.hairnt8 ));
      params( 178 ) := "+"( Integer'Pos( a_benunit.heatnt1 ));
      params( 179 ) := "+"( Integer'Pos( a_benunit.heatnt2 ));
      params( 180 ) := "+"( Integer'Pos( a_benunit.heatnt3 ));
      params( 181 ) := "+"( Integer'Pos( a_benunit.heatnt4 ));
      params( 182 ) := "+"( Integer'Pos( a_benunit.heatnt5 ));
      params( 183 ) := "+"( Integer'Pos( a_benunit.heatnt6 ));
      params( 184 ) := "+"( Integer'Pos( a_benunit.heatnt7 ));
      params( 185 ) := "+"( Integer'Pos( a_benunit.heatnt8 ));
      params( 186 ) := "+"( Integer'Pos( a_benunit.holnt1 ));
      params( 187 ) := "+"( Integer'Pos( a_benunit.holnt2 ));
      params( 188 ) := "+"( Integer'Pos( a_benunit.holnt3 ));
      params( 189 ) := "+"( Integer'Pos( a_benunit.holnt4 ));
      params( 190 ) := "+"( Integer'Pos( a_benunit.holnt5 ));
      params( 191 ) := "+"( Integer'Pos( a_benunit.holnt6 ));
      params( 192 ) := "+"( Integer'Pos( a_benunit.holnt7 ));
      params( 193 ) := "+"( Integer'Pos( a_benunit.holnt8 ));
      params( 194 ) := "+"( Integer'Pos( a_benunit.homent1 ));
      params( 195 ) := "+"( Integer'Pos( a_benunit.homent2 ));
      params( 196 ) := "+"( Integer'Pos( a_benunit.homent3 ));
      params( 197 ) := "+"( Integer'Pos( a_benunit.homent4 ));
      params( 198 ) := "+"( Integer'Pos( a_benunit.homent5 ));
      params( 199 ) := "+"( Integer'Pos( a_benunit.homent6 ));
      params( 200 ) := "+"( Integer'Pos( a_benunit.homent7 ));
      params( 201 ) := "+"( Integer'Pos( a_benunit.homent8 ));
      params( 202 ) := "+"( Integer'Pos( a_benunit.issue ));
      params( 203 ) := "+"( Integer'Pos( a_benunit.mealnt1 ));
      params( 204 ) := "+"( Integer'Pos( a_benunit.mealnt2 ));
      params( 205 ) := "+"( Integer'Pos( a_benunit.mealnt3 ));
      params( 206 ) := "+"( Integer'Pos( a_benunit.mealnt4 ));
      params( 207 ) := "+"( Integer'Pos( a_benunit.mealnt5 ));
      params( 208 ) := "+"( Integer'Pos( a_benunit.mealnt6 ));
      params( 209 ) := "+"( Integer'Pos( a_benunit.mealnt7 ));
      params( 210 ) := "+"( Integer'Pos( a_benunit.mealnt8 ));
      params( 211 ) := "+"( Integer'Pos( a_benunit.oabill ));
      params( 212 ) := "+"( Integer'Pos( a_benunit.oacoat ));
      params( 213 ) := "+"( Integer'Pos( a_benunit.oacook ));
      params( 214 ) := "+"( Integer'Pos( a_benunit.oadamp ));
      params( 215 ) := "+"( Integer'Pos( a_benunit.oaexpns ));
      params( 216 ) := "+"( Integer'Pos( a_benunit.oafrnd ));
      params( 217 ) := "+"( Integer'Pos( a_benunit.oahair ));
      params( 218 ) := "+"( Integer'Pos( a_benunit.oaheat ));
      params( 219 ) := "+"( Integer'Pos( a_benunit.oahol ));
      params( 220 ) := "+"( Integer'Pos( a_benunit.oahome ));
      params( 221 ) := "+"( Integer'Pos( a_benunit.oahowpy1 ));
      params( 222 ) := "+"( Integer'Pos( a_benunit.oahowpy2 ));
      params( 223 ) := "+"( Integer'Pos( a_benunit.oahowpy3 ));
      params( 224 ) := "+"( Integer'Pos( a_benunit.oahowpy4 ));
      params( 225 ) := "+"( Integer'Pos( a_benunit.oahowpy5 ));
      params( 226 ) := "+"( Integer'Pos( a_benunit.oahowpy6 ));
      params( 227 ) := "+"( Integer'Pos( a_benunit.oameal ));
      params( 228 ) := "+"( Integer'Pos( a_benunit.oaout ));
      params( 229 ) := "+"( Integer'Pos( a_benunit.oaphon ));
      params( 230 ) := "+"( Integer'Pos( a_benunit.oataxi ));
      params( 231 ) := "+"( Integer'Pos( a_benunit.oawarm ));
      params( 232 ) := "+"( Integer'Pos( a_benunit.outnt1 ));
      params( 233 ) := "+"( Integer'Pos( a_benunit.outnt2 ));
      params( 234 ) := "+"( Integer'Pos( a_benunit.outnt3 ));
      params( 235 ) := "+"( Integer'Pos( a_benunit.outnt4 ));
      params( 236 ) := "+"( Integer'Pos( a_benunit.outnt5 ));
      params( 237 ) := "+"( Integer'Pos( a_benunit.outnt6 ));
      params( 238 ) := "+"( Integer'Pos( a_benunit.outnt7 ));
      params( 239 ) := "+"( Integer'Pos( a_benunit.outnt8 ));
      params( 240 ) := "+"( Integer'Pos( a_benunit.phonnt1 ));
      params( 241 ) := "+"( Integer'Pos( a_benunit.phonnt2 ));
      params( 242 ) := "+"( Integer'Pos( a_benunit.phonnt3 ));
      params( 243 ) := "+"( Integer'Pos( a_benunit.phonnt4 ));
      params( 244 ) := "+"( Integer'Pos( a_benunit.phonnt5 ));
      params( 245 ) := "+"( Integer'Pos( a_benunit.phonnt6 ));
      params( 246 ) := "+"( Integer'Pos( a_benunit.phonnt7 ));
      params( 247 ) := "+"( Integer'Pos( a_benunit.phonnt8 ));
      params( 248 ) := "+"( Integer'Pos( a_benunit.taxint1 ));
      params( 249 ) := "+"( Integer'Pos( a_benunit.taxint2 ));
      params( 250 ) := "+"( Integer'Pos( a_benunit.taxint3 ));
      params( 251 ) := "+"( Integer'Pos( a_benunit.taxint4 ));
      params( 252 ) := "+"( Integer'Pos( a_benunit.taxint5 ));
      params( 253 ) := "+"( Integer'Pos( a_benunit.taxint6 ));
      params( 254 ) := "+"( Integer'Pos( a_benunit.taxint7 ));
      params( 255 ) := "+"( Integer'Pos( a_benunit.taxint8 ));
      params( 256 ) := "+"( Integer'Pos( a_benunit.warmnt1 ));
      params( 257 ) := "+"( Integer'Pos( a_benunit.warmnt2 ));
      params( 258 ) := "+"( Integer'Pos( a_benunit.warmnt3 ));
      params( 259 ) := "+"( Integer'Pos( a_benunit.warmnt4 ));
      params( 260 ) := "+"( Integer'Pos( a_benunit.warmnt5 ));
      params( 261 ) := "+"( Integer'Pos( a_benunit.warmnt6 ));
      params( 262 ) := "+"( Integer'Pos( a_benunit.warmnt7 ));
      params( 263 ) := "+"( Integer'Pos( a_benunit.warmnt8 ));
      params( 264 ) := "+"( Integer'Pos( a_benunit.buagegr3 ));
      params( 265 ) := "+"( Integer'Pos( a_benunit.buagegr4 ));
      params( 266 ) := "+"( Float( a_benunit.heartbu ));
      params( 267 ) := "+"( Integer'Pos( a_benunit.newfambu ));
      params( 268 ) := "+"( Integer'Pos( a_benunit.billnt9 ));
      params( 269 ) := "+"( Integer'Pos( a_benunit.cbaamt1 ));
      params( 270 ) := "+"( Integer'Pos( a_benunit.cbaamt2 ));
      params( 271 ) := "+"( Integer'Pos( a_benunit.coatnt9 ));
      params( 272 ) := "+"( Integer'Pos( a_benunit.cooknt9 ));
      params( 273 ) := "+"( Integer'Pos( a_benunit.dampnt9 ));
      params( 274 ) := "+"( Integer'Pos( a_benunit.frndnt9 ));
      params( 275 ) := "+"( Integer'Pos( a_benunit.hairnt9 ));
      params( 276 ) := "+"( Integer'Pos( a_benunit.hbolng ));
      params( 277 ) := "+"( Float( a_benunit.hbothamt ));
      params( 278 ) := "+"( Integer'Pos( a_benunit.hbothbu ));
      params( 279 ) := "+"( Integer'Pos( a_benunit.hbothmn ));
      params( 280 ) := "+"( Integer'Pos( a_benunit.hbothpd ));
      params( 281 ) := "+"( Integer'Pos( a_benunit.hbothwk ));
      params( 282 ) := "+"( Integer'Pos( a_benunit.hbothyr ));
      params( 283 ) := "+"( Integer'Pos( a_benunit.hbotwait ));
      params( 284 ) := "+"( Integer'Pos( a_benunit.heatnt9 ));
      params( 285 ) := "+"( Integer'Pos( a_benunit.helpgv01 ));
      params( 286 ) := "+"( Integer'Pos( a_benunit.helpgv02 ));
      params( 287 ) := "+"( Integer'Pos( a_benunit.helpgv03 ));
      params( 288 ) := "+"( Integer'Pos( a_benunit.helpgv04 ));
      params( 289 ) := "+"( Integer'Pos( a_benunit.helpgv05 ));
      params( 290 ) := "+"( Integer'Pos( a_benunit.helpgv06 ));
      params( 291 ) := "+"( Integer'Pos( a_benunit.helpgv07 ));
      params( 292 ) := "+"( Integer'Pos( a_benunit.helpgv08 ));
      params( 293 ) := "+"( Integer'Pos( a_benunit.helpgv09 ));
      params( 294 ) := "+"( Integer'Pos( a_benunit.helpgv10 ));
      params( 295 ) := "+"( Integer'Pos( a_benunit.helpgv11 ));
      params( 296 ) := "+"( Integer'Pos( a_benunit.helprc01 ));
      params( 297 ) := "+"( Integer'Pos( a_benunit.helprc02 ));
      params( 298 ) := "+"( Integer'Pos( a_benunit.helprc03 ));
      params( 299 ) := "+"( Integer'Pos( a_benunit.helprc04 ));
      params( 300 ) := "+"( Integer'Pos( a_benunit.helprc05 ));
      params( 301 ) := "+"( Integer'Pos( a_benunit.helprc06 ));
      params( 302 ) := "+"( Integer'Pos( a_benunit.helprc07 ));
      params( 303 ) := "+"( Integer'Pos( a_benunit.helprc08 ));
      params( 304 ) := "+"( Integer'Pos( a_benunit.helprc09 ));
      params( 305 ) := "+"( Integer'Pos( a_benunit.helprc10 ));
      params( 306 ) := "+"( Integer'Pos( a_benunit.helprc11 ));
      params( 307 ) := "+"( Integer'Pos( a_benunit.holnt9 ));
      params( 308 ) := "+"( Integer'Pos( a_benunit.homent9 ));
      params( 309 ) := "+"( Integer'Pos( a_benunit.loangvn1 ));
      params( 310 ) := "+"( Integer'Pos( a_benunit.loangvn2 ));
      params( 311 ) := "+"( Integer'Pos( a_benunit.loangvn3 ));
      params( 312 ) := "+"( Integer'Pos( a_benunit.loanrec1 ));
      params( 313 ) := "+"( Integer'Pos( a_benunit.loanrec2 ));
      params( 314 ) := "+"( Integer'Pos( a_benunit.loanrec3 ));
      params( 315 ) := "+"( Integer'Pos( a_benunit.mealnt9 ));
      params( 316 ) := "+"( Integer'Pos( a_benunit.outnt9 ));
      params( 317 ) := "+"( Integer'Pos( a_benunit.phonnt9 ));
      params( 318 ) := "+"( Integer'Pos( a_benunit.taxint9 ));
      params( 319 ) := "+"( Integer'Pos( a_benunit.warmnt9 ));
      params( 320 ) := "+"( Integer'Pos( a_benunit.ecostabu ));
      params( 321 ) := "+"( Integer'Pos( a_benunit.famtypb2 ));
      params( 322 ) := "+"( Integer'Pos( a_benunit.gross3_x ));
      params( 323 ) := "+"( Integer'Pos( a_benunit.newfamb2 ));
      params( 324 ) := "+"( Integer'Pos( a_benunit.oabilimp ));
      params( 325 ) := "+"( Integer'Pos( a_benunit.oacoaimp ));
      params( 326 ) := "+"( Integer'Pos( a_benunit.oacooimp ));
      params( 327 ) := "+"( Integer'Pos( a_benunit.oadamimp ));
      params( 328 ) := "+"( Integer'Pos( a_benunit.oaexpimp ));
      params( 329 ) := "+"( Integer'Pos( a_benunit.oafrnimp ));
      params( 330 ) := "+"( Integer'Pos( a_benunit.oahaiimp ));
      params( 331 ) := "+"( Integer'Pos( a_benunit.oaheaimp ));
      params( 332 ) := "+"( Integer'Pos( a_benunit.oaholimp ));
      params( 333 ) := "+"( Integer'Pos( a_benunit.oahomimp ));
      params( 334 ) := "+"( Integer'Pos( a_benunit.oameaimp ));
      params( 335 ) := "+"( Integer'Pos( a_benunit.oaoutimp ));
      params( 336 ) := "+"( Integer'Pos( a_benunit.oaphoimp ));
      params( 337 ) := "+"( Integer'Pos( a_benunit.oataximp ));
      params( 338 ) := "+"( Integer'Pos( a_benunit.oawarimp ));
      params( 339 ) := "+"( Float( a_benunit.totcapb3 ));
      params( 340 ) := "+"( Integer'Pos( a_benunit.adbtbl ));
      params( 341 ) := "+"( Integer'Pos( a_benunit.cdepact ));
      params( 342 ) := "+"( Integer'Pos( a_benunit.cdepveg ));
      params( 343 ) := "+"( Integer'Pos( a_benunit.cdpcoat ));
      params( 344 ) := "+"( Integer'Pos( a_benunit.oapre ));
      params( 345 ) := "+"( Integer'Pos( a_benunit.buethgr3 ));
      params( 346 ) := "+"( Float( a_benunit.fsbbu ));
      params( 347 ) := "+"( Integer'Pos( a_benunit.addholr ));
      params( 348 ) := "+"( Integer'Pos( a_benunit.computer ));
      params( 349 ) := "+"( Integer'Pos( a_benunit.compuwhy ));
      params( 350 ) := "+"( Integer'Pos( a_benunit.crime ));
      params( 351 ) := "+"( Integer'Pos( a_benunit.damp ));
      params( 352 ) := "+"( Integer'Pos( a_benunit.dark ));
      params( 353 ) := "+"( Integer'Pos( a_benunit.debt01 ));
      params( 354 ) := "+"( Integer'Pos( a_benunit.debt02 ));
      params( 355 ) := "+"( Integer'Pos( a_benunit.debt03 ));
      params( 356 ) := "+"( Integer'Pos( a_benunit.debt04 ));
      params( 357 ) := "+"( Integer'Pos( a_benunit.debt05 ));
      params( 358 ) := "+"( Integer'Pos( a_benunit.debt06 ));
      params( 359 ) := "+"( Integer'Pos( a_benunit.debt07 ));
      params( 360 ) := "+"( Integer'Pos( a_benunit.debt08 ));
      params( 361 ) := "+"( Integer'Pos( a_benunit.debt09 ));
      params( 362 ) := "+"( Integer'Pos( a_benunit.debt10 ));
      params( 363 ) := "+"( Integer'Pos( a_benunit.debt11 ));
      params( 364 ) := "+"( Integer'Pos( a_benunit.debt12 ));
      params( 365 ) := "+"( Integer'Pos( a_benunit.debtar01 ));
      params( 366 ) := "+"( Integer'Pos( a_benunit.debtar02 ));
      params( 367 ) := "+"( Integer'Pos( a_benunit.debtar03 ));
      params( 368 ) := "+"( Integer'Pos( a_benunit.debtar04 ));
      params( 369 ) := "+"( Integer'Pos( a_benunit.debtar05 ));
      params( 370 ) := "+"( Integer'Pos( a_benunit.debtar06 ));
      params( 371 ) := "+"( Integer'Pos( a_benunit.debtar07 ));
      params( 372 ) := "+"( Integer'Pos( a_benunit.debtar08 ));
      params( 373 ) := "+"( Integer'Pos( a_benunit.debtar09 ));
      params( 374 ) := "+"( Integer'Pos( a_benunit.debtar10 ));
      params( 375 ) := "+"( Integer'Pos( a_benunit.debtar11 ));
      params( 376 ) := "+"( Integer'Pos( a_benunit.debtar12 ));
      params( 377 ) := "+"( Integer'Pos( a_benunit.debtfre1 ));
      params( 378 ) := "+"( Integer'Pos( a_benunit.debtfre2 ));
      params( 379 ) := "+"( Integer'Pos( a_benunit.debtfre3 ));
      params( 380 ) := "+"( Integer'Pos( a_benunit.endsmeet ));
      params( 381 ) := "+"( Integer'Pos( a_benunit.eucar ));
      params( 382 ) := "+"( Integer'Pos( a_benunit.eucarwhy ));
      params( 383 ) := "+"( Integer'Pos( a_benunit.euexpns ));
      params( 384 ) := "+"( Integer'Pos( a_benunit.eumeal ));
      params( 385 ) := "+"( Integer'Pos( a_benunit.eurepay ));
      params( 386 ) := "+"( Integer'Pos( a_benunit.euteleph ));
      params( 387 ) := "+"( Integer'Pos( a_benunit.eutelwhy ));
      params( 388 ) := "+"( Integer'Pos( a_benunit.expnsoa ));
      params( 389 ) := "+"( Integer'Pos( a_benunit.houshew ));
      params( 390 ) := "+"( Integer'Pos( a_benunit.noise ));
      params( 391 ) := "+"( Integer'Pos( a_benunit.oacareu1 ));
      params( 392 ) := "+"( Integer'Pos( a_benunit.oacareu2 ));
      params( 393 ) := "+"( Integer'Pos( a_benunit.oacareu3 ));
      params( 394 ) := "+"( Integer'Pos( a_benunit.oacareu4 ));
      params( 395 ) := "+"( Integer'Pos( a_benunit.oacareu5 ));
      params( 396 ) := "+"( Integer'Pos( a_benunit.oacareu6 ));
      params( 397 ) := "+"( Integer'Pos( a_benunit.oacareu7 ));
      params( 398 ) := "+"( Integer'Pos( a_benunit.oacareu8 ));
      params( 399 ) := "+"( Integer'Pos( a_benunit.oataxieu ));
      params( 400 ) := "+"( Integer'Pos( a_benunit.oatelep1 ));
      params( 401 ) := "+"( Integer'Pos( a_benunit.oatelep2 ));
      params( 402 ) := "+"( Integer'Pos( a_benunit.oatelep3 ));
      params( 403 ) := "+"( Integer'Pos( a_benunit.oatelep4 ));
      params( 404 ) := "+"( Integer'Pos( a_benunit.oatelep5 ));
      params( 405 ) := "+"( Integer'Pos( a_benunit.oatelep6 ));
      params( 406 ) := "+"( Integer'Pos( a_benunit.oatelep7 ));
      params( 407 ) := "+"( Integer'Pos( a_benunit.oatelep8 ));
      params( 408 ) := "+"( Integer'Pos( a_benunit.oateleph ));
      params( 409 ) := "+"( Integer'Pos( a_benunit.outpay ));
      params( 410 ) := "+"( Float( a_benunit.outpyamt ));
      params( 411 ) := "+"( Integer'Pos( a_benunit.pollute ));
      params( 412 ) := "+"( Float( a_benunit.regpamt ));
      params( 413 ) := "+"( Integer'Pos( a_benunit.regularp ));
      params( 414 ) := "+"( Integer'Pos( a_benunit.repaybur ));
      params( 415 ) := "+"( Integer'Pos( a_benunit.washmach ));
      params( 416 ) := "+"( Integer'Pos( a_benunit.washwhy ));
      params( 417 ) := "+"( Integer'Pos( a_benunit.whodepq ));
      params( 418 ) := "+"( Integer'Pos( a_benunit.discbua1 ));
      params( 419 ) := "+"( Integer'Pos( a_benunit.discbuc1 ));
      params( 420 ) := "+"( Integer'Pos( a_benunit.diswbua1 ));
      params( 421 ) := "+"( Integer'Pos( a_benunit.diswbuc1 ));
      params( 422 ) := "+"( Float( a_benunit.fsfvbu ));
      params( 423 ) := "+"( Integer'Pos( a_benunit.gross4 ));
      params( 424 ) := "+"( Integer'Pos( a_benunit.adles ));
      params( 425 ) := "+"( Integer'Pos( a_benunit.adlesnt1 ));
      params( 426 ) := "+"( Integer'Pos( a_benunit.adlesnt2 ));
      params( 427 ) := "+"( Integer'Pos( a_benunit.adlesnt3 ));
      params( 428 ) := "+"( Integer'Pos( a_benunit.adlesnt4 ));
      params( 429 ) := "+"( Integer'Pos( a_benunit.adlesnt5 ));
      params( 430 ) := "+"( Integer'Pos( a_benunit.adlesnt6 ));
      params( 431 ) := "+"( Integer'Pos( a_benunit.adlesnt7 ));
      params( 432 ) := "+"( Integer'Pos( a_benunit.adlesnt8 ));
      params( 433 ) := "+"( Integer'Pos( a_benunit.adlesoa ));
      params( 434 ) := "+"( Integer'Pos( a_benunit.clothes ));
      params( 435 ) := "+"( Integer'Pos( a_benunit.clothnt1 ));
      params( 436 ) := "+"( Integer'Pos( a_benunit.clothnt2 ));
      params( 437 ) := "+"( Integer'Pos( a_benunit.clothnt3 ));
      params( 438 ) := "+"( Integer'Pos( a_benunit.clothnt4 ));
      params( 439 ) := "+"( Integer'Pos( a_benunit.clothnt5 ));
      params( 440 ) := "+"( Integer'Pos( a_benunit.clothnt6 ));
      params( 441 ) := "+"( Integer'Pos( a_benunit.clothnt7 ));
      params( 442 ) := "+"( Integer'Pos( a_benunit.clothnt8 ));
      params( 443 ) := "+"( Integer'Pos( a_benunit.clothsoa ));
      params( 444 ) := "+"( Integer'Pos( a_benunit.furnt1 ));
      params( 445 ) := "+"( Integer'Pos( a_benunit.furnt2 ));
      params( 446 ) := "+"( Integer'Pos( a_benunit.furnt3 ));
      params( 447 ) := "+"( Integer'Pos( a_benunit.furnt4 ));
      params( 448 ) := "+"( Integer'Pos( a_benunit.furnt5 ));
      params( 449 ) := "+"( Integer'Pos( a_benunit.furnt6 ));
      params( 450 ) := "+"( Integer'Pos( a_benunit.furnt7 ));
      params( 451 ) := "+"( Integer'Pos( a_benunit.furnt8 ));
      params( 452 ) := "+"( Integer'Pos( a_benunit.intntnt1 ));
      params( 453 ) := "+"( Integer'Pos( a_benunit.intntnt2 ));
      params( 454 ) := "+"( Integer'Pos( a_benunit.intntnt3 ));
      params( 455 ) := "+"( Integer'Pos( a_benunit.intntnt4 ));
      params( 456 ) := "+"( Integer'Pos( a_benunit.intntnt5 ));
      params( 457 ) := "+"( Integer'Pos( a_benunit.intntnt6 ));
      params( 458 ) := "+"( Integer'Pos( a_benunit.intntnt7 ));
      params( 459 ) := "+"( Integer'Pos( a_benunit.intntnt8 ));
      params( 460 ) := "+"( Integer'Pos( a_benunit.intrnet ));
      params( 461 ) := "+"( Integer'Pos( a_benunit.meal ));
      params( 462 ) := "+"( Integer'Pos( a_benunit.oadep2 ));
      params( 463 ) := "+"( Integer'Pos( a_benunit.oadp2nt1 ));
      params( 464 ) := "+"( Integer'Pos( a_benunit.oadp2nt2 ));
      params( 465 ) := "+"( Integer'Pos( a_benunit.oadp2nt3 ));
      params( 466 ) := "+"( Integer'Pos( a_benunit.oadp2nt4 ));
      params( 467 ) := "+"( Integer'Pos( a_benunit.oadp2nt5 ));
      params( 468 ) := "+"( Integer'Pos( a_benunit.oadp2nt6 ));
      params( 469 ) := "+"( Integer'Pos( a_benunit.oadp2nt7 ));
      params( 470 ) := "+"( Integer'Pos( a_benunit.oadp2nt8 ));
      params( 471 ) := "+"( Integer'Pos( a_benunit.oafur ));
      params( 472 ) := "+"( Integer'Pos( a_benunit.oaintern ));
      params( 473 ) := "+"( Integer'Pos( a_benunit.shoe ));
      params( 474 ) := "+"( Integer'Pos( a_benunit.shoent1 ));
      params( 475 ) := "+"( Integer'Pos( a_benunit.shoent2 ));
      params( 476 ) := "+"( Integer'Pos( a_benunit.shoent3 ));
      params( 477 ) := "+"( Integer'Pos( a_benunit.shoent4 ));
      params( 478 ) := "+"( Integer'Pos( a_benunit.shoent5 ));
      params( 479 ) := "+"( Integer'Pos( a_benunit.shoent6 ));
      params( 480 ) := "+"( Integer'Pos( a_benunit.shoent7 ));
      params( 481 ) := "+"( Integer'Pos( a_benunit.shoent8 ));
      params( 482 ) := "+"( Integer'Pos( a_benunit.shoeoa ));
      params( 483 ) := "+"( Integer'Pos( a_benunit.nbunirbn ));
      params( 484 ) := "+"( Integer'Pos( a_benunit.nbuothbn ));
      params( 485 ) := "+"( Integer'Pos( a_benunit.debt13 ));
      params( 486 ) := "+"( Integer'Pos( a_benunit.debtar13 ));
      params( 487 ) := "+"( Integer'Pos( a_benunit.euchbook ));
      params( 488 ) := "+"( Integer'Pos( a_benunit.euchclth ));
      params( 489 ) := "+"( Integer'Pos( a_benunit.euchgame ));
      params( 490 ) := "+"( Integer'Pos( a_benunit.euchmeat ));
      params( 491 ) := "+"( Integer'Pos( a_benunit.euchshoe ));
      params( 492 ) := "+"( Integer'Pos( a_benunit.eupbtran ));
      params( 493 ) := "+"( Integer'Pos( a_benunit.eupbtrn1 ));
      params( 494 ) := "+"( Integer'Pos( a_benunit.eupbtrn2 ));
      params( 495 ) := "+"( Integer'Pos( a_benunit.eupbtrn3 ));
      params( 496 ) := "+"( Integer'Pos( a_benunit.eupbtrn4 ));
      params( 497 ) := "+"( Integer'Pos( a_benunit.eupbtrn5 ));
      params( 498 ) := "+"( Integer'Pos( a_benunit.euroast ));
      params( 499 ) := "+"( Integer'Pos( a_benunit.eusmeal ));
      params( 500 ) := "+"( Integer'Pos( a_benunit.eustudy ));
      params( 501 ) := "+"( Integer'Pos( a_benunit.bueth ));
      params( 502 ) := "+"( Integer'Pos( a_benunit.oaeusmea ));
      params( 503 ) := "+"( Integer'Pos( a_benunit.oaholb ));
      params( 504 ) := "+"( Integer'Pos( a_benunit.oaroast ));
      params( 505 ) := "+"( Integer'Pos( a_benunit.ecostab2 ));
      params( 506 ) := "+"( Integer'Pos( a_benunit.user_id ));
      params( 507 ) := "+"( Integer'Pos( a_benunit.edition ));
      params( 508 ) := "+"( Integer'Pos( a_benunit.year ));
      params( 509 ) := As_Bigint( a_benunit.sernum );
      params( 510 ) := "+"( Integer'Pos( a_benunit.benunit ));
      
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

   procedure Save( a_benunit : Ukds.Frs.Benunit; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_benunit.user_id, a_benunit.edition, a_benunit.year, a_benunit.sernum, a_benunit.benunit ) then
         Update( a_benunit, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_benunit.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_benunit.edition ));
      params( 3 ) := "+"( Integer'Pos( a_benunit.year ));
      params( 4 ) := As_Bigint( a_benunit.sernum );
      params( 5 ) := "+"( Integer'Pos( a_benunit.benunit ));
      params( 6 ) := "+"( Integer'Pos( a_benunit.incchnge ));
      params( 7 ) := "+"( Integer'Pos( a_benunit.inchilow ));
      params( 8 ) := "+"( Integer'Pos( a_benunit.kidinc ));
      params( 9 ) := "+"( Integer'Pos( a_benunit.nhhchild ));
      params( 10 ) := "+"( Integer'Pos( a_benunit.totsav ));
      params( 11 ) := "+"( Integer'Pos( a_benunit.month ));
      params( 12 ) := "+"( Integer'Pos( a_benunit.actaccb ));
      params( 13 ) := "+"( Integer'Pos( a_benunit.adddabu ));
      params( 14 ) := "+"( Integer'Pos( a_benunit.adultb ));
      params( 15 ) := "+"( Integer'Pos( a_benunit.basactb ));
      params( 16 ) := "+"( Float( a_benunit.boarder ));
      params( 17 ) := "+"( Float( a_benunit.bpeninc ));
      params( 18 ) := "+"( Float( a_benunit.bseinc ));
      params( 19 ) := "+"( Integer'Pos( a_benunit.buagegr2 ));
      params( 20 ) := "+"( Integer'Pos( a_benunit.buagegrp ));
      params( 21 ) := "+"( Integer'Pos( a_benunit.budisben ));
      params( 22 ) := "+"( Float( a_benunit.buearns ));
      params( 23 ) := "+"( Integer'Pos( a_benunit.buethgr2 ));
      params( 24 ) := "+"( Integer'Pos( a_benunit.buethgrp ));
      params( 25 ) := "+"( Integer'Pos( a_benunit.buinc ));
      params( 26 ) := "+"( Float( a_benunit.buinv ));
      params( 27 ) := "+"( Integer'Pos( a_benunit.buirben ));
      params( 28 ) := "+"( Integer'Pos( a_benunit.bukids ));
      params( 29 ) := "+"( Integer'Pos( a_benunit.bunirben ));
      params( 30 ) := "+"( Integer'Pos( a_benunit.buothben ));
      params( 31 ) := "+"( Integer'Pos( a_benunit.burent ));
      params( 32 ) := "+"( Float( a_benunit.burinc ));
      params( 33 ) := "+"( Float( a_benunit.burpinc ));
      params( 34 ) := "+"( Float( a_benunit.butvlic ));
      params( 35 ) := "+"( Float( a_benunit.butxcred ));
      params( 36 ) := "+"( Integer'Pos( a_benunit.chddabu ));
      params( 37 ) := "+"( Integer'Pos( a_benunit.curactb ));
      params( 38 ) := "+"( Integer'Pos( a_benunit.depchldb ));
      params( 39 ) := "+"( Integer'Pos( a_benunit.depdeds ));
      params( 40 ) := "+"( Integer'Pos( a_benunit.disindhb ));
      params( 41 ) := "+"( Integer'Pos( a_benunit.ecotypbu ));
      params( 42 ) := "+"( Integer'Pos( a_benunit.ecstatbu ));
      params( 43 ) := "+"( Integer'Pos( a_benunit.famthbai ));
      params( 44 ) := "+"( Integer'Pos( a_benunit.famtypbs ));
      params( 45 ) := "+"( Integer'Pos( a_benunit.famtypbu ));
      params( 46 ) := "+"( Integer'Pos( a_benunit.famtype ));
      params( 47 ) := "+"( Integer'Pos( a_benunit.fsbndctb ));
      params( 48 ) := "+"( Float( a_benunit.fsmbu ));
      params( 49 ) := "+"( Float( a_benunit.fsmlkbu ));
      params( 50 ) := "+"( Float( a_benunit.fwmlkbu ));
      params( 51 ) := "+"( Integer'Pos( a_benunit.gebactb ));
      params( 52 ) := "+"( Integer'Pos( a_benunit.giltctb ));
      params( 53 ) := "+"( Integer'Pos( a_benunit.gross2 ));
      params( 54 ) := "+"( Integer'Pos( a_benunit.gross3 ));
      params( 55 ) := "+"( Integer'Pos( a_benunit.hbindbu ));
      params( 56 ) := "+"( Integer'Pos( a_benunit.isactb ));
      params( 57 ) := "+"( Integer'Pos( a_benunit.kid04 ));
      params( 58 ) := "+"( Integer'Pos( a_benunit.kid1115 ));
      params( 59 ) := "+"( Integer'Pos( a_benunit.kid1618 ));
      params( 60 ) := "+"( Integer'Pos( a_benunit.kid510 ));
      params( 61 ) := "+"( Integer'Pos( a_benunit.kidsbu0 ));
      params( 62 ) := "+"( Integer'Pos( a_benunit.kidsbu1 ));
      params( 63 ) := "+"( Integer'Pos( a_benunit.kidsbu10 ));
      params( 64 ) := "+"( Integer'Pos( a_benunit.kidsbu11 ));
      params( 65 ) := "+"( Integer'Pos( a_benunit.kidsbu12 ));
      params( 66 ) := "+"( Integer'Pos( a_benunit.kidsbu13 ));
      params( 67 ) := "+"( Integer'Pos( a_benunit.kidsbu14 ));
      params( 68 ) := "+"( Integer'Pos( a_benunit.kidsbu15 ));
      params( 69 ) := "+"( Integer'Pos( a_benunit.kidsbu16 ));
      params( 70 ) := "+"( Integer'Pos( a_benunit.kidsbu17 ));
      params( 71 ) := "+"( Integer'Pos( a_benunit.kidsbu18 ));
      params( 72 ) := "+"( Integer'Pos( a_benunit.kidsbu2 ));
      params( 73 ) := "+"( Integer'Pos( a_benunit.kidsbu3 ));
      params( 74 ) := "+"( Integer'Pos( a_benunit.kidsbu4 ));
      params( 75 ) := "+"( Integer'Pos( a_benunit.kidsbu5 ));
      params( 76 ) := "+"( Integer'Pos( a_benunit.kidsbu6 ));
      params( 77 ) := "+"( Integer'Pos( a_benunit.kidsbu7 ));
      params( 78 ) := "+"( Integer'Pos( a_benunit.kidsbu8 ));
      params( 79 ) := "+"( Integer'Pos( a_benunit.kidsbu9 ));
      params( 80 ) := "+"( Integer'Pos( a_benunit.lastwork ));
      params( 81 ) := "+"( Float( a_benunit.lodger ));
      params( 82 ) := "+"( Integer'Pos( a_benunit.nsboctb ));
      params( 83 ) := "+"( Integer'Pos( a_benunit.otbsctb ));
      params( 84 ) := "+"( Integer'Pos( a_benunit.pepsctb ));
      params( 85 ) := "+"( Integer'Pos( a_benunit.poacctb ));
      params( 86 ) := "+"( Integer'Pos( a_benunit.prboctb ));
      params( 87 ) := "+"( Integer'Pos( a_benunit.sayectb ));
      params( 88 ) := "+"( Integer'Pos( a_benunit.sclbctb ));
      params( 89 ) := "+"( Integer'Pos( a_benunit.ssctb ));
      params( 90 ) := "+"( Integer'Pos( a_benunit.stshctb ));
      params( 91 ) := "+"( Float( a_benunit.subltamt ));
      params( 92 ) := "+"( Integer'Pos( a_benunit.tessctb ));
      params( 93 ) := "+"( Float( a_benunit.totcapbu ));
      params( 94 ) := "+"( Integer'Pos( a_benunit.totsavbu ));
      params( 95 ) := "+"( Float( a_benunit.tuburent ));
      params( 96 ) := "+"( Integer'Pos( a_benunit.untrctb ));
      params( 97 ) := "+"( Integer'Pos( a_benunit.youngch ));
      params( 98 ) := "+"( Integer'Pos( a_benunit.adddec ));
      params( 99 ) := "+"( Integer'Pos( a_benunit.addeples ));
      params( 100 ) := "+"( Integer'Pos( a_benunit.addhol ));
      params( 101 ) := "+"( Integer'Pos( a_benunit.addins ));
      params( 102 ) := "+"( Integer'Pos( a_benunit.addmel ));
      params( 103 ) := "+"( Integer'Pos( a_benunit.addmon ));
      params( 104 ) := "+"( Integer'Pos( a_benunit.addshoe ));
      params( 105 ) := "+"( Integer'Pos( a_benunit.adepfur ));
      params( 106 ) := "+"( Integer'Pos( a_benunit.af1 ));
      params( 107 ) := "+"( Integer'Pos( a_benunit.afdep2 ));
      params( 108 ) := "+"( Integer'Pos( a_benunit.cdelply ));
      params( 109 ) := "+"( Integer'Pos( a_benunit.cdepbed ));
      params( 110 ) := "+"( Integer'Pos( a_benunit.cdepcel ));
      params( 111 ) := "+"( Integer'Pos( a_benunit.cdepeqp ));
      params( 112 ) := "+"( Integer'Pos( a_benunit.cdephol ));
      params( 113 ) := "+"( Integer'Pos( a_benunit.cdeples ));
      params( 114 ) := "+"( Integer'Pos( a_benunit.cdepsum ));
      params( 115 ) := "+"( Integer'Pos( a_benunit.cdeptea ));
      params( 116 ) := "+"( Integer'Pos( a_benunit.cdeptrp ));
      params( 117 ) := "+"( Integer'Pos( a_benunit.cplay ));
      params( 118 ) := "+"( Integer'Pos( a_benunit.debt1 ));
      params( 119 ) := "+"( Integer'Pos( a_benunit.debt2 ));
      params( 120 ) := "+"( Integer'Pos( a_benunit.debt3 ));
      params( 121 ) := "+"( Integer'Pos( a_benunit.debt4 ));
      params( 122 ) := "+"( Integer'Pos( a_benunit.debt5 ));
      params( 123 ) := "+"( Integer'Pos( a_benunit.debt6 ));
      params( 124 ) := "+"( Integer'Pos( a_benunit.debt7 ));
      params( 125 ) := "+"( Integer'Pos( a_benunit.debt8 ));
      params( 126 ) := "+"( Integer'Pos( a_benunit.debt9 ));
      params( 127 ) := "+"( Integer'Pos( a_benunit.houshe1 ));
      params( 128 ) := "+"( Integer'Pos( a_benunit.incold ));
      params( 129 ) := "+"( Integer'Pos( a_benunit.crunacb ));
      params( 130 ) := "+"( Integer'Pos( a_benunit.enomortb ));
      params( 131 ) := "+"( Integer'Pos( a_benunit.hbindbu2 ));
      params( 132 ) := "+"( Integer'Pos( a_benunit.pocardb ));
      params( 133 ) := "+"( Integer'Pos( a_benunit.kid1619 ));
      params( 134 ) := "+"( Float( a_benunit.totcapb2 ));
      params( 135 ) := "+"( Integer'Pos( a_benunit.billnt1 ));
      params( 136 ) := "+"( Integer'Pos( a_benunit.billnt2 ));
      params( 137 ) := "+"( Integer'Pos( a_benunit.billnt3 ));
      params( 138 ) := "+"( Integer'Pos( a_benunit.billnt4 ));
      params( 139 ) := "+"( Integer'Pos( a_benunit.billnt5 ));
      params( 140 ) := "+"( Integer'Pos( a_benunit.billnt6 ));
      params( 141 ) := "+"( Integer'Pos( a_benunit.billnt7 ));
      params( 142 ) := "+"( Integer'Pos( a_benunit.billnt8 ));
      params( 143 ) := "+"( Integer'Pos( a_benunit.coatnt1 ));
      params( 144 ) := "+"( Integer'Pos( a_benunit.coatnt2 ));
      params( 145 ) := "+"( Integer'Pos( a_benunit.coatnt3 ));
      params( 146 ) := "+"( Integer'Pos( a_benunit.coatnt4 ));
      params( 147 ) := "+"( Integer'Pos( a_benunit.coatnt5 ));
      params( 148 ) := "+"( Integer'Pos( a_benunit.coatnt6 ));
      params( 149 ) := "+"( Integer'Pos( a_benunit.coatnt7 ));
      params( 150 ) := "+"( Integer'Pos( a_benunit.coatnt8 ));
      params( 151 ) := "+"( Integer'Pos( a_benunit.cooknt1 ));
      params( 152 ) := "+"( Integer'Pos( a_benunit.cooknt2 ));
      params( 153 ) := "+"( Integer'Pos( a_benunit.cooknt3 ));
      params( 154 ) := "+"( Integer'Pos( a_benunit.cooknt4 ));
      params( 155 ) := "+"( Integer'Pos( a_benunit.cooknt5 ));
      params( 156 ) := "+"( Integer'Pos( a_benunit.cooknt6 ));
      params( 157 ) := "+"( Integer'Pos( a_benunit.cooknt7 ));
      params( 158 ) := "+"( Integer'Pos( a_benunit.cooknt8 ));
      params( 159 ) := "+"( Integer'Pos( a_benunit.dampnt1 ));
      params( 160 ) := "+"( Integer'Pos( a_benunit.dampnt2 ));
      params( 161 ) := "+"( Integer'Pos( a_benunit.dampnt3 ));
      params( 162 ) := "+"( Integer'Pos( a_benunit.dampnt4 ));
      params( 163 ) := "+"( Integer'Pos( a_benunit.dampnt5 ));
      params( 164 ) := "+"( Integer'Pos( a_benunit.dampnt6 ));
      params( 165 ) := "+"( Integer'Pos( a_benunit.dampnt7 ));
      params( 166 ) := "+"( Integer'Pos( a_benunit.dampnt8 ));
      params( 167 ) := "+"( Integer'Pos( a_benunit.frndnt1 ));
      params( 168 ) := "+"( Integer'Pos( a_benunit.frndnt2 ));
      params( 169 ) := "+"( Integer'Pos( a_benunit.frndnt3 ));
      params( 170 ) := "+"( Integer'Pos( a_benunit.frndnt4 ));
      params( 171 ) := "+"( Integer'Pos( a_benunit.frndnt5 ));
      params( 172 ) := "+"( Integer'Pos( a_benunit.frndnt6 ));
      params( 173 ) := "+"( Integer'Pos( a_benunit.frndnt7 ));
      params( 174 ) := "+"( Integer'Pos( a_benunit.frndnt8 ));
      params( 175 ) := "+"( Integer'Pos( a_benunit.hairnt1 ));
      params( 176 ) := "+"( Integer'Pos( a_benunit.hairnt2 ));
      params( 177 ) := "+"( Integer'Pos( a_benunit.hairnt3 ));
      params( 178 ) := "+"( Integer'Pos( a_benunit.hairnt4 ));
      params( 179 ) := "+"( Integer'Pos( a_benunit.hairnt5 ));
      params( 180 ) := "+"( Integer'Pos( a_benunit.hairnt6 ));
      params( 181 ) := "+"( Integer'Pos( a_benunit.hairnt7 ));
      params( 182 ) := "+"( Integer'Pos( a_benunit.hairnt8 ));
      params( 183 ) := "+"( Integer'Pos( a_benunit.heatnt1 ));
      params( 184 ) := "+"( Integer'Pos( a_benunit.heatnt2 ));
      params( 185 ) := "+"( Integer'Pos( a_benunit.heatnt3 ));
      params( 186 ) := "+"( Integer'Pos( a_benunit.heatnt4 ));
      params( 187 ) := "+"( Integer'Pos( a_benunit.heatnt5 ));
      params( 188 ) := "+"( Integer'Pos( a_benunit.heatnt6 ));
      params( 189 ) := "+"( Integer'Pos( a_benunit.heatnt7 ));
      params( 190 ) := "+"( Integer'Pos( a_benunit.heatnt8 ));
      params( 191 ) := "+"( Integer'Pos( a_benunit.holnt1 ));
      params( 192 ) := "+"( Integer'Pos( a_benunit.holnt2 ));
      params( 193 ) := "+"( Integer'Pos( a_benunit.holnt3 ));
      params( 194 ) := "+"( Integer'Pos( a_benunit.holnt4 ));
      params( 195 ) := "+"( Integer'Pos( a_benunit.holnt5 ));
      params( 196 ) := "+"( Integer'Pos( a_benunit.holnt6 ));
      params( 197 ) := "+"( Integer'Pos( a_benunit.holnt7 ));
      params( 198 ) := "+"( Integer'Pos( a_benunit.holnt8 ));
      params( 199 ) := "+"( Integer'Pos( a_benunit.homent1 ));
      params( 200 ) := "+"( Integer'Pos( a_benunit.homent2 ));
      params( 201 ) := "+"( Integer'Pos( a_benunit.homent3 ));
      params( 202 ) := "+"( Integer'Pos( a_benunit.homent4 ));
      params( 203 ) := "+"( Integer'Pos( a_benunit.homent5 ));
      params( 204 ) := "+"( Integer'Pos( a_benunit.homent6 ));
      params( 205 ) := "+"( Integer'Pos( a_benunit.homent7 ));
      params( 206 ) := "+"( Integer'Pos( a_benunit.homent8 ));
      params( 207 ) := "+"( Integer'Pos( a_benunit.issue ));
      params( 208 ) := "+"( Integer'Pos( a_benunit.mealnt1 ));
      params( 209 ) := "+"( Integer'Pos( a_benunit.mealnt2 ));
      params( 210 ) := "+"( Integer'Pos( a_benunit.mealnt3 ));
      params( 211 ) := "+"( Integer'Pos( a_benunit.mealnt4 ));
      params( 212 ) := "+"( Integer'Pos( a_benunit.mealnt5 ));
      params( 213 ) := "+"( Integer'Pos( a_benunit.mealnt6 ));
      params( 214 ) := "+"( Integer'Pos( a_benunit.mealnt7 ));
      params( 215 ) := "+"( Integer'Pos( a_benunit.mealnt8 ));
      params( 216 ) := "+"( Integer'Pos( a_benunit.oabill ));
      params( 217 ) := "+"( Integer'Pos( a_benunit.oacoat ));
      params( 218 ) := "+"( Integer'Pos( a_benunit.oacook ));
      params( 219 ) := "+"( Integer'Pos( a_benunit.oadamp ));
      params( 220 ) := "+"( Integer'Pos( a_benunit.oaexpns ));
      params( 221 ) := "+"( Integer'Pos( a_benunit.oafrnd ));
      params( 222 ) := "+"( Integer'Pos( a_benunit.oahair ));
      params( 223 ) := "+"( Integer'Pos( a_benunit.oaheat ));
      params( 224 ) := "+"( Integer'Pos( a_benunit.oahol ));
      params( 225 ) := "+"( Integer'Pos( a_benunit.oahome ));
      params( 226 ) := "+"( Integer'Pos( a_benunit.oahowpy1 ));
      params( 227 ) := "+"( Integer'Pos( a_benunit.oahowpy2 ));
      params( 228 ) := "+"( Integer'Pos( a_benunit.oahowpy3 ));
      params( 229 ) := "+"( Integer'Pos( a_benunit.oahowpy4 ));
      params( 230 ) := "+"( Integer'Pos( a_benunit.oahowpy5 ));
      params( 231 ) := "+"( Integer'Pos( a_benunit.oahowpy6 ));
      params( 232 ) := "+"( Integer'Pos( a_benunit.oameal ));
      params( 233 ) := "+"( Integer'Pos( a_benunit.oaout ));
      params( 234 ) := "+"( Integer'Pos( a_benunit.oaphon ));
      params( 235 ) := "+"( Integer'Pos( a_benunit.oataxi ));
      params( 236 ) := "+"( Integer'Pos( a_benunit.oawarm ));
      params( 237 ) := "+"( Integer'Pos( a_benunit.outnt1 ));
      params( 238 ) := "+"( Integer'Pos( a_benunit.outnt2 ));
      params( 239 ) := "+"( Integer'Pos( a_benunit.outnt3 ));
      params( 240 ) := "+"( Integer'Pos( a_benunit.outnt4 ));
      params( 241 ) := "+"( Integer'Pos( a_benunit.outnt5 ));
      params( 242 ) := "+"( Integer'Pos( a_benunit.outnt6 ));
      params( 243 ) := "+"( Integer'Pos( a_benunit.outnt7 ));
      params( 244 ) := "+"( Integer'Pos( a_benunit.outnt8 ));
      params( 245 ) := "+"( Integer'Pos( a_benunit.phonnt1 ));
      params( 246 ) := "+"( Integer'Pos( a_benunit.phonnt2 ));
      params( 247 ) := "+"( Integer'Pos( a_benunit.phonnt3 ));
      params( 248 ) := "+"( Integer'Pos( a_benunit.phonnt4 ));
      params( 249 ) := "+"( Integer'Pos( a_benunit.phonnt5 ));
      params( 250 ) := "+"( Integer'Pos( a_benunit.phonnt6 ));
      params( 251 ) := "+"( Integer'Pos( a_benunit.phonnt7 ));
      params( 252 ) := "+"( Integer'Pos( a_benunit.phonnt8 ));
      params( 253 ) := "+"( Integer'Pos( a_benunit.taxint1 ));
      params( 254 ) := "+"( Integer'Pos( a_benunit.taxint2 ));
      params( 255 ) := "+"( Integer'Pos( a_benunit.taxint3 ));
      params( 256 ) := "+"( Integer'Pos( a_benunit.taxint4 ));
      params( 257 ) := "+"( Integer'Pos( a_benunit.taxint5 ));
      params( 258 ) := "+"( Integer'Pos( a_benunit.taxint6 ));
      params( 259 ) := "+"( Integer'Pos( a_benunit.taxint7 ));
      params( 260 ) := "+"( Integer'Pos( a_benunit.taxint8 ));
      params( 261 ) := "+"( Integer'Pos( a_benunit.warmnt1 ));
      params( 262 ) := "+"( Integer'Pos( a_benunit.warmnt2 ));
      params( 263 ) := "+"( Integer'Pos( a_benunit.warmnt3 ));
      params( 264 ) := "+"( Integer'Pos( a_benunit.warmnt4 ));
      params( 265 ) := "+"( Integer'Pos( a_benunit.warmnt5 ));
      params( 266 ) := "+"( Integer'Pos( a_benunit.warmnt6 ));
      params( 267 ) := "+"( Integer'Pos( a_benunit.warmnt7 ));
      params( 268 ) := "+"( Integer'Pos( a_benunit.warmnt8 ));
      params( 269 ) := "+"( Integer'Pos( a_benunit.buagegr3 ));
      params( 270 ) := "+"( Integer'Pos( a_benunit.buagegr4 ));
      params( 271 ) := "+"( Float( a_benunit.heartbu ));
      params( 272 ) := "+"( Integer'Pos( a_benunit.newfambu ));
      params( 273 ) := "+"( Integer'Pos( a_benunit.billnt9 ));
      params( 274 ) := "+"( Integer'Pos( a_benunit.cbaamt1 ));
      params( 275 ) := "+"( Integer'Pos( a_benunit.cbaamt2 ));
      params( 276 ) := "+"( Integer'Pos( a_benunit.coatnt9 ));
      params( 277 ) := "+"( Integer'Pos( a_benunit.cooknt9 ));
      params( 278 ) := "+"( Integer'Pos( a_benunit.dampnt9 ));
      params( 279 ) := "+"( Integer'Pos( a_benunit.frndnt9 ));
      params( 280 ) := "+"( Integer'Pos( a_benunit.hairnt9 ));
      params( 281 ) := "+"( Integer'Pos( a_benunit.hbolng ));
      params( 282 ) := "+"( Float( a_benunit.hbothamt ));
      params( 283 ) := "+"( Integer'Pos( a_benunit.hbothbu ));
      params( 284 ) := "+"( Integer'Pos( a_benunit.hbothmn ));
      params( 285 ) := "+"( Integer'Pos( a_benunit.hbothpd ));
      params( 286 ) := "+"( Integer'Pos( a_benunit.hbothwk ));
      params( 287 ) := "+"( Integer'Pos( a_benunit.hbothyr ));
      params( 288 ) := "+"( Integer'Pos( a_benunit.hbotwait ));
      params( 289 ) := "+"( Integer'Pos( a_benunit.heatnt9 ));
      params( 290 ) := "+"( Integer'Pos( a_benunit.helpgv01 ));
      params( 291 ) := "+"( Integer'Pos( a_benunit.helpgv02 ));
      params( 292 ) := "+"( Integer'Pos( a_benunit.helpgv03 ));
      params( 293 ) := "+"( Integer'Pos( a_benunit.helpgv04 ));
      params( 294 ) := "+"( Integer'Pos( a_benunit.helpgv05 ));
      params( 295 ) := "+"( Integer'Pos( a_benunit.helpgv06 ));
      params( 296 ) := "+"( Integer'Pos( a_benunit.helpgv07 ));
      params( 297 ) := "+"( Integer'Pos( a_benunit.helpgv08 ));
      params( 298 ) := "+"( Integer'Pos( a_benunit.helpgv09 ));
      params( 299 ) := "+"( Integer'Pos( a_benunit.helpgv10 ));
      params( 300 ) := "+"( Integer'Pos( a_benunit.helpgv11 ));
      params( 301 ) := "+"( Integer'Pos( a_benunit.helprc01 ));
      params( 302 ) := "+"( Integer'Pos( a_benunit.helprc02 ));
      params( 303 ) := "+"( Integer'Pos( a_benunit.helprc03 ));
      params( 304 ) := "+"( Integer'Pos( a_benunit.helprc04 ));
      params( 305 ) := "+"( Integer'Pos( a_benunit.helprc05 ));
      params( 306 ) := "+"( Integer'Pos( a_benunit.helprc06 ));
      params( 307 ) := "+"( Integer'Pos( a_benunit.helprc07 ));
      params( 308 ) := "+"( Integer'Pos( a_benunit.helprc08 ));
      params( 309 ) := "+"( Integer'Pos( a_benunit.helprc09 ));
      params( 310 ) := "+"( Integer'Pos( a_benunit.helprc10 ));
      params( 311 ) := "+"( Integer'Pos( a_benunit.helprc11 ));
      params( 312 ) := "+"( Integer'Pos( a_benunit.holnt9 ));
      params( 313 ) := "+"( Integer'Pos( a_benunit.homent9 ));
      params( 314 ) := "+"( Integer'Pos( a_benunit.loangvn1 ));
      params( 315 ) := "+"( Integer'Pos( a_benunit.loangvn2 ));
      params( 316 ) := "+"( Integer'Pos( a_benunit.loangvn3 ));
      params( 317 ) := "+"( Integer'Pos( a_benunit.loanrec1 ));
      params( 318 ) := "+"( Integer'Pos( a_benunit.loanrec2 ));
      params( 319 ) := "+"( Integer'Pos( a_benunit.loanrec3 ));
      params( 320 ) := "+"( Integer'Pos( a_benunit.mealnt9 ));
      params( 321 ) := "+"( Integer'Pos( a_benunit.outnt9 ));
      params( 322 ) := "+"( Integer'Pos( a_benunit.phonnt9 ));
      params( 323 ) := "+"( Integer'Pos( a_benunit.taxint9 ));
      params( 324 ) := "+"( Integer'Pos( a_benunit.warmnt9 ));
      params( 325 ) := "+"( Integer'Pos( a_benunit.ecostabu ));
      params( 326 ) := "+"( Integer'Pos( a_benunit.famtypb2 ));
      params( 327 ) := "+"( Integer'Pos( a_benunit.gross3_x ));
      params( 328 ) := "+"( Integer'Pos( a_benunit.newfamb2 ));
      params( 329 ) := "+"( Integer'Pos( a_benunit.oabilimp ));
      params( 330 ) := "+"( Integer'Pos( a_benunit.oacoaimp ));
      params( 331 ) := "+"( Integer'Pos( a_benunit.oacooimp ));
      params( 332 ) := "+"( Integer'Pos( a_benunit.oadamimp ));
      params( 333 ) := "+"( Integer'Pos( a_benunit.oaexpimp ));
      params( 334 ) := "+"( Integer'Pos( a_benunit.oafrnimp ));
      params( 335 ) := "+"( Integer'Pos( a_benunit.oahaiimp ));
      params( 336 ) := "+"( Integer'Pos( a_benunit.oaheaimp ));
      params( 337 ) := "+"( Integer'Pos( a_benunit.oaholimp ));
      params( 338 ) := "+"( Integer'Pos( a_benunit.oahomimp ));
      params( 339 ) := "+"( Integer'Pos( a_benunit.oameaimp ));
      params( 340 ) := "+"( Integer'Pos( a_benunit.oaoutimp ));
      params( 341 ) := "+"( Integer'Pos( a_benunit.oaphoimp ));
      params( 342 ) := "+"( Integer'Pos( a_benunit.oataximp ));
      params( 343 ) := "+"( Integer'Pos( a_benunit.oawarimp ));
      params( 344 ) := "+"( Float( a_benunit.totcapb3 ));
      params( 345 ) := "+"( Integer'Pos( a_benunit.adbtbl ));
      params( 346 ) := "+"( Integer'Pos( a_benunit.cdepact ));
      params( 347 ) := "+"( Integer'Pos( a_benunit.cdepveg ));
      params( 348 ) := "+"( Integer'Pos( a_benunit.cdpcoat ));
      params( 349 ) := "+"( Integer'Pos( a_benunit.oapre ));
      params( 350 ) := "+"( Integer'Pos( a_benunit.buethgr3 ));
      params( 351 ) := "+"( Float( a_benunit.fsbbu ));
      params( 352 ) := "+"( Integer'Pos( a_benunit.addholr ));
      params( 353 ) := "+"( Integer'Pos( a_benunit.computer ));
      params( 354 ) := "+"( Integer'Pos( a_benunit.compuwhy ));
      params( 355 ) := "+"( Integer'Pos( a_benunit.crime ));
      params( 356 ) := "+"( Integer'Pos( a_benunit.damp ));
      params( 357 ) := "+"( Integer'Pos( a_benunit.dark ));
      params( 358 ) := "+"( Integer'Pos( a_benunit.debt01 ));
      params( 359 ) := "+"( Integer'Pos( a_benunit.debt02 ));
      params( 360 ) := "+"( Integer'Pos( a_benunit.debt03 ));
      params( 361 ) := "+"( Integer'Pos( a_benunit.debt04 ));
      params( 362 ) := "+"( Integer'Pos( a_benunit.debt05 ));
      params( 363 ) := "+"( Integer'Pos( a_benunit.debt06 ));
      params( 364 ) := "+"( Integer'Pos( a_benunit.debt07 ));
      params( 365 ) := "+"( Integer'Pos( a_benunit.debt08 ));
      params( 366 ) := "+"( Integer'Pos( a_benunit.debt09 ));
      params( 367 ) := "+"( Integer'Pos( a_benunit.debt10 ));
      params( 368 ) := "+"( Integer'Pos( a_benunit.debt11 ));
      params( 369 ) := "+"( Integer'Pos( a_benunit.debt12 ));
      params( 370 ) := "+"( Integer'Pos( a_benunit.debtar01 ));
      params( 371 ) := "+"( Integer'Pos( a_benunit.debtar02 ));
      params( 372 ) := "+"( Integer'Pos( a_benunit.debtar03 ));
      params( 373 ) := "+"( Integer'Pos( a_benunit.debtar04 ));
      params( 374 ) := "+"( Integer'Pos( a_benunit.debtar05 ));
      params( 375 ) := "+"( Integer'Pos( a_benunit.debtar06 ));
      params( 376 ) := "+"( Integer'Pos( a_benunit.debtar07 ));
      params( 377 ) := "+"( Integer'Pos( a_benunit.debtar08 ));
      params( 378 ) := "+"( Integer'Pos( a_benunit.debtar09 ));
      params( 379 ) := "+"( Integer'Pos( a_benunit.debtar10 ));
      params( 380 ) := "+"( Integer'Pos( a_benunit.debtar11 ));
      params( 381 ) := "+"( Integer'Pos( a_benunit.debtar12 ));
      params( 382 ) := "+"( Integer'Pos( a_benunit.debtfre1 ));
      params( 383 ) := "+"( Integer'Pos( a_benunit.debtfre2 ));
      params( 384 ) := "+"( Integer'Pos( a_benunit.debtfre3 ));
      params( 385 ) := "+"( Integer'Pos( a_benunit.endsmeet ));
      params( 386 ) := "+"( Integer'Pos( a_benunit.eucar ));
      params( 387 ) := "+"( Integer'Pos( a_benunit.eucarwhy ));
      params( 388 ) := "+"( Integer'Pos( a_benunit.euexpns ));
      params( 389 ) := "+"( Integer'Pos( a_benunit.eumeal ));
      params( 390 ) := "+"( Integer'Pos( a_benunit.eurepay ));
      params( 391 ) := "+"( Integer'Pos( a_benunit.euteleph ));
      params( 392 ) := "+"( Integer'Pos( a_benunit.eutelwhy ));
      params( 393 ) := "+"( Integer'Pos( a_benunit.expnsoa ));
      params( 394 ) := "+"( Integer'Pos( a_benunit.houshew ));
      params( 395 ) := "+"( Integer'Pos( a_benunit.noise ));
      params( 396 ) := "+"( Integer'Pos( a_benunit.oacareu1 ));
      params( 397 ) := "+"( Integer'Pos( a_benunit.oacareu2 ));
      params( 398 ) := "+"( Integer'Pos( a_benunit.oacareu3 ));
      params( 399 ) := "+"( Integer'Pos( a_benunit.oacareu4 ));
      params( 400 ) := "+"( Integer'Pos( a_benunit.oacareu5 ));
      params( 401 ) := "+"( Integer'Pos( a_benunit.oacareu6 ));
      params( 402 ) := "+"( Integer'Pos( a_benunit.oacareu7 ));
      params( 403 ) := "+"( Integer'Pos( a_benunit.oacareu8 ));
      params( 404 ) := "+"( Integer'Pos( a_benunit.oataxieu ));
      params( 405 ) := "+"( Integer'Pos( a_benunit.oatelep1 ));
      params( 406 ) := "+"( Integer'Pos( a_benunit.oatelep2 ));
      params( 407 ) := "+"( Integer'Pos( a_benunit.oatelep3 ));
      params( 408 ) := "+"( Integer'Pos( a_benunit.oatelep4 ));
      params( 409 ) := "+"( Integer'Pos( a_benunit.oatelep5 ));
      params( 410 ) := "+"( Integer'Pos( a_benunit.oatelep6 ));
      params( 411 ) := "+"( Integer'Pos( a_benunit.oatelep7 ));
      params( 412 ) := "+"( Integer'Pos( a_benunit.oatelep8 ));
      params( 413 ) := "+"( Integer'Pos( a_benunit.oateleph ));
      params( 414 ) := "+"( Integer'Pos( a_benunit.outpay ));
      params( 415 ) := "+"( Float( a_benunit.outpyamt ));
      params( 416 ) := "+"( Integer'Pos( a_benunit.pollute ));
      params( 417 ) := "+"( Float( a_benunit.regpamt ));
      params( 418 ) := "+"( Integer'Pos( a_benunit.regularp ));
      params( 419 ) := "+"( Integer'Pos( a_benunit.repaybur ));
      params( 420 ) := "+"( Integer'Pos( a_benunit.washmach ));
      params( 421 ) := "+"( Integer'Pos( a_benunit.washwhy ));
      params( 422 ) := "+"( Integer'Pos( a_benunit.whodepq ));
      params( 423 ) := "+"( Integer'Pos( a_benunit.discbua1 ));
      params( 424 ) := "+"( Integer'Pos( a_benunit.discbuc1 ));
      params( 425 ) := "+"( Integer'Pos( a_benunit.diswbua1 ));
      params( 426 ) := "+"( Integer'Pos( a_benunit.diswbuc1 ));
      params( 427 ) := "+"( Float( a_benunit.fsfvbu ));
      params( 428 ) := "+"( Integer'Pos( a_benunit.gross4 ));
      params( 429 ) := "+"( Integer'Pos( a_benunit.adles ));
      params( 430 ) := "+"( Integer'Pos( a_benunit.adlesnt1 ));
      params( 431 ) := "+"( Integer'Pos( a_benunit.adlesnt2 ));
      params( 432 ) := "+"( Integer'Pos( a_benunit.adlesnt3 ));
      params( 433 ) := "+"( Integer'Pos( a_benunit.adlesnt4 ));
      params( 434 ) := "+"( Integer'Pos( a_benunit.adlesnt5 ));
      params( 435 ) := "+"( Integer'Pos( a_benunit.adlesnt6 ));
      params( 436 ) := "+"( Integer'Pos( a_benunit.adlesnt7 ));
      params( 437 ) := "+"( Integer'Pos( a_benunit.adlesnt8 ));
      params( 438 ) := "+"( Integer'Pos( a_benunit.adlesoa ));
      params( 439 ) := "+"( Integer'Pos( a_benunit.clothes ));
      params( 440 ) := "+"( Integer'Pos( a_benunit.clothnt1 ));
      params( 441 ) := "+"( Integer'Pos( a_benunit.clothnt2 ));
      params( 442 ) := "+"( Integer'Pos( a_benunit.clothnt3 ));
      params( 443 ) := "+"( Integer'Pos( a_benunit.clothnt4 ));
      params( 444 ) := "+"( Integer'Pos( a_benunit.clothnt5 ));
      params( 445 ) := "+"( Integer'Pos( a_benunit.clothnt6 ));
      params( 446 ) := "+"( Integer'Pos( a_benunit.clothnt7 ));
      params( 447 ) := "+"( Integer'Pos( a_benunit.clothnt8 ));
      params( 448 ) := "+"( Integer'Pos( a_benunit.clothsoa ));
      params( 449 ) := "+"( Integer'Pos( a_benunit.furnt1 ));
      params( 450 ) := "+"( Integer'Pos( a_benunit.furnt2 ));
      params( 451 ) := "+"( Integer'Pos( a_benunit.furnt3 ));
      params( 452 ) := "+"( Integer'Pos( a_benunit.furnt4 ));
      params( 453 ) := "+"( Integer'Pos( a_benunit.furnt5 ));
      params( 454 ) := "+"( Integer'Pos( a_benunit.furnt6 ));
      params( 455 ) := "+"( Integer'Pos( a_benunit.furnt7 ));
      params( 456 ) := "+"( Integer'Pos( a_benunit.furnt8 ));
      params( 457 ) := "+"( Integer'Pos( a_benunit.intntnt1 ));
      params( 458 ) := "+"( Integer'Pos( a_benunit.intntnt2 ));
      params( 459 ) := "+"( Integer'Pos( a_benunit.intntnt3 ));
      params( 460 ) := "+"( Integer'Pos( a_benunit.intntnt4 ));
      params( 461 ) := "+"( Integer'Pos( a_benunit.intntnt5 ));
      params( 462 ) := "+"( Integer'Pos( a_benunit.intntnt6 ));
      params( 463 ) := "+"( Integer'Pos( a_benunit.intntnt7 ));
      params( 464 ) := "+"( Integer'Pos( a_benunit.intntnt8 ));
      params( 465 ) := "+"( Integer'Pos( a_benunit.intrnet ));
      params( 466 ) := "+"( Integer'Pos( a_benunit.meal ));
      params( 467 ) := "+"( Integer'Pos( a_benunit.oadep2 ));
      params( 468 ) := "+"( Integer'Pos( a_benunit.oadp2nt1 ));
      params( 469 ) := "+"( Integer'Pos( a_benunit.oadp2nt2 ));
      params( 470 ) := "+"( Integer'Pos( a_benunit.oadp2nt3 ));
      params( 471 ) := "+"( Integer'Pos( a_benunit.oadp2nt4 ));
      params( 472 ) := "+"( Integer'Pos( a_benunit.oadp2nt5 ));
      params( 473 ) := "+"( Integer'Pos( a_benunit.oadp2nt6 ));
      params( 474 ) := "+"( Integer'Pos( a_benunit.oadp2nt7 ));
      params( 475 ) := "+"( Integer'Pos( a_benunit.oadp2nt8 ));
      params( 476 ) := "+"( Integer'Pos( a_benunit.oafur ));
      params( 477 ) := "+"( Integer'Pos( a_benunit.oaintern ));
      params( 478 ) := "+"( Integer'Pos( a_benunit.shoe ));
      params( 479 ) := "+"( Integer'Pos( a_benunit.shoent1 ));
      params( 480 ) := "+"( Integer'Pos( a_benunit.shoent2 ));
      params( 481 ) := "+"( Integer'Pos( a_benunit.shoent3 ));
      params( 482 ) := "+"( Integer'Pos( a_benunit.shoent4 ));
      params( 483 ) := "+"( Integer'Pos( a_benunit.shoent5 ));
      params( 484 ) := "+"( Integer'Pos( a_benunit.shoent6 ));
      params( 485 ) := "+"( Integer'Pos( a_benunit.shoent7 ));
      params( 486 ) := "+"( Integer'Pos( a_benunit.shoent8 ));
      params( 487 ) := "+"( Integer'Pos( a_benunit.shoeoa ));
      params( 488 ) := "+"( Integer'Pos( a_benunit.nbunirbn ));
      params( 489 ) := "+"( Integer'Pos( a_benunit.nbuothbn ));
      params( 490 ) := "+"( Integer'Pos( a_benunit.debt13 ));
      params( 491 ) := "+"( Integer'Pos( a_benunit.debtar13 ));
      params( 492 ) := "+"( Integer'Pos( a_benunit.euchbook ));
      params( 493 ) := "+"( Integer'Pos( a_benunit.euchclth ));
      params( 494 ) := "+"( Integer'Pos( a_benunit.euchgame ));
      params( 495 ) := "+"( Integer'Pos( a_benunit.euchmeat ));
      params( 496 ) := "+"( Integer'Pos( a_benunit.euchshoe ));
      params( 497 ) := "+"( Integer'Pos( a_benunit.eupbtran ));
      params( 498 ) := "+"( Integer'Pos( a_benunit.eupbtrn1 ));
      params( 499 ) := "+"( Integer'Pos( a_benunit.eupbtrn2 ));
      params( 500 ) := "+"( Integer'Pos( a_benunit.eupbtrn3 ));
      params( 501 ) := "+"( Integer'Pos( a_benunit.eupbtrn4 ));
      params( 502 ) := "+"( Integer'Pos( a_benunit.eupbtrn5 ));
      params( 503 ) := "+"( Integer'Pos( a_benunit.euroast ));
      params( 504 ) := "+"( Integer'Pos( a_benunit.eusmeal ));
      params( 505 ) := "+"( Integer'Pos( a_benunit.eustudy ));
      params( 506 ) := "+"( Integer'Pos( a_benunit.bueth ));
      params( 507 ) := "+"( Integer'Pos( a_benunit.oaeusmea ));
      params( 508 ) := "+"( Integer'Pos( a_benunit.oaholb ));
      params( 509 ) := "+"( Integer'Pos( a_benunit.oaroast ));
      params( 510 ) := "+"( Integer'Pos( a_benunit.ecostab2 ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Benunit
   --

   procedure Delete( a_benunit : in out Ukds.Frs.Benunit; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_benunit.user_id );
      Add_edition( c, a_benunit.edition );
      Add_year( c, a_benunit.year );
      Add_sernum( c, a_benunit.sernum );
      Add_benunit( c, a_benunit.benunit );
      Delete( c, connection );
      a_benunit := Ukds.Frs.Null_Benunit;
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
   function Retrieve_Associated_Ukds_Frs_Govpays( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Govpay_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Govpay_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Govpay_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Govpay_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Govpay_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Govpay_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Govpay_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Govpays;


   function Retrieve_Associated_Ukds_Frs_Maints( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Maint_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Maint_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Maint_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Maint_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Maint_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Maint_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Maint_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Maints;


   function Retrieve_Associated_Ukds_Frs_Accounts( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Accounts_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Accounts_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Accounts_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Accounts_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Accounts_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Accounts_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Accounts_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Accounts;


   function Retrieve_Child_Ukds_Frs_Pianon1516( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null) return Ukds.Frs.Pianon1516 is
   begin
      return Ukds.Frs.Pianon1516_IO.retrieve_By_PK( 
         Year => a_benunit.Year,
         User_id => a_benunit.User_Id,
         Edition => a_benunit.Edition,
         Sernum => a_benunit.Sernum,
         Benunit => a_benunit.Benunit,
         Connection => connection );
   end Retrieve_Child_Ukds_Frs_Pianon1516;


   function Retrieve_Child_Ukds_Frs_Pianon1415( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null) return Ukds.Frs.Pianon1415 is
   begin
      return Ukds.Frs.Pianon1415_IO.retrieve_By_PK( 
         Year => a_benunit.Year,
         User_id => a_benunit.User_Id,
         Edition => a_benunit.Edition,
         Sernum => a_benunit.Sernum,
         Benunit => a_benunit.Benunit,
         Connection => connection );
   end Retrieve_Child_Ukds_Frs_Pianon1415;


   function Retrieve_Child_Ukds_Frs_Pianon1314( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null) return Ukds.Frs.Pianon1314 is
   begin
      return Ukds.Frs.Pianon1314_IO.retrieve_By_PK( 
         Year => a_benunit.Year,
         User_id => a_benunit.User_Id,
         Edition => a_benunit.Edition,
         Sernum => a_benunit.Sernum,
         Benunit => a_benunit.Benunit,
         Connection => connection );
   end Retrieve_Child_Ukds_Frs_Pianon1314;


   function Retrieve_Associated_Ukds_Frs_Prscrptns( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Prscrptn_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Prscrptn_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Prscrptn_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Prscrptn_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Prscrptn_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Prscrptn_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Prscrptn_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Prscrptns;


   function Retrieve_Associated_Ukds_Frs_Chldcares( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Chldcare_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Chldcare_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Chldcare_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Chldcare_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Chldcare_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Chldcare_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Chldcare_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Chldcares;


   function Retrieve_Associated_Ukds_Frs_Accouts( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Accouts_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Accouts_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Accouts_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Accouts_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Accouts_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Accouts_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Accouts_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Accouts;


   function Retrieve_Associated_Ukds_Frs_Oddjobs( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Oddjob_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Oddjob_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Oddjob_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Oddjob_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Oddjob_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Oddjob_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Oddjob_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Oddjobs;


   function Retrieve_Associated_Ukds_Frs_Penamts( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Penamt_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Penamt_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Penamt_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Penamt_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Penamt_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Penamt_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Penamt_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Penamts;


   function Retrieve_Associated_Ukds_Frs_Penprovs( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Penprov_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Penprov_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Penprov_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Penprov_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Penprov_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Penprov_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Penprov_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Penprovs;


   function Retrieve_Associated_Ukds_Frs_Jobs( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Job_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Job_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Job_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Job_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Job_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Job_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Job_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Jobs;


   function Retrieve_Child_Ukds_Frs_Pianon1213( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null) return Ukds.Frs.Pianon1213 is
   begin
      return Ukds.Frs.Pianon1213_IO.retrieve_By_PK( 
         Year => a_benunit.Year,
         User_id => a_benunit.User_Id,
         Edition => a_benunit.Edition,
         Sernum => a_benunit.Sernum,
         Benunit => a_benunit.Benunit,
         Connection => connection );
   end Retrieve_Child_Ukds_Frs_Pianon1213;


   function Retrieve_Associated_Ukds_Frs_Adults( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Adult_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Adult_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Adult_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Adult_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Adult_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Adult_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Adult_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Adults;


   function Retrieve_Associated_Ukds_Frs_Childs( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Child_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Child_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Child_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Child_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Child_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Child_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Child_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Childs;


   function Retrieve_Associated_Ukds_Frs_Cares( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Care_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Care_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Care_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Care_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Care_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Care_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Care_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Cares;


   function Retrieve_Child_Ukds_Frs_Pianon1011( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null) return Ukds.Frs.Pianon1011 is
   begin
      return Ukds.Frs.Pianon1011_IO.retrieve_By_PK( 
         Year => a_benunit.Year,
         User_id => a_benunit.User_Id,
         Edition => a_benunit.Edition,
         Sernum => a_benunit.Sernum,
         Benunit => a_benunit.Benunit,
         Connection => connection );
   end Retrieve_Child_Ukds_Frs_Pianon1011;


   function Retrieve_Associated_Ukds_Frs_Extchilds( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Extchild_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Extchild_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Extchild_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Extchild_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Extchild_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Extchild_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Extchild_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Extchilds;


   function Retrieve_Associated_Ukds_Frs_Benefits( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Benefits_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Benefits_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Benefits_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Benefits_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Benefits_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Benefits_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Benefits_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Benefits;


   function Retrieve_Associated_Ukds_Frs_Assets( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Assets_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Assets_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Assets_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Assets_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Assets_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Assets_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Assets_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Assets;


   function Retrieve_Associated_Ukds_Frs_Pensions( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Pension_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Pension_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Pension_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Pension_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Pension_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Pension_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Pension_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Pensions;


   function Retrieve_Associated_Ukds_Frs_Childcares( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null ) return Ukds.Frs.Childcare_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Childcare_IO.Add_Year( c, a_benunit.Year );
      Ukds.Frs.Childcare_IO.Add_User_Id( c, a_benunit.User_Id );
      Ukds.Frs.Childcare_IO.Add_Edition( c, a_benunit.Edition );
      Ukds.Frs.Childcare_IO.Add_Sernum( c, a_benunit.Sernum );
      Ukds.Frs.Childcare_IO.Add_Benunit( c, a_benunit.Benunit );
      return Ukds.Frs.Childcare_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Childcares;


   function Retrieve_Child_Ukds_Frs_Pianom0809( a_benunit : Ukds.Frs.Benunit; connection : Database_Connection := null) return Ukds.Frs.Pianom0809 is
   begin
      return Ukds.Frs.Pianom0809_IO.retrieve_By_PK( 
         Year => a_benunit.Year,
         User_id => a_benunit.User_Id,
         Edition => a_benunit.Edition,
         Sernum => a_benunit.Sernum,
         Benunit => a_benunit.Benunit,
         Connection => connection );
   end Retrieve_Child_Ukds_Frs_Pianom0809;



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


   procedure Add_benunit( c : in out d.Criteria; benunit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "benunit", op, join, benunit );
   begin
      d.add_to_criteria( c, elem );
   end Add_benunit;


   procedure Add_incchnge( c : in out d.Criteria; incchnge : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incchnge", op, join, incchnge );
   begin
      d.add_to_criteria( c, elem );
   end Add_incchnge;


   procedure Add_inchilow( c : in out d.Criteria; inchilow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inchilow", op, join, inchilow );
   begin
      d.add_to_criteria( c, elem );
   end Add_inchilow;


   procedure Add_kidinc( c : in out d.Criteria; kidinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidinc", op, join, kidinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidinc;


   procedure Add_nhhchild( c : in out d.Criteria; nhhchild : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nhhchild", op, join, nhhchild );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhhchild;


   procedure Add_totsav( c : in out d.Criteria; totsav : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totsav", op, join, totsav );
   begin
      d.add_to_criteria( c, elem );
   end Add_totsav;


   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "month", op, join, month );
   begin
      d.add_to_criteria( c, elem );
   end Add_month;


   procedure Add_actaccb( c : in out d.Criteria; actaccb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "actaccb", op, join, actaccb );
   begin
      d.add_to_criteria( c, elem );
   end Add_actaccb;


   procedure Add_adddabu( c : in out d.Criteria; adddabu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adddabu", op, join, adddabu );
   begin
      d.add_to_criteria( c, elem );
   end Add_adddabu;


   procedure Add_adultb( c : in out d.Criteria; adultb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adultb", op, join, adultb );
   begin
      d.add_to_criteria( c, elem );
   end Add_adultb;


   procedure Add_basactb( c : in out d.Criteria; basactb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "basactb", op, join, basactb );
   begin
      d.add_to_criteria( c, elem );
   end Add_basactb;


   procedure Add_boarder( c : in out d.Criteria; boarder : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "boarder", op, join, Long_Float( boarder ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_boarder;


   procedure Add_bpeninc( c : in out d.Criteria; bpeninc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bpeninc", op, join, Long_Float( bpeninc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bpeninc;


   procedure Add_bseinc( c : in out d.Criteria; bseinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bseinc", op, join, Long_Float( bseinc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bseinc;


   procedure Add_buagegr2( c : in out d.Criteria; buagegr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buagegr2", op, join, buagegr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_buagegr2;


   procedure Add_buagegrp( c : in out d.Criteria; buagegrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buagegrp", op, join, buagegrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_buagegrp;


   procedure Add_budisben( c : in out d.Criteria; budisben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "budisben", op, join, budisben );
   begin
      d.add_to_criteria( c, elem );
   end Add_budisben;


   procedure Add_buearns( c : in out d.Criteria; buearns : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buearns", op, join, Long_Float( buearns ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_buearns;


   procedure Add_buethgr2( c : in out d.Criteria; buethgr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buethgr2", op, join, buethgr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_buethgr2;


   procedure Add_buethgrp( c : in out d.Criteria; buethgrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buethgrp", op, join, buethgrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_buethgrp;


   procedure Add_buinc( c : in out d.Criteria; buinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buinc", op, join, buinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_buinc;


   procedure Add_buinv( c : in out d.Criteria; buinv : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buinv", op, join, Long_Float( buinv ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_buinv;


   procedure Add_buirben( c : in out d.Criteria; buirben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buirben", op, join, buirben );
   begin
      d.add_to_criteria( c, elem );
   end Add_buirben;


   procedure Add_bukids( c : in out d.Criteria; bukids : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bukids", op, join, bukids );
   begin
      d.add_to_criteria( c, elem );
   end Add_bukids;


   procedure Add_bunirben( c : in out d.Criteria; bunirben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bunirben", op, join, bunirben );
   begin
      d.add_to_criteria( c, elem );
   end Add_bunirben;


   procedure Add_buothben( c : in out d.Criteria; buothben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buothben", op, join, buothben );
   begin
      d.add_to_criteria( c, elem );
   end Add_buothben;


   procedure Add_burent( c : in out d.Criteria; burent : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "burent", op, join, burent );
   begin
      d.add_to_criteria( c, elem );
   end Add_burent;


   procedure Add_burinc( c : in out d.Criteria; burinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "burinc", op, join, Long_Float( burinc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_burinc;


   procedure Add_burpinc( c : in out d.Criteria; burpinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "burpinc", op, join, Long_Float( burpinc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_burpinc;


   procedure Add_butvlic( c : in out d.Criteria; butvlic : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "butvlic", op, join, Long_Float( butvlic ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_butvlic;


   procedure Add_butxcred( c : in out d.Criteria; butxcred : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "butxcred", op, join, Long_Float( butxcred ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_butxcred;


   procedure Add_chddabu( c : in out d.Criteria; chddabu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chddabu", op, join, chddabu );
   begin
      d.add_to_criteria( c, elem );
   end Add_chddabu;


   procedure Add_curactb( c : in out d.Criteria; curactb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "curactb", op, join, curactb );
   begin
      d.add_to_criteria( c, elem );
   end Add_curactb;


   procedure Add_depchldb( c : in out d.Criteria; depchldb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "depchldb", op, join, depchldb );
   begin
      d.add_to_criteria( c, elem );
   end Add_depchldb;


   procedure Add_depdeds( c : in out d.Criteria; depdeds : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "depdeds", op, join, depdeds );
   begin
      d.add_to_criteria( c, elem );
   end Add_depdeds;


   procedure Add_disindhb( c : in out d.Criteria; disindhb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disindhb", op, join, disindhb );
   begin
      d.add_to_criteria( c, elem );
   end Add_disindhb;


   procedure Add_ecotypbu( c : in out d.Criteria; ecotypbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ecotypbu", op, join, ecotypbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_ecotypbu;


   procedure Add_ecstatbu( c : in out d.Criteria; ecstatbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ecstatbu", op, join, ecstatbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_ecstatbu;


   procedure Add_famthbai( c : in out d.Criteria; famthbai : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "famthbai", op, join, famthbai );
   begin
      d.add_to_criteria( c, elem );
   end Add_famthbai;


   procedure Add_famtypbs( c : in out d.Criteria; famtypbs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "famtypbs", op, join, famtypbs );
   begin
      d.add_to_criteria( c, elem );
   end Add_famtypbs;


   procedure Add_famtypbu( c : in out d.Criteria; famtypbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "famtypbu", op, join, famtypbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_famtypbu;


   procedure Add_famtype( c : in out d.Criteria; famtype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "famtype", op, join, famtype );
   begin
      d.add_to_criteria( c, elem );
   end Add_famtype;


   procedure Add_fsbndctb( c : in out d.Criteria; fsbndctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fsbndctb", op, join, fsbndctb );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsbndctb;


   procedure Add_fsmbu( c : in out d.Criteria; fsmbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fsmbu", op, join, Long_Float( fsmbu ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsmbu;


   procedure Add_fsmlkbu( c : in out d.Criteria; fsmlkbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fsmlkbu", op, join, Long_Float( fsmlkbu ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsmlkbu;


   procedure Add_fwmlkbu( c : in out d.Criteria; fwmlkbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fwmlkbu", op, join, Long_Float( fwmlkbu ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fwmlkbu;


   procedure Add_gebactb( c : in out d.Criteria; gebactb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gebactb", op, join, gebactb );
   begin
      d.add_to_criteria( c, elem );
   end Add_gebactb;


   procedure Add_giltctb( c : in out d.Criteria; giltctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "giltctb", op, join, giltctb );
   begin
      d.add_to_criteria( c, elem );
   end Add_giltctb;


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


   procedure Add_hbindbu( c : in out d.Criteria; hbindbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbindbu", op, join, hbindbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbindbu;


   procedure Add_isactb( c : in out d.Criteria; isactb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "isactb", op, join, isactb );
   begin
      d.add_to_criteria( c, elem );
   end Add_isactb;


   procedure Add_kid04( c : in out d.Criteria; kid04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kid04", op, join, kid04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kid04;


   procedure Add_kid1115( c : in out d.Criteria; kid1115 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kid1115", op, join, kid1115 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kid1115;


   procedure Add_kid1618( c : in out d.Criteria; kid1618 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kid1618", op, join, kid1618 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kid1618;


   procedure Add_kid510( c : in out d.Criteria; kid510 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kid510", op, join, kid510 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kid510;


   procedure Add_kidsbu0( c : in out d.Criteria; kidsbu0 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu0", op, join, kidsbu0 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu0;


   procedure Add_kidsbu1( c : in out d.Criteria; kidsbu1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu1", op, join, kidsbu1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu1;


   procedure Add_kidsbu10( c : in out d.Criteria; kidsbu10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu10", op, join, kidsbu10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu10;


   procedure Add_kidsbu11( c : in out d.Criteria; kidsbu11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu11", op, join, kidsbu11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu11;


   procedure Add_kidsbu12( c : in out d.Criteria; kidsbu12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu12", op, join, kidsbu12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu12;


   procedure Add_kidsbu13( c : in out d.Criteria; kidsbu13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu13", op, join, kidsbu13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu13;


   procedure Add_kidsbu14( c : in out d.Criteria; kidsbu14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu14", op, join, kidsbu14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu14;


   procedure Add_kidsbu15( c : in out d.Criteria; kidsbu15 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu15", op, join, kidsbu15 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu15;


   procedure Add_kidsbu16( c : in out d.Criteria; kidsbu16 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu16", op, join, kidsbu16 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu16;


   procedure Add_kidsbu17( c : in out d.Criteria; kidsbu17 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu17", op, join, kidsbu17 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu17;


   procedure Add_kidsbu18( c : in out d.Criteria; kidsbu18 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu18", op, join, kidsbu18 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu18;


   procedure Add_kidsbu2( c : in out d.Criteria; kidsbu2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu2", op, join, kidsbu2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu2;


   procedure Add_kidsbu3( c : in out d.Criteria; kidsbu3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu3", op, join, kidsbu3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu3;


   procedure Add_kidsbu4( c : in out d.Criteria; kidsbu4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu4", op, join, kidsbu4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu4;


   procedure Add_kidsbu5( c : in out d.Criteria; kidsbu5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu5", op, join, kidsbu5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu5;


   procedure Add_kidsbu6( c : in out d.Criteria; kidsbu6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu6", op, join, kidsbu6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu6;


   procedure Add_kidsbu7( c : in out d.Criteria; kidsbu7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu7", op, join, kidsbu7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu7;


   procedure Add_kidsbu8( c : in out d.Criteria; kidsbu8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu8", op, join, kidsbu8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu8;


   procedure Add_kidsbu9( c : in out d.Criteria; kidsbu9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidsbu9", op, join, kidsbu9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu9;


   procedure Add_lastwork( c : in out d.Criteria; lastwork : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lastwork", op, join, lastwork );
   begin
      d.add_to_criteria( c, elem );
   end Add_lastwork;


   procedure Add_lodger( c : in out d.Criteria; lodger : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lodger", op, join, Long_Float( lodger ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_lodger;


   procedure Add_nsboctb( c : in out d.Criteria; nsboctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nsboctb", op, join, nsboctb );
   begin
      d.add_to_criteria( c, elem );
   end Add_nsboctb;


   procedure Add_otbsctb( c : in out d.Criteria; otbsctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "otbsctb", op, join, otbsctb );
   begin
      d.add_to_criteria( c, elem );
   end Add_otbsctb;


   procedure Add_pepsctb( c : in out d.Criteria; pepsctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pepsctb", op, join, pepsctb );
   begin
      d.add_to_criteria( c, elem );
   end Add_pepsctb;


   procedure Add_poacctb( c : in out d.Criteria; poacctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "poacctb", op, join, poacctb );
   begin
      d.add_to_criteria( c, elem );
   end Add_poacctb;


   procedure Add_prboctb( c : in out d.Criteria; prboctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "prboctb", op, join, prboctb );
   begin
      d.add_to_criteria( c, elem );
   end Add_prboctb;


   procedure Add_sayectb( c : in out d.Criteria; sayectb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sayectb", op, join, sayectb );
   begin
      d.add_to_criteria( c, elem );
   end Add_sayectb;


   procedure Add_sclbctb( c : in out d.Criteria; sclbctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sclbctb", op, join, sclbctb );
   begin
      d.add_to_criteria( c, elem );
   end Add_sclbctb;


   procedure Add_ssctb( c : in out d.Criteria; ssctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ssctb", op, join, ssctb );
   begin
      d.add_to_criteria( c, elem );
   end Add_ssctb;


   procedure Add_stshctb( c : in out d.Criteria; stshctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "stshctb", op, join, stshctb );
   begin
      d.add_to_criteria( c, elem );
   end Add_stshctb;


   procedure Add_subltamt( c : in out d.Criteria; subltamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "subltamt", op, join, Long_Float( subltamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_subltamt;


   procedure Add_tessctb( c : in out d.Criteria; tessctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tessctb", op, join, tessctb );
   begin
      d.add_to_criteria( c, elem );
   end Add_tessctb;


   procedure Add_totcapbu( c : in out d.Criteria; totcapbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totcapbu", op, join, Long_Float( totcapbu ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_totcapbu;


   procedure Add_totsavbu( c : in out d.Criteria; totsavbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totsavbu", op, join, totsavbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_totsavbu;


   procedure Add_tuburent( c : in out d.Criteria; tuburent : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tuburent", op, join, Long_Float( tuburent ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_tuburent;


   procedure Add_untrctb( c : in out d.Criteria; untrctb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "untrctb", op, join, untrctb );
   begin
      d.add_to_criteria( c, elem );
   end Add_untrctb;


   procedure Add_youngch( c : in out d.Criteria; youngch : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "youngch", op, join, youngch );
   begin
      d.add_to_criteria( c, elem );
   end Add_youngch;


   procedure Add_adddec( c : in out d.Criteria; adddec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adddec", op, join, adddec );
   begin
      d.add_to_criteria( c, elem );
   end Add_adddec;


   procedure Add_addeples( c : in out d.Criteria; addeples : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "addeples", op, join, addeples );
   begin
      d.add_to_criteria( c, elem );
   end Add_addeples;


   procedure Add_addhol( c : in out d.Criteria; addhol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "addhol", op, join, addhol );
   begin
      d.add_to_criteria( c, elem );
   end Add_addhol;


   procedure Add_addins( c : in out d.Criteria; addins : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "addins", op, join, addins );
   begin
      d.add_to_criteria( c, elem );
   end Add_addins;


   procedure Add_addmel( c : in out d.Criteria; addmel : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "addmel", op, join, addmel );
   begin
      d.add_to_criteria( c, elem );
   end Add_addmel;


   procedure Add_addmon( c : in out d.Criteria; addmon : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "addmon", op, join, addmon );
   begin
      d.add_to_criteria( c, elem );
   end Add_addmon;


   procedure Add_addshoe( c : in out d.Criteria; addshoe : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "addshoe", op, join, addshoe );
   begin
      d.add_to_criteria( c, elem );
   end Add_addshoe;


   procedure Add_adepfur( c : in out d.Criteria; adepfur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adepfur", op, join, adepfur );
   begin
      d.add_to_criteria( c, elem );
   end Add_adepfur;


   procedure Add_af1( c : in out d.Criteria; af1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "af1", op, join, af1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_af1;


   procedure Add_afdep2( c : in out d.Criteria; afdep2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "afdep2", op, join, afdep2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_afdep2;


   procedure Add_cdelply( c : in out d.Criteria; cdelply : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdelply", op, join, cdelply );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdelply;


   procedure Add_cdepbed( c : in out d.Criteria; cdepbed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdepbed", op, join, cdepbed );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdepbed;


   procedure Add_cdepcel( c : in out d.Criteria; cdepcel : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdepcel", op, join, cdepcel );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdepcel;


   procedure Add_cdepeqp( c : in out d.Criteria; cdepeqp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdepeqp", op, join, cdepeqp );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdepeqp;


   procedure Add_cdephol( c : in out d.Criteria; cdephol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdephol", op, join, cdephol );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdephol;


   procedure Add_cdeples( c : in out d.Criteria; cdeples : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdeples", op, join, cdeples );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdeples;


   procedure Add_cdepsum( c : in out d.Criteria; cdepsum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdepsum", op, join, cdepsum );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdepsum;


   procedure Add_cdeptea( c : in out d.Criteria; cdeptea : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdeptea", op, join, cdeptea );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdeptea;


   procedure Add_cdeptrp( c : in out d.Criteria; cdeptrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdeptrp", op, join, cdeptrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdeptrp;


   procedure Add_cplay( c : in out d.Criteria; cplay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cplay", op, join, cplay );
   begin
      d.add_to_criteria( c, elem );
   end Add_cplay;


   procedure Add_debt1( c : in out d.Criteria; debt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt1", op, join, debt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt1;


   procedure Add_debt2( c : in out d.Criteria; debt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt2", op, join, debt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt2;


   procedure Add_debt3( c : in out d.Criteria; debt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt3", op, join, debt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt3;


   procedure Add_debt4( c : in out d.Criteria; debt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt4", op, join, debt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt4;


   procedure Add_debt5( c : in out d.Criteria; debt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt5", op, join, debt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt5;


   procedure Add_debt6( c : in out d.Criteria; debt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt6", op, join, debt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt6;


   procedure Add_debt7( c : in out d.Criteria; debt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt7", op, join, debt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt7;


   procedure Add_debt8( c : in out d.Criteria; debt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt8", op, join, debt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt8;


   procedure Add_debt9( c : in out d.Criteria; debt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt9", op, join, debt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt9;


   procedure Add_houshe1( c : in out d.Criteria; houshe1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "houshe1", op, join, houshe1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_houshe1;


   procedure Add_incold( c : in out d.Criteria; incold : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incold", op, join, incold );
   begin
      d.add_to_criteria( c, elem );
   end Add_incold;


   procedure Add_crunacb( c : in out d.Criteria; crunacb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "crunacb", op, join, crunacb );
   begin
      d.add_to_criteria( c, elem );
   end Add_crunacb;


   procedure Add_enomortb( c : in out d.Criteria; enomortb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "enomortb", op, join, enomortb );
   begin
      d.add_to_criteria( c, elem );
   end Add_enomortb;


   procedure Add_hbindbu2( c : in out d.Criteria; hbindbu2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbindbu2", op, join, hbindbu2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbindbu2;


   procedure Add_pocardb( c : in out d.Criteria; pocardb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pocardb", op, join, pocardb );
   begin
      d.add_to_criteria( c, elem );
   end Add_pocardb;


   procedure Add_kid1619( c : in out d.Criteria; kid1619 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kid1619", op, join, kid1619 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kid1619;


   procedure Add_totcapb2( c : in out d.Criteria; totcapb2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totcapb2", op, join, Long_Float( totcapb2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_totcapb2;


   procedure Add_billnt1( c : in out d.Criteria; billnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "billnt1", op, join, billnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt1;


   procedure Add_billnt2( c : in out d.Criteria; billnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "billnt2", op, join, billnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt2;


   procedure Add_billnt3( c : in out d.Criteria; billnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "billnt3", op, join, billnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt3;


   procedure Add_billnt4( c : in out d.Criteria; billnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "billnt4", op, join, billnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt4;


   procedure Add_billnt5( c : in out d.Criteria; billnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "billnt5", op, join, billnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt5;


   procedure Add_billnt6( c : in out d.Criteria; billnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "billnt6", op, join, billnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt6;


   procedure Add_billnt7( c : in out d.Criteria; billnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "billnt7", op, join, billnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt7;


   procedure Add_billnt8( c : in out d.Criteria; billnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "billnt8", op, join, billnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt8;


   procedure Add_coatnt1( c : in out d.Criteria; coatnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coatnt1", op, join, coatnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt1;


   procedure Add_coatnt2( c : in out d.Criteria; coatnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coatnt2", op, join, coatnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt2;


   procedure Add_coatnt3( c : in out d.Criteria; coatnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coatnt3", op, join, coatnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt3;


   procedure Add_coatnt4( c : in out d.Criteria; coatnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coatnt4", op, join, coatnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt4;


   procedure Add_coatnt5( c : in out d.Criteria; coatnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coatnt5", op, join, coatnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt5;


   procedure Add_coatnt6( c : in out d.Criteria; coatnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coatnt6", op, join, coatnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt6;


   procedure Add_coatnt7( c : in out d.Criteria; coatnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coatnt7", op, join, coatnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt7;


   procedure Add_coatnt8( c : in out d.Criteria; coatnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coatnt8", op, join, coatnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt8;


   procedure Add_cooknt1( c : in out d.Criteria; cooknt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cooknt1", op, join, cooknt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt1;


   procedure Add_cooknt2( c : in out d.Criteria; cooknt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cooknt2", op, join, cooknt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt2;


   procedure Add_cooknt3( c : in out d.Criteria; cooknt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cooknt3", op, join, cooknt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt3;


   procedure Add_cooknt4( c : in out d.Criteria; cooknt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cooknt4", op, join, cooknt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt4;


   procedure Add_cooknt5( c : in out d.Criteria; cooknt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cooknt5", op, join, cooknt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt5;


   procedure Add_cooknt6( c : in out d.Criteria; cooknt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cooknt6", op, join, cooknt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt6;


   procedure Add_cooknt7( c : in out d.Criteria; cooknt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cooknt7", op, join, cooknt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt7;


   procedure Add_cooknt8( c : in out d.Criteria; cooknt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cooknt8", op, join, cooknt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt8;


   procedure Add_dampnt1( c : in out d.Criteria; dampnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dampnt1", op, join, dampnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt1;


   procedure Add_dampnt2( c : in out d.Criteria; dampnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dampnt2", op, join, dampnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt2;


   procedure Add_dampnt3( c : in out d.Criteria; dampnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dampnt3", op, join, dampnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt3;


   procedure Add_dampnt4( c : in out d.Criteria; dampnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dampnt4", op, join, dampnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt4;


   procedure Add_dampnt5( c : in out d.Criteria; dampnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dampnt5", op, join, dampnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt5;


   procedure Add_dampnt6( c : in out d.Criteria; dampnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dampnt6", op, join, dampnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt6;


   procedure Add_dampnt7( c : in out d.Criteria; dampnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dampnt7", op, join, dampnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt7;


   procedure Add_dampnt8( c : in out d.Criteria; dampnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dampnt8", op, join, dampnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt8;


   procedure Add_frndnt1( c : in out d.Criteria; frndnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frndnt1", op, join, frndnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt1;


   procedure Add_frndnt2( c : in out d.Criteria; frndnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frndnt2", op, join, frndnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt2;


   procedure Add_frndnt3( c : in out d.Criteria; frndnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frndnt3", op, join, frndnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt3;


   procedure Add_frndnt4( c : in out d.Criteria; frndnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frndnt4", op, join, frndnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt4;


   procedure Add_frndnt5( c : in out d.Criteria; frndnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frndnt5", op, join, frndnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt5;


   procedure Add_frndnt6( c : in out d.Criteria; frndnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frndnt6", op, join, frndnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt6;


   procedure Add_frndnt7( c : in out d.Criteria; frndnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frndnt7", op, join, frndnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt7;


   procedure Add_frndnt8( c : in out d.Criteria; frndnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frndnt8", op, join, frndnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt8;


   procedure Add_hairnt1( c : in out d.Criteria; hairnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hairnt1", op, join, hairnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt1;


   procedure Add_hairnt2( c : in out d.Criteria; hairnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hairnt2", op, join, hairnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt2;


   procedure Add_hairnt3( c : in out d.Criteria; hairnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hairnt3", op, join, hairnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt3;


   procedure Add_hairnt4( c : in out d.Criteria; hairnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hairnt4", op, join, hairnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt4;


   procedure Add_hairnt5( c : in out d.Criteria; hairnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hairnt5", op, join, hairnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt5;


   procedure Add_hairnt6( c : in out d.Criteria; hairnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hairnt6", op, join, hairnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt6;


   procedure Add_hairnt7( c : in out d.Criteria; hairnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hairnt7", op, join, hairnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt7;


   procedure Add_hairnt8( c : in out d.Criteria; hairnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hairnt8", op, join, hairnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt8;


   procedure Add_heatnt1( c : in out d.Criteria; heatnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heatnt1", op, join, heatnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt1;


   procedure Add_heatnt2( c : in out d.Criteria; heatnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heatnt2", op, join, heatnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt2;


   procedure Add_heatnt3( c : in out d.Criteria; heatnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heatnt3", op, join, heatnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt3;


   procedure Add_heatnt4( c : in out d.Criteria; heatnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heatnt4", op, join, heatnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt4;


   procedure Add_heatnt5( c : in out d.Criteria; heatnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heatnt5", op, join, heatnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt5;


   procedure Add_heatnt6( c : in out d.Criteria; heatnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heatnt6", op, join, heatnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt6;


   procedure Add_heatnt7( c : in out d.Criteria; heatnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heatnt7", op, join, heatnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt7;


   procedure Add_heatnt8( c : in out d.Criteria; heatnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heatnt8", op, join, heatnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt8;


   procedure Add_holnt1( c : in out d.Criteria; holnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "holnt1", op, join, holnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt1;


   procedure Add_holnt2( c : in out d.Criteria; holnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "holnt2", op, join, holnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt2;


   procedure Add_holnt3( c : in out d.Criteria; holnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "holnt3", op, join, holnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt3;


   procedure Add_holnt4( c : in out d.Criteria; holnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "holnt4", op, join, holnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt4;


   procedure Add_holnt5( c : in out d.Criteria; holnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "holnt5", op, join, holnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt5;


   procedure Add_holnt6( c : in out d.Criteria; holnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "holnt6", op, join, holnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt6;


   procedure Add_holnt7( c : in out d.Criteria; holnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "holnt7", op, join, holnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt7;


   procedure Add_holnt8( c : in out d.Criteria; holnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "holnt8", op, join, holnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt8;


   procedure Add_homent1( c : in out d.Criteria; homent1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "homent1", op, join, homent1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent1;


   procedure Add_homent2( c : in out d.Criteria; homent2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "homent2", op, join, homent2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent2;


   procedure Add_homent3( c : in out d.Criteria; homent3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "homent3", op, join, homent3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent3;


   procedure Add_homent4( c : in out d.Criteria; homent4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "homent4", op, join, homent4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent4;


   procedure Add_homent5( c : in out d.Criteria; homent5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "homent5", op, join, homent5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent5;


   procedure Add_homent6( c : in out d.Criteria; homent6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "homent6", op, join, homent6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent6;


   procedure Add_homent7( c : in out d.Criteria; homent7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "homent7", op, join, homent7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent7;


   procedure Add_homent8( c : in out d.Criteria; homent8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "homent8", op, join, homent8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent8;


   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issue", op, join, issue );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue;


   procedure Add_mealnt1( c : in out d.Criteria; mealnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mealnt1", op, join, mealnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt1;


   procedure Add_mealnt2( c : in out d.Criteria; mealnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mealnt2", op, join, mealnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt2;


   procedure Add_mealnt3( c : in out d.Criteria; mealnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mealnt3", op, join, mealnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt3;


   procedure Add_mealnt4( c : in out d.Criteria; mealnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mealnt4", op, join, mealnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt4;


   procedure Add_mealnt5( c : in out d.Criteria; mealnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mealnt5", op, join, mealnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt5;


   procedure Add_mealnt6( c : in out d.Criteria; mealnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mealnt6", op, join, mealnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt6;


   procedure Add_mealnt7( c : in out d.Criteria; mealnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mealnt7", op, join, mealnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt7;


   procedure Add_mealnt8( c : in out d.Criteria; mealnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mealnt8", op, join, mealnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt8;


   procedure Add_oabill( c : in out d.Criteria; oabill : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oabill", op, join, oabill );
   begin
      d.add_to_criteria( c, elem );
   end Add_oabill;


   procedure Add_oacoat( c : in out d.Criteria; oacoat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oacoat", op, join, oacoat );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacoat;


   procedure Add_oacook( c : in out d.Criteria; oacook : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oacook", op, join, oacook );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacook;


   procedure Add_oadamp( c : in out d.Criteria; oadamp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oadamp", op, join, oadamp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadamp;


   procedure Add_oaexpns( c : in out d.Criteria; oaexpns : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaexpns", op, join, oaexpns );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaexpns;


   procedure Add_oafrnd( c : in out d.Criteria; oafrnd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oafrnd", op, join, oafrnd );
   begin
      d.add_to_criteria( c, elem );
   end Add_oafrnd;


   procedure Add_oahair( c : in out d.Criteria; oahair : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oahair", op, join, oahair );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahair;


   procedure Add_oaheat( c : in out d.Criteria; oaheat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaheat", op, join, oaheat );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaheat;


   procedure Add_oahol( c : in out d.Criteria; oahol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oahol", op, join, oahol );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahol;


   procedure Add_oahome( c : in out d.Criteria; oahome : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oahome", op, join, oahome );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahome;


   procedure Add_oahowpy1( c : in out d.Criteria; oahowpy1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oahowpy1", op, join, oahowpy1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahowpy1;


   procedure Add_oahowpy2( c : in out d.Criteria; oahowpy2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oahowpy2", op, join, oahowpy2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahowpy2;


   procedure Add_oahowpy3( c : in out d.Criteria; oahowpy3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oahowpy3", op, join, oahowpy3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahowpy3;


   procedure Add_oahowpy4( c : in out d.Criteria; oahowpy4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oahowpy4", op, join, oahowpy4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahowpy4;


   procedure Add_oahowpy5( c : in out d.Criteria; oahowpy5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oahowpy5", op, join, oahowpy5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahowpy5;


   procedure Add_oahowpy6( c : in out d.Criteria; oahowpy6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oahowpy6", op, join, oahowpy6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahowpy6;


   procedure Add_oameal( c : in out d.Criteria; oameal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oameal", op, join, oameal );
   begin
      d.add_to_criteria( c, elem );
   end Add_oameal;


   procedure Add_oaout( c : in out d.Criteria; oaout : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaout", op, join, oaout );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaout;


   procedure Add_oaphon( c : in out d.Criteria; oaphon : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaphon", op, join, oaphon );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaphon;


   procedure Add_oataxi( c : in out d.Criteria; oataxi : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oataxi", op, join, oataxi );
   begin
      d.add_to_criteria( c, elem );
   end Add_oataxi;


   procedure Add_oawarm( c : in out d.Criteria; oawarm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oawarm", op, join, oawarm );
   begin
      d.add_to_criteria( c, elem );
   end Add_oawarm;


   procedure Add_outnt1( c : in out d.Criteria; outnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "outnt1", op, join, outnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt1;


   procedure Add_outnt2( c : in out d.Criteria; outnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "outnt2", op, join, outnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt2;


   procedure Add_outnt3( c : in out d.Criteria; outnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "outnt3", op, join, outnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt3;


   procedure Add_outnt4( c : in out d.Criteria; outnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "outnt4", op, join, outnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt4;


   procedure Add_outnt5( c : in out d.Criteria; outnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "outnt5", op, join, outnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt5;


   procedure Add_outnt6( c : in out d.Criteria; outnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "outnt6", op, join, outnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt6;


   procedure Add_outnt7( c : in out d.Criteria; outnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "outnt7", op, join, outnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt7;


   procedure Add_outnt8( c : in out d.Criteria; outnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "outnt8", op, join, outnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt8;


   procedure Add_phonnt1( c : in out d.Criteria; phonnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "phonnt1", op, join, phonnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt1;


   procedure Add_phonnt2( c : in out d.Criteria; phonnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "phonnt2", op, join, phonnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt2;


   procedure Add_phonnt3( c : in out d.Criteria; phonnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "phonnt3", op, join, phonnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt3;


   procedure Add_phonnt4( c : in out d.Criteria; phonnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "phonnt4", op, join, phonnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt4;


   procedure Add_phonnt5( c : in out d.Criteria; phonnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "phonnt5", op, join, phonnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt5;


   procedure Add_phonnt6( c : in out d.Criteria; phonnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "phonnt6", op, join, phonnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt6;


   procedure Add_phonnt7( c : in out d.Criteria; phonnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "phonnt7", op, join, phonnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt7;


   procedure Add_phonnt8( c : in out d.Criteria; phonnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "phonnt8", op, join, phonnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt8;


   procedure Add_taxint1( c : in out d.Criteria; taxint1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxint1", op, join, taxint1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint1;


   procedure Add_taxint2( c : in out d.Criteria; taxint2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxint2", op, join, taxint2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint2;


   procedure Add_taxint3( c : in out d.Criteria; taxint3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxint3", op, join, taxint3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint3;


   procedure Add_taxint4( c : in out d.Criteria; taxint4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxint4", op, join, taxint4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint4;


   procedure Add_taxint5( c : in out d.Criteria; taxint5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxint5", op, join, taxint5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint5;


   procedure Add_taxint6( c : in out d.Criteria; taxint6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxint6", op, join, taxint6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint6;


   procedure Add_taxint7( c : in out d.Criteria; taxint7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxint7", op, join, taxint7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint7;


   procedure Add_taxint8( c : in out d.Criteria; taxint8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxint8", op, join, taxint8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint8;


   procedure Add_warmnt1( c : in out d.Criteria; warmnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "warmnt1", op, join, warmnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt1;


   procedure Add_warmnt2( c : in out d.Criteria; warmnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "warmnt2", op, join, warmnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt2;


   procedure Add_warmnt3( c : in out d.Criteria; warmnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "warmnt3", op, join, warmnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt3;


   procedure Add_warmnt4( c : in out d.Criteria; warmnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "warmnt4", op, join, warmnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt4;


   procedure Add_warmnt5( c : in out d.Criteria; warmnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "warmnt5", op, join, warmnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt5;


   procedure Add_warmnt6( c : in out d.Criteria; warmnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "warmnt6", op, join, warmnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt6;


   procedure Add_warmnt7( c : in out d.Criteria; warmnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "warmnt7", op, join, warmnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt7;


   procedure Add_warmnt8( c : in out d.Criteria; warmnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "warmnt8", op, join, warmnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt8;


   procedure Add_buagegr3( c : in out d.Criteria; buagegr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buagegr3", op, join, buagegr3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_buagegr3;


   procedure Add_buagegr4( c : in out d.Criteria; buagegr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buagegr4", op, join, buagegr4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_buagegr4;


   procedure Add_heartbu( c : in out d.Criteria; heartbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heartbu", op, join, Long_Float( heartbu ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_heartbu;


   procedure Add_newfambu( c : in out d.Criteria; newfambu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "newfambu", op, join, newfambu );
   begin
      d.add_to_criteria( c, elem );
   end Add_newfambu;


   procedure Add_billnt9( c : in out d.Criteria; billnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "billnt9", op, join, billnt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt9;


   procedure Add_cbaamt1( c : in out d.Criteria; cbaamt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cbaamt1", op, join, cbaamt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbaamt1;


   procedure Add_cbaamt2( c : in out d.Criteria; cbaamt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cbaamt2", op, join, cbaamt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbaamt2;


   procedure Add_coatnt9( c : in out d.Criteria; coatnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coatnt9", op, join, coatnt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt9;


   procedure Add_cooknt9( c : in out d.Criteria; cooknt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cooknt9", op, join, cooknt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt9;


   procedure Add_dampnt9( c : in out d.Criteria; dampnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dampnt9", op, join, dampnt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt9;


   procedure Add_frndnt9( c : in out d.Criteria; frndnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "frndnt9", op, join, frndnt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt9;


   procedure Add_hairnt9( c : in out d.Criteria; hairnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hairnt9", op, join, hairnt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt9;


   procedure Add_hbolng( c : in out d.Criteria; hbolng : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbolng", op, join, hbolng );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbolng;


   procedure Add_hbothamt( c : in out d.Criteria; hbothamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbothamt", op, join, Long_Float( hbothamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbothamt;


   procedure Add_hbothbu( c : in out d.Criteria; hbothbu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbothbu", op, join, hbothbu );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbothbu;


   procedure Add_hbothmn( c : in out d.Criteria; hbothmn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbothmn", op, join, hbothmn );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbothmn;


   procedure Add_hbothpd( c : in out d.Criteria; hbothpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbothpd", op, join, hbothpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbothpd;


   procedure Add_hbothwk( c : in out d.Criteria; hbothwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbothwk", op, join, hbothwk );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbothwk;


   procedure Add_hbothyr( c : in out d.Criteria; hbothyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbothyr", op, join, hbothyr );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbothyr;


   procedure Add_hbotwait( c : in out d.Criteria; hbotwait : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbotwait", op, join, hbotwait );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbotwait;


   procedure Add_heatnt9( c : in out d.Criteria; heatnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heatnt9", op, join, heatnt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt9;


   procedure Add_helpgv01( c : in out d.Criteria; helpgv01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helpgv01", op, join, helpgv01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv01;


   procedure Add_helpgv02( c : in out d.Criteria; helpgv02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helpgv02", op, join, helpgv02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv02;


   procedure Add_helpgv03( c : in out d.Criteria; helpgv03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helpgv03", op, join, helpgv03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv03;


   procedure Add_helpgv04( c : in out d.Criteria; helpgv04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helpgv04", op, join, helpgv04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv04;


   procedure Add_helpgv05( c : in out d.Criteria; helpgv05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helpgv05", op, join, helpgv05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv05;


   procedure Add_helpgv06( c : in out d.Criteria; helpgv06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helpgv06", op, join, helpgv06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv06;


   procedure Add_helpgv07( c : in out d.Criteria; helpgv07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helpgv07", op, join, helpgv07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv07;


   procedure Add_helpgv08( c : in out d.Criteria; helpgv08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helpgv08", op, join, helpgv08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv08;


   procedure Add_helpgv09( c : in out d.Criteria; helpgv09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helpgv09", op, join, helpgv09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv09;


   procedure Add_helpgv10( c : in out d.Criteria; helpgv10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helpgv10", op, join, helpgv10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv10;


   procedure Add_helpgv11( c : in out d.Criteria; helpgv11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helpgv11", op, join, helpgv11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv11;


   procedure Add_helprc01( c : in out d.Criteria; helprc01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helprc01", op, join, helprc01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc01;


   procedure Add_helprc02( c : in out d.Criteria; helprc02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helprc02", op, join, helprc02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc02;


   procedure Add_helprc03( c : in out d.Criteria; helprc03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helprc03", op, join, helprc03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc03;


   procedure Add_helprc04( c : in out d.Criteria; helprc04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helprc04", op, join, helprc04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc04;


   procedure Add_helprc05( c : in out d.Criteria; helprc05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helprc05", op, join, helprc05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc05;


   procedure Add_helprc06( c : in out d.Criteria; helprc06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helprc06", op, join, helprc06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc06;


   procedure Add_helprc07( c : in out d.Criteria; helprc07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helprc07", op, join, helprc07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc07;


   procedure Add_helprc08( c : in out d.Criteria; helprc08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helprc08", op, join, helprc08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc08;


   procedure Add_helprc09( c : in out d.Criteria; helprc09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helprc09", op, join, helprc09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc09;


   procedure Add_helprc10( c : in out d.Criteria; helprc10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helprc10", op, join, helprc10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc10;


   procedure Add_helprc11( c : in out d.Criteria; helprc11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "helprc11", op, join, helprc11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc11;


   procedure Add_holnt9( c : in out d.Criteria; holnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "holnt9", op, join, holnt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt9;


   procedure Add_homent9( c : in out d.Criteria; homent9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "homent9", op, join, homent9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent9;


   procedure Add_loangvn1( c : in out d.Criteria; loangvn1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "loangvn1", op, join, loangvn1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_loangvn1;


   procedure Add_loangvn2( c : in out d.Criteria; loangvn2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "loangvn2", op, join, loangvn2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_loangvn2;


   procedure Add_loangvn3( c : in out d.Criteria; loangvn3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "loangvn3", op, join, loangvn3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_loangvn3;


   procedure Add_loanrec1( c : in out d.Criteria; loanrec1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "loanrec1", op, join, loanrec1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_loanrec1;


   procedure Add_loanrec2( c : in out d.Criteria; loanrec2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "loanrec2", op, join, loanrec2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_loanrec2;


   procedure Add_loanrec3( c : in out d.Criteria; loanrec3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "loanrec3", op, join, loanrec3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_loanrec3;


   procedure Add_mealnt9( c : in out d.Criteria; mealnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mealnt9", op, join, mealnt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt9;


   procedure Add_outnt9( c : in out d.Criteria; outnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "outnt9", op, join, outnt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt9;


   procedure Add_phonnt9( c : in out d.Criteria; phonnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "phonnt9", op, join, phonnt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt9;


   procedure Add_taxint9( c : in out d.Criteria; taxint9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxint9", op, join, taxint9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint9;


   procedure Add_warmnt9( c : in out d.Criteria; warmnt9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "warmnt9", op, join, warmnt9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt9;


   procedure Add_ecostabu( c : in out d.Criteria; ecostabu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ecostabu", op, join, ecostabu );
   begin
      d.add_to_criteria( c, elem );
   end Add_ecostabu;


   procedure Add_famtypb2( c : in out d.Criteria; famtypb2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "famtypb2", op, join, famtypb2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_famtypb2;


   procedure Add_gross3_x( c : in out d.Criteria; gross3_x : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gross3_x", op, join, gross3_x );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross3_x;


   procedure Add_newfamb2( c : in out d.Criteria; newfamb2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "newfamb2", op, join, newfamb2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_newfamb2;


   procedure Add_oabilimp( c : in out d.Criteria; oabilimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oabilimp", op, join, oabilimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oabilimp;


   procedure Add_oacoaimp( c : in out d.Criteria; oacoaimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oacoaimp", op, join, oacoaimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacoaimp;


   procedure Add_oacooimp( c : in out d.Criteria; oacooimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oacooimp", op, join, oacooimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacooimp;


   procedure Add_oadamimp( c : in out d.Criteria; oadamimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oadamimp", op, join, oadamimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadamimp;


   procedure Add_oaexpimp( c : in out d.Criteria; oaexpimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaexpimp", op, join, oaexpimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaexpimp;


   procedure Add_oafrnimp( c : in out d.Criteria; oafrnimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oafrnimp", op, join, oafrnimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oafrnimp;


   procedure Add_oahaiimp( c : in out d.Criteria; oahaiimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oahaiimp", op, join, oahaiimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahaiimp;


   procedure Add_oaheaimp( c : in out d.Criteria; oaheaimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaheaimp", op, join, oaheaimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaheaimp;


   procedure Add_oaholimp( c : in out d.Criteria; oaholimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaholimp", op, join, oaholimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaholimp;


   procedure Add_oahomimp( c : in out d.Criteria; oahomimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oahomimp", op, join, oahomimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahomimp;


   procedure Add_oameaimp( c : in out d.Criteria; oameaimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oameaimp", op, join, oameaimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oameaimp;


   procedure Add_oaoutimp( c : in out d.Criteria; oaoutimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaoutimp", op, join, oaoutimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaoutimp;


   procedure Add_oaphoimp( c : in out d.Criteria; oaphoimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaphoimp", op, join, oaphoimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaphoimp;


   procedure Add_oataximp( c : in out d.Criteria; oataximp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oataximp", op, join, oataximp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oataximp;


   procedure Add_oawarimp( c : in out d.Criteria; oawarimp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oawarimp", op, join, oawarimp );
   begin
      d.add_to_criteria( c, elem );
   end Add_oawarimp;


   procedure Add_totcapb3( c : in out d.Criteria; totcapb3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totcapb3", op, join, Long_Float( totcapb3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_totcapb3;


   procedure Add_adbtbl( c : in out d.Criteria; adbtbl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adbtbl", op, join, adbtbl );
   begin
      d.add_to_criteria( c, elem );
   end Add_adbtbl;


   procedure Add_cdepact( c : in out d.Criteria; cdepact : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdepact", op, join, cdepact );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdepact;


   procedure Add_cdepveg( c : in out d.Criteria; cdepveg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdepveg", op, join, cdepveg );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdepveg;


   procedure Add_cdpcoat( c : in out d.Criteria; cdpcoat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdpcoat", op, join, cdpcoat );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdpcoat;


   procedure Add_oapre( c : in out d.Criteria; oapre : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oapre", op, join, oapre );
   begin
      d.add_to_criteria( c, elem );
   end Add_oapre;


   procedure Add_buethgr3( c : in out d.Criteria; buethgr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "buethgr3", op, join, buethgr3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_buethgr3;


   procedure Add_fsbbu( c : in out d.Criteria; fsbbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fsbbu", op, join, Long_Float( fsbbu ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsbbu;


   procedure Add_addholr( c : in out d.Criteria; addholr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "addholr", op, join, addholr );
   begin
      d.add_to_criteria( c, elem );
   end Add_addholr;


   procedure Add_computer( c : in out d.Criteria; computer : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "computer", op, join, computer );
   begin
      d.add_to_criteria( c, elem );
   end Add_computer;


   procedure Add_compuwhy( c : in out d.Criteria; compuwhy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "compuwhy", op, join, compuwhy );
   begin
      d.add_to_criteria( c, elem );
   end Add_compuwhy;


   procedure Add_crime( c : in out d.Criteria; crime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "crime", op, join, crime );
   begin
      d.add_to_criteria( c, elem );
   end Add_crime;


   procedure Add_damp( c : in out d.Criteria; damp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "damp", op, join, damp );
   begin
      d.add_to_criteria( c, elem );
   end Add_damp;


   procedure Add_dark( c : in out d.Criteria; dark : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dark", op, join, dark );
   begin
      d.add_to_criteria( c, elem );
   end Add_dark;


   procedure Add_debt01( c : in out d.Criteria; debt01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt01", op, join, debt01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt01;


   procedure Add_debt02( c : in out d.Criteria; debt02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt02", op, join, debt02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt02;


   procedure Add_debt03( c : in out d.Criteria; debt03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt03", op, join, debt03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt03;


   procedure Add_debt04( c : in out d.Criteria; debt04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt04", op, join, debt04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt04;


   procedure Add_debt05( c : in out d.Criteria; debt05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt05", op, join, debt05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt05;


   procedure Add_debt06( c : in out d.Criteria; debt06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt06", op, join, debt06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt06;


   procedure Add_debt07( c : in out d.Criteria; debt07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt07", op, join, debt07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt07;


   procedure Add_debt08( c : in out d.Criteria; debt08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt08", op, join, debt08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt08;


   procedure Add_debt09( c : in out d.Criteria; debt09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt09", op, join, debt09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt09;


   procedure Add_debt10( c : in out d.Criteria; debt10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt10", op, join, debt10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt10;


   procedure Add_debt11( c : in out d.Criteria; debt11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt11", op, join, debt11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt11;


   procedure Add_debt12( c : in out d.Criteria; debt12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt12", op, join, debt12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt12;


   procedure Add_debtar01( c : in out d.Criteria; debtar01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar01", op, join, debtar01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar01;


   procedure Add_debtar02( c : in out d.Criteria; debtar02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar02", op, join, debtar02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar02;


   procedure Add_debtar03( c : in out d.Criteria; debtar03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar03", op, join, debtar03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar03;


   procedure Add_debtar04( c : in out d.Criteria; debtar04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar04", op, join, debtar04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar04;


   procedure Add_debtar05( c : in out d.Criteria; debtar05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar05", op, join, debtar05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar05;


   procedure Add_debtar06( c : in out d.Criteria; debtar06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar06", op, join, debtar06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar06;


   procedure Add_debtar07( c : in out d.Criteria; debtar07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar07", op, join, debtar07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar07;


   procedure Add_debtar08( c : in out d.Criteria; debtar08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar08", op, join, debtar08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar08;


   procedure Add_debtar09( c : in out d.Criteria; debtar09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar09", op, join, debtar09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar09;


   procedure Add_debtar10( c : in out d.Criteria; debtar10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar10", op, join, debtar10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar10;


   procedure Add_debtar11( c : in out d.Criteria; debtar11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar11", op, join, debtar11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar11;


   procedure Add_debtar12( c : in out d.Criteria; debtar12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar12", op, join, debtar12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar12;


   procedure Add_debtfre1( c : in out d.Criteria; debtfre1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtfre1", op, join, debtfre1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtfre1;


   procedure Add_debtfre2( c : in out d.Criteria; debtfre2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtfre2", op, join, debtfre2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtfre2;


   procedure Add_debtfre3( c : in out d.Criteria; debtfre3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtfre3", op, join, debtfre3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtfre3;


   procedure Add_endsmeet( c : in out d.Criteria; endsmeet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "endsmeet", op, join, endsmeet );
   begin
      d.add_to_criteria( c, elem );
   end Add_endsmeet;


   procedure Add_eucar( c : in out d.Criteria; eucar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eucar", op, join, eucar );
   begin
      d.add_to_criteria( c, elem );
   end Add_eucar;


   procedure Add_eucarwhy( c : in out d.Criteria; eucarwhy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eucarwhy", op, join, eucarwhy );
   begin
      d.add_to_criteria( c, elem );
   end Add_eucarwhy;


   procedure Add_euexpns( c : in out d.Criteria; euexpns : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euexpns", op, join, euexpns );
   begin
      d.add_to_criteria( c, elem );
   end Add_euexpns;


   procedure Add_eumeal( c : in out d.Criteria; eumeal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eumeal", op, join, eumeal );
   begin
      d.add_to_criteria( c, elem );
   end Add_eumeal;


   procedure Add_eurepay( c : in out d.Criteria; eurepay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eurepay", op, join, eurepay );
   begin
      d.add_to_criteria( c, elem );
   end Add_eurepay;


   procedure Add_euteleph( c : in out d.Criteria; euteleph : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euteleph", op, join, euteleph );
   begin
      d.add_to_criteria( c, elem );
   end Add_euteleph;


   procedure Add_eutelwhy( c : in out d.Criteria; eutelwhy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eutelwhy", op, join, eutelwhy );
   begin
      d.add_to_criteria( c, elem );
   end Add_eutelwhy;


   procedure Add_expnsoa( c : in out d.Criteria; expnsoa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "expnsoa", op, join, expnsoa );
   begin
      d.add_to_criteria( c, elem );
   end Add_expnsoa;


   procedure Add_houshew( c : in out d.Criteria; houshew : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "houshew", op, join, houshew );
   begin
      d.add_to_criteria( c, elem );
   end Add_houshew;


   procedure Add_noise( c : in out d.Criteria; noise : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "noise", op, join, noise );
   begin
      d.add_to_criteria( c, elem );
   end Add_noise;


   procedure Add_oacareu1( c : in out d.Criteria; oacareu1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oacareu1", op, join, oacareu1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu1;


   procedure Add_oacareu2( c : in out d.Criteria; oacareu2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oacareu2", op, join, oacareu2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu2;


   procedure Add_oacareu3( c : in out d.Criteria; oacareu3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oacareu3", op, join, oacareu3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu3;


   procedure Add_oacareu4( c : in out d.Criteria; oacareu4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oacareu4", op, join, oacareu4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu4;


   procedure Add_oacareu5( c : in out d.Criteria; oacareu5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oacareu5", op, join, oacareu5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu5;


   procedure Add_oacareu6( c : in out d.Criteria; oacareu6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oacareu6", op, join, oacareu6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu6;


   procedure Add_oacareu7( c : in out d.Criteria; oacareu7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oacareu7", op, join, oacareu7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu7;


   procedure Add_oacareu8( c : in out d.Criteria; oacareu8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oacareu8", op, join, oacareu8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu8;


   procedure Add_oataxieu( c : in out d.Criteria; oataxieu : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oataxieu", op, join, oataxieu );
   begin
      d.add_to_criteria( c, elem );
   end Add_oataxieu;


   procedure Add_oatelep1( c : in out d.Criteria; oatelep1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oatelep1", op, join, oatelep1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep1;


   procedure Add_oatelep2( c : in out d.Criteria; oatelep2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oatelep2", op, join, oatelep2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep2;


   procedure Add_oatelep3( c : in out d.Criteria; oatelep3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oatelep3", op, join, oatelep3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep3;


   procedure Add_oatelep4( c : in out d.Criteria; oatelep4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oatelep4", op, join, oatelep4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep4;


   procedure Add_oatelep5( c : in out d.Criteria; oatelep5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oatelep5", op, join, oatelep5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep5;


   procedure Add_oatelep6( c : in out d.Criteria; oatelep6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oatelep6", op, join, oatelep6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep6;


   procedure Add_oatelep7( c : in out d.Criteria; oatelep7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oatelep7", op, join, oatelep7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep7;


   procedure Add_oatelep8( c : in out d.Criteria; oatelep8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oatelep8", op, join, oatelep8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep8;


   procedure Add_oateleph( c : in out d.Criteria; oateleph : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oateleph", op, join, oateleph );
   begin
      d.add_to_criteria( c, elem );
   end Add_oateleph;


   procedure Add_outpay( c : in out d.Criteria; outpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "outpay", op, join, outpay );
   begin
      d.add_to_criteria( c, elem );
   end Add_outpay;


   procedure Add_outpyamt( c : in out d.Criteria; outpyamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "outpyamt", op, join, Long_Float( outpyamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_outpyamt;


   procedure Add_pollute( c : in out d.Criteria; pollute : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pollute", op, join, pollute );
   begin
      d.add_to_criteria( c, elem );
   end Add_pollute;


   procedure Add_regpamt( c : in out d.Criteria; regpamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "regpamt", op, join, Long_Float( regpamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_regpamt;


   procedure Add_regularp( c : in out d.Criteria; regularp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "regularp", op, join, regularp );
   begin
      d.add_to_criteria( c, elem );
   end Add_regularp;


   procedure Add_repaybur( c : in out d.Criteria; repaybur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "repaybur", op, join, repaybur );
   begin
      d.add_to_criteria( c, elem );
   end Add_repaybur;


   procedure Add_washmach( c : in out d.Criteria; washmach : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "washmach", op, join, washmach );
   begin
      d.add_to_criteria( c, elem );
   end Add_washmach;


   procedure Add_washwhy( c : in out d.Criteria; washwhy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "washwhy", op, join, washwhy );
   begin
      d.add_to_criteria( c, elem );
   end Add_washwhy;


   procedure Add_whodepq( c : in out d.Criteria; whodepq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whodepq", op, join, whodepq );
   begin
      d.add_to_criteria( c, elem );
   end Add_whodepq;


   procedure Add_discbua1( c : in out d.Criteria; discbua1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "discbua1", op, join, discbua1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_discbua1;


   procedure Add_discbuc1( c : in out d.Criteria; discbuc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "discbuc1", op, join, discbuc1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_discbuc1;


   procedure Add_diswbua1( c : in out d.Criteria; diswbua1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "diswbua1", op, join, diswbua1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_diswbua1;


   procedure Add_diswbuc1( c : in out d.Criteria; diswbuc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "diswbuc1", op, join, diswbuc1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_diswbuc1;


   procedure Add_fsfvbu( c : in out d.Criteria; fsfvbu : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fsfvbu", op, join, Long_Float( fsfvbu ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsfvbu;


   procedure Add_gross4( c : in out d.Criteria; gross4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gross4", op, join, gross4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross4;


   procedure Add_adles( c : in out d.Criteria; adles : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adles", op, join, adles );
   begin
      d.add_to_criteria( c, elem );
   end Add_adles;


   procedure Add_adlesnt1( c : in out d.Criteria; adlesnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adlesnt1", op, join, adlesnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt1;


   procedure Add_adlesnt2( c : in out d.Criteria; adlesnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adlesnt2", op, join, adlesnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt2;


   procedure Add_adlesnt3( c : in out d.Criteria; adlesnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adlesnt3", op, join, adlesnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt3;


   procedure Add_adlesnt4( c : in out d.Criteria; adlesnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adlesnt4", op, join, adlesnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt4;


   procedure Add_adlesnt5( c : in out d.Criteria; adlesnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adlesnt5", op, join, adlesnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt5;


   procedure Add_adlesnt6( c : in out d.Criteria; adlesnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adlesnt6", op, join, adlesnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt6;


   procedure Add_adlesnt7( c : in out d.Criteria; adlesnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adlesnt7", op, join, adlesnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt7;


   procedure Add_adlesnt8( c : in out d.Criteria; adlesnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adlesnt8", op, join, adlesnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt8;


   procedure Add_adlesoa( c : in out d.Criteria; adlesoa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adlesoa", op, join, adlesoa );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesoa;


   procedure Add_clothes( c : in out d.Criteria; clothes : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "clothes", op, join, clothes );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothes;


   procedure Add_clothnt1( c : in out d.Criteria; clothnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "clothnt1", op, join, clothnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt1;


   procedure Add_clothnt2( c : in out d.Criteria; clothnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "clothnt2", op, join, clothnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt2;


   procedure Add_clothnt3( c : in out d.Criteria; clothnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "clothnt3", op, join, clothnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt3;


   procedure Add_clothnt4( c : in out d.Criteria; clothnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "clothnt4", op, join, clothnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt4;


   procedure Add_clothnt5( c : in out d.Criteria; clothnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "clothnt5", op, join, clothnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt5;


   procedure Add_clothnt6( c : in out d.Criteria; clothnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "clothnt6", op, join, clothnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt6;


   procedure Add_clothnt7( c : in out d.Criteria; clothnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "clothnt7", op, join, clothnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt7;


   procedure Add_clothnt8( c : in out d.Criteria; clothnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "clothnt8", op, join, clothnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt8;


   procedure Add_clothsoa( c : in out d.Criteria; clothsoa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "clothsoa", op, join, clothsoa );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothsoa;


   procedure Add_furnt1( c : in out d.Criteria; furnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "furnt1", op, join, furnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt1;


   procedure Add_furnt2( c : in out d.Criteria; furnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "furnt2", op, join, furnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt2;


   procedure Add_furnt3( c : in out d.Criteria; furnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "furnt3", op, join, furnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt3;


   procedure Add_furnt4( c : in out d.Criteria; furnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "furnt4", op, join, furnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt4;


   procedure Add_furnt5( c : in out d.Criteria; furnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "furnt5", op, join, furnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt5;


   procedure Add_furnt6( c : in out d.Criteria; furnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "furnt6", op, join, furnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt6;


   procedure Add_furnt7( c : in out d.Criteria; furnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "furnt7", op, join, furnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt7;


   procedure Add_furnt8( c : in out d.Criteria; furnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "furnt8", op, join, furnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt8;


   procedure Add_intntnt1( c : in out d.Criteria; intntnt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intntnt1", op, join, intntnt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt1;


   procedure Add_intntnt2( c : in out d.Criteria; intntnt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intntnt2", op, join, intntnt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt2;


   procedure Add_intntnt3( c : in out d.Criteria; intntnt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intntnt3", op, join, intntnt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt3;


   procedure Add_intntnt4( c : in out d.Criteria; intntnt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intntnt4", op, join, intntnt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt4;


   procedure Add_intntnt5( c : in out d.Criteria; intntnt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intntnt5", op, join, intntnt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt5;


   procedure Add_intntnt6( c : in out d.Criteria; intntnt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intntnt6", op, join, intntnt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt6;


   procedure Add_intntnt7( c : in out d.Criteria; intntnt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intntnt7", op, join, intntnt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt7;


   procedure Add_intntnt8( c : in out d.Criteria; intntnt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intntnt8", op, join, intntnt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt8;


   procedure Add_intrnet( c : in out d.Criteria; intrnet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intrnet", op, join, intrnet );
   begin
      d.add_to_criteria( c, elem );
   end Add_intrnet;


   procedure Add_meal( c : in out d.Criteria; meal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "meal", op, join, meal );
   begin
      d.add_to_criteria( c, elem );
   end Add_meal;


   procedure Add_oadep2( c : in out d.Criteria; oadep2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oadep2", op, join, oadep2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadep2;


   procedure Add_oadp2nt1( c : in out d.Criteria; oadp2nt1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oadp2nt1", op, join, oadp2nt1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt1;


   procedure Add_oadp2nt2( c : in out d.Criteria; oadp2nt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oadp2nt2", op, join, oadp2nt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt2;


   procedure Add_oadp2nt3( c : in out d.Criteria; oadp2nt3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oadp2nt3", op, join, oadp2nt3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt3;


   procedure Add_oadp2nt4( c : in out d.Criteria; oadp2nt4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oadp2nt4", op, join, oadp2nt4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt4;


   procedure Add_oadp2nt5( c : in out d.Criteria; oadp2nt5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oadp2nt5", op, join, oadp2nt5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt5;


   procedure Add_oadp2nt6( c : in out d.Criteria; oadp2nt6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oadp2nt6", op, join, oadp2nt6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt6;


   procedure Add_oadp2nt7( c : in out d.Criteria; oadp2nt7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oadp2nt7", op, join, oadp2nt7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt7;


   procedure Add_oadp2nt8( c : in out d.Criteria; oadp2nt8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oadp2nt8", op, join, oadp2nt8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt8;


   procedure Add_oafur( c : in out d.Criteria; oafur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oafur", op, join, oafur );
   begin
      d.add_to_criteria( c, elem );
   end Add_oafur;


   procedure Add_oaintern( c : in out d.Criteria; oaintern : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaintern", op, join, oaintern );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaintern;


   procedure Add_shoe( c : in out d.Criteria; shoe : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "shoe", op, join, shoe );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoe;


   procedure Add_shoent1( c : in out d.Criteria; shoent1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "shoent1", op, join, shoent1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent1;


   procedure Add_shoent2( c : in out d.Criteria; shoent2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "shoent2", op, join, shoent2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent2;


   procedure Add_shoent3( c : in out d.Criteria; shoent3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "shoent3", op, join, shoent3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent3;


   procedure Add_shoent4( c : in out d.Criteria; shoent4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "shoent4", op, join, shoent4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent4;


   procedure Add_shoent5( c : in out d.Criteria; shoent5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "shoent5", op, join, shoent5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent5;


   procedure Add_shoent6( c : in out d.Criteria; shoent6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "shoent6", op, join, shoent6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent6;


   procedure Add_shoent7( c : in out d.Criteria; shoent7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "shoent7", op, join, shoent7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent7;


   procedure Add_shoent8( c : in out d.Criteria; shoent8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "shoent8", op, join, shoent8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent8;


   procedure Add_shoeoa( c : in out d.Criteria; shoeoa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "shoeoa", op, join, shoeoa );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoeoa;


   procedure Add_nbunirbn( c : in out d.Criteria; nbunirbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nbunirbn", op, join, nbunirbn );
   begin
      d.add_to_criteria( c, elem );
   end Add_nbunirbn;


   procedure Add_nbuothbn( c : in out d.Criteria; nbuothbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nbuothbn", op, join, nbuothbn );
   begin
      d.add_to_criteria( c, elem );
   end Add_nbuothbn;


   procedure Add_debt13( c : in out d.Criteria; debt13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debt13", op, join, debt13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt13;


   procedure Add_debtar13( c : in out d.Criteria; debtar13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "debtar13", op, join, debtar13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar13;


   procedure Add_euchbook( c : in out d.Criteria; euchbook : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euchbook", op, join, euchbook );
   begin
      d.add_to_criteria( c, elem );
   end Add_euchbook;


   procedure Add_euchclth( c : in out d.Criteria; euchclth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euchclth", op, join, euchclth );
   begin
      d.add_to_criteria( c, elem );
   end Add_euchclth;


   procedure Add_euchgame( c : in out d.Criteria; euchgame : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euchgame", op, join, euchgame );
   begin
      d.add_to_criteria( c, elem );
   end Add_euchgame;


   procedure Add_euchmeat( c : in out d.Criteria; euchmeat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euchmeat", op, join, euchmeat );
   begin
      d.add_to_criteria( c, elem );
   end Add_euchmeat;


   procedure Add_euchshoe( c : in out d.Criteria; euchshoe : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euchshoe", op, join, euchshoe );
   begin
      d.add_to_criteria( c, elem );
   end Add_euchshoe;


   procedure Add_eupbtran( c : in out d.Criteria; eupbtran : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eupbtran", op, join, eupbtran );
   begin
      d.add_to_criteria( c, elem );
   end Add_eupbtran;


   procedure Add_eupbtrn1( c : in out d.Criteria; eupbtrn1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eupbtrn1", op, join, eupbtrn1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_eupbtrn1;


   procedure Add_eupbtrn2( c : in out d.Criteria; eupbtrn2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eupbtrn2", op, join, eupbtrn2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_eupbtrn2;


   procedure Add_eupbtrn3( c : in out d.Criteria; eupbtrn3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eupbtrn3", op, join, eupbtrn3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_eupbtrn3;


   procedure Add_eupbtrn4( c : in out d.Criteria; eupbtrn4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eupbtrn4", op, join, eupbtrn4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_eupbtrn4;


   procedure Add_eupbtrn5( c : in out d.Criteria; eupbtrn5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eupbtrn5", op, join, eupbtrn5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_eupbtrn5;


   procedure Add_euroast( c : in out d.Criteria; euroast : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euroast", op, join, euroast );
   begin
      d.add_to_criteria( c, elem );
   end Add_euroast;


   procedure Add_eusmeal( c : in out d.Criteria; eusmeal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eusmeal", op, join, eusmeal );
   begin
      d.add_to_criteria( c, elem );
   end Add_eusmeal;


   procedure Add_eustudy( c : in out d.Criteria; eustudy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eustudy", op, join, eustudy );
   begin
      d.add_to_criteria( c, elem );
   end Add_eustudy;


   procedure Add_bueth( c : in out d.Criteria; bueth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bueth", op, join, bueth );
   begin
      d.add_to_criteria( c, elem );
   end Add_bueth;


   procedure Add_oaeusmea( c : in out d.Criteria; oaeusmea : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaeusmea", op, join, oaeusmea );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaeusmea;


   procedure Add_oaholb( c : in out d.Criteria; oaholb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaholb", op, join, oaholb );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaholb;


   procedure Add_oaroast( c : in out d.Criteria; oaroast : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oaroast", op, join, oaroast );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaroast;


   procedure Add_ecostab2( c : in out d.Criteria; ecostab2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ecostab2", op, join, ecostab2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ecostab2;


   
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


   procedure Add_benunit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benunit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benunit_To_Orderings;


   procedure Add_incchnge_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incchnge", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incchnge_To_Orderings;


   procedure Add_inchilow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inchilow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inchilow_To_Orderings;


   procedure Add_kidinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidinc_To_Orderings;


   procedure Add_nhhchild_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nhhchild", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhhchild_To_Orderings;


   procedure Add_totsav_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totsav", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totsav_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;


   procedure Add_actaccb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "actaccb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_actaccb_To_Orderings;


   procedure Add_adddabu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adddabu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adddabu_To_Orderings;


   procedure Add_adultb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adultb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adultb_To_Orderings;


   procedure Add_basactb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "basactb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_basactb_To_Orderings;


   procedure Add_boarder_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "boarder", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_boarder_To_Orderings;


   procedure Add_bpeninc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bpeninc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bpeninc_To_Orderings;


   procedure Add_bseinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bseinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bseinc_To_Orderings;


   procedure Add_buagegr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buagegr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buagegr2_To_Orderings;


   procedure Add_buagegrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buagegrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buagegrp_To_Orderings;


   procedure Add_budisben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "budisben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_budisben_To_Orderings;


   procedure Add_buearns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buearns", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buearns_To_Orderings;


   procedure Add_buethgr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buethgr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buethgr2_To_Orderings;


   procedure Add_buethgrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buethgrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buethgrp_To_Orderings;


   procedure Add_buinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buinc_To_Orderings;


   procedure Add_buinv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buinv", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buinv_To_Orderings;


   procedure Add_buirben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buirben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buirben_To_Orderings;


   procedure Add_bukids_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bukids", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bukids_To_Orderings;


   procedure Add_bunirben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bunirben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bunirben_To_Orderings;


   procedure Add_buothben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buothben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buothben_To_Orderings;


   procedure Add_burent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "burent", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_burent_To_Orderings;


   procedure Add_burinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "burinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_burinc_To_Orderings;


   procedure Add_burpinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "burpinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_burpinc_To_Orderings;


   procedure Add_butvlic_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "butvlic", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_butvlic_To_Orderings;


   procedure Add_butxcred_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "butxcred", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_butxcred_To_Orderings;


   procedure Add_chddabu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chddabu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chddabu_To_Orderings;


   procedure Add_curactb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "curactb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_curactb_To_Orderings;


   procedure Add_depchldb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "depchldb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_depchldb_To_Orderings;


   procedure Add_depdeds_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "depdeds", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_depdeds_To_Orderings;


   procedure Add_disindhb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disindhb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disindhb_To_Orderings;


   procedure Add_ecotypbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ecotypbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ecotypbu_To_Orderings;


   procedure Add_ecstatbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ecstatbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ecstatbu_To_Orderings;


   procedure Add_famthbai_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "famthbai", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_famthbai_To_Orderings;


   procedure Add_famtypbs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "famtypbs", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_famtypbs_To_Orderings;


   procedure Add_famtypbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "famtypbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_famtypbu_To_Orderings;


   procedure Add_famtype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "famtype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_famtype_To_Orderings;


   procedure Add_fsbndctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fsbndctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsbndctb_To_Orderings;


   procedure Add_fsmbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fsmbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsmbu_To_Orderings;


   procedure Add_fsmlkbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fsmlkbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsmlkbu_To_Orderings;


   procedure Add_fwmlkbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fwmlkbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fwmlkbu_To_Orderings;


   procedure Add_gebactb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gebactb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gebactb_To_Orderings;


   procedure Add_giltctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "giltctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_giltctb_To_Orderings;


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


   procedure Add_hbindbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbindbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbindbu_To_Orderings;


   procedure Add_isactb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "isactb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_isactb_To_Orderings;


   procedure Add_kid04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kid04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kid04_To_Orderings;


   procedure Add_kid1115_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kid1115", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kid1115_To_Orderings;


   procedure Add_kid1618_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kid1618", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kid1618_To_Orderings;


   procedure Add_kid510_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kid510", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kid510_To_Orderings;


   procedure Add_kidsbu0_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu0", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu0_To_Orderings;


   procedure Add_kidsbu1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu1_To_Orderings;


   procedure Add_kidsbu10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu10_To_Orderings;


   procedure Add_kidsbu11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu11_To_Orderings;


   procedure Add_kidsbu12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu12_To_Orderings;


   procedure Add_kidsbu13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu13_To_Orderings;


   procedure Add_kidsbu14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu14_To_Orderings;


   procedure Add_kidsbu15_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu15", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu15_To_Orderings;


   procedure Add_kidsbu16_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu16", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu16_To_Orderings;


   procedure Add_kidsbu17_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu17", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu17_To_Orderings;


   procedure Add_kidsbu18_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu18", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu18_To_Orderings;


   procedure Add_kidsbu2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu2_To_Orderings;


   procedure Add_kidsbu3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu3_To_Orderings;


   procedure Add_kidsbu4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu4_To_Orderings;


   procedure Add_kidsbu5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu5_To_Orderings;


   procedure Add_kidsbu6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu6_To_Orderings;


   procedure Add_kidsbu7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu7_To_Orderings;


   procedure Add_kidsbu8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu8_To_Orderings;


   procedure Add_kidsbu9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidsbu9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidsbu9_To_Orderings;


   procedure Add_lastwork_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lastwork", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lastwork_To_Orderings;


   procedure Add_lodger_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lodger", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lodger_To_Orderings;


   procedure Add_nsboctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nsboctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nsboctb_To_Orderings;


   procedure Add_otbsctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "otbsctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_otbsctb_To_Orderings;


   procedure Add_pepsctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pepsctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pepsctb_To_Orderings;


   procedure Add_poacctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "poacctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_poacctb_To_Orderings;


   procedure Add_prboctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "prboctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_prboctb_To_Orderings;


   procedure Add_sayectb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sayectb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sayectb_To_Orderings;


   procedure Add_sclbctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sclbctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sclbctb_To_Orderings;


   procedure Add_ssctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ssctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ssctb_To_Orderings;


   procedure Add_stshctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "stshctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_stshctb_To_Orderings;


   procedure Add_subltamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "subltamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_subltamt_To_Orderings;


   procedure Add_tessctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tessctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tessctb_To_Orderings;


   procedure Add_totcapbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totcapbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totcapbu_To_Orderings;


   procedure Add_totsavbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totsavbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totsavbu_To_Orderings;


   procedure Add_tuburent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tuburent", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tuburent_To_Orderings;


   procedure Add_untrctb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "untrctb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_untrctb_To_Orderings;


   procedure Add_youngch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "youngch", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_youngch_To_Orderings;


   procedure Add_adddec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adddec", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adddec_To_Orderings;


   procedure Add_addeples_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "addeples", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_addeples_To_Orderings;


   procedure Add_addhol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "addhol", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_addhol_To_Orderings;


   procedure Add_addins_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "addins", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_addins_To_Orderings;


   procedure Add_addmel_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "addmel", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_addmel_To_Orderings;


   procedure Add_addmon_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "addmon", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_addmon_To_Orderings;


   procedure Add_addshoe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "addshoe", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_addshoe_To_Orderings;


   procedure Add_adepfur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adepfur", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adepfur_To_Orderings;


   procedure Add_af1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "af1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_af1_To_Orderings;


   procedure Add_afdep2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "afdep2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_afdep2_To_Orderings;


   procedure Add_cdelply_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdelply", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdelply_To_Orderings;


   procedure Add_cdepbed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdepbed", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdepbed_To_Orderings;


   procedure Add_cdepcel_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdepcel", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdepcel_To_Orderings;


   procedure Add_cdepeqp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdepeqp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdepeqp_To_Orderings;


   procedure Add_cdephol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdephol", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdephol_To_Orderings;


   procedure Add_cdeples_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdeples", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdeples_To_Orderings;


   procedure Add_cdepsum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdepsum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdepsum_To_Orderings;


   procedure Add_cdeptea_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdeptea", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdeptea_To_Orderings;


   procedure Add_cdeptrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdeptrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdeptrp_To_Orderings;


   procedure Add_cplay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cplay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cplay_To_Orderings;


   procedure Add_debt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt1_To_Orderings;


   procedure Add_debt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt2_To_Orderings;


   procedure Add_debt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt3_To_Orderings;


   procedure Add_debt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt4_To_Orderings;


   procedure Add_debt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt5_To_Orderings;


   procedure Add_debt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt6_To_Orderings;


   procedure Add_debt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt7_To_Orderings;


   procedure Add_debt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt8_To_Orderings;


   procedure Add_debt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt9_To_Orderings;


   procedure Add_houshe1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "houshe1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_houshe1_To_Orderings;


   procedure Add_incold_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incold", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incold_To_Orderings;


   procedure Add_crunacb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "crunacb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_crunacb_To_Orderings;


   procedure Add_enomortb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "enomortb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_enomortb_To_Orderings;


   procedure Add_hbindbu2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbindbu2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbindbu2_To_Orderings;


   procedure Add_pocardb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pocardb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pocardb_To_Orderings;


   procedure Add_kid1619_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kid1619", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kid1619_To_Orderings;


   procedure Add_totcapb2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totcapb2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totcapb2_To_Orderings;


   procedure Add_billnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "billnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt1_To_Orderings;


   procedure Add_billnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "billnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt2_To_Orderings;


   procedure Add_billnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "billnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt3_To_Orderings;


   procedure Add_billnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "billnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt4_To_Orderings;


   procedure Add_billnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "billnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt5_To_Orderings;


   procedure Add_billnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "billnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt6_To_Orderings;


   procedure Add_billnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "billnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt7_To_Orderings;


   procedure Add_billnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "billnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt8_To_Orderings;


   procedure Add_coatnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coatnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt1_To_Orderings;


   procedure Add_coatnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coatnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt2_To_Orderings;


   procedure Add_coatnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coatnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt3_To_Orderings;


   procedure Add_coatnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coatnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt4_To_Orderings;


   procedure Add_coatnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coatnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt5_To_Orderings;


   procedure Add_coatnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coatnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt6_To_Orderings;


   procedure Add_coatnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coatnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt7_To_Orderings;


   procedure Add_coatnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coatnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt8_To_Orderings;


   procedure Add_cooknt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cooknt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt1_To_Orderings;


   procedure Add_cooknt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cooknt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt2_To_Orderings;


   procedure Add_cooknt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cooknt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt3_To_Orderings;


   procedure Add_cooknt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cooknt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt4_To_Orderings;


   procedure Add_cooknt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cooknt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt5_To_Orderings;


   procedure Add_cooknt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cooknt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt6_To_Orderings;


   procedure Add_cooknt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cooknt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt7_To_Orderings;


   procedure Add_cooknt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cooknt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt8_To_Orderings;


   procedure Add_dampnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dampnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt1_To_Orderings;


   procedure Add_dampnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dampnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt2_To_Orderings;


   procedure Add_dampnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dampnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt3_To_Orderings;


   procedure Add_dampnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dampnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt4_To_Orderings;


   procedure Add_dampnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dampnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt5_To_Orderings;


   procedure Add_dampnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dampnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt6_To_Orderings;


   procedure Add_dampnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dampnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt7_To_Orderings;


   procedure Add_dampnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dampnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt8_To_Orderings;


   procedure Add_frndnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "frndnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt1_To_Orderings;


   procedure Add_frndnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "frndnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt2_To_Orderings;


   procedure Add_frndnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "frndnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt3_To_Orderings;


   procedure Add_frndnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "frndnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt4_To_Orderings;


   procedure Add_frndnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "frndnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt5_To_Orderings;


   procedure Add_frndnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "frndnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt6_To_Orderings;


   procedure Add_frndnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "frndnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt7_To_Orderings;


   procedure Add_frndnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "frndnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt8_To_Orderings;


   procedure Add_hairnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hairnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt1_To_Orderings;


   procedure Add_hairnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hairnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt2_To_Orderings;


   procedure Add_hairnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hairnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt3_To_Orderings;


   procedure Add_hairnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hairnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt4_To_Orderings;


   procedure Add_hairnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hairnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt5_To_Orderings;


   procedure Add_hairnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hairnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt6_To_Orderings;


   procedure Add_hairnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hairnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt7_To_Orderings;


   procedure Add_hairnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hairnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt8_To_Orderings;


   procedure Add_heatnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heatnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt1_To_Orderings;


   procedure Add_heatnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heatnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt2_To_Orderings;


   procedure Add_heatnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heatnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt3_To_Orderings;


   procedure Add_heatnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heatnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt4_To_Orderings;


   procedure Add_heatnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heatnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt5_To_Orderings;


   procedure Add_heatnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heatnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt6_To_Orderings;


   procedure Add_heatnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heatnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt7_To_Orderings;


   procedure Add_heatnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heatnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt8_To_Orderings;


   procedure Add_holnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "holnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt1_To_Orderings;


   procedure Add_holnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "holnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt2_To_Orderings;


   procedure Add_holnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "holnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt3_To_Orderings;


   procedure Add_holnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "holnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt4_To_Orderings;


   procedure Add_holnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "holnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt5_To_Orderings;


   procedure Add_holnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "holnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt6_To_Orderings;


   procedure Add_holnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "holnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt7_To_Orderings;


   procedure Add_holnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "holnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt8_To_Orderings;


   procedure Add_homent1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "homent1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent1_To_Orderings;


   procedure Add_homent2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "homent2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent2_To_Orderings;


   procedure Add_homent3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "homent3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent3_To_Orderings;


   procedure Add_homent4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "homent4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent4_To_Orderings;


   procedure Add_homent5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "homent5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent5_To_Orderings;


   procedure Add_homent6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "homent6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent6_To_Orderings;


   procedure Add_homent7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "homent7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent7_To_Orderings;


   procedure Add_homent8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "homent8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent8_To_Orderings;


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;


   procedure Add_mealnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mealnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt1_To_Orderings;


   procedure Add_mealnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mealnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt2_To_Orderings;


   procedure Add_mealnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mealnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt3_To_Orderings;


   procedure Add_mealnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mealnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt4_To_Orderings;


   procedure Add_mealnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mealnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt5_To_Orderings;


   procedure Add_mealnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mealnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt6_To_Orderings;


   procedure Add_mealnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mealnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt7_To_Orderings;


   procedure Add_mealnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mealnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt8_To_Orderings;


   procedure Add_oabill_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oabill", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oabill_To_Orderings;


   procedure Add_oacoat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oacoat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacoat_To_Orderings;


   procedure Add_oacook_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oacook", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacook_To_Orderings;


   procedure Add_oadamp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oadamp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadamp_To_Orderings;


   procedure Add_oaexpns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaexpns", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaexpns_To_Orderings;


   procedure Add_oafrnd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oafrnd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oafrnd_To_Orderings;


   procedure Add_oahair_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oahair", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahair_To_Orderings;


   procedure Add_oaheat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaheat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaheat_To_Orderings;


   procedure Add_oahol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oahol", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahol_To_Orderings;


   procedure Add_oahome_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oahome", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahome_To_Orderings;


   procedure Add_oahowpy1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oahowpy1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahowpy1_To_Orderings;


   procedure Add_oahowpy2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oahowpy2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahowpy2_To_Orderings;


   procedure Add_oahowpy3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oahowpy3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahowpy3_To_Orderings;


   procedure Add_oahowpy4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oahowpy4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahowpy4_To_Orderings;


   procedure Add_oahowpy5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oahowpy5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahowpy5_To_Orderings;


   procedure Add_oahowpy6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oahowpy6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahowpy6_To_Orderings;


   procedure Add_oameal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oameal", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oameal_To_Orderings;


   procedure Add_oaout_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaout", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaout_To_Orderings;


   procedure Add_oaphon_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaphon", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaphon_To_Orderings;


   procedure Add_oataxi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oataxi", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oataxi_To_Orderings;


   procedure Add_oawarm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oawarm", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oawarm_To_Orderings;


   procedure Add_outnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "outnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt1_To_Orderings;


   procedure Add_outnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "outnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt2_To_Orderings;


   procedure Add_outnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "outnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt3_To_Orderings;


   procedure Add_outnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "outnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt4_To_Orderings;


   procedure Add_outnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "outnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt5_To_Orderings;


   procedure Add_outnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "outnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt6_To_Orderings;


   procedure Add_outnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "outnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt7_To_Orderings;


   procedure Add_outnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "outnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt8_To_Orderings;


   procedure Add_phonnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "phonnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt1_To_Orderings;


   procedure Add_phonnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "phonnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt2_To_Orderings;


   procedure Add_phonnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "phonnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt3_To_Orderings;


   procedure Add_phonnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "phonnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt4_To_Orderings;


   procedure Add_phonnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "phonnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt5_To_Orderings;


   procedure Add_phonnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "phonnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt6_To_Orderings;


   procedure Add_phonnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "phonnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt7_To_Orderings;


   procedure Add_phonnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "phonnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt8_To_Orderings;


   procedure Add_taxint1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxint1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint1_To_Orderings;


   procedure Add_taxint2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxint2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint2_To_Orderings;


   procedure Add_taxint3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxint3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint3_To_Orderings;


   procedure Add_taxint4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxint4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint4_To_Orderings;


   procedure Add_taxint5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxint5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint5_To_Orderings;


   procedure Add_taxint6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxint6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint6_To_Orderings;


   procedure Add_taxint7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxint7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint7_To_Orderings;


   procedure Add_taxint8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxint8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint8_To_Orderings;


   procedure Add_warmnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "warmnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt1_To_Orderings;


   procedure Add_warmnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "warmnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt2_To_Orderings;


   procedure Add_warmnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "warmnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt3_To_Orderings;


   procedure Add_warmnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "warmnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt4_To_Orderings;


   procedure Add_warmnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "warmnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt5_To_Orderings;


   procedure Add_warmnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "warmnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt6_To_Orderings;


   procedure Add_warmnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "warmnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt7_To_Orderings;


   procedure Add_warmnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "warmnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt8_To_Orderings;


   procedure Add_buagegr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buagegr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buagegr3_To_Orderings;


   procedure Add_buagegr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buagegr4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buagegr4_To_Orderings;


   procedure Add_heartbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heartbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heartbu_To_Orderings;


   procedure Add_newfambu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "newfambu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_newfambu_To_Orderings;


   procedure Add_billnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "billnt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_billnt9_To_Orderings;


   procedure Add_cbaamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cbaamt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbaamt1_To_Orderings;


   procedure Add_cbaamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cbaamt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbaamt2_To_Orderings;


   procedure Add_coatnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coatnt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coatnt9_To_Orderings;


   procedure Add_cooknt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cooknt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cooknt9_To_Orderings;


   procedure Add_dampnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dampnt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dampnt9_To_Orderings;


   procedure Add_frndnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "frndnt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_frndnt9_To_Orderings;


   procedure Add_hairnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hairnt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hairnt9_To_Orderings;


   procedure Add_hbolng_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbolng", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbolng_To_Orderings;


   procedure Add_hbothamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbothamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbothamt_To_Orderings;


   procedure Add_hbothbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbothbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbothbu_To_Orderings;


   procedure Add_hbothmn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbothmn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbothmn_To_Orderings;


   procedure Add_hbothpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbothpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbothpd_To_Orderings;


   procedure Add_hbothwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbothwk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbothwk_To_Orderings;


   procedure Add_hbothyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbothyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbothyr_To_Orderings;


   procedure Add_hbotwait_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbotwait", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbotwait_To_Orderings;


   procedure Add_heatnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heatnt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heatnt9_To_Orderings;


   procedure Add_helpgv01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helpgv01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv01_To_Orderings;


   procedure Add_helpgv02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helpgv02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv02_To_Orderings;


   procedure Add_helpgv03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helpgv03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv03_To_Orderings;


   procedure Add_helpgv04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helpgv04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv04_To_Orderings;


   procedure Add_helpgv05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helpgv05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv05_To_Orderings;


   procedure Add_helpgv06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helpgv06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv06_To_Orderings;


   procedure Add_helpgv07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helpgv07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv07_To_Orderings;


   procedure Add_helpgv08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helpgv08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv08_To_Orderings;


   procedure Add_helpgv09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helpgv09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv09_To_Orderings;


   procedure Add_helpgv10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helpgv10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv10_To_Orderings;


   procedure Add_helpgv11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helpgv11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helpgv11_To_Orderings;


   procedure Add_helprc01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helprc01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc01_To_Orderings;


   procedure Add_helprc02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helprc02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc02_To_Orderings;


   procedure Add_helprc03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helprc03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc03_To_Orderings;


   procedure Add_helprc04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helprc04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc04_To_Orderings;


   procedure Add_helprc05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helprc05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc05_To_Orderings;


   procedure Add_helprc06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helprc06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc06_To_Orderings;


   procedure Add_helprc07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helprc07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc07_To_Orderings;


   procedure Add_helprc08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helprc08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc08_To_Orderings;


   procedure Add_helprc09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helprc09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc09_To_Orderings;


   procedure Add_helprc10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helprc10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc10_To_Orderings;


   procedure Add_helprc11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "helprc11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_helprc11_To_Orderings;


   procedure Add_holnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "holnt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_holnt9_To_Orderings;


   procedure Add_homent9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "homent9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_homent9_To_Orderings;


   procedure Add_loangvn1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "loangvn1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_loangvn1_To_Orderings;


   procedure Add_loangvn2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "loangvn2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_loangvn2_To_Orderings;


   procedure Add_loangvn3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "loangvn3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_loangvn3_To_Orderings;


   procedure Add_loanrec1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "loanrec1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_loanrec1_To_Orderings;


   procedure Add_loanrec2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "loanrec2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_loanrec2_To_Orderings;


   procedure Add_loanrec3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "loanrec3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_loanrec3_To_Orderings;


   procedure Add_mealnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mealnt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mealnt9_To_Orderings;


   procedure Add_outnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "outnt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_outnt9_To_Orderings;


   procedure Add_phonnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "phonnt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_phonnt9_To_Orderings;


   procedure Add_taxint9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxint9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxint9_To_Orderings;


   procedure Add_warmnt9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "warmnt9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_warmnt9_To_Orderings;


   procedure Add_ecostabu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ecostabu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ecostabu_To_Orderings;


   procedure Add_famtypb2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "famtypb2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_famtypb2_To_Orderings;


   procedure Add_gross3_x_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gross3_x", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross3_x_To_Orderings;


   procedure Add_newfamb2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "newfamb2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_newfamb2_To_Orderings;


   procedure Add_oabilimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oabilimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oabilimp_To_Orderings;


   procedure Add_oacoaimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oacoaimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacoaimp_To_Orderings;


   procedure Add_oacooimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oacooimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacooimp_To_Orderings;


   procedure Add_oadamimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oadamimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadamimp_To_Orderings;


   procedure Add_oaexpimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaexpimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaexpimp_To_Orderings;


   procedure Add_oafrnimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oafrnimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oafrnimp_To_Orderings;


   procedure Add_oahaiimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oahaiimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahaiimp_To_Orderings;


   procedure Add_oaheaimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaheaimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaheaimp_To_Orderings;


   procedure Add_oaholimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaholimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaholimp_To_Orderings;


   procedure Add_oahomimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oahomimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oahomimp_To_Orderings;


   procedure Add_oameaimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oameaimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oameaimp_To_Orderings;


   procedure Add_oaoutimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaoutimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaoutimp_To_Orderings;


   procedure Add_oaphoimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaphoimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaphoimp_To_Orderings;


   procedure Add_oataximp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oataximp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oataximp_To_Orderings;


   procedure Add_oawarimp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oawarimp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oawarimp_To_Orderings;


   procedure Add_totcapb3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totcapb3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totcapb3_To_Orderings;


   procedure Add_adbtbl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adbtbl", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adbtbl_To_Orderings;


   procedure Add_cdepact_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdepact", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdepact_To_Orderings;


   procedure Add_cdepveg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdepveg", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdepveg_To_Orderings;


   procedure Add_cdpcoat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdpcoat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdpcoat_To_Orderings;


   procedure Add_oapre_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oapre", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oapre_To_Orderings;


   procedure Add_buethgr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "buethgr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_buethgr3_To_Orderings;


   procedure Add_fsbbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fsbbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsbbu_To_Orderings;


   procedure Add_addholr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "addholr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_addholr_To_Orderings;


   procedure Add_computer_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "computer", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_computer_To_Orderings;


   procedure Add_compuwhy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "compuwhy", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_compuwhy_To_Orderings;


   procedure Add_crime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "crime", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_crime_To_Orderings;


   procedure Add_damp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "damp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_damp_To_Orderings;


   procedure Add_dark_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dark", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dark_To_Orderings;


   procedure Add_debt01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt01_To_Orderings;


   procedure Add_debt02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt02_To_Orderings;


   procedure Add_debt03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt03_To_Orderings;


   procedure Add_debt04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt04_To_Orderings;


   procedure Add_debt05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt05_To_Orderings;


   procedure Add_debt06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt06_To_Orderings;


   procedure Add_debt07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt07_To_Orderings;


   procedure Add_debt08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt08_To_Orderings;


   procedure Add_debt09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt09_To_Orderings;


   procedure Add_debt10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt10_To_Orderings;


   procedure Add_debt11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt11_To_Orderings;


   procedure Add_debt12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt12_To_Orderings;


   procedure Add_debtar01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar01_To_Orderings;


   procedure Add_debtar02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar02_To_Orderings;


   procedure Add_debtar03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar03_To_Orderings;


   procedure Add_debtar04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar04_To_Orderings;


   procedure Add_debtar05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar05_To_Orderings;


   procedure Add_debtar06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar06_To_Orderings;


   procedure Add_debtar07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar07_To_Orderings;


   procedure Add_debtar08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar08_To_Orderings;


   procedure Add_debtar09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar09_To_Orderings;


   procedure Add_debtar10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar10_To_Orderings;


   procedure Add_debtar11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar11_To_Orderings;


   procedure Add_debtar12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar12_To_Orderings;


   procedure Add_debtfre1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtfre1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtfre1_To_Orderings;


   procedure Add_debtfre2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtfre2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtfre2_To_Orderings;


   procedure Add_debtfre3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtfre3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtfre3_To_Orderings;


   procedure Add_endsmeet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "endsmeet", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_endsmeet_To_Orderings;


   procedure Add_eucar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eucar", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eucar_To_Orderings;


   procedure Add_eucarwhy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eucarwhy", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eucarwhy_To_Orderings;


   procedure Add_euexpns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euexpns", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euexpns_To_Orderings;


   procedure Add_eumeal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eumeal", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eumeal_To_Orderings;


   procedure Add_eurepay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eurepay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eurepay_To_Orderings;


   procedure Add_euteleph_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euteleph", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euteleph_To_Orderings;


   procedure Add_eutelwhy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eutelwhy", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eutelwhy_To_Orderings;


   procedure Add_expnsoa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "expnsoa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_expnsoa_To_Orderings;


   procedure Add_houshew_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "houshew", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_houshew_To_Orderings;


   procedure Add_noise_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "noise", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_noise_To_Orderings;


   procedure Add_oacareu1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oacareu1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu1_To_Orderings;


   procedure Add_oacareu2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oacareu2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu2_To_Orderings;


   procedure Add_oacareu3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oacareu3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu3_To_Orderings;


   procedure Add_oacareu4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oacareu4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu4_To_Orderings;


   procedure Add_oacareu5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oacareu5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu5_To_Orderings;


   procedure Add_oacareu6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oacareu6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu6_To_Orderings;


   procedure Add_oacareu7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oacareu7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu7_To_Orderings;


   procedure Add_oacareu8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oacareu8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oacareu8_To_Orderings;


   procedure Add_oataxieu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oataxieu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oataxieu_To_Orderings;


   procedure Add_oatelep1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oatelep1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep1_To_Orderings;


   procedure Add_oatelep2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oatelep2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep2_To_Orderings;


   procedure Add_oatelep3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oatelep3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep3_To_Orderings;


   procedure Add_oatelep4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oatelep4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep4_To_Orderings;


   procedure Add_oatelep5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oatelep5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep5_To_Orderings;


   procedure Add_oatelep6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oatelep6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep6_To_Orderings;


   procedure Add_oatelep7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oatelep7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep7_To_Orderings;


   procedure Add_oatelep8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oatelep8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oatelep8_To_Orderings;


   procedure Add_oateleph_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oateleph", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oateleph_To_Orderings;


   procedure Add_outpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "outpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_outpay_To_Orderings;


   procedure Add_outpyamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "outpyamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_outpyamt_To_Orderings;


   procedure Add_pollute_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pollute", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pollute_To_Orderings;


   procedure Add_regpamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "regpamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_regpamt_To_Orderings;


   procedure Add_regularp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "regularp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_regularp_To_Orderings;


   procedure Add_repaybur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "repaybur", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_repaybur_To_Orderings;


   procedure Add_washmach_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "washmach", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_washmach_To_Orderings;


   procedure Add_washwhy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "washwhy", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_washwhy_To_Orderings;


   procedure Add_whodepq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whodepq", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whodepq_To_Orderings;


   procedure Add_discbua1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "discbua1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_discbua1_To_Orderings;


   procedure Add_discbuc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "discbuc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_discbuc1_To_Orderings;


   procedure Add_diswbua1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "diswbua1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_diswbua1_To_Orderings;


   procedure Add_diswbuc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "diswbuc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_diswbuc1_To_Orderings;


   procedure Add_fsfvbu_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fsfvbu", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsfvbu_To_Orderings;


   procedure Add_gross4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gross4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross4_To_Orderings;


   procedure Add_adles_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adles", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adles_To_Orderings;


   procedure Add_adlesnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adlesnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt1_To_Orderings;


   procedure Add_adlesnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adlesnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt2_To_Orderings;


   procedure Add_adlesnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adlesnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt3_To_Orderings;


   procedure Add_adlesnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adlesnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt4_To_Orderings;


   procedure Add_adlesnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adlesnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt5_To_Orderings;


   procedure Add_adlesnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adlesnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt6_To_Orderings;


   procedure Add_adlesnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adlesnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt7_To_Orderings;


   procedure Add_adlesnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adlesnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesnt8_To_Orderings;


   procedure Add_adlesoa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adlesoa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adlesoa_To_Orderings;


   procedure Add_clothes_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "clothes", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothes_To_Orderings;


   procedure Add_clothnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "clothnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt1_To_Orderings;


   procedure Add_clothnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "clothnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt2_To_Orderings;


   procedure Add_clothnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "clothnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt3_To_Orderings;


   procedure Add_clothnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "clothnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt4_To_Orderings;


   procedure Add_clothnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "clothnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt5_To_Orderings;


   procedure Add_clothnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "clothnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt6_To_Orderings;


   procedure Add_clothnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "clothnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt7_To_Orderings;


   procedure Add_clothnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "clothnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothnt8_To_Orderings;


   procedure Add_clothsoa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "clothsoa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_clothsoa_To_Orderings;


   procedure Add_furnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "furnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt1_To_Orderings;


   procedure Add_furnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "furnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt2_To_Orderings;


   procedure Add_furnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "furnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt3_To_Orderings;


   procedure Add_furnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "furnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt4_To_Orderings;


   procedure Add_furnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "furnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt5_To_Orderings;


   procedure Add_furnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "furnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt6_To_Orderings;


   procedure Add_furnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "furnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt7_To_Orderings;


   procedure Add_furnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "furnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_furnt8_To_Orderings;


   procedure Add_intntnt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intntnt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt1_To_Orderings;


   procedure Add_intntnt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intntnt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt2_To_Orderings;


   procedure Add_intntnt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intntnt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt3_To_Orderings;


   procedure Add_intntnt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intntnt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt4_To_Orderings;


   procedure Add_intntnt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intntnt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt5_To_Orderings;


   procedure Add_intntnt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intntnt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt6_To_Orderings;


   procedure Add_intntnt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intntnt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt7_To_Orderings;


   procedure Add_intntnt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intntnt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intntnt8_To_Orderings;


   procedure Add_intrnet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intrnet", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intrnet_To_Orderings;


   procedure Add_meal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "meal", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_meal_To_Orderings;


   procedure Add_oadep2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oadep2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadep2_To_Orderings;


   procedure Add_oadp2nt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oadp2nt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt1_To_Orderings;


   procedure Add_oadp2nt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oadp2nt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt2_To_Orderings;


   procedure Add_oadp2nt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oadp2nt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt3_To_Orderings;


   procedure Add_oadp2nt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oadp2nt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt4_To_Orderings;


   procedure Add_oadp2nt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oadp2nt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt5_To_Orderings;


   procedure Add_oadp2nt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oadp2nt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt6_To_Orderings;


   procedure Add_oadp2nt7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oadp2nt7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt7_To_Orderings;


   procedure Add_oadp2nt8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oadp2nt8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oadp2nt8_To_Orderings;


   procedure Add_oafur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oafur", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oafur_To_Orderings;


   procedure Add_oaintern_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaintern", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaintern_To_Orderings;


   procedure Add_shoe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "shoe", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoe_To_Orderings;


   procedure Add_shoent1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "shoent1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent1_To_Orderings;


   procedure Add_shoent2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "shoent2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent2_To_Orderings;


   procedure Add_shoent3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "shoent3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent3_To_Orderings;


   procedure Add_shoent4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "shoent4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent4_To_Orderings;


   procedure Add_shoent5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "shoent5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent5_To_Orderings;


   procedure Add_shoent6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "shoent6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent6_To_Orderings;


   procedure Add_shoent7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "shoent7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent7_To_Orderings;


   procedure Add_shoent8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "shoent8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoent8_To_Orderings;


   procedure Add_shoeoa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "shoeoa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_shoeoa_To_Orderings;


   procedure Add_nbunirbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nbunirbn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nbunirbn_To_Orderings;


   procedure Add_nbuothbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nbuothbn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nbuothbn_To_Orderings;


   procedure Add_debt13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debt13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debt13_To_Orderings;


   procedure Add_debtar13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "debtar13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_debtar13_To_Orderings;


   procedure Add_euchbook_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euchbook", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euchbook_To_Orderings;


   procedure Add_euchclth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euchclth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euchclth_To_Orderings;


   procedure Add_euchgame_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euchgame", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euchgame_To_Orderings;


   procedure Add_euchmeat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euchmeat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euchmeat_To_Orderings;


   procedure Add_euchshoe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euchshoe", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euchshoe_To_Orderings;


   procedure Add_eupbtran_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eupbtran", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eupbtran_To_Orderings;


   procedure Add_eupbtrn1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eupbtrn1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eupbtrn1_To_Orderings;


   procedure Add_eupbtrn2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eupbtrn2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eupbtrn2_To_Orderings;


   procedure Add_eupbtrn3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eupbtrn3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eupbtrn3_To_Orderings;


   procedure Add_eupbtrn4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eupbtrn4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eupbtrn4_To_Orderings;


   procedure Add_eupbtrn5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eupbtrn5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eupbtrn5_To_Orderings;


   procedure Add_euroast_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euroast", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euroast_To_Orderings;


   procedure Add_eusmeal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eusmeal", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eusmeal_To_Orderings;


   procedure Add_eustudy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eustudy", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eustudy_To_Orderings;


   procedure Add_bueth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bueth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bueth_To_Orderings;


   procedure Add_oaeusmea_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaeusmea", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaeusmea_To_Orderings;


   procedure Add_oaholb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaholb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaholb_To_Orderings;


   procedure Add_oaroast_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oaroast", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oaroast_To_Orderings;


   procedure Add_ecostab2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ecostab2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ecostab2_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Benunit_IO;

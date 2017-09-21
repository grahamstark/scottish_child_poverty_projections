--
-- Created by ada_generator.py on 2017-09-21 21:49:52.346628
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

package body Ukds.Frs.Child_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.CHILD_IO" );
   
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
         "user_id, edition, year, sernum, benunit, person, adeduc, age, benccdis, care," &
         "cdisdif1, cdisdif2, cdisdif3, cdisdif4, cdisdif5, cdisdif6, cdisdif7, cdisdif8, chamt1, chamt2," &
         "chamt3, chamt4, chamtern, chamttst, chdla1, chdla2, chealth, chearns1, chearns2, chema," &
         "chemaamt, chemapd, chfar, chhr1, chhr2, chlook01, chlook02, chlook03, chlook04, chlook05," &
         "chlook06, chlook07, chlook08, chlook09, chlook10, chpay1, chpay2, chpay3, chpdern, chpdtst," &
         "chprob, chsave, chwkern, chwktst, chyrern, chyrtst, clone, cohabit, convbl, cost," &
         "cvht, cvpay, cvpd, dentist, depend, dob, eligadlt, eligchld, endyr, eyetest," &
         "fted, x_grant, grtamt1, grtamt2, grtdir1, grtdir2, grtnum, grtsce1, grtsce2, grtval1," &
         "grtval2, hholder, hosp, lareg, legdep, ms, nhs1, nhs2, nhs3, parent1," &
         "parent2, prit, prscrpt, r01, r02, r03, r04, r05, r06, r07," &
         "r08, r09, r10, r11, r12, r13, r14, registr1, registr2, registr3," &
         "registr4, registr5, sex, smkit, smlit, spcreg1, spcreg2, spcreg3, specs, spout," &
         "srentamt, srentpd, startyr, totsave, trav, typeed, voucher, whytrav1, whytrav2, whytrav3," &
         "whytrav4, whytrav5, whytrav6, wmkit, month, careab, careah, carecb, carech, carecl," &
         "carefl, carefr, careot, carere, chdda, chearns, chincdv, chrinc, fsmlkval, fsmval," &
         "fwmlkval, hdagech, hourab, hourah, hourcb, hourch, hourcl, hourfr, hourot, hourre," &
         "hourtot, hperson, iagegr2, iagegrp, relhrp, totgntch, uperson, cddatre, cdisdif9, cddatrep," &
         "cdisdifp, cfund, cfundh, cfundtp, fundamt1, fundamt2, fundamt3, fundamt4, fundamt5, fundamt6," &
         "givcfnd1, givcfnd2, givcfnd3, givcfnd4, givcfnd5, givcfnd6, tuacam, schchk, trainee, cddaprg," &
         "issue, heartval, xbonflag, chca, disdifch, chearns3, chtrnamt, chtrnpd, hsvper, mednum," &
         "medprpd, medprpy, sbkit, dobmonth, dobyear, fsbval, btecnow, cameyr, cdaprog1, cdatre1," &
         "cdatrep1, cdisd01, cdisd02, cdisd03, cdisd04, cdisd05, cdisd06, cdisd07, cdisd08, cdisd09," &
         "cdisd10, chbfd, chbfdamt, chbfdpd, chbfdval, chcond, chealth1, chlimitl, citizen, citizen2," &
         "contuk, corign, corigoth, curqual, degrenow, denrec, dvmardf, heathch, highonow, hrsed," &
         "medrec, nvqlenow, othpass, reasden, reasmed, reasnhs, rsanow, sctvnow, sfvit, disactc1," &
         "discorc1, fsfvval, marital, typeed2, c2orign, prox1619, candgnow, curothf, curothp, curothwv," &
         "gnvqnow, ndeplnow, oqualc1, oqualc2, oqualc3, webacnow, ntsctnow, skiwknow " &
         " from frs.child " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.child (" &
         "user_id, edition, year, sernum, benunit, person, adeduc, age, benccdis, care," &
         "cdisdif1, cdisdif2, cdisdif3, cdisdif4, cdisdif5, cdisdif6, cdisdif7, cdisdif8, chamt1, chamt2," &
         "chamt3, chamt4, chamtern, chamttst, chdla1, chdla2, chealth, chearns1, chearns2, chema," &
         "chemaamt, chemapd, chfar, chhr1, chhr2, chlook01, chlook02, chlook03, chlook04, chlook05," &
         "chlook06, chlook07, chlook08, chlook09, chlook10, chpay1, chpay2, chpay3, chpdern, chpdtst," &
         "chprob, chsave, chwkern, chwktst, chyrern, chyrtst, clone, cohabit, convbl, cost," &
         "cvht, cvpay, cvpd, dentist, depend, dob, eligadlt, eligchld, endyr, eyetest," &
         "fted, x_grant, grtamt1, grtamt2, grtdir1, grtdir2, grtnum, grtsce1, grtsce2, grtval1," &
         "grtval2, hholder, hosp, lareg, legdep, ms, nhs1, nhs2, nhs3, parent1," &
         "parent2, prit, prscrpt, r01, r02, r03, r04, r05, r06, r07," &
         "r08, r09, r10, r11, r12, r13, r14, registr1, registr2, registr3," &
         "registr4, registr5, sex, smkit, smlit, spcreg1, spcreg2, spcreg3, specs, spout," &
         "srentamt, srentpd, startyr, totsave, trav, typeed, voucher, whytrav1, whytrav2, whytrav3," &
         "whytrav4, whytrav5, whytrav6, wmkit, month, careab, careah, carecb, carech, carecl," &
         "carefl, carefr, careot, carere, chdda, chearns, chincdv, chrinc, fsmlkval, fsmval," &
         "fwmlkval, hdagech, hourab, hourah, hourcb, hourch, hourcl, hourfr, hourot, hourre," &
         "hourtot, hperson, iagegr2, iagegrp, relhrp, totgntch, uperson, cddatre, cdisdif9, cddatrep," &
         "cdisdifp, cfund, cfundh, cfundtp, fundamt1, fundamt2, fundamt3, fundamt4, fundamt5, fundamt6," &
         "givcfnd1, givcfnd2, givcfnd3, givcfnd4, givcfnd5, givcfnd6, tuacam, schchk, trainee, cddaprg," &
         "issue, heartval, xbonflag, chca, disdifch, chearns3, chtrnamt, chtrnpd, hsvper, mednum," &
         "medprpd, medprpy, sbkit, dobmonth, dobyear, fsbval, btecnow, cameyr, cdaprog1, cdatre1," &
         "cdatrep1, cdisd01, cdisd02, cdisd03, cdisd04, cdisd05, cdisd06, cdisd07, cdisd08, cdisd09," &
         "cdisd10, chbfd, chbfdamt, chbfdpd, chbfdval, chcond, chealth1, chlimitl, citizen, citizen2," &
         "contuk, corign, corigoth, curqual, degrenow, denrec, dvmardf, heathch, highonow, hrsed," &
         "medrec, nvqlenow, othpass, reasden, reasmed, reasnhs, rsanow, sctvnow, sfvit, disactc1," &
         "discorc1, fsfvval, marital, typeed2, c2orign, prox1619, candgnow, curothf, curothp, curothwv," &
         "gnvqnow, ndeplnow, oqualc1, oqualc2, oqualc3, webacnow, ntsctnow, skiwknow " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.child ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.child set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 268 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : adeduc (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : age (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : benccdis (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : care (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : cdisdif1 (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : cdisdif2 (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : cdisdif3 (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : cdisdif4 (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : cdisdif5 (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : cdisdif6 (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : cdisdif7 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : cdisdif8 (Integer)
           13 => ( Parameter_Float, 0.0 ),   --  : chamt1 (Amount)
           14 => ( Parameter_Float, 0.0 ),   --  : chamt2 (Amount)
           15 => ( Parameter_Float, 0.0 ),   --  : chamt3 (Amount)
           16 => ( Parameter_Float, 0.0 ),   --  : chamt4 (Amount)
           17 => ( Parameter_Float, 0.0 ),   --  : chamtern (Amount)
           18 => ( Parameter_Float, 0.0 ),   --  : chamttst (Amount)
           19 => ( Parameter_Integer, 0 ),   --  : chdla1 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : chdla2 (Integer)
           21 => ( Parameter_Integer, 0 ),   --  : chealth (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : chearns1 (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : chearns2 (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : chema (Integer)
           25 => ( Parameter_Float, 0.0 ),   --  : chemaamt (Amount)
           26 => ( Parameter_Integer, 0 ),   --  : chemapd (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : chfar (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : chhr1 (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : chhr2 (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : chlook01 (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : chlook02 (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : chlook03 (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : chlook04 (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : chlook05 (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : chlook06 (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : chlook07 (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : chlook08 (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : chlook09 (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : chlook10 (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : chpay1 (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : chpay2 (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : chpay3 (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : chpdern (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : chpdtst (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : chprob (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : chsave (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : chwkern (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : chwktst (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : chyrern (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : chyrtst (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : clone (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : cohabit (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : convbl (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : cost (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : cvht (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : cvpay (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : cvpd (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : dentist (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : depend (Integer)
           60 => ( Parameter_Date, Clock ),   --  : dob (Ada.Calendar.Time)
           61 => ( Parameter_Integer, 0 ),   --  : eligadlt (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : eligchld (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : endyr (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : eyetest (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : fted (Integer)
           66 => ( Parameter_Integer, 0 ),   --  : x_grant (Integer)
           67 => ( Parameter_Float, 0.0 ),   --  : grtamt1 (Amount)
           68 => ( Parameter_Float, 0.0 ),   --  : grtamt2 (Amount)
           69 => ( Parameter_Float, 0.0 ),   --  : grtdir1 (Amount)
           70 => ( Parameter_Float, 0.0 ),   --  : grtdir2 (Amount)
           71 => ( Parameter_Integer, 0 ),   --  : grtnum (Integer)
           72 => ( Parameter_Integer, 0 ),   --  : grtsce1 (Integer)
           73 => ( Parameter_Integer, 0 ),   --  : grtsce2 (Integer)
           74 => ( Parameter_Float, 0.0 ),   --  : grtval1 (Amount)
           75 => ( Parameter_Float, 0.0 ),   --  : grtval2 (Amount)
           76 => ( Parameter_Integer, 0 ),   --  : hholder (Integer)
           77 => ( Parameter_Integer, 0 ),   --  : hosp (Integer)
           78 => ( Parameter_Integer, 0 ),   --  : lareg (Integer)
           79 => ( Parameter_Integer, 0 ),   --  : legdep (Integer)
           80 => ( Parameter_Integer, 0 ),   --  : ms (Integer)
           81 => ( Parameter_Integer, 0 ),   --  : nhs1 (Integer)
           82 => ( Parameter_Integer, 0 ),   --  : nhs2 (Integer)
           83 => ( Parameter_Integer, 0 ),   --  : nhs3 (Integer)
           84 => ( Parameter_Integer, 0 ),   --  : parent1 (Integer)
           85 => ( Parameter_Integer, 0 ),   --  : parent2 (Integer)
           86 => ( Parameter_Integer, 0 ),   --  : prit (Integer)
           87 => ( Parameter_Integer, 0 ),   --  : prscrpt (Integer)
           88 => ( Parameter_Integer, 0 ),   --  : r01 (Integer)
           89 => ( Parameter_Integer, 0 ),   --  : r02 (Integer)
           90 => ( Parameter_Integer, 0 ),   --  : r03 (Integer)
           91 => ( Parameter_Integer, 0 ),   --  : r04 (Integer)
           92 => ( Parameter_Integer, 0 ),   --  : r05 (Integer)
           93 => ( Parameter_Integer, 0 ),   --  : r06 (Integer)
           94 => ( Parameter_Integer, 0 ),   --  : r07 (Integer)
           95 => ( Parameter_Integer, 0 ),   --  : r08 (Integer)
           96 => ( Parameter_Integer, 0 ),   --  : r09 (Integer)
           97 => ( Parameter_Integer, 0 ),   --  : r10 (Integer)
           98 => ( Parameter_Integer, 0 ),   --  : r11 (Integer)
           99 => ( Parameter_Integer, 0 ),   --  : r12 (Integer)
           100 => ( Parameter_Integer, 0 ),   --  : r13 (Integer)
           101 => ( Parameter_Integer, 0 ),   --  : r14 (Integer)
           102 => ( Parameter_Integer, 0 ),   --  : registr1 (Integer)
           103 => ( Parameter_Integer, 0 ),   --  : registr2 (Integer)
           104 => ( Parameter_Integer, 0 ),   --  : registr3 (Integer)
           105 => ( Parameter_Integer, 0 ),   --  : registr4 (Integer)
           106 => ( Parameter_Integer, 0 ),   --  : registr5 (Integer)
           107 => ( Parameter_Integer, 0 ),   --  : sex (Integer)
           108 => ( Parameter_Integer, 0 ),   --  : smkit (Integer)
           109 => ( Parameter_Integer, 0 ),   --  : smlit (Integer)
           110 => ( Parameter_Integer, 0 ),   --  : spcreg1 (Integer)
           111 => ( Parameter_Integer, 0 ),   --  : spcreg2 (Integer)
           112 => ( Parameter_Integer, 0 ),   --  : spcreg3 (Integer)
           113 => ( Parameter_Integer, 0 ),   --  : specs (Integer)
           114 => ( Parameter_Integer, 0 ),   --  : spout (Integer)
           115 => ( Parameter_Integer, 0 ),   --  : srentamt (Integer)
           116 => ( Parameter_Integer, 0 ),   --  : srentpd (Integer)
           117 => ( Parameter_Integer, 0 ),   --  : startyr (Integer)
           118 => ( Parameter_Integer, 0 ),   --  : totsave (Integer)
           119 => ( Parameter_Integer, 0 ),   --  : trav (Integer)
           120 => ( Parameter_Integer, 0 ),   --  : typeed (Integer)
           121 => ( Parameter_Integer, 0 ),   --  : voucher (Integer)
           122 => ( Parameter_Integer, 0 ),   --  : whytrav1 (Integer)
           123 => ( Parameter_Integer, 0 ),   --  : whytrav2 (Integer)
           124 => ( Parameter_Integer, 0 ),   --  : whytrav3 (Integer)
           125 => ( Parameter_Integer, 0 ),   --  : whytrav4 (Integer)
           126 => ( Parameter_Integer, 0 ),   --  : whytrav5 (Integer)
           127 => ( Parameter_Integer, 0 ),   --  : whytrav6 (Integer)
           128 => ( Parameter_Integer, 0 ),   --  : wmkit (Integer)
           129 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           130 => ( Parameter_Integer, 0 ),   --  : careab (Integer)
           131 => ( Parameter_Integer, 0 ),   --  : careah (Integer)
           132 => ( Parameter_Integer, 0 ),   --  : carecb (Integer)
           133 => ( Parameter_Integer, 0 ),   --  : carech (Integer)
           134 => ( Parameter_Integer, 0 ),   --  : carecl (Integer)
           135 => ( Parameter_Integer, 0 ),   --  : carefl (Integer)
           136 => ( Parameter_Integer, 0 ),   --  : carefr (Integer)
           137 => ( Parameter_Integer, 0 ),   --  : careot (Integer)
           138 => ( Parameter_Integer, 0 ),   --  : carere (Integer)
           139 => ( Parameter_Integer, 0 ),   --  : chdda (Integer)
           140 => ( Parameter_Float, 0.0 ),   --  : chearns (Amount)
           141 => ( Parameter_Float, 0.0 ),   --  : chincdv (Amount)
           142 => ( Parameter_Float, 0.0 ),   --  : chrinc (Amount)
           143 => ( Parameter_Float, 0.0 ),   --  : fsmlkval (Amount)
           144 => ( Parameter_Float, 0.0 ),   --  : fsmval (Amount)
           145 => ( Parameter_Float, 0.0 ),   --  : fwmlkval (Amount)
           146 => ( Parameter_Integer, 0 ),   --  : hdagech (Integer)
           147 => ( Parameter_Integer, 0 ),   --  : hourab (Integer)
           148 => ( Parameter_Integer, 0 ),   --  : hourah (Integer)
           149 => ( Parameter_Integer, 0 ),   --  : hourcb (Integer)
           150 => ( Parameter_Integer, 0 ),   --  : hourch (Integer)
           151 => ( Parameter_Integer, 0 ),   --  : hourcl (Integer)
           152 => ( Parameter_Integer, 0 ),   --  : hourfr (Integer)
           153 => ( Parameter_Integer, 0 ),   --  : hourot (Integer)
           154 => ( Parameter_Integer, 0 ),   --  : hourre (Integer)
           155 => ( Parameter_Integer, 0 ),   --  : hourtot (Integer)
           156 => ( Parameter_Integer, 0 ),   --  : hperson (Integer)
           157 => ( Parameter_Integer, 0 ),   --  : iagegr2 (Integer)
           158 => ( Parameter_Integer, 0 ),   --  : iagegrp (Integer)
           159 => ( Parameter_Integer, 0 ),   --  : relhrp (Integer)
           160 => ( Parameter_Float, 0.0 ),   --  : totgntch (Amount)
           161 => ( Parameter_Integer, 0 ),   --  : uperson (Integer)
           162 => ( Parameter_Integer, 0 ),   --  : cddatre (Integer)
           163 => ( Parameter_Integer, 0 ),   --  : cdisdif9 (Integer)
           164 => ( Parameter_Integer, 0 ),   --  : cddatrep (Integer)
           165 => ( Parameter_Integer, 0 ),   --  : cdisdifp (Integer)
           166 => ( Parameter_Integer, 0 ),   --  : cfund (Integer)
           167 => ( Parameter_Float, 0.0 ),   --  : cfundh (Amount)
           168 => ( Parameter_Integer, 0 ),   --  : cfundtp (Integer)
           169 => ( Parameter_Float, 0.0 ),   --  : fundamt1 (Amount)
           170 => ( Parameter_Float, 0.0 ),   --  : fundamt2 (Amount)
           171 => ( Parameter_Float, 0.0 ),   --  : fundamt3 (Amount)
           172 => ( Parameter_Float, 0.0 ),   --  : fundamt4 (Amount)
           173 => ( Parameter_Float, 0.0 ),   --  : fundamt5 (Amount)
           174 => ( Parameter_Float, 0.0 ),   --  : fundamt6 (Amount)
           175 => ( Parameter_Integer, 0 ),   --  : givcfnd1 (Integer)
           176 => ( Parameter_Integer, 0 ),   --  : givcfnd2 (Integer)
           177 => ( Parameter_Integer, 0 ),   --  : givcfnd3 (Integer)
           178 => ( Parameter_Integer, 0 ),   --  : givcfnd4 (Integer)
           179 => ( Parameter_Integer, 0 ),   --  : givcfnd5 (Integer)
           180 => ( Parameter_Integer, 0 ),   --  : givcfnd6 (Integer)
           181 => ( Parameter_Float, 0.0 ),   --  : tuacam (Amount)
           182 => ( Parameter_Integer, 0 ),   --  : schchk (Integer)
           183 => ( Parameter_Integer, 0 ),   --  : trainee (Integer)
           184 => ( Parameter_Integer, 0 ),   --  : cddaprg (Integer)
           185 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           186 => ( Parameter_Float, 0.0 ),   --  : heartval (Amount)
           187 => ( Parameter_Integer, 0 ),   --  : xbonflag (Integer)
           188 => ( Parameter_Integer, 0 ),   --  : chca (Integer)
           189 => ( Parameter_Integer, 0 ),   --  : disdifch (Integer)
           190 => ( Parameter_Integer, 0 ),   --  : chearns3 (Integer)
           191 => ( Parameter_Float, 0.0 ),   --  : chtrnamt (Amount)
           192 => ( Parameter_Integer, 0 ),   --  : chtrnpd (Integer)
           193 => ( Parameter_Integer, 0 ),   --  : hsvper (Integer)
           194 => ( Parameter_Integer, 0 ),   --  : mednum (Integer)
           195 => ( Parameter_Integer, 0 ),   --  : medprpd (Integer)
           196 => ( Parameter_Integer, 0 ),   --  : medprpy (Integer)
           197 => ( Parameter_Integer, 0 ),   --  : sbkit (Integer)
           198 => ( Parameter_Integer, 0 ),   --  : dobmonth (Integer)
           199 => ( Parameter_Integer, 0 ),   --  : dobyear (Integer)
           200 => ( Parameter_Float, 0.0 ),   --  : fsbval (Amount)
           201 => ( Parameter_Integer, 0 ),   --  : btecnow (Integer)
           202 => ( Parameter_Integer, 0 ),   --  : cameyr (Integer)
           203 => ( Parameter_Integer, 0 ),   --  : cdaprog1 (Integer)
           204 => ( Parameter_Integer, 0 ),   --  : cdatre1 (Integer)
           205 => ( Parameter_Integer, 0 ),   --  : cdatrep1 (Integer)
           206 => ( Parameter_Integer, 0 ),   --  : cdisd01 (Integer)
           207 => ( Parameter_Integer, 0 ),   --  : cdisd02 (Integer)
           208 => ( Parameter_Integer, 0 ),   --  : cdisd03 (Integer)
           209 => ( Parameter_Integer, 0 ),   --  : cdisd04 (Integer)
           210 => ( Parameter_Integer, 0 ),   --  : cdisd05 (Integer)
           211 => ( Parameter_Integer, 0 ),   --  : cdisd06 (Integer)
           212 => ( Parameter_Integer, 0 ),   --  : cdisd07 (Integer)
           213 => ( Parameter_Integer, 0 ),   --  : cdisd08 (Integer)
           214 => ( Parameter_Integer, 0 ),   --  : cdisd09 (Integer)
           215 => ( Parameter_Integer, 0 ),   --  : cdisd10 (Integer)
           216 => ( Parameter_Integer, 0 ),   --  : chbfd (Integer)
           217 => ( Parameter_Float, 0.0 ),   --  : chbfdamt (Amount)
           218 => ( Parameter_Integer, 0 ),   --  : chbfdpd (Integer)
           219 => ( Parameter_Integer, 0 ),   --  : chbfdval (Integer)
           220 => ( Parameter_Integer, 0 ),   --  : chcond (Integer)
           221 => ( Parameter_Integer, 0 ),   --  : chealth1 (Integer)
           222 => ( Parameter_Integer, 0 ),   --  : chlimitl (Integer)
           223 => ( Parameter_Integer, 0 ),   --  : citizen (Integer)
           224 => ( Parameter_Integer, 0 ),   --  : citizen2 (Integer)
           225 => ( Parameter_Integer, 0 ),   --  : contuk (Integer)
           226 => ( Parameter_Integer, 0 ),   --  : corign (Integer)
           227 => ( Parameter_Integer, 0 ),   --  : corigoth (Integer)
           228 => ( Parameter_Integer, 0 ),   --  : curqual (Integer)
           229 => ( Parameter_Integer, 0 ),   --  : degrenow (Integer)
           230 => ( Parameter_Integer, 0 ),   --  : denrec (Integer)
           231 => ( Parameter_Integer, 0 ),   --  : dvmardf (Integer)
           232 => ( Parameter_Integer, 0 ),   --  : heathch (Integer)
           233 => ( Parameter_Integer, 0 ),   --  : highonow (Integer)
           234 => ( Parameter_Integer, 0 ),   --  : hrsed (Integer)
           235 => ( Parameter_Integer, 0 ),   --  : medrec (Integer)
           236 => ( Parameter_Integer, 0 ),   --  : nvqlenow (Integer)
           237 => ( Parameter_Integer, 0 ),   --  : othpass (Integer)
           238 => ( Parameter_Integer, 0 ),   --  : reasden (Integer)
           239 => ( Parameter_Integer, 0 ),   --  : reasmed (Integer)
           240 => ( Parameter_Integer, 0 ),   --  : reasnhs (Integer)
           241 => ( Parameter_Integer, 0 ),   --  : rsanow (Integer)
           242 => ( Parameter_Integer, 0 ),   --  : sctvnow (Integer)
           243 => ( Parameter_Integer, 0 ),   --  : sfvit (Integer)
           244 => ( Parameter_Integer, 0 ),   --  : disactc1 (Integer)
           245 => ( Parameter_Integer, 0 ),   --  : discorc1 (Integer)
           246 => ( Parameter_Float, 0.0 ),   --  : fsfvval (Amount)
           247 => ( Parameter_Integer, 0 ),   --  : marital (Integer)
           248 => ( Parameter_Integer, 0 ),   --  : typeed2 (Integer)
           249 => ( Parameter_Integer, 0 ),   --  : c2orign (Integer)
           250 => ( Parameter_Integer, 0 ),   --  : prox1619 (Integer)
           251 => ( Parameter_Integer, 0 ),   --  : candgnow (Integer)
           252 => ( Parameter_Integer, 0 ),   --  : curothf (Integer)
           253 => ( Parameter_Integer, 0 ),   --  : curothp (Integer)
           254 => ( Parameter_Integer, 0 ),   --  : curothwv (Integer)
           255 => ( Parameter_Integer, 0 ),   --  : gnvqnow (Integer)
           256 => ( Parameter_Integer, 0 ),   --  : ndeplnow (Integer)
           257 => ( Parameter_Integer, 0 ),   --  : oqualc1 (Integer)
           258 => ( Parameter_Integer, 0 ),   --  : oqualc2 (Integer)
           259 => ( Parameter_Integer, 0 ),   --  : oqualc3 (Integer)
           260 => ( Parameter_Integer, 0 ),   --  : webacnow (Integer)
           261 => ( Parameter_Integer, 0 ),   --  : ntsctnow (Integer)
           262 => ( Parameter_Integer, 0 ),   --  : skiwknow (Integer)
           263 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           264 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           265 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           266 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           267 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           268 => ( Parameter_Integer, 0 )   --  : person (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : adeduc (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : age (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : benccdis (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : care (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : cdisdif1 (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : cdisdif2 (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : cdisdif3 (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : cdisdif4 (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : cdisdif5 (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : cdisdif6 (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : cdisdif7 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : cdisdif8 (Integer)
           19 => ( Parameter_Float, 0.0 ),   --  : chamt1 (Amount)
           20 => ( Parameter_Float, 0.0 ),   --  : chamt2 (Amount)
           21 => ( Parameter_Float, 0.0 ),   --  : chamt3 (Amount)
           22 => ( Parameter_Float, 0.0 ),   --  : chamt4 (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : chamtern (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : chamttst (Amount)
           25 => ( Parameter_Integer, 0 ),   --  : chdla1 (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : chdla2 (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : chealth (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : chearns1 (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : chearns2 (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : chema (Integer)
           31 => ( Parameter_Float, 0.0 ),   --  : chemaamt (Amount)
           32 => ( Parameter_Integer, 0 ),   --  : chemapd (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : chfar (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : chhr1 (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : chhr2 (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : chlook01 (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : chlook02 (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : chlook03 (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : chlook04 (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : chlook05 (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : chlook06 (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : chlook07 (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : chlook08 (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : chlook09 (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : chlook10 (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : chpay1 (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : chpay2 (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : chpay3 (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : chpdern (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : chpdtst (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : chprob (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : chsave (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : chwkern (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : chwktst (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : chyrern (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : chyrtst (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : clone (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : cohabit (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : convbl (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : cost (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : cvht (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : cvpay (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : cvpd (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : dentist (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : depend (Integer)
           66 => ( Parameter_Date, Clock ),   --  : dob (Ada.Calendar.Time)
           67 => ( Parameter_Integer, 0 ),   --  : eligadlt (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : eligchld (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : endyr (Integer)
           70 => ( Parameter_Integer, 0 ),   --  : eyetest (Integer)
           71 => ( Parameter_Integer, 0 ),   --  : fted (Integer)
           72 => ( Parameter_Integer, 0 ),   --  : x_grant (Integer)
           73 => ( Parameter_Float, 0.0 ),   --  : grtamt1 (Amount)
           74 => ( Parameter_Float, 0.0 ),   --  : grtamt2 (Amount)
           75 => ( Parameter_Float, 0.0 ),   --  : grtdir1 (Amount)
           76 => ( Parameter_Float, 0.0 ),   --  : grtdir2 (Amount)
           77 => ( Parameter_Integer, 0 ),   --  : grtnum (Integer)
           78 => ( Parameter_Integer, 0 ),   --  : grtsce1 (Integer)
           79 => ( Parameter_Integer, 0 ),   --  : grtsce2 (Integer)
           80 => ( Parameter_Float, 0.0 ),   --  : grtval1 (Amount)
           81 => ( Parameter_Float, 0.0 ),   --  : grtval2 (Amount)
           82 => ( Parameter_Integer, 0 ),   --  : hholder (Integer)
           83 => ( Parameter_Integer, 0 ),   --  : hosp (Integer)
           84 => ( Parameter_Integer, 0 ),   --  : lareg (Integer)
           85 => ( Parameter_Integer, 0 ),   --  : legdep (Integer)
           86 => ( Parameter_Integer, 0 ),   --  : ms (Integer)
           87 => ( Parameter_Integer, 0 ),   --  : nhs1 (Integer)
           88 => ( Parameter_Integer, 0 ),   --  : nhs2 (Integer)
           89 => ( Parameter_Integer, 0 ),   --  : nhs3 (Integer)
           90 => ( Parameter_Integer, 0 ),   --  : parent1 (Integer)
           91 => ( Parameter_Integer, 0 ),   --  : parent2 (Integer)
           92 => ( Parameter_Integer, 0 ),   --  : prit (Integer)
           93 => ( Parameter_Integer, 0 ),   --  : prscrpt (Integer)
           94 => ( Parameter_Integer, 0 ),   --  : r01 (Integer)
           95 => ( Parameter_Integer, 0 ),   --  : r02 (Integer)
           96 => ( Parameter_Integer, 0 ),   --  : r03 (Integer)
           97 => ( Parameter_Integer, 0 ),   --  : r04 (Integer)
           98 => ( Parameter_Integer, 0 ),   --  : r05 (Integer)
           99 => ( Parameter_Integer, 0 ),   --  : r06 (Integer)
           100 => ( Parameter_Integer, 0 ),   --  : r07 (Integer)
           101 => ( Parameter_Integer, 0 ),   --  : r08 (Integer)
           102 => ( Parameter_Integer, 0 ),   --  : r09 (Integer)
           103 => ( Parameter_Integer, 0 ),   --  : r10 (Integer)
           104 => ( Parameter_Integer, 0 ),   --  : r11 (Integer)
           105 => ( Parameter_Integer, 0 ),   --  : r12 (Integer)
           106 => ( Parameter_Integer, 0 ),   --  : r13 (Integer)
           107 => ( Parameter_Integer, 0 ),   --  : r14 (Integer)
           108 => ( Parameter_Integer, 0 ),   --  : registr1 (Integer)
           109 => ( Parameter_Integer, 0 ),   --  : registr2 (Integer)
           110 => ( Parameter_Integer, 0 ),   --  : registr3 (Integer)
           111 => ( Parameter_Integer, 0 ),   --  : registr4 (Integer)
           112 => ( Parameter_Integer, 0 ),   --  : registr5 (Integer)
           113 => ( Parameter_Integer, 0 ),   --  : sex (Integer)
           114 => ( Parameter_Integer, 0 ),   --  : smkit (Integer)
           115 => ( Parameter_Integer, 0 ),   --  : smlit (Integer)
           116 => ( Parameter_Integer, 0 ),   --  : spcreg1 (Integer)
           117 => ( Parameter_Integer, 0 ),   --  : spcreg2 (Integer)
           118 => ( Parameter_Integer, 0 ),   --  : spcreg3 (Integer)
           119 => ( Parameter_Integer, 0 ),   --  : specs (Integer)
           120 => ( Parameter_Integer, 0 ),   --  : spout (Integer)
           121 => ( Parameter_Integer, 0 ),   --  : srentamt (Integer)
           122 => ( Parameter_Integer, 0 ),   --  : srentpd (Integer)
           123 => ( Parameter_Integer, 0 ),   --  : startyr (Integer)
           124 => ( Parameter_Integer, 0 ),   --  : totsave (Integer)
           125 => ( Parameter_Integer, 0 ),   --  : trav (Integer)
           126 => ( Parameter_Integer, 0 ),   --  : typeed (Integer)
           127 => ( Parameter_Integer, 0 ),   --  : voucher (Integer)
           128 => ( Parameter_Integer, 0 ),   --  : whytrav1 (Integer)
           129 => ( Parameter_Integer, 0 ),   --  : whytrav2 (Integer)
           130 => ( Parameter_Integer, 0 ),   --  : whytrav3 (Integer)
           131 => ( Parameter_Integer, 0 ),   --  : whytrav4 (Integer)
           132 => ( Parameter_Integer, 0 ),   --  : whytrav5 (Integer)
           133 => ( Parameter_Integer, 0 ),   --  : whytrav6 (Integer)
           134 => ( Parameter_Integer, 0 ),   --  : wmkit (Integer)
           135 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           136 => ( Parameter_Integer, 0 ),   --  : careab (Integer)
           137 => ( Parameter_Integer, 0 ),   --  : careah (Integer)
           138 => ( Parameter_Integer, 0 ),   --  : carecb (Integer)
           139 => ( Parameter_Integer, 0 ),   --  : carech (Integer)
           140 => ( Parameter_Integer, 0 ),   --  : carecl (Integer)
           141 => ( Parameter_Integer, 0 ),   --  : carefl (Integer)
           142 => ( Parameter_Integer, 0 ),   --  : carefr (Integer)
           143 => ( Parameter_Integer, 0 ),   --  : careot (Integer)
           144 => ( Parameter_Integer, 0 ),   --  : carere (Integer)
           145 => ( Parameter_Integer, 0 ),   --  : chdda (Integer)
           146 => ( Parameter_Float, 0.0 ),   --  : chearns (Amount)
           147 => ( Parameter_Float, 0.0 ),   --  : chincdv (Amount)
           148 => ( Parameter_Float, 0.0 ),   --  : chrinc (Amount)
           149 => ( Parameter_Float, 0.0 ),   --  : fsmlkval (Amount)
           150 => ( Parameter_Float, 0.0 ),   --  : fsmval (Amount)
           151 => ( Parameter_Float, 0.0 ),   --  : fwmlkval (Amount)
           152 => ( Parameter_Integer, 0 ),   --  : hdagech (Integer)
           153 => ( Parameter_Integer, 0 ),   --  : hourab (Integer)
           154 => ( Parameter_Integer, 0 ),   --  : hourah (Integer)
           155 => ( Parameter_Integer, 0 ),   --  : hourcb (Integer)
           156 => ( Parameter_Integer, 0 ),   --  : hourch (Integer)
           157 => ( Parameter_Integer, 0 ),   --  : hourcl (Integer)
           158 => ( Parameter_Integer, 0 ),   --  : hourfr (Integer)
           159 => ( Parameter_Integer, 0 ),   --  : hourot (Integer)
           160 => ( Parameter_Integer, 0 ),   --  : hourre (Integer)
           161 => ( Parameter_Integer, 0 ),   --  : hourtot (Integer)
           162 => ( Parameter_Integer, 0 ),   --  : hperson (Integer)
           163 => ( Parameter_Integer, 0 ),   --  : iagegr2 (Integer)
           164 => ( Parameter_Integer, 0 ),   --  : iagegrp (Integer)
           165 => ( Parameter_Integer, 0 ),   --  : relhrp (Integer)
           166 => ( Parameter_Float, 0.0 ),   --  : totgntch (Amount)
           167 => ( Parameter_Integer, 0 ),   --  : uperson (Integer)
           168 => ( Parameter_Integer, 0 ),   --  : cddatre (Integer)
           169 => ( Parameter_Integer, 0 ),   --  : cdisdif9 (Integer)
           170 => ( Parameter_Integer, 0 ),   --  : cddatrep (Integer)
           171 => ( Parameter_Integer, 0 ),   --  : cdisdifp (Integer)
           172 => ( Parameter_Integer, 0 ),   --  : cfund (Integer)
           173 => ( Parameter_Float, 0.0 ),   --  : cfundh (Amount)
           174 => ( Parameter_Integer, 0 ),   --  : cfundtp (Integer)
           175 => ( Parameter_Float, 0.0 ),   --  : fundamt1 (Amount)
           176 => ( Parameter_Float, 0.0 ),   --  : fundamt2 (Amount)
           177 => ( Parameter_Float, 0.0 ),   --  : fundamt3 (Amount)
           178 => ( Parameter_Float, 0.0 ),   --  : fundamt4 (Amount)
           179 => ( Parameter_Float, 0.0 ),   --  : fundamt5 (Amount)
           180 => ( Parameter_Float, 0.0 ),   --  : fundamt6 (Amount)
           181 => ( Parameter_Integer, 0 ),   --  : givcfnd1 (Integer)
           182 => ( Parameter_Integer, 0 ),   --  : givcfnd2 (Integer)
           183 => ( Parameter_Integer, 0 ),   --  : givcfnd3 (Integer)
           184 => ( Parameter_Integer, 0 ),   --  : givcfnd4 (Integer)
           185 => ( Parameter_Integer, 0 ),   --  : givcfnd5 (Integer)
           186 => ( Parameter_Integer, 0 ),   --  : givcfnd6 (Integer)
           187 => ( Parameter_Float, 0.0 ),   --  : tuacam (Amount)
           188 => ( Parameter_Integer, 0 ),   --  : schchk (Integer)
           189 => ( Parameter_Integer, 0 ),   --  : trainee (Integer)
           190 => ( Parameter_Integer, 0 ),   --  : cddaprg (Integer)
           191 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           192 => ( Parameter_Float, 0.0 ),   --  : heartval (Amount)
           193 => ( Parameter_Integer, 0 ),   --  : xbonflag (Integer)
           194 => ( Parameter_Integer, 0 ),   --  : chca (Integer)
           195 => ( Parameter_Integer, 0 ),   --  : disdifch (Integer)
           196 => ( Parameter_Integer, 0 ),   --  : chearns3 (Integer)
           197 => ( Parameter_Float, 0.0 ),   --  : chtrnamt (Amount)
           198 => ( Parameter_Integer, 0 ),   --  : chtrnpd (Integer)
           199 => ( Parameter_Integer, 0 ),   --  : hsvper (Integer)
           200 => ( Parameter_Integer, 0 ),   --  : mednum (Integer)
           201 => ( Parameter_Integer, 0 ),   --  : medprpd (Integer)
           202 => ( Parameter_Integer, 0 ),   --  : medprpy (Integer)
           203 => ( Parameter_Integer, 0 ),   --  : sbkit (Integer)
           204 => ( Parameter_Integer, 0 ),   --  : dobmonth (Integer)
           205 => ( Parameter_Integer, 0 ),   --  : dobyear (Integer)
           206 => ( Parameter_Float, 0.0 ),   --  : fsbval (Amount)
           207 => ( Parameter_Integer, 0 ),   --  : btecnow (Integer)
           208 => ( Parameter_Integer, 0 ),   --  : cameyr (Integer)
           209 => ( Parameter_Integer, 0 ),   --  : cdaprog1 (Integer)
           210 => ( Parameter_Integer, 0 ),   --  : cdatre1 (Integer)
           211 => ( Parameter_Integer, 0 ),   --  : cdatrep1 (Integer)
           212 => ( Parameter_Integer, 0 ),   --  : cdisd01 (Integer)
           213 => ( Parameter_Integer, 0 ),   --  : cdisd02 (Integer)
           214 => ( Parameter_Integer, 0 ),   --  : cdisd03 (Integer)
           215 => ( Parameter_Integer, 0 ),   --  : cdisd04 (Integer)
           216 => ( Parameter_Integer, 0 ),   --  : cdisd05 (Integer)
           217 => ( Parameter_Integer, 0 ),   --  : cdisd06 (Integer)
           218 => ( Parameter_Integer, 0 ),   --  : cdisd07 (Integer)
           219 => ( Parameter_Integer, 0 ),   --  : cdisd08 (Integer)
           220 => ( Parameter_Integer, 0 ),   --  : cdisd09 (Integer)
           221 => ( Parameter_Integer, 0 ),   --  : cdisd10 (Integer)
           222 => ( Parameter_Integer, 0 ),   --  : chbfd (Integer)
           223 => ( Parameter_Float, 0.0 ),   --  : chbfdamt (Amount)
           224 => ( Parameter_Integer, 0 ),   --  : chbfdpd (Integer)
           225 => ( Parameter_Integer, 0 ),   --  : chbfdval (Integer)
           226 => ( Parameter_Integer, 0 ),   --  : chcond (Integer)
           227 => ( Parameter_Integer, 0 ),   --  : chealth1 (Integer)
           228 => ( Parameter_Integer, 0 ),   --  : chlimitl (Integer)
           229 => ( Parameter_Integer, 0 ),   --  : citizen (Integer)
           230 => ( Parameter_Integer, 0 ),   --  : citizen2 (Integer)
           231 => ( Parameter_Integer, 0 ),   --  : contuk (Integer)
           232 => ( Parameter_Integer, 0 ),   --  : corign (Integer)
           233 => ( Parameter_Integer, 0 ),   --  : corigoth (Integer)
           234 => ( Parameter_Integer, 0 ),   --  : curqual (Integer)
           235 => ( Parameter_Integer, 0 ),   --  : degrenow (Integer)
           236 => ( Parameter_Integer, 0 ),   --  : denrec (Integer)
           237 => ( Parameter_Integer, 0 ),   --  : dvmardf (Integer)
           238 => ( Parameter_Integer, 0 ),   --  : heathch (Integer)
           239 => ( Parameter_Integer, 0 ),   --  : highonow (Integer)
           240 => ( Parameter_Integer, 0 ),   --  : hrsed (Integer)
           241 => ( Parameter_Integer, 0 ),   --  : medrec (Integer)
           242 => ( Parameter_Integer, 0 ),   --  : nvqlenow (Integer)
           243 => ( Parameter_Integer, 0 ),   --  : othpass (Integer)
           244 => ( Parameter_Integer, 0 ),   --  : reasden (Integer)
           245 => ( Parameter_Integer, 0 ),   --  : reasmed (Integer)
           246 => ( Parameter_Integer, 0 ),   --  : reasnhs (Integer)
           247 => ( Parameter_Integer, 0 ),   --  : rsanow (Integer)
           248 => ( Parameter_Integer, 0 ),   --  : sctvnow (Integer)
           249 => ( Parameter_Integer, 0 ),   --  : sfvit (Integer)
           250 => ( Parameter_Integer, 0 ),   --  : disactc1 (Integer)
           251 => ( Parameter_Integer, 0 ),   --  : discorc1 (Integer)
           252 => ( Parameter_Float, 0.0 ),   --  : fsfvval (Amount)
           253 => ( Parameter_Integer, 0 ),   --  : marital (Integer)
           254 => ( Parameter_Integer, 0 ),   --  : typeed2 (Integer)
           255 => ( Parameter_Integer, 0 ),   --  : c2orign (Integer)
           256 => ( Parameter_Integer, 0 ),   --  : prox1619 (Integer)
           257 => ( Parameter_Integer, 0 ),   --  : candgnow (Integer)
           258 => ( Parameter_Integer, 0 ),   --  : curothf (Integer)
           259 => ( Parameter_Integer, 0 ),   --  : curothp (Integer)
           260 => ( Parameter_Integer, 0 ),   --  : curothwv (Integer)
           261 => ( Parameter_Integer, 0 ),   --  : gnvqnow (Integer)
           262 => ( Parameter_Integer, 0 ),   --  : ndeplnow (Integer)
           263 => ( Parameter_Integer, 0 ),   --  : oqualc1 (Integer)
           264 => ( Parameter_Integer, 0 ),   --  : oqualc2 (Integer)
           265 => ( Parameter_Integer, 0 ),   --  : oqualc3 (Integer)
           266 => ( Parameter_Integer, 0 ),   --  : webacnow (Integer)
           267 => ( Parameter_Integer, 0 ),   --  : ntsctnow (Integer)
           268 => ( Parameter_Integer, 0 )   --  : skiwknow (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $100, $101, $102, $103, $104, $105, $106, $107, $108, $109, $110, $111, $112, $113, $114, $115, $116, $117, $118, $119, $120, $121, $122, $123, $124, $125, $126, $127, $128, $129, $130, $131, $132, $133, $134, $135, $136, $137, $138, $139, $140, $141, $142, $143, $144, $145, $146, $147, $148, $149, $150, $151, $152, $153, $154, $155, $156, $157, $158, $159, $160, $161, $162, $163, $164, $165, $166, $167, $168, $169, $170, $171, $172, $173, $174, $175, $176, $177, $178, $179, $180, $181, $182, $183, $184, $185, $186, $187, $188, $189, $190, $191, $192, $193, $194, $195, $196, $197, $198, $199, $200, $201, $202, $203, $204, $205, $206, $207, $208, $209, $210, $211, $212, $213, $214, $215, $216, $217, $218, $219, $220, $221, $222, $223, $224, $225, $226, $227, $228, $229, $230, $231, $232, $233, $234, $235, $236, $237, $238, $239, $240, $241, $242, $243, $244, $245, $246, $247, $248, $249, $250, $251, $252, $253, $254, $255, $256, $257, $258, $259, $260, $261, $262, $263, $264, $265, $266, $267, $268 )"; 
   begin 
      ps := gse.Prepare( query, On_Server => True ); 
      return ps; 
   end Get_Prepared_Insert_Statement; 



   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 6 ) := (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 )   --  : person (Integer)
      );
   begin
      return params;
   end Get_Configured_Retrieve_Params;



   function Get_Prepared_Retrieve_Statement return gse.Prepared_Statement is 
      s : constant String := " where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " adeduc = $1, age = $2, benccdis = $3, care = $4, cdisdif1 = $5, cdisdif2 = $6, cdisdif3 = $7, cdisdif4 = $8, cdisdif5 = $9, cdisdif6 = $10, cdisdif7 = $11, cdisdif8 = $12, chamt1 = $13, chamt2 = $14, chamt3 = $15, chamt4 = $16, chamtern = $17, chamttst = $18, chdla1 = $19, chdla2 = $20, chealth = $21, chearns1 = $22, chearns2 = $23, chema = $24, chemaamt = $25, chemapd = $26, chfar = $27, chhr1 = $28, chhr2 = $29, chlook01 = $30, chlook02 = $31, chlook03 = $32, chlook04 = $33, chlook05 = $34, chlook06 = $35, chlook07 = $36, chlook08 = $37, chlook09 = $38, chlook10 = $39, chpay1 = $40, chpay2 = $41, chpay3 = $42, chpdern = $43, chpdtst = $44, chprob = $45, chsave = $46, chwkern = $47, chwktst = $48, chyrern = $49, chyrtst = $50, clone = $51, cohabit = $52, convbl = $53, cost = $54, cvht = $55, cvpay = $56, cvpd = $57, dentist = $58, depend = $59, dob = $60, eligadlt = $61, eligchld = $62, endyr = $63, eyetest = $64, fted = $65, x_grant = $66, grtamt1 = $67, grtamt2 = $68, grtdir1 = $69, grtdir2 = $70, grtnum = $71, grtsce1 = $72, grtsce2 = $73, grtval1 = $74, grtval2 = $75, hholder = $76, hosp = $77, lareg = $78, legdep = $79, ms = $80, nhs1 = $81, nhs2 = $82, nhs3 = $83, parent1 = $84, parent2 = $85, prit = $86, prscrpt = $87, r01 = $88, r02 = $89, r03 = $90, r04 = $91, r05 = $92, r06 = $93, r07 = $94, r08 = $95, r09 = $96, r10 = $97, r11 = $98, r12 = $99, r13 = $100, r14 = $101, registr1 = $102, registr2 = $103, registr3 = $104, registr4 = $105, registr5 = $106, sex = $107, smkit = $108, smlit = $109, spcreg1 = $110, spcreg2 = $111, spcreg3 = $112, specs = $113, spout = $114, srentamt = $115, srentpd = $116, startyr = $117, totsave = $118, trav = $119, typeed = $120, voucher = $121, whytrav1 = $122, whytrav2 = $123, whytrav3 = $124, whytrav4 = $125, whytrav5 = $126, whytrav6 = $127, wmkit = $128, month = $129, careab = $130, careah = $131, carecb = $132, carech = $133, carecl = $134, carefl = $135, carefr = $136, careot = $137, carere = $138, chdda = $139, chearns = $140, chincdv = $141, chrinc = $142, fsmlkval = $143, fsmval = $144, fwmlkval = $145, hdagech = $146, hourab = $147, hourah = $148, hourcb = $149, hourch = $150, hourcl = $151, hourfr = $152, hourot = $153, hourre = $154, hourtot = $155, hperson = $156, iagegr2 = $157, iagegrp = $158, relhrp = $159, totgntch = $160, uperson = $161, cddatre = $162, cdisdif9 = $163, cddatrep = $164, cdisdifp = $165, cfund = $166, cfundh = $167, cfundtp = $168, fundamt1 = $169, fundamt2 = $170, fundamt3 = $171, fundamt4 = $172, fundamt5 = $173, fundamt6 = $174, givcfnd1 = $175, givcfnd2 = $176, givcfnd3 = $177, givcfnd4 = $178, givcfnd5 = $179, givcfnd6 = $180, tuacam = $181, schchk = $182, trainee = $183, cddaprg = $184, issue = $185, heartval = $186, xbonflag = $187, chca = $188, disdifch = $189, chearns3 = $190, chtrnamt = $191, chtrnpd = $192, hsvper = $193, mednum = $194, medprpd = $195, medprpy = $196, sbkit = $197, dobmonth = $198, dobyear = $199, fsbval = $200, btecnow = $201, cameyr = $202, cdaprog1 = $203, cdatre1 = $204, cdatrep1 = $205, cdisd01 = $206, cdisd02 = $207, cdisd03 = $208, cdisd04 = $209, cdisd05 = $210, cdisd06 = $211, cdisd07 = $212, cdisd08 = $213, cdisd09 = $214, cdisd10 = $215, chbfd = $216, chbfdamt = $217, chbfdpd = $218, chbfdval = $219, chcond = $220, chealth1 = $221, chlimitl = $222, citizen = $223, citizen2 = $224, contuk = $225, corign = $226, corigoth = $227, curqual = $228, degrenow = $229, denrec = $230, dvmardf = $231, heathch = $232, highonow = $233, hrsed = $234, medrec = $235, nvqlenow = $236, othpass = $237, reasden = $238, reasmed = $239, reasnhs = $240, rsanow = $241, sctvnow = $242, sfvit = $243, disactc1 = $244, discorc1 = $245, fsfvval = $246, marital = $247, typeed2 = $248, c2orign = $249, prox1619 = $250, candgnow = $251, curothf = $252, curothp = $253, curothwv = $254, gnvqnow = $255, ndeplnow = $256, oqualc1 = $257, oqualc2 = $258, oqualc3 = $259, webacnow = $260, ntsctnow = $261, skiwknow = $262 where user_id = $263 and edition = $264 and year = $265 and sernum = $266 and benunit = $267 and person = $268"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.child", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.child", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.child", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.child", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.child", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( person ) + 1, 1 ) from frs.child", SCHEMA_NAME );
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



   --
   -- returns true if the primary key parts of Ukds.Frs.Child match the defaults in Ukds.Frs.Null_Child
   --
   --
   -- Does this Ukds.Frs.Child equal the default Ukds.Frs.Null_Child ?
   --
   function Is_Null( a_child : Child ) return Boolean is
   begin
      return a_child = Ukds.Frs.Null_Child;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Child matching the primary key fields, or the Ukds.Frs.Null_Child record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; connection : Database_Connection := null ) return Ukds.Frs.Child is
      l : Ukds.Frs.Child_List;
      a_child : Ukds.Frs.Child;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      Add_benunit( c, benunit );
      Add_person( c, person );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Child_List_Package.is_empty( l ) ) then
         a_child := Ukds.Frs.Child_List_Package.First_Element( l );
      else
         a_child := Ukds.Frs.Null_Child;
      end if;
      return a_child;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.child where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6", 
        On_Server => True );
        
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; connection : Database_Connection := null ) return Boolean  is
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
      params( 6 ) := "+"( Integer'Pos( person ));
      cursor.Fetch( local_connection, EXISTS_PS, params );
      Check_Result( local_connection );
      found := gse.Has_Row( cursor );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
      return found;
   end Exists;

   
   --
   -- Retrieves a list of Child matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Child_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Child retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Child is
      a_child : Ukds.Frs.Child;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_child.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_child.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_child.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_child.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_child.benunit := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_child.person := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_child.adeduc := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_child.age := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_child.benccdis := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_child.care := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_child.cdisdif1 := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_child.cdisdif2 := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_child.cdisdif3 := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_child.cdisdif4 := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_child.cdisdif5 := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_child.cdisdif6 := gse.Integer_Value( cursor, 15 );
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_child.cdisdif7 := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_child.cdisdif8 := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_child.chamt1:= Amount'Value( gse.Value( cursor, 18 ));
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_child.chamt2:= Amount'Value( gse.Value( cursor, 19 ));
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_child.chamt3:= Amount'Value( gse.Value( cursor, 20 ));
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_child.chamt4:= Amount'Value( gse.Value( cursor, 21 ));
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_child.chamtern:= Amount'Value( gse.Value( cursor, 22 ));
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_child.chamttst:= Amount'Value( gse.Value( cursor, 23 ));
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_child.chdla1 := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_child.chdla2 := gse.Integer_Value( cursor, 25 );
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_child.chealth := gse.Integer_Value( cursor, 26 );
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_child.chearns1 := gse.Integer_Value( cursor, 27 );
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_child.chearns2 := gse.Integer_Value( cursor, 28 );
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_child.chema := gse.Integer_Value( cursor, 29 );
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_child.chemaamt:= Amount'Value( gse.Value( cursor, 30 ));
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_child.chemapd := gse.Integer_Value( cursor, 31 );
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_child.chfar := gse.Integer_Value( cursor, 32 );
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_child.chhr1 := gse.Integer_Value( cursor, 33 );
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_child.chhr2 := gse.Integer_Value( cursor, 34 );
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_child.chlook01 := gse.Integer_Value( cursor, 35 );
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_child.chlook02 := gse.Integer_Value( cursor, 36 );
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_child.chlook03 := gse.Integer_Value( cursor, 37 );
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_child.chlook04 := gse.Integer_Value( cursor, 38 );
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_child.chlook05 := gse.Integer_Value( cursor, 39 );
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_child.chlook06 := gse.Integer_Value( cursor, 40 );
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_child.chlook07 := gse.Integer_Value( cursor, 41 );
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_child.chlook08 := gse.Integer_Value( cursor, 42 );
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_child.chlook09 := gse.Integer_Value( cursor, 43 );
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_child.chlook10 := gse.Integer_Value( cursor, 44 );
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_child.chpay1 := gse.Integer_Value( cursor, 45 );
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_child.chpay2 := gse.Integer_Value( cursor, 46 );
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_child.chpay3 := gse.Integer_Value( cursor, 47 );
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_child.chpdern := gse.Integer_Value( cursor, 48 );
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_child.chpdtst := gse.Integer_Value( cursor, 49 );
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_child.chprob := gse.Integer_Value( cursor, 50 );
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_child.chsave := gse.Integer_Value( cursor, 51 );
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_child.chwkern := gse.Integer_Value( cursor, 52 );
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_child.chwktst := gse.Integer_Value( cursor, 53 );
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_child.chyrern := gse.Integer_Value( cursor, 54 );
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_child.chyrtst := gse.Integer_Value( cursor, 55 );
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_child.clone := gse.Integer_Value( cursor, 56 );
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_child.cohabit := gse.Integer_Value( cursor, 57 );
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_child.convbl := gse.Integer_Value( cursor, 58 );
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_child.cost := gse.Integer_Value( cursor, 59 );
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_child.cvht := gse.Integer_Value( cursor, 60 );
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_child.cvpay := gse.Integer_Value( cursor, 61 );
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_child.cvpd := gse.Integer_Value( cursor, 62 );
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_child.dentist := gse.Integer_Value( cursor, 63 );
      end if;
      if not gse.Is_Null( cursor, 64 )then
         a_child.depend := gse.Integer_Value( cursor, 64 );
      end if;
      if not gse.Is_Null( cursor, 65 )then
         a_child.dob := gse.Time_Value( cursor, 65 );
      end if;
      if not gse.Is_Null( cursor, 66 )then
         a_child.eligadlt := gse.Integer_Value( cursor, 66 );
      end if;
      if not gse.Is_Null( cursor, 67 )then
         a_child.eligchld := gse.Integer_Value( cursor, 67 );
      end if;
      if not gse.Is_Null( cursor, 68 )then
         a_child.endyr := gse.Integer_Value( cursor, 68 );
      end if;
      if not gse.Is_Null( cursor, 69 )then
         a_child.eyetest := gse.Integer_Value( cursor, 69 );
      end if;
      if not gse.Is_Null( cursor, 70 )then
         a_child.fted := gse.Integer_Value( cursor, 70 );
      end if;
      if not gse.Is_Null( cursor, 71 )then
         a_child.x_grant := gse.Integer_Value( cursor, 71 );
      end if;
      if not gse.Is_Null( cursor, 72 )then
         a_child.grtamt1:= Amount'Value( gse.Value( cursor, 72 ));
      end if;
      if not gse.Is_Null( cursor, 73 )then
         a_child.grtamt2:= Amount'Value( gse.Value( cursor, 73 ));
      end if;
      if not gse.Is_Null( cursor, 74 )then
         a_child.grtdir1:= Amount'Value( gse.Value( cursor, 74 ));
      end if;
      if not gse.Is_Null( cursor, 75 )then
         a_child.grtdir2:= Amount'Value( gse.Value( cursor, 75 ));
      end if;
      if not gse.Is_Null( cursor, 76 )then
         a_child.grtnum := gse.Integer_Value( cursor, 76 );
      end if;
      if not gse.Is_Null( cursor, 77 )then
         a_child.grtsce1 := gse.Integer_Value( cursor, 77 );
      end if;
      if not gse.Is_Null( cursor, 78 )then
         a_child.grtsce2 := gse.Integer_Value( cursor, 78 );
      end if;
      if not gse.Is_Null( cursor, 79 )then
         a_child.grtval1:= Amount'Value( gse.Value( cursor, 79 ));
      end if;
      if not gse.Is_Null( cursor, 80 )then
         a_child.grtval2:= Amount'Value( gse.Value( cursor, 80 ));
      end if;
      if not gse.Is_Null( cursor, 81 )then
         a_child.hholder := gse.Integer_Value( cursor, 81 );
      end if;
      if not gse.Is_Null( cursor, 82 )then
         a_child.hosp := gse.Integer_Value( cursor, 82 );
      end if;
      if not gse.Is_Null( cursor, 83 )then
         a_child.lareg := gse.Integer_Value( cursor, 83 );
      end if;
      if not gse.Is_Null( cursor, 84 )then
         a_child.legdep := gse.Integer_Value( cursor, 84 );
      end if;
      if not gse.Is_Null( cursor, 85 )then
         a_child.ms := gse.Integer_Value( cursor, 85 );
      end if;
      if not gse.Is_Null( cursor, 86 )then
         a_child.nhs1 := gse.Integer_Value( cursor, 86 );
      end if;
      if not gse.Is_Null( cursor, 87 )then
         a_child.nhs2 := gse.Integer_Value( cursor, 87 );
      end if;
      if not gse.Is_Null( cursor, 88 )then
         a_child.nhs3 := gse.Integer_Value( cursor, 88 );
      end if;
      if not gse.Is_Null( cursor, 89 )then
         a_child.parent1 := gse.Integer_Value( cursor, 89 );
      end if;
      if not gse.Is_Null( cursor, 90 )then
         a_child.parent2 := gse.Integer_Value( cursor, 90 );
      end if;
      if not gse.Is_Null( cursor, 91 )then
         a_child.prit := gse.Integer_Value( cursor, 91 );
      end if;
      if not gse.Is_Null( cursor, 92 )then
         a_child.prscrpt := gse.Integer_Value( cursor, 92 );
      end if;
      if not gse.Is_Null( cursor, 93 )then
         a_child.r01 := gse.Integer_Value( cursor, 93 );
      end if;
      if not gse.Is_Null( cursor, 94 )then
         a_child.r02 := gse.Integer_Value( cursor, 94 );
      end if;
      if not gse.Is_Null( cursor, 95 )then
         a_child.r03 := gse.Integer_Value( cursor, 95 );
      end if;
      if not gse.Is_Null( cursor, 96 )then
         a_child.r04 := gse.Integer_Value( cursor, 96 );
      end if;
      if not gse.Is_Null( cursor, 97 )then
         a_child.r05 := gse.Integer_Value( cursor, 97 );
      end if;
      if not gse.Is_Null( cursor, 98 )then
         a_child.r06 := gse.Integer_Value( cursor, 98 );
      end if;
      if not gse.Is_Null( cursor, 99 )then
         a_child.r07 := gse.Integer_Value( cursor, 99 );
      end if;
      if not gse.Is_Null( cursor, 100 )then
         a_child.r08 := gse.Integer_Value( cursor, 100 );
      end if;
      if not gse.Is_Null( cursor, 101 )then
         a_child.r09 := gse.Integer_Value( cursor, 101 );
      end if;
      if not gse.Is_Null( cursor, 102 )then
         a_child.r10 := gse.Integer_Value( cursor, 102 );
      end if;
      if not gse.Is_Null( cursor, 103 )then
         a_child.r11 := gse.Integer_Value( cursor, 103 );
      end if;
      if not gse.Is_Null( cursor, 104 )then
         a_child.r12 := gse.Integer_Value( cursor, 104 );
      end if;
      if not gse.Is_Null( cursor, 105 )then
         a_child.r13 := gse.Integer_Value( cursor, 105 );
      end if;
      if not gse.Is_Null( cursor, 106 )then
         a_child.r14 := gse.Integer_Value( cursor, 106 );
      end if;
      if not gse.Is_Null( cursor, 107 )then
         a_child.registr1 := gse.Integer_Value( cursor, 107 );
      end if;
      if not gse.Is_Null( cursor, 108 )then
         a_child.registr2 := gse.Integer_Value( cursor, 108 );
      end if;
      if not gse.Is_Null( cursor, 109 )then
         a_child.registr3 := gse.Integer_Value( cursor, 109 );
      end if;
      if not gse.Is_Null( cursor, 110 )then
         a_child.registr4 := gse.Integer_Value( cursor, 110 );
      end if;
      if not gse.Is_Null( cursor, 111 )then
         a_child.registr5 := gse.Integer_Value( cursor, 111 );
      end if;
      if not gse.Is_Null( cursor, 112 )then
         a_child.sex := gse.Integer_Value( cursor, 112 );
      end if;
      if not gse.Is_Null( cursor, 113 )then
         a_child.smkit := gse.Integer_Value( cursor, 113 );
      end if;
      if not gse.Is_Null( cursor, 114 )then
         a_child.smlit := gse.Integer_Value( cursor, 114 );
      end if;
      if not gse.Is_Null( cursor, 115 )then
         a_child.spcreg1 := gse.Integer_Value( cursor, 115 );
      end if;
      if not gse.Is_Null( cursor, 116 )then
         a_child.spcreg2 := gse.Integer_Value( cursor, 116 );
      end if;
      if not gse.Is_Null( cursor, 117 )then
         a_child.spcreg3 := gse.Integer_Value( cursor, 117 );
      end if;
      if not gse.Is_Null( cursor, 118 )then
         a_child.specs := gse.Integer_Value( cursor, 118 );
      end if;
      if not gse.Is_Null( cursor, 119 )then
         a_child.spout := gse.Integer_Value( cursor, 119 );
      end if;
      if not gse.Is_Null( cursor, 120 )then
         a_child.srentamt := gse.Integer_Value( cursor, 120 );
      end if;
      if not gse.Is_Null( cursor, 121 )then
         a_child.srentpd := gse.Integer_Value( cursor, 121 );
      end if;
      if not gse.Is_Null( cursor, 122 )then
         a_child.startyr := gse.Integer_Value( cursor, 122 );
      end if;
      if not gse.Is_Null( cursor, 123 )then
         a_child.totsave := gse.Integer_Value( cursor, 123 );
      end if;
      if not gse.Is_Null( cursor, 124 )then
         a_child.trav := gse.Integer_Value( cursor, 124 );
      end if;
      if not gse.Is_Null( cursor, 125 )then
         a_child.typeed := gse.Integer_Value( cursor, 125 );
      end if;
      if not gse.Is_Null( cursor, 126 )then
         a_child.voucher := gse.Integer_Value( cursor, 126 );
      end if;
      if not gse.Is_Null( cursor, 127 )then
         a_child.whytrav1 := gse.Integer_Value( cursor, 127 );
      end if;
      if not gse.Is_Null( cursor, 128 )then
         a_child.whytrav2 := gse.Integer_Value( cursor, 128 );
      end if;
      if not gse.Is_Null( cursor, 129 )then
         a_child.whytrav3 := gse.Integer_Value( cursor, 129 );
      end if;
      if not gse.Is_Null( cursor, 130 )then
         a_child.whytrav4 := gse.Integer_Value( cursor, 130 );
      end if;
      if not gse.Is_Null( cursor, 131 )then
         a_child.whytrav5 := gse.Integer_Value( cursor, 131 );
      end if;
      if not gse.Is_Null( cursor, 132 )then
         a_child.whytrav6 := gse.Integer_Value( cursor, 132 );
      end if;
      if not gse.Is_Null( cursor, 133 )then
         a_child.wmkit := gse.Integer_Value( cursor, 133 );
      end if;
      if not gse.Is_Null( cursor, 134 )then
         a_child.month := gse.Integer_Value( cursor, 134 );
      end if;
      if not gse.Is_Null( cursor, 135 )then
         a_child.careab := gse.Integer_Value( cursor, 135 );
      end if;
      if not gse.Is_Null( cursor, 136 )then
         a_child.careah := gse.Integer_Value( cursor, 136 );
      end if;
      if not gse.Is_Null( cursor, 137 )then
         a_child.carecb := gse.Integer_Value( cursor, 137 );
      end if;
      if not gse.Is_Null( cursor, 138 )then
         a_child.carech := gse.Integer_Value( cursor, 138 );
      end if;
      if not gse.Is_Null( cursor, 139 )then
         a_child.carecl := gse.Integer_Value( cursor, 139 );
      end if;
      if not gse.Is_Null( cursor, 140 )then
         a_child.carefl := gse.Integer_Value( cursor, 140 );
      end if;
      if not gse.Is_Null( cursor, 141 )then
         a_child.carefr := gse.Integer_Value( cursor, 141 );
      end if;
      if not gse.Is_Null( cursor, 142 )then
         a_child.careot := gse.Integer_Value( cursor, 142 );
      end if;
      if not gse.Is_Null( cursor, 143 )then
         a_child.carere := gse.Integer_Value( cursor, 143 );
      end if;
      if not gse.Is_Null( cursor, 144 )then
         a_child.chdda := gse.Integer_Value( cursor, 144 );
      end if;
      if not gse.Is_Null( cursor, 145 )then
         a_child.chearns:= Amount'Value( gse.Value( cursor, 145 ));
      end if;
      if not gse.Is_Null( cursor, 146 )then
         a_child.chincdv:= Amount'Value( gse.Value( cursor, 146 ));
      end if;
      if not gse.Is_Null( cursor, 147 )then
         a_child.chrinc:= Amount'Value( gse.Value( cursor, 147 ));
      end if;
      if not gse.Is_Null( cursor, 148 )then
         a_child.fsmlkval:= Amount'Value( gse.Value( cursor, 148 ));
      end if;
      if not gse.Is_Null( cursor, 149 )then
         a_child.fsmval:= Amount'Value( gse.Value( cursor, 149 ));
      end if;
      if not gse.Is_Null( cursor, 150 )then
         a_child.fwmlkval:= Amount'Value( gse.Value( cursor, 150 ));
      end if;
      if not gse.Is_Null( cursor, 151 )then
         a_child.hdagech := gse.Integer_Value( cursor, 151 );
      end if;
      if not gse.Is_Null( cursor, 152 )then
         a_child.hourab := gse.Integer_Value( cursor, 152 );
      end if;
      if not gse.Is_Null( cursor, 153 )then
         a_child.hourah := gse.Integer_Value( cursor, 153 );
      end if;
      if not gse.Is_Null( cursor, 154 )then
         a_child.hourcb := gse.Integer_Value( cursor, 154 );
      end if;
      if not gse.Is_Null( cursor, 155 )then
         a_child.hourch := gse.Integer_Value( cursor, 155 );
      end if;
      if not gse.Is_Null( cursor, 156 )then
         a_child.hourcl := gse.Integer_Value( cursor, 156 );
      end if;
      if not gse.Is_Null( cursor, 157 )then
         a_child.hourfr := gse.Integer_Value( cursor, 157 );
      end if;
      if not gse.Is_Null( cursor, 158 )then
         a_child.hourot := gse.Integer_Value( cursor, 158 );
      end if;
      if not gse.Is_Null( cursor, 159 )then
         a_child.hourre := gse.Integer_Value( cursor, 159 );
      end if;
      if not gse.Is_Null( cursor, 160 )then
         a_child.hourtot := gse.Integer_Value( cursor, 160 );
      end if;
      if not gse.Is_Null( cursor, 161 )then
         a_child.hperson := gse.Integer_Value( cursor, 161 );
      end if;
      if not gse.Is_Null( cursor, 162 )then
         a_child.iagegr2 := gse.Integer_Value( cursor, 162 );
      end if;
      if not gse.Is_Null( cursor, 163 )then
         a_child.iagegrp := gse.Integer_Value( cursor, 163 );
      end if;
      if not gse.Is_Null( cursor, 164 )then
         a_child.relhrp := gse.Integer_Value( cursor, 164 );
      end if;
      if not gse.Is_Null( cursor, 165 )then
         a_child.totgntch:= Amount'Value( gse.Value( cursor, 165 ));
      end if;
      if not gse.Is_Null( cursor, 166 )then
         a_child.uperson := gse.Integer_Value( cursor, 166 );
      end if;
      if not gse.Is_Null( cursor, 167 )then
         a_child.cddatre := gse.Integer_Value( cursor, 167 );
      end if;
      if not gse.Is_Null( cursor, 168 )then
         a_child.cdisdif9 := gse.Integer_Value( cursor, 168 );
      end if;
      if not gse.Is_Null( cursor, 169 )then
         a_child.cddatrep := gse.Integer_Value( cursor, 169 );
      end if;
      if not gse.Is_Null( cursor, 170 )then
         a_child.cdisdifp := gse.Integer_Value( cursor, 170 );
      end if;
      if not gse.Is_Null( cursor, 171 )then
         a_child.cfund := gse.Integer_Value( cursor, 171 );
      end if;
      if not gse.Is_Null( cursor, 172 )then
         a_child.cfundh:= Amount'Value( gse.Value( cursor, 172 ));
      end if;
      if not gse.Is_Null( cursor, 173 )then
         a_child.cfundtp := gse.Integer_Value( cursor, 173 );
      end if;
      if not gse.Is_Null( cursor, 174 )then
         a_child.fundamt1:= Amount'Value( gse.Value( cursor, 174 ));
      end if;
      if not gse.Is_Null( cursor, 175 )then
         a_child.fundamt2:= Amount'Value( gse.Value( cursor, 175 ));
      end if;
      if not gse.Is_Null( cursor, 176 )then
         a_child.fundamt3:= Amount'Value( gse.Value( cursor, 176 ));
      end if;
      if not gse.Is_Null( cursor, 177 )then
         a_child.fundamt4:= Amount'Value( gse.Value( cursor, 177 ));
      end if;
      if not gse.Is_Null( cursor, 178 )then
         a_child.fundamt5:= Amount'Value( gse.Value( cursor, 178 ));
      end if;
      if not gse.Is_Null( cursor, 179 )then
         a_child.fundamt6:= Amount'Value( gse.Value( cursor, 179 ));
      end if;
      if not gse.Is_Null( cursor, 180 )then
         a_child.givcfnd1 := gse.Integer_Value( cursor, 180 );
      end if;
      if not gse.Is_Null( cursor, 181 )then
         a_child.givcfnd2 := gse.Integer_Value( cursor, 181 );
      end if;
      if not gse.Is_Null( cursor, 182 )then
         a_child.givcfnd3 := gse.Integer_Value( cursor, 182 );
      end if;
      if not gse.Is_Null( cursor, 183 )then
         a_child.givcfnd4 := gse.Integer_Value( cursor, 183 );
      end if;
      if not gse.Is_Null( cursor, 184 )then
         a_child.givcfnd5 := gse.Integer_Value( cursor, 184 );
      end if;
      if not gse.Is_Null( cursor, 185 )then
         a_child.givcfnd6 := gse.Integer_Value( cursor, 185 );
      end if;
      if not gse.Is_Null( cursor, 186 )then
         a_child.tuacam:= Amount'Value( gse.Value( cursor, 186 ));
      end if;
      if not gse.Is_Null( cursor, 187 )then
         a_child.schchk := gse.Integer_Value( cursor, 187 );
      end if;
      if not gse.Is_Null( cursor, 188 )then
         a_child.trainee := gse.Integer_Value( cursor, 188 );
      end if;
      if not gse.Is_Null( cursor, 189 )then
         a_child.cddaprg := gse.Integer_Value( cursor, 189 );
      end if;
      if not gse.Is_Null( cursor, 190 )then
         a_child.issue := gse.Integer_Value( cursor, 190 );
      end if;
      if not gse.Is_Null( cursor, 191 )then
         a_child.heartval:= Amount'Value( gse.Value( cursor, 191 ));
      end if;
      if not gse.Is_Null( cursor, 192 )then
         a_child.xbonflag := gse.Integer_Value( cursor, 192 );
      end if;
      if not gse.Is_Null( cursor, 193 )then
         a_child.chca := gse.Integer_Value( cursor, 193 );
      end if;
      if not gse.Is_Null( cursor, 194 )then
         a_child.disdifch := gse.Integer_Value( cursor, 194 );
      end if;
      if not gse.Is_Null( cursor, 195 )then
         a_child.chearns3 := gse.Integer_Value( cursor, 195 );
      end if;
      if not gse.Is_Null( cursor, 196 )then
         a_child.chtrnamt:= Amount'Value( gse.Value( cursor, 196 ));
      end if;
      if not gse.Is_Null( cursor, 197 )then
         a_child.chtrnpd := gse.Integer_Value( cursor, 197 );
      end if;
      if not gse.Is_Null( cursor, 198 )then
         a_child.hsvper := gse.Integer_Value( cursor, 198 );
      end if;
      if not gse.Is_Null( cursor, 199 )then
         a_child.mednum := gse.Integer_Value( cursor, 199 );
      end if;
      if not gse.Is_Null( cursor, 200 )then
         a_child.medprpd := gse.Integer_Value( cursor, 200 );
      end if;
      if not gse.Is_Null( cursor, 201 )then
         a_child.medprpy := gse.Integer_Value( cursor, 201 );
      end if;
      if not gse.Is_Null( cursor, 202 )then
         a_child.sbkit := gse.Integer_Value( cursor, 202 );
      end if;
      if not gse.Is_Null( cursor, 203 )then
         a_child.dobmonth := gse.Integer_Value( cursor, 203 );
      end if;
      if not gse.Is_Null( cursor, 204 )then
         a_child.dobyear := gse.Integer_Value( cursor, 204 );
      end if;
      if not gse.Is_Null( cursor, 205 )then
         a_child.fsbval:= Amount'Value( gse.Value( cursor, 205 ));
      end if;
      if not gse.Is_Null( cursor, 206 )then
         a_child.btecnow := gse.Integer_Value( cursor, 206 );
      end if;
      if not gse.Is_Null( cursor, 207 )then
         a_child.cameyr := gse.Integer_Value( cursor, 207 );
      end if;
      if not gse.Is_Null( cursor, 208 )then
         a_child.cdaprog1 := gse.Integer_Value( cursor, 208 );
      end if;
      if not gse.Is_Null( cursor, 209 )then
         a_child.cdatre1 := gse.Integer_Value( cursor, 209 );
      end if;
      if not gse.Is_Null( cursor, 210 )then
         a_child.cdatrep1 := gse.Integer_Value( cursor, 210 );
      end if;
      if not gse.Is_Null( cursor, 211 )then
         a_child.cdisd01 := gse.Integer_Value( cursor, 211 );
      end if;
      if not gse.Is_Null( cursor, 212 )then
         a_child.cdisd02 := gse.Integer_Value( cursor, 212 );
      end if;
      if not gse.Is_Null( cursor, 213 )then
         a_child.cdisd03 := gse.Integer_Value( cursor, 213 );
      end if;
      if not gse.Is_Null( cursor, 214 )then
         a_child.cdisd04 := gse.Integer_Value( cursor, 214 );
      end if;
      if not gse.Is_Null( cursor, 215 )then
         a_child.cdisd05 := gse.Integer_Value( cursor, 215 );
      end if;
      if not gse.Is_Null( cursor, 216 )then
         a_child.cdisd06 := gse.Integer_Value( cursor, 216 );
      end if;
      if not gse.Is_Null( cursor, 217 )then
         a_child.cdisd07 := gse.Integer_Value( cursor, 217 );
      end if;
      if not gse.Is_Null( cursor, 218 )then
         a_child.cdisd08 := gse.Integer_Value( cursor, 218 );
      end if;
      if not gse.Is_Null( cursor, 219 )then
         a_child.cdisd09 := gse.Integer_Value( cursor, 219 );
      end if;
      if not gse.Is_Null( cursor, 220 )then
         a_child.cdisd10 := gse.Integer_Value( cursor, 220 );
      end if;
      if not gse.Is_Null( cursor, 221 )then
         a_child.chbfd := gse.Integer_Value( cursor, 221 );
      end if;
      if not gse.Is_Null( cursor, 222 )then
         a_child.chbfdamt:= Amount'Value( gse.Value( cursor, 222 ));
      end if;
      if not gse.Is_Null( cursor, 223 )then
         a_child.chbfdpd := gse.Integer_Value( cursor, 223 );
      end if;
      if not gse.Is_Null( cursor, 224 )then
         a_child.chbfdval := gse.Integer_Value( cursor, 224 );
      end if;
      if not gse.Is_Null( cursor, 225 )then
         a_child.chcond := gse.Integer_Value( cursor, 225 );
      end if;
      if not gse.Is_Null( cursor, 226 )then
         a_child.chealth1 := gse.Integer_Value( cursor, 226 );
      end if;
      if not gse.Is_Null( cursor, 227 )then
         a_child.chlimitl := gse.Integer_Value( cursor, 227 );
      end if;
      if not gse.Is_Null( cursor, 228 )then
         a_child.citizen := gse.Integer_Value( cursor, 228 );
      end if;
      if not gse.Is_Null( cursor, 229 )then
         a_child.citizen2 := gse.Integer_Value( cursor, 229 );
      end if;
      if not gse.Is_Null( cursor, 230 )then
         a_child.contuk := gse.Integer_Value( cursor, 230 );
      end if;
      if not gse.Is_Null( cursor, 231 )then
         a_child.corign := gse.Integer_Value( cursor, 231 );
      end if;
      if not gse.Is_Null( cursor, 232 )then
         a_child.corigoth := gse.Integer_Value( cursor, 232 );
      end if;
      if not gse.Is_Null( cursor, 233 )then
         a_child.curqual := gse.Integer_Value( cursor, 233 );
      end if;
      if not gse.Is_Null( cursor, 234 )then
         a_child.degrenow := gse.Integer_Value( cursor, 234 );
      end if;
      if not gse.Is_Null( cursor, 235 )then
         a_child.denrec := gse.Integer_Value( cursor, 235 );
      end if;
      if not gse.Is_Null( cursor, 236 )then
         a_child.dvmardf := gse.Integer_Value( cursor, 236 );
      end if;
      if not gse.Is_Null( cursor, 237 )then
         a_child.heathch := gse.Integer_Value( cursor, 237 );
      end if;
      if not gse.Is_Null( cursor, 238 )then
         a_child.highonow := gse.Integer_Value( cursor, 238 );
      end if;
      if not gse.Is_Null( cursor, 239 )then
         a_child.hrsed := gse.Integer_Value( cursor, 239 );
      end if;
      if not gse.Is_Null( cursor, 240 )then
         a_child.medrec := gse.Integer_Value( cursor, 240 );
      end if;
      if not gse.Is_Null( cursor, 241 )then
         a_child.nvqlenow := gse.Integer_Value( cursor, 241 );
      end if;
      if not gse.Is_Null( cursor, 242 )then
         a_child.othpass := gse.Integer_Value( cursor, 242 );
      end if;
      if not gse.Is_Null( cursor, 243 )then
         a_child.reasden := gse.Integer_Value( cursor, 243 );
      end if;
      if not gse.Is_Null( cursor, 244 )then
         a_child.reasmed := gse.Integer_Value( cursor, 244 );
      end if;
      if not gse.Is_Null( cursor, 245 )then
         a_child.reasnhs := gse.Integer_Value( cursor, 245 );
      end if;
      if not gse.Is_Null( cursor, 246 )then
         a_child.rsanow := gse.Integer_Value( cursor, 246 );
      end if;
      if not gse.Is_Null( cursor, 247 )then
         a_child.sctvnow := gse.Integer_Value( cursor, 247 );
      end if;
      if not gse.Is_Null( cursor, 248 )then
         a_child.sfvit := gse.Integer_Value( cursor, 248 );
      end if;
      if not gse.Is_Null( cursor, 249 )then
         a_child.disactc1 := gse.Integer_Value( cursor, 249 );
      end if;
      if not gse.Is_Null( cursor, 250 )then
         a_child.discorc1 := gse.Integer_Value( cursor, 250 );
      end if;
      if not gse.Is_Null( cursor, 251 )then
         a_child.fsfvval:= Amount'Value( gse.Value( cursor, 251 ));
      end if;
      if not gse.Is_Null( cursor, 252 )then
         a_child.marital := gse.Integer_Value( cursor, 252 );
      end if;
      if not gse.Is_Null( cursor, 253 )then
         a_child.typeed2 := gse.Integer_Value( cursor, 253 );
      end if;
      if not gse.Is_Null( cursor, 254 )then
         a_child.c2orign := gse.Integer_Value( cursor, 254 );
      end if;
      if not gse.Is_Null( cursor, 255 )then
         a_child.prox1619 := gse.Integer_Value( cursor, 255 );
      end if;
      if not gse.Is_Null( cursor, 256 )then
         a_child.candgnow := gse.Integer_Value( cursor, 256 );
      end if;
      if not gse.Is_Null( cursor, 257 )then
         a_child.curothf := gse.Integer_Value( cursor, 257 );
      end if;
      if not gse.Is_Null( cursor, 258 )then
         a_child.curothp := gse.Integer_Value( cursor, 258 );
      end if;
      if not gse.Is_Null( cursor, 259 )then
         a_child.curothwv := gse.Integer_Value( cursor, 259 );
      end if;
      if not gse.Is_Null( cursor, 260 )then
         a_child.gnvqnow := gse.Integer_Value( cursor, 260 );
      end if;
      if not gse.Is_Null( cursor, 261 )then
         a_child.ndeplnow := gse.Integer_Value( cursor, 261 );
      end if;
      if not gse.Is_Null( cursor, 262 )then
         a_child.oqualc1 := gse.Integer_Value( cursor, 262 );
      end if;
      if not gse.Is_Null( cursor, 263 )then
         a_child.oqualc2 := gse.Integer_Value( cursor, 263 );
      end if;
      if not gse.Is_Null( cursor, 264 )then
         a_child.oqualc3 := gse.Integer_Value( cursor, 264 );
      end if;
      if not gse.Is_Null( cursor, 265 )then
         a_child.webacnow := gse.Integer_Value( cursor, 265 );
      end if;
      if not gse.Is_Null( cursor, 266 )then
         a_child.ntsctnow := gse.Integer_Value( cursor, 266 );
      end if;
      if not gse.Is_Null( cursor, 267 )then
         a_child.skiwknow := gse.Integer_Value( cursor, 267 );
      end if;
      return a_child;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Child_List is
      l : Ukds.Frs.Child_List;
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
            a_child : Ukds.Frs.Child := Map_From_Cursor( cursor );
         begin
            l.append( a_child ); 
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
   
   procedure Update( a_child : Ukds.Frs.Child; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_child.adeduc ));
      params( 2 ) := "+"( Integer'Pos( a_child.age ));
      params( 3 ) := "+"( Integer'Pos( a_child.benccdis ));
      params( 4 ) := "+"( Integer'Pos( a_child.care ));
      params( 5 ) := "+"( Integer'Pos( a_child.cdisdif1 ));
      params( 6 ) := "+"( Integer'Pos( a_child.cdisdif2 ));
      params( 7 ) := "+"( Integer'Pos( a_child.cdisdif3 ));
      params( 8 ) := "+"( Integer'Pos( a_child.cdisdif4 ));
      params( 9 ) := "+"( Integer'Pos( a_child.cdisdif5 ));
      params( 10 ) := "+"( Integer'Pos( a_child.cdisdif6 ));
      params( 11 ) := "+"( Integer'Pos( a_child.cdisdif7 ));
      params( 12 ) := "+"( Integer'Pos( a_child.cdisdif8 ));
      params( 13 ) := "+"( Float( a_child.chamt1 ));
      params( 14 ) := "+"( Float( a_child.chamt2 ));
      params( 15 ) := "+"( Float( a_child.chamt3 ));
      params( 16 ) := "+"( Float( a_child.chamt4 ));
      params( 17 ) := "+"( Float( a_child.chamtern ));
      params( 18 ) := "+"( Float( a_child.chamttst ));
      params( 19 ) := "+"( Integer'Pos( a_child.chdla1 ));
      params( 20 ) := "+"( Integer'Pos( a_child.chdla2 ));
      params( 21 ) := "+"( Integer'Pos( a_child.chealth ));
      params( 22 ) := "+"( Integer'Pos( a_child.chearns1 ));
      params( 23 ) := "+"( Integer'Pos( a_child.chearns2 ));
      params( 24 ) := "+"( Integer'Pos( a_child.chema ));
      params( 25 ) := "+"( Float( a_child.chemaamt ));
      params( 26 ) := "+"( Integer'Pos( a_child.chemapd ));
      params( 27 ) := "+"( Integer'Pos( a_child.chfar ));
      params( 28 ) := "+"( Integer'Pos( a_child.chhr1 ));
      params( 29 ) := "+"( Integer'Pos( a_child.chhr2 ));
      params( 30 ) := "+"( Integer'Pos( a_child.chlook01 ));
      params( 31 ) := "+"( Integer'Pos( a_child.chlook02 ));
      params( 32 ) := "+"( Integer'Pos( a_child.chlook03 ));
      params( 33 ) := "+"( Integer'Pos( a_child.chlook04 ));
      params( 34 ) := "+"( Integer'Pos( a_child.chlook05 ));
      params( 35 ) := "+"( Integer'Pos( a_child.chlook06 ));
      params( 36 ) := "+"( Integer'Pos( a_child.chlook07 ));
      params( 37 ) := "+"( Integer'Pos( a_child.chlook08 ));
      params( 38 ) := "+"( Integer'Pos( a_child.chlook09 ));
      params( 39 ) := "+"( Integer'Pos( a_child.chlook10 ));
      params( 40 ) := "+"( Integer'Pos( a_child.chpay1 ));
      params( 41 ) := "+"( Integer'Pos( a_child.chpay2 ));
      params( 42 ) := "+"( Integer'Pos( a_child.chpay3 ));
      params( 43 ) := "+"( Integer'Pos( a_child.chpdern ));
      params( 44 ) := "+"( Integer'Pos( a_child.chpdtst ));
      params( 45 ) := "+"( Integer'Pos( a_child.chprob ));
      params( 46 ) := "+"( Integer'Pos( a_child.chsave ));
      params( 47 ) := "+"( Integer'Pos( a_child.chwkern ));
      params( 48 ) := "+"( Integer'Pos( a_child.chwktst ));
      params( 49 ) := "+"( Integer'Pos( a_child.chyrern ));
      params( 50 ) := "+"( Integer'Pos( a_child.chyrtst ));
      params( 51 ) := "+"( Integer'Pos( a_child.clone ));
      params( 52 ) := "+"( Integer'Pos( a_child.cohabit ));
      params( 53 ) := "+"( Integer'Pos( a_child.convbl ));
      params( 54 ) := "+"( Integer'Pos( a_child.cost ));
      params( 55 ) := "+"( Integer'Pos( a_child.cvht ));
      params( 56 ) := "+"( Integer'Pos( a_child.cvpay ));
      params( 57 ) := "+"( Integer'Pos( a_child.cvpd ));
      params( 58 ) := "+"( Integer'Pos( a_child.dentist ));
      params( 59 ) := "+"( Integer'Pos( a_child.depend ));
      params( 60 ) := "+"( a_child.dob );
      params( 61 ) := "+"( Integer'Pos( a_child.eligadlt ));
      params( 62 ) := "+"( Integer'Pos( a_child.eligchld ));
      params( 63 ) := "+"( Integer'Pos( a_child.endyr ));
      params( 64 ) := "+"( Integer'Pos( a_child.eyetest ));
      params( 65 ) := "+"( Integer'Pos( a_child.fted ));
      params( 66 ) := "+"( Integer'Pos( a_child.x_grant ));
      params( 67 ) := "+"( Float( a_child.grtamt1 ));
      params( 68 ) := "+"( Float( a_child.grtamt2 ));
      params( 69 ) := "+"( Float( a_child.grtdir1 ));
      params( 70 ) := "+"( Float( a_child.grtdir2 ));
      params( 71 ) := "+"( Integer'Pos( a_child.grtnum ));
      params( 72 ) := "+"( Integer'Pos( a_child.grtsce1 ));
      params( 73 ) := "+"( Integer'Pos( a_child.grtsce2 ));
      params( 74 ) := "+"( Float( a_child.grtval1 ));
      params( 75 ) := "+"( Float( a_child.grtval2 ));
      params( 76 ) := "+"( Integer'Pos( a_child.hholder ));
      params( 77 ) := "+"( Integer'Pos( a_child.hosp ));
      params( 78 ) := "+"( Integer'Pos( a_child.lareg ));
      params( 79 ) := "+"( Integer'Pos( a_child.legdep ));
      params( 80 ) := "+"( Integer'Pos( a_child.ms ));
      params( 81 ) := "+"( Integer'Pos( a_child.nhs1 ));
      params( 82 ) := "+"( Integer'Pos( a_child.nhs2 ));
      params( 83 ) := "+"( Integer'Pos( a_child.nhs3 ));
      params( 84 ) := "+"( Integer'Pos( a_child.parent1 ));
      params( 85 ) := "+"( Integer'Pos( a_child.parent2 ));
      params( 86 ) := "+"( Integer'Pos( a_child.prit ));
      params( 87 ) := "+"( Integer'Pos( a_child.prscrpt ));
      params( 88 ) := "+"( Integer'Pos( a_child.r01 ));
      params( 89 ) := "+"( Integer'Pos( a_child.r02 ));
      params( 90 ) := "+"( Integer'Pos( a_child.r03 ));
      params( 91 ) := "+"( Integer'Pos( a_child.r04 ));
      params( 92 ) := "+"( Integer'Pos( a_child.r05 ));
      params( 93 ) := "+"( Integer'Pos( a_child.r06 ));
      params( 94 ) := "+"( Integer'Pos( a_child.r07 ));
      params( 95 ) := "+"( Integer'Pos( a_child.r08 ));
      params( 96 ) := "+"( Integer'Pos( a_child.r09 ));
      params( 97 ) := "+"( Integer'Pos( a_child.r10 ));
      params( 98 ) := "+"( Integer'Pos( a_child.r11 ));
      params( 99 ) := "+"( Integer'Pos( a_child.r12 ));
      params( 100 ) := "+"( Integer'Pos( a_child.r13 ));
      params( 101 ) := "+"( Integer'Pos( a_child.r14 ));
      params( 102 ) := "+"( Integer'Pos( a_child.registr1 ));
      params( 103 ) := "+"( Integer'Pos( a_child.registr2 ));
      params( 104 ) := "+"( Integer'Pos( a_child.registr3 ));
      params( 105 ) := "+"( Integer'Pos( a_child.registr4 ));
      params( 106 ) := "+"( Integer'Pos( a_child.registr5 ));
      params( 107 ) := "+"( Integer'Pos( a_child.sex ));
      params( 108 ) := "+"( Integer'Pos( a_child.smkit ));
      params( 109 ) := "+"( Integer'Pos( a_child.smlit ));
      params( 110 ) := "+"( Integer'Pos( a_child.spcreg1 ));
      params( 111 ) := "+"( Integer'Pos( a_child.spcreg2 ));
      params( 112 ) := "+"( Integer'Pos( a_child.spcreg3 ));
      params( 113 ) := "+"( Integer'Pos( a_child.specs ));
      params( 114 ) := "+"( Integer'Pos( a_child.spout ));
      params( 115 ) := "+"( Integer'Pos( a_child.srentamt ));
      params( 116 ) := "+"( Integer'Pos( a_child.srentpd ));
      params( 117 ) := "+"( Integer'Pos( a_child.startyr ));
      params( 118 ) := "+"( Integer'Pos( a_child.totsave ));
      params( 119 ) := "+"( Integer'Pos( a_child.trav ));
      params( 120 ) := "+"( Integer'Pos( a_child.typeed ));
      params( 121 ) := "+"( Integer'Pos( a_child.voucher ));
      params( 122 ) := "+"( Integer'Pos( a_child.whytrav1 ));
      params( 123 ) := "+"( Integer'Pos( a_child.whytrav2 ));
      params( 124 ) := "+"( Integer'Pos( a_child.whytrav3 ));
      params( 125 ) := "+"( Integer'Pos( a_child.whytrav4 ));
      params( 126 ) := "+"( Integer'Pos( a_child.whytrav5 ));
      params( 127 ) := "+"( Integer'Pos( a_child.whytrav6 ));
      params( 128 ) := "+"( Integer'Pos( a_child.wmkit ));
      params( 129 ) := "+"( Integer'Pos( a_child.month ));
      params( 130 ) := "+"( Integer'Pos( a_child.careab ));
      params( 131 ) := "+"( Integer'Pos( a_child.careah ));
      params( 132 ) := "+"( Integer'Pos( a_child.carecb ));
      params( 133 ) := "+"( Integer'Pos( a_child.carech ));
      params( 134 ) := "+"( Integer'Pos( a_child.carecl ));
      params( 135 ) := "+"( Integer'Pos( a_child.carefl ));
      params( 136 ) := "+"( Integer'Pos( a_child.carefr ));
      params( 137 ) := "+"( Integer'Pos( a_child.careot ));
      params( 138 ) := "+"( Integer'Pos( a_child.carere ));
      params( 139 ) := "+"( Integer'Pos( a_child.chdda ));
      params( 140 ) := "+"( Float( a_child.chearns ));
      params( 141 ) := "+"( Float( a_child.chincdv ));
      params( 142 ) := "+"( Float( a_child.chrinc ));
      params( 143 ) := "+"( Float( a_child.fsmlkval ));
      params( 144 ) := "+"( Float( a_child.fsmval ));
      params( 145 ) := "+"( Float( a_child.fwmlkval ));
      params( 146 ) := "+"( Integer'Pos( a_child.hdagech ));
      params( 147 ) := "+"( Integer'Pos( a_child.hourab ));
      params( 148 ) := "+"( Integer'Pos( a_child.hourah ));
      params( 149 ) := "+"( Integer'Pos( a_child.hourcb ));
      params( 150 ) := "+"( Integer'Pos( a_child.hourch ));
      params( 151 ) := "+"( Integer'Pos( a_child.hourcl ));
      params( 152 ) := "+"( Integer'Pos( a_child.hourfr ));
      params( 153 ) := "+"( Integer'Pos( a_child.hourot ));
      params( 154 ) := "+"( Integer'Pos( a_child.hourre ));
      params( 155 ) := "+"( Integer'Pos( a_child.hourtot ));
      params( 156 ) := "+"( Integer'Pos( a_child.hperson ));
      params( 157 ) := "+"( Integer'Pos( a_child.iagegr2 ));
      params( 158 ) := "+"( Integer'Pos( a_child.iagegrp ));
      params( 159 ) := "+"( Integer'Pos( a_child.relhrp ));
      params( 160 ) := "+"( Float( a_child.totgntch ));
      params( 161 ) := "+"( Integer'Pos( a_child.uperson ));
      params( 162 ) := "+"( Integer'Pos( a_child.cddatre ));
      params( 163 ) := "+"( Integer'Pos( a_child.cdisdif9 ));
      params( 164 ) := "+"( Integer'Pos( a_child.cddatrep ));
      params( 165 ) := "+"( Integer'Pos( a_child.cdisdifp ));
      params( 166 ) := "+"( Integer'Pos( a_child.cfund ));
      params( 167 ) := "+"( Float( a_child.cfundh ));
      params( 168 ) := "+"( Integer'Pos( a_child.cfundtp ));
      params( 169 ) := "+"( Float( a_child.fundamt1 ));
      params( 170 ) := "+"( Float( a_child.fundamt2 ));
      params( 171 ) := "+"( Float( a_child.fundamt3 ));
      params( 172 ) := "+"( Float( a_child.fundamt4 ));
      params( 173 ) := "+"( Float( a_child.fundamt5 ));
      params( 174 ) := "+"( Float( a_child.fundamt6 ));
      params( 175 ) := "+"( Integer'Pos( a_child.givcfnd1 ));
      params( 176 ) := "+"( Integer'Pos( a_child.givcfnd2 ));
      params( 177 ) := "+"( Integer'Pos( a_child.givcfnd3 ));
      params( 178 ) := "+"( Integer'Pos( a_child.givcfnd4 ));
      params( 179 ) := "+"( Integer'Pos( a_child.givcfnd5 ));
      params( 180 ) := "+"( Integer'Pos( a_child.givcfnd6 ));
      params( 181 ) := "+"( Float( a_child.tuacam ));
      params( 182 ) := "+"( Integer'Pos( a_child.schchk ));
      params( 183 ) := "+"( Integer'Pos( a_child.trainee ));
      params( 184 ) := "+"( Integer'Pos( a_child.cddaprg ));
      params( 185 ) := "+"( Integer'Pos( a_child.issue ));
      params( 186 ) := "+"( Float( a_child.heartval ));
      params( 187 ) := "+"( Integer'Pos( a_child.xbonflag ));
      params( 188 ) := "+"( Integer'Pos( a_child.chca ));
      params( 189 ) := "+"( Integer'Pos( a_child.disdifch ));
      params( 190 ) := "+"( Integer'Pos( a_child.chearns3 ));
      params( 191 ) := "+"( Float( a_child.chtrnamt ));
      params( 192 ) := "+"( Integer'Pos( a_child.chtrnpd ));
      params( 193 ) := "+"( Integer'Pos( a_child.hsvper ));
      params( 194 ) := "+"( Integer'Pos( a_child.mednum ));
      params( 195 ) := "+"( Integer'Pos( a_child.medprpd ));
      params( 196 ) := "+"( Integer'Pos( a_child.medprpy ));
      params( 197 ) := "+"( Integer'Pos( a_child.sbkit ));
      params( 198 ) := "+"( Integer'Pos( a_child.dobmonth ));
      params( 199 ) := "+"( Integer'Pos( a_child.dobyear ));
      params( 200 ) := "+"( Float( a_child.fsbval ));
      params( 201 ) := "+"( Integer'Pos( a_child.btecnow ));
      params( 202 ) := "+"( Integer'Pos( a_child.cameyr ));
      params( 203 ) := "+"( Integer'Pos( a_child.cdaprog1 ));
      params( 204 ) := "+"( Integer'Pos( a_child.cdatre1 ));
      params( 205 ) := "+"( Integer'Pos( a_child.cdatrep1 ));
      params( 206 ) := "+"( Integer'Pos( a_child.cdisd01 ));
      params( 207 ) := "+"( Integer'Pos( a_child.cdisd02 ));
      params( 208 ) := "+"( Integer'Pos( a_child.cdisd03 ));
      params( 209 ) := "+"( Integer'Pos( a_child.cdisd04 ));
      params( 210 ) := "+"( Integer'Pos( a_child.cdisd05 ));
      params( 211 ) := "+"( Integer'Pos( a_child.cdisd06 ));
      params( 212 ) := "+"( Integer'Pos( a_child.cdisd07 ));
      params( 213 ) := "+"( Integer'Pos( a_child.cdisd08 ));
      params( 214 ) := "+"( Integer'Pos( a_child.cdisd09 ));
      params( 215 ) := "+"( Integer'Pos( a_child.cdisd10 ));
      params( 216 ) := "+"( Integer'Pos( a_child.chbfd ));
      params( 217 ) := "+"( Float( a_child.chbfdamt ));
      params( 218 ) := "+"( Integer'Pos( a_child.chbfdpd ));
      params( 219 ) := "+"( Integer'Pos( a_child.chbfdval ));
      params( 220 ) := "+"( Integer'Pos( a_child.chcond ));
      params( 221 ) := "+"( Integer'Pos( a_child.chealth1 ));
      params( 222 ) := "+"( Integer'Pos( a_child.chlimitl ));
      params( 223 ) := "+"( Integer'Pos( a_child.citizen ));
      params( 224 ) := "+"( Integer'Pos( a_child.citizen2 ));
      params( 225 ) := "+"( Integer'Pos( a_child.contuk ));
      params( 226 ) := "+"( Integer'Pos( a_child.corign ));
      params( 227 ) := "+"( Integer'Pos( a_child.corigoth ));
      params( 228 ) := "+"( Integer'Pos( a_child.curqual ));
      params( 229 ) := "+"( Integer'Pos( a_child.degrenow ));
      params( 230 ) := "+"( Integer'Pos( a_child.denrec ));
      params( 231 ) := "+"( Integer'Pos( a_child.dvmardf ));
      params( 232 ) := "+"( Integer'Pos( a_child.heathch ));
      params( 233 ) := "+"( Integer'Pos( a_child.highonow ));
      params( 234 ) := "+"( Integer'Pos( a_child.hrsed ));
      params( 235 ) := "+"( Integer'Pos( a_child.medrec ));
      params( 236 ) := "+"( Integer'Pos( a_child.nvqlenow ));
      params( 237 ) := "+"( Integer'Pos( a_child.othpass ));
      params( 238 ) := "+"( Integer'Pos( a_child.reasden ));
      params( 239 ) := "+"( Integer'Pos( a_child.reasmed ));
      params( 240 ) := "+"( Integer'Pos( a_child.reasnhs ));
      params( 241 ) := "+"( Integer'Pos( a_child.rsanow ));
      params( 242 ) := "+"( Integer'Pos( a_child.sctvnow ));
      params( 243 ) := "+"( Integer'Pos( a_child.sfvit ));
      params( 244 ) := "+"( Integer'Pos( a_child.disactc1 ));
      params( 245 ) := "+"( Integer'Pos( a_child.discorc1 ));
      params( 246 ) := "+"( Float( a_child.fsfvval ));
      params( 247 ) := "+"( Integer'Pos( a_child.marital ));
      params( 248 ) := "+"( Integer'Pos( a_child.typeed2 ));
      params( 249 ) := "+"( Integer'Pos( a_child.c2orign ));
      params( 250 ) := "+"( Integer'Pos( a_child.prox1619 ));
      params( 251 ) := "+"( Integer'Pos( a_child.candgnow ));
      params( 252 ) := "+"( Integer'Pos( a_child.curothf ));
      params( 253 ) := "+"( Integer'Pos( a_child.curothp ));
      params( 254 ) := "+"( Integer'Pos( a_child.curothwv ));
      params( 255 ) := "+"( Integer'Pos( a_child.gnvqnow ));
      params( 256 ) := "+"( Integer'Pos( a_child.ndeplnow ));
      params( 257 ) := "+"( Integer'Pos( a_child.oqualc1 ));
      params( 258 ) := "+"( Integer'Pos( a_child.oqualc2 ));
      params( 259 ) := "+"( Integer'Pos( a_child.oqualc3 ));
      params( 260 ) := "+"( Integer'Pos( a_child.webacnow ));
      params( 261 ) := "+"( Integer'Pos( a_child.ntsctnow ));
      params( 262 ) := "+"( Integer'Pos( a_child.skiwknow ));
      params( 263 ) := "+"( Integer'Pos( a_child.user_id ));
      params( 264 ) := "+"( Integer'Pos( a_child.edition ));
      params( 265 ) := "+"( Integer'Pos( a_child.year ));
      params( 266 ) := As_Bigint( a_child.sernum );
      params( 267 ) := "+"( Integer'Pos( a_child.benunit ));
      params( 268 ) := "+"( Integer'Pos( a_child.person ));
      
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

   procedure Save( a_child : Ukds.Frs.Child; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_child.user_id, a_child.edition, a_child.year, a_child.sernum, a_child.benunit, a_child.person ) then
         Update( a_child, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_child.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_child.edition ));
      params( 3 ) := "+"( Integer'Pos( a_child.year ));
      params( 4 ) := As_Bigint( a_child.sernum );
      params( 5 ) := "+"( Integer'Pos( a_child.benunit ));
      params( 6 ) := "+"( Integer'Pos( a_child.person ));
      params( 7 ) := "+"( Integer'Pos( a_child.adeduc ));
      params( 8 ) := "+"( Integer'Pos( a_child.age ));
      params( 9 ) := "+"( Integer'Pos( a_child.benccdis ));
      params( 10 ) := "+"( Integer'Pos( a_child.care ));
      params( 11 ) := "+"( Integer'Pos( a_child.cdisdif1 ));
      params( 12 ) := "+"( Integer'Pos( a_child.cdisdif2 ));
      params( 13 ) := "+"( Integer'Pos( a_child.cdisdif3 ));
      params( 14 ) := "+"( Integer'Pos( a_child.cdisdif4 ));
      params( 15 ) := "+"( Integer'Pos( a_child.cdisdif5 ));
      params( 16 ) := "+"( Integer'Pos( a_child.cdisdif6 ));
      params( 17 ) := "+"( Integer'Pos( a_child.cdisdif7 ));
      params( 18 ) := "+"( Integer'Pos( a_child.cdisdif8 ));
      params( 19 ) := "+"( Float( a_child.chamt1 ));
      params( 20 ) := "+"( Float( a_child.chamt2 ));
      params( 21 ) := "+"( Float( a_child.chamt3 ));
      params( 22 ) := "+"( Float( a_child.chamt4 ));
      params( 23 ) := "+"( Float( a_child.chamtern ));
      params( 24 ) := "+"( Float( a_child.chamttst ));
      params( 25 ) := "+"( Integer'Pos( a_child.chdla1 ));
      params( 26 ) := "+"( Integer'Pos( a_child.chdla2 ));
      params( 27 ) := "+"( Integer'Pos( a_child.chealth ));
      params( 28 ) := "+"( Integer'Pos( a_child.chearns1 ));
      params( 29 ) := "+"( Integer'Pos( a_child.chearns2 ));
      params( 30 ) := "+"( Integer'Pos( a_child.chema ));
      params( 31 ) := "+"( Float( a_child.chemaamt ));
      params( 32 ) := "+"( Integer'Pos( a_child.chemapd ));
      params( 33 ) := "+"( Integer'Pos( a_child.chfar ));
      params( 34 ) := "+"( Integer'Pos( a_child.chhr1 ));
      params( 35 ) := "+"( Integer'Pos( a_child.chhr2 ));
      params( 36 ) := "+"( Integer'Pos( a_child.chlook01 ));
      params( 37 ) := "+"( Integer'Pos( a_child.chlook02 ));
      params( 38 ) := "+"( Integer'Pos( a_child.chlook03 ));
      params( 39 ) := "+"( Integer'Pos( a_child.chlook04 ));
      params( 40 ) := "+"( Integer'Pos( a_child.chlook05 ));
      params( 41 ) := "+"( Integer'Pos( a_child.chlook06 ));
      params( 42 ) := "+"( Integer'Pos( a_child.chlook07 ));
      params( 43 ) := "+"( Integer'Pos( a_child.chlook08 ));
      params( 44 ) := "+"( Integer'Pos( a_child.chlook09 ));
      params( 45 ) := "+"( Integer'Pos( a_child.chlook10 ));
      params( 46 ) := "+"( Integer'Pos( a_child.chpay1 ));
      params( 47 ) := "+"( Integer'Pos( a_child.chpay2 ));
      params( 48 ) := "+"( Integer'Pos( a_child.chpay3 ));
      params( 49 ) := "+"( Integer'Pos( a_child.chpdern ));
      params( 50 ) := "+"( Integer'Pos( a_child.chpdtst ));
      params( 51 ) := "+"( Integer'Pos( a_child.chprob ));
      params( 52 ) := "+"( Integer'Pos( a_child.chsave ));
      params( 53 ) := "+"( Integer'Pos( a_child.chwkern ));
      params( 54 ) := "+"( Integer'Pos( a_child.chwktst ));
      params( 55 ) := "+"( Integer'Pos( a_child.chyrern ));
      params( 56 ) := "+"( Integer'Pos( a_child.chyrtst ));
      params( 57 ) := "+"( Integer'Pos( a_child.clone ));
      params( 58 ) := "+"( Integer'Pos( a_child.cohabit ));
      params( 59 ) := "+"( Integer'Pos( a_child.convbl ));
      params( 60 ) := "+"( Integer'Pos( a_child.cost ));
      params( 61 ) := "+"( Integer'Pos( a_child.cvht ));
      params( 62 ) := "+"( Integer'Pos( a_child.cvpay ));
      params( 63 ) := "+"( Integer'Pos( a_child.cvpd ));
      params( 64 ) := "+"( Integer'Pos( a_child.dentist ));
      params( 65 ) := "+"( Integer'Pos( a_child.depend ));
      params( 66 ) := "+"( a_child.dob );
      params( 67 ) := "+"( Integer'Pos( a_child.eligadlt ));
      params( 68 ) := "+"( Integer'Pos( a_child.eligchld ));
      params( 69 ) := "+"( Integer'Pos( a_child.endyr ));
      params( 70 ) := "+"( Integer'Pos( a_child.eyetest ));
      params( 71 ) := "+"( Integer'Pos( a_child.fted ));
      params( 72 ) := "+"( Integer'Pos( a_child.x_grant ));
      params( 73 ) := "+"( Float( a_child.grtamt1 ));
      params( 74 ) := "+"( Float( a_child.grtamt2 ));
      params( 75 ) := "+"( Float( a_child.grtdir1 ));
      params( 76 ) := "+"( Float( a_child.grtdir2 ));
      params( 77 ) := "+"( Integer'Pos( a_child.grtnum ));
      params( 78 ) := "+"( Integer'Pos( a_child.grtsce1 ));
      params( 79 ) := "+"( Integer'Pos( a_child.grtsce2 ));
      params( 80 ) := "+"( Float( a_child.grtval1 ));
      params( 81 ) := "+"( Float( a_child.grtval2 ));
      params( 82 ) := "+"( Integer'Pos( a_child.hholder ));
      params( 83 ) := "+"( Integer'Pos( a_child.hosp ));
      params( 84 ) := "+"( Integer'Pos( a_child.lareg ));
      params( 85 ) := "+"( Integer'Pos( a_child.legdep ));
      params( 86 ) := "+"( Integer'Pos( a_child.ms ));
      params( 87 ) := "+"( Integer'Pos( a_child.nhs1 ));
      params( 88 ) := "+"( Integer'Pos( a_child.nhs2 ));
      params( 89 ) := "+"( Integer'Pos( a_child.nhs3 ));
      params( 90 ) := "+"( Integer'Pos( a_child.parent1 ));
      params( 91 ) := "+"( Integer'Pos( a_child.parent2 ));
      params( 92 ) := "+"( Integer'Pos( a_child.prit ));
      params( 93 ) := "+"( Integer'Pos( a_child.prscrpt ));
      params( 94 ) := "+"( Integer'Pos( a_child.r01 ));
      params( 95 ) := "+"( Integer'Pos( a_child.r02 ));
      params( 96 ) := "+"( Integer'Pos( a_child.r03 ));
      params( 97 ) := "+"( Integer'Pos( a_child.r04 ));
      params( 98 ) := "+"( Integer'Pos( a_child.r05 ));
      params( 99 ) := "+"( Integer'Pos( a_child.r06 ));
      params( 100 ) := "+"( Integer'Pos( a_child.r07 ));
      params( 101 ) := "+"( Integer'Pos( a_child.r08 ));
      params( 102 ) := "+"( Integer'Pos( a_child.r09 ));
      params( 103 ) := "+"( Integer'Pos( a_child.r10 ));
      params( 104 ) := "+"( Integer'Pos( a_child.r11 ));
      params( 105 ) := "+"( Integer'Pos( a_child.r12 ));
      params( 106 ) := "+"( Integer'Pos( a_child.r13 ));
      params( 107 ) := "+"( Integer'Pos( a_child.r14 ));
      params( 108 ) := "+"( Integer'Pos( a_child.registr1 ));
      params( 109 ) := "+"( Integer'Pos( a_child.registr2 ));
      params( 110 ) := "+"( Integer'Pos( a_child.registr3 ));
      params( 111 ) := "+"( Integer'Pos( a_child.registr4 ));
      params( 112 ) := "+"( Integer'Pos( a_child.registr5 ));
      params( 113 ) := "+"( Integer'Pos( a_child.sex ));
      params( 114 ) := "+"( Integer'Pos( a_child.smkit ));
      params( 115 ) := "+"( Integer'Pos( a_child.smlit ));
      params( 116 ) := "+"( Integer'Pos( a_child.spcreg1 ));
      params( 117 ) := "+"( Integer'Pos( a_child.spcreg2 ));
      params( 118 ) := "+"( Integer'Pos( a_child.spcreg3 ));
      params( 119 ) := "+"( Integer'Pos( a_child.specs ));
      params( 120 ) := "+"( Integer'Pos( a_child.spout ));
      params( 121 ) := "+"( Integer'Pos( a_child.srentamt ));
      params( 122 ) := "+"( Integer'Pos( a_child.srentpd ));
      params( 123 ) := "+"( Integer'Pos( a_child.startyr ));
      params( 124 ) := "+"( Integer'Pos( a_child.totsave ));
      params( 125 ) := "+"( Integer'Pos( a_child.trav ));
      params( 126 ) := "+"( Integer'Pos( a_child.typeed ));
      params( 127 ) := "+"( Integer'Pos( a_child.voucher ));
      params( 128 ) := "+"( Integer'Pos( a_child.whytrav1 ));
      params( 129 ) := "+"( Integer'Pos( a_child.whytrav2 ));
      params( 130 ) := "+"( Integer'Pos( a_child.whytrav3 ));
      params( 131 ) := "+"( Integer'Pos( a_child.whytrav4 ));
      params( 132 ) := "+"( Integer'Pos( a_child.whytrav5 ));
      params( 133 ) := "+"( Integer'Pos( a_child.whytrav6 ));
      params( 134 ) := "+"( Integer'Pos( a_child.wmkit ));
      params( 135 ) := "+"( Integer'Pos( a_child.month ));
      params( 136 ) := "+"( Integer'Pos( a_child.careab ));
      params( 137 ) := "+"( Integer'Pos( a_child.careah ));
      params( 138 ) := "+"( Integer'Pos( a_child.carecb ));
      params( 139 ) := "+"( Integer'Pos( a_child.carech ));
      params( 140 ) := "+"( Integer'Pos( a_child.carecl ));
      params( 141 ) := "+"( Integer'Pos( a_child.carefl ));
      params( 142 ) := "+"( Integer'Pos( a_child.carefr ));
      params( 143 ) := "+"( Integer'Pos( a_child.careot ));
      params( 144 ) := "+"( Integer'Pos( a_child.carere ));
      params( 145 ) := "+"( Integer'Pos( a_child.chdda ));
      params( 146 ) := "+"( Float( a_child.chearns ));
      params( 147 ) := "+"( Float( a_child.chincdv ));
      params( 148 ) := "+"( Float( a_child.chrinc ));
      params( 149 ) := "+"( Float( a_child.fsmlkval ));
      params( 150 ) := "+"( Float( a_child.fsmval ));
      params( 151 ) := "+"( Float( a_child.fwmlkval ));
      params( 152 ) := "+"( Integer'Pos( a_child.hdagech ));
      params( 153 ) := "+"( Integer'Pos( a_child.hourab ));
      params( 154 ) := "+"( Integer'Pos( a_child.hourah ));
      params( 155 ) := "+"( Integer'Pos( a_child.hourcb ));
      params( 156 ) := "+"( Integer'Pos( a_child.hourch ));
      params( 157 ) := "+"( Integer'Pos( a_child.hourcl ));
      params( 158 ) := "+"( Integer'Pos( a_child.hourfr ));
      params( 159 ) := "+"( Integer'Pos( a_child.hourot ));
      params( 160 ) := "+"( Integer'Pos( a_child.hourre ));
      params( 161 ) := "+"( Integer'Pos( a_child.hourtot ));
      params( 162 ) := "+"( Integer'Pos( a_child.hperson ));
      params( 163 ) := "+"( Integer'Pos( a_child.iagegr2 ));
      params( 164 ) := "+"( Integer'Pos( a_child.iagegrp ));
      params( 165 ) := "+"( Integer'Pos( a_child.relhrp ));
      params( 166 ) := "+"( Float( a_child.totgntch ));
      params( 167 ) := "+"( Integer'Pos( a_child.uperson ));
      params( 168 ) := "+"( Integer'Pos( a_child.cddatre ));
      params( 169 ) := "+"( Integer'Pos( a_child.cdisdif9 ));
      params( 170 ) := "+"( Integer'Pos( a_child.cddatrep ));
      params( 171 ) := "+"( Integer'Pos( a_child.cdisdifp ));
      params( 172 ) := "+"( Integer'Pos( a_child.cfund ));
      params( 173 ) := "+"( Float( a_child.cfundh ));
      params( 174 ) := "+"( Integer'Pos( a_child.cfundtp ));
      params( 175 ) := "+"( Float( a_child.fundamt1 ));
      params( 176 ) := "+"( Float( a_child.fundamt2 ));
      params( 177 ) := "+"( Float( a_child.fundamt3 ));
      params( 178 ) := "+"( Float( a_child.fundamt4 ));
      params( 179 ) := "+"( Float( a_child.fundamt5 ));
      params( 180 ) := "+"( Float( a_child.fundamt6 ));
      params( 181 ) := "+"( Integer'Pos( a_child.givcfnd1 ));
      params( 182 ) := "+"( Integer'Pos( a_child.givcfnd2 ));
      params( 183 ) := "+"( Integer'Pos( a_child.givcfnd3 ));
      params( 184 ) := "+"( Integer'Pos( a_child.givcfnd4 ));
      params( 185 ) := "+"( Integer'Pos( a_child.givcfnd5 ));
      params( 186 ) := "+"( Integer'Pos( a_child.givcfnd6 ));
      params( 187 ) := "+"( Float( a_child.tuacam ));
      params( 188 ) := "+"( Integer'Pos( a_child.schchk ));
      params( 189 ) := "+"( Integer'Pos( a_child.trainee ));
      params( 190 ) := "+"( Integer'Pos( a_child.cddaprg ));
      params( 191 ) := "+"( Integer'Pos( a_child.issue ));
      params( 192 ) := "+"( Float( a_child.heartval ));
      params( 193 ) := "+"( Integer'Pos( a_child.xbonflag ));
      params( 194 ) := "+"( Integer'Pos( a_child.chca ));
      params( 195 ) := "+"( Integer'Pos( a_child.disdifch ));
      params( 196 ) := "+"( Integer'Pos( a_child.chearns3 ));
      params( 197 ) := "+"( Float( a_child.chtrnamt ));
      params( 198 ) := "+"( Integer'Pos( a_child.chtrnpd ));
      params( 199 ) := "+"( Integer'Pos( a_child.hsvper ));
      params( 200 ) := "+"( Integer'Pos( a_child.mednum ));
      params( 201 ) := "+"( Integer'Pos( a_child.medprpd ));
      params( 202 ) := "+"( Integer'Pos( a_child.medprpy ));
      params( 203 ) := "+"( Integer'Pos( a_child.sbkit ));
      params( 204 ) := "+"( Integer'Pos( a_child.dobmonth ));
      params( 205 ) := "+"( Integer'Pos( a_child.dobyear ));
      params( 206 ) := "+"( Float( a_child.fsbval ));
      params( 207 ) := "+"( Integer'Pos( a_child.btecnow ));
      params( 208 ) := "+"( Integer'Pos( a_child.cameyr ));
      params( 209 ) := "+"( Integer'Pos( a_child.cdaprog1 ));
      params( 210 ) := "+"( Integer'Pos( a_child.cdatre1 ));
      params( 211 ) := "+"( Integer'Pos( a_child.cdatrep1 ));
      params( 212 ) := "+"( Integer'Pos( a_child.cdisd01 ));
      params( 213 ) := "+"( Integer'Pos( a_child.cdisd02 ));
      params( 214 ) := "+"( Integer'Pos( a_child.cdisd03 ));
      params( 215 ) := "+"( Integer'Pos( a_child.cdisd04 ));
      params( 216 ) := "+"( Integer'Pos( a_child.cdisd05 ));
      params( 217 ) := "+"( Integer'Pos( a_child.cdisd06 ));
      params( 218 ) := "+"( Integer'Pos( a_child.cdisd07 ));
      params( 219 ) := "+"( Integer'Pos( a_child.cdisd08 ));
      params( 220 ) := "+"( Integer'Pos( a_child.cdisd09 ));
      params( 221 ) := "+"( Integer'Pos( a_child.cdisd10 ));
      params( 222 ) := "+"( Integer'Pos( a_child.chbfd ));
      params( 223 ) := "+"( Float( a_child.chbfdamt ));
      params( 224 ) := "+"( Integer'Pos( a_child.chbfdpd ));
      params( 225 ) := "+"( Integer'Pos( a_child.chbfdval ));
      params( 226 ) := "+"( Integer'Pos( a_child.chcond ));
      params( 227 ) := "+"( Integer'Pos( a_child.chealth1 ));
      params( 228 ) := "+"( Integer'Pos( a_child.chlimitl ));
      params( 229 ) := "+"( Integer'Pos( a_child.citizen ));
      params( 230 ) := "+"( Integer'Pos( a_child.citizen2 ));
      params( 231 ) := "+"( Integer'Pos( a_child.contuk ));
      params( 232 ) := "+"( Integer'Pos( a_child.corign ));
      params( 233 ) := "+"( Integer'Pos( a_child.corigoth ));
      params( 234 ) := "+"( Integer'Pos( a_child.curqual ));
      params( 235 ) := "+"( Integer'Pos( a_child.degrenow ));
      params( 236 ) := "+"( Integer'Pos( a_child.denrec ));
      params( 237 ) := "+"( Integer'Pos( a_child.dvmardf ));
      params( 238 ) := "+"( Integer'Pos( a_child.heathch ));
      params( 239 ) := "+"( Integer'Pos( a_child.highonow ));
      params( 240 ) := "+"( Integer'Pos( a_child.hrsed ));
      params( 241 ) := "+"( Integer'Pos( a_child.medrec ));
      params( 242 ) := "+"( Integer'Pos( a_child.nvqlenow ));
      params( 243 ) := "+"( Integer'Pos( a_child.othpass ));
      params( 244 ) := "+"( Integer'Pos( a_child.reasden ));
      params( 245 ) := "+"( Integer'Pos( a_child.reasmed ));
      params( 246 ) := "+"( Integer'Pos( a_child.reasnhs ));
      params( 247 ) := "+"( Integer'Pos( a_child.rsanow ));
      params( 248 ) := "+"( Integer'Pos( a_child.sctvnow ));
      params( 249 ) := "+"( Integer'Pos( a_child.sfvit ));
      params( 250 ) := "+"( Integer'Pos( a_child.disactc1 ));
      params( 251 ) := "+"( Integer'Pos( a_child.discorc1 ));
      params( 252 ) := "+"( Float( a_child.fsfvval ));
      params( 253 ) := "+"( Integer'Pos( a_child.marital ));
      params( 254 ) := "+"( Integer'Pos( a_child.typeed2 ));
      params( 255 ) := "+"( Integer'Pos( a_child.c2orign ));
      params( 256 ) := "+"( Integer'Pos( a_child.prox1619 ));
      params( 257 ) := "+"( Integer'Pos( a_child.candgnow ));
      params( 258 ) := "+"( Integer'Pos( a_child.curothf ));
      params( 259 ) := "+"( Integer'Pos( a_child.curothp ));
      params( 260 ) := "+"( Integer'Pos( a_child.curothwv ));
      params( 261 ) := "+"( Integer'Pos( a_child.gnvqnow ));
      params( 262 ) := "+"( Integer'Pos( a_child.ndeplnow ));
      params( 263 ) := "+"( Integer'Pos( a_child.oqualc1 ));
      params( 264 ) := "+"( Integer'Pos( a_child.oqualc2 ));
      params( 265 ) := "+"( Integer'Pos( a_child.oqualc3 ));
      params( 266 ) := "+"( Integer'Pos( a_child.webacnow ));
      params( 267 ) := "+"( Integer'Pos( a_child.ntsctnow ));
      params( 268 ) := "+"( Integer'Pos( a_child.skiwknow ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Child
   --

   procedure Delete( a_child : in out Ukds.Frs.Child; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_child.user_id );
      Add_edition( c, a_child.edition );
      Add_year( c, a_child.year );
      Add_sernum( c, a_child.sernum );
      Add_benunit( c, a_child.benunit );
      Add_person( c, a_child.person );
      Delete( c, connection );
      a_child := Ukds.Frs.Null_Child;
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


   procedure Add_adeduc( c : in out d.Criteria; adeduc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adeduc", op, join, adeduc );
   begin
      d.add_to_criteria( c, elem );
   end Add_adeduc;


   procedure Add_age( c : in out d.Criteria; age : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age", op, join, age );
   begin
      d.add_to_criteria( c, elem );
   end Add_age;


   procedure Add_benccdis( c : in out d.Criteria; benccdis : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "benccdis", op, join, benccdis );
   begin
      d.add_to_criteria( c, elem );
   end Add_benccdis;


   procedure Add_care( c : in out d.Criteria; care : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "care", op, join, care );
   begin
      d.add_to_criteria( c, elem );
   end Add_care;


   procedure Add_cdisdif1( c : in out d.Criteria; cdisdif1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisdif1", op, join, cdisdif1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif1;


   procedure Add_cdisdif2( c : in out d.Criteria; cdisdif2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisdif2", op, join, cdisdif2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif2;


   procedure Add_cdisdif3( c : in out d.Criteria; cdisdif3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisdif3", op, join, cdisdif3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif3;


   procedure Add_cdisdif4( c : in out d.Criteria; cdisdif4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisdif4", op, join, cdisdif4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif4;


   procedure Add_cdisdif5( c : in out d.Criteria; cdisdif5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisdif5", op, join, cdisdif5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif5;


   procedure Add_cdisdif6( c : in out d.Criteria; cdisdif6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisdif6", op, join, cdisdif6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif6;


   procedure Add_cdisdif7( c : in out d.Criteria; cdisdif7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisdif7", op, join, cdisdif7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif7;


   procedure Add_cdisdif8( c : in out d.Criteria; cdisdif8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisdif8", op, join, cdisdif8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif8;


   procedure Add_chamt1( c : in out d.Criteria; chamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chamt1", op, join, Long_Float( chamt1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamt1;


   procedure Add_chamt2( c : in out d.Criteria; chamt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chamt2", op, join, Long_Float( chamt2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamt2;


   procedure Add_chamt3( c : in out d.Criteria; chamt3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chamt3", op, join, Long_Float( chamt3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamt3;


   procedure Add_chamt4( c : in out d.Criteria; chamt4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chamt4", op, join, Long_Float( chamt4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamt4;


   procedure Add_chamtern( c : in out d.Criteria; chamtern : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chamtern", op, join, Long_Float( chamtern ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamtern;


   procedure Add_chamttst( c : in out d.Criteria; chamttst : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chamttst", op, join, Long_Float( chamttst ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamttst;


   procedure Add_chdla1( c : in out d.Criteria; chdla1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chdla1", op, join, chdla1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chdla1;


   procedure Add_chdla2( c : in out d.Criteria; chdla2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chdla2", op, join, chdla2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chdla2;


   procedure Add_chealth( c : in out d.Criteria; chealth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chealth", op, join, chealth );
   begin
      d.add_to_criteria( c, elem );
   end Add_chealth;


   procedure Add_chearns1( c : in out d.Criteria; chearns1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chearns1", op, join, chearns1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chearns1;


   procedure Add_chearns2( c : in out d.Criteria; chearns2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chearns2", op, join, chearns2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chearns2;


   procedure Add_chema( c : in out d.Criteria; chema : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chema", op, join, chema );
   begin
      d.add_to_criteria( c, elem );
   end Add_chema;


   procedure Add_chemaamt( c : in out d.Criteria; chemaamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chemaamt", op, join, Long_Float( chemaamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chemaamt;


   procedure Add_chemapd( c : in out d.Criteria; chemapd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chemapd", op, join, chemapd );
   begin
      d.add_to_criteria( c, elem );
   end Add_chemapd;


   procedure Add_chfar( c : in out d.Criteria; chfar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chfar", op, join, chfar );
   begin
      d.add_to_criteria( c, elem );
   end Add_chfar;


   procedure Add_chhr1( c : in out d.Criteria; chhr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chhr1", op, join, chhr1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chhr1;


   procedure Add_chhr2( c : in out d.Criteria; chhr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chhr2", op, join, chhr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chhr2;


   procedure Add_chlook01( c : in out d.Criteria; chlook01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chlook01", op, join, chlook01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook01;


   procedure Add_chlook02( c : in out d.Criteria; chlook02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chlook02", op, join, chlook02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook02;


   procedure Add_chlook03( c : in out d.Criteria; chlook03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chlook03", op, join, chlook03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook03;


   procedure Add_chlook04( c : in out d.Criteria; chlook04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chlook04", op, join, chlook04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook04;


   procedure Add_chlook05( c : in out d.Criteria; chlook05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chlook05", op, join, chlook05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook05;


   procedure Add_chlook06( c : in out d.Criteria; chlook06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chlook06", op, join, chlook06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook06;


   procedure Add_chlook07( c : in out d.Criteria; chlook07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chlook07", op, join, chlook07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook07;


   procedure Add_chlook08( c : in out d.Criteria; chlook08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chlook08", op, join, chlook08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook08;


   procedure Add_chlook09( c : in out d.Criteria; chlook09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chlook09", op, join, chlook09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook09;


   procedure Add_chlook10( c : in out d.Criteria; chlook10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chlook10", op, join, chlook10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook10;


   procedure Add_chpay1( c : in out d.Criteria; chpay1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chpay1", op, join, chpay1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chpay1;


   procedure Add_chpay2( c : in out d.Criteria; chpay2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chpay2", op, join, chpay2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chpay2;


   procedure Add_chpay3( c : in out d.Criteria; chpay3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chpay3", op, join, chpay3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chpay3;


   procedure Add_chpdern( c : in out d.Criteria; chpdern : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chpdern", op, join, chpdern );
   begin
      d.add_to_criteria( c, elem );
   end Add_chpdern;


   procedure Add_chpdtst( c : in out d.Criteria; chpdtst : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chpdtst", op, join, chpdtst );
   begin
      d.add_to_criteria( c, elem );
   end Add_chpdtst;


   procedure Add_chprob( c : in out d.Criteria; chprob : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chprob", op, join, chprob );
   begin
      d.add_to_criteria( c, elem );
   end Add_chprob;


   procedure Add_chsave( c : in out d.Criteria; chsave : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chsave", op, join, chsave );
   begin
      d.add_to_criteria( c, elem );
   end Add_chsave;


   procedure Add_chwkern( c : in out d.Criteria; chwkern : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chwkern", op, join, chwkern );
   begin
      d.add_to_criteria( c, elem );
   end Add_chwkern;


   procedure Add_chwktst( c : in out d.Criteria; chwktst : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chwktst", op, join, chwktst );
   begin
      d.add_to_criteria( c, elem );
   end Add_chwktst;


   procedure Add_chyrern( c : in out d.Criteria; chyrern : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chyrern", op, join, chyrern );
   begin
      d.add_to_criteria( c, elem );
   end Add_chyrern;


   procedure Add_chyrtst( c : in out d.Criteria; chyrtst : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chyrtst", op, join, chyrtst );
   begin
      d.add_to_criteria( c, elem );
   end Add_chyrtst;


   procedure Add_clone( c : in out d.Criteria; clone : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "clone", op, join, clone );
   begin
      d.add_to_criteria( c, elem );
   end Add_clone;


   procedure Add_cohabit( c : in out d.Criteria; cohabit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cohabit", op, join, cohabit );
   begin
      d.add_to_criteria( c, elem );
   end Add_cohabit;


   procedure Add_convbl( c : in out d.Criteria; convbl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "convbl", op, join, convbl );
   begin
      d.add_to_criteria( c, elem );
   end Add_convbl;


   procedure Add_cost( c : in out d.Criteria; cost : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cost", op, join, cost );
   begin
      d.add_to_criteria( c, elem );
   end Add_cost;


   procedure Add_cvht( c : in out d.Criteria; cvht : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cvht", op, join, cvht );
   begin
      d.add_to_criteria( c, elem );
   end Add_cvht;


   procedure Add_cvpay( c : in out d.Criteria; cvpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cvpay", op, join, cvpay );
   begin
      d.add_to_criteria( c, elem );
   end Add_cvpay;


   procedure Add_cvpd( c : in out d.Criteria; cvpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cvpd", op, join, cvpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_cvpd;


   procedure Add_dentist( c : in out d.Criteria; dentist : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dentist", op, join, dentist );
   begin
      d.add_to_criteria( c, elem );
   end Add_dentist;


   procedure Add_depend( c : in out d.Criteria; depend : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "depend", op, join, depend );
   begin
      d.add_to_criteria( c, elem );
   end Add_depend;


   procedure Add_dob( c : in out d.Criteria; dob : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dob", op, join, Ada.Calendar.Time( dob ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_dob;


   procedure Add_eligadlt( c : in out d.Criteria; eligadlt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eligadlt", op, join, eligadlt );
   begin
      d.add_to_criteria( c, elem );
   end Add_eligadlt;


   procedure Add_eligchld( c : in out d.Criteria; eligchld : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eligchld", op, join, eligchld );
   begin
      d.add_to_criteria( c, elem );
   end Add_eligchld;


   procedure Add_endyr( c : in out d.Criteria; endyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "endyr", op, join, endyr );
   begin
      d.add_to_criteria( c, elem );
   end Add_endyr;


   procedure Add_eyetest( c : in out d.Criteria; eyetest : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eyetest", op, join, eyetest );
   begin
      d.add_to_criteria( c, elem );
   end Add_eyetest;


   procedure Add_fted( c : in out d.Criteria; fted : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fted", op, join, fted );
   begin
      d.add_to_criteria( c, elem );
   end Add_fted;


   procedure Add_x_grant( c : in out d.Criteria; x_grant : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "x_grant", op, join, x_grant );
   begin
      d.add_to_criteria( c, elem );
   end Add_x_grant;


   procedure Add_grtamt1( c : in out d.Criteria; grtamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grtamt1", op, join, Long_Float( grtamt1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtamt1;


   procedure Add_grtamt2( c : in out d.Criteria; grtamt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grtamt2", op, join, Long_Float( grtamt2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtamt2;


   procedure Add_grtdir1( c : in out d.Criteria; grtdir1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grtdir1", op, join, Long_Float( grtdir1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtdir1;


   procedure Add_grtdir2( c : in out d.Criteria; grtdir2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grtdir2", op, join, Long_Float( grtdir2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtdir2;


   procedure Add_grtnum( c : in out d.Criteria; grtnum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grtnum", op, join, grtnum );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtnum;


   procedure Add_grtsce1( c : in out d.Criteria; grtsce1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grtsce1", op, join, grtsce1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtsce1;


   procedure Add_grtsce2( c : in out d.Criteria; grtsce2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grtsce2", op, join, grtsce2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtsce2;


   procedure Add_grtval1( c : in out d.Criteria; grtval1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grtval1", op, join, Long_Float( grtval1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtval1;


   procedure Add_grtval2( c : in out d.Criteria; grtval2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "grtval2", op, join, Long_Float( grtval2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtval2;


   procedure Add_hholder( c : in out d.Criteria; hholder : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hholder", op, join, hholder );
   begin
      d.add_to_criteria( c, elem );
   end Add_hholder;


   procedure Add_hosp( c : in out d.Criteria; hosp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hosp", op, join, hosp );
   begin
      d.add_to_criteria( c, elem );
   end Add_hosp;


   procedure Add_lareg( c : in out d.Criteria; lareg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lareg", op, join, lareg );
   begin
      d.add_to_criteria( c, elem );
   end Add_lareg;


   procedure Add_legdep( c : in out d.Criteria; legdep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "legdep", op, join, legdep );
   begin
      d.add_to_criteria( c, elem );
   end Add_legdep;


   procedure Add_ms( c : in out d.Criteria; ms : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ms", op, join, ms );
   begin
      d.add_to_criteria( c, elem );
   end Add_ms;


   procedure Add_nhs1( c : in out d.Criteria; nhs1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nhs1", op, join, nhs1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhs1;


   procedure Add_nhs2( c : in out d.Criteria; nhs2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nhs2", op, join, nhs2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhs2;


   procedure Add_nhs3( c : in out d.Criteria; nhs3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nhs3", op, join, nhs3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhs3;


   procedure Add_parent1( c : in out d.Criteria; parent1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "parent1", op, join, parent1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_parent1;


   procedure Add_parent2( c : in out d.Criteria; parent2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "parent2", op, join, parent2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_parent2;


   procedure Add_prit( c : in out d.Criteria; prit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "prit", op, join, prit );
   begin
      d.add_to_criteria( c, elem );
   end Add_prit;


   procedure Add_prscrpt( c : in out d.Criteria; prscrpt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "prscrpt", op, join, prscrpt );
   begin
      d.add_to_criteria( c, elem );
   end Add_prscrpt;


   procedure Add_r01( c : in out d.Criteria; r01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r01", op, join, r01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r01;


   procedure Add_r02( c : in out d.Criteria; r02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r02", op, join, r02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r02;


   procedure Add_r03( c : in out d.Criteria; r03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r03", op, join, r03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r03;


   procedure Add_r04( c : in out d.Criteria; r04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r04", op, join, r04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r04;


   procedure Add_r05( c : in out d.Criteria; r05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r05", op, join, r05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r05;


   procedure Add_r06( c : in out d.Criteria; r06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r06", op, join, r06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r06;


   procedure Add_r07( c : in out d.Criteria; r07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r07", op, join, r07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r07;


   procedure Add_r08( c : in out d.Criteria; r08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r08", op, join, r08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r08;


   procedure Add_r09( c : in out d.Criteria; r09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r09", op, join, r09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r09;


   procedure Add_r10( c : in out d.Criteria; r10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r10", op, join, r10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r10;


   procedure Add_r11( c : in out d.Criteria; r11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r11", op, join, r11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r11;


   procedure Add_r12( c : in out d.Criteria; r12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r12", op, join, r12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r12;


   procedure Add_r13( c : in out d.Criteria; r13 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r13", op, join, r13 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r13;


   procedure Add_r14( c : in out d.Criteria; r14 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "r14", op, join, r14 );
   begin
      d.add_to_criteria( c, elem );
   end Add_r14;


   procedure Add_registr1( c : in out d.Criteria; registr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "registr1", op, join, registr1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_registr1;


   procedure Add_registr2( c : in out d.Criteria; registr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "registr2", op, join, registr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_registr2;


   procedure Add_registr3( c : in out d.Criteria; registr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "registr3", op, join, registr3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_registr3;


   procedure Add_registr4( c : in out d.Criteria; registr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "registr4", op, join, registr4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_registr4;


   procedure Add_registr5( c : in out d.Criteria; registr5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "registr5", op, join, registr5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_registr5;


   procedure Add_sex( c : in out d.Criteria; sex : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sex", op, join, sex );
   begin
      d.add_to_criteria( c, elem );
   end Add_sex;


   procedure Add_smkit( c : in out d.Criteria; smkit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "smkit", op, join, smkit );
   begin
      d.add_to_criteria( c, elem );
   end Add_smkit;


   procedure Add_smlit( c : in out d.Criteria; smlit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "smlit", op, join, smlit );
   begin
      d.add_to_criteria( c, elem );
   end Add_smlit;


   procedure Add_spcreg1( c : in out d.Criteria; spcreg1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spcreg1", op, join, spcreg1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_spcreg1;


   procedure Add_spcreg2( c : in out d.Criteria; spcreg2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spcreg2", op, join, spcreg2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_spcreg2;


   procedure Add_spcreg3( c : in out d.Criteria; spcreg3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spcreg3", op, join, spcreg3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_spcreg3;


   procedure Add_specs( c : in out d.Criteria; specs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "specs", op, join, specs );
   begin
      d.add_to_criteria( c, elem );
   end Add_specs;


   procedure Add_spout( c : in out d.Criteria; spout : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spout", op, join, spout );
   begin
      d.add_to_criteria( c, elem );
   end Add_spout;


   procedure Add_srentamt( c : in out d.Criteria; srentamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "srentamt", op, join, srentamt );
   begin
      d.add_to_criteria( c, elem );
   end Add_srentamt;


   procedure Add_srentpd( c : in out d.Criteria; srentpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "srentpd", op, join, srentpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_srentpd;


   procedure Add_startyr( c : in out d.Criteria; startyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "startyr", op, join, startyr );
   begin
      d.add_to_criteria( c, elem );
   end Add_startyr;


   procedure Add_totsave( c : in out d.Criteria; totsave : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totsave", op, join, totsave );
   begin
      d.add_to_criteria( c, elem );
   end Add_totsave;


   procedure Add_trav( c : in out d.Criteria; trav : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "trav", op, join, trav );
   begin
      d.add_to_criteria( c, elem );
   end Add_trav;


   procedure Add_typeed( c : in out d.Criteria; typeed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "typeed", op, join, typeed );
   begin
      d.add_to_criteria( c, elem );
   end Add_typeed;


   procedure Add_voucher( c : in out d.Criteria; voucher : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "voucher", op, join, voucher );
   begin
      d.add_to_criteria( c, elem );
   end Add_voucher;


   procedure Add_whytrav1( c : in out d.Criteria; whytrav1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whytrav1", op, join, whytrav1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whytrav1;


   procedure Add_whytrav2( c : in out d.Criteria; whytrav2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whytrav2", op, join, whytrav2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whytrav2;


   procedure Add_whytrav3( c : in out d.Criteria; whytrav3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whytrav3", op, join, whytrav3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whytrav3;


   procedure Add_whytrav4( c : in out d.Criteria; whytrav4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whytrav4", op, join, whytrav4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whytrav4;


   procedure Add_whytrav5( c : in out d.Criteria; whytrav5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whytrav5", op, join, whytrav5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whytrav5;


   procedure Add_whytrav6( c : in out d.Criteria; whytrav6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whytrav6", op, join, whytrav6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whytrav6;


   procedure Add_wmkit( c : in out d.Criteria; wmkit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wmkit", op, join, wmkit );
   begin
      d.add_to_criteria( c, elem );
   end Add_wmkit;


   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "month", op, join, month );
   begin
      d.add_to_criteria( c, elem );
   end Add_month;


   procedure Add_careab( c : in out d.Criteria; careab : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "careab", op, join, careab );
   begin
      d.add_to_criteria( c, elem );
   end Add_careab;


   procedure Add_careah( c : in out d.Criteria; careah : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "careah", op, join, careah );
   begin
      d.add_to_criteria( c, elem );
   end Add_careah;


   procedure Add_carecb( c : in out d.Criteria; carecb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "carecb", op, join, carecb );
   begin
      d.add_to_criteria( c, elem );
   end Add_carecb;


   procedure Add_carech( c : in out d.Criteria; carech : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "carech", op, join, carech );
   begin
      d.add_to_criteria( c, elem );
   end Add_carech;


   procedure Add_carecl( c : in out d.Criteria; carecl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "carecl", op, join, carecl );
   begin
      d.add_to_criteria( c, elem );
   end Add_carecl;


   procedure Add_carefl( c : in out d.Criteria; carefl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "carefl", op, join, carefl );
   begin
      d.add_to_criteria( c, elem );
   end Add_carefl;


   procedure Add_carefr( c : in out d.Criteria; carefr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "carefr", op, join, carefr );
   begin
      d.add_to_criteria( c, elem );
   end Add_carefr;


   procedure Add_careot( c : in out d.Criteria; careot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "careot", op, join, careot );
   begin
      d.add_to_criteria( c, elem );
   end Add_careot;


   procedure Add_carere( c : in out d.Criteria; carere : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "carere", op, join, carere );
   begin
      d.add_to_criteria( c, elem );
   end Add_carere;


   procedure Add_chdda( c : in out d.Criteria; chdda : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chdda", op, join, chdda );
   begin
      d.add_to_criteria( c, elem );
   end Add_chdda;


   procedure Add_chearns( c : in out d.Criteria; chearns : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chearns", op, join, Long_Float( chearns ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chearns;


   procedure Add_chincdv( c : in out d.Criteria; chincdv : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chincdv", op, join, Long_Float( chincdv ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chincdv;


   procedure Add_chrinc( c : in out d.Criteria; chrinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chrinc", op, join, Long_Float( chrinc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrinc;


   procedure Add_fsmlkval( c : in out d.Criteria; fsmlkval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fsmlkval", op, join, Long_Float( fsmlkval ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsmlkval;


   procedure Add_fsmval( c : in out d.Criteria; fsmval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fsmval", op, join, Long_Float( fsmval ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsmval;


   procedure Add_fwmlkval( c : in out d.Criteria; fwmlkval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fwmlkval", op, join, Long_Float( fwmlkval ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fwmlkval;


   procedure Add_hdagech( c : in out d.Criteria; hdagech : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hdagech", op, join, hdagech );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdagech;


   procedure Add_hourab( c : in out d.Criteria; hourab : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hourab", op, join, hourab );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourab;


   procedure Add_hourah( c : in out d.Criteria; hourah : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hourah", op, join, hourah );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourah;


   procedure Add_hourcb( c : in out d.Criteria; hourcb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hourcb", op, join, hourcb );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourcb;


   procedure Add_hourch( c : in out d.Criteria; hourch : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hourch", op, join, hourch );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourch;


   procedure Add_hourcl( c : in out d.Criteria; hourcl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hourcl", op, join, hourcl );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourcl;


   procedure Add_hourfr( c : in out d.Criteria; hourfr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hourfr", op, join, hourfr );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourfr;


   procedure Add_hourot( c : in out d.Criteria; hourot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hourot", op, join, hourot );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourot;


   procedure Add_hourre( c : in out d.Criteria; hourre : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hourre", op, join, hourre );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourre;


   procedure Add_hourtot( c : in out d.Criteria; hourtot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hourtot", op, join, hourtot );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourtot;


   procedure Add_hperson( c : in out d.Criteria; hperson : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hperson", op, join, hperson );
   begin
      d.add_to_criteria( c, elem );
   end Add_hperson;


   procedure Add_iagegr2( c : in out d.Criteria; iagegr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iagegr2", op, join, iagegr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_iagegr2;


   procedure Add_iagegrp( c : in out d.Criteria; iagegrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iagegrp", op, join, iagegrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_iagegrp;


   procedure Add_relhrp( c : in out d.Criteria; relhrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "relhrp", op, join, relhrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_relhrp;


   procedure Add_totgntch( c : in out d.Criteria; totgntch : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totgntch", op, join, Long_Float( totgntch ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_totgntch;


   procedure Add_uperson( c : in out d.Criteria; uperson : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uperson", op, join, uperson );
   begin
      d.add_to_criteria( c, elem );
   end Add_uperson;


   procedure Add_cddatre( c : in out d.Criteria; cddatre : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cddatre", op, join, cddatre );
   begin
      d.add_to_criteria( c, elem );
   end Add_cddatre;


   procedure Add_cdisdif9( c : in out d.Criteria; cdisdif9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisdif9", op, join, cdisdif9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif9;


   procedure Add_cddatrep( c : in out d.Criteria; cddatrep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cddatrep", op, join, cddatrep );
   begin
      d.add_to_criteria( c, elem );
   end Add_cddatrep;


   procedure Add_cdisdifp( c : in out d.Criteria; cdisdifp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisdifp", op, join, cdisdifp );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdifp;


   procedure Add_cfund( c : in out d.Criteria; cfund : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cfund", op, join, cfund );
   begin
      d.add_to_criteria( c, elem );
   end Add_cfund;


   procedure Add_cfundh( c : in out d.Criteria; cfundh : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cfundh", op, join, Long_Float( cfundh ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_cfundh;


   procedure Add_cfundtp( c : in out d.Criteria; cfundtp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cfundtp", op, join, cfundtp );
   begin
      d.add_to_criteria( c, elem );
   end Add_cfundtp;


   procedure Add_fundamt1( c : in out d.Criteria; fundamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fundamt1", op, join, Long_Float( fundamt1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fundamt1;


   procedure Add_fundamt2( c : in out d.Criteria; fundamt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fundamt2", op, join, Long_Float( fundamt2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fundamt2;


   procedure Add_fundamt3( c : in out d.Criteria; fundamt3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fundamt3", op, join, Long_Float( fundamt3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fundamt3;


   procedure Add_fundamt4( c : in out d.Criteria; fundamt4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fundamt4", op, join, Long_Float( fundamt4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fundamt4;


   procedure Add_fundamt5( c : in out d.Criteria; fundamt5 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fundamt5", op, join, Long_Float( fundamt5 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fundamt5;


   procedure Add_fundamt6( c : in out d.Criteria; fundamt6 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fundamt6", op, join, Long_Float( fundamt6 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fundamt6;


   procedure Add_givcfnd1( c : in out d.Criteria; givcfnd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "givcfnd1", op, join, givcfnd1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_givcfnd1;


   procedure Add_givcfnd2( c : in out d.Criteria; givcfnd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "givcfnd2", op, join, givcfnd2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_givcfnd2;


   procedure Add_givcfnd3( c : in out d.Criteria; givcfnd3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "givcfnd3", op, join, givcfnd3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_givcfnd3;


   procedure Add_givcfnd4( c : in out d.Criteria; givcfnd4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "givcfnd4", op, join, givcfnd4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_givcfnd4;


   procedure Add_givcfnd5( c : in out d.Criteria; givcfnd5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "givcfnd5", op, join, givcfnd5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_givcfnd5;


   procedure Add_givcfnd6( c : in out d.Criteria; givcfnd6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "givcfnd6", op, join, givcfnd6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_givcfnd6;


   procedure Add_tuacam( c : in out d.Criteria; tuacam : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tuacam", op, join, Long_Float( tuacam ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_tuacam;


   procedure Add_schchk( c : in out d.Criteria; schchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "schchk", op, join, schchk );
   begin
      d.add_to_criteria( c, elem );
   end Add_schchk;


   procedure Add_trainee( c : in out d.Criteria; trainee : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "trainee", op, join, trainee );
   begin
      d.add_to_criteria( c, elem );
   end Add_trainee;


   procedure Add_cddaprg( c : in out d.Criteria; cddaprg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cddaprg", op, join, cddaprg );
   begin
      d.add_to_criteria( c, elem );
   end Add_cddaprg;


   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issue", op, join, issue );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue;


   procedure Add_heartval( c : in out d.Criteria; heartval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heartval", op, join, Long_Float( heartval ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_heartval;


   procedure Add_xbonflag( c : in out d.Criteria; xbonflag : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "xbonflag", op, join, xbonflag );
   begin
      d.add_to_criteria( c, elem );
   end Add_xbonflag;


   procedure Add_chca( c : in out d.Criteria; chca : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chca", op, join, chca );
   begin
      d.add_to_criteria( c, elem );
   end Add_chca;


   procedure Add_disdifch( c : in out d.Criteria; disdifch : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdifch", op, join, disdifch );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdifch;


   procedure Add_chearns3( c : in out d.Criteria; chearns3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chearns3", op, join, chearns3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chearns3;


   procedure Add_chtrnamt( c : in out d.Criteria; chtrnamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chtrnamt", op, join, Long_Float( chtrnamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chtrnamt;


   procedure Add_chtrnpd( c : in out d.Criteria; chtrnpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chtrnpd", op, join, chtrnpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_chtrnpd;


   procedure Add_hsvper( c : in out d.Criteria; hsvper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hsvper", op, join, hsvper );
   begin
      d.add_to_criteria( c, elem );
   end Add_hsvper;


   procedure Add_mednum( c : in out d.Criteria; mednum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mednum", op, join, mednum );
   begin
      d.add_to_criteria( c, elem );
   end Add_mednum;


   procedure Add_medprpd( c : in out d.Criteria; medprpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medprpd", op, join, medprpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_medprpd;


   procedure Add_medprpy( c : in out d.Criteria; medprpy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medprpy", op, join, medprpy );
   begin
      d.add_to_criteria( c, elem );
   end Add_medprpy;


   procedure Add_sbkit( c : in out d.Criteria; sbkit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sbkit", op, join, sbkit );
   begin
      d.add_to_criteria( c, elem );
   end Add_sbkit;


   procedure Add_dobmonth( c : in out d.Criteria; dobmonth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dobmonth", op, join, dobmonth );
   begin
      d.add_to_criteria( c, elem );
   end Add_dobmonth;


   procedure Add_dobyear( c : in out d.Criteria; dobyear : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dobyear", op, join, dobyear );
   begin
      d.add_to_criteria( c, elem );
   end Add_dobyear;


   procedure Add_fsbval( c : in out d.Criteria; fsbval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fsbval", op, join, Long_Float( fsbval ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsbval;


   procedure Add_btecnow( c : in out d.Criteria; btecnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "btecnow", op, join, btecnow );
   begin
      d.add_to_criteria( c, elem );
   end Add_btecnow;


   procedure Add_cameyr( c : in out d.Criteria; cameyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cameyr", op, join, cameyr );
   begin
      d.add_to_criteria( c, elem );
   end Add_cameyr;


   procedure Add_cdaprog1( c : in out d.Criteria; cdaprog1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdaprog1", op, join, cdaprog1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdaprog1;


   procedure Add_cdatre1( c : in out d.Criteria; cdatre1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdatre1", op, join, cdatre1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdatre1;


   procedure Add_cdatrep1( c : in out d.Criteria; cdatrep1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdatrep1", op, join, cdatrep1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdatrep1;


   procedure Add_cdisd01( c : in out d.Criteria; cdisd01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisd01", op, join, cdisd01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd01;


   procedure Add_cdisd02( c : in out d.Criteria; cdisd02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisd02", op, join, cdisd02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd02;


   procedure Add_cdisd03( c : in out d.Criteria; cdisd03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisd03", op, join, cdisd03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd03;


   procedure Add_cdisd04( c : in out d.Criteria; cdisd04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisd04", op, join, cdisd04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd04;


   procedure Add_cdisd05( c : in out d.Criteria; cdisd05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisd05", op, join, cdisd05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd05;


   procedure Add_cdisd06( c : in out d.Criteria; cdisd06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisd06", op, join, cdisd06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd06;


   procedure Add_cdisd07( c : in out d.Criteria; cdisd07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisd07", op, join, cdisd07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd07;


   procedure Add_cdisd08( c : in out d.Criteria; cdisd08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisd08", op, join, cdisd08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd08;


   procedure Add_cdisd09( c : in out d.Criteria; cdisd09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisd09", op, join, cdisd09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd09;


   procedure Add_cdisd10( c : in out d.Criteria; cdisd10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cdisd10", op, join, cdisd10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd10;


   procedure Add_chbfd( c : in out d.Criteria; chbfd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chbfd", op, join, chbfd );
   begin
      d.add_to_criteria( c, elem );
   end Add_chbfd;


   procedure Add_chbfdamt( c : in out d.Criteria; chbfdamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chbfdamt", op, join, Long_Float( chbfdamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_chbfdamt;


   procedure Add_chbfdpd( c : in out d.Criteria; chbfdpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chbfdpd", op, join, chbfdpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_chbfdpd;


   procedure Add_chbfdval( c : in out d.Criteria; chbfdval : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chbfdval", op, join, chbfdval );
   begin
      d.add_to_criteria( c, elem );
   end Add_chbfdval;


   procedure Add_chcond( c : in out d.Criteria; chcond : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chcond", op, join, chcond );
   begin
      d.add_to_criteria( c, elem );
   end Add_chcond;


   procedure Add_chealth1( c : in out d.Criteria; chealth1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chealth1", op, join, chealth1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chealth1;


   procedure Add_chlimitl( c : in out d.Criteria; chlimitl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chlimitl", op, join, chlimitl );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlimitl;


   procedure Add_citizen( c : in out d.Criteria; citizen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "citizen", op, join, citizen );
   begin
      d.add_to_criteria( c, elem );
   end Add_citizen;


   procedure Add_citizen2( c : in out d.Criteria; citizen2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "citizen2", op, join, citizen2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_citizen2;


   procedure Add_contuk( c : in out d.Criteria; contuk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "contuk", op, join, contuk );
   begin
      d.add_to_criteria( c, elem );
   end Add_contuk;


   procedure Add_corign( c : in out d.Criteria; corign : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "corign", op, join, corign );
   begin
      d.add_to_criteria( c, elem );
   end Add_corign;


   procedure Add_corigoth( c : in out d.Criteria; corigoth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "corigoth", op, join, corigoth );
   begin
      d.add_to_criteria( c, elem );
   end Add_corigoth;


   procedure Add_curqual( c : in out d.Criteria; curqual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "curqual", op, join, curqual );
   begin
      d.add_to_criteria( c, elem );
   end Add_curqual;


   procedure Add_degrenow( c : in out d.Criteria; degrenow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "degrenow", op, join, degrenow );
   begin
      d.add_to_criteria( c, elem );
   end Add_degrenow;


   procedure Add_denrec( c : in out d.Criteria; denrec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "denrec", op, join, denrec );
   begin
      d.add_to_criteria( c, elem );
   end Add_denrec;


   procedure Add_dvmardf( c : in out d.Criteria; dvmardf : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dvmardf", op, join, dvmardf );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvmardf;


   procedure Add_heathch( c : in out d.Criteria; heathch : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heathch", op, join, heathch );
   begin
      d.add_to_criteria( c, elem );
   end Add_heathch;


   procedure Add_highonow( c : in out d.Criteria; highonow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "highonow", op, join, highonow );
   begin
      d.add_to_criteria( c, elem );
   end Add_highonow;


   procedure Add_hrsed( c : in out d.Criteria; hrsed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrsed", op, join, hrsed );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrsed;


   procedure Add_medrec( c : in out d.Criteria; medrec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medrec", op, join, medrec );
   begin
      d.add_to_criteria( c, elem );
   end Add_medrec;


   procedure Add_nvqlenow( c : in out d.Criteria; nvqlenow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nvqlenow", op, join, nvqlenow );
   begin
      d.add_to_criteria( c, elem );
   end Add_nvqlenow;


   procedure Add_othpass( c : in out d.Criteria; othpass : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpass", op, join, othpass );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpass;


   procedure Add_reasden( c : in out d.Criteria; reasden : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "reasden", op, join, reasden );
   begin
      d.add_to_criteria( c, elem );
   end Add_reasden;


   procedure Add_reasmed( c : in out d.Criteria; reasmed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "reasmed", op, join, reasmed );
   begin
      d.add_to_criteria( c, elem );
   end Add_reasmed;


   procedure Add_reasnhs( c : in out d.Criteria; reasnhs : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "reasnhs", op, join, reasnhs );
   begin
      d.add_to_criteria( c, elem );
   end Add_reasnhs;


   procedure Add_rsanow( c : in out d.Criteria; rsanow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rsanow", op, join, rsanow );
   begin
      d.add_to_criteria( c, elem );
   end Add_rsanow;


   procedure Add_sctvnow( c : in out d.Criteria; sctvnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sctvnow", op, join, sctvnow );
   begin
      d.add_to_criteria( c, elem );
   end Add_sctvnow;


   procedure Add_sfvit( c : in out d.Criteria; sfvit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sfvit", op, join, sfvit );
   begin
      d.add_to_criteria( c, elem );
   end Add_sfvit;


   procedure Add_disactc1( c : in out d.Criteria; disactc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disactc1", op, join, disactc1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disactc1;


   procedure Add_discorc1( c : in out d.Criteria; discorc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "discorc1", op, join, discorc1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_discorc1;


   procedure Add_fsfvval( c : in out d.Criteria; fsfvval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fsfvval", op, join, Long_Float( fsfvval ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsfvval;


   procedure Add_marital( c : in out d.Criteria; marital : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "marital", op, join, marital );
   begin
      d.add_to_criteria( c, elem );
   end Add_marital;


   procedure Add_typeed2( c : in out d.Criteria; typeed2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "typeed2", op, join, typeed2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_typeed2;


   procedure Add_c2orign( c : in out d.Criteria; c2orign : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "c2orign", op, join, c2orign );
   begin
      d.add_to_criteria( c, elem );
   end Add_c2orign;


   procedure Add_prox1619( c : in out d.Criteria; prox1619 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "prox1619", op, join, prox1619 );
   begin
      d.add_to_criteria( c, elem );
   end Add_prox1619;


   procedure Add_candgnow( c : in out d.Criteria; candgnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "candgnow", op, join, candgnow );
   begin
      d.add_to_criteria( c, elem );
   end Add_candgnow;


   procedure Add_curothf( c : in out d.Criteria; curothf : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "curothf", op, join, curothf );
   begin
      d.add_to_criteria( c, elem );
   end Add_curothf;


   procedure Add_curothp( c : in out d.Criteria; curothp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "curothp", op, join, curothp );
   begin
      d.add_to_criteria( c, elem );
   end Add_curothp;


   procedure Add_curothwv( c : in out d.Criteria; curothwv : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "curothwv", op, join, curothwv );
   begin
      d.add_to_criteria( c, elem );
   end Add_curothwv;


   procedure Add_gnvqnow( c : in out d.Criteria; gnvqnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gnvqnow", op, join, gnvqnow );
   begin
      d.add_to_criteria( c, elem );
   end Add_gnvqnow;


   procedure Add_ndeplnow( c : in out d.Criteria; ndeplnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ndeplnow", op, join, ndeplnow );
   begin
      d.add_to_criteria( c, elem );
   end Add_ndeplnow;


   procedure Add_oqualc1( c : in out d.Criteria; oqualc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oqualc1", op, join, oqualc1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oqualc1;


   procedure Add_oqualc2( c : in out d.Criteria; oqualc2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oqualc2", op, join, oqualc2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oqualc2;


   procedure Add_oqualc3( c : in out d.Criteria; oqualc3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oqualc3", op, join, oqualc3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_oqualc3;


   procedure Add_webacnow( c : in out d.Criteria; webacnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "webacnow", op, join, webacnow );
   begin
      d.add_to_criteria( c, elem );
   end Add_webacnow;


   procedure Add_ntsctnow( c : in out d.Criteria; ntsctnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ntsctnow", op, join, ntsctnow );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntsctnow;


   procedure Add_skiwknow( c : in out d.Criteria; skiwknow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "skiwknow", op, join, skiwknow );
   begin
      d.add_to_criteria( c, elem );
   end Add_skiwknow;


   
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


   procedure Add_person_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "person", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_person_To_Orderings;


   procedure Add_adeduc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adeduc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adeduc_To_Orderings;


   procedure Add_age_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_To_Orderings;


   procedure Add_benccdis_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "benccdis", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_benccdis_To_Orderings;


   procedure Add_care_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "care", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_care_To_Orderings;


   procedure Add_cdisdif1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisdif1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif1_To_Orderings;


   procedure Add_cdisdif2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisdif2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif2_To_Orderings;


   procedure Add_cdisdif3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisdif3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif3_To_Orderings;


   procedure Add_cdisdif4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisdif4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif4_To_Orderings;


   procedure Add_cdisdif5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisdif5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif5_To_Orderings;


   procedure Add_cdisdif6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisdif6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif6_To_Orderings;


   procedure Add_cdisdif7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisdif7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif7_To_Orderings;


   procedure Add_cdisdif8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisdif8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif8_To_Orderings;


   procedure Add_chamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chamt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamt1_To_Orderings;


   procedure Add_chamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chamt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamt2_To_Orderings;


   procedure Add_chamt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chamt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamt3_To_Orderings;


   procedure Add_chamt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chamt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamt4_To_Orderings;


   procedure Add_chamtern_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chamtern", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamtern_To_Orderings;


   procedure Add_chamttst_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chamttst", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chamttst_To_Orderings;


   procedure Add_chdla1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chdla1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chdla1_To_Orderings;


   procedure Add_chdla2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chdla2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chdla2_To_Orderings;


   procedure Add_chealth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chealth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chealth_To_Orderings;


   procedure Add_chearns1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chearns1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chearns1_To_Orderings;


   procedure Add_chearns2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chearns2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chearns2_To_Orderings;


   procedure Add_chema_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chema", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chema_To_Orderings;


   procedure Add_chemaamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chemaamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chemaamt_To_Orderings;


   procedure Add_chemapd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chemapd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chemapd_To_Orderings;


   procedure Add_chfar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chfar", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chfar_To_Orderings;


   procedure Add_chhr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chhr1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chhr1_To_Orderings;


   procedure Add_chhr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chhr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chhr2_To_Orderings;


   procedure Add_chlook01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chlook01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook01_To_Orderings;


   procedure Add_chlook02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chlook02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook02_To_Orderings;


   procedure Add_chlook03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chlook03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook03_To_Orderings;


   procedure Add_chlook04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chlook04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook04_To_Orderings;


   procedure Add_chlook05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chlook05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook05_To_Orderings;


   procedure Add_chlook06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chlook06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook06_To_Orderings;


   procedure Add_chlook07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chlook07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook07_To_Orderings;


   procedure Add_chlook08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chlook08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook08_To_Orderings;


   procedure Add_chlook09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chlook09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook09_To_Orderings;


   procedure Add_chlook10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chlook10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlook10_To_Orderings;


   procedure Add_chpay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chpay1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chpay1_To_Orderings;


   procedure Add_chpay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chpay2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chpay2_To_Orderings;


   procedure Add_chpay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chpay3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chpay3_To_Orderings;


   procedure Add_chpdern_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chpdern", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chpdern_To_Orderings;


   procedure Add_chpdtst_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chpdtst", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chpdtst_To_Orderings;


   procedure Add_chprob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chprob", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chprob_To_Orderings;


   procedure Add_chsave_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chsave", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chsave_To_Orderings;


   procedure Add_chwkern_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chwkern", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chwkern_To_Orderings;


   procedure Add_chwktst_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chwktst", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chwktst_To_Orderings;


   procedure Add_chyrern_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chyrern", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chyrern_To_Orderings;


   procedure Add_chyrtst_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chyrtst", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chyrtst_To_Orderings;


   procedure Add_clone_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "clone", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_clone_To_Orderings;


   procedure Add_cohabit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cohabit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cohabit_To_Orderings;


   procedure Add_convbl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "convbl", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_convbl_To_Orderings;


   procedure Add_cost_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cost", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cost_To_Orderings;


   procedure Add_cvht_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cvht", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cvht_To_Orderings;


   procedure Add_cvpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cvpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cvpay_To_Orderings;


   procedure Add_cvpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cvpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cvpd_To_Orderings;


   procedure Add_dentist_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dentist", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dentist_To_Orderings;


   procedure Add_depend_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "depend", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_depend_To_Orderings;


   procedure Add_dob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dob", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dob_To_Orderings;


   procedure Add_eligadlt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eligadlt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eligadlt_To_Orderings;


   procedure Add_eligchld_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eligchld", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eligchld_To_Orderings;


   procedure Add_endyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "endyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_endyr_To_Orderings;


   procedure Add_eyetest_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eyetest", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eyetest_To_Orderings;


   procedure Add_fted_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fted", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fted_To_Orderings;


   procedure Add_x_grant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "x_grant", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_x_grant_To_Orderings;


   procedure Add_grtamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grtamt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtamt1_To_Orderings;


   procedure Add_grtamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grtamt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtamt2_To_Orderings;


   procedure Add_grtdir1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grtdir1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtdir1_To_Orderings;


   procedure Add_grtdir2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grtdir2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtdir2_To_Orderings;


   procedure Add_grtnum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grtnum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtnum_To_Orderings;


   procedure Add_grtsce1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grtsce1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtsce1_To_Orderings;


   procedure Add_grtsce2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grtsce2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtsce2_To_Orderings;


   procedure Add_grtval1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grtval1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtval1_To_Orderings;


   procedure Add_grtval2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "grtval2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_grtval2_To_Orderings;


   procedure Add_hholder_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hholder", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hholder_To_Orderings;


   procedure Add_hosp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hosp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hosp_To_Orderings;


   procedure Add_lareg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lareg", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lareg_To_Orderings;


   procedure Add_legdep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "legdep", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_legdep_To_Orderings;


   procedure Add_ms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ms", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ms_To_Orderings;


   procedure Add_nhs1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nhs1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhs1_To_Orderings;


   procedure Add_nhs2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nhs2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhs2_To_Orderings;


   procedure Add_nhs3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nhs3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nhs3_To_Orderings;


   procedure Add_parent1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "parent1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_parent1_To_Orderings;


   procedure Add_parent2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "parent2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_parent2_To_Orderings;


   procedure Add_prit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "prit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_prit_To_Orderings;


   procedure Add_prscrpt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "prscrpt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_prscrpt_To_Orderings;


   procedure Add_r01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r01_To_Orderings;


   procedure Add_r02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r02_To_Orderings;


   procedure Add_r03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r03_To_Orderings;


   procedure Add_r04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r04_To_Orderings;


   procedure Add_r05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r05_To_Orderings;


   procedure Add_r06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r06_To_Orderings;


   procedure Add_r07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r07_To_Orderings;


   procedure Add_r08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r08_To_Orderings;


   procedure Add_r09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r09_To_Orderings;


   procedure Add_r10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r10_To_Orderings;


   procedure Add_r11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r11_To_Orderings;


   procedure Add_r12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r12_To_Orderings;


   procedure Add_r13_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r13", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r13_To_Orderings;


   procedure Add_r14_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "r14", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_r14_To_Orderings;


   procedure Add_registr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "registr1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_registr1_To_Orderings;


   procedure Add_registr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "registr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_registr2_To_Orderings;


   procedure Add_registr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "registr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_registr3_To_Orderings;


   procedure Add_registr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "registr4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_registr4_To_Orderings;


   procedure Add_registr5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "registr5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_registr5_To_Orderings;


   procedure Add_sex_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sex", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sex_To_Orderings;


   procedure Add_smkit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "smkit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_smkit_To_Orderings;


   procedure Add_smlit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "smlit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_smlit_To_Orderings;


   procedure Add_spcreg1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spcreg1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spcreg1_To_Orderings;


   procedure Add_spcreg2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spcreg2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spcreg2_To_Orderings;


   procedure Add_spcreg3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spcreg3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spcreg3_To_Orderings;


   procedure Add_specs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "specs", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_specs_To_Orderings;


   procedure Add_spout_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spout", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spout_To_Orderings;


   procedure Add_srentamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "srentamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_srentamt_To_Orderings;


   procedure Add_srentpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "srentpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_srentpd_To_Orderings;


   procedure Add_startyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "startyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_startyr_To_Orderings;


   procedure Add_totsave_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totsave", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totsave_To_Orderings;


   procedure Add_trav_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "trav", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_trav_To_Orderings;


   procedure Add_typeed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "typeed", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_typeed_To_Orderings;


   procedure Add_voucher_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "voucher", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_voucher_To_Orderings;


   procedure Add_whytrav1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whytrav1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whytrav1_To_Orderings;


   procedure Add_whytrav2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whytrav2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whytrav2_To_Orderings;


   procedure Add_whytrav3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whytrav3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whytrav3_To_Orderings;


   procedure Add_whytrav4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whytrav4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whytrav4_To_Orderings;


   procedure Add_whytrav5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whytrav5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whytrav5_To_Orderings;


   procedure Add_whytrav6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whytrav6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whytrav6_To_Orderings;


   procedure Add_wmkit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wmkit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wmkit_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;


   procedure Add_careab_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "careab", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_careab_To_Orderings;


   procedure Add_careah_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "careah", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_careah_To_Orderings;


   procedure Add_carecb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "carecb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_carecb_To_Orderings;


   procedure Add_carech_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "carech", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_carech_To_Orderings;


   procedure Add_carecl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "carecl", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_carecl_To_Orderings;


   procedure Add_carefl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "carefl", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_carefl_To_Orderings;


   procedure Add_carefr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "carefr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_carefr_To_Orderings;


   procedure Add_careot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "careot", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_careot_To_Orderings;


   procedure Add_carere_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "carere", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_carere_To_Orderings;


   procedure Add_chdda_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chdda", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chdda_To_Orderings;


   procedure Add_chearns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chearns", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chearns_To_Orderings;


   procedure Add_chincdv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chincdv", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chincdv_To_Orderings;


   procedure Add_chrinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chrinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chrinc_To_Orderings;


   procedure Add_fsmlkval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fsmlkval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsmlkval_To_Orderings;


   procedure Add_fsmval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fsmval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsmval_To_Orderings;


   procedure Add_fwmlkval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fwmlkval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fwmlkval_To_Orderings;


   procedure Add_hdagech_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hdagech", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdagech_To_Orderings;


   procedure Add_hourab_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hourab", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourab_To_Orderings;


   procedure Add_hourah_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hourah", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourah_To_Orderings;


   procedure Add_hourcb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hourcb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourcb_To_Orderings;


   procedure Add_hourch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hourch", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourch_To_Orderings;


   procedure Add_hourcl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hourcl", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourcl_To_Orderings;


   procedure Add_hourfr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hourfr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourfr_To_Orderings;


   procedure Add_hourot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hourot", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourot_To_Orderings;


   procedure Add_hourre_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hourre", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourre_To_Orderings;


   procedure Add_hourtot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hourtot", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourtot_To_Orderings;


   procedure Add_hperson_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hperson", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hperson_To_Orderings;


   procedure Add_iagegr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iagegr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iagegr2_To_Orderings;


   procedure Add_iagegrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iagegrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iagegrp_To_Orderings;


   procedure Add_relhrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "relhrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_relhrp_To_Orderings;


   procedure Add_totgntch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totgntch", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totgntch_To_Orderings;


   procedure Add_uperson_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uperson", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uperson_To_Orderings;


   procedure Add_cddatre_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cddatre", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cddatre_To_Orderings;


   procedure Add_cdisdif9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisdif9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdif9_To_Orderings;


   procedure Add_cddatrep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cddatrep", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cddatrep_To_Orderings;


   procedure Add_cdisdifp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisdifp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisdifp_To_Orderings;


   procedure Add_cfund_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cfund", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cfund_To_Orderings;


   procedure Add_cfundh_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cfundh", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cfundh_To_Orderings;


   procedure Add_cfundtp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cfundtp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cfundtp_To_Orderings;


   procedure Add_fundamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fundamt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fundamt1_To_Orderings;


   procedure Add_fundamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fundamt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fundamt2_To_Orderings;


   procedure Add_fundamt3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fundamt3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fundamt3_To_Orderings;


   procedure Add_fundamt4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fundamt4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fundamt4_To_Orderings;


   procedure Add_fundamt5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fundamt5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fundamt5_To_Orderings;


   procedure Add_fundamt6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fundamt6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fundamt6_To_Orderings;


   procedure Add_givcfnd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "givcfnd1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_givcfnd1_To_Orderings;


   procedure Add_givcfnd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "givcfnd2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_givcfnd2_To_Orderings;


   procedure Add_givcfnd3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "givcfnd3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_givcfnd3_To_Orderings;


   procedure Add_givcfnd4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "givcfnd4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_givcfnd4_To_Orderings;


   procedure Add_givcfnd5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "givcfnd5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_givcfnd5_To_Orderings;


   procedure Add_givcfnd6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "givcfnd6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_givcfnd6_To_Orderings;


   procedure Add_tuacam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tuacam", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tuacam_To_Orderings;


   procedure Add_schchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "schchk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_schchk_To_Orderings;


   procedure Add_trainee_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "trainee", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_trainee_To_Orderings;


   procedure Add_cddaprg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cddaprg", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cddaprg_To_Orderings;


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;


   procedure Add_heartval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heartval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heartval_To_Orderings;


   procedure Add_xbonflag_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "xbonflag", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_xbonflag_To_Orderings;


   procedure Add_chca_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chca", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chca_To_Orderings;


   procedure Add_disdifch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdifch", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdifch_To_Orderings;


   procedure Add_chearns3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chearns3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chearns3_To_Orderings;


   procedure Add_chtrnamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chtrnamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chtrnamt_To_Orderings;


   procedure Add_chtrnpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chtrnpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chtrnpd_To_Orderings;


   procedure Add_hsvper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hsvper", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hsvper_To_Orderings;


   procedure Add_mednum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mednum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mednum_To_Orderings;


   procedure Add_medprpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medprpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medprpd_To_Orderings;


   procedure Add_medprpy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medprpy", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medprpy_To_Orderings;


   procedure Add_sbkit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sbkit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sbkit_To_Orderings;


   procedure Add_dobmonth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dobmonth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dobmonth_To_Orderings;


   procedure Add_dobyear_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dobyear", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dobyear_To_Orderings;


   procedure Add_fsbval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fsbval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsbval_To_Orderings;


   procedure Add_btecnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "btecnow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_btecnow_To_Orderings;


   procedure Add_cameyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cameyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cameyr_To_Orderings;


   procedure Add_cdaprog1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdaprog1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdaprog1_To_Orderings;


   procedure Add_cdatre1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdatre1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdatre1_To_Orderings;


   procedure Add_cdatrep1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdatrep1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdatrep1_To_Orderings;


   procedure Add_cdisd01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisd01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd01_To_Orderings;


   procedure Add_cdisd02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisd02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd02_To_Orderings;


   procedure Add_cdisd03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisd03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd03_To_Orderings;


   procedure Add_cdisd04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisd04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd04_To_Orderings;


   procedure Add_cdisd05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisd05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd05_To_Orderings;


   procedure Add_cdisd06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisd06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd06_To_Orderings;


   procedure Add_cdisd07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisd07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd07_To_Orderings;


   procedure Add_cdisd08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisd08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd08_To_Orderings;


   procedure Add_cdisd09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisd09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd09_To_Orderings;


   procedure Add_cdisd10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cdisd10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cdisd10_To_Orderings;


   procedure Add_chbfd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chbfd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chbfd_To_Orderings;


   procedure Add_chbfdamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chbfdamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chbfdamt_To_Orderings;


   procedure Add_chbfdpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chbfdpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chbfdpd_To_Orderings;


   procedure Add_chbfdval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chbfdval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chbfdval_To_Orderings;


   procedure Add_chcond_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chcond", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chcond_To_Orderings;


   procedure Add_chealth1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chealth1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chealth1_To_Orderings;


   procedure Add_chlimitl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chlimitl", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chlimitl_To_Orderings;


   procedure Add_citizen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "citizen", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_citizen_To_Orderings;


   procedure Add_citizen2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "citizen2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_citizen2_To_Orderings;


   procedure Add_contuk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "contuk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_contuk_To_Orderings;


   procedure Add_corign_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "corign", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_corign_To_Orderings;


   procedure Add_corigoth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "corigoth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_corigoth_To_Orderings;


   procedure Add_curqual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "curqual", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_curqual_To_Orderings;


   procedure Add_degrenow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "degrenow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_degrenow_To_Orderings;


   procedure Add_denrec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "denrec", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_denrec_To_Orderings;


   procedure Add_dvmardf_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dvmardf", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvmardf_To_Orderings;


   procedure Add_heathch_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heathch", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heathch_To_Orderings;


   procedure Add_highonow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "highonow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_highonow_To_Orderings;


   procedure Add_hrsed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrsed", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrsed_To_Orderings;


   procedure Add_medrec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medrec", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medrec_To_Orderings;


   procedure Add_nvqlenow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nvqlenow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nvqlenow_To_Orderings;


   procedure Add_othpass_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpass", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpass_To_Orderings;


   procedure Add_reasden_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "reasden", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_reasden_To_Orderings;


   procedure Add_reasmed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "reasmed", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_reasmed_To_Orderings;


   procedure Add_reasnhs_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "reasnhs", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_reasnhs_To_Orderings;


   procedure Add_rsanow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rsanow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rsanow_To_Orderings;


   procedure Add_sctvnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sctvnow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sctvnow_To_Orderings;


   procedure Add_sfvit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sfvit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sfvit_To_Orderings;


   procedure Add_disactc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disactc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disactc1_To_Orderings;


   procedure Add_discorc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "discorc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_discorc1_To_Orderings;


   procedure Add_fsfvval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fsfvval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsfvval_To_Orderings;


   procedure Add_marital_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "marital", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_marital_To_Orderings;


   procedure Add_typeed2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "typeed2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_typeed2_To_Orderings;


   procedure Add_c2orign_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "c2orign", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_c2orign_To_Orderings;


   procedure Add_prox1619_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "prox1619", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_prox1619_To_Orderings;


   procedure Add_candgnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "candgnow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_candgnow_To_Orderings;


   procedure Add_curothf_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "curothf", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_curothf_To_Orderings;


   procedure Add_curothp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "curothp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_curothp_To_Orderings;


   procedure Add_curothwv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "curothwv", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_curothwv_To_Orderings;


   procedure Add_gnvqnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gnvqnow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gnvqnow_To_Orderings;


   procedure Add_ndeplnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ndeplnow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ndeplnow_To_Orderings;


   procedure Add_oqualc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oqualc1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oqualc1_To_Orderings;


   procedure Add_oqualc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oqualc2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oqualc2_To_Orderings;


   procedure Add_oqualc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oqualc3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oqualc3_To_Orderings;


   procedure Add_webacnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "webacnow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_webacnow_To_Orderings;


   procedure Add_ntsctnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ntsctnow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntsctnow_To_Orderings;


   procedure Add_skiwknow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "skiwknow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_skiwknow_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Child_IO;

--
-- Created by ada_generator.py on 2017-09-20 20:40:54.822709
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

with Ukds.Frs.Penamt_IO;
with Ukds.Frs.Govpay_IO;
with Ukds.Frs.Assets_IO;
with Ukds.Frs.Penprov_IO;
with Ukds.Frs.Maint_IO;
with Ukds.Frs.Job_IO;
with Ukds.Frs.Childcare_IO;
with Ukds.Frs.Pension_IO;
with Ukds.Frs.Accouts_IO;
with Ukds.Frs.Accounts_IO;
with Ukds.Frs.Oddjob_IO;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package body Ukds.Frs.Adult_IO is

   use Ada.Strings.Unbounded;
   use Ada.Exceptions;
   use Ada.Strings;

   package gsi renames GNATCOLL.SQL_Impl;
   package gsp renames GNATCOLL.SQL.Postgres;
   package gse renames GNATCOLL.SQL.Exec;
   package dbp renames DB_Commons.PSQL;
   
   use Base_Types;
   
   log_trace : GNATColl.Traces.Trace_Handle := GNATColl.Traces.Create( "UKDS.FRS.ADULT_IO" );
   
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
         "user_id, edition, year, sernum, benunit, person, abs1no, abs2no, abspar, abspay," &
         "abswhy, abswk, x_access, accftpt, accjb, accssamt, accsspd, adeduc, adema, ademaamt," &
         "ademapd, age, allow1, allow2, allow3, allow4, allpay1, allpay2, allpay3, allpay4," &
         "allpd1, allpd2, allpd3, allpd4, anyacc, anyed, anymon, anypen1, anypen2, anypen3," &
         "anypen4, anypen5, anypen6, anypen7, apamt, apdamt, apdir, apdpd, appd, b2qfut1," &
         "b2qfut2, b2qfut3, b3qfut1, b3qfut2, b3qfut3, b3qfut4, b3qfut5, b3qfut6, ben1q1, ben1q2," &
         "ben1q3, ben1q4, ben1q5, ben1q6, ben1q7, ben2q1, ben2q2, ben2q3, ben3q1, ben3q2," &
         "ben3q3, ben3q4, ben3q5, ben3q6, ben4q1, ben4q2, ben4q3, ben5q1, ben5q2, ben5q3," &
         "ben5q4, ben5q5, ben5q6, ben7q1, ben7q2, ben7q3, ben7q4, ben7q5, ben7q6, ben7q7," &
         "ben7q8, ben7q9, btwacc, claimant, cohabit, combid, convbl, ctclum1, ctclum2, cupchk," &
         "cvht, cvpay, cvpd, dentist, depend, disdif1, disdif2, disdif3, disdif4, disdif5," &
         "disdif6, disdif7, disdif8, dob, dptcboth, dptclum, dvil03a, dvil04a, dvjb12ml, dvmardf," &
         "ed1amt, ed1borr, ed1int, ed1monyr, ed1pd, ed1sum, ed2amt, ed2borr, ed2int, ed2monyr," &
         "ed2pd, ed2sum, edatt, edattn1, edattn2, edattn3, edhr, edtime, edtyp, eligadlt," &
         "eligchld, emppay1, emppay2, emppay3, empstat, endyr, epcur, es2000, ethgrp, everwrk," &
         "exthbct1, exthbct2, exthbct3, eyetest, follow, fted, ftwk, future, govpis, govpjsa," &
         "x_grant, grtamt1, grtamt2, grtdir1, grtdir2, grtnum, grtsce1, grtsce2, grtval1, grtval2," &
         "gta, hbothamt, hbothbu, hbothpd, hbothwk, hbotwait, health, hholder, hosp, hprob," &
         "hrpid, incdur, injlong, injwk, invests, iout, isa1type, isa2type, isa3type, jobaway," &
         "lareg, likewk, lktime, ln1rpint, ln2rpint, loan, loannum, look, lookwk, lstwrk1," &
         "lstwrk2, lstyr, mntamt1, mntamt2, mntct, mntfor1, mntfor2, mntgov1, mntgov2, mntpay," &
         "mntpd1, mntpd2, mntrec, mnttota1, mnttota2, mntus1, mntus2, mntusam1, mntusam2, mntuspd1," &
         "mntuspd2, ms, natid1, natid2, natid3, natid4, natid5, natid6, ndeal, newdtype," &
         "nhs1, nhs2, nhs3, niamt, niethgrp, niexthbb, ninatid1, ninatid2, ninatid3, ninatid4," &
         "ninatid5, ninatid6, ninatid7, ninatid8, nipd, nireg, nirel, nitrain, nlper, nolk1," &
         "nolk2, nolk3, nolook, nowant, nssec, ntcapp, ntcdat, ntcinc, ntcorig1, ntcorig2," &
         "ntcorig3, ntcorig4, ntcorig5, numjob, numjob2, oddjob, oldstud, otabspar, otamt, otapamt," &
         "otappd, othtax, otinva, pareamt, parepd, penlump, ppnumc, prit, prscrpt, ptwk," &
         "r01, r02, r03, r04, r05, r06, r07, r08, r09, r10," &
         "r11, r12, r13, r14, redamt, redany, rentprof, retire, retire1, retreas," &
         "royal1, royal2, royal3, royal4, royyr1, royyr2, royyr3, royyr4, rstrct, sex," &
         "sflntyp1, sflntyp2, sftype1, sftype2, sic, slrepamt, slrepay, slreppd, soc2000, spcreg1," &
         "spcreg2, spcreg3, specs, spout, srentamt, srentpd, start, startyr, taxcred1, taxcred2," &
         "taxcred3, taxcred4, taxcred5, taxfut, tdaywrk, tea, topupl, totint, train, trav," &
         "tuborr, typeed, unpaid1, unpaid2, voucher, w1, w2, wait, war1, war2," &
         "wftcboth, wftclum, whoresp, whosectb, whyfrde1, whyfrde2, whyfrde3, whyfrde4, whyfrde5, whyfrde6," &
         "whyfrey1, whyfrey2, whyfrey3, whyfrey4, whyfrey5, whyfrey6, whyfrpr1, whyfrpr2, whyfrpr3, whyfrpr4," &
         "whyfrpr5, whyfrpr6, whytrav1, whytrav2, whytrav3, whytrav4, whytrav5, whytrav6, wintfuel, wmkit," &
         "working, wpa, wpba, wtclum1, wtclum2, wtclum3, ystrtwk, month, able, actacci," &
         "addda, basacti, bntxcred, careab, careah, carecb, carech, carecl, carefl, carefr," &
         "careot, carere, curacti, empoccp, empstatb, empstatc, empstati, fsbndcti, fwmlkval, gebacti," &
         "giltcti, gross2, gross3, hbsupran, hdage, hdben, hdindinc, hourab, hourah, hourcare," &
         "hourcb, hourch, hourcl, hourfr, hourot, hourre, hourtot, hperson, iagegr2, iagegrp," &
         "incseo2, indinc, indisben, inearns, ininv, inirben, innirben, inothben, inpeninc, inrinc," &
         "inrpinc, intvlic, intxcred, isacti, marital, netocpen, nincseo2, nindinc, ninearns, nininv," &
         "ninpenin, ninsein2, nsbocti, occupnum, otbscti, pepscti, poaccti, prbocti, relhrp, sayecti," &
         "sclbcti, seincam2, smpadj, sscti, sspadj, stshcti, superan, taxpayer, tesscti, totgrant," &
         "tothours, totoccp, ttwcosts, untrcti, uperson, widoccp, accountq, ben5q7, ben5q8, ben5q9," &
         "ddatre, disdif9, fare, nittwmod, oneway, pssamt, pssdate, ttwcode1, ttwcode2, ttwcode3," &
         "ttwcost, ttwfar, ttwfrq, ttwmod, ttwpay, ttwpss, ttwrec, chbflg, crunaci, enomorti," &
         "sapadj, sppadj, ttwmode, ddatrep, defrpen, disdifp, followup, practice, sfrpis, sfrpjsa," &
         "age80, ethgr2, pocardi, chkdpn, chknop, consent, dvpens, eligschm, emparr, emppen," &
         "empschm, lnkref1, lnkref2, lnkref21, lnkref22, lnkref23, lnkref24, lnkref25, lnkref3, lnkref4," &
         "lnkref5, memschm, pconsent, perspen1, perspen2, privpen, schchk, spnumc, stakep, trainee," &
         "lnkdwp, lnkons, lnkref6, lnkref7, lnkref8, lnkref9, tcever1, tcever2, tcrepay1, tcrepay2," &
         "tcrepay3, tcrepay4, tcrepay5, tcrepay6, tcthsyr1, tcthsyr2, currjobm, prevjobm, b3qfut7, ben3q7," &
         "camemt, cameyr, cameyr2, contuk, corign, ddaprog, hbolng, hi1qual1, hi1qual2, hi1qual3," &
         "hi1qual4, hi1qual5, hi1qual6, hi2qual, hlpgvn01, hlpgvn02, hlpgvn03, hlpgvn04, hlpgvn05, hlpgvn06," &
         "hlpgvn07, hlpgvn08, hlpgvn09, hlpgvn10, hlpgvn11, hlprec01, hlprec02, hlprec03, hlprec04, hlprec05," &
         "hlprec06, hlprec07, hlprec08, hlprec09, hlprec10, hlprec11, issue, loangvn1, loangvn2, loangvn3," &
         "loanrec1, loanrec2, loanrec3, mntarr1, mntarr2, mntarr3, mntarr4, mntnrp, othqual1, othqual2," &
         "othqual3, tea9697, heartval, iagegr3, iagegr4, nirel2, xbonflag, alg, algamt, algpd," &
         "ben4q4, chkctc, chkdpco1, chkdpco2, chkdpco3, chkdsco1, chkdsco2, chkdsco3, dv09pens, lnkref01," &
         "lnkref02, lnkref03, lnkref04, lnkref05, lnkref06, lnkref07, lnkref08, lnkref09, lnkref10, lnkref11," &
         "spyrot, disdifad, gross3_x, aliamt, alimny, alipd, alius, aluamt, alupd, cbaamt," &
         "hsvper, mednum, medprpd, medprpy, penflag, ppchk1, ppchk2, ppchk3, ttbprx, mjobsect," &
         "etngrp, medpay, medrep, medrpnm, nanid1, nanid2, nanid3, nanid4, nanid5, nanid6," &
         "nietngrp, ninanid1, ninanid2, ninanid3, ninanid4, ninanid5, ninanid6, ninanid7, nirelig, pollopin," &
         "religenw, religsc, sidqn, soc2010, corignan, dobmonth, dobyear, ethgr3, ninanida, agehqual," &
         "bfd, bfdamt, bfdpd, bfdval, btec, btecnow, cbaamt2, change, citizen, citizen2," &
         "condit, corigoth, curqual, ddaprog1, ddatre1, ddatrep1, degree, degrenow, denrec, disd01," &
         "disd02, disd03, disd04, disd05, disd06, disd07, disd08, disd09, disd10, disdifp1," &
         "empcontr, ethgrps, eualiamt, eualimny, eualipd, euetype, followsc, health1, heathad, hi3qual," &
         "higho, highonow, jobbyr, limitl, lktrain, lkwork, medrec, nvqlenow, nvqlev, othpass," &
         "ppper, proptax, reasden, reasmed, reasnhs, reason, rednet, redtax, rsa, rsanow," &
         "samesit, scotvec, sctvnow, sdemp01, sdemp02, sdemp03, sdemp04, sdemp05, sdemp06, sdemp07," &
         "sdemp08, sdemp09, sdemp10, sdemp11, sdemp12, selfdemp, tempjob, agehq80, disacta1, discora1," &
         "gross4, ninrinc, typeed2, w45, accmsat, c2orign, calm, cbchk, claifut1, claifut2," &
         "claifut3, claifut4, claifut5, claifut6, claifut7, claifut8, commusat, coptrust, depress, disben1," &
         "disben2, disben3, disben4, disben5, disben6, discuss, dla1, dla2, dls, dlsamt," &
         "dlspd, dlsval, down, envirsat, gpispc, gpjsaesa, happy, help, iclaim1, iclaim2," &
         "iclaim3, iclaim4, iclaim5, iclaim6, iclaim7, iclaim8, iclaim9, jobsat, kidben1, kidben2," &
         "kidben3, legltrus, lifesat, meaning, moneysat, nervous, ni2train, othben1, othben2, othben3," &
         "othben4, othben5, othben6, othtrust, penben1, penben2, penben3, penben4, penben5, pip1," &
         "pip2, polttrus, recsat, relasat, safe, socfund1, socfund2, socfund3, socfund4, srispc," &
         "srjsaesa, timesat, train2, trnallow, wageben1, wageben2, wageben3, wageben4, wageben5, wageben6," &
         "wageben7, wageben8, ninnirbn, ninothbn, anxious, candgnow, curothf, curothp, curothwv, dvhiqual," &
         "gnvqnow, gpuc, happywb, hi1qual7, hi1qual8, mntarr5, mntnoch1, mntnoch2, mntnoch3, mntnoch4," &
         "mntnoch5, mntpro1, mntpro2, mntpro3, mnttim1, mnttim2, mnttim3, mntwrk1, mntwrk2, mntwrk3," &
         "mntwrk4, mntwrk5, ndeplnow, oqualc1, oqualc2, oqualc3, sruc, webacnow, indeth, euactive," &
         "euactno, euartact, euaskhlp, eucinema, eucultur, euinvol, eulivpe, eumtfam, eumtfrnd, eusocnet," &
         "eusport, eutkfam, eutkfrnd, eutkmat, euvol, natscot, ntsctnow, penwel1, penwel2, penwel3," &
         "penwel4, penwel5, penwel6, skiwknow, skiwrk, slos, yjblev " &
         " from frs.adult " ;
   
   --
   -- Insert all variables; substring to be competed with output from some criteria
   --
   INSERT_PART : constant String := "insert into frs.adult (" &
         "user_id, edition, year, sernum, benunit, person, abs1no, abs2no, abspar, abspay," &
         "abswhy, abswk, x_access, accftpt, accjb, accssamt, accsspd, adeduc, adema, ademaamt," &
         "ademapd, age, allow1, allow2, allow3, allow4, allpay1, allpay2, allpay3, allpay4," &
         "allpd1, allpd2, allpd3, allpd4, anyacc, anyed, anymon, anypen1, anypen2, anypen3," &
         "anypen4, anypen5, anypen6, anypen7, apamt, apdamt, apdir, apdpd, appd, b2qfut1," &
         "b2qfut2, b2qfut3, b3qfut1, b3qfut2, b3qfut3, b3qfut4, b3qfut5, b3qfut6, ben1q1, ben1q2," &
         "ben1q3, ben1q4, ben1q5, ben1q6, ben1q7, ben2q1, ben2q2, ben2q3, ben3q1, ben3q2," &
         "ben3q3, ben3q4, ben3q5, ben3q6, ben4q1, ben4q2, ben4q3, ben5q1, ben5q2, ben5q3," &
         "ben5q4, ben5q5, ben5q6, ben7q1, ben7q2, ben7q3, ben7q4, ben7q5, ben7q6, ben7q7," &
         "ben7q8, ben7q9, btwacc, claimant, cohabit, combid, convbl, ctclum1, ctclum2, cupchk," &
         "cvht, cvpay, cvpd, dentist, depend, disdif1, disdif2, disdif3, disdif4, disdif5," &
         "disdif6, disdif7, disdif8, dob, dptcboth, dptclum, dvil03a, dvil04a, dvjb12ml, dvmardf," &
         "ed1amt, ed1borr, ed1int, ed1monyr, ed1pd, ed1sum, ed2amt, ed2borr, ed2int, ed2monyr," &
         "ed2pd, ed2sum, edatt, edattn1, edattn2, edattn3, edhr, edtime, edtyp, eligadlt," &
         "eligchld, emppay1, emppay2, emppay3, empstat, endyr, epcur, es2000, ethgrp, everwrk," &
         "exthbct1, exthbct2, exthbct3, eyetest, follow, fted, ftwk, future, govpis, govpjsa," &
         "x_grant, grtamt1, grtamt2, grtdir1, grtdir2, grtnum, grtsce1, grtsce2, grtval1, grtval2," &
         "gta, hbothamt, hbothbu, hbothpd, hbothwk, hbotwait, health, hholder, hosp, hprob," &
         "hrpid, incdur, injlong, injwk, invests, iout, isa1type, isa2type, isa3type, jobaway," &
         "lareg, likewk, lktime, ln1rpint, ln2rpint, loan, loannum, look, lookwk, lstwrk1," &
         "lstwrk2, lstyr, mntamt1, mntamt2, mntct, mntfor1, mntfor2, mntgov1, mntgov2, mntpay," &
         "mntpd1, mntpd2, mntrec, mnttota1, mnttota2, mntus1, mntus2, mntusam1, mntusam2, mntuspd1," &
         "mntuspd2, ms, natid1, natid2, natid3, natid4, natid5, natid6, ndeal, newdtype," &
         "nhs1, nhs2, nhs3, niamt, niethgrp, niexthbb, ninatid1, ninatid2, ninatid3, ninatid4," &
         "ninatid5, ninatid6, ninatid7, ninatid8, nipd, nireg, nirel, nitrain, nlper, nolk1," &
         "nolk2, nolk3, nolook, nowant, nssec, ntcapp, ntcdat, ntcinc, ntcorig1, ntcorig2," &
         "ntcorig3, ntcorig4, ntcorig5, numjob, numjob2, oddjob, oldstud, otabspar, otamt, otapamt," &
         "otappd, othtax, otinva, pareamt, parepd, penlump, ppnumc, prit, prscrpt, ptwk," &
         "r01, r02, r03, r04, r05, r06, r07, r08, r09, r10," &
         "r11, r12, r13, r14, redamt, redany, rentprof, retire, retire1, retreas," &
         "royal1, royal2, royal3, royal4, royyr1, royyr2, royyr3, royyr4, rstrct, sex," &
         "sflntyp1, sflntyp2, sftype1, sftype2, sic, slrepamt, slrepay, slreppd, soc2000, spcreg1," &
         "spcreg2, spcreg3, specs, spout, srentamt, srentpd, start, startyr, taxcred1, taxcred2," &
         "taxcred3, taxcred4, taxcred5, taxfut, tdaywrk, tea, topupl, totint, train, trav," &
         "tuborr, typeed, unpaid1, unpaid2, voucher, w1, w2, wait, war1, war2," &
         "wftcboth, wftclum, whoresp, whosectb, whyfrde1, whyfrde2, whyfrde3, whyfrde4, whyfrde5, whyfrde6," &
         "whyfrey1, whyfrey2, whyfrey3, whyfrey4, whyfrey5, whyfrey6, whyfrpr1, whyfrpr2, whyfrpr3, whyfrpr4," &
         "whyfrpr5, whyfrpr6, whytrav1, whytrav2, whytrav3, whytrav4, whytrav5, whytrav6, wintfuel, wmkit," &
         "working, wpa, wpba, wtclum1, wtclum2, wtclum3, ystrtwk, month, able, actacci," &
         "addda, basacti, bntxcred, careab, careah, carecb, carech, carecl, carefl, carefr," &
         "careot, carere, curacti, empoccp, empstatb, empstatc, empstati, fsbndcti, fwmlkval, gebacti," &
         "giltcti, gross2, gross3, hbsupran, hdage, hdben, hdindinc, hourab, hourah, hourcare," &
         "hourcb, hourch, hourcl, hourfr, hourot, hourre, hourtot, hperson, iagegr2, iagegrp," &
         "incseo2, indinc, indisben, inearns, ininv, inirben, innirben, inothben, inpeninc, inrinc," &
         "inrpinc, intvlic, intxcred, isacti, marital, netocpen, nincseo2, nindinc, ninearns, nininv," &
         "ninpenin, ninsein2, nsbocti, occupnum, otbscti, pepscti, poaccti, prbocti, relhrp, sayecti," &
         "sclbcti, seincam2, smpadj, sscti, sspadj, stshcti, superan, taxpayer, tesscti, totgrant," &
         "tothours, totoccp, ttwcosts, untrcti, uperson, widoccp, accountq, ben5q7, ben5q8, ben5q9," &
         "ddatre, disdif9, fare, nittwmod, oneway, pssamt, pssdate, ttwcode1, ttwcode2, ttwcode3," &
         "ttwcost, ttwfar, ttwfrq, ttwmod, ttwpay, ttwpss, ttwrec, chbflg, crunaci, enomorti," &
         "sapadj, sppadj, ttwmode, ddatrep, defrpen, disdifp, followup, practice, sfrpis, sfrpjsa," &
         "age80, ethgr2, pocardi, chkdpn, chknop, consent, dvpens, eligschm, emparr, emppen," &
         "empschm, lnkref1, lnkref2, lnkref21, lnkref22, lnkref23, lnkref24, lnkref25, lnkref3, lnkref4," &
         "lnkref5, memschm, pconsent, perspen1, perspen2, privpen, schchk, spnumc, stakep, trainee," &
         "lnkdwp, lnkons, lnkref6, lnkref7, lnkref8, lnkref9, tcever1, tcever2, tcrepay1, tcrepay2," &
         "tcrepay3, tcrepay4, tcrepay5, tcrepay6, tcthsyr1, tcthsyr2, currjobm, prevjobm, b3qfut7, ben3q7," &
         "camemt, cameyr, cameyr2, contuk, corign, ddaprog, hbolng, hi1qual1, hi1qual2, hi1qual3," &
         "hi1qual4, hi1qual5, hi1qual6, hi2qual, hlpgvn01, hlpgvn02, hlpgvn03, hlpgvn04, hlpgvn05, hlpgvn06," &
         "hlpgvn07, hlpgvn08, hlpgvn09, hlpgvn10, hlpgvn11, hlprec01, hlprec02, hlprec03, hlprec04, hlprec05," &
         "hlprec06, hlprec07, hlprec08, hlprec09, hlprec10, hlprec11, issue, loangvn1, loangvn2, loangvn3," &
         "loanrec1, loanrec2, loanrec3, mntarr1, mntarr2, mntarr3, mntarr4, mntnrp, othqual1, othqual2," &
         "othqual3, tea9697, heartval, iagegr3, iagegr4, nirel2, xbonflag, alg, algamt, algpd," &
         "ben4q4, chkctc, chkdpco1, chkdpco2, chkdpco3, chkdsco1, chkdsco2, chkdsco3, dv09pens, lnkref01," &
         "lnkref02, lnkref03, lnkref04, lnkref05, lnkref06, lnkref07, lnkref08, lnkref09, lnkref10, lnkref11," &
         "spyrot, disdifad, gross3_x, aliamt, alimny, alipd, alius, aluamt, alupd, cbaamt," &
         "hsvper, mednum, medprpd, medprpy, penflag, ppchk1, ppchk2, ppchk3, ttbprx, mjobsect," &
         "etngrp, medpay, medrep, medrpnm, nanid1, nanid2, nanid3, nanid4, nanid5, nanid6," &
         "nietngrp, ninanid1, ninanid2, ninanid3, ninanid4, ninanid5, ninanid6, ninanid7, nirelig, pollopin," &
         "religenw, religsc, sidqn, soc2010, corignan, dobmonth, dobyear, ethgr3, ninanida, agehqual," &
         "bfd, bfdamt, bfdpd, bfdval, btec, btecnow, cbaamt2, change, citizen, citizen2," &
         "condit, corigoth, curqual, ddaprog1, ddatre1, ddatrep1, degree, degrenow, denrec, disd01," &
         "disd02, disd03, disd04, disd05, disd06, disd07, disd08, disd09, disd10, disdifp1," &
         "empcontr, ethgrps, eualiamt, eualimny, eualipd, euetype, followsc, health1, heathad, hi3qual," &
         "higho, highonow, jobbyr, limitl, lktrain, lkwork, medrec, nvqlenow, nvqlev, othpass," &
         "ppper, proptax, reasden, reasmed, reasnhs, reason, rednet, redtax, rsa, rsanow," &
         "samesit, scotvec, sctvnow, sdemp01, sdemp02, sdemp03, sdemp04, sdemp05, sdemp06, sdemp07," &
         "sdemp08, sdemp09, sdemp10, sdemp11, sdemp12, selfdemp, tempjob, agehq80, disacta1, discora1," &
         "gross4, ninrinc, typeed2, w45, accmsat, c2orign, calm, cbchk, claifut1, claifut2," &
         "claifut3, claifut4, claifut5, claifut6, claifut7, claifut8, commusat, coptrust, depress, disben1," &
         "disben2, disben3, disben4, disben5, disben6, discuss, dla1, dla2, dls, dlsamt," &
         "dlspd, dlsval, down, envirsat, gpispc, gpjsaesa, happy, help, iclaim1, iclaim2," &
         "iclaim3, iclaim4, iclaim5, iclaim6, iclaim7, iclaim8, iclaim9, jobsat, kidben1, kidben2," &
         "kidben3, legltrus, lifesat, meaning, moneysat, nervous, ni2train, othben1, othben2, othben3," &
         "othben4, othben5, othben6, othtrust, penben1, penben2, penben3, penben4, penben5, pip1," &
         "pip2, polttrus, recsat, relasat, safe, socfund1, socfund2, socfund3, socfund4, srispc," &
         "srjsaesa, timesat, train2, trnallow, wageben1, wageben2, wageben3, wageben4, wageben5, wageben6," &
         "wageben7, wageben8, ninnirbn, ninothbn, anxious, candgnow, curothf, curothp, curothwv, dvhiqual," &
         "gnvqnow, gpuc, happywb, hi1qual7, hi1qual8, mntarr5, mntnoch1, mntnoch2, mntnoch3, mntnoch4," &
         "mntnoch5, mntpro1, mntpro2, mntpro3, mnttim1, mnttim2, mnttim3, mntwrk1, mntwrk2, mntwrk3," &
         "mntwrk4, mntwrk5, ndeplnow, oqualc1, oqualc2, oqualc3, sruc, webacnow, indeth, euactive," &
         "euactno, euartact, euaskhlp, eucinema, eucultur, euinvol, eulivpe, eumtfam, eumtfrnd, eusocnet," &
         "eusport, eutkfam, eutkfrnd, eutkmat, euvol, natscot, ntsctnow, penwel1, penwel2, penwel3," &
         "penwel4, penwel5, penwel6, skiwknow, skiwrk, slos, yjblev " &
         " ) values " ;

   
   --
   -- delete all the records identified by the where SQL clause 
   --
   DELETE_PART : constant String := "delete from frs.adult ";
   
   --
   -- update
   --
   UPDATE_PART : constant String := "update frs.adult set  ";
   function Get_Configured_Insert_Params( update_order : Boolean := False )  return GNATCOLL.SQL.Exec.SQL_Parameters is
   use GNATCOLL.SQL_Impl;
      params : constant SQL_Parameters( 1 .. 927 ) := ( if update_order then (
            1 => ( Parameter_Integer, 0 ),   --  : abs1no (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : abs2no (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : abspar (Integer)
            4 => ( Parameter_Integer, 0 ),   --  : abspay (Integer)
            5 => ( Parameter_Integer, 0 ),   --  : abswhy (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : abswk (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : x_access (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : accftpt (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : accjb (Integer)
           10 => ( Parameter_Float, 0.0 ),   --  : accssamt (Amount)
           11 => ( Parameter_Integer, 0 ),   --  : accsspd (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : adeduc (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : adema (Integer)
           14 => ( Parameter_Float, 0.0 ),   --  : ademaamt (Amount)
           15 => ( Parameter_Integer, 0 ),   --  : ademapd (Integer)
           16 => ( Parameter_Integer, 0 ),   --  : age (Integer)
           17 => ( Parameter_Integer, 0 ),   --  : allow1 (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : allow2 (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : allow3 (Integer)
           20 => ( Parameter_Integer, 0 ),   --  : allow4 (Integer)
           21 => ( Parameter_Float, 0.0 ),   --  : allpay1 (Amount)
           22 => ( Parameter_Float, 0.0 ),   --  : allpay2 (Amount)
           23 => ( Parameter_Float, 0.0 ),   --  : allpay3 (Amount)
           24 => ( Parameter_Float, 0.0 ),   --  : allpay4 (Amount)
           25 => ( Parameter_Integer, 0 ),   --  : allpd1 (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : allpd2 (Integer)
           27 => ( Parameter_Integer, 0 ),   --  : allpd3 (Integer)
           28 => ( Parameter_Integer, 0 ),   --  : allpd4 (Integer)
           29 => ( Parameter_Integer, 0 ),   --  : anyacc (Integer)
           30 => ( Parameter_Integer, 0 ),   --  : anyed (Integer)
           31 => ( Parameter_Integer, 0 ),   --  : anymon (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : anypen1 (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : anypen2 (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : anypen3 (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : anypen4 (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : anypen5 (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : anypen6 (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : anypen7 (Integer)
           39 => ( Parameter_Float, 0.0 ),   --  : apamt (Amount)
           40 => ( Parameter_Float, 0.0 ),   --  : apdamt (Amount)
           41 => ( Parameter_Integer, 0 ),   --  : apdir (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : apdpd (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : appd (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : b2qfut1 (Integer)
           45 => ( Parameter_Integer, 0 ),   --  : b2qfut2 (Integer)
           46 => ( Parameter_Integer, 0 ),   --  : b2qfut3 (Integer)
           47 => ( Parameter_Integer, 0 ),   --  : b3qfut1 (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : b3qfut2 (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : b3qfut3 (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : b3qfut4 (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : b3qfut5 (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : b3qfut6 (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : ben1q1 (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : ben1q2 (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : ben1q3 (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : ben1q4 (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : ben1q5 (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : ben1q6 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : ben1q7 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : ben2q1 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : ben2q2 (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : ben2q3 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : ben3q1 (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : ben3q2 (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : ben3q3 (Integer)
           66 => ( Parameter_Integer, 0 ),   --  : ben3q4 (Integer)
           67 => ( Parameter_Integer, 0 ),   --  : ben3q5 (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : ben3q6 (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : ben4q1 (Integer)
           70 => ( Parameter_Integer, 0 ),   --  : ben4q2 (Integer)
           71 => ( Parameter_Integer, 0 ),   --  : ben4q3 (Integer)
           72 => ( Parameter_Integer, 0 ),   --  : ben5q1 (Integer)
           73 => ( Parameter_Integer, 0 ),   --  : ben5q2 (Integer)
           74 => ( Parameter_Integer, 0 ),   --  : ben5q3 (Integer)
           75 => ( Parameter_Integer, 0 ),   --  : ben5q4 (Integer)
           76 => ( Parameter_Integer, 0 ),   --  : ben5q5 (Integer)
           77 => ( Parameter_Integer, 0 ),   --  : ben5q6 (Integer)
           78 => ( Parameter_Integer, 0 ),   --  : ben7q1 (Integer)
           79 => ( Parameter_Integer, 0 ),   --  : ben7q2 (Integer)
           80 => ( Parameter_Integer, 0 ),   --  : ben7q3 (Integer)
           81 => ( Parameter_Integer, 0 ),   --  : ben7q4 (Integer)
           82 => ( Parameter_Integer, 0 ),   --  : ben7q5 (Integer)
           83 => ( Parameter_Integer, 0 ),   --  : ben7q6 (Integer)
           84 => ( Parameter_Integer, 0 ),   --  : ben7q7 (Integer)
           85 => ( Parameter_Integer, 0 ),   --  : ben7q8 (Integer)
           86 => ( Parameter_Integer, 0 ),   --  : ben7q9 (Integer)
           87 => ( Parameter_Integer, 0 ),   --  : btwacc (Integer)
           88 => ( Parameter_Integer, 0 ),   --  : claimant (Integer)
           89 => ( Parameter_Integer, 0 ),   --  : cohabit (Integer)
           90 => ( Parameter_Integer, 0 ),   --  : combid (Integer)
           91 => ( Parameter_Integer, 0 ),   --  : convbl (Integer)
           92 => ( Parameter_Integer, 0 ),   --  : ctclum1 (Integer)
           93 => ( Parameter_Integer, 0 ),   --  : ctclum2 (Integer)
           94 => ( Parameter_Integer, 0 ),   --  : cupchk (Integer)
           95 => ( Parameter_Integer, 0 ),   --  : cvht (Integer)
           96 => ( Parameter_Float, 0.0 ),   --  : cvpay (Amount)
           97 => ( Parameter_Integer, 0 ),   --  : cvpd (Integer)
           98 => ( Parameter_Integer, 0 ),   --  : dentist (Integer)
           99 => ( Parameter_Integer, 0 ),   --  : depend (Integer)
           100 => ( Parameter_Integer, 0 ),   --  : disdif1 (Integer)
           101 => ( Parameter_Integer, 0 ),   --  : disdif2 (Integer)
           102 => ( Parameter_Integer, 0 ),   --  : disdif3 (Integer)
           103 => ( Parameter_Integer, 0 ),   --  : disdif4 (Integer)
           104 => ( Parameter_Integer, 0 ),   --  : disdif5 (Integer)
           105 => ( Parameter_Integer, 0 ),   --  : disdif6 (Integer)
           106 => ( Parameter_Integer, 0 ),   --  : disdif7 (Integer)
           107 => ( Parameter_Integer, 0 ),   --  : disdif8 (Integer)
           108 => ( Parameter_Date, Clock ),   --  : dob (Ada.Calendar.Time)
           109 => ( Parameter_Integer, 0 ),   --  : dptcboth (Integer)
           110 => ( Parameter_Integer, 0 ),   --  : dptclum (Integer)
           111 => ( Parameter_Integer, 0 ),   --  : dvil03a (Integer)
           112 => ( Parameter_Integer, 0 ),   --  : dvil04a (Integer)
           113 => ( Parameter_Integer, 0 ),   --  : dvjb12ml (Integer)
           114 => ( Parameter_Integer, 0 ),   --  : dvmardf (Integer)
           115 => ( Parameter_Float, 0.0 ),   --  : ed1amt (Amount)
           116 => ( Parameter_Integer, 0 ),   --  : ed1borr (Integer)
           117 => ( Parameter_Integer, 0 ),   --  : ed1int (Integer)
           118 => ( Parameter_Date, Clock ),   --  : ed1monyr (Ada.Calendar.Time)
           119 => ( Parameter_Integer, 0 ),   --  : ed1pd (Integer)
           120 => ( Parameter_Integer, 0 ),   --  : ed1sum (Integer)
           121 => ( Parameter_Float, 0.0 ),   --  : ed2amt (Amount)
           122 => ( Parameter_Integer, 0 ),   --  : ed2borr (Integer)
           123 => ( Parameter_Integer, 0 ),   --  : ed2int (Integer)
           124 => ( Parameter_Date, Clock ),   --  : ed2monyr (Ada.Calendar.Time)
           125 => ( Parameter_Integer, 0 ),   --  : ed2pd (Integer)
           126 => ( Parameter_Integer, 0 ),   --  : ed2sum (Integer)
           127 => ( Parameter_Integer, 0 ),   --  : edatt (Integer)
           128 => ( Parameter_Integer, 0 ),   --  : edattn1 (Integer)
           129 => ( Parameter_Integer, 0 ),   --  : edattn2 (Integer)
           130 => ( Parameter_Integer, 0 ),   --  : edattn3 (Integer)
           131 => ( Parameter_Integer, 0 ),   --  : edhr (Integer)
           132 => ( Parameter_Integer, 0 ),   --  : edtime (Integer)
           133 => ( Parameter_Integer, 0 ),   --  : edtyp (Integer)
           134 => ( Parameter_Integer, 0 ),   --  : eligadlt (Integer)
           135 => ( Parameter_Integer, 0 ),   --  : eligchld (Integer)
           136 => ( Parameter_Integer, 0 ),   --  : emppay1 (Integer)
           137 => ( Parameter_Integer, 0 ),   --  : emppay2 (Integer)
           138 => ( Parameter_Integer, 0 ),   --  : emppay3 (Integer)
           139 => ( Parameter_Integer, 0 ),   --  : empstat (Integer)
           140 => ( Parameter_Integer, 0 ),   --  : endyr (Integer)
           141 => ( Parameter_Integer, 0 ),   --  : epcur (Integer)
           142 => ( Parameter_Integer, 0 ),   --  : es2000 (Integer)
           143 => ( Parameter_Integer, 0 ),   --  : ethgrp (Integer)
           144 => ( Parameter_Integer, 0 ),   --  : everwrk (Integer)
           145 => ( Parameter_Integer, 0 ),   --  : exthbct1 (Integer)
           146 => ( Parameter_Integer, 0 ),   --  : exthbct2 (Integer)
           147 => ( Parameter_Integer, 0 ),   --  : exthbct3 (Integer)
           148 => ( Parameter_Integer, 0 ),   --  : eyetest (Integer)
           149 => ( Parameter_Integer, 0 ),   --  : follow (Integer)
           150 => ( Parameter_Integer, 0 ),   --  : fted (Integer)
           151 => ( Parameter_Integer, 0 ),   --  : ftwk (Integer)
           152 => ( Parameter_Integer, 0 ),   --  : future (Integer)
           153 => ( Parameter_Integer, 0 ),   --  : govpis (Integer)
           154 => ( Parameter_Integer, 0 ),   --  : govpjsa (Integer)
           155 => ( Parameter_Integer, 0 ),   --  : x_grant (Integer)
           156 => ( Parameter_Float, 0.0 ),   --  : grtamt1 (Amount)
           157 => ( Parameter_Float, 0.0 ),   --  : grtamt2 (Amount)
           158 => ( Parameter_Float, 0.0 ),   --  : grtdir1 (Amount)
           159 => ( Parameter_Float, 0.0 ),   --  : grtdir2 (Amount)
           160 => ( Parameter_Integer, 0 ),   --  : grtnum (Integer)
           161 => ( Parameter_Integer, 0 ),   --  : grtsce1 (Integer)
           162 => ( Parameter_Integer, 0 ),   --  : grtsce2 (Integer)
           163 => ( Parameter_Float, 0.0 ),   --  : grtval1 (Amount)
           164 => ( Parameter_Float, 0.0 ),   --  : grtval2 (Amount)
           165 => ( Parameter_Integer, 0 ),   --  : gta (Integer)
           166 => ( Parameter_Float, 0.0 ),   --  : hbothamt (Amount)
           167 => ( Parameter_Integer, 0 ),   --  : hbothbu (Integer)
           168 => ( Parameter_Integer, 0 ),   --  : hbothpd (Integer)
           169 => ( Parameter_Integer, 0 ),   --  : hbothwk (Integer)
           170 => ( Parameter_Integer, 0 ),   --  : hbotwait (Integer)
           171 => ( Parameter_Integer, 0 ),   --  : health (Integer)
           172 => ( Parameter_Integer, 0 ),   --  : hholder (Integer)
           173 => ( Parameter_Integer, 0 ),   --  : hosp (Integer)
           174 => ( Parameter_Integer, 0 ),   --  : hprob (Integer)
           175 => ( Parameter_Integer, 0 ),   --  : hrpid (Integer)
           176 => ( Parameter_Integer, 0 ),   --  : incdur (Integer)
           177 => ( Parameter_Integer, 0 ),   --  : injlong (Integer)
           178 => ( Parameter_Integer, 0 ),   --  : injwk (Integer)
           179 => ( Parameter_Integer, 0 ),   --  : invests (Integer)
           180 => ( Parameter_Integer, 0 ),   --  : iout (Integer)
           181 => ( Parameter_Integer, 0 ),   --  : isa1type (Integer)
           182 => ( Parameter_Integer, 0 ),   --  : isa2type (Integer)
           183 => ( Parameter_Integer, 0 ),   --  : isa3type (Integer)
           184 => ( Parameter_Integer, 0 ),   --  : jobaway (Integer)
           185 => ( Parameter_Integer, 0 ),   --  : lareg (Integer)
           186 => ( Parameter_Integer, 0 ),   --  : likewk (Integer)
           187 => ( Parameter_Integer, 0 ),   --  : lktime (Integer)
           188 => ( Parameter_Integer, 0 ),   --  : ln1rpint (Integer)
           189 => ( Parameter_Integer, 0 ),   --  : ln2rpint (Integer)
           190 => ( Parameter_Integer, 0 ),   --  : loan (Integer)
           191 => ( Parameter_Integer, 0 ),   --  : loannum (Integer)
           192 => ( Parameter_Integer, 0 ),   --  : look (Integer)
           193 => ( Parameter_Integer, 0 ),   --  : lookwk (Integer)
           194 => ( Parameter_Integer, 0 ),   --  : lstwrk1 (Integer)
           195 => ( Parameter_Integer, 0 ),   --  : lstwrk2 (Integer)
           196 => ( Parameter_Integer, 0 ),   --  : lstyr (Integer)
           197 => ( Parameter_Float, 0.0 ),   --  : mntamt1 (Amount)
           198 => ( Parameter_Float, 0.0 ),   --  : mntamt2 (Amount)
           199 => ( Parameter_Integer, 0 ),   --  : mntct (Integer)
           200 => ( Parameter_Integer, 0 ),   --  : mntfor1 (Integer)
           201 => ( Parameter_Integer, 0 ),   --  : mntfor2 (Integer)
           202 => ( Parameter_Integer, 0 ),   --  : mntgov1 (Integer)
           203 => ( Parameter_Integer, 0 ),   --  : mntgov2 (Integer)
           204 => ( Parameter_Integer, 0 ),   --  : mntpay (Integer)
           205 => ( Parameter_Integer, 0 ),   --  : mntpd1 (Integer)
           206 => ( Parameter_Integer, 0 ),   --  : mntpd2 (Integer)
           207 => ( Parameter_Integer, 0 ),   --  : mntrec (Integer)
           208 => ( Parameter_Integer, 0 ),   --  : mnttota1 (Integer)
           209 => ( Parameter_Integer, 0 ),   --  : mnttota2 (Integer)
           210 => ( Parameter_Integer, 0 ),   --  : mntus1 (Integer)
           211 => ( Parameter_Integer, 0 ),   --  : mntus2 (Integer)
           212 => ( Parameter_Float, 0.0 ),   --  : mntusam1 (Amount)
           213 => ( Parameter_Float, 0.0 ),   --  : mntusam2 (Amount)
           214 => ( Parameter_Integer, 0 ),   --  : mntuspd1 (Integer)
           215 => ( Parameter_Integer, 0 ),   --  : mntuspd2 (Integer)
           216 => ( Parameter_Integer, 0 ),   --  : ms (Integer)
           217 => ( Parameter_Integer, 0 ),   --  : natid1 (Integer)
           218 => ( Parameter_Integer, 0 ),   --  : natid2 (Integer)
           219 => ( Parameter_Integer, 0 ),   --  : natid3 (Integer)
           220 => ( Parameter_Integer, 0 ),   --  : natid4 (Integer)
           221 => ( Parameter_Integer, 0 ),   --  : natid5 (Integer)
           222 => ( Parameter_Integer, 0 ),   --  : natid6 (Integer)
           223 => ( Parameter_Integer, 0 ),   --  : ndeal (Integer)
           224 => ( Parameter_Integer, 0 ),   --  : newdtype (Integer)
           225 => ( Parameter_Integer, 0 ),   --  : nhs1 (Integer)
           226 => ( Parameter_Integer, 0 ),   --  : nhs2 (Integer)
           227 => ( Parameter_Integer, 0 ),   --  : nhs3 (Integer)
           228 => ( Parameter_Float, 0.0 ),   --  : niamt (Amount)
           229 => ( Parameter_Integer, 0 ),   --  : niethgrp (Integer)
           230 => ( Parameter_Integer, 0 ),   --  : niexthbb (Integer)
           231 => ( Parameter_Integer, 0 ),   --  : ninatid1 (Integer)
           232 => ( Parameter_Integer, 0 ),   --  : ninatid2 (Integer)
           233 => ( Parameter_Integer, 0 ),   --  : ninatid3 (Integer)
           234 => ( Parameter_Integer, 0 ),   --  : ninatid4 (Integer)
           235 => ( Parameter_Integer, 0 ),   --  : ninatid5 (Integer)
           236 => ( Parameter_Integer, 0 ),   --  : ninatid6 (Integer)
           237 => ( Parameter_Integer, 0 ),   --  : ninatid7 (Integer)
           238 => ( Parameter_Integer, 0 ),   --  : ninatid8 (Integer)
           239 => ( Parameter_Integer, 0 ),   --  : nipd (Integer)
           240 => ( Parameter_Integer, 0 ),   --  : nireg (Integer)
           241 => ( Parameter_Integer, 0 ),   --  : nirel (Integer)
           242 => ( Parameter_Integer, 0 ),   --  : nitrain (Integer)
           243 => ( Parameter_Integer, 0 ),   --  : nlper (Integer)
           244 => ( Parameter_Integer, 0 ),   --  : nolk1 (Integer)
           245 => ( Parameter_Integer, 0 ),   --  : nolk2 (Integer)
           246 => ( Parameter_Integer, 0 ),   --  : nolk3 (Integer)
           247 => ( Parameter_Integer, 0 ),   --  : nolook (Integer)
           248 => ( Parameter_Integer, 0 ),   --  : nowant (Integer)
           249 => ( Parameter_Float, 0.0 ),   --  : nssec (Amount)
           250 => ( Parameter_Integer, 0 ),   --  : ntcapp (Integer)
           251 => ( Parameter_Integer, 0 ),   --  : ntcdat (Integer)
           252 => ( Parameter_Float, 0.0 ),   --  : ntcinc (Amount)
           253 => ( Parameter_Integer, 0 ),   --  : ntcorig1 (Integer)
           254 => ( Parameter_Integer, 0 ),   --  : ntcorig2 (Integer)
           255 => ( Parameter_Integer, 0 ),   --  : ntcorig3 (Integer)
           256 => ( Parameter_Integer, 0 ),   --  : ntcorig4 (Integer)
           257 => ( Parameter_Integer, 0 ),   --  : ntcorig5 (Integer)
           258 => ( Parameter_Integer, 0 ),   --  : numjob (Integer)
           259 => ( Parameter_Integer, 0 ),   --  : numjob2 (Integer)
           260 => ( Parameter_Integer, 0 ),   --  : oddjob (Integer)
           261 => ( Parameter_Integer, 0 ),   --  : oldstud (Integer)
           262 => ( Parameter_Integer, 0 ),   --  : otabspar (Integer)
           263 => ( Parameter_Float, 0.0 ),   --  : otamt (Amount)
           264 => ( Parameter_Float, 0.0 ),   --  : otapamt (Amount)
           265 => ( Parameter_Integer, 0 ),   --  : otappd (Integer)
           266 => ( Parameter_Integer, 0 ),   --  : othtax (Integer)
           267 => ( Parameter_Integer, 0 ),   --  : otinva (Integer)
           268 => ( Parameter_Float, 0.0 ),   --  : pareamt (Amount)
           269 => ( Parameter_Integer, 0 ),   --  : parepd (Integer)
           270 => ( Parameter_Integer, 0 ),   --  : penlump (Integer)
           271 => ( Parameter_Integer, 0 ),   --  : ppnumc (Integer)
           272 => ( Parameter_Integer, 0 ),   --  : prit (Integer)
           273 => ( Parameter_Integer, 0 ),   --  : prscrpt (Integer)
           274 => ( Parameter_Integer, 0 ),   --  : ptwk (Integer)
           275 => ( Parameter_Integer, 0 ),   --  : r01 (Integer)
           276 => ( Parameter_Integer, 0 ),   --  : r02 (Integer)
           277 => ( Parameter_Integer, 0 ),   --  : r03 (Integer)
           278 => ( Parameter_Integer, 0 ),   --  : r04 (Integer)
           279 => ( Parameter_Integer, 0 ),   --  : r05 (Integer)
           280 => ( Parameter_Integer, 0 ),   --  : r06 (Integer)
           281 => ( Parameter_Integer, 0 ),   --  : r07 (Integer)
           282 => ( Parameter_Integer, 0 ),   --  : r08 (Integer)
           283 => ( Parameter_Integer, 0 ),   --  : r09 (Integer)
           284 => ( Parameter_Integer, 0 ),   --  : r10 (Integer)
           285 => ( Parameter_Integer, 0 ),   --  : r11 (Integer)
           286 => ( Parameter_Integer, 0 ),   --  : r12 (Integer)
           287 => ( Parameter_Integer, 0 ),   --  : r13 (Integer)
           288 => ( Parameter_Integer, 0 ),   --  : r14 (Integer)
           289 => ( Parameter_Float, 0.0 ),   --  : redamt (Amount)
           290 => ( Parameter_Integer, 0 ),   --  : redany (Integer)
           291 => ( Parameter_Integer, 0 ),   --  : rentprof (Integer)
           292 => ( Parameter_Integer, 0 ),   --  : retire (Integer)
           293 => ( Parameter_Integer, 0 ),   --  : retire1 (Integer)
           294 => ( Parameter_Integer, 0 ),   --  : retreas (Integer)
           295 => ( Parameter_Integer, 0 ),   --  : royal1 (Integer)
           296 => ( Parameter_Integer, 0 ),   --  : royal2 (Integer)
           297 => ( Parameter_Integer, 0 ),   --  : royal3 (Integer)
           298 => ( Parameter_Integer, 0 ),   --  : royal4 (Integer)
           299 => ( Parameter_Float, 0.0 ),   --  : royyr1 (Amount)
           300 => ( Parameter_Float, 0.0 ),   --  : royyr2 (Amount)
           301 => ( Parameter_Float, 0.0 ),   --  : royyr3 (Amount)
           302 => ( Parameter_Float, 0.0 ),   --  : royyr4 (Amount)
           303 => ( Parameter_Integer, 0 ),   --  : rstrct (Integer)
           304 => ( Parameter_Integer, 0 ),   --  : sex (Integer)
           305 => ( Parameter_Integer, 0 ),   --  : sflntyp1 (Integer)
           306 => ( Parameter_Integer, 0 ),   --  : sflntyp2 (Integer)
           307 => ( Parameter_Integer, 0 ),   --  : sftype1 (Integer)
           308 => ( Parameter_Integer, 0 ),   --  : sftype2 (Integer)
           309 => ( Parameter_Integer, 0 ),   --  : sic (Integer)
           310 => ( Parameter_Float, 0.0 ),   --  : slrepamt (Amount)
           311 => ( Parameter_Integer, 0 ),   --  : slrepay (Integer)
           312 => ( Parameter_Integer, 0 ),   --  : slreppd (Integer)
           313 => ( Parameter_Integer, 0 ),   --  : soc2000 (Integer)
           314 => ( Parameter_Integer, 0 ),   --  : spcreg1 (Integer)
           315 => ( Parameter_Integer, 0 ),   --  : spcreg2 (Integer)
           316 => ( Parameter_Integer, 0 ),   --  : spcreg3 (Integer)
           317 => ( Parameter_Integer, 0 ),   --  : specs (Integer)
           318 => ( Parameter_Integer, 0 ),   --  : spout (Integer)
           319 => ( Parameter_Float, 0.0 ),   --  : srentamt (Amount)
           320 => ( Parameter_Integer, 0 ),   --  : srentpd (Integer)
           321 => ( Parameter_Integer, 0 ),   --  : start (Integer)
           322 => ( Parameter_Integer, 0 ),   --  : startyr (Integer)
           323 => ( Parameter_Integer, 0 ),   --  : taxcred1 (Integer)
           324 => ( Parameter_Integer, 0 ),   --  : taxcred2 (Integer)
           325 => ( Parameter_Integer, 0 ),   --  : taxcred3 (Integer)
           326 => ( Parameter_Integer, 0 ),   --  : taxcred4 (Integer)
           327 => ( Parameter_Integer, 0 ),   --  : taxcred5 (Integer)
           328 => ( Parameter_Integer, 0 ),   --  : taxfut (Integer)
           329 => ( Parameter_Integer, 0 ),   --  : tdaywrk (Integer)
           330 => ( Parameter_Integer, 0 ),   --  : tea (Integer)
           331 => ( Parameter_Integer, 0 ),   --  : topupl (Integer)
           332 => ( Parameter_Float, 0.0 ),   --  : totint (Amount)
           333 => ( Parameter_Integer, 0 ),   --  : train (Integer)
           334 => ( Parameter_Integer, 0 ),   --  : trav (Integer)
           335 => ( Parameter_Integer, 0 ),   --  : tuborr (Integer)
           336 => ( Parameter_Integer, 0 ),   --  : typeed (Integer)
           337 => ( Parameter_Integer, 0 ),   --  : unpaid1 (Integer)
           338 => ( Parameter_Integer, 0 ),   --  : unpaid2 (Integer)
           339 => ( Parameter_Integer, 0 ),   --  : voucher (Integer)
           340 => ( Parameter_Integer, 0 ),   --  : w1 (Integer)
           341 => ( Parameter_Integer, 0 ),   --  : w2 (Integer)
           342 => ( Parameter_Integer, 0 ),   --  : wait (Integer)
           343 => ( Parameter_Integer, 0 ),   --  : war1 (Integer)
           344 => ( Parameter_Integer, 0 ),   --  : war2 (Integer)
           345 => ( Parameter_Integer, 0 ),   --  : wftcboth (Integer)
           346 => ( Parameter_Integer, 0 ),   --  : wftclum (Integer)
           347 => ( Parameter_Integer, 0 ),   --  : whoresp (Integer)
           348 => ( Parameter_Integer, 0 ),   --  : whosectb (Integer)
           349 => ( Parameter_Integer, 0 ),   --  : whyfrde1 (Integer)
           350 => ( Parameter_Integer, 0 ),   --  : whyfrde2 (Integer)
           351 => ( Parameter_Integer, 0 ),   --  : whyfrde3 (Integer)
           352 => ( Parameter_Integer, 0 ),   --  : whyfrde4 (Integer)
           353 => ( Parameter_Integer, 0 ),   --  : whyfrde5 (Integer)
           354 => ( Parameter_Integer, 0 ),   --  : whyfrde6 (Integer)
           355 => ( Parameter_Integer, 0 ),   --  : whyfrey1 (Integer)
           356 => ( Parameter_Integer, 0 ),   --  : whyfrey2 (Integer)
           357 => ( Parameter_Integer, 0 ),   --  : whyfrey3 (Integer)
           358 => ( Parameter_Integer, 0 ),   --  : whyfrey4 (Integer)
           359 => ( Parameter_Integer, 0 ),   --  : whyfrey5 (Integer)
           360 => ( Parameter_Integer, 0 ),   --  : whyfrey6 (Integer)
           361 => ( Parameter_Integer, 0 ),   --  : whyfrpr1 (Integer)
           362 => ( Parameter_Integer, 0 ),   --  : whyfrpr2 (Integer)
           363 => ( Parameter_Integer, 0 ),   --  : whyfrpr3 (Integer)
           364 => ( Parameter_Integer, 0 ),   --  : whyfrpr4 (Integer)
           365 => ( Parameter_Integer, 0 ),   --  : whyfrpr5 (Integer)
           366 => ( Parameter_Integer, 0 ),   --  : whyfrpr6 (Integer)
           367 => ( Parameter_Integer, 0 ),   --  : whytrav1 (Integer)
           368 => ( Parameter_Integer, 0 ),   --  : whytrav2 (Integer)
           369 => ( Parameter_Integer, 0 ),   --  : whytrav3 (Integer)
           370 => ( Parameter_Integer, 0 ),   --  : whytrav4 (Integer)
           371 => ( Parameter_Integer, 0 ),   --  : whytrav5 (Integer)
           372 => ( Parameter_Integer, 0 ),   --  : whytrav6 (Integer)
           373 => ( Parameter_Integer, 0 ),   --  : wintfuel (Integer)
           374 => ( Parameter_Integer, 0 ),   --  : wmkit (Integer)
           375 => ( Parameter_Integer, 0 ),   --  : working (Integer)
           376 => ( Parameter_Integer, 0 ),   --  : wpa (Integer)
           377 => ( Parameter_Integer, 0 ),   --  : wpba (Integer)
           378 => ( Parameter_Integer, 0 ),   --  : wtclum1 (Integer)
           379 => ( Parameter_Integer, 0 ),   --  : wtclum2 (Integer)
           380 => ( Parameter_Integer, 0 ),   --  : wtclum3 (Integer)
           381 => ( Parameter_Integer, 0 ),   --  : ystrtwk (Integer)
           382 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           383 => ( Parameter_Integer, 0 ),   --  : able (Integer)
           384 => ( Parameter_Integer, 0 ),   --  : actacci (Integer)
           385 => ( Parameter_Integer, 0 ),   --  : addda (Integer)
           386 => ( Parameter_Integer, 0 ),   --  : basacti (Integer)
           387 => ( Parameter_Float, 0.0 ),   --  : bntxcred (Amount)
           388 => ( Parameter_Integer, 0 ),   --  : careab (Integer)
           389 => ( Parameter_Integer, 0 ),   --  : careah (Integer)
           390 => ( Parameter_Integer, 0 ),   --  : carecb (Integer)
           391 => ( Parameter_Integer, 0 ),   --  : carech (Integer)
           392 => ( Parameter_Integer, 0 ),   --  : carecl (Integer)
           393 => ( Parameter_Integer, 0 ),   --  : carefl (Integer)
           394 => ( Parameter_Integer, 0 ),   --  : carefr (Integer)
           395 => ( Parameter_Integer, 0 ),   --  : careot (Integer)
           396 => ( Parameter_Integer, 0 ),   --  : carere (Integer)
           397 => ( Parameter_Integer, 0 ),   --  : curacti (Integer)
           398 => ( Parameter_Float, 0.0 ),   --  : empoccp (Amount)
           399 => ( Parameter_Integer, 0 ),   --  : empstatb (Integer)
           400 => ( Parameter_Integer, 0 ),   --  : empstatc (Integer)
           401 => ( Parameter_Integer, 0 ),   --  : empstati (Integer)
           402 => ( Parameter_Integer, 0 ),   --  : fsbndcti (Integer)
           403 => ( Parameter_Float, 0.0 ),   --  : fwmlkval (Amount)
           404 => ( Parameter_Integer, 0 ),   --  : gebacti (Integer)
           405 => ( Parameter_Integer, 0 ),   --  : giltcti (Integer)
           406 => ( Parameter_Integer, 0 ),   --  : gross2 (Integer)
           407 => ( Parameter_Integer, 0 ),   --  : gross3 (Integer)
           408 => ( Parameter_Float, 0.0 ),   --  : hbsupran (Amount)
           409 => ( Parameter_Integer, 0 ),   --  : hdage (Integer)
           410 => ( Parameter_Integer, 0 ),   --  : hdben (Integer)
           411 => ( Parameter_Integer, 0 ),   --  : hdindinc (Integer)
           412 => ( Parameter_Integer, 0 ),   --  : hourab (Integer)
           413 => ( Parameter_Integer, 0 ),   --  : hourah (Integer)
           414 => ( Parameter_Float, 0.0 ),   --  : hourcare (Amount)
           415 => ( Parameter_Integer, 0 ),   --  : hourcb (Integer)
           416 => ( Parameter_Integer, 0 ),   --  : hourch (Integer)
           417 => ( Parameter_Integer, 0 ),   --  : hourcl (Integer)
           418 => ( Parameter_Integer, 0 ),   --  : hourfr (Integer)
           419 => ( Parameter_Integer, 0 ),   --  : hourot (Integer)
           420 => ( Parameter_Integer, 0 ),   --  : hourre (Integer)
           421 => ( Parameter_Integer, 0 ),   --  : hourtot (Integer)
           422 => ( Parameter_Integer, 0 ),   --  : hperson (Integer)
           423 => ( Parameter_Integer, 0 ),   --  : iagegr2 (Integer)
           424 => ( Parameter_Integer, 0 ),   --  : iagegrp (Integer)
           425 => ( Parameter_Float, 0.0 ),   --  : incseo2 (Amount)
           426 => ( Parameter_Integer, 0 ),   --  : indinc (Integer)
           427 => ( Parameter_Integer, 0 ),   --  : indisben (Integer)
           428 => ( Parameter_Float, 0.0 ),   --  : inearns (Amount)
           429 => ( Parameter_Float, 0.0 ),   --  : ininv (Amount)
           430 => ( Parameter_Integer, 0 ),   --  : inirben (Integer)
           431 => ( Parameter_Integer, 0 ),   --  : innirben (Integer)
           432 => ( Parameter_Integer, 0 ),   --  : inothben (Integer)
           433 => ( Parameter_Float, 0.0 ),   --  : inpeninc (Amount)
           434 => ( Parameter_Float, 0.0 ),   --  : inrinc (Amount)
           435 => ( Parameter_Float, 0.0 ),   --  : inrpinc (Amount)
           436 => ( Parameter_Float, 0.0 ),   --  : intvlic (Amount)
           437 => ( Parameter_Float, 0.0 ),   --  : intxcred (Amount)
           438 => ( Parameter_Integer, 0 ),   --  : isacti (Integer)
           439 => ( Parameter_Integer, 0 ),   --  : marital (Integer)
           440 => ( Parameter_Float, 0.0 ),   --  : netocpen (Amount)
           441 => ( Parameter_Float, 0.0 ),   --  : nincseo2 (Amount)
           442 => ( Parameter_Integer, 0 ),   --  : nindinc (Integer)
           443 => ( Parameter_Integer, 0 ),   --  : ninearns (Integer)
           444 => ( Parameter_Integer, 0 ),   --  : nininv (Integer)
           445 => ( Parameter_Integer, 0 ),   --  : ninpenin (Integer)
           446 => ( Parameter_Float, 0.0 ),   --  : ninsein2 (Amount)
           447 => ( Parameter_Integer, 0 ),   --  : nsbocti (Integer)
           448 => ( Parameter_Integer, 0 ),   --  : occupnum (Integer)
           449 => ( Parameter_Integer, 0 ),   --  : otbscti (Integer)
           450 => ( Parameter_Integer, 0 ),   --  : pepscti (Integer)
           451 => ( Parameter_Integer, 0 ),   --  : poaccti (Integer)
           452 => ( Parameter_Integer, 0 ),   --  : prbocti (Integer)
           453 => ( Parameter_Integer, 0 ),   --  : relhrp (Integer)
           454 => ( Parameter_Integer, 0 ),   --  : sayecti (Integer)
           455 => ( Parameter_Integer, 0 ),   --  : sclbcti (Integer)
           456 => ( Parameter_Float, 0.0 ),   --  : seincam2 (Amount)
           457 => ( Parameter_Float, 0.0 ),   --  : smpadj (Amount)
           458 => ( Parameter_Integer, 0 ),   --  : sscti (Integer)
           459 => ( Parameter_Float, 0.0 ),   --  : sspadj (Amount)
           460 => ( Parameter_Integer, 0 ),   --  : stshcti (Integer)
           461 => ( Parameter_Float, 0.0 ),   --  : superan (Amount)
           462 => ( Parameter_Integer, 0 ),   --  : taxpayer (Integer)
           463 => ( Parameter_Integer, 0 ),   --  : tesscti (Integer)
           464 => ( Parameter_Float, 0.0 ),   --  : totgrant (Amount)
           465 => ( Parameter_Float, 0.0 ),   --  : tothours (Amount)
           466 => ( Parameter_Float, 0.0 ),   --  : totoccp (Amount)
           467 => ( Parameter_Float, 0.0 ),   --  : ttwcosts (Amount)
           468 => ( Parameter_Integer, 0 ),   --  : untrcti (Integer)
           469 => ( Parameter_Integer, 0 ),   --  : uperson (Integer)
           470 => ( Parameter_Float, 0.0 ),   --  : widoccp (Amount)
           471 => ( Parameter_Integer, 0 ),   --  : accountq (Integer)
           472 => ( Parameter_Integer, 0 ),   --  : ben5q7 (Integer)
           473 => ( Parameter_Integer, 0 ),   --  : ben5q8 (Integer)
           474 => ( Parameter_Integer, 0 ),   --  : ben5q9 (Integer)
           475 => ( Parameter_Integer, 0 ),   --  : ddatre (Integer)
           476 => ( Parameter_Integer, 0 ),   --  : disdif9 (Integer)
           477 => ( Parameter_Float, 0.0 ),   --  : fare (Amount)
           478 => ( Parameter_Integer, 0 ),   --  : nittwmod (Integer)
           479 => ( Parameter_Integer, 0 ),   --  : oneway (Integer)
           480 => ( Parameter_Float, 0.0 ),   --  : pssamt (Amount)
           481 => ( Parameter_Integer, 0 ),   --  : pssdate (Integer)
           482 => ( Parameter_Integer, 0 ),   --  : ttwcode1 (Integer)
           483 => ( Parameter_Integer, 0 ),   --  : ttwcode2 (Integer)
           484 => ( Parameter_Integer, 0 ),   --  : ttwcode3 (Integer)
           485 => ( Parameter_Float, 0.0 ),   --  : ttwcost (Amount)
           486 => ( Parameter_Integer, 0 ),   --  : ttwfar (Integer)
           487 => ( Parameter_Float, 0.0 ),   --  : ttwfrq (Amount)
           488 => ( Parameter_Integer, 0 ),   --  : ttwmod (Integer)
           489 => ( Parameter_Integer, 0 ),   --  : ttwpay (Integer)
           490 => ( Parameter_Integer, 0 ),   --  : ttwpss (Integer)
           491 => ( Parameter_Float, 0.0 ),   --  : ttwrec (Amount)
           492 => ( Parameter_Integer, 0 ),   --  : chbflg (Integer)
           493 => ( Parameter_Integer, 0 ),   --  : crunaci (Integer)
           494 => ( Parameter_Integer, 0 ),   --  : enomorti (Integer)
           495 => ( Parameter_Float, 0.0 ),   --  : sapadj (Amount)
           496 => ( Parameter_Float, 0.0 ),   --  : sppadj (Amount)
           497 => ( Parameter_Integer, 0 ),   --  : ttwmode (Integer)
           498 => ( Parameter_Integer, 0 ),   --  : ddatrep (Integer)
           499 => ( Parameter_Integer, 0 ),   --  : defrpen (Integer)
           500 => ( Parameter_Integer, 0 ),   --  : disdifp (Integer)
           501 => ( Parameter_Integer, 0 ),   --  : followup (Integer)
           502 => ( Parameter_Integer, 0 ),   --  : practice (Integer)
           503 => ( Parameter_Integer, 0 ),   --  : sfrpis (Integer)
           504 => ( Parameter_Integer, 0 ),   --  : sfrpjsa (Integer)
           505 => ( Parameter_Integer, 0 ),   --  : age80 (Integer)
           506 => ( Parameter_Integer, 0 ),   --  : ethgr2 (Integer)
           507 => ( Parameter_Integer, 0 ),   --  : pocardi (Integer)
           508 => ( Parameter_Integer, 0 ),   --  : chkdpn (Integer)
           509 => ( Parameter_Integer, 0 ),   --  : chknop (Integer)
           510 => ( Parameter_Integer, 0 ),   --  : consent (Integer)
           511 => ( Parameter_Integer, 0 ),   --  : dvpens (Integer)
           512 => ( Parameter_Integer, 0 ),   --  : eligschm (Integer)
           513 => ( Parameter_Integer, 0 ),   --  : emparr (Integer)
           514 => ( Parameter_Integer, 0 ),   --  : emppen (Integer)
           515 => ( Parameter_Integer, 0 ),   --  : empschm (Integer)
           516 => ( Parameter_Integer, 0 ),   --  : lnkref1 (Integer)
           517 => ( Parameter_Integer, 0 ),   --  : lnkref2 (Integer)
           518 => ( Parameter_Integer, 0 ),   --  : lnkref21 (Integer)
           519 => ( Parameter_Integer, 0 ),   --  : lnkref22 (Integer)
           520 => ( Parameter_Integer, 0 ),   --  : lnkref23 (Integer)
           521 => ( Parameter_Integer, 0 ),   --  : lnkref24 (Integer)
           522 => ( Parameter_Integer, 0 ),   --  : lnkref25 (Integer)
           523 => ( Parameter_Integer, 0 ),   --  : lnkref3 (Integer)
           524 => ( Parameter_Integer, 0 ),   --  : lnkref4 (Integer)
           525 => ( Parameter_Integer, 0 ),   --  : lnkref5 (Integer)
           526 => ( Parameter_Integer, 0 ),   --  : memschm (Integer)
           527 => ( Parameter_Integer, 0 ),   --  : pconsent (Integer)
           528 => ( Parameter_Integer, 0 ),   --  : perspen1 (Integer)
           529 => ( Parameter_Integer, 0 ),   --  : perspen2 (Integer)
           530 => ( Parameter_Integer, 0 ),   --  : privpen (Integer)
           531 => ( Parameter_Integer, 0 ),   --  : schchk (Integer)
           532 => ( Parameter_Integer, 0 ),   --  : spnumc (Integer)
           533 => ( Parameter_Integer, 0 ),   --  : stakep (Integer)
           534 => ( Parameter_Integer, 0 ),   --  : trainee (Integer)
           535 => ( Parameter_Integer, 0 ),   --  : lnkdwp (Integer)
           536 => ( Parameter_Integer, 0 ),   --  : lnkons (Integer)
           537 => ( Parameter_Integer, 0 ),   --  : lnkref6 (Integer)
           538 => ( Parameter_Integer, 0 ),   --  : lnkref7 (Integer)
           539 => ( Parameter_Integer, 0 ),   --  : lnkref8 (Integer)
           540 => ( Parameter_Integer, 0 ),   --  : lnkref9 (Integer)
           541 => ( Parameter_Integer, 0 ),   --  : tcever1 (Integer)
           542 => ( Parameter_Integer, 0 ),   --  : tcever2 (Integer)
           543 => ( Parameter_Integer, 0 ),   --  : tcrepay1 (Integer)
           544 => ( Parameter_Integer, 0 ),   --  : tcrepay2 (Integer)
           545 => ( Parameter_Integer, 0 ),   --  : tcrepay3 (Integer)
           546 => ( Parameter_Integer, 0 ),   --  : tcrepay4 (Integer)
           547 => ( Parameter_Integer, 0 ),   --  : tcrepay5 (Integer)
           548 => ( Parameter_Integer, 0 ),   --  : tcrepay6 (Integer)
           549 => ( Parameter_Integer, 0 ),   --  : tcthsyr1 (Integer)
           550 => ( Parameter_Integer, 0 ),   --  : tcthsyr2 (Integer)
           551 => ( Parameter_Integer, 0 ),   --  : currjobm (Integer)
           552 => ( Parameter_Integer, 0 ),   --  : prevjobm (Integer)
           553 => ( Parameter_Integer, 0 ),   --  : b3qfut7 (Integer)
           554 => ( Parameter_Integer, 0 ),   --  : ben3q7 (Integer)
           555 => ( Parameter_Integer, 0 ),   --  : camemt (Integer)
           556 => ( Parameter_Integer, 0 ),   --  : cameyr (Integer)
           557 => ( Parameter_Integer, 0 ),   --  : cameyr2 (Integer)
           558 => ( Parameter_Integer, 0 ),   --  : contuk (Integer)
           559 => ( Parameter_Integer, 0 ),   --  : corign (Integer)
           560 => ( Parameter_Integer, 0 ),   --  : ddaprog (Integer)
           561 => ( Parameter_Integer, 0 ),   --  : hbolng (Integer)
           562 => ( Parameter_Integer, 0 ),   --  : hi1qual1 (Integer)
           563 => ( Parameter_Integer, 0 ),   --  : hi1qual2 (Integer)
           564 => ( Parameter_Integer, 0 ),   --  : hi1qual3 (Integer)
           565 => ( Parameter_Integer, 0 ),   --  : hi1qual4 (Integer)
           566 => ( Parameter_Integer, 0 ),   --  : hi1qual5 (Integer)
           567 => ( Parameter_Integer, 0 ),   --  : hi1qual6 (Integer)
           568 => ( Parameter_Integer, 0 ),   --  : hi2qual (Integer)
           569 => ( Parameter_Integer, 0 ),   --  : hlpgvn01 (Integer)
           570 => ( Parameter_Integer, 0 ),   --  : hlpgvn02 (Integer)
           571 => ( Parameter_Integer, 0 ),   --  : hlpgvn03 (Integer)
           572 => ( Parameter_Integer, 0 ),   --  : hlpgvn04 (Integer)
           573 => ( Parameter_Integer, 0 ),   --  : hlpgvn05 (Integer)
           574 => ( Parameter_Integer, 0 ),   --  : hlpgvn06 (Integer)
           575 => ( Parameter_Integer, 0 ),   --  : hlpgvn07 (Integer)
           576 => ( Parameter_Integer, 0 ),   --  : hlpgvn08 (Integer)
           577 => ( Parameter_Integer, 0 ),   --  : hlpgvn09 (Integer)
           578 => ( Parameter_Integer, 0 ),   --  : hlpgvn10 (Integer)
           579 => ( Parameter_Integer, 0 ),   --  : hlpgvn11 (Integer)
           580 => ( Parameter_Integer, 0 ),   --  : hlprec01 (Integer)
           581 => ( Parameter_Integer, 0 ),   --  : hlprec02 (Integer)
           582 => ( Parameter_Integer, 0 ),   --  : hlprec03 (Integer)
           583 => ( Parameter_Integer, 0 ),   --  : hlprec04 (Integer)
           584 => ( Parameter_Integer, 0 ),   --  : hlprec05 (Integer)
           585 => ( Parameter_Integer, 0 ),   --  : hlprec06 (Integer)
           586 => ( Parameter_Integer, 0 ),   --  : hlprec07 (Integer)
           587 => ( Parameter_Integer, 0 ),   --  : hlprec08 (Integer)
           588 => ( Parameter_Integer, 0 ),   --  : hlprec09 (Integer)
           589 => ( Parameter_Integer, 0 ),   --  : hlprec10 (Integer)
           590 => ( Parameter_Integer, 0 ),   --  : hlprec11 (Integer)
           591 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           592 => ( Parameter_Integer, 0 ),   --  : loangvn1 (Integer)
           593 => ( Parameter_Integer, 0 ),   --  : loangvn2 (Integer)
           594 => ( Parameter_Integer, 0 ),   --  : loangvn3 (Integer)
           595 => ( Parameter_Integer, 0 ),   --  : loanrec1 (Integer)
           596 => ( Parameter_Integer, 0 ),   --  : loanrec2 (Integer)
           597 => ( Parameter_Integer, 0 ),   --  : loanrec3 (Integer)
           598 => ( Parameter_Integer, 0 ),   --  : mntarr1 (Integer)
           599 => ( Parameter_Integer, 0 ),   --  : mntarr2 (Integer)
           600 => ( Parameter_Integer, 0 ),   --  : mntarr3 (Integer)
           601 => ( Parameter_Integer, 0 ),   --  : mntarr4 (Integer)
           602 => ( Parameter_Integer, 0 ),   --  : mntnrp (Integer)
           603 => ( Parameter_Integer, 0 ),   --  : othqual1 (Integer)
           604 => ( Parameter_Integer, 0 ),   --  : othqual2 (Integer)
           605 => ( Parameter_Integer, 0 ),   --  : othqual3 (Integer)
           606 => ( Parameter_Integer, 0 ),   --  : tea9697 (Integer)
           607 => ( Parameter_Float, 0.0 ),   --  : heartval (Amount)
           608 => ( Parameter_Integer, 0 ),   --  : iagegr3 (Integer)
           609 => ( Parameter_Integer, 0 ),   --  : iagegr4 (Integer)
           610 => ( Parameter_Integer, 0 ),   --  : nirel2 (Integer)
           611 => ( Parameter_Integer, 0 ),   --  : xbonflag (Integer)
           612 => ( Parameter_Integer, 0 ),   --  : alg (Integer)
           613 => ( Parameter_Float, 0.0 ),   --  : algamt (Amount)
           614 => ( Parameter_Integer, 0 ),   --  : algpd (Integer)
           615 => ( Parameter_Integer, 0 ),   --  : ben4q4 (Integer)
           616 => ( Parameter_Integer, 0 ),   --  : chkctc (Integer)
           617 => ( Parameter_Integer, 0 ),   --  : chkdpco1 (Integer)
           618 => ( Parameter_Integer, 0 ),   --  : chkdpco2 (Integer)
           619 => ( Parameter_Integer, 0 ),   --  : chkdpco3 (Integer)
           620 => ( Parameter_Integer, 0 ),   --  : chkdsco1 (Integer)
           621 => ( Parameter_Integer, 0 ),   --  : chkdsco2 (Integer)
           622 => ( Parameter_Integer, 0 ),   --  : chkdsco3 (Integer)
           623 => ( Parameter_Integer, 0 ),   --  : dv09pens (Integer)
           624 => ( Parameter_Integer, 0 ),   --  : lnkref01 (Integer)
           625 => ( Parameter_Integer, 0 ),   --  : lnkref02 (Integer)
           626 => ( Parameter_Integer, 0 ),   --  : lnkref03 (Integer)
           627 => ( Parameter_Integer, 0 ),   --  : lnkref04 (Integer)
           628 => ( Parameter_Integer, 0 ),   --  : lnkref05 (Integer)
           629 => ( Parameter_Integer, 0 ),   --  : lnkref06 (Integer)
           630 => ( Parameter_Integer, 0 ),   --  : lnkref07 (Integer)
           631 => ( Parameter_Integer, 0 ),   --  : lnkref08 (Integer)
           632 => ( Parameter_Integer, 0 ),   --  : lnkref09 (Integer)
           633 => ( Parameter_Integer, 0 ),   --  : lnkref10 (Integer)
           634 => ( Parameter_Integer, 0 ),   --  : lnkref11 (Integer)
           635 => ( Parameter_Integer, 0 ),   --  : spyrot (Integer)
           636 => ( Parameter_Integer, 0 ),   --  : disdifad (Integer)
           637 => ( Parameter_Integer, 0 ),   --  : gross3_x (Integer)
           638 => ( Parameter_Float, 0.0 ),   --  : aliamt (Amount)
           639 => ( Parameter_Integer, 0 ),   --  : alimny (Integer)
           640 => ( Parameter_Integer, 0 ),   --  : alipd (Integer)
           641 => ( Parameter_Integer, 0 ),   --  : alius (Integer)
           642 => ( Parameter_Float, 0.0 ),   --  : aluamt (Amount)
           643 => ( Parameter_Integer, 0 ),   --  : alupd (Integer)
           644 => ( Parameter_Integer, 0 ),   --  : cbaamt (Integer)
           645 => ( Parameter_Integer, 0 ),   --  : hsvper (Integer)
           646 => ( Parameter_Integer, 0 ),   --  : mednum (Integer)
           647 => ( Parameter_Integer, 0 ),   --  : medprpd (Integer)
           648 => ( Parameter_Integer, 0 ),   --  : medprpy (Integer)
           649 => ( Parameter_Integer, 0 ),   --  : penflag (Integer)
           650 => ( Parameter_Integer, 0 ),   --  : ppchk1 (Integer)
           651 => ( Parameter_Integer, 0 ),   --  : ppchk2 (Integer)
           652 => ( Parameter_Integer, 0 ),   --  : ppchk3 (Integer)
           653 => ( Parameter_Float, 0.0 ),   --  : ttbprx (Amount)
           654 => ( Parameter_Integer, 0 ),   --  : mjobsect (Integer)
           655 => ( Parameter_Integer, 0 ),   --  : etngrp (Integer)
           656 => ( Parameter_Integer, 0 ),   --  : medpay (Integer)
           657 => ( Parameter_Integer, 0 ),   --  : medrep (Integer)
           658 => ( Parameter_Integer, 0 ),   --  : medrpnm (Integer)
           659 => ( Parameter_Integer, 0 ),   --  : nanid1 (Integer)
           660 => ( Parameter_Integer, 0 ),   --  : nanid2 (Integer)
           661 => ( Parameter_Integer, 0 ),   --  : nanid3 (Integer)
           662 => ( Parameter_Integer, 0 ),   --  : nanid4 (Integer)
           663 => ( Parameter_Integer, 0 ),   --  : nanid5 (Integer)
           664 => ( Parameter_Integer, 0 ),   --  : nanid6 (Integer)
           665 => ( Parameter_Integer, 0 ),   --  : nietngrp (Integer)
           666 => ( Parameter_Integer, 0 ),   --  : ninanid1 (Integer)
           667 => ( Parameter_Integer, 0 ),   --  : ninanid2 (Integer)
           668 => ( Parameter_Integer, 0 ),   --  : ninanid3 (Integer)
           669 => ( Parameter_Integer, 0 ),   --  : ninanid4 (Integer)
           670 => ( Parameter_Integer, 0 ),   --  : ninanid5 (Integer)
           671 => ( Parameter_Integer, 0 ),   --  : ninanid6 (Integer)
           672 => ( Parameter_Integer, 0 ),   --  : ninanid7 (Integer)
           673 => ( Parameter_Integer, 0 ),   --  : nirelig (Integer)
           674 => ( Parameter_Integer, 0 ),   --  : pollopin (Integer)
           675 => ( Parameter_Integer, 0 ),   --  : religenw (Integer)
           676 => ( Parameter_Integer, 0 ),   --  : religsc (Integer)
           677 => ( Parameter_Integer, 0 ),   --  : sidqn (Integer)
           678 => ( Parameter_Integer, 0 ),   --  : soc2010 (Integer)
           679 => ( Parameter_Integer, 0 ),   --  : corignan (Integer)
           680 => ( Parameter_Integer, 0 ),   --  : dobmonth (Integer)
           681 => ( Parameter_Integer, 0 ),   --  : dobyear (Integer)
           682 => ( Parameter_Integer, 0 ),   --  : ethgr3 (Integer)
           683 => ( Parameter_Integer, 0 ),   --  : ninanida (Integer)
           684 => ( Parameter_Integer, 0 ),   --  : agehqual (Integer)
           685 => ( Parameter_Integer, 0 ),   --  : bfd (Integer)
           686 => ( Parameter_Float, 0.0 ),   --  : bfdamt (Amount)
           687 => ( Parameter_Integer, 0 ),   --  : bfdpd (Integer)
           688 => ( Parameter_Integer, 0 ),   --  : bfdval (Integer)
           689 => ( Parameter_Integer, 0 ),   --  : btec (Integer)
           690 => ( Parameter_Integer, 0 ),   --  : btecnow (Integer)
           691 => ( Parameter_Integer, 0 ),   --  : cbaamt2 (Integer)
           692 => ( Parameter_Integer, 0 ),   --  : change (Integer)
           693 => ( Parameter_Integer, 0 ),   --  : citizen (Integer)
           694 => ( Parameter_Integer, 0 ),   --  : citizen2 (Integer)
           695 => ( Parameter_Integer, 0 ),   --  : condit (Integer)
           696 => ( Parameter_Integer, 0 ),   --  : corigoth (Integer)
           697 => ( Parameter_Integer, 0 ),   --  : curqual (Integer)
           698 => ( Parameter_Integer, 0 ),   --  : ddaprog1 (Integer)
           699 => ( Parameter_Integer, 0 ),   --  : ddatre1 (Integer)
           700 => ( Parameter_Integer, 0 ),   --  : ddatrep1 (Integer)
           701 => ( Parameter_Integer, 0 ),   --  : degree (Integer)
           702 => ( Parameter_Integer, 0 ),   --  : degrenow (Integer)
           703 => ( Parameter_Integer, 0 ),   --  : denrec (Integer)
           704 => ( Parameter_Integer, 0 ),   --  : disd01 (Integer)
           705 => ( Parameter_Integer, 0 ),   --  : disd02 (Integer)
           706 => ( Parameter_Integer, 0 ),   --  : disd03 (Integer)
           707 => ( Parameter_Integer, 0 ),   --  : disd04 (Integer)
           708 => ( Parameter_Integer, 0 ),   --  : disd05 (Integer)
           709 => ( Parameter_Integer, 0 ),   --  : disd06 (Integer)
           710 => ( Parameter_Integer, 0 ),   --  : disd07 (Integer)
           711 => ( Parameter_Integer, 0 ),   --  : disd08 (Integer)
           712 => ( Parameter_Integer, 0 ),   --  : disd09 (Integer)
           713 => ( Parameter_Integer, 0 ),   --  : disd10 (Integer)
           714 => ( Parameter_Integer, 0 ),   --  : disdifp1 (Integer)
           715 => ( Parameter_Integer, 0 ),   --  : empcontr (Integer)
           716 => ( Parameter_Integer, 0 ),   --  : ethgrps (Integer)
           717 => ( Parameter_Float, 0.0 ),   --  : eualiamt (Amount)
           718 => ( Parameter_Integer, 0 ),   --  : eualimny (Integer)
           719 => ( Parameter_Integer, 0 ),   --  : eualipd (Integer)
           720 => ( Parameter_Integer, 0 ),   --  : euetype (Integer)
           721 => ( Parameter_Integer, 0 ),   --  : followsc (Integer)
           722 => ( Parameter_Integer, 0 ),   --  : health1 (Integer)
           723 => ( Parameter_Integer, 0 ),   --  : heathad (Integer)
           724 => ( Parameter_Integer, 0 ),   --  : hi3qual (Integer)
           725 => ( Parameter_Integer, 0 ),   --  : higho (Integer)
           726 => ( Parameter_Integer, 0 ),   --  : highonow (Integer)
           727 => ( Parameter_Integer, 0 ),   --  : jobbyr (Integer)
           728 => ( Parameter_Integer, 0 ),   --  : limitl (Integer)
           729 => ( Parameter_Integer, 0 ),   --  : lktrain (Integer)
           730 => ( Parameter_Integer, 0 ),   --  : lkwork (Integer)
           731 => ( Parameter_Integer, 0 ),   --  : medrec (Integer)
           732 => ( Parameter_Integer, 0 ),   --  : nvqlenow (Integer)
           733 => ( Parameter_Integer, 0 ),   --  : nvqlev (Integer)
           734 => ( Parameter_Integer, 0 ),   --  : othpass (Integer)
           735 => ( Parameter_Integer, 0 ),   --  : ppper (Integer)
           736 => ( Parameter_Float, 0.0 ),   --  : proptax (Amount)
           737 => ( Parameter_Integer, 0 ),   --  : reasden (Integer)
           738 => ( Parameter_Integer, 0 ),   --  : reasmed (Integer)
           739 => ( Parameter_Integer, 0 ),   --  : reasnhs (Integer)
           740 => ( Parameter_Integer, 0 ),   --  : reason (Integer)
           741 => ( Parameter_Integer, 0 ),   --  : rednet (Integer)
           742 => ( Parameter_Float, 0.0 ),   --  : redtax (Amount)
           743 => ( Parameter_Integer, 0 ),   --  : rsa (Integer)
           744 => ( Parameter_Integer, 0 ),   --  : rsanow (Integer)
           745 => ( Parameter_Integer, 0 ),   --  : samesit (Integer)
           746 => ( Parameter_Integer, 0 ),   --  : scotvec (Integer)
           747 => ( Parameter_Integer, 0 ),   --  : sctvnow (Integer)
           748 => ( Parameter_Integer, 0 ),   --  : sdemp01 (Integer)
           749 => ( Parameter_Integer, 0 ),   --  : sdemp02 (Integer)
           750 => ( Parameter_Integer, 0 ),   --  : sdemp03 (Integer)
           751 => ( Parameter_Integer, 0 ),   --  : sdemp04 (Integer)
           752 => ( Parameter_Integer, 0 ),   --  : sdemp05 (Integer)
           753 => ( Parameter_Integer, 0 ),   --  : sdemp06 (Integer)
           754 => ( Parameter_Integer, 0 ),   --  : sdemp07 (Integer)
           755 => ( Parameter_Integer, 0 ),   --  : sdemp08 (Integer)
           756 => ( Parameter_Integer, 0 ),   --  : sdemp09 (Integer)
           757 => ( Parameter_Integer, 0 ),   --  : sdemp10 (Integer)
           758 => ( Parameter_Integer, 0 ),   --  : sdemp11 (Integer)
           759 => ( Parameter_Integer, 0 ),   --  : sdemp12 (Integer)
           760 => ( Parameter_Integer, 0 ),   --  : selfdemp (Integer)
           761 => ( Parameter_Integer, 0 ),   --  : tempjob (Integer)
           762 => ( Parameter_Integer, 0 ),   --  : agehq80 (Integer)
           763 => ( Parameter_Integer, 0 ),   --  : disacta1 (Integer)
           764 => ( Parameter_Integer, 0 ),   --  : discora1 (Integer)
           765 => ( Parameter_Integer, 0 ),   --  : gross4 (Integer)
           766 => ( Parameter_Integer, 0 ),   --  : ninrinc (Integer)
           767 => ( Parameter_Integer, 0 ),   --  : typeed2 (Integer)
           768 => ( Parameter_Integer, 0 ),   --  : w45 (Integer)
           769 => ( Parameter_Integer, 0 ),   --  : accmsat (Integer)
           770 => ( Parameter_Integer, 0 ),   --  : c2orign (Integer)
           771 => ( Parameter_Integer, 0 ),   --  : calm (Integer)
           772 => ( Parameter_Integer, 0 ),   --  : cbchk (Integer)
           773 => ( Parameter_Integer, 0 ),   --  : claifut1 (Integer)
           774 => ( Parameter_Integer, 0 ),   --  : claifut2 (Integer)
           775 => ( Parameter_Integer, 0 ),   --  : claifut3 (Integer)
           776 => ( Parameter_Integer, 0 ),   --  : claifut4 (Integer)
           777 => ( Parameter_Integer, 0 ),   --  : claifut5 (Integer)
           778 => ( Parameter_Integer, 0 ),   --  : claifut6 (Integer)
           779 => ( Parameter_Integer, 0 ),   --  : claifut7 (Integer)
           780 => ( Parameter_Integer, 0 ),   --  : claifut8 (Integer)
           781 => ( Parameter_Integer, 0 ),   --  : commusat (Integer)
           782 => ( Parameter_Integer, 0 ),   --  : coptrust (Integer)
           783 => ( Parameter_Integer, 0 ),   --  : depress (Integer)
           784 => ( Parameter_Integer, 0 ),   --  : disben1 (Integer)
           785 => ( Parameter_Integer, 0 ),   --  : disben2 (Integer)
           786 => ( Parameter_Integer, 0 ),   --  : disben3 (Integer)
           787 => ( Parameter_Integer, 0 ),   --  : disben4 (Integer)
           788 => ( Parameter_Integer, 0 ),   --  : disben5 (Integer)
           789 => ( Parameter_Integer, 0 ),   --  : disben6 (Integer)
           790 => ( Parameter_Integer, 0 ),   --  : discuss (Integer)
           791 => ( Parameter_Integer, 0 ),   --  : dla1 (Integer)
           792 => ( Parameter_Integer, 0 ),   --  : dla2 (Integer)
           793 => ( Parameter_Integer, 0 ),   --  : dls (Integer)
           794 => ( Parameter_Float, 0.0 ),   --  : dlsamt (Amount)
           795 => ( Parameter_Integer, 0 ),   --  : dlspd (Integer)
           796 => ( Parameter_Integer, 0 ),   --  : dlsval (Integer)
           797 => ( Parameter_Integer, 0 ),   --  : down (Integer)
           798 => ( Parameter_Integer, 0 ),   --  : envirsat (Integer)
           799 => ( Parameter_Integer, 0 ),   --  : gpispc (Integer)
           800 => ( Parameter_Integer, 0 ),   --  : gpjsaesa (Integer)
           801 => ( Parameter_Integer, 0 ),   --  : happy (Integer)
           802 => ( Parameter_Integer, 0 ),   --  : help (Integer)
           803 => ( Parameter_Integer, 0 ),   --  : iclaim1 (Integer)
           804 => ( Parameter_Integer, 0 ),   --  : iclaim2 (Integer)
           805 => ( Parameter_Integer, 0 ),   --  : iclaim3 (Integer)
           806 => ( Parameter_Integer, 0 ),   --  : iclaim4 (Integer)
           807 => ( Parameter_Integer, 0 ),   --  : iclaim5 (Integer)
           808 => ( Parameter_Integer, 0 ),   --  : iclaim6 (Integer)
           809 => ( Parameter_Integer, 0 ),   --  : iclaim7 (Integer)
           810 => ( Parameter_Integer, 0 ),   --  : iclaim8 (Integer)
           811 => ( Parameter_Integer, 0 ),   --  : iclaim9 (Integer)
           812 => ( Parameter_Integer, 0 ),   --  : jobsat (Integer)
           813 => ( Parameter_Integer, 0 ),   --  : kidben1 (Integer)
           814 => ( Parameter_Integer, 0 ),   --  : kidben2 (Integer)
           815 => ( Parameter_Integer, 0 ),   --  : kidben3 (Integer)
           816 => ( Parameter_Integer, 0 ),   --  : legltrus (Integer)
           817 => ( Parameter_Integer, 0 ),   --  : lifesat (Integer)
           818 => ( Parameter_Integer, 0 ),   --  : meaning (Integer)
           819 => ( Parameter_Integer, 0 ),   --  : moneysat (Integer)
           820 => ( Parameter_Integer, 0 ),   --  : nervous (Integer)
           821 => ( Parameter_Integer, 0 ),   --  : ni2train (Integer)
           822 => ( Parameter_Integer, 0 ),   --  : othben1 (Integer)
           823 => ( Parameter_Integer, 0 ),   --  : othben2 (Integer)
           824 => ( Parameter_Integer, 0 ),   --  : othben3 (Integer)
           825 => ( Parameter_Integer, 0 ),   --  : othben4 (Integer)
           826 => ( Parameter_Integer, 0 ),   --  : othben5 (Integer)
           827 => ( Parameter_Integer, 0 ),   --  : othben6 (Integer)
           828 => ( Parameter_Integer, 0 ),   --  : othtrust (Integer)
           829 => ( Parameter_Integer, 0 ),   --  : penben1 (Integer)
           830 => ( Parameter_Integer, 0 ),   --  : penben2 (Integer)
           831 => ( Parameter_Integer, 0 ),   --  : penben3 (Integer)
           832 => ( Parameter_Integer, 0 ),   --  : penben4 (Integer)
           833 => ( Parameter_Integer, 0 ),   --  : penben5 (Integer)
           834 => ( Parameter_Integer, 0 ),   --  : pip1 (Integer)
           835 => ( Parameter_Integer, 0 ),   --  : pip2 (Integer)
           836 => ( Parameter_Integer, 0 ),   --  : polttrus (Integer)
           837 => ( Parameter_Integer, 0 ),   --  : recsat (Integer)
           838 => ( Parameter_Integer, 0 ),   --  : relasat (Integer)
           839 => ( Parameter_Integer, 0 ),   --  : safe (Integer)
           840 => ( Parameter_Integer, 0 ),   --  : socfund1 (Integer)
           841 => ( Parameter_Integer, 0 ),   --  : socfund2 (Integer)
           842 => ( Parameter_Integer, 0 ),   --  : socfund3 (Integer)
           843 => ( Parameter_Integer, 0 ),   --  : socfund4 (Integer)
           844 => ( Parameter_Integer, 0 ),   --  : srispc (Integer)
           845 => ( Parameter_Integer, 0 ),   --  : srjsaesa (Integer)
           846 => ( Parameter_Integer, 0 ),   --  : timesat (Integer)
           847 => ( Parameter_Integer, 0 ),   --  : train2 (Integer)
           848 => ( Parameter_Integer, 0 ),   --  : trnallow (Integer)
           849 => ( Parameter_Integer, 0 ),   --  : wageben1 (Integer)
           850 => ( Parameter_Integer, 0 ),   --  : wageben2 (Integer)
           851 => ( Parameter_Integer, 0 ),   --  : wageben3 (Integer)
           852 => ( Parameter_Integer, 0 ),   --  : wageben4 (Integer)
           853 => ( Parameter_Integer, 0 ),   --  : wageben5 (Integer)
           854 => ( Parameter_Integer, 0 ),   --  : wageben6 (Integer)
           855 => ( Parameter_Integer, 0 ),   --  : wageben7 (Integer)
           856 => ( Parameter_Integer, 0 ),   --  : wageben8 (Integer)
           857 => ( Parameter_Integer, 0 ),   --  : ninnirbn (Integer)
           858 => ( Parameter_Integer, 0 ),   --  : ninothbn (Integer)
           859 => ( Parameter_Integer, 0 ),   --  : anxious (Integer)
           860 => ( Parameter_Integer, 0 ),   --  : candgnow (Integer)
           861 => ( Parameter_Integer, 0 ),   --  : curothf (Integer)
           862 => ( Parameter_Integer, 0 ),   --  : curothp (Integer)
           863 => ( Parameter_Integer, 0 ),   --  : curothwv (Integer)
           864 => ( Parameter_Integer, 0 ),   --  : dvhiqual (Integer)
           865 => ( Parameter_Integer, 0 ),   --  : gnvqnow (Integer)
           866 => ( Parameter_Integer, 0 ),   --  : gpuc (Integer)
           867 => ( Parameter_Integer, 0 ),   --  : happywb (Integer)
           868 => ( Parameter_Integer, 0 ),   --  : hi1qual7 (Integer)
           869 => ( Parameter_Integer, 0 ),   --  : hi1qual8 (Integer)
           870 => ( Parameter_Integer, 0 ),   --  : mntarr5 (Integer)
           871 => ( Parameter_Integer, 0 ),   --  : mntnoch1 (Integer)
           872 => ( Parameter_Integer, 0 ),   --  : mntnoch2 (Integer)
           873 => ( Parameter_Integer, 0 ),   --  : mntnoch3 (Integer)
           874 => ( Parameter_Integer, 0 ),   --  : mntnoch4 (Integer)
           875 => ( Parameter_Integer, 0 ),   --  : mntnoch5 (Integer)
           876 => ( Parameter_Integer, 0 ),   --  : mntpro1 (Integer)
           877 => ( Parameter_Integer, 0 ),   --  : mntpro2 (Integer)
           878 => ( Parameter_Integer, 0 ),   --  : mntpro3 (Integer)
           879 => ( Parameter_Integer, 0 ),   --  : mnttim1 (Integer)
           880 => ( Parameter_Integer, 0 ),   --  : mnttim2 (Integer)
           881 => ( Parameter_Integer, 0 ),   --  : mnttim3 (Integer)
           882 => ( Parameter_Integer, 0 ),   --  : mntwrk1 (Integer)
           883 => ( Parameter_Integer, 0 ),   --  : mntwrk2 (Integer)
           884 => ( Parameter_Integer, 0 ),   --  : mntwrk3 (Integer)
           885 => ( Parameter_Integer, 0 ),   --  : mntwrk4 (Integer)
           886 => ( Parameter_Integer, 0 ),   --  : mntwrk5 (Integer)
           887 => ( Parameter_Integer, 0 ),   --  : ndeplnow (Integer)
           888 => ( Parameter_Integer, 0 ),   --  : oqualc1 (Integer)
           889 => ( Parameter_Integer, 0 ),   --  : oqualc2 (Integer)
           890 => ( Parameter_Integer, 0 ),   --  : oqualc3 (Integer)
           891 => ( Parameter_Integer, 0 ),   --  : sruc (Integer)
           892 => ( Parameter_Integer, 0 ),   --  : webacnow (Integer)
           893 => ( Parameter_Integer, 0 ),   --  : indeth (Integer)
           894 => ( Parameter_Integer, 0 ),   --  : euactive (Integer)
           895 => ( Parameter_Integer, 0 ),   --  : euactno (Integer)
           896 => ( Parameter_Integer, 0 ),   --  : euartact (Integer)
           897 => ( Parameter_Integer, 0 ),   --  : euaskhlp (Integer)
           898 => ( Parameter_Integer, 0 ),   --  : eucinema (Integer)
           899 => ( Parameter_Integer, 0 ),   --  : eucultur (Integer)
           900 => ( Parameter_Integer, 0 ),   --  : euinvol (Integer)
           901 => ( Parameter_Integer, 0 ),   --  : eulivpe (Integer)
           902 => ( Parameter_Integer, 0 ),   --  : eumtfam (Integer)
           903 => ( Parameter_Integer, 0 ),   --  : eumtfrnd (Integer)
           904 => ( Parameter_Integer, 0 ),   --  : eusocnet (Integer)
           905 => ( Parameter_Integer, 0 ),   --  : eusport (Integer)
           906 => ( Parameter_Integer, 0 ),   --  : eutkfam (Integer)
           907 => ( Parameter_Integer, 0 ),   --  : eutkfrnd (Integer)
           908 => ( Parameter_Integer, 0 ),   --  : eutkmat (Integer)
           909 => ( Parameter_Integer, 0 ),   --  : euvol (Integer)
           910 => ( Parameter_Integer, 0 ),   --  : natscot (Integer)
           911 => ( Parameter_Integer, 0 ),   --  : ntsctnow (Integer)
           912 => ( Parameter_Integer, 0 ),   --  : penwel1 (Integer)
           913 => ( Parameter_Integer, 0 ),   --  : penwel2 (Integer)
           914 => ( Parameter_Integer, 0 ),   --  : penwel3 (Integer)
           915 => ( Parameter_Integer, 0 ),   --  : penwel4 (Integer)
           916 => ( Parameter_Integer, 0 ),   --  : penwel5 (Integer)
           917 => ( Parameter_Integer, 0 ),   --  : penwel6 (Integer)
           918 => ( Parameter_Integer, 0 ),   --  : skiwknow (Integer)
           919 => ( Parameter_Integer, 0 ),   --  : skiwrk (Integer)
           920 => ( Parameter_Integer, 0 ),   --  : slos (Integer)
           921 => ( Parameter_Integer, 0 ),   --  : yjblev (Integer)
           922 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
           923 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
           924 => ( Parameter_Integer, 0 ),   --  : year (Integer)
           925 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
           926 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
           927 => ( Parameter_Integer, 0 )   --  : person (Integer)
      ) else (
            1 => ( Parameter_Integer, 0 ),   --  : user_id (Integer)
            2 => ( Parameter_Integer, 0 ),   --  : edition (Integer)
            3 => ( Parameter_Integer, 0 ),   --  : year (Integer)
            4 => ( Parameter_Bigint, 0 ),   --  : sernum (Sernum_Value)
            5 => ( Parameter_Integer, 0 ),   --  : benunit (Integer)
            6 => ( Parameter_Integer, 0 ),   --  : person (Integer)
            7 => ( Parameter_Integer, 0 ),   --  : abs1no (Integer)
            8 => ( Parameter_Integer, 0 ),   --  : abs2no (Integer)
            9 => ( Parameter_Integer, 0 ),   --  : abspar (Integer)
           10 => ( Parameter_Integer, 0 ),   --  : abspay (Integer)
           11 => ( Parameter_Integer, 0 ),   --  : abswhy (Integer)
           12 => ( Parameter_Integer, 0 ),   --  : abswk (Integer)
           13 => ( Parameter_Integer, 0 ),   --  : x_access (Integer)
           14 => ( Parameter_Integer, 0 ),   --  : accftpt (Integer)
           15 => ( Parameter_Integer, 0 ),   --  : accjb (Integer)
           16 => ( Parameter_Float, 0.0 ),   --  : accssamt (Amount)
           17 => ( Parameter_Integer, 0 ),   --  : accsspd (Integer)
           18 => ( Parameter_Integer, 0 ),   --  : adeduc (Integer)
           19 => ( Parameter_Integer, 0 ),   --  : adema (Integer)
           20 => ( Parameter_Float, 0.0 ),   --  : ademaamt (Amount)
           21 => ( Parameter_Integer, 0 ),   --  : ademapd (Integer)
           22 => ( Parameter_Integer, 0 ),   --  : age (Integer)
           23 => ( Parameter_Integer, 0 ),   --  : allow1 (Integer)
           24 => ( Parameter_Integer, 0 ),   --  : allow2 (Integer)
           25 => ( Parameter_Integer, 0 ),   --  : allow3 (Integer)
           26 => ( Parameter_Integer, 0 ),   --  : allow4 (Integer)
           27 => ( Parameter_Float, 0.0 ),   --  : allpay1 (Amount)
           28 => ( Parameter_Float, 0.0 ),   --  : allpay2 (Amount)
           29 => ( Parameter_Float, 0.0 ),   --  : allpay3 (Amount)
           30 => ( Parameter_Float, 0.0 ),   --  : allpay4 (Amount)
           31 => ( Parameter_Integer, 0 ),   --  : allpd1 (Integer)
           32 => ( Parameter_Integer, 0 ),   --  : allpd2 (Integer)
           33 => ( Parameter_Integer, 0 ),   --  : allpd3 (Integer)
           34 => ( Parameter_Integer, 0 ),   --  : allpd4 (Integer)
           35 => ( Parameter_Integer, 0 ),   --  : anyacc (Integer)
           36 => ( Parameter_Integer, 0 ),   --  : anyed (Integer)
           37 => ( Parameter_Integer, 0 ),   --  : anymon (Integer)
           38 => ( Parameter_Integer, 0 ),   --  : anypen1 (Integer)
           39 => ( Parameter_Integer, 0 ),   --  : anypen2 (Integer)
           40 => ( Parameter_Integer, 0 ),   --  : anypen3 (Integer)
           41 => ( Parameter_Integer, 0 ),   --  : anypen4 (Integer)
           42 => ( Parameter_Integer, 0 ),   --  : anypen5 (Integer)
           43 => ( Parameter_Integer, 0 ),   --  : anypen6 (Integer)
           44 => ( Parameter_Integer, 0 ),   --  : anypen7 (Integer)
           45 => ( Parameter_Float, 0.0 ),   --  : apamt (Amount)
           46 => ( Parameter_Float, 0.0 ),   --  : apdamt (Amount)
           47 => ( Parameter_Integer, 0 ),   --  : apdir (Integer)
           48 => ( Parameter_Integer, 0 ),   --  : apdpd (Integer)
           49 => ( Parameter_Integer, 0 ),   --  : appd (Integer)
           50 => ( Parameter_Integer, 0 ),   --  : b2qfut1 (Integer)
           51 => ( Parameter_Integer, 0 ),   --  : b2qfut2 (Integer)
           52 => ( Parameter_Integer, 0 ),   --  : b2qfut3 (Integer)
           53 => ( Parameter_Integer, 0 ),   --  : b3qfut1 (Integer)
           54 => ( Parameter_Integer, 0 ),   --  : b3qfut2 (Integer)
           55 => ( Parameter_Integer, 0 ),   --  : b3qfut3 (Integer)
           56 => ( Parameter_Integer, 0 ),   --  : b3qfut4 (Integer)
           57 => ( Parameter_Integer, 0 ),   --  : b3qfut5 (Integer)
           58 => ( Parameter_Integer, 0 ),   --  : b3qfut6 (Integer)
           59 => ( Parameter_Integer, 0 ),   --  : ben1q1 (Integer)
           60 => ( Parameter_Integer, 0 ),   --  : ben1q2 (Integer)
           61 => ( Parameter_Integer, 0 ),   --  : ben1q3 (Integer)
           62 => ( Parameter_Integer, 0 ),   --  : ben1q4 (Integer)
           63 => ( Parameter_Integer, 0 ),   --  : ben1q5 (Integer)
           64 => ( Parameter_Integer, 0 ),   --  : ben1q6 (Integer)
           65 => ( Parameter_Integer, 0 ),   --  : ben1q7 (Integer)
           66 => ( Parameter_Integer, 0 ),   --  : ben2q1 (Integer)
           67 => ( Parameter_Integer, 0 ),   --  : ben2q2 (Integer)
           68 => ( Parameter_Integer, 0 ),   --  : ben2q3 (Integer)
           69 => ( Parameter_Integer, 0 ),   --  : ben3q1 (Integer)
           70 => ( Parameter_Integer, 0 ),   --  : ben3q2 (Integer)
           71 => ( Parameter_Integer, 0 ),   --  : ben3q3 (Integer)
           72 => ( Parameter_Integer, 0 ),   --  : ben3q4 (Integer)
           73 => ( Parameter_Integer, 0 ),   --  : ben3q5 (Integer)
           74 => ( Parameter_Integer, 0 ),   --  : ben3q6 (Integer)
           75 => ( Parameter_Integer, 0 ),   --  : ben4q1 (Integer)
           76 => ( Parameter_Integer, 0 ),   --  : ben4q2 (Integer)
           77 => ( Parameter_Integer, 0 ),   --  : ben4q3 (Integer)
           78 => ( Parameter_Integer, 0 ),   --  : ben5q1 (Integer)
           79 => ( Parameter_Integer, 0 ),   --  : ben5q2 (Integer)
           80 => ( Parameter_Integer, 0 ),   --  : ben5q3 (Integer)
           81 => ( Parameter_Integer, 0 ),   --  : ben5q4 (Integer)
           82 => ( Parameter_Integer, 0 ),   --  : ben5q5 (Integer)
           83 => ( Parameter_Integer, 0 ),   --  : ben5q6 (Integer)
           84 => ( Parameter_Integer, 0 ),   --  : ben7q1 (Integer)
           85 => ( Parameter_Integer, 0 ),   --  : ben7q2 (Integer)
           86 => ( Parameter_Integer, 0 ),   --  : ben7q3 (Integer)
           87 => ( Parameter_Integer, 0 ),   --  : ben7q4 (Integer)
           88 => ( Parameter_Integer, 0 ),   --  : ben7q5 (Integer)
           89 => ( Parameter_Integer, 0 ),   --  : ben7q6 (Integer)
           90 => ( Parameter_Integer, 0 ),   --  : ben7q7 (Integer)
           91 => ( Parameter_Integer, 0 ),   --  : ben7q8 (Integer)
           92 => ( Parameter_Integer, 0 ),   --  : ben7q9 (Integer)
           93 => ( Parameter_Integer, 0 ),   --  : btwacc (Integer)
           94 => ( Parameter_Integer, 0 ),   --  : claimant (Integer)
           95 => ( Parameter_Integer, 0 ),   --  : cohabit (Integer)
           96 => ( Parameter_Integer, 0 ),   --  : combid (Integer)
           97 => ( Parameter_Integer, 0 ),   --  : convbl (Integer)
           98 => ( Parameter_Integer, 0 ),   --  : ctclum1 (Integer)
           99 => ( Parameter_Integer, 0 ),   --  : ctclum2 (Integer)
           100 => ( Parameter_Integer, 0 ),   --  : cupchk (Integer)
           101 => ( Parameter_Integer, 0 ),   --  : cvht (Integer)
           102 => ( Parameter_Float, 0.0 ),   --  : cvpay (Amount)
           103 => ( Parameter_Integer, 0 ),   --  : cvpd (Integer)
           104 => ( Parameter_Integer, 0 ),   --  : dentist (Integer)
           105 => ( Parameter_Integer, 0 ),   --  : depend (Integer)
           106 => ( Parameter_Integer, 0 ),   --  : disdif1 (Integer)
           107 => ( Parameter_Integer, 0 ),   --  : disdif2 (Integer)
           108 => ( Parameter_Integer, 0 ),   --  : disdif3 (Integer)
           109 => ( Parameter_Integer, 0 ),   --  : disdif4 (Integer)
           110 => ( Parameter_Integer, 0 ),   --  : disdif5 (Integer)
           111 => ( Parameter_Integer, 0 ),   --  : disdif6 (Integer)
           112 => ( Parameter_Integer, 0 ),   --  : disdif7 (Integer)
           113 => ( Parameter_Integer, 0 ),   --  : disdif8 (Integer)
           114 => ( Parameter_Date, Clock ),   --  : dob (Ada.Calendar.Time)
           115 => ( Parameter_Integer, 0 ),   --  : dptcboth (Integer)
           116 => ( Parameter_Integer, 0 ),   --  : dptclum (Integer)
           117 => ( Parameter_Integer, 0 ),   --  : dvil03a (Integer)
           118 => ( Parameter_Integer, 0 ),   --  : dvil04a (Integer)
           119 => ( Parameter_Integer, 0 ),   --  : dvjb12ml (Integer)
           120 => ( Parameter_Integer, 0 ),   --  : dvmardf (Integer)
           121 => ( Parameter_Float, 0.0 ),   --  : ed1amt (Amount)
           122 => ( Parameter_Integer, 0 ),   --  : ed1borr (Integer)
           123 => ( Parameter_Integer, 0 ),   --  : ed1int (Integer)
           124 => ( Parameter_Date, Clock ),   --  : ed1monyr (Ada.Calendar.Time)
           125 => ( Parameter_Integer, 0 ),   --  : ed1pd (Integer)
           126 => ( Parameter_Integer, 0 ),   --  : ed1sum (Integer)
           127 => ( Parameter_Float, 0.0 ),   --  : ed2amt (Amount)
           128 => ( Parameter_Integer, 0 ),   --  : ed2borr (Integer)
           129 => ( Parameter_Integer, 0 ),   --  : ed2int (Integer)
           130 => ( Parameter_Date, Clock ),   --  : ed2monyr (Ada.Calendar.Time)
           131 => ( Parameter_Integer, 0 ),   --  : ed2pd (Integer)
           132 => ( Parameter_Integer, 0 ),   --  : ed2sum (Integer)
           133 => ( Parameter_Integer, 0 ),   --  : edatt (Integer)
           134 => ( Parameter_Integer, 0 ),   --  : edattn1 (Integer)
           135 => ( Parameter_Integer, 0 ),   --  : edattn2 (Integer)
           136 => ( Parameter_Integer, 0 ),   --  : edattn3 (Integer)
           137 => ( Parameter_Integer, 0 ),   --  : edhr (Integer)
           138 => ( Parameter_Integer, 0 ),   --  : edtime (Integer)
           139 => ( Parameter_Integer, 0 ),   --  : edtyp (Integer)
           140 => ( Parameter_Integer, 0 ),   --  : eligadlt (Integer)
           141 => ( Parameter_Integer, 0 ),   --  : eligchld (Integer)
           142 => ( Parameter_Integer, 0 ),   --  : emppay1 (Integer)
           143 => ( Parameter_Integer, 0 ),   --  : emppay2 (Integer)
           144 => ( Parameter_Integer, 0 ),   --  : emppay3 (Integer)
           145 => ( Parameter_Integer, 0 ),   --  : empstat (Integer)
           146 => ( Parameter_Integer, 0 ),   --  : endyr (Integer)
           147 => ( Parameter_Integer, 0 ),   --  : epcur (Integer)
           148 => ( Parameter_Integer, 0 ),   --  : es2000 (Integer)
           149 => ( Parameter_Integer, 0 ),   --  : ethgrp (Integer)
           150 => ( Parameter_Integer, 0 ),   --  : everwrk (Integer)
           151 => ( Parameter_Integer, 0 ),   --  : exthbct1 (Integer)
           152 => ( Parameter_Integer, 0 ),   --  : exthbct2 (Integer)
           153 => ( Parameter_Integer, 0 ),   --  : exthbct3 (Integer)
           154 => ( Parameter_Integer, 0 ),   --  : eyetest (Integer)
           155 => ( Parameter_Integer, 0 ),   --  : follow (Integer)
           156 => ( Parameter_Integer, 0 ),   --  : fted (Integer)
           157 => ( Parameter_Integer, 0 ),   --  : ftwk (Integer)
           158 => ( Parameter_Integer, 0 ),   --  : future (Integer)
           159 => ( Parameter_Integer, 0 ),   --  : govpis (Integer)
           160 => ( Parameter_Integer, 0 ),   --  : govpjsa (Integer)
           161 => ( Parameter_Integer, 0 ),   --  : x_grant (Integer)
           162 => ( Parameter_Float, 0.0 ),   --  : grtamt1 (Amount)
           163 => ( Parameter_Float, 0.0 ),   --  : grtamt2 (Amount)
           164 => ( Parameter_Float, 0.0 ),   --  : grtdir1 (Amount)
           165 => ( Parameter_Float, 0.0 ),   --  : grtdir2 (Amount)
           166 => ( Parameter_Integer, 0 ),   --  : grtnum (Integer)
           167 => ( Parameter_Integer, 0 ),   --  : grtsce1 (Integer)
           168 => ( Parameter_Integer, 0 ),   --  : grtsce2 (Integer)
           169 => ( Parameter_Float, 0.0 ),   --  : grtval1 (Amount)
           170 => ( Parameter_Float, 0.0 ),   --  : grtval2 (Amount)
           171 => ( Parameter_Integer, 0 ),   --  : gta (Integer)
           172 => ( Parameter_Float, 0.0 ),   --  : hbothamt (Amount)
           173 => ( Parameter_Integer, 0 ),   --  : hbothbu (Integer)
           174 => ( Parameter_Integer, 0 ),   --  : hbothpd (Integer)
           175 => ( Parameter_Integer, 0 ),   --  : hbothwk (Integer)
           176 => ( Parameter_Integer, 0 ),   --  : hbotwait (Integer)
           177 => ( Parameter_Integer, 0 ),   --  : health (Integer)
           178 => ( Parameter_Integer, 0 ),   --  : hholder (Integer)
           179 => ( Parameter_Integer, 0 ),   --  : hosp (Integer)
           180 => ( Parameter_Integer, 0 ),   --  : hprob (Integer)
           181 => ( Parameter_Integer, 0 ),   --  : hrpid (Integer)
           182 => ( Parameter_Integer, 0 ),   --  : incdur (Integer)
           183 => ( Parameter_Integer, 0 ),   --  : injlong (Integer)
           184 => ( Parameter_Integer, 0 ),   --  : injwk (Integer)
           185 => ( Parameter_Integer, 0 ),   --  : invests (Integer)
           186 => ( Parameter_Integer, 0 ),   --  : iout (Integer)
           187 => ( Parameter_Integer, 0 ),   --  : isa1type (Integer)
           188 => ( Parameter_Integer, 0 ),   --  : isa2type (Integer)
           189 => ( Parameter_Integer, 0 ),   --  : isa3type (Integer)
           190 => ( Parameter_Integer, 0 ),   --  : jobaway (Integer)
           191 => ( Parameter_Integer, 0 ),   --  : lareg (Integer)
           192 => ( Parameter_Integer, 0 ),   --  : likewk (Integer)
           193 => ( Parameter_Integer, 0 ),   --  : lktime (Integer)
           194 => ( Parameter_Integer, 0 ),   --  : ln1rpint (Integer)
           195 => ( Parameter_Integer, 0 ),   --  : ln2rpint (Integer)
           196 => ( Parameter_Integer, 0 ),   --  : loan (Integer)
           197 => ( Parameter_Integer, 0 ),   --  : loannum (Integer)
           198 => ( Parameter_Integer, 0 ),   --  : look (Integer)
           199 => ( Parameter_Integer, 0 ),   --  : lookwk (Integer)
           200 => ( Parameter_Integer, 0 ),   --  : lstwrk1 (Integer)
           201 => ( Parameter_Integer, 0 ),   --  : lstwrk2 (Integer)
           202 => ( Parameter_Integer, 0 ),   --  : lstyr (Integer)
           203 => ( Parameter_Float, 0.0 ),   --  : mntamt1 (Amount)
           204 => ( Parameter_Float, 0.0 ),   --  : mntamt2 (Amount)
           205 => ( Parameter_Integer, 0 ),   --  : mntct (Integer)
           206 => ( Parameter_Integer, 0 ),   --  : mntfor1 (Integer)
           207 => ( Parameter_Integer, 0 ),   --  : mntfor2 (Integer)
           208 => ( Parameter_Integer, 0 ),   --  : mntgov1 (Integer)
           209 => ( Parameter_Integer, 0 ),   --  : mntgov2 (Integer)
           210 => ( Parameter_Integer, 0 ),   --  : mntpay (Integer)
           211 => ( Parameter_Integer, 0 ),   --  : mntpd1 (Integer)
           212 => ( Parameter_Integer, 0 ),   --  : mntpd2 (Integer)
           213 => ( Parameter_Integer, 0 ),   --  : mntrec (Integer)
           214 => ( Parameter_Integer, 0 ),   --  : mnttota1 (Integer)
           215 => ( Parameter_Integer, 0 ),   --  : mnttota2 (Integer)
           216 => ( Parameter_Integer, 0 ),   --  : mntus1 (Integer)
           217 => ( Parameter_Integer, 0 ),   --  : mntus2 (Integer)
           218 => ( Parameter_Float, 0.0 ),   --  : mntusam1 (Amount)
           219 => ( Parameter_Float, 0.0 ),   --  : mntusam2 (Amount)
           220 => ( Parameter_Integer, 0 ),   --  : mntuspd1 (Integer)
           221 => ( Parameter_Integer, 0 ),   --  : mntuspd2 (Integer)
           222 => ( Parameter_Integer, 0 ),   --  : ms (Integer)
           223 => ( Parameter_Integer, 0 ),   --  : natid1 (Integer)
           224 => ( Parameter_Integer, 0 ),   --  : natid2 (Integer)
           225 => ( Parameter_Integer, 0 ),   --  : natid3 (Integer)
           226 => ( Parameter_Integer, 0 ),   --  : natid4 (Integer)
           227 => ( Parameter_Integer, 0 ),   --  : natid5 (Integer)
           228 => ( Parameter_Integer, 0 ),   --  : natid6 (Integer)
           229 => ( Parameter_Integer, 0 ),   --  : ndeal (Integer)
           230 => ( Parameter_Integer, 0 ),   --  : newdtype (Integer)
           231 => ( Parameter_Integer, 0 ),   --  : nhs1 (Integer)
           232 => ( Parameter_Integer, 0 ),   --  : nhs2 (Integer)
           233 => ( Parameter_Integer, 0 ),   --  : nhs3 (Integer)
           234 => ( Parameter_Float, 0.0 ),   --  : niamt (Amount)
           235 => ( Parameter_Integer, 0 ),   --  : niethgrp (Integer)
           236 => ( Parameter_Integer, 0 ),   --  : niexthbb (Integer)
           237 => ( Parameter_Integer, 0 ),   --  : ninatid1 (Integer)
           238 => ( Parameter_Integer, 0 ),   --  : ninatid2 (Integer)
           239 => ( Parameter_Integer, 0 ),   --  : ninatid3 (Integer)
           240 => ( Parameter_Integer, 0 ),   --  : ninatid4 (Integer)
           241 => ( Parameter_Integer, 0 ),   --  : ninatid5 (Integer)
           242 => ( Parameter_Integer, 0 ),   --  : ninatid6 (Integer)
           243 => ( Parameter_Integer, 0 ),   --  : ninatid7 (Integer)
           244 => ( Parameter_Integer, 0 ),   --  : ninatid8 (Integer)
           245 => ( Parameter_Integer, 0 ),   --  : nipd (Integer)
           246 => ( Parameter_Integer, 0 ),   --  : nireg (Integer)
           247 => ( Parameter_Integer, 0 ),   --  : nirel (Integer)
           248 => ( Parameter_Integer, 0 ),   --  : nitrain (Integer)
           249 => ( Parameter_Integer, 0 ),   --  : nlper (Integer)
           250 => ( Parameter_Integer, 0 ),   --  : nolk1 (Integer)
           251 => ( Parameter_Integer, 0 ),   --  : nolk2 (Integer)
           252 => ( Parameter_Integer, 0 ),   --  : nolk3 (Integer)
           253 => ( Parameter_Integer, 0 ),   --  : nolook (Integer)
           254 => ( Parameter_Integer, 0 ),   --  : nowant (Integer)
           255 => ( Parameter_Float, 0.0 ),   --  : nssec (Amount)
           256 => ( Parameter_Integer, 0 ),   --  : ntcapp (Integer)
           257 => ( Parameter_Integer, 0 ),   --  : ntcdat (Integer)
           258 => ( Parameter_Float, 0.0 ),   --  : ntcinc (Amount)
           259 => ( Parameter_Integer, 0 ),   --  : ntcorig1 (Integer)
           260 => ( Parameter_Integer, 0 ),   --  : ntcorig2 (Integer)
           261 => ( Parameter_Integer, 0 ),   --  : ntcorig3 (Integer)
           262 => ( Parameter_Integer, 0 ),   --  : ntcorig4 (Integer)
           263 => ( Parameter_Integer, 0 ),   --  : ntcorig5 (Integer)
           264 => ( Parameter_Integer, 0 ),   --  : numjob (Integer)
           265 => ( Parameter_Integer, 0 ),   --  : numjob2 (Integer)
           266 => ( Parameter_Integer, 0 ),   --  : oddjob (Integer)
           267 => ( Parameter_Integer, 0 ),   --  : oldstud (Integer)
           268 => ( Parameter_Integer, 0 ),   --  : otabspar (Integer)
           269 => ( Parameter_Float, 0.0 ),   --  : otamt (Amount)
           270 => ( Parameter_Float, 0.0 ),   --  : otapamt (Amount)
           271 => ( Parameter_Integer, 0 ),   --  : otappd (Integer)
           272 => ( Parameter_Integer, 0 ),   --  : othtax (Integer)
           273 => ( Parameter_Integer, 0 ),   --  : otinva (Integer)
           274 => ( Parameter_Float, 0.0 ),   --  : pareamt (Amount)
           275 => ( Parameter_Integer, 0 ),   --  : parepd (Integer)
           276 => ( Parameter_Integer, 0 ),   --  : penlump (Integer)
           277 => ( Parameter_Integer, 0 ),   --  : ppnumc (Integer)
           278 => ( Parameter_Integer, 0 ),   --  : prit (Integer)
           279 => ( Parameter_Integer, 0 ),   --  : prscrpt (Integer)
           280 => ( Parameter_Integer, 0 ),   --  : ptwk (Integer)
           281 => ( Parameter_Integer, 0 ),   --  : r01 (Integer)
           282 => ( Parameter_Integer, 0 ),   --  : r02 (Integer)
           283 => ( Parameter_Integer, 0 ),   --  : r03 (Integer)
           284 => ( Parameter_Integer, 0 ),   --  : r04 (Integer)
           285 => ( Parameter_Integer, 0 ),   --  : r05 (Integer)
           286 => ( Parameter_Integer, 0 ),   --  : r06 (Integer)
           287 => ( Parameter_Integer, 0 ),   --  : r07 (Integer)
           288 => ( Parameter_Integer, 0 ),   --  : r08 (Integer)
           289 => ( Parameter_Integer, 0 ),   --  : r09 (Integer)
           290 => ( Parameter_Integer, 0 ),   --  : r10 (Integer)
           291 => ( Parameter_Integer, 0 ),   --  : r11 (Integer)
           292 => ( Parameter_Integer, 0 ),   --  : r12 (Integer)
           293 => ( Parameter_Integer, 0 ),   --  : r13 (Integer)
           294 => ( Parameter_Integer, 0 ),   --  : r14 (Integer)
           295 => ( Parameter_Float, 0.0 ),   --  : redamt (Amount)
           296 => ( Parameter_Integer, 0 ),   --  : redany (Integer)
           297 => ( Parameter_Integer, 0 ),   --  : rentprof (Integer)
           298 => ( Parameter_Integer, 0 ),   --  : retire (Integer)
           299 => ( Parameter_Integer, 0 ),   --  : retire1 (Integer)
           300 => ( Parameter_Integer, 0 ),   --  : retreas (Integer)
           301 => ( Parameter_Integer, 0 ),   --  : royal1 (Integer)
           302 => ( Parameter_Integer, 0 ),   --  : royal2 (Integer)
           303 => ( Parameter_Integer, 0 ),   --  : royal3 (Integer)
           304 => ( Parameter_Integer, 0 ),   --  : royal4 (Integer)
           305 => ( Parameter_Float, 0.0 ),   --  : royyr1 (Amount)
           306 => ( Parameter_Float, 0.0 ),   --  : royyr2 (Amount)
           307 => ( Parameter_Float, 0.0 ),   --  : royyr3 (Amount)
           308 => ( Parameter_Float, 0.0 ),   --  : royyr4 (Amount)
           309 => ( Parameter_Integer, 0 ),   --  : rstrct (Integer)
           310 => ( Parameter_Integer, 0 ),   --  : sex (Integer)
           311 => ( Parameter_Integer, 0 ),   --  : sflntyp1 (Integer)
           312 => ( Parameter_Integer, 0 ),   --  : sflntyp2 (Integer)
           313 => ( Parameter_Integer, 0 ),   --  : sftype1 (Integer)
           314 => ( Parameter_Integer, 0 ),   --  : sftype2 (Integer)
           315 => ( Parameter_Integer, 0 ),   --  : sic (Integer)
           316 => ( Parameter_Float, 0.0 ),   --  : slrepamt (Amount)
           317 => ( Parameter_Integer, 0 ),   --  : slrepay (Integer)
           318 => ( Parameter_Integer, 0 ),   --  : slreppd (Integer)
           319 => ( Parameter_Integer, 0 ),   --  : soc2000 (Integer)
           320 => ( Parameter_Integer, 0 ),   --  : spcreg1 (Integer)
           321 => ( Parameter_Integer, 0 ),   --  : spcreg2 (Integer)
           322 => ( Parameter_Integer, 0 ),   --  : spcreg3 (Integer)
           323 => ( Parameter_Integer, 0 ),   --  : specs (Integer)
           324 => ( Parameter_Integer, 0 ),   --  : spout (Integer)
           325 => ( Parameter_Float, 0.0 ),   --  : srentamt (Amount)
           326 => ( Parameter_Integer, 0 ),   --  : srentpd (Integer)
           327 => ( Parameter_Integer, 0 ),   --  : start (Integer)
           328 => ( Parameter_Integer, 0 ),   --  : startyr (Integer)
           329 => ( Parameter_Integer, 0 ),   --  : taxcred1 (Integer)
           330 => ( Parameter_Integer, 0 ),   --  : taxcred2 (Integer)
           331 => ( Parameter_Integer, 0 ),   --  : taxcred3 (Integer)
           332 => ( Parameter_Integer, 0 ),   --  : taxcred4 (Integer)
           333 => ( Parameter_Integer, 0 ),   --  : taxcred5 (Integer)
           334 => ( Parameter_Integer, 0 ),   --  : taxfut (Integer)
           335 => ( Parameter_Integer, 0 ),   --  : tdaywrk (Integer)
           336 => ( Parameter_Integer, 0 ),   --  : tea (Integer)
           337 => ( Parameter_Integer, 0 ),   --  : topupl (Integer)
           338 => ( Parameter_Float, 0.0 ),   --  : totint (Amount)
           339 => ( Parameter_Integer, 0 ),   --  : train (Integer)
           340 => ( Parameter_Integer, 0 ),   --  : trav (Integer)
           341 => ( Parameter_Integer, 0 ),   --  : tuborr (Integer)
           342 => ( Parameter_Integer, 0 ),   --  : typeed (Integer)
           343 => ( Parameter_Integer, 0 ),   --  : unpaid1 (Integer)
           344 => ( Parameter_Integer, 0 ),   --  : unpaid2 (Integer)
           345 => ( Parameter_Integer, 0 ),   --  : voucher (Integer)
           346 => ( Parameter_Integer, 0 ),   --  : w1 (Integer)
           347 => ( Parameter_Integer, 0 ),   --  : w2 (Integer)
           348 => ( Parameter_Integer, 0 ),   --  : wait (Integer)
           349 => ( Parameter_Integer, 0 ),   --  : war1 (Integer)
           350 => ( Parameter_Integer, 0 ),   --  : war2 (Integer)
           351 => ( Parameter_Integer, 0 ),   --  : wftcboth (Integer)
           352 => ( Parameter_Integer, 0 ),   --  : wftclum (Integer)
           353 => ( Parameter_Integer, 0 ),   --  : whoresp (Integer)
           354 => ( Parameter_Integer, 0 ),   --  : whosectb (Integer)
           355 => ( Parameter_Integer, 0 ),   --  : whyfrde1 (Integer)
           356 => ( Parameter_Integer, 0 ),   --  : whyfrde2 (Integer)
           357 => ( Parameter_Integer, 0 ),   --  : whyfrde3 (Integer)
           358 => ( Parameter_Integer, 0 ),   --  : whyfrde4 (Integer)
           359 => ( Parameter_Integer, 0 ),   --  : whyfrde5 (Integer)
           360 => ( Parameter_Integer, 0 ),   --  : whyfrde6 (Integer)
           361 => ( Parameter_Integer, 0 ),   --  : whyfrey1 (Integer)
           362 => ( Parameter_Integer, 0 ),   --  : whyfrey2 (Integer)
           363 => ( Parameter_Integer, 0 ),   --  : whyfrey3 (Integer)
           364 => ( Parameter_Integer, 0 ),   --  : whyfrey4 (Integer)
           365 => ( Parameter_Integer, 0 ),   --  : whyfrey5 (Integer)
           366 => ( Parameter_Integer, 0 ),   --  : whyfrey6 (Integer)
           367 => ( Parameter_Integer, 0 ),   --  : whyfrpr1 (Integer)
           368 => ( Parameter_Integer, 0 ),   --  : whyfrpr2 (Integer)
           369 => ( Parameter_Integer, 0 ),   --  : whyfrpr3 (Integer)
           370 => ( Parameter_Integer, 0 ),   --  : whyfrpr4 (Integer)
           371 => ( Parameter_Integer, 0 ),   --  : whyfrpr5 (Integer)
           372 => ( Parameter_Integer, 0 ),   --  : whyfrpr6 (Integer)
           373 => ( Parameter_Integer, 0 ),   --  : whytrav1 (Integer)
           374 => ( Parameter_Integer, 0 ),   --  : whytrav2 (Integer)
           375 => ( Parameter_Integer, 0 ),   --  : whytrav3 (Integer)
           376 => ( Parameter_Integer, 0 ),   --  : whytrav4 (Integer)
           377 => ( Parameter_Integer, 0 ),   --  : whytrav5 (Integer)
           378 => ( Parameter_Integer, 0 ),   --  : whytrav6 (Integer)
           379 => ( Parameter_Integer, 0 ),   --  : wintfuel (Integer)
           380 => ( Parameter_Integer, 0 ),   --  : wmkit (Integer)
           381 => ( Parameter_Integer, 0 ),   --  : working (Integer)
           382 => ( Parameter_Integer, 0 ),   --  : wpa (Integer)
           383 => ( Parameter_Integer, 0 ),   --  : wpba (Integer)
           384 => ( Parameter_Integer, 0 ),   --  : wtclum1 (Integer)
           385 => ( Parameter_Integer, 0 ),   --  : wtclum2 (Integer)
           386 => ( Parameter_Integer, 0 ),   --  : wtclum3 (Integer)
           387 => ( Parameter_Integer, 0 ),   --  : ystrtwk (Integer)
           388 => ( Parameter_Integer, 0 ),   --  : month (Integer)
           389 => ( Parameter_Integer, 0 ),   --  : able (Integer)
           390 => ( Parameter_Integer, 0 ),   --  : actacci (Integer)
           391 => ( Parameter_Integer, 0 ),   --  : addda (Integer)
           392 => ( Parameter_Integer, 0 ),   --  : basacti (Integer)
           393 => ( Parameter_Float, 0.0 ),   --  : bntxcred (Amount)
           394 => ( Parameter_Integer, 0 ),   --  : careab (Integer)
           395 => ( Parameter_Integer, 0 ),   --  : careah (Integer)
           396 => ( Parameter_Integer, 0 ),   --  : carecb (Integer)
           397 => ( Parameter_Integer, 0 ),   --  : carech (Integer)
           398 => ( Parameter_Integer, 0 ),   --  : carecl (Integer)
           399 => ( Parameter_Integer, 0 ),   --  : carefl (Integer)
           400 => ( Parameter_Integer, 0 ),   --  : carefr (Integer)
           401 => ( Parameter_Integer, 0 ),   --  : careot (Integer)
           402 => ( Parameter_Integer, 0 ),   --  : carere (Integer)
           403 => ( Parameter_Integer, 0 ),   --  : curacti (Integer)
           404 => ( Parameter_Float, 0.0 ),   --  : empoccp (Amount)
           405 => ( Parameter_Integer, 0 ),   --  : empstatb (Integer)
           406 => ( Parameter_Integer, 0 ),   --  : empstatc (Integer)
           407 => ( Parameter_Integer, 0 ),   --  : empstati (Integer)
           408 => ( Parameter_Integer, 0 ),   --  : fsbndcti (Integer)
           409 => ( Parameter_Float, 0.0 ),   --  : fwmlkval (Amount)
           410 => ( Parameter_Integer, 0 ),   --  : gebacti (Integer)
           411 => ( Parameter_Integer, 0 ),   --  : giltcti (Integer)
           412 => ( Parameter_Integer, 0 ),   --  : gross2 (Integer)
           413 => ( Parameter_Integer, 0 ),   --  : gross3 (Integer)
           414 => ( Parameter_Float, 0.0 ),   --  : hbsupran (Amount)
           415 => ( Parameter_Integer, 0 ),   --  : hdage (Integer)
           416 => ( Parameter_Integer, 0 ),   --  : hdben (Integer)
           417 => ( Parameter_Integer, 0 ),   --  : hdindinc (Integer)
           418 => ( Parameter_Integer, 0 ),   --  : hourab (Integer)
           419 => ( Parameter_Integer, 0 ),   --  : hourah (Integer)
           420 => ( Parameter_Float, 0.0 ),   --  : hourcare (Amount)
           421 => ( Parameter_Integer, 0 ),   --  : hourcb (Integer)
           422 => ( Parameter_Integer, 0 ),   --  : hourch (Integer)
           423 => ( Parameter_Integer, 0 ),   --  : hourcl (Integer)
           424 => ( Parameter_Integer, 0 ),   --  : hourfr (Integer)
           425 => ( Parameter_Integer, 0 ),   --  : hourot (Integer)
           426 => ( Parameter_Integer, 0 ),   --  : hourre (Integer)
           427 => ( Parameter_Integer, 0 ),   --  : hourtot (Integer)
           428 => ( Parameter_Integer, 0 ),   --  : hperson (Integer)
           429 => ( Parameter_Integer, 0 ),   --  : iagegr2 (Integer)
           430 => ( Parameter_Integer, 0 ),   --  : iagegrp (Integer)
           431 => ( Parameter_Float, 0.0 ),   --  : incseo2 (Amount)
           432 => ( Parameter_Integer, 0 ),   --  : indinc (Integer)
           433 => ( Parameter_Integer, 0 ),   --  : indisben (Integer)
           434 => ( Parameter_Float, 0.0 ),   --  : inearns (Amount)
           435 => ( Parameter_Float, 0.0 ),   --  : ininv (Amount)
           436 => ( Parameter_Integer, 0 ),   --  : inirben (Integer)
           437 => ( Parameter_Integer, 0 ),   --  : innirben (Integer)
           438 => ( Parameter_Integer, 0 ),   --  : inothben (Integer)
           439 => ( Parameter_Float, 0.0 ),   --  : inpeninc (Amount)
           440 => ( Parameter_Float, 0.0 ),   --  : inrinc (Amount)
           441 => ( Parameter_Float, 0.0 ),   --  : inrpinc (Amount)
           442 => ( Parameter_Float, 0.0 ),   --  : intvlic (Amount)
           443 => ( Parameter_Float, 0.0 ),   --  : intxcred (Amount)
           444 => ( Parameter_Integer, 0 ),   --  : isacti (Integer)
           445 => ( Parameter_Integer, 0 ),   --  : marital (Integer)
           446 => ( Parameter_Float, 0.0 ),   --  : netocpen (Amount)
           447 => ( Parameter_Float, 0.0 ),   --  : nincseo2 (Amount)
           448 => ( Parameter_Integer, 0 ),   --  : nindinc (Integer)
           449 => ( Parameter_Integer, 0 ),   --  : ninearns (Integer)
           450 => ( Parameter_Integer, 0 ),   --  : nininv (Integer)
           451 => ( Parameter_Integer, 0 ),   --  : ninpenin (Integer)
           452 => ( Parameter_Float, 0.0 ),   --  : ninsein2 (Amount)
           453 => ( Parameter_Integer, 0 ),   --  : nsbocti (Integer)
           454 => ( Parameter_Integer, 0 ),   --  : occupnum (Integer)
           455 => ( Parameter_Integer, 0 ),   --  : otbscti (Integer)
           456 => ( Parameter_Integer, 0 ),   --  : pepscti (Integer)
           457 => ( Parameter_Integer, 0 ),   --  : poaccti (Integer)
           458 => ( Parameter_Integer, 0 ),   --  : prbocti (Integer)
           459 => ( Parameter_Integer, 0 ),   --  : relhrp (Integer)
           460 => ( Parameter_Integer, 0 ),   --  : sayecti (Integer)
           461 => ( Parameter_Integer, 0 ),   --  : sclbcti (Integer)
           462 => ( Parameter_Float, 0.0 ),   --  : seincam2 (Amount)
           463 => ( Parameter_Float, 0.0 ),   --  : smpadj (Amount)
           464 => ( Parameter_Integer, 0 ),   --  : sscti (Integer)
           465 => ( Parameter_Float, 0.0 ),   --  : sspadj (Amount)
           466 => ( Parameter_Integer, 0 ),   --  : stshcti (Integer)
           467 => ( Parameter_Float, 0.0 ),   --  : superan (Amount)
           468 => ( Parameter_Integer, 0 ),   --  : taxpayer (Integer)
           469 => ( Parameter_Integer, 0 ),   --  : tesscti (Integer)
           470 => ( Parameter_Float, 0.0 ),   --  : totgrant (Amount)
           471 => ( Parameter_Float, 0.0 ),   --  : tothours (Amount)
           472 => ( Parameter_Float, 0.0 ),   --  : totoccp (Amount)
           473 => ( Parameter_Float, 0.0 ),   --  : ttwcosts (Amount)
           474 => ( Parameter_Integer, 0 ),   --  : untrcti (Integer)
           475 => ( Parameter_Integer, 0 ),   --  : uperson (Integer)
           476 => ( Parameter_Float, 0.0 ),   --  : widoccp (Amount)
           477 => ( Parameter_Integer, 0 ),   --  : accountq (Integer)
           478 => ( Parameter_Integer, 0 ),   --  : ben5q7 (Integer)
           479 => ( Parameter_Integer, 0 ),   --  : ben5q8 (Integer)
           480 => ( Parameter_Integer, 0 ),   --  : ben5q9 (Integer)
           481 => ( Parameter_Integer, 0 ),   --  : ddatre (Integer)
           482 => ( Parameter_Integer, 0 ),   --  : disdif9 (Integer)
           483 => ( Parameter_Float, 0.0 ),   --  : fare (Amount)
           484 => ( Parameter_Integer, 0 ),   --  : nittwmod (Integer)
           485 => ( Parameter_Integer, 0 ),   --  : oneway (Integer)
           486 => ( Parameter_Float, 0.0 ),   --  : pssamt (Amount)
           487 => ( Parameter_Integer, 0 ),   --  : pssdate (Integer)
           488 => ( Parameter_Integer, 0 ),   --  : ttwcode1 (Integer)
           489 => ( Parameter_Integer, 0 ),   --  : ttwcode2 (Integer)
           490 => ( Parameter_Integer, 0 ),   --  : ttwcode3 (Integer)
           491 => ( Parameter_Float, 0.0 ),   --  : ttwcost (Amount)
           492 => ( Parameter_Integer, 0 ),   --  : ttwfar (Integer)
           493 => ( Parameter_Float, 0.0 ),   --  : ttwfrq (Amount)
           494 => ( Parameter_Integer, 0 ),   --  : ttwmod (Integer)
           495 => ( Parameter_Integer, 0 ),   --  : ttwpay (Integer)
           496 => ( Parameter_Integer, 0 ),   --  : ttwpss (Integer)
           497 => ( Parameter_Float, 0.0 ),   --  : ttwrec (Amount)
           498 => ( Parameter_Integer, 0 ),   --  : chbflg (Integer)
           499 => ( Parameter_Integer, 0 ),   --  : crunaci (Integer)
           500 => ( Parameter_Integer, 0 ),   --  : enomorti (Integer)
           501 => ( Parameter_Float, 0.0 ),   --  : sapadj (Amount)
           502 => ( Parameter_Float, 0.0 ),   --  : sppadj (Amount)
           503 => ( Parameter_Integer, 0 ),   --  : ttwmode (Integer)
           504 => ( Parameter_Integer, 0 ),   --  : ddatrep (Integer)
           505 => ( Parameter_Integer, 0 ),   --  : defrpen (Integer)
           506 => ( Parameter_Integer, 0 ),   --  : disdifp (Integer)
           507 => ( Parameter_Integer, 0 ),   --  : followup (Integer)
           508 => ( Parameter_Integer, 0 ),   --  : practice (Integer)
           509 => ( Parameter_Integer, 0 ),   --  : sfrpis (Integer)
           510 => ( Parameter_Integer, 0 ),   --  : sfrpjsa (Integer)
           511 => ( Parameter_Integer, 0 ),   --  : age80 (Integer)
           512 => ( Parameter_Integer, 0 ),   --  : ethgr2 (Integer)
           513 => ( Parameter_Integer, 0 ),   --  : pocardi (Integer)
           514 => ( Parameter_Integer, 0 ),   --  : chkdpn (Integer)
           515 => ( Parameter_Integer, 0 ),   --  : chknop (Integer)
           516 => ( Parameter_Integer, 0 ),   --  : consent (Integer)
           517 => ( Parameter_Integer, 0 ),   --  : dvpens (Integer)
           518 => ( Parameter_Integer, 0 ),   --  : eligschm (Integer)
           519 => ( Parameter_Integer, 0 ),   --  : emparr (Integer)
           520 => ( Parameter_Integer, 0 ),   --  : emppen (Integer)
           521 => ( Parameter_Integer, 0 ),   --  : empschm (Integer)
           522 => ( Parameter_Integer, 0 ),   --  : lnkref1 (Integer)
           523 => ( Parameter_Integer, 0 ),   --  : lnkref2 (Integer)
           524 => ( Parameter_Integer, 0 ),   --  : lnkref21 (Integer)
           525 => ( Parameter_Integer, 0 ),   --  : lnkref22 (Integer)
           526 => ( Parameter_Integer, 0 ),   --  : lnkref23 (Integer)
           527 => ( Parameter_Integer, 0 ),   --  : lnkref24 (Integer)
           528 => ( Parameter_Integer, 0 ),   --  : lnkref25 (Integer)
           529 => ( Parameter_Integer, 0 ),   --  : lnkref3 (Integer)
           530 => ( Parameter_Integer, 0 ),   --  : lnkref4 (Integer)
           531 => ( Parameter_Integer, 0 ),   --  : lnkref5 (Integer)
           532 => ( Parameter_Integer, 0 ),   --  : memschm (Integer)
           533 => ( Parameter_Integer, 0 ),   --  : pconsent (Integer)
           534 => ( Parameter_Integer, 0 ),   --  : perspen1 (Integer)
           535 => ( Parameter_Integer, 0 ),   --  : perspen2 (Integer)
           536 => ( Parameter_Integer, 0 ),   --  : privpen (Integer)
           537 => ( Parameter_Integer, 0 ),   --  : schchk (Integer)
           538 => ( Parameter_Integer, 0 ),   --  : spnumc (Integer)
           539 => ( Parameter_Integer, 0 ),   --  : stakep (Integer)
           540 => ( Parameter_Integer, 0 ),   --  : trainee (Integer)
           541 => ( Parameter_Integer, 0 ),   --  : lnkdwp (Integer)
           542 => ( Parameter_Integer, 0 ),   --  : lnkons (Integer)
           543 => ( Parameter_Integer, 0 ),   --  : lnkref6 (Integer)
           544 => ( Parameter_Integer, 0 ),   --  : lnkref7 (Integer)
           545 => ( Parameter_Integer, 0 ),   --  : lnkref8 (Integer)
           546 => ( Parameter_Integer, 0 ),   --  : lnkref9 (Integer)
           547 => ( Parameter_Integer, 0 ),   --  : tcever1 (Integer)
           548 => ( Parameter_Integer, 0 ),   --  : tcever2 (Integer)
           549 => ( Parameter_Integer, 0 ),   --  : tcrepay1 (Integer)
           550 => ( Parameter_Integer, 0 ),   --  : tcrepay2 (Integer)
           551 => ( Parameter_Integer, 0 ),   --  : tcrepay3 (Integer)
           552 => ( Parameter_Integer, 0 ),   --  : tcrepay4 (Integer)
           553 => ( Parameter_Integer, 0 ),   --  : tcrepay5 (Integer)
           554 => ( Parameter_Integer, 0 ),   --  : tcrepay6 (Integer)
           555 => ( Parameter_Integer, 0 ),   --  : tcthsyr1 (Integer)
           556 => ( Parameter_Integer, 0 ),   --  : tcthsyr2 (Integer)
           557 => ( Parameter_Integer, 0 ),   --  : currjobm (Integer)
           558 => ( Parameter_Integer, 0 ),   --  : prevjobm (Integer)
           559 => ( Parameter_Integer, 0 ),   --  : b3qfut7 (Integer)
           560 => ( Parameter_Integer, 0 ),   --  : ben3q7 (Integer)
           561 => ( Parameter_Integer, 0 ),   --  : camemt (Integer)
           562 => ( Parameter_Integer, 0 ),   --  : cameyr (Integer)
           563 => ( Parameter_Integer, 0 ),   --  : cameyr2 (Integer)
           564 => ( Parameter_Integer, 0 ),   --  : contuk (Integer)
           565 => ( Parameter_Integer, 0 ),   --  : corign (Integer)
           566 => ( Parameter_Integer, 0 ),   --  : ddaprog (Integer)
           567 => ( Parameter_Integer, 0 ),   --  : hbolng (Integer)
           568 => ( Parameter_Integer, 0 ),   --  : hi1qual1 (Integer)
           569 => ( Parameter_Integer, 0 ),   --  : hi1qual2 (Integer)
           570 => ( Parameter_Integer, 0 ),   --  : hi1qual3 (Integer)
           571 => ( Parameter_Integer, 0 ),   --  : hi1qual4 (Integer)
           572 => ( Parameter_Integer, 0 ),   --  : hi1qual5 (Integer)
           573 => ( Parameter_Integer, 0 ),   --  : hi1qual6 (Integer)
           574 => ( Parameter_Integer, 0 ),   --  : hi2qual (Integer)
           575 => ( Parameter_Integer, 0 ),   --  : hlpgvn01 (Integer)
           576 => ( Parameter_Integer, 0 ),   --  : hlpgvn02 (Integer)
           577 => ( Parameter_Integer, 0 ),   --  : hlpgvn03 (Integer)
           578 => ( Parameter_Integer, 0 ),   --  : hlpgvn04 (Integer)
           579 => ( Parameter_Integer, 0 ),   --  : hlpgvn05 (Integer)
           580 => ( Parameter_Integer, 0 ),   --  : hlpgvn06 (Integer)
           581 => ( Parameter_Integer, 0 ),   --  : hlpgvn07 (Integer)
           582 => ( Parameter_Integer, 0 ),   --  : hlpgvn08 (Integer)
           583 => ( Parameter_Integer, 0 ),   --  : hlpgvn09 (Integer)
           584 => ( Parameter_Integer, 0 ),   --  : hlpgvn10 (Integer)
           585 => ( Parameter_Integer, 0 ),   --  : hlpgvn11 (Integer)
           586 => ( Parameter_Integer, 0 ),   --  : hlprec01 (Integer)
           587 => ( Parameter_Integer, 0 ),   --  : hlprec02 (Integer)
           588 => ( Parameter_Integer, 0 ),   --  : hlprec03 (Integer)
           589 => ( Parameter_Integer, 0 ),   --  : hlprec04 (Integer)
           590 => ( Parameter_Integer, 0 ),   --  : hlprec05 (Integer)
           591 => ( Parameter_Integer, 0 ),   --  : hlprec06 (Integer)
           592 => ( Parameter_Integer, 0 ),   --  : hlprec07 (Integer)
           593 => ( Parameter_Integer, 0 ),   --  : hlprec08 (Integer)
           594 => ( Parameter_Integer, 0 ),   --  : hlprec09 (Integer)
           595 => ( Parameter_Integer, 0 ),   --  : hlprec10 (Integer)
           596 => ( Parameter_Integer, 0 ),   --  : hlprec11 (Integer)
           597 => ( Parameter_Integer, 0 ),   --  : issue (Integer)
           598 => ( Parameter_Integer, 0 ),   --  : loangvn1 (Integer)
           599 => ( Parameter_Integer, 0 ),   --  : loangvn2 (Integer)
           600 => ( Parameter_Integer, 0 ),   --  : loangvn3 (Integer)
           601 => ( Parameter_Integer, 0 ),   --  : loanrec1 (Integer)
           602 => ( Parameter_Integer, 0 ),   --  : loanrec2 (Integer)
           603 => ( Parameter_Integer, 0 ),   --  : loanrec3 (Integer)
           604 => ( Parameter_Integer, 0 ),   --  : mntarr1 (Integer)
           605 => ( Parameter_Integer, 0 ),   --  : mntarr2 (Integer)
           606 => ( Parameter_Integer, 0 ),   --  : mntarr3 (Integer)
           607 => ( Parameter_Integer, 0 ),   --  : mntarr4 (Integer)
           608 => ( Parameter_Integer, 0 ),   --  : mntnrp (Integer)
           609 => ( Parameter_Integer, 0 ),   --  : othqual1 (Integer)
           610 => ( Parameter_Integer, 0 ),   --  : othqual2 (Integer)
           611 => ( Parameter_Integer, 0 ),   --  : othqual3 (Integer)
           612 => ( Parameter_Integer, 0 ),   --  : tea9697 (Integer)
           613 => ( Parameter_Float, 0.0 ),   --  : heartval (Amount)
           614 => ( Parameter_Integer, 0 ),   --  : iagegr3 (Integer)
           615 => ( Parameter_Integer, 0 ),   --  : iagegr4 (Integer)
           616 => ( Parameter_Integer, 0 ),   --  : nirel2 (Integer)
           617 => ( Parameter_Integer, 0 ),   --  : xbonflag (Integer)
           618 => ( Parameter_Integer, 0 ),   --  : alg (Integer)
           619 => ( Parameter_Float, 0.0 ),   --  : algamt (Amount)
           620 => ( Parameter_Integer, 0 ),   --  : algpd (Integer)
           621 => ( Parameter_Integer, 0 ),   --  : ben4q4 (Integer)
           622 => ( Parameter_Integer, 0 ),   --  : chkctc (Integer)
           623 => ( Parameter_Integer, 0 ),   --  : chkdpco1 (Integer)
           624 => ( Parameter_Integer, 0 ),   --  : chkdpco2 (Integer)
           625 => ( Parameter_Integer, 0 ),   --  : chkdpco3 (Integer)
           626 => ( Parameter_Integer, 0 ),   --  : chkdsco1 (Integer)
           627 => ( Parameter_Integer, 0 ),   --  : chkdsco2 (Integer)
           628 => ( Parameter_Integer, 0 ),   --  : chkdsco3 (Integer)
           629 => ( Parameter_Integer, 0 ),   --  : dv09pens (Integer)
           630 => ( Parameter_Integer, 0 ),   --  : lnkref01 (Integer)
           631 => ( Parameter_Integer, 0 ),   --  : lnkref02 (Integer)
           632 => ( Parameter_Integer, 0 ),   --  : lnkref03 (Integer)
           633 => ( Parameter_Integer, 0 ),   --  : lnkref04 (Integer)
           634 => ( Parameter_Integer, 0 ),   --  : lnkref05 (Integer)
           635 => ( Parameter_Integer, 0 ),   --  : lnkref06 (Integer)
           636 => ( Parameter_Integer, 0 ),   --  : lnkref07 (Integer)
           637 => ( Parameter_Integer, 0 ),   --  : lnkref08 (Integer)
           638 => ( Parameter_Integer, 0 ),   --  : lnkref09 (Integer)
           639 => ( Parameter_Integer, 0 ),   --  : lnkref10 (Integer)
           640 => ( Parameter_Integer, 0 ),   --  : lnkref11 (Integer)
           641 => ( Parameter_Integer, 0 ),   --  : spyrot (Integer)
           642 => ( Parameter_Integer, 0 ),   --  : disdifad (Integer)
           643 => ( Parameter_Integer, 0 ),   --  : gross3_x (Integer)
           644 => ( Parameter_Float, 0.0 ),   --  : aliamt (Amount)
           645 => ( Parameter_Integer, 0 ),   --  : alimny (Integer)
           646 => ( Parameter_Integer, 0 ),   --  : alipd (Integer)
           647 => ( Parameter_Integer, 0 ),   --  : alius (Integer)
           648 => ( Parameter_Float, 0.0 ),   --  : aluamt (Amount)
           649 => ( Parameter_Integer, 0 ),   --  : alupd (Integer)
           650 => ( Parameter_Integer, 0 ),   --  : cbaamt (Integer)
           651 => ( Parameter_Integer, 0 ),   --  : hsvper (Integer)
           652 => ( Parameter_Integer, 0 ),   --  : mednum (Integer)
           653 => ( Parameter_Integer, 0 ),   --  : medprpd (Integer)
           654 => ( Parameter_Integer, 0 ),   --  : medprpy (Integer)
           655 => ( Parameter_Integer, 0 ),   --  : penflag (Integer)
           656 => ( Parameter_Integer, 0 ),   --  : ppchk1 (Integer)
           657 => ( Parameter_Integer, 0 ),   --  : ppchk2 (Integer)
           658 => ( Parameter_Integer, 0 ),   --  : ppchk3 (Integer)
           659 => ( Parameter_Float, 0.0 ),   --  : ttbprx (Amount)
           660 => ( Parameter_Integer, 0 ),   --  : mjobsect (Integer)
           661 => ( Parameter_Integer, 0 ),   --  : etngrp (Integer)
           662 => ( Parameter_Integer, 0 ),   --  : medpay (Integer)
           663 => ( Parameter_Integer, 0 ),   --  : medrep (Integer)
           664 => ( Parameter_Integer, 0 ),   --  : medrpnm (Integer)
           665 => ( Parameter_Integer, 0 ),   --  : nanid1 (Integer)
           666 => ( Parameter_Integer, 0 ),   --  : nanid2 (Integer)
           667 => ( Parameter_Integer, 0 ),   --  : nanid3 (Integer)
           668 => ( Parameter_Integer, 0 ),   --  : nanid4 (Integer)
           669 => ( Parameter_Integer, 0 ),   --  : nanid5 (Integer)
           670 => ( Parameter_Integer, 0 ),   --  : nanid6 (Integer)
           671 => ( Parameter_Integer, 0 ),   --  : nietngrp (Integer)
           672 => ( Parameter_Integer, 0 ),   --  : ninanid1 (Integer)
           673 => ( Parameter_Integer, 0 ),   --  : ninanid2 (Integer)
           674 => ( Parameter_Integer, 0 ),   --  : ninanid3 (Integer)
           675 => ( Parameter_Integer, 0 ),   --  : ninanid4 (Integer)
           676 => ( Parameter_Integer, 0 ),   --  : ninanid5 (Integer)
           677 => ( Parameter_Integer, 0 ),   --  : ninanid6 (Integer)
           678 => ( Parameter_Integer, 0 ),   --  : ninanid7 (Integer)
           679 => ( Parameter_Integer, 0 ),   --  : nirelig (Integer)
           680 => ( Parameter_Integer, 0 ),   --  : pollopin (Integer)
           681 => ( Parameter_Integer, 0 ),   --  : religenw (Integer)
           682 => ( Parameter_Integer, 0 ),   --  : religsc (Integer)
           683 => ( Parameter_Integer, 0 ),   --  : sidqn (Integer)
           684 => ( Parameter_Integer, 0 ),   --  : soc2010 (Integer)
           685 => ( Parameter_Integer, 0 ),   --  : corignan (Integer)
           686 => ( Parameter_Integer, 0 ),   --  : dobmonth (Integer)
           687 => ( Parameter_Integer, 0 ),   --  : dobyear (Integer)
           688 => ( Parameter_Integer, 0 ),   --  : ethgr3 (Integer)
           689 => ( Parameter_Integer, 0 ),   --  : ninanida (Integer)
           690 => ( Parameter_Integer, 0 ),   --  : agehqual (Integer)
           691 => ( Parameter_Integer, 0 ),   --  : bfd (Integer)
           692 => ( Parameter_Float, 0.0 ),   --  : bfdamt (Amount)
           693 => ( Parameter_Integer, 0 ),   --  : bfdpd (Integer)
           694 => ( Parameter_Integer, 0 ),   --  : bfdval (Integer)
           695 => ( Parameter_Integer, 0 ),   --  : btec (Integer)
           696 => ( Parameter_Integer, 0 ),   --  : btecnow (Integer)
           697 => ( Parameter_Integer, 0 ),   --  : cbaamt2 (Integer)
           698 => ( Parameter_Integer, 0 ),   --  : change (Integer)
           699 => ( Parameter_Integer, 0 ),   --  : citizen (Integer)
           700 => ( Parameter_Integer, 0 ),   --  : citizen2 (Integer)
           701 => ( Parameter_Integer, 0 ),   --  : condit (Integer)
           702 => ( Parameter_Integer, 0 ),   --  : corigoth (Integer)
           703 => ( Parameter_Integer, 0 ),   --  : curqual (Integer)
           704 => ( Parameter_Integer, 0 ),   --  : ddaprog1 (Integer)
           705 => ( Parameter_Integer, 0 ),   --  : ddatre1 (Integer)
           706 => ( Parameter_Integer, 0 ),   --  : ddatrep1 (Integer)
           707 => ( Parameter_Integer, 0 ),   --  : degree (Integer)
           708 => ( Parameter_Integer, 0 ),   --  : degrenow (Integer)
           709 => ( Parameter_Integer, 0 ),   --  : denrec (Integer)
           710 => ( Parameter_Integer, 0 ),   --  : disd01 (Integer)
           711 => ( Parameter_Integer, 0 ),   --  : disd02 (Integer)
           712 => ( Parameter_Integer, 0 ),   --  : disd03 (Integer)
           713 => ( Parameter_Integer, 0 ),   --  : disd04 (Integer)
           714 => ( Parameter_Integer, 0 ),   --  : disd05 (Integer)
           715 => ( Parameter_Integer, 0 ),   --  : disd06 (Integer)
           716 => ( Parameter_Integer, 0 ),   --  : disd07 (Integer)
           717 => ( Parameter_Integer, 0 ),   --  : disd08 (Integer)
           718 => ( Parameter_Integer, 0 ),   --  : disd09 (Integer)
           719 => ( Parameter_Integer, 0 ),   --  : disd10 (Integer)
           720 => ( Parameter_Integer, 0 ),   --  : disdifp1 (Integer)
           721 => ( Parameter_Integer, 0 ),   --  : empcontr (Integer)
           722 => ( Parameter_Integer, 0 ),   --  : ethgrps (Integer)
           723 => ( Parameter_Float, 0.0 ),   --  : eualiamt (Amount)
           724 => ( Parameter_Integer, 0 ),   --  : eualimny (Integer)
           725 => ( Parameter_Integer, 0 ),   --  : eualipd (Integer)
           726 => ( Parameter_Integer, 0 ),   --  : euetype (Integer)
           727 => ( Parameter_Integer, 0 ),   --  : followsc (Integer)
           728 => ( Parameter_Integer, 0 ),   --  : health1 (Integer)
           729 => ( Parameter_Integer, 0 ),   --  : heathad (Integer)
           730 => ( Parameter_Integer, 0 ),   --  : hi3qual (Integer)
           731 => ( Parameter_Integer, 0 ),   --  : higho (Integer)
           732 => ( Parameter_Integer, 0 ),   --  : highonow (Integer)
           733 => ( Parameter_Integer, 0 ),   --  : jobbyr (Integer)
           734 => ( Parameter_Integer, 0 ),   --  : limitl (Integer)
           735 => ( Parameter_Integer, 0 ),   --  : lktrain (Integer)
           736 => ( Parameter_Integer, 0 ),   --  : lkwork (Integer)
           737 => ( Parameter_Integer, 0 ),   --  : medrec (Integer)
           738 => ( Parameter_Integer, 0 ),   --  : nvqlenow (Integer)
           739 => ( Parameter_Integer, 0 ),   --  : nvqlev (Integer)
           740 => ( Parameter_Integer, 0 ),   --  : othpass (Integer)
           741 => ( Parameter_Integer, 0 ),   --  : ppper (Integer)
           742 => ( Parameter_Float, 0.0 ),   --  : proptax (Amount)
           743 => ( Parameter_Integer, 0 ),   --  : reasden (Integer)
           744 => ( Parameter_Integer, 0 ),   --  : reasmed (Integer)
           745 => ( Parameter_Integer, 0 ),   --  : reasnhs (Integer)
           746 => ( Parameter_Integer, 0 ),   --  : reason (Integer)
           747 => ( Parameter_Integer, 0 ),   --  : rednet (Integer)
           748 => ( Parameter_Float, 0.0 ),   --  : redtax (Amount)
           749 => ( Parameter_Integer, 0 ),   --  : rsa (Integer)
           750 => ( Parameter_Integer, 0 ),   --  : rsanow (Integer)
           751 => ( Parameter_Integer, 0 ),   --  : samesit (Integer)
           752 => ( Parameter_Integer, 0 ),   --  : scotvec (Integer)
           753 => ( Parameter_Integer, 0 ),   --  : sctvnow (Integer)
           754 => ( Parameter_Integer, 0 ),   --  : sdemp01 (Integer)
           755 => ( Parameter_Integer, 0 ),   --  : sdemp02 (Integer)
           756 => ( Parameter_Integer, 0 ),   --  : sdemp03 (Integer)
           757 => ( Parameter_Integer, 0 ),   --  : sdemp04 (Integer)
           758 => ( Parameter_Integer, 0 ),   --  : sdemp05 (Integer)
           759 => ( Parameter_Integer, 0 ),   --  : sdemp06 (Integer)
           760 => ( Parameter_Integer, 0 ),   --  : sdemp07 (Integer)
           761 => ( Parameter_Integer, 0 ),   --  : sdemp08 (Integer)
           762 => ( Parameter_Integer, 0 ),   --  : sdemp09 (Integer)
           763 => ( Parameter_Integer, 0 ),   --  : sdemp10 (Integer)
           764 => ( Parameter_Integer, 0 ),   --  : sdemp11 (Integer)
           765 => ( Parameter_Integer, 0 ),   --  : sdemp12 (Integer)
           766 => ( Parameter_Integer, 0 ),   --  : selfdemp (Integer)
           767 => ( Parameter_Integer, 0 ),   --  : tempjob (Integer)
           768 => ( Parameter_Integer, 0 ),   --  : agehq80 (Integer)
           769 => ( Parameter_Integer, 0 ),   --  : disacta1 (Integer)
           770 => ( Parameter_Integer, 0 ),   --  : discora1 (Integer)
           771 => ( Parameter_Integer, 0 ),   --  : gross4 (Integer)
           772 => ( Parameter_Integer, 0 ),   --  : ninrinc (Integer)
           773 => ( Parameter_Integer, 0 ),   --  : typeed2 (Integer)
           774 => ( Parameter_Integer, 0 ),   --  : w45 (Integer)
           775 => ( Parameter_Integer, 0 ),   --  : accmsat (Integer)
           776 => ( Parameter_Integer, 0 ),   --  : c2orign (Integer)
           777 => ( Parameter_Integer, 0 ),   --  : calm (Integer)
           778 => ( Parameter_Integer, 0 ),   --  : cbchk (Integer)
           779 => ( Parameter_Integer, 0 ),   --  : claifut1 (Integer)
           780 => ( Parameter_Integer, 0 ),   --  : claifut2 (Integer)
           781 => ( Parameter_Integer, 0 ),   --  : claifut3 (Integer)
           782 => ( Parameter_Integer, 0 ),   --  : claifut4 (Integer)
           783 => ( Parameter_Integer, 0 ),   --  : claifut5 (Integer)
           784 => ( Parameter_Integer, 0 ),   --  : claifut6 (Integer)
           785 => ( Parameter_Integer, 0 ),   --  : claifut7 (Integer)
           786 => ( Parameter_Integer, 0 ),   --  : claifut8 (Integer)
           787 => ( Parameter_Integer, 0 ),   --  : commusat (Integer)
           788 => ( Parameter_Integer, 0 ),   --  : coptrust (Integer)
           789 => ( Parameter_Integer, 0 ),   --  : depress (Integer)
           790 => ( Parameter_Integer, 0 ),   --  : disben1 (Integer)
           791 => ( Parameter_Integer, 0 ),   --  : disben2 (Integer)
           792 => ( Parameter_Integer, 0 ),   --  : disben3 (Integer)
           793 => ( Parameter_Integer, 0 ),   --  : disben4 (Integer)
           794 => ( Parameter_Integer, 0 ),   --  : disben5 (Integer)
           795 => ( Parameter_Integer, 0 ),   --  : disben6 (Integer)
           796 => ( Parameter_Integer, 0 ),   --  : discuss (Integer)
           797 => ( Parameter_Integer, 0 ),   --  : dla1 (Integer)
           798 => ( Parameter_Integer, 0 ),   --  : dla2 (Integer)
           799 => ( Parameter_Integer, 0 ),   --  : dls (Integer)
           800 => ( Parameter_Float, 0.0 ),   --  : dlsamt (Amount)
           801 => ( Parameter_Integer, 0 ),   --  : dlspd (Integer)
           802 => ( Parameter_Integer, 0 ),   --  : dlsval (Integer)
           803 => ( Parameter_Integer, 0 ),   --  : down (Integer)
           804 => ( Parameter_Integer, 0 ),   --  : envirsat (Integer)
           805 => ( Parameter_Integer, 0 ),   --  : gpispc (Integer)
           806 => ( Parameter_Integer, 0 ),   --  : gpjsaesa (Integer)
           807 => ( Parameter_Integer, 0 ),   --  : happy (Integer)
           808 => ( Parameter_Integer, 0 ),   --  : help (Integer)
           809 => ( Parameter_Integer, 0 ),   --  : iclaim1 (Integer)
           810 => ( Parameter_Integer, 0 ),   --  : iclaim2 (Integer)
           811 => ( Parameter_Integer, 0 ),   --  : iclaim3 (Integer)
           812 => ( Parameter_Integer, 0 ),   --  : iclaim4 (Integer)
           813 => ( Parameter_Integer, 0 ),   --  : iclaim5 (Integer)
           814 => ( Parameter_Integer, 0 ),   --  : iclaim6 (Integer)
           815 => ( Parameter_Integer, 0 ),   --  : iclaim7 (Integer)
           816 => ( Parameter_Integer, 0 ),   --  : iclaim8 (Integer)
           817 => ( Parameter_Integer, 0 ),   --  : iclaim9 (Integer)
           818 => ( Parameter_Integer, 0 ),   --  : jobsat (Integer)
           819 => ( Parameter_Integer, 0 ),   --  : kidben1 (Integer)
           820 => ( Parameter_Integer, 0 ),   --  : kidben2 (Integer)
           821 => ( Parameter_Integer, 0 ),   --  : kidben3 (Integer)
           822 => ( Parameter_Integer, 0 ),   --  : legltrus (Integer)
           823 => ( Parameter_Integer, 0 ),   --  : lifesat (Integer)
           824 => ( Parameter_Integer, 0 ),   --  : meaning (Integer)
           825 => ( Parameter_Integer, 0 ),   --  : moneysat (Integer)
           826 => ( Parameter_Integer, 0 ),   --  : nervous (Integer)
           827 => ( Parameter_Integer, 0 ),   --  : ni2train (Integer)
           828 => ( Parameter_Integer, 0 ),   --  : othben1 (Integer)
           829 => ( Parameter_Integer, 0 ),   --  : othben2 (Integer)
           830 => ( Parameter_Integer, 0 ),   --  : othben3 (Integer)
           831 => ( Parameter_Integer, 0 ),   --  : othben4 (Integer)
           832 => ( Parameter_Integer, 0 ),   --  : othben5 (Integer)
           833 => ( Parameter_Integer, 0 ),   --  : othben6 (Integer)
           834 => ( Parameter_Integer, 0 ),   --  : othtrust (Integer)
           835 => ( Parameter_Integer, 0 ),   --  : penben1 (Integer)
           836 => ( Parameter_Integer, 0 ),   --  : penben2 (Integer)
           837 => ( Parameter_Integer, 0 ),   --  : penben3 (Integer)
           838 => ( Parameter_Integer, 0 ),   --  : penben4 (Integer)
           839 => ( Parameter_Integer, 0 ),   --  : penben5 (Integer)
           840 => ( Parameter_Integer, 0 ),   --  : pip1 (Integer)
           841 => ( Parameter_Integer, 0 ),   --  : pip2 (Integer)
           842 => ( Parameter_Integer, 0 ),   --  : polttrus (Integer)
           843 => ( Parameter_Integer, 0 ),   --  : recsat (Integer)
           844 => ( Parameter_Integer, 0 ),   --  : relasat (Integer)
           845 => ( Parameter_Integer, 0 ),   --  : safe (Integer)
           846 => ( Parameter_Integer, 0 ),   --  : socfund1 (Integer)
           847 => ( Parameter_Integer, 0 ),   --  : socfund2 (Integer)
           848 => ( Parameter_Integer, 0 ),   --  : socfund3 (Integer)
           849 => ( Parameter_Integer, 0 ),   --  : socfund4 (Integer)
           850 => ( Parameter_Integer, 0 ),   --  : srispc (Integer)
           851 => ( Parameter_Integer, 0 ),   --  : srjsaesa (Integer)
           852 => ( Parameter_Integer, 0 ),   --  : timesat (Integer)
           853 => ( Parameter_Integer, 0 ),   --  : train2 (Integer)
           854 => ( Parameter_Integer, 0 ),   --  : trnallow (Integer)
           855 => ( Parameter_Integer, 0 ),   --  : wageben1 (Integer)
           856 => ( Parameter_Integer, 0 ),   --  : wageben2 (Integer)
           857 => ( Parameter_Integer, 0 ),   --  : wageben3 (Integer)
           858 => ( Parameter_Integer, 0 ),   --  : wageben4 (Integer)
           859 => ( Parameter_Integer, 0 ),   --  : wageben5 (Integer)
           860 => ( Parameter_Integer, 0 ),   --  : wageben6 (Integer)
           861 => ( Parameter_Integer, 0 ),   --  : wageben7 (Integer)
           862 => ( Parameter_Integer, 0 ),   --  : wageben8 (Integer)
           863 => ( Parameter_Integer, 0 ),   --  : ninnirbn (Integer)
           864 => ( Parameter_Integer, 0 ),   --  : ninothbn (Integer)
           865 => ( Parameter_Integer, 0 ),   --  : anxious (Integer)
           866 => ( Parameter_Integer, 0 ),   --  : candgnow (Integer)
           867 => ( Parameter_Integer, 0 ),   --  : curothf (Integer)
           868 => ( Parameter_Integer, 0 ),   --  : curothp (Integer)
           869 => ( Parameter_Integer, 0 ),   --  : curothwv (Integer)
           870 => ( Parameter_Integer, 0 ),   --  : dvhiqual (Integer)
           871 => ( Parameter_Integer, 0 ),   --  : gnvqnow (Integer)
           872 => ( Parameter_Integer, 0 ),   --  : gpuc (Integer)
           873 => ( Parameter_Integer, 0 ),   --  : happywb (Integer)
           874 => ( Parameter_Integer, 0 ),   --  : hi1qual7 (Integer)
           875 => ( Parameter_Integer, 0 ),   --  : hi1qual8 (Integer)
           876 => ( Parameter_Integer, 0 ),   --  : mntarr5 (Integer)
           877 => ( Parameter_Integer, 0 ),   --  : mntnoch1 (Integer)
           878 => ( Parameter_Integer, 0 ),   --  : mntnoch2 (Integer)
           879 => ( Parameter_Integer, 0 ),   --  : mntnoch3 (Integer)
           880 => ( Parameter_Integer, 0 ),   --  : mntnoch4 (Integer)
           881 => ( Parameter_Integer, 0 ),   --  : mntnoch5 (Integer)
           882 => ( Parameter_Integer, 0 ),   --  : mntpro1 (Integer)
           883 => ( Parameter_Integer, 0 ),   --  : mntpro2 (Integer)
           884 => ( Parameter_Integer, 0 ),   --  : mntpro3 (Integer)
           885 => ( Parameter_Integer, 0 ),   --  : mnttim1 (Integer)
           886 => ( Parameter_Integer, 0 ),   --  : mnttim2 (Integer)
           887 => ( Parameter_Integer, 0 ),   --  : mnttim3 (Integer)
           888 => ( Parameter_Integer, 0 ),   --  : mntwrk1 (Integer)
           889 => ( Parameter_Integer, 0 ),   --  : mntwrk2 (Integer)
           890 => ( Parameter_Integer, 0 ),   --  : mntwrk3 (Integer)
           891 => ( Parameter_Integer, 0 ),   --  : mntwrk4 (Integer)
           892 => ( Parameter_Integer, 0 ),   --  : mntwrk5 (Integer)
           893 => ( Parameter_Integer, 0 ),   --  : ndeplnow (Integer)
           894 => ( Parameter_Integer, 0 ),   --  : oqualc1 (Integer)
           895 => ( Parameter_Integer, 0 ),   --  : oqualc2 (Integer)
           896 => ( Parameter_Integer, 0 ),   --  : oqualc3 (Integer)
           897 => ( Parameter_Integer, 0 ),   --  : sruc (Integer)
           898 => ( Parameter_Integer, 0 ),   --  : webacnow (Integer)
           899 => ( Parameter_Integer, 0 ),   --  : indeth (Integer)
           900 => ( Parameter_Integer, 0 ),   --  : euactive (Integer)
           901 => ( Parameter_Integer, 0 ),   --  : euactno (Integer)
           902 => ( Parameter_Integer, 0 ),   --  : euartact (Integer)
           903 => ( Parameter_Integer, 0 ),   --  : euaskhlp (Integer)
           904 => ( Parameter_Integer, 0 ),   --  : eucinema (Integer)
           905 => ( Parameter_Integer, 0 ),   --  : eucultur (Integer)
           906 => ( Parameter_Integer, 0 ),   --  : euinvol (Integer)
           907 => ( Parameter_Integer, 0 ),   --  : eulivpe (Integer)
           908 => ( Parameter_Integer, 0 ),   --  : eumtfam (Integer)
           909 => ( Parameter_Integer, 0 ),   --  : eumtfrnd (Integer)
           910 => ( Parameter_Integer, 0 ),   --  : eusocnet (Integer)
           911 => ( Parameter_Integer, 0 ),   --  : eusport (Integer)
           912 => ( Parameter_Integer, 0 ),   --  : eutkfam (Integer)
           913 => ( Parameter_Integer, 0 ),   --  : eutkfrnd (Integer)
           914 => ( Parameter_Integer, 0 ),   --  : eutkmat (Integer)
           915 => ( Parameter_Integer, 0 ),   --  : euvol (Integer)
           916 => ( Parameter_Integer, 0 ),   --  : natscot (Integer)
           917 => ( Parameter_Integer, 0 ),   --  : ntsctnow (Integer)
           918 => ( Parameter_Integer, 0 ),   --  : penwel1 (Integer)
           919 => ( Parameter_Integer, 0 ),   --  : penwel2 (Integer)
           920 => ( Parameter_Integer, 0 ),   --  : penwel3 (Integer)
           921 => ( Parameter_Integer, 0 ),   --  : penwel4 (Integer)
           922 => ( Parameter_Integer, 0 ),   --  : penwel5 (Integer)
           923 => ( Parameter_Integer, 0 ),   --  : penwel6 (Integer)
           924 => ( Parameter_Integer, 0 ),   --  : skiwknow (Integer)
           925 => ( Parameter_Integer, 0 ),   --  : skiwrk (Integer)
           926 => ( Parameter_Integer, 0 ),   --  : slos (Integer)
           927 => ( Parameter_Integer, 0 )   --  : yjblev (Integer)
      
      ));
   begin
      return params;
   end Get_Configured_Insert_Params;



   function Get_Prepared_Insert_Statement return gse.Prepared_Statement is 
      ps : gse.Prepared_Statement; 
      query : constant String := DB_Commons.Add_Schema_To_Query( INSERT_PART, SCHEMA_NAME ) & " ( $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $100, $101, $102, $103, $104, $105, $106, $107, $108, $109, $110, $111, $112, $113, $114, $115, $116, $117, $118, $119, $120, $121, $122, $123, $124, $125, $126, $127, $128, $129, $130, $131, $132, $133, $134, $135, $136, $137, $138, $139, $140, $141, $142, $143, $144, $145, $146, $147, $148, $149, $150, $151, $152, $153, $154, $155, $156, $157, $158, $159, $160, $161, $162, $163, $164, $165, $166, $167, $168, $169, $170, $171, $172, $173, $174, $175, $176, $177, $178, $179, $180, $181, $182, $183, $184, $185, $186, $187, $188, $189, $190, $191, $192, $193, $194, $195, $196, $197, $198, $199, $200, $201, $202, $203, $204, $205, $206, $207, $208, $209, $210, $211, $212, $213, $214, $215, $216, $217, $218, $219, $220, $221, $222, $223, $224, $225, $226, $227, $228, $229, $230, $231, $232, $233, $234, $235, $236, $237, $238, $239, $240, $241, $242, $243, $244, $245, $246, $247, $248, $249, $250, $251, $252, $253, $254, $255, $256, $257, $258, $259, $260, $261, $262, $263, $264, $265, $266, $267, $268, $269, $270, $271, $272, $273, $274, $275, $276, $277, $278, $279, $280, $281, $282, $283, $284, $285, $286, $287, $288, $289, $290, $291, $292, $293, $294, $295, $296, $297, $298, $299, $300, $301, $302, $303, $304, $305, $306, $307, $308, $309, $310, $311, $312, $313, $314, $315, $316, $317, $318, $319, $320, $321, $322, $323, $324, $325, $326, $327, $328, $329, $330, $331, $332, $333, $334, $335, $336, $337, $338, $339, $340, $341, $342, $343, $344, $345, $346, $347, $348, $349, $350, $351, $352, $353, $354, $355, $356, $357, $358, $359, $360, $361, $362, $363, $364, $365, $366, $367, $368, $369, $370, $371, $372, $373, $374, $375, $376, $377, $378, $379, $380, $381, $382, $383, $384, $385, $386, $387, $388, $389, $390, $391, $392, $393, $394, $395, $396, $397, $398, $399, $400, $401, $402, $403, $404, $405, $406, $407, $408, $409, $410, $411, $412, $413, $414, $415, $416, $417, $418, $419, $420, $421, $422, $423, $424, $425, $426, $427, $428, $429, $430, $431, $432, $433, $434, $435, $436, $437, $438, $439, $440, $441, $442, $443, $444, $445, $446, $447, $448, $449, $450, $451, $452, $453, $454, $455, $456, $457, $458, $459, $460, $461, $462, $463, $464, $465, $466, $467, $468, $469, $470, $471, $472, $473, $474, $475, $476, $477, $478, $479, $480, $481, $482, $483, $484, $485, $486, $487, $488, $489, $490, $491, $492, $493, $494, $495, $496, $497, $498, $499, $500, $501, $502, $503, $504, $505, $506, $507, $508, $509, $510, $511, $512, $513, $514, $515, $516, $517, $518, $519, $520, $521, $522, $523, $524, $525, $526, $527, $528, $529, $530, $531, $532, $533, $534, $535, $536, $537, $538, $539, $540, $541, $542, $543, $544, $545, $546, $547, $548, $549, $550, $551, $552, $553, $554, $555, $556, $557, $558, $559, $560, $561, $562, $563, $564, $565, $566, $567, $568, $569, $570, $571, $572, $573, $574, $575, $576, $577, $578, $579, $580, $581, $582, $583, $584, $585, $586, $587, $588, $589, $590, $591, $592, $593, $594, $595, $596, $597, $598, $599, $600, $601, $602, $603, $604, $605, $606, $607, $608, $609, $610, $611, $612, $613, $614, $615, $616, $617, $618, $619, $620, $621, $622, $623, $624, $625, $626, $627, $628, $629, $630, $631, $632, $633, $634, $635, $636, $637, $638, $639, $640, $641, $642, $643, $644, $645, $646, $647, $648, $649, $650, $651, $652, $653, $654, $655, $656, $657, $658, $659, $660, $661, $662, $663, $664, $665, $666, $667, $668, $669, $670, $671, $672, $673, $674, $675, $676, $677, $678, $679, $680, $681, $682, $683, $684, $685, $686, $687, $688, $689, $690, $691, $692, $693, $694, $695, $696, $697, $698, $699, $700, $701, $702, $703, $704, $705, $706, $707, $708, $709, $710, $711, $712, $713, $714, $715, $716, $717, $718, $719, $720, $721, $722, $723, $724, $725, $726, $727, $728, $729, $730, $731, $732, $733, $734, $735, $736, $737, $738, $739, $740, $741, $742, $743, $744, $745, $746, $747, $748, $749, $750, $751, $752, $753, $754, $755, $756, $757, $758, $759, $760, $761, $762, $763, $764, $765, $766, $767, $768, $769, $770, $771, $772, $773, $774, $775, $776, $777, $778, $779, $780, $781, $782, $783, $784, $785, $786, $787, $788, $789, $790, $791, $792, $793, $794, $795, $796, $797, $798, $799, $800, $801, $802, $803, $804, $805, $806, $807, $808, $809, $810, $811, $812, $813, $814, $815, $816, $817, $818, $819, $820, $821, $822, $823, $824, $825, $826, $827, $828, $829, $830, $831, $832, $833, $834, $835, $836, $837, $838, $839, $840, $841, $842, $843, $844, $845, $846, $847, $848, $849, $850, $851, $852, $853, $854, $855, $856, $857, $858, $859, $860, $861, $862, $863, $864, $865, $866, $867, $868, $869, $870, $871, $872, $873, $874, $875, $876, $877, $878, $879, $880, $881, $882, $883, $884, $885, $886, $887, $888, $889, $890, $891, $892, $893, $894, $895, $896, $897, $898, $899, $900, $901, $902, $903, $904, $905, $906, $907, $908, $909, $910, $911, $912, $913, $914, $915, $916, $917, $918, $919, $920, $921, $922, $923, $924, $925, $926, $927 )"; 
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
      
      query : constant String := DB_Commons.Add_Schema_To_Query( UPDATE_PART, SCHEMA_NAME ) & " abs1no = $1, abs2no = $2, abspar = $3, abspay = $4, abswhy = $5, abswk = $6, x_access = $7, accftpt = $8, accjb = $9, accssamt = $10, accsspd = $11, adeduc = $12, adema = $13, ademaamt = $14, ademapd = $15, age = $16, allow1 = $17, allow2 = $18, allow3 = $19, allow4 = $20, allpay1 = $21, allpay2 = $22, allpay3 = $23, allpay4 = $24, allpd1 = $25, allpd2 = $26, allpd3 = $27, allpd4 = $28, anyacc = $29, anyed = $30, anymon = $31, anypen1 = $32, anypen2 = $33, anypen3 = $34, anypen4 = $35, anypen5 = $36, anypen6 = $37, anypen7 = $38, apamt = $39, apdamt = $40, apdir = $41, apdpd = $42, appd = $43, b2qfut1 = $44, b2qfut2 = $45, b2qfut3 = $46, b3qfut1 = $47, b3qfut2 = $48, b3qfut3 = $49, b3qfut4 = $50, b3qfut5 = $51, b3qfut6 = $52, ben1q1 = $53, ben1q2 = $54, ben1q3 = $55, ben1q4 = $56, ben1q5 = $57, ben1q6 = $58, ben1q7 = $59, ben2q1 = $60, ben2q2 = $61, ben2q3 = $62, ben3q1 = $63, ben3q2 = $64, ben3q3 = $65, ben3q4 = $66, ben3q5 = $67, ben3q6 = $68, ben4q1 = $69, ben4q2 = $70, ben4q3 = $71, ben5q1 = $72, ben5q2 = $73, ben5q3 = $74, ben5q4 = $75, ben5q5 = $76, ben5q6 = $77, ben7q1 = $78, ben7q2 = $79, ben7q3 = $80, ben7q4 = $81, ben7q5 = $82, ben7q6 = $83, ben7q7 = $84, ben7q8 = $85, ben7q9 = $86, btwacc = $87, claimant = $88, cohabit = $89, combid = $90, convbl = $91, ctclum1 = $92, ctclum2 = $93, cupchk = $94, cvht = $95, cvpay = $96, cvpd = $97, dentist = $98, depend = $99, disdif1 = $100, disdif2 = $101, disdif3 = $102, disdif4 = $103, disdif5 = $104, disdif6 = $105, disdif7 = $106, disdif8 = $107, dob = $108, dptcboth = $109, dptclum = $110, dvil03a = $111, dvil04a = $112, dvjb12ml = $113, dvmardf = $114, ed1amt = $115, ed1borr = $116, ed1int = $117, ed1monyr = $118, ed1pd = $119, ed1sum = $120, ed2amt = $121, ed2borr = $122, ed2int = $123, ed2monyr = $124, ed2pd = $125, ed2sum = $126, edatt = $127, edattn1 = $128, edattn2 = $129, edattn3 = $130, edhr = $131, edtime = $132, edtyp = $133, eligadlt = $134, eligchld = $135, emppay1 = $136, emppay2 = $137, emppay3 = $138, empstat = $139, endyr = $140, epcur = $141, es2000 = $142, ethgrp = $143, everwrk = $144, exthbct1 = $145, exthbct2 = $146, exthbct3 = $147, eyetest = $148, follow = $149, fted = $150, ftwk = $151, future = $152, govpis = $153, govpjsa = $154, x_grant = $155, grtamt1 = $156, grtamt2 = $157, grtdir1 = $158, grtdir2 = $159, grtnum = $160, grtsce1 = $161, grtsce2 = $162, grtval1 = $163, grtval2 = $164, gta = $165, hbothamt = $166, hbothbu = $167, hbothpd = $168, hbothwk = $169, hbotwait = $170, health = $171, hholder = $172, hosp = $173, hprob = $174, hrpid = $175, incdur = $176, injlong = $177, injwk = $178, invests = $179, iout = $180, isa1type = $181, isa2type = $182, isa3type = $183, jobaway = $184, lareg = $185, likewk = $186, lktime = $187, ln1rpint = $188, ln2rpint = $189, loan = $190, loannum = $191, look = $192, lookwk = $193, lstwrk1 = $194, lstwrk2 = $195, lstyr = $196, mntamt1 = $197, mntamt2 = $198, mntct = $199, mntfor1 = $200, mntfor2 = $201, mntgov1 = $202, mntgov2 = $203, mntpay = $204, mntpd1 = $205, mntpd2 = $206, mntrec = $207, mnttota1 = $208, mnttota2 = $209, mntus1 = $210, mntus2 = $211, mntusam1 = $212, mntusam2 = $213, mntuspd1 = $214, mntuspd2 = $215, ms = $216, natid1 = $217, natid2 = $218, natid3 = $219, natid4 = $220, natid5 = $221, natid6 = $222, ndeal = $223, newdtype = $224, nhs1 = $225, nhs2 = $226, nhs3 = $227, niamt = $228, niethgrp = $229, niexthbb = $230, ninatid1 = $231, ninatid2 = $232, ninatid3 = $233, ninatid4 = $234, ninatid5 = $235, ninatid6 = $236, ninatid7 = $237, ninatid8 = $238, nipd = $239, nireg = $240, nirel = $241, nitrain = $242, nlper = $243, nolk1 = $244, nolk2 = $245, nolk3 = $246, nolook = $247, nowant = $248, nssec = $249, ntcapp = $250, ntcdat = $251, ntcinc = $252, ntcorig1 = $253, ntcorig2 = $254, ntcorig3 = $255, ntcorig4 = $256, ntcorig5 = $257, numjob = $258, numjob2 = $259, oddjob = $260, oldstud = $261, otabspar = $262, otamt = $263, otapamt = $264, otappd = $265, othtax = $266, otinva = $267, pareamt = $268, parepd = $269, penlump = $270, ppnumc = $271, prit = $272, prscrpt = $273, ptwk = $274, r01 = $275, r02 = $276, r03 = $277, r04 = $278, r05 = $279, r06 = $280, r07 = $281, r08 = $282, r09 = $283, r10 = $284, r11 = $285, r12 = $286, r13 = $287, r14 = $288, redamt = $289, redany = $290, rentprof = $291, retire = $292, retire1 = $293, retreas = $294, royal1 = $295, royal2 = $296, royal3 = $297, royal4 = $298, royyr1 = $299, royyr2 = $300, royyr3 = $301, royyr4 = $302, rstrct = $303, sex = $304, sflntyp1 = $305, sflntyp2 = $306, sftype1 = $307, sftype2 = $308, sic = $309, slrepamt = $310, slrepay = $311, slreppd = $312, soc2000 = $313, spcreg1 = $314, spcreg2 = $315, spcreg3 = $316, specs = $317, spout = $318, srentamt = $319, srentpd = $320, start = $321, startyr = $322, taxcred1 = $323, taxcred2 = $324, taxcred3 = $325, taxcred4 = $326, taxcred5 = $327, taxfut = $328, tdaywrk = $329, tea = $330, topupl = $331, totint = $332, train = $333, trav = $334, tuborr = $335, typeed = $336, unpaid1 = $337, unpaid2 = $338, voucher = $339, w1 = $340, w2 = $341, wait = $342, war1 = $343, war2 = $344, wftcboth = $345, wftclum = $346, whoresp = $347, whosectb = $348, whyfrde1 = $349, whyfrde2 = $350, whyfrde3 = $351, whyfrde4 = $352, whyfrde5 = $353, whyfrde6 = $354, whyfrey1 = $355, whyfrey2 = $356, whyfrey3 = $357, whyfrey4 = $358, whyfrey5 = $359, whyfrey6 = $360, whyfrpr1 = $361, whyfrpr2 = $362, whyfrpr3 = $363, whyfrpr4 = $364, whyfrpr5 = $365, whyfrpr6 = $366, whytrav1 = $367, whytrav2 = $368, whytrav3 = $369, whytrav4 = $370, whytrav5 = $371, whytrav6 = $372, wintfuel = $373, wmkit = $374, working = $375, wpa = $376, wpba = $377, wtclum1 = $378, wtclum2 = $379, wtclum3 = $380, ystrtwk = $381, month = $382, able = $383, actacci = $384, addda = $385, basacti = $386, bntxcred = $387, careab = $388, careah = $389, carecb = $390, carech = $391, carecl = $392, carefl = $393, carefr = $394, careot = $395, carere = $396, curacti = $397, empoccp = $398, empstatb = $399, empstatc = $400, empstati = $401, fsbndcti = $402, fwmlkval = $403, gebacti = $404, giltcti = $405, gross2 = $406, gross3 = $407, hbsupran = $408, hdage = $409, hdben = $410, hdindinc = $411, hourab = $412, hourah = $413, hourcare = $414, hourcb = $415, hourch = $416, hourcl = $417, hourfr = $418, hourot = $419, hourre = $420, hourtot = $421, hperson = $422, iagegr2 = $423, iagegrp = $424, incseo2 = $425, indinc = $426, indisben = $427, inearns = $428, ininv = $429, inirben = $430, innirben = $431, inothben = $432, inpeninc = $433, inrinc = $434, inrpinc = $435, intvlic = $436, intxcred = $437, isacti = $438, marital = $439, netocpen = $440, nincseo2 = $441, nindinc = $442, ninearns = $443, nininv = $444, ninpenin = $445, ninsein2 = $446, nsbocti = $447, occupnum = $448, otbscti = $449, pepscti = $450, poaccti = $451, prbocti = $452, relhrp = $453, sayecti = $454, sclbcti = $455, seincam2 = $456, smpadj = $457, sscti = $458, sspadj = $459, stshcti = $460, superan = $461, taxpayer = $462, tesscti = $463, totgrant = $464, tothours = $465, totoccp = $466, ttwcosts = $467, untrcti = $468, uperson = $469, widoccp = $470, accountq = $471, ben5q7 = $472, ben5q8 = $473, ben5q9 = $474, ddatre = $475, disdif9 = $476, fare = $477, nittwmod = $478, oneway = $479, pssamt = $480, pssdate = $481, ttwcode1 = $482, ttwcode2 = $483, ttwcode3 = $484, ttwcost = $485, ttwfar = $486, ttwfrq = $487, ttwmod = $488, ttwpay = $489, ttwpss = $490, ttwrec = $491, chbflg = $492, crunaci = $493, enomorti = $494, sapadj = $495, sppadj = $496, ttwmode = $497, ddatrep = $498, defrpen = $499, disdifp = $500, followup = $501, practice = $502, sfrpis = $503, sfrpjsa = $504, age80 = $505, ethgr2 = $506, pocardi = $507, chkdpn = $508, chknop = $509, consent = $510, dvpens = $511, eligschm = $512, emparr = $513, emppen = $514, empschm = $515, lnkref1 = $516, lnkref2 = $517, lnkref21 = $518, lnkref22 = $519, lnkref23 = $520, lnkref24 = $521, lnkref25 = $522, lnkref3 = $523, lnkref4 = $524, lnkref5 = $525, memschm = $526, pconsent = $527, perspen1 = $528, perspen2 = $529, privpen = $530, schchk = $531, spnumc = $532, stakep = $533, trainee = $534, lnkdwp = $535, lnkons = $536, lnkref6 = $537, lnkref7 = $538, lnkref8 = $539, lnkref9 = $540, tcever1 = $541, tcever2 = $542, tcrepay1 = $543, tcrepay2 = $544, tcrepay3 = $545, tcrepay4 = $546, tcrepay5 = $547, tcrepay6 = $548, tcthsyr1 = $549, tcthsyr2 = $550, currjobm = $551, prevjobm = $552, b3qfut7 = $553, ben3q7 = $554, camemt = $555, cameyr = $556, cameyr2 = $557, contuk = $558, corign = $559, ddaprog = $560, hbolng = $561, hi1qual1 = $562, hi1qual2 = $563, hi1qual3 = $564, hi1qual4 = $565, hi1qual5 = $566, hi1qual6 = $567, hi2qual = $568, hlpgvn01 = $569, hlpgvn02 = $570, hlpgvn03 = $571, hlpgvn04 = $572, hlpgvn05 = $573, hlpgvn06 = $574, hlpgvn07 = $575, hlpgvn08 = $576, hlpgvn09 = $577, hlpgvn10 = $578, hlpgvn11 = $579, hlprec01 = $580, hlprec02 = $581, hlprec03 = $582, hlprec04 = $583, hlprec05 = $584, hlprec06 = $585, hlprec07 = $586, hlprec08 = $587, hlprec09 = $588, hlprec10 = $589, hlprec11 = $590, issue = $591, loangvn1 = $592, loangvn2 = $593, loangvn3 = $594, loanrec1 = $595, loanrec2 = $596, loanrec3 = $597, mntarr1 = $598, mntarr2 = $599, mntarr3 = $600, mntarr4 = $601, mntnrp = $602, othqual1 = $603, othqual2 = $604, othqual3 = $605, tea9697 = $606, heartval = $607, iagegr3 = $608, iagegr4 = $609, nirel2 = $610, xbonflag = $611, alg = $612, algamt = $613, algpd = $614, ben4q4 = $615, chkctc = $616, chkdpco1 = $617, chkdpco2 = $618, chkdpco3 = $619, chkdsco1 = $620, chkdsco2 = $621, chkdsco3 = $622, dv09pens = $623, lnkref01 = $624, lnkref02 = $625, lnkref03 = $626, lnkref04 = $627, lnkref05 = $628, lnkref06 = $629, lnkref07 = $630, lnkref08 = $631, lnkref09 = $632, lnkref10 = $633, lnkref11 = $634, spyrot = $635, disdifad = $636, gross3_x = $637, aliamt = $638, alimny = $639, alipd = $640, alius = $641, aluamt = $642, alupd = $643, cbaamt = $644, hsvper = $645, mednum = $646, medprpd = $647, medprpy = $648, penflag = $649, ppchk1 = $650, ppchk2 = $651, ppchk3 = $652, ttbprx = $653, mjobsect = $654, etngrp = $655, medpay = $656, medrep = $657, medrpnm = $658, nanid1 = $659, nanid2 = $660, nanid3 = $661, nanid4 = $662, nanid5 = $663, nanid6 = $664, nietngrp = $665, ninanid1 = $666, ninanid2 = $667, ninanid3 = $668, ninanid4 = $669, ninanid5 = $670, ninanid6 = $671, ninanid7 = $672, nirelig = $673, pollopin = $674, religenw = $675, religsc = $676, sidqn = $677, soc2010 = $678, corignan = $679, dobmonth = $680, dobyear = $681, ethgr3 = $682, ninanida = $683, agehqual = $684, bfd = $685, bfdamt = $686, bfdpd = $687, bfdval = $688, btec = $689, btecnow = $690, cbaamt2 = $691, change = $692, citizen = $693, citizen2 = $694, condit = $695, corigoth = $696, curqual = $697, ddaprog1 = $698, ddatre1 = $699, ddatrep1 = $700, degree = $701, degrenow = $702, denrec = $703, disd01 = $704, disd02 = $705, disd03 = $706, disd04 = $707, disd05 = $708, disd06 = $709, disd07 = $710, disd08 = $711, disd09 = $712, disd10 = $713, disdifp1 = $714, empcontr = $715, ethgrps = $716, eualiamt = $717, eualimny = $718, eualipd = $719, euetype = $720, followsc = $721, health1 = $722, heathad = $723, hi3qual = $724, higho = $725, highonow = $726, jobbyr = $727, limitl = $728, lktrain = $729, lkwork = $730, medrec = $731, nvqlenow = $732, nvqlev = $733, othpass = $734, ppper = $735, proptax = $736, reasden = $737, reasmed = $738, reasnhs = $739, reason = $740, rednet = $741, redtax = $742, rsa = $743, rsanow = $744, samesit = $745, scotvec = $746, sctvnow = $747, sdemp01 = $748, sdemp02 = $749, sdemp03 = $750, sdemp04 = $751, sdemp05 = $752, sdemp06 = $753, sdemp07 = $754, sdemp08 = $755, sdemp09 = $756, sdemp10 = $757, sdemp11 = $758, sdemp12 = $759, selfdemp = $760, tempjob = $761, agehq80 = $762, disacta1 = $763, discora1 = $764, gross4 = $765, ninrinc = $766, typeed2 = $767, w45 = $768, accmsat = $769, c2orign = $770, calm = $771, cbchk = $772, claifut1 = $773, claifut2 = $774, claifut3 = $775, claifut4 = $776, claifut5 = $777, claifut6 = $778, claifut7 = $779, claifut8 = $780, commusat = $781, coptrust = $782, depress = $783, disben1 = $784, disben2 = $785, disben3 = $786, disben4 = $787, disben5 = $788, disben6 = $789, discuss = $790, dla1 = $791, dla2 = $792, dls = $793, dlsamt = $794, dlspd = $795, dlsval = $796, down = $797, envirsat = $798, gpispc = $799, gpjsaesa = $800, happy = $801, help = $802, iclaim1 = $803, iclaim2 = $804, iclaim3 = $805, iclaim4 = $806, iclaim5 = $807, iclaim6 = $808, iclaim7 = $809, iclaim8 = $810, iclaim9 = $811, jobsat = $812, kidben1 = $813, kidben2 = $814, kidben3 = $815, legltrus = $816, lifesat = $817, meaning = $818, moneysat = $819, nervous = $820, ni2train = $821, othben1 = $822, othben2 = $823, othben3 = $824, othben4 = $825, othben5 = $826, othben6 = $827, othtrust = $828, penben1 = $829, penben2 = $830, penben3 = $831, penben4 = $832, penben5 = $833, pip1 = $834, pip2 = $835, polttrus = $836, recsat = $837, relasat = $838, safe = $839, socfund1 = $840, socfund2 = $841, socfund3 = $842, socfund4 = $843, srispc = $844, srjsaesa = $845, timesat = $846, train2 = $847, trnallow = $848, wageben1 = $849, wageben2 = $850, wageben3 = $851, wageben4 = $852, wageben5 = $853, wageben6 = $854, wageben7 = $855, wageben8 = $856, ninnirbn = $857, ninothbn = $858, anxious = $859, candgnow = $860, curothf = $861, curothp = $862, curothwv = $863, dvhiqual = $864, gnvqnow = $865, gpuc = $866, happywb = $867, hi1qual7 = $868, hi1qual8 = $869, mntarr5 = $870, mntnoch1 = $871, mntnoch2 = $872, mntnoch3 = $873, mntnoch4 = $874, mntnoch5 = $875, mntpro1 = $876, mntpro2 = $877, mntpro3 = $878, mnttim1 = $879, mnttim2 = $880, mnttim3 = $881, mntwrk1 = $882, mntwrk2 = $883, mntwrk3 = $884, mntwrk4 = $885, mntwrk5 = $886, ndeplnow = $887, oqualc1 = $888, oqualc2 = $889, oqualc3 = $890, sruc = $891, webacnow = $892, indeth = $893, euactive = $894, euactno = $895, euartact = $896, euaskhlp = $897, eucinema = $898, eucultur = $899, euinvol = $900, eulivpe = $901, eumtfam = $902, eumtfrnd = $903, eusocnet = $904, eusport = $905, eutkfam = $906, eutkfrnd = $907, eutkmat = $908, euvol = $909, natscot = $910, ntsctnow = $911, penwel1 = $912, penwel2 = $913, penwel3 = $914, penwel4 = $915, penwel5 = $916, penwel6 = $917, skiwknow = $918, skiwrk = $919, slos = $920, yjblev = $921 where user_id = $922 and edition = $923 and year = $924 and sernum = $925 and benunit = $926 and person = $927"; 
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( user_id ) + 1, 1 ) from frs.adult", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( edition ) + 1, 1 ) from frs.adult", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( year ) + 1, 1 ) from frs.adult", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( sernum ) + 1, 1 ) from frs.adult", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( benunit ) + 1, 1 ) from frs.adult", SCHEMA_NAME );
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
         DB_Commons.Add_Schema_To_Query( "select coalesce( max( person ) + 1, 1 ) from frs.adult", SCHEMA_NAME );
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
   -- returns true if the primary key parts of Ukds.Frs.Adult match the defaults in Ukds.Frs.Null_Adult
   --
   --
   -- Does this Ukds.Frs.Adult equal the default Ukds.Frs.Null_Adult ?
   --
   function Is_Null( a_adult : Adult ) return Boolean is
   begin
      return a_adult = Ukds.Frs.Null_Adult;
   end Is_Null;


   
   --
   -- returns the single Ukds.Frs.Adult matching the primary key fields, or the Ukds.Frs.Null_Adult record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; benunit : Integer; person : Integer; connection : Database_Connection := null ) return Ukds.Frs.Adult is
      l : Ukds.Frs.Adult_List;
      a_adult : Ukds.Frs.Adult;
      c : d.Criteria;
   begin      
      Add_user_id( c, user_id );
      Add_edition( c, edition );
      Add_year( c, year );
      Add_sernum( c, sernum );
      Add_benunit( c, benunit );
      Add_person( c, person );
      l := Retrieve( c, connection );
      if( not Ukds.Frs.Adult_List_Package.is_empty( l ) ) then
         a_adult := Ukds.Frs.Adult_List_Package.First_Element( l );
      else
         a_adult := Ukds.Frs.Null_Adult;
      end if;
      return a_adult;
   end Retrieve_By_PK;


   --
   -- Returns true if record with the given primary key exists
   --
   EXISTS_PS : constant gse.Prepared_Statement := gse.Prepare( 
        "select 1 from frs.adult where user_id = $1 and edition = $2 and year = $3 and sernum = $4 and benunit = $5 and person = $6", 
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
   -- Retrieves a list of Adult matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Adult_List is
   begin      
      return Retrieve( d.to_string( c ) );
   end Retrieve;

   
   --
   -- Retrieves a list of Adult retrived by the sql string, or throws an exception
   --
   function Map_From_Cursor( cursor : gse.Forward_Cursor ) return Ukds.Frs.Adult is
      a_adult : Ukds.Frs.Adult;
   begin
      if not gse.Is_Null( cursor, 0 )then
         a_adult.user_id := gse.Integer_Value( cursor, 0 );
      end if;
      if not gse.Is_Null( cursor, 1 )then
         a_adult.edition := gse.Integer_Value( cursor, 1 );
      end if;
      if not gse.Is_Null( cursor, 2 )then
         a_adult.year := gse.Integer_Value( cursor, 2 );
      end if;
      if not gse.Is_Null( cursor, 3 )then
         a_adult.sernum := Sernum_Value'Value( gse.Value( cursor, 3 ));
      end if;
      if not gse.Is_Null( cursor, 4 )then
         a_adult.benunit := gse.Integer_Value( cursor, 4 );
      end if;
      if not gse.Is_Null( cursor, 5 )then
         a_adult.person := gse.Integer_Value( cursor, 5 );
      end if;
      if not gse.Is_Null( cursor, 6 )then
         a_adult.abs1no := gse.Integer_Value( cursor, 6 );
      end if;
      if not gse.Is_Null( cursor, 7 )then
         a_adult.abs2no := gse.Integer_Value( cursor, 7 );
      end if;
      if not gse.Is_Null( cursor, 8 )then
         a_adult.abspar := gse.Integer_Value( cursor, 8 );
      end if;
      if not gse.Is_Null( cursor, 9 )then
         a_adult.abspay := gse.Integer_Value( cursor, 9 );
      end if;
      if not gse.Is_Null( cursor, 10 )then
         a_adult.abswhy := gse.Integer_Value( cursor, 10 );
      end if;
      if not gse.Is_Null( cursor, 11 )then
         a_adult.abswk := gse.Integer_Value( cursor, 11 );
      end if;
      if not gse.Is_Null( cursor, 12 )then
         a_adult.x_access := gse.Integer_Value( cursor, 12 );
      end if;
      if not gse.Is_Null( cursor, 13 )then
         a_adult.accftpt := gse.Integer_Value( cursor, 13 );
      end if;
      if not gse.Is_Null( cursor, 14 )then
         a_adult.accjb := gse.Integer_Value( cursor, 14 );
      end if;
      if not gse.Is_Null( cursor, 15 )then
         a_adult.accssamt:= Amount'Value( gse.Value( cursor, 15 ));
      end if;
      if not gse.Is_Null( cursor, 16 )then
         a_adult.accsspd := gse.Integer_Value( cursor, 16 );
      end if;
      if not gse.Is_Null( cursor, 17 )then
         a_adult.adeduc := gse.Integer_Value( cursor, 17 );
      end if;
      if not gse.Is_Null( cursor, 18 )then
         a_adult.adema := gse.Integer_Value( cursor, 18 );
      end if;
      if not gse.Is_Null( cursor, 19 )then
         a_adult.ademaamt:= Amount'Value( gse.Value( cursor, 19 ));
      end if;
      if not gse.Is_Null( cursor, 20 )then
         a_adult.ademapd := gse.Integer_Value( cursor, 20 );
      end if;
      if not gse.Is_Null( cursor, 21 )then
         a_adult.age := gse.Integer_Value( cursor, 21 );
      end if;
      if not gse.Is_Null( cursor, 22 )then
         a_adult.allow1 := gse.Integer_Value( cursor, 22 );
      end if;
      if not gse.Is_Null( cursor, 23 )then
         a_adult.allow2 := gse.Integer_Value( cursor, 23 );
      end if;
      if not gse.Is_Null( cursor, 24 )then
         a_adult.allow3 := gse.Integer_Value( cursor, 24 );
      end if;
      if not gse.Is_Null( cursor, 25 )then
         a_adult.allow4 := gse.Integer_Value( cursor, 25 );
      end if;
      if not gse.Is_Null( cursor, 26 )then
         a_adult.allpay1:= Amount'Value( gse.Value( cursor, 26 ));
      end if;
      if not gse.Is_Null( cursor, 27 )then
         a_adult.allpay2:= Amount'Value( gse.Value( cursor, 27 ));
      end if;
      if not gse.Is_Null( cursor, 28 )then
         a_adult.allpay3:= Amount'Value( gse.Value( cursor, 28 ));
      end if;
      if not gse.Is_Null( cursor, 29 )then
         a_adult.allpay4:= Amount'Value( gse.Value( cursor, 29 ));
      end if;
      if not gse.Is_Null( cursor, 30 )then
         a_adult.allpd1 := gse.Integer_Value( cursor, 30 );
      end if;
      if not gse.Is_Null( cursor, 31 )then
         a_adult.allpd2 := gse.Integer_Value( cursor, 31 );
      end if;
      if not gse.Is_Null( cursor, 32 )then
         a_adult.allpd3 := gse.Integer_Value( cursor, 32 );
      end if;
      if not gse.Is_Null( cursor, 33 )then
         a_adult.allpd4 := gse.Integer_Value( cursor, 33 );
      end if;
      if not gse.Is_Null( cursor, 34 )then
         a_adult.anyacc := gse.Integer_Value( cursor, 34 );
      end if;
      if not gse.Is_Null( cursor, 35 )then
         a_adult.anyed := gse.Integer_Value( cursor, 35 );
      end if;
      if not gse.Is_Null( cursor, 36 )then
         a_adult.anymon := gse.Integer_Value( cursor, 36 );
      end if;
      if not gse.Is_Null( cursor, 37 )then
         a_adult.anypen1 := gse.Integer_Value( cursor, 37 );
      end if;
      if not gse.Is_Null( cursor, 38 )then
         a_adult.anypen2 := gse.Integer_Value( cursor, 38 );
      end if;
      if not gse.Is_Null( cursor, 39 )then
         a_adult.anypen3 := gse.Integer_Value( cursor, 39 );
      end if;
      if not gse.Is_Null( cursor, 40 )then
         a_adult.anypen4 := gse.Integer_Value( cursor, 40 );
      end if;
      if not gse.Is_Null( cursor, 41 )then
         a_adult.anypen5 := gse.Integer_Value( cursor, 41 );
      end if;
      if not gse.Is_Null( cursor, 42 )then
         a_adult.anypen6 := gse.Integer_Value( cursor, 42 );
      end if;
      if not gse.Is_Null( cursor, 43 )then
         a_adult.anypen7 := gse.Integer_Value( cursor, 43 );
      end if;
      if not gse.Is_Null( cursor, 44 )then
         a_adult.apamt:= Amount'Value( gse.Value( cursor, 44 ));
      end if;
      if not gse.Is_Null( cursor, 45 )then
         a_adult.apdamt:= Amount'Value( gse.Value( cursor, 45 ));
      end if;
      if not gse.Is_Null( cursor, 46 )then
         a_adult.apdir := gse.Integer_Value( cursor, 46 );
      end if;
      if not gse.Is_Null( cursor, 47 )then
         a_adult.apdpd := gse.Integer_Value( cursor, 47 );
      end if;
      if not gse.Is_Null( cursor, 48 )then
         a_adult.appd := gse.Integer_Value( cursor, 48 );
      end if;
      if not gse.Is_Null( cursor, 49 )then
         a_adult.b2qfut1 := gse.Integer_Value( cursor, 49 );
      end if;
      if not gse.Is_Null( cursor, 50 )then
         a_adult.b2qfut2 := gse.Integer_Value( cursor, 50 );
      end if;
      if not gse.Is_Null( cursor, 51 )then
         a_adult.b2qfut3 := gse.Integer_Value( cursor, 51 );
      end if;
      if not gse.Is_Null( cursor, 52 )then
         a_adult.b3qfut1 := gse.Integer_Value( cursor, 52 );
      end if;
      if not gse.Is_Null( cursor, 53 )then
         a_adult.b3qfut2 := gse.Integer_Value( cursor, 53 );
      end if;
      if not gse.Is_Null( cursor, 54 )then
         a_adult.b3qfut3 := gse.Integer_Value( cursor, 54 );
      end if;
      if not gse.Is_Null( cursor, 55 )then
         a_adult.b3qfut4 := gse.Integer_Value( cursor, 55 );
      end if;
      if not gse.Is_Null( cursor, 56 )then
         a_adult.b3qfut5 := gse.Integer_Value( cursor, 56 );
      end if;
      if not gse.Is_Null( cursor, 57 )then
         a_adult.b3qfut6 := gse.Integer_Value( cursor, 57 );
      end if;
      if not gse.Is_Null( cursor, 58 )then
         a_adult.ben1q1 := gse.Integer_Value( cursor, 58 );
      end if;
      if not gse.Is_Null( cursor, 59 )then
         a_adult.ben1q2 := gse.Integer_Value( cursor, 59 );
      end if;
      if not gse.Is_Null( cursor, 60 )then
         a_adult.ben1q3 := gse.Integer_Value( cursor, 60 );
      end if;
      if not gse.Is_Null( cursor, 61 )then
         a_adult.ben1q4 := gse.Integer_Value( cursor, 61 );
      end if;
      if not gse.Is_Null( cursor, 62 )then
         a_adult.ben1q5 := gse.Integer_Value( cursor, 62 );
      end if;
      if not gse.Is_Null( cursor, 63 )then
         a_adult.ben1q6 := gse.Integer_Value( cursor, 63 );
      end if;
      if not gse.Is_Null( cursor, 64 )then
         a_adult.ben1q7 := gse.Integer_Value( cursor, 64 );
      end if;
      if not gse.Is_Null( cursor, 65 )then
         a_adult.ben2q1 := gse.Integer_Value( cursor, 65 );
      end if;
      if not gse.Is_Null( cursor, 66 )then
         a_adult.ben2q2 := gse.Integer_Value( cursor, 66 );
      end if;
      if not gse.Is_Null( cursor, 67 )then
         a_adult.ben2q3 := gse.Integer_Value( cursor, 67 );
      end if;
      if not gse.Is_Null( cursor, 68 )then
         a_adult.ben3q1 := gse.Integer_Value( cursor, 68 );
      end if;
      if not gse.Is_Null( cursor, 69 )then
         a_adult.ben3q2 := gse.Integer_Value( cursor, 69 );
      end if;
      if not gse.Is_Null( cursor, 70 )then
         a_adult.ben3q3 := gse.Integer_Value( cursor, 70 );
      end if;
      if not gse.Is_Null( cursor, 71 )then
         a_adult.ben3q4 := gse.Integer_Value( cursor, 71 );
      end if;
      if not gse.Is_Null( cursor, 72 )then
         a_adult.ben3q5 := gse.Integer_Value( cursor, 72 );
      end if;
      if not gse.Is_Null( cursor, 73 )then
         a_adult.ben3q6 := gse.Integer_Value( cursor, 73 );
      end if;
      if not gse.Is_Null( cursor, 74 )then
         a_adult.ben4q1 := gse.Integer_Value( cursor, 74 );
      end if;
      if not gse.Is_Null( cursor, 75 )then
         a_adult.ben4q2 := gse.Integer_Value( cursor, 75 );
      end if;
      if not gse.Is_Null( cursor, 76 )then
         a_adult.ben4q3 := gse.Integer_Value( cursor, 76 );
      end if;
      if not gse.Is_Null( cursor, 77 )then
         a_adult.ben5q1 := gse.Integer_Value( cursor, 77 );
      end if;
      if not gse.Is_Null( cursor, 78 )then
         a_adult.ben5q2 := gse.Integer_Value( cursor, 78 );
      end if;
      if not gse.Is_Null( cursor, 79 )then
         a_adult.ben5q3 := gse.Integer_Value( cursor, 79 );
      end if;
      if not gse.Is_Null( cursor, 80 )then
         a_adult.ben5q4 := gse.Integer_Value( cursor, 80 );
      end if;
      if not gse.Is_Null( cursor, 81 )then
         a_adult.ben5q5 := gse.Integer_Value( cursor, 81 );
      end if;
      if not gse.Is_Null( cursor, 82 )then
         a_adult.ben5q6 := gse.Integer_Value( cursor, 82 );
      end if;
      if not gse.Is_Null( cursor, 83 )then
         a_adult.ben7q1 := gse.Integer_Value( cursor, 83 );
      end if;
      if not gse.Is_Null( cursor, 84 )then
         a_adult.ben7q2 := gse.Integer_Value( cursor, 84 );
      end if;
      if not gse.Is_Null( cursor, 85 )then
         a_adult.ben7q3 := gse.Integer_Value( cursor, 85 );
      end if;
      if not gse.Is_Null( cursor, 86 )then
         a_adult.ben7q4 := gse.Integer_Value( cursor, 86 );
      end if;
      if not gse.Is_Null( cursor, 87 )then
         a_adult.ben7q5 := gse.Integer_Value( cursor, 87 );
      end if;
      if not gse.Is_Null( cursor, 88 )then
         a_adult.ben7q6 := gse.Integer_Value( cursor, 88 );
      end if;
      if not gse.Is_Null( cursor, 89 )then
         a_adult.ben7q7 := gse.Integer_Value( cursor, 89 );
      end if;
      if not gse.Is_Null( cursor, 90 )then
         a_adult.ben7q8 := gse.Integer_Value( cursor, 90 );
      end if;
      if not gse.Is_Null( cursor, 91 )then
         a_adult.ben7q9 := gse.Integer_Value( cursor, 91 );
      end if;
      if not gse.Is_Null( cursor, 92 )then
         a_adult.btwacc := gse.Integer_Value( cursor, 92 );
      end if;
      if not gse.Is_Null( cursor, 93 )then
         a_adult.claimant := gse.Integer_Value( cursor, 93 );
      end if;
      if not gse.Is_Null( cursor, 94 )then
         a_adult.cohabit := gse.Integer_Value( cursor, 94 );
      end if;
      if not gse.Is_Null( cursor, 95 )then
         a_adult.combid := gse.Integer_Value( cursor, 95 );
      end if;
      if not gse.Is_Null( cursor, 96 )then
         a_adult.convbl := gse.Integer_Value( cursor, 96 );
      end if;
      if not gse.Is_Null( cursor, 97 )then
         a_adult.ctclum1 := gse.Integer_Value( cursor, 97 );
      end if;
      if not gse.Is_Null( cursor, 98 )then
         a_adult.ctclum2 := gse.Integer_Value( cursor, 98 );
      end if;
      if not gse.Is_Null( cursor, 99 )then
         a_adult.cupchk := gse.Integer_Value( cursor, 99 );
      end if;
      if not gse.Is_Null( cursor, 100 )then
         a_adult.cvht := gse.Integer_Value( cursor, 100 );
      end if;
      if not gse.Is_Null( cursor, 101 )then
         a_adult.cvpay:= Amount'Value( gse.Value( cursor, 101 ));
      end if;
      if not gse.Is_Null( cursor, 102 )then
         a_adult.cvpd := gse.Integer_Value( cursor, 102 );
      end if;
      if not gse.Is_Null( cursor, 103 )then
         a_adult.dentist := gse.Integer_Value( cursor, 103 );
      end if;
      if not gse.Is_Null( cursor, 104 )then
         a_adult.depend := gse.Integer_Value( cursor, 104 );
      end if;
      if not gse.Is_Null( cursor, 105 )then
         a_adult.disdif1 := gse.Integer_Value( cursor, 105 );
      end if;
      if not gse.Is_Null( cursor, 106 )then
         a_adult.disdif2 := gse.Integer_Value( cursor, 106 );
      end if;
      if not gse.Is_Null( cursor, 107 )then
         a_adult.disdif3 := gse.Integer_Value( cursor, 107 );
      end if;
      if not gse.Is_Null( cursor, 108 )then
         a_adult.disdif4 := gse.Integer_Value( cursor, 108 );
      end if;
      if not gse.Is_Null( cursor, 109 )then
         a_adult.disdif5 := gse.Integer_Value( cursor, 109 );
      end if;
      if not gse.Is_Null( cursor, 110 )then
         a_adult.disdif6 := gse.Integer_Value( cursor, 110 );
      end if;
      if not gse.Is_Null( cursor, 111 )then
         a_adult.disdif7 := gse.Integer_Value( cursor, 111 );
      end if;
      if not gse.Is_Null( cursor, 112 )then
         a_adult.disdif8 := gse.Integer_Value( cursor, 112 );
      end if;
      if not gse.Is_Null( cursor, 113 )then
         a_adult.dob := gse.Time_Value( cursor, 113 );
      end if;
      if not gse.Is_Null( cursor, 114 )then
         a_adult.dptcboth := gse.Integer_Value( cursor, 114 );
      end if;
      if not gse.Is_Null( cursor, 115 )then
         a_adult.dptclum := gse.Integer_Value( cursor, 115 );
      end if;
      if not gse.Is_Null( cursor, 116 )then
         a_adult.dvil03a := gse.Integer_Value( cursor, 116 );
      end if;
      if not gse.Is_Null( cursor, 117 )then
         a_adult.dvil04a := gse.Integer_Value( cursor, 117 );
      end if;
      if not gse.Is_Null( cursor, 118 )then
         a_adult.dvjb12ml := gse.Integer_Value( cursor, 118 );
      end if;
      if not gse.Is_Null( cursor, 119 )then
         a_adult.dvmardf := gse.Integer_Value( cursor, 119 );
      end if;
      if not gse.Is_Null( cursor, 120 )then
         a_adult.ed1amt:= Amount'Value( gse.Value( cursor, 120 ));
      end if;
      if not gse.Is_Null( cursor, 121 )then
         a_adult.ed1borr := gse.Integer_Value( cursor, 121 );
      end if;
      if not gse.Is_Null( cursor, 122 )then
         a_adult.ed1int := gse.Integer_Value( cursor, 122 );
      end if;
      if not gse.Is_Null( cursor, 123 )then
         a_adult.ed1monyr := gse.Time_Value( cursor, 123 );
      end if;
      if not gse.Is_Null( cursor, 124 )then
         a_adult.ed1pd := gse.Integer_Value( cursor, 124 );
      end if;
      if not gse.Is_Null( cursor, 125 )then
         a_adult.ed1sum := gse.Integer_Value( cursor, 125 );
      end if;
      if not gse.Is_Null( cursor, 126 )then
         a_adult.ed2amt:= Amount'Value( gse.Value( cursor, 126 ));
      end if;
      if not gse.Is_Null( cursor, 127 )then
         a_adult.ed2borr := gse.Integer_Value( cursor, 127 );
      end if;
      if not gse.Is_Null( cursor, 128 )then
         a_adult.ed2int := gse.Integer_Value( cursor, 128 );
      end if;
      if not gse.Is_Null( cursor, 129 )then
         a_adult.ed2monyr := gse.Time_Value( cursor, 129 );
      end if;
      if not gse.Is_Null( cursor, 130 )then
         a_adult.ed2pd := gse.Integer_Value( cursor, 130 );
      end if;
      if not gse.Is_Null( cursor, 131 )then
         a_adult.ed2sum := gse.Integer_Value( cursor, 131 );
      end if;
      if not gse.Is_Null( cursor, 132 )then
         a_adult.edatt := gse.Integer_Value( cursor, 132 );
      end if;
      if not gse.Is_Null( cursor, 133 )then
         a_adult.edattn1 := gse.Integer_Value( cursor, 133 );
      end if;
      if not gse.Is_Null( cursor, 134 )then
         a_adult.edattn2 := gse.Integer_Value( cursor, 134 );
      end if;
      if not gse.Is_Null( cursor, 135 )then
         a_adult.edattn3 := gse.Integer_Value( cursor, 135 );
      end if;
      if not gse.Is_Null( cursor, 136 )then
         a_adult.edhr := gse.Integer_Value( cursor, 136 );
      end if;
      if not gse.Is_Null( cursor, 137 )then
         a_adult.edtime := gse.Integer_Value( cursor, 137 );
      end if;
      if not gse.Is_Null( cursor, 138 )then
         a_adult.edtyp := gse.Integer_Value( cursor, 138 );
      end if;
      if not gse.Is_Null( cursor, 139 )then
         a_adult.eligadlt := gse.Integer_Value( cursor, 139 );
      end if;
      if not gse.Is_Null( cursor, 140 )then
         a_adult.eligchld := gse.Integer_Value( cursor, 140 );
      end if;
      if not gse.Is_Null( cursor, 141 )then
         a_adult.emppay1 := gse.Integer_Value( cursor, 141 );
      end if;
      if not gse.Is_Null( cursor, 142 )then
         a_adult.emppay2 := gse.Integer_Value( cursor, 142 );
      end if;
      if not gse.Is_Null( cursor, 143 )then
         a_adult.emppay3 := gse.Integer_Value( cursor, 143 );
      end if;
      if not gse.Is_Null( cursor, 144 )then
         a_adult.empstat := gse.Integer_Value( cursor, 144 );
      end if;
      if not gse.Is_Null( cursor, 145 )then
         a_adult.endyr := gse.Integer_Value( cursor, 145 );
      end if;
      if not gse.Is_Null( cursor, 146 )then
         a_adult.epcur := gse.Integer_Value( cursor, 146 );
      end if;
      if not gse.Is_Null( cursor, 147 )then
         a_adult.es2000 := gse.Integer_Value( cursor, 147 );
      end if;
      if not gse.Is_Null( cursor, 148 )then
         a_adult.ethgrp := gse.Integer_Value( cursor, 148 );
      end if;
      if not gse.Is_Null( cursor, 149 )then
         a_adult.everwrk := gse.Integer_Value( cursor, 149 );
      end if;
      if not gse.Is_Null( cursor, 150 )then
         a_adult.exthbct1 := gse.Integer_Value( cursor, 150 );
      end if;
      if not gse.Is_Null( cursor, 151 )then
         a_adult.exthbct2 := gse.Integer_Value( cursor, 151 );
      end if;
      if not gse.Is_Null( cursor, 152 )then
         a_adult.exthbct3 := gse.Integer_Value( cursor, 152 );
      end if;
      if not gse.Is_Null( cursor, 153 )then
         a_adult.eyetest := gse.Integer_Value( cursor, 153 );
      end if;
      if not gse.Is_Null( cursor, 154 )then
         a_adult.follow := gse.Integer_Value( cursor, 154 );
      end if;
      if not gse.Is_Null( cursor, 155 )then
         a_adult.fted := gse.Integer_Value( cursor, 155 );
      end if;
      if not gse.Is_Null( cursor, 156 )then
         a_adult.ftwk := gse.Integer_Value( cursor, 156 );
      end if;
      if not gse.Is_Null( cursor, 157 )then
         a_adult.future := gse.Integer_Value( cursor, 157 );
      end if;
      if not gse.Is_Null( cursor, 158 )then
         a_adult.govpis := gse.Integer_Value( cursor, 158 );
      end if;
      if not gse.Is_Null( cursor, 159 )then
         a_adult.govpjsa := gse.Integer_Value( cursor, 159 );
      end if;
      if not gse.Is_Null( cursor, 160 )then
         a_adult.x_grant := gse.Integer_Value( cursor, 160 );
      end if;
      if not gse.Is_Null( cursor, 161 )then
         a_adult.grtamt1:= Amount'Value( gse.Value( cursor, 161 ));
      end if;
      if not gse.Is_Null( cursor, 162 )then
         a_adult.grtamt2:= Amount'Value( gse.Value( cursor, 162 ));
      end if;
      if not gse.Is_Null( cursor, 163 )then
         a_adult.grtdir1:= Amount'Value( gse.Value( cursor, 163 ));
      end if;
      if not gse.Is_Null( cursor, 164 )then
         a_adult.grtdir2:= Amount'Value( gse.Value( cursor, 164 ));
      end if;
      if not gse.Is_Null( cursor, 165 )then
         a_adult.grtnum := gse.Integer_Value( cursor, 165 );
      end if;
      if not gse.Is_Null( cursor, 166 )then
         a_adult.grtsce1 := gse.Integer_Value( cursor, 166 );
      end if;
      if not gse.Is_Null( cursor, 167 )then
         a_adult.grtsce2 := gse.Integer_Value( cursor, 167 );
      end if;
      if not gse.Is_Null( cursor, 168 )then
         a_adult.grtval1:= Amount'Value( gse.Value( cursor, 168 ));
      end if;
      if not gse.Is_Null( cursor, 169 )then
         a_adult.grtval2:= Amount'Value( gse.Value( cursor, 169 ));
      end if;
      if not gse.Is_Null( cursor, 170 )then
         a_adult.gta := gse.Integer_Value( cursor, 170 );
      end if;
      if not gse.Is_Null( cursor, 171 )then
         a_adult.hbothamt:= Amount'Value( gse.Value( cursor, 171 ));
      end if;
      if not gse.Is_Null( cursor, 172 )then
         a_adult.hbothbu := gse.Integer_Value( cursor, 172 );
      end if;
      if not gse.Is_Null( cursor, 173 )then
         a_adult.hbothpd := gse.Integer_Value( cursor, 173 );
      end if;
      if not gse.Is_Null( cursor, 174 )then
         a_adult.hbothwk := gse.Integer_Value( cursor, 174 );
      end if;
      if not gse.Is_Null( cursor, 175 )then
         a_adult.hbotwait := gse.Integer_Value( cursor, 175 );
      end if;
      if not gse.Is_Null( cursor, 176 )then
         a_adult.health := gse.Integer_Value( cursor, 176 );
      end if;
      if not gse.Is_Null( cursor, 177 )then
         a_adult.hholder := gse.Integer_Value( cursor, 177 );
      end if;
      if not gse.Is_Null( cursor, 178 )then
         a_adult.hosp := gse.Integer_Value( cursor, 178 );
      end if;
      if not gse.Is_Null( cursor, 179 )then
         a_adult.hprob := gse.Integer_Value( cursor, 179 );
      end if;
      if not gse.Is_Null( cursor, 180 )then
         a_adult.hrpid := gse.Integer_Value( cursor, 180 );
      end if;
      if not gse.Is_Null( cursor, 181 )then
         a_adult.incdur := gse.Integer_Value( cursor, 181 );
      end if;
      if not gse.Is_Null( cursor, 182 )then
         a_adult.injlong := gse.Integer_Value( cursor, 182 );
      end if;
      if not gse.Is_Null( cursor, 183 )then
         a_adult.injwk := gse.Integer_Value( cursor, 183 );
      end if;
      if not gse.Is_Null( cursor, 184 )then
         a_adult.invests := gse.Integer_Value( cursor, 184 );
      end if;
      if not gse.Is_Null( cursor, 185 )then
         a_adult.iout := gse.Integer_Value( cursor, 185 );
      end if;
      if not gse.Is_Null( cursor, 186 )then
         a_adult.isa1type := gse.Integer_Value( cursor, 186 );
      end if;
      if not gse.Is_Null( cursor, 187 )then
         a_adult.isa2type := gse.Integer_Value( cursor, 187 );
      end if;
      if not gse.Is_Null( cursor, 188 )then
         a_adult.isa3type := gse.Integer_Value( cursor, 188 );
      end if;
      if not gse.Is_Null( cursor, 189 )then
         a_adult.jobaway := gse.Integer_Value( cursor, 189 );
      end if;
      if not gse.Is_Null( cursor, 190 )then
         a_adult.lareg := gse.Integer_Value( cursor, 190 );
      end if;
      if not gse.Is_Null( cursor, 191 )then
         a_adult.likewk := gse.Integer_Value( cursor, 191 );
      end if;
      if not gse.Is_Null( cursor, 192 )then
         a_adult.lktime := gse.Integer_Value( cursor, 192 );
      end if;
      if not gse.Is_Null( cursor, 193 )then
         a_adult.ln1rpint := gse.Integer_Value( cursor, 193 );
      end if;
      if not gse.Is_Null( cursor, 194 )then
         a_adult.ln2rpint := gse.Integer_Value( cursor, 194 );
      end if;
      if not gse.Is_Null( cursor, 195 )then
         a_adult.loan := gse.Integer_Value( cursor, 195 );
      end if;
      if not gse.Is_Null( cursor, 196 )then
         a_adult.loannum := gse.Integer_Value( cursor, 196 );
      end if;
      if not gse.Is_Null( cursor, 197 )then
         a_adult.look := gse.Integer_Value( cursor, 197 );
      end if;
      if not gse.Is_Null( cursor, 198 )then
         a_adult.lookwk := gse.Integer_Value( cursor, 198 );
      end if;
      if not gse.Is_Null( cursor, 199 )then
         a_adult.lstwrk1 := gse.Integer_Value( cursor, 199 );
      end if;
      if not gse.Is_Null( cursor, 200 )then
         a_adult.lstwrk2 := gse.Integer_Value( cursor, 200 );
      end if;
      if not gse.Is_Null( cursor, 201 )then
         a_adult.lstyr := gse.Integer_Value( cursor, 201 );
      end if;
      if not gse.Is_Null( cursor, 202 )then
         a_adult.mntamt1:= Amount'Value( gse.Value( cursor, 202 ));
      end if;
      if not gse.Is_Null( cursor, 203 )then
         a_adult.mntamt2:= Amount'Value( gse.Value( cursor, 203 ));
      end if;
      if not gse.Is_Null( cursor, 204 )then
         a_adult.mntct := gse.Integer_Value( cursor, 204 );
      end if;
      if not gse.Is_Null( cursor, 205 )then
         a_adult.mntfor1 := gse.Integer_Value( cursor, 205 );
      end if;
      if not gse.Is_Null( cursor, 206 )then
         a_adult.mntfor2 := gse.Integer_Value( cursor, 206 );
      end if;
      if not gse.Is_Null( cursor, 207 )then
         a_adult.mntgov1 := gse.Integer_Value( cursor, 207 );
      end if;
      if not gse.Is_Null( cursor, 208 )then
         a_adult.mntgov2 := gse.Integer_Value( cursor, 208 );
      end if;
      if not gse.Is_Null( cursor, 209 )then
         a_adult.mntpay := gse.Integer_Value( cursor, 209 );
      end if;
      if not gse.Is_Null( cursor, 210 )then
         a_adult.mntpd1 := gse.Integer_Value( cursor, 210 );
      end if;
      if not gse.Is_Null( cursor, 211 )then
         a_adult.mntpd2 := gse.Integer_Value( cursor, 211 );
      end if;
      if not gse.Is_Null( cursor, 212 )then
         a_adult.mntrec := gse.Integer_Value( cursor, 212 );
      end if;
      if not gse.Is_Null( cursor, 213 )then
         a_adult.mnttota1 := gse.Integer_Value( cursor, 213 );
      end if;
      if not gse.Is_Null( cursor, 214 )then
         a_adult.mnttota2 := gse.Integer_Value( cursor, 214 );
      end if;
      if not gse.Is_Null( cursor, 215 )then
         a_adult.mntus1 := gse.Integer_Value( cursor, 215 );
      end if;
      if not gse.Is_Null( cursor, 216 )then
         a_adult.mntus2 := gse.Integer_Value( cursor, 216 );
      end if;
      if not gse.Is_Null( cursor, 217 )then
         a_adult.mntusam1:= Amount'Value( gse.Value( cursor, 217 ));
      end if;
      if not gse.Is_Null( cursor, 218 )then
         a_adult.mntusam2:= Amount'Value( gse.Value( cursor, 218 ));
      end if;
      if not gse.Is_Null( cursor, 219 )then
         a_adult.mntuspd1 := gse.Integer_Value( cursor, 219 );
      end if;
      if not gse.Is_Null( cursor, 220 )then
         a_adult.mntuspd2 := gse.Integer_Value( cursor, 220 );
      end if;
      if not gse.Is_Null( cursor, 221 )then
         a_adult.ms := gse.Integer_Value( cursor, 221 );
      end if;
      if not gse.Is_Null( cursor, 222 )then
         a_adult.natid1 := gse.Integer_Value( cursor, 222 );
      end if;
      if not gse.Is_Null( cursor, 223 )then
         a_adult.natid2 := gse.Integer_Value( cursor, 223 );
      end if;
      if not gse.Is_Null( cursor, 224 )then
         a_adult.natid3 := gse.Integer_Value( cursor, 224 );
      end if;
      if not gse.Is_Null( cursor, 225 )then
         a_adult.natid4 := gse.Integer_Value( cursor, 225 );
      end if;
      if not gse.Is_Null( cursor, 226 )then
         a_adult.natid5 := gse.Integer_Value( cursor, 226 );
      end if;
      if not gse.Is_Null( cursor, 227 )then
         a_adult.natid6 := gse.Integer_Value( cursor, 227 );
      end if;
      if not gse.Is_Null( cursor, 228 )then
         a_adult.ndeal := gse.Integer_Value( cursor, 228 );
      end if;
      if not gse.Is_Null( cursor, 229 )then
         a_adult.newdtype := gse.Integer_Value( cursor, 229 );
      end if;
      if not gse.Is_Null( cursor, 230 )then
         a_adult.nhs1 := gse.Integer_Value( cursor, 230 );
      end if;
      if not gse.Is_Null( cursor, 231 )then
         a_adult.nhs2 := gse.Integer_Value( cursor, 231 );
      end if;
      if not gse.Is_Null( cursor, 232 )then
         a_adult.nhs3 := gse.Integer_Value( cursor, 232 );
      end if;
      if not gse.Is_Null( cursor, 233 )then
         a_adult.niamt:= Amount'Value( gse.Value( cursor, 233 ));
      end if;
      if not gse.Is_Null( cursor, 234 )then
         a_adult.niethgrp := gse.Integer_Value( cursor, 234 );
      end if;
      if not gse.Is_Null( cursor, 235 )then
         a_adult.niexthbb := gse.Integer_Value( cursor, 235 );
      end if;
      if not gse.Is_Null( cursor, 236 )then
         a_adult.ninatid1 := gse.Integer_Value( cursor, 236 );
      end if;
      if not gse.Is_Null( cursor, 237 )then
         a_adult.ninatid2 := gse.Integer_Value( cursor, 237 );
      end if;
      if not gse.Is_Null( cursor, 238 )then
         a_adult.ninatid3 := gse.Integer_Value( cursor, 238 );
      end if;
      if not gse.Is_Null( cursor, 239 )then
         a_adult.ninatid4 := gse.Integer_Value( cursor, 239 );
      end if;
      if not gse.Is_Null( cursor, 240 )then
         a_adult.ninatid5 := gse.Integer_Value( cursor, 240 );
      end if;
      if not gse.Is_Null( cursor, 241 )then
         a_adult.ninatid6 := gse.Integer_Value( cursor, 241 );
      end if;
      if not gse.Is_Null( cursor, 242 )then
         a_adult.ninatid7 := gse.Integer_Value( cursor, 242 );
      end if;
      if not gse.Is_Null( cursor, 243 )then
         a_adult.ninatid8 := gse.Integer_Value( cursor, 243 );
      end if;
      if not gse.Is_Null( cursor, 244 )then
         a_adult.nipd := gse.Integer_Value( cursor, 244 );
      end if;
      if not gse.Is_Null( cursor, 245 )then
         a_adult.nireg := gse.Integer_Value( cursor, 245 );
      end if;
      if not gse.Is_Null( cursor, 246 )then
         a_adult.nirel := gse.Integer_Value( cursor, 246 );
      end if;
      if not gse.Is_Null( cursor, 247 )then
         a_adult.nitrain := gse.Integer_Value( cursor, 247 );
      end if;
      if not gse.Is_Null( cursor, 248 )then
         a_adult.nlper := gse.Integer_Value( cursor, 248 );
      end if;
      if not gse.Is_Null( cursor, 249 )then
         a_adult.nolk1 := gse.Integer_Value( cursor, 249 );
      end if;
      if not gse.Is_Null( cursor, 250 )then
         a_adult.nolk2 := gse.Integer_Value( cursor, 250 );
      end if;
      if not gse.Is_Null( cursor, 251 )then
         a_adult.nolk3 := gse.Integer_Value( cursor, 251 );
      end if;
      if not gse.Is_Null( cursor, 252 )then
         a_adult.nolook := gse.Integer_Value( cursor, 252 );
      end if;
      if not gse.Is_Null( cursor, 253 )then
         a_adult.nowant := gse.Integer_Value( cursor, 253 );
      end if;
      if not gse.Is_Null( cursor, 254 )then
         a_adult.nssec:= Amount'Value( gse.Value( cursor, 254 ));
      end if;
      if not gse.Is_Null( cursor, 255 )then
         a_adult.ntcapp := gse.Integer_Value( cursor, 255 );
      end if;
      if not gse.Is_Null( cursor, 256 )then
         a_adult.ntcdat := gse.Integer_Value( cursor, 256 );
      end if;
      if not gse.Is_Null( cursor, 257 )then
         a_adult.ntcinc:= Amount'Value( gse.Value( cursor, 257 ));
      end if;
      if not gse.Is_Null( cursor, 258 )then
         a_adult.ntcorig1 := gse.Integer_Value( cursor, 258 );
      end if;
      if not gse.Is_Null( cursor, 259 )then
         a_adult.ntcorig2 := gse.Integer_Value( cursor, 259 );
      end if;
      if not gse.Is_Null( cursor, 260 )then
         a_adult.ntcorig3 := gse.Integer_Value( cursor, 260 );
      end if;
      if not gse.Is_Null( cursor, 261 )then
         a_adult.ntcorig4 := gse.Integer_Value( cursor, 261 );
      end if;
      if not gse.Is_Null( cursor, 262 )then
         a_adult.ntcorig5 := gse.Integer_Value( cursor, 262 );
      end if;
      if not gse.Is_Null( cursor, 263 )then
         a_adult.numjob := gse.Integer_Value( cursor, 263 );
      end if;
      if not gse.Is_Null( cursor, 264 )then
         a_adult.numjob2 := gse.Integer_Value( cursor, 264 );
      end if;
      if not gse.Is_Null( cursor, 265 )then
         a_adult.oddjob := gse.Integer_Value( cursor, 265 );
      end if;
      if not gse.Is_Null( cursor, 266 )then
         a_adult.oldstud := gse.Integer_Value( cursor, 266 );
      end if;
      if not gse.Is_Null( cursor, 267 )then
         a_adult.otabspar := gse.Integer_Value( cursor, 267 );
      end if;
      if not gse.Is_Null( cursor, 268 )then
         a_adult.otamt:= Amount'Value( gse.Value( cursor, 268 ));
      end if;
      if not gse.Is_Null( cursor, 269 )then
         a_adult.otapamt:= Amount'Value( gse.Value( cursor, 269 ));
      end if;
      if not gse.Is_Null( cursor, 270 )then
         a_adult.otappd := gse.Integer_Value( cursor, 270 );
      end if;
      if not gse.Is_Null( cursor, 271 )then
         a_adult.othtax := gse.Integer_Value( cursor, 271 );
      end if;
      if not gse.Is_Null( cursor, 272 )then
         a_adult.otinva := gse.Integer_Value( cursor, 272 );
      end if;
      if not gse.Is_Null( cursor, 273 )then
         a_adult.pareamt:= Amount'Value( gse.Value( cursor, 273 ));
      end if;
      if not gse.Is_Null( cursor, 274 )then
         a_adult.parepd := gse.Integer_Value( cursor, 274 );
      end if;
      if not gse.Is_Null( cursor, 275 )then
         a_adult.penlump := gse.Integer_Value( cursor, 275 );
      end if;
      if not gse.Is_Null( cursor, 276 )then
         a_adult.ppnumc := gse.Integer_Value( cursor, 276 );
      end if;
      if not gse.Is_Null( cursor, 277 )then
         a_adult.prit := gse.Integer_Value( cursor, 277 );
      end if;
      if not gse.Is_Null( cursor, 278 )then
         a_adult.prscrpt := gse.Integer_Value( cursor, 278 );
      end if;
      if not gse.Is_Null( cursor, 279 )then
         a_adult.ptwk := gse.Integer_Value( cursor, 279 );
      end if;
      if not gse.Is_Null( cursor, 280 )then
         a_adult.r01 := gse.Integer_Value( cursor, 280 );
      end if;
      if not gse.Is_Null( cursor, 281 )then
         a_adult.r02 := gse.Integer_Value( cursor, 281 );
      end if;
      if not gse.Is_Null( cursor, 282 )then
         a_adult.r03 := gse.Integer_Value( cursor, 282 );
      end if;
      if not gse.Is_Null( cursor, 283 )then
         a_adult.r04 := gse.Integer_Value( cursor, 283 );
      end if;
      if not gse.Is_Null( cursor, 284 )then
         a_adult.r05 := gse.Integer_Value( cursor, 284 );
      end if;
      if not gse.Is_Null( cursor, 285 )then
         a_adult.r06 := gse.Integer_Value( cursor, 285 );
      end if;
      if not gse.Is_Null( cursor, 286 )then
         a_adult.r07 := gse.Integer_Value( cursor, 286 );
      end if;
      if not gse.Is_Null( cursor, 287 )then
         a_adult.r08 := gse.Integer_Value( cursor, 287 );
      end if;
      if not gse.Is_Null( cursor, 288 )then
         a_adult.r09 := gse.Integer_Value( cursor, 288 );
      end if;
      if not gse.Is_Null( cursor, 289 )then
         a_adult.r10 := gse.Integer_Value( cursor, 289 );
      end if;
      if not gse.Is_Null( cursor, 290 )then
         a_adult.r11 := gse.Integer_Value( cursor, 290 );
      end if;
      if not gse.Is_Null( cursor, 291 )then
         a_adult.r12 := gse.Integer_Value( cursor, 291 );
      end if;
      if not gse.Is_Null( cursor, 292 )then
         a_adult.r13 := gse.Integer_Value( cursor, 292 );
      end if;
      if not gse.Is_Null( cursor, 293 )then
         a_adult.r14 := gse.Integer_Value( cursor, 293 );
      end if;
      if not gse.Is_Null( cursor, 294 )then
         a_adult.redamt:= Amount'Value( gse.Value( cursor, 294 ));
      end if;
      if not gse.Is_Null( cursor, 295 )then
         a_adult.redany := gse.Integer_Value( cursor, 295 );
      end if;
      if not gse.Is_Null( cursor, 296 )then
         a_adult.rentprof := gse.Integer_Value( cursor, 296 );
      end if;
      if not gse.Is_Null( cursor, 297 )then
         a_adult.retire := gse.Integer_Value( cursor, 297 );
      end if;
      if not gse.Is_Null( cursor, 298 )then
         a_adult.retire1 := gse.Integer_Value( cursor, 298 );
      end if;
      if not gse.Is_Null( cursor, 299 )then
         a_adult.retreas := gse.Integer_Value( cursor, 299 );
      end if;
      if not gse.Is_Null( cursor, 300 )then
         a_adult.royal1 := gse.Integer_Value( cursor, 300 );
      end if;
      if not gse.Is_Null( cursor, 301 )then
         a_adult.royal2 := gse.Integer_Value( cursor, 301 );
      end if;
      if not gse.Is_Null( cursor, 302 )then
         a_adult.royal3 := gse.Integer_Value( cursor, 302 );
      end if;
      if not gse.Is_Null( cursor, 303 )then
         a_adult.royal4 := gse.Integer_Value( cursor, 303 );
      end if;
      if not gse.Is_Null( cursor, 304 )then
         a_adult.royyr1:= Amount'Value( gse.Value( cursor, 304 ));
      end if;
      if not gse.Is_Null( cursor, 305 )then
         a_adult.royyr2:= Amount'Value( gse.Value( cursor, 305 ));
      end if;
      if not gse.Is_Null( cursor, 306 )then
         a_adult.royyr3:= Amount'Value( gse.Value( cursor, 306 ));
      end if;
      if not gse.Is_Null( cursor, 307 )then
         a_adult.royyr4:= Amount'Value( gse.Value( cursor, 307 ));
      end if;
      if not gse.Is_Null( cursor, 308 )then
         a_adult.rstrct := gse.Integer_Value( cursor, 308 );
      end if;
      if not gse.Is_Null( cursor, 309 )then
         a_adult.sex := gse.Integer_Value( cursor, 309 );
      end if;
      if not gse.Is_Null( cursor, 310 )then
         a_adult.sflntyp1 := gse.Integer_Value( cursor, 310 );
      end if;
      if not gse.Is_Null( cursor, 311 )then
         a_adult.sflntyp2 := gse.Integer_Value( cursor, 311 );
      end if;
      if not gse.Is_Null( cursor, 312 )then
         a_adult.sftype1 := gse.Integer_Value( cursor, 312 );
      end if;
      if not gse.Is_Null( cursor, 313 )then
         a_adult.sftype2 := gse.Integer_Value( cursor, 313 );
      end if;
      if not gse.Is_Null( cursor, 314 )then
         a_adult.sic := gse.Integer_Value( cursor, 314 );
      end if;
      if not gse.Is_Null( cursor, 315 )then
         a_adult.slrepamt:= Amount'Value( gse.Value( cursor, 315 ));
      end if;
      if not gse.Is_Null( cursor, 316 )then
         a_adult.slrepay := gse.Integer_Value( cursor, 316 );
      end if;
      if not gse.Is_Null( cursor, 317 )then
         a_adult.slreppd := gse.Integer_Value( cursor, 317 );
      end if;
      if not gse.Is_Null( cursor, 318 )then
         a_adult.soc2000 := gse.Integer_Value( cursor, 318 );
      end if;
      if not gse.Is_Null( cursor, 319 )then
         a_adult.spcreg1 := gse.Integer_Value( cursor, 319 );
      end if;
      if not gse.Is_Null( cursor, 320 )then
         a_adult.spcreg2 := gse.Integer_Value( cursor, 320 );
      end if;
      if not gse.Is_Null( cursor, 321 )then
         a_adult.spcreg3 := gse.Integer_Value( cursor, 321 );
      end if;
      if not gse.Is_Null( cursor, 322 )then
         a_adult.specs := gse.Integer_Value( cursor, 322 );
      end if;
      if not gse.Is_Null( cursor, 323 )then
         a_adult.spout := gse.Integer_Value( cursor, 323 );
      end if;
      if not gse.Is_Null( cursor, 324 )then
         a_adult.srentamt:= Amount'Value( gse.Value( cursor, 324 ));
      end if;
      if not gse.Is_Null( cursor, 325 )then
         a_adult.srentpd := gse.Integer_Value( cursor, 325 );
      end if;
      if not gse.Is_Null( cursor, 326 )then
         a_adult.start := gse.Integer_Value( cursor, 326 );
      end if;
      if not gse.Is_Null( cursor, 327 )then
         a_adult.startyr := gse.Integer_Value( cursor, 327 );
      end if;
      if not gse.Is_Null( cursor, 328 )then
         a_adult.taxcred1 := gse.Integer_Value( cursor, 328 );
      end if;
      if not gse.Is_Null( cursor, 329 )then
         a_adult.taxcred2 := gse.Integer_Value( cursor, 329 );
      end if;
      if not gse.Is_Null( cursor, 330 )then
         a_adult.taxcred3 := gse.Integer_Value( cursor, 330 );
      end if;
      if not gse.Is_Null( cursor, 331 )then
         a_adult.taxcred4 := gse.Integer_Value( cursor, 331 );
      end if;
      if not gse.Is_Null( cursor, 332 )then
         a_adult.taxcred5 := gse.Integer_Value( cursor, 332 );
      end if;
      if not gse.Is_Null( cursor, 333 )then
         a_adult.taxfut := gse.Integer_Value( cursor, 333 );
      end if;
      if not gse.Is_Null( cursor, 334 )then
         a_adult.tdaywrk := gse.Integer_Value( cursor, 334 );
      end if;
      if not gse.Is_Null( cursor, 335 )then
         a_adult.tea := gse.Integer_Value( cursor, 335 );
      end if;
      if not gse.Is_Null( cursor, 336 )then
         a_adult.topupl := gse.Integer_Value( cursor, 336 );
      end if;
      if not gse.Is_Null( cursor, 337 )then
         a_adult.totint:= Amount'Value( gse.Value( cursor, 337 ));
      end if;
      if not gse.Is_Null( cursor, 338 )then
         a_adult.train := gse.Integer_Value( cursor, 338 );
      end if;
      if not gse.Is_Null( cursor, 339 )then
         a_adult.trav := gse.Integer_Value( cursor, 339 );
      end if;
      if not gse.Is_Null( cursor, 340 )then
         a_adult.tuborr := gse.Integer_Value( cursor, 340 );
      end if;
      if not gse.Is_Null( cursor, 341 )then
         a_adult.typeed := gse.Integer_Value( cursor, 341 );
      end if;
      if not gse.Is_Null( cursor, 342 )then
         a_adult.unpaid1 := gse.Integer_Value( cursor, 342 );
      end if;
      if not gse.Is_Null( cursor, 343 )then
         a_adult.unpaid2 := gse.Integer_Value( cursor, 343 );
      end if;
      if not gse.Is_Null( cursor, 344 )then
         a_adult.voucher := gse.Integer_Value( cursor, 344 );
      end if;
      if not gse.Is_Null( cursor, 345 )then
         a_adult.w1 := gse.Integer_Value( cursor, 345 );
      end if;
      if not gse.Is_Null( cursor, 346 )then
         a_adult.w2 := gse.Integer_Value( cursor, 346 );
      end if;
      if not gse.Is_Null( cursor, 347 )then
         a_adult.wait := gse.Integer_Value( cursor, 347 );
      end if;
      if not gse.Is_Null( cursor, 348 )then
         a_adult.war1 := gse.Integer_Value( cursor, 348 );
      end if;
      if not gse.Is_Null( cursor, 349 )then
         a_adult.war2 := gse.Integer_Value( cursor, 349 );
      end if;
      if not gse.Is_Null( cursor, 350 )then
         a_adult.wftcboth := gse.Integer_Value( cursor, 350 );
      end if;
      if not gse.Is_Null( cursor, 351 )then
         a_adult.wftclum := gse.Integer_Value( cursor, 351 );
      end if;
      if not gse.Is_Null( cursor, 352 )then
         a_adult.whoresp := gse.Integer_Value( cursor, 352 );
      end if;
      if not gse.Is_Null( cursor, 353 )then
         a_adult.whosectb := gse.Integer_Value( cursor, 353 );
      end if;
      if not gse.Is_Null( cursor, 354 )then
         a_adult.whyfrde1 := gse.Integer_Value( cursor, 354 );
      end if;
      if not gse.Is_Null( cursor, 355 )then
         a_adult.whyfrde2 := gse.Integer_Value( cursor, 355 );
      end if;
      if not gse.Is_Null( cursor, 356 )then
         a_adult.whyfrde3 := gse.Integer_Value( cursor, 356 );
      end if;
      if not gse.Is_Null( cursor, 357 )then
         a_adult.whyfrde4 := gse.Integer_Value( cursor, 357 );
      end if;
      if not gse.Is_Null( cursor, 358 )then
         a_adult.whyfrde5 := gse.Integer_Value( cursor, 358 );
      end if;
      if not gse.Is_Null( cursor, 359 )then
         a_adult.whyfrde6 := gse.Integer_Value( cursor, 359 );
      end if;
      if not gse.Is_Null( cursor, 360 )then
         a_adult.whyfrey1 := gse.Integer_Value( cursor, 360 );
      end if;
      if not gse.Is_Null( cursor, 361 )then
         a_adult.whyfrey2 := gse.Integer_Value( cursor, 361 );
      end if;
      if not gse.Is_Null( cursor, 362 )then
         a_adult.whyfrey3 := gse.Integer_Value( cursor, 362 );
      end if;
      if not gse.Is_Null( cursor, 363 )then
         a_adult.whyfrey4 := gse.Integer_Value( cursor, 363 );
      end if;
      if not gse.Is_Null( cursor, 364 )then
         a_adult.whyfrey5 := gse.Integer_Value( cursor, 364 );
      end if;
      if not gse.Is_Null( cursor, 365 )then
         a_adult.whyfrey6 := gse.Integer_Value( cursor, 365 );
      end if;
      if not gse.Is_Null( cursor, 366 )then
         a_adult.whyfrpr1 := gse.Integer_Value( cursor, 366 );
      end if;
      if not gse.Is_Null( cursor, 367 )then
         a_adult.whyfrpr2 := gse.Integer_Value( cursor, 367 );
      end if;
      if not gse.Is_Null( cursor, 368 )then
         a_adult.whyfrpr3 := gse.Integer_Value( cursor, 368 );
      end if;
      if not gse.Is_Null( cursor, 369 )then
         a_adult.whyfrpr4 := gse.Integer_Value( cursor, 369 );
      end if;
      if not gse.Is_Null( cursor, 370 )then
         a_adult.whyfrpr5 := gse.Integer_Value( cursor, 370 );
      end if;
      if not gse.Is_Null( cursor, 371 )then
         a_adult.whyfrpr6 := gse.Integer_Value( cursor, 371 );
      end if;
      if not gse.Is_Null( cursor, 372 )then
         a_adult.whytrav1 := gse.Integer_Value( cursor, 372 );
      end if;
      if not gse.Is_Null( cursor, 373 )then
         a_adult.whytrav2 := gse.Integer_Value( cursor, 373 );
      end if;
      if not gse.Is_Null( cursor, 374 )then
         a_adult.whytrav3 := gse.Integer_Value( cursor, 374 );
      end if;
      if not gse.Is_Null( cursor, 375 )then
         a_adult.whytrav4 := gse.Integer_Value( cursor, 375 );
      end if;
      if not gse.Is_Null( cursor, 376 )then
         a_adult.whytrav5 := gse.Integer_Value( cursor, 376 );
      end if;
      if not gse.Is_Null( cursor, 377 )then
         a_adult.whytrav6 := gse.Integer_Value( cursor, 377 );
      end if;
      if not gse.Is_Null( cursor, 378 )then
         a_adult.wintfuel := gse.Integer_Value( cursor, 378 );
      end if;
      if not gse.Is_Null( cursor, 379 )then
         a_adult.wmkit := gse.Integer_Value( cursor, 379 );
      end if;
      if not gse.Is_Null( cursor, 380 )then
         a_adult.working := gse.Integer_Value( cursor, 380 );
      end if;
      if not gse.Is_Null( cursor, 381 )then
         a_adult.wpa := gse.Integer_Value( cursor, 381 );
      end if;
      if not gse.Is_Null( cursor, 382 )then
         a_adult.wpba := gse.Integer_Value( cursor, 382 );
      end if;
      if not gse.Is_Null( cursor, 383 )then
         a_adult.wtclum1 := gse.Integer_Value( cursor, 383 );
      end if;
      if not gse.Is_Null( cursor, 384 )then
         a_adult.wtclum2 := gse.Integer_Value( cursor, 384 );
      end if;
      if not gse.Is_Null( cursor, 385 )then
         a_adult.wtclum3 := gse.Integer_Value( cursor, 385 );
      end if;
      if not gse.Is_Null( cursor, 386 )then
         a_adult.ystrtwk := gse.Integer_Value( cursor, 386 );
      end if;
      if not gse.Is_Null( cursor, 387 )then
         a_adult.month := gse.Integer_Value( cursor, 387 );
      end if;
      if not gse.Is_Null( cursor, 388 )then
         a_adult.able := gse.Integer_Value( cursor, 388 );
      end if;
      if not gse.Is_Null( cursor, 389 )then
         a_adult.actacci := gse.Integer_Value( cursor, 389 );
      end if;
      if not gse.Is_Null( cursor, 390 )then
         a_adult.addda := gse.Integer_Value( cursor, 390 );
      end if;
      if not gse.Is_Null( cursor, 391 )then
         a_adult.basacti := gse.Integer_Value( cursor, 391 );
      end if;
      if not gse.Is_Null( cursor, 392 )then
         a_adult.bntxcred:= Amount'Value( gse.Value( cursor, 392 ));
      end if;
      if not gse.Is_Null( cursor, 393 )then
         a_adult.careab := gse.Integer_Value( cursor, 393 );
      end if;
      if not gse.Is_Null( cursor, 394 )then
         a_adult.careah := gse.Integer_Value( cursor, 394 );
      end if;
      if not gse.Is_Null( cursor, 395 )then
         a_adult.carecb := gse.Integer_Value( cursor, 395 );
      end if;
      if not gse.Is_Null( cursor, 396 )then
         a_adult.carech := gse.Integer_Value( cursor, 396 );
      end if;
      if not gse.Is_Null( cursor, 397 )then
         a_adult.carecl := gse.Integer_Value( cursor, 397 );
      end if;
      if not gse.Is_Null( cursor, 398 )then
         a_adult.carefl := gse.Integer_Value( cursor, 398 );
      end if;
      if not gse.Is_Null( cursor, 399 )then
         a_adult.carefr := gse.Integer_Value( cursor, 399 );
      end if;
      if not gse.Is_Null( cursor, 400 )then
         a_adult.careot := gse.Integer_Value( cursor, 400 );
      end if;
      if not gse.Is_Null( cursor, 401 )then
         a_adult.carere := gse.Integer_Value( cursor, 401 );
      end if;
      if not gse.Is_Null( cursor, 402 )then
         a_adult.curacti := gse.Integer_Value( cursor, 402 );
      end if;
      if not gse.Is_Null( cursor, 403 )then
         a_adult.empoccp:= Amount'Value( gse.Value( cursor, 403 ));
      end if;
      if not gse.Is_Null( cursor, 404 )then
         a_adult.empstatb := gse.Integer_Value( cursor, 404 );
      end if;
      if not gse.Is_Null( cursor, 405 )then
         a_adult.empstatc := gse.Integer_Value( cursor, 405 );
      end if;
      if not gse.Is_Null( cursor, 406 )then
         a_adult.empstati := gse.Integer_Value( cursor, 406 );
      end if;
      if not gse.Is_Null( cursor, 407 )then
         a_adult.fsbndcti := gse.Integer_Value( cursor, 407 );
      end if;
      if not gse.Is_Null( cursor, 408 )then
         a_adult.fwmlkval:= Amount'Value( gse.Value( cursor, 408 ));
      end if;
      if not gse.Is_Null( cursor, 409 )then
         a_adult.gebacti := gse.Integer_Value( cursor, 409 );
      end if;
      if not gse.Is_Null( cursor, 410 )then
         a_adult.giltcti := gse.Integer_Value( cursor, 410 );
      end if;
      if not gse.Is_Null( cursor, 411 )then
         a_adult.gross2 := gse.Integer_Value( cursor, 411 );
      end if;
      if not gse.Is_Null( cursor, 412 )then
         a_adult.gross3 := gse.Integer_Value( cursor, 412 );
      end if;
      if not gse.Is_Null( cursor, 413 )then
         a_adult.hbsupran:= Amount'Value( gse.Value( cursor, 413 ));
      end if;
      if not gse.Is_Null( cursor, 414 )then
         a_adult.hdage := gse.Integer_Value( cursor, 414 );
      end if;
      if not gse.Is_Null( cursor, 415 )then
         a_adult.hdben := gse.Integer_Value( cursor, 415 );
      end if;
      if not gse.Is_Null( cursor, 416 )then
         a_adult.hdindinc := gse.Integer_Value( cursor, 416 );
      end if;
      if not gse.Is_Null( cursor, 417 )then
         a_adult.hourab := gse.Integer_Value( cursor, 417 );
      end if;
      if not gse.Is_Null( cursor, 418 )then
         a_adult.hourah := gse.Integer_Value( cursor, 418 );
      end if;
      if not gse.Is_Null( cursor, 419 )then
         a_adult.hourcare:= Amount'Value( gse.Value( cursor, 419 ));
      end if;
      if not gse.Is_Null( cursor, 420 )then
         a_adult.hourcb := gse.Integer_Value( cursor, 420 );
      end if;
      if not gse.Is_Null( cursor, 421 )then
         a_adult.hourch := gse.Integer_Value( cursor, 421 );
      end if;
      if not gse.Is_Null( cursor, 422 )then
         a_adult.hourcl := gse.Integer_Value( cursor, 422 );
      end if;
      if not gse.Is_Null( cursor, 423 )then
         a_adult.hourfr := gse.Integer_Value( cursor, 423 );
      end if;
      if not gse.Is_Null( cursor, 424 )then
         a_adult.hourot := gse.Integer_Value( cursor, 424 );
      end if;
      if not gse.Is_Null( cursor, 425 )then
         a_adult.hourre := gse.Integer_Value( cursor, 425 );
      end if;
      if not gse.Is_Null( cursor, 426 )then
         a_adult.hourtot := gse.Integer_Value( cursor, 426 );
      end if;
      if not gse.Is_Null( cursor, 427 )then
         a_adult.hperson := gse.Integer_Value( cursor, 427 );
      end if;
      if not gse.Is_Null( cursor, 428 )then
         a_adult.iagegr2 := gse.Integer_Value( cursor, 428 );
      end if;
      if not gse.Is_Null( cursor, 429 )then
         a_adult.iagegrp := gse.Integer_Value( cursor, 429 );
      end if;
      if not gse.Is_Null( cursor, 430 )then
         a_adult.incseo2:= Amount'Value( gse.Value( cursor, 430 ));
      end if;
      if not gse.Is_Null( cursor, 431 )then
         a_adult.indinc := gse.Integer_Value( cursor, 431 );
      end if;
      if not gse.Is_Null( cursor, 432 )then
         a_adult.indisben := gse.Integer_Value( cursor, 432 );
      end if;
      if not gse.Is_Null( cursor, 433 )then
         a_adult.inearns:= Amount'Value( gse.Value( cursor, 433 ));
      end if;
      if not gse.Is_Null( cursor, 434 )then
         a_adult.ininv:= Amount'Value( gse.Value( cursor, 434 ));
      end if;
      if not gse.Is_Null( cursor, 435 )then
         a_adult.inirben := gse.Integer_Value( cursor, 435 );
      end if;
      if not gse.Is_Null( cursor, 436 )then
         a_adult.innirben := gse.Integer_Value( cursor, 436 );
      end if;
      if not gse.Is_Null( cursor, 437 )then
         a_adult.inothben := gse.Integer_Value( cursor, 437 );
      end if;
      if not gse.Is_Null( cursor, 438 )then
         a_adult.inpeninc:= Amount'Value( gse.Value( cursor, 438 ));
      end if;
      if not gse.Is_Null( cursor, 439 )then
         a_adult.inrinc:= Amount'Value( gse.Value( cursor, 439 ));
      end if;
      if not gse.Is_Null( cursor, 440 )then
         a_adult.inrpinc:= Amount'Value( gse.Value( cursor, 440 ));
      end if;
      if not gse.Is_Null( cursor, 441 )then
         a_adult.intvlic:= Amount'Value( gse.Value( cursor, 441 ));
      end if;
      if not gse.Is_Null( cursor, 442 )then
         a_adult.intxcred:= Amount'Value( gse.Value( cursor, 442 ));
      end if;
      if not gse.Is_Null( cursor, 443 )then
         a_adult.isacti := gse.Integer_Value( cursor, 443 );
      end if;
      if not gse.Is_Null( cursor, 444 )then
         a_adult.marital := gse.Integer_Value( cursor, 444 );
      end if;
      if not gse.Is_Null( cursor, 445 )then
         a_adult.netocpen:= Amount'Value( gse.Value( cursor, 445 ));
      end if;
      if not gse.Is_Null( cursor, 446 )then
         a_adult.nincseo2:= Amount'Value( gse.Value( cursor, 446 ));
      end if;
      if not gse.Is_Null( cursor, 447 )then
         a_adult.nindinc := gse.Integer_Value( cursor, 447 );
      end if;
      if not gse.Is_Null( cursor, 448 )then
         a_adult.ninearns := gse.Integer_Value( cursor, 448 );
      end if;
      if not gse.Is_Null( cursor, 449 )then
         a_adult.nininv := gse.Integer_Value( cursor, 449 );
      end if;
      if not gse.Is_Null( cursor, 450 )then
         a_adult.ninpenin := gse.Integer_Value( cursor, 450 );
      end if;
      if not gse.Is_Null( cursor, 451 )then
         a_adult.ninsein2:= Amount'Value( gse.Value( cursor, 451 ));
      end if;
      if not gse.Is_Null( cursor, 452 )then
         a_adult.nsbocti := gse.Integer_Value( cursor, 452 );
      end if;
      if not gse.Is_Null( cursor, 453 )then
         a_adult.occupnum := gse.Integer_Value( cursor, 453 );
      end if;
      if not gse.Is_Null( cursor, 454 )then
         a_adult.otbscti := gse.Integer_Value( cursor, 454 );
      end if;
      if not gse.Is_Null( cursor, 455 )then
         a_adult.pepscti := gse.Integer_Value( cursor, 455 );
      end if;
      if not gse.Is_Null( cursor, 456 )then
         a_adult.poaccti := gse.Integer_Value( cursor, 456 );
      end if;
      if not gse.Is_Null( cursor, 457 )then
         a_adult.prbocti := gse.Integer_Value( cursor, 457 );
      end if;
      if not gse.Is_Null( cursor, 458 )then
         a_adult.relhrp := gse.Integer_Value( cursor, 458 );
      end if;
      if not gse.Is_Null( cursor, 459 )then
         a_adult.sayecti := gse.Integer_Value( cursor, 459 );
      end if;
      if not gse.Is_Null( cursor, 460 )then
         a_adult.sclbcti := gse.Integer_Value( cursor, 460 );
      end if;
      if not gse.Is_Null( cursor, 461 )then
         a_adult.seincam2:= Amount'Value( gse.Value( cursor, 461 ));
      end if;
      if not gse.Is_Null( cursor, 462 )then
         a_adult.smpadj:= Amount'Value( gse.Value( cursor, 462 ));
      end if;
      if not gse.Is_Null( cursor, 463 )then
         a_adult.sscti := gse.Integer_Value( cursor, 463 );
      end if;
      if not gse.Is_Null( cursor, 464 )then
         a_adult.sspadj:= Amount'Value( gse.Value( cursor, 464 ));
      end if;
      if not gse.Is_Null( cursor, 465 )then
         a_adult.stshcti := gse.Integer_Value( cursor, 465 );
      end if;
      if not gse.Is_Null( cursor, 466 )then
         a_adult.superan:= Amount'Value( gse.Value( cursor, 466 ));
      end if;
      if not gse.Is_Null( cursor, 467 )then
         a_adult.taxpayer := gse.Integer_Value( cursor, 467 );
      end if;
      if not gse.Is_Null( cursor, 468 )then
         a_adult.tesscti := gse.Integer_Value( cursor, 468 );
      end if;
      if not gse.Is_Null( cursor, 469 )then
         a_adult.totgrant:= Amount'Value( gse.Value( cursor, 469 ));
      end if;
      if not gse.Is_Null( cursor, 470 )then
         a_adult.tothours:= Amount'Value( gse.Value( cursor, 470 ));
      end if;
      if not gse.Is_Null( cursor, 471 )then
         a_adult.totoccp:= Amount'Value( gse.Value( cursor, 471 ));
      end if;
      if not gse.Is_Null( cursor, 472 )then
         a_adult.ttwcosts:= Amount'Value( gse.Value( cursor, 472 ));
      end if;
      if not gse.Is_Null( cursor, 473 )then
         a_adult.untrcti := gse.Integer_Value( cursor, 473 );
      end if;
      if not gse.Is_Null( cursor, 474 )then
         a_adult.uperson := gse.Integer_Value( cursor, 474 );
      end if;
      if not gse.Is_Null( cursor, 475 )then
         a_adult.widoccp:= Amount'Value( gse.Value( cursor, 475 ));
      end if;
      if not gse.Is_Null( cursor, 476 )then
         a_adult.accountq := gse.Integer_Value( cursor, 476 );
      end if;
      if not gse.Is_Null( cursor, 477 )then
         a_adult.ben5q7 := gse.Integer_Value( cursor, 477 );
      end if;
      if not gse.Is_Null( cursor, 478 )then
         a_adult.ben5q8 := gse.Integer_Value( cursor, 478 );
      end if;
      if not gse.Is_Null( cursor, 479 )then
         a_adult.ben5q9 := gse.Integer_Value( cursor, 479 );
      end if;
      if not gse.Is_Null( cursor, 480 )then
         a_adult.ddatre := gse.Integer_Value( cursor, 480 );
      end if;
      if not gse.Is_Null( cursor, 481 )then
         a_adult.disdif9 := gse.Integer_Value( cursor, 481 );
      end if;
      if not gse.Is_Null( cursor, 482 )then
         a_adult.fare:= Amount'Value( gse.Value( cursor, 482 ));
      end if;
      if not gse.Is_Null( cursor, 483 )then
         a_adult.nittwmod := gse.Integer_Value( cursor, 483 );
      end if;
      if not gse.Is_Null( cursor, 484 )then
         a_adult.oneway := gse.Integer_Value( cursor, 484 );
      end if;
      if not gse.Is_Null( cursor, 485 )then
         a_adult.pssamt:= Amount'Value( gse.Value( cursor, 485 ));
      end if;
      if not gse.Is_Null( cursor, 486 )then
         a_adult.pssdate := gse.Integer_Value( cursor, 486 );
      end if;
      if not gse.Is_Null( cursor, 487 )then
         a_adult.ttwcode1 := gse.Integer_Value( cursor, 487 );
      end if;
      if not gse.Is_Null( cursor, 488 )then
         a_adult.ttwcode2 := gse.Integer_Value( cursor, 488 );
      end if;
      if not gse.Is_Null( cursor, 489 )then
         a_adult.ttwcode3 := gse.Integer_Value( cursor, 489 );
      end if;
      if not gse.Is_Null( cursor, 490 )then
         a_adult.ttwcost:= Amount'Value( gse.Value( cursor, 490 ));
      end if;
      if not gse.Is_Null( cursor, 491 )then
         a_adult.ttwfar := gse.Integer_Value( cursor, 491 );
      end if;
      if not gse.Is_Null( cursor, 492 )then
         a_adult.ttwfrq:= Amount'Value( gse.Value( cursor, 492 ));
      end if;
      if not gse.Is_Null( cursor, 493 )then
         a_adult.ttwmod := gse.Integer_Value( cursor, 493 );
      end if;
      if not gse.Is_Null( cursor, 494 )then
         a_adult.ttwpay := gse.Integer_Value( cursor, 494 );
      end if;
      if not gse.Is_Null( cursor, 495 )then
         a_adult.ttwpss := gse.Integer_Value( cursor, 495 );
      end if;
      if not gse.Is_Null( cursor, 496 )then
         a_adult.ttwrec:= Amount'Value( gse.Value( cursor, 496 ));
      end if;
      if not gse.Is_Null( cursor, 497 )then
         a_adult.chbflg := gse.Integer_Value( cursor, 497 );
      end if;
      if not gse.Is_Null( cursor, 498 )then
         a_adult.crunaci := gse.Integer_Value( cursor, 498 );
      end if;
      if not gse.Is_Null( cursor, 499 )then
         a_adult.enomorti := gse.Integer_Value( cursor, 499 );
      end if;
      if not gse.Is_Null( cursor, 500 )then
         a_adult.sapadj:= Amount'Value( gse.Value( cursor, 500 ));
      end if;
      if not gse.Is_Null( cursor, 501 )then
         a_adult.sppadj:= Amount'Value( gse.Value( cursor, 501 ));
      end if;
      if not gse.Is_Null( cursor, 502 )then
         a_adult.ttwmode := gse.Integer_Value( cursor, 502 );
      end if;
      if not gse.Is_Null( cursor, 503 )then
         a_adult.ddatrep := gse.Integer_Value( cursor, 503 );
      end if;
      if not gse.Is_Null( cursor, 504 )then
         a_adult.defrpen := gse.Integer_Value( cursor, 504 );
      end if;
      if not gse.Is_Null( cursor, 505 )then
         a_adult.disdifp := gse.Integer_Value( cursor, 505 );
      end if;
      if not gse.Is_Null( cursor, 506 )then
         a_adult.followup := gse.Integer_Value( cursor, 506 );
      end if;
      if not gse.Is_Null( cursor, 507 )then
         a_adult.practice := gse.Integer_Value( cursor, 507 );
      end if;
      if not gse.Is_Null( cursor, 508 )then
         a_adult.sfrpis := gse.Integer_Value( cursor, 508 );
      end if;
      if not gse.Is_Null( cursor, 509 )then
         a_adult.sfrpjsa := gse.Integer_Value( cursor, 509 );
      end if;
      if not gse.Is_Null( cursor, 510 )then
         a_adult.age80 := gse.Integer_Value( cursor, 510 );
      end if;
      if not gse.Is_Null( cursor, 511 )then
         a_adult.ethgr2 := gse.Integer_Value( cursor, 511 );
      end if;
      if not gse.Is_Null( cursor, 512 )then
         a_adult.pocardi := gse.Integer_Value( cursor, 512 );
      end if;
      if not gse.Is_Null( cursor, 513 )then
         a_adult.chkdpn := gse.Integer_Value( cursor, 513 );
      end if;
      if not gse.Is_Null( cursor, 514 )then
         a_adult.chknop := gse.Integer_Value( cursor, 514 );
      end if;
      if not gse.Is_Null( cursor, 515 )then
         a_adult.consent := gse.Integer_Value( cursor, 515 );
      end if;
      if not gse.Is_Null( cursor, 516 )then
         a_adult.dvpens := gse.Integer_Value( cursor, 516 );
      end if;
      if not gse.Is_Null( cursor, 517 )then
         a_adult.eligschm := gse.Integer_Value( cursor, 517 );
      end if;
      if not gse.Is_Null( cursor, 518 )then
         a_adult.emparr := gse.Integer_Value( cursor, 518 );
      end if;
      if not gse.Is_Null( cursor, 519 )then
         a_adult.emppen := gse.Integer_Value( cursor, 519 );
      end if;
      if not gse.Is_Null( cursor, 520 )then
         a_adult.empschm := gse.Integer_Value( cursor, 520 );
      end if;
      if not gse.Is_Null( cursor, 521 )then
         a_adult.lnkref1 := gse.Integer_Value( cursor, 521 );
      end if;
      if not gse.Is_Null( cursor, 522 )then
         a_adult.lnkref2 := gse.Integer_Value( cursor, 522 );
      end if;
      if not gse.Is_Null( cursor, 523 )then
         a_adult.lnkref21 := gse.Integer_Value( cursor, 523 );
      end if;
      if not gse.Is_Null( cursor, 524 )then
         a_adult.lnkref22 := gse.Integer_Value( cursor, 524 );
      end if;
      if not gse.Is_Null( cursor, 525 )then
         a_adult.lnkref23 := gse.Integer_Value( cursor, 525 );
      end if;
      if not gse.Is_Null( cursor, 526 )then
         a_adult.lnkref24 := gse.Integer_Value( cursor, 526 );
      end if;
      if not gse.Is_Null( cursor, 527 )then
         a_adult.lnkref25 := gse.Integer_Value( cursor, 527 );
      end if;
      if not gse.Is_Null( cursor, 528 )then
         a_adult.lnkref3 := gse.Integer_Value( cursor, 528 );
      end if;
      if not gse.Is_Null( cursor, 529 )then
         a_adult.lnkref4 := gse.Integer_Value( cursor, 529 );
      end if;
      if not gse.Is_Null( cursor, 530 )then
         a_adult.lnkref5 := gse.Integer_Value( cursor, 530 );
      end if;
      if not gse.Is_Null( cursor, 531 )then
         a_adult.memschm := gse.Integer_Value( cursor, 531 );
      end if;
      if not gse.Is_Null( cursor, 532 )then
         a_adult.pconsent := gse.Integer_Value( cursor, 532 );
      end if;
      if not gse.Is_Null( cursor, 533 )then
         a_adult.perspen1 := gse.Integer_Value( cursor, 533 );
      end if;
      if not gse.Is_Null( cursor, 534 )then
         a_adult.perspen2 := gse.Integer_Value( cursor, 534 );
      end if;
      if not gse.Is_Null( cursor, 535 )then
         a_adult.privpen := gse.Integer_Value( cursor, 535 );
      end if;
      if not gse.Is_Null( cursor, 536 )then
         a_adult.schchk := gse.Integer_Value( cursor, 536 );
      end if;
      if not gse.Is_Null( cursor, 537 )then
         a_adult.spnumc := gse.Integer_Value( cursor, 537 );
      end if;
      if not gse.Is_Null( cursor, 538 )then
         a_adult.stakep := gse.Integer_Value( cursor, 538 );
      end if;
      if not gse.Is_Null( cursor, 539 )then
         a_adult.trainee := gse.Integer_Value( cursor, 539 );
      end if;
      if not gse.Is_Null( cursor, 540 )then
         a_adult.lnkdwp := gse.Integer_Value( cursor, 540 );
      end if;
      if not gse.Is_Null( cursor, 541 )then
         a_adult.lnkons := gse.Integer_Value( cursor, 541 );
      end if;
      if not gse.Is_Null( cursor, 542 )then
         a_adult.lnkref6 := gse.Integer_Value( cursor, 542 );
      end if;
      if not gse.Is_Null( cursor, 543 )then
         a_adult.lnkref7 := gse.Integer_Value( cursor, 543 );
      end if;
      if not gse.Is_Null( cursor, 544 )then
         a_adult.lnkref8 := gse.Integer_Value( cursor, 544 );
      end if;
      if not gse.Is_Null( cursor, 545 )then
         a_adult.lnkref9 := gse.Integer_Value( cursor, 545 );
      end if;
      if not gse.Is_Null( cursor, 546 )then
         a_adult.tcever1 := gse.Integer_Value( cursor, 546 );
      end if;
      if not gse.Is_Null( cursor, 547 )then
         a_adult.tcever2 := gse.Integer_Value( cursor, 547 );
      end if;
      if not gse.Is_Null( cursor, 548 )then
         a_adult.tcrepay1 := gse.Integer_Value( cursor, 548 );
      end if;
      if not gse.Is_Null( cursor, 549 )then
         a_adult.tcrepay2 := gse.Integer_Value( cursor, 549 );
      end if;
      if not gse.Is_Null( cursor, 550 )then
         a_adult.tcrepay3 := gse.Integer_Value( cursor, 550 );
      end if;
      if not gse.Is_Null( cursor, 551 )then
         a_adult.tcrepay4 := gse.Integer_Value( cursor, 551 );
      end if;
      if not gse.Is_Null( cursor, 552 )then
         a_adult.tcrepay5 := gse.Integer_Value( cursor, 552 );
      end if;
      if not gse.Is_Null( cursor, 553 )then
         a_adult.tcrepay6 := gse.Integer_Value( cursor, 553 );
      end if;
      if not gse.Is_Null( cursor, 554 )then
         a_adult.tcthsyr1 := gse.Integer_Value( cursor, 554 );
      end if;
      if not gse.Is_Null( cursor, 555 )then
         a_adult.tcthsyr2 := gse.Integer_Value( cursor, 555 );
      end if;
      if not gse.Is_Null( cursor, 556 )then
         a_adult.currjobm := gse.Integer_Value( cursor, 556 );
      end if;
      if not gse.Is_Null( cursor, 557 )then
         a_adult.prevjobm := gse.Integer_Value( cursor, 557 );
      end if;
      if not gse.Is_Null( cursor, 558 )then
         a_adult.b3qfut7 := gse.Integer_Value( cursor, 558 );
      end if;
      if not gse.Is_Null( cursor, 559 )then
         a_adult.ben3q7 := gse.Integer_Value( cursor, 559 );
      end if;
      if not gse.Is_Null( cursor, 560 )then
         a_adult.camemt := gse.Integer_Value( cursor, 560 );
      end if;
      if not gse.Is_Null( cursor, 561 )then
         a_adult.cameyr := gse.Integer_Value( cursor, 561 );
      end if;
      if not gse.Is_Null( cursor, 562 )then
         a_adult.cameyr2 := gse.Integer_Value( cursor, 562 );
      end if;
      if not gse.Is_Null( cursor, 563 )then
         a_adult.contuk := gse.Integer_Value( cursor, 563 );
      end if;
      if not gse.Is_Null( cursor, 564 )then
         a_adult.corign := gse.Integer_Value( cursor, 564 );
      end if;
      if not gse.Is_Null( cursor, 565 )then
         a_adult.ddaprog := gse.Integer_Value( cursor, 565 );
      end if;
      if not gse.Is_Null( cursor, 566 )then
         a_adult.hbolng := gse.Integer_Value( cursor, 566 );
      end if;
      if not gse.Is_Null( cursor, 567 )then
         a_adult.hi1qual1 := gse.Integer_Value( cursor, 567 );
      end if;
      if not gse.Is_Null( cursor, 568 )then
         a_adult.hi1qual2 := gse.Integer_Value( cursor, 568 );
      end if;
      if not gse.Is_Null( cursor, 569 )then
         a_adult.hi1qual3 := gse.Integer_Value( cursor, 569 );
      end if;
      if not gse.Is_Null( cursor, 570 )then
         a_adult.hi1qual4 := gse.Integer_Value( cursor, 570 );
      end if;
      if not gse.Is_Null( cursor, 571 )then
         a_adult.hi1qual5 := gse.Integer_Value( cursor, 571 );
      end if;
      if not gse.Is_Null( cursor, 572 )then
         a_adult.hi1qual6 := gse.Integer_Value( cursor, 572 );
      end if;
      if not gse.Is_Null( cursor, 573 )then
         a_adult.hi2qual := gse.Integer_Value( cursor, 573 );
      end if;
      if not gse.Is_Null( cursor, 574 )then
         a_adult.hlpgvn01 := gse.Integer_Value( cursor, 574 );
      end if;
      if not gse.Is_Null( cursor, 575 )then
         a_adult.hlpgvn02 := gse.Integer_Value( cursor, 575 );
      end if;
      if not gse.Is_Null( cursor, 576 )then
         a_adult.hlpgvn03 := gse.Integer_Value( cursor, 576 );
      end if;
      if not gse.Is_Null( cursor, 577 )then
         a_adult.hlpgvn04 := gse.Integer_Value( cursor, 577 );
      end if;
      if not gse.Is_Null( cursor, 578 )then
         a_adult.hlpgvn05 := gse.Integer_Value( cursor, 578 );
      end if;
      if not gse.Is_Null( cursor, 579 )then
         a_adult.hlpgvn06 := gse.Integer_Value( cursor, 579 );
      end if;
      if not gse.Is_Null( cursor, 580 )then
         a_adult.hlpgvn07 := gse.Integer_Value( cursor, 580 );
      end if;
      if not gse.Is_Null( cursor, 581 )then
         a_adult.hlpgvn08 := gse.Integer_Value( cursor, 581 );
      end if;
      if not gse.Is_Null( cursor, 582 )then
         a_adult.hlpgvn09 := gse.Integer_Value( cursor, 582 );
      end if;
      if not gse.Is_Null( cursor, 583 )then
         a_adult.hlpgvn10 := gse.Integer_Value( cursor, 583 );
      end if;
      if not gse.Is_Null( cursor, 584 )then
         a_adult.hlpgvn11 := gse.Integer_Value( cursor, 584 );
      end if;
      if not gse.Is_Null( cursor, 585 )then
         a_adult.hlprec01 := gse.Integer_Value( cursor, 585 );
      end if;
      if not gse.Is_Null( cursor, 586 )then
         a_adult.hlprec02 := gse.Integer_Value( cursor, 586 );
      end if;
      if not gse.Is_Null( cursor, 587 )then
         a_adult.hlprec03 := gse.Integer_Value( cursor, 587 );
      end if;
      if not gse.Is_Null( cursor, 588 )then
         a_adult.hlprec04 := gse.Integer_Value( cursor, 588 );
      end if;
      if not gse.Is_Null( cursor, 589 )then
         a_adult.hlprec05 := gse.Integer_Value( cursor, 589 );
      end if;
      if not gse.Is_Null( cursor, 590 )then
         a_adult.hlprec06 := gse.Integer_Value( cursor, 590 );
      end if;
      if not gse.Is_Null( cursor, 591 )then
         a_adult.hlprec07 := gse.Integer_Value( cursor, 591 );
      end if;
      if not gse.Is_Null( cursor, 592 )then
         a_adult.hlprec08 := gse.Integer_Value( cursor, 592 );
      end if;
      if not gse.Is_Null( cursor, 593 )then
         a_adult.hlprec09 := gse.Integer_Value( cursor, 593 );
      end if;
      if not gse.Is_Null( cursor, 594 )then
         a_adult.hlprec10 := gse.Integer_Value( cursor, 594 );
      end if;
      if not gse.Is_Null( cursor, 595 )then
         a_adult.hlprec11 := gse.Integer_Value( cursor, 595 );
      end if;
      if not gse.Is_Null( cursor, 596 )then
         a_adult.issue := gse.Integer_Value( cursor, 596 );
      end if;
      if not gse.Is_Null( cursor, 597 )then
         a_adult.loangvn1 := gse.Integer_Value( cursor, 597 );
      end if;
      if not gse.Is_Null( cursor, 598 )then
         a_adult.loangvn2 := gse.Integer_Value( cursor, 598 );
      end if;
      if not gse.Is_Null( cursor, 599 )then
         a_adult.loangvn3 := gse.Integer_Value( cursor, 599 );
      end if;
      if not gse.Is_Null( cursor, 600 )then
         a_adult.loanrec1 := gse.Integer_Value( cursor, 600 );
      end if;
      if not gse.Is_Null( cursor, 601 )then
         a_adult.loanrec2 := gse.Integer_Value( cursor, 601 );
      end if;
      if not gse.Is_Null( cursor, 602 )then
         a_adult.loanrec3 := gse.Integer_Value( cursor, 602 );
      end if;
      if not gse.Is_Null( cursor, 603 )then
         a_adult.mntarr1 := gse.Integer_Value( cursor, 603 );
      end if;
      if not gse.Is_Null( cursor, 604 )then
         a_adult.mntarr2 := gse.Integer_Value( cursor, 604 );
      end if;
      if not gse.Is_Null( cursor, 605 )then
         a_adult.mntarr3 := gse.Integer_Value( cursor, 605 );
      end if;
      if not gse.Is_Null( cursor, 606 )then
         a_adult.mntarr4 := gse.Integer_Value( cursor, 606 );
      end if;
      if not gse.Is_Null( cursor, 607 )then
         a_adult.mntnrp := gse.Integer_Value( cursor, 607 );
      end if;
      if not gse.Is_Null( cursor, 608 )then
         a_adult.othqual1 := gse.Integer_Value( cursor, 608 );
      end if;
      if not gse.Is_Null( cursor, 609 )then
         a_adult.othqual2 := gse.Integer_Value( cursor, 609 );
      end if;
      if not gse.Is_Null( cursor, 610 )then
         a_adult.othqual3 := gse.Integer_Value( cursor, 610 );
      end if;
      if not gse.Is_Null( cursor, 611 )then
         a_adult.tea9697 := gse.Integer_Value( cursor, 611 );
      end if;
      if not gse.Is_Null( cursor, 612 )then
         a_adult.heartval:= Amount'Value( gse.Value( cursor, 612 ));
      end if;
      if not gse.Is_Null( cursor, 613 )then
         a_adult.iagegr3 := gse.Integer_Value( cursor, 613 );
      end if;
      if not gse.Is_Null( cursor, 614 )then
         a_adult.iagegr4 := gse.Integer_Value( cursor, 614 );
      end if;
      if not gse.Is_Null( cursor, 615 )then
         a_adult.nirel2 := gse.Integer_Value( cursor, 615 );
      end if;
      if not gse.Is_Null( cursor, 616 )then
         a_adult.xbonflag := gse.Integer_Value( cursor, 616 );
      end if;
      if not gse.Is_Null( cursor, 617 )then
         a_adult.alg := gse.Integer_Value( cursor, 617 );
      end if;
      if not gse.Is_Null( cursor, 618 )then
         a_adult.algamt:= Amount'Value( gse.Value( cursor, 618 ));
      end if;
      if not gse.Is_Null( cursor, 619 )then
         a_adult.algpd := gse.Integer_Value( cursor, 619 );
      end if;
      if not gse.Is_Null( cursor, 620 )then
         a_adult.ben4q4 := gse.Integer_Value( cursor, 620 );
      end if;
      if not gse.Is_Null( cursor, 621 )then
         a_adult.chkctc := gse.Integer_Value( cursor, 621 );
      end if;
      if not gse.Is_Null( cursor, 622 )then
         a_adult.chkdpco1 := gse.Integer_Value( cursor, 622 );
      end if;
      if not gse.Is_Null( cursor, 623 )then
         a_adult.chkdpco2 := gse.Integer_Value( cursor, 623 );
      end if;
      if not gse.Is_Null( cursor, 624 )then
         a_adult.chkdpco3 := gse.Integer_Value( cursor, 624 );
      end if;
      if not gse.Is_Null( cursor, 625 )then
         a_adult.chkdsco1 := gse.Integer_Value( cursor, 625 );
      end if;
      if not gse.Is_Null( cursor, 626 )then
         a_adult.chkdsco2 := gse.Integer_Value( cursor, 626 );
      end if;
      if not gse.Is_Null( cursor, 627 )then
         a_adult.chkdsco3 := gse.Integer_Value( cursor, 627 );
      end if;
      if not gse.Is_Null( cursor, 628 )then
         a_adult.dv09pens := gse.Integer_Value( cursor, 628 );
      end if;
      if not gse.Is_Null( cursor, 629 )then
         a_adult.lnkref01 := gse.Integer_Value( cursor, 629 );
      end if;
      if not gse.Is_Null( cursor, 630 )then
         a_adult.lnkref02 := gse.Integer_Value( cursor, 630 );
      end if;
      if not gse.Is_Null( cursor, 631 )then
         a_adult.lnkref03 := gse.Integer_Value( cursor, 631 );
      end if;
      if not gse.Is_Null( cursor, 632 )then
         a_adult.lnkref04 := gse.Integer_Value( cursor, 632 );
      end if;
      if not gse.Is_Null( cursor, 633 )then
         a_adult.lnkref05 := gse.Integer_Value( cursor, 633 );
      end if;
      if not gse.Is_Null( cursor, 634 )then
         a_adult.lnkref06 := gse.Integer_Value( cursor, 634 );
      end if;
      if not gse.Is_Null( cursor, 635 )then
         a_adult.lnkref07 := gse.Integer_Value( cursor, 635 );
      end if;
      if not gse.Is_Null( cursor, 636 )then
         a_adult.lnkref08 := gse.Integer_Value( cursor, 636 );
      end if;
      if not gse.Is_Null( cursor, 637 )then
         a_adult.lnkref09 := gse.Integer_Value( cursor, 637 );
      end if;
      if not gse.Is_Null( cursor, 638 )then
         a_adult.lnkref10 := gse.Integer_Value( cursor, 638 );
      end if;
      if not gse.Is_Null( cursor, 639 )then
         a_adult.lnkref11 := gse.Integer_Value( cursor, 639 );
      end if;
      if not gse.Is_Null( cursor, 640 )then
         a_adult.spyrot := gse.Integer_Value( cursor, 640 );
      end if;
      if not gse.Is_Null( cursor, 641 )then
         a_adult.disdifad := gse.Integer_Value( cursor, 641 );
      end if;
      if not gse.Is_Null( cursor, 642 )then
         a_adult.gross3_x := gse.Integer_Value( cursor, 642 );
      end if;
      if not gse.Is_Null( cursor, 643 )then
         a_adult.aliamt:= Amount'Value( gse.Value( cursor, 643 ));
      end if;
      if not gse.Is_Null( cursor, 644 )then
         a_adult.alimny := gse.Integer_Value( cursor, 644 );
      end if;
      if not gse.Is_Null( cursor, 645 )then
         a_adult.alipd := gse.Integer_Value( cursor, 645 );
      end if;
      if not gse.Is_Null( cursor, 646 )then
         a_adult.alius := gse.Integer_Value( cursor, 646 );
      end if;
      if not gse.Is_Null( cursor, 647 )then
         a_adult.aluamt:= Amount'Value( gse.Value( cursor, 647 ));
      end if;
      if not gse.Is_Null( cursor, 648 )then
         a_adult.alupd := gse.Integer_Value( cursor, 648 );
      end if;
      if not gse.Is_Null( cursor, 649 )then
         a_adult.cbaamt := gse.Integer_Value( cursor, 649 );
      end if;
      if not gse.Is_Null( cursor, 650 )then
         a_adult.hsvper := gse.Integer_Value( cursor, 650 );
      end if;
      if not gse.Is_Null( cursor, 651 )then
         a_adult.mednum := gse.Integer_Value( cursor, 651 );
      end if;
      if not gse.Is_Null( cursor, 652 )then
         a_adult.medprpd := gse.Integer_Value( cursor, 652 );
      end if;
      if not gse.Is_Null( cursor, 653 )then
         a_adult.medprpy := gse.Integer_Value( cursor, 653 );
      end if;
      if not gse.Is_Null( cursor, 654 )then
         a_adult.penflag := gse.Integer_Value( cursor, 654 );
      end if;
      if not gse.Is_Null( cursor, 655 )then
         a_adult.ppchk1 := gse.Integer_Value( cursor, 655 );
      end if;
      if not gse.Is_Null( cursor, 656 )then
         a_adult.ppchk2 := gse.Integer_Value( cursor, 656 );
      end if;
      if not gse.Is_Null( cursor, 657 )then
         a_adult.ppchk3 := gse.Integer_Value( cursor, 657 );
      end if;
      if not gse.Is_Null( cursor, 658 )then
         a_adult.ttbprx:= Amount'Value( gse.Value( cursor, 658 ));
      end if;
      if not gse.Is_Null( cursor, 659 )then
         a_adult.mjobsect := gse.Integer_Value( cursor, 659 );
      end if;
      if not gse.Is_Null( cursor, 660 )then
         a_adult.etngrp := gse.Integer_Value( cursor, 660 );
      end if;
      if not gse.Is_Null( cursor, 661 )then
         a_adult.medpay := gse.Integer_Value( cursor, 661 );
      end if;
      if not gse.Is_Null( cursor, 662 )then
         a_adult.medrep := gse.Integer_Value( cursor, 662 );
      end if;
      if not gse.Is_Null( cursor, 663 )then
         a_adult.medrpnm := gse.Integer_Value( cursor, 663 );
      end if;
      if not gse.Is_Null( cursor, 664 )then
         a_adult.nanid1 := gse.Integer_Value( cursor, 664 );
      end if;
      if not gse.Is_Null( cursor, 665 )then
         a_adult.nanid2 := gse.Integer_Value( cursor, 665 );
      end if;
      if not gse.Is_Null( cursor, 666 )then
         a_adult.nanid3 := gse.Integer_Value( cursor, 666 );
      end if;
      if not gse.Is_Null( cursor, 667 )then
         a_adult.nanid4 := gse.Integer_Value( cursor, 667 );
      end if;
      if not gse.Is_Null( cursor, 668 )then
         a_adult.nanid5 := gse.Integer_Value( cursor, 668 );
      end if;
      if not gse.Is_Null( cursor, 669 )then
         a_adult.nanid6 := gse.Integer_Value( cursor, 669 );
      end if;
      if not gse.Is_Null( cursor, 670 )then
         a_adult.nietngrp := gse.Integer_Value( cursor, 670 );
      end if;
      if not gse.Is_Null( cursor, 671 )then
         a_adult.ninanid1 := gse.Integer_Value( cursor, 671 );
      end if;
      if not gse.Is_Null( cursor, 672 )then
         a_adult.ninanid2 := gse.Integer_Value( cursor, 672 );
      end if;
      if not gse.Is_Null( cursor, 673 )then
         a_adult.ninanid3 := gse.Integer_Value( cursor, 673 );
      end if;
      if not gse.Is_Null( cursor, 674 )then
         a_adult.ninanid4 := gse.Integer_Value( cursor, 674 );
      end if;
      if not gse.Is_Null( cursor, 675 )then
         a_adult.ninanid5 := gse.Integer_Value( cursor, 675 );
      end if;
      if not gse.Is_Null( cursor, 676 )then
         a_adult.ninanid6 := gse.Integer_Value( cursor, 676 );
      end if;
      if not gse.Is_Null( cursor, 677 )then
         a_adult.ninanid7 := gse.Integer_Value( cursor, 677 );
      end if;
      if not gse.Is_Null( cursor, 678 )then
         a_adult.nirelig := gse.Integer_Value( cursor, 678 );
      end if;
      if not gse.Is_Null( cursor, 679 )then
         a_adult.pollopin := gse.Integer_Value( cursor, 679 );
      end if;
      if not gse.Is_Null( cursor, 680 )then
         a_adult.religenw := gse.Integer_Value( cursor, 680 );
      end if;
      if not gse.Is_Null( cursor, 681 )then
         a_adult.religsc := gse.Integer_Value( cursor, 681 );
      end if;
      if not gse.Is_Null( cursor, 682 )then
         a_adult.sidqn := gse.Integer_Value( cursor, 682 );
      end if;
      if not gse.Is_Null( cursor, 683 )then
         a_adult.soc2010 := gse.Integer_Value( cursor, 683 );
      end if;
      if not gse.Is_Null( cursor, 684 )then
         a_adult.corignan := gse.Integer_Value( cursor, 684 );
      end if;
      if not gse.Is_Null( cursor, 685 )then
         a_adult.dobmonth := gse.Integer_Value( cursor, 685 );
      end if;
      if not gse.Is_Null( cursor, 686 )then
         a_adult.dobyear := gse.Integer_Value( cursor, 686 );
      end if;
      if not gse.Is_Null( cursor, 687 )then
         a_adult.ethgr3 := gse.Integer_Value( cursor, 687 );
      end if;
      if not gse.Is_Null( cursor, 688 )then
         a_adult.ninanida := gse.Integer_Value( cursor, 688 );
      end if;
      if not gse.Is_Null( cursor, 689 )then
         a_adult.agehqual := gse.Integer_Value( cursor, 689 );
      end if;
      if not gse.Is_Null( cursor, 690 )then
         a_adult.bfd := gse.Integer_Value( cursor, 690 );
      end if;
      if not gse.Is_Null( cursor, 691 )then
         a_adult.bfdamt:= Amount'Value( gse.Value( cursor, 691 ));
      end if;
      if not gse.Is_Null( cursor, 692 )then
         a_adult.bfdpd := gse.Integer_Value( cursor, 692 );
      end if;
      if not gse.Is_Null( cursor, 693 )then
         a_adult.bfdval := gse.Integer_Value( cursor, 693 );
      end if;
      if not gse.Is_Null( cursor, 694 )then
         a_adult.btec := gse.Integer_Value( cursor, 694 );
      end if;
      if not gse.Is_Null( cursor, 695 )then
         a_adult.btecnow := gse.Integer_Value( cursor, 695 );
      end if;
      if not gse.Is_Null( cursor, 696 )then
         a_adult.cbaamt2 := gse.Integer_Value( cursor, 696 );
      end if;
      if not gse.Is_Null( cursor, 697 )then
         a_adult.change := gse.Integer_Value( cursor, 697 );
      end if;
      if not gse.Is_Null( cursor, 698 )then
         a_adult.citizen := gse.Integer_Value( cursor, 698 );
      end if;
      if not gse.Is_Null( cursor, 699 )then
         a_adult.citizen2 := gse.Integer_Value( cursor, 699 );
      end if;
      if not gse.Is_Null( cursor, 700 )then
         a_adult.condit := gse.Integer_Value( cursor, 700 );
      end if;
      if not gse.Is_Null( cursor, 701 )then
         a_adult.corigoth := gse.Integer_Value( cursor, 701 );
      end if;
      if not gse.Is_Null( cursor, 702 )then
         a_adult.curqual := gse.Integer_Value( cursor, 702 );
      end if;
      if not gse.Is_Null( cursor, 703 )then
         a_adult.ddaprog1 := gse.Integer_Value( cursor, 703 );
      end if;
      if not gse.Is_Null( cursor, 704 )then
         a_adult.ddatre1 := gse.Integer_Value( cursor, 704 );
      end if;
      if not gse.Is_Null( cursor, 705 )then
         a_adult.ddatrep1 := gse.Integer_Value( cursor, 705 );
      end if;
      if not gse.Is_Null( cursor, 706 )then
         a_adult.degree := gse.Integer_Value( cursor, 706 );
      end if;
      if not gse.Is_Null( cursor, 707 )then
         a_adult.degrenow := gse.Integer_Value( cursor, 707 );
      end if;
      if not gse.Is_Null( cursor, 708 )then
         a_adult.denrec := gse.Integer_Value( cursor, 708 );
      end if;
      if not gse.Is_Null( cursor, 709 )then
         a_adult.disd01 := gse.Integer_Value( cursor, 709 );
      end if;
      if not gse.Is_Null( cursor, 710 )then
         a_adult.disd02 := gse.Integer_Value( cursor, 710 );
      end if;
      if not gse.Is_Null( cursor, 711 )then
         a_adult.disd03 := gse.Integer_Value( cursor, 711 );
      end if;
      if not gse.Is_Null( cursor, 712 )then
         a_adult.disd04 := gse.Integer_Value( cursor, 712 );
      end if;
      if not gse.Is_Null( cursor, 713 )then
         a_adult.disd05 := gse.Integer_Value( cursor, 713 );
      end if;
      if not gse.Is_Null( cursor, 714 )then
         a_adult.disd06 := gse.Integer_Value( cursor, 714 );
      end if;
      if not gse.Is_Null( cursor, 715 )then
         a_adult.disd07 := gse.Integer_Value( cursor, 715 );
      end if;
      if not gse.Is_Null( cursor, 716 )then
         a_adult.disd08 := gse.Integer_Value( cursor, 716 );
      end if;
      if not gse.Is_Null( cursor, 717 )then
         a_adult.disd09 := gse.Integer_Value( cursor, 717 );
      end if;
      if not gse.Is_Null( cursor, 718 )then
         a_adult.disd10 := gse.Integer_Value( cursor, 718 );
      end if;
      if not gse.Is_Null( cursor, 719 )then
         a_adult.disdifp1 := gse.Integer_Value( cursor, 719 );
      end if;
      if not gse.Is_Null( cursor, 720 )then
         a_adult.empcontr := gse.Integer_Value( cursor, 720 );
      end if;
      if not gse.Is_Null( cursor, 721 )then
         a_adult.ethgrps := gse.Integer_Value( cursor, 721 );
      end if;
      if not gse.Is_Null( cursor, 722 )then
         a_adult.eualiamt:= Amount'Value( gse.Value( cursor, 722 ));
      end if;
      if not gse.Is_Null( cursor, 723 )then
         a_adult.eualimny := gse.Integer_Value( cursor, 723 );
      end if;
      if not gse.Is_Null( cursor, 724 )then
         a_adult.eualipd := gse.Integer_Value( cursor, 724 );
      end if;
      if not gse.Is_Null( cursor, 725 )then
         a_adult.euetype := gse.Integer_Value( cursor, 725 );
      end if;
      if not gse.Is_Null( cursor, 726 )then
         a_adult.followsc := gse.Integer_Value( cursor, 726 );
      end if;
      if not gse.Is_Null( cursor, 727 )then
         a_adult.health1 := gse.Integer_Value( cursor, 727 );
      end if;
      if not gse.Is_Null( cursor, 728 )then
         a_adult.heathad := gse.Integer_Value( cursor, 728 );
      end if;
      if not gse.Is_Null( cursor, 729 )then
         a_adult.hi3qual := gse.Integer_Value( cursor, 729 );
      end if;
      if not gse.Is_Null( cursor, 730 )then
         a_adult.higho := gse.Integer_Value( cursor, 730 );
      end if;
      if not gse.Is_Null( cursor, 731 )then
         a_adult.highonow := gse.Integer_Value( cursor, 731 );
      end if;
      if not gse.Is_Null( cursor, 732 )then
         a_adult.jobbyr := gse.Integer_Value( cursor, 732 );
      end if;
      if not gse.Is_Null( cursor, 733 )then
         a_adult.limitl := gse.Integer_Value( cursor, 733 );
      end if;
      if not gse.Is_Null( cursor, 734 )then
         a_adult.lktrain := gse.Integer_Value( cursor, 734 );
      end if;
      if not gse.Is_Null( cursor, 735 )then
         a_adult.lkwork := gse.Integer_Value( cursor, 735 );
      end if;
      if not gse.Is_Null( cursor, 736 )then
         a_adult.medrec := gse.Integer_Value( cursor, 736 );
      end if;
      if not gse.Is_Null( cursor, 737 )then
         a_adult.nvqlenow := gse.Integer_Value( cursor, 737 );
      end if;
      if not gse.Is_Null( cursor, 738 )then
         a_adult.nvqlev := gse.Integer_Value( cursor, 738 );
      end if;
      if not gse.Is_Null( cursor, 739 )then
         a_adult.othpass := gse.Integer_Value( cursor, 739 );
      end if;
      if not gse.Is_Null( cursor, 740 )then
         a_adult.ppper := gse.Integer_Value( cursor, 740 );
      end if;
      if not gse.Is_Null( cursor, 741 )then
         a_adult.proptax:= Amount'Value( gse.Value( cursor, 741 ));
      end if;
      if not gse.Is_Null( cursor, 742 )then
         a_adult.reasden := gse.Integer_Value( cursor, 742 );
      end if;
      if not gse.Is_Null( cursor, 743 )then
         a_adult.reasmed := gse.Integer_Value( cursor, 743 );
      end if;
      if not gse.Is_Null( cursor, 744 )then
         a_adult.reasnhs := gse.Integer_Value( cursor, 744 );
      end if;
      if not gse.Is_Null( cursor, 745 )then
         a_adult.reason := gse.Integer_Value( cursor, 745 );
      end if;
      if not gse.Is_Null( cursor, 746 )then
         a_adult.rednet := gse.Integer_Value( cursor, 746 );
      end if;
      if not gse.Is_Null( cursor, 747 )then
         a_adult.redtax:= Amount'Value( gse.Value( cursor, 747 ));
      end if;
      if not gse.Is_Null( cursor, 748 )then
         a_adult.rsa := gse.Integer_Value( cursor, 748 );
      end if;
      if not gse.Is_Null( cursor, 749 )then
         a_adult.rsanow := gse.Integer_Value( cursor, 749 );
      end if;
      if not gse.Is_Null( cursor, 750 )then
         a_adult.samesit := gse.Integer_Value( cursor, 750 );
      end if;
      if not gse.Is_Null( cursor, 751 )then
         a_adult.scotvec := gse.Integer_Value( cursor, 751 );
      end if;
      if not gse.Is_Null( cursor, 752 )then
         a_adult.sctvnow := gse.Integer_Value( cursor, 752 );
      end if;
      if not gse.Is_Null( cursor, 753 )then
         a_adult.sdemp01 := gse.Integer_Value( cursor, 753 );
      end if;
      if not gse.Is_Null( cursor, 754 )then
         a_adult.sdemp02 := gse.Integer_Value( cursor, 754 );
      end if;
      if not gse.Is_Null( cursor, 755 )then
         a_adult.sdemp03 := gse.Integer_Value( cursor, 755 );
      end if;
      if not gse.Is_Null( cursor, 756 )then
         a_adult.sdemp04 := gse.Integer_Value( cursor, 756 );
      end if;
      if not gse.Is_Null( cursor, 757 )then
         a_adult.sdemp05 := gse.Integer_Value( cursor, 757 );
      end if;
      if not gse.Is_Null( cursor, 758 )then
         a_adult.sdemp06 := gse.Integer_Value( cursor, 758 );
      end if;
      if not gse.Is_Null( cursor, 759 )then
         a_adult.sdemp07 := gse.Integer_Value( cursor, 759 );
      end if;
      if not gse.Is_Null( cursor, 760 )then
         a_adult.sdemp08 := gse.Integer_Value( cursor, 760 );
      end if;
      if not gse.Is_Null( cursor, 761 )then
         a_adult.sdemp09 := gse.Integer_Value( cursor, 761 );
      end if;
      if not gse.Is_Null( cursor, 762 )then
         a_adult.sdemp10 := gse.Integer_Value( cursor, 762 );
      end if;
      if not gse.Is_Null( cursor, 763 )then
         a_adult.sdemp11 := gse.Integer_Value( cursor, 763 );
      end if;
      if not gse.Is_Null( cursor, 764 )then
         a_adult.sdemp12 := gse.Integer_Value( cursor, 764 );
      end if;
      if not gse.Is_Null( cursor, 765 )then
         a_adult.selfdemp := gse.Integer_Value( cursor, 765 );
      end if;
      if not gse.Is_Null( cursor, 766 )then
         a_adult.tempjob := gse.Integer_Value( cursor, 766 );
      end if;
      if not gse.Is_Null( cursor, 767 )then
         a_adult.agehq80 := gse.Integer_Value( cursor, 767 );
      end if;
      if not gse.Is_Null( cursor, 768 )then
         a_adult.disacta1 := gse.Integer_Value( cursor, 768 );
      end if;
      if not gse.Is_Null( cursor, 769 )then
         a_adult.discora1 := gse.Integer_Value( cursor, 769 );
      end if;
      if not gse.Is_Null( cursor, 770 )then
         a_adult.gross4 := gse.Integer_Value( cursor, 770 );
      end if;
      if not gse.Is_Null( cursor, 771 )then
         a_adult.ninrinc := gse.Integer_Value( cursor, 771 );
      end if;
      if not gse.Is_Null( cursor, 772 )then
         a_adult.typeed2 := gse.Integer_Value( cursor, 772 );
      end if;
      if not gse.Is_Null( cursor, 773 )then
         a_adult.w45 := gse.Integer_Value( cursor, 773 );
      end if;
      if not gse.Is_Null( cursor, 774 )then
         a_adult.accmsat := gse.Integer_Value( cursor, 774 );
      end if;
      if not gse.Is_Null( cursor, 775 )then
         a_adult.c2orign := gse.Integer_Value( cursor, 775 );
      end if;
      if not gse.Is_Null( cursor, 776 )then
         a_adult.calm := gse.Integer_Value( cursor, 776 );
      end if;
      if not gse.Is_Null( cursor, 777 )then
         a_adult.cbchk := gse.Integer_Value( cursor, 777 );
      end if;
      if not gse.Is_Null( cursor, 778 )then
         a_adult.claifut1 := gse.Integer_Value( cursor, 778 );
      end if;
      if not gse.Is_Null( cursor, 779 )then
         a_adult.claifut2 := gse.Integer_Value( cursor, 779 );
      end if;
      if not gse.Is_Null( cursor, 780 )then
         a_adult.claifut3 := gse.Integer_Value( cursor, 780 );
      end if;
      if not gse.Is_Null( cursor, 781 )then
         a_adult.claifut4 := gse.Integer_Value( cursor, 781 );
      end if;
      if not gse.Is_Null( cursor, 782 )then
         a_adult.claifut5 := gse.Integer_Value( cursor, 782 );
      end if;
      if not gse.Is_Null( cursor, 783 )then
         a_adult.claifut6 := gse.Integer_Value( cursor, 783 );
      end if;
      if not gse.Is_Null( cursor, 784 )then
         a_adult.claifut7 := gse.Integer_Value( cursor, 784 );
      end if;
      if not gse.Is_Null( cursor, 785 )then
         a_adult.claifut8 := gse.Integer_Value( cursor, 785 );
      end if;
      if not gse.Is_Null( cursor, 786 )then
         a_adult.commusat := gse.Integer_Value( cursor, 786 );
      end if;
      if not gse.Is_Null( cursor, 787 )then
         a_adult.coptrust := gse.Integer_Value( cursor, 787 );
      end if;
      if not gse.Is_Null( cursor, 788 )then
         a_adult.depress := gse.Integer_Value( cursor, 788 );
      end if;
      if not gse.Is_Null( cursor, 789 )then
         a_adult.disben1 := gse.Integer_Value( cursor, 789 );
      end if;
      if not gse.Is_Null( cursor, 790 )then
         a_adult.disben2 := gse.Integer_Value( cursor, 790 );
      end if;
      if not gse.Is_Null( cursor, 791 )then
         a_adult.disben3 := gse.Integer_Value( cursor, 791 );
      end if;
      if not gse.Is_Null( cursor, 792 )then
         a_adult.disben4 := gse.Integer_Value( cursor, 792 );
      end if;
      if not gse.Is_Null( cursor, 793 )then
         a_adult.disben5 := gse.Integer_Value( cursor, 793 );
      end if;
      if not gse.Is_Null( cursor, 794 )then
         a_adult.disben6 := gse.Integer_Value( cursor, 794 );
      end if;
      if not gse.Is_Null( cursor, 795 )then
         a_adult.discuss := gse.Integer_Value( cursor, 795 );
      end if;
      if not gse.Is_Null( cursor, 796 )then
         a_adult.dla1 := gse.Integer_Value( cursor, 796 );
      end if;
      if not gse.Is_Null( cursor, 797 )then
         a_adult.dla2 := gse.Integer_Value( cursor, 797 );
      end if;
      if not gse.Is_Null( cursor, 798 )then
         a_adult.dls := gse.Integer_Value( cursor, 798 );
      end if;
      if not gse.Is_Null( cursor, 799 )then
         a_adult.dlsamt:= Amount'Value( gse.Value( cursor, 799 ));
      end if;
      if not gse.Is_Null( cursor, 800 )then
         a_adult.dlspd := gse.Integer_Value( cursor, 800 );
      end if;
      if not gse.Is_Null( cursor, 801 )then
         a_adult.dlsval := gse.Integer_Value( cursor, 801 );
      end if;
      if not gse.Is_Null( cursor, 802 )then
         a_adult.down := gse.Integer_Value( cursor, 802 );
      end if;
      if not gse.Is_Null( cursor, 803 )then
         a_adult.envirsat := gse.Integer_Value( cursor, 803 );
      end if;
      if not gse.Is_Null( cursor, 804 )then
         a_adult.gpispc := gse.Integer_Value( cursor, 804 );
      end if;
      if not gse.Is_Null( cursor, 805 )then
         a_adult.gpjsaesa := gse.Integer_Value( cursor, 805 );
      end if;
      if not gse.Is_Null( cursor, 806 )then
         a_adult.happy := gse.Integer_Value( cursor, 806 );
      end if;
      if not gse.Is_Null( cursor, 807 )then
         a_adult.help := gse.Integer_Value( cursor, 807 );
      end if;
      if not gse.Is_Null( cursor, 808 )then
         a_adult.iclaim1 := gse.Integer_Value( cursor, 808 );
      end if;
      if not gse.Is_Null( cursor, 809 )then
         a_adult.iclaim2 := gse.Integer_Value( cursor, 809 );
      end if;
      if not gse.Is_Null( cursor, 810 )then
         a_adult.iclaim3 := gse.Integer_Value( cursor, 810 );
      end if;
      if not gse.Is_Null( cursor, 811 )then
         a_adult.iclaim4 := gse.Integer_Value( cursor, 811 );
      end if;
      if not gse.Is_Null( cursor, 812 )then
         a_adult.iclaim5 := gse.Integer_Value( cursor, 812 );
      end if;
      if not gse.Is_Null( cursor, 813 )then
         a_adult.iclaim6 := gse.Integer_Value( cursor, 813 );
      end if;
      if not gse.Is_Null( cursor, 814 )then
         a_adult.iclaim7 := gse.Integer_Value( cursor, 814 );
      end if;
      if not gse.Is_Null( cursor, 815 )then
         a_adult.iclaim8 := gse.Integer_Value( cursor, 815 );
      end if;
      if not gse.Is_Null( cursor, 816 )then
         a_adult.iclaim9 := gse.Integer_Value( cursor, 816 );
      end if;
      if not gse.Is_Null( cursor, 817 )then
         a_adult.jobsat := gse.Integer_Value( cursor, 817 );
      end if;
      if not gse.Is_Null( cursor, 818 )then
         a_adult.kidben1 := gse.Integer_Value( cursor, 818 );
      end if;
      if not gse.Is_Null( cursor, 819 )then
         a_adult.kidben2 := gse.Integer_Value( cursor, 819 );
      end if;
      if not gse.Is_Null( cursor, 820 )then
         a_adult.kidben3 := gse.Integer_Value( cursor, 820 );
      end if;
      if not gse.Is_Null( cursor, 821 )then
         a_adult.legltrus := gse.Integer_Value( cursor, 821 );
      end if;
      if not gse.Is_Null( cursor, 822 )then
         a_adult.lifesat := gse.Integer_Value( cursor, 822 );
      end if;
      if not gse.Is_Null( cursor, 823 )then
         a_adult.meaning := gse.Integer_Value( cursor, 823 );
      end if;
      if not gse.Is_Null( cursor, 824 )then
         a_adult.moneysat := gse.Integer_Value( cursor, 824 );
      end if;
      if not gse.Is_Null( cursor, 825 )then
         a_adult.nervous := gse.Integer_Value( cursor, 825 );
      end if;
      if not gse.Is_Null( cursor, 826 )then
         a_adult.ni2train := gse.Integer_Value( cursor, 826 );
      end if;
      if not gse.Is_Null( cursor, 827 )then
         a_adult.othben1 := gse.Integer_Value( cursor, 827 );
      end if;
      if not gse.Is_Null( cursor, 828 )then
         a_adult.othben2 := gse.Integer_Value( cursor, 828 );
      end if;
      if not gse.Is_Null( cursor, 829 )then
         a_adult.othben3 := gse.Integer_Value( cursor, 829 );
      end if;
      if not gse.Is_Null( cursor, 830 )then
         a_adult.othben4 := gse.Integer_Value( cursor, 830 );
      end if;
      if not gse.Is_Null( cursor, 831 )then
         a_adult.othben5 := gse.Integer_Value( cursor, 831 );
      end if;
      if not gse.Is_Null( cursor, 832 )then
         a_adult.othben6 := gse.Integer_Value( cursor, 832 );
      end if;
      if not gse.Is_Null( cursor, 833 )then
         a_adult.othtrust := gse.Integer_Value( cursor, 833 );
      end if;
      if not gse.Is_Null( cursor, 834 )then
         a_adult.penben1 := gse.Integer_Value( cursor, 834 );
      end if;
      if not gse.Is_Null( cursor, 835 )then
         a_adult.penben2 := gse.Integer_Value( cursor, 835 );
      end if;
      if not gse.Is_Null( cursor, 836 )then
         a_adult.penben3 := gse.Integer_Value( cursor, 836 );
      end if;
      if not gse.Is_Null( cursor, 837 )then
         a_adult.penben4 := gse.Integer_Value( cursor, 837 );
      end if;
      if not gse.Is_Null( cursor, 838 )then
         a_adult.penben5 := gse.Integer_Value( cursor, 838 );
      end if;
      if not gse.Is_Null( cursor, 839 )then
         a_adult.pip1 := gse.Integer_Value( cursor, 839 );
      end if;
      if not gse.Is_Null( cursor, 840 )then
         a_adult.pip2 := gse.Integer_Value( cursor, 840 );
      end if;
      if not gse.Is_Null( cursor, 841 )then
         a_adult.polttrus := gse.Integer_Value( cursor, 841 );
      end if;
      if not gse.Is_Null( cursor, 842 )then
         a_adult.recsat := gse.Integer_Value( cursor, 842 );
      end if;
      if not gse.Is_Null( cursor, 843 )then
         a_adult.relasat := gse.Integer_Value( cursor, 843 );
      end if;
      if not gse.Is_Null( cursor, 844 )then
         a_adult.safe := gse.Integer_Value( cursor, 844 );
      end if;
      if not gse.Is_Null( cursor, 845 )then
         a_adult.socfund1 := gse.Integer_Value( cursor, 845 );
      end if;
      if not gse.Is_Null( cursor, 846 )then
         a_adult.socfund2 := gse.Integer_Value( cursor, 846 );
      end if;
      if not gse.Is_Null( cursor, 847 )then
         a_adult.socfund3 := gse.Integer_Value( cursor, 847 );
      end if;
      if not gse.Is_Null( cursor, 848 )then
         a_adult.socfund4 := gse.Integer_Value( cursor, 848 );
      end if;
      if not gse.Is_Null( cursor, 849 )then
         a_adult.srispc := gse.Integer_Value( cursor, 849 );
      end if;
      if not gse.Is_Null( cursor, 850 )then
         a_adult.srjsaesa := gse.Integer_Value( cursor, 850 );
      end if;
      if not gse.Is_Null( cursor, 851 )then
         a_adult.timesat := gse.Integer_Value( cursor, 851 );
      end if;
      if not gse.Is_Null( cursor, 852 )then
         a_adult.train2 := gse.Integer_Value( cursor, 852 );
      end if;
      if not gse.Is_Null( cursor, 853 )then
         a_adult.trnallow := gse.Integer_Value( cursor, 853 );
      end if;
      if not gse.Is_Null( cursor, 854 )then
         a_adult.wageben1 := gse.Integer_Value( cursor, 854 );
      end if;
      if not gse.Is_Null( cursor, 855 )then
         a_adult.wageben2 := gse.Integer_Value( cursor, 855 );
      end if;
      if not gse.Is_Null( cursor, 856 )then
         a_adult.wageben3 := gse.Integer_Value( cursor, 856 );
      end if;
      if not gse.Is_Null( cursor, 857 )then
         a_adult.wageben4 := gse.Integer_Value( cursor, 857 );
      end if;
      if not gse.Is_Null( cursor, 858 )then
         a_adult.wageben5 := gse.Integer_Value( cursor, 858 );
      end if;
      if not gse.Is_Null( cursor, 859 )then
         a_adult.wageben6 := gse.Integer_Value( cursor, 859 );
      end if;
      if not gse.Is_Null( cursor, 860 )then
         a_adult.wageben7 := gse.Integer_Value( cursor, 860 );
      end if;
      if not gse.Is_Null( cursor, 861 )then
         a_adult.wageben8 := gse.Integer_Value( cursor, 861 );
      end if;
      if not gse.Is_Null( cursor, 862 )then
         a_adult.ninnirbn := gse.Integer_Value( cursor, 862 );
      end if;
      if not gse.Is_Null( cursor, 863 )then
         a_adult.ninothbn := gse.Integer_Value( cursor, 863 );
      end if;
      if not gse.Is_Null( cursor, 864 )then
         a_adult.anxious := gse.Integer_Value( cursor, 864 );
      end if;
      if not gse.Is_Null( cursor, 865 )then
         a_adult.candgnow := gse.Integer_Value( cursor, 865 );
      end if;
      if not gse.Is_Null( cursor, 866 )then
         a_adult.curothf := gse.Integer_Value( cursor, 866 );
      end if;
      if not gse.Is_Null( cursor, 867 )then
         a_adult.curothp := gse.Integer_Value( cursor, 867 );
      end if;
      if not gse.Is_Null( cursor, 868 )then
         a_adult.curothwv := gse.Integer_Value( cursor, 868 );
      end if;
      if not gse.Is_Null( cursor, 869 )then
         a_adult.dvhiqual := gse.Integer_Value( cursor, 869 );
      end if;
      if not gse.Is_Null( cursor, 870 )then
         a_adult.gnvqnow := gse.Integer_Value( cursor, 870 );
      end if;
      if not gse.Is_Null( cursor, 871 )then
         a_adult.gpuc := gse.Integer_Value( cursor, 871 );
      end if;
      if not gse.Is_Null( cursor, 872 )then
         a_adult.happywb := gse.Integer_Value( cursor, 872 );
      end if;
      if not gse.Is_Null( cursor, 873 )then
         a_adult.hi1qual7 := gse.Integer_Value( cursor, 873 );
      end if;
      if not gse.Is_Null( cursor, 874 )then
         a_adult.hi1qual8 := gse.Integer_Value( cursor, 874 );
      end if;
      if not gse.Is_Null( cursor, 875 )then
         a_adult.mntarr5 := gse.Integer_Value( cursor, 875 );
      end if;
      if not gse.Is_Null( cursor, 876 )then
         a_adult.mntnoch1 := gse.Integer_Value( cursor, 876 );
      end if;
      if not gse.Is_Null( cursor, 877 )then
         a_adult.mntnoch2 := gse.Integer_Value( cursor, 877 );
      end if;
      if not gse.Is_Null( cursor, 878 )then
         a_adult.mntnoch3 := gse.Integer_Value( cursor, 878 );
      end if;
      if not gse.Is_Null( cursor, 879 )then
         a_adult.mntnoch4 := gse.Integer_Value( cursor, 879 );
      end if;
      if not gse.Is_Null( cursor, 880 )then
         a_adult.mntnoch5 := gse.Integer_Value( cursor, 880 );
      end if;
      if not gse.Is_Null( cursor, 881 )then
         a_adult.mntpro1 := gse.Integer_Value( cursor, 881 );
      end if;
      if not gse.Is_Null( cursor, 882 )then
         a_adult.mntpro2 := gse.Integer_Value( cursor, 882 );
      end if;
      if not gse.Is_Null( cursor, 883 )then
         a_adult.mntpro3 := gse.Integer_Value( cursor, 883 );
      end if;
      if not gse.Is_Null( cursor, 884 )then
         a_adult.mnttim1 := gse.Integer_Value( cursor, 884 );
      end if;
      if not gse.Is_Null( cursor, 885 )then
         a_adult.mnttim2 := gse.Integer_Value( cursor, 885 );
      end if;
      if not gse.Is_Null( cursor, 886 )then
         a_adult.mnttim3 := gse.Integer_Value( cursor, 886 );
      end if;
      if not gse.Is_Null( cursor, 887 )then
         a_adult.mntwrk1 := gse.Integer_Value( cursor, 887 );
      end if;
      if not gse.Is_Null( cursor, 888 )then
         a_adult.mntwrk2 := gse.Integer_Value( cursor, 888 );
      end if;
      if not gse.Is_Null( cursor, 889 )then
         a_adult.mntwrk3 := gse.Integer_Value( cursor, 889 );
      end if;
      if not gse.Is_Null( cursor, 890 )then
         a_adult.mntwrk4 := gse.Integer_Value( cursor, 890 );
      end if;
      if not gse.Is_Null( cursor, 891 )then
         a_adult.mntwrk5 := gse.Integer_Value( cursor, 891 );
      end if;
      if not gse.Is_Null( cursor, 892 )then
         a_adult.ndeplnow := gse.Integer_Value( cursor, 892 );
      end if;
      if not gse.Is_Null( cursor, 893 )then
         a_adult.oqualc1 := gse.Integer_Value( cursor, 893 );
      end if;
      if not gse.Is_Null( cursor, 894 )then
         a_adult.oqualc2 := gse.Integer_Value( cursor, 894 );
      end if;
      if not gse.Is_Null( cursor, 895 )then
         a_adult.oqualc3 := gse.Integer_Value( cursor, 895 );
      end if;
      if not gse.Is_Null( cursor, 896 )then
         a_adult.sruc := gse.Integer_Value( cursor, 896 );
      end if;
      if not gse.Is_Null( cursor, 897 )then
         a_adult.webacnow := gse.Integer_Value( cursor, 897 );
      end if;
      if not gse.Is_Null( cursor, 898 )then
         a_adult.indeth := gse.Integer_Value( cursor, 898 );
      end if;
      if not gse.Is_Null( cursor, 899 )then
         a_adult.euactive := gse.Integer_Value( cursor, 899 );
      end if;
      if not gse.Is_Null( cursor, 900 )then
         a_adult.euactno := gse.Integer_Value( cursor, 900 );
      end if;
      if not gse.Is_Null( cursor, 901 )then
         a_adult.euartact := gse.Integer_Value( cursor, 901 );
      end if;
      if not gse.Is_Null( cursor, 902 )then
         a_adult.euaskhlp := gse.Integer_Value( cursor, 902 );
      end if;
      if not gse.Is_Null( cursor, 903 )then
         a_adult.eucinema := gse.Integer_Value( cursor, 903 );
      end if;
      if not gse.Is_Null( cursor, 904 )then
         a_adult.eucultur := gse.Integer_Value( cursor, 904 );
      end if;
      if not gse.Is_Null( cursor, 905 )then
         a_adult.euinvol := gse.Integer_Value( cursor, 905 );
      end if;
      if not gse.Is_Null( cursor, 906 )then
         a_adult.eulivpe := gse.Integer_Value( cursor, 906 );
      end if;
      if not gse.Is_Null( cursor, 907 )then
         a_adult.eumtfam := gse.Integer_Value( cursor, 907 );
      end if;
      if not gse.Is_Null( cursor, 908 )then
         a_adult.eumtfrnd := gse.Integer_Value( cursor, 908 );
      end if;
      if not gse.Is_Null( cursor, 909 )then
         a_adult.eusocnet := gse.Integer_Value( cursor, 909 );
      end if;
      if not gse.Is_Null( cursor, 910 )then
         a_adult.eusport := gse.Integer_Value( cursor, 910 );
      end if;
      if not gse.Is_Null( cursor, 911 )then
         a_adult.eutkfam := gse.Integer_Value( cursor, 911 );
      end if;
      if not gse.Is_Null( cursor, 912 )then
         a_adult.eutkfrnd := gse.Integer_Value( cursor, 912 );
      end if;
      if not gse.Is_Null( cursor, 913 )then
         a_adult.eutkmat := gse.Integer_Value( cursor, 913 );
      end if;
      if not gse.Is_Null( cursor, 914 )then
         a_adult.euvol := gse.Integer_Value( cursor, 914 );
      end if;
      if not gse.Is_Null( cursor, 915 )then
         a_adult.natscot := gse.Integer_Value( cursor, 915 );
      end if;
      if not gse.Is_Null( cursor, 916 )then
         a_adult.ntsctnow := gse.Integer_Value( cursor, 916 );
      end if;
      if not gse.Is_Null( cursor, 917 )then
         a_adult.penwel1 := gse.Integer_Value( cursor, 917 );
      end if;
      if not gse.Is_Null( cursor, 918 )then
         a_adult.penwel2 := gse.Integer_Value( cursor, 918 );
      end if;
      if not gse.Is_Null( cursor, 919 )then
         a_adult.penwel3 := gse.Integer_Value( cursor, 919 );
      end if;
      if not gse.Is_Null( cursor, 920 )then
         a_adult.penwel4 := gse.Integer_Value( cursor, 920 );
      end if;
      if not gse.Is_Null( cursor, 921 )then
         a_adult.penwel5 := gse.Integer_Value( cursor, 921 );
      end if;
      if not gse.Is_Null( cursor, 922 )then
         a_adult.penwel6 := gse.Integer_Value( cursor, 922 );
      end if;
      if not gse.Is_Null( cursor, 923 )then
         a_adult.skiwknow := gse.Integer_Value( cursor, 923 );
      end if;
      if not gse.Is_Null( cursor, 924 )then
         a_adult.skiwrk := gse.Integer_Value( cursor, 924 );
      end if;
      if not gse.Is_Null( cursor, 925 )then
         a_adult.slos := gse.Integer_Value( cursor, 925 );
      end if;
      if not gse.Is_Null( cursor, 926 )then
         a_adult.yjblev := gse.Integer_Value( cursor, 926 );
      end if;
      return a_adult;
   end Map_From_Cursor;

   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Adult_List is
      l : Ukds.Frs.Adult_List;
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
            a_adult : Ukds.Frs.Adult := Map_From_Cursor( cursor );
         begin
            l.append( a_adult ); 
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
   
   procedure Update( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) is
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

      params( 1 ) := "+"( Integer'Pos( a_adult.abs1no ));
      params( 2 ) := "+"( Integer'Pos( a_adult.abs2no ));
      params( 3 ) := "+"( Integer'Pos( a_adult.abspar ));
      params( 4 ) := "+"( Integer'Pos( a_adult.abspay ));
      params( 5 ) := "+"( Integer'Pos( a_adult.abswhy ));
      params( 6 ) := "+"( Integer'Pos( a_adult.abswk ));
      params( 7 ) := "+"( Integer'Pos( a_adult.x_access ));
      params( 8 ) := "+"( Integer'Pos( a_adult.accftpt ));
      params( 9 ) := "+"( Integer'Pos( a_adult.accjb ));
      params( 10 ) := "+"( Float( a_adult.accssamt ));
      params( 11 ) := "+"( Integer'Pos( a_adult.accsspd ));
      params( 12 ) := "+"( Integer'Pos( a_adult.adeduc ));
      params( 13 ) := "+"( Integer'Pos( a_adult.adema ));
      params( 14 ) := "+"( Float( a_adult.ademaamt ));
      params( 15 ) := "+"( Integer'Pos( a_adult.ademapd ));
      params( 16 ) := "+"( Integer'Pos( a_adult.age ));
      params( 17 ) := "+"( Integer'Pos( a_adult.allow1 ));
      params( 18 ) := "+"( Integer'Pos( a_adult.allow2 ));
      params( 19 ) := "+"( Integer'Pos( a_adult.allow3 ));
      params( 20 ) := "+"( Integer'Pos( a_adult.allow4 ));
      params( 21 ) := "+"( Float( a_adult.allpay1 ));
      params( 22 ) := "+"( Float( a_adult.allpay2 ));
      params( 23 ) := "+"( Float( a_adult.allpay3 ));
      params( 24 ) := "+"( Float( a_adult.allpay4 ));
      params( 25 ) := "+"( Integer'Pos( a_adult.allpd1 ));
      params( 26 ) := "+"( Integer'Pos( a_adult.allpd2 ));
      params( 27 ) := "+"( Integer'Pos( a_adult.allpd3 ));
      params( 28 ) := "+"( Integer'Pos( a_adult.allpd4 ));
      params( 29 ) := "+"( Integer'Pos( a_adult.anyacc ));
      params( 30 ) := "+"( Integer'Pos( a_adult.anyed ));
      params( 31 ) := "+"( Integer'Pos( a_adult.anymon ));
      params( 32 ) := "+"( Integer'Pos( a_adult.anypen1 ));
      params( 33 ) := "+"( Integer'Pos( a_adult.anypen2 ));
      params( 34 ) := "+"( Integer'Pos( a_adult.anypen3 ));
      params( 35 ) := "+"( Integer'Pos( a_adult.anypen4 ));
      params( 36 ) := "+"( Integer'Pos( a_adult.anypen5 ));
      params( 37 ) := "+"( Integer'Pos( a_adult.anypen6 ));
      params( 38 ) := "+"( Integer'Pos( a_adult.anypen7 ));
      params( 39 ) := "+"( Float( a_adult.apamt ));
      params( 40 ) := "+"( Float( a_adult.apdamt ));
      params( 41 ) := "+"( Integer'Pos( a_adult.apdir ));
      params( 42 ) := "+"( Integer'Pos( a_adult.apdpd ));
      params( 43 ) := "+"( Integer'Pos( a_adult.appd ));
      params( 44 ) := "+"( Integer'Pos( a_adult.b2qfut1 ));
      params( 45 ) := "+"( Integer'Pos( a_adult.b2qfut2 ));
      params( 46 ) := "+"( Integer'Pos( a_adult.b2qfut3 ));
      params( 47 ) := "+"( Integer'Pos( a_adult.b3qfut1 ));
      params( 48 ) := "+"( Integer'Pos( a_adult.b3qfut2 ));
      params( 49 ) := "+"( Integer'Pos( a_adult.b3qfut3 ));
      params( 50 ) := "+"( Integer'Pos( a_adult.b3qfut4 ));
      params( 51 ) := "+"( Integer'Pos( a_adult.b3qfut5 ));
      params( 52 ) := "+"( Integer'Pos( a_adult.b3qfut6 ));
      params( 53 ) := "+"( Integer'Pos( a_adult.ben1q1 ));
      params( 54 ) := "+"( Integer'Pos( a_adult.ben1q2 ));
      params( 55 ) := "+"( Integer'Pos( a_adult.ben1q3 ));
      params( 56 ) := "+"( Integer'Pos( a_adult.ben1q4 ));
      params( 57 ) := "+"( Integer'Pos( a_adult.ben1q5 ));
      params( 58 ) := "+"( Integer'Pos( a_adult.ben1q6 ));
      params( 59 ) := "+"( Integer'Pos( a_adult.ben1q7 ));
      params( 60 ) := "+"( Integer'Pos( a_adult.ben2q1 ));
      params( 61 ) := "+"( Integer'Pos( a_adult.ben2q2 ));
      params( 62 ) := "+"( Integer'Pos( a_adult.ben2q3 ));
      params( 63 ) := "+"( Integer'Pos( a_adult.ben3q1 ));
      params( 64 ) := "+"( Integer'Pos( a_adult.ben3q2 ));
      params( 65 ) := "+"( Integer'Pos( a_adult.ben3q3 ));
      params( 66 ) := "+"( Integer'Pos( a_adult.ben3q4 ));
      params( 67 ) := "+"( Integer'Pos( a_adult.ben3q5 ));
      params( 68 ) := "+"( Integer'Pos( a_adult.ben3q6 ));
      params( 69 ) := "+"( Integer'Pos( a_adult.ben4q1 ));
      params( 70 ) := "+"( Integer'Pos( a_adult.ben4q2 ));
      params( 71 ) := "+"( Integer'Pos( a_adult.ben4q3 ));
      params( 72 ) := "+"( Integer'Pos( a_adult.ben5q1 ));
      params( 73 ) := "+"( Integer'Pos( a_adult.ben5q2 ));
      params( 74 ) := "+"( Integer'Pos( a_adult.ben5q3 ));
      params( 75 ) := "+"( Integer'Pos( a_adult.ben5q4 ));
      params( 76 ) := "+"( Integer'Pos( a_adult.ben5q5 ));
      params( 77 ) := "+"( Integer'Pos( a_adult.ben5q6 ));
      params( 78 ) := "+"( Integer'Pos( a_adult.ben7q1 ));
      params( 79 ) := "+"( Integer'Pos( a_adult.ben7q2 ));
      params( 80 ) := "+"( Integer'Pos( a_adult.ben7q3 ));
      params( 81 ) := "+"( Integer'Pos( a_adult.ben7q4 ));
      params( 82 ) := "+"( Integer'Pos( a_adult.ben7q5 ));
      params( 83 ) := "+"( Integer'Pos( a_adult.ben7q6 ));
      params( 84 ) := "+"( Integer'Pos( a_adult.ben7q7 ));
      params( 85 ) := "+"( Integer'Pos( a_adult.ben7q8 ));
      params( 86 ) := "+"( Integer'Pos( a_adult.ben7q9 ));
      params( 87 ) := "+"( Integer'Pos( a_adult.btwacc ));
      params( 88 ) := "+"( Integer'Pos( a_adult.claimant ));
      params( 89 ) := "+"( Integer'Pos( a_adult.cohabit ));
      params( 90 ) := "+"( Integer'Pos( a_adult.combid ));
      params( 91 ) := "+"( Integer'Pos( a_adult.convbl ));
      params( 92 ) := "+"( Integer'Pos( a_adult.ctclum1 ));
      params( 93 ) := "+"( Integer'Pos( a_adult.ctclum2 ));
      params( 94 ) := "+"( Integer'Pos( a_adult.cupchk ));
      params( 95 ) := "+"( Integer'Pos( a_adult.cvht ));
      params( 96 ) := "+"( Float( a_adult.cvpay ));
      params( 97 ) := "+"( Integer'Pos( a_adult.cvpd ));
      params( 98 ) := "+"( Integer'Pos( a_adult.dentist ));
      params( 99 ) := "+"( Integer'Pos( a_adult.depend ));
      params( 100 ) := "+"( Integer'Pos( a_adult.disdif1 ));
      params( 101 ) := "+"( Integer'Pos( a_adult.disdif2 ));
      params( 102 ) := "+"( Integer'Pos( a_adult.disdif3 ));
      params( 103 ) := "+"( Integer'Pos( a_adult.disdif4 ));
      params( 104 ) := "+"( Integer'Pos( a_adult.disdif5 ));
      params( 105 ) := "+"( Integer'Pos( a_adult.disdif6 ));
      params( 106 ) := "+"( Integer'Pos( a_adult.disdif7 ));
      params( 107 ) := "+"( Integer'Pos( a_adult.disdif8 ));
      params( 108 ) := "+"( a_adult.dob );
      params( 109 ) := "+"( Integer'Pos( a_adult.dptcboth ));
      params( 110 ) := "+"( Integer'Pos( a_adult.dptclum ));
      params( 111 ) := "+"( Integer'Pos( a_adult.dvil03a ));
      params( 112 ) := "+"( Integer'Pos( a_adult.dvil04a ));
      params( 113 ) := "+"( Integer'Pos( a_adult.dvjb12ml ));
      params( 114 ) := "+"( Integer'Pos( a_adult.dvmardf ));
      params( 115 ) := "+"( Float( a_adult.ed1amt ));
      params( 116 ) := "+"( Integer'Pos( a_adult.ed1borr ));
      params( 117 ) := "+"( Integer'Pos( a_adult.ed1int ));
      params( 118 ) := "+"( a_adult.ed1monyr );
      params( 119 ) := "+"( Integer'Pos( a_adult.ed1pd ));
      params( 120 ) := "+"( Integer'Pos( a_adult.ed1sum ));
      params( 121 ) := "+"( Float( a_adult.ed2amt ));
      params( 122 ) := "+"( Integer'Pos( a_adult.ed2borr ));
      params( 123 ) := "+"( Integer'Pos( a_adult.ed2int ));
      params( 124 ) := "+"( a_adult.ed2monyr );
      params( 125 ) := "+"( Integer'Pos( a_adult.ed2pd ));
      params( 126 ) := "+"( Integer'Pos( a_adult.ed2sum ));
      params( 127 ) := "+"( Integer'Pos( a_adult.edatt ));
      params( 128 ) := "+"( Integer'Pos( a_adult.edattn1 ));
      params( 129 ) := "+"( Integer'Pos( a_adult.edattn2 ));
      params( 130 ) := "+"( Integer'Pos( a_adult.edattn3 ));
      params( 131 ) := "+"( Integer'Pos( a_adult.edhr ));
      params( 132 ) := "+"( Integer'Pos( a_adult.edtime ));
      params( 133 ) := "+"( Integer'Pos( a_adult.edtyp ));
      params( 134 ) := "+"( Integer'Pos( a_adult.eligadlt ));
      params( 135 ) := "+"( Integer'Pos( a_adult.eligchld ));
      params( 136 ) := "+"( Integer'Pos( a_adult.emppay1 ));
      params( 137 ) := "+"( Integer'Pos( a_adult.emppay2 ));
      params( 138 ) := "+"( Integer'Pos( a_adult.emppay3 ));
      params( 139 ) := "+"( Integer'Pos( a_adult.empstat ));
      params( 140 ) := "+"( Integer'Pos( a_adult.endyr ));
      params( 141 ) := "+"( Integer'Pos( a_adult.epcur ));
      params( 142 ) := "+"( Integer'Pos( a_adult.es2000 ));
      params( 143 ) := "+"( Integer'Pos( a_adult.ethgrp ));
      params( 144 ) := "+"( Integer'Pos( a_adult.everwrk ));
      params( 145 ) := "+"( Integer'Pos( a_adult.exthbct1 ));
      params( 146 ) := "+"( Integer'Pos( a_adult.exthbct2 ));
      params( 147 ) := "+"( Integer'Pos( a_adult.exthbct3 ));
      params( 148 ) := "+"( Integer'Pos( a_adult.eyetest ));
      params( 149 ) := "+"( Integer'Pos( a_adult.follow ));
      params( 150 ) := "+"( Integer'Pos( a_adult.fted ));
      params( 151 ) := "+"( Integer'Pos( a_adult.ftwk ));
      params( 152 ) := "+"( Integer'Pos( a_adult.future ));
      params( 153 ) := "+"( Integer'Pos( a_adult.govpis ));
      params( 154 ) := "+"( Integer'Pos( a_adult.govpjsa ));
      params( 155 ) := "+"( Integer'Pos( a_adult.x_grant ));
      params( 156 ) := "+"( Float( a_adult.grtamt1 ));
      params( 157 ) := "+"( Float( a_adult.grtamt2 ));
      params( 158 ) := "+"( Float( a_adult.grtdir1 ));
      params( 159 ) := "+"( Float( a_adult.grtdir2 ));
      params( 160 ) := "+"( Integer'Pos( a_adult.grtnum ));
      params( 161 ) := "+"( Integer'Pos( a_adult.grtsce1 ));
      params( 162 ) := "+"( Integer'Pos( a_adult.grtsce2 ));
      params( 163 ) := "+"( Float( a_adult.grtval1 ));
      params( 164 ) := "+"( Float( a_adult.grtval2 ));
      params( 165 ) := "+"( Integer'Pos( a_adult.gta ));
      params( 166 ) := "+"( Float( a_adult.hbothamt ));
      params( 167 ) := "+"( Integer'Pos( a_adult.hbothbu ));
      params( 168 ) := "+"( Integer'Pos( a_adult.hbothpd ));
      params( 169 ) := "+"( Integer'Pos( a_adult.hbothwk ));
      params( 170 ) := "+"( Integer'Pos( a_adult.hbotwait ));
      params( 171 ) := "+"( Integer'Pos( a_adult.health ));
      params( 172 ) := "+"( Integer'Pos( a_adult.hholder ));
      params( 173 ) := "+"( Integer'Pos( a_adult.hosp ));
      params( 174 ) := "+"( Integer'Pos( a_adult.hprob ));
      params( 175 ) := "+"( Integer'Pos( a_adult.hrpid ));
      params( 176 ) := "+"( Integer'Pos( a_adult.incdur ));
      params( 177 ) := "+"( Integer'Pos( a_adult.injlong ));
      params( 178 ) := "+"( Integer'Pos( a_adult.injwk ));
      params( 179 ) := "+"( Integer'Pos( a_adult.invests ));
      params( 180 ) := "+"( Integer'Pos( a_adult.iout ));
      params( 181 ) := "+"( Integer'Pos( a_adult.isa1type ));
      params( 182 ) := "+"( Integer'Pos( a_adult.isa2type ));
      params( 183 ) := "+"( Integer'Pos( a_adult.isa3type ));
      params( 184 ) := "+"( Integer'Pos( a_adult.jobaway ));
      params( 185 ) := "+"( Integer'Pos( a_adult.lareg ));
      params( 186 ) := "+"( Integer'Pos( a_adult.likewk ));
      params( 187 ) := "+"( Integer'Pos( a_adult.lktime ));
      params( 188 ) := "+"( Integer'Pos( a_adult.ln1rpint ));
      params( 189 ) := "+"( Integer'Pos( a_adult.ln2rpint ));
      params( 190 ) := "+"( Integer'Pos( a_adult.loan ));
      params( 191 ) := "+"( Integer'Pos( a_adult.loannum ));
      params( 192 ) := "+"( Integer'Pos( a_adult.look ));
      params( 193 ) := "+"( Integer'Pos( a_adult.lookwk ));
      params( 194 ) := "+"( Integer'Pos( a_adult.lstwrk1 ));
      params( 195 ) := "+"( Integer'Pos( a_adult.lstwrk2 ));
      params( 196 ) := "+"( Integer'Pos( a_adult.lstyr ));
      params( 197 ) := "+"( Float( a_adult.mntamt1 ));
      params( 198 ) := "+"( Float( a_adult.mntamt2 ));
      params( 199 ) := "+"( Integer'Pos( a_adult.mntct ));
      params( 200 ) := "+"( Integer'Pos( a_adult.mntfor1 ));
      params( 201 ) := "+"( Integer'Pos( a_adult.mntfor2 ));
      params( 202 ) := "+"( Integer'Pos( a_adult.mntgov1 ));
      params( 203 ) := "+"( Integer'Pos( a_adult.mntgov2 ));
      params( 204 ) := "+"( Integer'Pos( a_adult.mntpay ));
      params( 205 ) := "+"( Integer'Pos( a_adult.mntpd1 ));
      params( 206 ) := "+"( Integer'Pos( a_adult.mntpd2 ));
      params( 207 ) := "+"( Integer'Pos( a_adult.mntrec ));
      params( 208 ) := "+"( Integer'Pos( a_adult.mnttota1 ));
      params( 209 ) := "+"( Integer'Pos( a_adult.mnttota2 ));
      params( 210 ) := "+"( Integer'Pos( a_adult.mntus1 ));
      params( 211 ) := "+"( Integer'Pos( a_adult.mntus2 ));
      params( 212 ) := "+"( Float( a_adult.mntusam1 ));
      params( 213 ) := "+"( Float( a_adult.mntusam2 ));
      params( 214 ) := "+"( Integer'Pos( a_adult.mntuspd1 ));
      params( 215 ) := "+"( Integer'Pos( a_adult.mntuspd2 ));
      params( 216 ) := "+"( Integer'Pos( a_adult.ms ));
      params( 217 ) := "+"( Integer'Pos( a_adult.natid1 ));
      params( 218 ) := "+"( Integer'Pos( a_adult.natid2 ));
      params( 219 ) := "+"( Integer'Pos( a_adult.natid3 ));
      params( 220 ) := "+"( Integer'Pos( a_adult.natid4 ));
      params( 221 ) := "+"( Integer'Pos( a_adult.natid5 ));
      params( 222 ) := "+"( Integer'Pos( a_adult.natid6 ));
      params( 223 ) := "+"( Integer'Pos( a_adult.ndeal ));
      params( 224 ) := "+"( Integer'Pos( a_adult.newdtype ));
      params( 225 ) := "+"( Integer'Pos( a_adult.nhs1 ));
      params( 226 ) := "+"( Integer'Pos( a_adult.nhs2 ));
      params( 227 ) := "+"( Integer'Pos( a_adult.nhs3 ));
      params( 228 ) := "+"( Float( a_adult.niamt ));
      params( 229 ) := "+"( Integer'Pos( a_adult.niethgrp ));
      params( 230 ) := "+"( Integer'Pos( a_adult.niexthbb ));
      params( 231 ) := "+"( Integer'Pos( a_adult.ninatid1 ));
      params( 232 ) := "+"( Integer'Pos( a_adult.ninatid2 ));
      params( 233 ) := "+"( Integer'Pos( a_adult.ninatid3 ));
      params( 234 ) := "+"( Integer'Pos( a_adult.ninatid4 ));
      params( 235 ) := "+"( Integer'Pos( a_adult.ninatid5 ));
      params( 236 ) := "+"( Integer'Pos( a_adult.ninatid6 ));
      params( 237 ) := "+"( Integer'Pos( a_adult.ninatid7 ));
      params( 238 ) := "+"( Integer'Pos( a_adult.ninatid8 ));
      params( 239 ) := "+"( Integer'Pos( a_adult.nipd ));
      params( 240 ) := "+"( Integer'Pos( a_adult.nireg ));
      params( 241 ) := "+"( Integer'Pos( a_adult.nirel ));
      params( 242 ) := "+"( Integer'Pos( a_adult.nitrain ));
      params( 243 ) := "+"( Integer'Pos( a_adult.nlper ));
      params( 244 ) := "+"( Integer'Pos( a_adult.nolk1 ));
      params( 245 ) := "+"( Integer'Pos( a_adult.nolk2 ));
      params( 246 ) := "+"( Integer'Pos( a_adult.nolk3 ));
      params( 247 ) := "+"( Integer'Pos( a_adult.nolook ));
      params( 248 ) := "+"( Integer'Pos( a_adult.nowant ));
      params( 249 ) := "+"( Float( a_adult.nssec ));
      params( 250 ) := "+"( Integer'Pos( a_adult.ntcapp ));
      params( 251 ) := "+"( Integer'Pos( a_adult.ntcdat ));
      params( 252 ) := "+"( Float( a_adult.ntcinc ));
      params( 253 ) := "+"( Integer'Pos( a_adult.ntcorig1 ));
      params( 254 ) := "+"( Integer'Pos( a_adult.ntcorig2 ));
      params( 255 ) := "+"( Integer'Pos( a_adult.ntcorig3 ));
      params( 256 ) := "+"( Integer'Pos( a_adult.ntcorig4 ));
      params( 257 ) := "+"( Integer'Pos( a_adult.ntcorig5 ));
      params( 258 ) := "+"( Integer'Pos( a_adult.numjob ));
      params( 259 ) := "+"( Integer'Pos( a_adult.numjob2 ));
      params( 260 ) := "+"( Integer'Pos( a_adult.oddjob ));
      params( 261 ) := "+"( Integer'Pos( a_adult.oldstud ));
      params( 262 ) := "+"( Integer'Pos( a_adult.otabspar ));
      params( 263 ) := "+"( Float( a_adult.otamt ));
      params( 264 ) := "+"( Float( a_adult.otapamt ));
      params( 265 ) := "+"( Integer'Pos( a_adult.otappd ));
      params( 266 ) := "+"( Integer'Pos( a_adult.othtax ));
      params( 267 ) := "+"( Integer'Pos( a_adult.otinva ));
      params( 268 ) := "+"( Float( a_adult.pareamt ));
      params( 269 ) := "+"( Integer'Pos( a_adult.parepd ));
      params( 270 ) := "+"( Integer'Pos( a_adult.penlump ));
      params( 271 ) := "+"( Integer'Pos( a_adult.ppnumc ));
      params( 272 ) := "+"( Integer'Pos( a_adult.prit ));
      params( 273 ) := "+"( Integer'Pos( a_adult.prscrpt ));
      params( 274 ) := "+"( Integer'Pos( a_adult.ptwk ));
      params( 275 ) := "+"( Integer'Pos( a_adult.r01 ));
      params( 276 ) := "+"( Integer'Pos( a_adult.r02 ));
      params( 277 ) := "+"( Integer'Pos( a_adult.r03 ));
      params( 278 ) := "+"( Integer'Pos( a_adult.r04 ));
      params( 279 ) := "+"( Integer'Pos( a_adult.r05 ));
      params( 280 ) := "+"( Integer'Pos( a_adult.r06 ));
      params( 281 ) := "+"( Integer'Pos( a_adult.r07 ));
      params( 282 ) := "+"( Integer'Pos( a_adult.r08 ));
      params( 283 ) := "+"( Integer'Pos( a_adult.r09 ));
      params( 284 ) := "+"( Integer'Pos( a_adult.r10 ));
      params( 285 ) := "+"( Integer'Pos( a_adult.r11 ));
      params( 286 ) := "+"( Integer'Pos( a_adult.r12 ));
      params( 287 ) := "+"( Integer'Pos( a_adult.r13 ));
      params( 288 ) := "+"( Integer'Pos( a_adult.r14 ));
      params( 289 ) := "+"( Float( a_adult.redamt ));
      params( 290 ) := "+"( Integer'Pos( a_adult.redany ));
      params( 291 ) := "+"( Integer'Pos( a_adult.rentprof ));
      params( 292 ) := "+"( Integer'Pos( a_adult.retire ));
      params( 293 ) := "+"( Integer'Pos( a_adult.retire1 ));
      params( 294 ) := "+"( Integer'Pos( a_adult.retreas ));
      params( 295 ) := "+"( Integer'Pos( a_adult.royal1 ));
      params( 296 ) := "+"( Integer'Pos( a_adult.royal2 ));
      params( 297 ) := "+"( Integer'Pos( a_adult.royal3 ));
      params( 298 ) := "+"( Integer'Pos( a_adult.royal4 ));
      params( 299 ) := "+"( Float( a_adult.royyr1 ));
      params( 300 ) := "+"( Float( a_adult.royyr2 ));
      params( 301 ) := "+"( Float( a_adult.royyr3 ));
      params( 302 ) := "+"( Float( a_adult.royyr4 ));
      params( 303 ) := "+"( Integer'Pos( a_adult.rstrct ));
      params( 304 ) := "+"( Integer'Pos( a_adult.sex ));
      params( 305 ) := "+"( Integer'Pos( a_adult.sflntyp1 ));
      params( 306 ) := "+"( Integer'Pos( a_adult.sflntyp2 ));
      params( 307 ) := "+"( Integer'Pos( a_adult.sftype1 ));
      params( 308 ) := "+"( Integer'Pos( a_adult.sftype2 ));
      params( 309 ) := "+"( Integer'Pos( a_adult.sic ));
      params( 310 ) := "+"( Float( a_adult.slrepamt ));
      params( 311 ) := "+"( Integer'Pos( a_adult.slrepay ));
      params( 312 ) := "+"( Integer'Pos( a_adult.slreppd ));
      params( 313 ) := "+"( Integer'Pos( a_adult.soc2000 ));
      params( 314 ) := "+"( Integer'Pos( a_adult.spcreg1 ));
      params( 315 ) := "+"( Integer'Pos( a_adult.spcreg2 ));
      params( 316 ) := "+"( Integer'Pos( a_adult.spcreg3 ));
      params( 317 ) := "+"( Integer'Pos( a_adult.specs ));
      params( 318 ) := "+"( Integer'Pos( a_adult.spout ));
      params( 319 ) := "+"( Float( a_adult.srentamt ));
      params( 320 ) := "+"( Integer'Pos( a_adult.srentpd ));
      params( 321 ) := "+"( Integer'Pos( a_adult.start ));
      params( 322 ) := "+"( Integer'Pos( a_adult.startyr ));
      params( 323 ) := "+"( Integer'Pos( a_adult.taxcred1 ));
      params( 324 ) := "+"( Integer'Pos( a_adult.taxcred2 ));
      params( 325 ) := "+"( Integer'Pos( a_adult.taxcred3 ));
      params( 326 ) := "+"( Integer'Pos( a_adult.taxcred4 ));
      params( 327 ) := "+"( Integer'Pos( a_adult.taxcred5 ));
      params( 328 ) := "+"( Integer'Pos( a_adult.taxfut ));
      params( 329 ) := "+"( Integer'Pos( a_adult.tdaywrk ));
      params( 330 ) := "+"( Integer'Pos( a_adult.tea ));
      params( 331 ) := "+"( Integer'Pos( a_adult.topupl ));
      params( 332 ) := "+"( Float( a_adult.totint ));
      params( 333 ) := "+"( Integer'Pos( a_adult.train ));
      params( 334 ) := "+"( Integer'Pos( a_adult.trav ));
      params( 335 ) := "+"( Integer'Pos( a_adult.tuborr ));
      params( 336 ) := "+"( Integer'Pos( a_adult.typeed ));
      params( 337 ) := "+"( Integer'Pos( a_adult.unpaid1 ));
      params( 338 ) := "+"( Integer'Pos( a_adult.unpaid2 ));
      params( 339 ) := "+"( Integer'Pos( a_adult.voucher ));
      params( 340 ) := "+"( Integer'Pos( a_adult.w1 ));
      params( 341 ) := "+"( Integer'Pos( a_adult.w2 ));
      params( 342 ) := "+"( Integer'Pos( a_adult.wait ));
      params( 343 ) := "+"( Integer'Pos( a_adult.war1 ));
      params( 344 ) := "+"( Integer'Pos( a_adult.war2 ));
      params( 345 ) := "+"( Integer'Pos( a_adult.wftcboth ));
      params( 346 ) := "+"( Integer'Pos( a_adult.wftclum ));
      params( 347 ) := "+"( Integer'Pos( a_adult.whoresp ));
      params( 348 ) := "+"( Integer'Pos( a_adult.whosectb ));
      params( 349 ) := "+"( Integer'Pos( a_adult.whyfrde1 ));
      params( 350 ) := "+"( Integer'Pos( a_adult.whyfrde2 ));
      params( 351 ) := "+"( Integer'Pos( a_adult.whyfrde3 ));
      params( 352 ) := "+"( Integer'Pos( a_adult.whyfrde4 ));
      params( 353 ) := "+"( Integer'Pos( a_adult.whyfrde5 ));
      params( 354 ) := "+"( Integer'Pos( a_adult.whyfrde6 ));
      params( 355 ) := "+"( Integer'Pos( a_adult.whyfrey1 ));
      params( 356 ) := "+"( Integer'Pos( a_adult.whyfrey2 ));
      params( 357 ) := "+"( Integer'Pos( a_adult.whyfrey3 ));
      params( 358 ) := "+"( Integer'Pos( a_adult.whyfrey4 ));
      params( 359 ) := "+"( Integer'Pos( a_adult.whyfrey5 ));
      params( 360 ) := "+"( Integer'Pos( a_adult.whyfrey6 ));
      params( 361 ) := "+"( Integer'Pos( a_adult.whyfrpr1 ));
      params( 362 ) := "+"( Integer'Pos( a_adult.whyfrpr2 ));
      params( 363 ) := "+"( Integer'Pos( a_adult.whyfrpr3 ));
      params( 364 ) := "+"( Integer'Pos( a_adult.whyfrpr4 ));
      params( 365 ) := "+"( Integer'Pos( a_adult.whyfrpr5 ));
      params( 366 ) := "+"( Integer'Pos( a_adult.whyfrpr6 ));
      params( 367 ) := "+"( Integer'Pos( a_adult.whytrav1 ));
      params( 368 ) := "+"( Integer'Pos( a_adult.whytrav2 ));
      params( 369 ) := "+"( Integer'Pos( a_adult.whytrav3 ));
      params( 370 ) := "+"( Integer'Pos( a_adult.whytrav4 ));
      params( 371 ) := "+"( Integer'Pos( a_adult.whytrav5 ));
      params( 372 ) := "+"( Integer'Pos( a_adult.whytrav6 ));
      params( 373 ) := "+"( Integer'Pos( a_adult.wintfuel ));
      params( 374 ) := "+"( Integer'Pos( a_adult.wmkit ));
      params( 375 ) := "+"( Integer'Pos( a_adult.working ));
      params( 376 ) := "+"( Integer'Pos( a_adult.wpa ));
      params( 377 ) := "+"( Integer'Pos( a_adult.wpba ));
      params( 378 ) := "+"( Integer'Pos( a_adult.wtclum1 ));
      params( 379 ) := "+"( Integer'Pos( a_adult.wtclum2 ));
      params( 380 ) := "+"( Integer'Pos( a_adult.wtclum3 ));
      params( 381 ) := "+"( Integer'Pos( a_adult.ystrtwk ));
      params( 382 ) := "+"( Integer'Pos( a_adult.month ));
      params( 383 ) := "+"( Integer'Pos( a_adult.able ));
      params( 384 ) := "+"( Integer'Pos( a_adult.actacci ));
      params( 385 ) := "+"( Integer'Pos( a_adult.addda ));
      params( 386 ) := "+"( Integer'Pos( a_adult.basacti ));
      params( 387 ) := "+"( Float( a_adult.bntxcred ));
      params( 388 ) := "+"( Integer'Pos( a_adult.careab ));
      params( 389 ) := "+"( Integer'Pos( a_adult.careah ));
      params( 390 ) := "+"( Integer'Pos( a_adult.carecb ));
      params( 391 ) := "+"( Integer'Pos( a_adult.carech ));
      params( 392 ) := "+"( Integer'Pos( a_adult.carecl ));
      params( 393 ) := "+"( Integer'Pos( a_adult.carefl ));
      params( 394 ) := "+"( Integer'Pos( a_adult.carefr ));
      params( 395 ) := "+"( Integer'Pos( a_adult.careot ));
      params( 396 ) := "+"( Integer'Pos( a_adult.carere ));
      params( 397 ) := "+"( Integer'Pos( a_adult.curacti ));
      params( 398 ) := "+"( Float( a_adult.empoccp ));
      params( 399 ) := "+"( Integer'Pos( a_adult.empstatb ));
      params( 400 ) := "+"( Integer'Pos( a_adult.empstatc ));
      params( 401 ) := "+"( Integer'Pos( a_adult.empstati ));
      params( 402 ) := "+"( Integer'Pos( a_adult.fsbndcti ));
      params( 403 ) := "+"( Float( a_adult.fwmlkval ));
      params( 404 ) := "+"( Integer'Pos( a_adult.gebacti ));
      params( 405 ) := "+"( Integer'Pos( a_adult.giltcti ));
      params( 406 ) := "+"( Integer'Pos( a_adult.gross2 ));
      params( 407 ) := "+"( Integer'Pos( a_adult.gross3 ));
      params( 408 ) := "+"( Float( a_adult.hbsupran ));
      params( 409 ) := "+"( Integer'Pos( a_adult.hdage ));
      params( 410 ) := "+"( Integer'Pos( a_adult.hdben ));
      params( 411 ) := "+"( Integer'Pos( a_adult.hdindinc ));
      params( 412 ) := "+"( Integer'Pos( a_adult.hourab ));
      params( 413 ) := "+"( Integer'Pos( a_adult.hourah ));
      params( 414 ) := "+"( Float( a_adult.hourcare ));
      params( 415 ) := "+"( Integer'Pos( a_adult.hourcb ));
      params( 416 ) := "+"( Integer'Pos( a_adult.hourch ));
      params( 417 ) := "+"( Integer'Pos( a_adult.hourcl ));
      params( 418 ) := "+"( Integer'Pos( a_adult.hourfr ));
      params( 419 ) := "+"( Integer'Pos( a_adult.hourot ));
      params( 420 ) := "+"( Integer'Pos( a_adult.hourre ));
      params( 421 ) := "+"( Integer'Pos( a_adult.hourtot ));
      params( 422 ) := "+"( Integer'Pos( a_adult.hperson ));
      params( 423 ) := "+"( Integer'Pos( a_adult.iagegr2 ));
      params( 424 ) := "+"( Integer'Pos( a_adult.iagegrp ));
      params( 425 ) := "+"( Float( a_adult.incseo2 ));
      params( 426 ) := "+"( Integer'Pos( a_adult.indinc ));
      params( 427 ) := "+"( Integer'Pos( a_adult.indisben ));
      params( 428 ) := "+"( Float( a_adult.inearns ));
      params( 429 ) := "+"( Float( a_adult.ininv ));
      params( 430 ) := "+"( Integer'Pos( a_adult.inirben ));
      params( 431 ) := "+"( Integer'Pos( a_adult.innirben ));
      params( 432 ) := "+"( Integer'Pos( a_adult.inothben ));
      params( 433 ) := "+"( Float( a_adult.inpeninc ));
      params( 434 ) := "+"( Float( a_adult.inrinc ));
      params( 435 ) := "+"( Float( a_adult.inrpinc ));
      params( 436 ) := "+"( Float( a_adult.intvlic ));
      params( 437 ) := "+"( Float( a_adult.intxcred ));
      params( 438 ) := "+"( Integer'Pos( a_adult.isacti ));
      params( 439 ) := "+"( Integer'Pos( a_adult.marital ));
      params( 440 ) := "+"( Float( a_adult.netocpen ));
      params( 441 ) := "+"( Float( a_adult.nincseo2 ));
      params( 442 ) := "+"( Integer'Pos( a_adult.nindinc ));
      params( 443 ) := "+"( Integer'Pos( a_adult.ninearns ));
      params( 444 ) := "+"( Integer'Pos( a_adult.nininv ));
      params( 445 ) := "+"( Integer'Pos( a_adult.ninpenin ));
      params( 446 ) := "+"( Float( a_adult.ninsein2 ));
      params( 447 ) := "+"( Integer'Pos( a_adult.nsbocti ));
      params( 448 ) := "+"( Integer'Pos( a_adult.occupnum ));
      params( 449 ) := "+"( Integer'Pos( a_adult.otbscti ));
      params( 450 ) := "+"( Integer'Pos( a_adult.pepscti ));
      params( 451 ) := "+"( Integer'Pos( a_adult.poaccti ));
      params( 452 ) := "+"( Integer'Pos( a_adult.prbocti ));
      params( 453 ) := "+"( Integer'Pos( a_adult.relhrp ));
      params( 454 ) := "+"( Integer'Pos( a_adult.sayecti ));
      params( 455 ) := "+"( Integer'Pos( a_adult.sclbcti ));
      params( 456 ) := "+"( Float( a_adult.seincam2 ));
      params( 457 ) := "+"( Float( a_adult.smpadj ));
      params( 458 ) := "+"( Integer'Pos( a_adult.sscti ));
      params( 459 ) := "+"( Float( a_adult.sspadj ));
      params( 460 ) := "+"( Integer'Pos( a_adult.stshcti ));
      params( 461 ) := "+"( Float( a_adult.superan ));
      params( 462 ) := "+"( Integer'Pos( a_adult.taxpayer ));
      params( 463 ) := "+"( Integer'Pos( a_adult.tesscti ));
      params( 464 ) := "+"( Float( a_adult.totgrant ));
      params( 465 ) := "+"( Float( a_adult.tothours ));
      params( 466 ) := "+"( Float( a_adult.totoccp ));
      params( 467 ) := "+"( Float( a_adult.ttwcosts ));
      params( 468 ) := "+"( Integer'Pos( a_adult.untrcti ));
      params( 469 ) := "+"( Integer'Pos( a_adult.uperson ));
      params( 470 ) := "+"( Float( a_adult.widoccp ));
      params( 471 ) := "+"( Integer'Pos( a_adult.accountq ));
      params( 472 ) := "+"( Integer'Pos( a_adult.ben5q7 ));
      params( 473 ) := "+"( Integer'Pos( a_adult.ben5q8 ));
      params( 474 ) := "+"( Integer'Pos( a_adult.ben5q9 ));
      params( 475 ) := "+"( Integer'Pos( a_adult.ddatre ));
      params( 476 ) := "+"( Integer'Pos( a_adult.disdif9 ));
      params( 477 ) := "+"( Float( a_adult.fare ));
      params( 478 ) := "+"( Integer'Pos( a_adult.nittwmod ));
      params( 479 ) := "+"( Integer'Pos( a_adult.oneway ));
      params( 480 ) := "+"( Float( a_adult.pssamt ));
      params( 481 ) := "+"( Integer'Pos( a_adult.pssdate ));
      params( 482 ) := "+"( Integer'Pos( a_adult.ttwcode1 ));
      params( 483 ) := "+"( Integer'Pos( a_adult.ttwcode2 ));
      params( 484 ) := "+"( Integer'Pos( a_adult.ttwcode3 ));
      params( 485 ) := "+"( Float( a_adult.ttwcost ));
      params( 486 ) := "+"( Integer'Pos( a_adult.ttwfar ));
      params( 487 ) := "+"( Float( a_adult.ttwfrq ));
      params( 488 ) := "+"( Integer'Pos( a_adult.ttwmod ));
      params( 489 ) := "+"( Integer'Pos( a_adult.ttwpay ));
      params( 490 ) := "+"( Integer'Pos( a_adult.ttwpss ));
      params( 491 ) := "+"( Float( a_adult.ttwrec ));
      params( 492 ) := "+"( Integer'Pos( a_adult.chbflg ));
      params( 493 ) := "+"( Integer'Pos( a_adult.crunaci ));
      params( 494 ) := "+"( Integer'Pos( a_adult.enomorti ));
      params( 495 ) := "+"( Float( a_adult.sapadj ));
      params( 496 ) := "+"( Float( a_adult.sppadj ));
      params( 497 ) := "+"( Integer'Pos( a_adult.ttwmode ));
      params( 498 ) := "+"( Integer'Pos( a_adult.ddatrep ));
      params( 499 ) := "+"( Integer'Pos( a_adult.defrpen ));
      params( 500 ) := "+"( Integer'Pos( a_adult.disdifp ));
      params( 501 ) := "+"( Integer'Pos( a_adult.followup ));
      params( 502 ) := "+"( Integer'Pos( a_adult.practice ));
      params( 503 ) := "+"( Integer'Pos( a_adult.sfrpis ));
      params( 504 ) := "+"( Integer'Pos( a_adult.sfrpjsa ));
      params( 505 ) := "+"( Integer'Pos( a_adult.age80 ));
      params( 506 ) := "+"( Integer'Pos( a_adult.ethgr2 ));
      params( 507 ) := "+"( Integer'Pos( a_adult.pocardi ));
      params( 508 ) := "+"( Integer'Pos( a_adult.chkdpn ));
      params( 509 ) := "+"( Integer'Pos( a_adult.chknop ));
      params( 510 ) := "+"( Integer'Pos( a_adult.consent ));
      params( 511 ) := "+"( Integer'Pos( a_adult.dvpens ));
      params( 512 ) := "+"( Integer'Pos( a_adult.eligschm ));
      params( 513 ) := "+"( Integer'Pos( a_adult.emparr ));
      params( 514 ) := "+"( Integer'Pos( a_adult.emppen ));
      params( 515 ) := "+"( Integer'Pos( a_adult.empschm ));
      params( 516 ) := "+"( Integer'Pos( a_adult.lnkref1 ));
      params( 517 ) := "+"( Integer'Pos( a_adult.lnkref2 ));
      params( 518 ) := "+"( Integer'Pos( a_adult.lnkref21 ));
      params( 519 ) := "+"( Integer'Pos( a_adult.lnkref22 ));
      params( 520 ) := "+"( Integer'Pos( a_adult.lnkref23 ));
      params( 521 ) := "+"( Integer'Pos( a_adult.lnkref24 ));
      params( 522 ) := "+"( Integer'Pos( a_adult.lnkref25 ));
      params( 523 ) := "+"( Integer'Pos( a_adult.lnkref3 ));
      params( 524 ) := "+"( Integer'Pos( a_adult.lnkref4 ));
      params( 525 ) := "+"( Integer'Pos( a_adult.lnkref5 ));
      params( 526 ) := "+"( Integer'Pos( a_adult.memschm ));
      params( 527 ) := "+"( Integer'Pos( a_adult.pconsent ));
      params( 528 ) := "+"( Integer'Pos( a_adult.perspen1 ));
      params( 529 ) := "+"( Integer'Pos( a_adult.perspen2 ));
      params( 530 ) := "+"( Integer'Pos( a_adult.privpen ));
      params( 531 ) := "+"( Integer'Pos( a_adult.schchk ));
      params( 532 ) := "+"( Integer'Pos( a_adult.spnumc ));
      params( 533 ) := "+"( Integer'Pos( a_adult.stakep ));
      params( 534 ) := "+"( Integer'Pos( a_adult.trainee ));
      params( 535 ) := "+"( Integer'Pos( a_adult.lnkdwp ));
      params( 536 ) := "+"( Integer'Pos( a_adult.lnkons ));
      params( 537 ) := "+"( Integer'Pos( a_adult.lnkref6 ));
      params( 538 ) := "+"( Integer'Pos( a_adult.lnkref7 ));
      params( 539 ) := "+"( Integer'Pos( a_adult.lnkref8 ));
      params( 540 ) := "+"( Integer'Pos( a_adult.lnkref9 ));
      params( 541 ) := "+"( Integer'Pos( a_adult.tcever1 ));
      params( 542 ) := "+"( Integer'Pos( a_adult.tcever2 ));
      params( 543 ) := "+"( Integer'Pos( a_adult.tcrepay1 ));
      params( 544 ) := "+"( Integer'Pos( a_adult.tcrepay2 ));
      params( 545 ) := "+"( Integer'Pos( a_adult.tcrepay3 ));
      params( 546 ) := "+"( Integer'Pos( a_adult.tcrepay4 ));
      params( 547 ) := "+"( Integer'Pos( a_adult.tcrepay5 ));
      params( 548 ) := "+"( Integer'Pos( a_adult.tcrepay6 ));
      params( 549 ) := "+"( Integer'Pos( a_adult.tcthsyr1 ));
      params( 550 ) := "+"( Integer'Pos( a_adult.tcthsyr2 ));
      params( 551 ) := "+"( Integer'Pos( a_adult.currjobm ));
      params( 552 ) := "+"( Integer'Pos( a_adult.prevjobm ));
      params( 553 ) := "+"( Integer'Pos( a_adult.b3qfut7 ));
      params( 554 ) := "+"( Integer'Pos( a_adult.ben3q7 ));
      params( 555 ) := "+"( Integer'Pos( a_adult.camemt ));
      params( 556 ) := "+"( Integer'Pos( a_adult.cameyr ));
      params( 557 ) := "+"( Integer'Pos( a_adult.cameyr2 ));
      params( 558 ) := "+"( Integer'Pos( a_adult.contuk ));
      params( 559 ) := "+"( Integer'Pos( a_adult.corign ));
      params( 560 ) := "+"( Integer'Pos( a_adult.ddaprog ));
      params( 561 ) := "+"( Integer'Pos( a_adult.hbolng ));
      params( 562 ) := "+"( Integer'Pos( a_adult.hi1qual1 ));
      params( 563 ) := "+"( Integer'Pos( a_adult.hi1qual2 ));
      params( 564 ) := "+"( Integer'Pos( a_adult.hi1qual3 ));
      params( 565 ) := "+"( Integer'Pos( a_adult.hi1qual4 ));
      params( 566 ) := "+"( Integer'Pos( a_adult.hi1qual5 ));
      params( 567 ) := "+"( Integer'Pos( a_adult.hi1qual6 ));
      params( 568 ) := "+"( Integer'Pos( a_adult.hi2qual ));
      params( 569 ) := "+"( Integer'Pos( a_adult.hlpgvn01 ));
      params( 570 ) := "+"( Integer'Pos( a_adult.hlpgvn02 ));
      params( 571 ) := "+"( Integer'Pos( a_adult.hlpgvn03 ));
      params( 572 ) := "+"( Integer'Pos( a_adult.hlpgvn04 ));
      params( 573 ) := "+"( Integer'Pos( a_adult.hlpgvn05 ));
      params( 574 ) := "+"( Integer'Pos( a_adult.hlpgvn06 ));
      params( 575 ) := "+"( Integer'Pos( a_adult.hlpgvn07 ));
      params( 576 ) := "+"( Integer'Pos( a_adult.hlpgvn08 ));
      params( 577 ) := "+"( Integer'Pos( a_adult.hlpgvn09 ));
      params( 578 ) := "+"( Integer'Pos( a_adult.hlpgvn10 ));
      params( 579 ) := "+"( Integer'Pos( a_adult.hlpgvn11 ));
      params( 580 ) := "+"( Integer'Pos( a_adult.hlprec01 ));
      params( 581 ) := "+"( Integer'Pos( a_adult.hlprec02 ));
      params( 582 ) := "+"( Integer'Pos( a_adult.hlprec03 ));
      params( 583 ) := "+"( Integer'Pos( a_adult.hlprec04 ));
      params( 584 ) := "+"( Integer'Pos( a_adult.hlprec05 ));
      params( 585 ) := "+"( Integer'Pos( a_adult.hlprec06 ));
      params( 586 ) := "+"( Integer'Pos( a_adult.hlprec07 ));
      params( 587 ) := "+"( Integer'Pos( a_adult.hlprec08 ));
      params( 588 ) := "+"( Integer'Pos( a_adult.hlprec09 ));
      params( 589 ) := "+"( Integer'Pos( a_adult.hlprec10 ));
      params( 590 ) := "+"( Integer'Pos( a_adult.hlprec11 ));
      params( 591 ) := "+"( Integer'Pos( a_adult.issue ));
      params( 592 ) := "+"( Integer'Pos( a_adult.loangvn1 ));
      params( 593 ) := "+"( Integer'Pos( a_adult.loangvn2 ));
      params( 594 ) := "+"( Integer'Pos( a_adult.loangvn3 ));
      params( 595 ) := "+"( Integer'Pos( a_adult.loanrec1 ));
      params( 596 ) := "+"( Integer'Pos( a_adult.loanrec2 ));
      params( 597 ) := "+"( Integer'Pos( a_adult.loanrec3 ));
      params( 598 ) := "+"( Integer'Pos( a_adult.mntarr1 ));
      params( 599 ) := "+"( Integer'Pos( a_adult.mntarr2 ));
      params( 600 ) := "+"( Integer'Pos( a_adult.mntarr3 ));
      params( 601 ) := "+"( Integer'Pos( a_adult.mntarr4 ));
      params( 602 ) := "+"( Integer'Pos( a_adult.mntnrp ));
      params( 603 ) := "+"( Integer'Pos( a_adult.othqual1 ));
      params( 604 ) := "+"( Integer'Pos( a_adult.othqual2 ));
      params( 605 ) := "+"( Integer'Pos( a_adult.othqual3 ));
      params( 606 ) := "+"( Integer'Pos( a_adult.tea9697 ));
      params( 607 ) := "+"( Float( a_adult.heartval ));
      params( 608 ) := "+"( Integer'Pos( a_adult.iagegr3 ));
      params( 609 ) := "+"( Integer'Pos( a_adult.iagegr4 ));
      params( 610 ) := "+"( Integer'Pos( a_adult.nirel2 ));
      params( 611 ) := "+"( Integer'Pos( a_adult.xbonflag ));
      params( 612 ) := "+"( Integer'Pos( a_adult.alg ));
      params( 613 ) := "+"( Float( a_adult.algamt ));
      params( 614 ) := "+"( Integer'Pos( a_adult.algpd ));
      params( 615 ) := "+"( Integer'Pos( a_adult.ben4q4 ));
      params( 616 ) := "+"( Integer'Pos( a_adult.chkctc ));
      params( 617 ) := "+"( Integer'Pos( a_adult.chkdpco1 ));
      params( 618 ) := "+"( Integer'Pos( a_adult.chkdpco2 ));
      params( 619 ) := "+"( Integer'Pos( a_adult.chkdpco3 ));
      params( 620 ) := "+"( Integer'Pos( a_adult.chkdsco1 ));
      params( 621 ) := "+"( Integer'Pos( a_adult.chkdsco2 ));
      params( 622 ) := "+"( Integer'Pos( a_adult.chkdsco3 ));
      params( 623 ) := "+"( Integer'Pos( a_adult.dv09pens ));
      params( 624 ) := "+"( Integer'Pos( a_adult.lnkref01 ));
      params( 625 ) := "+"( Integer'Pos( a_adult.lnkref02 ));
      params( 626 ) := "+"( Integer'Pos( a_adult.lnkref03 ));
      params( 627 ) := "+"( Integer'Pos( a_adult.lnkref04 ));
      params( 628 ) := "+"( Integer'Pos( a_adult.lnkref05 ));
      params( 629 ) := "+"( Integer'Pos( a_adult.lnkref06 ));
      params( 630 ) := "+"( Integer'Pos( a_adult.lnkref07 ));
      params( 631 ) := "+"( Integer'Pos( a_adult.lnkref08 ));
      params( 632 ) := "+"( Integer'Pos( a_adult.lnkref09 ));
      params( 633 ) := "+"( Integer'Pos( a_adult.lnkref10 ));
      params( 634 ) := "+"( Integer'Pos( a_adult.lnkref11 ));
      params( 635 ) := "+"( Integer'Pos( a_adult.spyrot ));
      params( 636 ) := "+"( Integer'Pos( a_adult.disdifad ));
      params( 637 ) := "+"( Integer'Pos( a_adult.gross3_x ));
      params( 638 ) := "+"( Float( a_adult.aliamt ));
      params( 639 ) := "+"( Integer'Pos( a_adult.alimny ));
      params( 640 ) := "+"( Integer'Pos( a_adult.alipd ));
      params( 641 ) := "+"( Integer'Pos( a_adult.alius ));
      params( 642 ) := "+"( Float( a_adult.aluamt ));
      params( 643 ) := "+"( Integer'Pos( a_adult.alupd ));
      params( 644 ) := "+"( Integer'Pos( a_adult.cbaamt ));
      params( 645 ) := "+"( Integer'Pos( a_adult.hsvper ));
      params( 646 ) := "+"( Integer'Pos( a_adult.mednum ));
      params( 647 ) := "+"( Integer'Pos( a_adult.medprpd ));
      params( 648 ) := "+"( Integer'Pos( a_adult.medprpy ));
      params( 649 ) := "+"( Integer'Pos( a_adult.penflag ));
      params( 650 ) := "+"( Integer'Pos( a_adult.ppchk1 ));
      params( 651 ) := "+"( Integer'Pos( a_adult.ppchk2 ));
      params( 652 ) := "+"( Integer'Pos( a_adult.ppchk3 ));
      params( 653 ) := "+"( Float( a_adult.ttbprx ));
      params( 654 ) := "+"( Integer'Pos( a_adult.mjobsect ));
      params( 655 ) := "+"( Integer'Pos( a_adult.etngrp ));
      params( 656 ) := "+"( Integer'Pos( a_adult.medpay ));
      params( 657 ) := "+"( Integer'Pos( a_adult.medrep ));
      params( 658 ) := "+"( Integer'Pos( a_adult.medrpnm ));
      params( 659 ) := "+"( Integer'Pos( a_adult.nanid1 ));
      params( 660 ) := "+"( Integer'Pos( a_adult.nanid2 ));
      params( 661 ) := "+"( Integer'Pos( a_adult.nanid3 ));
      params( 662 ) := "+"( Integer'Pos( a_adult.nanid4 ));
      params( 663 ) := "+"( Integer'Pos( a_adult.nanid5 ));
      params( 664 ) := "+"( Integer'Pos( a_adult.nanid6 ));
      params( 665 ) := "+"( Integer'Pos( a_adult.nietngrp ));
      params( 666 ) := "+"( Integer'Pos( a_adult.ninanid1 ));
      params( 667 ) := "+"( Integer'Pos( a_adult.ninanid2 ));
      params( 668 ) := "+"( Integer'Pos( a_adult.ninanid3 ));
      params( 669 ) := "+"( Integer'Pos( a_adult.ninanid4 ));
      params( 670 ) := "+"( Integer'Pos( a_adult.ninanid5 ));
      params( 671 ) := "+"( Integer'Pos( a_adult.ninanid6 ));
      params( 672 ) := "+"( Integer'Pos( a_adult.ninanid7 ));
      params( 673 ) := "+"( Integer'Pos( a_adult.nirelig ));
      params( 674 ) := "+"( Integer'Pos( a_adult.pollopin ));
      params( 675 ) := "+"( Integer'Pos( a_adult.religenw ));
      params( 676 ) := "+"( Integer'Pos( a_adult.religsc ));
      params( 677 ) := "+"( Integer'Pos( a_adult.sidqn ));
      params( 678 ) := "+"( Integer'Pos( a_adult.soc2010 ));
      params( 679 ) := "+"( Integer'Pos( a_adult.corignan ));
      params( 680 ) := "+"( Integer'Pos( a_adult.dobmonth ));
      params( 681 ) := "+"( Integer'Pos( a_adult.dobyear ));
      params( 682 ) := "+"( Integer'Pos( a_adult.ethgr3 ));
      params( 683 ) := "+"( Integer'Pos( a_adult.ninanida ));
      params( 684 ) := "+"( Integer'Pos( a_adult.agehqual ));
      params( 685 ) := "+"( Integer'Pos( a_adult.bfd ));
      params( 686 ) := "+"( Float( a_adult.bfdamt ));
      params( 687 ) := "+"( Integer'Pos( a_adult.bfdpd ));
      params( 688 ) := "+"( Integer'Pos( a_adult.bfdval ));
      params( 689 ) := "+"( Integer'Pos( a_adult.btec ));
      params( 690 ) := "+"( Integer'Pos( a_adult.btecnow ));
      params( 691 ) := "+"( Integer'Pos( a_adult.cbaamt2 ));
      params( 692 ) := "+"( Integer'Pos( a_adult.change ));
      params( 693 ) := "+"( Integer'Pos( a_adult.citizen ));
      params( 694 ) := "+"( Integer'Pos( a_adult.citizen2 ));
      params( 695 ) := "+"( Integer'Pos( a_adult.condit ));
      params( 696 ) := "+"( Integer'Pos( a_adult.corigoth ));
      params( 697 ) := "+"( Integer'Pos( a_adult.curqual ));
      params( 698 ) := "+"( Integer'Pos( a_adult.ddaprog1 ));
      params( 699 ) := "+"( Integer'Pos( a_adult.ddatre1 ));
      params( 700 ) := "+"( Integer'Pos( a_adult.ddatrep1 ));
      params( 701 ) := "+"( Integer'Pos( a_adult.degree ));
      params( 702 ) := "+"( Integer'Pos( a_adult.degrenow ));
      params( 703 ) := "+"( Integer'Pos( a_adult.denrec ));
      params( 704 ) := "+"( Integer'Pos( a_adult.disd01 ));
      params( 705 ) := "+"( Integer'Pos( a_adult.disd02 ));
      params( 706 ) := "+"( Integer'Pos( a_adult.disd03 ));
      params( 707 ) := "+"( Integer'Pos( a_adult.disd04 ));
      params( 708 ) := "+"( Integer'Pos( a_adult.disd05 ));
      params( 709 ) := "+"( Integer'Pos( a_adult.disd06 ));
      params( 710 ) := "+"( Integer'Pos( a_adult.disd07 ));
      params( 711 ) := "+"( Integer'Pos( a_adult.disd08 ));
      params( 712 ) := "+"( Integer'Pos( a_adult.disd09 ));
      params( 713 ) := "+"( Integer'Pos( a_adult.disd10 ));
      params( 714 ) := "+"( Integer'Pos( a_adult.disdifp1 ));
      params( 715 ) := "+"( Integer'Pos( a_adult.empcontr ));
      params( 716 ) := "+"( Integer'Pos( a_adult.ethgrps ));
      params( 717 ) := "+"( Float( a_adult.eualiamt ));
      params( 718 ) := "+"( Integer'Pos( a_adult.eualimny ));
      params( 719 ) := "+"( Integer'Pos( a_adult.eualipd ));
      params( 720 ) := "+"( Integer'Pos( a_adult.euetype ));
      params( 721 ) := "+"( Integer'Pos( a_adult.followsc ));
      params( 722 ) := "+"( Integer'Pos( a_adult.health1 ));
      params( 723 ) := "+"( Integer'Pos( a_adult.heathad ));
      params( 724 ) := "+"( Integer'Pos( a_adult.hi3qual ));
      params( 725 ) := "+"( Integer'Pos( a_adult.higho ));
      params( 726 ) := "+"( Integer'Pos( a_adult.highonow ));
      params( 727 ) := "+"( Integer'Pos( a_adult.jobbyr ));
      params( 728 ) := "+"( Integer'Pos( a_adult.limitl ));
      params( 729 ) := "+"( Integer'Pos( a_adult.lktrain ));
      params( 730 ) := "+"( Integer'Pos( a_adult.lkwork ));
      params( 731 ) := "+"( Integer'Pos( a_adult.medrec ));
      params( 732 ) := "+"( Integer'Pos( a_adult.nvqlenow ));
      params( 733 ) := "+"( Integer'Pos( a_adult.nvqlev ));
      params( 734 ) := "+"( Integer'Pos( a_adult.othpass ));
      params( 735 ) := "+"( Integer'Pos( a_adult.ppper ));
      params( 736 ) := "+"( Float( a_adult.proptax ));
      params( 737 ) := "+"( Integer'Pos( a_adult.reasden ));
      params( 738 ) := "+"( Integer'Pos( a_adult.reasmed ));
      params( 739 ) := "+"( Integer'Pos( a_adult.reasnhs ));
      params( 740 ) := "+"( Integer'Pos( a_adult.reason ));
      params( 741 ) := "+"( Integer'Pos( a_adult.rednet ));
      params( 742 ) := "+"( Float( a_adult.redtax ));
      params( 743 ) := "+"( Integer'Pos( a_adult.rsa ));
      params( 744 ) := "+"( Integer'Pos( a_adult.rsanow ));
      params( 745 ) := "+"( Integer'Pos( a_adult.samesit ));
      params( 746 ) := "+"( Integer'Pos( a_adult.scotvec ));
      params( 747 ) := "+"( Integer'Pos( a_adult.sctvnow ));
      params( 748 ) := "+"( Integer'Pos( a_adult.sdemp01 ));
      params( 749 ) := "+"( Integer'Pos( a_adult.sdemp02 ));
      params( 750 ) := "+"( Integer'Pos( a_adult.sdemp03 ));
      params( 751 ) := "+"( Integer'Pos( a_adult.sdemp04 ));
      params( 752 ) := "+"( Integer'Pos( a_adult.sdemp05 ));
      params( 753 ) := "+"( Integer'Pos( a_adult.sdemp06 ));
      params( 754 ) := "+"( Integer'Pos( a_adult.sdemp07 ));
      params( 755 ) := "+"( Integer'Pos( a_adult.sdemp08 ));
      params( 756 ) := "+"( Integer'Pos( a_adult.sdemp09 ));
      params( 757 ) := "+"( Integer'Pos( a_adult.sdemp10 ));
      params( 758 ) := "+"( Integer'Pos( a_adult.sdemp11 ));
      params( 759 ) := "+"( Integer'Pos( a_adult.sdemp12 ));
      params( 760 ) := "+"( Integer'Pos( a_adult.selfdemp ));
      params( 761 ) := "+"( Integer'Pos( a_adult.tempjob ));
      params( 762 ) := "+"( Integer'Pos( a_adult.agehq80 ));
      params( 763 ) := "+"( Integer'Pos( a_adult.disacta1 ));
      params( 764 ) := "+"( Integer'Pos( a_adult.discora1 ));
      params( 765 ) := "+"( Integer'Pos( a_adult.gross4 ));
      params( 766 ) := "+"( Integer'Pos( a_adult.ninrinc ));
      params( 767 ) := "+"( Integer'Pos( a_adult.typeed2 ));
      params( 768 ) := "+"( Integer'Pos( a_adult.w45 ));
      params( 769 ) := "+"( Integer'Pos( a_adult.accmsat ));
      params( 770 ) := "+"( Integer'Pos( a_adult.c2orign ));
      params( 771 ) := "+"( Integer'Pos( a_adult.calm ));
      params( 772 ) := "+"( Integer'Pos( a_adult.cbchk ));
      params( 773 ) := "+"( Integer'Pos( a_adult.claifut1 ));
      params( 774 ) := "+"( Integer'Pos( a_adult.claifut2 ));
      params( 775 ) := "+"( Integer'Pos( a_adult.claifut3 ));
      params( 776 ) := "+"( Integer'Pos( a_adult.claifut4 ));
      params( 777 ) := "+"( Integer'Pos( a_adult.claifut5 ));
      params( 778 ) := "+"( Integer'Pos( a_adult.claifut6 ));
      params( 779 ) := "+"( Integer'Pos( a_adult.claifut7 ));
      params( 780 ) := "+"( Integer'Pos( a_adult.claifut8 ));
      params( 781 ) := "+"( Integer'Pos( a_adult.commusat ));
      params( 782 ) := "+"( Integer'Pos( a_adult.coptrust ));
      params( 783 ) := "+"( Integer'Pos( a_adult.depress ));
      params( 784 ) := "+"( Integer'Pos( a_adult.disben1 ));
      params( 785 ) := "+"( Integer'Pos( a_adult.disben2 ));
      params( 786 ) := "+"( Integer'Pos( a_adult.disben3 ));
      params( 787 ) := "+"( Integer'Pos( a_adult.disben4 ));
      params( 788 ) := "+"( Integer'Pos( a_adult.disben5 ));
      params( 789 ) := "+"( Integer'Pos( a_adult.disben6 ));
      params( 790 ) := "+"( Integer'Pos( a_adult.discuss ));
      params( 791 ) := "+"( Integer'Pos( a_adult.dla1 ));
      params( 792 ) := "+"( Integer'Pos( a_adult.dla2 ));
      params( 793 ) := "+"( Integer'Pos( a_adult.dls ));
      params( 794 ) := "+"( Float( a_adult.dlsamt ));
      params( 795 ) := "+"( Integer'Pos( a_adult.dlspd ));
      params( 796 ) := "+"( Integer'Pos( a_adult.dlsval ));
      params( 797 ) := "+"( Integer'Pos( a_adult.down ));
      params( 798 ) := "+"( Integer'Pos( a_adult.envirsat ));
      params( 799 ) := "+"( Integer'Pos( a_adult.gpispc ));
      params( 800 ) := "+"( Integer'Pos( a_adult.gpjsaesa ));
      params( 801 ) := "+"( Integer'Pos( a_adult.happy ));
      params( 802 ) := "+"( Integer'Pos( a_adult.help ));
      params( 803 ) := "+"( Integer'Pos( a_adult.iclaim1 ));
      params( 804 ) := "+"( Integer'Pos( a_adult.iclaim2 ));
      params( 805 ) := "+"( Integer'Pos( a_adult.iclaim3 ));
      params( 806 ) := "+"( Integer'Pos( a_adult.iclaim4 ));
      params( 807 ) := "+"( Integer'Pos( a_adult.iclaim5 ));
      params( 808 ) := "+"( Integer'Pos( a_adult.iclaim6 ));
      params( 809 ) := "+"( Integer'Pos( a_adult.iclaim7 ));
      params( 810 ) := "+"( Integer'Pos( a_adult.iclaim8 ));
      params( 811 ) := "+"( Integer'Pos( a_adult.iclaim9 ));
      params( 812 ) := "+"( Integer'Pos( a_adult.jobsat ));
      params( 813 ) := "+"( Integer'Pos( a_adult.kidben1 ));
      params( 814 ) := "+"( Integer'Pos( a_adult.kidben2 ));
      params( 815 ) := "+"( Integer'Pos( a_adult.kidben3 ));
      params( 816 ) := "+"( Integer'Pos( a_adult.legltrus ));
      params( 817 ) := "+"( Integer'Pos( a_adult.lifesat ));
      params( 818 ) := "+"( Integer'Pos( a_adult.meaning ));
      params( 819 ) := "+"( Integer'Pos( a_adult.moneysat ));
      params( 820 ) := "+"( Integer'Pos( a_adult.nervous ));
      params( 821 ) := "+"( Integer'Pos( a_adult.ni2train ));
      params( 822 ) := "+"( Integer'Pos( a_adult.othben1 ));
      params( 823 ) := "+"( Integer'Pos( a_adult.othben2 ));
      params( 824 ) := "+"( Integer'Pos( a_adult.othben3 ));
      params( 825 ) := "+"( Integer'Pos( a_adult.othben4 ));
      params( 826 ) := "+"( Integer'Pos( a_adult.othben5 ));
      params( 827 ) := "+"( Integer'Pos( a_adult.othben6 ));
      params( 828 ) := "+"( Integer'Pos( a_adult.othtrust ));
      params( 829 ) := "+"( Integer'Pos( a_adult.penben1 ));
      params( 830 ) := "+"( Integer'Pos( a_adult.penben2 ));
      params( 831 ) := "+"( Integer'Pos( a_adult.penben3 ));
      params( 832 ) := "+"( Integer'Pos( a_adult.penben4 ));
      params( 833 ) := "+"( Integer'Pos( a_adult.penben5 ));
      params( 834 ) := "+"( Integer'Pos( a_adult.pip1 ));
      params( 835 ) := "+"( Integer'Pos( a_adult.pip2 ));
      params( 836 ) := "+"( Integer'Pos( a_adult.polttrus ));
      params( 837 ) := "+"( Integer'Pos( a_adult.recsat ));
      params( 838 ) := "+"( Integer'Pos( a_adult.relasat ));
      params( 839 ) := "+"( Integer'Pos( a_adult.safe ));
      params( 840 ) := "+"( Integer'Pos( a_adult.socfund1 ));
      params( 841 ) := "+"( Integer'Pos( a_adult.socfund2 ));
      params( 842 ) := "+"( Integer'Pos( a_adult.socfund3 ));
      params( 843 ) := "+"( Integer'Pos( a_adult.socfund4 ));
      params( 844 ) := "+"( Integer'Pos( a_adult.srispc ));
      params( 845 ) := "+"( Integer'Pos( a_adult.srjsaesa ));
      params( 846 ) := "+"( Integer'Pos( a_adult.timesat ));
      params( 847 ) := "+"( Integer'Pos( a_adult.train2 ));
      params( 848 ) := "+"( Integer'Pos( a_adult.trnallow ));
      params( 849 ) := "+"( Integer'Pos( a_adult.wageben1 ));
      params( 850 ) := "+"( Integer'Pos( a_adult.wageben2 ));
      params( 851 ) := "+"( Integer'Pos( a_adult.wageben3 ));
      params( 852 ) := "+"( Integer'Pos( a_adult.wageben4 ));
      params( 853 ) := "+"( Integer'Pos( a_adult.wageben5 ));
      params( 854 ) := "+"( Integer'Pos( a_adult.wageben6 ));
      params( 855 ) := "+"( Integer'Pos( a_adult.wageben7 ));
      params( 856 ) := "+"( Integer'Pos( a_adult.wageben8 ));
      params( 857 ) := "+"( Integer'Pos( a_adult.ninnirbn ));
      params( 858 ) := "+"( Integer'Pos( a_adult.ninothbn ));
      params( 859 ) := "+"( Integer'Pos( a_adult.anxious ));
      params( 860 ) := "+"( Integer'Pos( a_adult.candgnow ));
      params( 861 ) := "+"( Integer'Pos( a_adult.curothf ));
      params( 862 ) := "+"( Integer'Pos( a_adult.curothp ));
      params( 863 ) := "+"( Integer'Pos( a_adult.curothwv ));
      params( 864 ) := "+"( Integer'Pos( a_adult.dvhiqual ));
      params( 865 ) := "+"( Integer'Pos( a_adult.gnvqnow ));
      params( 866 ) := "+"( Integer'Pos( a_adult.gpuc ));
      params( 867 ) := "+"( Integer'Pos( a_adult.happywb ));
      params( 868 ) := "+"( Integer'Pos( a_adult.hi1qual7 ));
      params( 869 ) := "+"( Integer'Pos( a_adult.hi1qual8 ));
      params( 870 ) := "+"( Integer'Pos( a_adult.mntarr5 ));
      params( 871 ) := "+"( Integer'Pos( a_adult.mntnoch1 ));
      params( 872 ) := "+"( Integer'Pos( a_adult.mntnoch2 ));
      params( 873 ) := "+"( Integer'Pos( a_adult.mntnoch3 ));
      params( 874 ) := "+"( Integer'Pos( a_adult.mntnoch4 ));
      params( 875 ) := "+"( Integer'Pos( a_adult.mntnoch5 ));
      params( 876 ) := "+"( Integer'Pos( a_adult.mntpro1 ));
      params( 877 ) := "+"( Integer'Pos( a_adult.mntpro2 ));
      params( 878 ) := "+"( Integer'Pos( a_adult.mntpro3 ));
      params( 879 ) := "+"( Integer'Pos( a_adult.mnttim1 ));
      params( 880 ) := "+"( Integer'Pos( a_adult.mnttim2 ));
      params( 881 ) := "+"( Integer'Pos( a_adult.mnttim3 ));
      params( 882 ) := "+"( Integer'Pos( a_adult.mntwrk1 ));
      params( 883 ) := "+"( Integer'Pos( a_adult.mntwrk2 ));
      params( 884 ) := "+"( Integer'Pos( a_adult.mntwrk3 ));
      params( 885 ) := "+"( Integer'Pos( a_adult.mntwrk4 ));
      params( 886 ) := "+"( Integer'Pos( a_adult.mntwrk5 ));
      params( 887 ) := "+"( Integer'Pos( a_adult.ndeplnow ));
      params( 888 ) := "+"( Integer'Pos( a_adult.oqualc1 ));
      params( 889 ) := "+"( Integer'Pos( a_adult.oqualc2 ));
      params( 890 ) := "+"( Integer'Pos( a_adult.oqualc3 ));
      params( 891 ) := "+"( Integer'Pos( a_adult.sruc ));
      params( 892 ) := "+"( Integer'Pos( a_adult.webacnow ));
      params( 893 ) := "+"( Integer'Pos( a_adult.indeth ));
      params( 894 ) := "+"( Integer'Pos( a_adult.euactive ));
      params( 895 ) := "+"( Integer'Pos( a_adult.euactno ));
      params( 896 ) := "+"( Integer'Pos( a_adult.euartact ));
      params( 897 ) := "+"( Integer'Pos( a_adult.euaskhlp ));
      params( 898 ) := "+"( Integer'Pos( a_adult.eucinema ));
      params( 899 ) := "+"( Integer'Pos( a_adult.eucultur ));
      params( 900 ) := "+"( Integer'Pos( a_adult.euinvol ));
      params( 901 ) := "+"( Integer'Pos( a_adult.eulivpe ));
      params( 902 ) := "+"( Integer'Pos( a_adult.eumtfam ));
      params( 903 ) := "+"( Integer'Pos( a_adult.eumtfrnd ));
      params( 904 ) := "+"( Integer'Pos( a_adult.eusocnet ));
      params( 905 ) := "+"( Integer'Pos( a_adult.eusport ));
      params( 906 ) := "+"( Integer'Pos( a_adult.eutkfam ));
      params( 907 ) := "+"( Integer'Pos( a_adult.eutkfrnd ));
      params( 908 ) := "+"( Integer'Pos( a_adult.eutkmat ));
      params( 909 ) := "+"( Integer'Pos( a_adult.euvol ));
      params( 910 ) := "+"( Integer'Pos( a_adult.natscot ));
      params( 911 ) := "+"( Integer'Pos( a_adult.ntsctnow ));
      params( 912 ) := "+"( Integer'Pos( a_adult.penwel1 ));
      params( 913 ) := "+"( Integer'Pos( a_adult.penwel2 ));
      params( 914 ) := "+"( Integer'Pos( a_adult.penwel3 ));
      params( 915 ) := "+"( Integer'Pos( a_adult.penwel4 ));
      params( 916 ) := "+"( Integer'Pos( a_adult.penwel5 ));
      params( 917 ) := "+"( Integer'Pos( a_adult.penwel6 ));
      params( 918 ) := "+"( Integer'Pos( a_adult.skiwknow ));
      params( 919 ) := "+"( Integer'Pos( a_adult.skiwrk ));
      params( 920 ) := "+"( Integer'Pos( a_adult.slos ));
      params( 921 ) := "+"( Integer'Pos( a_adult.yjblev ));
      params( 922 ) := "+"( Integer'Pos( a_adult.user_id ));
      params( 923 ) := "+"( Integer'Pos( a_adult.edition ));
      params( 924 ) := "+"( Integer'Pos( a_adult.year ));
      params( 925 ) := As_Bigint( a_adult.sernum );
      params( 926 ) := "+"( Integer'Pos( a_adult.benunit ));
      params( 927 ) := "+"( Integer'Pos( a_adult.person ));
      
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

   procedure Save( a_adult : Ukds.Frs.Adult; overwrite : Boolean := True; connection : Database_Connection := null ) is   
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
      if overwrite and Exists( a_adult.user_id, a_adult.edition, a_adult.year, a_adult.sernum, a_adult.benunit, a_adult.person ) then
         Update( a_adult, local_connection );
         if( is_local_connection )then
            Connection_Pool.Return_Connection( local_connection );
         end if;
         return;
      end if;
      params( 1 ) := "+"( Integer'Pos( a_adult.user_id ));
      params( 2 ) := "+"( Integer'Pos( a_adult.edition ));
      params( 3 ) := "+"( Integer'Pos( a_adult.year ));
      params( 4 ) := As_Bigint( a_adult.sernum );
      params( 5 ) := "+"( Integer'Pos( a_adult.benunit ));
      params( 6 ) := "+"( Integer'Pos( a_adult.person ));
      params( 7 ) := "+"( Integer'Pos( a_adult.abs1no ));
      params( 8 ) := "+"( Integer'Pos( a_adult.abs2no ));
      params( 9 ) := "+"( Integer'Pos( a_adult.abspar ));
      params( 10 ) := "+"( Integer'Pos( a_adult.abspay ));
      params( 11 ) := "+"( Integer'Pos( a_adult.abswhy ));
      params( 12 ) := "+"( Integer'Pos( a_adult.abswk ));
      params( 13 ) := "+"( Integer'Pos( a_adult.x_access ));
      params( 14 ) := "+"( Integer'Pos( a_adult.accftpt ));
      params( 15 ) := "+"( Integer'Pos( a_adult.accjb ));
      params( 16 ) := "+"( Float( a_adult.accssamt ));
      params( 17 ) := "+"( Integer'Pos( a_adult.accsspd ));
      params( 18 ) := "+"( Integer'Pos( a_adult.adeduc ));
      params( 19 ) := "+"( Integer'Pos( a_adult.adema ));
      params( 20 ) := "+"( Float( a_adult.ademaamt ));
      params( 21 ) := "+"( Integer'Pos( a_adult.ademapd ));
      params( 22 ) := "+"( Integer'Pos( a_adult.age ));
      params( 23 ) := "+"( Integer'Pos( a_adult.allow1 ));
      params( 24 ) := "+"( Integer'Pos( a_adult.allow2 ));
      params( 25 ) := "+"( Integer'Pos( a_adult.allow3 ));
      params( 26 ) := "+"( Integer'Pos( a_adult.allow4 ));
      params( 27 ) := "+"( Float( a_adult.allpay1 ));
      params( 28 ) := "+"( Float( a_adult.allpay2 ));
      params( 29 ) := "+"( Float( a_adult.allpay3 ));
      params( 30 ) := "+"( Float( a_adult.allpay4 ));
      params( 31 ) := "+"( Integer'Pos( a_adult.allpd1 ));
      params( 32 ) := "+"( Integer'Pos( a_adult.allpd2 ));
      params( 33 ) := "+"( Integer'Pos( a_adult.allpd3 ));
      params( 34 ) := "+"( Integer'Pos( a_adult.allpd4 ));
      params( 35 ) := "+"( Integer'Pos( a_adult.anyacc ));
      params( 36 ) := "+"( Integer'Pos( a_adult.anyed ));
      params( 37 ) := "+"( Integer'Pos( a_adult.anymon ));
      params( 38 ) := "+"( Integer'Pos( a_adult.anypen1 ));
      params( 39 ) := "+"( Integer'Pos( a_adult.anypen2 ));
      params( 40 ) := "+"( Integer'Pos( a_adult.anypen3 ));
      params( 41 ) := "+"( Integer'Pos( a_adult.anypen4 ));
      params( 42 ) := "+"( Integer'Pos( a_adult.anypen5 ));
      params( 43 ) := "+"( Integer'Pos( a_adult.anypen6 ));
      params( 44 ) := "+"( Integer'Pos( a_adult.anypen7 ));
      params( 45 ) := "+"( Float( a_adult.apamt ));
      params( 46 ) := "+"( Float( a_adult.apdamt ));
      params( 47 ) := "+"( Integer'Pos( a_adult.apdir ));
      params( 48 ) := "+"( Integer'Pos( a_adult.apdpd ));
      params( 49 ) := "+"( Integer'Pos( a_adult.appd ));
      params( 50 ) := "+"( Integer'Pos( a_adult.b2qfut1 ));
      params( 51 ) := "+"( Integer'Pos( a_adult.b2qfut2 ));
      params( 52 ) := "+"( Integer'Pos( a_adult.b2qfut3 ));
      params( 53 ) := "+"( Integer'Pos( a_adult.b3qfut1 ));
      params( 54 ) := "+"( Integer'Pos( a_adult.b3qfut2 ));
      params( 55 ) := "+"( Integer'Pos( a_adult.b3qfut3 ));
      params( 56 ) := "+"( Integer'Pos( a_adult.b3qfut4 ));
      params( 57 ) := "+"( Integer'Pos( a_adult.b3qfut5 ));
      params( 58 ) := "+"( Integer'Pos( a_adult.b3qfut6 ));
      params( 59 ) := "+"( Integer'Pos( a_adult.ben1q1 ));
      params( 60 ) := "+"( Integer'Pos( a_adult.ben1q2 ));
      params( 61 ) := "+"( Integer'Pos( a_adult.ben1q3 ));
      params( 62 ) := "+"( Integer'Pos( a_adult.ben1q4 ));
      params( 63 ) := "+"( Integer'Pos( a_adult.ben1q5 ));
      params( 64 ) := "+"( Integer'Pos( a_adult.ben1q6 ));
      params( 65 ) := "+"( Integer'Pos( a_adult.ben1q7 ));
      params( 66 ) := "+"( Integer'Pos( a_adult.ben2q1 ));
      params( 67 ) := "+"( Integer'Pos( a_adult.ben2q2 ));
      params( 68 ) := "+"( Integer'Pos( a_adult.ben2q3 ));
      params( 69 ) := "+"( Integer'Pos( a_adult.ben3q1 ));
      params( 70 ) := "+"( Integer'Pos( a_adult.ben3q2 ));
      params( 71 ) := "+"( Integer'Pos( a_adult.ben3q3 ));
      params( 72 ) := "+"( Integer'Pos( a_adult.ben3q4 ));
      params( 73 ) := "+"( Integer'Pos( a_adult.ben3q5 ));
      params( 74 ) := "+"( Integer'Pos( a_adult.ben3q6 ));
      params( 75 ) := "+"( Integer'Pos( a_adult.ben4q1 ));
      params( 76 ) := "+"( Integer'Pos( a_adult.ben4q2 ));
      params( 77 ) := "+"( Integer'Pos( a_adult.ben4q3 ));
      params( 78 ) := "+"( Integer'Pos( a_adult.ben5q1 ));
      params( 79 ) := "+"( Integer'Pos( a_adult.ben5q2 ));
      params( 80 ) := "+"( Integer'Pos( a_adult.ben5q3 ));
      params( 81 ) := "+"( Integer'Pos( a_adult.ben5q4 ));
      params( 82 ) := "+"( Integer'Pos( a_adult.ben5q5 ));
      params( 83 ) := "+"( Integer'Pos( a_adult.ben5q6 ));
      params( 84 ) := "+"( Integer'Pos( a_adult.ben7q1 ));
      params( 85 ) := "+"( Integer'Pos( a_adult.ben7q2 ));
      params( 86 ) := "+"( Integer'Pos( a_adult.ben7q3 ));
      params( 87 ) := "+"( Integer'Pos( a_adult.ben7q4 ));
      params( 88 ) := "+"( Integer'Pos( a_adult.ben7q5 ));
      params( 89 ) := "+"( Integer'Pos( a_adult.ben7q6 ));
      params( 90 ) := "+"( Integer'Pos( a_adult.ben7q7 ));
      params( 91 ) := "+"( Integer'Pos( a_adult.ben7q8 ));
      params( 92 ) := "+"( Integer'Pos( a_adult.ben7q9 ));
      params( 93 ) := "+"( Integer'Pos( a_adult.btwacc ));
      params( 94 ) := "+"( Integer'Pos( a_adult.claimant ));
      params( 95 ) := "+"( Integer'Pos( a_adult.cohabit ));
      params( 96 ) := "+"( Integer'Pos( a_adult.combid ));
      params( 97 ) := "+"( Integer'Pos( a_adult.convbl ));
      params( 98 ) := "+"( Integer'Pos( a_adult.ctclum1 ));
      params( 99 ) := "+"( Integer'Pos( a_adult.ctclum2 ));
      params( 100 ) := "+"( Integer'Pos( a_adult.cupchk ));
      params( 101 ) := "+"( Integer'Pos( a_adult.cvht ));
      params( 102 ) := "+"( Float( a_adult.cvpay ));
      params( 103 ) := "+"( Integer'Pos( a_adult.cvpd ));
      params( 104 ) := "+"( Integer'Pos( a_adult.dentist ));
      params( 105 ) := "+"( Integer'Pos( a_adult.depend ));
      params( 106 ) := "+"( Integer'Pos( a_adult.disdif1 ));
      params( 107 ) := "+"( Integer'Pos( a_adult.disdif2 ));
      params( 108 ) := "+"( Integer'Pos( a_adult.disdif3 ));
      params( 109 ) := "+"( Integer'Pos( a_adult.disdif4 ));
      params( 110 ) := "+"( Integer'Pos( a_adult.disdif5 ));
      params( 111 ) := "+"( Integer'Pos( a_adult.disdif6 ));
      params( 112 ) := "+"( Integer'Pos( a_adult.disdif7 ));
      params( 113 ) := "+"( Integer'Pos( a_adult.disdif8 ));
      params( 114 ) := "+"( a_adult.dob );
      params( 115 ) := "+"( Integer'Pos( a_adult.dptcboth ));
      params( 116 ) := "+"( Integer'Pos( a_adult.dptclum ));
      params( 117 ) := "+"( Integer'Pos( a_adult.dvil03a ));
      params( 118 ) := "+"( Integer'Pos( a_adult.dvil04a ));
      params( 119 ) := "+"( Integer'Pos( a_adult.dvjb12ml ));
      params( 120 ) := "+"( Integer'Pos( a_adult.dvmardf ));
      params( 121 ) := "+"( Float( a_adult.ed1amt ));
      params( 122 ) := "+"( Integer'Pos( a_adult.ed1borr ));
      params( 123 ) := "+"( Integer'Pos( a_adult.ed1int ));
      params( 124 ) := "+"( a_adult.ed1monyr );
      params( 125 ) := "+"( Integer'Pos( a_adult.ed1pd ));
      params( 126 ) := "+"( Integer'Pos( a_adult.ed1sum ));
      params( 127 ) := "+"( Float( a_adult.ed2amt ));
      params( 128 ) := "+"( Integer'Pos( a_adult.ed2borr ));
      params( 129 ) := "+"( Integer'Pos( a_adult.ed2int ));
      params( 130 ) := "+"( a_adult.ed2monyr );
      params( 131 ) := "+"( Integer'Pos( a_adult.ed2pd ));
      params( 132 ) := "+"( Integer'Pos( a_adult.ed2sum ));
      params( 133 ) := "+"( Integer'Pos( a_adult.edatt ));
      params( 134 ) := "+"( Integer'Pos( a_adult.edattn1 ));
      params( 135 ) := "+"( Integer'Pos( a_adult.edattn2 ));
      params( 136 ) := "+"( Integer'Pos( a_adult.edattn3 ));
      params( 137 ) := "+"( Integer'Pos( a_adult.edhr ));
      params( 138 ) := "+"( Integer'Pos( a_adult.edtime ));
      params( 139 ) := "+"( Integer'Pos( a_adult.edtyp ));
      params( 140 ) := "+"( Integer'Pos( a_adult.eligadlt ));
      params( 141 ) := "+"( Integer'Pos( a_adult.eligchld ));
      params( 142 ) := "+"( Integer'Pos( a_adult.emppay1 ));
      params( 143 ) := "+"( Integer'Pos( a_adult.emppay2 ));
      params( 144 ) := "+"( Integer'Pos( a_adult.emppay3 ));
      params( 145 ) := "+"( Integer'Pos( a_adult.empstat ));
      params( 146 ) := "+"( Integer'Pos( a_adult.endyr ));
      params( 147 ) := "+"( Integer'Pos( a_adult.epcur ));
      params( 148 ) := "+"( Integer'Pos( a_adult.es2000 ));
      params( 149 ) := "+"( Integer'Pos( a_adult.ethgrp ));
      params( 150 ) := "+"( Integer'Pos( a_adult.everwrk ));
      params( 151 ) := "+"( Integer'Pos( a_adult.exthbct1 ));
      params( 152 ) := "+"( Integer'Pos( a_adult.exthbct2 ));
      params( 153 ) := "+"( Integer'Pos( a_adult.exthbct3 ));
      params( 154 ) := "+"( Integer'Pos( a_adult.eyetest ));
      params( 155 ) := "+"( Integer'Pos( a_adult.follow ));
      params( 156 ) := "+"( Integer'Pos( a_adult.fted ));
      params( 157 ) := "+"( Integer'Pos( a_adult.ftwk ));
      params( 158 ) := "+"( Integer'Pos( a_adult.future ));
      params( 159 ) := "+"( Integer'Pos( a_adult.govpis ));
      params( 160 ) := "+"( Integer'Pos( a_adult.govpjsa ));
      params( 161 ) := "+"( Integer'Pos( a_adult.x_grant ));
      params( 162 ) := "+"( Float( a_adult.grtamt1 ));
      params( 163 ) := "+"( Float( a_adult.grtamt2 ));
      params( 164 ) := "+"( Float( a_adult.grtdir1 ));
      params( 165 ) := "+"( Float( a_adult.grtdir2 ));
      params( 166 ) := "+"( Integer'Pos( a_adult.grtnum ));
      params( 167 ) := "+"( Integer'Pos( a_adult.grtsce1 ));
      params( 168 ) := "+"( Integer'Pos( a_adult.grtsce2 ));
      params( 169 ) := "+"( Float( a_adult.grtval1 ));
      params( 170 ) := "+"( Float( a_adult.grtval2 ));
      params( 171 ) := "+"( Integer'Pos( a_adult.gta ));
      params( 172 ) := "+"( Float( a_adult.hbothamt ));
      params( 173 ) := "+"( Integer'Pos( a_adult.hbothbu ));
      params( 174 ) := "+"( Integer'Pos( a_adult.hbothpd ));
      params( 175 ) := "+"( Integer'Pos( a_adult.hbothwk ));
      params( 176 ) := "+"( Integer'Pos( a_adult.hbotwait ));
      params( 177 ) := "+"( Integer'Pos( a_adult.health ));
      params( 178 ) := "+"( Integer'Pos( a_adult.hholder ));
      params( 179 ) := "+"( Integer'Pos( a_adult.hosp ));
      params( 180 ) := "+"( Integer'Pos( a_adult.hprob ));
      params( 181 ) := "+"( Integer'Pos( a_adult.hrpid ));
      params( 182 ) := "+"( Integer'Pos( a_adult.incdur ));
      params( 183 ) := "+"( Integer'Pos( a_adult.injlong ));
      params( 184 ) := "+"( Integer'Pos( a_adult.injwk ));
      params( 185 ) := "+"( Integer'Pos( a_adult.invests ));
      params( 186 ) := "+"( Integer'Pos( a_adult.iout ));
      params( 187 ) := "+"( Integer'Pos( a_adult.isa1type ));
      params( 188 ) := "+"( Integer'Pos( a_adult.isa2type ));
      params( 189 ) := "+"( Integer'Pos( a_adult.isa3type ));
      params( 190 ) := "+"( Integer'Pos( a_adult.jobaway ));
      params( 191 ) := "+"( Integer'Pos( a_adult.lareg ));
      params( 192 ) := "+"( Integer'Pos( a_adult.likewk ));
      params( 193 ) := "+"( Integer'Pos( a_adult.lktime ));
      params( 194 ) := "+"( Integer'Pos( a_adult.ln1rpint ));
      params( 195 ) := "+"( Integer'Pos( a_adult.ln2rpint ));
      params( 196 ) := "+"( Integer'Pos( a_adult.loan ));
      params( 197 ) := "+"( Integer'Pos( a_adult.loannum ));
      params( 198 ) := "+"( Integer'Pos( a_adult.look ));
      params( 199 ) := "+"( Integer'Pos( a_adult.lookwk ));
      params( 200 ) := "+"( Integer'Pos( a_adult.lstwrk1 ));
      params( 201 ) := "+"( Integer'Pos( a_adult.lstwrk2 ));
      params( 202 ) := "+"( Integer'Pos( a_adult.lstyr ));
      params( 203 ) := "+"( Float( a_adult.mntamt1 ));
      params( 204 ) := "+"( Float( a_adult.mntamt2 ));
      params( 205 ) := "+"( Integer'Pos( a_adult.mntct ));
      params( 206 ) := "+"( Integer'Pos( a_adult.mntfor1 ));
      params( 207 ) := "+"( Integer'Pos( a_adult.mntfor2 ));
      params( 208 ) := "+"( Integer'Pos( a_adult.mntgov1 ));
      params( 209 ) := "+"( Integer'Pos( a_adult.mntgov2 ));
      params( 210 ) := "+"( Integer'Pos( a_adult.mntpay ));
      params( 211 ) := "+"( Integer'Pos( a_adult.mntpd1 ));
      params( 212 ) := "+"( Integer'Pos( a_adult.mntpd2 ));
      params( 213 ) := "+"( Integer'Pos( a_adult.mntrec ));
      params( 214 ) := "+"( Integer'Pos( a_adult.mnttota1 ));
      params( 215 ) := "+"( Integer'Pos( a_adult.mnttota2 ));
      params( 216 ) := "+"( Integer'Pos( a_adult.mntus1 ));
      params( 217 ) := "+"( Integer'Pos( a_adult.mntus2 ));
      params( 218 ) := "+"( Float( a_adult.mntusam1 ));
      params( 219 ) := "+"( Float( a_adult.mntusam2 ));
      params( 220 ) := "+"( Integer'Pos( a_adult.mntuspd1 ));
      params( 221 ) := "+"( Integer'Pos( a_adult.mntuspd2 ));
      params( 222 ) := "+"( Integer'Pos( a_adult.ms ));
      params( 223 ) := "+"( Integer'Pos( a_adult.natid1 ));
      params( 224 ) := "+"( Integer'Pos( a_adult.natid2 ));
      params( 225 ) := "+"( Integer'Pos( a_adult.natid3 ));
      params( 226 ) := "+"( Integer'Pos( a_adult.natid4 ));
      params( 227 ) := "+"( Integer'Pos( a_adult.natid5 ));
      params( 228 ) := "+"( Integer'Pos( a_adult.natid6 ));
      params( 229 ) := "+"( Integer'Pos( a_adult.ndeal ));
      params( 230 ) := "+"( Integer'Pos( a_adult.newdtype ));
      params( 231 ) := "+"( Integer'Pos( a_adult.nhs1 ));
      params( 232 ) := "+"( Integer'Pos( a_adult.nhs2 ));
      params( 233 ) := "+"( Integer'Pos( a_adult.nhs3 ));
      params( 234 ) := "+"( Float( a_adult.niamt ));
      params( 235 ) := "+"( Integer'Pos( a_adult.niethgrp ));
      params( 236 ) := "+"( Integer'Pos( a_adult.niexthbb ));
      params( 237 ) := "+"( Integer'Pos( a_adult.ninatid1 ));
      params( 238 ) := "+"( Integer'Pos( a_adult.ninatid2 ));
      params( 239 ) := "+"( Integer'Pos( a_adult.ninatid3 ));
      params( 240 ) := "+"( Integer'Pos( a_adult.ninatid4 ));
      params( 241 ) := "+"( Integer'Pos( a_adult.ninatid5 ));
      params( 242 ) := "+"( Integer'Pos( a_adult.ninatid6 ));
      params( 243 ) := "+"( Integer'Pos( a_adult.ninatid7 ));
      params( 244 ) := "+"( Integer'Pos( a_adult.ninatid8 ));
      params( 245 ) := "+"( Integer'Pos( a_adult.nipd ));
      params( 246 ) := "+"( Integer'Pos( a_adult.nireg ));
      params( 247 ) := "+"( Integer'Pos( a_adult.nirel ));
      params( 248 ) := "+"( Integer'Pos( a_adult.nitrain ));
      params( 249 ) := "+"( Integer'Pos( a_adult.nlper ));
      params( 250 ) := "+"( Integer'Pos( a_adult.nolk1 ));
      params( 251 ) := "+"( Integer'Pos( a_adult.nolk2 ));
      params( 252 ) := "+"( Integer'Pos( a_adult.nolk3 ));
      params( 253 ) := "+"( Integer'Pos( a_adult.nolook ));
      params( 254 ) := "+"( Integer'Pos( a_adult.nowant ));
      params( 255 ) := "+"( Float( a_adult.nssec ));
      params( 256 ) := "+"( Integer'Pos( a_adult.ntcapp ));
      params( 257 ) := "+"( Integer'Pos( a_adult.ntcdat ));
      params( 258 ) := "+"( Float( a_adult.ntcinc ));
      params( 259 ) := "+"( Integer'Pos( a_adult.ntcorig1 ));
      params( 260 ) := "+"( Integer'Pos( a_adult.ntcorig2 ));
      params( 261 ) := "+"( Integer'Pos( a_adult.ntcorig3 ));
      params( 262 ) := "+"( Integer'Pos( a_adult.ntcorig4 ));
      params( 263 ) := "+"( Integer'Pos( a_adult.ntcorig5 ));
      params( 264 ) := "+"( Integer'Pos( a_adult.numjob ));
      params( 265 ) := "+"( Integer'Pos( a_adult.numjob2 ));
      params( 266 ) := "+"( Integer'Pos( a_adult.oddjob ));
      params( 267 ) := "+"( Integer'Pos( a_adult.oldstud ));
      params( 268 ) := "+"( Integer'Pos( a_adult.otabspar ));
      params( 269 ) := "+"( Float( a_adult.otamt ));
      params( 270 ) := "+"( Float( a_adult.otapamt ));
      params( 271 ) := "+"( Integer'Pos( a_adult.otappd ));
      params( 272 ) := "+"( Integer'Pos( a_adult.othtax ));
      params( 273 ) := "+"( Integer'Pos( a_adult.otinva ));
      params( 274 ) := "+"( Float( a_adult.pareamt ));
      params( 275 ) := "+"( Integer'Pos( a_adult.parepd ));
      params( 276 ) := "+"( Integer'Pos( a_adult.penlump ));
      params( 277 ) := "+"( Integer'Pos( a_adult.ppnumc ));
      params( 278 ) := "+"( Integer'Pos( a_adult.prit ));
      params( 279 ) := "+"( Integer'Pos( a_adult.prscrpt ));
      params( 280 ) := "+"( Integer'Pos( a_adult.ptwk ));
      params( 281 ) := "+"( Integer'Pos( a_adult.r01 ));
      params( 282 ) := "+"( Integer'Pos( a_adult.r02 ));
      params( 283 ) := "+"( Integer'Pos( a_adult.r03 ));
      params( 284 ) := "+"( Integer'Pos( a_adult.r04 ));
      params( 285 ) := "+"( Integer'Pos( a_adult.r05 ));
      params( 286 ) := "+"( Integer'Pos( a_adult.r06 ));
      params( 287 ) := "+"( Integer'Pos( a_adult.r07 ));
      params( 288 ) := "+"( Integer'Pos( a_adult.r08 ));
      params( 289 ) := "+"( Integer'Pos( a_adult.r09 ));
      params( 290 ) := "+"( Integer'Pos( a_adult.r10 ));
      params( 291 ) := "+"( Integer'Pos( a_adult.r11 ));
      params( 292 ) := "+"( Integer'Pos( a_adult.r12 ));
      params( 293 ) := "+"( Integer'Pos( a_adult.r13 ));
      params( 294 ) := "+"( Integer'Pos( a_adult.r14 ));
      params( 295 ) := "+"( Float( a_adult.redamt ));
      params( 296 ) := "+"( Integer'Pos( a_adult.redany ));
      params( 297 ) := "+"( Integer'Pos( a_adult.rentprof ));
      params( 298 ) := "+"( Integer'Pos( a_adult.retire ));
      params( 299 ) := "+"( Integer'Pos( a_adult.retire1 ));
      params( 300 ) := "+"( Integer'Pos( a_adult.retreas ));
      params( 301 ) := "+"( Integer'Pos( a_adult.royal1 ));
      params( 302 ) := "+"( Integer'Pos( a_adult.royal2 ));
      params( 303 ) := "+"( Integer'Pos( a_adult.royal3 ));
      params( 304 ) := "+"( Integer'Pos( a_adult.royal4 ));
      params( 305 ) := "+"( Float( a_adult.royyr1 ));
      params( 306 ) := "+"( Float( a_adult.royyr2 ));
      params( 307 ) := "+"( Float( a_adult.royyr3 ));
      params( 308 ) := "+"( Float( a_adult.royyr4 ));
      params( 309 ) := "+"( Integer'Pos( a_adult.rstrct ));
      params( 310 ) := "+"( Integer'Pos( a_adult.sex ));
      params( 311 ) := "+"( Integer'Pos( a_adult.sflntyp1 ));
      params( 312 ) := "+"( Integer'Pos( a_adult.sflntyp2 ));
      params( 313 ) := "+"( Integer'Pos( a_adult.sftype1 ));
      params( 314 ) := "+"( Integer'Pos( a_adult.sftype2 ));
      params( 315 ) := "+"( Integer'Pos( a_adult.sic ));
      params( 316 ) := "+"( Float( a_adult.slrepamt ));
      params( 317 ) := "+"( Integer'Pos( a_adult.slrepay ));
      params( 318 ) := "+"( Integer'Pos( a_adult.slreppd ));
      params( 319 ) := "+"( Integer'Pos( a_adult.soc2000 ));
      params( 320 ) := "+"( Integer'Pos( a_adult.spcreg1 ));
      params( 321 ) := "+"( Integer'Pos( a_adult.spcreg2 ));
      params( 322 ) := "+"( Integer'Pos( a_adult.spcreg3 ));
      params( 323 ) := "+"( Integer'Pos( a_adult.specs ));
      params( 324 ) := "+"( Integer'Pos( a_adult.spout ));
      params( 325 ) := "+"( Float( a_adult.srentamt ));
      params( 326 ) := "+"( Integer'Pos( a_adult.srentpd ));
      params( 327 ) := "+"( Integer'Pos( a_adult.start ));
      params( 328 ) := "+"( Integer'Pos( a_adult.startyr ));
      params( 329 ) := "+"( Integer'Pos( a_adult.taxcred1 ));
      params( 330 ) := "+"( Integer'Pos( a_adult.taxcred2 ));
      params( 331 ) := "+"( Integer'Pos( a_adult.taxcred3 ));
      params( 332 ) := "+"( Integer'Pos( a_adult.taxcred4 ));
      params( 333 ) := "+"( Integer'Pos( a_adult.taxcred5 ));
      params( 334 ) := "+"( Integer'Pos( a_adult.taxfut ));
      params( 335 ) := "+"( Integer'Pos( a_adult.tdaywrk ));
      params( 336 ) := "+"( Integer'Pos( a_adult.tea ));
      params( 337 ) := "+"( Integer'Pos( a_adult.topupl ));
      params( 338 ) := "+"( Float( a_adult.totint ));
      params( 339 ) := "+"( Integer'Pos( a_adult.train ));
      params( 340 ) := "+"( Integer'Pos( a_adult.trav ));
      params( 341 ) := "+"( Integer'Pos( a_adult.tuborr ));
      params( 342 ) := "+"( Integer'Pos( a_adult.typeed ));
      params( 343 ) := "+"( Integer'Pos( a_adult.unpaid1 ));
      params( 344 ) := "+"( Integer'Pos( a_adult.unpaid2 ));
      params( 345 ) := "+"( Integer'Pos( a_adult.voucher ));
      params( 346 ) := "+"( Integer'Pos( a_adult.w1 ));
      params( 347 ) := "+"( Integer'Pos( a_adult.w2 ));
      params( 348 ) := "+"( Integer'Pos( a_adult.wait ));
      params( 349 ) := "+"( Integer'Pos( a_adult.war1 ));
      params( 350 ) := "+"( Integer'Pos( a_adult.war2 ));
      params( 351 ) := "+"( Integer'Pos( a_adult.wftcboth ));
      params( 352 ) := "+"( Integer'Pos( a_adult.wftclum ));
      params( 353 ) := "+"( Integer'Pos( a_adult.whoresp ));
      params( 354 ) := "+"( Integer'Pos( a_adult.whosectb ));
      params( 355 ) := "+"( Integer'Pos( a_adult.whyfrde1 ));
      params( 356 ) := "+"( Integer'Pos( a_adult.whyfrde2 ));
      params( 357 ) := "+"( Integer'Pos( a_adult.whyfrde3 ));
      params( 358 ) := "+"( Integer'Pos( a_adult.whyfrde4 ));
      params( 359 ) := "+"( Integer'Pos( a_adult.whyfrde5 ));
      params( 360 ) := "+"( Integer'Pos( a_adult.whyfrde6 ));
      params( 361 ) := "+"( Integer'Pos( a_adult.whyfrey1 ));
      params( 362 ) := "+"( Integer'Pos( a_adult.whyfrey2 ));
      params( 363 ) := "+"( Integer'Pos( a_adult.whyfrey3 ));
      params( 364 ) := "+"( Integer'Pos( a_adult.whyfrey4 ));
      params( 365 ) := "+"( Integer'Pos( a_adult.whyfrey5 ));
      params( 366 ) := "+"( Integer'Pos( a_adult.whyfrey6 ));
      params( 367 ) := "+"( Integer'Pos( a_adult.whyfrpr1 ));
      params( 368 ) := "+"( Integer'Pos( a_adult.whyfrpr2 ));
      params( 369 ) := "+"( Integer'Pos( a_adult.whyfrpr3 ));
      params( 370 ) := "+"( Integer'Pos( a_adult.whyfrpr4 ));
      params( 371 ) := "+"( Integer'Pos( a_adult.whyfrpr5 ));
      params( 372 ) := "+"( Integer'Pos( a_adult.whyfrpr6 ));
      params( 373 ) := "+"( Integer'Pos( a_adult.whytrav1 ));
      params( 374 ) := "+"( Integer'Pos( a_adult.whytrav2 ));
      params( 375 ) := "+"( Integer'Pos( a_adult.whytrav3 ));
      params( 376 ) := "+"( Integer'Pos( a_adult.whytrav4 ));
      params( 377 ) := "+"( Integer'Pos( a_adult.whytrav5 ));
      params( 378 ) := "+"( Integer'Pos( a_adult.whytrav6 ));
      params( 379 ) := "+"( Integer'Pos( a_adult.wintfuel ));
      params( 380 ) := "+"( Integer'Pos( a_adult.wmkit ));
      params( 381 ) := "+"( Integer'Pos( a_adult.working ));
      params( 382 ) := "+"( Integer'Pos( a_adult.wpa ));
      params( 383 ) := "+"( Integer'Pos( a_adult.wpba ));
      params( 384 ) := "+"( Integer'Pos( a_adult.wtclum1 ));
      params( 385 ) := "+"( Integer'Pos( a_adult.wtclum2 ));
      params( 386 ) := "+"( Integer'Pos( a_adult.wtclum3 ));
      params( 387 ) := "+"( Integer'Pos( a_adult.ystrtwk ));
      params( 388 ) := "+"( Integer'Pos( a_adult.month ));
      params( 389 ) := "+"( Integer'Pos( a_adult.able ));
      params( 390 ) := "+"( Integer'Pos( a_adult.actacci ));
      params( 391 ) := "+"( Integer'Pos( a_adult.addda ));
      params( 392 ) := "+"( Integer'Pos( a_adult.basacti ));
      params( 393 ) := "+"( Float( a_adult.bntxcred ));
      params( 394 ) := "+"( Integer'Pos( a_adult.careab ));
      params( 395 ) := "+"( Integer'Pos( a_adult.careah ));
      params( 396 ) := "+"( Integer'Pos( a_adult.carecb ));
      params( 397 ) := "+"( Integer'Pos( a_adult.carech ));
      params( 398 ) := "+"( Integer'Pos( a_adult.carecl ));
      params( 399 ) := "+"( Integer'Pos( a_adult.carefl ));
      params( 400 ) := "+"( Integer'Pos( a_adult.carefr ));
      params( 401 ) := "+"( Integer'Pos( a_adult.careot ));
      params( 402 ) := "+"( Integer'Pos( a_adult.carere ));
      params( 403 ) := "+"( Integer'Pos( a_adult.curacti ));
      params( 404 ) := "+"( Float( a_adult.empoccp ));
      params( 405 ) := "+"( Integer'Pos( a_adult.empstatb ));
      params( 406 ) := "+"( Integer'Pos( a_adult.empstatc ));
      params( 407 ) := "+"( Integer'Pos( a_adult.empstati ));
      params( 408 ) := "+"( Integer'Pos( a_adult.fsbndcti ));
      params( 409 ) := "+"( Float( a_adult.fwmlkval ));
      params( 410 ) := "+"( Integer'Pos( a_adult.gebacti ));
      params( 411 ) := "+"( Integer'Pos( a_adult.giltcti ));
      params( 412 ) := "+"( Integer'Pos( a_adult.gross2 ));
      params( 413 ) := "+"( Integer'Pos( a_adult.gross3 ));
      params( 414 ) := "+"( Float( a_adult.hbsupran ));
      params( 415 ) := "+"( Integer'Pos( a_adult.hdage ));
      params( 416 ) := "+"( Integer'Pos( a_adult.hdben ));
      params( 417 ) := "+"( Integer'Pos( a_adult.hdindinc ));
      params( 418 ) := "+"( Integer'Pos( a_adult.hourab ));
      params( 419 ) := "+"( Integer'Pos( a_adult.hourah ));
      params( 420 ) := "+"( Float( a_adult.hourcare ));
      params( 421 ) := "+"( Integer'Pos( a_adult.hourcb ));
      params( 422 ) := "+"( Integer'Pos( a_adult.hourch ));
      params( 423 ) := "+"( Integer'Pos( a_adult.hourcl ));
      params( 424 ) := "+"( Integer'Pos( a_adult.hourfr ));
      params( 425 ) := "+"( Integer'Pos( a_adult.hourot ));
      params( 426 ) := "+"( Integer'Pos( a_adult.hourre ));
      params( 427 ) := "+"( Integer'Pos( a_adult.hourtot ));
      params( 428 ) := "+"( Integer'Pos( a_adult.hperson ));
      params( 429 ) := "+"( Integer'Pos( a_adult.iagegr2 ));
      params( 430 ) := "+"( Integer'Pos( a_adult.iagegrp ));
      params( 431 ) := "+"( Float( a_adult.incseo2 ));
      params( 432 ) := "+"( Integer'Pos( a_adult.indinc ));
      params( 433 ) := "+"( Integer'Pos( a_adult.indisben ));
      params( 434 ) := "+"( Float( a_adult.inearns ));
      params( 435 ) := "+"( Float( a_adult.ininv ));
      params( 436 ) := "+"( Integer'Pos( a_adult.inirben ));
      params( 437 ) := "+"( Integer'Pos( a_adult.innirben ));
      params( 438 ) := "+"( Integer'Pos( a_adult.inothben ));
      params( 439 ) := "+"( Float( a_adult.inpeninc ));
      params( 440 ) := "+"( Float( a_adult.inrinc ));
      params( 441 ) := "+"( Float( a_adult.inrpinc ));
      params( 442 ) := "+"( Float( a_adult.intvlic ));
      params( 443 ) := "+"( Float( a_adult.intxcred ));
      params( 444 ) := "+"( Integer'Pos( a_adult.isacti ));
      params( 445 ) := "+"( Integer'Pos( a_adult.marital ));
      params( 446 ) := "+"( Float( a_adult.netocpen ));
      params( 447 ) := "+"( Float( a_adult.nincseo2 ));
      params( 448 ) := "+"( Integer'Pos( a_adult.nindinc ));
      params( 449 ) := "+"( Integer'Pos( a_adult.ninearns ));
      params( 450 ) := "+"( Integer'Pos( a_adult.nininv ));
      params( 451 ) := "+"( Integer'Pos( a_adult.ninpenin ));
      params( 452 ) := "+"( Float( a_adult.ninsein2 ));
      params( 453 ) := "+"( Integer'Pos( a_adult.nsbocti ));
      params( 454 ) := "+"( Integer'Pos( a_adult.occupnum ));
      params( 455 ) := "+"( Integer'Pos( a_adult.otbscti ));
      params( 456 ) := "+"( Integer'Pos( a_adult.pepscti ));
      params( 457 ) := "+"( Integer'Pos( a_adult.poaccti ));
      params( 458 ) := "+"( Integer'Pos( a_adult.prbocti ));
      params( 459 ) := "+"( Integer'Pos( a_adult.relhrp ));
      params( 460 ) := "+"( Integer'Pos( a_adult.sayecti ));
      params( 461 ) := "+"( Integer'Pos( a_adult.sclbcti ));
      params( 462 ) := "+"( Float( a_adult.seincam2 ));
      params( 463 ) := "+"( Float( a_adult.smpadj ));
      params( 464 ) := "+"( Integer'Pos( a_adult.sscti ));
      params( 465 ) := "+"( Float( a_adult.sspadj ));
      params( 466 ) := "+"( Integer'Pos( a_adult.stshcti ));
      params( 467 ) := "+"( Float( a_adult.superan ));
      params( 468 ) := "+"( Integer'Pos( a_adult.taxpayer ));
      params( 469 ) := "+"( Integer'Pos( a_adult.tesscti ));
      params( 470 ) := "+"( Float( a_adult.totgrant ));
      params( 471 ) := "+"( Float( a_adult.tothours ));
      params( 472 ) := "+"( Float( a_adult.totoccp ));
      params( 473 ) := "+"( Float( a_adult.ttwcosts ));
      params( 474 ) := "+"( Integer'Pos( a_adult.untrcti ));
      params( 475 ) := "+"( Integer'Pos( a_adult.uperson ));
      params( 476 ) := "+"( Float( a_adult.widoccp ));
      params( 477 ) := "+"( Integer'Pos( a_adult.accountq ));
      params( 478 ) := "+"( Integer'Pos( a_adult.ben5q7 ));
      params( 479 ) := "+"( Integer'Pos( a_adult.ben5q8 ));
      params( 480 ) := "+"( Integer'Pos( a_adult.ben5q9 ));
      params( 481 ) := "+"( Integer'Pos( a_adult.ddatre ));
      params( 482 ) := "+"( Integer'Pos( a_adult.disdif9 ));
      params( 483 ) := "+"( Float( a_adult.fare ));
      params( 484 ) := "+"( Integer'Pos( a_adult.nittwmod ));
      params( 485 ) := "+"( Integer'Pos( a_adult.oneway ));
      params( 486 ) := "+"( Float( a_adult.pssamt ));
      params( 487 ) := "+"( Integer'Pos( a_adult.pssdate ));
      params( 488 ) := "+"( Integer'Pos( a_adult.ttwcode1 ));
      params( 489 ) := "+"( Integer'Pos( a_adult.ttwcode2 ));
      params( 490 ) := "+"( Integer'Pos( a_adult.ttwcode3 ));
      params( 491 ) := "+"( Float( a_adult.ttwcost ));
      params( 492 ) := "+"( Integer'Pos( a_adult.ttwfar ));
      params( 493 ) := "+"( Float( a_adult.ttwfrq ));
      params( 494 ) := "+"( Integer'Pos( a_adult.ttwmod ));
      params( 495 ) := "+"( Integer'Pos( a_adult.ttwpay ));
      params( 496 ) := "+"( Integer'Pos( a_adult.ttwpss ));
      params( 497 ) := "+"( Float( a_adult.ttwrec ));
      params( 498 ) := "+"( Integer'Pos( a_adult.chbflg ));
      params( 499 ) := "+"( Integer'Pos( a_adult.crunaci ));
      params( 500 ) := "+"( Integer'Pos( a_adult.enomorti ));
      params( 501 ) := "+"( Float( a_adult.sapadj ));
      params( 502 ) := "+"( Float( a_adult.sppadj ));
      params( 503 ) := "+"( Integer'Pos( a_adult.ttwmode ));
      params( 504 ) := "+"( Integer'Pos( a_adult.ddatrep ));
      params( 505 ) := "+"( Integer'Pos( a_adult.defrpen ));
      params( 506 ) := "+"( Integer'Pos( a_adult.disdifp ));
      params( 507 ) := "+"( Integer'Pos( a_adult.followup ));
      params( 508 ) := "+"( Integer'Pos( a_adult.practice ));
      params( 509 ) := "+"( Integer'Pos( a_adult.sfrpis ));
      params( 510 ) := "+"( Integer'Pos( a_adult.sfrpjsa ));
      params( 511 ) := "+"( Integer'Pos( a_adult.age80 ));
      params( 512 ) := "+"( Integer'Pos( a_adult.ethgr2 ));
      params( 513 ) := "+"( Integer'Pos( a_adult.pocardi ));
      params( 514 ) := "+"( Integer'Pos( a_adult.chkdpn ));
      params( 515 ) := "+"( Integer'Pos( a_adult.chknop ));
      params( 516 ) := "+"( Integer'Pos( a_adult.consent ));
      params( 517 ) := "+"( Integer'Pos( a_adult.dvpens ));
      params( 518 ) := "+"( Integer'Pos( a_adult.eligschm ));
      params( 519 ) := "+"( Integer'Pos( a_adult.emparr ));
      params( 520 ) := "+"( Integer'Pos( a_adult.emppen ));
      params( 521 ) := "+"( Integer'Pos( a_adult.empschm ));
      params( 522 ) := "+"( Integer'Pos( a_adult.lnkref1 ));
      params( 523 ) := "+"( Integer'Pos( a_adult.lnkref2 ));
      params( 524 ) := "+"( Integer'Pos( a_adult.lnkref21 ));
      params( 525 ) := "+"( Integer'Pos( a_adult.lnkref22 ));
      params( 526 ) := "+"( Integer'Pos( a_adult.lnkref23 ));
      params( 527 ) := "+"( Integer'Pos( a_adult.lnkref24 ));
      params( 528 ) := "+"( Integer'Pos( a_adult.lnkref25 ));
      params( 529 ) := "+"( Integer'Pos( a_adult.lnkref3 ));
      params( 530 ) := "+"( Integer'Pos( a_adult.lnkref4 ));
      params( 531 ) := "+"( Integer'Pos( a_adult.lnkref5 ));
      params( 532 ) := "+"( Integer'Pos( a_adult.memschm ));
      params( 533 ) := "+"( Integer'Pos( a_adult.pconsent ));
      params( 534 ) := "+"( Integer'Pos( a_adult.perspen1 ));
      params( 535 ) := "+"( Integer'Pos( a_adult.perspen2 ));
      params( 536 ) := "+"( Integer'Pos( a_adult.privpen ));
      params( 537 ) := "+"( Integer'Pos( a_adult.schchk ));
      params( 538 ) := "+"( Integer'Pos( a_adult.spnumc ));
      params( 539 ) := "+"( Integer'Pos( a_adult.stakep ));
      params( 540 ) := "+"( Integer'Pos( a_adult.trainee ));
      params( 541 ) := "+"( Integer'Pos( a_adult.lnkdwp ));
      params( 542 ) := "+"( Integer'Pos( a_adult.lnkons ));
      params( 543 ) := "+"( Integer'Pos( a_adult.lnkref6 ));
      params( 544 ) := "+"( Integer'Pos( a_adult.lnkref7 ));
      params( 545 ) := "+"( Integer'Pos( a_adult.lnkref8 ));
      params( 546 ) := "+"( Integer'Pos( a_adult.lnkref9 ));
      params( 547 ) := "+"( Integer'Pos( a_adult.tcever1 ));
      params( 548 ) := "+"( Integer'Pos( a_adult.tcever2 ));
      params( 549 ) := "+"( Integer'Pos( a_adult.tcrepay1 ));
      params( 550 ) := "+"( Integer'Pos( a_adult.tcrepay2 ));
      params( 551 ) := "+"( Integer'Pos( a_adult.tcrepay3 ));
      params( 552 ) := "+"( Integer'Pos( a_adult.tcrepay4 ));
      params( 553 ) := "+"( Integer'Pos( a_adult.tcrepay5 ));
      params( 554 ) := "+"( Integer'Pos( a_adult.tcrepay6 ));
      params( 555 ) := "+"( Integer'Pos( a_adult.tcthsyr1 ));
      params( 556 ) := "+"( Integer'Pos( a_adult.tcthsyr2 ));
      params( 557 ) := "+"( Integer'Pos( a_adult.currjobm ));
      params( 558 ) := "+"( Integer'Pos( a_adult.prevjobm ));
      params( 559 ) := "+"( Integer'Pos( a_adult.b3qfut7 ));
      params( 560 ) := "+"( Integer'Pos( a_adult.ben3q7 ));
      params( 561 ) := "+"( Integer'Pos( a_adult.camemt ));
      params( 562 ) := "+"( Integer'Pos( a_adult.cameyr ));
      params( 563 ) := "+"( Integer'Pos( a_adult.cameyr2 ));
      params( 564 ) := "+"( Integer'Pos( a_adult.contuk ));
      params( 565 ) := "+"( Integer'Pos( a_adult.corign ));
      params( 566 ) := "+"( Integer'Pos( a_adult.ddaprog ));
      params( 567 ) := "+"( Integer'Pos( a_adult.hbolng ));
      params( 568 ) := "+"( Integer'Pos( a_adult.hi1qual1 ));
      params( 569 ) := "+"( Integer'Pos( a_adult.hi1qual2 ));
      params( 570 ) := "+"( Integer'Pos( a_adult.hi1qual3 ));
      params( 571 ) := "+"( Integer'Pos( a_adult.hi1qual4 ));
      params( 572 ) := "+"( Integer'Pos( a_adult.hi1qual5 ));
      params( 573 ) := "+"( Integer'Pos( a_adult.hi1qual6 ));
      params( 574 ) := "+"( Integer'Pos( a_adult.hi2qual ));
      params( 575 ) := "+"( Integer'Pos( a_adult.hlpgvn01 ));
      params( 576 ) := "+"( Integer'Pos( a_adult.hlpgvn02 ));
      params( 577 ) := "+"( Integer'Pos( a_adult.hlpgvn03 ));
      params( 578 ) := "+"( Integer'Pos( a_adult.hlpgvn04 ));
      params( 579 ) := "+"( Integer'Pos( a_adult.hlpgvn05 ));
      params( 580 ) := "+"( Integer'Pos( a_adult.hlpgvn06 ));
      params( 581 ) := "+"( Integer'Pos( a_adult.hlpgvn07 ));
      params( 582 ) := "+"( Integer'Pos( a_adult.hlpgvn08 ));
      params( 583 ) := "+"( Integer'Pos( a_adult.hlpgvn09 ));
      params( 584 ) := "+"( Integer'Pos( a_adult.hlpgvn10 ));
      params( 585 ) := "+"( Integer'Pos( a_adult.hlpgvn11 ));
      params( 586 ) := "+"( Integer'Pos( a_adult.hlprec01 ));
      params( 587 ) := "+"( Integer'Pos( a_adult.hlprec02 ));
      params( 588 ) := "+"( Integer'Pos( a_adult.hlprec03 ));
      params( 589 ) := "+"( Integer'Pos( a_adult.hlprec04 ));
      params( 590 ) := "+"( Integer'Pos( a_adult.hlprec05 ));
      params( 591 ) := "+"( Integer'Pos( a_adult.hlprec06 ));
      params( 592 ) := "+"( Integer'Pos( a_adult.hlprec07 ));
      params( 593 ) := "+"( Integer'Pos( a_adult.hlprec08 ));
      params( 594 ) := "+"( Integer'Pos( a_adult.hlprec09 ));
      params( 595 ) := "+"( Integer'Pos( a_adult.hlprec10 ));
      params( 596 ) := "+"( Integer'Pos( a_adult.hlprec11 ));
      params( 597 ) := "+"( Integer'Pos( a_adult.issue ));
      params( 598 ) := "+"( Integer'Pos( a_adult.loangvn1 ));
      params( 599 ) := "+"( Integer'Pos( a_adult.loangvn2 ));
      params( 600 ) := "+"( Integer'Pos( a_adult.loangvn3 ));
      params( 601 ) := "+"( Integer'Pos( a_adult.loanrec1 ));
      params( 602 ) := "+"( Integer'Pos( a_adult.loanrec2 ));
      params( 603 ) := "+"( Integer'Pos( a_adult.loanrec3 ));
      params( 604 ) := "+"( Integer'Pos( a_adult.mntarr1 ));
      params( 605 ) := "+"( Integer'Pos( a_adult.mntarr2 ));
      params( 606 ) := "+"( Integer'Pos( a_adult.mntarr3 ));
      params( 607 ) := "+"( Integer'Pos( a_adult.mntarr4 ));
      params( 608 ) := "+"( Integer'Pos( a_adult.mntnrp ));
      params( 609 ) := "+"( Integer'Pos( a_adult.othqual1 ));
      params( 610 ) := "+"( Integer'Pos( a_adult.othqual2 ));
      params( 611 ) := "+"( Integer'Pos( a_adult.othqual3 ));
      params( 612 ) := "+"( Integer'Pos( a_adult.tea9697 ));
      params( 613 ) := "+"( Float( a_adult.heartval ));
      params( 614 ) := "+"( Integer'Pos( a_adult.iagegr3 ));
      params( 615 ) := "+"( Integer'Pos( a_adult.iagegr4 ));
      params( 616 ) := "+"( Integer'Pos( a_adult.nirel2 ));
      params( 617 ) := "+"( Integer'Pos( a_adult.xbonflag ));
      params( 618 ) := "+"( Integer'Pos( a_adult.alg ));
      params( 619 ) := "+"( Float( a_adult.algamt ));
      params( 620 ) := "+"( Integer'Pos( a_adult.algpd ));
      params( 621 ) := "+"( Integer'Pos( a_adult.ben4q4 ));
      params( 622 ) := "+"( Integer'Pos( a_adult.chkctc ));
      params( 623 ) := "+"( Integer'Pos( a_adult.chkdpco1 ));
      params( 624 ) := "+"( Integer'Pos( a_adult.chkdpco2 ));
      params( 625 ) := "+"( Integer'Pos( a_adult.chkdpco3 ));
      params( 626 ) := "+"( Integer'Pos( a_adult.chkdsco1 ));
      params( 627 ) := "+"( Integer'Pos( a_adult.chkdsco2 ));
      params( 628 ) := "+"( Integer'Pos( a_adult.chkdsco3 ));
      params( 629 ) := "+"( Integer'Pos( a_adult.dv09pens ));
      params( 630 ) := "+"( Integer'Pos( a_adult.lnkref01 ));
      params( 631 ) := "+"( Integer'Pos( a_adult.lnkref02 ));
      params( 632 ) := "+"( Integer'Pos( a_adult.lnkref03 ));
      params( 633 ) := "+"( Integer'Pos( a_adult.lnkref04 ));
      params( 634 ) := "+"( Integer'Pos( a_adult.lnkref05 ));
      params( 635 ) := "+"( Integer'Pos( a_adult.lnkref06 ));
      params( 636 ) := "+"( Integer'Pos( a_adult.lnkref07 ));
      params( 637 ) := "+"( Integer'Pos( a_adult.lnkref08 ));
      params( 638 ) := "+"( Integer'Pos( a_adult.lnkref09 ));
      params( 639 ) := "+"( Integer'Pos( a_adult.lnkref10 ));
      params( 640 ) := "+"( Integer'Pos( a_adult.lnkref11 ));
      params( 641 ) := "+"( Integer'Pos( a_adult.spyrot ));
      params( 642 ) := "+"( Integer'Pos( a_adult.disdifad ));
      params( 643 ) := "+"( Integer'Pos( a_adult.gross3_x ));
      params( 644 ) := "+"( Float( a_adult.aliamt ));
      params( 645 ) := "+"( Integer'Pos( a_adult.alimny ));
      params( 646 ) := "+"( Integer'Pos( a_adult.alipd ));
      params( 647 ) := "+"( Integer'Pos( a_adult.alius ));
      params( 648 ) := "+"( Float( a_adult.aluamt ));
      params( 649 ) := "+"( Integer'Pos( a_adult.alupd ));
      params( 650 ) := "+"( Integer'Pos( a_adult.cbaamt ));
      params( 651 ) := "+"( Integer'Pos( a_adult.hsvper ));
      params( 652 ) := "+"( Integer'Pos( a_adult.mednum ));
      params( 653 ) := "+"( Integer'Pos( a_adult.medprpd ));
      params( 654 ) := "+"( Integer'Pos( a_adult.medprpy ));
      params( 655 ) := "+"( Integer'Pos( a_adult.penflag ));
      params( 656 ) := "+"( Integer'Pos( a_adult.ppchk1 ));
      params( 657 ) := "+"( Integer'Pos( a_adult.ppchk2 ));
      params( 658 ) := "+"( Integer'Pos( a_adult.ppchk3 ));
      params( 659 ) := "+"( Float( a_adult.ttbprx ));
      params( 660 ) := "+"( Integer'Pos( a_adult.mjobsect ));
      params( 661 ) := "+"( Integer'Pos( a_adult.etngrp ));
      params( 662 ) := "+"( Integer'Pos( a_adult.medpay ));
      params( 663 ) := "+"( Integer'Pos( a_adult.medrep ));
      params( 664 ) := "+"( Integer'Pos( a_adult.medrpnm ));
      params( 665 ) := "+"( Integer'Pos( a_adult.nanid1 ));
      params( 666 ) := "+"( Integer'Pos( a_adult.nanid2 ));
      params( 667 ) := "+"( Integer'Pos( a_adult.nanid3 ));
      params( 668 ) := "+"( Integer'Pos( a_adult.nanid4 ));
      params( 669 ) := "+"( Integer'Pos( a_adult.nanid5 ));
      params( 670 ) := "+"( Integer'Pos( a_adult.nanid6 ));
      params( 671 ) := "+"( Integer'Pos( a_adult.nietngrp ));
      params( 672 ) := "+"( Integer'Pos( a_adult.ninanid1 ));
      params( 673 ) := "+"( Integer'Pos( a_adult.ninanid2 ));
      params( 674 ) := "+"( Integer'Pos( a_adult.ninanid3 ));
      params( 675 ) := "+"( Integer'Pos( a_adult.ninanid4 ));
      params( 676 ) := "+"( Integer'Pos( a_adult.ninanid5 ));
      params( 677 ) := "+"( Integer'Pos( a_adult.ninanid6 ));
      params( 678 ) := "+"( Integer'Pos( a_adult.ninanid7 ));
      params( 679 ) := "+"( Integer'Pos( a_adult.nirelig ));
      params( 680 ) := "+"( Integer'Pos( a_adult.pollopin ));
      params( 681 ) := "+"( Integer'Pos( a_adult.religenw ));
      params( 682 ) := "+"( Integer'Pos( a_adult.religsc ));
      params( 683 ) := "+"( Integer'Pos( a_adult.sidqn ));
      params( 684 ) := "+"( Integer'Pos( a_adult.soc2010 ));
      params( 685 ) := "+"( Integer'Pos( a_adult.corignan ));
      params( 686 ) := "+"( Integer'Pos( a_adult.dobmonth ));
      params( 687 ) := "+"( Integer'Pos( a_adult.dobyear ));
      params( 688 ) := "+"( Integer'Pos( a_adult.ethgr3 ));
      params( 689 ) := "+"( Integer'Pos( a_adult.ninanida ));
      params( 690 ) := "+"( Integer'Pos( a_adult.agehqual ));
      params( 691 ) := "+"( Integer'Pos( a_adult.bfd ));
      params( 692 ) := "+"( Float( a_adult.bfdamt ));
      params( 693 ) := "+"( Integer'Pos( a_adult.bfdpd ));
      params( 694 ) := "+"( Integer'Pos( a_adult.bfdval ));
      params( 695 ) := "+"( Integer'Pos( a_adult.btec ));
      params( 696 ) := "+"( Integer'Pos( a_adult.btecnow ));
      params( 697 ) := "+"( Integer'Pos( a_adult.cbaamt2 ));
      params( 698 ) := "+"( Integer'Pos( a_adult.change ));
      params( 699 ) := "+"( Integer'Pos( a_adult.citizen ));
      params( 700 ) := "+"( Integer'Pos( a_adult.citizen2 ));
      params( 701 ) := "+"( Integer'Pos( a_adult.condit ));
      params( 702 ) := "+"( Integer'Pos( a_adult.corigoth ));
      params( 703 ) := "+"( Integer'Pos( a_adult.curqual ));
      params( 704 ) := "+"( Integer'Pos( a_adult.ddaprog1 ));
      params( 705 ) := "+"( Integer'Pos( a_adult.ddatre1 ));
      params( 706 ) := "+"( Integer'Pos( a_adult.ddatrep1 ));
      params( 707 ) := "+"( Integer'Pos( a_adult.degree ));
      params( 708 ) := "+"( Integer'Pos( a_adult.degrenow ));
      params( 709 ) := "+"( Integer'Pos( a_adult.denrec ));
      params( 710 ) := "+"( Integer'Pos( a_adult.disd01 ));
      params( 711 ) := "+"( Integer'Pos( a_adult.disd02 ));
      params( 712 ) := "+"( Integer'Pos( a_adult.disd03 ));
      params( 713 ) := "+"( Integer'Pos( a_adult.disd04 ));
      params( 714 ) := "+"( Integer'Pos( a_adult.disd05 ));
      params( 715 ) := "+"( Integer'Pos( a_adult.disd06 ));
      params( 716 ) := "+"( Integer'Pos( a_adult.disd07 ));
      params( 717 ) := "+"( Integer'Pos( a_adult.disd08 ));
      params( 718 ) := "+"( Integer'Pos( a_adult.disd09 ));
      params( 719 ) := "+"( Integer'Pos( a_adult.disd10 ));
      params( 720 ) := "+"( Integer'Pos( a_adult.disdifp1 ));
      params( 721 ) := "+"( Integer'Pos( a_adult.empcontr ));
      params( 722 ) := "+"( Integer'Pos( a_adult.ethgrps ));
      params( 723 ) := "+"( Float( a_adult.eualiamt ));
      params( 724 ) := "+"( Integer'Pos( a_adult.eualimny ));
      params( 725 ) := "+"( Integer'Pos( a_adult.eualipd ));
      params( 726 ) := "+"( Integer'Pos( a_adult.euetype ));
      params( 727 ) := "+"( Integer'Pos( a_adult.followsc ));
      params( 728 ) := "+"( Integer'Pos( a_adult.health1 ));
      params( 729 ) := "+"( Integer'Pos( a_adult.heathad ));
      params( 730 ) := "+"( Integer'Pos( a_adult.hi3qual ));
      params( 731 ) := "+"( Integer'Pos( a_adult.higho ));
      params( 732 ) := "+"( Integer'Pos( a_adult.highonow ));
      params( 733 ) := "+"( Integer'Pos( a_adult.jobbyr ));
      params( 734 ) := "+"( Integer'Pos( a_adult.limitl ));
      params( 735 ) := "+"( Integer'Pos( a_adult.lktrain ));
      params( 736 ) := "+"( Integer'Pos( a_adult.lkwork ));
      params( 737 ) := "+"( Integer'Pos( a_adult.medrec ));
      params( 738 ) := "+"( Integer'Pos( a_adult.nvqlenow ));
      params( 739 ) := "+"( Integer'Pos( a_adult.nvqlev ));
      params( 740 ) := "+"( Integer'Pos( a_adult.othpass ));
      params( 741 ) := "+"( Integer'Pos( a_adult.ppper ));
      params( 742 ) := "+"( Float( a_adult.proptax ));
      params( 743 ) := "+"( Integer'Pos( a_adult.reasden ));
      params( 744 ) := "+"( Integer'Pos( a_adult.reasmed ));
      params( 745 ) := "+"( Integer'Pos( a_adult.reasnhs ));
      params( 746 ) := "+"( Integer'Pos( a_adult.reason ));
      params( 747 ) := "+"( Integer'Pos( a_adult.rednet ));
      params( 748 ) := "+"( Float( a_adult.redtax ));
      params( 749 ) := "+"( Integer'Pos( a_adult.rsa ));
      params( 750 ) := "+"( Integer'Pos( a_adult.rsanow ));
      params( 751 ) := "+"( Integer'Pos( a_adult.samesit ));
      params( 752 ) := "+"( Integer'Pos( a_adult.scotvec ));
      params( 753 ) := "+"( Integer'Pos( a_adult.sctvnow ));
      params( 754 ) := "+"( Integer'Pos( a_adult.sdemp01 ));
      params( 755 ) := "+"( Integer'Pos( a_adult.sdemp02 ));
      params( 756 ) := "+"( Integer'Pos( a_adult.sdemp03 ));
      params( 757 ) := "+"( Integer'Pos( a_adult.sdemp04 ));
      params( 758 ) := "+"( Integer'Pos( a_adult.sdemp05 ));
      params( 759 ) := "+"( Integer'Pos( a_adult.sdemp06 ));
      params( 760 ) := "+"( Integer'Pos( a_adult.sdemp07 ));
      params( 761 ) := "+"( Integer'Pos( a_adult.sdemp08 ));
      params( 762 ) := "+"( Integer'Pos( a_adult.sdemp09 ));
      params( 763 ) := "+"( Integer'Pos( a_adult.sdemp10 ));
      params( 764 ) := "+"( Integer'Pos( a_adult.sdemp11 ));
      params( 765 ) := "+"( Integer'Pos( a_adult.sdemp12 ));
      params( 766 ) := "+"( Integer'Pos( a_adult.selfdemp ));
      params( 767 ) := "+"( Integer'Pos( a_adult.tempjob ));
      params( 768 ) := "+"( Integer'Pos( a_adult.agehq80 ));
      params( 769 ) := "+"( Integer'Pos( a_adult.disacta1 ));
      params( 770 ) := "+"( Integer'Pos( a_adult.discora1 ));
      params( 771 ) := "+"( Integer'Pos( a_adult.gross4 ));
      params( 772 ) := "+"( Integer'Pos( a_adult.ninrinc ));
      params( 773 ) := "+"( Integer'Pos( a_adult.typeed2 ));
      params( 774 ) := "+"( Integer'Pos( a_adult.w45 ));
      params( 775 ) := "+"( Integer'Pos( a_adult.accmsat ));
      params( 776 ) := "+"( Integer'Pos( a_adult.c2orign ));
      params( 777 ) := "+"( Integer'Pos( a_adult.calm ));
      params( 778 ) := "+"( Integer'Pos( a_adult.cbchk ));
      params( 779 ) := "+"( Integer'Pos( a_adult.claifut1 ));
      params( 780 ) := "+"( Integer'Pos( a_adult.claifut2 ));
      params( 781 ) := "+"( Integer'Pos( a_adult.claifut3 ));
      params( 782 ) := "+"( Integer'Pos( a_adult.claifut4 ));
      params( 783 ) := "+"( Integer'Pos( a_adult.claifut5 ));
      params( 784 ) := "+"( Integer'Pos( a_adult.claifut6 ));
      params( 785 ) := "+"( Integer'Pos( a_adult.claifut7 ));
      params( 786 ) := "+"( Integer'Pos( a_adult.claifut8 ));
      params( 787 ) := "+"( Integer'Pos( a_adult.commusat ));
      params( 788 ) := "+"( Integer'Pos( a_adult.coptrust ));
      params( 789 ) := "+"( Integer'Pos( a_adult.depress ));
      params( 790 ) := "+"( Integer'Pos( a_adult.disben1 ));
      params( 791 ) := "+"( Integer'Pos( a_adult.disben2 ));
      params( 792 ) := "+"( Integer'Pos( a_adult.disben3 ));
      params( 793 ) := "+"( Integer'Pos( a_adult.disben4 ));
      params( 794 ) := "+"( Integer'Pos( a_adult.disben5 ));
      params( 795 ) := "+"( Integer'Pos( a_adult.disben6 ));
      params( 796 ) := "+"( Integer'Pos( a_adult.discuss ));
      params( 797 ) := "+"( Integer'Pos( a_adult.dla1 ));
      params( 798 ) := "+"( Integer'Pos( a_adult.dla2 ));
      params( 799 ) := "+"( Integer'Pos( a_adult.dls ));
      params( 800 ) := "+"( Float( a_adult.dlsamt ));
      params( 801 ) := "+"( Integer'Pos( a_adult.dlspd ));
      params( 802 ) := "+"( Integer'Pos( a_adult.dlsval ));
      params( 803 ) := "+"( Integer'Pos( a_adult.down ));
      params( 804 ) := "+"( Integer'Pos( a_adult.envirsat ));
      params( 805 ) := "+"( Integer'Pos( a_adult.gpispc ));
      params( 806 ) := "+"( Integer'Pos( a_adult.gpjsaesa ));
      params( 807 ) := "+"( Integer'Pos( a_adult.happy ));
      params( 808 ) := "+"( Integer'Pos( a_adult.help ));
      params( 809 ) := "+"( Integer'Pos( a_adult.iclaim1 ));
      params( 810 ) := "+"( Integer'Pos( a_adult.iclaim2 ));
      params( 811 ) := "+"( Integer'Pos( a_adult.iclaim3 ));
      params( 812 ) := "+"( Integer'Pos( a_adult.iclaim4 ));
      params( 813 ) := "+"( Integer'Pos( a_adult.iclaim5 ));
      params( 814 ) := "+"( Integer'Pos( a_adult.iclaim6 ));
      params( 815 ) := "+"( Integer'Pos( a_adult.iclaim7 ));
      params( 816 ) := "+"( Integer'Pos( a_adult.iclaim8 ));
      params( 817 ) := "+"( Integer'Pos( a_adult.iclaim9 ));
      params( 818 ) := "+"( Integer'Pos( a_adult.jobsat ));
      params( 819 ) := "+"( Integer'Pos( a_adult.kidben1 ));
      params( 820 ) := "+"( Integer'Pos( a_adult.kidben2 ));
      params( 821 ) := "+"( Integer'Pos( a_adult.kidben3 ));
      params( 822 ) := "+"( Integer'Pos( a_adult.legltrus ));
      params( 823 ) := "+"( Integer'Pos( a_adult.lifesat ));
      params( 824 ) := "+"( Integer'Pos( a_adult.meaning ));
      params( 825 ) := "+"( Integer'Pos( a_adult.moneysat ));
      params( 826 ) := "+"( Integer'Pos( a_adult.nervous ));
      params( 827 ) := "+"( Integer'Pos( a_adult.ni2train ));
      params( 828 ) := "+"( Integer'Pos( a_adult.othben1 ));
      params( 829 ) := "+"( Integer'Pos( a_adult.othben2 ));
      params( 830 ) := "+"( Integer'Pos( a_adult.othben3 ));
      params( 831 ) := "+"( Integer'Pos( a_adult.othben4 ));
      params( 832 ) := "+"( Integer'Pos( a_adult.othben5 ));
      params( 833 ) := "+"( Integer'Pos( a_adult.othben6 ));
      params( 834 ) := "+"( Integer'Pos( a_adult.othtrust ));
      params( 835 ) := "+"( Integer'Pos( a_adult.penben1 ));
      params( 836 ) := "+"( Integer'Pos( a_adult.penben2 ));
      params( 837 ) := "+"( Integer'Pos( a_adult.penben3 ));
      params( 838 ) := "+"( Integer'Pos( a_adult.penben4 ));
      params( 839 ) := "+"( Integer'Pos( a_adult.penben5 ));
      params( 840 ) := "+"( Integer'Pos( a_adult.pip1 ));
      params( 841 ) := "+"( Integer'Pos( a_adult.pip2 ));
      params( 842 ) := "+"( Integer'Pos( a_adult.polttrus ));
      params( 843 ) := "+"( Integer'Pos( a_adult.recsat ));
      params( 844 ) := "+"( Integer'Pos( a_adult.relasat ));
      params( 845 ) := "+"( Integer'Pos( a_adult.safe ));
      params( 846 ) := "+"( Integer'Pos( a_adult.socfund1 ));
      params( 847 ) := "+"( Integer'Pos( a_adult.socfund2 ));
      params( 848 ) := "+"( Integer'Pos( a_adult.socfund3 ));
      params( 849 ) := "+"( Integer'Pos( a_adult.socfund4 ));
      params( 850 ) := "+"( Integer'Pos( a_adult.srispc ));
      params( 851 ) := "+"( Integer'Pos( a_adult.srjsaesa ));
      params( 852 ) := "+"( Integer'Pos( a_adult.timesat ));
      params( 853 ) := "+"( Integer'Pos( a_adult.train2 ));
      params( 854 ) := "+"( Integer'Pos( a_adult.trnallow ));
      params( 855 ) := "+"( Integer'Pos( a_adult.wageben1 ));
      params( 856 ) := "+"( Integer'Pos( a_adult.wageben2 ));
      params( 857 ) := "+"( Integer'Pos( a_adult.wageben3 ));
      params( 858 ) := "+"( Integer'Pos( a_adult.wageben4 ));
      params( 859 ) := "+"( Integer'Pos( a_adult.wageben5 ));
      params( 860 ) := "+"( Integer'Pos( a_adult.wageben6 ));
      params( 861 ) := "+"( Integer'Pos( a_adult.wageben7 ));
      params( 862 ) := "+"( Integer'Pos( a_adult.wageben8 ));
      params( 863 ) := "+"( Integer'Pos( a_adult.ninnirbn ));
      params( 864 ) := "+"( Integer'Pos( a_adult.ninothbn ));
      params( 865 ) := "+"( Integer'Pos( a_adult.anxious ));
      params( 866 ) := "+"( Integer'Pos( a_adult.candgnow ));
      params( 867 ) := "+"( Integer'Pos( a_adult.curothf ));
      params( 868 ) := "+"( Integer'Pos( a_adult.curothp ));
      params( 869 ) := "+"( Integer'Pos( a_adult.curothwv ));
      params( 870 ) := "+"( Integer'Pos( a_adult.dvhiqual ));
      params( 871 ) := "+"( Integer'Pos( a_adult.gnvqnow ));
      params( 872 ) := "+"( Integer'Pos( a_adult.gpuc ));
      params( 873 ) := "+"( Integer'Pos( a_adult.happywb ));
      params( 874 ) := "+"( Integer'Pos( a_adult.hi1qual7 ));
      params( 875 ) := "+"( Integer'Pos( a_adult.hi1qual8 ));
      params( 876 ) := "+"( Integer'Pos( a_adult.mntarr5 ));
      params( 877 ) := "+"( Integer'Pos( a_adult.mntnoch1 ));
      params( 878 ) := "+"( Integer'Pos( a_adult.mntnoch2 ));
      params( 879 ) := "+"( Integer'Pos( a_adult.mntnoch3 ));
      params( 880 ) := "+"( Integer'Pos( a_adult.mntnoch4 ));
      params( 881 ) := "+"( Integer'Pos( a_adult.mntnoch5 ));
      params( 882 ) := "+"( Integer'Pos( a_adult.mntpro1 ));
      params( 883 ) := "+"( Integer'Pos( a_adult.mntpro2 ));
      params( 884 ) := "+"( Integer'Pos( a_adult.mntpro3 ));
      params( 885 ) := "+"( Integer'Pos( a_adult.mnttim1 ));
      params( 886 ) := "+"( Integer'Pos( a_adult.mnttim2 ));
      params( 887 ) := "+"( Integer'Pos( a_adult.mnttim3 ));
      params( 888 ) := "+"( Integer'Pos( a_adult.mntwrk1 ));
      params( 889 ) := "+"( Integer'Pos( a_adult.mntwrk2 ));
      params( 890 ) := "+"( Integer'Pos( a_adult.mntwrk3 ));
      params( 891 ) := "+"( Integer'Pos( a_adult.mntwrk4 ));
      params( 892 ) := "+"( Integer'Pos( a_adult.mntwrk5 ));
      params( 893 ) := "+"( Integer'Pos( a_adult.ndeplnow ));
      params( 894 ) := "+"( Integer'Pos( a_adult.oqualc1 ));
      params( 895 ) := "+"( Integer'Pos( a_adult.oqualc2 ));
      params( 896 ) := "+"( Integer'Pos( a_adult.oqualc3 ));
      params( 897 ) := "+"( Integer'Pos( a_adult.sruc ));
      params( 898 ) := "+"( Integer'Pos( a_adult.webacnow ));
      params( 899 ) := "+"( Integer'Pos( a_adult.indeth ));
      params( 900 ) := "+"( Integer'Pos( a_adult.euactive ));
      params( 901 ) := "+"( Integer'Pos( a_adult.euactno ));
      params( 902 ) := "+"( Integer'Pos( a_adult.euartact ));
      params( 903 ) := "+"( Integer'Pos( a_adult.euaskhlp ));
      params( 904 ) := "+"( Integer'Pos( a_adult.eucinema ));
      params( 905 ) := "+"( Integer'Pos( a_adult.eucultur ));
      params( 906 ) := "+"( Integer'Pos( a_adult.euinvol ));
      params( 907 ) := "+"( Integer'Pos( a_adult.eulivpe ));
      params( 908 ) := "+"( Integer'Pos( a_adult.eumtfam ));
      params( 909 ) := "+"( Integer'Pos( a_adult.eumtfrnd ));
      params( 910 ) := "+"( Integer'Pos( a_adult.eusocnet ));
      params( 911 ) := "+"( Integer'Pos( a_adult.eusport ));
      params( 912 ) := "+"( Integer'Pos( a_adult.eutkfam ));
      params( 913 ) := "+"( Integer'Pos( a_adult.eutkfrnd ));
      params( 914 ) := "+"( Integer'Pos( a_adult.eutkmat ));
      params( 915 ) := "+"( Integer'Pos( a_adult.euvol ));
      params( 916 ) := "+"( Integer'Pos( a_adult.natscot ));
      params( 917 ) := "+"( Integer'Pos( a_adult.ntsctnow ));
      params( 918 ) := "+"( Integer'Pos( a_adult.penwel1 ));
      params( 919 ) := "+"( Integer'Pos( a_adult.penwel2 ));
      params( 920 ) := "+"( Integer'Pos( a_adult.penwel3 ));
      params( 921 ) := "+"( Integer'Pos( a_adult.penwel4 ));
      params( 922 ) := "+"( Integer'Pos( a_adult.penwel5 ));
      params( 923 ) := "+"( Integer'Pos( a_adult.penwel6 ));
      params( 924 ) := "+"( Integer'Pos( a_adult.skiwknow ));
      params( 925 ) := "+"( Integer'Pos( a_adult.skiwrk ));
      params( 926 ) := "+"( Integer'Pos( a_adult.slos ));
      params( 927 ) := "+"( Integer'Pos( a_adult.yjblev ));
      gse.Execute( local_connection, SAVE_PS, params );  
      Check_Result( local_connection );
      if( is_local_connection )then
         Connection_Pool.Return_Connection( local_connection );
      end if;
   end Save;

   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Adult
   --

   procedure Delete( a_adult : in out Ukds.Frs.Adult; connection : Database_Connection := null ) is
         c : d.Criteria;
   begin  
      Add_user_id( c, a_adult.user_id );
      Add_edition( c, a_adult.edition );
      Add_year( c, a_adult.year );
      Add_sernum( c, a_adult.sernum );
      Add_benunit( c, a_adult.benunit );
      Add_person( c, a_adult.person );
      Delete( c, connection );
      a_adult := Ukds.Frs.Null_Adult;
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
   function Retrieve_Associated_Ukds_Frs_Penamts( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Penamt_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Penamt_IO.Add_Year( c, a_adult.Year );
      Ukds.Frs.Penamt_IO.Add_User_Id( c, a_adult.User_Id );
      Ukds.Frs.Penamt_IO.Add_Edition( c, a_adult.Edition );
      Ukds.Frs.Penamt_IO.Add_Sernum( c, a_adult.Sernum );
      Ukds.Frs.Penamt_IO.Add_Benunit( c, a_adult.Benunit );
      Ukds.Frs.Penamt_IO.Add_Person( c, a_adult.Person );
      return Ukds.Frs.Penamt_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Penamts;


   function Retrieve_Associated_Ukds_Frs_Govpays( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Govpay_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Govpay_IO.Add_Year( c, a_adult.Year );
      Ukds.Frs.Govpay_IO.Add_User_Id( c, a_adult.User_Id );
      Ukds.Frs.Govpay_IO.Add_Edition( c, a_adult.Edition );
      Ukds.Frs.Govpay_IO.Add_Sernum( c, a_adult.Sernum );
      Ukds.Frs.Govpay_IO.Add_Benunit( c, a_adult.Benunit );
      Ukds.Frs.Govpay_IO.Add_Person( c, a_adult.Person );
      return Ukds.Frs.Govpay_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Govpays;


   function Retrieve_Associated_Ukds_Frs_Assets( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Assets_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Assets_IO.Add_Year( c, a_adult.Year );
      Ukds.Frs.Assets_IO.Add_User_Id( c, a_adult.User_Id );
      Ukds.Frs.Assets_IO.Add_Edition( c, a_adult.Edition );
      Ukds.Frs.Assets_IO.Add_Sernum( c, a_adult.Sernum );
      Ukds.Frs.Assets_IO.Add_Benunit( c, a_adult.Benunit );
      Ukds.Frs.Assets_IO.Add_Person( c, a_adult.Person );
      return Ukds.Frs.Assets_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Assets;


   function Retrieve_Associated_Ukds_Frs_Penprovs( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Penprov_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Penprov_IO.Add_Year( c, a_adult.Year );
      Ukds.Frs.Penprov_IO.Add_User_Id( c, a_adult.User_Id );
      Ukds.Frs.Penprov_IO.Add_Edition( c, a_adult.Edition );
      Ukds.Frs.Penprov_IO.Add_Sernum( c, a_adult.Sernum );
      Ukds.Frs.Penprov_IO.Add_Benunit( c, a_adult.Benunit );
      Ukds.Frs.Penprov_IO.Add_Person( c, a_adult.Person );
      return Ukds.Frs.Penprov_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Penprovs;


   function Retrieve_Associated_Ukds_Frs_Maints( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Maint_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Maint_IO.Add_Year( c, a_adult.Year );
      Ukds.Frs.Maint_IO.Add_User_Id( c, a_adult.User_Id );
      Ukds.Frs.Maint_IO.Add_Edition( c, a_adult.Edition );
      Ukds.Frs.Maint_IO.Add_Sernum( c, a_adult.Sernum );
      Ukds.Frs.Maint_IO.Add_Benunit( c, a_adult.Benunit );
      Ukds.Frs.Maint_IO.Add_Person( c, a_adult.Person );
      return Ukds.Frs.Maint_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Maints;


   function Retrieve_Associated_Ukds_Frs_Jobs( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Job_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Job_IO.Add_Year( c, a_adult.Year );
      Ukds.Frs.Job_IO.Add_User_Id( c, a_adult.User_Id );
      Ukds.Frs.Job_IO.Add_Edition( c, a_adult.Edition );
      Ukds.Frs.Job_IO.Add_Sernum( c, a_adult.Sernum );
      Ukds.Frs.Job_IO.Add_Benunit( c, a_adult.Benunit );
      Ukds.Frs.Job_IO.Add_Person( c, a_adult.Person );
      return Ukds.Frs.Job_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Jobs;


   function Retrieve_Associated_Ukds_Frs_Childcares( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Childcare_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Childcare_IO.Add_Year( c, a_adult.Year );
      Ukds.Frs.Childcare_IO.Add_User_Id( c, a_adult.User_Id );
      Ukds.Frs.Childcare_IO.Add_Edition( c, a_adult.Edition );
      Ukds.Frs.Childcare_IO.Add_Sernum( c, a_adult.Sernum );
      Ukds.Frs.Childcare_IO.Add_Benunit( c, a_adult.Benunit );
      Ukds.Frs.Childcare_IO.Add_Person( c, a_adult.Person );
      return Ukds.Frs.Childcare_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Childcares;


   function Retrieve_Associated_Ukds_Frs_Pensions( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Pension_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Pension_IO.Add_Year( c, a_adult.Year );
      Ukds.Frs.Pension_IO.Add_User_Id( c, a_adult.User_Id );
      Ukds.Frs.Pension_IO.Add_Edition( c, a_adult.Edition );
      Ukds.Frs.Pension_IO.Add_Sernum( c, a_adult.Sernum );
      Ukds.Frs.Pension_IO.Add_Benunit( c, a_adult.Benunit );
      Ukds.Frs.Pension_IO.Add_Person( c, a_adult.Person );
      return Ukds.Frs.Pension_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Pensions;


   function Retrieve_Associated_Ukds_Frs_Accouts( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Accouts_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Accouts_IO.Add_Year( c, a_adult.Year );
      Ukds.Frs.Accouts_IO.Add_User_Id( c, a_adult.User_Id );
      Ukds.Frs.Accouts_IO.Add_Edition( c, a_adult.Edition );
      Ukds.Frs.Accouts_IO.Add_Sernum( c, a_adult.Sernum );
      Ukds.Frs.Accouts_IO.Add_Benunit( c, a_adult.Benunit );
      Ukds.Frs.Accouts_IO.Add_Person( c, a_adult.Person );
      return Ukds.Frs.Accouts_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Accouts;


   function Retrieve_Associated_Ukds_Frs_Accounts( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Accounts_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Accounts_IO.Add_Year( c, a_adult.Year );
      Ukds.Frs.Accounts_IO.Add_User_Id( c, a_adult.User_Id );
      Ukds.Frs.Accounts_IO.Add_Edition( c, a_adult.Edition );
      Ukds.Frs.Accounts_IO.Add_Sernum( c, a_adult.Sernum );
      Ukds.Frs.Accounts_IO.Add_Benunit( c, a_adult.Benunit );
      Ukds.Frs.Accounts_IO.Add_Person( c, a_adult.Person );
      return Ukds.Frs.Accounts_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Accounts;


   function Retrieve_Associated_Ukds_Frs_Oddjobs( a_adult : Ukds.Frs.Adult; connection : Database_Connection := null ) return Ukds.Frs.Oddjob_List is
      c : d.Criteria;
   begin
      Ukds.Frs.Oddjob_IO.Add_Year( c, a_adult.Year );
      Ukds.Frs.Oddjob_IO.Add_User_Id( c, a_adult.User_Id );
      Ukds.Frs.Oddjob_IO.Add_Edition( c, a_adult.Edition );
      Ukds.Frs.Oddjob_IO.Add_Sernum( c, a_adult.Sernum );
      Ukds.Frs.Oddjob_IO.Add_Benunit( c, a_adult.Benunit );
      Ukds.Frs.Oddjob_IO.Add_Person( c, a_adult.Person );
      return Ukds.Frs.Oddjob_IO.retrieve( c, connection );
   end Retrieve_Associated_Ukds_Frs_Oddjobs;



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


   procedure Add_abs1no( c : in out d.Criteria; abs1no : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "abs1no", op, join, abs1no );
   begin
      d.add_to_criteria( c, elem );
   end Add_abs1no;


   procedure Add_abs2no( c : in out d.Criteria; abs2no : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "abs2no", op, join, abs2no );
   begin
      d.add_to_criteria( c, elem );
   end Add_abs2no;


   procedure Add_abspar( c : in out d.Criteria; abspar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "abspar", op, join, abspar );
   begin
      d.add_to_criteria( c, elem );
   end Add_abspar;


   procedure Add_abspay( c : in out d.Criteria; abspay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "abspay", op, join, abspay );
   begin
      d.add_to_criteria( c, elem );
   end Add_abspay;


   procedure Add_abswhy( c : in out d.Criteria; abswhy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "abswhy", op, join, abswhy );
   begin
      d.add_to_criteria( c, elem );
   end Add_abswhy;


   procedure Add_abswk( c : in out d.Criteria; abswk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "abswk", op, join, abswk );
   begin
      d.add_to_criteria( c, elem );
   end Add_abswk;


   procedure Add_x_access( c : in out d.Criteria; x_access : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "x_access", op, join, x_access );
   begin
      d.add_to_criteria( c, elem );
   end Add_x_access;


   procedure Add_accftpt( c : in out d.Criteria; accftpt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accftpt", op, join, accftpt );
   begin
      d.add_to_criteria( c, elem );
   end Add_accftpt;


   procedure Add_accjb( c : in out d.Criteria; accjb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accjb", op, join, accjb );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjb;


   procedure Add_accssamt( c : in out d.Criteria; accssamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accssamt", op, join, Long_Float( accssamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_accssamt;


   procedure Add_accsspd( c : in out d.Criteria; accsspd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accsspd", op, join, accsspd );
   begin
      d.add_to_criteria( c, elem );
   end Add_accsspd;


   procedure Add_adeduc( c : in out d.Criteria; adeduc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adeduc", op, join, adeduc );
   begin
      d.add_to_criteria( c, elem );
   end Add_adeduc;


   procedure Add_adema( c : in out d.Criteria; adema : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "adema", op, join, adema );
   begin
      d.add_to_criteria( c, elem );
   end Add_adema;


   procedure Add_ademaamt( c : in out d.Criteria; ademaamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ademaamt", op, join, Long_Float( ademaamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ademaamt;


   procedure Add_ademapd( c : in out d.Criteria; ademapd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ademapd", op, join, ademapd );
   begin
      d.add_to_criteria( c, elem );
   end Add_ademapd;


   procedure Add_age( c : in out d.Criteria; age : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age", op, join, age );
   begin
      d.add_to_criteria( c, elem );
   end Add_age;


   procedure Add_allow1( c : in out d.Criteria; allow1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "allow1", op, join, allow1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_allow1;


   procedure Add_allow2( c : in out d.Criteria; allow2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "allow2", op, join, allow2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_allow2;


   procedure Add_allow3( c : in out d.Criteria; allow3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "allow3", op, join, allow3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_allow3;


   procedure Add_allow4( c : in out d.Criteria; allow4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "allow4", op, join, allow4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_allow4;


   procedure Add_allpay1( c : in out d.Criteria; allpay1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "allpay1", op, join, Long_Float( allpay1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpay1;


   procedure Add_allpay2( c : in out d.Criteria; allpay2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "allpay2", op, join, Long_Float( allpay2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpay2;


   procedure Add_allpay3( c : in out d.Criteria; allpay3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "allpay3", op, join, Long_Float( allpay3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpay3;


   procedure Add_allpay4( c : in out d.Criteria; allpay4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "allpay4", op, join, Long_Float( allpay4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpay4;


   procedure Add_allpd1( c : in out d.Criteria; allpd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "allpd1", op, join, allpd1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpd1;


   procedure Add_allpd2( c : in out d.Criteria; allpd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "allpd2", op, join, allpd2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpd2;


   procedure Add_allpd3( c : in out d.Criteria; allpd3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "allpd3", op, join, allpd3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpd3;


   procedure Add_allpd4( c : in out d.Criteria; allpd4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "allpd4", op, join, allpd4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpd4;


   procedure Add_anyacc( c : in out d.Criteria; anyacc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "anyacc", op, join, anyacc );
   begin
      d.add_to_criteria( c, elem );
   end Add_anyacc;


   procedure Add_anyed( c : in out d.Criteria; anyed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "anyed", op, join, anyed );
   begin
      d.add_to_criteria( c, elem );
   end Add_anyed;


   procedure Add_anymon( c : in out d.Criteria; anymon : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "anymon", op, join, anymon );
   begin
      d.add_to_criteria( c, elem );
   end Add_anymon;


   procedure Add_anypen1( c : in out d.Criteria; anypen1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "anypen1", op, join, anypen1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen1;


   procedure Add_anypen2( c : in out d.Criteria; anypen2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "anypen2", op, join, anypen2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen2;


   procedure Add_anypen3( c : in out d.Criteria; anypen3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "anypen3", op, join, anypen3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen3;


   procedure Add_anypen4( c : in out d.Criteria; anypen4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "anypen4", op, join, anypen4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen4;


   procedure Add_anypen5( c : in out d.Criteria; anypen5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "anypen5", op, join, anypen5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen5;


   procedure Add_anypen6( c : in out d.Criteria; anypen6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "anypen6", op, join, anypen6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen6;


   procedure Add_anypen7( c : in out d.Criteria; anypen7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "anypen7", op, join, anypen7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen7;


   procedure Add_apamt( c : in out d.Criteria; apamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "apamt", op, join, Long_Float( apamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_apamt;


   procedure Add_apdamt( c : in out d.Criteria; apdamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "apdamt", op, join, Long_Float( apdamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_apdamt;


   procedure Add_apdir( c : in out d.Criteria; apdir : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "apdir", op, join, apdir );
   begin
      d.add_to_criteria( c, elem );
   end Add_apdir;


   procedure Add_apdpd( c : in out d.Criteria; apdpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "apdpd", op, join, apdpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_apdpd;


   procedure Add_appd( c : in out d.Criteria; appd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "appd", op, join, appd );
   begin
      d.add_to_criteria( c, elem );
   end Add_appd;


   procedure Add_b2qfut1( c : in out d.Criteria; b2qfut1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "b2qfut1", op, join, b2qfut1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_b2qfut1;


   procedure Add_b2qfut2( c : in out d.Criteria; b2qfut2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "b2qfut2", op, join, b2qfut2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_b2qfut2;


   procedure Add_b2qfut3( c : in out d.Criteria; b2qfut3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "b2qfut3", op, join, b2qfut3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_b2qfut3;


   procedure Add_b3qfut1( c : in out d.Criteria; b3qfut1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "b3qfut1", op, join, b3qfut1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut1;


   procedure Add_b3qfut2( c : in out d.Criteria; b3qfut2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "b3qfut2", op, join, b3qfut2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut2;


   procedure Add_b3qfut3( c : in out d.Criteria; b3qfut3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "b3qfut3", op, join, b3qfut3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut3;


   procedure Add_b3qfut4( c : in out d.Criteria; b3qfut4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "b3qfut4", op, join, b3qfut4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut4;


   procedure Add_b3qfut5( c : in out d.Criteria; b3qfut5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "b3qfut5", op, join, b3qfut5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut5;


   procedure Add_b3qfut6( c : in out d.Criteria; b3qfut6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "b3qfut6", op, join, b3qfut6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut6;


   procedure Add_ben1q1( c : in out d.Criteria; ben1q1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben1q1", op, join, ben1q1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q1;


   procedure Add_ben1q2( c : in out d.Criteria; ben1q2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben1q2", op, join, ben1q2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q2;


   procedure Add_ben1q3( c : in out d.Criteria; ben1q3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben1q3", op, join, ben1q3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q3;


   procedure Add_ben1q4( c : in out d.Criteria; ben1q4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben1q4", op, join, ben1q4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q4;


   procedure Add_ben1q5( c : in out d.Criteria; ben1q5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben1q5", op, join, ben1q5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q5;


   procedure Add_ben1q6( c : in out d.Criteria; ben1q6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben1q6", op, join, ben1q6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q6;


   procedure Add_ben1q7( c : in out d.Criteria; ben1q7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben1q7", op, join, ben1q7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q7;


   procedure Add_ben2q1( c : in out d.Criteria; ben2q1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben2q1", op, join, ben2q1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben2q1;


   procedure Add_ben2q2( c : in out d.Criteria; ben2q2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben2q2", op, join, ben2q2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben2q2;


   procedure Add_ben2q3( c : in out d.Criteria; ben2q3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben2q3", op, join, ben2q3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben2q3;


   procedure Add_ben3q1( c : in out d.Criteria; ben3q1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben3q1", op, join, ben3q1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q1;


   procedure Add_ben3q2( c : in out d.Criteria; ben3q2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben3q2", op, join, ben3q2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q2;


   procedure Add_ben3q3( c : in out d.Criteria; ben3q3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben3q3", op, join, ben3q3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q3;


   procedure Add_ben3q4( c : in out d.Criteria; ben3q4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben3q4", op, join, ben3q4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q4;


   procedure Add_ben3q5( c : in out d.Criteria; ben3q5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben3q5", op, join, ben3q5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q5;


   procedure Add_ben3q6( c : in out d.Criteria; ben3q6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben3q6", op, join, ben3q6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q6;


   procedure Add_ben4q1( c : in out d.Criteria; ben4q1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben4q1", op, join, ben4q1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben4q1;


   procedure Add_ben4q2( c : in out d.Criteria; ben4q2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben4q2", op, join, ben4q2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben4q2;


   procedure Add_ben4q3( c : in out d.Criteria; ben4q3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben4q3", op, join, ben4q3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben4q3;


   procedure Add_ben5q1( c : in out d.Criteria; ben5q1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben5q1", op, join, ben5q1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q1;


   procedure Add_ben5q2( c : in out d.Criteria; ben5q2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben5q2", op, join, ben5q2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q2;


   procedure Add_ben5q3( c : in out d.Criteria; ben5q3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben5q3", op, join, ben5q3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q3;


   procedure Add_ben5q4( c : in out d.Criteria; ben5q4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben5q4", op, join, ben5q4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q4;


   procedure Add_ben5q5( c : in out d.Criteria; ben5q5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben5q5", op, join, ben5q5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q5;


   procedure Add_ben5q6( c : in out d.Criteria; ben5q6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben5q6", op, join, ben5q6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q6;


   procedure Add_ben7q1( c : in out d.Criteria; ben7q1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben7q1", op, join, ben7q1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q1;


   procedure Add_ben7q2( c : in out d.Criteria; ben7q2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben7q2", op, join, ben7q2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q2;


   procedure Add_ben7q3( c : in out d.Criteria; ben7q3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben7q3", op, join, ben7q3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q3;


   procedure Add_ben7q4( c : in out d.Criteria; ben7q4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben7q4", op, join, ben7q4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q4;


   procedure Add_ben7q5( c : in out d.Criteria; ben7q5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben7q5", op, join, ben7q5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q5;


   procedure Add_ben7q6( c : in out d.Criteria; ben7q6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben7q6", op, join, ben7q6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q6;


   procedure Add_ben7q7( c : in out d.Criteria; ben7q7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben7q7", op, join, ben7q7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q7;


   procedure Add_ben7q8( c : in out d.Criteria; ben7q8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben7q8", op, join, ben7q8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q8;


   procedure Add_ben7q9( c : in out d.Criteria; ben7q9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben7q9", op, join, ben7q9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q9;


   procedure Add_btwacc( c : in out d.Criteria; btwacc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "btwacc", op, join, btwacc );
   begin
      d.add_to_criteria( c, elem );
   end Add_btwacc;


   procedure Add_claimant( c : in out d.Criteria; claimant : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "claimant", op, join, claimant );
   begin
      d.add_to_criteria( c, elem );
   end Add_claimant;


   procedure Add_cohabit( c : in out d.Criteria; cohabit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cohabit", op, join, cohabit );
   begin
      d.add_to_criteria( c, elem );
   end Add_cohabit;


   procedure Add_combid( c : in out d.Criteria; combid : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "combid", op, join, combid );
   begin
      d.add_to_criteria( c, elem );
   end Add_combid;


   procedure Add_convbl( c : in out d.Criteria; convbl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "convbl", op, join, convbl );
   begin
      d.add_to_criteria( c, elem );
   end Add_convbl;


   procedure Add_ctclum1( c : in out d.Criteria; ctclum1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctclum1", op, join, ctclum1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctclum1;


   procedure Add_ctclum2( c : in out d.Criteria; ctclum2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ctclum2", op, join, ctclum2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctclum2;


   procedure Add_cupchk( c : in out d.Criteria; cupchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cupchk", op, join, cupchk );
   begin
      d.add_to_criteria( c, elem );
   end Add_cupchk;


   procedure Add_cvht( c : in out d.Criteria; cvht : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cvht", op, join, cvht );
   begin
      d.add_to_criteria( c, elem );
   end Add_cvht;


   procedure Add_cvpay( c : in out d.Criteria; cvpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cvpay", op, join, Long_Float( cvpay ) );
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


   procedure Add_disdif1( c : in out d.Criteria; disdif1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdif1", op, join, disdif1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif1;


   procedure Add_disdif2( c : in out d.Criteria; disdif2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdif2", op, join, disdif2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif2;


   procedure Add_disdif3( c : in out d.Criteria; disdif3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdif3", op, join, disdif3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif3;


   procedure Add_disdif4( c : in out d.Criteria; disdif4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdif4", op, join, disdif4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif4;


   procedure Add_disdif5( c : in out d.Criteria; disdif5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdif5", op, join, disdif5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif5;


   procedure Add_disdif6( c : in out d.Criteria; disdif6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdif6", op, join, disdif6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif6;


   procedure Add_disdif7( c : in out d.Criteria; disdif7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdif7", op, join, disdif7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif7;


   procedure Add_disdif8( c : in out d.Criteria; disdif8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdif8", op, join, disdif8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif8;


   procedure Add_dob( c : in out d.Criteria; dob : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dob", op, join, Ada.Calendar.Time( dob ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_dob;


   procedure Add_dptcboth( c : in out d.Criteria; dptcboth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dptcboth", op, join, dptcboth );
   begin
      d.add_to_criteria( c, elem );
   end Add_dptcboth;


   procedure Add_dptclum( c : in out d.Criteria; dptclum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dptclum", op, join, dptclum );
   begin
      d.add_to_criteria( c, elem );
   end Add_dptclum;


   procedure Add_dvil03a( c : in out d.Criteria; dvil03a : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dvil03a", op, join, dvil03a );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvil03a;


   procedure Add_dvil04a( c : in out d.Criteria; dvil04a : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dvil04a", op, join, dvil04a );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvil04a;


   procedure Add_dvjb12ml( c : in out d.Criteria; dvjb12ml : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dvjb12ml", op, join, dvjb12ml );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvjb12ml;


   procedure Add_dvmardf( c : in out d.Criteria; dvmardf : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dvmardf", op, join, dvmardf );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvmardf;


   procedure Add_ed1amt( c : in out d.Criteria; ed1amt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ed1amt", op, join, Long_Float( ed1amt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed1amt;


   procedure Add_ed1borr( c : in out d.Criteria; ed1borr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ed1borr", op, join, ed1borr );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed1borr;


   procedure Add_ed1int( c : in out d.Criteria; ed1int : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ed1int", op, join, ed1int );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed1int;


   procedure Add_ed1monyr( c : in out d.Criteria; ed1monyr : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ed1monyr", op, join, Ada.Calendar.Time( ed1monyr ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed1monyr;


   procedure Add_ed1pd( c : in out d.Criteria; ed1pd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ed1pd", op, join, ed1pd );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed1pd;


   procedure Add_ed1sum( c : in out d.Criteria; ed1sum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ed1sum", op, join, ed1sum );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed1sum;


   procedure Add_ed2amt( c : in out d.Criteria; ed2amt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ed2amt", op, join, Long_Float( ed2amt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed2amt;


   procedure Add_ed2borr( c : in out d.Criteria; ed2borr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ed2borr", op, join, ed2borr );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed2borr;


   procedure Add_ed2int( c : in out d.Criteria; ed2int : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ed2int", op, join, ed2int );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed2int;


   procedure Add_ed2monyr( c : in out d.Criteria; ed2monyr : Ada.Calendar.Time; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ed2monyr", op, join, Ada.Calendar.Time( ed2monyr ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed2monyr;


   procedure Add_ed2pd( c : in out d.Criteria; ed2pd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ed2pd", op, join, ed2pd );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed2pd;


   procedure Add_ed2sum( c : in out d.Criteria; ed2sum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ed2sum", op, join, ed2sum );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed2sum;


   procedure Add_edatt( c : in out d.Criteria; edatt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "edatt", op, join, edatt );
   begin
      d.add_to_criteria( c, elem );
   end Add_edatt;


   procedure Add_edattn1( c : in out d.Criteria; edattn1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "edattn1", op, join, edattn1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_edattn1;


   procedure Add_edattn2( c : in out d.Criteria; edattn2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "edattn2", op, join, edattn2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_edattn2;


   procedure Add_edattn3( c : in out d.Criteria; edattn3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "edattn3", op, join, edattn3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_edattn3;


   procedure Add_edhr( c : in out d.Criteria; edhr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "edhr", op, join, edhr );
   begin
      d.add_to_criteria( c, elem );
   end Add_edhr;


   procedure Add_edtime( c : in out d.Criteria; edtime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "edtime", op, join, edtime );
   begin
      d.add_to_criteria( c, elem );
   end Add_edtime;


   procedure Add_edtyp( c : in out d.Criteria; edtyp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "edtyp", op, join, edtyp );
   begin
      d.add_to_criteria( c, elem );
   end Add_edtyp;


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


   procedure Add_emppay1( c : in out d.Criteria; emppay1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "emppay1", op, join, emppay1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_emppay1;


   procedure Add_emppay2( c : in out d.Criteria; emppay2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "emppay2", op, join, emppay2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_emppay2;


   procedure Add_emppay3( c : in out d.Criteria; emppay3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "emppay3", op, join, emppay3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_emppay3;


   procedure Add_empstat( c : in out d.Criteria; empstat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "empstat", op, join, empstat );
   begin
      d.add_to_criteria( c, elem );
   end Add_empstat;


   procedure Add_endyr( c : in out d.Criteria; endyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "endyr", op, join, endyr );
   begin
      d.add_to_criteria( c, elem );
   end Add_endyr;


   procedure Add_epcur( c : in out d.Criteria; epcur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "epcur", op, join, epcur );
   begin
      d.add_to_criteria( c, elem );
   end Add_epcur;


   procedure Add_es2000( c : in out d.Criteria; es2000 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "es2000", op, join, es2000 );
   begin
      d.add_to_criteria( c, elem );
   end Add_es2000;


   procedure Add_ethgrp( c : in out d.Criteria; ethgrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ethgrp", op, join, ethgrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_ethgrp;


   procedure Add_everwrk( c : in out d.Criteria; everwrk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "everwrk", op, join, everwrk );
   begin
      d.add_to_criteria( c, elem );
   end Add_everwrk;


   procedure Add_exthbct1( c : in out d.Criteria; exthbct1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "exthbct1", op, join, exthbct1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_exthbct1;


   procedure Add_exthbct2( c : in out d.Criteria; exthbct2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "exthbct2", op, join, exthbct2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_exthbct2;


   procedure Add_exthbct3( c : in out d.Criteria; exthbct3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "exthbct3", op, join, exthbct3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_exthbct3;


   procedure Add_eyetest( c : in out d.Criteria; eyetest : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eyetest", op, join, eyetest );
   begin
      d.add_to_criteria( c, elem );
   end Add_eyetest;


   procedure Add_follow( c : in out d.Criteria; follow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "follow", op, join, follow );
   begin
      d.add_to_criteria( c, elem );
   end Add_follow;


   procedure Add_fted( c : in out d.Criteria; fted : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fted", op, join, fted );
   begin
      d.add_to_criteria( c, elem );
   end Add_fted;


   procedure Add_ftwk( c : in out d.Criteria; ftwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ftwk", op, join, ftwk );
   begin
      d.add_to_criteria( c, elem );
   end Add_ftwk;


   procedure Add_future( c : in out d.Criteria; future : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "future", op, join, future );
   begin
      d.add_to_criteria( c, elem );
   end Add_future;


   procedure Add_govpis( c : in out d.Criteria; govpis : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "govpis", op, join, govpis );
   begin
      d.add_to_criteria( c, elem );
   end Add_govpis;


   procedure Add_govpjsa( c : in out d.Criteria; govpjsa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "govpjsa", op, join, govpjsa );
   begin
      d.add_to_criteria( c, elem );
   end Add_govpjsa;


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


   procedure Add_gta( c : in out d.Criteria; gta : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gta", op, join, gta );
   begin
      d.add_to_criteria( c, elem );
   end Add_gta;


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


   procedure Add_hbotwait( c : in out d.Criteria; hbotwait : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbotwait", op, join, hbotwait );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbotwait;


   procedure Add_health( c : in out d.Criteria; health : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "health", op, join, health );
   begin
      d.add_to_criteria( c, elem );
   end Add_health;


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


   procedure Add_hprob( c : in out d.Criteria; hprob : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hprob", op, join, hprob );
   begin
      d.add_to_criteria( c, elem );
   end Add_hprob;


   procedure Add_hrpid( c : in out d.Criteria; hrpid : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hrpid", op, join, hrpid );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrpid;


   procedure Add_incdur( c : in out d.Criteria; incdur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incdur", op, join, incdur );
   begin
      d.add_to_criteria( c, elem );
   end Add_incdur;


   procedure Add_injlong( c : in out d.Criteria; injlong : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "injlong", op, join, injlong );
   begin
      d.add_to_criteria( c, elem );
   end Add_injlong;


   procedure Add_injwk( c : in out d.Criteria; injwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "injwk", op, join, injwk );
   begin
      d.add_to_criteria( c, elem );
   end Add_injwk;


   procedure Add_invests( c : in out d.Criteria; invests : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "invests", op, join, invests );
   begin
      d.add_to_criteria( c, elem );
   end Add_invests;


   procedure Add_iout( c : in out d.Criteria; iout : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iout", op, join, iout );
   begin
      d.add_to_criteria( c, elem );
   end Add_iout;


   procedure Add_isa1type( c : in out d.Criteria; isa1type : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "isa1type", op, join, isa1type );
   begin
      d.add_to_criteria( c, elem );
   end Add_isa1type;


   procedure Add_isa2type( c : in out d.Criteria; isa2type : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "isa2type", op, join, isa2type );
   begin
      d.add_to_criteria( c, elem );
   end Add_isa2type;


   procedure Add_isa3type( c : in out d.Criteria; isa3type : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "isa3type", op, join, isa3type );
   begin
      d.add_to_criteria( c, elem );
   end Add_isa3type;


   procedure Add_jobaway( c : in out d.Criteria; jobaway : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "jobaway", op, join, jobaway );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobaway;


   procedure Add_lareg( c : in out d.Criteria; lareg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lareg", op, join, lareg );
   begin
      d.add_to_criteria( c, elem );
   end Add_lareg;


   procedure Add_likewk( c : in out d.Criteria; likewk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "likewk", op, join, likewk );
   begin
      d.add_to_criteria( c, elem );
   end Add_likewk;


   procedure Add_lktime( c : in out d.Criteria; lktime : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lktime", op, join, lktime );
   begin
      d.add_to_criteria( c, elem );
   end Add_lktime;


   procedure Add_ln1rpint( c : in out d.Criteria; ln1rpint : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ln1rpint", op, join, ln1rpint );
   begin
      d.add_to_criteria( c, elem );
   end Add_ln1rpint;


   procedure Add_ln2rpint( c : in out d.Criteria; ln2rpint : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ln2rpint", op, join, ln2rpint );
   begin
      d.add_to_criteria( c, elem );
   end Add_ln2rpint;


   procedure Add_loan( c : in out d.Criteria; loan : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "loan", op, join, loan );
   begin
      d.add_to_criteria( c, elem );
   end Add_loan;


   procedure Add_loannum( c : in out d.Criteria; loannum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "loannum", op, join, loannum );
   begin
      d.add_to_criteria( c, elem );
   end Add_loannum;


   procedure Add_look( c : in out d.Criteria; look : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "look", op, join, look );
   begin
      d.add_to_criteria( c, elem );
   end Add_look;


   procedure Add_lookwk( c : in out d.Criteria; lookwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lookwk", op, join, lookwk );
   begin
      d.add_to_criteria( c, elem );
   end Add_lookwk;


   procedure Add_lstwrk1( c : in out d.Criteria; lstwrk1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lstwrk1", op, join, lstwrk1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lstwrk1;


   procedure Add_lstwrk2( c : in out d.Criteria; lstwrk2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lstwrk2", op, join, lstwrk2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lstwrk2;


   procedure Add_lstyr( c : in out d.Criteria; lstyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lstyr", op, join, lstyr );
   begin
      d.add_to_criteria( c, elem );
   end Add_lstyr;


   procedure Add_mntamt1( c : in out d.Criteria; mntamt1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntamt1", op, join, Long_Float( mntamt1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntamt1;


   procedure Add_mntamt2( c : in out d.Criteria; mntamt2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntamt2", op, join, Long_Float( mntamt2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntamt2;


   procedure Add_mntct( c : in out d.Criteria; mntct : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntct", op, join, mntct );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntct;


   procedure Add_mntfor1( c : in out d.Criteria; mntfor1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntfor1", op, join, mntfor1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntfor1;


   procedure Add_mntfor2( c : in out d.Criteria; mntfor2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntfor2", op, join, mntfor2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntfor2;


   procedure Add_mntgov1( c : in out d.Criteria; mntgov1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntgov1", op, join, mntgov1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntgov1;


   procedure Add_mntgov2( c : in out d.Criteria; mntgov2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntgov2", op, join, mntgov2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntgov2;


   procedure Add_mntpay( c : in out d.Criteria; mntpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntpay", op, join, mntpay );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntpay;


   procedure Add_mntpd1( c : in out d.Criteria; mntpd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntpd1", op, join, mntpd1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntpd1;


   procedure Add_mntpd2( c : in out d.Criteria; mntpd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntpd2", op, join, mntpd2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntpd2;


   procedure Add_mntrec( c : in out d.Criteria; mntrec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntrec", op, join, mntrec );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntrec;


   procedure Add_mnttota1( c : in out d.Criteria; mnttota1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mnttota1", op, join, mnttota1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mnttota1;


   procedure Add_mnttota2( c : in out d.Criteria; mnttota2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mnttota2", op, join, mnttota2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mnttota2;


   procedure Add_mntus1( c : in out d.Criteria; mntus1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntus1", op, join, mntus1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntus1;


   procedure Add_mntus2( c : in out d.Criteria; mntus2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntus2", op, join, mntus2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntus2;


   procedure Add_mntusam1( c : in out d.Criteria; mntusam1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntusam1", op, join, Long_Float( mntusam1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntusam1;


   procedure Add_mntusam2( c : in out d.Criteria; mntusam2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntusam2", op, join, Long_Float( mntusam2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntusam2;


   procedure Add_mntuspd1( c : in out d.Criteria; mntuspd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntuspd1", op, join, mntuspd1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntuspd1;


   procedure Add_mntuspd2( c : in out d.Criteria; mntuspd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntuspd2", op, join, mntuspd2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntuspd2;


   procedure Add_ms( c : in out d.Criteria; ms : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ms", op, join, ms );
   begin
      d.add_to_criteria( c, elem );
   end Add_ms;


   procedure Add_natid1( c : in out d.Criteria; natid1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "natid1", op, join, natid1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_natid1;


   procedure Add_natid2( c : in out d.Criteria; natid2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "natid2", op, join, natid2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_natid2;


   procedure Add_natid3( c : in out d.Criteria; natid3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "natid3", op, join, natid3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_natid3;


   procedure Add_natid4( c : in out d.Criteria; natid4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "natid4", op, join, natid4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_natid4;


   procedure Add_natid5( c : in out d.Criteria; natid5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "natid5", op, join, natid5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_natid5;


   procedure Add_natid6( c : in out d.Criteria; natid6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "natid6", op, join, natid6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_natid6;


   procedure Add_ndeal( c : in out d.Criteria; ndeal : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ndeal", op, join, ndeal );
   begin
      d.add_to_criteria( c, elem );
   end Add_ndeal;


   procedure Add_newdtype( c : in out d.Criteria; newdtype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "newdtype", op, join, newdtype );
   begin
      d.add_to_criteria( c, elem );
   end Add_newdtype;


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


   procedure Add_niamt( c : in out d.Criteria; niamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "niamt", op, join, Long_Float( niamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_niamt;


   procedure Add_niethgrp( c : in out d.Criteria; niethgrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "niethgrp", op, join, niethgrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_niethgrp;


   procedure Add_niexthbb( c : in out d.Criteria; niexthbb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "niexthbb", op, join, niexthbb );
   begin
      d.add_to_criteria( c, elem );
   end Add_niexthbb;


   procedure Add_ninatid1( c : in out d.Criteria; ninatid1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninatid1", op, join, ninatid1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid1;


   procedure Add_ninatid2( c : in out d.Criteria; ninatid2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninatid2", op, join, ninatid2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid2;


   procedure Add_ninatid3( c : in out d.Criteria; ninatid3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninatid3", op, join, ninatid3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid3;


   procedure Add_ninatid4( c : in out d.Criteria; ninatid4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninatid4", op, join, ninatid4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid4;


   procedure Add_ninatid5( c : in out d.Criteria; ninatid5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninatid5", op, join, ninatid5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid5;


   procedure Add_ninatid6( c : in out d.Criteria; ninatid6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninatid6", op, join, ninatid6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid6;


   procedure Add_ninatid7( c : in out d.Criteria; ninatid7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninatid7", op, join, ninatid7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid7;


   procedure Add_ninatid8( c : in out d.Criteria; ninatid8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninatid8", op, join, ninatid8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid8;


   procedure Add_nipd( c : in out d.Criteria; nipd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nipd", op, join, nipd );
   begin
      d.add_to_criteria( c, elem );
   end Add_nipd;


   procedure Add_nireg( c : in out d.Criteria; nireg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nireg", op, join, nireg );
   begin
      d.add_to_criteria( c, elem );
   end Add_nireg;


   procedure Add_nirel( c : in out d.Criteria; nirel : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nirel", op, join, nirel );
   begin
      d.add_to_criteria( c, elem );
   end Add_nirel;


   procedure Add_nitrain( c : in out d.Criteria; nitrain : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nitrain", op, join, nitrain );
   begin
      d.add_to_criteria( c, elem );
   end Add_nitrain;


   procedure Add_nlper( c : in out d.Criteria; nlper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nlper", op, join, nlper );
   begin
      d.add_to_criteria( c, elem );
   end Add_nlper;


   procedure Add_nolk1( c : in out d.Criteria; nolk1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nolk1", op, join, nolk1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nolk1;


   procedure Add_nolk2( c : in out d.Criteria; nolk2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nolk2", op, join, nolk2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nolk2;


   procedure Add_nolk3( c : in out d.Criteria; nolk3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nolk3", op, join, nolk3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nolk3;


   procedure Add_nolook( c : in out d.Criteria; nolook : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nolook", op, join, nolook );
   begin
      d.add_to_criteria( c, elem );
   end Add_nolook;


   procedure Add_nowant( c : in out d.Criteria; nowant : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nowant", op, join, nowant );
   begin
      d.add_to_criteria( c, elem );
   end Add_nowant;


   procedure Add_nssec( c : in out d.Criteria; nssec : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nssec", op, join, Long_Float( nssec ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_nssec;


   procedure Add_ntcapp( c : in out d.Criteria; ntcapp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ntcapp", op, join, ntcapp );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcapp;


   procedure Add_ntcdat( c : in out d.Criteria; ntcdat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ntcdat", op, join, ntcdat );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcdat;


   procedure Add_ntcinc( c : in out d.Criteria; ntcinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ntcinc", op, join, Long_Float( ntcinc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcinc;


   procedure Add_ntcorig1( c : in out d.Criteria; ntcorig1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ntcorig1", op, join, ntcorig1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcorig1;


   procedure Add_ntcorig2( c : in out d.Criteria; ntcorig2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ntcorig2", op, join, ntcorig2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcorig2;


   procedure Add_ntcorig3( c : in out d.Criteria; ntcorig3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ntcorig3", op, join, ntcorig3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcorig3;


   procedure Add_ntcorig4( c : in out d.Criteria; ntcorig4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ntcorig4", op, join, ntcorig4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcorig4;


   procedure Add_ntcorig5( c : in out d.Criteria; ntcorig5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ntcorig5", op, join, ntcorig5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcorig5;


   procedure Add_numjob( c : in out d.Criteria; numjob : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numjob", op, join, numjob );
   begin
      d.add_to_criteria( c, elem );
   end Add_numjob;


   procedure Add_numjob2( c : in out d.Criteria; numjob2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "numjob2", op, join, numjob2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_numjob2;


   procedure Add_oddjob( c : in out d.Criteria; oddjob : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oddjob", op, join, oddjob );
   begin
      d.add_to_criteria( c, elem );
   end Add_oddjob;


   procedure Add_oldstud( c : in out d.Criteria; oldstud : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oldstud", op, join, oldstud );
   begin
      d.add_to_criteria( c, elem );
   end Add_oldstud;


   procedure Add_otabspar( c : in out d.Criteria; otabspar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "otabspar", op, join, otabspar );
   begin
      d.add_to_criteria( c, elem );
   end Add_otabspar;


   procedure Add_otamt( c : in out d.Criteria; otamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "otamt", op, join, Long_Float( otamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_otamt;


   procedure Add_otapamt( c : in out d.Criteria; otapamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "otapamt", op, join, Long_Float( otapamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_otapamt;


   procedure Add_otappd( c : in out d.Criteria; otappd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "otappd", op, join, otappd );
   begin
      d.add_to_criteria( c, elem );
   end Add_otappd;


   procedure Add_othtax( c : in out d.Criteria; othtax : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othtax", op, join, othtax );
   begin
      d.add_to_criteria( c, elem );
   end Add_othtax;


   procedure Add_otinva( c : in out d.Criteria; otinva : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "otinva", op, join, otinva );
   begin
      d.add_to_criteria( c, elem );
   end Add_otinva;


   procedure Add_pareamt( c : in out d.Criteria; pareamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pareamt", op, join, Long_Float( pareamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_pareamt;


   procedure Add_parepd( c : in out d.Criteria; parepd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "parepd", op, join, parepd );
   begin
      d.add_to_criteria( c, elem );
   end Add_parepd;


   procedure Add_penlump( c : in out d.Criteria; penlump : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penlump", op, join, penlump );
   begin
      d.add_to_criteria( c, elem );
   end Add_penlump;


   procedure Add_ppnumc( c : in out d.Criteria; ppnumc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ppnumc", op, join, ppnumc );
   begin
      d.add_to_criteria( c, elem );
   end Add_ppnumc;


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


   procedure Add_ptwk( c : in out d.Criteria; ptwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ptwk", op, join, ptwk );
   begin
      d.add_to_criteria( c, elem );
   end Add_ptwk;


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


   procedure Add_redamt( c : in out d.Criteria; redamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "redamt", op, join, Long_Float( redamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_redamt;


   procedure Add_redany( c : in out d.Criteria; redany : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "redany", op, join, redany );
   begin
      d.add_to_criteria( c, elem );
   end Add_redany;


   procedure Add_rentprof( c : in out d.Criteria; rentprof : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rentprof", op, join, rentprof );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentprof;


   procedure Add_retire( c : in out d.Criteria; retire : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "retire", op, join, retire );
   begin
      d.add_to_criteria( c, elem );
   end Add_retire;


   procedure Add_retire1( c : in out d.Criteria; retire1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "retire1", op, join, retire1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_retire1;


   procedure Add_retreas( c : in out d.Criteria; retreas : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "retreas", op, join, retreas );
   begin
      d.add_to_criteria( c, elem );
   end Add_retreas;


   procedure Add_royal1( c : in out d.Criteria; royal1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "royal1", op, join, royal1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_royal1;


   procedure Add_royal2( c : in out d.Criteria; royal2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "royal2", op, join, royal2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_royal2;


   procedure Add_royal3( c : in out d.Criteria; royal3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "royal3", op, join, royal3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_royal3;


   procedure Add_royal4( c : in out d.Criteria; royal4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "royal4", op, join, royal4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_royal4;


   procedure Add_royyr1( c : in out d.Criteria; royyr1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "royyr1", op, join, Long_Float( royyr1 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_royyr1;


   procedure Add_royyr2( c : in out d.Criteria; royyr2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "royyr2", op, join, Long_Float( royyr2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_royyr2;


   procedure Add_royyr3( c : in out d.Criteria; royyr3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "royyr3", op, join, Long_Float( royyr3 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_royyr3;


   procedure Add_royyr4( c : in out d.Criteria; royyr4 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "royyr4", op, join, Long_Float( royyr4 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_royyr4;


   procedure Add_rstrct( c : in out d.Criteria; rstrct : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rstrct", op, join, rstrct );
   begin
      d.add_to_criteria( c, elem );
   end Add_rstrct;


   procedure Add_sex( c : in out d.Criteria; sex : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sex", op, join, sex );
   begin
      d.add_to_criteria( c, elem );
   end Add_sex;


   procedure Add_sflntyp1( c : in out d.Criteria; sflntyp1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sflntyp1", op, join, sflntyp1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sflntyp1;


   procedure Add_sflntyp2( c : in out d.Criteria; sflntyp2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sflntyp2", op, join, sflntyp2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sflntyp2;


   procedure Add_sftype1( c : in out d.Criteria; sftype1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sftype1", op, join, sftype1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sftype1;


   procedure Add_sftype2( c : in out d.Criteria; sftype2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sftype2", op, join, sftype2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sftype2;


   procedure Add_sic( c : in out d.Criteria; sic : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sic", op, join, sic );
   begin
      d.add_to_criteria( c, elem );
   end Add_sic;


   procedure Add_slrepamt( c : in out d.Criteria; slrepamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "slrepamt", op, join, Long_Float( slrepamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_slrepamt;


   procedure Add_slrepay( c : in out d.Criteria; slrepay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "slrepay", op, join, slrepay );
   begin
      d.add_to_criteria( c, elem );
   end Add_slrepay;


   procedure Add_slreppd( c : in out d.Criteria; slreppd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "slreppd", op, join, slreppd );
   begin
      d.add_to_criteria( c, elem );
   end Add_slreppd;


   procedure Add_soc2000( c : in out d.Criteria; soc2000 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "soc2000", op, join, soc2000 );
   begin
      d.add_to_criteria( c, elem );
   end Add_soc2000;


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


   procedure Add_srentamt( c : in out d.Criteria; srentamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "srentamt", op, join, Long_Float( srentamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_srentamt;


   procedure Add_srentpd( c : in out d.Criteria; srentpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "srentpd", op, join, srentpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_srentpd;


   procedure Add_start( c : in out d.Criteria; start : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "start", op, join, start );
   begin
      d.add_to_criteria( c, elem );
   end Add_start;


   procedure Add_startyr( c : in out d.Criteria; startyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "startyr", op, join, startyr );
   begin
      d.add_to_criteria( c, elem );
   end Add_startyr;


   procedure Add_taxcred1( c : in out d.Criteria; taxcred1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxcred1", op, join, taxcred1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxcred1;


   procedure Add_taxcred2( c : in out d.Criteria; taxcred2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxcred2", op, join, taxcred2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxcred2;


   procedure Add_taxcred3( c : in out d.Criteria; taxcred3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxcred3", op, join, taxcred3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxcred3;


   procedure Add_taxcred4( c : in out d.Criteria; taxcred4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxcred4", op, join, taxcred4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxcred4;


   procedure Add_taxcred5( c : in out d.Criteria; taxcred5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxcred5", op, join, taxcred5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxcred5;


   procedure Add_taxfut( c : in out d.Criteria; taxfut : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxfut", op, join, taxfut );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxfut;


   procedure Add_tdaywrk( c : in out d.Criteria; tdaywrk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tdaywrk", op, join, tdaywrk );
   begin
      d.add_to_criteria( c, elem );
   end Add_tdaywrk;


   procedure Add_tea( c : in out d.Criteria; tea : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tea", op, join, tea );
   begin
      d.add_to_criteria( c, elem );
   end Add_tea;


   procedure Add_topupl( c : in out d.Criteria; topupl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "topupl", op, join, topupl );
   begin
      d.add_to_criteria( c, elem );
   end Add_topupl;


   procedure Add_totint( c : in out d.Criteria; totint : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totint", op, join, Long_Float( totint ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_totint;


   procedure Add_train( c : in out d.Criteria; train : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "train", op, join, train );
   begin
      d.add_to_criteria( c, elem );
   end Add_train;


   procedure Add_trav( c : in out d.Criteria; trav : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "trav", op, join, trav );
   begin
      d.add_to_criteria( c, elem );
   end Add_trav;


   procedure Add_tuborr( c : in out d.Criteria; tuborr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tuborr", op, join, tuborr );
   begin
      d.add_to_criteria( c, elem );
   end Add_tuborr;


   procedure Add_typeed( c : in out d.Criteria; typeed : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "typeed", op, join, typeed );
   begin
      d.add_to_criteria( c, elem );
   end Add_typeed;


   procedure Add_unpaid1( c : in out d.Criteria; unpaid1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "unpaid1", op, join, unpaid1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_unpaid1;


   procedure Add_unpaid2( c : in out d.Criteria; unpaid2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "unpaid2", op, join, unpaid2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_unpaid2;


   procedure Add_voucher( c : in out d.Criteria; voucher : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "voucher", op, join, voucher );
   begin
      d.add_to_criteria( c, elem );
   end Add_voucher;


   procedure Add_w1( c : in out d.Criteria; w1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "w1", op, join, w1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_w1;


   procedure Add_w2( c : in out d.Criteria; w2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "w2", op, join, w2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_w2;


   procedure Add_wait( c : in out d.Criteria; wait : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wait", op, join, wait );
   begin
      d.add_to_criteria( c, elem );
   end Add_wait;


   procedure Add_war1( c : in out d.Criteria; war1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "war1", op, join, war1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_war1;


   procedure Add_war2( c : in out d.Criteria; war2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "war2", op, join, war2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_war2;


   procedure Add_wftcboth( c : in out d.Criteria; wftcboth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wftcboth", op, join, wftcboth );
   begin
      d.add_to_criteria( c, elem );
   end Add_wftcboth;


   procedure Add_wftclum( c : in out d.Criteria; wftclum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wftclum", op, join, wftclum );
   begin
      d.add_to_criteria( c, elem );
   end Add_wftclum;


   procedure Add_whoresp( c : in out d.Criteria; whoresp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whoresp", op, join, whoresp );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoresp;


   procedure Add_whosectb( c : in out d.Criteria; whosectb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whosectb", op, join, whosectb );
   begin
      d.add_to_criteria( c, elem );
   end Add_whosectb;


   procedure Add_whyfrde1( c : in out d.Criteria; whyfrde1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrde1", op, join, whyfrde1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrde1;


   procedure Add_whyfrde2( c : in out d.Criteria; whyfrde2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrde2", op, join, whyfrde2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrde2;


   procedure Add_whyfrde3( c : in out d.Criteria; whyfrde3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrde3", op, join, whyfrde3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrde3;


   procedure Add_whyfrde4( c : in out d.Criteria; whyfrde4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrde4", op, join, whyfrde4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrde4;


   procedure Add_whyfrde5( c : in out d.Criteria; whyfrde5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrde5", op, join, whyfrde5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrde5;


   procedure Add_whyfrde6( c : in out d.Criteria; whyfrde6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrde6", op, join, whyfrde6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrde6;


   procedure Add_whyfrey1( c : in out d.Criteria; whyfrey1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrey1", op, join, whyfrey1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrey1;


   procedure Add_whyfrey2( c : in out d.Criteria; whyfrey2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrey2", op, join, whyfrey2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrey2;


   procedure Add_whyfrey3( c : in out d.Criteria; whyfrey3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrey3", op, join, whyfrey3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrey3;


   procedure Add_whyfrey4( c : in out d.Criteria; whyfrey4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrey4", op, join, whyfrey4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrey4;


   procedure Add_whyfrey5( c : in out d.Criteria; whyfrey5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrey5", op, join, whyfrey5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrey5;


   procedure Add_whyfrey6( c : in out d.Criteria; whyfrey6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrey6", op, join, whyfrey6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrey6;


   procedure Add_whyfrpr1( c : in out d.Criteria; whyfrpr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrpr1", op, join, whyfrpr1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrpr1;


   procedure Add_whyfrpr2( c : in out d.Criteria; whyfrpr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrpr2", op, join, whyfrpr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrpr2;


   procedure Add_whyfrpr3( c : in out d.Criteria; whyfrpr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrpr3", op, join, whyfrpr3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrpr3;


   procedure Add_whyfrpr4( c : in out d.Criteria; whyfrpr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrpr4", op, join, whyfrpr4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrpr4;


   procedure Add_whyfrpr5( c : in out d.Criteria; whyfrpr5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrpr5", op, join, whyfrpr5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrpr5;


   procedure Add_whyfrpr6( c : in out d.Criteria; whyfrpr6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "whyfrpr6", op, join, whyfrpr6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrpr6;


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


   procedure Add_wintfuel( c : in out d.Criteria; wintfuel : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wintfuel", op, join, wintfuel );
   begin
      d.add_to_criteria( c, elem );
   end Add_wintfuel;


   procedure Add_wmkit( c : in out d.Criteria; wmkit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wmkit", op, join, wmkit );
   begin
      d.add_to_criteria( c, elem );
   end Add_wmkit;


   procedure Add_working( c : in out d.Criteria; working : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "working", op, join, working );
   begin
      d.add_to_criteria( c, elem );
   end Add_working;


   procedure Add_wpa( c : in out d.Criteria; wpa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wpa", op, join, wpa );
   begin
      d.add_to_criteria( c, elem );
   end Add_wpa;


   procedure Add_wpba( c : in out d.Criteria; wpba : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wpba", op, join, wpba );
   begin
      d.add_to_criteria( c, elem );
   end Add_wpba;


   procedure Add_wtclum1( c : in out d.Criteria; wtclum1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wtclum1", op, join, wtclum1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wtclum1;


   procedure Add_wtclum2( c : in out d.Criteria; wtclum2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wtclum2", op, join, wtclum2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wtclum2;


   procedure Add_wtclum3( c : in out d.Criteria; wtclum3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wtclum3", op, join, wtclum3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wtclum3;


   procedure Add_ystrtwk( c : in out d.Criteria; ystrtwk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ystrtwk", op, join, ystrtwk );
   begin
      d.add_to_criteria( c, elem );
   end Add_ystrtwk;


   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "month", op, join, month );
   begin
      d.add_to_criteria( c, elem );
   end Add_month;


   procedure Add_able( c : in out d.Criteria; able : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "able", op, join, able );
   begin
      d.add_to_criteria( c, elem );
   end Add_able;


   procedure Add_actacci( c : in out d.Criteria; actacci : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "actacci", op, join, actacci );
   begin
      d.add_to_criteria( c, elem );
   end Add_actacci;


   procedure Add_addda( c : in out d.Criteria; addda : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "addda", op, join, addda );
   begin
      d.add_to_criteria( c, elem );
   end Add_addda;


   procedure Add_basacti( c : in out d.Criteria; basacti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "basacti", op, join, basacti );
   begin
      d.add_to_criteria( c, elem );
   end Add_basacti;


   procedure Add_bntxcred( c : in out d.Criteria; bntxcred : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bntxcred", op, join, Long_Float( bntxcred ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bntxcred;


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


   procedure Add_curacti( c : in out d.Criteria; curacti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "curacti", op, join, curacti );
   begin
      d.add_to_criteria( c, elem );
   end Add_curacti;


   procedure Add_empoccp( c : in out d.Criteria; empoccp : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "empoccp", op, join, Long_Float( empoccp ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_empoccp;


   procedure Add_empstatb( c : in out d.Criteria; empstatb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "empstatb", op, join, empstatb );
   begin
      d.add_to_criteria( c, elem );
   end Add_empstatb;


   procedure Add_empstatc( c : in out d.Criteria; empstatc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "empstatc", op, join, empstatc );
   begin
      d.add_to_criteria( c, elem );
   end Add_empstatc;


   procedure Add_empstati( c : in out d.Criteria; empstati : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "empstati", op, join, empstati );
   begin
      d.add_to_criteria( c, elem );
   end Add_empstati;


   procedure Add_fsbndcti( c : in out d.Criteria; fsbndcti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fsbndcti", op, join, fsbndcti );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsbndcti;


   procedure Add_fwmlkval( c : in out d.Criteria; fwmlkval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fwmlkval", op, join, Long_Float( fwmlkval ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fwmlkval;


   procedure Add_gebacti( c : in out d.Criteria; gebacti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gebacti", op, join, gebacti );
   begin
      d.add_to_criteria( c, elem );
   end Add_gebacti;


   procedure Add_giltcti( c : in out d.Criteria; giltcti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "giltcti", op, join, giltcti );
   begin
      d.add_to_criteria( c, elem );
   end Add_giltcti;


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


   procedure Add_hbsupran( c : in out d.Criteria; hbsupran : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbsupran", op, join, Long_Float( hbsupran ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbsupran;


   procedure Add_hdage( c : in out d.Criteria; hdage : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hdage", op, join, hdage );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdage;


   procedure Add_hdben( c : in out d.Criteria; hdben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hdben", op, join, hdben );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdben;


   procedure Add_hdindinc( c : in out d.Criteria; hdindinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hdindinc", op, join, hdindinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdindinc;


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


   procedure Add_hourcare( c : in out d.Criteria; hourcare : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hourcare", op, join, Long_Float( hourcare ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourcare;


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


   procedure Add_incseo2( c : in out d.Criteria; incseo2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "incseo2", op, join, Long_Float( incseo2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_incseo2;


   procedure Add_indinc( c : in out d.Criteria; indinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "indinc", op, join, indinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_indinc;


   procedure Add_indisben( c : in out d.Criteria; indisben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "indisben", op, join, indisben );
   begin
      d.add_to_criteria( c, elem );
   end Add_indisben;


   procedure Add_inearns( c : in out d.Criteria; inearns : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inearns", op, join, Long_Float( inearns ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_inearns;


   procedure Add_ininv( c : in out d.Criteria; ininv : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ininv", op, join, Long_Float( ininv ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ininv;


   procedure Add_inirben( c : in out d.Criteria; inirben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inirben", op, join, inirben );
   begin
      d.add_to_criteria( c, elem );
   end Add_inirben;


   procedure Add_innirben( c : in out d.Criteria; innirben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "innirben", op, join, innirben );
   begin
      d.add_to_criteria( c, elem );
   end Add_innirben;


   procedure Add_inothben( c : in out d.Criteria; inothben : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inothben", op, join, inothben );
   begin
      d.add_to_criteria( c, elem );
   end Add_inothben;


   procedure Add_inpeninc( c : in out d.Criteria; inpeninc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inpeninc", op, join, Long_Float( inpeninc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_inpeninc;


   procedure Add_inrinc( c : in out d.Criteria; inrinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inrinc", op, join, Long_Float( inrinc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_inrinc;


   procedure Add_inrpinc( c : in out d.Criteria; inrpinc : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "inrpinc", op, join, Long_Float( inrpinc ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_inrpinc;


   procedure Add_intvlic( c : in out d.Criteria; intvlic : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intvlic", op, join, Long_Float( intvlic ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_intvlic;


   procedure Add_intxcred( c : in out d.Criteria; intxcred : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "intxcred", op, join, Long_Float( intxcred ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_intxcred;


   procedure Add_isacti( c : in out d.Criteria; isacti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "isacti", op, join, isacti );
   begin
      d.add_to_criteria( c, elem );
   end Add_isacti;


   procedure Add_marital( c : in out d.Criteria; marital : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "marital", op, join, marital );
   begin
      d.add_to_criteria( c, elem );
   end Add_marital;


   procedure Add_netocpen( c : in out d.Criteria; netocpen : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "netocpen", op, join, Long_Float( netocpen ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_netocpen;


   procedure Add_nincseo2( c : in out d.Criteria; nincseo2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nincseo2", op, join, Long_Float( nincseo2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_nincseo2;


   procedure Add_nindinc( c : in out d.Criteria; nindinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nindinc", op, join, nindinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_nindinc;


   procedure Add_ninearns( c : in out d.Criteria; ninearns : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninearns", op, join, ninearns );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninearns;


   procedure Add_nininv( c : in out d.Criteria; nininv : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nininv", op, join, nininv );
   begin
      d.add_to_criteria( c, elem );
   end Add_nininv;


   procedure Add_ninpenin( c : in out d.Criteria; ninpenin : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninpenin", op, join, ninpenin );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninpenin;


   procedure Add_ninsein2( c : in out d.Criteria; ninsein2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninsein2", op, join, Long_Float( ninsein2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninsein2;


   procedure Add_nsbocti( c : in out d.Criteria; nsbocti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nsbocti", op, join, nsbocti );
   begin
      d.add_to_criteria( c, elem );
   end Add_nsbocti;


   procedure Add_occupnum( c : in out d.Criteria; occupnum : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "occupnum", op, join, occupnum );
   begin
      d.add_to_criteria( c, elem );
   end Add_occupnum;


   procedure Add_otbscti( c : in out d.Criteria; otbscti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "otbscti", op, join, otbscti );
   begin
      d.add_to_criteria( c, elem );
   end Add_otbscti;


   procedure Add_pepscti( c : in out d.Criteria; pepscti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pepscti", op, join, pepscti );
   begin
      d.add_to_criteria( c, elem );
   end Add_pepscti;


   procedure Add_poaccti( c : in out d.Criteria; poaccti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "poaccti", op, join, poaccti );
   begin
      d.add_to_criteria( c, elem );
   end Add_poaccti;


   procedure Add_prbocti( c : in out d.Criteria; prbocti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "prbocti", op, join, prbocti );
   begin
      d.add_to_criteria( c, elem );
   end Add_prbocti;


   procedure Add_relhrp( c : in out d.Criteria; relhrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "relhrp", op, join, relhrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_relhrp;


   procedure Add_sayecti( c : in out d.Criteria; sayecti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sayecti", op, join, sayecti );
   begin
      d.add_to_criteria( c, elem );
   end Add_sayecti;


   procedure Add_sclbcti( c : in out d.Criteria; sclbcti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sclbcti", op, join, sclbcti );
   begin
      d.add_to_criteria( c, elem );
   end Add_sclbcti;


   procedure Add_seincam2( c : in out d.Criteria; seincam2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "seincam2", op, join, Long_Float( seincam2 ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_seincam2;


   procedure Add_smpadj( c : in out d.Criteria; smpadj : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "smpadj", op, join, Long_Float( smpadj ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_smpadj;


   procedure Add_sscti( c : in out d.Criteria; sscti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sscti", op, join, sscti );
   begin
      d.add_to_criteria( c, elem );
   end Add_sscti;


   procedure Add_sspadj( c : in out d.Criteria; sspadj : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sspadj", op, join, Long_Float( sspadj ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sspadj;


   procedure Add_stshcti( c : in out d.Criteria; stshcti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "stshcti", op, join, stshcti );
   begin
      d.add_to_criteria( c, elem );
   end Add_stshcti;


   procedure Add_superan( c : in out d.Criteria; superan : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "superan", op, join, Long_Float( superan ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_superan;


   procedure Add_taxpayer( c : in out d.Criteria; taxpayer : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "taxpayer", op, join, taxpayer );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxpayer;


   procedure Add_tesscti( c : in out d.Criteria; tesscti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tesscti", op, join, tesscti );
   begin
      d.add_to_criteria( c, elem );
   end Add_tesscti;


   procedure Add_totgrant( c : in out d.Criteria; totgrant : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totgrant", op, join, Long_Float( totgrant ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_totgrant;


   procedure Add_tothours( c : in out d.Criteria; tothours : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tothours", op, join, Long_Float( tothours ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_tothours;


   procedure Add_totoccp( c : in out d.Criteria; totoccp : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "totoccp", op, join, Long_Float( totoccp ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_totoccp;


   procedure Add_ttwcosts( c : in out d.Criteria; ttwcosts : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttwcosts", op, join, Long_Float( ttwcosts ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwcosts;


   procedure Add_untrcti( c : in out d.Criteria; untrcti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "untrcti", op, join, untrcti );
   begin
      d.add_to_criteria( c, elem );
   end Add_untrcti;


   procedure Add_uperson( c : in out d.Criteria; uperson : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "uperson", op, join, uperson );
   begin
      d.add_to_criteria( c, elem );
   end Add_uperson;


   procedure Add_widoccp( c : in out d.Criteria; widoccp : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "widoccp", op, join, Long_Float( widoccp ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_widoccp;


   procedure Add_accountq( c : in out d.Criteria; accountq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accountq", op, join, accountq );
   begin
      d.add_to_criteria( c, elem );
   end Add_accountq;


   procedure Add_ben5q7( c : in out d.Criteria; ben5q7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben5q7", op, join, ben5q7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q7;


   procedure Add_ben5q8( c : in out d.Criteria; ben5q8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben5q8", op, join, ben5q8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q8;


   procedure Add_ben5q9( c : in out d.Criteria; ben5q9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben5q9", op, join, ben5q9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q9;


   procedure Add_ddatre( c : in out d.Criteria; ddatre : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ddatre", op, join, ddatre );
   begin
      d.add_to_criteria( c, elem );
   end Add_ddatre;


   procedure Add_disdif9( c : in out d.Criteria; disdif9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdif9", op, join, disdif9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif9;


   procedure Add_fare( c : in out d.Criteria; fare : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "fare", op, join, Long_Float( fare ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_fare;


   procedure Add_nittwmod( c : in out d.Criteria; nittwmod : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nittwmod", op, join, nittwmod );
   begin
      d.add_to_criteria( c, elem );
   end Add_nittwmod;


   procedure Add_oneway( c : in out d.Criteria; oneway : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "oneway", op, join, oneway );
   begin
      d.add_to_criteria( c, elem );
   end Add_oneway;


   procedure Add_pssamt( c : in out d.Criteria; pssamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pssamt", op, join, Long_Float( pssamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_pssamt;


   procedure Add_pssdate( c : in out d.Criteria; pssdate : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pssdate", op, join, pssdate );
   begin
      d.add_to_criteria( c, elem );
   end Add_pssdate;


   procedure Add_ttwcode1( c : in out d.Criteria; ttwcode1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttwcode1", op, join, ttwcode1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwcode1;


   procedure Add_ttwcode2( c : in out d.Criteria; ttwcode2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttwcode2", op, join, ttwcode2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwcode2;


   procedure Add_ttwcode3( c : in out d.Criteria; ttwcode3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttwcode3", op, join, ttwcode3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwcode3;


   procedure Add_ttwcost( c : in out d.Criteria; ttwcost : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttwcost", op, join, Long_Float( ttwcost ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwcost;


   procedure Add_ttwfar( c : in out d.Criteria; ttwfar : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttwfar", op, join, ttwfar );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwfar;


   procedure Add_ttwfrq( c : in out d.Criteria; ttwfrq : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttwfrq", op, join, Long_Float( ttwfrq ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwfrq;


   procedure Add_ttwmod( c : in out d.Criteria; ttwmod : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttwmod", op, join, ttwmod );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwmod;


   procedure Add_ttwpay( c : in out d.Criteria; ttwpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttwpay", op, join, ttwpay );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwpay;


   procedure Add_ttwpss( c : in out d.Criteria; ttwpss : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttwpss", op, join, ttwpss );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwpss;


   procedure Add_ttwrec( c : in out d.Criteria; ttwrec : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttwrec", op, join, Long_Float( ttwrec ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwrec;


   procedure Add_chbflg( c : in out d.Criteria; chbflg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chbflg", op, join, chbflg );
   begin
      d.add_to_criteria( c, elem );
   end Add_chbflg;


   procedure Add_crunaci( c : in out d.Criteria; crunaci : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "crunaci", op, join, crunaci );
   begin
      d.add_to_criteria( c, elem );
   end Add_crunaci;


   procedure Add_enomorti( c : in out d.Criteria; enomorti : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "enomorti", op, join, enomorti );
   begin
      d.add_to_criteria( c, elem );
   end Add_enomorti;


   procedure Add_sapadj( c : in out d.Criteria; sapadj : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sapadj", op, join, Long_Float( sapadj ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sapadj;


   procedure Add_sppadj( c : in out d.Criteria; sppadj : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sppadj", op, join, Long_Float( sppadj ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_sppadj;


   procedure Add_ttwmode( c : in out d.Criteria; ttwmode : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttwmode", op, join, ttwmode );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwmode;


   procedure Add_ddatrep( c : in out d.Criteria; ddatrep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ddatrep", op, join, ddatrep );
   begin
      d.add_to_criteria( c, elem );
   end Add_ddatrep;


   procedure Add_defrpen( c : in out d.Criteria; defrpen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "defrpen", op, join, defrpen );
   begin
      d.add_to_criteria( c, elem );
   end Add_defrpen;


   procedure Add_disdifp( c : in out d.Criteria; disdifp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdifp", op, join, disdifp );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdifp;


   procedure Add_followup( c : in out d.Criteria; followup : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "followup", op, join, followup );
   begin
      d.add_to_criteria( c, elem );
   end Add_followup;


   procedure Add_practice( c : in out d.Criteria; practice : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "practice", op, join, practice );
   begin
      d.add_to_criteria( c, elem );
   end Add_practice;


   procedure Add_sfrpis( c : in out d.Criteria; sfrpis : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sfrpis", op, join, sfrpis );
   begin
      d.add_to_criteria( c, elem );
   end Add_sfrpis;


   procedure Add_sfrpjsa( c : in out d.Criteria; sfrpjsa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sfrpjsa", op, join, sfrpjsa );
   begin
      d.add_to_criteria( c, elem );
   end Add_sfrpjsa;


   procedure Add_age80( c : in out d.Criteria; age80 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "age80", op, join, age80 );
   begin
      d.add_to_criteria( c, elem );
   end Add_age80;


   procedure Add_ethgr2( c : in out d.Criteria; ethgr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ethgr2", op, join, ethgr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ethgr2;


   procedure Add_pocardi( c : in out d.Criteria; pocardi : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pocardi", op, join, pocardi );
   begin
      d.add_to_criteria( c, elem );
   end Add_pocardi;


   procedure Add_chkdpn( c : in out d.Criteria; chkdpn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chkdpn", op, join, chkdpn );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdpn;


   procedure Add_chknop( c : in out d.Criteria; chknop : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chknop", op, join, chknop );
   begin
      d.add_to_criteria( c, elem );
   end Add_chknop;


   procedure Add_consent( c : in out d.Criteria; consent : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "consent", op, join, consent );
   begin
      d.add_to_criteria( c, elem );
   end Add_consent;


   procedure Add_dvpens( c : in out d.Criteria; dvpens : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dvpens", op, join, dvpens );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvpens;


   procedure Add_eligschm( c : in out d.Criteria; eligschm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eligschm", op, join, eligschm );
   begin
      d.add_to_criteria( c, elem );
   end Add_eligschm;


   procedure Add_emparr( c : in out d.Criteria; emparr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "emparr", op, join, emparr );
   begin
      d.add_to_criteria( c, elem );
   end Add_emparr;


   procedure Add_emppen( c : in out d.Criteria; emppen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "emppen", op, join, emppen );
   begin
      d.add_to_criteria( c, elem );
   end Add_emppen;


   procedure Add_empschm( c : in out d.Criteria; empschm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "empschm", op, join, empschm );
   begin
      d.add_to_criteria( c, elem );
   end Add_empschm;


   procedure Add_lnkref1( c : in out d.Criteria; lnkref1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref1", op, join, lnkref1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref1;


   procedure Add_lnkref2( c : in out d.Criteria; lnkref2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref2", op, join, lnkref2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref2;


   procedure Add_lnkref21( c : in out d.Criteria; lnkref21 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref21", op, join, lnkref21 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref21;


   procedure Add_lnkref22( c : in out d.Criteria; lnkref22 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref22", op, join, lnkref22 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref22;


   procedure Add_lnkref23( c : in out d.Criteria; lnkref23 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref23", op, join, lnkref23 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref23;


   procedure Add_lnkref24( c : in out d.Criteria; lnkref24 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref24", op, join, lnkref24 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref24;


   procedure Add_lnkref25( c : in out d.Criteria; lnkref25 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref25", op, join, lnkref25 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref25;


   procedure Add_lnkref3( c : in out d.Criteria; lnkref3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref3", op, join, lnkref3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref3;


   procedure Add_lnkref4( c : in out d.Criteria; lnkref4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref4", op, join, lnkref4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref4;


   procedure Add_lnkref5( c : in out d.Criteria; lnkref5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref5", op, join, lnkref5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref5;


   procedure Add_memschm( c : in out d.Criteria; memschm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "memschm", op, join, memschm );
   begin
      d.add_to_criteria( c, elem );
   end Add_memschm;


   procedure Add_pconsent( c : in out d.Criteria; pconsent : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pconsent", op, join, pconsent );
   begin
      d.add_to_criteria( c, elem );
   end Add_pconsent;


   procedure Add_perspen1( c : in out d.Criteria; perspen1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "perspen1", op, join, perspen1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_perspen1;


   procedure Add_perspen2( c : in out d.Criteria; perspen2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "perspen2", op, join, perspen2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_perspen2;


   procedure Add_privpen( c : in out d.Criteria; privpen : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "privpen", op, join, privpen );
   begin
      d.add_to_criteria( c, elem );
   end Add_privpen;


   procedure Add_schchk( c : in out d.Criteria; schchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "schchk", op, join, schchk );
   begin
      d.add_to_criteria( c, elem );
   end Add_schchk;


   procedure Add_spnumc( c : in out d.Criteria; spnumc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spnumc", op, join, spnumc );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnumc;


   procedure Add_stakep( c : in out d.Criteria; stakep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "stakep", op, join, stakep );
   begin
      d.add_to_criteria( c, elem );
   end Add_stakep;


   procedure Add_trainee( c : in out d.Criteria; trainee : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "trainee", op, join, trainee );
   begin
      d.add_to_criteria( c, elem );
   end Add_trainee;


   procedure Add_lnkdwp( c : in out d.Criteria; lnkdwp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkdwp", op, join, lnkdwp );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkdwp;


   procedure Add_lnkons( c : in out d.Criteria; lnkons : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkons", op, join, lnkons );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkons;


   procedure Add_lnkref6( c : in out d.Criteria; lnkref6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref6", op, join, lnkref6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref6;


   procedure Add_lnkref7( c : in out d.Criteria; lnkref7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref7", op, join, lnkref7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref7;


   procedure Add_lnkref8( c : in out d.Criteria; lnkref8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref8", op, join, lnkref8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref8;


   procedure Add_lnkref9( c : in out d.Criteria; lnkref9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref9", op, join, lnkref9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref9;


   procedure Add_tcever1( c : in out d.Criteria; tcever1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tcever1", op, join, tcever1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcever1;


   procedure Add_tcever2( c : in out d.Criteria; tcever2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tcever2", op, join, tcever2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcever2;


   procedure Add_tcrepay1( c : in out d.Criteria; tcrepay1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tcrepay1", op, join, tcrepay1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcrepay1;


   procedure Add_tcrepay2( c : in out d.Criteria; tcrepay2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tcrepay2", op, join, tcrepay2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcrepay2;


   procedure Add_tcrepay3( c : in out d.Criteria; tcrepay3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tcrepay3", op, join, tcrepay3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcrepay3;


   procedure Add_tcrepay4( c : in out d.Criteria; tcrepay4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tcrepay4", op, join, tcrepay4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcrepay4;


   procedure Add_tcrepay5( c : in out d.Criteria; tcrepay5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tcrepay5", op, join, tcrepay5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcrepay5;


   procedure Add_tcrepay6( c : in out d.Criteria; tcrepay6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tcrepay6", op, join, tcrepay6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcrepay6;


   procedure Add_tcthsyr1( c : in out d.Criteria; tcthsyr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tcthsyr1", op, join, tcthsyr1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcthsyr1;


   procedure Add_tcthsyr2( c : in out d.Criteria; tcthsyr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tcthsyr2", op, join, tcthsyr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcthsyr2;


   procedure Add_currjobm( c : in out d.Criteria; currjobm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "currjobm", op, join, currjobm );
   begin
      d.add_to_criteria( c, elem );
   end Add_currjobm;


   procedure Add_prevjobm( c : in out d.Criteria; prevjobm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "prevjobm", op, join, prevjobm );
   begin
      d.add_to_criteria( c, elem );
   end Add_prevjobm;


   procedure Add_b3qfut7( c : in out d.Criteria; b3qfut7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "b3qfut7", op, join, b3qfut7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut7;


   procedure Add_ben3q7( c : in out d.Criteria; ben3q7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben3q7", op, join, ben3q7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q7;


   procedure Add_camemt( c : in out d.Criteria; camemt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "camemt", op, join, camemt );
   begin
      d.add_to_criteria( c, elem );
   end Add_camemt;


   procedure Add_cameyr( c : in out d.Criteria; cameyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cameyr", op, join, cameyr );
   begin
      d.add_to_criteria( c, elem );
   end Add_cameyr;


   procedure Add_cameyr2( c : in out d.Criteria; cameyr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cameyr2", op, join, cameyr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cameyr2;


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


   procedure Add_ddaprog( c : in out d.Criteria; ddaprog : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ddaprog", op, join, ddaprog );
   begin
      d.add_to_criteria( c, elem );
   end Add_ddaprog;


   procedure Add_hbolng( c : in out d.Criteria; hbolng : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hbolng", op, join, hbolng );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbolng;


   procedure Add_hi1qual1( c : in out d.Criteria; hi1qual1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hi1qual1", op, join, hi1qual1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual1;


   procedure Add_hi1qual2( c : in out d.Criteria; hi1qual2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hi1qual2", op, join, hi1qual2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual2;


   procedure Add_hi1qual3( c : in out d.Criteria; hi1qual3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hi1qual3", op, join, hi1qual3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual3;


   procedure Add_hi1qual4( c : in out d.Criteria; hi1qual4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hi1qual4", op, join, hi1qual4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual4;


   procedure Add_hi1qual5( c : in out d.Criteria; hi1qual5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hi1qual5", op, join, hi1qual5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual5;


   procedure Add_hi1qual6( c : in out d.Criteria; hi1qual6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hi1qual6", op, join, hi1qual6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual6;


   procedure Add_hi2qual( c : in out d.Criteria; hi2qual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hi2qual", op, join, hi2qual );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi2qual;


   procedure Add_hlpgvn01( c : in out d.Criteria; hlpgvn01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlpgvn01", op, join, hlpgvn01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn01;


   procedure Add_hlpgvn02( c : in out d.Criteria; hlpgvn02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlpgvn02", op, join, hlpgvn02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn02;


   procedure Add_hlpgvn03( c : in out d.Criteria; hlpgvn03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlpgvn03", op, join, hlpgvn03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn03;


   procedure Add_hlpgvn04( c : in out d.Criteria; hlpgvn04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlpgvn04", op, join, hlpgvn04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn04;


   procedure Add_hlpgvn05( c : in out d.Criteria; hlpgvn05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlpgvn05", op, join, hlpgvn05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn05;


   procedure Add_hlpgvn06( c : in out d.Criteria; hlpgvn06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlpgvn06", op, join, hlpgvn06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn06;


   procedure Add_hlpgvn07( c : in out d.Criteria; hlpgvn07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlpgvn07", op, join, hlpgvn07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn07;


   procedure Add_hlpgvn08( c : in out d.Criteria; hlpgvn08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlpgvn08", op, join, hlpgvn08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn08;


   procedure Add_hlpgvn09( c : in out d.Criteria; hlpgvn09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlpgvn09", op, join, hlpgvn09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn09;


   procedure Add_hlpgvn10( c : in out d.Criteria; hlpgvn10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlpgvn10", op, join, hlpgvn10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn10;


   procedure Add_hlpgvn11( c : in out d.Criteria; hlpgvn11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlpgvn11", op, join, hlpgvn11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn11;


   procedure Add_hlprec01( c : in out d.Criteria; hlprec01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlprec01", op, join, hlprec01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec01;


   procedure Add_hlprec02( c : in out d.Criteria; hlprec02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlprec02", op, join, hlprec02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec02;


   procedure Add_hlprec03( c : in out d.Criteria; hlprec03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlprec03", op, join, hlprec03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec03;


   procedure Add_hlprec04( c : in out d.Criteria; hlprec04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlprec04", op, join, hlprec04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec04;


   procedure Add_hlprec05( c : in out d.Criteria; hlprec05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlprec05", op, join, hlprec05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec05;


   procedure Add_hlprec06( c : in out d.Criteria; hlprec06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlprec06", op, join, hlprec06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec06;


   procedure Add_hlprec07( c : in out d.Criteria; hlprec07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlprec07", op, join, hlprec07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec07;


   procedure Add_hlprec08( c : in out d.Criteria; hlprec08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlprec08", op, join, hlprec08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec08;


   procedure Add_hlprec09( c : in out d.Criteria; hlprec09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlprec09", op, join, hlprec09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec09;


   procedure Add_hlprec10( c : in out d.Criteria; hlprec10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlprec10", op, join, hlprec10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec10;


   procedure Add_hlprec11( c : in out d.Criteria; hlprec11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hlprec11", op, join, hlprec11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec11;


   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "issue", op, join, issue );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue;


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


   procedure Add_mntarr1( c : in out d.Criteria; mntarr1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntarr1", op, join, mntarr1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntarr1;


   procedure Add_mntarr2( c : in out d.Criteria; mntarr2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntarr2", op, join, mntarr2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntarr2;


   procedure Add_mntarr3( c : in out d.Criteria; mntarr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntarr3", op, join, mntarr3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntarr3;


   procedure Add_mntarr4( c : in out d.Criteria; mntarr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntarr4", op, join, mntarr4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntarr4;


   procedure Add_mntnrp( c : in out d.Criteria; mntnrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntnrp", op, join, mntnrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntnrp;


   procedure Add_othqual1( c : in out d.Criteria; othqual1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othqual1", op, join, othqual1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othqual1;


   procedure Add_othqual2( c : in out d.Criteria; othqual2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othqual2", op, join, othqual2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othqual2;


   procedure Add_othqual3( c : in out d.Criteria; othqual3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othqual3", op, join, othqual3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othqual3;


   procedure Add_tea9697( c : in out d.Criteria; tea9697 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tea9697", op, join, tea9697 );
   begin
      d.add_to_criteria( c, elem );
   end Add_tea9697;


   procedure Add_heartval( c : in out d.Criteria; heartval : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heartval", op, join, Long_Float( heartval ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_heartval;


   procedure Add_iagegr3( c : in out d.Criteria; iagegr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iagegr3", op, join, iagegr3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_iagegr3;


   procedure Add_iagegr4( c : in out d.Criteria; iagegr4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iagegr4", op, join, iagegr4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_iagegr4;


   procedure Add_nirel2( c : in out d.Criteria; nirel2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nirel2", op, join, nirel2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nirel2;


   procedure Add_xbonflag( c : in out d.Criteria; xbonflag : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "xbonflag", op, join, xbonflag );
   begin
      d.add_to_criteria( c, elem );
   end Add_xbonflag;


   procedure Add_alg( c : in out d.Criteria; alg : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "alg", op, join, alg );
   begin
      d.add_to_criteria( c, elem );
   end Add_alg;


   procedure Add_algamt( c : in out d.Criteria; algamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "algamt", op, join, Long_Float( algamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_algamt;


   procedure Add_algpd( c : in out d.Criteria; algpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "algpd", op, join, algpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_algpd;


   procedure Add_ben4q4( c : in out d.Criteria; ben4q4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ben4q4", op, join, ben4q4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben4q4;


   procedure Add_chkctc( c : in out d.Criteria; chkctc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chkctc", op, join, chkctc );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkctc;


   procedure Add_chkdpco1( c : in out d.Criteria; chkdpco1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chkdpco1", op, join, chkdpco1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdpco1;


   procedure Add_chkdpco2( c : in out d.Criteria; chkdpco2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chkdpco2", op, join, chkdpco2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdpco2;


   procedure Add_chkdpco3( c : in out d.Criteria; chkdpco3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chkdpco3", op, join, chkdpco3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdpco3;


   procedure Add_chkdsco1( c : in out d.Criteria; chkdsco1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chkdsco1", op, join, chkdsco1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdsco1;


   procedure Add_chkdsco2( c : in out d.Criteria; chkdsco2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chkdsco2", op, join, chkdsco2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdsco2;


   procedure Add_chkdsco3( c : in out d.Criteria; chkdsco3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "chkdsco3", op, join, chkdsco3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdsco3;


   procedure Add_dv09pens( c : in out d.Criteria; dv09pens : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dv09pens", op, join, dv09pens );
   begin
      d.add_to_criteria( c, elem );
   end Add_dv09pens;


   procedure Add_lnkref01( c : in out d.Criteria; lnkref01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref01", op, join, lnkref01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref01;


   procedure Add_lnkref02( c : in out d.Criteria; lnkref02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref02", op, join, lnkref02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref02;


   procedure Add_lnkref03( c : in out d.Criteria; lnkref03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref03", op, join, lnkref03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref03;


   procedure Add_lnkref04( c : in out d.Criteria; lnkref04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref04", op, join, lnkref04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref04;


   procedure Add_lnkref05( c : in out d.Criteria; lnkref05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref05", op, join, lnkref05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref05;


   procedure Add_lnkref06( c : in out d.Criteria; lnkref06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref06", op, join, lnkref06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref06;


   procedure Add_lnkref07( c : in out d.Criteria; lnkref07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref07", op, join, lnkref07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref07;


   procedure Add_lnkref08( c : in out d.Criteria; lnkref08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref08", op, join, lnkref08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref08;


   procedure Add_lnkref09( c : in out d.Criteria; lnkref09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref09", op, join, lnkref09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref09;


   procedure Add_lnkref10( c : in out d.Criteria; lnkref10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref10", op, join, lnkref10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref10;


   procedure Add_lnkref11( c : in out d.Criteria; lnkref11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lnkref11", op, join, lnkref11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref11;


   procedure Add_spyrot( c : in out d.Criteria; spyrot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "spyrot", op, join, spyrot );
   begin
      d.add_to_criteria( c, elem );
   end Add_spyrot;


   procedure Add_disdifad( c : in out d.Criteria; disdifad : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdifad", op, join, disdifad );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdifad;


   procedure Add_gross3_x( c : in out d.Criteria; gross3_x : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gross3_x", op, join, gross3_x );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross3_x;


   procedure Add_aliamt( c : in out d.Criteria; aliamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "aliamt", op, join, Long_Float( aliamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_aliamt;


   procedure Add_alimny( c : in out d.Criteria; alimny : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "alimny", op, join, alimny );
   begin
      d.add_to_criteria( c, elem );
   end Add_alimny;


   procedure Add_alipd( c : in out d.Criteria; alipd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "alipd", op, join, alipd );
   begin
      d.add_to_criteria( c, elem );
   end Add_alipd;


   procedure Add_alius( c : in out d.Criteria; alius : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "alius", op, join, alius );
   begin
      d.add_to_criteria( c, elem );
   end Add_alius;


   procedure Add_aluamt( c : in out d.Criteria; aluamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "aluamt", op, join, Long_Float( aluamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_aluamt;


   procedure Add_alupd( c : in out d.Criteria; alupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "alupd", op, join, alupd );
   begin
      d.add_to_criteria( c, elem );
   end Add_alupd;


   procedure Add_cbaamt( c : in out d.Criteria; cbaamt : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cbaamt", op, join, cbaamt );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbaamt;


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


   procedure Add_penflag( c : in out d.Criteria; penflag : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penflag", op, join, penflag );
   begin
      d.add_to_criteria( c, elem );
   end Add_penflag;


   procedure Add_ppchk1( c : in out d.Criteria; ppchk1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ppchk1", op, join, ppchk1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ppchk1;


   procedure Add_ppchk2( c : in out d.Criteria; ppchk2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ppchk2", op, join, ppchk2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ppchk2;


   procedure Add_ppchk3( c : in out d.Criteria; ppchk3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ppchk3", op, join, ppchk3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ppchk3;


   procedure Add_ttbprx( c : in out d.Criteria; ttbprx : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ttbprx", op, join, Long_Float( ttbprx ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttbprx;


   procedure Add_mjobsect( c : in out d.Criteria; mjobsect : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mjobsect", op, join, mjobsect );
   begin
      d.add_to_criteria( c, elem );
   end Add_mjobsect;


   procedure Add_etngrp( c : in out d.Criteria; etngrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "etngrp", op, join, etngrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_etngrp;


   procedure Add_medpay( c : in out d.Criteria; medpay : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medpay", op, join, medpay );
   begin
      d.add_to_criteria( c, elem );
   end Add_medpay;


   procedure Add_medrep( c : in out d.Criteria; medrep : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medrep", op, join, medrep );
   begin
      d.add_to_criteria( c, elem );
   end Add_medrep;


   procedure Add_medrpnm( c : in out d.Criteria; medrpnm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "medrpnm", op, join, medrpnm );
   begin
      d.add_to_criteria( c, elem );
   end Add_medrpnm;


   procedure Add_nanid1( c : in out d.Criteria; nanid1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nanid1", op, join, nanid1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nanid1;


   procedure Add_nanid2( c : in out d.Criteria; nanid2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nanid2", op, join, nanid2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nanid2;


   procedure Add_nanid3( c : in out d.Criteria; nanid3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nanid3", op, join, nanid3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nanid3;


   procedure Add_nanid4( c : in out d.Criteria; nanid4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nanid4", op, join, nanid4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nanid4;


   procedure Add_nanid5( c : in out d.Criteria; nanid5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nanid5", op, join, nanid5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nanid5;


   procedure Add_nanid6( c : in out d.Criteria; nanid6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nanid6", op, join, nanid6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_nanid6;


   procedure Add_nietngrp( c : in out d.Criteria; nietngrp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nietngrp", op, join, nietngrp );
   begin
      d.add_to_criteria( c, elem );
   end Add_nietngrp;


   procedure Add_ninanid1( c : in out d.Criteria; ninanid1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninanid1", op, join, ninanid1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid1;


   procedure Add_ninanid2( c : in out d.Criteria; ninanid2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninanid2", op, join, ninanid2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid2;


   procedure Add_ninanid3( c : in out d.Criteria; ninanid3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninanid3", op, join, ninanid3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid3;


   procedure Add_ninanid4( c : in out d.Criteria; ninanid4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninanid4", op, join, ninanid4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid4;


   procedure Add_ninanid5( c : in out d.Criteria; ninanid5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninanid5", op, join, ninanid5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid5;


   procedure Add_ninanid6( c : in out d.Criteria; ninanid6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninanid6", op, join, ninanid6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid6;


   procedure Add_ninanid7( c : in out d.Criteria; ninanid7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninanid7", op, join, ninanid7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid7;


   procedure Add_nirelig( c : in out d.Criteria; nirelig : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nirelig", op, join, nirelig );
   begin
      d.add_to_criteria( c, elem );
   end Add_nirelig;


   procedure Add_pollopin( c : in out d.Criteria; pollopin : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pollopin", op, join, pollopin );
   begin
      d.add_to_criteria( c, elem );
   end Add_pollopin;


   procedure Add_religenw( c : in out d.Criteria; religenw : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "religenw", op, join, religenw );
   begin
      d.add_to_criteria( c, elem );
   end Add_religenw;


   procedure Add_religsc( c : in out d.Criteria; religsc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "religsc", op, join, religsc );
   begin
      d.add_to_criteria( c, elem );
   end Add_religsc;


   procedure Add_sidqn( c : in out d.Criteria; sidqn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sidqn", op, join, sidqn );
   begin
      d.add_to_criteria( c, elem );
   end Add_sidqn;


   procedure Add_soc2010( c : in out d.Criteria; soc2010 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "soc2010", op, join, soc2010 );
   begin
      d.add_to_criteria( c, elem );
   end Add_soc2010;


   procedure Add_corignan( c : in out d.Criteria; corignan : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "corignan", op, join, corignan );
   begin
      d.add_to_criteria( c, elem );
   end Add_corignan;


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


   procedure Add_ethgr3( c : in out d.Criteria; ethgr3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ethgr3", op, join, ethgr3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ethgr3;


   procedure Add_ninanida( c : in out d.Criteria; ninanida : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninanida", op, join, ninanida );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanida;


   procedure Add_agehqual( c : in out d.Criteria; agehqual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "agehqual", op, join, agehqual );
   begin
      d.add_to_criteria( c, elem );
   end Add_agehqual;


   procedure Add_bfd( c : in out d.Criteria; bfd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bfd", op, join, bfd );
   begin
      d.add_to_criteria( c, elem );
   end Add_bfd;


   procedure Add_bfdamt( c : in out d.Criteria; bfdamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bfdamt", op, join, Long_Float( bfdamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_bfdamt;


   procedure Add_bfdpd( c : in out d.Criteria; bfdpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bfdpd", op, join, bfdpd );
   begin
      d.add_to_criteria( c, elem );
   end Add_bfdpd;


   procedure Add_bfdval( c : in out d.Criteria; bfdval : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "bfdval", op, join, bfdval );
   begin
      d.add_to_criteria( c, elem );
   end Add_bfdval;


   procedure Add_btec( c : in out d.Criteria; btec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "btec", op, join, btec );
   begin
      d.add_to_criteria( c, elem );
   end Add_btec;


   procedure Add_btecnow( c : in out d.Criteria; btecnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "btecnow", op, join, btecnow );
   begin
      d.add_to_criteria( c, elem );
   end Add_btecnow;


   procedure Add_cbaamt2( c : in out d.Criteria; cbaamt2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cbaamt2", op, join, cbaamt2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbaamt2;


   procedure Add_change( c : in out d.Criteria; change : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "change", op, join, change );
   begin
      d.add_to_criteria( c, elem );
   end Add_change;


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


   procedure Add_condit( c : in out d.Criteria; condit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "condit", op, join, condit );
   begin
      d.add_to_criteria( c, elem );
   end Add_condit;


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


   procedure Add_ddaprog1( c : in out d.Criteria; ddaprog1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ddaprog1", op, join, ddaprog1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ddaprog1;


   procedure Add_ddatre1( c : in out d.Criteria; ddatre1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ddatre1", op, join, ddatre1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ddatre1;


   procedure Add_ddatrep1( c : in out d.Criteria; ddatrep1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ddatrep1", op, join, ddatrep1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_ddatrep1;


   procedure Add_degree( c : in out d.Criteria; degree : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "degree", op, join, degree );
   begin
      d.add_to_criteria( c, elem );
   end Add_degree;


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


   procedure Add_disd01( c : in out d.Criteria; disd01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disd01", op, join, disd01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd01;


   procedure Add_disd02( c : in out d.Criteria; disd02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disd02", op, join, disd02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd02;


   procedure Add_disd03( c : in out d.Criteria; disd03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disd03", op, join, disd03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd03;


   procedure Add_disd04( c : in out d.Criteria; disd04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disd04", op, join, disd04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd04;


   procedure Add_disd05( c : in out d.Criteria; disd05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disd05", op, join, disd05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd05;


   procedure Add_disd06( c : in out d.Criteria; disd06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disd06", op, join, disd06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd06;


   procedure Add_disd07( c : in out d.Criteria; disd07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disd07", op, join, disd07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd07;


   procedure Add_disd08( c : in out d.Criteria; disd08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disd08", op, join, disd08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd08;


   procedure Add_disd09( c : in out d.Criteria; disd09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disd09", op, join, disd09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd09;


   procedure Add_disd10( c : in out d.Criteria; disd10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disd10", op, join, disd10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd10;


   procedure Add_disdifp1( c : in out d.Criteria; disdifp1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disdifp1", op, join, disdifp1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdifp1;


   procedure Add_empcontr( c : in out d.Criteria; empcontr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "empcontr", op, join, empcontr );
   begin
      d.add_to_criteria( c, elem );
   end Add_empcontr;


   procedure Add_ethgrps( c : in out d.Criteria; ethgrps : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ethgrps", op, join, ethgrps );
   begin
      d.add_to_criteria( c, elem );
   end Add_ethgrps;


   procedure Add_eualiamt( c : in out d.Criteria; eualiamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eualiamt", op, join, Long_Float( eualiamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_eualiamt;


   procedure Add_eualimny( c : in out d.Criteria; eualimny : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eualimny", op, join, eualimny );
   begin
      d.add_to_criteria( c, elem );
   end Add_eualimny;


   procedure Add_eualipd( c : in out d.Criteria; eualipd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eualipd", op, join, eualipd );
   begin
      d.add_to_criteria( c, elem );
   end Add_eualipd;


   procedure Add_euetype( c : in out d.Criteria; euetype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euetype", op, join, euetype );
   begin
      d.add_to_criteria( c, elem );
   end Add_euetype;


   procedure Add_followsc( c : in out d.Criteria; followsc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "followsc", op, join, followsc );
   begin
      d.add_to_criteria( c, elem );
   end Add_followsc;


   procedure Add_health1( c : in out d.Criteria; health1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "health1", op, join, health1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_health1;


   procedure Add_heathad( c : in out d.Criteria; heathad : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "heathad", op, join, heathad );
   begin
      d.add_to_criteria( c, elem );
   end Add_heathad;


   procedure Add_hi3qual( c : in out d.Criteria; hi3qual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hi3qual", op, join, hi3qual );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi3qual;


   procedure Add_higho( c : in out d.Criteria; higho : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "higho", op, join, higho );
   begin
      d.add_to_criteria( c, elem );
   end Add_higho;


   procedure Add_highonow( c : in out d.Criteria; highonow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "highonow", op, join, highonow );
   begin
      d.add_to_criteria( c, elem );
   end Add_highonow;


   procedure Add_jobbyr( c : in out d.Criteria; jobbyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "jobbyr", op, join, jobbyr );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobbyr;


   procedure Add_limitl( c : in out d.Criteria; limitl : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "limitl", op, join, limitl );
   begin
      d.add_to_criteria( c, elem );
   end Add_limitl;


   procedure Add_lktrain( c : in out d.Criteria; lktrain : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lktrain", op, join, lktrain );
   begin
      d.add_to_criteria( c, elem );
   end Add_lktrain;


   procedure Add_lkwork( c : in out d.Criteria; lkwork : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lkwork", op, join, lkwork );
   begin
      d.add_to_criteria( c, elem );
   end Add_lkwork;


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


   procedure Add_nvqlev( c : in out d.Criteria; nvqlev : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nvqlev", op, join, nvqlev );
   begin
      d.add_to_criteria( c, elem );
   end Add_nvqlev;


   procedure Add_othpass( c : in out d.Criteria; othpass : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othpass", op, join, othpass );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpass;


   procedure Add_ppper( c : in out d.Criteria; ppper : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ppper", op, join, ppper );
   begin
      d.add_to_criteria( c, elem );
   end Add_ppper;


   procedure Add_proptax( c : in out d.Criteria; proptax : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "proptax", op, join, Long_Float( proptax ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_proptax;


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


   procedure Add_reason( c : in out d.Criteria; reason : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "reason", op, join, reason );
   begin
      d.add_to_criteria( c, elem );
   end Add_reason;


   procedure Add_rednet( c : in out d.Criteria; rednet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rednet", op, join, rednet );
   begin
      d.add_to_criteria( c, elem );
   end Add_rednet;


   procedure Add_redtax( c : in out d.Criteria; redtax : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "redtax", op, join, Long_Float( redtax ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_redtax;


   procedure Add_rsa( c : in out d.Criteria; rsa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rsa", op, join, rsa );
   begin
      d.add_to_criteria( c, elem );
   end Add_rsa;


   procedure Add_rsanow( c : in out d.Criteria; rsanow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "rsanow", op, join, rsanow );
   begin
      d.add_to_criteria( c, elem );
   end Add_rsanow;


   procedure Add_samesit( c : in out d.Criteria; samesit : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "samesit", op, join, samesit );
   begin
      d.add_to_criteria( c, elem );
   end Add_samesit;


   procedure Add_scotvec( c : in out d.Criteria; scotvec : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "scotvec", op, join, scotvec );
   begin
      d.add_to_criteria( c, elem );
   end Add_scotvec;


   procedure Add_sctvnow( c : in out d.Criteria; sctvnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sctvnow", op, join, sctvnow );
   begin
      d.add_to_criteria( c, elem );
   end Add_sctvnow;


   procedure Add_sdemp01( c : in out d.Criteria; sdemp01 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sdemp01", op, join, sdemp01 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp01;


   procedure Add_sdemp02( c : in out d.Criteria; sdemp02 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sdemp02", op, join, sdemp02 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp02;


   procedure Add_sdemp03( c : in out d.Criteria; sdemp03 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sdemp03", op, join, sdemp03 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp03;


   procedure Add_sdemp04( c : in out d.Criteria; sdemp04 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sdemp04", op, join, sdemp04 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp04;


   procedure Add_sdemp05( c : in out d.Criteria; sdemp05 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sdemp05", op, join, sdemp05 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp05;


   procedure Add_sdemp06( c : in out d.Criteria; sdemp06 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sdemp06", op, join, sdemp06 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp06;


   procedure Add_sdemp07( c : in out d.Criteria; sdemp07 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sdemp07", op, join, sdemp07 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp07;


   procedure Add_sdemp08( c : in out d.Criteria; sdemp08 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sdemp08", op, join, sdemp08 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp08;


   procedure Add_sdemp09( c : in out d.Criteria; sdemp09 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sdemp09", op, join, sdemp09 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp09;


   procedure Add_sdemp10( c : in out d.Criteria; sdemp10 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sdemp10", op, join, sdemp10 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp10;


   procedure Add_sdemp11( c : in out d.Criteria; sdemp11 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sdemp11", op, join, sdemp11 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp11;


   procedure Add_sdemp12( c : in out d.Criteria; sdemp12 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sdemp12", op, join, sdemp12 );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp12;


   procedure Add_selfdemp( c : in out d.Criteria; selfdemp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "selfdemp", op, join, selfdemp );
   begin
      d.add_to_criteria( c, elem );
   end Add_selfdemp;


   procedure Add_tempjob( c : in out d.Criteria; tempjob : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "tempjob", op, join, tempjob );
   begin
      d.add_to_criteria( c, elem );
   end Add_tempjob;


   procedure Add_agehq80( c : in out d.Criteria; agehq80 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "agehq80", op, join, agehq80 );
   begin
      d.add_to_criteria( c, elem );
   end Add_agehq80;


   procedure Add_disacta1( c : in out d.Criteria; disacta1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disacta1", op, join, disacta1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disacta1;


   procedure Add_discora1( c : in out d.Criteria; discora1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "discora1", op, join, discora1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_discora1;


   procedure Add_gross4( c : in out d.Criteria; gross4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gross4", op, join, gross4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross4;


   procedure Add_ninrinc( c : in out d.Criteria; ninrinc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninrinc", op, join, ninrinc );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninrinc;


   procedure Add_typeed2( c : in out d.Criteria; typeed2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "typeed2", op, join, typeed2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_typeed2;


   procedure Add_w45( c : in out d.Criteria; w45 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "w45", op, join, w45 );
   begin
      d.add_to_criteria( c, elem );
   end Add_w45;


   procedure Add_accmsat( c : in out d.Criteria; accmsat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "accmsat", op, join, accmsat );
   begin
      d.add_to_criteria( c, elem );
   end Add_accmsat;


   procedure Add_c2orign( c : in out d.Criteria; c2orign : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "c2orign", op, join, c2orign );
   begin
      d.add_to_criteria( c, elem );
   end Add_c2orign;


   procedure Add_calm( c : in out d.Criteria; calm : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "calm", op, join, calm );
   begin
      d.add_to_criteria( c, elem );
   end Add_calm;


   procedure Add_cbchk( c : in out d.Criteria; cbchk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "cbchk", op, join, cbchk );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbchk;


   procedure Add_claifut1( c : in out d.Criteria; claifut1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "claifut1", op, join, claifut1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut1;


   procedure Add_claifut2( c : in out d.Criteria; claifut2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "claifut2", op, join, claifut2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut2;


   procedure Add_claifut3( c : in out d.Criteria; claifut3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "claifut3", op, join, claifut3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut3;


   procedure Add_claifut4( c : in out d.Criteria; claifut4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "claifut4", op, join, claifut4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut4;


   procedure Add_claifut5( c : in out d.Criteria; claifut5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "claifut5", op, join, claifut5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut5;


   procedure Add_claifut6( c : in out d.Criteria; claifut6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "claifut6", op, join, claifut6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut6;


   procedure Add_claifut7( c : in out d.Criteria; claifut7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "claifut7", op, join, claifut7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut7;


   procedure Add_claifut8( c : in out d.Criteria; claifut8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "claifut8", op, join, claifut8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut8;


   procedure Add_commusat( c : in out d.Criteria; commusat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "commusat", op, join, commusat );
   begin
      d.add_to_criteria( c, elem );
   end Add_commusat;


   procedure Add_coptrust( c : in out d.Criteria; coptrust : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "coptrust", op, join, coptrust );
   begin
      d.add_to_criteria( c, elem );
   end Add_coptrust;


   procedure Add_depress( c : in out d.Criteria; depress : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "depress", op, join, depress );
   begin
      d.add_to_criteria( c, elem );
   end Add_depress;


   procedure Add_disben1( c : in out d.Criteria; disben1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disben1", op, join, disben1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disben1;


   procedure Add_disben2( c : in out d.Criteria; disben2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disben2", op, join, disben2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disben2;


   procedure Add_disben3( c : in out d.Criteria; disben3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disben3", op, join, disben3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disben3;


   procedure Add_disben4( c : in out d.Criteria; disben4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disben4", op, join, disben4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disben4;


   procedure Add_disben5( c : in out d.Criteria; disben5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disben5", op, join, disben5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disben5;


   procedure Add_disben6( c : in out d.Criteria; disben6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "disben6", op, join, disben6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_disben6;


   procedure Add_discuss( c : in out d.Criteria; discuss : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "discuss", op, join, discuss );
   begin
      d.add_to_criteria( c, elem );
   end Add_discuss;


   procedure Add_dla1( c : in out d.Criteria; dla1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dla1", op, join, dla1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dla1;


   procedure Add_dla2( c : in out d.Criteria; dla2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dla2", op, join, dla2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_dla2;


   procedure Add_dls( c : in out d.Criteria; dls : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dls", op, join, dls );
   begin
      d.add_to_criteria( c, elem );
   end Add_dls;


   procedure Add_dlsamt( c : in out d.Criteria; dlsamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dlsamt", op, join, Long_Float( dlsamt ) );
   begin
      d.add_to_criteria( c, elem );
   end Add_dlsamt;


   procedure Add_dlspd( c : in out d.Criteria; dlspd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dlspd", op, join, dlspd );
   begin
      d.add_to_criteria( c, elem );
   end Add_dlspd;


   procedure Add_dlsval( c : in out d.Criteria; dlsval : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dlsval", op, join, dlsval );
   begin
      d.add_to_criteria( c, elem );
   end Add_dlsval;


   procedure Add_down( c : in out d.Criteria; down : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "down", op, join, down );
   begin
      d.add_to_criteria( c, elem );
   end Add_down;


   procedure Add_envirsat( c : in out d.Criteria; envirsat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "envirsat", op, join, envirsat );
   begin
      d.add_to_criteria( c, elem );
   end Add_envirsat;


   procedure Add_gpispc( c : in out d.Criteria; gpispc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gpispc", op, join, gpispc );
   begin
      d.add_to_criteria( c, elem );
   end Add_gpispc;


   procedure Add_gpjsaesa( c : in out d.Criteria; gpjsaesa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gpjsaesa", op, join, gpjsaesa );
   begin
      d.add_to_criteria( c, elem );
   end Add_gpjsaesa;


   procedure Add_happy( c : in out d.Criteria; happy : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "happy", op, join, happy );
   begin
      d.add_to_criteria( c, elem );
   end Add_happy;


   procedure Add_help( c : in out d.Criteria; help : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "help", op, join, help );
   begin
      d.add_to_criteria( c, elem );
   end Add_help;


   procedure Add_iclaim1( c : in out d.Criteria; iclaim1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iclaim1", op, join, iclaim1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim1;


   procedure Add_iclaim2( c : in out d.Criteria; iclaim2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iclaim2", op, join, iclaim2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim2;


   procedure Add_iclaim3( c : in out d.Criteria; iclaim3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iclaim3", op, join, iclaim3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim3;


   procedure Add_iclaim4( c : in out d.Criteria; iclaim4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iclaim4", op, join, iclaim4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim4;


   procedure Add_iclaim5( c : in out d.Criteria; iclaim5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iclaim5", op, join, iclaim5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim5;


   procedure Add_iclaim6( c : in out d.Criteria; iclaim6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iclaim6", op, join, iclaim6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim6;


   procedure Add_iclaim7( c : in out d.Criteria; iclaim7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iclaim7", op, join, iclaim7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim7;


   procedure Add_iclaim8( c : in out d.Criteria; iclaim8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iclaim8", op, join, iclaim8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim8;


   procedure Add_iclaim9( c : in out d.Criteria; iclaim9 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "iclaim9", op, join, iclaim9 );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim9;


   procedure Add_jobsat( c : in out d.Criteria; jobsat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "jobsat", op, join, jobsat );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobsat;


   procedure Add_kidben1( c : in out d.Criteria; kidben1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidben1", op, join, kidben1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidben1;


   procedure Add_kidben2( c : in out d.Criteria; kidben2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidben2", op, join, kidben2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidben2;


   procedure Add_kidben3( c : in out d.Criteria; kidben3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "kidben3", op, join, kidben3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidben3;


   procedure Add_legltrus( c : in out d.Criteria; legltrus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "legltrus", op, join, legltrus );
   begin
      d.add_to_criteria( c, elem );
   end Add_legltrus;


   procedure Add_lifesat( c : in out d.Criteria; lifesat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "lifesat", op, join, lifesat );
   begin
      d.add_to_criteria( c, elem );
   end Add_lifesat;


   procedure Add_meaning( c : in out d.Criteria; meaning : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "meaning", op, join, meaning );
   begin
      d.add_to_criteria( c, elem );
   end Add_meaning;


   procedure Add_moneysat( c : in out d.Criteria; moneysat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "moneysat", op, join, moneysat );
   begin
      d.add_to_criteria( c, elem );
   end Add_moneysat;


   procedure Add_nervous( c : in out d.Criteria; nervous : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "nervous", op, join, nervous );
   begin
      d.add_to_criteria( c, elem );
   end Add_nervous;


   procedure Add_ni2train( c : in out d.Criteria; ni2train : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ni2train", op, join, ni2train );
   begin
      d.add_to_criteria( c, elem );
   end Add_ni2train;


   procedure Add_othben1( c : in out d.Criteria; othben1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othben1", op, join, othben1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othben1;


   procedure Add_othben2( c : in out d.Criteria; othben2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othben2", op, join, othben2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othben2;


   procedure Add_othben3( c : in out d.Criteria; othben3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othben3", op, join, othben3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othben3;


   procedure Add_othben4( c : in out d.Criteria; othben4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othben4", op, join, othben4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othben4;


   procedure Add_othben5( c : in out d.Criteria; othben5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othben5", op, join, othben5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othben5;


   procedure Add_othben6( c : in out d.Criteria; othben6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othben6", op, join, othben6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_othben6;


   procedure Add_othtrust( c : in out d.Criteria; othtrust : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "othtrust", op, join, othtrust );
   begin
      d.add_to_criteria( c, elem );
   end Add_othtrust;


   procedure Add_penben1( c : in out d.Criteria; penben1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penben1", op, join, penben1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penben1;


   procedure Add_penben2( c : in out d.Criteria; penben2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penben2", op, join, penben2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penben2;


   procedure Add_penben3( c : in out d.Criteria; penben3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penben3", op, join, penben3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penben3;


   procedure Add_penben4( c : in out d.Criteria; penben4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penben4", op, join, penben4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penben4;


   procedure Add_penben5( c : in out d.Criteria; penben5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penben5", op, join, penben5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penben5;


   procedure Add_pip1( c : in out d.Criteria; pip1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pip1", op, join, pip1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_pip1;


   procedure Add_pip2( c : in out d.Criteria; pip2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "pip2", op, join, pip2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_pip2;


   procedure Add_polttrus( c : in out d.Criteria; polttrus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "polttrus", op, join, polttrus );
   begin
      d.add_to_criteria( c, elem );
   end Add_polttrus;


   procedure Add_recsat( c : in out d.Criteria; recsat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "recsat", op, join, recsat );
   begin
      d.add_to_criteria( c, elem );
   end Add_recsat;


   procedure Add_relasat( c : in out d.Criteria; relasat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "relasat", op, join, relasat );
   begin
      d.add_to_criteria( c, elem );
   end Add_relasat;


   procedure Add_safe( c : in out d.Criteria; safe : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "safe", op, join, safe );
   begin
      d.add_to_criteria( c, elem );
   end Add_safe;


   procedure Add_socfund1( c : in out d.Criteria; socfund1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "socfund1", op, join, socfund1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_socfund1;


   procedure Add_socfund2( c : in out d.Criteria; socfund2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "socfund2", op, join, socfund2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_socfund2;


   procedure Add_socfund3( c : in out d.Criteria; socfund3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "socfund3", op, join, socfund3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_socfund3;


   procedure Add_socfund4( c : in out d.Criteria; socfund4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "socfund4", op, join, socfund4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_socfund4;


   procedure Add_srispc( c : in out d.Criteria; srispc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "srispc", op, join, srispc );
   begin
      d.add_to_criteria( c, elem );
   end Add_srispc;


   procedure Add_srjsaesa( c : in out d.Criteria; srjsaesa : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "srjsaesa", op, join, srjsaesa );
   begin
      d.add_to_criteria( c, elem );
   end Add_srjsaesa;


   procedure Add_timesat( c : in out d.Criteria; timesat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "timesat", op, join, timesat );
   begin
      d.add_to_criteria( c, elem );
   end Add_timesat;


   procedure Add_train2( c : in out d.Criteria; train2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "train2", op, join, train2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_train2;


   procedure Add_trnallow( c : in out d.Criteria; trnallow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "trnallow", op, join, trnallow );
   begin
      d.add_to_criteria( c, elem );
   end Add_trnallow;


   procedure Add_wageben1( c : in out d.Criteria; wageben1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wageben1", op, join, wageben1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben1;


   procedure Add_wageben2( c : in out d.Criteria; wageben2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wageben2", op, join, wageben2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben2;


   procedure Add_wageben3( c : in out d.Criteria; wageben3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wageben3", op, join, wageben3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben3;


   procedure Add_wageben4( c : in out d.Criteria; wageben4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wageben4", op, join, wageben4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben4;


   procedure Add_wageben5( c : in out d.Criteria; wageben5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wageben5", op, join, wageben5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben5;


   procedure Add_wageben6( c : in out d.Criteria; wageben6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wageben6", op, join, wageben6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben6;


   procedure Add_wageben7( c : in out d.Criteria; wageben7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wageben7", op, join, wageben7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben7;


   procedure Add_wageben8( c : in out d.Criteria; wageben8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "wageben8", op, join, wageben8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben8;


   procedure Add_ninnirbn( c : in out d.Criteria; ninnirbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninnirbn", op, join, ninnirbn );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninnirbn;


   procedure Add_ninothbn( c : in out d.Criteria; ninothbn : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ninothbn", op, join, ninothbn );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninothbn;


   procedure Add_anxious( c : in out d.Criteria; anxious : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "anxious", op, join, anxious );
   begin
      d.add_to_criteria( c, elem );
   end Add_anxious;


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


   procedure Add_dvhiqual( c : in out d.Criteria; dvhiqual : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "dvhiqual", op, join, dvhiqual );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvhiqual;


   procedure Add_gnvqnow( c : in out d.Criteria; gnvqnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gnvqnow", op, join, gnvqnow );
   begin
      d.add_to_criteria( c, elem );
   end Add_gnvqnow;


   procedure Add_gpuc( c : in out d.Criteria; gpuc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "gpuc", op, join, gpuc );
   begin
      d.add_to_criteria( c, elem );
   end Add_gpuc;


   procedure Add_happywb( c : in out d.Criteria; happywb : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "happywb", op, join, happywb );
   begin
      d.add_to_criteria( c, elem );
   end Add_happywb;


   procedure Add_hi1qual7( c : in out d.Criteria; hi1qual7 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hi1qual7", op, join, hi1qual7 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual7;


   procedure Add_hi1qual8( c : in out d.Criteria; hi1qual8 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "hi1qual8", op, join, hi1qual8 );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual8;


   procedure Add_mntarr5( c : in out d.Criteria; mntarr5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntarr5", op, join, mntarr5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntarr5;


   procedure Add_mntnoch1( c : in out d.Criteria; mntnoch1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntnoch1", op, join, mntnoch1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntnoch1;


   procedure Add_mntnoch2( c : in out d.Criteria; mntnoch2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntnoch2", op, join, mntnoch2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntnoch2;


   procedure Add_mntnoch3( c : in out d.Criteria; mntnoch3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntnoch3", op, join, mntnoch3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntnoch3;


   procedure Add_mntnoch4( c : in out d.Criteria; mntnoch4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntnoch4", op, join, mntnoch4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntnoch4;


   procedure Add_mntnoch5( c : in out d.Criteria; mntnoch5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntnoch5", op, join, mntnoch5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntnoch5;


   procedure Add_mntpro1( c : in out d.Criteria; mntpro1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntpro1", op, join, mntpro1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntpro1;


   procedure Add_mntpro2( c : in out d.Criteria; mntpro2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntpro2", op, join, mntpro2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntpro2;


   procedure Add_mntpro3( c : in out d.Criteria; mntpro3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntpro3", op, join, mntpro3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntpro3;


   procedure Add_mnttim1( c : in out d.Criteria; mnttim1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mnttim1", op, join, mnttim1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mnttim1;


   procedure Add_mnttim2( c : in out d.Criteria; mnttim2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mnttim2", op, join, mnttim2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mnttim2;


   procedure Add_mnttim3( c : in out d.Criteria; mnttim3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mnttim3", op, join, mnttim3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mnttim3;


   procedure Add_mntwrk1( c : in out d.Criteria; mntwrk1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntwrk1", op, join, mntwrk1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntwrk1;


   procedure Add_mntwrk2( c : in out d.Criteria; mntwrk2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntwrk2", op, join, mntwrk2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntwrk2;


   procedure Add_mntwrk3( c : in out d.Criteria; mntwrk3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntwrk3", op, join, mntwrk3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntwrk3;


   procedure Add_mntwrk4( c : in out d.Criteria; mntwrk4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntwrk4", op, join, mntwrk4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntwrk4;


   procedure Add_mntwrk5( c : in out d.Criteria; mntwrk5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "mntwrk5", op, join, mntwrk5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntwrk5;


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


   procedure Add_sruc( c : in out d.Criteria; sruc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "sruc", op, join, sruc );
   begin
      d.add_to_criteria( c, elem );
   end Add_sruc;


   procedure Add_webacnow( c : in out d.Criteria; webacnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "webacnow", op, join, webacnow );
   begin
      d.add_to_criteria( c, elem );
   end Add_webacnow;


   procedure Add_indeth( c : in out d.Criteria; indeth : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "indeth", op, join, indeth );
   begin
      d.add_to_criteria( c, elem );
   end Add_indeth;


   procedure Add_euactive( c : in out d.Criteria; euactive : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euactive", op, join, euactive );
   begin
      d.add_to_criteria( c, elem );
   end Add_euactive;


   procedure Add_euactno( c : in out d.Criteria; euactno : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euactno", op, join, euactno );
   begin
      d.add_to_criteria( c, elem );
   end Add_euactno;


   procedure Add_euartact( c : in out d.Criteria; euartact : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euartact", op, join, euartact );
   begin
      d.add_to_criteria( c, elem );
   end Add_euartact;


   procedure Add_euaskhlp( c : in out d.Criteria; euaskhlp : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euaskhlp", op, join, euaskhlp );
   begin
      d.add_to_criteria( c, elem );
   end Add_euaskhlp;


   procedure Add_eucinema( c : in out d.Criteria; eucinema : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eucinema", op, join, eucinema );
   begin
      d.add_to_criteria( c, elem );
   end Add_eucinema;


   procedure Add_eucultur( c : in out d.Criteria; eucultur : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eucultur", op, join, eucultur );
   begin
      d.add_to_criteria( c, elem );
   end Add_eucultur;


   procedure Add_euinvol( c : in out d.Criteria; euinvol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euinvol", op, join, euinvol );
   begin
      d.add_to_criteria( c, elem );
   end Add_euinvol;


   procedure Add_eulivpe( c : in out d.Criteria; eulivpe : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eulivpe", op, join, eulivpe );
   begin
      d.add_to_criteria( c, elem );
   end Add_eulivpe;


   procedure Add_eumtfam( c : in out d.Criteria; eumtfam : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eumtfam", op, join, eumtfam );
   begin
      d.add_to_criteria( c, elem );
   end Add_eumtfam;


   procedure Add_eumtfrnd( c : in out d.Criteria; eumtfrnd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eumtfrnd", op, join, eumtfrnd );
   begin
      d.add_to_criteria( c, elem );
   end Add_eumtfrnd;


   procedure Add_eusocnet( c : in out d.Criteria; eusocnet : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eusocnet", op, join, eusocnet );
   begin
      d.add_to_criteria( c, elem );
   end Add_eusocnet;


   procedure Add_eusport( c : in out d.Criteria; eusport : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eusport", op, join, eusport );
   begin
      d.add_to_criteria( c, elem );
   end Add_eusport;


   procedure Add_eutkfam( c : in out d.Criteria; eutkfam : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eutkfam", op, join, eutkfam );
   begin
      d.add_to_criteria( c, elem );
   end Add_eutkfam;


   procedure Add_eutkfrnd( c : in out d.Criteria; eutkfrnd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eutkfrnd", op, join, eutkfrnd );
   begin
      d.add_to_criteria( c, elem );
   end Add_eutkfrnd;


   procedure Add_eutkmat( c : in out d.Criteria; eutkmat : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "eutkmat", op, join, eutkmat );
   begin
      d.add_to_criteria( c, elem );
   end Add_eutkmat;


   procedure Add_euvol( c : in out d.Criteria; euvol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "euvol", op, join, euvol );
   begin
      d.add_to_criteria( c, elem );
   end Add_euvol;


   procedure Add_natscot( c : in out d.Criteria; natscot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "natscot", op, join, natscot );
   begin
      d.add_to_criteria( c, elem );
   end Add_natscot;


   procedure Add_ntsctnow( c : in out d.Criteria; ntsctnow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "ntsctnow", op, join, ntsctnow );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntsctnow;


   procedure Add_penwel1( c : in out d.Criteria; penwel1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penwel1", op, join, penwel1 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penwel1;


   procedure Add_penwel2( c : in out d.Criteria; penwel2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penwel2", op, join, penwel2 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penwel2;


   procedure Add_penwel3( c : in out d.Criteria; penwel3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penwel3", op, join, penwel3 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penwel3;


   procedure Add_penwel4( c : in out d.Criteria; penwel4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penwel4", op, join, penwel4 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penwel4;


   procedure Add_penwel5( c : in out d.Criteria; penwel5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penwel5", op, join, penwel5 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penwel5;


   procedure Add_penwel6( c : in out d.Criteria; penwel6 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "penwel6", op, join, penwel6 );
   begin
      d.add_to_criteria( c, elem );
   end Add_penwel6;


   procedure Add_skiwknow( c : in out d.Criteria; skiwknow : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "skiwknow", op, join, skiwknow );
   begin
      d.add_to_criteria( c, elem );
   end Add_skiwknow;


   procedure Add_skiwrk( c : in out d.Criteria; skiwrk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "skiwrk", op, join, skiwrk );
   begin
      d.add_to_criteria( c, elem );
   end Add_skiwrk;


   procedure Add_slos( c : in out d.Criteria; slos : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "slos", op, join, slos );
   begin
      d.add_to_criteria( c, elem );
   end Add_slos;


   procedure Add_yjblev( c : in out d.Criteria; yjblev : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and ) is   
   elem : d.Criterion := d.Make_Criterion_Element( "yjblev", op, join, yjblev );
   begin
      d.add_to_criteria( c, elem );
   end Add_yjblev;


   
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


   procedure Add_abs1no_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "abs1no", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_abs1no_To_Orderings;


   procedure Add_abs2no_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "abs2no", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_abs2no_To_Orderings;


   procedure Add_abspar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "abspar", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_abspar_To_Orderings;


   procedure Add_abspay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "abspay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_abspay_To_Orderings;


   procedure Add_abswhy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "abswhy", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_abswhy_To_Orderings;


   procedure Add_abswk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "abswk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_abswk_To_Orderings;


   procedure Add_x_access_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "x_access", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_x_access_To_Orderings;


   procedure Add_accftpt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accftpt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accftpt_To_Orderings;


   procedure Add_accjb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accjb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accjb_To_Orderings;


   procedure Add_accssamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accssamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accssamt_To_Orderings;


   procedure Add_accsspd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accsspd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accsspd_To_Orderings;


   procedure Add_adeduc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adeduc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adeduc_To_Orderings;


   procedure Add_adema_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "adema", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_adema_To_Orderings;


   procedure Add_ademaamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ademaamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ademaamt_To_Orderings;


   procedure Add_ademapd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ademapd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ademapd_To_Orderings;


   procedure Add_age_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age_To_Orderings;


   procedure Add_allow1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "allow1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_allow1_To_Orderings;


   procedure Add_allow2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "allow2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_allow2_To_Orderings;


   procedure Add_allow3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "allow3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_allow3_To_Orderings;


   procedure Add_allow4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "allow4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_allow4_To_Orderings;


   procedure Add_allpay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "allpay1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpay1_To_Orderings;


   procedure Add_allpay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "allpay2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpay2_To_Orderings;


   procedure Add_allpay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "allpay3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpay3_To_Orderings;


   procedure Add_allpay4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "allpay4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpay4_To_Orderings;


   procedure Add_allpd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "allpd1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpd1_To_Orderings;


   procedure Add_allpd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "allpd2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpd2_To_Orderings;


   procedure Add_allpd3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "allpd3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpd3_To_Orderings;


   procedure Add_allpd4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "allpd4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_allpd4_To_Orderings;


   procedure Add_anyacc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "anyacc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_anyacc_To_Orderings;


   procedure Add_anyed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "anyed", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_anyed_To_Orderings;


   procedure Add_anymon_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "anymon", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_anymon_To_Orderings;


   procedure Add_anypen1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "anypen1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen1_To_Orderings;


   procedure Add_anypen2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "anypen2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen2_To_Orderings;


   procedure Add_anypen3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "anypen3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen3_To_Orderings;


   procedure Add_anypen4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "anypen4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen4_To_Orderings;


   procedure Add_anypen5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "anypen5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen5_To_Orderings;


   procedure Add_anypen6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "anypen6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen6_To_Orderings;


   procedure Add_anypen7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "anypen7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_anypen7_To_Orderings;


   procedure Add_apamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "apamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_apamt_To_Orderings;


   procedure Add_apdamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "apdamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_apdamt_To_Orderings;


   procedure Add_apdir_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "apdir", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_apdir_To_Orderings;


   procedure Add_apdpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "apdpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_apdpd_To_Orderings;


   procedure Add_appd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "appd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_appd_To_Orderings;


   procedure Add_b2qfut1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "b2qfut1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_b2qfut1_To_Orderings;


   procedure Add_b2qfut2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "b2qfut2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_b2qfut2_To_Orderings;


   procedure Add_b2qfut3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "b2qfut3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_b2qfut3_To_Orderings;


   procedure Add_b3qfut1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "b3qfut1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut1_To_Orderings;


   procedure Add_b3qfut2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "b3qfut2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut2_To_Orderings;


   procedure Add_b3qfut3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "b3qfut3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut3_To_Orderings;


   procedure Add_b3qfut4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "b3qfut4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut4_To_Orderings;


   procedure Add_b3qfut5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "b3qfut5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut5_To_Orderings;


   procedure Add_b3qfut6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "b3qfut6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut6_To_Orderings;


   procedure Add_ben1q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben1q1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q1_To_Orderings;


   procedure Add_ben1q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben1q2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q2_To_Orderings;


   procedure Add_ben1q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben1q3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q3_To_Orderings;


   procedure Add_ben1q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben1q4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q4_To_Orderings;


   procedure Add_ben1q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben1q5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q5_To_Orderings;


   procedure Add_ben1q6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben1q6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q6_To_Orderings;


   procedure Add_ben1q7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben1q7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben1q7_To_Orderings;


   procedure Add_ben2q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben2q1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben2q1_To_Orderings;


   procedure Add_ben2q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben2q2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben2q2_To_Orderings;


   procedure Add_ben2q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben2q3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben2q3_To_Orderings;


   procedure Add_ben3q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben3q1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q1_To_Orderings;


   procedure Add_ben3q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben3q2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q2_To_Orderings;


   procedure Add_ben3q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben3q3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q3_To_Orderings;


   procedure Add_ben3q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben3q4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q4_To_Orderings;


   procedure Add_ben3q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben3q5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q5_To_Orderings;


   procedure Add_ben3q6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben3q6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q6_To_Orderings;


   procedure Add_ben4q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben4q1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben4q1_To_Orderings;


   procedure Add_ben4q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben4q2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben4q2_To_Orderings;


   procedure Add_ben4q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben4q3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben4q3_To_Orderings;


   procedure Add_ben5q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben5q1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q1_To_Orderings;


   procedure Add_ben5q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben5q2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q2_To_Orderings;


   procedure Add_ben5q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben5q3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q3_To_Orderings;


   procedure Add_ben5q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben5q4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q4_To_Orderings;


   procedure Add_ben5q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben5q5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q5_To_Orderings;


   procedure Add_ben5q6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben5q6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q6_To_Orderings;


   procedure Add_ben7q1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben7q1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q1_To_Orderings;


   procedure Add_ben7q2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben7q2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q2_To_Orderings;


   procedure Add_ben7q3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben7q3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q3_To_Orderings;


   procedure Add_ben7q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben7q4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q4_To_Orderings;


   procedure Add_ben7q5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben7q5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q5_To_Orderings;


   procedure Add_ben7q6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben7q6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q6_To_Orderings;


   procedure Add_ben7q7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben7q7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q7_To_Orderings;


   procedure Add_ben7q8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben7q8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q8_To_Orderings;


   procedure Add_ben7q9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben7q9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben7q9_To_Orderings;


   procedure Add_btwacc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "btwacc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_btwacc_To_Orderings;


   procedure Add_claimant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "claimant", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_claimant_To_Orderings;


   procedure Add_cohabit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cohabit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cohabit_To_Orderings;


   procedure Add_combid_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "combid", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_combid_To_Orderings;


   procedure Add_convbl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "convbl", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_convbl_To_Orderings;


   procedure Add_ctclum1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctclum1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctclum1_To_Orderings;


   procedure Add_ctclum2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ctclum2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ctclum2_To_Orderings;


   procedure Add_cupchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cupchk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cupchk_To_Orderings;


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


   procedure Add_disdif1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdif1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif1_To_Orderings;


   procedure Add_disdif2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdif2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif2_To_Orderings;


   procedure Add_disdif3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdif3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif3_To_Orderings;


   procedure Add_disdif4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdif4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif4_To_Orderings;


   procedure Add_disdif5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdif5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif5_To_Orderings;


   procedure Add_disdif6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdif6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif6_To_Orderings;


   procedure Add_disdif7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdif7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif7_To_Orderings;


   procedure Add_disdif8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdif8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif8_To_Orderings;


   procedure Add_dob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dob", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dob_To_Orderings;


   procedure Add_dptcboth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dptcboth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dptcboth_To_Orderings;


   procedure Add_dptclum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dptclum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dptclum_To_Orderings;


   procedure Add_dvil03a_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dvil03a", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvil03a_To_Orderings;


   procedure Add_dvil04a_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dvil04a", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvil04a_To_Orderings;


   procedure Add_dvjb12ml_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dvjb12ml", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvjb12ml_To_Orderings;


   procedure Add_dvmardf_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dvmardf", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvmardf_To_Orderings;


   procedure Add_ed1amt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ed1amt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed1amt_To_Orderings;


   procedure Add_ed1borr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ed1borr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed1borr_To_Orderings;


   procedure Add_ed1int_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ed1int", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed1int_To_Orderings;


   procedure Add_ed1monyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ed1monyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed1monyr_To_Orderings;


   procedure Add_ed1pd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ed1pd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed1pd_To_Orderings;


   procedure Add_ed1sum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ed1sum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed1sum_To_Orderings;


   procedure Add_ed2amt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ed2amt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed2amt_To_Orderings;


   procedure Add_ed2borr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ed2borr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed2borr_To_Orderings;


   procedure Add_ed2int_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ed2int", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed2int_To_Orderings;


   procedure Add_ed2monyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ed2monyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed2monyr_To_Orderings;


   procedure Add_ed2pd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ed2pd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed2pd_To_Orderings;


   procedure Add_ed2sum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ed2sum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ed2sum_To_Orderings;


   procedure Add_edatt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edatt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_edatt_To_Orderings;


   procedure Add_edattn1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edattn1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_edattn1_To_Orderings;


   procedure Add_edattn2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edattn2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_edattn2_To_Orderings;


   procedure Add_edattn3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edattn3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_edattn3_To_Orderings;


   procedure Add_edhr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edhr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_edhr_To_Orderings;


   procedure Add_edtime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edtime", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_edtime_To_Orderings;


   procedure Add_edtyp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "edtyp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_edtyp_To_Orderings;


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


   procedure Add_emppay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "emppay1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_emppay1_To_Orderings;


   procedure Add_emppay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "emppay2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_emppay2_To_Orderings;


   procedure Add_emppay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "emppay3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_emppay3_To_Orderings;


   procedure Add_empstat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "empstat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_empstat_To_Orderings;


   procedure Add_endyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "endyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_endyr_To_Orderings;


   procedure Add_epcur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "epcur", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_epcur_To_Orderings;


   procedure Add_es2000_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "es2000", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_es2000_To_Orderings;


   procedure Add_ethgrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ethgrp_To_Orderings;


   procedure Add_everwrk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "everwrk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_everwrk_To_Orderings;


   procedure Add_exthbct1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "exthbct1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_exthbct1_To_Orderings;


   procedure Add_exthbct2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "exthbct2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_exthbct2_To_Orderings;


   procedure Add_exthbct3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "exthbct3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_exthbct3_To_Orderings;


   procedure Add_eyetest_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eyetest", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eyetest_To_Orderings;


   procedure Add_follow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "follow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_follow_To_Orderings;


   procedure Add_fted_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fted", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fted_To_Orderings;


   procedure Add_ftwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ftwk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ftwk_To_Orderings;


   procedure Add_future_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "future", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_future_To_Orderings;


   procedure Add_govpis_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "govpis", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_govpis_To_Orderings;


   procedure Add_govpjsa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "govpjsa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_govpjsa_To_Orderings;


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


   procedure Add_gta_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gta", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gta_To_Orderings;


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


   procedure Add_hbotwait_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbotwait", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbotwait_To_Orderings;


   procedure Add_health_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "health", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_health_To_Orderings;


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


   procedure Add_hprob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hprob", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hprob_To_Orderings;


   procedure Add_hrpid_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hrpid", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hrpid_To_Orderings;


   procedure Add_incdur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incdur", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incdur_To_Orderings;


   procedure Add_injlong_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "injlong", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_injlong_To_Orderings;


   procedure Add_injwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "injwk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_injwk_To_Orderings;


   procedure Add_invests_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "invests", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_invests_To_Orderings;


   procedure Add_iout_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iout", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iout_To_Orderings;


   procedure Add_isa1type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "isa1type", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_isa1type_To_Orderings;


   procedure Add_isa2type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "isa2type", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_isa2type_To_Orderings;


   procedure Add_isa3type_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "isa3type", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_isa3type_To_Orderings;


   procedure Add_jobaway_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "jobaway", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobaway_To_Orderings;


   procedure Add_lareg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lareg", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lareg_To_Orderings;


   procedure Add_likewk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "likewk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_likewk_To_Orderings;


   procedure Add_lktime_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lktime", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lktime_To_Orderings;


   procedure Add_ln1rpint_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ln1rpint", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ln1rpint_To_Orderings;


   procedure Add_ln2rpint_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ln2rpint", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ln2rpint_To_Orderings;


   procedure Add_loan_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "loan", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_loan_To_Orderings;


   procedure Add_loannum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "loannum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_loannum_To_Orderings;


   procedure Add_look_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "look", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_look_To_Orderings;


   procedure Add_lookwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lookwk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lookwk_To_Orderings;


   procedure Add_lstwrk1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lstwrk1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lstwrk1_To_Orderings;


   procedure Add_lstwrk2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lstwrk2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lstwrk2_To_Orderings;


   procedure Add_lstyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lstyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lstyr_To_Orderings;


   procedure Add_mntamt1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntamt1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntamt1_To_Orderings;


   procedure Add_mntamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntamt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntamt2_To_Orderings;


   procedure Add_mntct_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntct", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntct_To_Orderings;


   procedure Add_mntfor1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntfor1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntfor1_To_Orderings;


   procedure Add_mntfor2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntfor2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntfor2_To_Orderings;


   procedure Add_mntgov1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntgov1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntgov1_To_Orderings;


   procedure Add_mntgov2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntgov2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntgov2_To_Orderings;


   procedure Add_mntpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntpay_To_Orderings;


   procedure Add_mntpd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntpd1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntpd1_To_Orderings;


   procedure Add_mntpd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntpd2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntpd2_To_Orderings;


   procedure Add_mntrec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntrec", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntrec_To_Orderings;


   procedure Add_mnttota1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mnttota1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mnttota1_To_Orderings;


   procedure Add_mnttota2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mnttota2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mnttota2_To_Orderings;


   procedure Add_mntus1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntus1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntus1_To_Orderings;


   procedure Add_mntus2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntus2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntus2_To_Orderings;


   procedure Add_mntusam1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntusam1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntusam1_To_Orderings;


   procedure Add_mntusam2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntusam2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntusam2_To_Orderings;


   procedure Add_mntuspd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntuspd1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntuspd1_To_Orderings;


   procedure Add_mntuspd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntuspd2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntuspd2_To_Orderings;


   procedure Add_ms_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ms", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ms_To_Orderings;


   procedure Add_natid1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "natid1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_natid1_To_Orderings;


   procedure Add_natid2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "natid2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_natid2_To_Orderings;


   procedure Add_natid3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "natid3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_natid3_To_Orderings;


   procedure Add_natid4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "natid4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_natid4_To_Orderings;


   procedure Add_natid5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "natid5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_natid5_To_Orderings;


   procedure Add_natid6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "natid6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_natid6_To_Orderings;


   procedure Add_ndeal_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ndeal", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ndeal_To_Orderings;


   procedure Add_newdtype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "newdtype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_newdtype_To_Orderings;


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


   procedure Add_niamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "niamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_niamt_To_Orderings;


   procedure Add_niethgrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "niethgrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_niethgrp_To_Orderings;


   procedure Add_niexthbb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "niexthbb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_niexthbb_To_Orderings;


   procedure Add_ninatid1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninatid1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid1_To_Orderings;


   procedure Add_ninatid2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninatid2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid2_To_Orderings;


   procedure Add_ninatid3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninatid3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid3_To_Orderings;


   procedure Add_ninatid4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninatid4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid4_To_Orderings;


   procedure Add_ninatid5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninatid5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid5_To_Orderings;


   procedure Add_ninatid6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninatid6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid6_To_Orderings;


   procedure Add_ninatid7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninatid7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid7_To_Orderings;


   procedure Add_ninatid8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninatid8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninatid8_To_Orderings;


   procedure Add_nipd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nipd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nipd_To_Orderings;


   procedure Add_nireg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nireg", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nireg_To_Orderings;


   procedure Add_nirel_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nirel", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nirel_To_Orderings;


   procedure Add_nitrain_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nitrain", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nitrain_To_Orderings;


   procedure Add_nlper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nlper", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nlper_To_Orderings;


   procedure Add_nolk1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nolk1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nolk1_To_Orderings;


   procedure Add_nolk2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nolk2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nolk2_To_Orderings;


   procedure Add_nolk3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nolk3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nolk3_To_Orderings;


   procedure Add_nolook_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nolook", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nolook_To_Orderings;


   procedure Add_nowant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nowant", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nowant_To_Orderings;


   procedure Add_nssec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nssec", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nssec_To_Orderings;


   procedure Add_ntcapp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ntcapp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcapp_To_Orderings;


   procedure Add_ntcdat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ntcdat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcdat_To_Orderings;


   procedure Add_ntcinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ntcinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcinc_To_Orderings;


   procedure Add_ntcorig1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ntcorig1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcorig1_To_Orderings;


   procedure Add_ntcorig2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ntcorig2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcorig2_To_Orderings;


   procedure Add_ntcorig3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ntcorig3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcorig3_To_Orderings;


   procedure Add_ntcorig4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ntcorig4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcorig4_To_Orderings;


   procedure Add_ntcorig5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ntcorig5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntcorig5_To_Orderings;


   procedure Add_numjob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numjob", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numjob_To_Orderings;


   procedure Add_numjob2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "numjob2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_numjob2_To_Orderings;


   procedure Add_oddjob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oddjob", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oddjob_To_Orderings;


   procedure Add_oldstud_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oldstud", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oldstud_To_Orderings;


   procedure Add_otabspar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "otabspar", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_otabspar_To_Orderings;


   procedure Add_otamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "otamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_otamt_To_Orderings;


   procedure Add_otapamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "otapamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_otapamt_To_Orderings;


   procedure Add_otappd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "otappd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_otappd_To_Orderings;


   procedure Add_othtax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othtax", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othtax_To_Orderings;


   procedure Add_otinva_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "otinva", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_otinva_To_Orderings;


   procedure Add_pareamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pareamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pareamt_To_Orderings;


   procedure Add_parepd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "parepd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_parepd_To_Orderings;


   procedure Add_penlump_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penlump", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penlump_To_Orderings;


   procedure Add_ppnumc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ppnumc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ppnumc_To_Orderings;


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


   procedure Add_ptwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ptwk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ptwk_To_Orderings;


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


   procedure Add_redamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "redamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_redamt_To_Orderings;


   procedure Add_redany_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "redany", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_redany_To_Orderings;


   procedure Add_rentprof_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rentprof", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rentprof_To_Orderings;


   procedure Add_retire_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "retire", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_retire_To_Orderings;


   procedure Add_retire1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "retire1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_retire1_To_Orderings;


   procedure Add_retreas_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "retreas", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_retreas_To_Orderings;


   procedure Add_royal1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "royal1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_royal1_To_Orderings;


   procedure Add_royal2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "royal2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_royal2_To_Orderings;


   procedure Add_royal3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "royal3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_royal3_To_Orderings;


   procedure Add_royal4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "royal4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_royal4_To_Orderings;


   procedure Add_royyr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "royyr1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_royyr1_To_Orderings;


   procedure Add_royyr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "royyr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_royyr2_To_Orderings;


   procedure Add_royyr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "royyr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_royyr3_To_Orderings;


   procedure Add_royyr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "royyr4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_royyr4_To_Orderings;


   procedure Add_rstrct_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rstrct", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rstrct_To_Orderings;


   procedure Add_sex_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sex", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sex_To_Orderings;


   procedure Add_sflntyp1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sflntyp1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sflntyp1_To_Orderings;


   procedure Add_sflntyp2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sflntyp2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sflntyp2_To_Orderings;


   procedure Add_sftype1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sftype1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sftype1_To_Orderings;


   procedure Add_sftype2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sftype2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sftype2_To_Orderings;


   procedure Add_sic_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sic", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sic_To_Orderings;


   procedure Add_slrepamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "slrepamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_slrepamt_To_Orderings;


   procedure Add_slrepay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "slrepay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_slrepay_To_Orderings;


   procedure Add_slreppd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "slreppd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_slreppd_To_Orderings;


   procedure Add_soc2000_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "soc2000", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_soc2000_To_Orderings;


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


   procedure Add_start_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "start", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_start_To_Orderings;


   procedure Add_startyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "startyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_startyr_To_Orderings;


   procedure Add_taxcred1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxcred1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxcred1_To_Orderings;


   procedure Add_taxcred2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxcred2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxcred2_To_Orderings;


   procedure Add_taxcred3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxcred3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxcred3_To_Orderings;


   procedure Add_taxcred4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxcred4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxcred4_To_Orderings;


   procedure Add_taxcred5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxcred5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxcred5_To_Orderings;


   procedure Add_taxfut_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxfut", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxfut_To_Orderings;


   procedure Add_tdaywrk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tdaywrk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tdaywrk_To_Orderings;


   procedure Add_tea_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tea", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tea_To_Orderings;


   procedure Add_topupl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "topupl", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_topupl_To_Orderings;


   procedure Add_totint_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totint", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totint_To_Orderings;


   procedure Add_train_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "train", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_train_To_Orderings;


   procedure Add_trav_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "trav", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_trav_To_Orderings;


   procedure Add_tuborr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tuborr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tuborr_To_Orderings;


   procedure Add_typeed_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "typeed", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_typeed_To_Orderings;


   procedure Add_unpaid1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "unpaid1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_unpaid1_To_Orderings;


   procedure Add_unpaid2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "unpaid2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_unpaid2_To_Orderings;


   procedure Add_voucher_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "voucher", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_voucher_To_Orderings;


   procedure Add_w1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "w1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_w1_To_Orderings;


   procedure Add_w2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "w2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_w2_To_Orderings;


   procedure Add_wait_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wait", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wait_To_Orderings;


   procedure Add_war1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "war1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_war1_To_Orderings;


   procedure Add_war2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "war2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_war2_To_Orderings;


   procedure Add_wftcboth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wftcboth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wftcboth_To_Orderings;


   procedure Add_wftclum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wftclum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wftclum_To_Orderings;


   procedure Add_whoresp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whoresp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whoresp_To_Orderings;


   procedure Add_whosectb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whosectb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whosectb_To_Orderings;


   procedure Add_whyfrde1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrde1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrde1_To_Orderings;


   procedure Add_whyfrde2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrde2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrde2_To_Orderings;


   procedure Add_whyfrde3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrde3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrde3_To_Orderings;


   procedure Add_whyfrde4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrde4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrde4_To_Orderings;


   procedure Add_whyfrde5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrde5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrde5_To_Orderings;


   procedure Add_whyfrde6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrde6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrde6_To_Orderings;


   procedure Add_whyfrey1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrey1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrey1_To_Orderings;


   procedure Add_whyfrey2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrey2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrey2_To_Orderings;


   procedure Add_whyfrey3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrey3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrey3_To_Orderings;


   procedure Add_whyfrey4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrey4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrey4_To_Orderings;


   procedure Add_whyfrey5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrey5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrey5_To_Orderings;


   procedure Add_whyfrey6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrey6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrey6_To_Orderings;


   procedure Add_whyfrpr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrpr1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrpr1_To_Orderings;


   procedure Add_whyfrpr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrpr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrpr2_To_Orderings;


   procedure Add_whyfrpr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrpr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrpr3_To_Orderings;


   procedure Add_whyfrpr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrpr4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrpr4_To_Orderings;


   procedure Add_whyfrpr5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrpr5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrpr5_To_Orderings;


   procedure Add_whyfrpr6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "whyfrpr6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_whyfrpr6_To_Orderings;


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


   procedure Add_wintfuel_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wintfuel", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wintfuel_To_Orderings;


   procedure Add_wmkit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wmkit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wmkit_To_Orderings;


   procedure Add_working_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "working", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_working_To_Orderings;


   procedure Add_wpa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wpa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wpa_To_Orderings;


   procedure Add_wpba_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wpba", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wpba_To_Orderings;


   procedure Add_wtclum1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wtclum1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wtclum1_To_Orderings;


   procedure Add_wtclum2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wtclum2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wtclum2_To_Orderings;


   procedure Add_wtclum3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wtclum3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wtclum3_To_Orderings;


   procedure Add_ystrtwk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ystrtwk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ystrtwk_To_Orderings;


   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "month", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_month_To_Orderings;


   procedure Add_able_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "able", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_able_To_Orderings;


   procedure Add_actacci_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "actacci", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_actacci_To_Orderings;


   procedure Add_addda_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "addda", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_addda_To_Orderings;


   procedure Add_basacti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "basacti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_basacti_To_Orderings;


   procedure Add_bntxcred_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bntxcred", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bntxcred_To_Orderings;


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


   procedure Add_curacti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "curacti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_curacti_To_Orderings;


   procedure Add_empoccp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "empoccp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_empoccp_To_Orderings;


   procedure Add_empstatb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "empstatb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_empstatb_To_Orderings;


   procedure Add_empstatc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "empstatc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_empstatc_To_Orderings;


   procedure Add_empstati_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "empstati", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_empstati_To_Orderings;


   procedure Add_fsbndcti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fsbndcti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fsbndcti_To_Orderings;


   procedure Add_fwmlkval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fwmlkval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fwmlkval_To_Orderings;


   procedure Add_gebacti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gebacti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gebacti_To_Orderings;


   procedure Add_giltcti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "giltcti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_giltcti_To_Orderings;


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


   procedure Add_hbsupran_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbsupran", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbsupran_To_Orderings;


   procedure Add_hdage_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hdage", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdage_To_Orderings;


   procedure Add_hdben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hdben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdben_To_Orderings;


   procedure Add_hdindinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hdindinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hdindinc_To_Orderings;


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


   procedure Add_hourcare_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hourcare", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hourcare_To_Orderings;


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


   procedure Add_incseo2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "incseo2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_incseo2_To_Orderings;


   procedure Add_indinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "indinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_indinc_To_Orderings;


   procedure Add_indisben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "indisben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_indisben_To_Orderings;


   procedure Add_inearns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inearns", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inearns_To_Orderings;


   procedure Add_ininv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ininv", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ininv_To_Orderings;


   procedure Add_inirben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inirben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inirben_To_Orderings;


   procedure Add_innirben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "innirben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_innirben_To_Orderings;


   procedure Add_inothben_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inothben", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inothben_To_Orderings;


   procedure Add_inpeninc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inpeninc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inpeninc_To_Orderings;


   procedure Add_inrinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inrinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inrinc_To_Orderings;


   procedure Add_inrpinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "inrpinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_inrpinc_To_Orderings;


   procedure Add_intvlic_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intvlic", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intvlic_To_Orderings;


   procedure Add_intxcred_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "intxcred", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_intxcred_To_Orderings;


   procedure Add_isacti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "isacti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_isacti_To_Orderings;


   procedure Add_marital_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "marital", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_marital_To_Orderings;


   procedure Add_netocpen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "netocpen", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_netocpen_To_Orderings;


   procedure Add_nincseo2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nincseo2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nincseo2_To_Orderings;


   procedure Add_nindinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nindinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nindinc_To_Orderings;


   procedure Add_ninearns_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninearns", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninearns_To_Orderings;


   procedure Add_nininv_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nininv", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nininv_To_Orderings;


   procedure Add_ninpenin_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninpenin", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninpenin_To_Orderings;


   procedure Add_ninsein2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninsein2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninsein2_To_Orderings;


   procedure Add_nsbocti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nsbocti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nsbocti_To_Orderings;


   procedure Add_occupnum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "occupnum", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_occupnum_To_Orderings;


   procedure Add_otbscti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "otbscti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_otbscti_To_Orderings;


   procedure Add_pepscti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pepscti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pepscti_To_Orderings;


   procedure Add_poaccti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "poaccti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_poaccti_To_Orderings;


   procedure Add_prbocti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "prbocti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_prbocti_To_Orderings;


   procedure Add_relhrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "relhrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_relhrp_To_Orderings;


   procedure Add_sayecti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sayecti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sayecti_To_Orderings;


   procedure Add_sclbcti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sclbcti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sclbcti_To_Orderings;


   procedure Add_seincam2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "seincam2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_seincam2_To_Orderings;


   procedure Add_smpadj_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "smpadj", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_smpadj_To_Orderings;


   procedure Add_sscti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sscti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sscti_To_Orderings;


   procedure Add_sspadj_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sspadj", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sspadj_To_Orderings;


   procedure Add_stshcti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "stshcti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_stshcti_To_Orderings;


   procedure Add_superan_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "superan", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_superan_To_Orderings;


   procedure Add_taxpayer_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "taxpayer", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_taxpayer_To_Orderings;


   procedure Add_tesscti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tesscti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tesscti_To_Orderings;


   procedure Add_totgrant_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totgrant", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totgrant_To_Orderings;


   procedure Add_tothours_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tothours", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tothours_To_Orderings;


   procedure Add_totoccp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "totoccp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_totoccp_To_Orderings;


   procedure Add_ttwcosts_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttwcosts", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwcosts_To_Orderings;


   procedure Add_untrcti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "untrcti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_untrcti_To_Orderings;


   procedure Add_uperson_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "uperson", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_uperson_To_Orderings;


   procedure Add_widoccp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "widoccp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_widoccp_To_Orderings;


   procedure Add_accountq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accountq", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accountq_To_Orderings;


   procedure Add_ben5q7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben5q7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q7_To_Orderings;


   procedure Add_ben5q8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben5q8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q8_To_Orderings;


   procedure Add_ben5q9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben5q9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben5q9_To_Orderings;


   procedure Add_ddatre_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ddatre", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ddatre_To_Orderings;


   procedure Add_disdif9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdif9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdif9_To_Orderings;


   procedure Add_fare_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "fare", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_fare_To_Orderings;


   procedure Add_nittwmod_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nittwmod", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nittwmod_To_Orderings;


   procedure Add_oneway_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "oneway", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_oneway_To_Orderings;


   procedure Add_pssamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pssamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pssamt_To_Orderings;


   procedure Add_pssdate_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pssdate", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pssdate_To_Orderings;


   procedure Add_ttwcode1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttwcode1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwcode1_To_Orderings;


   procedure Add_ttwcode2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttwcode2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwcode2_To_Orderings;


   procedure Add_ttwcode3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttwcode3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwcode3_To_Orderings;


   procedure Add_ttwcost_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttwcost", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwcost_To_Orderings;


   procedure Add_ttwfar_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttwfar", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwfar_To_Orderings;


   procedure Add_ttwfrq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttwfrq", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwfrq_To_Orderings;


   procedure Add_ttwmod_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttwmod", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwmod_To_Orderings;


   procedure Add_ttwpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttwpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwpay_To_Orderings;


   procedure Add_ttwpss_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttwpss", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwpss_To_Orderings;


   procedure Add_ttwrec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttwrec", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwrec_To_Orderings;


   procedure Add_chbflg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chbflg", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chbflg_To_Orderings;


   procedure Add_crunaci_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "crunaci", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_crunaci_To_Orderings;


   procedure Add_enomorti_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "enomorti", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_enomorti_To_Orderings;


   procedure Add_sapadj_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sapadj", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sapadj_To_Orderings;


   procedure Add_sppadj_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sppadj", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sppadj_To_Orderings;


   procedure Add_ttwmode_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttwmode", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttwmode_To_Orderings;


   procedure Add_ddatrep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ddatrep", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ddatrep_To_Orderings;


   procedure Add_defrpen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "defrpen", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_defrpen_To_Orderings;


   procedure Add_disdifp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdifp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdifp_To_Orderings;


   procedure Add_followup_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "followup", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_followup_To_Orderings;


   procedure Add_practice_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "practice", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_practice_To_Orderings;


   procedure Add_sfrpis_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sfrpis", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sfrpis_To_Orderings;


   procedure Add_sfrpjsa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sfrpjsa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sfrpjsa_To_Orderings;


   procedure Add_age80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "age80", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_age80_To_Orderings;


   procedure Add_ethgr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ethgr2_To_Orderings;


   procedure Add_pocardi_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pocardi", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pocardi_To_Orderings;


   procedure Add_chkdpn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chkdpn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdpn_To_Orderings;


   procedure Add_chknop_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chknop", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chknop_To_Orderings;


   procedure Add_consent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "consent", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_consent_To_Orderings;


   procedure Add_dvpens_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dvpens", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvpens_To_Orderings;


   procedure Add_eligschm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eligschm", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eligschm_To_Orderings;


   procedure Add_emparr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "emparr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_emparr_To_Orderings;


   procedure Add_emppen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "emppen", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_emppen_To_Orderings;


   procedure Add_empschm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "empschm", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_empschm_To_Orderings;


   procedure Add_lnkref1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref1_To_Orderings;


   procedure Add_lnkref2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref2_To_Orderings;


   procedure Add_lnkref21_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref21", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref21_To_Orderings;


   procedure Add_lnkref22_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref22", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref22_To_Orderings;


   procedure Add_lnkref23_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref23", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref23_To_Orderings;


   procedure Add_lnkref24_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref24", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref24_To_Orderings;


   procedure Add_lnkref25_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref25", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref25_To_Orderings;


   procedure Add_lnkref3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref3_To_Orderings;


   procedure Add_lnkref4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref4_To_Orderings;


   procedure Add_lnkref5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref5_To_Orderings;


   procedure Add_memschm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "memschm", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_memschm_To_Orderings;


   procedure Add_pconsent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pconsent", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pconsent_To_Orderings;


   procedure Add_perspen1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "perspen1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_perspen1_To_Orderings;


   procedure Add_perspen2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "perspen2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_perspen2_To_Orderings;


   procedure Add_privpen_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "privpen", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_privpen_To_Orderings;


   procedure Add_schchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "schchk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_schchk_To_Orderings;


   procedure Add_spnumc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spnumc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spnumc_To_Orderings;


   procedure Add_stakep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "stakep", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_stakep_To_Orderings;


   procedure Add_trainee_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "trainee", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_trainee_To_Orderings;


   procedure Add_lnkdwp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkdwp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkdwp_To_Orderings;


   procedure Add_lnkons_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkons", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkons_To_Orderings;


   procedure Add_lnkref6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref6_To_Orderings;


   procedure Add_lnkref7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref7_To_Orderings;


   procedure Add_lnkref8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref8_To_Orderings;


   procedure Add_lnkref9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref9_To_Orderings;


   procedure Add_tcever1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tcever1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcever1_To_Orderings;


   procedure Add_tcever2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tcever2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcever2_To_Orderings;


   procedure Add_tcrepay1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tcrepay1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcrepay1_To_Orderings;


   procedure Add_tcrepay2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tcrepay2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcrepay2_To_Orderings;


   procedure Add_tcrepay3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tcrepay3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcrepay3_To_Orderings;


   procedure Add_tcrepay4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tcrepay4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcrepay4_To_Orderings;


   procedure Add_tcrepay5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tcrepay5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcrepay5_To_Orderings;


   procedure Add_tcrepay6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tcrepay6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcrepay6_To_Orderings;


   procedure Add_tcthsyr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tcthsyr1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcthsyr1_To_Orderings;


   procedure Add_tcthsyr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tcthsyr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tcthsyr2_To_Orderings;


   procedure Add_currjobm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "currjobm", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_currjobm_To_Orderings;


   procedure Add_prevjobm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "prevjobm", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_prevjobm_To_Orderings;


   procedure Add_b3qfut7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "b3qfut7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_b3qfut7_To_Orderings;


   procedure Add_ben3q7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben3q7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben3q7_To_Orderings;


   procedure Add_camemt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "camemt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_camemt_To_Orderings;


   procedure Add_cameyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cameyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cameyr_To_Orderings;


   procedure Add_cameyr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cameyr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cameyr2_To_Orderings;


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


   procedure Add_ddaprog_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ddaprog", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ddaprog_To_Orderings;


   procedure Add_hbolng_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hbolng", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hbolng_To_Orderings;


   procedure Add_hi1qual1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hi1qual1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual1_To_Orderings;


   procedure Add_hi1qual2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hi1qual2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual2_To_Orderings;


   procedure Add_hi1qual3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hi1qual3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual3_To_Orderings;


   procedure Add_hi1qual4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hi1qual4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual4_To_Orderings;


   procedure Add_hi1qual5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hi1qual5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual5_To_Orderings;


   procedure Add_hi1qual6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hi1qual6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual6_To_Orderings;


   procedure Add_hi2qual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hi2qual", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi2qual_To_Orderings;


   procedure Add_hlpgvn01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlpgvn01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn01_To_Orderings;


   procedure Add_hlpgvn02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlpgvn02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn02_To_Orderings;


   procedure Add_hlpgvn03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlpgvn03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn03_To_Orderings;


   procedure Add_hlpgvn04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlpgvn04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn04_To_Orderings;


   procedure Add_hlpgvn05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlpgvn05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn05_To_Orderings;


   procedure Add_hlpgvn06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlpgvn06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn06_To_Orderings;


   procedure Add_hlpgvn07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlpgvn07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn07_To_Orderings;


   procedure Add_hlpgvn08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlpgvn08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn08_To_Orderings;


   procedure Add_hlpgvn09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlpgvn09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn09_To_Orderings;


   procedure Add_hlpgvn10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlpgvn10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn10_To_Orderings;


   procedure Add_hlpgvn11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlpgvn11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlpgvn11_To_Orderings;


   procedure Add_hlprec01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlprec01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec01_To_Orderings;


   procedure Add_hlprec02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlprec02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec02_To_Orderings;


   procedure Add_hlprec03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlprec03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec03_To_Orderings;


   procedure Add_hlprec04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlprec04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec04_To_Orderings;


   procedure Add_hlprec05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlprec05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec05_To_Orderings;


   procedure Add_hlprec06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlprec06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec06_To_Orderings;


   procedure Add_hlprec07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlprec07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec07_To_Orderings;


   procedure Add_hlprec08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlprec08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec08_To_Orderings;


   procedure Add_hlprec09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlprec09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec09_To_Orderings;


   procedure Add_hlprec10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlprec10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec10_To_Orderings;


   procedure Add_hlprec11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hlprec11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hlprec11_To_Orderings;


   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "issue", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_issue_To_Orderings;


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


   procedure Add_mntarr1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntarr1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntarr1_To_Orderings;


   procedure Add_mntarr2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntarr2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntarr2_To_Orderings;


   procedure Add_mntarr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntarr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntarr3_To_Orderings;


   procedure Add_mntarr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntarr4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntarr4_To_Orderings;


   procedure Add_mntnrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntnrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntnrp_To_Orderings;


   procedure Add_othqual1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othqual1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othqual1_To_Orderings;


   procedure Add_othqual2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othqual2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othqual2_To_Orderings;


   procedure Add_othqual3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othqual3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othqual3_To_Orderings;


   procedure Add_tea9697_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tea9697", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tea9697_To_Orderings;


   procedure Add_heartval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heartval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heartval_To_Orderings;


   procedure Add_iagegr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iagegr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iagegr3_To_Orderings;


   procedure Add_iagegr4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iagegr4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iagegr4_To_Orderings;


   procedure Add_nirel2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nirel2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nirel2_To_Orderings;


   procedure Add_xbonflag_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "xbonflag", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_xbonflag_To_Orderings;


   procedure Add_alg_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "alg", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_alg_To_Orderings;


   procedure Add_algamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "algamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_algamt_To_Orderings;


   procedure Add_algpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "algpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_algpd_To_Orderings;


   procedure Add_ben4q4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ben4q4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ben4q4_To_Orderings;


   procedure Add_chkctc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chkctc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkctc_To_Orderings;


   procedure Add_chkdpco1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chkdpco1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdpco1_To_Orderings;


   procedure Add_chkdpco2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chkdpco2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdpco2_To_Orderings;


   procedure Add_chkdpco3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chkdpco3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdpco3_To_Orderings;


   procedure Add_chkdsco1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chkdsco1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdsco1_To_Orderings;


   procedure Add_chkdsco2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chkdsco2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdsco2_To_Orderings;


   procedure Add_chkdsco3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "chkdsco3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_chkdsco3_To_Orderings;


   procedure Add_dv09pens_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dv09pens", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dv09pens_To_Orderings;


   procedure Add_lnkref01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref01_To_Orderings;


   procedure Add_lnkref02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref02_To_Orderings;


   procedure Add_lnkref03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref03_To_Orderings;


   procedure Add_lnkref04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref04_To_Orderings;


   procedure Add_lnkref05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref05_To_Orderings;


   procedure Add_lnkref06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref06_To_Orderings;


   procedure Add_lnkref07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref07_To_Orderings;


   procedure Add_lnkref08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref08_To_Orderings;


   procedure Add_lnkref09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref09_To_Orderings;


   procedure Add_lnkref10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref10_To_Orderings;


   procedure Add_lnkref11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lnkref11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lnkref11_To_Orderings;


   procedure Add_spyrot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "spyrot", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_spyrot_To_Orderings;


   procedure Add_disdifad_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdifad", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdifad_To_Orderings;


   procedure Add_gross3_x_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gross3_x", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross3_x_To_Orderings;


   procedure Add_aliamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "aliamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_aliamt_To_Orderings;


   procedure Add_alimny_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "alimny", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_alimny_To_Orderings;


   procedure Add_alipd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "alipd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_alipd_To_Orderings;


   procedure Add_alius_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "alius", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_alius_To_Orderings;


   procedure Add_aluamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "aluamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_aluamt_To_Orderings;


   procedure Add_alupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "alupd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_alupd_To_Orderings;


   procedure Add_cbaamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cbaamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbaamt_To_Orderings;


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


   procedure Add_penflag_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penflag", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penflag_To_Orderings;


   procedure Add_ppchk1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ppchk1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ppchk1_To_Orderings;


   procedure Add_ppchk2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ppchk2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ppchk2_To_Orderings;


   procedure Add_ppchk3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ppchk3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ppchk3_To_Orderings;


   procedure Add_ttbprx_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ttbprx", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ttbprx_To_Orderings;


   procedure Add_mjobsect_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mjobsect", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mjobsect_To_Orderings;


   procedure Add_etngrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "etngrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_etngrp_To_Orderings;


   procedure Add_medpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medpay", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medpay_To_Orderings;


   procedure Add_medrep_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medrep", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medrep_To_Orderings;


   procedure Add_medrpnm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "medrpnm", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_medrpnm_To_Orderings;


   procedure Add_nanid1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nanid1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nanid1_To_Orderings;


   procedure Add_nanid2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nanid2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nanid2_To_Orderings;


   procedure Add_nanid3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nanid3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nanid3_To_Orderings;


   procedure Add_nanid4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nanid4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nanid4_To_Orderings;


   procedure Add_nanid5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nanid5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nanid5_To_Orderings;


   procedure Add_nanid6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nanid6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nanid6_To_Orderings;


   procedure Add_nietngrp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nietngrp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nietngrp_To_Orderings;


   procedure Add_ninanid1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninanid1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid1_To_Orderings;


   procedure Add_ninanid2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninanid2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid2_To_Orderings;


   procedure Add_ninanid3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninanid3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid3_To_Orderings;


   procedure Add_ninanid4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninanid4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid4_To_Orderings;


   procedure Add_ninanid5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninanid5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid5_To_Orderings;


   procedure Add_ninanid6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninanid6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid6_To_Orderings;


   procedure Add_ninanid7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninanid7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanid7_To_Orderings;


   procedure Add_nirelig_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nirelig", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nirelig_To_Orderings;


   procedure Add_pollopin_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pollopin", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pollopin_To_Orderings;


   procedure Add_religenw_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "religenw", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_religenw_To_Orderings;


   procedure Add_religsc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "religsc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_religsc_To_Orderings;


   procedure Add_sidqn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sidqn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sidqn_To_Orderings;


   procedure Add_soc2010_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "soc2010", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_soc2010_To_Orderings;


   procedure Add_corignan_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "corignan", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_corignan_To_Orderings;


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


   procedure Add_ethgr3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgr3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ethgr3_To_Orderings;


   procedure Add_ninanida_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninanida", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninanida_To_Orderings;


   procedure Add_agehqual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "agehqual", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_agehqual_To_Orderings;


   procedure Add_bfd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bfd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bfd_To_Orderings;


   procedure Add_bfdamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bfdamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bfdamt_To_Orderings;


   procedure Add_bfdpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bfdpd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bfdpd_To_Orderings;


   procedure Add_bfdval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "bfdval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_bfdval_To_Orderings;


   procedure Add_btec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "btec", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_btec_To_Orderings;


   procedure Add_btecnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "btecnow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_btecnow_To_Orderings;


   procedure Add_cbaamt2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cbaamt2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbaamt2_To_Orderings;


   procedure Add_change_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "change", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_change_To_Orderings;


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


   procedure Add_condit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "condit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_condit_To_Orderings;


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


   procedure Add_ddaprog1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ddaprog1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ddaprog1_To_Orderings;


   procedure Add_ddatre1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ddatre1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ddatre1_To_Orderings;


   procedure Add_ddatrep1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ddatrep1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ddatrep1_To_Orderings;


   procedure Add_degree_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "degree", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_degree_To_Orderings;


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


   procedure Add_disd01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disd01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd01_To_Orderings;


   procedure Add_disd02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disd02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd02_To_Orderings;


   procedure Add_disd03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disd03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd03_To_Orderings;


   procedure Add_disd04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disd04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd04_To_Orderings;


   procedure Add_disd05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disd05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd05_To_Orderings;


   procedure Add_disd06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disd06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd06_To_Orderings;


   procedure Add_disd07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disd07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd07_To_Orderings;


   procedure Add_disd08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disd08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd08_To_Orderings;


   procedure Add_disd09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disd09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd09_To_Orderings;


   procedure Add_disd10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disd10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disd10_To_Orderings;


   procedure Add_disdifp1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disdifp1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disdifp1_To_Orderings;


   procedure Add_empcontr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "empcontr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_empcontr_To_Orderings;


   procedure Add_ethgrps_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ethgrps", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ethgrps_To_Orderings;


   procedure Add_eualiamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eualiamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eualiamt_To_Orderings;


   procedure Add_eualimny_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eualimny", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eualimny_To_Orderings;


   procedure Add_eualipd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eualipd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eualipd_To_Orderings;


   procedure Add_euetype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euetype", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euetype_To_Orderings;


   procedure Add_followsc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "followsc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_followsc_To_Orderings;


   procedure Add_health1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "health1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_health1_To_Orderings;


   procedure Add_heathad_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "heathad", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_heathad_To_Orderings;


   procedure Add_hi3qual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hi3qual", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi3qual_To_Orderings;


   procedure Add_higho_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "higho", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_higho_To_Orderings;


   procedure Add_highonow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "highonow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_highonow_To_Orderings;


   procedure Add_jobbyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "jobbyr", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobbyr_To_Orderings;


   procedure Add_limitl_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "limitl", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_limitl_To_Orderings;


   procedure Add_lktrain_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lktrain", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lktrain_To_Orderings;


   procedure Add_lkwork_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lkwork", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lkwork_To_Orderings;


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


   procedure Add_nvqlev_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nvqlev", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nvqlev_To_Orderings;


   procedure Add_othpass_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othpass", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othpass_To_Orderings;


   procedure Add_ppper_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ppper", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ppper_To_Orderings;


   procedure Add_proptax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "proptax", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_proptax_To_Orderings;


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


   procedure Add_reason_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "reason", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_reason_To_Orderings;


   procedure Add_rednet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rednet", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rednet_To_Orderings;


   procedure Add_redtax_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "redtax", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_redtax_To_Orderings;


   procedure Add_rsa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rsa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rsa_To_Orderings;


   procedure Add_rsanow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "rsanow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_rsanow_To_Orderings;


   procedure Add_samesit_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "samesit", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_samesit_To_Orderings;


   procedure Add_scotvec_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "scotvec", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_scotvec_To_Orderings;


   procedure Add_sctvnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sctvnow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sctvnow_To_Orderings;


   procedure Add_sdemp01_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sdemp01", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp01_To_Orderings;


   procedure Add_sdemp02_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sdemp02", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp02_To_Orderings;


   procedure Add_sdemp03_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sdemp03", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp03_To_Orderings;


   procedure Add_sdemp04_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sdemp04", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp04_To_Orderings;


   procedure Add_sdemp05_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sdemp05", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp05_To_Orderings;


   procedure Add_sdemp06_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sdemp06", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp06_To_Orderings;


   procedure Add_sdemp07_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sdemp07", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp07_To_Orderings;


   procedure Add_sdemp08_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sdemp08", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp08_To_Orderings;


   procedure Add_sdemp09_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sdemp09", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp09_To_Orderings;


   procedure Add_sdemp10_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sdemp10", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp10_To_Orderings;


   procedure Add_sdemp11_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sdemp11", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp11_To_Orderings;


   procedure Add_sdemp12_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sdemp12", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sdemp12_To_Orderings;


   procedure Add_selfdemp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "selfdemp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_selfdemp_To_Orderings;


   procedure Add_tempjob_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "tempjob", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_tempjob_To_Orderings;


   procedure Add_agehq80_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "agehq80", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_agehq80_To_Orderings;


   procedure Add_disacta1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disacta1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disacta1_To_Orderings;


   procedure Add_discora1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "discora1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_discora1_To_Orderings;


   procedure Add_gross4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gross4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gross4_To_Orderings;


   procedure Add_ninrinc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninrinc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninrinc_To_Orderings;


   procedure Add_typeed2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "typeed2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_typeed2_To_Orderings;


   procedure Add_w45_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "w45", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_w45_To_Orderings;


   procedure Add_accmsat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "accmsat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_accmsat_To_Orderings;


   procedure Add_c2orign_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "c2orign", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_c2orign_To_Orderings;


   procedure Add_calm_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "calm", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_calm_To_Orderings;


   procedure Add_cbchk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "cbchk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_cbchk_To_Orderings;


   procedure Add_claifut1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "claifut1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut1_To_Orderings;


   procedure Add_claifut2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "claifut2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut2_To_Orderings;


   procedure Add_claifut3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "claifut3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut3_To_Orderings;


   procedure Add_claifut4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "claifut4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut4_To_Orderings;


   procedure Add_claifut5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "claifut5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut5_To_Orderings;


   procedure Add_claifut6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "claifut6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut6_To_Orderings;


   procedure Add_claifut7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "claifut7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut7_To_Orderings;


   procedure Add_claifut8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "claifut8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_claifut8_To_Orderings;


   procedure Add_commusat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "commusat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_commusat_To_Orderings;


   procedure Add_coptrust_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "coptrust", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_coptrust_To_Orderings;


   procedure Add_depress_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "depress", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_depress_To_Orderings;


   procedure Add_disben1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disben1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disben1_To_Orderings;


   procedure Add_disben2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disben2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disben2_To_Orderings;


   procedure Add_disben3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disben3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disben3_To_Orderings;


   procedure Add_disben4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disben4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disben4_To_Orderings;


   procedure Add_disben5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disben5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disben5_To_Orderings;


   procedure Add_disben6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "disben6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_disben6_To_Orderings;


   procedure Add_discuss_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "discuss", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_discuss_To_Orderings;


   procedure Add_dla1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dla1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dla1_To_Orderings;


   procedure Add_dla2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dla2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dla2_To_Orderings;


   procedure Add_dls_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dls", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dls_To_Orderings;


   procedure Add_dlsamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dlsamt", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dlsamt_To_Orderings;


   procedure Add_dlspd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dlspd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dlspd_To_Orderings;


   procedure Add_dlsval_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dlsval", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dlsval_To_Orderings;


   procedure Add_down_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "down", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_down_To_Orderings;


   procedure Add_envirsat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "envirsat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_envirsat_To_Orderings;


   procedure Add_gpispc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gpispc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gpispc_To_Orderings;


   procedure Add_gpjsaesa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gpjsaesa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gpjsaesa_To_Orderings;


   procedure Add_happy_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "happy", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_happy_To_Orderings;


   procedure Add_help_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "help", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_help_To_Orderings;


   procedure Add_iclaim1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iclaim1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim1_To_Orderings;


   procedure Add_iclaim2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iclaim2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim2_To_Orderings;


   procedure Add_iclaim3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iclaim3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim3_To_Orderings;


   procedure Add_iclaim4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iclaim4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim4_To_Orderings;


   procedure Add_iclaim5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iclaim5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim5_To_Orderings;


   procedure Add_iclaim6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iclaim6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim6_To_Orderings;


   procedure Add_iclaim7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iclaim7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim7_To_Orderings;


   procedure Add_iclaim8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iclaim8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim8_To_Orderings;


   procedure Add_iclaim9_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "iclaim9", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_iclaim9_To_Orderings;


   procedure Add_jobsat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "jobsat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_jobsat_To_Orderings;


   procedure Add_kidben1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidben1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidben1_To_Orderings;


   procedure Add_kidben2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidben2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidben2_To_Orderings;


   procedure Add_kidben3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "kidben3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_kidben3_To_Orderings;


   procedure Add_legltrus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "legltrus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_legltrus_To_Orderings;


   procedure Add_lifesat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "lifesat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_lifesat_To_Orderings;


   procedure Add_meaning_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "meaning", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_meaning_To_Orderings;


   procedure Add_moneysat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "moneysat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_moneysat_To_Orderings;


   procedure Add_nervous_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "nervous", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_nervous_To_Orderings;


   procedure Add_ni2train_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ni2train", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ni2train_To_Orderings;


   procedure Add_othben1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othben1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othben1_To_Orderings;


   procedure Add_othben2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othben2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othben2_To_Orderings;


   procedure Add_othben3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othben3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othben3_To_Orderings;


   procedure Add_othben4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othben4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othben4_To_Orderings;


   procedure Add_othben5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othben5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othben5_To_Orderings;


   procedure Add_othben6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othben6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othben6_To_Orderings;


   procedure Add_othtrust_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "othtrust", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_othtrust_To_Orderings;


   procedure Add_penben1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penben1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penben1_To_Orderings;


   procedure Add_penben2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penben2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penben2_To_Orderings;


   procedure Add_penben3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penben3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penben3_To_Orderings;


   procedure Add_penben4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penben4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penben4_To_Orderings;


   procedure Add_penben5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penben5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penben5_To_Orderings;


   procedure Add_pip1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pip1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pip1_To_Orderings;


   procedure Add_pip2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "pip2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_pip2_To_Orderings;


   procedure Add_polttrus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "polttrus", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_polttrus_To_Orderings;


   procedure Add_recsat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "recsat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_recsat_To_Orderings;


   procedure Add_relasat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "relasat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_relasat_To_Orderings;


   procedure Add_safe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "safe", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_safe_To_Orderings;


   procedure Add_socfund1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "socfund1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_socfund1_To_Orderings;


   procedure Add_socfund2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "socfund2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_socfund2_To_Orderings;


   procedure Add_socfund3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "socfund3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_socfund3_To_Orderings;


   procedure Add_socfund4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "socfund4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_socfund4_To_Orderings;


   procedure Add_srispc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "srispc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_srispc_To_Orderings;


   procedure Add_srjsaesa_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "srjsaesa", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_srjsaesa_To_Orderings;


   procedure Add_timesat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "timesat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_timesat_To_Orderings;


   procedure Add_train2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "train2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_train2_To_Orderings;


   procedure Add_trnallow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "trnallow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_trnallow_To_Orderings;


   procedure Add_wageben1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wageben1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben1_To_Orderings;


   procedure Add_wageben2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wageben2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben2_To_Orderings;


   procedure Add_wageben3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wageben3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben3_To_Orderings;


   procedure Add_wageben4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wageben4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben4_To_Orderings;


   procedure Add_wageben5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wageben5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben5_To_Orderings;


   procedure Add_wageben6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wageben6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben6_To_Orderings;


   procedure Add_wageben7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wageben7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben7_To_Orderings;


   procedure Add_wageben8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "wageben8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_wageben8_To_Orderings;


   procedure Add_ninnirbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninnirbn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninnirbn_To_Orderings;


   procedure Add_ninothbn_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ninothbn", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ninothbn_To_Orderings;


   procedure Add_anxious_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "anxious", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_anxious_To_Orderings;


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


   procedure Add_dvhiqual_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "dvhiqual", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_dvhiqual_To_Orderings;


   procedure Add_gnvqnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gnvqnow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gnvqnow_To_Orderings;


   procedure Add_gpuc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "gpuc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_gpuc_To_Orderings;


   procedure Add_happywb_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "happywb", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_happywb_To_Orderings;


   procedure Add_hi1qual7_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hi1qual7", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual7_To_Orderings;


   procedure Add_hi1qual8_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "hi1qual8", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_hi1qual8_To_Orderings;


   procedure Add_mntarr5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntarr5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntarr5_To_Orderings;


   procedure Add_mntnoch1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntnoch1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntnoch1_To_Orderings;


   procedure Add_mntnoch2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntnoch2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntnoch2_To_Orderings;


   procedure Add_mntnoch3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntnoch3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntnoch3_To_Orderings;


   procedure Add_mntnoch4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntnoch4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntnoch4_To_Orderings;


   procedure Add_mntnoch5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntnoch5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntnoch5_To_Orderings;


   procedure Add_mntpro1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntpro1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntpro1_To_Orderings;


   procedure Add_mntpro2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntpro2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntpro2_To_Orderings;


   procedure Add_mntpro3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntpro3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntpro3_To_Orderings;


   procedure Add_mnttim1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mnttim1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mnttim1_To_Orderings;


   procedure Add_mnttim2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mnttim2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mnttim2_To_Orderings;


   procedure Add_mnttim3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mnttim3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mnttim3_To_Orderings;


   procedure Add_mntwrk1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntwrk1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntwrk1_To_Orderings;


   procedure Add_mntwrk2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntwrk2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntwrk2_To_Orderings;


   procedure Add_mntwrk3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntwrk3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntwrk3_To_Orderings;


   procedure Add_mntwrk4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntwrk4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntwrk4_To_Orderings;


   procedure Add_mntwrk5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "mntwrk5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_mntwrk5_To_Orderings;


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


   procedure Add_sruc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "sruc", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_sruc_To_Orderings;


   procedure Add_webacnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "webacnow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_webacnow_To_Orderings;


   procedure Add_indeth_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "indeth", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_indeth_To_Orderings;


   procedure Add_euactive_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euactive", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euactive_To_Orderings;


   procedure Add_euactno_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euactno", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euactno_To_Orderings;


   procedure Add_euartact_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euartact", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euartact_To_Orderings;


   procedure Add_euaskhlp_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euaskhlp", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euaskhlp_To_Orderings;


   procedure Add_eucinema_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eucinema", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eucinema_To_Orderings;


   procedure Add_eucultur_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eucultur", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eucultur_To_Orderings;


   procedure Add_euinvol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euinvol", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euinvol_To_Orderings;


   procedure Add_eulivpe_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eulivpe", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eulivpe_To_Orderings;


   procedure Add_eumtfam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eumtfam", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eumtfam_To_Orderings;


   procedure Add_eumtfrnd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eumtfrnd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eumtfrnd_To_Orderings;


   procedure Add_eusocnet_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eusocnet", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eusocnet_To_Orderings;


   procedure Add_eusport_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eusport", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eusport_To_Orderings;


   procedure Add_eutkfam_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eutkfam", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eutkfam_To_Orderings;


   procedure Add_eutkfrnd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eutkfrnd", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eutkfrnd_To_Orderings;


   procedure Add_eutkmat_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "eutkmat", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_eutkmat_To_Orderings;


   procedure Add_euvol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "euvol", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_euvol_To_Orderings;


   procedure Add_natscot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "natscot", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_natscot_To_Orderings;


   procedure Add_ntsctnow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "ntsctnow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_ntsctnow_To_Orderings;


   procedure Add_penwel1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penwel1", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penwel1_To_Orderings;


   procedure Add_penwel2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penwel2", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penwel2_To_Orderings;


   procedure Add_penwel3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penwel3", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penwel3_To_Orderings;


   procedure Add_penwel4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penwel4", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penwel4_To_Orderings;


   procedure Add_penwel5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penwel5", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penwel5_To_Orderings;


   procedure Add_penwel6_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "penwel6", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_penwel6_To_Orderings;


   procedure Add_skiwknow_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "skiwknow", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_skiwknow_To_Orderings;


   procedure Add_skiwrk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "skiwrk", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_skiwrk_To_Orderings;


   procedure Add_slos_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "slos", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_slos_To_Orderings;


   procedure Add_yjblev_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc ) is   
   elem : d.Order_By_Element := d.Make_Order_By_Element( "yjblev", direction  );
   begin
      d.add_to_criteria( c, elem );
   end Add_yjblev_To_Orderings;



   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

end Ukds.Frs.Adult_IO;

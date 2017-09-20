--
-- this stuff is just to force compilation - borrowed from auto test case.
--

with Model.SCP.FRS_Creator;

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
with Ukds.Target_Data.Forecast_Type_IO;
with Ukds.Target_Data.Country_IO;
with Ukds.Target_Data.Forecast_Variant_IO;
with Ukds.Target_Data.Households_Forecasts_IO;
with Ukds.Target_Data.Population_Forecasts_IO;

with Data_Constants;
with Base_Model_Types;
with Ada.Calendar;

with Ada.Text_IO;

procedure Basic_SCP_Driver is
   
   use Ada.Exceptions;
   use Ada.Calendar;
   use UKDS;
   use Ada.Text_IO;
   use UKDS.FRS;
   use GNATCOLL.SQL.Exec;
   package d renames DB_Commons;
   package frsh_io renames Househol_IO;

   
   startTime    : Time;
   endTime      : Time;
   elapsed      : Duration;
   cursor       : GNATCOLL.SQL.Exec.Forward_Cursor;
   household_r  : Househol;
   ps           : GNATCOLL.SQL.Exec.Prepared_Statement;   
   conn         : Database_Connection;
   count        : Natural := 0;
   frs_criteria : d.Criteria;
begin
   startTime := Clock;
   Put_Line( "We're making a start on this.." );
   Connection_Pool.Initialise;
   conn := Connection_Pool.Lease;

   Househol_IO.Add_User_Id( frs_criteria, 1 );
   Househol_IO.Add_Edition( frs_criteria, 1 );
   Househol_IO.Add_Year( frs_criteria, 2008, d.GE );
   Househol_IO.Add_Year_To_Orderings( frs_criteria, d.Asc );
   Househol_IO.Add_Sernum_To_Orderings( frs_criteria, d.Asc );
   ps := Househol_IO.Get_Prepared_Retrieve_Statement( frs_criteria );  
   cursor.Fetch( conn, ps ); -- "select * from frs.househol where year >= 2011 order by year,sernum" );
   while Has_Row( cursor ) loop 
      household_r := Househol_IO.Map_From_Cursor( cursor );
      declare
         hh_crit : d.Criteria;
      begin         
         Househol_IO.Add_User_Id( hh_crit, household_r.user_id );
         Househol_IO.Add_Edition( hh_crit, household_r.edition );
         Househol_IO.Add_Year( hh_crit, household_r.year );
         Househol_IO.Add_Sernum( hh_crit, household_r.sernum );
         Adult_IO.Add_Person_To_Orderings( hh_crit, d.Asc );
         Put_Line( d.To_String( hh_crit ));
         Put_Line( "on year " & household_r.year'Img & " sernum " & household_r.sernum'Img );
         declare
            adult_l : FRS.Adult_List := Adult_IO.Retrieve( hh_crit );
            child_l : FRS.Child_List := Child_IO.Retrieve( hh_crit );
         begin
            Put_Line( "num adults " & adult_l.Length'Img );
            Put_Line( "num children " & child_l.Length'Img );
         end;
      end;
      count := count + 1;
      Next( cursor );
   end loop;
   endTime := Clock;
   elapsed := endTime - startTime;
   Put_Line( "Time Taken " & elapsed'Img & " secs " & count'Img & " hhlds " );
end Basic_SCP_Driver;
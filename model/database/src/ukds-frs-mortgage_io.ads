--
-- Created by ada_generator.py on 2017-10-16 22:11:04.445451
-- 
with Ukds;
with DB_Commons;
with Base_Types;
with ADA.Calendar;
with Ada.Strings.Unbounded;

with GNATCOLL.SQL.Exec;

with Data_Constants;
with Base_Model_Types;
with Ada.Calendar;
with SCP_Types;
with Weighting_Commons;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package Ukds.Frs.Mortgage_IO is
  
   package d renames DB_Commons;   
   use Base_Types;
   use Ada.Strings.Unbounded;
   use Ada.Calendar;
   
   SCHEMA_NAME : constant String := "frs";
   
   use GNATCOLL.SQL.Exec;
   
   use Ukds;
   use Data_Constants;
   use Base_Model_Types;
   use Ada.Calendar;
   use SCP_Types;
   use Weighting_Commons;

   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===

   
   function Next_Free_user_id( connection : Database_Connection := null) return Integer;
   function Next_Free_edition( connection : Database_Connection := null) return Integer;
   function Next_Free_year( connection : Database_Connection := null) return Integer;
   function Next_Free_sernum( connection : Database_Connection := null) return Sernum_Value;
   function Next_Free_mortseq( connection : Database_Connection := null) return Integer;

   --
   -- returns true if the primary key parts of a_mortgage match the defaults in Ukds.Frs.Null_Mortgage
   --
   function Is_Null( a_mortgage : Mortgage ) return Boolean;
   
   --
   -- returns the single a_mortgage matching the primary key fields, or the Ukds.Frs.Null_Mortgage record
   -- if no such record exists
   --
   function Retrieve_By_PK( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; mortseq : Integer; connection : Database_Connection := null ) return Ukds.Frs.Mortgage;
   --
   -- Returns true if record with the given primary key exists
   --
   function Exists( user_id : Integer; edition : Integer; year : Integer; sernum : Sernum_Value; mortseq : Integer; connection : Database_Connection := null ) return Boolean ;
   
   --
   -- Retrieves a list of Ukds.Frs.Mortgage matching the criteria, or throws an exception
   --
   function Retrieve( c : d.Criteria; connection : Database_Connection := null ) return Ukds.Frs.Mortgage_List;
   
   --
   -- Retrieves a list of Ukds.Frs.Mortgage retrived by the sql string, or throws an exception
   --
   function Retrieve( sqlstr : String; connection : Database_Connection := null ) return Ukds.Frs.Mortgage_List;
   
   --
   -- Save the given record, overwriting if it exists and overwrite is true, 
   -- otherwise throws DB_Exception exception. 
   --
   procedure Save( a_mortgage : Ukds.Frs.Mortgage; overwrite : Boolean := True; connection : Database_Connection := null );
   
   --
   -- Delete the given record. Throws DB_Exception exception. Sets value to Ukds.Frs.Null_Mortgage
   --
   procedure Delete( a_mortgage : in out Ukds.Frs.Mortgage; connection : Database_Connection := null );
   --
   -- delete the records indentified by the criteria
   --
   procedure Delete( c : d.Criteria; connection : Database_Connection := null );
   --
   -- delete all the records identified by the where SQL clause 
   --
   procedure Delete( where_Clause : String; connection : Database_Connection := null );
   --
   -- functions to retrieve records from tables with foreign keys
   -- referencing the table modelled by this package
   --

   --
   -- functions to add something to a criteria
   --
   procedure Add_user_id( c : in out d.Criteria; user_id : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_edition( c : in out d.Criteria; edition : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_year( c : in out d.Criteria; year : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_sernum( c : in out d.Criteria; sernum : Sernum_Value; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mortseq( c : in out d.Criteria; mortseq : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_boramtdk( c : in out d.Criteria; boramtdk : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_borramt( c : in out d.Criteria; borramt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_endwpri1( c : in out d.Criteria; endwpri1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_endwpri2( c : in out d.Criteria; endwpri2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_endwpri3( c : in out d.Criteria; endwpri3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_endwpri4( c : in out d.Criteria; endwpri4 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_exrent( c : in out d.Criteria; exrent : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incminc1( c : in out d.Criteria; incminc1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incminc2( c : in out d.Criteria; incminc2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incminc3( c : in out d.Criteria; incminc3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incmp1( c : in out d.Criteria; incmp1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incmp2( c : in out d.Criteria; incmp2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incmp3( c : in out d.Criteria; incmp3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incmpam1( c : in out d.Criteria; incmpam1 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incmpam2( c : in out d.Criteria; incmpam2 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incmpam3( c : in out d.Criteria; incmpam3 : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incmppd1( c : in out d.Criteria; incmppd1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incmppd2( c : in out d.Criteria; incmppd2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incmppd3( c : in out d.Criteria; incmppd3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incmsty1( c : in out d.Criteria; incmsty1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incmsty2( c : in out d.Criteria; incmsty2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_incmsty3( c : in out d.Criteria; incmsty3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intprpay( c : in out d.Criteria; intprpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intprpd( c : in out d.Criteria; intprpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intru( c : in out d.Criteria; intru : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intrupd( c : in out d.Criteria; intrupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_intrus( c : in out d.Criteria; intrus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loan2y( c : in out d.Criteria; loan2y : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_loanyear( c : in out d.Criteria; loanyear : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_menpol( c : in out d.Criteria; menpol : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_morall( c : in out d.Criteria; morall : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_morflc( c : in out d.Criteria; morflc : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_morinpay( c : in out d.Criteria; morinpay : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_morinpd( c : in out d.Criteria; morinpd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_morinus( c : in out d.Criteria; morinus : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mortend( c : in out d.Criteria; mortend : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mortleft( c : in out d.Criteria; mortleft : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mortprot( c : in out d.Criteria; mortprot : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_morttype( c : in out d.Criteria; morttype : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_morupd( c : in out d.Criteria; morupd : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_morus( c : in out d.Criteria; morus : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mpcover1( c : in out d.Criteria; mpcover1 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mpcover2( c : in out d.Criteria; mpcover2 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mpcover3( c : in out d.Criteria; mpcover3 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_mpolno( c : in out d.Criteria; mpolno : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_outsmort( c : in out d.Criteria; outsmort : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rentfrom( c : in out d.Criteria; rentfrom : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rmamt( c : in out d.Criteria; rmamt : Amount; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rmort( c : in out d.Criteria; rmort : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rmortyr( c : in out d.Criteria; rmortyr : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rmpur001( c : in out d.Criteria; rmpur001 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rmpur002( c : in out d.Criteria; rmpur002 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rmpur003( c : in out d.Criteria; rmpur003 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rmpur004( c : in out d.Criteria; rmpur004 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rmpur005( c : in out d.Criteria; rmpur005 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rmpur006( c : in out d.Criteria; rmpur006 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rmpur007( c : in out d.Criteria; rmpur007 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_rmpur008( c : in out d.Criteria; rmpur008 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_month( c : in out d.Criteria; month : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_endwpri5( c : in out d.Criteria; endwpri5 : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   procedure Add_issue( c : in out d.Criteria; issue : Integer; op : d.operation_type:= d.eq; join : d.join_type := d.join_and );
   --
   -- functions to add an ordering to a criteria
   --
   procedure Add_user_id_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_edition_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_year_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_sernum_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mortseq_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_boramtdk_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_borramt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_endwpri1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_endwpri2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_endwpri3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_endwpri4_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_exrent_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incminc1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incminc2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incminc3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incmp1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incmp2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incmp3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incmpam1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incmpam2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incmpam3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incmppd1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incmppd2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incmppd3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incmsty1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incmsty2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_incmsty3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intprpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intprpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intru_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intrupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_intrus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loan2y_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_loanyear_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_menpol_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_morall_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_morflc_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_morinpay_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_morinpd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_morinus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mortend_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mortleft_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mortprot_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_morttype_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_morupd_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_morus_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mpcover1_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mpcover2_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mpcover3_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_mpolno_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_outsmort_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rentfrom_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rmamt_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rmort_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rmortyr_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rmpur001_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rmpur002_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rmpur003_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rmpur004_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rmpur005_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rmpur006_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rmpur007_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_rmpur008_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_month_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_endwpri5_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );
   procedure Add_issue_To_Orderings( c : in out d.Criteria; direction : d.Asc_Or_Desc );

   function Map_From_Cursor( cursor : GNATCOLL.SQL.Exec.Forward_Cursor ) return Ukds.Frs.Mortgage;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 66, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : mortseq                  : Parameter_Integer  : Integer              :        0 
   --    6 : boramtdk                 : Parameter_Integer  : Integer              :        0 
   --    7 : borramt                  : Parameter_Float    : Amount               :      0.0 
   --    8 : endwpri1                 : Parameter_Integer  : Integer              :        0 
   --    9 : endwpri2                 : Parameter_Integer  : Integer              :        0 
   --   10 : endwpri3                 : Parameter_Integer  : Integer              :        0 
   --   11 : endwpri4                 : Parameter_Integer  : Integer              :        0 
   --   12 : exrent                   : Parameter_Integer  : Integer              :        0 
   --   13 : incminc1                 : Parameter_Integer  : Integer              :        0 
   --   14 : incminc2                 : Parameter_Integer  : Integer              :        0 
   --   15 : incminc3                 : Parameter_Integer  : Integer              :        0 
   --   16 : incmp1                   : Parameter_Integer  : Integer              :        0 
   --   17 : incmp2                   : Parameter_Integer  : Integer              :        0 
   --   18 : incmp3                   : Parameter_Integer  : Integer              :        0 
   --   19 : incmpam1                 : Parameter_Float    : Amount               :      0.0 
   --   20 : incmpam2                 : Parameter_Float    : Amount               :      0.0 
   --   21 : incmpam3                 : Parameter_Float    : Amount               :      0.0 
   --   22 : incmppd1                 : Parameter_Integer  : Integer              :        0 
   --   23 : incmppd2                 : Parameter_Integer  : Integer              :        0 
   --   24 : incmppd3                 : Parameter_Integer  : Integer              :        0 
   --   25 : incmsty1                 : Parameter_Integer  : Integer              :        0 
   --   26 : incmsty2                 : Parameter_Integer  : Integer              :        0 
   --   27 : incmsty3                 : Parameter_Integer  : Integer              :        0 
   --   28 : intprpay                 : Parameter_Float    : Amount               :      0.0 
   --   29 : intprpd                  : Parameter_Integer  : Integer              :        0 
   --   30 : intru                    : Parameter_Float    : Amount               :      0.0 
   --   31 : intrupd                  : Parameter_Integer  : Integer              :        0 
   --   32 : intrus                   : Parameter_Integer  : Integer              :        0 
   --   33 : loan2y                   : Parameter_Integer  : Integer              :        0 
   --   34 : loanyear                 : Parameter_Integer  : Integer              :        0 
   --   35 : menpol                   : Parameter_Integer  : Integer              :        0 
   --   36 : morall                   : Parameter_Integer  : Integer              :        0 
   --   37 : morflc                   : Parameter_Integer  : Integer              :        0 
   --   38 : morinpay                 : Parameter_Float    : Amount               :      0.0 
   --   39 : morinpd                  : Parameter_Integer  : Integer              :        0 
   --   40 : morinus                  : Parameter_Integer  : Integer              :        0 
   --   41 : mortend                  : Parameter_Integer  : Integer              :        0 
   --   42 : mortleft                 : Parameter_Float    : Amount               :      0.0 
   --   43 : mortprot                 : Parameter_Integer  : Integer              :        0 
   --   44 : morttype                 : Parameter_Integer  : Integer              :        0 
   --   45 : morupd                   : Parameter_Integer  : Integer              :        0 
   --   46 : morus                    : Parameter_Float    : Amount               :      0.0 
   --   47 : mpcover1                 : Parameter_Integer  : Integer              :        0 
   --   48 : mpcover2                 : Parameter_Integer  : Integer              :        0 
   --   49 : mpcover3                 : Parameter_Integer  : Integer              :        0 
   --   50 : mpolno                   : Parameter_Integer  : Integer              :        0 
   --   51 : outsmort                 : Parameter_Integer  : Integer              :        0 
   --   52 : rentfrom                 : Parameter_Integer  : Integer              :        0 
   --   53 : rmamt                    : Parameter_Float    : Amount               :      0.0 
   --   54 : rmort                    : Parameter_Integer  : Integer              :        0 
   --   55 : rmortyr                  : Parameter_Integer  : Integer              :        0 
   --   56 : rmpur001                 : Parameter_Integer  : Integer              :        0 
   --   57 : rmpur002                 : Parameter_Integer  : Integer              :        0 
   --   58 : rmpur003                 : Parameter_Integer  : Integer              :        0 
   --   59 : rmpur004                 : Parameter_Integer  : Integer              :        0 
   --   60 : rmpur005                 : Parameter_Integer  : Integer              :        0 
   --   61 : rmpur006                 : Parameter_Integer  : Integer              :        0 
   --   62 : rmpur007                 : Parameter_Integer  : Integer              :        0 
   --   63 : rmpur008                 : Parameter_Integer  : Integer              :        0 
   --   64 : month                    : Parameter_Integer  : Integer              :        0 
   --   65 : endwpri5                 : Parameter_Integer  : Integer              :        0 
   --   66 : issue                    : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Insert_Params( update_order : Boolean := False ) return GNATCOLL.SQL.Exec.SQL_Parameters;


--
-- a prepared statement of the form insert into xx values ( [ everything, including pk fields ] )
--
   function Get_Prepared_Insert_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;

--
-- a prepared statement of the form update xx set [ everything except pk fields ] where [pk fields ] 
-- 
   function Get_Prepared_Update_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- 
   -- returns an array of GNATColl SQL Parameters indexed 1 .. 5, as follows
   -- Pos  |       Name               | SQL Type           | Ada Type             | Default
   --    1 : user_id                  : Parameter_Integer  : Integer              :        0 
   --    2 : edition                  : Parameter_Integer  : Integer              :        0 
   --    3 : year                     : Parameter_Integer  : Integer              :        0 
   --    4 : sernum                   : Parameter_Bigint   : Sernum_Value         :        0 
   --    5 : mortseq                  : Parameter_Integer  : Integer              :        0 
   function Get_Configured_Retrieve_Params return GNATCOLL.SQL.Exec.SQL_Parameters;


   function Get_Prepared_Retrieve_Statement return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( sqlstr : String ) return GNATCOLL.SQL.Exec.Prepared_Statement;
   function Get_Prepared_Retrieve_Statement( crit : d.Criteria ) return GNATCOLL.SQL.Exec.Prepared_Statement;

   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===

  
end Ukds.Frs.Mortgage_IO;

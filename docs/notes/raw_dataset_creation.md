Title: Raw Dataset Creation
Author: Graham Stark
Date: 5th September 2017

# Notes on Raw Dataset Creation

These are all ported from southampton/model/scripts. DB stuff, dates, need for HSE, etc. changed. Scripts in Ruby. Needs

## Requirements 

1. [Ruby](https://www.ruby-lang.org/en/) - using 2.3, but earlier/later should work. With
- [Sequel](http://tutorials.jumpstartlab.com/topics/sql/sequel.html) DB Driver. (Old version used DBI).
- [RexML](http://www.germane-software.com/software/rexml/docs/tutorial.html)
- `utils.rb` and `ukds_schema_utils` libraries from [tax_benefit_model_components](https://github.com/grahamstark/tax_benefit_model_components)
2. [Open Office](https://www.openoffice.org/download/) (for rtf file conversion; see (1) below).

## UKDS Datasets

Unzip UKDS TAB version files into `/mnt/data/frs/[year]` where `year` is 2015 for 2015/6 FRS. Make symlinks
`tab/` and `mrdoc/`.

## Directories

All the scripts in `models/scripts`
Create `datatabase/`. (Subdirs should all be created automatically).

## Database structure
[TODO] explain the dictionary. Explain the schema structure. See SOTON Database note.

## Steps

These scripts are copies of the SOTON ones and need edited for years and target datasets - they've also been modded to
use Sequel rather than DBI.

1. `convert_frs_rtf_to_tab.sh` to make ascii versions of FRS codebooks. Notes: - openoffice needs shut down
   everywhere so headless version can run - old version creates to `.tab`, new version `.txt`; these are actually the same.

2. `load_schemas_to_db.rb` to load the UKDS docs into our metadata dictionary. 

3. `infer_type.rb`. Change `todo` field at top as needed, and inspect and change years in various places.
   This adds type information to the metadata.

4. `create_db_xml_schema.rb` - this creates load scripts for the TAB data, and [Mill](https://github.com/grahamstark/ada_mill) XML files.

5. Run [Ada Mill](). In `database/` directory, run `python ../../../ada_mill/scripts/mill.py . native`

6. create the database. SQL schema in `database/database`. Postgres only at the moment. 

7. create cleaned up versions of the UKDS tabfiles. Run `tabFileFixer.rb`. Needs editing at bottom, and in each dataset
   for years.

8. load data. If the datasets have been set up as above, the script `database/sql/postgres_load_statements.sql` should
   bulk-load everything.


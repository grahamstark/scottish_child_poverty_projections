#!/usr/bin/ruby

require './forecast_libs'


CLAUSES_MAP = {
        'genders'                  => FALSE,
        'household_type'           => FALSE,
        'by_year_ages'             => FALSE,
        'by_year_ages_by_gender'   => FALSE,
        'aggregate_ages'           => FALSE,
        'aggregate_ages_by_gender' => FALSE,
        'employment'               => FALSE,
        'employees'                => FALSE,
        'ilo_unemployment'         => FALSE,
        'jsa_claimants'            => FALSE,
        'participation_rate'       => FALSE,
        'employment_by_sector'     => FALSE }

TYPE_OF_RUN = {:data_generation=>0, :target_generation=>1, :weights_generation=>2, :validation=>3 }

DISTANCE_FUNCTION = {
        :chi_square => 0, 
        :d_and_s_type_a => 1, 
        :d_and_s_type_b => 2, 
        :constrained_chi_square => 3, 
        :d_and_s_constrainted => 4
}

def clauseToString( clauses )
        "{ " + clauses.map{
                |k,v|
                "#{v}"}.join(', ') + " }"
end


def insert201000()       
        clauses = CLAUSES_MAP
        clauses['household_type'] = TRUE
        clauses['aggregate_ages_by_gender' ] = TRUE
        clauses['employment_by_sector' ] = TRUE
        clauses['participation_rate'] = TRUE
        clauseStr =  clauseToString( clauses )
        puts "clauseStr #{clauseStr}"
        # selected_clauses[:]
        INSERT_RUN_STMT.call(     
                :insert,
                :run_id => 201000,
                :user_id => 1,
                :description => 'Attempt to emulate IFS Weights',
                :start_year => 2014,
                :end_year => 2021,
                :macro_edition => 2017,
                :households_edition => 2014,
                :population_edition => 2014,
                :country => 'UK',
                :households_variant => 'ppp',
                :population_variant => 'ppp',
                :macro_variant => 'baseline',
                :run_type => TYPE_OF_RUN[:weights_generation],
                :weighting_function => DISTANCE_FUNCTION[:constrained_chi_square],
                :weighting_lower_bound => 0.1,
                :weighting_upper_bound => 4.0,
                :targets_run_id => 100128,
                :targets_run_user_id => 1,
                :data_run_id => 999998,
                :data_run_user_id => 1,
                :selected_clauses => clauseStr,
                :data_start_year => 2012,
                :data_end_year => 2015,
                :uk_wide_only => TRUE  );
end
        
insert201000()
                
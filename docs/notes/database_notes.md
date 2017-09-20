# RANDOM POSTGRES NOTES

rights stuff. From [Stack Overflow](https://stackoverflow.com/questions/10352695/grant-all-on-a-specific-schema-in-the-db-to-a-group-role-in-postgresql).:w


    grant all privileges on all tables in schema target_data to graham_s;
    alter default privileges in schema target_data grant all privileges on tables to graham_s;
    

    grant all privileges on all tables in schema frs to graham_s;
    alter default privileges in schema frs grant all privileges on tables to graham_s;
    
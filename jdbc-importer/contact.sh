#!bin/bash
bin=/home/ubuntu/elastic/elasticsearch-jdbc-2.3.4.0/bin
lib=/home/ubuntu/elastic/elasticsearch-jdbc-2.3.4.0/lib
echo '
{
    "type" : "contact",
    "jdbc" : {
        "url" : "jdbc:mysql://hawkeye-test.clxybluj7kyg.ap-southeast-1.rds.amazonaws.com:3306/hawkeye_staging_fixed",
        "user" : "hetest",
        "password" : "OGYyZTk5NjJkOGM",
        "sql" : "SELECT contact.*, contact_group.name as 'contact_group_name', contact_group.is_valid as 'contact_group_name_is_valid', contact_group.is_forward_group, account.name as 'account_name', creator_user.email as 'creator_user' FROM (`contact_group`) LEFT OUTER JOIN `user` creator_user ON `creator_user`.`id` = `contact_group`.`created_by_id` LEFT OUTER JOIN `user` updater_user ON `updater_user`.`id` = `contact_group`.`updated_by_id` LEFT OUTER JOIN `account` account ON `account`.`id` = `contact_group`.`account_id` LEFT OUTER JOIN `keyword` keyword ON `keyword`.`id` = `contact_group`.`keyword_id` LEFT OUTER JOIN `contactgroup_contact` cgc ON `cgc`.`contactgroup_id` =  `contact_group`.`id` LEFT OUTER JOIN `contact` contact on `cgc`.`contact_id` = `contact`.`id`",
        "treat_binary_as_string" : true,
        "elasticsearch" : {
            "cluster" : "elasticsearch",
            "host" : "localhost",
            "port" : 9300,
            "autodiscover": true
        },
        "index" : "hawkeye",
        "type"  : "contact_test"
    }
}
' | java \
-cp "${lib}/*" \
-Dlog4j.configurationFile=${bin}/log4j2.xml \
org.xbib.tools.Runner \
org.xbib.tools.JDBCImporter
echo "Done...."


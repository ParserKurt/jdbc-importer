#!/bin/bash

bin=/home/kurt/elastic/elasticsearch-jdbc-2.3.4.0/bin
lib=/home/kurt/elastic/elasticsearch-jdbc-2.3.4.0/lib
echo '
{
    "type" : "jdbc",
    "jdbc" : {
        "url" : "jdbc:mysql://127.0.0.1:3306/hawkeye",
        "user" : "root",
        "password" : "root",
        "sql" : "SELECT `contact_group`.*, `contact_group`.`id`, `contact_group`.`name`, `contact_group`.`test`, `contact_group`.`date_created`, `contact_group`.`date_last_updated`, `contact_group`.`is_valid`, `contact_group`.`total_contacts`, `contact_group`.`date_last_used`, `creator_user`.`email` AS creator_email, `updater_user`.`email` AS updater_email, `account`.`name` AS account_name FROM (`contact_group`) LEFT OUTER JOIN `user` creator_user ON `creator_user`.`id` = `contact_group`.`created_by_id` LEFT OUTER JOIN `user` updater_user ON `updater_user`.`id`, `contact_group`.`updated_by_id` LEFT OUTER JOIN `account` account ON `account`.`id` = `contact_group`.`account_id` LEFT OUTER JOIN `keyword` keyword ON `keyword`.`id` = `contact_group`.`keyword_id`",
        "treat_binary_as_string" : true,
        "elasticsearch" : {
            "cluster" : "elasticsearch",
            "host" : "localhost",
            "port" : 9300,
            "autodiscover": true
        },
        "index" : "campaigns"
    }
}
' | java \
-cp "${lib}/*" \
-Dlog4j.configurationFile=${bin}/log4j2.xml \
org.xbib.tools.Runner \
org.xbib.tools.JDBCImporter

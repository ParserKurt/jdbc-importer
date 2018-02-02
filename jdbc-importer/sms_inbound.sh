#!bin/bash
bin=/home/ubuntu/elastic/elasticsearch-jdbc-2.3.4.0/bin
lib=/home/ubuntu/elastic/elasticsearch-jdbc-2.3.4.0/lib
echo '
{
    "type" : "sms_inbound",
    "jdbc" : {
        "url" : "jdbc:mysql://hawkeye-test.clxybluj7kyg.ap-southeast-1.rds.amazonaws.com:3306/hawkeye_staging_fixed",
        "user" : "hetest",
        "password" : "OGYyZTk5NjJkOGM",
        "sql" : "SELECT sms_inbound.*, contact.first_name AS contact_first_name, contact.last_name AS contact_last_name, message_folders_message_folder.is_valid AS message_folder_is_valid, message_folders_message_folder.inbound_id as message_folder_inbound_id FROM (sms_inbound) LEFT OUTER JOIN contact contact ON contact.id = sms_inbound.contact_id LEFT OUTER JOIN message_folder message_folders_message_folder ON sms_inbound.id =message_folders_message_folder.inbound_id",
        "treat_binary_as_string" : true,
        "elasticsearch" : {
            "cluster" : "elasticsearch",
            "host" : "localhost",
            "port" : 9300,
            "autodiscover": true
        },
        "index" : "hawkeye",
        "type"  : "sms_inbound"
    }
}
' | java \
-cp "${lib}/*" \
-Dlog4j.configurationFile=${bin}/log4j2.xml \
org.xbib.tools.Runner \
org.xbib.tools.JDBCImporter
echo "Done......."

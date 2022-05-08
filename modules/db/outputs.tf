output "db_name" {
  value = oci_database_autonomous_database.adb_dw.display_name
}

output "db_state" {
  value = oci_database_autonomous_database.adb_dw.state
}
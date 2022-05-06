# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

locals {
 
  generate_dbschema_sql_template = templatefile("${path.module}/scripts/create_db_schema.template.sql", {})

  generate_dbschema_sh_template = templatefile("${path.module}/scripts/create_db_schema.template.sh", {})

}

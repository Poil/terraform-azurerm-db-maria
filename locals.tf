locals {
  name_prefix         = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""
  default_server_name = lower("${local.name_prefix}${var.stack}-${var.client_name}-${var.location_short}-${var.environment}-mariadb")
  server_name         = coalesce(var.custom_server_name, "${local.default_server_name}")

  administrator_login    = format("%s@%s", azurerm_mariadb_server.mariadb_server.administrator_login, azurerm_mariadb_server.mariadb_server.name)
  administrator_password = var.administrator_password == "" ? random_password.mariadb_administrator_password.result : var.administrator_password

  db_users_login = formatlist("%s@%s", mysql_user.users[*].user, azurerm_mariadb_server.mariadb_server.name)

  tier_map = {
    "GeneralPurpose"  = "GP"
    "Basic"           = "B"
    "MemoryOptimized" = "MO"
  }

  default_tags = {
    env   = var.environment
    stack = var.stack
  }

}

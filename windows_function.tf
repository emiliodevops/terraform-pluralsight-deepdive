
resource "azurerm_windows_function_app" "WindowsFunction1" {
  app_settings = {
    FUNCTIONS_INPROC_NET8_ENABLED = "1"
    EMILIO_DATA                   = "ApplicationData"
  }
  builtin_logging_enabled                  = false
  client_certificate_enabled               = false
  client_certificate_exclusion_paths       = null
  client_certificate_mode                  = "Required"
  content_share_force_disabled             = false
  daily_memory_time_quota                  = 0
  enabled                                  = true
  ftp_publish_basic_authentication_enabled = true
  functions_extension_version              = "~4"
  https_only                               = false
  location                                 = "eastus"
  name                                     = "OrderFunctioneaa1cd1b77"
  public_network_access_enabled            = true
  resource_group_name                      = "rg-apim-training"
  service_plan_id                          = "/subscriptions/15daa60f-4479-482d-8728-a1d99f5ee7ed/resourceGroups/rg-apim-training/providers/Microsoft.Web/serverFarms/EastUSPlan"
  storage_account_access_key               = null # sensitive
  storage_account_name                     = "storestorage2ca3eb53e0"
  storage_key_vault_secret_id              = null
  storage_uses_managed_identity            = false
  tags = {
    "hidden-link: /app-insights-conn-string"         = "InstrumentationKey=b427c0eb-0869-4877-b410-c9665cc9e3ff;IngestionEndpoint=https://eastus-8.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus.livediagnostics.monitor.azure.com/;ApplicationId=67acc8b7-a019-4b85-a56b-522fc9fd8c4e"
    "hidden-link: /app-insights-instrumentation-key" = "b427c0eb-0869-4877-b410-c9665cc9e3ff"
    "hidden-link: /app-insights-resource-id"         = "/subscriptions/15daa60f-4479-482d-8728-a1d99f5ee7ed/resourceGroups/rg-apim-training/providers/microsoft.insights/components/OrderFunctioneaa1cd1b77"
  }
  virtual_network_subnet_id                      = null
  webdeploy_publish_basic_authentication_enabled = true
  zip_deploy_file                                = null
  site_config {
    always_on                              = false
    api_definition_url                     = null
    api_management_api_id                  = null
    app_command_line                       = null
    app_scale_limit                        = 200
    application_insights_connection_string = null # sensitive
    application_insights_key               = null # sensitive
    default_documents                      = ["Default.htm", "Default.html", "Default.asp", "index.htm", "index.html", "iisstart.htm", "default.aspx", "index.php"]
    elastic_instance_minimum               = 1
    ftps_state                             = "FtpsOnly"
    health_check_path                      = null
    http2_enabled                          = true
    ip_restriction_default_action          = null
    load_balancing_mode                    = "LeastRequests"
    managed_pipeline_mode                  = "Integrated"
    minimum_tls_version                    = jsonencode(1.2)
    pre_warmed_instance_count              = 0
    remote_debugging_enabled               = false
    remote_debugging_version               = "VS2022"
    runtime_scale_monitoring_enabled       = false
    scm_ip_restriction_default_action      = null
    scm_minimum_tls_version                = jsonencode(1.2)
    scm_use_main_ip_restriction            = false
    use_32_bit_worker                      = true
    vnet_route_all_enabled                 = false
    websockets_enabled                     = false
    worker_count                           = 1
    application_stack {
      dotnet_version              = "v8.0"
      use_dotnet_isolated_runtime = false
    }
    cors {
      allowed_origins     = ["https://portal.azure.com"]
      support_credentials = false
    }
  }
}

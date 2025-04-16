provider "azurerm" {
  features {}
  subscription_id = "c55e620b-000d-45fb-9dbb-da2840b9c5d0"
}

resource "azurerm_resource_group" "this" {
  name     = "rg-jenkins"
  location = var.location
}

resource "azurerm_service_plan" "this" {
  name                = "appserviceplan-jenkins"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"

  sku_name = "B1"
}

resource "azurerm_linux_web_app" "this" {
  name                = "webapijenkinsnaitik457"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id  # Updated attribute

  site_config {
    always_on = true
  }
}


provider "azurerm" {
  features {}
  subscription_id = "c55e620b-000d-45fb-9dbb-da2840b9c5d0"
}

resource "azurerm_resource_group" "main" {
  name     = "rg-jenkins"
  location = "East US 2"
}

resource "azurerm_container_registry" "acr" {
  name                = "acrnaitik0564571"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aksnaitik7563701"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "dotnetaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}

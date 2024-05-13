
package main

allowed_locations := {"westus", "westus2", "eastus", "eastus2"}

deny[msg] {
    some i
    input.resource_changes[i].type == "azurerm_resource_group"
    not regex.match("^azr-rg-[a-zA-Z0-9]{1,6}$", input.resource_changes[i].change.after.name)
    msg := sprintf("Resource Group '%s' does not match the required name pattern 'azr-rg-bu-eco-env' with a maximum of 12 characters", [input.resource_changes[i].change.after.name])
}

deny[msg] {
    some i
    input.resource_changes[i].type == "azurerm_resource_group"
    location := input.resource_changes[i].change.after.location
    not allowed_locations[location]
    msg := sprintf("Resource Group '%s' is in the '%s' location, which is not allowed", [input.resource_changes[i].change.after.name, location])
}
param($name)

Connect-PnPOnline -Url $env:PNP_SPO_ADMIN_URL -ClientId $env:PNP_CLIENT_ID -Thumbprint $env:PNP_CERT_THUMBPRINT -Tenant $env:PNP_TENANT_URL

Get-PnPTenantSite | Select-Object Url
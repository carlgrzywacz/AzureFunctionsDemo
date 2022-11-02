param($name)

#"Hello $name!"

Connect-PnPOnline -Url $env:PNP_SPO_REPORT_URL -ManagedIdentity
#Add-PnPFile -FileName DemoResults.txt -Folder "Shared Documents" -Content #'{ "Test": "Value" }'

$report = $name | ConvertTo-Json;

Add-PnPFile -FileName AzureFunctionReport.json -Folder "Shared Documents" -Content $report
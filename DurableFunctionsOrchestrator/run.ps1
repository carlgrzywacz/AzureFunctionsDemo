param($Context)

$output = @()

# Default Durable Function Code
# $output += Invoke-DurableActivity -FunctionName 'Set-UserExpiration' -Input 'Tokyo'
# $output += Invoke-DurableActivity -FunctionName 'Set-UserExpiration' -Input 'Seattle'
# $output += Invoke-DurableActivity -FunctionName 'Set-UserExpiration' -Input 'London'

#Pattern #1: Function chaining
# $X = Invoke-DurableActivity -FunctionName 'F1'
# $Y = Invoke-DurableActivity -FunctionName 'F2' -Input $X
# $Z = Invoke-DurableActivity -FunctionName 'F3' -Input $Y
# Invoke-DurableActivity -FunctionName 'F4' -Input $Z

## Get a list of work items to process in parallel.
$sites = Invoke-DurableActivity -FunctionName 'Get-SPOSites'

#Pattern #2: Fan out/Fan in 
$ParallelTasks =
    foreach ($site in $sites) {
        Invoke-DurableActivity -FunctionName 'Set-UserExpiration' -Input $site.Url -NoWait
    }

$Outputs = Wait-ActivityFunction -Task $ParallelTasks

# Save Results to SP List
Invoke-DurableActivity -FunctionName 'Add-UserExpirationReport' -Input $Outputs

$output
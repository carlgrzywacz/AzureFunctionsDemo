param($name)

#"Processing Site: $name!"

Connect-PnPOnline -Url $name -ManagedIdentity

# get all site users​
$newUserExpirations = @();

$users = Get-PnPUser -Includes Expiration, IsSiteAdmin | Where-Object {$_.PrincipalType -eq "User" -and -not $_.IsSiteAdmin}

foreach($user in $users)
{ 
    $user.Expiration = [DateTime]::UtcNow.AddDays(30).ToString("yyyy-MM-ddTHH:mm:ssZ");
    $user.Update();

    $newUserExpirations += New-Object PSObject -Property @{
        Site       = $name
        User       = $user.LoginName
        Expiration = $user.Expiration
    }
}

Invoke-PnPQuery

$newUserExpirations
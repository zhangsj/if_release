#
# PreDeploy.ps1 for Ocotpus deployment
#
trap [Exception] {
    $host.SetShouldExit(1)
    break
}

function FindApp($appName)
{
    # Search path for app
    foreach ($path  in $env:PATH.Split(";") ) {
        $name = "${path}\${appName}"
        $name = $name.Replace("`"", "")      
        if (test-path $name) {
            return $name
        }
    }    

    return $null
}

$IFDeaOriginalFile = join-path $OctopusOriginalPackageDirectoryPath dea_original.yml
$IFDeaConfigFile = join-path $OctopusOriginalPackageDirectoryPath dea.yml

Write-Host "Copying from host $IFExampleDeaConfigHost"
Get-SCP -Server $IFExampleDeaConfigHost -RemoteFile /var/vcap/jobs/dea_next/config/dea.yml -LocalFile $IFDeaOriginalFile -User $IFExampleDeaUserName -Password $IFExampleDeaUserPassword -Force

$rubyExe = FindApp "ruby.exe"
if ($rubyExe -eq $null)
{
    throw 'Could not find ruby application.'
}

$rubyPath = split-path $rubyExe

. $rubyExe configure-dea.rb $IFDeaOriginalFile $rubyPath $IFRootDataPath $IFDeaConfigFile

Set-OctopusVariable -Name "IFDeaConfigFile" -Value $IFDeaConfigFile
Write-Host "Starting IronFoundry for .NET Services..."

Start-Service IFDeaDirSvc
Start-Service ironfoundry.warden
Start-Service IFDeaSvc

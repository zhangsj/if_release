Write-Host "Starting IronFoundry for .NET Services"

Stop-Service IFDeaSvc
Stop-Service ironfoundry.warden
Stop-Service IFDeaDirSvc

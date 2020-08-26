function Connect-OPExchange {
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$false)]
		[PSCredential]$Credentials,
		[Parameter(Mandatory=$true)]
		[String]$Server
	)
	
	$credFile = "$($env:USERPROFILE)\Documents\WindowsPowerShell\Credentials\exchange.xml"
    
    if(!$Credentials -and (Test-Path $credFile)) {
		$UserCredential = Import-Clixml $credFile
	}
	else {
		$UserCredential = $Credentials
	}
 
	$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "http://$($Server)/PowerShell/" -Credential $UserCredential
 
	Import-PSSession $Session -DisableNameChecking -Prefix OP
}
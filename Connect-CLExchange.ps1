function Connect-CLExchange {
    [CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$false)]
		[PSCredential]$Credentials
    )

    $credFile = "$($env:USERPROFILE)\Documents\WindowsPowerShell\Credentials\exchange.xml"
    
    if(!$Credentials -and (Test-Path $credFile)) {
        $UserCredential = Import-Clixml $credFile
    }
    else {
        $UserCredential = $Credentials
    }
 
    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $UserCredential -Authentication Basic -AllowRedirection
 
    Import-PSSession $Session -DisableNameChecking -Prefix CL
}
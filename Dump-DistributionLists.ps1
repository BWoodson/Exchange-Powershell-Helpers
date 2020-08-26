Function Dump-DistributionLists
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$true)]
		[PSObject[]]$DistributionLists
	)

	$DistributionLists | Foreach-Object {
		# Save the dl information
		$dlIdentity = $_.Identity
		$dlName = $_.DisplayName
		$dlEmail = $_.PrimarySmtpAddress
		
		# Grab the members of the dl
		$members = @(Get-CLDistributionGroupMember $dlEmail -ResultSize Unlimited)

		foreach( $member in $members )
		{
			# Create a new object that just contains the information we want to see
			$obj = [PSCustomObject]@{
				DLIdentity  = $dlIdentity
				DLName      = $dlName
				DLEmail     = $dlEmail
				UserName	= $member.Name
				UserEmail	= $member.PrimarySmtpAddress
			}

			# Dump the object to the pipeline. Capturing the output of this function to a variable creates an array of these objects
			$obj
		}
	}
}
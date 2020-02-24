<#
    Invoke-VulDBAPI - PowerShell VulDB API Demo
    
    License: GPL-3.0    
    Required Dependencies: None
    Optional Dependencies: None
#>

# Define parameters for API script
[CmdletBinding()]
Param (
    [ValidateSet(0,1)]    
    [Int]
    $Details,

    [Int]
    $Recent,

    [Int]
    $Id
)

# Add your personal API key here
$PersonalApiKey = ''

# Set HTTP Header
$UserAgent = 'VulDB API Advanced PowerShell Demo Agent'
$Headers = @{'User-Agent' = $UserAgent;'X-VulDB-ApiKey' = $PersonalApiKey}

# URL VulDB endpoint
$Uri = 'https://vuldb.com/?api'

Function Main() {

    # Choose the API call based on the passed parameters
    # Default call is the last 5 recent entries
    If ($Recent -ne 0) {
        $Body = @{'recent' = $Recent}
    } ElseIf ( $Id -ne 0) {
        $Body = @{'id' = $Id}        
    } Else {
        $Body = @{'recent' = 5}
    }

    If ($Recent -ne 0) {
        $Body['details'] = $Details
    }

    # Get API response
    $Response = Invoke-WebRequest -Headers $Headers -Method Post -Uri $Uri -Body $Body

    # Display result if evertything went OK
    If ($Response.StatusCode -eq 200) {

        # Parse HTTP body as JSON
        $ResponseJson = ConvertFrom-Json($Response.Content)
        # Output 
        $ResponseJson.result
    }
}

Main
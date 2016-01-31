function Get-DotNetVersion {
    Clear-Host
    Write-Host 'Installed .NET Framework Components' -ForegroundColor Green
    Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -Recurse |
    Get-ItemProperty -Name Version,Release -ErrorAction 0 |
    Where-Object { $_.PSChildName -match '^(?!S)\p{L}'} |
    Select-Object -Property @{N='.NET Component';E={$_.PSChildName}}, @{N='Version';E={$_.Version}} |
    Sort-Object -Property Version -Descending |
    Format-Table -AutoSize
}

function Test-Domain {
[CmdletBinding()]
Param (
    [parameter(position=0,
        Mandatory=$true,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)]
    [string]$ComputerName='.'
)
Begin {}
Process {
    Write-Host 'Domain or Workgroup Membership' -ForegroundColor Green
    Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ComputerName | 
        Select-Object -Property Name, Domain | Format-Table -AutoSize
}
End {}
}

Get-DotNetVersion
Test-Domain -ComputerName 'localhost'
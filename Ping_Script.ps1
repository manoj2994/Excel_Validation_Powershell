

function prompt{

"\_(ツ)_/"

}

$ip = '10.170.9.0'

function Test-Ping{


[cmdletbinding()]param(


)

begin{



[System.Object]$result = @()
$n =$ip.Count
$ip = Import-Csv -Path "\\172.20.108.150\e$\IS\daily\ISLAB\ISLAB_TEST_PING.csv"
Write-Verbose "[Reading ]File Reading From Share Path" -Verbose
Write-Verbose "[Started ]Servers Started Testing" -Verbose
}

process{



foreach ($i in $ip){


try{
$ping = New-Object System.Net.NetworkInformation.Ping
$test = $ping.Send("$($i.'IP ADDRESS')",1900)


#$dns = [Net.DNS]::GetHostEntry("$i")





switch ( $test.Status)  {


("TimedOut"){

$i | Add-Member -MemberType NoteProperty -Name "STATUS AT $((get-date).tostring('d.M.y-hh tt'))" -Value "OFFLINE" -Force


$result += $i

}

( "Success"){

   
   $i | Add-Member -MemberType NoteProperty -Name "STATUS AT $((get-date).tostring('d.M.y-hh tt'))" -Value "ONLINE" -Force
   $result += $i 

}

("DestinationHostUnreachable") {

$i | Add-Member -MemberType NoteProperty -Name "STATUS AT $((get-date).tostring('d.M.y-hh tt'))" -Value "HOST NOT REACHABLE" -Force
 
  $result += $i 

}



}
}

catch{

	$i | Add-Member -MemberType NoteProperty -Name "STATUS AT $((get-date).tostring('d.M.y-hh tt'))" -Value "HOST NOT FOUND" -Force
 
        $result += $i 

}

}



}

end{

$Totalo=($ip."STATUS AT $((get-date).tostring('d.M.y-hh tt'))" | where {$_ -eq "OFFLINE"} ).count
$Total= ($ip.'IP ADDRESS').Count

  if(($result."STATUS AT $((get-date).tostring('d.M.y-hh tt'))" ) -eq "OFFLINE"){
 Write-Host ""
 Write-Warning -Message "ALERT!!!!!!!! TEAM PLEASE TAKE IMMEDIATE ACTION ON THE BELOW SERVERS"
 write-host "This Report is Taken From VDI: " -NoNewline
 Write-Host $env:COMPUTERNAME -ForegroundColor green

 Write-Host "`nTotal Number of Servers Checked: " -NoNewline
 Write-Host $Total -ForegroundColor green
 write-host "`nTotal Number of Servers OFFLINE: " -NoNewline 
 Write-Host $Totalo  -ForegroundColor green


 $result | select -Property 'Computer Name', 'IP ADDRESS','Domain',"STATUS AT $((get-date).tostring('d.M.y-hh tt'))"  |Where-Object  {($_."STATUS AT $((get-date).tostring('d.M.y-hh tt'))") -contains 'OFFLINE' }

  }
  
  
  else{


Write-Host ""
Write-Host "ALL Reachable  100%  " -ForegroundColor Green
write-host "This Report is Taken From VDI: " -NoNewline
Write-Host $env:COMPUTERNAME -ForegroundColor green

Write-Host "`nTotal Number of Servers Checked: " -NoNewline
Write-Host $Total -ForegroundColor green
write-host "`nTotal Number of Servers OFFLINE: " -NoNewline 
Write-Host $Totalo  -ForegroundColor green


}

try{

$result | Export-Csv -NoTypeInformation "\\172.20.108.150\e$\IS\daily\ISLAB\ISLAB_TEST_PING.csv"

}
catch{




Write-Warning "Unable to Save the Excel File in the Path ,The Sheet is opened.Please close and Try again " 

write-host ""

}
Clear-Variable -Name result,ip
}


}

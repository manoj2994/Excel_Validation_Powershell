

function prompt{

"\_(ツ)_/"

}

$ip = '10.170.9.0'

function Test-Ping{


[cmdletbinding()]param(


)

begin{

$ping = New-Object System.Net.NetworkInformation.Ping
$ip = (Get-Content C:\Users\Administrator\Desktop\servers.txt)
$array = @()
$n =$ip.Count

 
}

process{



foreach ($i in $ip){


try{

$check = $ping.SendPingAsync("$i")

$test = $check.result
#$dns = [Net.DNS]::GetHostEntry("$i") 


if ($test.Status -eq "TimedOut" ){


$PingStatus = [pscustomobject]@{

'STATUS' = "OFFLINE" 

'IP ADDRESS' = "$i"

                         }


$array += $PingStatus

}


 
   

}catch{

$error =$_.Exception.Message

}
}

}



end{

  if($array.STATUS -eq "OFFLINE"){

 Write-Warning -Message "Team Please Take Neccesary Action Before gets Escalation form Either Team or Ramathas"

 $array

  }else{



Write-Host "ALL Reachable  100%  " -ForegroundColor Green

}

}
}
Clear-Variable -Name array



ping 10.0.0.0



foreach ($i in $ip){

$i


}
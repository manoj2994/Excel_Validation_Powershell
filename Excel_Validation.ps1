$hi = Import-Csv -Path "C:\Users\lenovo\Documents\Test_Karthik.csv"

$hi | gm

function Validation-Excel {

    param(

        # Parameter help description
        [Parameter(Mandatory = $true)]
        [PSCustomObject]
        $hi
        
    )

    foreach ($i in $hi) {


        switch -Wildcard ($i) {


            ( {$i -imatch 'TamilNadu'}) {

                switch -Regex ($i.PassCode) {
                    '\d\d\d-\d\d-\d\d\d' {
                        $i | Add-Member -MemberType NoteProperty -Name 'Status' -Value 'OK' -Force
                    }

                    default {
                        $i | Add-Member -MemberType NoteProperty -Name 'Status' -Value 'NOT OK' -Force
                    }
                }

            }


     

            ( {$i -imatch 'Mumbai'}) {

                switch -Regex ($i.PassCode) {

                    '^[a-z]{3}-[0-9]{2}$' {
                        $i | Add-Member -MemberType NoteProperty -Name 'Status' -Value 'OK' -Force
                    }

                    default {
                        $i | Add-Member -MemberType NoteProperty -Name 'Status' -Value 'NOT OK' -Force
                    }

                }

 

            }

            ( {$i -imatch 'Kerela'}) {
                switch -Regex ($i.PassCode) {

                    '[a-z]{5}' {


                        $i | Add-Member -MemberType NoteProperty -Name 'Status' -Value 'OK' -Force
                    }

                    default {

                        $i | Add-Member -MemberType NoteProperty -Name 'Status' -Value 'OK' -Force


                    }
                }
            }


            default {

                Out-Null

            }


        }

        $i
    }

}



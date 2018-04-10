Function Form {
    <#
    .SYNOPSIS
    Generates Form HTML tag.
    
    .EXAMPLE
    
    form "/action_Page.php" post _self
    
    Generates the following html element: (Not very usefull, we both agree on that)

    <from action="/action_Page.php" method="post" target="_self" >
    </form>
    
    .EXAMPLE
    The following Example show how to pass custom HTML tag and their values
    form "/action_Page.php" post _self -attributes @{"Woop"="Wap";"sap"="sop"}

    .NOTES
    Current version 0.8
    History:
        2018.04.08;Stephanvg; Fixed custom Attributes display bug. Updated help
        2018.04.01;Stephanevg;Fix disyplay bug.

    #>
    [CmdletBinding()]
    Param(

        [Parameter(Mandatory=$true,Position = 0)]
        [String]$action,

        [Parameter(Mandatory=$true,Position = 1)]
        [ValidateSet("get","post")]
        [String]$method = "get",

        [Parameter(Mandatory=$true,Position = 2)]
        [ValidateSet("_blank","_self","_parent","top")]
        [String]$target = "_self",

        [Parameter(Position = 3)]
        [String]$Class,

        [Parameter(Position = 4)]
        [String]$Id,

        [Parameter(Position = 5)]
        [String]$Style,

        [Parameter(Position = 6)]
        [Hashtable]$Attributes,

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 7
        )]
        [scriptblock]
        $Content
    )
    Process{

        $attr = ""
        $CommonParameters = ("Attributes", "content") + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | ? { $_ -notin $CommonParameters }
        
        if($CustomParameters){
            
            foreach ($entry in $CustomParameters){

                
                $Attr += "{0}=`"{1}`" " -f $entry,$PSBoundParameters[$entry]
    
            }
                
        }

        if($Attributes){
            foreach($entry in $Attributes.Keys){
               
                $attr += "{0}=`"{1}`" " -f $entry,$Attributes[$Entry]
            }
        }

        if($attr){
            "<form {0} >"  -f $attr
        }else{
            "<form>"
        }
        
      

        if($Content){
            $Content.Invoke()
        }
            

        '</form>'
    }
    
    
}


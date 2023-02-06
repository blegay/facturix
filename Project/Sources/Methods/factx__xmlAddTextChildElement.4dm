//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : factx__xmlAddTextChildElement
//@scope : private 
//@attributes :    
//@deprecated : no
//@description : This method adds an element and sets the text value
//@parameter[0-OUT-domRefNew-TEXT] : new dom ref
//@parameter[1-IN-domRef-TEXT] : dom ref
//@parameter[2-IN-elementName-TEXT] : element name
//@parameter[3-IN-value-TEXT] : value
//@notes : 
//@example : factx__xmlAddTextChildElement
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 28/08/2022, 14:21:55 - 1.00.00
//@xdoc-end
//================================================================================

C_TEXT:C284($0; $vt_domRefNew)
C_TEXT:C284($1; $vt_domRef)
C_TEXT:C284($2; $vt_elementName)
C_TEXT:C284($3; $vt_value)

$vt_domRefNew:=""
$vt_domRef:=$1
$vt_elementName:=$2
$vt_value:=$3

$vt_domRefNew:=DOM Append XML child node:C1080($vt_domRef; XML ELEMENT:K45:20; $vt_elementName)
DOM SET XML ELEMENT VALUE:C868($vt_domRefNew; $vt_value)

$0:=$vt_domRefNew
//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : factx__xmlAddRealChildElement
//@scope : private 
//@attributes :    
//@deprecated : no
//@description : This method adds an element and sets the value 
//@parameter[0-OUT-domRefNew-TEXT] : new dom ref
//@parameter[1-IN-domRef-TEXT] : dom ref
//@parameter[2-IN-elementName-TEXT] : element name
//@parameter[3-IN-value-REAL] : value
//@notes : 
//@example : FACT__xmlAddRealChildElement
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 28/08/2022, 15:17:23 - 1.00.00
//@xdoc-end
//================================================================================

C_TEXT:C284($0; $vt_domRefNew)
C_TEXT:C284($1; $vt_domRef)
C_TEXT:C284($2; $vt_elementName)
C_REAL:C285($3; $vr_value)

$vt_domRefNew:=""
$vt_domRef:=$1
$vt_elementName:=$2
$vr_value:=$3

$vt_domRefNew:=DOM Append XML child node:C1080($vt_domRef; XML ELEMENT:K45:20; $vt_elementName)
DOM SET XML ELEMENT VALUE:C868($vt_domRefNew; $vr_value)

$0:=$vt_domRefNew
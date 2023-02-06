//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : factx__xmlAddDateChildElement
//@scope : private 
//@attributes :    
//@deprecated : no
//@description : This method adds a "udt:DateTimeString" element with a date value
//@parameter[1-IN-domRef-TEXT] : dom is modified
//@parameter[2-IN-date-DATE] : date
//@notes : 
//@example : factx__xmlAddDateChildElement
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 28/08/2022, 09:59:33 - 1.00.00
//@xdoc-end
//================================================================================

C_TEXT:C284($1; $vt_domRef)
C_DATE:C307($2; $vd_date)

$vt_domRef:=$1
$vd_date:=$2

C_TEXT:C284($vt_domRefTmp)
$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRef; XML ELEMENT:K45:20; "udt:DateTimeString")
DOM SET XML ATTRIBUTE:C866($vt_domRefTmp; "format"; "102")

DOM SET XML ELEMENT VALUE:C868($vt_domRefTmp; \
String:C10(Year of:C25($vd_date); "0000")+\
String:C10(Month of:C24($vd_date); "00")+\
String:C10(Day of:C23($vd_date); "00"))
//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : factx__xmlSetParty
//@scope : private
//@attributes :
//@deprecated : no
//@description : This method/function returns
//@parameter[1-INOUT-domRef-TEXT] : party xml dom reference (dom is modified)
//@parameter[2-IN-party-OBJECT] : party (seller or buyer) object
//@notes :
//@example : factx__xmlSetParty
//@see :
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
//@history :
//  CREATION : Bruno LEGAY (BLE) - 28/08/2022, 11:09:18 - 1.00.00
//@xdoc-end
//================================================================================

C_TEXT:C284($1; $vt_domRef)
C_OBJECT:C1216($2; $vo_party)

$vt_domRef:=$1
$vo_party:=$2

C_TEXT:C284($vt_domRefTmp)
$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRef; XML ELEMENT:K45:20; "ram:Name")  // facturx-BT-27 / facturx-BT-44
DOM SET XML ELEMENT VALUE:C868($vt_domRefTmp; $vo_party.name)

If ($vo_party.siret#Null:C1517)
	$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRef; XML ELEMENT:K45:20; "ram:SpecifiedLegalOrganization")  // facturx-BT-30-00 / facturx-BT-47-00
	$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefTmp; XML ELEMENT:K45:20; "ram:ID")  // facturx-BT-30 / facturx-BT-47
	DOM SET XML ELEMENT VALUE:C868($vt_domRefTmp; $vo_party.siret)
	DOM SET XML ATTRIBUTE:C866($vt_domRefTmp; "schemeID"; "0002")  // facturx-BT-30-1 / facturx-BT-47-1
End if 

C_TEXT:C284($vt_domRefAddress)
$vt_domRefAddress:=DOM Append XML child node:C1080($vt_domRef; XML ELEMENT:K45:20; "ram:PostalTradeAddress")  // facturx-BG-5 / facturx-BG-8

If ($vo_party.postcode#Null:C1517)
	factx__xmlAddTextChildElement($vt_domRefAddress; "ram:PostcodeCode"; $vo_party.postcode)  // facturx-BT-38 / facturx-BT-53
End if 

If ($vo_party.lineOne#Null:C1517)
	factx__xmlAddTextChildElement($vt_domRefAddress; "ram:LineOne"; $vo_party.lineOne)  // facturx-BT-35 / facturx-BT-50
End if 

If ($vo_party.lineTwo#Null:C1517)
	factx__xmlAddTextChildElement($vt_domRefAddress; "ram:LineTwo"; $vo_party.lineTwo)  // facturx-BT-36 / facturx-BT-51
End if 

If ($vo_party.lineThree#Null:C1517)
	factx__xmlAddTextChildElement($vt_domRefAddress; "ram:LineThree"; $vo_party.lineThree)  // facturx-BT-162 / facturx-BT-163
End if 

If ($vo_party.cityName#Null:C1517)
	factx__xmlAddTextChildElement($vt_domRefAddress; "ram:CityName"; $vo_party.cityName)  // facturx-BT-37 / facturx-BT-52
End if 

If ($vo_party.countrySubDivisionName#Null:C1517)
	factx__xmlAddTextChildElement($vt_domRefAddress; "ram:CountrySubDivisionName"; $vo_party.countrySubDivisionName)  // facturx-BT-39 / facturx-BT-54
End if 

factx__xmlAddTextChildElement($vt_domRefAddress; "ram:CountryID"; $vo_party.countryID)  // facturx-BT-40 / facturx-BT-55

If ($vo_party.email#Null:C1517)
	$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRef; XML ELEMENT:K45:20; "ram:URIUniversalCommunication")  // facturx-BT-34-00  facturx-BT-49-00
	$vt_domRefTmp:=factx__xmlAddTextChildElement($vt_domRefTmp; "ram:URIID"; $vo_party.email)  // facturx-BT-34 / facturx-BT-49
	DOM SET XML ATTRIBUTE:C866($vt_domRefTmp; "schemeID"; "EM")
End if 

If ($vo_party.noTVA#Null:C1517)
	$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRef; XML ELEMENT:K45:20; "ram:SpecifiedTaxRegistration")  // facturx-BT-31-00 / facturx-BT-48-00
	$vt_domRefTmp:=factx__xmlAddTextChildElement($vt_domRefTmp; "ram:ID"; $vo_party.noTVA)  // facturx-BT-31 / facturx-BT-48
	DOM SET XML ATTRIBUTE:C866($vt_domRefTmp; "schemeID"; "VA")
End if 
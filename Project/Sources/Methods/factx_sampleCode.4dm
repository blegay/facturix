//%attributes = {"invisible":false,"shared":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : factx_sampleCode
//@scope : public
//@deprecated : no
//@description : This is a sample code for generation factur-x xml
//@notes :
//@example :
//
//  C_OBJECT($vo_data)
//  $vo_data:=New object
//
//  $vo_data.profile:="BASIC"  // ("MINIMUM", "BASIC-WL", "BASIC", "EN16931" or "EXTENDED")
//  // ...
//
//  // convert object to factur-x xml
//  C_TEXT($vt_xml)
//  If (factx_objectToFacturx($vo_data; ->$vt_xml))
//
//  End if
//
//@see :
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2023
//@history :
//  CREATION : Bruno LEGAY (BLE) - 31/01/2023, 07:48:56 - 0.50.00
//@xdoc-end
//================================================================================

C_OBJECT:C1216($vo_data)
$vo_data:=New object:C1471

$vo_data:=factx_sampleData

// convert object to factur-x xml
C_TEXT:C284($vt_xml)
If (factx_objectToFacturx($vo_data; ->$vt_xml; False:C215))
	
	//%T-
	SET TEXT TO PASTEBOARD:C523($vt_xml)
	//%T+
	
End if 
//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
//================================================================================
//@xdoc-start : en
//@name : factx_testcasesRun
//@scope : public
//@deprecated : no
//@description : This method runs a crude testcases
//@notes :
//@example : factx_testcasesRun
//@see :
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2023
//@history :
//  CREATION : Bruno LEGAY (BLE) - 31/01/2023, 07:26:55 - 0.50.00
//@xdoc-end
//================================================================================

SET ASSERT ENABLED:C1131(True:C214)

C_TEXT:C284($vt_testcasesDir)
$vt_testcasesDir:=Get 4D folder:C485(Current resources folder:K5:16)+"testcases"+Folder separator:K24:12

ARRAY TEXT:C222($tt_testcase; 0)
APPEND TO ARRAY:C911($tt_testcase; "test1_basic")

C_BOOLEAN:C305($vb_reset)
$vb_reset:=False:C215

C_OBJECT:C1216($vo_data)
C_TEXT:C284($vt_testcase)
C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($tt_testcase))
	$vt_testcase:=$tt_testcase{$i}
	
	$vo_data:=factx_sampleData($vt_testcase)
	
	C_TEXT:C284($vt_jsonExpected; $vt_json)
	$vt_json:=JSON Stringify:C1217($vo_data; *)
	
	If ($vb_reset)
		TEXT TO DOCUMENT:C1237($vt_testcasesDir+$vt_testcase+".json"; $vt_json; "UTF-8"; Document with LF:K24:22)
	Else 
		$vt_jsonExpected:=Document to text:C1236($vt_testcasesDir+$vt_testcase+".json"; "UTF-8"; Document with LF:K24:22)
		ASSERT:C1129(Generate digest:C1147($vt_jsonExpected; MD5 digest:K66:1)=Generate digest:C1147(JSON Stringify:C1217($vo_data; *); MD5 digest:K66:1); $vt_testcase+" - json result failed")
	End if 
	
	// convert object to factur-x xml
	C_BLOB:C604($vx_xml; $vx_xmlExpected)
	If (factx_objectToFacturx($vo_data; ->$vx_xml; False:C215))
		
		If ($vb_reset)
			BLOB TO DOCUMENT:C526($vt_testcasesDir+$vt_testcase+".xml"; $vx_xml)
		Else 
			DOCUMENT TO BLOB:C525($vt_testcasesDir+$vt_testcase+".xml"; $vx_xmlExpected)
			ASSERT:C1129(Generate digest:C1147($vx_xmlExpected; MD5 digest:K66:1)=Generate digest:C1147($vx_xml; MD5 digest:K66:1); $vt_testcase+" - factx_objectToFacturx xml result failed")
		End if 
		
	Else 
		ASSERT:C1129(False:C215; $vt_testcase+" - factx_objectToFacturx failed")
	End if 
	
End for 

ARRAY TEXT:C222($tt_testcase; 0)

ALERT:C41("end")

//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : xml_blobEraseBom
//@scope : private
//@deprecated : no
//@description : This method will erase the BOM from a blob
//@parameter[1-INOUT-blobPtr-POINTER] : xml blob pointer (modified)
//@notes : since 4D v13, DOM EXPORT TO VAR generates blob with DOM, unlike previous versions
//@example : xml_blobEraseBom 
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2015
//@history : CREATION : Bruno LEGAY (BLE) - 18/09/2014, 15:47:11 - v1.00.00
//@xdoc-end
//================================================================================

C_POINTER:C301($1; $vp_xmlBlobPtr)  //xml blob pointer

If (Count parameters:C259>0)
	$vp_xmlBlobPtr:=$1
	
	If (Type:C295($vp_xmlBlobPtr->)=Is BLOB:K8:12)
		
		C_LONGINT:C283($vl_bomSize)
		$vl_bomSize:=xml_blobBomSize($vp_xmlBlobPtr)
		
		If ($vl_bomSize>0)
			DELETE FROM BLOB:C560($vp_xmlBlobPtr->; 0; $vl_bomSize)
		End if 
		
	End if 
	
End if 

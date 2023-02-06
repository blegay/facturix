//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : xml_blobBomSize
//@scope : private
//@deprecated : no
//@description : This function will return the size of the BOM (and offset of the xml real data)
//@parameter[0-OUT-bomSize-LONGINT] : bom size (2, 3, 4 or 0 if no BOM)
//@parameter[1-IN-xmlBlobPtr-POINTER] : xml blob pointer (not modified)
//@notes : 
//@example : xml_blobBomSize
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY- Copyrights A&C Consulting - 2017
//@history : 
//  CREATION : Bruno LEGAY - 01/10/2017, 12:48:28 - 1.00.00
//@xdoc-end
//================================================================================

C_LONGINT:C283($0; $vl_bomSize)  //index start
C_POINTER:C301($1; $vp_xmlBlobPtr)  //xml blob pointer

$vl_bomSize:=0
If (Count parameters:C259>0)
	$vp_xmlBlobPtr:=$1
	
	If (Type:C295($vp_xmlBlobPtr->)=Is BLOB:K8:12)
		
		C_LONGINT:C283($vl_size)
		$vl_size:=BLOB size:C605($vp_xmlBlobPtr->)
		If ($vl_size>1)  //a bom is at least 2 bytes...
			
			//The code needs to work even for a 2 bytes blob (could be an empty file with bom)
			//$vx_blob needs to be for bytes (no more is necessary, but no less)
			C_BLOB:C604($vx_blob)
			SET BLOB SIZE:C606($vx_blob; 4; 0x0000)
			
			C_LONGINT:C283($vl_copySize)
			If ($vl_size>=4)
				$vl_copySize:=4
			Else 
				$vl_copySize:=$vl_size
			End if 
			
			COPY BLOB:C558($vp_xmlBlobPtr->; $vx_blob; 0; 0; $vl_copySize)
			
			Case of 
				: (($vx_blob{0}=0x0000) & ($vx_blob{1}=0x0000) & ($vx_blob{2}=0x00FE) & ($vx_blob{3}=0x00FF))  //00 00 FE FF `UTF-32, big-endian
					$vl_bomSize:=4
					
				: (($vx_blob{0}=0x00FF) & ($vx_blob{1}=0x00FE) & ($vx_blob{2}=0x0000) & ($vx_blob{3}=0x0000))  //FF FE 00 00 `UTF-32, little-endian
					$vl_bomSize:=4
					
				: (($vx_blob{0}=0x00FE) & ($vx_blob{1}=0x00FF))  //FE FF `UTF-16, big-endian
					$vl_bomSize:=2
					
				: (($vx_blob{0}=0x00FF) & ($vx_blob{1}=0x00FE))  //FF FE `UTF-16, little-endian
					$vl_bomSize:=2
					
				: (($vx_blob{0}=0x00EF) & ($vx_blob{1}=0x00BB) & ($vx_blob{2}=0x00BF))  //EF BB BF `UTF-8
					$vl_bomSize:=3
					
			End case 
			
		End if 
		
	End if 
	
End if 
$0:=$vl_bomSize

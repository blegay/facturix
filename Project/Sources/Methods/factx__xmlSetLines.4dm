//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : factx__xmlSetLines
//@scope : private
//@attributes :
//@deprecated : no
//@description : This method/function returns
//@parameter[0-OUT-paramName-TEXT] : ParamDescription
//@parameter[1-IN-paramName-OBJECT] : ParamDescription
//@parameter[2-IN-paramName-POINTER] : ParamDescription (not modified)
//@parameter[3-INOUT-paramName-POINTER] : ParamDescription (modified)
//@parameter[4-OUT-paramName-POINTER] : ParamDescription (modified)
//@parameter[5-IN-paramName-LONGINT] : ParamDescription (optional, default value : 1)
//@notes :
//@example : factx__xmlSetLines
//@see :
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
//@history :
//  CREATION : Bruno LEGAY (BLE) - 28/08/2022, 11:29:42 - 1.00.00
//@xdoc-end
//================================================================================

C_TEXT:C284($1; $vt_domRefTransaction)
C_COLLECTION:C1488($2; $c_lines)

$vt_domRefTransaction:=$1
$c_lines:=$2

C_OBJECT:C1216($vo_line)
For each ($vo_line; $c_lines)
	
	C_TEXT:C284($vt_domRefTradeLineItem)
	$vt_domRefTradeLineItem:=DOM Append XML child node:C1080($vt_domRefTransaction; XML ELEMENT:K45:20; "ram:IncludedSupplyChainTradeLineItem")
	
	C_TEXT:C284($vt_domRefTmp)
	$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefTradeLineItem; XML ELEMENT:K45:20; "ram:AssociatedDocumentLineDocument")
	factx__xmlAddRealChildElement($vt_domRefTmp; "ram:LineID"; $vo_line.lineNo)
	
	
	C_TEXT:C284($vt_domRefTmp)
	$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefTradeLineItem; XML ELEMENT:K45:20; "ram:SpecifiedTradeProduct")
	factx__xmlAddTextChildElement($vt_domRefTmp; "ram:Name"; $vo_line.name)
	
	
	
	$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefTradeLineItem; XML ELEMENT:K45:20; "ram:SpecifiedLineTradeAgreement")
	$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefTmp; XML ELEMENT:K45:20; "ram:NetPriceProductTradePrice")
	factx__xmlAddRealChildElement($vt_domRefTmp; "ram:ChargeAmount"; $vo_line.netPrice)
	
	$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefTradeLineItem; XML ELEMENT:K45:20; "ram:SpecifiedLineTradeDelivery")
	$vt_domRefTmp:=factx__xmlAddRealChildElement($vt_domRefTmp; "ram:BilledQuantity"; $vo_line.quantity)
	DOM SET XML ATTRIBUTE:C866($vt_domRefTmp; "unitCode"; $vo_line.unit)
	
	// LTR=Litre (1 dm3)
	// MTQ=Mètre cube
	// KGM=Kilogramme
	// MTR=Mètre
	// C62 = Unité
	// TNE = Tonne
	
	
	C_TEXT:C284($vt_domRefTradeSettlement)
	$vt_domRefTradeSettlement:=DOM Append XML child node:C1080($vt_domRefTradeLineItem; XML ELEMENT:K45:20; "ram:SpecifiedLineTradeSettlement")
	
	C_TEXT:C284($vt_domRefApplicableTradeTax)
	$vt_domRefApplicableTradeTax:=DOM Append XML child node:C1080($vt_domRefTradeSettlement; XML ELEMENT:K45:20; "ram:ApplicableTradeTax")
	
	factx__xmlAddTextChildElement($vt_domRefApplicableTradeTax; "ram:TypeCode"; "VAT")
	factx__xmlAddTextChildElement($vt_domRefApplicableTradeTax; "ram:CategoryCode"; $vo_line.vatCategory)
	
	// S = Taux de TVA standard
	// Z = Taux de TVA égal à 0 (non applicable en France)
	// E = Exempté de TVA
	// AE = Autoliquidation de TVA
	// K = Autoliquidation pour cause de livraison intracommunautaire
	// G = Exempté de TVA pour Export hors UE
	// O = Hors du périmètre d'application de la TVA
	// L = Iles Canaries
	// M = Ceuta et Mellila
	
	If ($vo_line.vatRate#Null:C1517)
		factx__xmlAddRealChildElement($vt_domRefApplicableTradeTax; "ram:RateApplicablePercent"; $vo_line.vatRate)
	End if 
	
	$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefTradeSettlement; XML ELEMENT:K45:20; "ram:SpecifiedTradeSettlementLineMonetarySummation")
	factx__xmlAddRealChildElement($vt_domRefTmp; "ram:LineTotalAmount"; $vo_line.lineTotalAmount)
	
End for each 


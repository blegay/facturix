//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : factx_objectToFacturx
//@scope : private
//@attributes :
//@deprecated : no
//@description : This function converts a invoice data object into a factur-x xml
//@parameter[0-OUT-ok-BOOLEAN] : TRUE if OK, FALSE otherwise
//@parameter[1-IN-invoiceData-OBJECT] : data object
//@parameter[2-OUT-xmlPtr-POINTER] : xml blob or text data (modified)
//@parameter[3-IN-withComments-BOOLEAN] : if true include a comment (optional, default True)
//@parameter[4-IN-indent-BOOLEAN] : if true, the xml will be indented (optional, default True)
//@notes :
//@example : factx_objectToFacturx
//@see :
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
//@history :
//  CREATION : Bruno LEGAY (BLE) - 28/08/2022, 14:46:11 - 1.00.00
//@xdoc-end
//================================================================================

C_BOOLEAN:C305($0; $vb_ok)
C_OBJECT:C1216($1; $vo_data)
C_POINTER:C301($2; $vp_xmlPtr)
C_BOOLEAN:C305($3; $vb_withComments)
C_BOOLEAN:C305($4; $vb_indent)

$vb_ok:=False:C215

ASSERT:C1129(Count parameters:C259>1; "requires 2 parameters")

$vo_data:=$1
$vp_xmlPtr:=$2
Case of 
	: (Count parameters:C259>3)
		$vb_withComments:=$3
		$vb_indent:=$4
		
	: (Count parameters:C259>2)
		$vb_withComments:=$3
		$vb_indent:=True:C214
		
	Else 
		$vb_withComments:=True:C214
		$vb_indent:=True:C214
End case 

C_TEXT:C284($vt_templatePath)  //;$vt_schemaPath)
$vt_templatePath:=Get 4D folder:C485(Current resources folder:K5:16)+"templates"+Folder separator:K24:12+"facture-x-template.xml"
//$vt_schemaPath:=Get 4D folder(Current resources folder)+\
"xsd"+Folder separator+\
"Factur-X"+Folder separator+\
"version_1.0.06"+Folder separator+\
"2. Factur-X_1.0.06_BASIC_XSD"+Folder separator+\
"FACTUR-X_BASIC.xsd"

C_TEXT:C284($vt_domRootRef)
$vt_domRootRef:=DOM Parse XML source:C719($vt_templatePath)
If (ok=1)
	
	C_TEXT:C284($vt_charset)
	C_BOOLEAN:C305($vb_standalone)
	$vt_charset:="UTF-8"  // (default)
	$vb_standalone:=True:C214
	DOM SET XML DECLARATION:C859($vt_domRootRef; $vt_charset; $vb_standalone)
	
	XML SET OPTIONS:C1090($vt_domRootRef; XML indentation:K45:34; Choose:C955($vb_indent; XML with indentation:K45:35; XML no indentation:K45:36))  // (default)
	
	XML SET OPTIONS:C1090($vt_domRootRef; XML binary encoding:K45:37; XML base64:K45:38)  // (default)
	XML SET OPTIONS:C1090($vt_domRootRef; XML date encoding:K45:24; XML ISO:K45:25)  // (default)
	XML SET OPTIONS:C1090($vt_domRootRef; XML time encoding:K45:30; XML datetime local absolute:K45:31)  // (default)
	XML SET OPTIONS:C1090($vt_domRootRef; XML picture encoding:K45:40; XML convert to PNG:K45:41)  // (default)
	XML SET OPTIONS:C1090($vt_domRootRef; XML String encoding:K45:21; XML with escaping:K45:22)  // (default)
	
	If ($vb_withComments)  // not a good idea wif we want to do testcases, otherwise it can help (it is not mandatory nor standard)
		C_OBJECT:C1216($vo_systemInfos)
		$vo_systemInfos:=Get system info:C1571
		
		C_TEXT:C284($vt_domRefTmp)
		$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRootRef; XML comment:K45:8; " \""+$vo_data.profile+"\" factur-x generated on "+Timestamp:C1445+"+ with 4D v"+env_versionStr+" ("+$vo_systemInfos.osVersion+" / "+$vo_systemInfos.processor+") by facturixClient v"+factx_componentVersionGet+" (written by Bruno LEGAY - A&C Consulting)")
	End if 
	
	If (True:C214)
		// "rsm:ExchangedDocumentContext"
		//     <rsm:ExchangedDocumentContext>
		//         <ram:GuidelineSpecifiedDocumentContextParameter>
		//             <ram:ID>urn:cen.eu:en16931:2017#compliant#urn:factur-x.eu:1p0:basic</ram:ID>
		//         </ram:GuidelineSpecifiedDocumentContextParameter>
		//     </rsm:ExchangedDocumentContext>
		
		C_TEXT:C284($vt_profilValue)
		Case of 
			: ($vo_data.profile="MINIMUM")
				$vt_profilValue:="urn:factur-x.eu:1p0:minimum"
				
			: ($vo_data.profile="BASIC-WL")
				$vt_profilValue:="urn:factur-x.eu:1p0:basicwl"
				
			: ($vo_data.profile="BASIC")
				$vt_profilValue:="urn:cen.eu:en16931:2017#compliant#urn:factur-x.eu:1p0:basic"
				
			: ($vo_data.profile="EN16931")
				$vt_profilValue:="urn:cen.eu:en16931:2017"
				
			: ($vo_data.profile="EXTENDED")
				$vt_profilValue:="urn:cen.eu:en16931:2017#conformant#urn:factur-x.eu:1p0:extended"
				
			Else 
				ASSERT:C1129(False:C215; "undefined property \"profile\"")
		End case 
		
		C_TEXT:C284($vt_domRefTmp)
		$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRootRef; XML ELEMENT:K45:20; "rsm:ExchangedDocumentContext")
		$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefTmp; XML ELEMENT:K45:20; "ram:GuidelineSpecifiedDocumentContextParameter")  // facturx-BT-24-00
		factx__xmlAddTextChildElement($vt_domRefTmp; "ram:ID"; $vt_profilValue)  // facturx-BT-24
		
		// "urn:factur-x.eu:1p0:minimum"
		// "urn:factur-x.eu:1p0:basicwl"
		// "urn:cen.eu:en16931:2017#compliant#urn:factur- x.eu:1p0:basic"
		// "urn:cen.eu:en16931:2017"
		// "urn:cen.eu:en16931:2017#conformant#urn:factur- x.eu:1p0:extended"
		
	End if 
	
	If (True:C214)  // "rsm:ExchangedDocument"
		C_TEXT:C284($vt_domRefExchngdDoc)
		$vt_domRefExchngdDoc:=DOM Append XML child node:C1080($vt_domRootRef; XML ELEMENT:K45:20; "rsm:ExchangedDocument")
		
		factx__xmlAddTextChildElement($vt_domRefExchngdDoc; "ram:ID"; $vo_data.exchangedDocument.id)  // facturx-BT-1
		
		factx__xmlAddTextChildElement($vt_domRefExchngdDoc; "ram:TypeCode"; $vo_data.exchangedDocument.typeCode)  // facturx-BT-3
		
		$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefExchngdDoc; XML ELEMENT:K45:20; "ram:IssueDateTime")  // facturx-BT-2-00
		factx__xmlAddDateChildElement($vt_domRefTmp; $vo_data.exchangedDocument.issueDateTime)  // facturx-BT-2
		
		C_OBJECT:C1216($vo_note)
		C_TEXT:C284($vt_domRefIncludedNote)
		For each ($vo_note; $vo_data.exchangedDocument.notes)
			$vt_domRefIncludedNote:=DOM Append XML child node:C1080($vt_domRefExchngdDoc; XML ELEMENT:K45:20; "ram:IncludedNote")  // facturx-BG-1
			
			factx__xmlAddTextChildElement($vt_domRefIncludedNote; "ram:Content"; $vo_note.content)  // facturx-BT-22
			
			If ($vo_note.subjectCode#Null:C1517)
				factx__xmlAddTextChildElement($vt_domRefIncludedNote; "ram:SubjectCode"; $vo_note.subjectCode)  // facturx-BT-21
				// AAI : Information générale
				// SUR : Remarques fournisseur
				// REG : Information réglementaire
				// ABL : Information légale
				// TXD : Information fiscale
				// CUS : Information douanière
			End if 
		End for each 
		
	End if 
	
	
	C_TEXT:C284($vt_domRefTransaction; $vt_domRefTradeAgreement; $vt_domRefDelivery; $vt_domRefSettlement)
	$vt_domRefTransaction:=DOM Append XML child node:C1080($vt_domRootRef; XML ELEMENT:K45:20; "rsm:SupplyChainTradeTransaction")
	
	If ($vo_data.lines.length>0)  // "ram:IncludedSupplyChainTradeLineItem"
		factx__xmlSetLines($vt_domRefTransaction; $vo_data.lines)
	End if 
	
	$vt_domRefTradeAgreement:=DOM Append XML child node:C1080($vt_domRefTransaction; XML ELEMENT:K45:20; "ram:ApplicableHeaderTradeAgreement")
	$vt_domRefDelivery:=DOM Append XML child node:C1080($vt_domRefTransaction; XML ELEMENT:K45:20; "ram:ApplicableHeaderTradeDelivery")
	$vt_domRefSettlement:=DOM Append XML child node:C1080($vt_domRefTransaction; XML ELEMENT:K45:20; "ram:ApplicableHeaderTradeSettlement")
	
	
	If (True:C214)  // "ram:ApplicableHeaderTradeAgreement"
		
		//$vt_domRefTmp:=DOM Append XML child node($vt_domRefTradeAgreement;XML ELEMENT;"ram:BuyerReference")
		//DOM SET XML ELEMENT VALUE($vt_domRefTmp;$vo_data.tradeAgreement.buyerReference)
		
		C_TEXT:C284($vt_domRefSeller)
		$vt_domRefSeller:=DOM Append XML child node:C1080($vt_domRefTradeAgreement; XML ELEMENT:K45:20; "ram:SellerTradeParty")
		factx__xmlSetParty($vt_domRefSeller; $vo_data.seller)
		
		C_TEXT:C284($vt_domRefBuyer)
		$vt_domRefBuyer:=DOM Append XML child node:C1080($vt_domRefTradeAgreement; XML ELEMENT:K45:20; "ram:BuyerTradeParty")
		factx__xmlSetParty($vt_domRefBuyer; $vo_data.buyer)
		
		If ($vo_data.tradeAgreement.orderReference#Null:C1517)
			$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefTradeAgreement; XML ELEMENT:K45:20; "ram:BuyerOrderReferencedDocument")  // facturx-BT-13-00
			factx__xmlAddTextChildElement($vt_domRefTmp; "ram:IssuerAssignedID"; $vo_data.tradeAgreement.orderReference)  // facturx-BT-13
		End if 
		
		If ($vo_data.tradeAgreement.contractReference#Null:C1517)
			$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefTradeAgreement; XML ELEMENT:K45:20; "ram:ContractReferencedDocument")  // facturx-BT-12-00
			factx__xmlAddTextChildElement($vt_domRefTmp; "ram:IssuerAssignedID"; $vo_data.tradeAgreement.contractReference)  // facturx-BT-12
		End if 
		
	End if 
	
	If (True:C214)  // "ram:ApplicableHeaderTradeDelivery"
		
		$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefDelivery; XML ELEMENT:K45:20; "ram:ActualDeliverySupplyChainEvent")  // facturx-BT-72-00
		$vt_domRefTmp:=DOM Append XML child node:C1080($vt_domRefTmp; XML ELEMENT:K45:20; "ram:OccurrenceDateTime")  // facturx-BT-72-01
		factx__xmlAddDateChildElement($vt_domRefTmp; $vo_data.tradeDelivery.actualDelivery)
		
		//$vt_domRefTmp:=DOM Append XML child node($vt_domRefTmp;XML ELEMENT;"udt:DateTimeString")
		//DOM SET XML ATTRIBUTE($vt_domRefTmp;"format";"102")
		
		//DOM SET XML ELEMENT VALUE($vt_domRefTmp;\
						String(Year of($vo_data.tradeDelivery.actualDelivery);"0000")+\
						String(Month of($vo_data.tradeDelivery.actualDelivery);"00")+\
						String(Day of($vo_data.tradeDelivery.actualDelivery);"00"))
	End if 
	
	
	If (True:C214)  // "ram:ApplicableHeaderTradeSettlement"
		
		//         <ram:ApplicableHeaderTradeSettlement>
		//             <ram:SpecifiedTradeSettlementHeaderMonetarySummation>
		//                 <ram:LineTotalAmount>198</ram:LineTotalAmount>
		//                 <ram:ChargeTotalAmount>0</ram:ChargeTotalAmount>
		//                 <ram:AllowanceTotalAmount>0</ram:AllowanceTotalAmount>
		//                 <ram:TaxBasisTotalAmount>198</ram:TaxBasisTotalAmount>
		//                 <ram:taxTotalAmount currencyID="EUR">37.62</ram:taxTotalAmount>
		//                 <ram:GrandTotalAmount>235.62</ram:GrandTotalAmount>
		//                 <ram:DuePayableAmount>235.62</ram:DuePayableAmount>
		//             </ram:SpecifiedTradeSettlementHeaderMonetarySummation>
		//         </ram:ApplicableHeaderTradeSettlement>
		
		factx__xmlAddTextChildElement($vt_domRefSettlement; "ram:InvoiceCurrencyCode"; $vo_data.settlement.currency)  // facturx-BT-5
		
		If (OB Is defined:C1231($vo_data.settlement; "PaymentMeans"))
			C_TEXT:C284($vt_domRefSpecifiedTradeSettleme)  //facturx-BG-16
			$vt_domRefSpecifiedTradeSettleme:=DOM Append XML child node:C1080($vt_domRefSettlement; XML ELEMENT:K45:20; "ram:SpecifiedTradeSettlementPaymentMeans")
			
			factx__xmlAddTextChildElement($vt_domRefSpecifiedTradeSettleme; "ram:TypeCode"; $vo_data.settlement.PaymentMeans.typeCode)
		End if 
		
		C_OBJECT:C1216($vo_applicableTradeTax)
		For each ($vo_applicableTradeTax; $vo_data.settlement.applicableTradeTax)
			C_TEXT:C284($vt_domRefApplicableTradeTax)
			$vt_domRefApplicableTradeTax:=DOM Append XML child node:C1080($vt_domRefSettlement; XML ELEMENT:K45:20; "ram:ApplicableTradeTax")  // facturx-BG-23
			
			factx__xmlAddRealChildElement($vt_domRefApplicableTradeTax; "ram:CalculatedAmount"; $vo_applicableTradeTax.calulatedAmount)  // facturx-BT-117
			factx__xmlAddTextChildElement($vt_domRefApplicableTradeTax; "ram:TypeCode"; "VAT")  // facturx-BT-118-0
			factx__xmlAddRealChildElement($vt_domRefApplicableTradeTax; "ram:BasisAmount"; $vo_applicableTradeTax.basisAmount)  // facturx-BT-116
			factx__xmlAddTextChildElement($vt_domRefApplicableTradeTax; "ram:CategoryCode"; $vo_applicableTradeTax.categoryCode)  // facturx-BT-118
			If ($vo_applicableTradeTax.rateApplicablePercent#Null:C1517)
				factx__xmlAddRealChildElement($vt_domRefApplicableTradeTax; "ram:RateApplicablePercent"; $vo_applicableTradeTax.rateApplicablePercent)  // facturx-BT-103
			End if 
			
		End for each 
		
		
		If ($vo_data.settlement.dueDate#Null:C1517)
			C_TEXT:C284($vt_domRefSpecifiedTrdPmtTrms; $vt_domRefDueDate)
			$vt_domRefSpecifiedTrdPmtTrms:=DOM Append XML child node:C1080($vt_domRefSettlement; XML ELEMENT:K45:20; "ram:SpecifiedTradePaymentTerms")  // facturx-BT-20
			$vt_domRefDueDate:=DOM Append XML child node:C1080($vt_domRefSpecifiedTrdPmtTrms; XML ELEMENT:K45:20; "ram:DueDateDateTime")  // facturx-BT-9-00
			factx__xmlAddDateChildElement($vt_domRefDueDate; $vo_data.settlement.dueDate)
		End if 
		
		
		C_TEXT:C284($vt_domRefSummation)
		$vt_domRefSummation:=DOM Append XML child node:C1080($vt_domRefSettlement; XML ELEMENT:K45:20; "ram:SpecifiedTradeSettlementHeaderMonetarySummation")  // facturx-BG-22
		
		factx__xmlAddRealChildElement($vt_domRefSummation; "ram:LineTotalAmount"; $vo_data.settlement.lineTotalAmount)  // facturx-BT-106
		
		If ($vo_data.settlement.chargeTotalAmount#Null:C1517)
			factx__xmlAddRealChildElement($vt_domRefSummation; "ram:ChargeTotalAmount"; $vo_data.settlement.chargeTotalAmount)  //  facturx-BT-108
		End if 
		
		If ($vo_data.settlement.allowanceTotalAmount#Null:C1517)
			factx__xmlAddRealChildElement($vt_domRefSummation; "ram:AllowanceTotalAmount"; $vo_data.settlement.allowanceTotalAmount)  //  facturx-BT-107
		End if 
		
		factx__xmlAddRealChildElement($vt_domRefSummation; "ram:TaxBasisTotalAmount"; $vo_data.settlement.taxBasisTotalAmount)  //  facturx-BT-109
		
		$vt_domRefTmp:=factx__xmlAddRealChildElement($vt_domRefSummation; "ram:TaxTotalAmount"; $vo_data.settlement.taxTotalAmount)  // facturx-BT-111
		DOM SET XML ATTRIBUTE:C866($vt_domRefTmp; "currencyID"; $vo_data.settlement.currency)
		
		factx__xmlAddRealChildElement($vt_domRefSummation; "ram:GrandTotalAmount"; $vo_data.settlement.grandTotalAmount)  //  facturx-BT-112
		
		If ($vo_data.settlement.totalPrepaidAmount#Null:C1517)
			factx__xmlAddRealChildElement($vt_domRefSummation; "ram:TotalPrepaidAmount"; $vo_data.settlement.totalPrepaidAmount)  //  facturx-BT-113
		End if 
		
		factx__xmlAddRealChildElement($vt_domRefSummation; "ram:DuePayableAmount"; $vo_data.settlement.duePayableAmount)  // facturx-BT-115
	End if 
	
	DOM EXPORT TO VAR:C863($vt_domRootRef; $vp_xmlPtr->)
	$vb_ok:=(ok=1)
	
	// remove the bom from the xml
	xml_blobEraseBom($vp_xmlPtr)
	
	DOM CLOSE XML:C722($vt_domRootRef)
End if 

$0:=$vb_ok
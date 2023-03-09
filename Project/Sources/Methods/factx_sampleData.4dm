//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
//================================================================================
//@xdoc-start : en
//@name : factx_sampleData
//@scope : private 
//@deprecated : no
//@description : This function returns a sample facturx data object (for reference/sample implementation and test cases)
//@parameter[0-OUT-data-OBJECT] : sample data object 
//@parameter[1-IN-testcase-TEXT] : testcase (optional, default is "test1_basic")
//@notes : 
//@example : 
// C_TEXT($vt_xml)
// C_OBJECT($vo_data)
// $vo_data:=factx_sampleData("test1_basic")
// // convert object to factur-x xml
// If (factx_objectToFacturx($vo_data; ->$vt_xml))
//   SET TEXT TO PASTEBOARD($vt_xml)
// End if 
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2023
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 31/01/2023, 07:19:32 - 0.50.00
//@xdoc-end
//================================================================================

C_OBJECT:C1216($0; $vo_data)
C_TEXT:C284($1; $vt_testcase)

$vo_data:=New object:C1471
If (Count parameters:C259>0)
	$vt_testcase:=$1
Else 
	$vt_testcase:="test1_basic"
End if 

Case of 
	: ($vt_testcase="test1_basic")
		
		$vo_data.profile:="BASIC"  // ("MINIMUM", "BASIC-WL", "BASIC", "EN16931" or "EXTENDED")
		
		// "rsm:ExchangedDocument"
		$vo_data.exchangedDocument:=New object:C1471
		$vo_data.exchangedDocument.id:="471102"  // facturx-BT-1
		$vo_data.exchangedDocument.typeCode:="380"  // facturx-BT-3
		// 380 : Facture commerciale
		// 381 : Avoir (note de crédit)
		// 384 : Facture rectificative
		// 386 : Facture d'acompte
		
		$vo_data.exchangedDocument.issueDateTime:=!2022-03-05!  // facturx-BT-2 (date d'émission de la facture)
		
		$vo_data.lines:=New collection:C1472
		$vo_data.lines.push(New object:C1471("lineNo"; 1; \
			"name"; "GTIN: 4012345001235\rUnsere Art.-Nr.: TB100A4\rTrennblätter A4"; \
			"netPrice"; 9.9; \
			"quantity"; 20; \
			"unit"; "C62"; \
			"vatCategory"; "S"; \
			"vatRate"; 19; \
			"lineTotalAmount"; 198))
		
		$vo_data.seller:=New object:C1471
		$vo_data.seller.name:="Lieferant GmbH"  // facturx-BT-27
		$vo_data.seller.siret:="12345678900014"  // facturx-BT-30-1
		$vo_data.seller.noTVA:="FR23123456789"  // facturx-BT-31
		$vo_data.seller.postcode:="80333"  // facturx-BT-38
		$vo_data.seller.lineOne:="Lieferantenstraße 20"  // facturx-BT-35
		$vo_data.seller.cityName:="München"  // facturx-BT-37
		$vo_data.seller.countryID:="DE"  //facturx-BT-40
		
		$vo_data.buyer:=New object:C1471
		$vo_data.buyer.name:="Kunden AG Mitte"  // facturx-BT-44
		$vo_data.buyer.siret:="98765432100034"  // facturx-BT-47
		$vo_data.buyer.postcode:="69876"  // facturx-BT-53
		$vo_data.buyer.lineOne:="Hans Muster"  // facturx-BT-50
		$vo_data.buyer.lineTwo:="Kundenstraße 15"  // facturx-BT-51
		$vo_data.buyer.cityName:="Frankfurt"  // facturx-BT-52
		$vo_data.buyer.countryID:="DE"  // facturx-BT-55
		
		// facturx-BT-22 / facturx-BT-21
		$vo_data.exchangedDocument.notes:=New collection:C1472(\
			New object:C1471("content"; "Rechnung gemäß Bestellung vom 01.03.2020."); \
			New object:C1471("content"; "Lieferant GmbH\rLieferantenstraße 20\r80333 München\rDeutschland\rGeschäftsführer: Hans Muster\rHandelsregisternummer: H A 123"); \
			New object:C1471("content"; "Unsere GLN: 4000001123452\nIhre GLN: 4000001987658\nIhre Kundennummer: GE2020211\n\n\nZahlbar innerhalb 30 Tagen netto bis 04.04.2020, 3% Skonto innerhalb 10 Tagen bis 15.03.2020."))
		
		// "ram:ApplicableHeaderTradeAgreement"
		//$vo_data.tradeAgreement.actualDelivery:=!2022-03-05!
		
		// "ram:ApplicableHeaderTradeDelivery"
		$vo_data.tradeDelivery:=New object:C1471
		$vo_data.tradeDelivery.actualDelivery:=!2022-03-05!
		
		
		// "ram:ApplicableHeaderTradeSettlement"
		$vo_data.settlement:=New object:C1471
		$vo_data.settlement.currency:="EUR"  // facturx-BT-5
		$vo_data.settlement.dueDate:=!2022-04-05!  // facturx-BT-9
		
		$vo_data.settlement.applicableTradeTax:=New collection:C1472(New object:C1471(\
			"calulatedAmount"; 37.62; \
			"basisAmount"; 198; \
			"categoryCode"; "S"; \
			"rateApplicablePercent"; 19))
		
		$vo_data.settlement.lineTotalAmount:=198  // facturx-BT-106
		$vo_data.settlement.chargeTotalAmount:=0  // facturx-BT-108
		$vo_data.settlement.allowanceTotalAmount:=0  // facturx-BT-107
		$vo_data.settlement.taxBasisTotalAmount:=$vo_data.settlement.lineTotalAmount  // facturx-BT-109
		$vo_data.settlement.taxTotalAmount:=37.62  // facturx-BT-111
		//$vo_data.settlement.taxTotalAmountCurrency:=$vo_data.settlement.currency
		$vo_data.settlement.grandTotalAmount:=$vo_data.settlement.lineTotalAmount+$vo_data.settlement.taxTotalAmount  // facturx-BT-112
		$vo_data.settlement.duePayableAmount:=$vo_data.settlement.grandTotalAmount  // facturx-BT-115
		
End case 

$0:=$vo_data
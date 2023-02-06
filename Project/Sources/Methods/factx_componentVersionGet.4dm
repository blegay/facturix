//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
//================================================================================
//@xdoc-start : en
//@name : factx_componentVersionGet
//@scope : private 
//@deprecated : no
//@description : This function returns the facturix component version (e.g. "1.00.00")
//@notes : 
// This component is voluntarily left in traditional 4D code style to be backward compatible with older versions of 4D (4D v17 upwards)
//@example : factx_componentVersionGet
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 11/01/2023, 23:08:48 - v1.00.00
//@xdoc-end
//================================================================================

C_TEXT:C284($0; $vt_version)

$vt_version:="1.00.00"

$0:=$vt_version


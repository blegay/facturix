# **Method :** factx_sampleData
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns a sample facturx data object (for reference/sample implementation and test cases)
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | data | OBJECT | sample data object | 
| $1 | IN | testcase | TEXT | testcase (optional, default is "test1_basic") | 

## **Notes :** 

## **Example :** 
```

       C_TEXT($vt_xml)
       C_OBJECT($vo_data)
       $vo_data:=factx_sampleData("test1_basic")
       // convert object to factur-x xml
       If (factx_objectToFacturx($vo_data; ->$vt_xml))
         SET TEXT TO PASTEBOARD($vt_xml)
       End if
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2023
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 31/01/2023, 07:19:32 - 0.50.00

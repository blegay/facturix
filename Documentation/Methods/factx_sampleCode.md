# **Method :** factx_sampleCode
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This is a sample code for generation factur-x xml
## **Parameters :** 
## **Notes :** 

## **Example :** 
```

      
        C_OBJECT($vo_data)
        $vo_data:=New object
      
        $vo_data.profile:="BASIC"  // ("MINIMUM", "BASIC-WL", "BASIC", "EN16931" or "EXTENDED")
        // ...
      
        // convert object to factur-x xml
        C_TEXT($vt_xml)
        If (factx_objectToFacturx($vo_data; ->$vt_xml))
      
        End if
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting 2023
## **History :** 

        CREATION : Bruno LEGAY (BLE) - 31/01/2023, 07:48:56 - 0.50.00

# **Method :** factx_objectToFacturx
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This function converts a invoice data object into a factur-x xml
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | ok | BOOLEAN | TRUE if OK, FALSE otherwise | 
| $1 | IN | invoiceData | OBJECT | data object | 
| $2 | OUT | xmlPtr | POINTER | xml blob or text data (modified) | 
| $3 | IN | withComments | BOOLEAN | if true include a comment (optional, default True) | 
| $4 | IN | indent | BOOLEAN | if true, the xml will be indented (optional, default True) | 

## **Notes :** 

## **Example :** 
```
factx_objectToFacturx
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
## **History :** 

        CREATION : Bruno LEGAY (BLE) - 28/08/2022, 14:46:11 - 1.00.00

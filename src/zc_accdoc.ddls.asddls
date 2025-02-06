@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view ZI_ACCDOC'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZC_ACCDOC
  provider contract transactional_query
  as projection on ZI_ACCDOC
{
//      @EndUserText.label: 'Serial No'
//
//      @UI.facet: [{   id : 'D1',
//                  purpose: #STANDARD,
//                  type: #IDENTIFICATION_REFERENCE,
//                  label: 'SO Data',
//                  position: 10
//              } ]
//
//
//      @UI: {
//                identification: [{ position: 10, label : 'Serial No' } ]}
////                lineItem: [{ position: 10 ,
////                              type: #FOR_ACTION,
////                              label: 'Post Journal',
////                              dataAction: 'PostDoc',
////                              invocationGrouping: #CHANGE_SET }] }
  key Id,
      @EndUserText.label: 'Doc Id'
//      @UI.lineItem: [{ position: 20 , importance: #HIGH},
//     { type: #FOR_ACTION, label: 'Posting', dataAction: 'Jrposting', invocationGrouping: #CHANGE_SET   }]
      Docid,

      @EndUserText.label: 'Company Code'
//      @UI: { lineItem: [{position: 30 }], identification: [{position: 30 }] 
//      ,selectionField: [{ position: 30 }]
//      }
      Bukrs,

      @EndUserText.label: 'Year'
//      @UI: { lineItem: [{position: 40 }], identification: [{position: 40 }]
//      ,selectionField: [{ position: 40 }]
//       }
      Gjahr,

      @EndUserText.label: 'Doc Type'
//      @UI: { lineItem: [{position: 50 }], identification: [{position: 50 }] 
//      ,selectionField: [{ position: 50 }]}
      Blart,

      @EndUserText.label: 'Doc Date'
//      @UI: { lineItem: [{position: 60 }], identification: [{position: 60 }] }
      Bldat,

      @EndUserText.label: 'Posting Date'
//      @UI: { lineItem: [{position: 70 }], identification: [{position: 70 }] 
//      ,selectionField: [{ position: 70 }]}
      Budat,

      @EndUserText.label: 'Currcy'
//      @UI: { lineItem: [{position: 80 }], identification: [{position: 80 }] }
      Waers,

      @EndUserText.label: 'Bus Place'
//      @UI: { lineItem: [{position: 90 }], identification: [{position: 90 }]
//      ,selectionField: [{ position: 90 }] }
      Bupla,

      @EndUserText.label: 'Section Code'
//      @UI: { lineItem: [{position: 100 }], identification: [{position: 100 }] }
      Secco,

      @EndUserText.label: 'Reference'
//      @UI: { lineItem: [{position: 110 }], identification: [{position: 110 }] }
      Xblnr,

      @EndUserText.label: 'Header Text'
//      @UI: { lineItem: [{position: 120 }], identification: [{position: 120 }] }
      Bktxt,

      @EndUserText.label: 'GL Account'
//      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_GLAccountStdVH', element: 'GLAccount' } } ]
//      @UI: { lineItem: [{position: 130 }], identification: [{position: 130 }] 
//      ,selectionField: [{ position: 130 }]}
      Hkont,

      @EndUserText.label: 'Amount'
      @Semantics.amount.currencyCode : 'waers'
//      @UI: { lineItem: [{position: 140 }], identification: [{position: 140 }] }
      Dmbtr,

      //    @EndUserText.label: 'Credit Amount'
      //      @UI: { lineItem: [{position: 150 }], identification: [{position: 150 }] }
      //    Wrbtr,

      @EndUserText.label: 'Dr/Cr'
//      @UI: { lineItem: [{position: 160 }], identification: [{position: 160 }] }
      Shkzg,

      @EndUserText.label: 'Cost Center'
//      @UI: { lineItem: [{position: 170 }], identification: [{position: 170 }]
//      ,selectionField: [{ position: 170 }] }
      Kostl,

      @EndUserText.label: 'Profit Center'
//      @UI: { lineItem: [{position: 180 }], identification: [{position: 180 }] 
//      ,selectionField: [{ position: 180 }]}
      Prctr,

      @EndUserText.label: 'Tax Code'
//      @UI: { lineItem: [{position: 190 }], identification: [{position: 190 }] }
      Mwskz,

      @EndUserText.label: 'House Bank'
      
//      @UI: { lineItem: [{position: 200 }], identification: [{position: 200 }]
//      ,selectionField: [{ position: 200 }] }
      Bank,

      @EndUserText.label: 'House Bank ID'
//      @UI: { lineItem: [{position: 210 }], identification: [{position: 210 }] }
      Hbkid,
//      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Customer_VH', element: 'Customer' } } ]
      @EndUserText.label: 'Customer'
//      @UI: { lineItem: [{position: 220 }], identification: [{position: 220 }]
//      ,selectionField: [{ position: 220 }] }
      Kunnr,
//      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Supplier_VH', element: 'Supplier' } } ]
      @EndUserText.label: 'Vendor'
//      @UI: { lineItem: [{position: 230 }], identification: [{position: 230 }] 
//      ,selectionField: [{ position: 230 }]}
      Lifnr,

      @EndUserText.label: 'Sp GL Indc'
//      @UI: { lineItem: [{position: 240 }], identification: [{position: 240 }] }
      Umskz,

      @EndUserText.label: 'Acc Doc'
//      @UI: { lineItem: [{position: 250 }], identification: [{position: 250 }]
//      ,selectionField: [{ position: 250 }] }
      Belnr,

      @EndUserText.label: 'Item text'
//      @UI: { lineItem: [{position: 250 }], identification: [{position: 260 }] }
      sgtxt,

      @EndUserText.label: 'Assignment Ref'
//      @UI: { lineItem: [{position: 250 }], identification: [{position: 270 }] }
      ZUONR,
      
      @EndUserText.label: 'Payment Method'
//      @UI: { lineItem: [{position: 250 }], identification: [{position: 280 }] }
      zlsch,
      
      @EndUserText.label: 'UserName'
//      @UI: { lineItem: [{position: 250 }], identification: [{position: 280 }] }
      uname
      
} where Id is not initial

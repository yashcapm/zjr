@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_JR_V1 
provider contract transactional_query
as projection on zi_jr_v1
{
    key Id,
    Docid,
    Belnr,
    Bukrs,
    Gjahr,
    Blart,
    Bldat,
    Budat,
    Waers,
    Bupla,
    Secco,
    Xblnr,
    Bktxt,
    Hkont,
    @Semantics.amount.currencyCode : 'waers'
    Dmbtr,
    Shkzg,
    Kostl,
    Prctr,
    Mwskz,
    Bank,
    Hbkid,
    Kunnr,
    Lifnr,
    Umskz,
    Sgtxt,
    Zuonr,
    Zlsch,
    Uname
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'jr root view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_jr_v1 
as select from zfit_accdoc

{
    key id as Id,
    docid as Docid,
    belnr as Belnr,
    bukrs as Bukrs,
    gjahr as Gjahr,
    blart as Blart,
    bldat as Bldat,
    budat as Budat,
    waers as Waers,
    bupla as Bupla,
    secco as Secco,
    xblnr as Xblnr,
    bktxt as Bktxt,
    hkont as Hkont,
    @Semantics.amount.currencyCode : 'waers'
    dmbtr as Dmbtr,
    shkzg as Shkzg,
    kostl as Kostl,
    prctr as Prctr,
    mwskz as Mwskz,
    bank as Bank,
    hbkid as Hbkid,
    kunnr as Kunnr,
    lifnr as Lifnr,
    umskz as Umskz,
    sgtxt as Sgtxt,
    zuonr as Zuonr,
    zlsch as Zlsch,
    uname as Uname
    
}

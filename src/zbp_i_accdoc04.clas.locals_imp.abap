CLASS lhc_zi_accdoc DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_accdoc RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_accdoc RESULT result.

    METHODS jrposting FOR MODIFY
      IMPORTING keys FOR ACTION zi_accdoc~jrposting RESULT result.

ENDCLASS.

CLASS lhc_zi_accdoc IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD jrposting.
  READ ENTITIES OF ZI_ACCDOC IN LOCAL MODE
         ENTITY ZI_ACCDOC
          ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(data_read)
         FAILED failed.


         DATA: lt_doc_h        TYPE TABLE FOR ACTION IMPORT i_journalentrytp~post,
          lv_cid          TYPE abp_behv_cid,
          ls_doc_h        LIKE LINE OF lt_doc_h,
          ls_glitem       LIKE LINE OF ls_doc_h-%param-_glitems,
          ls_glcurrency   LIKE LINE OF ls_glitem-_currencyamount,
          ls_aritem       LIKE LINE OF ls_doc_h-%param-_aritems, "customer
          ls_taxitems     LIKE LINE OF ls_doc_h-%param-_taxitems,
          ls_custcurrency LIKE LINE OF ls_aritem-_currencyamount,
          ls_apitem       LIKE LINE OF ls_doc_h-%param-_apitems, "vendor
          ls_vencurrency  LIKE LINE OF ls_apitem-_currencyamount,
          lv_docid(10)    TYPE c,
          lv_buzei        TYPE i.

    TYPES : BEGIN OF ty_msg,
              docid(10) TYPE c,
              belnr     TYPE belnr_d,
              msgty(1)  TYPE c,
              msg(200)  TYPE c,
            END OF ty_msg.
    DATA : it_msg    TYPE STANDARD TABLE OF ty_msg,
           wa_msg    TYPE ty_msg,
           lv_result TYPE string,
           lv_msg    TYPE c LENGTH 200.
    DATA : r_date TYPE RANGE OF datum,
           s_date LIKE LINE OF r_date,
           n      TYPE i.
  loop at  data_read ASSIGNING FIELD-SYMBOL(<fs_read>).
* GL
    lv_buzei = lv_buzei + 1.
    ls_glitem-glaccountlineitem = lv_buzei.         ls_glitem-%control-glaccountlineitem = if_abap_behv=>mk-on.
    ls_glitem-glaccount         = <fs_read>-Hkont   .ls_glitem-%control-glaccount = if_abap_behv=>mk-on.
    ls_glitem-costcenter        = ''           .ls_glitem-%control-costcenter = if_abap_behv=>mk-on.
    ls_glitem-profitcenter      = <fs_read>-Prctr   .ls_glitem-%control-profitcenter = if_abap_behv=>mk-on.
    ls_glitem-housebank = <fs_read>-Bank.              ls_glitem-%control-housebank = if_abap_behv=>mk-on.
    ls_glitem-housebankaccount = <fs_read>-Bank.   ls_glitem-%control-housebankaccount = if_abap_behv=>mk-on.
"    ls_glitem-businessplace = ''.ls_glitem-%control-businessplace = if_abap_behv=>mk-on.
    ls_glitem-assignmentreference = ''.ls_glitem-%control-assignmentreference = if_abap_behv=>mk-on.
    ls_glitem-documentitemtext = <fs_read>-sgtxt.ls_glitem-%control-documentitemtext = if_abap_behv=>mk-on.
*                ls_glitem-TaxCode = <fs_member>-mwskz.

*   DATA(TT) = <fs_read>-Dmbtr * -1.
    ls_glcurrency-journalentryitemamount = <fs_read>-Dmbtr * -1.
    ls_glcurrency-%control-journalentryitemamount = if_abap_behv=>mk-on.
    ls_glcurrency-currency = 'EUR'.             ls_glcurrency-%control-currency = if_abap_behv=>mk-on.
    ls_glcurrency-currencyrole = '00'.                      ls_glcurrency-%control-currencyrole = if_abap_behv=>mk-on.

    ls_glitem-%control-_currencyamount = if_abap_behv=>mk-on.
    ls_doc_h-%param-%control-_glitems = if_abap_behv=>mk-on.

    APPEND ls_glcurrency TO ls_glitem-_currencyamount.
    APPEND ls_glitem TO ls_doc_h-%param-_glitems.
* CUTOMER

    lv_buzei = lv_buzei + 1.
    ls_aritem-glaccountlineitem = lv_buzei. ls_aritem-%control-glaccountlineitem = if_abap_behv=>mk-on.
    ls_aritem-customer = <fs_read>-Kunnr. ls_aritem-%control-customer = if_abap_behv=>mk-on.
 "   ls_aritem-specialglcode     = ''.ls_aritem-%control-specialglcode = if_abap_behv=>mk-on.
 "   ls_aritem-businessplace = ''.ls_aritem-%control-businessplace = if_abap_behv=>mk-on.
    ls_aritem-assignmentreference = ''.ls_aritem-%control-assignmentreference = if_abap_behv=>mk-on.
    ls_aritem-documentitemtext = ''.ls_aritem-%control-documentitemtext = if_abap_behv=>mk-on.

    ls_custcurrency-journalentryitemamount = <fs_read>-Dmbtr.

    ls_custcurrency-%control-journalentryitemamount = if_abap_behv=>mk-on.
    ls_custcurrency-currency = 'EUR'.ls_custcurrency-%control-currency = if_abap_behv=>mk-on.
    ls_custcurrency-currencyrole = '00'.         ls_custcurrency-%control-currencyrole = if_abap_behv=>mk-on.

    ls_aritem-%control-_currencyamount = if_abap_behv=>mk-on.
    ls_doc_h-%param-%control-_aritems = if_abap_behv=>mk-on.

    APPEND ls_custcurrency TO ls_aritem-_currencyamount.
    APPEND ls_aritem TO ls_doc_h-%param-_aritems.

    CLEAR: ls_aritem, ls_apitem, ls_glitem, ls_glcurrency, ls_custcurrency, ls_vencurrency.

     n += 1.
    "purchase requisition
    DATA(cid) = 'My%CID_' && '_' && n.

    ls_doc_h-%cid = cid.
            ls_doc_h-%param-companycode = <fs_read>-Bukrs.
            ls_doc_h-%param-documentreferenceid = 'BKPFF'.
            ls_doc_h-%param-createdbyuser = sy-uname.
            ls_doc_h-%param-businesstransactiontype = 'RFPI'.
            ls_doc_h-%param-accountingdocumenttype = <fs_read>-Blart.
            ls_doc_h-%param-documentdate = sy-datum.
            ls_doc_h-%param-postingdate = sy-datum.
            ls_doc_h-%param-accountingdocumentheadertext = <fs_read>-sgtxt.
*            ls_doc_h-%param-TaxDeterminationDate = <fs_member>-budat.

            ls_doc_h-%param-%control-companycode = if_abap_behv=>mk-on.
            ls_doc_h-%param-%control-documentreferenceid = if_abap_behv=>mk-on.
            ls_doc_h-%param-%control-createdbyuser = if_abap_behv=>mk-on.
            ls_doc_h-%param-%control-businesstransactiontype = if_abap_behv=>mk-on.
            ls_doc_h-%param-%control-accountingdocumenttype = if_abap_behv=>mk-on.
            ls_doc_h-%param-%control-documentdate = if_abap_behv=>mk-on.
            ls_doc_h-%param-%control-postingdate = if_abap_behv=>mk-on.
            ls_doc_h-%param-%control-accountingdocumentheadertext = if_abap_behv=>mk-on.
            ls_doc_h-%param-%control-documentreferenceid = if_abap_behv=>mk-on.

            APPEND ls_doc_h TO lt_doc_h.

*

            IF lt_doc_h IS NOT INITIAL.

              MODIFY ENTITIES OF i_journalentrytp
                  ENTITY journalentry
                  EXECUTE post FROM lt_doc_h
                  FAILED FINAL(ls_failed_deep)
                  REPORTED FINAL(ls_reported_deep)
                  MAPPED FINAL(ls_mapped_deep).


              IF ls_failed_deep IS NOT INITIAL.
                LOOP AT ls_reported_deep-journalentry ASSIGNING FIELD-SYMBOL(<ls_reported_deep>).
                  lv_result = <ls_reported_deep>-%msg->if_message~get_text( ).
                  CLEAR : wa_msg.
*                  wa_msg-docid    = <fs_member>-docid.
                  wa_msg-msgty    = 'E'.
                  wa_msg-msg      = lv_result.
                  APPEND wa_msg TO it_msg.
                  CLEAR wa_msg.
                ENDLOOP.
              ELSE.
*                COMMIT ENTITIES BEGIN
*                RESPONSE OF i_journalentrytp
*                FAILED DATA(lt_commit_failed)
*                REPORTED DATA(lt_commit_reported).
*
*
*                IF lt_commit_reported IS NOT INITIAL.
*                  LOOP AT lt_commit_reported-journalentry ASSIGNING FIELD-SYMBOL(<ls_invoice>).
*                    IF <ls_invoice>-accountingdocument IS NOT INITIAL.
*                      "Success case
*                      CLEAR : wa_msg.
*                      wa_msg-belnr    = <ls_invoice>-accountingdocument.
*                      wa_msg-msgty    = 'S'.
*                      CONCATENATE  'Journal Posted Doc No. ' <ls_invoice>-accountingdocument INTO wa_msg-msg SEPARATED BY ''.
*                      APPEND wa_msg TO it_msg.
*                      CLEAR wa_msg.
*
**                      UPDATE zfit_accdoc SET belnr = @<ls_invoice>-accountingdocument,
**                                              gjahr = @<ls_invoice>-fiscalyear,
**                                              bukrs = @<ls_invoice>-companycode
**                                        WHERE docid = @<fs_member>-docid.
*                      COMMIT WORK.
*                    ELSE.
*
*                      "Error handling
*
**                      CLEAR : wa_msg.
**                      wa_msg-docid    = <fs_member>-docid.
**                      wa_msg-msgty    = 'E'.
**                      CONCATENATE 'Error hile Journal Entry' <fs_member>-docid
**                      INTO wa_msg-msg SEPARATED BY ''.
**                      APPEND wa_msg TO it_msg.
**                      CLEAR wa_msg.
*                    ENDIF.
*
*
*
*                  ENDLOOP.
*                ENDIF.
*
*                IF lt_commit_failed IS NOT INITIAL.
*                  LOOP AT lt_commit_reported-journalentry ASSIGNING FIELD-SYMBOL(<ls_commit>).
*                    "Error handling
*
*                    CLEAR lv_result.
*                    lv_result = lv_result = <ls_commit>-%msg->if_message~get_text( ).
*
*                    CLEAR : wa_msg.
**                    wa_msg-docid    = <fs_member>-docid.
*                    wa_msg-msgty    = 'E'.
*                    wa_msg-msg      = lv_result.
*                    APPEND wa_msg TO it_msg.
*                    CLEAR wa_msg.
*
*                  ENDLOOP.
*                ENDIF.
*
*                COMMIT ENTITIES END.
*              ENDIF.
*
*
*              CLEAR: lt_doc_h[], ls_doc_h.


            ENDIF.
           endif.
ENDLOOP.



  ENDMETHOD.

ENDCLASS.

CLASS lsc_zi_accdoc DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zi_accdoc IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

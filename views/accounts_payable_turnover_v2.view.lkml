# The name of this view in Looker is "Accounts Payable Turnover"
view: accounts_payable_turnover_v2 {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `@{GCP_PROJECT}.@{REPORTING_DATASET}.AccountsPayableTurnover`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Account Number of Vendor or Creditor Lifnr" in Explore.

  dimension: account_number_of_vendor_or_creditor_lifnr {
    type: string
    sql: ${TABLE}.AccountNumberOfVendorOrCreditor_LIFNR ;;
  }

  dimension: accounting_document_number_belnr {
    type: string
    sql: ${TABLE}.AccountingDocumentNumber_BELNR ;;
  }

  dimension: accounting_documenttype_blart {
    type: string
    sql: ${TABLE}.AccountingDocumenttype_BLART ;;
  }

  dimension: accounts_payable_turnover_in_source_currency {
    type: number
    sql: ${TABLE}.AccountsPayableTurnoverInSourceCurrency;;
  }

  dimension: accounts_payable_turnover_in_target_currency {
    type: number
    sql: (${TABLE}.AccountsPayableTurnoverInTargetCurrency * -1);;
  }

  dimension: doc_fiscal_period_cast {
    type: date
    sql: concat(LEFT(${doc_fisc_period},4),"-",RIGHT(${doc_fisc_period},2),"-01") ;;
  }

  dimension_group: doc_fiscal_period_group {
    type: time
    convert_tz: no
    timeframes: [month, year]
    sql: ${doc_fiscal_period_cast};;
    hidden: no
  }

  dimension: fiscal_period {
    type: string
    sql: concat(LEFT(${doc_fisc_period},4),"/",RIGHT(${doc_fisc_period},2)) ;;
    hidden: no
  }



  # measure: turnover_distinct {
  #   type: number
  #   sql: distinct(${accounts_payable_turnover_in_target_currency}) ;;
  #   #required_fields: [accounts_payable_turnover_in_target_currency]
  # }

  measure: turnover {
    type: average
    value_format: "0.0"
    sql: ${accounts_payable_turnover_in_target_currency} ;;
    sql_distinct_key: ${fiscal_period} ;;
    #sql_distinct_key: ${doc_fisc_period},${accounts_payable_turnover_in_target_currency},${company_text_butxt} ;;
    required_fields: [doc_fisc_period]
    hidden: no
  }


  dimension: amount_in_local_currency_dmbtr {
    type: number
    sql: ${TABLE}.AmountInLocalCurrency_DMBTR ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_amount_in_local_currency_dmbtr {
    type: sum
    sql: ${amount_in_local_currency_dmbtr} ;;
  }

  measure: average_amount_in_local_currency_dmbtr {
    type: average
    sql: ${amount_in_local_currency_dmbtr} ;;
  }

  dimension: amount_in_target_currency_dmbtr {
    type: number
    sql: ${TABLE}.AmountInTargetCurrency_DMBTR ;;
  }

  dimension: client_mandt {
    type: string
    sql: ${TABLE}.Client_MANDT ;;
  }

  dimension: closing_apin_source_currency {
    type: number
    sql: ${TABLE}.ClosingAPInSourceCurrency ;;
  }

  dimension: closing_apin_target_currency {
    type: number
    sql: ${TABLE}.ClosingAPInTargetCurrency ;;
  }

  dimension: company_code_bukrs {
    type: string
    sql: ${TABLE}.CompanyCode_BUKRS ;;
  }

  dimension: company_text_butxt {
    type: string
    sql: ${TABLE}.CompanyText_BUTXT ;;
  }

  dimension: currency_key_waers {
    type: string
    sql: ${TABLE}.CurrencyKey_WAERS ;;
  }

  dimension: doc_fisc_period {
    type: string
    sql: ${TABLE}.DocFiscPeriod ;;
  }

  dimension: name1 {
    type: string
    sql: ${TABLE}.NAME1 ;;
  }

  dimension: number_of_line_item_within_accounting_document_buzei {
    type: string
    sql: ${TABLE}.NumberOfLineItemWithinAccountingDocument_BUZEI ;;
  }

  dimension: opening_apin_source_currency {
    type: number
    sql: ${TABLE}.OpeningAPInSourceCurrency ;;
  }

  dimension: opening_apin_target_currency {
    type: number
    sql: ${TABLE}.OpeningAPInTargetCurrency ;;
  }

  dimension: period_apin_source_currency {
    type: number
    sql: ${TABLE}.PeriodAPInSourceCurrency ;;
  }

  dimension: period_apin_target_currency {
    type: number
    sql: ${TABLE}.PeriodAPInTargetCurrency ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: posting_date_in_the_document_budat {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.PostingDateInTheDocument_BUDAT ;;
  }

  dimension: target_currency_tcurr {
    type: string
    sql: ${TABLE}.TargetCurrency_TCURR ;;
  }

  dimension: total_purchases_in_source_currency {
    type: number
    sql: ${TABLE}.TotalPurchasesInSourceCurrency ;;
  }

  dimension: total_purchases_in_target_currency {
    type: number
    sql: ${TABLE}.TotalPurchasesInTargetCurrency ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
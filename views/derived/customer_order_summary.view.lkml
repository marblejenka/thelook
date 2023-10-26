# https://cloud.google.com/looker/docs/derived-tables
view: customer_order_summary {
  derived_table: {
    datagroup_trigger: everything
    # note: スキーマがサンプルと違う
    sql:
      SELECT
        user_id AS customer_id,
        MIN(DATE(shipped_at)) AS first_order,
        SUM(num_of_item) AS total_amount
      FROM
        ${orders.SQL_TABLE_NAME}
      GROUP BY
        user_id ;;
  }

  dimension: customer_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.customer_id ;;
  }
  dimension_group: first_order {
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.first_order ;;
  }
  dimension: total_amount {
    type: number
    value_format: "0.00"
    sql: ${TABLE}.total_amount ;;
  }
}

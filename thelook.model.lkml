connection: "sample_bigquery_connection"

# include all the views
include: "/views/*.view"
include: "/views/derived/*.view"

# include all the dashboards
include: "*.dashboard"


# data config
datagroup: everything {
  # sql_trigger: SELECT max(created_at) FROM ecomm.events ;;
  interval_trigger : "2400 hours"
  max_cache_age: "24 hours"
}
persist_with: everything


explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
    view_label: ""

  }
}

explore: order_items {
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: products {}

explore: users {}

explore: customer_order_summary {}

explore: fixed {
  label: "固定の表示をするExplore"
  query: default {
    dimensions: [state, gender, count]
    label: "固定の表示をするExploreのクィックスタート"
  }
  sql_always_where:
    {% if state_parameter._in_query %}
      ${state} = {% parameter state_parameter %}
    {% endif %} ;;
}

# If necessary, uncomment the line below to include explore_source.
# include: "thelook.model.lkml"

view: fixed {
  derived_table: {
    explore_source: order_items {
      column: state { field: users.state }
      column: count { field: orders.count }
      column: gender { field: users.gender }
    }
  }
  dimension: state {
    # hidden: yes
    description: ""
  }
  dimension: gender {
    # hidden: yes
    description: ""
  }
  dimension: count {
    # hidden: yes
    description: ""
  }

  parameter: state_parameter {
    type: string
    label: "州のパラメーター"
    suggest_dimension: state
  }

  filter: state_filter {
    label: "州によるフィルタ"
    type: string
    suggest_dimension: state
    sql: {% condition state_filter %} ${state} {% endcondition %} ;;
  }
}

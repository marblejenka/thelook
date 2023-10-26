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
    hidden: yes
    description: ""
  }
  dimension: gender {
    hidden: yes
    description: ""
  }
  measure: count {
    hidden: yes
    description: ""
    type: number
  }
}

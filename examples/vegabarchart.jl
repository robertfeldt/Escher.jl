# From Vega tutorial
vegavarbarchart = """
{
  "width": 400,
  "height": 200,
  "padding": {"top": 10, "left": 30, "bottom": 20, "right": 10},

  "data": [
    {
      "name": "table",
      "values": [
        {"category":"A", "amount":28},
        {"category":"B", "amount":55},
        {"category":"C", "amount":43},
        {"category":"D", "amount":91},
        {"category":"E", "amount":81},
        {"category":"F", "amount":53},
        {"category":"G", "amount":19},
        {"category":"H", "amount":87},
        {"category":"I", "amount":52}
      ]
    }
  ],

  "signals": [
    {
      "name": "tooltip",
      "init": {},
      "streams": [
        {"type": "rect:mouseover", "expr": "datum"},
        {"type": "rect:mouseout", "expr": "{}"}
      ]
    }
  ],

  "predicates": [
    {
      "name": "tooltip", "type": "==", 
      "operands": [{"signal": "tooltip._id"}, {"arg": "id"}]
    }
  ],

  "scales": [
    { "name": "xscale", "type": "ordinal", "range": "width",
      "domain": {"data": "table", "field": "category"} },
    { "name": "yscale", "range": "height", "nice": true,
      "domain": {"data": "table", "field": "amount"} }
  ],

  "axes": [
    { "type": "x", "scale": "xscale" },
    { "type": "y", "scale": "yscale" }
  ],

  "marks": [
    {
      "type": "rect",
      "from": {"data":"table"},
      "properties": {
        "enter": {
          "x": {"scale": "xscale", "field": "category"},
          "width": {"scale": "xscale", "band": true, "offset": -1},
          "y": {"scale": "yscale", "field": "amount"},
          "y2": {"scale": "yscale", "value":0}
        },
        "update": { "fill": {"value": "steelblue"} },
        "hover": { "fill": {"value": "red"} }
      }
    },
    {
      "type": "text",
      "properties": {
        "enter": {
          "align": {"value": "center"},
          "fill": {"value": "#333"}
        },
        "update": {
          "x": {"scale": "xscale", "signal": "tooltip.category"},
          "dx": {"scale": "xscale", "band": true, "mult": 0.5},
          "y": {"scale": "yscale", "signal": "tooltip.amount", "offset": -5},
          "text": {"signal": "tooltip.amount"},
          "fillOpacity": {
            "rule": [
              {
                "predicate": {"name": "tooltip", "id": {"value": null}},
                "value": 0
              },
              {"value": 1}
            ]
          }
        }
      }
    }
  ]
}
"""

function main(window)
    push!(window.assets, "vega")

    vega(vegavarbarchart)
end

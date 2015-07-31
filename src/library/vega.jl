export vega

@api vega => (VegaPlot <: Tile) begin
    doc("Vega plotting.")
    arg(jsonsrc::String, doc="The json vega specification to be rendered.")
end

render(v::VegaPlot, state) =
    Elem("vega-plot", jsonsrc=v.jsonsrc)

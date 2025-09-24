components {
  id: "floatingText"
  component: "/main/battle/floatingText.script"
}
embedded_components {
  id: "label"
  type: "label"
  data: "size {\n"
  "  x: 128.0\n"
  "  y: 32.0\n"
  "}\n"
  "text: \"Label\"\n"
  "font: \"/assets/font/game.font\"\n"
  "material: \"/builtins/fonts/label.material\"\n"
  ""
  position {
    z: 0.3
  }
}

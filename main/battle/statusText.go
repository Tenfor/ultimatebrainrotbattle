components {
  id: "statusText"
  component: "/main/battle/statusText.script"
}
embedded_components {
  id: "label"
  type: "label"
  data: "size {\n"
  "  x: 128.0\n"
  "  y: 32.0\n"
  "}\n"
  "color {\n"
  "  y: 0.8\n"
  "  z: 0.0\n"
  "}\n"
  "shadow {\n"
  "  w: 0.0\n"
  "}\n"
  "text: \"Critical\"\n"
  "font: \"/assets/font/statusText.font\"\n"
  "material: \"/builtins/fonts/label.material\"\n"
  ""
  position {
    z: 0.3
  }
}

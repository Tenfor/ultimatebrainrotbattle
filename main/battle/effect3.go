components {
  id: "effect"
  component: "/main/battle/effect.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"fire_punch\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/img/effects/effects4.atlas\"\n"
  "}\n"
  ""
  position {
    z: 0.3
  }
}

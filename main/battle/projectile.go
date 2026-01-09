components {
  id: "projectile"
  component: "/main/battle/projectile.script"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"fire_bolt\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/img/effects/effects2.atlas\"\n"
  "}\n"
  ""
  position {
    z: 0.4
  }
}

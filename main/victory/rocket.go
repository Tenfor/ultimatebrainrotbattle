components {
  id: "rocket"
  component: "/main/victory/rocket.script"
}
components {
  id: "blueParticle"
  component: "/main/victory/blueParticle.particlefx"
}
components {
  id: "cyanParticle"
  component: "/main/victory/cyanParticle.particlefx"
}
components {
  id: "greenParticle"
  component: "/main/victory/greenParticle.particlefx"
}
components {
  id: "purpleParticle"
  component: "/main/victory/purpleParticle.particlefx"
}
components {
  id: "redParticle"
  component: "/main/victory/redParticle.particlefx"
}
components {
  id: "yellowParticle"
  component: "/main/victory/yellowParticle.particlefx"
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "default_animation: \"rocket\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "textures {\n"
  "  sampler: \"texture_sampler\"\n"
  "  texture: \"/assets/img/effects/effects2.atlas\"\n"
  "}\n"
  ""
  position {
    z: 0.5
  }
  scale {
    x: 0.2
    y: 0.2
  }
}

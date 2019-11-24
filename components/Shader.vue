<template>
  <canvas width="670" height="496"></canvas>
</template>

<script>
// import axios from 'axios'
import * as createShader from 'gl-shader'
import * as triangle from "a-big-triangle"
import * as getPixels from "get-pixels"

import vertShader from 'raw-loader!glslify-loader!../static/shaders/noise-grid/shader.vert'
import fragShader from 'raw-loader!glslify-loader!../static/shaders/noise-grid/collage.glsl'

export default {
    beforeCreate: function(){
        // console.log("beforeCreate")
        this.state = {}
    },
    created: function(){
        // console.log("created")

        // let self = this
        this.start = function(){
            var width = this.gl.drawingBufferWidth
            var height = this.gl.drawingBufferHeight
            this.gl.viewport(0, 0, width, height)

            this.texture.bind()
            this.shader.bind()
            this.shader.uniforms.u_time += 0.01
            triangle(this.gl)
            this.raf = window.requestAnimationFrame(this.start)
        }.bind(this)

        // this.vertShader = glslify("../assets/shaders/noise-grid/shader.vert")
        // this.fragShader = glslify("../assets/shaders/noise-grid/collage.glsl")
    },
    beforeMount: function(){
        // console.log("beforeMount:", this)
    },
    mounted: function(){
        // console.log("mounted:", this.$el)
        let elt = this.$el

        this.gl = require("webgl-context")({
            canvas: elt,
            width: 670,
            height: 496
        })

        var self = this
        getPixels("/images/paisagem.jpg", function(err, pixels) {
            if (err) {
                console.log(err)
                return
            }

            self.texture = require("gl-texture2d")(self.gl, pixels)

            self.shader = createShader(
                self.gl,
                vertShader,
                fragShader
            )
            self.shader.bind()
            self.shader.uniforms.u_resolution = [self.gl.drawingBufferWidth, self.gl.drawingBufferHeight]
            self.shader.uniforms.u_mouse = [0.98, 0.96]
            self.shader.uniforms.u_time = 0.0
            self.shader.uniforms.img = 0

            self.start()
        })
    },
    destroyed: function(){
        window.cancelAnimationFrame(this.raf)
    }
}
</script>

<style lang="scss">
canvas {
    width: 100%;
    max-width: 670px;
    margin-right: 100px;

    @media (max-width: 768px) {
    max-width: 100%;
    }
}
</style>

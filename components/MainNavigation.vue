<template>
    <div class="main-navigation">
        <nuxt-link to="/">
            <h1>connor trotter</h1>
        </nuxt-link>
    </div>
</template>

<script>
import { TimelineMax, TweenMax, Sine, Expo } from 'gsap'

export default {
    data(){
        return {
            scrollY: 0,
            isOn: true
        }
    },
    beforeCreate(){
        // console.log("beforeCreate:", this)
    },
    created(){
        // console.log("created:", this)
    },
    beforeMount(){
        // console.log("beforeMount:", this)
        if(this.$el){
            this.tl = new TimelineMax({paused: true, delay: 1})
            this.tl.fromTo(this.$el, 0.6, {autoAlpha: 0}, {autoAlpha: 1, ease: Sine.easeOut})
            this.tl.fromTo(this.$el.querySelector("h1"), 0.6, {color: "#ffffff"}, {color: "#000000", ease: Sine.easeOut})
            this.tl.fromTo(this.$el.querySelector("h1"), 0.8, {x: 0, y: 0}, {x: 5, y: -7, force3D: true, ease: Expo.easeOut})
            this.tl.fromTo(".global-mask", 0.4, {autoAlpha: 1}, {autoAlpha: 0, force3D: true, ease: Sine.easeOut}, "-=0.8")
        }
    },
    mounted(){
        // console.log("mounted:", this)
        // let overflowEl = window.innerWidth > 768 ? window : document.querySelector("main")
        let overflowEl = window

        overflowEl.addEventListener("scroll", (e) => {
            // console.log(overflowEl)

            // let delta = (window.innerWidth > 768 ? overflowEl.scrollY : overflowEl.scrollTop) - this.scrollY
            let delta = window.scrollY - this.scrollY

            if(delta > 0 && this.isOn){
                // console.log("down")
                TweenMax.to(this.$el, 0.5, {autoAlpha: 0, ease: Expo.easeInOut})
                this.isOn = false
            }else if(delta < 0 && !this.isOn && window.scrollY < 800) {
                // console.log("up")
                TweenMax.to(this.$el, 0.5, {autoAlpha: 1, ease: Expo.easeInOut})
                this.isOn = true
            }

            // this.scrollY = (window.innerWidth > 768 ? overflowEl.scrollY : overflowEl.scrollTop) 
            this.scrollY = window.scrollY
        })

        if(this.tl){
            this.tl.play()
        }
    }
}
</script>

<style lang="scss">
.main-navigation {
    display: flex;
    padding: 70px 60px;
    position: fixed;
    top: 0px;
    left: 0px;
    width: 100%;
    pointer-events: none;
    z-index: 10;
    opacity: 0;

    @media (max-width: 768px) {
        padding: 35px 30px;
        align-items: flex-start;
    }

    a {
        z-index: 0;
        display: flex;
        text-decoration: none;
        pointer-events: all;
        transform-origin: left;
        background: black;
        /* opacity: 0; */

        h1 {
            color: white;
            font-size: 16px;
            padding: 9px 15px;
            margin: 0;
            position: relative;
            font-weight: 100;
            letter-spacing: 1px;
            font-family: monospace;
            border: 1px solid black;
            background: white;
            /* transform: translate(5px, -7px); */
            /* opacity: 0; */
        }
    }
}
</style>

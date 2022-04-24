<template>
  <div class="main-navigation">
    <nuxt-link to="/">
      <h1>connor trotter</h1>
    </nuxt-link>
    <a href="mailto:connor.trotter.dev@gmail.com">
      <div class="mail">
        <svg
          width="51"
          height="51"
          viewBox="0 0 51 51"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <line
            x1="1.3721"
            y1="29.6356"
            x2="20.6356"
            y2="18.6279"
            stroke="black"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
          <line
            x1="29.3721"
            y1="12.6356"
            x2="48.6356"
            y2="1.6279"
            stroke="black"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
          <line
            x1="1.3721"
            y1="39.6356"
            x2="20.6356"
            y2="28.6279"
            stroke="black"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
          <line
            x1="1.3721"
            y1="49.6356"
            x2="20.6356"
            y2="38.6279"
            stroke="black"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
          <line
            x1="29.3721"
            y1="35.6356"
            x2="48.6356"
            y2="24.6279"
            stroke="black"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
          <line
            x1="28.025"
            y1="36.1763"
            x2="28.2315"
            y2="13.9905"
            stroke="black"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
          <line
            x1="49.025"
            y1="24.1763"
            x2="49.2315"
            y2="1.99047"
            stroke="black"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
          <line
            x1="29.3676"
            y1="12.6401"
            x2="39.6401"
            y2="18.6323"
            stroke="black"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
          <line
            x1="39.6451"
            y1="17.631"
            x2="48.631"
            y2="2.35491"
            stroke="black"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          />
        </svg>
      </div>
    </a>
  </div>
</template>

<script>
import { TimelineMax, TweenMax, Sine, Expo } from 'gsap'

export default {
  data() {
    return {
      scrollY: 0,
      isOn: true
    }
  },
  beforeCreate() {
    // console.log("beforeCreate:", this)
  },
  created() {
    // console.log("created:", this)
  },
  beforeMount() {
    // console.log("beforeMount:", this)
    if (this.$el) {
      this.tl = new TimelineMax({ paused: true, delay: 1 })
      this.tl.fromTo(this.$el, 0.6, { autoAlpha: 0 }, { autoAlpha: 1, ease: Sine.easeOut })
      this.tl.fromTo(this.$el.querySelector("h1"), 0.6, { color: "#ffffff" }, { color: "#000000", ease: Sine.easeOut })
      this.tl.fromTo(this.$el.querySelector("h1"), 0.8, { x: 0, y: 0 }, { x: 5, y: -7, force3D: true, ease: Expo.easeOut })
      this.tl.fromTo(".global-mask", 0.4, { autoAlpha: 1 }, { autoAlpha: 0, force3D: true, ease: Sine.easeOut }, "-=0.8")
    }
  },
  mounted() {
    // console.log("mounted:", this)
    // let overflowEl = window.innerWidth > 768 ? window : document.querySelector("main")
    let overflowEl = window

    overflowEl.addEventListener("scroll", (e) => {
      // console.log(overflowEl)

      // let delta = (window.innerWidth > 768 ? overflowEl.scrollY : overflowEl.scrollTop) - this.scrollY
      let delta = window.scrollY - this.scrollY

      if (delta > 0 && this.isOn && window.scrollY > 100) {
        // console.log("down")
        TweenMax.to(this.$el, 0.5, { autoAlpha: 0, ease: Expo.easeInOut })
        this.isOn = false
      } else if (delta < 0 && !this.isOn && window.scrollY < 800) {
        // console.log("up")
        TweenMax.to(this.$el, 0.5, { autoAlpha: 1, ease: Expo.easeInOut })
        this.isOn = true
      }

      // this.scrollY = (window.innerWidth > 768 ? overflowEl.scrollY : overflowEl.scrollTop)
      this.scrollY = window.scrollY
    })

    if (this.tl) {
      this.tl.play()
    }
  }
}
</script>

<style lang="scss">
.main-navigation {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 70px 60px;
  position: fixed;
  top: 0px;
  left: 0px;
  width: 100%;
  pointer-events: none;
  z-index: 10;
  opacity: 0;

  @media (max-width: 768px) {
    padding: 30px 10px;
    align-items: flex-start;
  }

  a:first-child {
    z-index: 0;
    display: flex;
    text-decoration: none;
    pointer-events: initial;
    transform-origin: left;
    background: black;
    /* opacity: 0; */

    h1 {
      color: white;
      font-size: 16px;
      padding: 9px 14px;
      margin: 0;
      position: relative;
      font-weight: 100;
      letter-spacing: 0.3px;
      font-family: monospace;
      border: 1px solid black;
      background: white;
      /* transform: translate(5px, -7px); */
      /* opacity: 0; */
    }
  }

  .mail {
    pointer-events: initial;
    position: relative;

    svg {
      width: 25px;
      height: auto;
    }

    &:after {
      width: 60px;
      height: 60px;
      content: "";
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
  }
}
</style>

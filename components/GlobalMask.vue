<template>
    <div v-bind:class="['global-mask', {active: loading}]"></div>
</template>

<script>
import { TweenMax } from 'gsap'

export default {
  data: () => ({
    loading: false
  }),
  methods: {
    start () {
        // TweenMax.to('.global-mask', 0.3, {autoAlpha: 1})
        this.loading = true
    },
    finish () {},
    hide () {
        //   TweenMax.to('.global-mask', 0.3, {autoAlpha: 0, delay: 0.3})
        this.loading = false
    }
  }
}
</script>

<style lang="scss">
.global-mask {
    position: fixed;
    top: 0px;
    left: 0px;
    width: 100%;
    height: 100vh;
    z-index: 9;
    background: white;
    will-change: opacity;
    opacity: 0;
    /* visibility: hidden; */
    transition: opacity 0.3s ease-out;
    pointer-events: none;

    &.active {
        opacity: 1;
        /* visibility: visible; */
    }
}
</style>

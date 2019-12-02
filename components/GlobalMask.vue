<template>
  <div class="global-mask"></div>
</template>

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
  pointer-events: none;
}
</style>

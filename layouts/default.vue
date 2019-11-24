<template>
  <div>
    <main-navigation />
    <global-mask />
    <main>
      <nuxt />
    </main>
  </div>
</template>

<script>
import MainNavigation from '~/components/MainNavigation.vue'
import GlobalMask from '~/components/GlobalMask.vue'

export default {
  components: {
    MainNavigation,
    GlobalMask
  }
}
</script>

<style lang="scss">
html {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  font-size: 16px;
  word-spacing: 1px;
  -ms-text-size-adjust: 100%;
  -webkit-text-size-adjust: 100%;
  -moz-osx-font-smoothing: grayscale;
  -webkit-font-smoothing: antialiased;
  box-sizing: border-box;
}

*,
*:before,
*:after {
  box-sizing: border-box;
  margin: 0;
}

main {
  padding: 170px 60px;

  @media (max-width: 768px) {
    padding: 105px 30px;
  }
}

.button--green {
  display: inline-block;
  border-radius: 4px;
  border: 1px solid #3b8070;
  color: #3b8070;
  text-decoration: none;
  padding: 10px 30px;
}

.button--green:hover {
  color: #fff;
  background-color: #3b8070;
}

.button--grey {
  display: inline-block;
  border-radius: 4px;
  border: 1px solid #35495e;
  color: #35495e;
  text-decoration: none;
  padding: 10px 30px;
  margin-left: 15px;
}

.button--grey:hover {
  color: #fff;
  background-color: #35495e;
}

@font-face {
	font-family: "Inter";
	src: url("/fonts/Inter-Regular.woff") format("woff");
	font-weight: 100;
	font-style: normal;
}

@font-face {
	font-family: "Inter";
	src: url("/fonts/Inter-Medium.woff") format("woff");
	font-weight: normal;
	font-style: normal;
}
</style>

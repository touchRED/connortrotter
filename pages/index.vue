<template>
  <div class="home">
    <div class="hero">
      <shader />
      <div class="hero__text" v-html="channelData[0].content_html"></div>
    </div>
    <div class="work">
      <h1>Recent Work</h1>
      <div class="work__grid">
        <div class="work__item" v-for="block in channelData.slice(1)" v-bind:key="block.id">
          <nuxt-link v-bind:to="'/project/' + block.slug + '/'">
            <div
              class="work__item-image preload"
              v-bind:preload="block.contents[0].image.display.url"
            ></div>
          </nuxt-link>
          <p>{{ block.title }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Shader from '~/components/Shader.vue'
import { TweenMax } from 'gsap'

export default {
  computed: {
    channelData() {
      return this.$store.state.channelData
    }
  },
  components: {
    Shader
  },
  mounted() {
    let preloads = this.$el.querySelectorAll(".preload")

    preloads.forEach(preload => {
      let preloadURL = preload.getAttribute("preload")
      let image = new Image();

      /* --- Use Img load to measure for background-image --- */
      image.onload = () => {
        preload.style.backgroundImage = "url(" + preloadURL + ")";
        preload.className += " preloaded";
      };

      image.src = preloadURL;
    })
  },
  transition: {
    css: false,
    beforeEnter(el) {
      TweenMax.set(el, { autoAlpha: 0 })
    },
    enter(el, done) {
      // console.log("enter: ", this, el)
      TweenMax.to(el, 0.5, { autoAlpha: 1, onComplete: done })
    },
    leave(el, done) {
      // console.log("leave: ", this, el)
      TweenMax.to(el, 0.5, { autoAlpha: 0, onComplete: done })
    }
  }
}
</script>

<style lang="scss">
.hero {
  display: flex;
  justify-content: space-between;
  margin-bottom: 60px;

  @media (max-width: 768px) {
    flex-direction: column;
  }

  &__text {
    width: 100%;
    max-width: 495px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 50px 0px;

    @media (max-width: 768px) {
      padding: 30px 0px 0px;
    }

    p {
      font-size: 28px;
      line-height: 38px;
      color: black;
      font-weight: 500;
      font-family: "Inter", system-ui, sans-serif;
      margin: 0 auto 30px;

      &:last-child {
        margin: 0 auto;
      }

      @media (max-width: 768px) {
        font-size: 20px;
        line-height: 28px;
      }

      a {
        text-decoration: underline;
        font-size: inherit;
        color: black;
      }
    }
  }
}

.work {
  h1 {
    font-size: 24px;
    color: #4a4a4a;
    margin-bottom: 30px;
    font-weight: 100;
    font-family: system-ui, sans-serif;
  }

  &__grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-column-gap: 60px;

    @media (max-width: 768px) {
      grid-template-columns: 1fr;
      grid-row-gap: 30px;
    }
  }

  &__item {
    &-image {
      padding-bottom: 70%;
      margin-bottom: 10px;
      background-position: center;
      background-size: cover;
    }

    p {
      font-size: 16px;
      color: #4a4a4a;
      font-weight: 100;
      font-family: "Inter", system-ui, sans-serif;

      @media (max-width: 768px) {
        font-size: 14px;
      }
    }
  }
}
</style>

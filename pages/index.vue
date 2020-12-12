<template>
  <div class="home">
    <div class="hero">
      <shader />
      <div class="hero__text" v-html="channelData[0].content_html"></div>
    </div>
    <div class="work">
      <div class="work__type" v-for="type in channelData.slice(1)" v-bind:key="type.id">
        <h1>{{ type.title }}</h1>
        <div class="work__grid">
          <div class="work__item" v-for="block in type.contents" v-bind:key="block.id">
            <nuxt-link v-bind:to="'/project/' + block.slug + '/'">
              <div
                class="work__item-image preload"
                v-bind:preload="block.contents[0].image.original.url"
              ></div>
            </nuxt-link>
            <p>{{ block.title }}</p>
          </div>
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
      // console.log("frontend:", this.$store.state.channelData)
      // console.log("routes:", this.$store.state.routes)
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
      if (preloadURL == "") return
      let image = new Image();
      TweenMax.set(preload, { autoAlpha: 0 })

      /* --- Use Img load to measure for background-image --- */
      image.onload = () => {
        if (preload.tagName.toLowerCase() == "img") {
          preload.src = preloadURL;
        } else {
          preload.style.backgroundImage = "url(" + preloadURL + ")";
        }

        preload.className += " preloaded";
        TweenMax.to(preload, 0.4, { autoAlpha: 1, ease: Sine.easeOut })
      };

      image.src = preloadURL;
    })
  },
  // transition: {
  //   css: false,
  //   beforeEnter(el) {
  //     TweenMax.set(el, { autoAlpha: 0 })
  //   },
  //   enter(el, done) {
  //     // console.log("enter: ", this, el)
  //     TweenMax.to(el, 0.5, { autoAlpha: 1, onComplete: done })
  //   },
  //   leave(el, done) {
  //     // console.log("leave: ", this, el)
  //     TweenMax.to(el, 0.5, { autoAlpha: 0, onComplete: done })
  //   }
  // }
}
</script>

<style lang="scss">
.hero {
  display: flex;
  justify-content: space-between;
  margin: 0 auto 60px;
  width: 100%;
  max-width: 1320px;

  @media (max-width: 768px) {
    flex-direction: column;
    margin: 0 auto 40px;
  }

  &__text {
    width: 100%;
    /* max-width: 495px; */
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 50px 0px;
    /* margin: 0 auto; */

    @media (max-width: 768px) {
      padding: 30px 0px 0px;
    }

    p {
      width: 100%;
      font-size: 34px;
      line-height: 38px;
      letter-spacing: -0.8px;
      color: black;
      font-weight: 500;
      font-family: "Inter", system-ui, sans-serif;
      margin: 0 auto 30px;

      &:last-child {
        margin: 0 auto;
      }

      @media (max-width: 768px) {
        font-size: 20px;
        line-height: 25px;
        letter-spacing: -0.4px;
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
  width: 100%;
  max-width: 1320px;
  margin: 0 auto;

  h1 {
    font-size: 20px;
    margin-bottom: 0px;
    font-weight: 300;
    letter-spacing: -0.4px;
    font-family: "Inter", system-ui, sans-serif;

    @media (max-width: 768px) {
      font-size: 14px;
      margin-bottom: 15px;
    }
  }

  &__type {
    margin-bottom: 60px;
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
      background-position: center bottom;
      background-size: contain;
      background-repeat: no-repeat;

      @media (max-width: 768px) {
        width: 106%;
        position: relative;
        left: -3%;
      }
    }

    p {
      font-size: 16px;
      letter-spacing: 0;
      font-family: "Inter", system-ui, sans-serif;
      padding-left: 13px;

      @media (max-width: 768px) {
        font-size: 14px;
        padding-left: 0px;
        /* letter-spacing: -0.5px; */
      }
    }
  }
}
</style>

<template>
  <div class="project">
    <div class="project-hero">
      <div class="project-hero__block" v-for="block in channelData.contents" v-bind:key="block.id">
        <div
          class="project-hero__image preload"
          v-if="block.image"
          v-bind:preload="block.image ? block.image.original.url : ''"
        >
          <a
            v-if="block.source"
            v-bind:href="block.source.url ? block.source.url : ''"
            target="_blank"
          >
            <img class="preload" v-bind:preload="block.image ? block.image.original.url : ''" />
          </a>
          <img class="preload" v-else v-bind:preload="block.image ? block.image.original.url : ''" />
        </div>
        <div
          class="project-hero__content"
          v-else
          v-html="block.content_html ? block.content_html : ''"
        ></div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { TweenMax, Sine } from 'gsap'

export default {
  asyncData({ params }) {
    return { slug: params.slug }
  },
  computed: {
    channelData() {
      return this.$store.getters.getChannelContents(this.slug)
    }
  },
  mounted() {
    // console.log(this)
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
  //     let fades = el.querySelectorAll(".js-fade")
  //     TweenMax.set(fades, { autoAlpha: 0 })
  //   },
  //   enter(el, done) {
  //     // console.log("enter: ", this, el)
  //     TweenMax.to(el, 0.5, { autoAlpha: 1, onComplete: done })
  //     let fades = el.querySelectorAll(".js-fade")
  //     TweenMax.staggerFromTo(fades, 0.4, { autoAlpha: 0 }, { autoAlpha: 1, ease: Sine.easeOut, onComplete: done }, 0.2)
  //   },
  //   leave(el, done) {
  //     // console.log("leave: ", this, el)
  //     TweenMax.to(el, 0.5, { autoAlpha: 0, onComplete: done })
  //   }
  // }
}
</script>

<style lang="scss">
.project {
  /* opacity: 0; */

  &-hero {
    display: grid;
    grid-template-columns: 1fr;
    grid-gap: 30px;
    align-items: center;

    @media (max-width: 768px) {
      grid-gap: 30px;
    }

    &__image {
      padding-bottom: 70%;
      background-position: center bottom;
      background-size: contain;
      background-repeat: no-repeat;

      @media (max-width: 768px) {
        width: 106%;
        position: relative;
        left: -3%;
        padding: 0;
        background-image: none !important;
      }

      img {
        display: none;

        @media (max-width: 768px) {
          display: block;
          width: 100%;
          height: auto;
        }
      }
    }

    &__content {
      font-family: "Inter", system-ui, sans-serif;
      max-width: 620px;
      margin: 0 auto;
      
      @media (max-width: 768px) {
        padding: 0 6px;
        max-width: 100%;
      }

      h1 {
        font-size: 48px;
        margin-bottom: 15px;
        font-weight: bold;
        letter-spacing: 0;

        @media (max-width: 768px) {
          font-size: 28px;
          margin-bottom: 30px;
          letter-spacing: -0.8px;
        }

        a {
          text-decoration: none;
          font-weight: inherit;
          font-size: inherit;
          letter-spacing: inherit;
          color: black;
          border-bottom: 4px solid black;
        }
      }

      p {
        font-size: 18px;
        line-height: 26px;
        letter-spacing: 0;
        color: black;
        margin: 0;

        &:not(:first-child) {
          margin: 30px auto 0;
        }

        @media (max-width: 768px) {
          font-weight: 300;
          line-height: normal;
        }

        a {
          text-decoration: underline;
        }
      }

      li {
        font-size: 18px;
        line-height: 26px;
        letter-spacing: 0;
        color: black;

        @media (max-width: 768px) {
          font-size: 16px;
          font-weight: 300;
          line-height: normal;
          /* letter-spacing: -0.5px; */
        }
      }

      a {
        font-size: inherit;
        color: black;
      }
    }
  }
}
</style>

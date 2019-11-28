<template>
  <div class="project">
    <div class="project-hero">
      <div class="project-hero__block" v-for="block in channelData" v-bind:key="block.id">
        <div
          class="project-hero__image preload"
          v-if="block.image"
          v-bind:preload="block.image ? block.image.display.url : ''"
        >
          <img class="preload" v-bind:preload="block.image ? block.image.display.url : ''" />
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
import { TweenMax } from 'gsap'

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
    console.log(this)
    let preloads = this.$el.querySelectorAll(".preload")

    preloads.forEach(preload => {
      let preloadURL = preload.getAttribute("preload")
      if (preloadURL == "") return
      let image = new Image();

      /* --- Use Img load to measure for background-image --- */
      image.onload = () => {
        if (preload.tagName.toLowerCase() == "img") {
          preload.src = preloadURL;
        } else {
          preload.style.backgroundImage = "url(" + preloadURL + ")";
        }

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
.project {
  /* opacity: 0; */

  &-hero {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    grid-gap: 60px;
    align-items: center;

    @media (max-width: 768px) {
      grid-template-columns: 1fr;
      grid-gap: 30px;
    }

    &__block {
    }

    &__image {
      padding-bottom: 70%;
      background-position: center;
      background-size: contain;
      background-repeat: no-repeat;

      @media (max-width: 768px) {
        padding: 0;
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

      h1 {
        font-size: 48px;
        margin-bottom: 15px;

        @media (max-width: 768px) {
          font-size: 28px;
        }
      }

      p {
        font-size: 18px;
        line-height: 26px;
        color: black;
        /* font-weight: 500; */
        margin: 0 auto 30px;

        &:last-child {
          margin: 0 auto;
        }

        @media (max-width: 768px) {
          font-size: 14px;
          line-height: normal;
          margin-bottom: 15px;
        }

        a {
          text-decoration: underline;
          font-size: inherit;
          color: black;
        }
      }
    }
  }
}
</style>

<template>
  <div class="project">
    <div class="project-hero">
      <div class="project-hero__block" v-for="block in channelData.contents" v-bind:key="block.id">
        <div class="project-hero__image preload" v-if="block.image" v-bind:preload="block.image ? block.image.display.url : ''"></div>
        <div class="project-hero__content" v-else v-html="block.content_html ? block.content_html : ''"></div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { TweenMax } from 'gsap'

export default {
  asyncData(context) {
      // console.log(context)
    return axios.get("http://api.are.na/v2/channels/" + context.params.slug)
      .then((res) => {
        // console.log(res.data)
        return { channelData: res.data }
      })
  },
  mounted() {
    this.$nextTick(() => {
      console.log("GlobalMask root-attached: ", this.$root.$loading)
      this.$root.$loading.hide()
    })

    let preloads = this.$el.querySelectorAll(".preload")

    preloads.forEach(preload => {
      let preloadURL = preload.getAttribute("preload")
      if(preloadURL == "") return
      let image = new Image();

			/* --- Use Img load to measure for background-image --- */
			image.onload = ()=>{
				preload.style.backgroundImage = "url(" + preloadURL + ")";
				preload.className += " preloaded";
			};

			image.src = preloadURL;
    })
  }
}
</script>

<style lang="scss">
.project {

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

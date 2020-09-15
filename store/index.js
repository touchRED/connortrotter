import axios from 'axios'

export const state = () => ({
    loaded: false,
    channelData: [],
    routes: {}
})

const trackBlock = (block, state) => {

  block.contents.forEach(content => {
    if(content.base_class == "Channel") {
      state.routes[content.slug] = content
      trackBlock(content, state)
    }
  })
}

export const mutations = {
		setChannelData(state, data){
        state.channelData = data
        data.forEach(block => {
            if(block.base_class == "Channel") {
              state.routes[block.slug] = block
              trackBlock(block, state)
            }
        });
        state.loaded = true
    }
}

export const getters = {
    getChannelContents(state){
        return function(slug){
            return state.routes[slug]
        }
    }
}

export const actions = {
  nuxtServerInit(store) {
    return recursiveGetChannel("http://api.are.na/v2/channels/site-yufxd4bzdt8", 0).then(fetched => {
      console.log("hmm...", fetched)
      store.commit('setChannelData', fetched)
    })
  }
}

const recursiveGetChannel = async (url, depth) => {
  const temporaryDepthLimit = 5

  console.log(depth)

  if(depth > temporaryDepthLimit) return null
  
  return axios.get(url)
    .then((res) => {
      let promises = []

      
      // res.data.contents = res.data.contents.map(content => {
      //   if (content.base_class == 'Channel') {
      //     return axios.get("http://api.are.na/v2/channels/" + content.slug).then(res => {
      //       return res.data
      //     })
      //   } else {
      //     return content
      //   }
      // })

      if (res.data.base_class == 'Channel') {

        res.data.contents = res.data.contents.map(content => {
          if (content.base_class == 'Channel') {
            return recursiveGetChannel("http://api.are.na/v2/channels/" + content.slug, depth + 1).then(channel => {
              return channel
            })
          } else {
            return content
          }
        })

        // res.data.contents = recursiveGetChannel("http://api.are.na/v2/channels/" + content.slug, depth + 1).then(channel => {
        //   return channel
        // })

        if(depth == 0) {
          return Promise.all(res.data.contents)
        }else {
          return Promise.all(res.data.contents).then(arr => {
            return {
              ...res.data,
              contents: arr
            }
          })
        }
      } else {
        return res.data
      }
    })
}

// get root -> 
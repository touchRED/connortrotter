import axios from 'axios'

export const state = () => ({
    loaded: false,
    channelData: false,
    routes: {}
})

export const mutations = {
    setChannelData(state, data){
        state.channelData = data
        data.forEach(block => {
            if(block.base_class == "Channel") {
                state.routes[block.slug] = block
            }
        });
        state.loaded = true
    }
}

export const getters = {
    getChannelContents(state){
        return function(slug){
            return state.routes[slug].contents
        }
    }
}

export const actions = {
    nuxtServerInit(store) {
    
        return axios.get("http://api.are.na/v2/channels/site-yufxd4bzdt8")
          .then((res) => {
            let promises = []
            res.data.contents = res.data.contents.map(content => {
              if (content.base_class == 'Channel') {
                return axios.get("http://api.are.na/v2/channels/" + content.slug).then(res => {
                  return res.data
                })
              } else {
                return content
              }
            })
    
            return Promise.all(res.data.contents)
          })
          .then(fetched => {
            store.commit('setChannelData', fetched)
          })
      }
}
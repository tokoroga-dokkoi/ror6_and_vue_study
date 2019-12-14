import Vue from 'vue'
import Vuex from 'vuex'
import auth from './modules/auth'
import message from './modules/message'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    auth,
    message
  }
})

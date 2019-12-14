<template>
  <v-app>
    <v-content>
      <MyLoginHedaer
        v-if="isLogin">
      </MyLoginHedaer>
      
      <MyNonLoginHeader
        v-else
      >
      </MyNonLoginHeader>
      <router-view></router-view>
    </v-content>
  </v-app>
</template>

<script>
import MyNonLoginHeader from './components/common/Header'
import MyLoginHedaer from './components/common/LoginHeader'
export default {
  name: 'App',

  components: {
    MyNonLoginHeader,
    MyLoginHedaer
  },
  computed: {
      isLogin() {
          // Headerの項目をログインに応じて変更する
          // Check Vue Store
          const storeCheck         = this.$store.state.auth.loggedIn
          const localStorageCheck  = localStorage.getItem('Token') && true
          return storeCheck | localStorageCheck
      }
  },


};
</script>

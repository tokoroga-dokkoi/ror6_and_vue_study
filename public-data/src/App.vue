<template>
  <v-app>
    <v-content>
      <MyHeader/>
      <Home/>
    </v-content>
  </v-app>
</template>

<script>
import Home from './components/HelloRunningShare'
import MyHeader from './components/common/Header';
export default {
  name: 'App',

  components: {
    Home,
    MyHeader
  },

  data: () => ({
    //
  }),
};
</script>

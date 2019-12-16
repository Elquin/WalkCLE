import Vue from 'vue'
import App from './App.vue'
import router from './router'
import * as VueGoogleMaps from "vue2-google-maps";


Vue.config.productionTip = false

Vue.use(VueGoogleMaps, {
  load: {
    key: "AIzaSyA8qsiApLrQeAAIrs-Rx8lGQHOxa_lxHc0",
  }
});

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')

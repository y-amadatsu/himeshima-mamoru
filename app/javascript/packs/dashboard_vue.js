/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue'
import { BootstrapVue, IconsPlugin, TooltipPlugin } from 'bootstrap-vue'
Vue.use(TooltipPlugin)
import App from '../dashboard.vue'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(BootstrapVue)
Vue.use(IconsPlugin)
Vue.use(TooltipPlugin)

$(function(){
  const app = new Vue({
    render: h => h(App),
    el: '#dashboard_app'
  }).$mount()
})

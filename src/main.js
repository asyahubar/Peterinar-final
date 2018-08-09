import Vue from 'vue'
import VueRouter from 'vue-router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import locale from 'element-ui/lib/locale/lang/en'
import axios from 'axios'
import moment from 'moment'

import App from './App.vue'
import Login from './components/Login.vue'
import HomePage from './components/HomePage.vue'
import Edit from './components/Edit.vue'
import Create from './components/Create.vue'

Vue.use(VueRouter)
Vue.use(ElementUI, { locale })

Vue.config.productionTip = false
Vue.prototype.axios = axios
Vue.prototype.moment = moment

// defining routes
const routes = [
    { path: '/', component: Login, alias: '/login' },
    { path: '/all', component: HomePage },
    { path: '/edit/:id', component: Edit },
    { path: '/create', component: Create }
]

const router = new VueRouter({
    routes
})

new Vue({
  render: h => h(App),
    router
}).$mount('#app')

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import Vue from 'vue'
import App from '../components/app.vue'
import 'devextreme/dist/css/dx.common.css'
import 'devextreme/dist/css/dx.light.css'

import VueApollo from "vue-apollo";
import ApolloClient from 'apollo-client';
import { HttpLink } from "apollo-link-http";
import { InMemoryCache } from "apollo-cache-inmemory";

Vue.use(VueApollo);
Vue.config.devtools = true;

const getHeaders = () => {
  const headers = {};
    const token = window.localStorage.getItem('apollo-token');
    if (token) {
      headers.authorization = `Bearer ${token}`;
    }
    return headers;
}

const link = new HttpLink({
  uri: 'http://35.223.154.241:8080/v1/graphql',
  fetch,
  headers: getHeaders()
});

export const client = new ApolloClient({
  link: link,
  cache: new InMemoryCache({
    addTypename: true
  })
});

const apolloProvider = new VueApollo({
  defaultClient: client,
});


document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    //el: "#app",
    //components: { App },
    //provide: apolloProvider.provide(),
    //template: "<App/>",
    apolloProvider,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)
})


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

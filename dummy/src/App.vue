<template>
  <div id="app">
    <img src="./assets/logo.png">
    <el-button>Default</el-button>
    <el-button type="primary" icon="el-icon-edit" circle></el-button>
    <HelloWorld msg="Welcome to Your Vue.js App"/>
    <el-button @click="addData">More data</el-button>
    <Another v-if="another" :tableData="tableData" :loading="loading"></Another>
  </div>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'
import Another from './components/Another.vue'

export default {
  name: 'app',
  components: {
    HelloWorld,
    Another
  },
    data() {
      return {
          another: false,
          loading: true,
          tableData: []
      }
    },
    methods: {
        addData() {
          this.another = true;
          this.axios
              .get('https://api.myjson.com/bins/197hj4')
              .then((response) => {
                this.tableData = response.data;
                this.loading = false;
              });
        }
    }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

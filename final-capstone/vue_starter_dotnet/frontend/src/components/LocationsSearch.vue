<template>
    <div class="wrap">
   <div class="search">
      <input type="text" v-model="searchTerm" id="search-bar" class="searchTerm" v-on:keyup='filterLocations' placeholder="Please enter a location name or description...">
      <button type="submit" class="searchButton">🔍
        <i class="fa fa-search"></i>
     </button>
   </div>
</div>
</template>

<script>
export default {
    name: 'locations-search',
    data() {
      return {
        searchTerm: ''
      }
    },
    methods: {
        filterLocations(){
          //const query = document.getElementById('search-bar').value;
        
          console.log('search bar query ' + this.searchTerm);
          this.$emit('filter-locations', this.searchTerm);
        }
    }
}
</script>

<style>
@import url(https://fonts.googleapis.com/css?family=Open+Sans);

body{
  background: #f2f2f2;
  font-family: 'Open Sans', sans-serif;
}

.search {
  width: 100%;
  position: fixed;
  display: flex;
}

.searchTerm {
  width: 100%;
  border: 3px solid #aec6ce;
  border-right: none;
  padding: 5px;
  height: 20px;
  border-radius: 5px 0 0 5px;
  outline: none;
  color: #000000;
}

.searchTerm:focus{
  color: #aec6ce;
}

.searchButton {
  width: 40px;
  height: 36px;
  border: 1px solid #aec6ce;
  background: #aec6ce;
  text-align: center;
  color: #fff;
  border-radius: 0 5px 5px 0;
  cursor: pointer;
  font-size: 20px;
}

/*Resize the wrap to set search width*/
.wrap{
  width: 100%;
  position: fixed;
  top: 0%;
  left: 50%;
  transform: translate(-50%, -50%);
}
</style>
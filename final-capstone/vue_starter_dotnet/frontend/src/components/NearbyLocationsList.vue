<template>
    <div class="locations-list-results"> 
        <ul id="Locations-list">
            <li class="clearfix" id="AssetLocation" v-for="location in filteredLocations" :key="location.id">
                <div class="col-md-9 col-sm-9 col-xs-12 table-cell list_left">
                    <h2>{{location.name}}</h2>
                    <h3><a href="" id="">Location Name</a></h3>
                    <h4>{{location.description}}</h4>
                    <h4>{{location.distance}}</h4>
                </div>
            </li>
        </ul>
    </div>
</template>

<script>
export default {
  name: 'nearby-locations-list',
  data() {
    return {
      locations: [
        { id: 1, img: 'test.jpg', name: 'nameTest1', description: 'descriptionTest1', distance: 11 },
        { id: 2, img: 'test.jpg', name: 'nameTest2', description: 'descriptionTest2', distance: 22 },
        { id: 3, img: 'test.jpg', name: 'nameTest3', description: 'descriptionTest3', distance: 33 },
        { id: 4, img: 'test.jpg', name: 'nameTest4', description: 'descriptionTest4', distance: 44 },
        { id: 5, img: 'test.jpg', name: 'nameTest5', description: 'descriptionTest5', distance: 55 },
      ]
    }
  },
      computed: {
        filteredLocations() {
            const filter = new RegExp(this.search,'i');
            let arr1 = this.locations.filter(location => location.task.match(filter));
            let arr2 = this.locations.filter(location => location.category.match(filter));
            arr1.concat(arr2);
            return Array.from(new Set(arr1));
    }
  },
  methods: {

  }
}
</script>





<template>
  <div class="grid-container">
    <div class="portrait">
        <div class="portrait-top">
            <img src="@/assets/user.png">
        </div>
        <h3>{{user.usernname}}</h3>
        <button id="logout" v-on:click="logout()"><img src="@/assets/logout.png"/></button>
    </div>
    <div class="history-card">
        <div class="history-title"><h3>Location History</h3></div>
            <div class="history-content">
                <ul>
                    <li v-for="location in checkinHistory" v-bind:key="location">
                        {{location}}
                    </li>
                </ul>
            </div>
    </div>
    <div class="badges-card">
        <div class="badges-title"><h3>Badges</h3></div>
            <div class="badges-content">
                <ul>
                    <li v-for="badge in badges" v-bind:key="badge">
                        {{badge}}
                    </li>
                </ul>
            </div>
    </div>
  </div>
</template>

<script>
import auth from '@/auth';
export default {
    data () {
        return {
            checkinHistory: [],
            user: "",
            badges: []
        }
    },
    created() {
        this.fetchCheckinHistory(),
        this.fetchUsername()
    },
    methods: {
        fetchUsername(){
            fetch(`${process.env.VUE_APP_REMOTE_API}/values`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',         //remember to do
                    Authorization: 'Bearer ' + auth.getToken(),  //remember to do
                },
            })
            .then((response) => {
                if (response.ok) {
                    response.json().then(
                        (data) => {
                            this.user = data;
                            console.log(this.user);
                        }
                    )
                }
            })
            .catch((err) => console.error(err));
        },
        fetchCheckinHistory(){
            fetch(`${process.env.VUE_APP_REMOTE_API}/checkin`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',         //remember to do
                    Authorization: 'Bearer ' + auth.getToken(),  //remember to do
                },
            })
            .then((response) => {
                if (response.ok) {
                    response.json().then(
                        (data) => {
                            this.checkinHistory = data;
                            console.log(this.checkinHistory);
                            this.createBadges();
                        }
                    )
                }
            })
            .catch((err) => console.error(err));
        },
        createBadges(){
            let slicedCheckins = [];
            for(let i = 0; i < this.checkinHistory.length; i++){
                slicedCheckins.push(this.checkinHistory[i].slice(0, this.checkinHistory[i].length - 12));
            }
            let locationSet = new Set();
            slicedCheckins.forEach(item => locationSet.add(item));
            if (locationSet.size >= 1){
                this.badges.unshift("First Checkin Badge");
                // <img src="@/assets/shield.svg"/>
            }
            if (locationSet.size >= 5){
                this.badges.unshift("Amateur Tourist Badge. You've visited 5 unique locations. Keep walking for more badges!");
                // <img src="@/assets/shield2.svg"/>
            }
            if (locationSet.size >= 10){
                this.badges.unshift("Pro Tourist Badge. You've just gone pro with 10 unique locations. There's more badges so dont stop!");
                // <img src="@/assets/shield3.svg"/>
            }
            if (locationSet.size >= 16){
                this.badges.unshift("***Defender Of The Land*** You're the best of the best and have visited all our locations!");
                // <img src="@/assets/shield-trophy.svg"/>
            }
            console.log(slicedCheckins);
            console.log(locationSet);
            console.log(this.badges);
        },
        logout (){
            window.localStorage.removeItem('Authorization');
            this.$router.push('/');
        }
    }
}

</script>


<style scoped>
/* #region Content */
#logout {
    background-color: maroon;
    border: none;
    border-radius: 50px;
    cursor: pointer;
    position: fixed;
    top: 360px;
    right: 9px;
    width: 95px;
    height: 95px;
    -webkit-filter: drop-shadow(4px 4px 25px rgba(0,0,0,0.5));
}

#logout > img {
    width: 70%;
}

#logout:hover {
    opacity: 60%;
}

#logout:active {
    width: 90px;
    height: 90px;
    top: 362px;
    right: 11px;
  }

.grid-container {
    margin-top: 40px;
    display: grid;
    grid-column-gap: 2px;
    grid-row-gap: 2px;
    grid-template-columns: 1fr 2fr 2fr 1fr;
    grid-template-rows: 1fr 3fr;
    grid-template-areas: 
        '. portrait portrait .'
        '. history badges .';
}


.portrait {
    background-color: white;
    border-radius: 2px;
    grid-area: portrait;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
}

.portrait-top {
    width: 100%;
    background-image: url('../assets/clevedt.jpg');
    background-size: 100%;
    background-position:bottom;
    border-radius: 2px 2px 0px 0px;
}

.portrait-top > img {
    width: 20%;
}

.portrait h3 {
    margin: 0px;
    padding: 10px;
    background-image: url('../assets/map.png');
}

::-webkit-scrollbar {
    width: 0px;
    background: transparent; /* make scrollbar transparent */
}

.history-card {
    background-image: url('../assets/map.png');
    background-size:cover;
    border-radius: 2px;
    grid-area: history;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    overflow-y:scroll;
}

#filler {
    background-color: white;
}

.history-title {
    border-radius: 2px 2px 0px 0px;
    background-image: url('../assets/blue-bkgrd.jpg');
    padding: 2px 0px 2px 0px;
    margin: 0px;
}

.history-title h3 {
    margin: 6px;
    font-size: 26px;
    color: white;
    text-shadow:
		-1px -1px 0 #000,
		1px -1px 0 #000,
		-1px 1px 0 #000,
		1px 1px 0 #000;
}

.history-content {
    /* background: linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.733) 15%, rgb(255, 255, 255) 75%); */
    height: 100%;
    border-radius: 2px;
    color: black;
    font-size: 20px;
}

.history-content ul {
    list-style-type: none;
    padding-left: 0px;
    margin: 0px;
}

.history-content ul li {
    background: rgb(255, 255, 255, 0.8);
    line-height: 20px;
    vertical-align: center;
    height: 100%;
    padding-bottom: 5px;
    padding-top: 5px;
}

.history-content ul li:nth-child(odd) {
    background: rgb(235, 235, 235, 0.8);
    vertical-align: center;
    height: 100%;
    padding-bottom: 5px;
    padding-top: 5px;
}


.badges-card {
    background-image: url('../assets/trophybkgd.png');
    background-size:cover;
    border-radius: 2px;
    grid-area: badges;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    overflow-y:scroll;
}

.badges-title {
    border-radius: 2px 2px 0px 0px;
    background-image: url('../assets/green-bkgrd.jpg');
    background-position: center;
    padding: 2px 0px 2px 0px;
    margin: 0px;
}

.badges-title h3 {
    margin: 6px;
    font-size: 26px;
    color: white;
    text-shadow:
		-1px -1px 0 #000,
		1px -1px 0 #000,
		-1px 1px 0 #000,
		1px 1px 0 #000;
}

.badges-content {
    height: 100%;
    border-radius: 2px;
    color: black;
    font-size:inherit;
}

.badges-content ul {
    list-style-type: none;
    padding-left: 0px;
    margin: 0px;
}

.badges-content ul li {
    background: rgb(255, 255, 255, 0.8);
    height: 60px;
    vertical-align: middle;
    padding-right: 80px;
    padding-top: 15px;
    padding-bottom: 15px;
}

.badges-content ul li:nth-child(odd) {
    background: rgb(235, 235, 235, 0.8);
    vertical-align: center;
}

.badges-content ul li:nth-last-child(1) {
  background-image: url('../assets/shield-2.svg');
  background-repeat: no-repeat;
  background-position-x:right;
  background-size:contain;
  height: 60px;
  vertical-align: center;
}

.badges-content ul li:nth-last-child(2) {
  background-image: url('../assets/shield-2.svg');
  background-repeat: no-repeat;
  background-position-x:right;
  background-size:contain;
  height: 60px;
  vertical-align: center;
}

.badges-content ul li:nth-last-child(3) {
  background-image: url('../assets/shield-2.svg');
  background-repeat: no-repeat;
  background-position-x:right;
  background-size:contain;
  height: 60px;
  vertical-align: center;
}

.badges-content ul li:nth-last-child(4) {
  background-image: url('../assets/shield-trophy.svg');
  background-repeat: no-repeat;
  background-position-x:right;
  background-size:contain;
  height: 60px;
  vertical-align: center;
}


/* #endregion Content */
</style>


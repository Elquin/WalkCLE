<template>
  <div class="grid-container">
    <div class="portrait">
        <div class="portrait-top">
            <img src="@/assets/user.png">
        </div>
        <h3>{{user.usernname}}</h3>
        <button v-on:click="logout()">Logout</button>
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
                    <li>Badge 1</li>
                    <li>Badge 2</li>
                    <li>Badge 3</li>
                    <li>Badge 4</li>
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
            user: ""
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
                        }
                    )
                }
            })
            .catch((err) => console.error(err));
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
    margin: 10px;
}

::-webkit-scrollbar {
    width: 0px;
    background: transparent; /* make scrollbar transparent */
}

.history-card {
    background-image: url('../assets/map.png');
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
    background: linear-gradient(to top, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.733) 15%, rgb(255, 255, 255) 75%);
    padding: 2px 0px 2px 0px;
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
    line-height: 20px;
    vertical-align: center;
    height: 100%;
    padding-bottom: 5px;
    padding-top: 5px;
}


.badges-card {
    background-image: url('../assets/trophybkgd.png');
    border-radius: 2px;
    grid-area: badges;
    text-align: center;
    box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
    overflow-y:scroll;
}

.badges-title {
    border-radius: 2px 2px 0px 0px;
    background: linear-gradient(to top, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0.733) 15%, rgb(255, 255, 255) 75%);
    padding: 2px 0px 2px 0px;
}

.badges-content {
    height: 100%;
    border-radius: 2px;
    color: black;
    font-size: 20px;
}

.badges-content ul {
    list-style-type: none;
    padding-left: 0px;
}

.badges-content ul li {
    background: rgb(255, 255, 255, 0.8);
    line-height: 20px;
    vertical-align: center;
    height: 100%;
    padding-bottom: 5px;
    padding-top: 5px;
}

.badges-content ul li:nth-child(odd) {
    background: rgb(235, 235, 235, 0.8);
    line-height: 20px;
    vertical-align: center;
    height: 100%;
    padding-bottom: 5px;
    padding-top: 5px;
}


/* #endregion Content */
</style>


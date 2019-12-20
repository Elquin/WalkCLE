<template>
  <div id="login" class="text-center">
    <form class="form-signin" @submit.prevent="login">
      <div id="icon"><img src="@/assets/user.png"/></div>
      <h1 class="h3 mb-3 font-weight-normal">Please Sign In</h1>
      <div class="alert alert-danger" role="alert" v-if="invalidCredentials">
        Invalid username and password!
      </div>
      <div class="alert alert-success" role="alert" v-if="this.$route.query.registration">
        Thank you for registering, please sign in.
      </div>
      <div id="username-block">
        <label for="username" class="sr-only"></label>
        <input
          type="text"
          id="username"
          class="form-control"
          placeholder="Username"
          v-model="user.username"
          required
          autofocus
        />
      </div>
      <div id="password-block">
        <label for="password" class="sr-only"></label>
        <input
          type="password"
          id="password"
          class="form-control"
          placeholder="Password"
          v-model="user.password"
          required
        />
      </div>
      <button id="submit-button" type="submit">Sign in</button>
      <router-link class="register-link" :to="{ name: 'register' }">Need an account?</router-link>
    </form>
  </div>
</template>

<script>
import auth from '../auth';

export default {
  name: 'login',
  components: {},
  data() {
    return {
      user: {
        username: '',
        password: '',
      },
      invalidCredentials: false,
    };
  },
  methods: {
    login() {
      fetch(`${process.env.VUE_APP_REMOTE_API}/account/login`, {
        method: 'POST',
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(this.user),
      })
        .then((response) => {
          if (response.ok) {
            return response.text();
          } else {
            this.invalidCredentials = true;
          }
        })
        .then((token) => {
          if (token != undefined) {
            if (token.includes('"')) {
              token = token.replace(/"/g, '');
            }
            auth.saveToken(token);
            this.$router.push('/profile');
            // this.$router.go(-1); // after logging in, takes you to the previous page
          }
        })
        .catch((err) => console.error(err));
    },
  },
};
</script>

<style scoped>

    #login {
      display: flex;
      align-items: center;
      flex-direction: column;
      background-color: white;
      width:fit-content;
      padding: 25px;
      display: flex;
      box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
      border-radius: 3px;
      margin: 100px auto 0px auto;
      
    }

    #icon img {
      width: 80px;
      margin-top: -40px;
      -webkit-filter: drop-shadow(5px 5px 6px rgba(0,0,0,0.5));
    }

    form {
      text-align: center;
    }

    .h3 {
      margin-top: 0px;
    }

    #username-block {
      text-align: center;
    }

    #username-block input::placeholder {
      color: black;
      text-align: center;
    }

    input[type=text] {
      background-color: rgb(206, 206, 206);
      color: black;
      border: none;
      padding: 10px;
      padding-left: 15px;
      padding-right: 15px;
      border-radius: 2px;
      text-align: center;
    }

    #password-block {
      text-align: center;
      margin-top: 5px;
    }

    #password-block input::placeholder {
      color: black;
      text-align: center;
    }

    input[type=password] {
      background-color: rgb(206, 206, 206);
      color: black;
      border: none;
      padding: 10px;
      padding-left: 15px;
      padding-right: 15px;
      border-radius: 2px;
      text-align: center;
    }

    .register-link {
      display: block;
      text-align: center;
      margin-top: 15px;
    }

    #submit-button button {
      display: block;
    }

    button[type=submit] {
      display: inline-block;
      width: 98%;
      margin-top: 6px;
      padding: 10px 25px;
      font-size: 16px;
      cursor: pointer;
      text-align: center;
      text-decoration: none;
      outline: none;
      color: #fff;
      background-color: rgb(57, 135, 236);
      border: none;
      border-radius: 2px;
      box-shadow: 2px 2px rgb(13, 61, 122);
    }

    .alert {
      color: red;
      font-style: italic;
    }

    .alert-success {
      color: green;
      font-style: italic;
    }

    a {}

    a:visited {  text-decoration: none;}

</style>

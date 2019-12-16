<template>
  <div id="login" class="text-center">
    <form class="form-signin" @submit.prevent="login">
      <h1 class="h3 mb-3 font-weight-normal">Please Sign In</h1>
      <div class="alert alert-danger" role="alert" v-if="invalidCredentials">
        Invalid username and password!
      </div>
      <div class="alert alert-success" role="alert" v-if="this.$route.query.registration">
        Thank you for registering, please sign in.
      </div>
      <div id="username-block">
        <label for="username" class="sr-only">Username </label>
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
        <label for="password" class="sr-only">Password </label>
        <input
          type="password"
          id="password"
          class="form-control"
          placeholder="Password"
          v-model="user.password"
          required
        />
      </div>
      <router-link class="register-link" :to="{ name: 'register' }">Need an account?</router-link>
      <button id="submit-button" type="submit">Sign in</button>
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
            //this.$router.push('/');
            this.$router.go(-1); // after logging in, takes you to the previous page
          }
        })
        .catch((err) => console.error(err));
    },
  },
};
</script>

<style>

    #login {
      display: flex;
      align-items: center;
      flex-direction: column;
      background-color: white;
      width:fit-content;
      padding: 25px;
      display: flex;
      box-shadow: 7px 7px 15px 0px  rgba(0,0,0,0.3);
      border-radius: 10px;
      margin: 180px auto 0px auto;
      
    }

    form {
      text-align: center;
    }

    .h3 {
      margin-top: 0px;
    }

    #username-block {
      text-align: right;
    }

    #password-block {
      text-align: right;
    }

    .register-link {
      display: block;
      text-align: center;
    }

    #submit-button button {
      display: block;
      text-align: center;
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

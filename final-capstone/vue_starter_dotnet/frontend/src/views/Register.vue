<template>
  <div id="register" class="text-center">
    <form class="form-register" @submit.prevent="register">
      <div id="icon"><img src="@/assets/pencil.svg"/></div>
      <h1 class="h3 mb-3 font-weight-normal">Create Account</h1>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">
        There were problems registering this user.
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
        <div id="password-input">
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
        <div id="password-confirm">
          <label for="confirmPassword" class="sr-only"></label>
          <input
            type="password"
            id="confirmPassword"
            class="form-control"
            placeholder="Confirm Password"
            v-model="user.confirmPassword"
            required
          />
        </div>
      </div>
      <button id="create-button" class="btn btn-lg btn-primary btn-block" type="submit">
        Create Account
      </button>
      <router-link class="register-link" :to="{ name: 'login' }">
        Have an account?
      </router-link>
    </form>
  </div>
</template>

<script>
export default {
  name: 'register',
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        role: 'user',
      },
      registrationErrors: false,
    };
  },
  methods: {
    register() {
      fetch(`${process.env.VUE_APP_REMOTE_API}/account/register`, {
        method: 'POST',
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(this.user),
      })
        .then((response) => {
          if (response.ok) {
            this.$router.push({ path: '/login', query: { registration: 'success' } });
          } else {
            this.registrationErrors = true;
          }
        })

        .then((err) => console.error(err));
    },
  },
};
</script>

<style scoped>

    #register {
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
      text-align: right;
    }

    #username-block input::placeholder {
      color: black;
      text-align: center;
    }

    #username-block .form-control {
      width: 86%;
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
      text-align: right;
      margin-top: 5px;
    }

    #password-block input::placeholder {
      color: black;
      text-align: center;
    }

    #password-block .form-control {
      width: 86%;
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

    #password-confirm {
      text-align: center;
      margin-top: 5px;
    }

    .register-link {
      display: block;
      text-align: center;
      margin-top: 15px;
    }

    #create-button button {
      display: block;
      text-align: center;
    }

    #create-button button {
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
    }

    .alert-success {
      color: green;
      font-style: italic;
    }

    a {}

    a:visited {  text-decoration: none;}
</style>

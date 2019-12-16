<template>
  <div id="register" class="text-center">
    <form class="form-register" @submit.prevent="register">
      <h1 class="h3 mb-3 font-weight-normal">Create Account</h1>
      <div class="alert alert-danger" role="alert" v-if="registrationErrors">
        There were problems registering this user.
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
        <div id="password-input">
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
        <div id="password-confirm">
          <label for="confirmPassword" class="sr-only">Password </label>
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
      <router-link class="register-link" :to="{ name: 'login' }">
        Have an account?
      </router-link>
      <button id="create-button" class="btn btn-lg btn-primary btn-block" type="submit">
        Create Account
      </button>
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

<style>

    #register {
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

    #password-input {
      display: inline;
    }

    #password-confirm {
      display: block;
    }

    .register-link {
      display: block;
      text-align: center;
    }

    #create-button button {
      display: block;
      text-align: center;
    }

    .alert {
      color: red;
    }

    a {}

    a:visited {  text-decoration: none;}
</style>

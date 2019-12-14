<template>
    <v-form
        ref="form"
        v-model="valid"
        :lazy-validation="lazy"
    >
        <MyTextForm
            v-model="email.value"
            label="メールアドレス"
            :rules="email.rules"
            :counter="100"
            >
        </MyTextForm>
        <MyPasswordForm
            v-model="password.value"
            label="パスワード"
            :rules="password.rules"
        >
        </MyPasswordForm>
        <v-btn
            :disabled="!valid"
            color="success"
            class="mr-3"
            @click="login"
        >
            ログイン
        </v-btn>
    </v-form>
</template>
<script>
import MyTextForm from '../modules/textInputForm'
import MyPasswordForm from '../modules/passwordInputForm'
export default {
    data: () => ({
        valid: true,
        lazy: false,
        email: {
            value: '',
            rules: [
                v => !!v || 'メールアドレスが入力されていません',
                v => /.+@.+\..+/.test(v) || 'メールアドレスは正しい入力形式で入力してください'
            ],
            label: 'メールアドレス'
        },
        password: {
            value: '',
            rules: [
                v => !!v || 'パスワードが入力されていません',
            ],
            label: 'パスワード'
        }
    }),
    methods:{
        login() {
            const payload = {
                email: this.email.value,
                password: this.password.value,
                router: this.$router
            }
            this.$store.dispatch('auth/login', payload, {root: true})
        }
    },
    components: {
        MyTextForm,
        MyPasswordForm
    }
}
</script>
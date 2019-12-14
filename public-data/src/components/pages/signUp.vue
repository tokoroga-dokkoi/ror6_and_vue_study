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
        <MyTextForm
            v-model="userName.value"
            label="ユーザ名"
            :rules="userName.rules"
        >
        </MyTextForm>
        <MyPasswordField
            v-model="password.value"
            label="パスワード"
            :rules="password.rules"
        >
        </MyPasswordField>
        <MyPasswordField
            v-model="passwordConfirmation.value"
            label="パスワード(確認用)"
            :rules="[passwordConfirmationRules]"
        >
        </MyPasswordField>
        <v-btn
            :disabled="!valid"
            color="success"
            class="mr-3"
            @click="signUp()"
        >
            登録
        </v-btn>

    </v-form>
</template>

<script>
import MyTextForm from '../modules/textInputForm'
import MyPasswordField from '../modules/passwordInputForm'
import request from '../../utils/request'

export default {
    data: () => ({
        valid: true,
        lazy: false,
        email: {
            value: '',
            rules: [
                v => !!v || 'パスワードが入力されていません',
                v => /.+@.+\..+/.test(v) || 'メールアドレスは正しい入力形式で入力してください'
            ]
        },
        userName: {
            value: '',
            rules: [
                v => !!v || 'ユーザ名が入力されていません',
            ]
        },
        password: {
            value: '',
            rules: [
                v => !!v || 'パスワードが入力されていません',
                v => (v && v.length >= 6) || 'パスワードは６文字以上で入力してください'
            ]
        },
        passwordConfirmation: {
            value: ''
        }
    }),
    computed: {
        passwordConfirmationRules() {
            return () => (this.password.value === this.passwordConfirmation.value) || 'パスワードが一致しません'
        }
    },
    methods: {
        signUp(){
            if(this.$refs.form.validate()){
                const parameter = {
                    email:                 this.email.value,
                    name:                  this.userName.value,
                    password:              this.password.value,
                    password_confirmation: this.passwordConfirmation.value
                }
                const options = {
                    params: parameter,
                    auth: false,
                    header: {}
                }
                const url     = process.env.VUE_APP_API_URL_BASE ? 
                                process.env.VUE_APP_API_URL_BASE + '/auth' :
                                '/api/v1/auth'
                request.post(url, options).then( (response) => {
                    console.log(response)
                    this.$store.commit('message/setMessage', {'content': 'ユーザ登録が完了しました。ログインしてください。'}, {root: true})
                    this.$router.push('/login')
                }).catch( (error) => {
                    console.error(error)
                    this.$store.commit('message/setMessage', {'content': 'ユーザ登録に失敗しました', 'type': 'error'}, {root: true})
                })
            }
        }
    },
    components: {
        MyTextForm,
        MyPasswordField,
    }
}
</script>
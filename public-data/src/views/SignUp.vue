<template>
    <v-container fruid id="container-full">
        <div class="title px2 mt-3">
            ユーザ登録
        </div>
        <MyAlert></MyAlert>
        <MySignUpForm></MySignUpForm>
    </v-container>
</template>
<script>
import MySignUpForm from '../components/pages/signUp'
import MyAlert from '../components/common/alert'
export default {
    name: 'signup',
    components: {
        MySignUpForm,
        MyAlert
    }
}
</script>
<template>
    <v-container fruid id="container-full">
        <div class="title px2 mt-3">
            ログイン
        </div>
        <MyAlert></MyAlert>
        <MyLoginForm></MyLoginForm>
    </v-container>
</template>
<script>
import MyLoginForm from '../components/pages/login.vue'
import MyAlert from '../components/common/alert'
export default {
    name: 'login',
    components: {
        MyLoginForm,
        MyAlert
    }
}
</script>
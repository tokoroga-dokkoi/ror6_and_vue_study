<template>
    <v-container fruid id="container-full">
        <MyAlert></MyAlert>
        <UserMyPage></UserMyPage>
    </v-container>
</template>

<script>
import MyAlert from '../components/common/alert'
import UserMyPage from '../components/pages/mypage'
export default {
    components: {
        UserMyPage,
        MyAlert
    }
}
</script>
<style lang="stylus" scoped>
#container-full{
    max-width: 100%;
}
</style>
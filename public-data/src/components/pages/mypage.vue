<template>
    <v-row>
        <v-col cols="3">
            <UserNavigationMenu></UserNavigationMenu>
        </v-col>
        <v-col cols="9">
            <v-row>
                <PostForm></PostForm>
            </v-row>
            <v-row>
                <PostList></PostList>
            </v-row>
        </v-col>
    </v-row>
</template>

<script>
import UserNavigationMenu from '../modules/userNavigationMenu'
import PostForm from '../modules/postForm'
import PostList from '../modules/postList'
export default {
    components: {
        UserNavigationMenu,
        PostForm,
        PostList
    }
}
</script>

<template>
    <div>
        PostList
    </div>
</template>
<script>
import requests from '../../utils/request'
export default {
    data: () => ({
        timelines: [],
        page: 1,
    }),
    created() {
        const options = {
            auth: true
        }
        const url     = process.env.VUE_APP_API_URL_BASE ?
                        process.env.VUE_APP_API_URL_BASE + '/posts' :
                        '/api/v1/posts'
        requests.get(url, options).then( (response) => {
            console.log(response)
        }).catch( (error) => {
            console.error(error)
        })
    }
}
</script>
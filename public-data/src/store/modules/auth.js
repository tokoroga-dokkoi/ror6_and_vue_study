import request from '../../utils/request'
export default {
    namespaced: true,
    state: {
        loggedIn: false
    },
    mutations: {
        login(state, response_header) {
            localStorage.setItem('Token', response_header['access-token'])
            localStorage.setItem('client', response_header['client'])
            localStorage.setItem('expiry', response_header['expiry'])
            localStorage.setItem('uid', response_header['uid'])
            localStorage.setItem('token_type', response_header['token_type'])
            state.loggedIn = true;
        },
        logout(state) {
            localStorage.removeItem('Token')
            localStorage.removeItem('client')
            localStorage.removeItem('expiry')
            localStorage.removeItem('uid')
            localStorage.removeItem('token_type')
            state.loggedIn = false;
        }
    },

    actions: {
        login( { commit }, payload ) {
            const options = {
                params: {
                    email: payload.email,
                    password: payload.password
                }
            }
            const url     = process.env.VUE_APP_API_URL_BASE ? 
                            process.env.VUE_APP_API_URL_BASE + '/auth/sign_in' :
                            '/api/v1/auth/sign_in'
            // request
            request.post(url, options).then( (response) => {
                // TokenをHeaderにセットする
                commit('login', response.headers)
                // messageをセットする
                commit('message/setMessage',
                        {'content': 'ログインしました'},
                        {root: true})
                //router
                payload.router.push('/home')
            }).catch( (error) => {
                commit('message/setMessage',
                        {'content': 'ログインに失敗しました','type':'error'},
                        {root: true})
                console.log(error)
            })
        },

        logout( { commit }, payload ) {
            const options = {
                auth: true
            }
            const url     = process.env.VUE_APP_API_URL_BASE ? 
                            process.env.VUE_APP_API_URL_BASE + '/auth/sign_out' :
                            '/api/v1/auth/sign_out'
            // logout
            request.delete(url, options).then( (response) => {
                console.log(response)
                commit('logout')
                // router
                payload.router.push('/')
            }).catch( (error) => {
                console.error(error)
                commit('auth/setMessage',
                        {'content': 'ログアウトに失敗しました', 'type': 'error'},
                        {root: true}
                )
            })
        }
    }
}
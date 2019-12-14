import axios from 'axios'

export default {
    request(method, url, options) {
        let promise = null;
        let params  = {};
        let headers = {};

        if(options.params) {
            params = options.params
        }

        if(options.header) {
            headers = options.header
        }

        if(options.auth) {
            const token         = localStorage.getItem('Token')
            const client        = localStorage.getItem('client')
            const uid           = localStorage.getItem('uid')
            const expiry        = localStorage.getItem('expiry')
            const token_type    = localStorage.getItem('token_type')
            const auth_headers  = {
                'access-token': token,
                'client': client,
                'uid': uid,
                'expiry': expiry,
                'token_type': token_type
            }
            headers = Object.assign(headers, auth_headers)
        }

        promise = axios({
            method: method,
            url: url,
            data: params,
            headers: headers
        })

        promise.catch( () => {
            return console.log(promise)
        })

        return promise;
    },

    get(url, options){
        return this.request('get', url, options)
    },
    post(url, options){
        return this.request('post', url, options)
    },
    patch(url, options){
        return this.request('patch', url, options)
    },
    delete(url, options){
        return this.request('delete', url, options)
    }
}
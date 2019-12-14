export default {
    namespaced: true,
    state: {
        content: '',
        type: 'success'
    },
    getters: {
        content(state){
            return state.content
        },
        type(state){
            return state.type
        }
    },
    mutations: {
        setMessage(state, {content, type}){
            state.content = content
            state.type    = type || 'success'
        },
        clearMessage(state) {
            state.content = ''
            state.type    = 'success'
        }
    },
}
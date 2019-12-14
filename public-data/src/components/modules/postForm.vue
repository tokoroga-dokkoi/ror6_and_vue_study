<template>
    <v-card
        class="mr-auto post-form"
        color="#f5f5f5"
        width="90%"
    >
        <v-card-title>
            <v-icon
                large
                left
                color="blue darken-2"
            >
                mdi-message-processing
            </v-icon>
            <span class="title blue--text text-lighten-1 font-weight-bold">記録を投稿</span>
        </v-card-title>
        <v-card-text class="headline">
            <v-form
                ref="form"
                v-model="valid"
                :lazy-validation="lazy"
            >
                <MyTextarea
                    v-model="content.value"
                    label="メモ"
                    :rules="content.rules"
                    :counter="100"
                    :style="style"
                >
                </MyTextarea>
                <MyFileUpload
                    v-model="file.value"
                    :label="'画像ファイル'"
                    :icon="'mdi-camera'"
                    @upload="fileUpload($event)"
                >
                </MyFileUpload>
            </v-form>
            <div v-show="resizedImg" class="resize-img__preview">
                <v-icon large color="blue-grey darken-2" @click="clearUploadedImage">
                    mdi-close-circle
                </v-icon>
            </div>
            <canvas ref="canvas" class="resize-img__preview__canvas" />
        </v-card-text>
        <v-card-actions>
            <v-row align="center" justify="end">
                <v-icon color="blue" class="darken-2 mr-3">mdi-map-marker</v-icon>
                <v-btn rounded color="blue" class="darken-2 mr-2" dark @click="registerPost">記録</v-btn>
            </v-row>
        </v-card-actions>
    </v-card>
</template>
<script>
import MyTextarea from '../modules/textareaForm'
import MyFileUpload from '../modules/fileInput'
import request from '../../utils/request'
export default {
    data: () => ({
        valid: true,
        lazy: false,
        content: {
            value: '',
            rules: [
                v => (v || '').length <=100 || '100文字以内で入力してください' 
            ]
        },
        file: {
            value: [],
            uploaded: '',
            rules:[
                v => !v || v.size < 200000 || 'ファイルサイズの上限は2MBまでです'
            ]
        },
        style: {
            'color': '#1E00A7'
        },
        resizedImg: ''
    }),
    components: {
        MyTextarea,
        MyFileUpload
    },
    methods: {
        registerPost() {
            console.log(this.resizedImg)
            //データ整形
            const params  = {
                post: {
                    content: this.content.value,
                    image: this.resizedImg
                }
            }
            const options = {
                params: params,
                header: {},
                auth  : true
            }
            const url    = process.env.VUE_APP_API_URL_BASE?
                           process.env.VUE_APP_API_URL_BASE + '/posts' :
                           '/api/v1/posts'
            console.log(url)
            request.post(url, options).then( (response) => {
                console.log(response)
                this.$store.commit('message/setMessage', {'content': '投稿が完了しました'}, { root: true })
            })
        },
        fileUpload(eventArgs) {
            this.file.uploaded = eventArgs
            let reader         = new FileReader()
            // fileをpreview
            reader.onload = (e) => {
                // base64にエンコード
                this.generateImgUrl(e.target.result)
            }
            reader.readAsDataURL(eventArgs)
        },
        generateImgUrl(file) {
            /*
            *
            * canvasに画像を描画
            * 
            */ 
            // Image API呼び出し
            const image       = new Image()
            image.crossOrigin = 'Anonymous'

            image.onload = () => {
                //画像のリサイズ
                const resizedBase64 = this.makeResizeImg(image)
                this.resizedImg     = resizedBase64
            }
            image.src          = file
        },
        makeResizeImg(image){
            const canvas   = this.$refs.canvas
            const ctx      = canvas.getContext('2d')
            //画像の最大値
            const MAX_SIZE = 500
            //最大値よりも小さい場合
            if(image.width < MAX_SIZE && image.height < MAX_SIZE) {
                [canvas.width, canvas.height] = [image.width, image.height]
                ctx.drawImage(image, 0, 0)
                return canvas.toDataURL('image/jpeg')
            }
            //画像のリサイズが必要な場合
            let resizedWidth  = 0
            let resizedHeight = 0

            if(image.width > image.height) {
                resizedWidth  = MAX_SIZE
                resizedHeight = (image.height * MAX_SIZE) / image.width
            } else{
                resizedHeight = MAX_SIZE
                resizedWidth  = (image.width * MAX_SIZE) / image.height
            }
            [canvas.width, canvas.height] = [resizedWidth, resizedHeight]

            //リサイズ
            ctx.drawImage(image, 0, 0, image.width, image.height, 0, 0, resizedWidth, resizedHeight)
            return canvas.toDataURL('image/jpeg')
        },
        clearUploadedImage() {
            this.resizedImg = ''
            if(!this.file.value.length && this.file.value[0] !== '') {
                this.file.value = []
            }
        }

    }
}
</script>

<template>
    <v-container fruid id="container-full">
        <v-layout>
            <v-flex xs12>
                <v-img
                    :src="require('../assets/index-prod.jpg')"
                    gradient="to top right, rgba(105,105,105,.7), rgba(169, 169, 169, .4)"
                >
                    <v-row align="top" class="lightbox white--text pa-2 fill-height">
                        <v-col>
                            <div class="title px-2">
                                発見があればランニングはもっと楽しくなる
                            </div>
                            <div class="subtitle-1">
                                ランニンング中に見つけたお店・風景のシェアアプリ
                            </div>
                        </v-col>
                    </v-row>
                </v-img>
            </v-flex>
        </v-layout>
        <v-layout mt-5 px-3 py-3 justify-center id="about">
            <v-flex xs12>
                <span class="display-2 font-weight-bold">About</span>
            </v-flex>
        </v-layout>
        <v-layout mt-3 px-5 class="text-xs-center" row wrap id="about">
            <v-flex lg4 xs12 >
                <v-avatar size="250" color="grey lighten-4">
                    <v-img
                        :src="require('../assets/app-shoze.svg')"
                    >
                    </v-img>
                </v-avatar>
                <div class="my-2">
                    <p class="font-weight-bold">ランニンング中に見つけた場所・風景をシェア</p>
                </div>
            </v-flex>
            <v-flex lg4 xs12>
                <v-avatar size="250" color="grey lighten-4">
                    <v-img
                        :src="require('../assets/app-map.svg')"
                    >
                    </v-img>
                </v-avatar>
                <div class="my-2">
                    <p class="font-weight-bold">たまたま見つけたお店の場所を記録しておく</p>
                </div>
            </v-flex>
            <v-flex lg4 xs12>
                <v-avatar size="250" color="gray lighten-4">
                    <v-img
                        :src="require('../assets/app-sns.svg')">
                    </v-img>
                </v-avatar>
                <div class="my-2">
                    <p class="font-weight-bold">疑問や見つけたお店の情報に関して共有</p>
                </div>
            </v-flex>
        </v-layout>
    </v-container>
</template>
<style lang="scss" scoped>
#about{
    text-align: center;
}
</style>
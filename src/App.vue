<template>
  <!-- ページコンポーネントをここにインポートして差し替える -->
  <RouterView v-if="useRouter" />
  <MainView v-else />
</template>

<script setup>
// シングルページの場合: views/ 配下のコンポーネントを直接インポート
// import MainView from './views/MainView.vue'

// Vue Router を使う場合: router/index.js を作成して createRouter を設定
// const useRouter = true
</script>

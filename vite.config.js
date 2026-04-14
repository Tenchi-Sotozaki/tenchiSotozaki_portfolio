import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// GitHub Pages にデプロイする場合は base を '/[REPO_NAME]/' に変更
// Netlify / 独自ドメインの場合は '/' のまま
export default defineConfig({
  base: '/',
  plugins: [vue()],
  server: {
    port: 3000
  }
})

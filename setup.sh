#!/bin/bash
# =============================================================
# setup.sh — Vue 3 + Vite プロジェクト自動セットアップスクリプト
# 使い方: bash setup.sh
# =============================================================

set -e

# --- 設定 ---
read -p "プロジェクト名を入力してください (例: my-portfolio): " PROJECT_NAME
read -p "ローディング表示テキストを入力してください (例: MY STUDIO): " LOADING_TEXT
read -p "サイトタイトルを入力してください (例: My Studio | Portfolio): " SITE_TITLE
read -p "サイト説明文を入力してください: " SITE_DESC

echo ""
echo "▶ プロジェクト「$PROJECT_NAME」を作成します..."

# --- ディレクトリ作成 ---
mkdir -p "$PROJECT_NAME/src/components"
mkdir -p "$PROJECT_NAME/src/views"
mkdir -p "$PROJECT_NAME/public/assets"

cd "$PROJECT_NAME"

# --- package.json ---
cat > package.json << EOF
{
  "name": "$PROJECT_NAME",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "deploy": "gh-pages -d dist"
  },
  "dependencies": {
    "vue": "^3.4.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^5.0.0",
    "gh-pages": "^6.3.0",
    "vite": "^5.0.0"
  }
}
EOF

# --- vite.config.js ---
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  base: '/',
  plugins: [vue()],
  server: {
    port: 3000
  }
})
EOF

# --- .gitignore ---
cat > .gitignore << 'EOF'
node_modules/
dist/
.env.local
.env.*.local
*.log
npm-debug.log*
.vscode/
.idea/
.DS_Store
Thumbs.db
EOF

# --- .env.example ---
cat > .env.example << 'EOF'
VITE_SITE_URL=https://[YOUR_DOMAIN]
# VITE_FORM_ENDPOINT=[YOUR_FORM_ENDPOINT]
# VITE_GA_MEASUREMENT_ID=[YOUR_GA_MEASUREMENT_ID]
# VITE_API_KEY=[YOUR_API_KEY]
EOF

cp .env.example .env.local

# --- index.html ---
cat > index.html << EOF
<!doctype html>
<html lang="ja">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>$SITE_TITLE</title>
    <meta name="description" content="$SITE_DESC" />
    <meta name="theme-color" content="#ffffff" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet" />
    <style>
      *, *::before, *::after { box-sizing: border-box; }
      html, body { margin: 0; padding: 0; width: 100%; height: 100%; }
      body { font-family: 'Helvetica Neue', Arial, sans-serif; background-color: #f7f4ef; color: #0c0c0c; line-height: 1.6; -webkit-font-smoothing: antialiased; overflow-x: hidden; }
      ::selection { background: rgba(0, 0, 0, 0.12); }
      #app { min-height: 100vh; }
      .app-loading { position: fixed; inset: 0; display: flex; align-items: center; justify-content: center; background: #f7f4ef; z-index: 9999; font-family: 'Playfair Display', serif; letter-spacing: 0.05em; font-size: 14px; color: #0c0c0c; opacity: 1; transition: opacity 0.6s ease; }
      .app-loading.is-hidden { opacity: 0; pointer-events: none; }
    </style>
  </head>
  <body>
    <div class="app-loading" id="app-loading">$LOADING_TEXT</div>
    <div id="app"></div>
    <script type="module" src="/src/main.js"></script>
    <script>
      window.addEventListener('load', () => {
        const loader = document.getElementById('app-loading');
        if (loader) { loader.classList.add('is-hidden'); setTimeout(() => loader.remove(), 800); }
      });
    </script>
  </body>
</html>
EOF

# --- src/main.js ---
cat > src/main.js << 'EOF'
import { createApp } from 'vue'
import App from './App.vue'
import './style.css'

createApp(App).mount('#app')
EOF

# --- src/style.css ---
touch src/style.css

# --- src/App.vue ---
cat > src/App.vue << 'EOF'
<template>
  <MainView />
</template>

<script setup>
import MainView from './views/MainView.vue'
</script>
EOF

# --- src/views/MainView.vue ---
cat > src/views/MainView.vue << EOF
<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
const isScrolled = ref(false)
onMounted(() => window.addEventListener('scroll', () => { isScrolled.value = window.scrollY > 50 }, { passive: true }))
onUnmounted(() => window.removeEventListener('scroll', () => {}))
</script>

<template>
  <div class="page">
    <header :class="['header', { 'is-scrolled': isScrolled }]">
      <div class="header-inner">
        <div class="logo">$PROJECT_NAME</div>
      </div>
    </header>
    <main style="padding-top: 80px;">
      <p style="text-align:center; padding: 80px 24px;">ここにコンテンツを追加してください。</p>
    </main>
    <footer class="footer">
      <p>&copy; \$(date +%Y) $PROJECT_NAME. All Rights Reserved.</p>
    </footer>
  </div>
</template>

<style scoped>
.page { --color-paper: #f7f4ef; --color-ink: #0c0c0c; --color-border: rgba(12,12,12,0.12); --font-sans: 'Helvetica Neue', Arial, sans-serif; --font-en: 'Playfair Display', serif; font-family: var(--font-sans); color: var(--color-ink); min-height: 100vh; }
.header { position: fixed; top: 0; left: 0; width: 100%; z-index: 50; transition: all 0.35s ease; padding: 20px 0; }
.header.is-scrolled { background-color: rgba(247,244,239,0.85); backdrop-filter: blur(14px); box-shadow: 0 10px 40px rgba(0,0,0,0.08); padding: 14px 0; border-bottom: 1px solid var(--color-border); }
.header-inner { display: flex; justify-content: space-between; align-items: center; max-width: 1440px; margin: 0 auto; padding: 0 40px; }
.logo { font-family: var(--font-en); font-size: 1.65rem; font-weight: 600; letter-spacing: -0.01em; }
.footer { text-align: center; padding: 40px 24px; font-size: 0.8rem; color: rgba(12,12,12,0.62); letter-spacing: 0.08em; }
</style>
EOF

# --- npm install ---
echo ""
echo "▶ npm install を実行します..."
npm install

echo ""
echo "✅ セットアップ完了！"
echo ""
echo "次のコマンドで開発を開始できます:"
echo "  cd $PROJECT_NAME"
echo "  npm run dev"
echo ""
echo "⚠️  .env.local を開いて環境変数を設定してください。"

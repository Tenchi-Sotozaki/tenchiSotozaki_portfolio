<template>
  <div class="portfolio-container">
    
    <!-- 左側：固定ナビゲーション（Sidebar） -->
    <aside class="sidebar">
      <h1 class="site-title">TENCHI SOTOZAKI</h1>
      <nav class="nav-menu">
        <ul>
          <li><button @click="setCategory('All')" :class="{ active: currentCategory === 'All' }">All</button></li>
          <li><button @click="setCategory('Movie')" :class="{ active: currentCategory === 'Movie' }">Movie</button></li>
          <li><button @click="setCategory('Music')" :class="{ active: currentCategory === 'Music' }">Music</button></li>
          <li><button @click="setCategory('WebDesign')" :class="{ active: currentCategory === 'WebDesign' }">WebDesign</button></li>
        </ul>
      </nav>
      <div class="footer-info">
        <p>KEST STUDIO</p>
      </div>
    </aside>

    <!-- Vimeoモーダル -->
    <div v-if="modalWork" class="modal-overlay" @click.self="modalWork = null">
      <div class="modal-inner">
        <button class="modal-close" @click="modalWork = null">✕</button>
        <div class="modal-info">
          <h2>{{ modalWork.title }}</h2>
          <p>{{ modalWork.description }}</p>
        </div>
        <div class="modal-video">
          <iframe
            :src="modalWork.vimeoSrc"
            frameborder="0"
            allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media"
            allowfullscreen
          ></iframe>
        </div>
      </div>
    </div>

    <!-- 右側：作品ギャラリー（Main Content） -->
    <main class="gallery-wrapper">
      <transition-group name="fade" tag="div" class="works-grid">
        
        <!-- 作品アイテム -->
        <article 
          v-for="work in filteredWorks" 
          :key="work.id" 
          class="work-item"
          @mouseenter="hoveredId = work.id"
          @mouseleave="hoveredId = null"
          @click="work.vimeoSrc ? modalWork = work : null"
        >
          <!-- サムネイル・動画・説明文を重ねるボックス -->
          <div class="image-box">
            
            <!-- 1. デフォルトの静止画サムネイル -->
            <img 
              :src="work.image" 
              :alt="work.title" 
              loading="lazy" 
              :class="{ 'is-hidden': hoveredId === work.id && work.videoSrc }"
            />
            
            <!-- 2. ホバー時に自動再生される動画（動画URLがある場合のみ） -->
            <video 
              v-if="work.videoSrc && hoveredId === work.id" 
              :src="work.videoSrc" 
              autoplay loop muted playsinline 
              class="hover-video"
            ></video>

            <!-- 3. ホバー時に浮かび上がる説明文 -->
            <div class="hover-overlay" :class="{ 'is-active': hoveredId === work.id }">
              <p class="description">{{ work.description }}</p>
            </div>
            
          </div>
          
          <div class="work-caption">
            <h2 class="work-title">{{ work.title }}</h2>
          </div>
        </article>

      </transition-group>
    </main>

  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

const currentCategory = ref('All');
const hoveredId = ref(null);
const modalWork = ref(null);

// 作品データ（動画URLと説明文を追加）
const works = ref([
  { 
    id: 1, 
    title: 'FEI THE ADEPT - WATTER FALL', 
    category: 'Movie', 
    image: 'https://vumbnail.com/1196325173.jpg',
    videoSrc: null,
    vimeoSrc: 'https://player.vimeo.com/video/1196325173?title=0&byline=0&portrait=0&badge=0&autopause=0&player_id=0&app_id=58479',
    description: 'Director & Editor: Tenchi Sotozaki / Camera Assistant: Einosuke\nListen / Stream: https://linkco.re/CT9yVDcm' 
  },
  { 
    id: 2, 
    title: 'Fei_ - LOVE MY SELF', 
    category: 'Movie', 
    image: 'https://vumbnail.com/1196324981.jpg',
    videoSrc: null,
    vimeoSrc: 'https://player.vimeo.com/video/1196324981?title=0&byline=0&portrait=0&badge=0&autopause=0&player_id=0&app_id=58479',
    description: 'Directed by: Tenchi Sotozaki / Edit Assistant: Einosuke / Camera Assistant: Ryudai' 
  },
  { 
    id: 3, 
    title: 'Hako-Stamp UI', 
    category: 'WebDesign', 
    image: 'https://picsum.photos/seed/3/800/600',
    videoSrc: null,
    vimeoSrc: null,
    description: 'UI/UX Design. 函館市内の店舗を回遊させるデジタルスタンプラリー。' 
  },
  { 
    id: 4, 
    title: 'Night Walk', 
    category: 'Movie', 
    image: 'https://picsum.photos/seed/4/800/600',
    videoSrc: 'https://www.w3schools.com/html/mov_bbb.mp4',
    vimeoSrc: null,
    description: 'Sony FX30を使用し、低照度での美しいノイズ感と色彩を追求。' 
  },
  { 
    id: 5, 
    title: 'SinotPizza Promo', 
    category: 'Movie', 
    image: 'https://picsum.photos/seed/5/800/600',
    videoSrc: 'https://www.w3schools.com/html/mov_bbb.mp4',
    vimeoSrc: null,
    description: 'SNS向けのショートプロモーション。シズル感とテンポを重視。' 
  },
  { 
    id: 6, 
    title: 'Ambient Flow', 
    category: 'Music', 
    image: 'https://picsum.photos/seed/6/800/600',
    videoSrc: null,
    vimeoSrc: null,
    description: 'Logic Proで制作したアンビエントトラック。空間を彩る音。' 
  },
]);

const setCategory = (category) => {
  currentCategory.value = category;
  hoveredId.value = null; // カテゴリ切り替え時にホバー状態をリセット
};

const filteredWorks = computed(() => {
  if (currentCategory.value === 'All') return works.value;
  return works.value.filter(work => work.category === currentCategory.value);
});
</script>

<style scoped>
/* ベース設定 */
.portfolio-container {
  display: flex;
  min-height: 100vh;
  background-color: #f6f5f0;
  color: #333333;
  font-family: 'Helvetica Neue', Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
}

/* === 左側：サイドバー（変更なし） === */
.sidebar {
  position: fixed;
  top: 0; left: 0;
  width: 250px;
  height: 100vh;
  padding: 60px 40px;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
}
.site-title { font-size: 1rem; font-weight: 400; letter-spacing: 0.15em; margin-bottom: 80px; }
.nav-menu ul { list-style: none; padding: 0; margin: 0; }
.nav-menu li { margin-bottom: 20px; }
.nav-menu button { background: none; border: none; color: #888888; font-size: 0.85rem; letter-spacing: 0.1em; cursor: pointer; transition: color 0.3s; padding: 0; }
.nav-menu button:hover, .nav-menu button.active { color: #333333; }
.footer-info { margin-top: auto; font-size: 0.7rem; letter-spacing: 0.1em; color: #aaaaaa; }

/* === 右側：ギャラリー === */
.gallery-wrapper {
  flex: 1;
  margin-left: 250px;
  padding: 60px 60px 60px 0;
}

/* 横に3個並べる（3カラム固定） */
.works-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr); /* ここで3列を指定 */
  gap: 60px 30px; /* 縦の余白60px、横の余白30px */
}

.work-item {
  display: flex;
  flex-direction: column;
  cursor: pointer;
}

/* === 画像・動画・説明を重ねるボックス === */
.image-box {
  position: relative;
  width: 100%;
  aspect-ratio: 16 / 9; /* 動画に合わせて16:9の比率に固定 */
  margin-bottom: 16px;
  background-color: #eae9e4;
  overflow: hidden;
}

/* 静止画サムネイル */
.image-box img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  transition: opacity 0.3s ease;
}

/* 動画再生時にサムネイルを隠す */
.image-box img.is-hidden {
  opacity: 0;
}

/* ホバー時の動画 */
.hover-video {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* ホバー時の説明文オーバーレイ */
.hover-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.6); /* 黒い半透明のフィルター */
  color: #ffffff;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
  box-sizing: border-box;
  opacity: 0; /* 初期状態は透明 */
  transition: opacity 0.3s ease;
  z-index: 10;
}

/* ホバー状態でオーバーレイを表示 */
.hover-overlay.is-active {
  opacity: 1;
}

.description {
  font-size: 0.85rem;
  font-weight: 300;
  line-height: 1.6;
  text-align: center;
  letter-spacing: 0.05em;
  margin: 0;
}

/* === キャプション === */
.work-caption { text-align: left; }
.work-title { font-size: 0.8rem; font-weight: 400; letter-spacing: 0.05em; margin: 0; color: #555555; }

/* === モーダル === */
.modal-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.85);
  z-index: 100;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
  box-sizing: border-box;
}
.modal-inner {
  position: relative;
  width: 100%;
  max-width: 900px;
  background: #111;
  color: #fff;
  padding: 40px;
  box-sizing: border-box;
}
.modal-close {
  position: absolute;
  top: 16px;
  right: 20px;
  background: none;
  border: none;
  color: #fff;
  font-size: 1.2rem;
  cursor: pointer;
  line-height: 1;
}
.modal-info {
  margin-bottom: 20px;
}
.modal-info h2 {
  font-size: 1rem;
  font-weight: 400;
  letter-spacing: 0.1em;
  margin: 0 0 8px;
}
.modal-info p {
  font-size: 0.8rem;
  color: #aaa;
  margin: 0;
  white-space: pre-line;
  line-height: 1.6;
}
.modal-video {
  position: relative;
  width: 100%;
  aspect-ratio: 16 / 9;
}
.modal-video iframe {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
}

/* === アニメーション === */
.fade-enter-active, .fade-leave-active { transition: opacity 0.5s ease, transform 0.5s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; transform: translateY(10px); }
.fade-leave-active { position: absolute; }

/* === レスポンシブ対応 === */
@media (max-width: 1024px) {
  /* PCの画面が少し狭いときは2列にする */
  .works-grid { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 768px) {
  /* スマホの時は1列にする */
  .portfolio-container { flex-direction: column; }
  .sidebar { position: relative; width: 100%; height: auto; padding: 40px 20px 20px; }
  .gallery-wrapper { margin-left: 0; padding: 20px; }
  .works-grid { grid-template-columns: 1fr; gap: 40px 20px; }
  .site-title { margin-bottom: 30px; }
  .nav-menu ul { display: flex; gap: 15px; flex-wrap: wrap; }
}
</style>
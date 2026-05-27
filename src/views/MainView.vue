<template>
  <div class="portfolio-container">
    
    <aside class="sidebar">
      <h1 class="site-title">TENCHI SOTOZAKI</h1>
      <nav class="nav-menu">
        <ul>
          <li>
            <button 
              @click="setCategory('All')" 
              :class="{ active: currentCategory === 'All' }"
            >All</button>
          </li>
          <li>
            <button 
              @click="setCategory('Movie')" 
              :class="{ active: currentCategory === 'Movie' }"
            >Movie</button>
          </li>
          <li>
            <button 
              @click="setCategory('Music')" 
              :class="{ active: currentCategory === 'Music' }"
            >Music</button>
          </li>
          <li>
            <button 
              @click="setCategory('WebDesign')" 
              :class="{ active: currentCategory === 'WebDesign' }"
            >WebDesign</button>
          </li>
        </ul>
      </nav>
      <div class="footer-info">
        <p>KEST STUDIO</p>
      </div>
    </aside>

    <main class="gallery-wrapper">
      <transition-group name="fade" tag="div" class="works-grid">
        <article 
          v-for="work in filteredWorks" 
          :key="work.id" 
          class="work-item"
        >
          <div class="image-box">
            <img :src="work.image" :alt="work.title" loading="lazy" />
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

// 現在選択されているカテゴリー
const currentCategory = ref('All');

// 作品データの配列（モックデータ）
const works = ref([
  { id: 1, title: 'water fall - MV', category: 'Movie', image: 'https://picsum.photos/seed/1/800/600' },
  { id: 2, title: 'Beat Tape Vol.1', category: 'Music', image: 'https://picsum.photos/seed/2/600/600' },
  { id: 3, title: 'Hako-Stamp UI', category: 'WebDesign', image: 'https://picsum.photos/seed/3/800/1000' },
  { id: 4, title: 'Night Walk', category: 'Movie', image: 'https://picsum.photos/seed/4/800/600' },
  { id: 5, title: 'SinotPizza Promo', category: 'Movie', image: 'https://picsum.photos/seed/5/800/450' },
  { id: 6, title: 'Deep House Track', category: 'Music', image: 'https://picsum.photos/seed/6/600/600' },
]);

// カテゴリーを変更する関数
const setCategory = (category) => {
  currentCategory.value = category;
};

// 選択されたカテゴリーに合わせて作品を絞り込む
const filteredWorks = computed(() => {
  if (currentCategory.value === 'All') {
    return works.value;
  }
  return works.value.filter(work => work.category === currentCategory.value);
});
</script>

<style scoped>
/* 全体のベース設定（クリーム色の背景と柔らかな黒文字） */
.portfolio-container {
  display: flex;
  min-height: 100vh;
  background-color: #f6f5f0; /* 山谷さん風の温かいクリーム色 */
  color: #333333; /* 真っ黒ではなく、少し柔らかいチャコールグレー */
  font-family: 'Helvetica Neue', Arial, sans-serif; /* クリーンなサンセリフ */
  -webkit-font-smoothing: antialiased;
}

/* === 左側：サイドバー（固定） === */
.sidebar {
  position: fixed;
  top: 0;
  left: 0;
  width: 280px;
  height: 100vh;
  padding: 60px 40px;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
}

.site-title {
  font-size: 1rem;
  font-weight: 400;
  letter-spacing: 0.15em;
  margin-bottom: 80px;
}

.nav-menu ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.nav-menu li {
  margin-bottom: 20px;
}

.nav-menu button {
  background: none;
  border: none;
  padding: 0;
  color: #888888;
  font-size: 0.85rem;
  letter-spacing: 0.1em;
  cursor: pointer;
  transition: color 0.3s ease;
  font-family: inherit;
}

/* ホバー時と現在選択されているカテゴリーの色 */
.nav-menu button:hover,
.nav-menu button.active {
  color: #333333;
}

.footer-info {
  margin-top: auto;
  font-size: 0.7rem;
  letter-spacing: 0.1em;
  color: #aaaaaa;
}

/* === 右側：ギャラリー（スクロール可能） === */
.gallery-wrapper {
  flex: 1;
  margin-left: 280px; /* サイドバーの幅分だけ余白を空ける */
  padding: 60px 60px 60px 0;
}

.works-grid {
  display: grid;
  /* 画面幅に合わせてカラム数を自動調整（最低300px） */
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 80px 40px; /* 縦の隙間を大きくして「作品」感を出す */
}

.work-item {
  display: flex;
  flex-direction: column;
}

/* 画像を囲むボックス */
.image-box {
  width: 100%;
  margin-bottom: 16px;
  overflow: hidden;
  background-color: #eae9e4; /* 画像読み込み前の仮色 */
}

.image-box img {
  width: 100%;
  height: auto;
  display: block;
  transition: opacity 0.3s ease;
}

.image-box img:hover {
  opacity: 0.8; /* ホバーで少しだけ薄くする上品な演出 */
}

.work-caption {
  text-align: left;
}

.work-title {
  font-size: 0.8rem;
  font-weight: 300;
  letter-spacing: 0.05em;
  margin: 0;
  color: #555555;
}

/* === アニメーション（Vue Transition） === */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease, transform 0.5s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: translateY(10px);
}
.fade-leave-active {
  position: absolute; /* 切り替え時にレイアウトが崩れないように */
}

/* === レスポンシブ対応（スマホ表示） === */
@media (max-width: 768px) {
  .portfolio-container {
    flex-direction: column;
  }
  .sidebar {
    position: relative;
    width: 100%;
    height: auto;
    padding: 40px 20px 20px;
  }
  .site-title {
    margin-bottom: 40px;
  }
  .nav-menu ul {
    display: flex;
    gap: 20px;
    flex-wrap: wrap;
  }
  .gallery-wrapper {
    margin-left: 0;
    padding: 20px;
  }
  .works-grid {
    gap: 40px 20px;
  }
}
</style>
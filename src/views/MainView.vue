<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

// --- State ---
const isScrolled = ref(false)

// --- Lifecycle ---
onMounted(() => {
  window.addEventListener('scroll', handleScroll, { passive: true })
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})

const handleScroll = () => {
  isScrolled.value = window.scrollY > 50
}
</script>

<template>
  <div class="page">
    <!-- ページコンテンツをここに記述 -->
    <header :class="['header', { 'is-scrolled': isScrolled }]">
      <div class="header-inner">
        <div class="logo">[PROJECT_NAME]</div>
      </div>
    </header>

    <main>
      <slot />
    </main>

    <footer class="footer">
      <p>&copy; {{ new Date().getFullYear() }} [PROJECT_NAME]. All Rights Reserved.</p>
    </footer>
  </div>
</template>

<style scoped>
/* --- Design Tokens --- */
.page {
  --color-paper: #f7f4ef;
  --color-ink: #0c0c0c;
  --color-ink-muted: rgba(12, 12, 12, 0.62);
  --color-border: rgba(12, 12, 12, 0.12);
  --font-sans: 'Helvetica Neue', Arial, sans-serif;
  --font-en: 'Playfair Display', serif;

  font-family: var(--font-sans);
  color: var(--color-ink);
  min-height: 100vh;
}

/* --- Header --- */
.header {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 50;
  transition: all 0.35s ease;
  padding: 20px 0;
}

.header.is-scrolled {
  background-color: rgba(247, 244, 239, 0.85);
  backdrop-filter: blur(14px);
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
  padding: 14px 0;
  border-bottom: 1px solid var(--color-border);
}

.header-inner {
  display: flex;
  justify-content: space-between;
  align-items: center;
  max-width: 1440px;
  margin: 0 auto;
  padding: 0 40px;
}

.logo {
  font-family: var(--font-en);
  font-size: 1.65rem;
  font-weight: 600;
  letter-spacing: -0.01em;
}

/* --- Footer --- */
.footer {
  text-align: center;
  padding: 40px 24px;
  font-size: 0.8rem;
  color: var(--color-ink-muted);
  letter-spacing: 0.08em;
}
</style>

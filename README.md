# [PROJECT_NAME]

> Vue 3 + Vite によるシングルページアプリケーションのテンプレートです。

## 技術スタック

| 役割 | ライブラリ / ツール |
|---|---|
| UI フレームワーク | Vue 3 (Composition API / `<script setup>`) |
| ビルドツール | Vite 5 |
| デプロイ | Netlify / GitHub Pages（選択式） |
| フォーム | Netlify Forms |

---

## ディレクトリ構成

```
[PROJECT_NAME]/
├── public/
│   ├── assets/          # 静的画像・メディア
│   └── favicon.ico
├── src/
│   ├── components/      # 再利用コンポーネント
│   ├── views/           # ページ単位のコンポーネント
│   ├── App.vue
│   ├── main.js
│   └── style.css        # グローバルスタイル
├── .env.example         # 環境変数のひな形
├── .gitignore
├── index.html
├── package.json
└── vite.config.js
```

---

## セットアップ手順

### 1. リポジトリをクローン（または setup.sh を実行）

```bash
git clone https://github.com/[GITHUB_USERNAME]/[PROJECT_NAME].git
cd [PROJECT_NAME]
```

または自動セットアップ：

```bash
bash setup.sh
```

### 2. 依存パッケージをインストール

```bash
npm install
```

### 3. 環境変数を設定

```bash
cp .env.example .env.local
```

`.env.local` を開き、各プレースホルダーを実際の値に置き換えてください。

### 4. 開発サーバーを起動

```bash
npm run dev
# → http://localhost:3000
```

---

## 利用可能なスクリプト

| コマンド | 内容 |
|---|---|
| `npm run dev` | 開発サーバー起動（ポート 3000） |
| `npm run build` | プロダクションビルド（`dist/` に出力） |
| `npm run preview` | ビルド結果をローカルでプレビュー |
| `npm run deploy` | GitHub Pages へデプロイ（`gh-pages` 使用） |

---

## デプロイ

### Netlify

1. Netlify ダッシュボードで「New site from Git」を選択
2. ビルドコマンド: `npm run build`
3. 公開ディレクトリ: `dist`
4. 環境変数は Netlify の「Site settings > Environment variables」で設定

### GitHub Pages

```bash
npm run deploy
```

`package.json` の `homepage` フィールドを自分のリポジトリ URL に変更してから実行してください。

---

## Netlify Forms の設定

`index.html` に以下の hidden フォームが含まれています。Netlify にデプロイすると自動的にフォームが有効になります。

```html
<form name="contact" netlify netlify-honeypot="bot-field" hidden>
  ...
</form>
```

通知メールの設定は Netlify ダッシュボードの **Forms > Notifications** から行ってください。

---

## カスタマイズチェックリスト

新規プロジェクト開始時に以下を置き換えてください。

- [ ] `package.json` の `name` を変更
- [ ] `index.html` のタイトル・description・OGP を変更
- [ ] `index.html` のローディング表示テキストを変更
- [ ] `index.html` の Google Fonts URL を必要なフォントに変更
- [ ] `.env.local` の環境変数を設定
- [ ] `public/favicon.ico` を差し替え
- [ ] `src/views/` 配下にページコンポーネントを追加
- [ ] `src/App.vue` のインポート先を変更

---

## ライセンス

[LICENSE]

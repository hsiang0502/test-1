# 教學部教具借還系統

繁體中文靜態網站，包含 36 項教具及照片、借用登記、分批歸還、庫存計算、逾期篩選、歷史明細、CSV 報表及 JSON 備份。
借用登記包含姓名、員編、職類、單位、聯絡方式、數量、用途與預計歸還日期。

## 檔案結構

```text
index.html       網站首頁
style.css        版面樣式
data.js          原始教具清冊資料
app.js           借還管理程式
assets/          36 張教具照片與 catalog.pdf 原始清冊
.nojekyll        靜態網站標記
README.md        本說明
supabase/        Supabase SQL migration
supabase-config.js 專案 URL 與 publishable key
```

## 上傳 GitHub

1. 解壓縮 ZIP。
2. 在 GitHub 儲存庫選擇 Add file → Upload files。
3. 上傳解壓後的所有檔案及 assets 資料夾，保留資料夾結構。不要只上傳 ZIP。
4. 確認 index.html 在儲存庫最外層，並提交變更。

## 發布 GitHub Pages

在儲存庫 Settings → Pages，選擇 Deploy from a branch，分支選 main，資料夾選 / (root)，然後儲存。等待 GitHub 完成發布，使用 Pages 顯示的網站網址。

## 使用方式

1. 教具總覽：搜尋、分類或查看教具詳情。
2. 借用教具：填寫借用人資料、數量、日期與用途。
3. 借用與歸還：選擇辦理歸還，可一次或分批歸還；填寫點收人。
4. 歷史紀錄：查看借用及每次歸還明細。
5. 資料管理：匯出 CSV、下載完整 JSON 備份或匯入備份。

## 資料保存與適用範圍

- 借還資料同步至 Supabase，資料表為 public.teaching_app_state。
- 專案管理員須先在 Supabase SQL Editor 執行 `supabase/migrations/202611180001_teaching_app_state.sql`。
- Supabase Authentication → URL Configuration 的 Site URL 設為 `https://hsiang0502.github.io/test-1/`，並將相同網址加入 Redirect URLs。
- 啟用 Email OTP。使用者需以 `@tpech.gov.tw` 信箱登入；資料表 RLS 也會檢查登入者網域。
- localStorage 只作為登入裝置的備份與初次資料初始化來源；雲端 revision 鎖定可避免不同使用者更新時互相覆蓋。
- 清除網站資料前仍建議匯出備份。
- 初始數量來自提供的清冊；請先確認現場實際數量與存放位置。
- 借用與歸還表單由 app.js 產生；單獨上傳 index.html 不會有完整功能。
- 網站為純 HTML/CSS/JavaScript，不需要 npm 安裝或編譯。正式使用建議透過網站網址開啟。
- Google Fonts 載入失敗時會使用系統字型。

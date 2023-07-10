# Sort-File
任意のファイル・フォルダを仕分けて移動させるPowerShellスクリプト

## 概要
- `Sort-File.bat`
  - `Sort-File.ps1` を呼び出すプログラムの起動部分
  - `Sort-File.ps1` と同じフォルダになければならない
- `Sort-File.bat - ショートカット`
  - `Sort-File.bat` のショートカット
- `Sort-File.ps1`
  - プログラムの本体部分
  - パスやフィルタを直接設定するファイル

## 使い方
### 登録
1. `Sort-File.ps1` の `$StartPath` に探索フォルダのパスを追加する
2. `Sort-File.ps1` の `$SortTable` に正規表現のフィルターと移動先のパスを追加する
3. `Sort-File.bat` または `Sort-File.bat - ショートカット` から実行

### 使用例
- 要件：**ダウンロードフォルダ**内の**ファイル名に数学が入ったpdfファイル**を**C:\数学講義**に移動させたい場合
- 対象フォルダ：高校数学復讐.pdf,数学資料01.pdf,数学資料02.pdf...
```PowerShell
```

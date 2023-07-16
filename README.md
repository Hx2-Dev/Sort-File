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
- 要件
  1. **"ダウンロードフォルダ内"** の **"ファイル名に数学が入ったPDFファイル"** を **"C:\数学\講義資料"** に移動させたい
  2. **"ダウンロードフォルダ内"** の **"ファイル名に数学が入ったWordファイル"** を **"C:\数学\課題"** に移動させたい

- 登録
```PowerShell
# <- はPowerShellのコメント
$StartPath = "C:\Users\***\Downloads"
# 省略
$SortTable = @(
    @{
      # 要件1
      Filter = ".*数学.*\.pdf";
      GoalPath = "C:\数学\講義資料";
    },# つなぎ目には,を付ける
    @{
      # 要件2
      Filter = ".*数学.*\.docx";
      GoalPath = "C:\数学\課題";
    } # 終端には,を付けない
)
```

- 実行

     移動してほしいタイミングで `Sort-File.bat` または `Sort-File.bat - ショートカット` から実行

## 利用・改変
- ライセンス：MIT license
- 利用・改変自由
- 文字コードは `UTF-8`

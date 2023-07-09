# 関数定義 ------------------------------------------------------------
# ユーザーからの入力を待ってからプロセスを終了
# 勝手にプロセスが終了することを防ぐ
function Exit-Process {
    Read-Host "Push enter to end process" > $null
    exit
}

# パスが$Nullか空文字であるかを確認
function Test-NullorEmptyPath {
    param (
        $Path
    )
    return [string]::IsNullOrEmpty($Path)
}

# パスが存在するかを確認
function Test-NotExistPath {
    param (
        $Path
    )
    return (-not (Test-Path -Path $Path))
}

# プロセス ------------------------------------------------------------

# 探索フォルダのパス
$StartPath = ""

# 探索フォルダの正当性確認
if (Test-NullorEmptyPath -Path $StartPath) {
    Write-Host ("StartPath is null or empty") -ForegroundColor DarkRed
    Exit-Process
}
if (Test-NotExistPath -Path $StartPath) {
    Write-Host ("StartPath = " + $StartPath + " is not exists") -ForegroundColor DarkRed
    Exit-Process
}

# 分類表
$SortTable = @(
    # @{
    #   # 対象ファイルを表す正規表現
    #   Filter = "";
    #   # 移動先のパス
    #   GoalPath = "";
    # },
    @{
        Filter = "";
        GoalPath = "";
    }
)

# 分類表の有効な項目のインデックスリスト
$ValidIndexes = @()
# 分類表の各項目の正当性確認
# パスの正当性確認のみ確認,正規表現は事前に確認できない
for ($Index = 0; $Index -lt $SortTable.Count; $Index++) {
    if (Test-NullorEmptyPath -Path $SortTable[$Index].GoalPath) {
        Write-Host ("GoalPath (Index = " + $Index + ") is empty") -ForegroundColor DarkRed
        $ValidIndexes += $false
        continue
    }
    if (Test-NotExistPath -Path $SortTable[$Index].GoalPath) {
        Write-Host ("GoalPath (Index = " + $Index + ") is not exists") -ForegroundColor DarkRed
        $ValidIndexes += $false
        continue
    }
    $ValidIndexes += $true
}

# $StartPath内のファイルを順に取得
Get-ChildItem -Path $StartPath -Name | ForEach-Object {
    $FileName = $_
    # 分類表の有効な項目のみ使用
    for ($Index = 0; $Index -lt $SortTable.Count; $Index++) {
        if (-not $ValidIndexes[$Index]) { continue }
        if ($FileName -notmatch $SortTable[$Index].Filter) { continue }
        $Answer = "y"
        if (Test-Path ($SortTable[$Index].GoalPath + "\" + $FileName)) {
            Write-Host ("`"" + $FileName + "`"" + "is already exists") -ForegroundColor DarkRed
            Write-Host "    -> Overwrite the file ? [y or n]: " -ForegroundColor DarkRed -NoNewline
            $Answer = Read-Host
        }
        if ($Answer -ne "y") { continue }
        Move-Item -Path ($StartPath + "\" + $FileName) $SortTable[$Index].GoalPath -Force
        Write-Host ("`"" + $FileName + "`"")
        Write-Host ("   -> Move to " + $SortTable[$Index].GoalPath)
    }
}

Exit-Process
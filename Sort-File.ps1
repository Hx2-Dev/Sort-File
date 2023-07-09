# �֐���` ------------------------------------------------------------
# ���[�U�[����̓��͂�҂��Ă���v���Z�X���I��
# ����Ƀv���Z�X���I�����邱�Ƃ�h��
function Exit-Process {
    Read-Host "Push enter to end process" > $null
    exit
}

# �p�X��$Null���󕶎��ł��邩���m�F
function Test-NullorEmptyPath {
    param (
        $Path
    )
    return [string]::IsNullOrEmpty($Path)
}

# �p�X�����݂��邩���m�F
function Test-NotExistPath {
    param (
        $Path
    )
    return (-not (Test-Path -Path $Path))
}

# �v���Z�X ------------------------------------------------------------

# �T���t�H���_�̃p�X
$StartPath = ""

# �T���t�H���_�̐������m�F
if (Test-NullorEmptyPath -Path $StartPath) {
    Write-Host ("StartPath is null or empty") -ForegroundColor DarkRed
    Exit-Process
}
if (Test-NotExistPath -Path $StartPath) {
    Write-Host ("StartPath = " + $StartPath + " is not exists") -ForegroundColor DarkRed
    Exit-Process
}

# ���ޕ\
$SortTable = @(
    # @{
    #   # �Ώۃt�@�C����\�����K�\��
    #   Filter = "";
    #   # �ړ���̃p�X
    #   GoalPath = "";
    # },
    @{
        Filter = "";
        GoalPath = "";
    }
)

# ���ޕ\�̗L���ȍ��ڂ̃C���f�b�N�X���X�g
$ValidIndexes = @()
# ���ޕ\�̊e���ڂ̐������m�F
# �p�X�̐������m�F�̂݊m�F,���K�\���͎��O�Ɋm�F�ł��Ȃ�
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

# $StartPath���̃t�@�C�������Ɏ擾
Get-ChildItem -Path $StartPath -Name | ForEach-Object {
    $FileName = $_
    # ���ޕ\�̗L���ȍ��ڂ̂ݎg�p
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
$sourceFilePath = "<処理対象ファイルパス>"
$destinationFilePath = "<処理後の出力ファイルパス>"

# ファイルを逐次的に読み込み、置換して新しいファイルに書き込む
$reader = [System.IO.File]::OpenText($sourceFilePath)
$writer = [System.IO.File]::CreateText($destinationFilePath)

$bufferSize = 16384 # 16KB バッファサイズ
$buffer = New-Object char[] $bufferSize

$halfwidthYen = [char]0x005C # \ のSJIS文字コード
$fullwidthYen = [char]0xffe5 # ￥ のSJIS文字コード

while ($reader.Peek() -ge 0) {
    $charsRead = $reader.Read($buffer, 0, $bufferSize)
    for ($i = 0; $i -lt $charsRead; $i++) {
        if ($buffer[$i] -eq $halfwidthYen) {
            $writer.Write($fullwidthYen) # 全角の￥に置換
        } else {
            $writer.Write($buffer[$i])
        }
    }
}

$reader.Close()
$writer.Close()

Write-Host "置換が完了しました。"


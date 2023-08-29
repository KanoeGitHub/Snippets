$i = 0
$sourceFilePath = "<source file path>"
$encoding = [System.Text.Encoding]::GetEncoding("Shift-JIS")

Get-Content $sourceFilePath -Encoding Default -ReadCount 500000 | ForEach-Object {
    $content = $_ -join "`r`n"  # 改行を復元
    $outputFilePath = "<output file path>"
    [System.IO.File]::WriteAllText($outputFilePath, $content, $encoding)
    $i++
}


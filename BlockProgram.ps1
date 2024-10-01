Add-Type -AssemblyName System.Windows.Forms

$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$openFileDialog.Filter = "Executáveis (*.exe)|*.exe"
$openFileDialog.Title = "Selecione um executável"

if ($openFileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $programaCompleto = $openFileDialog.FileName
    $programa = [System.IO.Path]::GetFileName($programaCompleto)

    netsh advfirewall firewall add rule name="$programa" dir=OUT action=BLOCK program="$programaCompleto"
    netsh advfirewall firewall add rule name="$programa" dir=IN action=BLOCK program="$programaCompleto"

    Write-Host "Regras de bloqueio de $programa foram adicionadas."
} else {
    Write-Host "Nenhum programa selecionado."
}
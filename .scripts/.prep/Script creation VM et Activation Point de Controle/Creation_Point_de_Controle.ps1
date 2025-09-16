# Définir le préfixe des VMs
$vmPrefix = "VMW"
$vmCount = 30  # Nombre total de VMs

# Créer un point de contrôle sur chaque VM
For ($i = 1; $i -le $vmCount; $i++) {
    $vmName = "$vmPrefix" + $i.ToString("00")

    # Vérifier si la VM existe
    if (Get-VM -Name $vmName -ErrorAction SilentlyContinue) {
        Write-Host "🔄 Création d'un point de contrôle pour $vmName..."
        Checkpoint-VM -Name $vmName -SnapshotName "Etat_Initial"
        Write-Host "✅ Point de contrôle créé pour $vmName"
    } else {
        Write-Host "❌ VM $vmName introuvable."
    }
}

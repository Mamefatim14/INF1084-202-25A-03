# Définir le chemin du fichier .vmcx exporté de la VM
#$vmcxPath = "C:\VMs\VMs_Templates\TEMPLATE_VM\VM01\Virtual Machines\30EC2AA7-24AA-497F-B28E-435717023443.vmcx"
#$vhdxPath = "C:\VMs\VMs_Templates\TEMPLATE_VM\VM01\Virtual Hard Disks\VDISK.vhdx"
$vmcxPath = "C:\VMs\VMs_Templates\TEMPLATE_WINDOWS\Virtual Machines\EAC81999-749D-4AA8-81B3-30B361F6BD63.vmcx"
$vhdxPath = "C:\VMs\VMs_Templates\TEMPLATE_WINDOWS\Virtual Hard Disks\VDISK.vhdx"

# Définir le nombre de copies Ã  importer
$numberOfCopies = 70

# Définir le chemin oÃ¹ les VMs importées seront stockées
$importPath = "C:\VMs"

# Boucle pour importer n copies de la VM
for ($i = 1; $i -le $numberOfCopies; $i++) {
    # Définir le nom de la nouvelle VM
    $vmName = "SRV" + "{0:D2}" -f $i

    # Définir le chemin unique pour les fichiers de la VM
    $uniqueVhdPath = "$importPath\$vmName\Virtual Hard Disks"
    $uniqueVmPath = "$importPath\$vmName\Virtual Machines"

    # Créer les dossiers nécessaires
    New-Item -ItemType Directory -Path $uniqueVhdPath -Force
    New-Item -ItemType Directory -Path $uniqueVmPath -Force

    # Copier le fichier VHDX dans le chemin unique
    Copy-Item -Path $vhdxPath -Destination "$uniqueVhdPath\$vmName.vhdx"

    # Importer la VM
    $importedVM = Import-VM -Path $vmcxPath -Copy -GenerateNewId -VirtualMachinePath $uniqueVmPath -VhdDestinationPath $uniqueVhdPath

    # Renommer la VM importée
    Rename-VM -VM $importedVM -NewName $vmName
    #Remove-Item -Path "$uniqueVhdPath\TEMPLATE.vhdx" -Force
}

#Load the Azure PowerShell cmdlets
Import-Module Azure 

#Login to your Azure account and select your subscription (if your account has multiple subscriptions)
Login-AzureRmAccount 
Set-AzureRmContext -SubscriptionId 550b1d7b-296a-4d02-9e5c-0995ed799a3f
$resourceGroup = "CertTraining"
$vmName = "WinVM" 
$storageName = "kevfilestorage"

#Publish the configuration script into Azure Storage
Publish-AzureRmVmDscConfiguration -ConfigurationPath .\iisInstall.ps1 -ResourceGroupName $resourceGroup -StorageAccountName $storageName -force

#Configure the VM to run the DSC configuration 
Set-AzureRmVmDscExtension -Version 2.21 -ResourceGroupName $resourceGroup -VMName $vmName -ArchiveStorageAccountName $storageName -ArchiveBlobName iisInstall.ps1.zip -AutoUpdate:$true -ConfigurationName "IISInstall"


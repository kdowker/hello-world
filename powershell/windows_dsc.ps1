# File will be used to test Custom Script Extension for Azure VMs
Configuration DeployWebPage
{
    Node "WinVM"
    {
        WindowsFeature IIS {
            Ensure = "Present"
            Name = "Web-Server"
        }

        File WebPage {
            Ensure = "Present"
            DestinationPath = "C:\inetpub\wwwroot\index.html"
            Force = $true 
            Type = "File"
            Contents = '<html><body><h1>Hello web page!</h1></body></html>'
        }
    }
}
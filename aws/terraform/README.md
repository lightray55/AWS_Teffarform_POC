## Install terraform on Windows

Install the chocolatey package manager
`Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`

Then run the command
`choco install terraform`

https://learn.hashicorp.com/tutorials/terraform/install-cli

You may need to restart VSCode after running these steps in order for the correct PATH environment variables to be picked up.

## Run terraform

After terraform is installed - open a terminal and navigate to this folder `cd aws\terraform`

Run this command to setup terraform locally

`terraform init`

Update the access_key and secret_key values in the uploadToBucket.tf file (We can make this easier in future)

Run the following command to see what terraform will do:

`terraform plan`

Run the following command to actually make the changes

`terraform apply`
1. Criando Service Connection com Microsoft Azure
   ```
   az ad sp create-for-rbac --name "tf-finance" --role Contributor --scopes /subscriptions/{subscriptionid} --sdk-auth
   ```
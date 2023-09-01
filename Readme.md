# Creation d'une stack LAMP sur un cluster Kubernetes en utilisant le provider kubernetes de terraform  

## Architecture  de la configuration 
liste de modules  
1. root module  : 
- main.tf 
- variables.tf 
- outputs.tf 

2. module Apache (service externe) 
3. module mySQL (service interne)
4. module PhpMyAdmin (service externe)
5. PHP (inclus dans l'image)
6. LINUX (plateforme)

liste des fichiers de configuration(config-map) : 
 - Apache.conf 
 - ports.conf 
 - enable-sites 
 - /etc/mysql/my.cnf 
  
Liste des volumes : 
- volume de base de données 
- Volume Apache 


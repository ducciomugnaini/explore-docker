# https://stackoverflow.com/questions/1773805/how-can-i-parse-a-yaml-file-in-python

# pip install pyyaml

import yaml

with open('../k8s/deploy-webapp.yml', "r") as stream:
    try:
        deployWebapp = yaml.safe_load(stream)
        print(deployWebapp)
        env = deployWebapp['spec']['template']['spec']['containers'][0]['env']
        envLenght = len(deployWebapp['spec']['template']['spec']['containers'][0]['env'])        
        for currEnvVariable in env:
            if currEnvVariable['name'] == 'HelloFrontendPhrase':
                currEnvVariable['value'] = 'HELLO_FRONTEND_PHRASE'
    except yaml.YAMLError as exc:
        print(exc)
with open('../k8s/deploy-webapp.yml', 'w') as file:
    yaml.dump(deployWebapp, file)

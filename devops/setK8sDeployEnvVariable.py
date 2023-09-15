# https://stackoverflow.com/questions/17140886/how-to-search-and-replace-text-in-a-file

import sys


def replace_value(valueToReplace):
    # Read in the file
    with open('../k8s/deploy-webapp.yml', 'r') as file:
        filedata = file.read()

    # Replace the target string
    filedata = filedata.replace('value: HELLO_FRONTEND_PHRASE', 'value: ' + valueToReplace)

    print('ok ' + filedata)

    # Write the file out again
    with open('../k8s/deploy-webapp.yml', 'w') as file:
        file.write(filedata)


replace_value(sys.argv[1])
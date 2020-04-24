


def loadText(path):
    with open(path, "r") as file:
        return file.read()



def saveText(path, content):
    with open(path, "w") as file:
        file.write(content)
        file.close()

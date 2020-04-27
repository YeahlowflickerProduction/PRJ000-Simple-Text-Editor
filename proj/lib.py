
import pickle


def loadText(path):
    with open(path, "r") as file:
        return file.read()



def saveText(path, content):
    with open(path, "w+") as file:
        file.write(content)
        file.close()



def loadObject(path):
    with open(path, "rb") as file:
        return pickle.load(file)


def saveObject(path, *args):
    with open(path, "wb+") as file:
        pickle.dump(args, file)
        file.close()


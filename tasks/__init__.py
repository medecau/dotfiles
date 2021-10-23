from importlib import import_module

from invoke import Collection


def add_collection_from_module(collection, module_name):
    collection.add_collection(
        Collection.from_module(import_module(module_name, __name__))
    )


_bin = Collection("bin")
add_collection_from_module(_bin, ".shiv")

ns = Collection()
ns.add_collection(_bin)

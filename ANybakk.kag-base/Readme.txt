In kag-base, entities is organized a bit differently than usual. Each entity 
consists of up to several scripts divided into three categories:

1) Functions:   These scripts contain the actual code for an entity.
2) Variables:   These scripts contain variables the code is dependant on.
3) Interfaces:  These scripts is the glue that binds the code and variables 
together, and forms the interface to the game engine through any entity 
descriptor file (.cfg)

Functions and variables are wrapped into name-spaces. This is to avoid naming 
collisions and improve re-use in inheritance-like hierarchies. The hierarchy is 
also reflected in the folder structure.

Functions and interfaces can be divided into different kinds of behaviour as 
dictated by the game engine, such as blob, brain, movement, sprite and 
inventory.

To simply override variables on a server, create a mod with a copy of the files
in question, and set different values. The data types cannot be changed with 
any guarantees that it will work.

To add new entities, determine it's position in the hierarchy, and make sure 
that any onInit functions call the parent's version of the same function first. 
For the most part, these parents will only do things that would make sense for 
inheriting types, but if something is undesirable, you will have to manually 
revert those things. One thing that is commonly done for blobs is to set 
various tags, or flags, on the underlying objects.

New entities may also have to include their parent's variables in their 
original name-space.
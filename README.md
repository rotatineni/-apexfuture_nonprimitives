# -collectionsinfuture
Describes how to pass collections to @future annotated methods in Apex

@future annotation is used to overcome the apex governor limits (SOQL, DML, CPU, HEAP) in a transaction by pushing some methods to run asynchronously. 

Methods with the future annotation must be static methods, and can only return a void type. The specified parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types. Methods with the future annotation cannot take sObjects(Standard and Custom) objects as arguments.

There will be times when your data is not a primitive or collection of primitives but more complex data types like SObjects, collection of non-primitives or nested collections (collections within collections) in which case a common pattern is to pass the method a List of record IDs that you want to process asynchronously.

Refer to file "asyncapex" in this project on how to overcome this limitation by serializing your data before passing to @future method and then deserialize inside the @future method. 


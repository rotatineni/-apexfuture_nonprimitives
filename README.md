# -collectionsinfuture
Describes how to pass collections to @future annotated methods in Apex

@future annotation is used to overcome the apex governor limits (SOQL, DML, CPU, HEAP) in a transaction by pushing some methods to run asynchronously. 

Methods with the future annotation must be static methods, and can only return a void type. The specified parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types. Methods with the future annotation cannot take sObjects(Standard and Custom) objects as arguments.

There will be times when your data is not a primitive or collection of primitives but more complex data types like SObjects, collection of non-primitives or nested collections (collections within collections) in which case a common pattern is to pass the method a List of record IDs that you want to process asynchronously.

Refer to file "asyncapex" in this project on how to overcome this limitation by serializing your data before passing to @future method and then deserialize inside the @future method. 

General Best Practices for @future methods:
Since every future method invocation adds one request to the asynchronous queue, avoid design patterns that add large numbers of future requests over a short period of time. If your design has the potential to add 2000 or more requests at a time, requests could get delayed due to flow control. Here are some best practices you want to keep in mind:
-- Ensure that future methods execute as fast as possible.
-- If using Web service callouts, try to bundle all callouts together from the same future method, rather than using a separate future method for each callout.
-- Conduct thorough testing at scale. Test that a trigger enqueuing the @future calls is able to handle a trigger collection of 200 records. This helps determine if delays may occur given the design at current and future volumes.
-- Consider using Batch Apex instead of future methods to process large number of records asynchronously. This is more efficient than creating a future request for each record.

Here are some things to keep in mind when using @future methods:
-- Methods with the future annotation must be static methods, and can only return a void type.
-- The specified parameters must be primitive data types, arrays of primitive data types, or collections of primitive data types; future methods can’t take objects as arguments.
-- Future methods won’t necessarily execute in the same order they are called. In addition, it’s possible that two future methods could run concurrently, which could result in record locking if the two methods were updating the same record.
-- Future methods can’t be used in Visualforce controllers in getMethodName(), setMethodName(), nor in the constructor.
-- You can’t call a future method from a future method. Nor can you invoke a trigger that calls a future method while running a future method. See this link (http://blog.jeffdouglas.com/2009/10/02/preventing-recursive-future-method-calls-in-salesforce/) for preventing recursive future method calls.
-- The getContent() and getContentAsPDF() methods can’t be used in methods with the future annotation.
-- You’re limited to 50 future calls per Apex invocation, and there’s an additional limit on the number of calls in a 24-hour period. 

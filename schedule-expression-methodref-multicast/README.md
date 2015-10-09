# Multi-cast workaround

Limitations of `TimerConfig` accepting only a Serializable rather than a functional interface are worked around using Java 8 multi-cast.
The resulting object that "wraps" the Lambda will end up implementing two interfaces `Runnable` and `Serializable`.  We leverage it critically

 - Cast to `Serializable` in `TimerConfig` creation
 - Cast to `Runnable` in execution of `Timer`

While this works, the resulting Lambda should not actually be serialized.

 - `FarmerBrown` does not implement serializable
 - `FarmerBrown` upon deserialization would not be an "EJB"
     - equivalent to a direct "new FarmberBrown()" instance
     - not container-managed instance
     - no dependecy injection by the container

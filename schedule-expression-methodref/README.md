# Functional ScheduleExpression

This example does not work.  One obvious thing is missing and one subtle thing is missing.  Two bits of syntax are changed
to make this more direct passing of a `Runnable` to the `TimerService` possible

 - The `TimerService.createCalendarTimer` method signature changed to accept a `Runnable` instance
 - The deletion of the `@Timeout` method causes subtle issues

The existence of this `@Timeout` method is what drives the interceptor stack and more.

    @Timeout
    public void timeout(Timer timer) {
        ((Runnable) timer.getInfo()).run();
    }

When we delete it and pass the method reference directly to the TimerService, we effectively pass a `this` reference.

 - invoking the EJB via a `this` reference dilema: no interceptors, no decorators, no JNDI,
 - invoking the EJB via the proxy: all good.

The container would have to ensure proper context is given before

Interceptors can provide around advice to `@Timeout` via `@AroundTimeout`

```
@AroundTimeout
public Object invoke(javax.interceptor.InvocationContext invocationContext) throws Exception {

}
```

there would be same harder under-the-covers considerations vendors would need to hammer out to get it to work equivalently.

Experienced EJB developers know that passing a this reference "outside" the bean means:

 - interceptors are *not* invoked
 - transaction semantics
 - JNDI Context association
 - `@RunAs` enforcement



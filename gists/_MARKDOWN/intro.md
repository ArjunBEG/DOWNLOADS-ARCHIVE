A few conversations have circled around user-side structural profiling. For context, see [React PR #7549: Show React events in the timeline when ReactPerf is active](https://github.com/facebook/react/pull/7549)

One particular concern is the measurement overhead. This gist has a benchmarking script ([`measure.js`](#file-measure-js)) for evaluating overhead and initial results.


### Results: `performance.mark()`
Runs about 0.65µs per `mark()` call. Naturally, that's ~= an overhead of 1ms for 1500 `mark()`s. 
![image](https://cloud.githubusercontent.com/assets/39191/18573919/df822002-7b7c-11e6-8d66-40d5e31f4385.png)



### Results: `performance.measure()`

Calls to `measure()` are not significantly more expensive than calls to `mark()`. They appears to be ~30% more expensive than a `mark()`, but still only clocking in at ~0.85µs per `measure()` call. 

(If benchmarking, be sure to run timeline against your benchmark; I've seen large DOM GC's when calling measure >50,000 times a second. :)


### Results: `console.time()`
`console.time` is much more expensive at ~11.5 µs/call (thats ~18x slower than perf.mark()). Therefore, it's not recommended. Also it spams your console, so it's inconvenient to use for high-volume work.

![image](https://cloud.githubusercontent.com/assets/39191/18573937/002aa018-7b7d-11e6-805c-7349fd0d6a4b.png)






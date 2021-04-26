_(This is an excerpt from a much longer paper I'm writing about code quality and maintaining FOSS projects.)_

# FOSS dependency scoring

In an effort to improve the quality of search results on sites like https://npmjs.com, there has been more and more discussion about factoring in the ranking/scoring of dependencies to influence search results. The general idea is that a library should be ranked not only on its own merits, but dependencies should weigh into the score as well.

I’m not sure what my opinion is on this yet. I was initially in favor of this, and still might be, but this document is a summary of some things that crossed my mind about the topic.

**Should dependencies weigh into the search score for a library?**

1. Some very popular libraries on npm are very poorly written, but solve problems that are sufficiently complex that few alternatives exist. From a scoring standpoint, this alone wouldn't matter because the law of averages would even it out. However...
2. It's possible for developers to write high quality, stable code on top of lesser quality libraries.
3. The better quality the code, and more knowledgable the maintainers, the more likely it is that a codebase insulates itself from weaknesses in its dependency tree.
4. Moreover, the higher quality the library is, the more disproportionate the difference will be (predictably) between the quality of the library itself and it's dependencies (again, because of the law of averages). Good libraries represent a spike in the asymptote. Poor libraries are the proverbial "long tail". Thus, if we use a relative scoring scale, in comparison to "the very best library" all other dependencies are relatively "poor" and would lower the score of the best library. (would a common "3" library improve it's score by having a dep with a score of "5", whilst a high-quality and rare "10" library has its score lowered by depending on "6"? Should we just penalize them both? Or should we reward high quality libraries that score well despite having a weak dependency tree?)
5. Would version locking factor in? If so, how would it be weighted?
6. I think it's debatable that this would encourage devs to contribute to poor quality modules. IMHO it's arguably more likely that this would encourage developers of high quality modules to remove low quality modules in lieu of publishing their own modules to use as dependencies. The higher quality the code is produced by a developer, the more likely it is that scoring dependencies which are out of his/her control will put them in a position of "risk". In which case, in order to avoid being at continual disadvantage and perpetual position of risktaking control of said libraries is most likely to yield an outcome that )
7. Even if the current scoring model for invidivual libraries was mature and stable, any potential flaws in the model that might typically be tolerable and smoothed out in the averages could be geometrically magnified when dependencies are factored in.

One big takeaway is this: depending on how the algorithm is written, higher quality libraries that specifically go to great lengths to insulate the library from bad upstream code might be disproportionately penalized if low quality libraries are in the tree.

**FOSS conversion funnel**

A page-rank-like scoring model with a conversion funnel might be a good approach to scoring. In which case the algorithm should take the following into consideration:

| Conversion funnel equivalent | Metric | Description |
| --- | --- | --- |
| `awareness` | **github stars** | Equivalent of "likes", but only slightly better than visits (it's possible to have many stars per one visitor). This metric only proves awareness, no causal relationship to actual interest, "real" popularity, code quality or reliability, trust (or the maintainers' trustworthiness or competency for meeting the needs of the community), intent to use, or advancement in the "conversion funnel (e.g. there is no indication the project will go from "starred" to "battle tested and reliable"). This metric should count for 10-15% of the score. |
| `interest` | **dependants** | Dependants are a sign of awareness and commitment from the authors that chose to depend on the library, but no correlation to actual usage, commitment from upstream implementors and users to use the dependant, and is just as likely to represent herd mentality or a reaction to recent awareness as it is to be a predictor of success. This metric should count for 10-15% of the score |
| `conversion` | **downloads** | A sign of both commitment and success. Regardless of the number of direct dependants, libraries with higher downloads are vetted by more users and upstream implementors. This is number should count for 75-90% of the score |

**Stars are subjective for other reasons**

- "apps" and "frameworks" tend to get more stars than "libraries".
- projects that get lots of stars right after being published tend to accumulate more stars over time
- projects that don't get lots of stars right away tend to stay that way. It's rare for projects to suddenly become popular long after being published ("you only get one chance to make a first impression")
- people generally do not "un-star" projects that they are no longer interested in, which creates an illusion of popularity for projects that might have looked awesome when they were initially published, but never really lived up to their potential.

**Weighing activity and issues**

Frequency of issues and commits are often seen as a sign of a popular and healthy library. But that's arguably only true of:

- complicated libraries
- libs with a large API surface
- libs with lots of moving parts that are a topic of discussion or are still open for debate
- libs that have a lot of unanswered questions
- libs that are subject to a lot of platform-specific edge cases

versus, for example:

- mature libraries with predictable, deliberate release cycles
- micro-libraries that do one thing, and do it well
- libraries that strive to be immutable (why would we penalize this?)
- libraries that don't receive bug reports and patches because they are well-written (IMHO, libraries with high downloads and few bug reports should receive disproportionately positive scores)
- libraries that many devs don't view as "star-worthy"

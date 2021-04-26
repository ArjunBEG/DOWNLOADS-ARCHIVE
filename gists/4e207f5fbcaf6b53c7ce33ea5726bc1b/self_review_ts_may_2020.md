
## Core Priorities

> Briefly state your (2-5) core priorities that represent your primary areas of focus and the targeted business impact. Also include your critical indicators of success for each

1. **Lower the barrier of entry to adopting and understanding TypeScript**. Will validate by re-requesting feedback from the community a second time like issues #31983 and hopefully it should be a new set of problems.

2. **Understand the TypeScript Codebase enough to provide useful API documentation and fix bugs.** Validated by having a more comprehensive set of tools for understanding 

3. **Make contributing to TypeScript easier, and reduce the amount of work maintainers need to do.** Validated probably by the number of open PRs, and the number of external contributors per release.

4. **Make it easier to people wanting to build tooling around TypeScript.** Some of this can be think this can be validated by making a community survey and comparing to internal feedback. I have some personal docs, and ideas in the website overview but would be good to get overall ideas.

5. **Provide resources for people wanting to improve the TypeScript community.** Validated by seeing more meetups, conferences rely on infra we provide.


##  Looking Back

> Consider your overall impact to the business through: Your key individual accomplishments, your results that built on the work, ideas or efforts of others, your contributions to the success of others and the resulting impact of each area

In November I had just started providing [public updates](https://github.com/microsoft/TypeScript-Website/issues/130) which are a good idea of the tactics-level changes through the last 6 months. It looks like I had just shipped the fork of the typescript-play as the main website. With work on the new site having just started.

1 - New & old site updated with most of the community feedback around TypeScript's documentation and web infra.

2 - Playgrounds became 1st class building primitives - we use Playgrounds on PRs, people are building playground plugins. There's no extra work for the existing deployment workflow to get a PR build.

3 - Eco-system ownership: I've been working quite a lot with Nathan on DOM dts files and Ryan with DT automation to help reduce their workload and split out ownership across more people

Like a lot of a compiler team's work - you need to squint a little little to see the a direct business impact, but I like to think of it as:

> Making it easier for the people who do a lot of the deep TypeScript work to focus more


#### What could you have done differently for even greater business impact?

There's a reasonable argument that the website could be less infra in order to have got shipped faster, but I'm not too sold on that. The trade-off would probably come at the expense of tests/docs/abstraction simplification of the codebase (e.g. not filling it with node_modules)

There's definitely a case that I'm slow on the uptake on understanding the compiler. I can still spend a whole day trying to understand a reasonably simple bug, and have spent many days on infinite loop bugs that never end up anywhere. At least most times I pair with someone on something I'm stuck on I get a "huh, this is trickier than I expected."

## Going Forward

> What are your key deliverables and the expected business impact for the upcoming period?

_( I'm assuming 6 months as the periods )_

#### 2020 Goals

- Ship the v2 site
- Reduce DT burden on TypeScript team (through docs and automation)
- Support the localization effort to get some languages to 100% coverage
- Create more internal compiler docs, and begin typescript module docs

- Have a very strong working model of:
   - CFA
   - Type Checking
   - Project References
   - TSServer internals

#### 2020 Stretch

- Hit an RC with 0 assigned bugs

#### What will you do in the upcoming period to learn and grow?

This may come up in connects for the rest of my life, but making more requests for pairing on specific issues. Right now I tend to only ask Nathan and Andrew Branch, but maybe I should... branch, out more. I strive to be very independent (which is why I also studied design and product management) as a creator, but deep projects are deep. I'll try expanding the folks I make requests to and poke Wes about my next one.

Re: Compiler

I really kinda need to find a way to settle in and enjoy diving into the compiler. I'm currently writing up compiler notes along side any bugs ( https://github.com/orta/typescript-notes and the TS wiki) but I'm still not sure it's quite the right mindset to hit the right notes

I need to become a client of the TypeScript module somehow - so far that's been through some of the TS website modules, and I've started to expand into playground plugins in my spare time which help me introspect TS to get a better sense of how things work under the hood

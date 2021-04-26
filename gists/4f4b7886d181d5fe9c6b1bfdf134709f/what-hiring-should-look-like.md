# What Hiring Should Look Like

This is definitely not the first time I've written about this topic, but I haven't written formally about it in quite awhile. So I want to revisit why I think technical-position interviewing is so poorly designed, and lay out what I think would be a better process.

I'm just one guy, with a bunch of strong opinions and a bunch of flaws. So take these suggestions with a grain of salt. I'm sure there's a lot of talented, passionate folks with other thoughts, and some are probably a lot more interesting and useful than my own.

But at the same time, I hope you'll set aside the assumptions and status quo of how interviewing is always done. Just because you were hired a certain way, and even if you liked it, doesn't mean that it's a good interview process to repeat.

If you're happy with the way technical interviewing currently works at your company, fine. Just stop, don't read any further. I'm not going to spend any effort trying to convince you otherwise.

The rest of this post will *assume* that you agree with me, that's the whole current status quo process is broken from the ground up, and that it needs to be completely re-designed. I'm going to offer thoughts on what I think it *should look like*.

## Technical Screen

Off the top, let's call out that every technical-position interview is necessarily going to need several parts to it. You can't have a single 15 minute conversation with any person and know (and them know!) that everything is a perfect fit and hire them on the spot. That's a terrible and unattainable process.

One of those steps is the *technical screen*. Why does this step exist? Why is it necessary?

The reason for the "screening call" is to weed out, in an early pass with very little expense on either side, those who are definitely not a good fit (technically, especially), perhaps either because they're too inexperienced, or (worse) they are misrepresenting themselves.

I guess it's also possible that screening eliminates those who are over-qualified. But for this post, I'm going to assume that it's a *good problem* if you find someone over-qualified, because at least you now have a future pool for other positions you may someday need to fill.

Somewhere along the way, the screening call also became more of a way to fully vet technical skills. Let's all admit that while vetting technical skills is important, that's separate from weeding out the lower end that isn't up to the necessary level. Using the same *mechanism* for both is part of what makes technical interviewing so broken.

Let's also talk about this "lower threshold" for a moment. My assertion is that most companies *think* they know what the lower threshold is, but they are actually really bad at that.

If your job posting title is "Junior Developer - JS", what exactly is the lowest threshold that you should screen people out who fall below?

You may think this is a trivial concern. Let's just say that they need "at least 12 months experience with JS", but that's not even close to sufficient of a standard. "12 months experience" can be radically different depending on the job, the code base, the team around you, etc.

Basically, I think I've come to the conculsion that most screening is bullshit and should be tossed out.

I think the process I will suggest in a moment will naturally handle the false-positive signals you're so worried about.

## Technical Vetting

Vetting a candidate to see what their technical skills are -- problem solving, coding style, algorithmic thinking, etc -- is important, no doubt.

But coding quiz type interviews are **the worst possible way** to do this vetting. Why? Because the noise-to-signal ratio is so poor that you can't actually get any useful information. Worse, you probably don't even realize all the bias factors muddying the signal, so you make really poor decisions.

Also, ability to code with algorithms should only be a **tiny** part of what you should be trying to vet a candidate.

Anyone who's ever spent much time as a developer knows that coding is *a* part of the job, but there's a ton of other stuff that I would argue is every bit as important as the code, probably more. For example: documentation, writing good tests, written communication (in PRs/issues), ability to take constructive feedback on code, and much, much more.

All of those things are far more indicative of how well you'll do as a developer on most teams than whether you're someone who likes to write `for (let i = 0; ..)` or `list.forEach(..)`.

If you focus on vetting all these things, you'll actually end up vetting their coding skills at the same time (for free!). But if you focus only on vetting their coding skills, you miss out vetting all this other stuff.

One reason people don't focus on this sort of vetting, and instead obsess about vetting coding skills, is because it makes them feel better if they can design gotcha quiz questions that trip people up on lack of some esoteric corner-case knowledge. They substitute that poor signal for "has been around coding long enough".

Another reason they do it is because of the bullshit of "meritocracy", the idea that tech and ideas are the most important thing. This is complete horseshit. Anyone who still doesn't realize that this job is all about people, who thinks this is still about operating computers, has no business being any where near the design or implementation of a hiring process (or managing developers).

Humans over code. I make no apologies for that stance. And if you don't agree, we have nothing else left to talk about. Move along.

So, we have to vet candidates for a variety of technical skills, only one small part of that being coding. Is it really that much of a surprise that we do so poorly in hiring and placing individuals when the process we use for that only focuses on one tiny part of it?

## The Ideal Tech Interview

Here's my concept for the ideal tech interview. By the way, I'm going to say throughout "I ..." as if I'm the only one conducting all these steps. But that's not necessary. Other team members can absolutely help with different parts, and we can collect all that feedback together at the end.

First, my strong preference is that a candidate be able to demonstrate what they've done *over a period of time*, ideally at least 3-6 months. I don't need a picture of you over the course of *45 minutes* or even *4 hours*. That's not even close to a large enough time sample.

One great way this can be done is through someone's OSS work (on github, etc). That's by far not the only way to get this information -- I'll cover alternatives in a minute -- but it's in my mind a really good option if the person has done so.

What I want then is for them to submit links to 1-3 samples of recent (less than 2 years old) OSS work they've done, with some brief descriptions of what they contributed (especially if others participated, too).

What I'm looking for in my quick review (say, 15-20 minutes max) is:

* Can I see some samples of code they wrote?

* Can I see any documentation? How easy it to understand the project from the docs?

* Are there tests, and what do the tests look like? Are they insightful and well designed, or naive?

* Any open issues filed (by others)? How has this person triaged comments/questions from others?

* Any PRs opened? How did this person handle when someone wanted to change their code? Did they feel threatened? Did they respond cogently and respectfully?

After I've reviewed this material, if I feel I've seen enough that I can ask some questions, I'll want to schedule a call with the person, say for 30-60 minutes. On this call, I want that person to walk me through their submitted links. I'll hopefully have a bunch of questions I can probe with, but I'll want them to convince me that what I'm seeing is a good representation of how that person performed *as a developer* over the span of some time.

### Alternative To OSS Portfolio

If I'm interviewing a person who's well known publicly -- perhaps they've run some high profile OSS projects, or spoken at conferences, or written one or more books, or whatever -- then I would substitute review of some of those materials for at least some of the OSS portfolio submissions.

I'd still probably want to see at least one example to review, but depending on the body of public reputation/track record the person has, and the level of the position (highly specialist) we're hiring for, I wouldn't expect that person to re-prove all their technical chops. That part should be pretty obvious.

Let's say the person has no public resources to demonstrate their developer credentials.

My backup plan, which by the way any candidate could choose to participate in if they didn't *want* to use their public work, would be this:

1. I would clone a private github repo with a half dozen code files and resources in it, maybe something on the lines of a TodoMVC level of complexity.

2. I'd give access to the candidate, and give them a day or two to take a look at it at their own pace.

3. I'd ask them to send me a list of 1-3 observations or questions they have from looking at the repo.

4. Then I'd tell them that I would be assigning some small tasks to them over the course of the next few days. I'd set the expectation that they're going to spend, at most, 15-30 minutes on each task, and that total they may need to spend 60-90 minutes across all the tasks. I'd give them a window of 3-5 days to complete these, and I would deliberately spread them out.

5. One task might be to file a PR with a change to the code. I'd ask them to review the PR and make any comments they feel are necessary, and to ask any clarifying questions.

6. Another task might be to ask for a newly added feature to have some documentation written. Another might be to write tests for a segment of the code. Another might be to conduct a PR review of *their* code they added.

7. I might, in the persona of a customer, file a bug report (with very little information!), and ask the candidate to triage this report. I'd want them to politely ask for more information and follow-up to understand the bug report.

8. I'd iterate with the candidate on these kinds of tasks for a few days, never more than 15-30 minutes at a time, and let them tackle at their own pace (quickly or slowly), so as to not burden them too much.

9. Over the course of this interaction, I'd be gathering a bunch of observations about how they behave in these various scenarios. This is super valuable info. My goal is to collect over the course of these 60-90 minutes of interactions the same kind of insight as I could have gained if they had submitted the 1-3 OSS project links.

At the end, I'd schedule a short (30min max) feedback call, for the candidate to provide feedback to me, ask questions, etc, and for me to do the same with them, get any clarifications I may still be curious about.

## Next Steps

By the end of either a review session of existing OSS work, or the private re-creation of the whole software lifecycle process in the private repository, I would think I have a very solid idea of their technical skills.

In other words, at this point, they've been fully vetted technically. I've seen everything *technical* that I need to make my decision.

If they want to keep moving forward, and I like what I've seen, then we move onto the next stage: the in-person (or, in these COVID days, the group online) interview.

I would schedule a half day (at most) with the candidate. Here's how we'd break down that time:

1. (30 min) To start, I'd ask them to attend my team's standup (meeting/call). They don't have to speak, just want them to observe. Then I'd ask them to provide me 5-10 minutes of feedback on what they observed. What could they tell about what we're working on, where our blockers are, any potential communication gaps, etc?

2. (60 min) Next, I'd have them pair with a senior member of the team for about 30-45 minutes. Their goal should be to ask questions and watch as that team member worked on some task. Then I'd ask them to come back and give me the same sort of observation feedback.

3. (60 min) Next, I'd have them attend a team/group meeting. Again, no need to present, just observe. And ask questions if appropriate. Come back and give me any feedback.

4. (60-90 min) Lastly, I'd ask them to teach me something (they would be prepared for this in advance of the interview). I'd want to see how carefully they pay attention to me and the questions I ask as they explain some skill. This could be tech related, or not. Their choice. My objective is to see how well they communicate and share knowledge with others.

	**Note:** If they can't come up with anything suitable to teach me, I'd ask them (in advance of the interview) to take a quick 30-60min course on something, and then re-teach me what they learned.

At the end, I'd have one final short feedback session where I give them a chance to ask me any final questions, and provide any other observations they made while being embedded with the team for the (half) day.

## Final Steps

After the interview, I'd gather with any others who participated or observed the candidate, and collect their feedback. We'd discuss the pros/cons of this candidate.

Here's an important part: whether we decide to move forward or not, I would expect to need to provide some amount of concrete written feedback for them. I'd probably want to be able to provide at least 3-4 paragraphs, like half a page or a medium-length email, amount. I'd include quotes from other team members where appropriate.

My belief is that the candidate deserves this feedback, if they went through this whole interview process. Even if we're going to give them a job offer, I want to make sure they get feedback on the good stuff and on the constructive criticisms.

## Take Stock

Let's step back and consider what I'm suggesting:

1. The initial vetting of a candidate can take somewhere from 45 minutes up to 120 minutes. It might be on one single call, or it may be spread over ~ 3-7 days.

2. If the vetting passed, we'd invest up to 4 hours of interaction with me and our team.

3. In other words, the candidate has to be willing to give 5-6 total hours over the whole process. Most companies already require at least that much anyway. But in this way, some of that time is spread out, to make it easier for both the company and the candidate to fit it into their broader life/schedule.

Is this really an impossibly high bar? I don't think so. I think it's at least as much as a company should be willing to spend vetting and hiring a candidate.

And yes, if you're going to hire, you probably need to run ideally 3-10 candidates through some or all of this process, so each job opening might take upwards of 40-50 hours of company labor. But again, that's already happening at most teams, when you add up all the time recruiters, managers, and interviewers spend interacting with the candidate.

So I'm really not expanding the scope of interviewing burden, but re-purposing that time to be more well spent, focusing on signals rather than noise.

## Wrapping Up

There's a lot more details in between the lines of all these suggested ideas. And it's just a rough sketch, not a precise formula.

I suspect some readers will reject everything here entirely. That's fine. But I hope a few more of you take a step back and re-consider if your processes are actually asking *the right questions* of candidates.

Wouldn't you rather know how they're going to do when you file a bug against their code, than spending time checking to see what style of `for` loop/iteration they prefer?
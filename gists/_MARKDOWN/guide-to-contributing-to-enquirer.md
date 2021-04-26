# Guide to Contributing to Enquirer

## Welcome!

Thanks for choosing to contribute to Enquirer! We're so happy that you're contributing to open source projects, and we're even happier that one of those projects is ours!

## Teamwork

> There is no faster, more effective way to improve a product than from the feedback from the first experience of a new user -- [Jon Schlinkert](https://twitter.com/jonschlinkert/status/1115315646110343168)

Collaboration is a huge part of contributing to open source. As we get to know each other, not only will our trust grow, but we will also get a sense for one anothers strengths or preferences. This allows us to help each other out, or ask for help more effectively. 

### Learning phases

We believe every team follows a learning curve that resembles the following list. Our goal is to help you advance as quickly from one step to the next as you want:

1. **Orientation** - You aren't even sure where to start. Everyone begins here, on every project. Even the most experienced programmers need to poke around in a code base for a while before everything starts to click.  
1. **Ramp up** - You're getting familiar with the project, but you don't know it inside and out. 
1. **Familiar** - You can quickly identify what might be causing a bug, and you are able to fill in missing documentation with little or no guidance. 
1. **Mastery** - You could refactor the project from scratch with little guidance.

### One step at a time

It's important for you to know that you will never be judged for not knowing something, and every question you ask helps us to learn how to make our project better for unfamiliar users.

It's also important to know that even the most experienced programmers and maintainers feel completely and utterly overwhelmed when first diving into a new codebase or project. Not only do you need to learn a bunch of new code, but you need to learn code that was written by someone else! While that other person is watching you learn! 

But fear not! We completely embrace and enjoy the thrill of discovering new coding concepts and approaches to solving problems, and you will quickly find that the rush of discovery and the power of developing new programming skills will outweigh everything else!

Now that we've gotten to know each other a little bit, let's move onto our objectives!

## Objectives

**At any learning phase**

1. Have fun!
1. Learn the codebase
1. Identify bugs
1. Ideas for new features and improvements
1. Find gaps or errors in documentation


**When you're more familiar**

1. Fix bugs
1. Write new documentation
1. Optimize code
1. Add features


## Getting Started

The fastest way to get comfortable with a project, aside from reading through code and examples, is to read the documentation, and run unit tests and examples. But don't just run them in the command line, hack around with the tests and examples. Make them break, change them, log out values, and create new ones.

Also, keep checking the documentation while you're running the examples and docs. Look for features and options that are mentioned that you might have overlooked. Sometimes our brains tell us to ignore something we don't understand. We encourage you to seek out those revelations, look for code, examples, and documentation that you don't quite understand, and use that as an opportunity to fill in knowledge gaps about the project.

### First things first

To run Enquirer, you will need to have [Node.js](https://nodejs.org/en/) installed. 

Follow the installation instructions on [nodejs.org](https://nodejs.org/en/) to get everything set up. To check if everything is installed properly, run the following command in the terminal:

```sh
$ node -v
```

### Git-Clone Enquirer

```sh
$ git clone https://github.com/enquirer/enquirer.git my-enquirer
```

Then `cd` into the project:

```sh
$ cd my-enquirer
```

### Download dependencies

The following command will install all `dependencies` and `devDependencies`.

```sh
$ npm install
```

### Run unit tests

To ensure that everything installed correctly, run Enquirer's unit tests with the following command:

```sh
$ npm test
```

If all "checks" are green, you're good to go!


## Developing Enquirer

To become acquainted with the Enquirer codebase, start by playing around with code in the following directories:

```
/examples
/test
```

This activity will lead to your first contribution to Enquirer!

### Goals while running Examples

Take some time to run examples for each prompt type. Try creating new examples with different configurations to see how prompts behave in different scenarios. You can do whatever you want! Feel free to break things, it's how we learn!

**Learn how the prompts work**

Getting familiar with the prompts as a user will make it easier to understand the code when you begin hacking around in the codebase.

**Identify and record bugs**

You will most likely find bugs while your running the examples. They will fall into at least the following categories:

1. _Incorrect code in the examples_ - Sometimes maintainers forget to update the examples after API changes are made. 
1. _Obvious errors_ - There are scenarios where errors are supposed to be thrown. Like when an invalid valid is passed to a prompt. Or in test assertions that are explicitly testing errors. Aside for those situations, if a prompt throws an error, it's a bug.
1. _Unexpected behavior_ - If it seems like a prompt is behaving in a way that is unexpected, the first goal is to rule out user-error by checking the documentation and searching the unit tests for code examples that might explain what you're seeing. After that, if you still think it's bug, then it's probably a bug. 

**Reporting bugs**

Depending on your [learning phase](#learning-phases), when you identify a bug we recommend the following steps:

1. **Orientation** - Write them down throughout the day. Make sure you write a description that will help us understand the bug you're experiencing. Also save a code example that demonstrates the bug with the least possible code and configuration, so that we can reproduce it easily. Towards the end of your day, give yourself enough time to create an [issue on GitHub](https://github.com/enquirer/enquirer/issues) with all of the details you recorded. (Until you get more familiar with the project, you might want to use an issue `title` like: Potential )
1. **Ramp up** - Create issues, with clear descriptions and labels
1. **Familiar** - Submit a pull request with a fix!
1. **Mastery** - You will tell us what do to!

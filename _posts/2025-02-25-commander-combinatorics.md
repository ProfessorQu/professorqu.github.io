---
layout: post
title: 'Commander Combinatorics: Counting the Deck Possibilities'
categories:
- Magic the Gathering
- Math
tags:
- Magic the Gathering
- Commander
description: A calculation of the number of possible decks.
math: true
image:
  path: "/assets/img/posts/commander-combinatorics/preview.jpg"
  alt: Some random math
date: 2025-02-25 21:37 +0100
---
In this article I will calculate how many possible combinations of cards could be in the command zone. To do this I will use math and combinatorics together with [Scryfall](https://scryfall.com/).

## Single Commanders

To calculate all the possibilities for the command zone, you might think: just a simple scryfall search and we're done. This is not true, but it is a good starting point. First we can get all commanders by searching using the tag `is:commander`. This includes creatures from MTG Arena so to remove those we will add `game:paper`. Searching Scryfall with [`is: commander game:paper`](https://scryfall.com/search?q=is%3Acommander+game%3Apaper) gives us 2413 results. Some of these however can't be used on their own, these are Backgrounds. Running an [updated search](https://scryfall.com/search?q=is%3Acommander+game%3Apaper+-t%3Abackground) gives us 2383 cards. So, is this the answer?

## Partners

2383 is just the beginning, we are going to add to this number by doing a few more searches. If we search for cards with partner (`o:partner`) then we also get cards like [Blue, Loyal Raptor](https://scryfall.com/card/rex/8/blue-loyal-raptor):

<div style="width:100%;height:30em;display:flex">
  <img src="https://cards.scryfall.io/large/front/0/a/0a764ec9-6a30-4df3-91b4-c64fd8e32fa0.jpg?1698988752"
  style="border-radius:5%" alt="Blue, Loyal Raptor">
</div>

We can fix this by **not** searching for cards with "Partner with": `-o:"partner with"`. [Searching on Scryfall](https://scryfall.com/search?q=is%3Acommander+game%3Apaper+o%3Apartner+-o%3A%22partner+with%22) gives us 63 results. Now we want to use some combinatorics, namely: 63 choose 2 as each of the commanders with partner can be partnered with each other one. This can be calculated as ${64\choose2} = \frac{64!}{62!\cdot2!} = 1953$. Bringing our running total to: 4336.

## Partner with

The easiest way to calculate how the possibilities for partner with can be calculated is by finding the total commanders with it and dividing by two. Given that the total count is twice as large as the amount of partners. Running [the Scryfall search](https://scryfall.com/search?q=is%3Acommander+game%3Apaper+o%3A%22partner+with%22) gives us 38 cards so 19 extra for a total of 4355.

## Friends Forever

Friends forever is the same as partner but these cards can only partner with themself. As there are [seven of the cards](https://scryfall.com/search?q=is%3Acommander+game%3Apaper+o%3A%22friends+forever%22), the number of combinatinations is ${7\choose2} = \frac{7!}{5!\cdot2!} = 21$. Making the total 4376.

## Choose a Background

<div style="width:100%;height:30em;display:flex">
  <img src="https://cards.scryfall.io/large/front/2/5/25564fba-5765-457b-8dd3-f26b877221b8.jpg?1732545989"
  style="border-radius:5%" alt="Amy Pond">
</div>

For this we have to have a commander that has "Choose a Background" and a, well, Background. [Searching for "Choose a Background"](https://scryfall.com/search?q=is%3Acommander+game%3Apaper+o%3A%22choose+a+background%22) gets us 32 results. [Searching for Backgrounds](https://scryfall.com/search?q=is%3Acommander+game%3Apaper+t%3Abackground&unique=cards&as=grid&order=name) gets us 30. Now we multiple these $32 \cdot 30 = 960$ for a current total of 5336, we have to subtract one from this however due to [Faceless One](https://scryfall.com/card/clb/1/faceless-one), there is one combination of commander-Background where it is both Faceless One, but that is not possible so we remove it giving us a running total of 5335.

## Doctor's Companion

[Searching for cards with "Doctor's Companion"](https://scryfall.com/search?q=is%3Acommander+game%3Apaper+o%3A%22doctor%27s+companion%22) gets us 27 cards. Doctor's Companion works in the way that they can be partnered up with a legendary Time Lord Doctor, [if we search using this](https://scryfall.com/search?q=is%3Acommander+game%3Apaper+t%3Alegendary+t%3A%22time+lord%22+t%3Adoctor) we find 17 cards that fit the criteria. Simple calculations show us that there are $27\cdot 17 = 459$ combinations. And with that we end up with a total of 5794 possibilities for commanders in the command zone.

## Doubles

<div style="width:100%;height:30em;display:flex">
  <img src="https://cards.scryfall.io/large/front/e/5/e50a2faa-91e3-4e89-ba8d-2cbf7ac005c0.jpg?1696691798"
  style="border-radius:5%" alt="Amy Pond">
</div>

There are a few cards, like [Amy Pond](https://scryfall.com/card/who/75/amy-pond) which has multiple ways to partner with another card but that doesn't matter because all the ways I've counted are combinations, so Amy Pond can be played alone, with Rory, or with one of the 17 Doctors. So there should not be any doubles unless I've missed something.

## Conclusion

I created a simple script on [Gist](https://gist.github.com/ProfessorQu/05dadef3647162e6761a0b983f2ad474) so I could see if my experiment was correct and I actually made a mistake because, in a previous draft of this article, I said that 38 / 2 = 14. Oops. Now it's fixed of course and that is why I can say that, at the time of the publishing of this article there are 5794 different possibilities for cards in the command zone. This number is subject to a lot of change because if there is one more legendary creature the number goes up. Also if creatures get banned or there are more partners printed then the number will dramatically shoot up. Or maybe WoTC will invent another partner-like mechanic! The possibilities are endless, but for commander, they are not.

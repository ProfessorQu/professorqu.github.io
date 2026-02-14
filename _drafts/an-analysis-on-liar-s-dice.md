---
layout: post
title: An Analysis on Liar's Dice
categories:
- Technical
- Math
- Statistics
tags:
- Tech
- Game
description: An analysis on the best strategies for Liar's Dice.
math: true
---

A friend of mine recently got me the game [Liar's Bar](https://store.steampowered.com/app/3097560/Liars_Bar/). And it is a great game. There are a lot of games that have some sort of bluffing. After playing all the games for a bit I started analyzing them. Thinking of different strategies and what would be the best options. That has led me to writing this article about the first game [Liar's Dice](https://en.wikipedia.org/wiki/Liar%27s_dice). In this article I will outline how the game is played, what the probabilities involved are and finally an analysis of a few different strategies to see which one works best.

## Rules

There are two variants of the game and I will discuss both. The first variant is *Basic*. This is the default gamemode in Liar's Bar. You play the game with 2-4 players and each player gets five 6-sided dice and rolls them secretly. Each player can look at their own dice without revealing them to other players.

The first player places a bid of some number of faces, claiming that there are at least that many dice with a certain face. Then the next player can up the bid by either claiming more dice of the same face, the same number of dice of a higher face or both. Apart from upping the bid, the next player can also call **Liar** or **Spot on**.

If they call **Liar**, each player reveals their dice and the last placed bid is checked. If the bid is correct, the one who called **Liar** drinks one dose of poison. If the bid is incorrect however, the player who placed it drinks one dose of poison.

If a player calls **Spot on** all dice are revealed and are checked against the last bid again. If it is EXACTLY correct, everyone but the player who called **Spot on** must drink, if it is not exactly correct, the caller must drink instead.

Whenever a player has drank their two doses of poison that player dies and can no longer play. In the case that **Spot on** was called and was correct, the one who called it goes first in the next round. Otherwise, play continues as normal, starting from the loser. But if the loser died then the next player after them starts instead.

*Traditional* works the same as basic but dice with ones on them count as all other faces. They basically become a wildcard.

## Probabilties

As everyone knows, the probability of rolling a specific number on a 6-sided die is $\frac{1}{6}$. We are interested in the number of dice that are of a certain face $F$ and the amount $X$. First we'll look at a two player game and then later we will look at more players. If we look at a certain face we can look at it's probability of appearing in a game.

$$
P(F = 1, X = 1)=\frac{1}{6} \cdot \frac{5^9}{6^9}\approx 0.032
$$

So there is a 3.2% chance of exactly a single one appearing in a game of Liar's Dice between two players. However, for every game we know exactly what our dice are, therefore we can just look at the probabilities of our opponent. One more optimization we can do is ignore what face exactly we use, for the *Basic* gamemode this is not required as each face has the same chances and are functionally identical. Therefore the previous probability becomes.

$$
P(X = 1) = \frac{1}{6} \cdot \frac{5^4}{6^4}\approx 0.080
$$

Therefore the chance to get exactly a single die of any specific face on an opponents dice is about 8.0%. But this is not correct, as we forgot to account for the possibility of X-1-X-X-X as well as X-X-1-X-X, X-X-X-1-X and X-X-X-X-1, where X is not 1. Therefore we need to multiply the probability by 5 to get the correct result. Doing this results in approximately 40%.

We multiply by 5 to get the correct result, but this is not always the same, as for the possibilities of no ones, where the one is does not matter. And for 2 there are more possibilities for ordering. I am not the first to discover this fact and therefore a [Binomial Distribution](https://en.wikipedia.org/wiki/Binomial_distribution) was created:

$$
P(X = k) = \binom{n}{k} p^k (1-p)^{n-k}
$$

Where $n$ is the number of trails, in our cause 5. This uses the [Binomial coefficient](https://en.wikipedia.org/wiki/Binomial_coefficient) which is defined as follows.

$$
\binom{n}{k} = \frac{n!}{k!(n-k)!}
$$

Which for $k = 1$ is exactly 5 and for $k = 0$ it is 1! Now we have a precise definition for a probability and with it we can continue our calculations.

### Imprecise Probabilities

Now, this is all quite useful, we could calculate what the chances are that, if we have 3 sixes that 4 sixes are spot on, but we can't calculate the chances that there are at least 3 fives when we have none. But to do this, we can simply sum our existing probabilities.

$$
P(X \geq k) = \sum_{i=k}^n P(X=i) = \sum_{i=k}^n \binom{n}{i}p^i(1-p)^{n-i}
$$

Using this we can now calculate what the probabilities are that a certain bet is correct. Say my opponent bids 3 fours, and I have none. Then the chances of them being correct are $P(X=3) + P(X=4) + P(X=5)$ $\approx 0.03215 + 0.003215 + 0.0001286 $ $\approx 0.035$, or 3.5%.

### Conclusion

To adjust these formulas for more players we can simply look at the number of players and increase $n$ by 5 for each opponent. Finally, the chances of having at least some number $k$ of a certain face with $n$ dice that opponents roll (5 per) given that we have $k_0$ dice of that face ourselves is:

$$
P(X \geq k - k_0) = \sum_{i=k - k_0}^{n} \binom{n}{i}p^i(1-p)^{n-i}
$$

Now we can get into some strategies using the knowledge we have obtained here.

## Strategies

There are a bunch of strategies that are possible and I will outline all of them here and then at the end show you which ones ended up being the most effective. But we'll have to start with the dumb strategies.

### Basic Strategies

#### Random

#### Increase amount

#### Increase face

#### Increase amount + face

#### Liar

#### Spot on


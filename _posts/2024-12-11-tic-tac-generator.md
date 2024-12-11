---
layout: post
title: Tic Tac Generator
categories:
- Technical
- Program
tags:
- Rust
- Tic Tac Toe
- AI
description: How I made a 3500 line Python file to play Tic Tac Toe
image:
  path: "/assets/img/posts/tic-tac-generator/preview.png"
  alt: Tic Tac Toe
date: 2024-12-11 21:49 +0100
---
> Find the source code on [Github](https://github.com/ProfessorQu/tic-tac-gen)
{: .prompt-tip}

Some of you may have seen those memes where someone programs chess using a lot of print statements and if statements. I thought this was interesting, so I created it, but for Tic Tac Toe.

![Meme](/assets/img/posts/tic-tac-generator/meme.jpeg)
_Meme, sidenote: 2,605,200 is way too little_

## Game tree

So I had the idea of creating a game tree, with values for each cell. I wanted to do this to hopefully make it easier to then generate the file. First, I generated the entire tree and assigned each state a value, if O wins -1, if X wins 1 otherwise 0. I used a sort of minimax where I looked at each state and their children and if there was one child that would be chosen over all the others, assign the value of that child to the current state. If that state doesn't end in a terminal way however (e.g. it is not a guaranteed win or loss), assign it the value of all it's children, averaged. This way it ends up preferring ways of play that can allow it more options for a win. It will contain about 255168 nodes, which is quite a lot but [Math Stackexchange](https://math.stackexchange.com/questions/269066/game-combinations-of-tic-tac-toe) agrees with me exactly, so no worries.

![Game Tree](/assets/img/posts/tic-tac-generator/game_tree.png){: .dark}
![Game Tree](/assets/img/posts/tic-tac-generator/game_tree_light.png){: .light}
_A part of a game tree_

## Collapsing

After generating a game tree with all the values and everything, I then wanted to find some way to condense it. If we are playing against an AI, then we can "collapse" the game tree. With this I mean that we keep the entire tree exactly as it is, however we skip O's turn for what the best move is. I did this by skipping to the children of the state when it was the human player's turn. When it wasn't I chose the state with the highest score and simply replaced the current state with that one.

![Collapsed Game Tree](/assets/img/posts/tic-tac-generator/collapsed_game_tree.png){: .dark}
![Collapsed Game Tree](/assets/img/posts/tic-tac-generator/collapsed_game_tree_light.png){: .light}
_A part of a collapsed game tree_

## Tests
By the way, most of the code that I wrote was recursive. The generating and collapsing were both recursive and really hard to debug as the entire game tree was really big and almost impossible to debug. I added some tests and with those I convinced myself eventually that it works but it was a tedious process. It was quite fun to work on though, as it was not a very difficult project but it did generate it's own unique challenges.

## Results
Making the code was actually pretty easy. For each node we start by adding a question for input, then we want to check the move and then print the board and recur this for each possible move.

Eventually, I ended up with a file that is about 2860 lines long, but each generation gives a different file length, probably because I store everything in a HashMap and some other reasons (picking a longer path to victory maybe?). I dislike that and I did fix it, just as how I've set it up I could implement it for more languages but I'm more interested in making it more reproducable and generating the least amount of lines. The file that I have now is 117 KB, but again I want to try and maybe make it more reproducable.

I updated the code so that the value is updated on each iteration and it brought the line count to a solid 2040 lines and 82 KB. I reduced the value by timesing it by 0.99 each iteration so that it is slowly reduced. So it's finally finished (for now...). The project brought up a few fun problems to solve that's for sure.

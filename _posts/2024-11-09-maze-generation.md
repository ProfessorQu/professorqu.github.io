---
layout: post
title: Maze Generation
categories:
- Technical
- Program
tags:
- Tech
- Rust
- SDL
- Mazes
description: Some maze generation algorithms
image:
  path: "/assets/img/posts/maze-generation/preview.png"
  alt: A generated maze
date: 2024-11-09 21:44 +0100
---
## Intro

This post outlines a bunch of maze generation algorithms. I implemented all of them in Rust, if you want to look at the code here's [the GitHub repository](https://github.com/ProfessorQu/maze-gen-and-solve). All of these algorithms and their implementations were taken from [Jamis Buck's blog](https://weblog.jamisbuck.org/under-the-hood/). I added some CLI arguments using `clap` and used `SDL` to make it easier to use and actually show the mazes while they're being made.

## Recursive Backtracker

![Recursive Backtracker](/assets/img/posts/maze-generation/recursive_backtracker.gif)

[Recursive backtracking algorithm](https://weblog.jamisbuck.org/2010/12/27/maze-generation-recursive-backtracking.html) is very simple, it keeps a path and then just tries to go in a random direction and if it has no direction to go it goes back one. It repeats this until completion.
```
path = []

while path is not empty:
  last = path.pop()

  if last.has_unvisited():
    unvisited_neighbor = last.random_unvisited()
    last.remove_wall_to(unvisited_neighbor)
```

## Eller's Algorithm

![Eller's Algorithm](/assets/img/posts/maze-generation/ellers.gif)

[Eller's algorithm](https://weblog.jamisbuck.org/2010/12/29/maze-generation-eller-s-algorithm.html) is one of the fastest maze generation algorithms. It works by giving each cell in the first row its own set. Then randomly join these sets after that make at least one connection downward for each set and set the rest of the cells to new sets. Do this for every row but the last one where we join all disjoint sets.

## Kruskal's Algorithm

![Kruskal's Algorithm](/assets/img/posts/maze-generation/kruskal.gif)

[Kruskal's algorithm](https://weblog.jamisbuck.org/2011/1/3/maze-generation-kruskal-s-algorithm.html) is not very efficient or particularly nice to watch. It takes all the walls and randomly removes it if the cells aren't in the same set and then joins the cells into the same set. This will make it so that each cell has at least one connection to every other.

## Prim's Algorithm

![Prim's Algorithm](/assets/img/posts/maze-generation/prim.gif)

[Prim's algorithm](https://weblog.jamisbuck.org/2011/1/10/maze-generation-prim-s-algorithm.html) is probably one of my favorite algorithms to watch. It works by randomly selecting one of the cells in the purple set and then adding a wall to one of the cells that have been visited (white cells), then adding the neighboring cells that aren't visited to the purple set. I think it looks very cool.

## Recursive Division

![Recursive Division](/assets/img/posts/maze-generation/recursive_division.gif)

[Recursive division](https://weblog.jamisbuck.org/2011/1/12/maze-generation-recursive-division-algorithm.html) is a very neat algorithm, also the only one that adds walls instead of removing them. It works by creating a wall with a passage based on a rectangle, then separating the two sides into two rectangles and doing that recursively. Or, you could say, it divides recursively (*that's the name of the algorithm!*).

## Aldous-Broder Algorithm

![Aldous-Broder Algorithm](/assets/img/posts/maze-generation/aldous_broder.gif)

[Aldous-Broder](https://weblog.jamisbuck.org/2011/1/17/maze-generation-aldous-broder-algorithm.html) is probably the most frustrating to watch and probably the slowest algorithm. It moves randomly and if it moves from visited cells (white) to unvisited ones it removes a wall, that's it. It's a very simple algorithm but for large mazes it could take a little while to find the last unvisited cells.

## Wilson's Algorithm

![Wilson's Algorithm](/assets/img/posts/maze-generation/wilson.gif)

[Wilson's algorithm](https://weblog.jamisbuck.org/2011/1/20/maze-generation-wilson-s-algorithm.html) is very similar to <a href="#aldous-broder-algorithm">Aldous-Broder</a>. It takes some random starting point and moves randomly until it finds some visited cells, after that it chooses a new location until it can't choose anymore. It looks way cooler than <a href="#aldous-broder-algorithm">Aldous-Broder</a> and is more efficient but the first contact could still take a while.

## Hunt-and-Kill Algorithm

![Hunt-and-Kill Algorithm](/assets/img/posts/maze-generation/hunt_and_kill.gif)

[Hunt-and-Kill](https://weblog.jamisbuck.org/2011/1/24/maze-generation-hunt-and-kill-algorithm.html) is very similar to the <a href="#recursive-backtracker">Recursive Backtracker</a>, it works almost exactly like it, but if it gets stuck it scans the grid to find a new starting point. It continues like this until there are no more spaces to start from.

## Growing Tree Algorithm

![Growing Tree Algorithm Last](/assets/img/posts/maze-generation/growing_tree_last.gif)

[Growing Tree](https://weblog.jamisbuck.org/2011/1/27/maze-generation-growing-tree-algorithm.html) is a very interesting algorithm as it is very similar to some other algorithms. If you configure it like the GIF file above it is exactly the same as the <a href="#recursive-backtracker">Recursive Backtracker</a>. The Growing Tree algorithms works by creating a set of cells, then selecting a cell from that set (this is configurable), then carving a passage to a neighbor or removing the cell from the set if there are no neighbors. If you set the cell selecting algorithm to the last cell added then you get the <a href="#recursive-backtracker">Recursive Backtracker</a>. If you choose the first cell you get this:

![Growing Tree Algorithm First](/assets/img/posts/maze-generation/growing_tree_first.gif)

This is very weird and not a very good way of generating a maze, we can also choose a random cell and then it is almost exactly like <a href="#prims-algorithm">Prim's Algorithm</a>:

![Growing Tree Algorithm Random](/assets/img/posts/maze-generation/growing_tree_random.gif)

## Binary Tree Algorithm

![Binary Tree Algorithm](/assets/img/posts/maze-generation/binary_tree.gif)

[Binary Tree](https://weblog.jamisbuck.org/2011/2/1/maze-generation-binary-tree-algorithm.html) works by simply randomly creating a passage upward or to the left for each cell if it can. Therefore, it creates these passages along the top and left of the maze, because there is only one direction it creates directions in.

## Sidewinder Algorithm

![Sidewinder Algorithm](/assets/img/posts/maze-generation/sidewinder.gif)

[Sidewinder](https://weblog.jamisbuck.org/2011/2/3/maze-generation-sidewinder-algorithm.html) we create a run set that expands to the right and randomly choose when to create an upward connection between the run set and the row above. When we do so we start a new run set and keep repeating this for each row.

## Wrapping up

So these were some maze generating algorithms, I enjoyed implementing them. I'm thinking of implementing some pathfinding algorithms to solve these mazes. I also want to implement some tests for the maze generating algorithms, maybe try to find some more and benchmarking all of them. If I do any of these things and feel like writing about them then I will.

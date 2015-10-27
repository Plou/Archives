---
layout: post
title:  "natural bloc columns sorting"
date:   2013-08-27 16:17:15
categories: [code]
tags: [experiment, front end, ergonomy, responsive]
description: "how to sort and build a cart chronologic list"
---

# From comics to news thread

## A trend
When Pinterest tills layout show up, everybody wanted the same thing on their websites.

## A problem to solve
I will not discuss the pertinence of this choice but I'll focus of a problem that can occur when you try to apply this layout to a list of chronological contents.
With any content the trick is to fill the smallest column with the next content but if you want to keep the ordering  it’ll not work.

**Illustration of Pinterest way**

You could fill it from left to right and it’ll do a good job. But when you deal with real life clients you know that a four lines title with 6 lines sum up and a pictures will eventually be side by side with a two word title, no picture. Even if the editor try to homogenize each item, the user could and will zoom the font size, the screens width will affect too blocks width & height...

**Illustration sadly it's broken,**

You’ll have a first, second and perhaps a third well ordered line, but eventually the more you dive into the older posts the chronological order will break.

## So how can we prevent this ?

So we have to figure out what the natural reading way is.
What is the next item our eye will consider as the following content ?

If we translate it to the code side the question we'll have to answer is: ’when to discard a column and put the next item in an another one’. Then a new interrogation arise, which column we choose ?

**Illustration of were to put the next one**

Our script must be smarter than what we could have expected. How  translate a natural behavior to a script.
First, we have to somehow know how we do it ourself. Hopefully we're aren't the first ones to look for an answer here! It is what do comics writer since years. They put block from left to right and top to bottom that have a chronological ordering.

Obviously we don't have the same control about the size and position of our content as them, but it's a good hint.

** Illustration on how to do It **

From this sketch we can see that the column to chose for the next content is related to the offset between the previous column bottom and the one will could put our block in.

Now if we transpose this acceptable offset to a constant and compare it each time we put an element in a column we will achieve a nice ordering !
It also allow us to play slightly with this constant to adapt it to the content, the size of the screen, the number of columns, rows etc…

**Result**

Enjoy playing with it, and help me improve it [here](http://github.com/Plou/jCascading)

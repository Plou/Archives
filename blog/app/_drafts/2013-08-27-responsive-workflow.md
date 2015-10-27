---
layout: post
title:  "Responsive workflow"
categories: [code]
tags: [responsive,front end,workflow]
description: "An effective & agile way of thinking responsive design"
---

# Responsive workflow, a case study.
## Right now
In the better world, building websites shouldn't be related to the tools used to access the information on it. To make the list short, think about how many size exist from a phone screen to giant 27"… Then add the ways of interacting with them: mice, keyboard, finger, etc… For the topping we even have to think about screen readers which doesn't even display anything !

Now that we know that, how much sense make designing a fixed 1024px wide mock-up ?

    Figure : a fixed layout behind screens size layer

A solution is the **mobile first** approach. Designer are used to do fixed layout, so making a narrow mobile layout first make it really easy to imagine what the wide screen will look, and then you can end up with a flexible (responsive) interface.

As the design become more focused on the content, we should do the same. If all pieces of content behave well from a mobile width to a wider size, all we have to do is to organise them from one tall column to a larger layout. It's easier to fill space than compress contents.



## what
It now obvious making a unique fixed design is absurd.   Making one for each device is Dumb too. So how can a designer plan the website without ending crazy but achieve with a final result -pixel- percent perfect ?
I'll be talking about non-coding designer and forget about HTML prototype on purpose.

### design
So how can we design a website with the fewest mock-up
? As of now a common number is between 3 to 4 :
- small screens like vertical mobiles
- standard size like horizontal tablets
- an half way, big landscape mobiles or portrait tablets
- some times a wide version for big desktop screens (> 1200px with a common pixel density).

Making them can be really time consuming and needs good understanding of the programming constrains.
It also ask thinking simultaneously of three versions of each content being designed.

The easiest material to fit in any shape is liquids. You don't have to worry, it'll behave well in a tall and narrow glass, and still be nice in a little and large glass.

So how about designing fluids design ?

### program

To achieve a abstraction of the content size, we'll have to forgot about pixels, they will be important for only one purpose, breakpoints.


## how
### design
A solid grid is the key. If the grid is well planned, the transition from big to small screen will be natural. Making different size of columns of content between readable sizes not so large and then easing the adjustments.
I don't think multiplying interfaces won't be necessary anymore, two extreme should be enough to start the front-end developing.
Refining the in betweens will occur once the development started.


### program
When programming we should keep in mind the differences between user. A 1024px screen with ie8 (less shouldn't exist anymore) will display your website without knowing about media queries, so if you need them to have a nice experience build your site for them. And then make it responsive for all the others who'll understand media queries.


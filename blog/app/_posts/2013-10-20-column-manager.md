---
layout: post
title:  "Column manager"
categories: [code]
tags: [ergonomy,front end]
description: "a simple webApp like layout manager"
---

# A script to manage a webApp like layout

Building this web site I came across the problem of managing columns so the layout don't break on any device size.
I first Tried with pure css, using flex display property, I wanted to try it. I made a first version of this website with it, I almost achieved what I wanted but the result wasn't exactly what I had in mind, I had to put some javascript in it to manage some features and the resulting CSS was far too long and not future friendly at all. If I wanted to change the default size of one column I had to edit at least 5 or 6 lines...

So I decided to build a script who will manage the columns for me. The purpose was to give it a simple columns & views configuration and let him handle everything.

The down size was the loss of support on browser with javascript disabled. But with the use of table-cell display I achieved a graceful degradation. Managing my layout with Javascript also widen my browser compatibility.

Here is how to use it :

## How to use it
Create a bunch of columns with a identifier, min, max and medium sizes.

### Columns
{% highlight javascript %}
    c1 = new column "column-1", 20, 100, 50
    c2 = new column "column-2", 40, 600
    c3 = new column "column-3", 20, 150
    c4 = new column "column-4", 20, 100
    c5 = new column "column-5", 100
{% endhighlight %}

### Views
Create one or more views with sets of size, if the last size can't be satisfied the next set will be used.

{% highlight javascript %}
    vMain = new view "main",
      [
        [c1.max, c2.max, c3.max, c4.max, c5.min]
        [c1.medium, c2.max, c3.max, c4.max, c5.min]
        [c1.medium, c2.max, c3.max, c4.min]
        [c1.medium, c2.max, "hide", c4.min]
        [c1.medium, c2.max, c3.min]
        [c1.medium, c2.max]
        [c1.min, c2.min]
      ]
{% endhighlight %}

### Let it manage the columns
At last create the manager with columns and views.
{% highlight javascript %}
    cManager = new columnManager "cManager",
      [c1, c2, c3, c4, c5],
      [vMain]
{% endhighlight %}

### Ask it to change the view
Use views to switch displayed columns
{% highlight javascript %}
    cManager.setView("vMain")
{% endhighlight %}


## Tips
The default event used to refresh the manager is the resize event on the window, you should use your how resize event to keep your performance high.

You can use the keyword "hide" instead of a column size to not display the chosen column for the current set of sizes.

## Demo & Code
You can check the light demo [here](http://plou.github.io/demo/columnManager/)

Please fork or send me requests and help improve it at [gitHub](https://github.com/Plou/columnManager)
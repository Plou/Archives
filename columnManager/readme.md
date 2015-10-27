# Column Manager
A javaScript library wrote in cofeeScript to help you managing a multiple column webApp like layout.

It is used on <a href="http://plou.github.com">plou.github.io</a> and a 5 columns light demo exist <a href="http://plou.github.com/demo/columnManager/">here</a>

## How to

Create a bunch of columns with a identifier, min, max and medium sizes.

    c1 = new cManager.column("column-1", 20, 100, 50);
    c2 = new cManager.column("column-2", 40, 600);
    c3 = new cManager.column("column-3", 20, 100);
    c4 = new cManager.column("column-4", 20, 100);
    c5 = new cManager.column("column-5", 100);

Create a view with sets of size, if the last size can't be satisfied the next set will be used.

    vMain = new cManager.view("main", [[c1.max, c2.max, c3.max, c4.max, c5.min], [c1.medium, c2.max, c3.max, c4.max, c5.min], [c1.medium, c2.max, c3.max, c4.min], [c1.medium, c2.max, c3.min], [c1.medium, c2.max], [c1.min, c2.min]]);

At last create the manager with columns and views.

    cManager = new cManager.columnManager "cManager",
      [c1, c2, c3, c4, c5],
      [vMain]

Use views to switch displayed columnds

    cM = new cManager.columnManager("cManager", [c1, c2, c3, c4, c5], [vMain]);

Ask it to change the view

    cManager.setView("vMain")

## Tips
- The default event used to refresh the manager is the resize event on the window, you should use your how resize event to keep your performance high.
- You can use the keyword "hide" instead of a column size to not display the chosen column for the current set of sizes.

## Licence
<a href="http://www.gnu.org/licenses/gpl-3.0.html">GPL v3</a> (c) <a href="https://twitter.com/@devPlou">Plou</a>

## Change log

###1.2.0 :
- jquery is now a dependency
- a small change in the way the cManager object is populated to the window object
- temporary removal of livereload

###1.1.0 :
- removed the mandatory custom *endResize* Event, default resize event on window i now used. The last parameter of the columnManager constructor can override it
- added gruntFile.js and package.js to ease getting started
- reworked the example

###1.0.2 :
- first fonctionnal version whith a bower manifest ;)
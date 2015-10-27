$(function() {
    $(window).ready(function() {
        var c1, c2, c3, c4, c5, vMain, view;

        c1 = new cManager.column("column-1", 20, 100, 50);
        c2 = new cManager.column("column-2", 40, 600);
        c3 = new cManager.column("column-3", 20, 100);
        c4 = new cManager.column("column-4", 20, 100);
        c5 = new cManager.column("column-5", 100);

        vMain = new cManager.view("main", [[c1.max, c2.max, c3.max, c4.max, c5.min], [c1.medium, c2.max, c3.max, c4.max, c5.min], [c1.medium, c2.max, c3.max, c4.min], [c1.medium, c2.max, c3.min], [c1.medium, c2.max], [c1.min, c2.min]]);

        cM = new cManager.columnManager("cManager", [c1, c2, c3, c4, c5], [vMain]);

    });
});

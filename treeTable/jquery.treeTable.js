/*
 * TreeTable
 *
 * cplou@inouit.com
 */

var TreeTable = {}
// Table
TreeTable.Table = function(element, settings) {
    // settings
    var _this = this;
    this.element = element;

    if (!settings){
        this.element.prepend('<p class="error">I\'m lost ! Can you give me some more informations please :</p> <ul><li>{ "levelClass" : "level-" }</li>')
        return;
    }

    this.settings = settings;

    if (!this.settings.levelClass){
        this.element.prepend('<p class="error">I\'m lost ! Can you give me some more informations please :</p> <ul><li>{ "levelClass" : "level-" }</li>')
        return;
    }

    // set rows and levels
    this.rows = this.element.find('tr');
    this.height = this.rows.length;
    for( var i = 0; i < this.height; i++) {
        this.rows[i] = new TreeTable.Row(jQuery(this.rows[i]), this.settings);
        this.rows[i].index = parseInt(i);
    }
    this.setGroups()
};

TreeTable.Table.prototype.setGroups = function() {
    var goNext = false
    var current = 0
    for( var i = 1; i <= this.height; i++) {
        if (goNext){
            if (this.rows[current].children.length){
                this.rows[current].element.addClass('hasChild');
            }
            current = i-1
        }

        if (i <= (this.height - 1) && parseInt(this.rows[current].level) == parseInt(this.rows[i].level) - 1) {          
            this.rows[current].addChild(this.rows[i]);
            goNext = false;
        }
        else if ( i <= (this.height - 1) && parseInt(this.rows[current].level) < parseInt(this.rows[i].level) ){
            goNext = false;
        }
        else {
            goNext = true;
            i = current+1
        }
    }
};


// Row
TreeTable.Row = function(element, InheritedSettings) {
    var _this = this;
    this.element = element;
    this.settings = InheritedSettings;
    this.children = [];
    this.setLevel();
    this.element.bind('click', function(e){
        e.stopPropagation();
        _this.toggle(_this);
    });
    this.element.css('cursor', 'pointer');
};

TreeTable.Row.prototype.setChildren = function(children) {
    this.children = children;
};

TreeTable.Row.prototype.addChild = function(child) {
    this.children.push(child);
};

TreeTable.Row.prototype.setLevel = function() {
    var elementClasses = this.element.attr('class').split(' ');
    var classesLength = elementClasses.length;
    for (var i = 0; i < classesLength; i++) {
        if (elementClasses[i].indexOf(this.settings.levelClass) >= 0) {
            this.level = elementClasses[i].replace(this.settings.levelClass, '');
        }
    }
};

TreeTable.Row.prototype.unFold = function() {
    var childLength = this.children.length;
    for (var i = 0; i < childLength; i++) {
        this.children[i].element.show();
    }
    
    this.foldState = false;
    if (this.children.length){
        this.element.removeClass('folded');
    }
};

TreeTable.Row.prototype.fold = function() {
    var childLength = this.children.length;
    for (var i = 0; i < childLength; i++) {
         this.children[i].element.hide();
         this.children[i].fold()
    }
    this.foldState = true;
    if (this.children.length){
        this.element.addClass('folded');
    }};

TreeTable.Row.prototype.toggle = function(_this) {
    if (_this.foldState) {
        _this.unFold();
    }
    else {
        _this.fold();
    }

};

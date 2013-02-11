/**
 * FeyaSoft MyCalendar
 * Copyright(c) 2006-2012, FeyaSoft Inc. All right reserved.
 * info@cubedrive.com
 * http://www.cubedrive.com
 *
 * Please read license first before your use myCalendar, For more detail
 * information, please can visit our link: http://www.cubedrive.com/myCalendar
 *
 * You need buy one of the Feyasoft's License if you want to use MyCalendar in
 * your commercial product. You must not remove, obscure or interfere with any
 * FeyaSoft copyright, acknowledgment, attribution, trademark, warning or
 * disclaimer statement affixed to, incorporated in or otherwise applied in
 * connection with the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
 * KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 * WARRANTIES OF MERCHANTABILITY,FITNESS FOR A PARTICULAR PURPOSE
 * AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
	

Ext.define('Ext.ux.calendar.WestPanel', {
	
    extend : 'Ext.Panel',
    
    title: 'Ax Agenda',
    
    iconCls: 'icon-cubedrive',
        
    cls : 'x-calendar-west',
    
    collapsible : true,
    
    region : 'west',
    
    minWidth : 200,
    
    width : 200,    

    style: 'padding:5px;',
        
    bodyStyle: 'border:none',
    
    // layout : 'border',    
    
    initComponent : function() {
        var eh = this.ehandler;
        eh.applyCalendarSetting(this);
        this.ds = eh.ds;
        var lan = Ext.ux.calendar.Mask.WestPanel;
        this.datePicker =Ext.create('Ext.util.DatePicker',{
        	region: 'north',
        	style:'border:1px solid #a3bad9;',
        	cls:'x-west-datepicker',
            value : new Date(),
            startDay : this.startDay
        });
        this.poweredBy = "http://www.cubedrive.com";
        /*
			 * for my calendar panel
			 */
        /*=================Begin:No share function==================*/
        this.showAllBtn =Ext.create('Ext.Button',{ 
            iconCls : 'icon_feyaCalendar_calendar_show',
            text : lan['myShowAllBtn.text'],
            handler : this.onShowAllFn,
            scope : this
        });
	
        this.addBtn =Ext.create('Ext.Button',{
            iconCls : 'icon_feyaCalendar_add_calendar',
            text : lan['myAddBtn.text'],
            handler : this.onAddFn,
            scope : this
        });
        var bbar = [this.showAllBtn, '->'];
        // if (!this.readOnly) {
        //     bbar.push(this.addBtn);
        // }
        this.myCalendarPanel =Ext.create('Ext.Panel',{
            region : 'center',
            iconCls : 'icon_feyaCalendar_calendar',
            title : lan['myCalendarPanel.title'],
            style: 'padding-top:5px;',
            bodyStyle : 'padding:2px;background-color:white;overflow-x:hidden;position:relative;',            
            autoScroll : true,
            bbar : bbar
        });

	Ext.define('User', {
	    extend: 'Ext.data.Model',
	    fields: [
		{ name: 'completename', type: 'string' },
		{ name: 'firstname', type: 'string' },
		{ name: 'name',      type: 'string' },
		{ name: 'rowid',     type: 'string' }
	    ]
	});

	var calUsers = Ext.create('Ext.data.Store', {
	    model: 'User',
	    proxy: {
		type: 'ajax',
		url: document.URL + '/users',
		reader: {
		    type: 'json',
		    root: 'users',
		    successProperty: 'success'
		}
	    },
	    autoLoad: true
	});

	this.usersFilterBtn = Ext.create('Ext.Button', {
	    text: 'Filtrer par utilisateur',
	    padding: 3,
	    margin: 3,
	    handler: this.onUsersFilterFn,
	    scope: this
	});

	this.useraskedLabel = Ext.create('Ext.form.Label', {text: 'Enregistrés par' });
	this.useraskedCombo = Ext.create('Ext.form.ComboBox', {
	    hiddenName: 'userasked',
	    editable: false,
	    store: calUsers,
	    queryMode: 'local',
	    displayField: 'completename',
	    valueField: 'rowid',
	    multiSelect: true,
	    renderTo: Ext.getBody()
	});
	this.usertodoLabel = Ext.create('Ext.form.Label', {text: 'Affectés à' });
	this.usertodoCombo = Ext.create('Ext.form.ComboBox', {
	    hiddenName: 'usertodo',
	    editable: false,
	    fieldLabel: '',
	    store: calUsers,
	    queryMode: 'local',
	    displayField: 'completename',
	    valueField: 'rowid',
	    multiSelect: true,
	    renderTo: Ext.getBody()
	});
	// this.useraskedCombo.on('select', function(combo, records, oOpts) {
	//     onSelectAskedFn(combo, records, oOpts);
	// });
	// this.usertodoCombo.on('select', function(combo, records, oOpts) {
	//     onSelectTodoFn(combo, records, oOpts);
	// });

	// this.userdoneLabel = Ext.create('Ext.form.Label', {text: 'Réalisés par' });
	// this.userdoneCombo = Ext.create('Ext.form.ComboBox', {
	//     hiddenName: 'userdone',
	//     editable: false,
	//     fieldLabel: '',
	//     store: calUsers,
	//     queryMode: 'local',
	//     displayField: 'completename',
	//     valueField: 'rowid',
	//     multiSelect: true,
	//     renderTo: Ext.getBody()
	// });
	// this.useraskedCombo.on('select', function(combo, records, oOpts) {
	//     Ext.Ajax.request({ 
	// 	url: Ext.ux.calendar.CONST.showOnlyUserEventURL,
	// 	params: {
	// 	    user_id: combo.value,
	// 	    combo_name: combo.hiddenName
	// 	},
	// 	success: function(response, options) {
	// 	    var backObj = Ext.decode(response.responseText);
	// 	},
	// 	failure: function(response, options) {
	// 	},
	// 	scope: this
	//     });
	    
	// });
	// this.usertodoCombo.on('select', function(combo, records, oOpts) {
	//     Ext.Ajax.request({ 
	// 	url: Ext.ux.calendar.CONST.showOnlyUserEventURL,
	// 	params: {
	// 	    user_id: combo.value,
	// 	    combo_name: combo.hiddenName
	// 	},
	// 	success: function(response, options) {
	// 	    var backObj = Ext.decode(response.responseText);
	// 	    sucessFn.call(this, backObj);
	// 	},
	// 	failure: function(response, options) {

	// 	},
	// 	scope: this
	//     });
	    
	// });
	// this.userdoneCombo.on('select', function(combo, records, oOpts) {
	//     Ext.Ajax.request({ 
	// 	url: Ext.ux.calendar.CONST.showOnlyUserEventURL,
	// 	params: {
	// 	    user_id: combo.value,
	// 	    combo_name: combo.hiddenName
	// 	},
	// 	success: function(response, options) {
	// 	    var backObj = Ext.decode(response.responseText);
	// 	    sucessFn.call(this, backObj);
	// 	},
	// 	failure: function(response, options) {

	// 	},
	// 	scope: this
	//     });
	    
	// });


        this.myCalendarPanel.on('render', this.onMyCalendarRenderFn, this);

	this.usersFilterPanel = Ext.create('Ext.Panel', {
	    title: "Filtres",
	    layout: { type:'vbox', align: 'stretch', padding: 3 },
	    items: [ this.useraskedLabel, this.useraskedCombo, 
		     this.usertodoLabel, this.usertodoCombo, 
		     this.userdoneLabel, this.userdoneCombo,
		     this.usersFilterBtn
		   ]
	});

        this.items = [this.datePicker, this.myCalendarPanel, this.usersFilterPanel];

        
        this.callParent(arguments);
        
        this.addEvents('changedate');
        this.datePicker.on('aferinitevent', this.afterDatePickerInitFn, this);
        this.datePicker.on('select', this.onSelectFn, this);
        this.on('changedate', this.changeDateLabel, this);
        this.on('afterrender', this.onRenderFn, this);        
	// this.useraskedCombo.on('select', this.onSelectUsersFn, this);
	// this.usertodoCombo.on('select', this.onSelectUsersFn, this);
    },
    
    onOtherCalendarRenderFn : function(p) {
        var eh = this.ehandler;
        eh.renderSharedCalendar(p.body);
    },
	
    onRenderFn : function(p) {
        p.header.on('click', this.onHeaderClickFn, this);
        p.header.addCls('x-panel-header-default-custom');
    },
	
    onHeaderClickFn : function(e) {
        var target = e.getTarget();
        var uxhasClass=Ext.ux.calendar.Mask.includeIsClass;
        if(uxhasClass(target.className,'x-panel-header-text')){
            window.open(this.poweredBy, '_blank');
        }
    },
	
    // onSelectUsersFn: function(combo, record, oOpts) {
    // 	console.log("asked value <" + combo.value + ">");
    // 	console.log("asked hidden val <" + combo.hiddenName + ">");
    // 	this.ehandler.onSelectUsersFn(combo.value, combo.hiddenName);
    // },
    onUsersFilterFn: function(e) {
	console.log("useraskedCombo.value <"+this.useraskedCombo.value+">");
	console.log("useraskedCombo.hiddenName <"+this.useraskedCombo.hiddenName+">");
	console.log("usertodoCombo.value <"+this.usertodoCombo.value+">");
	console.log("usertodoCombo.hiddenName <"+this.usertodoCombo.hiddenName+">");
	this.ehandler.onUsersFilterFn(this.useraskedCombo.value, this.usertodoCombo.value);
    },
    onShowAllFn : function() {
        this.ehandler.onShowAllFn();
    },
	
    onAddFn : function() {
        this.ehandler.ceditor.popup({
            action : 'add'
        });
    },
	
    onSelectFn : function(dp, date) {
        var calendarContainer = this.ownerCt.calendarContainer;
        calendarContainer.showDay(date);
    },
	
    onMyCalendarRenderFn : function(p) {
        var eh = this.ehandler;
        eh.renderOwnedCalendar(p.body);
    },
	
    changeDateLabel : function(fromDate, toDate) {
        this.updateDatePicker(fromDate, toDate);
    },
	
    updateDatePicker : function(fromDate, toDate) {
        if (fromDate && toDate) {
            var vDate = Ext.Date;
            var from = vDate.format(fromDate, this.fromtoFormat);
            this.datePicker.setRange(fromDate, toDate);
            var dnum = Ext.ux.calendar.Mask.getDayOffset(fromDate, toDate);
            if (7 < dnum) {
                var fd = vDate.getFirstDateOfMonth(fromDate);
                var fday = vDate.format(fd, 'Y-m-d');
                from = vDate.format(fromDate, 'Y-m-d');
                if (from != fday) {
                    fd = vDate.add(vDate.getLastDateOfMonth(fromDate),
                        Ext.Date.DAY, 1);
                }
                this.datePicker.setValue(fd);
            } else {
            	this.datePicker.setValue(fromDate);
            }
        }
    },
	
    afterDatePickerInitFn : function() {
        var cview = this.ownerCt.calendarContainer.currentView;
        this.updateDatePicker(cview.daySet[0], cview.daySet[cview.daySet.length - 1]);
    }
});
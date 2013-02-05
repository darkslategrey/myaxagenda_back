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
Ext.ns("Ext.ux.calendar");

Ext.ux.calendar.Mask = {
    'CalendarWin':{
        'title':'Ax Agenda v. 0.1',
        'loadMask.msg':'Merci de patienter ...'
    },

    'MainPanel':{
        'loadMask.msg':'Merci de patienter ...'
    },

    'SharingPopup':{
        'title':'Partager l\'agenda'
    },

    'CalendarContainer':{
        'todayBtn.text':'Aujourd\'hui',
        'dayBtn.text':'Vue jour',
        'weekBtn.text':'Vue semaine',
        'monthBtn.text':'Vue Mois',
        'weekMenu.showAll.text':'Monter tout les agendas',
        'weekMenu.onlyWeek.text':'Seulement les weekends',
        'monthMenu.showAll.text':'Monter tout les agendas',
        'monthMenu.onlyWeek.text':'Seulement les jours de la semaines',
        'moreMenu.setting.text':'Préférences',
        'moreMenu.about.text':'A propos',
        'moreBtn.text':'Plus',
        'searchCriteria.text':'Rechercher',
        'moreMenu.showAlert.text':'Activer les fonctions d\'alertes',
        'moreMenu.language.text':'Préférences linguistiques'
    },

    'WestPanel':{
        'myCalendarPanel.title':'Ax Agenda',
        'otherCalendarPanel.title':'Autre Agendas',
        'myShowAllBtn.text':'Afficher tous les agendas',
        'myAddBtn.text':'Nouveau'
    },

    'EventHandler':{
        'showOnlyItem.text':'N\'afficher que cet agenda',
        'viewItem.hide.text':'Cacher l\'agenda',
        'viewItem.show.text':'Afficher l\'agenda',
        'editItem.text':'Editer l\'agenda',
        'deleteItem.text':'Supprimer l\'agenda',
        'clearItem.text':'Vider l\'agenda',
        'wholeDay':'Jour entier',
        'untitled':'Sans tître',
        'unlockItem.text':'Dévérouiller',
        'lockItem.text':'Vérouiller',
        'editEvent.title':'Editer l\'évènement',
        'deleteEvent.title':'Supprimer l\'évènement',
        'more':'Plus',
        'deleteRepeatPopup.title':'Confirmer',
        'deleteRepeatPopup.msg':'Cliquez "Oui" pour supprimer tous les évènements récurrents, ou cliquez "Non" pour ne supprimer que cet évènement?',
        'updateRepeatPopup.title':'Confirmer',
        'updateRepeatPopup.msg':'Cliquez "Oui" pour mettre à jour tous les évènements récurrents, ou cliquez "Non" pour ne mettre à jour que cet évènement?',
        'shareItem.text':'Partager l\'agenda'
    },

    'Editor':{
        'startDayField.label':'Heure',
        'wholeField.label':'Journée entière',
        'subjectField.label':'Sujet',
        'contentField.label':'Contenu',
        'calendarField.label':'Agenda',
        'alertCB.label':'Programmer une alerte',
        'lockCB.label':'Vérouillé',
        'deleteBtn.text':'Supprimer',
        'saveBtn.text':'Sauver',
        'cancelBtn.text':'Annuler',
        'new.title':'Nouvel évènement',
        'edit.title':'Modifier un évènement',
        'repeatTypeField.label':'Récurrence',
        'repeatIntervalField.label':'Tous les jours',
        'intervalUnitLabel.day.text':' Jour(s) ',
        'intervalUnitLabel.week.text':' Semaine(s) ',
        'intervalUnitLabel.month.text':' Mois ',
        'intervalUnitLabel.year.text':' Année(s) ',
        'detailSetting':'Editer les détails ...',
        'returnBtn.text':'Retour',
        'startAndEnd':'Début et fin',
        'repeatStartField.label':'Début',
        'repeatNoEndRG.label':'Pas de date de fin',
        'repeatEndTimeRG.label':'Finit après',
        'repeatEndDateRG.label':'Finit le',
        'repeatEndTimeUnit':'occurrence(s)',
        'weekCheckGroup.label':'Toute les semaines',
        'monthRadioGroup.label':'Répéter par',
        'repeatByDate':'Date',
        'repeatByDay':'Jour',
        'alertLabel':'Configuration des rappels',
        'alertEarly.label':'Avant',
        'newAlertBtn.text':'Nouvelle alerte',
        'deleteAlertBtn.label':'Supprimer alerte',
        'emailAlertEarlyInvalid':'L\'alerte par couriel doît précéder l\'évènement d\'au moins 30 minutes.',
        'popupAlertEarlyInvalid':'L\'alerte par fenêtre surgissante doît précéder de moins de 24 heures le début de l\'évènement.',
        'repeatIntervalInvalid':'Cette valeur doît être un entier positif !',
        'repeatBeginDayInvalid':'La date de début doît être antèrieure à la date de fin',
        'repeatEndDayInvalid':'La date de fin doît être postèrieure à la date de début',
        'repeatTimeInvalid':'Cette valeur doît être un entier positif !'
    },

    'CalendarEditor':{
        'new.title':'Nouvel Agenda',
        'edit.title':'Modifier l\'agenda',
        'nameField.label':'Nom',
        'descriptionField.label':'Description',
        'clearBtn.text':'Clair',
        'saveBtn.text':'Sauver',
        'cancelBtn.text':'Annuler',
        'returnBtn.text':'Retour',
        'shareCalendar':'Partager l\'agenda avec d\'autres',
        'shareColumns.user':'Utilisateur',
        'shareColumns.permit':'Autoriser',
        'shareColumns.add':'Ajouter l\'utilisateur pour partage',
        'shareColumns.remove':'Supprimer',
        'userField.emptyText':'Merci d\'indiquer le nom ou le couriel'
    },
    'ExpirePopup':{
        'hideCB.label':'Ne plus faire apparaître la fenêtre surgissante',
        'title':'Alertes d\'évènements',
        'tpl.calendar':'Agenda',
        'tpl.subject':'Sujet',
        'tpl.content':'Contenu',
        'tpl.leftTime':'Temps restant',
        'hour':'Heure(s)',
        'minute':'Minute(s)',
        'untitled':'Sans tître',
        'noContent':'Pas de contenu',
        'cancelReminder':'ANNULER',
        'editEvent':'EDITER'
    },

    'SettingPopup':{
        'title':'Propriétés Ax Agenda',
        'hourFormatField.label':'Format de l\'heure',
        'dayFormatField.label':'Format vue jour',
        'weekFormatField.label':'Format vue semaine',
        'monthFormatField.label':'Format vue mois',
        'applyBtn.text':'Appliquer',
        'resetBtn.text':'Annuler',
        'closeBtn.text':'Fermer',
        'fromtoFormatField.label':'De à format',
        'scrollStartRowField.label':'Scroll Start Row',
        'languageField.label':'Langue',
        'generalForm.title':'General',
        'dwViewForm.title':'Vue jour|Vue semaine',
        'monthViewForm.title':'Vue mois',
        'createByDblClickField.label':'Création d\'un évènement par double clique',
        'singleDayField.label':'Cross Day Event',
        'weekStartDayField.label': 'Jour de début de semaine',
        'activeStartTimeField.label':'Horaire de début d\'activité',
        'activeEndTimeField.label':'Horaire de fin d\'activité',
        'hideInactiveTimeField.label':'Caché les plages horaires innactives',
        'readOnlyField.label':'Lecure seule',
        'intervalField.label':'Interval',
        'startEndInvalid':'Horaire de début doît être antèrieur à l\'horaire de fin',
        'formatInvalid':'Example: 09:00',
        'initialViewField.label':'Vue initiale'
    },

    'ResultView':{
        'cm.date':'Date',
        'cm.calendar':'Agenda',
        'cm.time':'Heure',
        'cm.subject':'Sujet',
        'cm.content':'Contenu',
        'cm.expire':'Temps restant',
        'groupBtn.group.text':'Grouper',
        'groupBtn.unGroup.text':'Dégrouper',
        'returnBtn.text':'Retour',
        'hour':'Heure(s)',
        'noSubject':'(Pas de sujet)',
        'noContent':'(Pas de contenu)',
        'loadMask.msg':'S\'il vous plaît patienter...'
    },

    'DayView':{
        'loadMask.msg':'S\'il vous plaît patienter...',
        'addItem.text':'Nouvel événement',
        'events':'événement'
    },

    'MonthView':{
        'loadMask.msg':'S\'il vous plaît patienter...',
        'overview':'Présentation',
        'showingEvents':'Monter les évènements',
        'totalEvents':'Total des évènements',
        'dayPre':'',
        'addItem.text':'Nouvel événement',
        'clearItem.text':'Propreté de l\'événement',
        'cutItem.text':'Couper',
        'copyItem.text':'Copier',
        'pasteItem.text':'Coller',
        'events':'événement'
    },

    'Mask':{
        '12Hours':'12 Heures',
        '24Hours':'24 Heures',
        'ar': 'Arabic',
        'de': 'German',
        'en':'American English',
        'es': 'Spanish',
        'fr': 'Français',
        'it': 'Italiano',
        'ja': 'Japanese',
        'lt': 'Lietuvių',
        'nl': 'Nederlandse',
        'pl': 'Polski',
        'pt': 'Portuguese',
        'ru': 'Russian',
        'zh_CN':'简体中文',
        'enable':'Activé',
        'disable':'Désactivé',
        'minute':'Minutes',
        'monday':'Lundi',
        'sunday':'Dimanche',
        'permitData':[
            [0, 'Lecture, Ecrire and Partager'],
            [1, 'Lecture and Ecrire'],
            [2, 'Lecture seule']
        ],
        'alertType':[
            ['popup', 'Message surgissant'],
            ['email', 'Couriel']
        ],
        'popupAlertUnit':[
	    ['jour', 'Jour(s)'],
            ['minute', 'Minute(s)'],
            ['hour', 'Heure(s)']
        ],
        'alertUnit':[
            ['minute', 'Minute(s)'],
            ['hour', 'Heure(s)'],
            ['day', 'Jour(s)'],
            ['wek', 'Semaine(s)']
        ],
        'initialView':[
            [0, 'Vue jour'],
            [1, 'Vue semaine'],
            [2, 'Vue mois']
        ]
    },

    repeatType:[
        ['no', 'Non'],
        ['day', 'Quotitien'],
        ['week', 'Hebdomadaire'],
        ['month', 'Mensuel'],
        ['year', 'Annuel']
    ],

    colors:['668CD9', 'D96666', '59BFB3', 'F2A442', '4CB052', 'B373B3', 'E01B1B', '040480'],

    colorIndex:["bleu", "rouge", "cyan", "orange", "vert", "parme", "rougevif", "bleumarine"],

    getMinute:function(t, u){
        t = parseInt(t);
        if('hour' == u){
            t = t*60;
        }else if('day' == u){
            t = t*60*24;
        }else if('week' == u){
            t = t*60*24*7;
        }
        return t;
    },

    getColorByIndex:function(colorIndex){
        var mask = Ext.ux.calendar.Mask;
        for(var i = 0, len = mask.colorIndex.length; i < len; i++){
            if(colorIndex == mask.colorIndex[i]){
                return mask.colors[i];
            }
        }
        return null;
    },

    getIndexByColor:function(color){
        var mask = Ext.ux.calendar.Mask;
        for(var i = 0, len = mask.colors.length; i < len; i++){
            if(color == mask.colors[i]){
                return mask.colorIndex[i];
            }
        }
        return null;
    },
	
    getRepeatTypeStore:function() {
        var store = new Ext.data.SimpleStore({
                fields:['value', 'display'],
                data:Ext.ux.calendar.Mask.repeatType
        });
        return store;
    },

	getEventStore : function(url,pageSize) {
		var store = Ext.create('Ext.data.Store', {
					//sorters : ['ymd'],
					pageSize : pageSize,
					proxy : {
						type : 'ajax',
						url : url,
						reader : {
							type : 'json',
							root : 'results',
							totalProperty : 'total'
						}
					},
					groupField : 'ymd',
					fields :[{name: "id"},
			                {name: "calendarId"},
			                {name: "startTime"},
			                {name: "endTime"},
			                {name: "subject"},
			                {name: "description"},
			                {name: "ymd"},
			                {name: "eymd"},
			                {name: "color"},
			                {name: "isShared"},                
			                {name: "alertFlag"},
			                {name: "locked"},
			                {name: "repeatType"}]
					
		})
		return store;
	},
    getCalendarStore:function(){
        var store =Ext.create('Ext.data.SimpleStore', {
                fields:['id', 'title', 'description', 'color'],
                data:[]
        });
        return store;
    },
    
    getHourFormatStore:function(){
        var lan = Ext.ux.calendar.Mask.Mask;
    	var store = Ext.create('Ext.data.SimpleStore', {
                fields:['id', 'text'],
                data:[
                        ['12', lan['12Hours']],
                        ['24', lan['24Hours']]
                ]
        });
        return store;
    },

    getLanguageConfig:function(){
        /*
         * you can change the data here, add/substract languages. But notice you need have the related file under multi-language folder first;
         * For example, ['en', 'American English'], this means there is a file named en_US.js under multi-language folder
         */
        var lan = Ext.ux.calendar.Mask.Mask;
        var data = [
            ['en', lan['en']],
            ['es', lan['es']],
            ['de', lan['de']],
            ['fr', lan['fr']],
            ['it', lan['it']],
            ['lt', lan['lt']],
            ['nl', lan['nl']],
            ['pl', lan['pl']],
            ['pt', lan['pt']],
            ['zh_CN', lan['zh_CN']]
        ];
        var store =Ext.create('Ext.data.SimpleStore', {
                fields:['name', 'display'],
                data:data
        });

        return {
            data:data,
            store:store
        };
    },

    parseHM:function(hm){
        var h, m;
        var parts = hm.split(':');
        h = parts[0];
        if('0' == h.charAt(0)){
            h = h.charAt(1);
        }
        h = parseInt(h);
        m = parts[1];
        if('0' == m.charAt(0)){
            m = m.charAt(1);
        }
        m = parseInt(m);
        return {
            h:h,
            m:m
        };
    },

    calculateActiveRow:function(cs){        
        var obj = {};
        var hm = this.parseHM(cs.activeStartTime);
        var st = hm.h*60+hm.m;
        hm = this.parseHM(cs.activeEndTime);
        var et = hm.h*60+hm.m;
        obj.intervalSlot = parseInt(cs.intervalSlot);
        obj.rowCount = 24*60/obj.intervalSlot;
        obj.activeStartRow = Math.floor(st/obj.intervalSlot);
        obj.activeEndRow = Math.floor(et/obj.intervalSlot);
        obj.numInHour = Math.floor(60/obj.intervalSlot);
        delete(cs['id']);
        delete(cs['class']); 
        obj = Ext.apply(obj, cs);
        obj.startDay = parseInt(obj.startDay);        
        obj.startRow = 0;
        obj.endRow = obj.rowCount;
        if(obj.hideInactiveRow){
            obj.startRow = obj.activeStartRow;
            obj.endRow = obj.activeEndRow;
        }        
        return obj;
    },

    getTimeStore:function(){
        var store = new Ext.data.SimpleStore({
			fields:['row', 'hour'],
			data:[]
		});
		return store;
    },

    getHMFromRow:function(intervalSlot, row, hourFormat){
        var m = intervalSlot*row;
        var h = Math.floor(m/60);
        m = m%60;
        if(10 > m){
            m = '0'+m;
        }
        if(10 > h){
            h = '0'+h;
        }
        var s = h+':'+m;
        if('12' == hourFormat){
            var dt = Ext.Date.parseDate(h+':'+m, 'H:i');
            s = Ext.Date.format(dt,'h:i A');
        }
        return s;
    },

    generateIntervalData:function(intervalSlot, start, end, hourFormat){
        var num = Math.floor(24*60/intervalSlot);
        start = start || 0;
        end = end || num;
        var data = [];
        for(var i = start; i <= end; i++){
            var o = [];
            o.push(i);
            var s = this.getHMFromRow(intervalSlot, i, hourFormat);
            o.push(s);
            data.push(o);
        }
        return data;
    },

    getIntervalFromRow:function(intervalSlot, row, hourFormat){
        try{
            var m = intervalSlot*row;
            var h = Math.floor(m/60);
            m = m%60;
            if(10 > m){
                m = '0'+m;
            }
            if(10 > h){
                h = '0'+h;
            }
            var s = h+':'+m;
            if('12' == hourFormat){
                if('24:00' == s){
                    s = '00:00';
                }
                var dt = Ext.Date.parseDate(s, 'H:i');
                s = Ext.Date.format(dt,'h:i A');
            }
        }catch(e){

        }
        return s;
    },

    getRowFromHM:function(hm, intervalSlot){
        if('23:59' == hm){
            hm = '24:00';
        }
        hm = Ext.ux.calendar.Mask.parseHM(hm);
        var row = Math.floor(hm.h*60/intervalSlot+hm.m/intervalSlot);
        return row;
    },

    getEDStore:function(){
        var lan = Ext.ux.calendar.Mask.Mask;
        var store = new Ext.data.SimpleStore({
			fields:['value', 'display'],
			data:[
                [true, lan['enable']],
                [false, lan['disable']]
            ]
		});
		return store;
    },

    getStartDayStore:function(){
        var lan = Ext.ux.calendar.Mask.Mask;
        var store =Ext.create('Ext.data.SimpleStore', {
			fields:['value', 'display'],
			data:[
                [0, lan['sunday']],
                [1, lan['monday']]
            ]
		});
		return store;
    },

    getIntervalStore:function(){
        var lan = Ext.ux.calendar.Mask.Mask;
        var store = Ext.create('Ext.data.SimpleStore', {
			fields:['value', 'display'],
			data:[
                [10, '10 '+lan['minute']],
                [15, '15 '+lan['minute']],
                [20, '20 '+lan['minute']],
                [30, '30 '+lan['minute']],
                [60, '60 '+lan['minute']]
            ]
		});
		return store;
    },

    getDayOffset:function(sday, eday){
    	var vDate=Ext.Date;
        if(!(sday instanceof Date)){
            sday = vDate.parseDate(sday, 'Y-m-d');
        }
        if(!(eday instanceof Date)){
            eday = vDate.parseDate(eday, 'Y-m-d');
        }
        var offset =  vDate.getElapsed(sday,eday);
        offset = Math.round(offset/(3600000*24));
        return offset;
    },

    getWeekDayInMonth:function(date){   
    	var vDate=Ext.Date;
        var d =  vDate.format(date,'d');
        var w = Math.floor(d/7)+1;
        var wd =  vDate.format(date,'l');
        var str = 'le '+w;
        // if(1 == w){
        //     str += 'st';
        // }else if(2 == w){
        //     str += 'nd';
        // }else if(3 == w){
        //     str += 'rd';
        // }else{
        //     str += 'th';
        // }
        return str+' '+wd;
    },

    getIntervalText:function(rtype, intervalSlot){
        var str = '';
        if('day' == rtype){
            if(1 == intervalSlot){
                str = 'Tous les jours';
            }else{
                str = 'Tous les '+intervalSlot+' jours';
            }
        }else if('week' == rtype){
            if(1 == intervalSlot){
                str = 'Toutes les semaines à ';
            }else{
                str = 'Toutes les '+intervalSlot+' semaines à ';
            }
        }else if('month' == rtype){
            if(1 == intervalSlot){
                str = 'Tous les mois à ';
            }else{
                str = 'Tous les '+intervalSlot+' mois à ';
            }
        }else if('year' == rtype){
            if(1 == intervalSlot){
                str = 'Tous les ans à ';
            }else{
                str = 'Tous les '+intervalSlot+' ans à ';
            }
        }
        return str;
    },

    getPermitStore:function(){
        var lan = Ext.ux.calendar.Mask.Mask;
        var store = Ext.create('Ext.data.SimpleStore', {
			fields:['value', 'display'],
			data:lan['permitData']
		});
		return store;
    },

    getUserStore:function(){        
        var store = new Ext.data.Store({
            proxy:new Ext.data.HttpProxy({
                url:Ext.ux.calendar.CONST.listUserURL
            }),
			reader:Ext.create('Ext.data.JsonReader', {
                root: 'results',
                id: 'id',
                totalProperty: 'total'
            }, [
                {name: "id"},
                {name: "username"},
                {name: "email"}
            ])
		});
		return store;
    },

    getAlertTypeStore:function(){
        var lan = Ext.ux.calendar.Mask.Mask;
        var store = Ext.create('Ext.data.SimpleStore', {
			fields:['value', 'display'],
			data:lan['alertType']
		});
		return store;
    },

    getAlertUnitStore:function(){
        var lan = Ext.ux.calendar.Mask.Mask;
        var store = Ext.create('Ext.data.SimpleStore', {
			fields:['value', 'display'],
			data:lan['popupAlertUnit']
		});
		return store;
    },

    getInitialViewStore:function(){
        var lan = Ext.ux.calendar.Mask.Mask;
        var store = Ext.create('Ext.data.SimpleStore', {
			fields:['value', 'display'],
			data:lan['initialView']
		});
		return store;
    },

    cleanObj:function(o){
        o = Ext.apply({}, o);
        var n = {};
        for(var p in o){
            var f = Ext.ux.calendar.Mask.typeOf(o[p]);
            if(false == f){
                delete(o[p]);
            }else if('string' == f){
                o[p] = o[p].trim();
                if('' == o[p]){
                    delete(o[p]);
                }
            }else if('boolean' == f){
                if(false == o[p]){
                    delete(o[p]);
                }
            }
            if(o[p]){
                n[p] = o[p];
            }
        }
        return n;
    },

    isEqualObj:function(o, n){
        try{
            o = Ext.ux.calendar.Mask.cleanObj(o);
            n = Ext.ux.calendar.Mask.cleanObj(n);            
            return Ext.encode(o) == Ext.encode(n);
        }catch(e){
            return false;
        }
    },
    
    includeIsClass : function(className, merclass) {
		return className
				&& (' ' + className + ' ').indexOf(' ' + merclass + ' ') != -1;
	},
	
	typeOf : function(v){	
		if(undefined === v || null === v){
			return false;
		}
		var t = Ext.type(v);		
		return t;
	}
};
/**
 * CubeDrive MyCalendar
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

Ext.ux.calendar.Language = {

    // please help to transfer words after :. Thanks
    'CalendarWin':{
        'title':'CubeDrive MyCalendar 2.5.3',
        'loadMask.msg':'S\'il vous plaît patienter...'
    },

    'MainPanel':{
        'loadMask.msg':'S\'il vous plaît patienter...'
    },

    'CalendarContainer':{
        'todayBtn.text':'Aujourd\'hui',
        'dayBtn.text':'La vue Jour',
        'weekBtn.text':'Vue de la semaine',
        'monthBtn.text':'Vue par mois',
        'weekMenu.showAll.text':'Voir tout',
        'weekMenu.onlyWeek.text':'Seulement la semaine',
        'monthMenu.showAll.text':'Voir tout',
        'monthMenu.onlyWeek.text':'Seulement la semaine',
        'moreMenu.setting.text':'Param\350tre',
        'moreMenu.about.text':'About CubeDrive MyCalendar',
        'moreBtn.text':'Plus',
        'searchCriteria.text':'Recherche',        
        'moreMenu.showAlert.text':'Activer fonction d\'alerte',
        'moreMenu.language.text':'R\350glage de la Langue'
    },

    'WestPanel':{
        'myCalendarPanel.title':'Ax Agenda',
        'myShowAllBtn.text':'Voir tout',
        'myAddBtn.text':'Nouveau'
    },

    'EventHandler':{
        'showOnlyItem.text':'N\'afficher que cet agenda',
        'viewItem.hide.text':'Masquer cet agenda',
        'viewItem.show.text':'Afficher le agenda',
        'editItem.text':'Modification du agenda',
        'deleteItem.text':'Supprimer l\'agenda',
        'clearItem.text':'Vider le agenda',
        'wholeDay':'Journ\351e enti\350re',
        'untitled':'Sans t\356tre',
        'unlockItem.text':'V\351rouiller',
        'lockItem.text':'D\351v\351rouiller',
        'editEvent.title':'Modifier un \351v\350nement',
        'deleteEvent.title':'Supprimer l\'\351v\350nement',
        'more':'Plus',
        'deleteRepeatPopup.title':'Confirmation',
        'deleteRepeatPopup.msg':'Cliquez "Oui" pour supprimer tous les \351v\350nements r\351currants, ou cliquez "Non" pour ne supprimer que cet \351v\350nement?',
        'updateRepeatPopup.title':'Confirmation',
        'updateRepeatPopup.msg':'Cliquez "Oui" pour mettre à jour tous les \351v\350nements r\351currants, ou cliquez "Non" pour ne mettre à jour que cet \351v\350nement?'
    },

    'Editor':{
        'startDayField.label':'Heure',
        'wholeField.label':'Journ\351e enti\350re',
        'subjectField.label':'Sujet',
        'contentField.label':'Contenu',
        'calendarField.label':'Agenda',
        'alertCB.label':'Alerte lorsque activ\351',
        'lockCB.label':'V\351rouill\351',
        'deleteBtn.text':'Supprimer',
        'saveBtn.text':'Sauver',
        'cancelBtn.text':'Annuler',
        'new.title':'Nouvel \351v\350nement',
        'edit.title':'Modifier un \351v\350nement',
        'repeatTypeField.label':'R\351currence',
        'repeatIntervalField.label':'Tous les jours',
        'intervalUnitLabel.day.text':' Jour(s) ',
        'intervalUnitLabel.week.text':' Semaine(s) ',
        'intervalUnitLabel.month.text':' Mois ',
        'intervalUnitLabel.year.text':' Ann\351e(s) ',
        'detailSetting':'Editer les d\351tails ...',
        'returnBtn.text':'Retour',
        'startAndEnd':'D\351but et fin',
        'repeatStartField.label':'D\351but',
        'repeatNoEndRG.label':'Pas de date de fin',
        'repeatEndTimeRG.label':'Finit apr\350s',
        'repeatEndDateRG.label':'Finit par',
        'repeatEndTimeUnit':'occurrence(s)',
        'weekCheckGroup.label':'Toute les semaines',
        'monthRadioGroup.label':'R\351p\351ter par',
        'repeatByDate':'Date',
        'repeatByDay':'Jour',
        'alertLabel':'Configuration des rappels',
        'alertEarly.label':'Avant',
        'newAlertBtn.text':'Nouvelle alerte',
        'deleteAlertBtn.label':'Supprimer alerte',
        'emailAlertEarlyInvalid':'L\'alerte par couriel doît pr\351c\351der l\'\351v\350nement d\'au moins 30 minutes.',
        'popupAlertEarlyInvalid':'L\'alerte par fenêtre surgissante doît pr\351c\351der de moins de 24 heures le d\351but de l\'\351v\350nement.',
        'repeatIntervalInvalid':'Cette valeur doît être un entier positif !',
        'repeatBeginDayInvalid':'La date de d\351but doît être ant\350rieure à la date de fin',
        'repeatEndDayInvalid':'La date de fin doît être post\350rieure à la date de d\351but',
        'repeatTimeInvalid':'Cette valeur doît être un entier positif !',
    },
    
    'CalendarEditor':{
        'new.title':'Nouveau Agenda',
        'edit.title':'Modifier l\'agenda',
        'nameField.label':'Nom',
        'descriptionField.label':'Description',
        'clearBtn.text':'Clair',
        'saveBtn.text':'Sauver',
        'cancelBtn.text':'Annuler'
    },
    
    'ExpirePopup':{
        'hideCB.label':'Ne plus faire apparaître la fenêtre surgissante',
        'title':'Alertes d\'\351v\350nements',
        'tpl.calendar':'Agenda',
        'tpl.subject':'Sujet',
        'tpl.content':'Contenu',
        'tpl.leftTime':'Temps restant',
        'hour':'Heure(s)',
        'minute':'Minute(s)',
        'untitled':'Sans t\356tre',
        'noContent':'Pas de contenu'
    },

    'SettingPopup':{
        'title':'Propri\351t\351s Ax Agenda',
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
        'createByDblClickField.label':'Cr\351ation d\'un \351v\350nement par double clique',
        'singleDayField.label':'Cross Day Event',
        'weekStartDayField.label': 'Jour de d\351but de semaine',
        'activeStartTimeField.label':'Horaire de d\351but d\'activit\351',
        'activeEndTimeField.label':'Horaire de fin d\'activit\351',
        'hideInactiveTimeField.label':'Cach\351 les plages horaires innactives',
        'readOnlyField.label':'Lecure seule',
        'intervalField.label':'Interval',
        'startEndInvalid':'Horaire de d\351but doît être ant\350rieur à l\'horaire de fin',
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
        'groupBtn.unGroup.text':'D\351grouper',
        'returnBtn.text':'Retour',
        'hour':'Heure(s)',
        'noSubject':'(Pas de sujet)',
        'noContent':'(Pas de contenu)',
        'loadMask.msg':'S\'il vous plaît patienter...'
    },

    'DayView':{
        'loadMask.msg':'S\'il vous plaît patienter...',
        'addItem.text':'Nouvel \351v\351nement',
        'events':'\351v\351nement'
    },

    'MonthView':{
        'loadMask.msg':'S\'il vous plaît patienter...',
        'overview':'Pr\351sentation',
        'showingEvents':'Monter les \351v\350nements',
        'totalEvents':'Total des \351v\350nements',
        'dayPre':'',
        'addItem.text':'Nouvel \351v\351nement',
        'clearItem.text':'Propret\351 de l\'\351v\351nement',
        'cutItem.text':'Couper',
        'copyItem.text':'Copier',
        'pasteItem.text':'Coller',
        'events':'\351v\351nement'
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
        'enable':'Activ\351',
        'disable':'D\351sactiv\351',
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
        ['no', 'Non r\351p\351t\351'],
        ['day', 'Quotitien'],
        ['week', 'Hebdomadaire'],
        ['month', 'Mensuel'],
        ['year', 'Annuel']
    ],

    getWeekDayInMonth:function(date){
        var d = Ext.Date.format(date,'d');
        var w = Math.floor(d/7)+1;
        var wd =Ext.Date.format(date,'l');
        var str = 'le '+w;
        // if(1 == w){
        //     str += '';
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
    }
};

Ext.apply(Ext.ux.calendar.Mask, Ext.ux.calendar.Language);
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

Ext.ux.calendar.CONST = {
    /*
     * The version number of myCalendar
     */
    VERSION:'2.6.1',
    /*
     *true to show the language submenu in myCalendar, or not
     */
    SHOW_LANGUAGE_MENU:false,
    
    /*
     *define the main path of myCalendar
     */
    MAIN_PATH:document.URL + '/js/feyaSoft/calendar/',
    /*
     *define the multi-language path of myCalendar
     */
    CALENDAR_LANGUAGE_PATH:document.URL + '/js/feyaSoft/calendar/multi-language/',
    /*
     *define the multi-language path of EXT
     */
    EXT_LANGUAGE_PATH:document.URL + '/js/extjs/locale/',
    /*
     * define the some url here for datasource
     */
    searchURL:document.URL + '/' + 'search',

    showAllCalendarURL:document.URL + '/' + 'showAllCalendar',

    showOnlyUserEventURL:document.URL + '/' +  'showOnlyUserEvent',

    showOnlyCalendarURL:document.URL + '/' + 'showOnlyCalendar',

    createUpdateCalendarURL:document.URL + '/' + 'createUpdateCalendar',

    deleteEventsByCalendarURL:document.URL + '/' + 'deleteEventsByCalendar',

    deleteCalendarURL:document.URL + '/' + 'deleteCalendar',

    loadCalendarURL:document.URL + '/' + 'loadCalendar',

    loadEventURL:document.URL + '/' + 'loadEvent',

    loadRepeatEventURL:document.URL + '/' + 'loadRepeatEvent',

    createEventURL:document.URL + '/' + 'createEvent',

    updateEventURL:document.URL + '/' + 'updateEvent',

    deleteEventURL:document.URL + '/' + 'deleteEvent',

    deleteRepeatEventURL:document.URL + '/' + 'deleteRepeatEvent',

    changeDayURL:document.URL + '/' + 'changeDay',

    deleteDayURL:document.URL + '/' + 'deleteDay',

    loadSettingURL:document.URL + '/' + 'loadSetting',

    updateSettingURL:document.URL + '/' + 'updateSetting',

    createUpdateRepeatEventURL:document.URL + '/' + 'createUpdateRepeatEvent',

    initialLoadURL:document.URL + '/' + 'initialLoad'
};
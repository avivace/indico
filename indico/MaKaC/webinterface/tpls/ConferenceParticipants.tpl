<% from MaKaC.common.timezoneUtils import nowutc %>

<form action="${ participantsAction }" method="post" name="participantsForm" id="participantsForm">

<table width="100%" cellspacing="0" align="center" border="0">
    <tr>
       <td nowrap colspan="10">
            <div class="CRLgroupTitleNoBorder">${ _("Displaying")} <span id="numberParticipants" style="font-weight: bold;">${numberParticipants}</span>
                 <span id="numberParticipantsText"> ${ _("participant") if numberParticipants == 1 else _("participants")}</span>
            </div>
        </td>
    </tr>
    <tr id="headPanel" style="box-shadow: 0 4px 2px -2px rgba(0, 0, 0, 0.1);" class="follow-scroll">
        <td valign="bottom" width="100%" align="left" style="padding-top:5px;" colspan="9">
            <table>
                <tr >
                    <td valign="bottom" align="left">
                        <ul id="button-menu" class="ui-list-menu">
                          <li class="left arrow" id="addParticipant">
                              <a href="#">${_("Add")}</a>
                              <ul>
                                <li><a href="#" id="add_existing_user">${_("Existing user")}</a></li>
                                <li><a href="#" id="add_new_user">${_("New user")}</a></li>
                                % if nowutc() < self_._conf.getStartDate() :
                                    <li><a href="#" id="invite_users">${_("Invite")}</a></li>
                                % endif
                              </ul>
                          </li>
                          <li class="middle">
                            <a href="#" id="remove_users">${_("Remove")}</a>
                          </li>
                          % if nowutc() > self_._conf.getStartDate():
                            <li class="button middle arrow">
                              <a href="#">${_("Manage attendance")}</a>
                              <ul>
                                <li><a href="#" id="set_present">${_("Set as present")}</a></li>
                                <li><a href="#" id="set_absent">${_("Set as absent")}</a></li>
                                <li><a href="#" id="excuse_absence">${_("Excuse absence")}</a></li>
                              </ul>

                            </li>
                          % endif
                          <li class="right">
                            <a href="#" id="send_email">${_("Email")}</a>
                          </li>
                        </ul>

                    </td>
                    <td style="margin-left: 10px;">Export to: </td>
                    <td>
                        <input border="0" type="image" src=${excelIconURL} name="excel" style="margin-top:3px;">
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr id="selectBar" style="display:none">
        <td colspan=10 style="padding: 5px 5px 10px;" nowrap>
        Select: <a style="color: #0B63A5;" id="selectAll"> All</a>, <a style="color: #0B63A5;" id="deselectAll">None</a>
        </td>
    </tr>
    <tr id="headParticipants"  style="display:none">
        <td style="border-bottom: 1px solid #DDDDDD; padding-left:5px" class="titleCellFormat" align="right" width="3%"></td>
        <td style="border-bottom: 1px solid #DDDDDD; padding-left:5px" class="titleCellFormat">
            ${_("Name")}
        </td>
        <td style="border-bottom: 1px solid #DDDDDD; padding-left:5px" class="titleCellFormat">
            ${_("Affiliation")}
        </td>
        <td style="border-bottom: 1px solid #DDDDDD; padding-left:5px" class="titleCellFormat">
            ${_("Email")}
        </td>
        <td style="border-bottom: 1px solid #DDDDDD; padding-left:5px" class="titleCellFormat">
            ${_("Address")}
        </td>
        <td style="border-bottom: 1px solid #DDDDDD; padding-left:5px" class="titleCellFormat">
            ${_("Telephone")}
        </td>
        <td style="border-bottom: 1px solid #DDDDDD; padding-left:5px" class="titleCellFormat">
            ${_("Fax")}
        </td>
        <td style="border-bottom: 1px solid #DDDDDD; padding-left:5px" class="titleCellFormat">
            ${_("Status")}
        </td>
        <td style="border-bottom: 1px solid #DDDDDD; padding-left:5px" class="titleCellFormat">
            ${_("Presence")}
        </td>
    </tr>
    <tr id="noParticipantsInfo" style="display:none">
        <td colspan=10 style="font-style: italic; padding:15px 0px 15px 15px; border-bottom: 1px solid #DDDDDD;" nowrap>
            <span class="collShowBookingsText">${_("There are no participants yet")}</span>
        </td>
    </tr>
        % for p in self_._conf.getParticipation().getParticipantList():
             <%include file="ConferenceParticipant.tpl" args="participant=p,conference=conf"/>
        % endfor
    <tr>

    </tr>
</table>
</form>


<script type="text/javascript">
var actionParticipantRows = function(){
    $("[id^=checkParticipant]").click(function(){
        if(this.checked){
            $(this).parents('tr[id^=participant]').css('background-color',"#CDEB8B");
        }else{
            $(this).parents('tr[id^=participant]').css('background-color',"transparent");
        }
    });

    $("tr[id^=participant]").hover(function () {
        if($(this).find('input:checkbox:checked[id^=checkParticipant]').size() == 0){
            $(this).css({'background-color' : 'rgb(255, 246, 223)'});
        }}
        , function () {
          if($(this).find('input:checkbox:checked[id^=checkParticipant]').size() > 0){
              $(this).css('background-color',"#CDEB8B");
          }else{
              $(this).css('background-color',"transparent");
          }
    });
    $('input:checkbox:checked[id^=checkParticipant]').parents('tr[id^=participant]').css('background-color',"#CDEB8B");
};

var selectAll = function () {
    $('input:checkbox[id^=checkParticipant]').attr('checked', 'checked');
    $('input:checkbox[id^=checkParticipant]').parents('tr[id^=participant]').css('background-color',"#CDEB8B");
};

var deselectAll = function () {
    $('input:checkbox[id^=checkParticipant]').removeAttr('checked');
    $('input:checkbox[id^=checkParticipant]').parents('tr[id^=participant]').css('background-color',"transparent");
};

var checkNumberParticipants = function(){
    $('#numberParticipants').text($('input:checkbox[id^=checkParticipant]').length);
    if($('input:checkbox:checked[id^=checkParticipant]').length == 1) {
        $('#numberParticipantsText').text("participant");
    } else {
        $('#numberParticipantsText').text("participants");
    }
    if($('input:checkbox[id^=checkParticipant]').length == 0){
        $('#selectBar, #headParticipants').hide();
        $('#noParticipantsInfo').show();
    }else{
        $('#selectBar, #headParticipants').show();
        $('#noParticipantsInfo').hide();
    }
};

var legends = {'confTitle':$T('field containing the conference title.'),
        'name':$T('field containing the full name of the participant.'),
        'url':$T('field containing the url of the event.'),
        'urlRefusal':$T('field containing the url of the refusal to attend to the meeting.'),
        'urlInvitation':$T('field containing the url of the invitation to attend to the meeting.')};

IndicoUI.executeOnLoad(function(){
    var addParticipantMenu = null;
    var attendanceMenu = null;

    actionParticipantRows();
    checkNumberParticipants();

    $("#selectAll").click(function(){selectAll();});
    $("#deselectAll").click(function(){deselectAll();});

    var atLeastOneParticipantSelected = function(){
        if ($("input:checkbox:checked[id^=checkParticipant]").length>0){
            return true;
        } else{
            var dialog = new WarningPopup($T("Warning"), $T("No participant selected! Please select at least one."));
            dialog.open();
            return false;
        }

    };

    var successAddParticipantsHandler = function(result){
        if(result.infoWarning){
            (new WarningPopup($T("Warning"),result.infoWarning)).open();
        }
        if(result.added)
        {
            $(result.added).insertAfter($("#headParticipants")).filter("tr[id^=participant]").effect("highlight",{},3000)
            actionParticipantRows();
            checkNumberParticipants();
        }
    };


    var searchParticipants = function(method,peopleList){
        var killProgress = IndicoUI.Dialogs.Util.progress("Processing...");
        jsonRpc(Indico.Urls.JsonRpcService, method,
                { confId: "${self_._conf.getId()}",
                  userIds: peopleList },
                function(result, error){
                    killProgress();
                    if (exists(error)) {
                        IndicoUtil.errorReport(error);
                    } else {
                        successAddParticipantsHandler(result);
                    }
                });
    };

    var searchUsers = function(title, handler) {
        var chooseUsersPopup = new ChooseUsersPopup(title, true, ${self_._conf.getId()}, true,
                true, null, false, false, handler);
        chooseUsersPopup.execute();
        return false;
    };

    var removeParticipants = function(){
        var arrayChecked=[];
        if (atLeastOneParticipantSelected()){
            $("input:checkbox:checked").each(function() {
                   arrayChecked.push($(this).val());
            });
            var killProgress = IndicoUI.Dialogs.Util.progress("Processing...");
            jsonRpc(Indico.Urls.JsonRpcService, "event.participation.removeParticipants",
                    { confId: "${self_._conf.getId()}",
                      userIds: arrayChecked },
                    function(result, error){
                        killProgress();
                        if (exists(error)) {
                            IndicoUtil.errorReport(error);
                        } else {
                            $("input:checkbox:checked").parents("tr[id^=participant]").remove();
                            checkNumberParticipants();
                        }
                    });
            }
        return false;
    };

    var composeEmail = function(method){
        var participantsChecked={};
        if (atLeastOneParticipantSelected()){
            $("input:checkbox:checked").each(function() {
                participantsChecked[$(this).val()] = $(this).parent().siblings("[id^=nameParticipant]").children("[id^=participantEdit]").text();
            });
            var popup = new ParticipantsEmailPopup($T("Send mail to the participants"),"${conf.getTitle()}", ${conf.getId()},
                                                   method, participantsChecked, "${currentUser.getStraightFullName()}",
                                                   null, null, legends, function() {
                                                       (new AlertPopup($T("E-mail sent"), $T('An e-mail has been sent to: ') + \
                                                                       "<em>" + _.values(participantsChecked).join("</em>, <em>") + "</em>.")).open();
                                                       deselectAll();
                                                   });
            popup.open();
        }
        return false;
    };

    var manageAttendance = function(method, target, type){
        var arrayChecked=[];
        if (atLeastOneParticipantSelected()){
            $("input:checkbox:checked").each(function() {
                   arrayChecked.push($(this).val());
            });
        var killProgress = IndicoUI.Dialogs.Util.progress("Processing...");
        jsonRpc(Indico.Urls.JsonRpcService, method,
                { confId: "${self_._conf.getId()}",
                  userIds: arrayChecked },
                function(result, error){
                    killProgress();
                    if (exists(error)) {
                        IndicoUtil.errorReport(error);
                    } else {
                        $('input:checkbox:checked[id^=checkParticipant]').parent().siblings("td[id^="+target+"]").text(type);
                        $('input:checkbox:checked[id^=checkParticipant]').parents('tr[id^=participant]').effect("highlight", {}, 1500, deselectAll());
                    }
                });
        }
        return false;
    };

    $('#button-menu').dropdown();

    $('#add_existing_user').bind('menu_select', function() {
        var peopleAddedHandler = function(peopleList){
            searchParticipants("event.participation.addParticipants", peopleList);
        };
        return searchUsers("Add User(s)", peopleAddedHandler);
    });

    $('#add_new_user').bind('menu_select', function() {
        var onSuccess = function(result){
            $(result).insertAfter($("#headParticipants")).filter("tr[id^=participant]").effect("highlight",{},3000)
            actionParticipantRows();
            checkNumberParticipants();
        };
        new ApplyForParticipationPopup("${self_._conf.getId()}","event.participation.addParticipant",  $T("Add participant"), {}, onSuccess, true);
        return false;
    });

    $("#invite_users").bind('menu_select', function(){
        var inviteHandler = function(peopleList){
            var text = 'Dear {name}, event manager of {confTitle} would like to invite you to take part in this event, ' +
            'which will take place on ${conf.getAdjustedStartDate()}. Further information on this event are available at {url}' +
            '<br/><br/>' +
            'You are kindly requested to accept or decline your participation in this event by clicking on the link below :<br/>' +
            '{urlInvitation}' +
            'Looking forward to meeting you at {confTitle} <br/>' +
            'Best regards';
            var subject = "Invitation to ${conf.getTitle()}";
            var popup = new ParticipantsInvitePopup($T("Send mail to the participants"),"${conf.getTitle()}", ${conf.getId()}, "event.participation.inviteParticipants", peopleList, "${currentUser.getFullName()}" ,subject, text, legends, successAddParticipantsHandler);
            popup.open();
        };
        return searchUsers("Invite Participant(s)", inviteHandler);
    });
    $("#remove_users").bind('menu_select',
                                  function(){
                                      return removeParticipants();
                                  });
    $("#send_email").bind('menu_select', function(){
        return composeEmail("event.participation.emailParticipants");
    });

    $("#set_present").bind('menu_select', function () {
        return manageAttendance('event.participation.markPresent', 'presence','present');
    });

    $("#set_absent").bind('menu_select', function () {
        return manageAttendance('event.participation.markAbsence', 'presence','absent');
    });

    $("#excuse_absence").bind('menu_select', function () {
        return manageAttendance('event.participation.excuseAbsence', 'status','excused');
    });

    $("[name=excel]").click(function(){
        return atLeastOneParticipantSelected();
    });

    $(window).scroll(function(){
        IndicoUI.Effect.followScroll();
    });
});

</script>

const animations = {
    "STOP": "animation_desc",
    "COMBINE": "animation_desc",
    "PICKUP_LOWER": "animation_desc",
    "PICKUP_MIDDLE": "animation_desc",
    "PICKUP_UPPER": "animation_desc",
    "HANDSHEAD_KNEEL": "animation_desc",
    "HANDSHEAD_STAND": "animation_desc",
    "HANDSUP_KNEEL": "animation_desc",
    "HANDSUP_STAND": "animation_desc",
    "ENTERCODE": "animation_desc",
    "VOMIT": "animation_desc",
    "CROSSARMS": "animation_desc",
    "DABSAREGAY": "animation_desc",
    "DONTKNOW": "animation_desc",
    "DUSTOFF": "animation_desc",
    "FACEPALM": "animation_desc",
    "IDONTLISTEN": "animation_desc",
    "FLEXX": "animation_desc",
    "HALTSTOP": "animation_desc",
    "INEAR_COMM": "animation_desc",
    "ITSJUSTRIGHT": "animation_desc",
    "FALLONKNEES": "animation_desc",
    "KUNGFU": "animation_desc",
    "CALLME": "animation_desc",
    "SALUTE": "animation_desc",
    "SHOOSH": "animation_desc",
    "SLAPOWNASS": "animation_desc",
    "SLAPOWNASS2": "animation_desc",
    "THROATSLIT": "animation_desc",
    "THUMBSUP": "animation_desc",
    "WAVE3": "animation_desc",
    "WIPEOFFSWEAT": "animation_desc",
    "KICKDOOR": "animation_desc",
    "LOCKDOOR": "animation_desc",
    "CRAZYMAN": "animation_desc",
    "DARKSOULS": "animation_desc",
    "SMOKING": "animation_desc",
    "CLAP": "animation_desc",
    "SIT01": "animation_desc",
    "SIT02": "animation_desc",
    "SIT03": "animation_desc",
    "SIT04": "animation_desc",
    "SIT05": "animation_desc",
    "SIT06": "animation_desc",
    "SIT07": "animation_desc",
    "LAY01": "animation_desc",
    "LAY02": "animation_desc",
    "LAY03": "animation_desc",
    "LAY04": "animation_desc",
    "LAY05": "animation_desc",
    "LAY06": "animation_desc",
    "LAY07": "animation_desc",
    "LAY08": "animation_desc",
    "LAY09": "animation_desc",
    "LAY10": "animation_desc",
    "LAY11": "animation_desc",
    "LAY12": "animation_desc",
    "LAY13": "animation_desc",
    "LAY14": "animation_desc",
    "LAY15": "animation_desc",
    "LAY16": "animation_desc",
    "LAY17": "animation_desc",
    "LAY18": "animation_desc",
    "WAVE": "animation_desc",
    "WAVE2": "animation_desc",
    "STRETCH": "animation_desc",
    "BOW": "animation_desc",
    "CALL_GUARDS": "animation_desc",
    "CALL_SOMEONE": "animation_desc",
    "CALL_SOMEONE2": "animation_desc",
    "CHECK_EQUIPMENT": "animation_desc",
    "CHECK_EQUIPMENT2": "animation_desc",
    "CHECK_EQUIPMENT3": "animation_desc",
    "CLAP2": "animation_desc",
    "CLAP3": "animation_desc",
    "CHEER": "animation_desc",
    "DRUNK": "animation_desc",
    "FIX_STUFF": "animation_desc",
    "GET_HERE": "animation_desc",
    "GET_HERE2": "animation_desc",
    "GOAWAY": "animation_desc",
    "LAUGH": "animation_desc",
    "SALUTE2": "animation_desc",
    "THINKING": "animation_desc",
    "THROW": "animation_desc",
    "TRIUMPH": "animation_desc",
    "WASH_WINDOWS": "animation_desc",
    "WATCHING": "animation_desc",
    "DANCE01": "animation_desc",
    "DANCE02": "animation_desc",
    "DANCE03": "animation_desc",
    "DANCE04": "animation_desc",
    "DANCE05": "animation_desc",
    "DANCE06": "animation_desc",
    "DANCE07": "animation_desc",
    "DANCE08": "animation_desc",
    "DANCE09": "animation_desc",
    "DANCE10": "animation_desc",
    "DANCE11": "animation_desc",
    "DANCE12": "animation_desc",
    "DANCE13": "animation_desc",
    "DANCE14": "animation_desc",
    "DANCE15": "animation_desc",
    "DANCE16": "animation_desc",
    "DANCE17": "animation_desc",
    "DANCE18": "animation_desc",
    "DANCE19": "animation_desc",
    "DANCE20": "animation_desc",
    "CUFF": "animation_desc",
    "CUFF2": "animation_desc",
    "REVIVE": "animation_desc"
}

$(document).ready(() => {
    $('#close-button').click(() => {
        CallEvent('ORF.AnimationMenu.Close');
    });

    const anim_list = $('#anim_list');

    for (const animName in animations) {
        if (animations.hasOwnProperty(animName)) {
            const animDesc = animations[animName];
            
            anim_list.append('<div class="four wide column"><button id="anim_' + animName + '" class="ui button">' + animName + '</button ></div>');

            $('#anim_' + animName).click(() => {
                CallEvent('ORF.AnimationMenu.StartAction', animName, true);
            });

            $('#anim_' + animName).hover(() => {
                CallEvent('ORF.AnimationMenu.StartAction', animName, false);
            });
        }
    }
});

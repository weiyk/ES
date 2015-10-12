$(function () {
    $(".id-login .pic-list li").each(function () {
        $(this).css("background", "url(" + $(this).attr("rel") + ") center no-repeat");
    })
    var bnpic = function () {
        var df = 0;
        var time = 3500;
        var ttnum = $(".id-login .pic-list li").length - 1;
        var t;
        var play = function () {
            if (df < ttnum) {
                $(".id-login .pic-list li").eq(df).hide();
                df++;
                $(".id-login .pic-list li").eq(df).css("opacity", "1").fadeIn(200);
                $(".id-login .pic-dot span").eq(df).addClass("cur").siblings().removeClass("cur")
            } else {
                $(".id-login .pic-list li").eq(df).hide();
                df = 0;
                $(".id-login .pic-list li").eq(df).css("opacity", "1").fadeIn(200);
                $(".id-login .pic-dot span").eq(df).addClass("cur").siblings().removeClass("cur")
            }
        }
        t = setInterval(function () { play() }, time);

        $(".id-login .pic-dot span").click(function () {
            clearInterval(t);
            $(this).addClass("cur").siblings().removeClass("cur");
            $(".id-login .pic-list li").css("opacity", ".5").hide();
            $(".id-login .pic-list li").eq($(this).index()).css("opacity", "1").fadeIn(200);
            df = $(this).index();
        })
        $(".id-login .pic-dot span").mouseup(function () {
            t = setInterval(function () { play() }, time);
        })
    }
    bnpic();
})
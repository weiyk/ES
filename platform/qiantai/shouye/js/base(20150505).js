$(function () {
    $(".sub-tab li").click(function () {
        var xnum = $(this).index();
        $(this).addClass("cur").siblings().removeClass("cur");
        $(this).parents(".sub-tab").parent().find(".one-tabc").addClass("hidden");
        $(this).parents(".sub-tab").parent().find(".one-tabc").eq(xnum).removeClass("hidden");
    })

    $(".reader-box .pic-box").hover(function () {
        $(this).find(".cover").fadeIn(200);
        $(this).find(".to-read").fadeIn(200);
    }, function () {
        $(this).find(".cover").fadeOut(200);
        $(this).find(".to-read").fadeOut(200);
    })

    $(".select-box .select-cover").click(function (event) {
        $(".select-box").removeClass("curselect")
        $(this).parent().addClass("curselect");
        var sc = $(this).parent().find("ul");
        $(".select-box ul").hide();
        if (sc.hasClass("hidden")) {
            sc.show();
        } else {
            sc.hide();
        }
        event.stopPropagation();
    })
    $(".select-box ul li a").click(function () {
        $(this).parents(".select-box").find(".df-val").text($(this).text() + "");
        var pv = $(this).parents(".select-box");
        pv.find(".the-val").val($(this).attr("rel"));
        $(this).parent().parent().hide();
        $(this).parents(".select-box").removeClass("curselect")

    })
    $("body").click(function (event) {
        $(".select-box").removeClass("curselect")
        $(".select-box").find("ul").hide();
    })


    $(".reader-box .pic-box").hover(function () {
        $(this).find(".cover").fadeIn(200);
        $(this).find(".to-read").fadeIn(200);
    }, function () {
        $(this).find(".cover").fadeOut(200);
        $(this).find(".to-read").fadeOut(200);
    })


    $(".radio-box .one-rd").click(function () {
        $(this).addClass("rd-checked").siblings().removeClass("rd-checked");
        $(this).parent(".radio-box").find(".the-val").val($(this).attr("rel"));
    })


    var pop = function () {
        var bh = $("body").height();
        $(".pop-box .cover").css("height", bh + "px");

    }
    pop();
    $(".pop-box .to-close").click(function () {
        $(".pop-box").addClass("hidden");

    })
    $(".toup-zy").click(function () {
        $(".pop-box").removeClass("hidden");
    })


    $(".jc-tree .one-tree .title h4").click(function () {
        if ($(this).parent().parent().hasClass("curtree")) {
            $(this).parent().parent().removeClass("curtree");
        } else {
            $(this).parent().parent().addClass("curtree").siblings().removeClass("curtree");
        }
    })
    $(".jc-tree .list h5").click(function () {
        if ($(this).hasClass("cur")) {

            $(this).removeClass("cur");
            $(this).next().hide();
        } else {
            $(this).addClass("cur").siblings("h5").removeClass("cur");
            $(this).next().show().siblings("ul").hide();

        }
    })


    $(".bk-to-like").click(function () {
        if ($(this).hasClass("bk-liked")) {
            $(this).removeClass("bk-liked")
        } else {
            $(this).addClass("bk-liked")
        }
    })


    //lhl
    $(".side-title li").click(function () {
        var xnum = $(this).index();
        $(this).addClass("cur").siblings().removeClass("cur");
        if (xnum == "0") {
            $(".tlq-group").css("display", "block");
            $(".group-detail").css("display", "none");
        }
        else {
            $(".group-detail").css("display", "block");
            $(".tlq-group").css("display", "none");
        }
        // $(this).parents(".side-title").parent().find(".one-tabc").addClass("hidden");
        // $(this).parents(".side-title").parent().find(".one-tabc").eq(xnum).removeClass("hidden");
    })

    $(".questiondy-rt").click(function () {
        // $(this).parents(".dy-index-inlist").siblings().find(".dy-div-inlist").addClass("hidden");
        //var aa = $(this).children().attr("src");
        var aa = $(this).parents("li").attr("class");
        if (aa == "cur") {
            $(this).parents("li").attr("class", "");
            $(this).children().attr("src", "images/btn_down.png");
            $(this).parents(".dy-index-inlist").siblings().hide();
        }
        else {
            $(this).parents("li").attr("class", "cur");
            $(this).children().attr("src", "images/btn-up.png");
            $(this).parents(".dy-index-inlist").siblings().show();
        }

    });

    //评分控件
    $(".rating li").mouseover(function () {
        var lis = $(".rating li");
        var aa = $(this).index();
        for (var i = 0; i < 5; i++) {
            if (i < aa) {
                $(lis[i]).find("img").attr("src", "images/Star_Copy_selected.png");
            }
            else {
                $(lis[i]).find("img").attr("src", "images/Star_Copy_unselected.png");
            }
        }
    });
    //个人中心 切换点击按钮
    $(".grzx-title-all div").click(function () {
        if ($(this).attr("class") == "uncur") {
            $(this).attr("class", "cur");
            $(this).siblings().attr("class", "uncur");
        }
    })

    //自己学 教材目录
    $(".classone-ch-left .one-tree .title h4").click(function () {
        if ($(this).parent().parent().hasClass("curtree")) {
            $(this).parent().parent().removeClass("curtree");
        } else {
            $(this).parent().parent().addClass("curtree").siblings().removeClass("curtree");
        }
    })
    $(".classone-ch-left .list h5").click(function () {
        if ($(this).hasClass("cur")) {

            $(this).removeClass("cur");
            $(this).next().hide();
        } else {
            $(this).addClass("cur").siblings("h5").removeClass("cur");
            $(this).next().show().siblings("ul").hide();

        }
    })


    //单选按钮
    $(".radio-boxs .one-rd").click(function () {
        $(this).addClass("rd-checked").siblings().removeClass("rd-checked");
        $(this).parent(".radio-boxs").find(".the-val").val($(this).attr("rel"));
    })
    //多选按钮
    $(".multiselect-box .one-mult").click(function () {
        if ($(this).hasClass("mult-checked")) {
            $(this).removeClass("mult-checked");
        } else {
            $(this).addClass("mult-checked");
        }
        $(this).parent(".multiselect-box").find(".the-val").val($(this).attr("rel"));
    })
    //end lhl

    /* lh */
    $(".jc-tree .one-tree .dy-title h4").click(function () {
        if ($(this).parent().parent().hasClass("curtree")) {
            $(this).parent().parent().removeClass("curtree");
            $(this).parent().removeClass("bj");
            $(this).next().addClass("act").siblings().removeClass("act");

        } else {
            $(this).parent().parent().addClass("curtree").siblings().removeClass("curtree");
            $(this).parent().addClass("bj").siblings().removeClass("bj");
            $(this).parent().removeClass("act");
        }
    })

    /*zmt*/
    /*zmt 下拉菜单*/
    $(".select-boxs .select-cover").click(function (event) {
        $(".select-boxs").removeClass("curselect")
        $(this).parent().addClass("curselect");
        var sc = $(this).parent().find("ul");
        $(".select-boxs ul").hide();
        if (sc.hasClass("hidden")) {
            sc.show();
        } else {
            sc.hide();
        }
        event.stopPropagation();
    })
    $(".select-boxs ul li a").click(function () {
        $(this).parents(".select-boxs").find(".df-val").text($(this).text() + "");
        var pv = $(this).parents(".select-boxs");
        pv.find(".the-val").val($(this).attr("rel"));
        $(this).parent().parent().hide();
        $(this).parents(".select-boxs").removeClass("curselect")

    })
    $("body").click(function (event) {
        $(".select-boxs").removeClass("curselect")
        $(".select-boxs").find("ul").hide();
    })

    $(".select-q-boxs .select-cover").click(function (event) {
        $(".select-q-boxs").removeClass("curselect")
        $(this).parent().addClass("curselect");
        var sc = $(this).parent().find("ul");
        $(".select-q-boxs ul").hide();
        if (sc.hasClass("hidden")) {
            sc.show();
        } else {
            sc.hide();
        }
        event.stopPropagation();
    })
    $(".select-q-boxs ul li a").click(function () {
        $(this).parents(".select-q-boxs").find(".df-val").text($(this).text() + "");
        var pv = $(this).parents(".select-q-boxs");
        pv.find(".the-val").val($(this).attr("rel"));
        $(this).parent().parent().hide();
        $(this).parents(".select-q-boxs").removeClass("curselect")

    })
    $("body").click(function (event) {
        $(".select-q-boxs").removeClass("curselect")
        $(".select-q-boxs").find("ul").hide();
    })

    /*悬浮层 页面多个悬浮层 lh*/
    var pop2 = function () {
        var bh = $("body").height();
        $(".pop-box-1 .cover").css("height", bh + "px");

    }
    pop2();
    $(".pop-box-1 .to-close").click(function () {
        $(".pop-box-1").addClass("hidden");

    })
    $(".toup-zy-1").click(function () {
        $(".pop-box-1").removeClass("hidden");
    })
    var pop3 = function () {
        var bh = $("body").height();
        $(".pop-box-2 .cover").css("height", bh + "px");

    }
    pop3();
    $(".pop-box-2 .to-close").click(function () {
        $(".pop-box-2").addClass("hidden");

    })
    $(".toup-zy-2").click(function () {
        $(".pop-box-2").removeClass("hidden");
    })



    $(".jc-tree .one-tree .title h4").click(function () {
        if ($(this).parent().parent().hasClass("curtree")) {
            $(this).parent().parent().removeClass("curtree");
        } else {
            $(this).parent().parent().addClass("curtree").siblings().removeClass("curtree");
        }
    })
    $(".jc-tree .list h5").click(function () {
        if ($(this).hasClass("cur")) {

            $(this).removeClass("cur");
            $(this).next().hide();
        } else {
            $(this).addClass("cur").siblings("h5").removeClass("cur");
            $(this).next().show().siblings("ul").hide();

        }
    })
})
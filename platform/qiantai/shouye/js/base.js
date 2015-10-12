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
    $(".rating li").click(function () {
        var lis = $(".rating li");
        var aa = $(this).index();

        for (var i = 0; i < 5; i++) {
            if (i <= aa) {
                if (aa == 0) {
                    var pic = $(lis[i]).find("img").attr("src");
                    var pn = pic.substring(pic.lastIndexOf('/') + 1);
                    var picNext = $(lis[i + 1]).find("img").attr("src");
                    var pnNext = picNext.substring(picNext.lastIndexOf('/') + 1);
                    if (pn == "Star_Copy_selected.png" && pnNext == "Star_Copy_unselected.png") {
                        $(lis[i]).find("img").attr("src", "images/Star_Copy_unselected.png");
                    }
                    else {
                        $(lis[i]).find("img").attr("src", "images/Star_Copy_selected.png");
                    }
                }
                else {
                    $(lis[i]).find("img").attr("src", "images/Star_Copy_selected.png");
                }
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

    //教学空间到教学中心的跳转
    
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
    $(".star-box span").click(function () {
        var lis = $(".star-box span");
        var aa = $(this).index();
        for (var i = 0; i < 5; i++) {
            if (i <= aa) {
                if (aa == 0 && $(lis[i]).hasClass("star-on") && !$(lis[i + 1]).hasClass("star-on")) {
                    $(lis[i]).removeClass("star-on");
                }
                else {
                    $(lis[i]).addClass("star-on");
                }
            }
            else {
                $(lis[i]).removeClass("star-on");
            }
        }
    });
    $(".zy-reader-box .pic-box").hover(function () {
        $(this).find(".cover").fadeIn(200);
        $(this).find(".to-read").fadeIn(200);
    }, function () {
        $(this).find(".cover").fadeOut(200);
        $(this).find(".to-read").fadeOut(200);
    })

    $(".zy-reader-box .pic-box-1").hover(function () {
        $(this).find(".cover").fadeIn(200);
        $(this).find(".to-read").fadeIn(200);
    }, function () {
        $(this).find(".cover").fadeOut(200);
        $(this).find(".to-read").fadeOut(200);
    })
    $(".zy-reader-box .pic-box-2").hover(function () {
        $(this).find(".cover").fadeIn(200);
        $(this).find(".to-read").fadeIn(200);
    }, function () {
        $(this).find(".cover").fadeOut(200);
        $(this).find(".to-read").fadeOut(200);
    })
    $(".zy-reader-box .pic-box-3").hover(function () {
        $(this).find(".cover").fadeIn(200);
        $(this).find(".to-read").fadeIn(200);
    }, function () {
        $(this).find(".cover").fadeOut(200);
        $(this).find(".to-read").fadeOut(200);
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

    /* --xia下拉-- */
    $(".jc-tree .list-kclb h5").click(function () {
        if ($(this).hasClass("cur")) {

            $(this).removeClass("cur");
            $(this).next().hide();
        } else {
            $(this).addClass("cur").siblings("h5").removeClass("cur");
            $(this).next().show().siblings("ul").hide();

        }
    })
    $(".zyq-fb-ywq-tlq-s li").click(function () {
        var xnum = $(this).index();
        $(this).addClass("cur").siblings().removeClass("cur");
        $(this).parents(".zyq-fb-ywq-tlq-s").parent().find(".one-tabc").addClass("hidden");
        $(this).parents(".zyq-fb-ywq-tlq-s").parent().find(".one-tabc").eq(xnum).removeClass("hidden");
    })


    //    $(".jc-tree .one-tree .title h4").click(function () {
    //        if ($(this).parent().parent().hasClass("curtree")) {
    //            $(this).parent().parent().removeClass("curtree");
    //        } else {
    //            $(this).parent().parent().addClass("curtree").siblings().removeClass("curtree");
    //        }
    //    })
    //    $(".jc-tree .list h5").click(function () {
    //        if ($(this).hasClass("cur")) {

    //            $(this).removeClass("cur");
    //            $(this).next().hide();
    //        } else {
    //            $(this).addClass("cur").siblings("h5").removeClass("cur");
    //            $(this).next().show().siblings("ul").hide();

    //        }
    //    })

    //lh 2015-05-15
    var pop4= function () {
        var bh = $("body").height();
        $(".pop-box-4 .cover").css("height", bh + "px");

    }
    pop4();
    $(".pop-box-4 .to-close").click(function () {
        $(".pop-box-4").addClass("hidden");

    })
    $(".toup-zy-4").click(function () {
        $(".pop-box-4").removeClass("hidden");
    })






	 var pop6 = function () {
        var bh = $("body").height();
        $(".pop-box-6 .cover").css("height", bh + "px");

    }
    pop6();
    $(".pop-box-6 .to-close").click(function () {
        $(".pop-box-6").addClass("hidden");

    })
    $(".toup-zy-6").click(function () {
        $(".pop-box-6").removeClass("hidden");
    })



     var pop7 = function () {
        var bh = $("body").height();
        $(".pop-box-7 .cover").css("height", bh + "px");

    }
    pop7();
    $(".pop-box-7 .to-close").click(function () {
        $(".pop-box-7").addClass("hidden");

    })
    $(".toup-zy-7").click(function () {
        $(".pop-box-7").removeClass("hidden");
    })



     var pop8 = function () {
        var bh = $("body").height();
        $(".pop-box-8 .cover").css("height", bh + "px");

    }
    pop8();
    $(".pop-box-8 .to-close").click(function () {
        $(".pop-box-8").addClass("hidden");

    })
    $(".toup-zy-8").click(function () {
        $(".pop-box-8").removeClass("hidden");
    })




     var pop9 = function () {
        var bh = $("body").height();
        $(".pop-box-9 .cover").css("height", bh + "px");

    }
    pop9();
    $(".pop-box-9 .to-close").click(function () {
        $(".pop-box-9").addClass("hidden");

    })
    $(".toup-zy-9").click(function () {
        $(".pop-box-9").removeClass("hidden");
    })
	



     var pop10 = function () {
        var bh = $("body").height();
        $(".pop-box-10 .cover").css("height", bh + "px");

    }
    pop10();
    $(".pop-box-10 .to-close").click(function () {
        $(".pop-box-10").addClass("hidden");

    })
    $(".toup-zy-10").click(function () {
        $(".pop-box-10").removeClass("hidden");
    })
    




     var pop11 = function () {
        var bh = $("body").height();
        $(".pop-box-11 .cover").css("height", bh + "px");

    }
    pop11();
    $(".pop-box-11 .to-close").click(function () {
        $(".pop-box-11").addClass("hidden");

    })
    $(".toup-zy-11").click(function () {
        $(".pop-box-11").removeClass("hidden");
    })


    var pop12 = function () {
        var bh = $("body").height();
        $(".pop-box-12 .cover").css("height", bh + "px");

    }
    pop12();
    $(".pop-box-12 .to-close").click(function () {
        $(".pop-box-12").addClass("hidden");

    })
    $(".toup-zy-12").click(function () {
        $(".pop-box-12").removeClass("hidden");
    })




     var pop13 = function () {
        var bh = $("body").height();
        $(".pop-box-13 .cover").css("height", bh + "px");

    }
    pop13();
    $(".pop-box-13 .to-close").click(function () {
        $(".pop-box-13").addClass("hidden");

    })
    $(".toup-zy-13").click(function () {
        $(".pop-box-13").removeClass("hidden");
    })





     var pop14 = function () {
        var bh = $("body").height();
        $(".pop-box-14 .cover").css("height", bh + "px");

    }
    pop14();
    $(".pop-box-14 .to-close").click(function () {
        $(".pop-box-14").addClass("hidden");

    })
    $(".toup-zy-14").click(function () {
        $(".pop-box-14").removeClass("hidden");
    })




     var pop15 = function () {
        var bh = $("body").height();
        $(".pop-box-15 .cover").css("height", bh + "px");

    }
    pop15();
    $(".pop-box-15 .to-close").click(function () {
        $(".pop-box-15").addClass("hidden");

    })
    $(".toup-zy-15").click(function () {
        $(".pop-box-15").removeClass("hidden");
    })
    





     var pop16 = function () {
        var bh = $("body").height();
        $(".pop-box-16 .cover").css("height", bh + "px");

    }
    pop16();
    $(".pop-box-16 .to-close").click(function () {
        $(".pop-box-16").addClass("hidden");

    })
    $(".toup-zy-16").click(function () {
        $(".pop-box-16").removeClass("hidden");
    })
    





     var pop17 = function () {
        var bh = $("body").height();
        $(".pop-box-17 .cover").css("height", bh + "px");

    }
    pop17();
    $(".pop-box-17 .to-close").click(function () {
        $(".pop-box-17").addClass("hidden");

    })
    $(".toup-zy-17").click(function () {
        $(".pop-box-17").removeClass("hidden");
    })
    





     var pop18 = function () {
        var bh = $("body").height();
        $(".pop-box-18 .cover").css("height", bh + "px");

    }
    pop18();
    $(".pop-box-18 .to-close").click(function () {
        $(".pop-box-18").addClass("hidden");

    })
    $(".toup-zy-18").click(function () {
        $(".pop-box-18").removeClass("hidden");
    })
    




    var pop19 = function () {
        var bh = $("body").height();
        $(".pop-box-19 .cover").css("height", bh + "px");

    }
    pop19();
    $(".pop-box-19 .to-close").click(function () {
        $(".pop-box-19").addClass("hidden");

    })
    $(".toup-zy-19").click(function () {
        $(".pop-box-19").removeClass("hidden");
    })
    


    var pop20 = function () {
        var bh = $("body").height();
        $(".pop-box-20 .cover").css("height", bh + "px");

    }
    pop20();
    $(".pop-box-20 .to-close").click(function () {
        $(".pop-box-20").addClass("hidden");

    })
    $(".toup-zy-20").click(function () {
        $(".pop-box-20").removeClass("hidden");
    })
    



    var pop21 = function () {
        var bh = $("body").height();
        $(".pop-box-21 .cover").css("height", bh + "px");

    }
    pop21();
    $(".pop-box-21 .to-close").click(function () {
        $(".pop-box-21").addClass("hidden");

    })
    $(".toup-zy-21").click(function () {
        $(".pop-box-21").removeClass("hidden");
    })
    

    var pop22 = function () {
        var bh = $("body").height();
        $(".pop-box-22 .cover").css("height", bh + "px");

    }
    pop22();
    $(".pop-box-22 .to-close").click(function () {
        $(".pop-box-22").addClass("hidden");

    })
    $(".toup-zy-22").click(function () {
        $(".pop-box-22").removeClass("hidden");
    })
    



    var pop23 = function () {
        var bh = $("body").height();
        $(".pop-box-23 .cover").css("height", bh + "px");

    }
    pop23();
    $(".pop-box-23 .to-close").click(function () {
        $(".pop-box-23").addClass("hidden");

    })
    $(".toup-zy-23").click(function () {
        $(".pop-box-23").removeClass("hidden");
    })
    



    var pop24 = function () {
        var bh = $("body").height();
        $(".pop-box-24 .cover").css("height", bh + "px");

    }
    pop24();
    $(".pop-box-24 .to-close").click(function () {
        $(".pop-box-24").addClass("hidden");

    })
    $(".toup-zy-24").click(function () {
        $(".pop-box-24").removeClass("hidden");
    })
    


    var pop25 = function () {
        var bh = $("body").height();
        $(".pop-box-25 .cover").css("height", bh + "px");

    }
    pop25();
    $(".pop-box-25 .to-close").click(function () {
        $(".pop-box-25").addClass("hidden");

    })
    $(".toup-zy-25").click(function () {
        $(".pop-box-25").removeClass("hidden");
    })
    



    var pop26 = function () {
        var bh = $("body").height();
        $(".pop-box-26 .cover").css("height", bh + "px");

    }
    pop26();
    $(".pop-box-26 .to-close").click(function () {
        $(".pop-box-26").addClass("hidden");

    })
    $(".toup-zy-26").click(function () {
        $(".pop-box-26").removeClass("hidden");
    })
    


    var pop27 = function () {
        var bh = $("body").height();
        $(".pop-box-27 .cover").css("height", bh + "px");

    }
    pop27();
    $(".pop-box-27 .to-close").click(function () {
        $(".pop-box-27").addClass("hidden");

    })
    $(".toup-zy-27").click(function () {
        $(".pop-box-27").removeClass("hidden");
    })
    


    var pop28 = function () {
        var bh = $("body").height();
        $(".pop-box-28 .cover").css("height", bh + "px");

    }
    pop28();
    $(".pop-box-28 .to-close").click(function () {
        $(".pop-box-28").addClass("hidden");

    })
    $(".toup-zy-28").click(function () {
        $(".pop-box-28").removeClass("hidden");
    })
    


    var pop29 = function () {
        var bh = $("body").height();
        $(".pop-box-29 .cover").css("height", bh + "px");

    }
    pop29();
    $(".pop-box-29 .to-close").click(function () {
        $(".pop-box-29").addClass("hidden");

    })
    $(".toup-zy-29").click(function () {
        $(".pop-box-29").removeClass("hidden");
    })
    


    var pop30 = function () {
        var bh = $("body").height();
        $(".pop-box-30 .cover").css("height", bh + "px");

    }
    pop30();
    $(".pop-box-30 .to-close").click(function () {
        $(".pop-box-30").addClass("hidden");

    })
    $(".toup-zy-30").click(function () {
        $(".pop-box-30").removeClass("hidden");
    })
    

    var pop31 = function () {
        var bh = $("body").height();
        $(".pop-box-31 .cover").css("height", bh + "px");

    }
    pop31();
    $(".pop-box-31 .to-close").click(function () {
        $(".pop-box-31").addClass("hidden");

    })
    $(".toup-zy-31").click(function () {
        $(".pop-box-31").removeClass("hidden");
    })
    


    var pop32 = function () {
        var bh = $("body").height();
        $(".pop-box-32 .cover").css("height", bh + "px");

    }
    pop32();
    $(".pop-box-32 .to-close").click(function () {
        $(".pop-box-32").addClass("hidden");

    })
    $(".toup-zy-32").click(function () {
        $(".pop-box-32").removeClass("hidden");
    })
    


    var pop33 = function () {
        var bh = $("body").height();
        $(".pop-box-33 .cover").css("height", bh + "px");

    }
    pop33();
    $(".pop-box-33 .to-close").click(function () {
        $(".pop-box-33").addClass("hidden");

    })
    $(".toup-zy-33").click(function () {
        $(".pop-box-33").removeClass("hidden");
    })
    

    var pop34 = function () {
        var bh = $("body").height();
        $(".pop-box-34 .cover").css("height", bh + "px");

    }
    pop34();
    $(".pop-box-34 .to-close").click(function () {
        $(".pop-box-34").addClass("hidden");

    })
    $(".toup-zy-34").click(function () {
        $(".pop-box-34").removeClass("hidden");
    })
    


    var pop35 = function () {
        var bh = $("body").height();
        $(".pop-box-35 .cover").css("height", bh + "px");

    }
    pop35();
    $(".pop-box-35 .to-close").click(function () {
        $(".pop-box-35").addClass("hidden");

    })
    $(".toup-zy-35").click(function () {
        $(".pop-box-35").removeClass("hidden");
    })



    var pop36 = function () {
        var bh = $("body").height();
        $(".pop-box-36 .cover").css("height", bh + "px");

    }
    pop36();
    $(".pop-box-36 .to-close").click(function () {
        $(".pop-box-36").addClass("hidden");

    })
    $(".toup-zy-36").click(function () {
        $(".pop-box-36").removeClass("hidden");
    })



    var pop37 = function () {
        var bh = $("body").height();
        $(".pop-box-37 .cover").css("height", bh + "px");

    }
    pop37();
    $(".pop-box-37 .to-close").click(function () {
        $(".pop-box-37").addClass("hidden");

    })
    $(".toup-zy-37").click(function () {
        $(".pop-box-37").removeClass("hidden");
    })
    


    var pop38 = function () {
        var bh = $("body").height();
        $(".pop-box-38 .cover").css("height", bh + "px");

    }
    pop38();
    $(".pop-box-38 .to-close").click(function () {
        $(".pop-box-38").addClass("hidden");

    })
    $(".toup-zy-38").click(function () {
        $(".pop-box-38").removeClass("hidden");
    })



    var pop39 = function () {
        var bh = $("body").height();
        $(".pop-box-39 .cover").css("height", bh + "px");

    }
    pop39();
    $(".pop-box-39 .to-close").click(function () {
        $(".pop-box-39").addClass("hidden");

    })
    $(".toup-zy-39").click(function () {
        $(".pop-box-39").removeClass("hidden");
    })



var pop40 = function () {
        var bh = $("body").height();
        $(".pop-box-40 .cover").css("height", bh + "px");

    }
    pop40();
    $(".pop-box-40 .to-close").click(function () {
        $(".pop-box-40").addClass("hidden");

    })
    $(".toup-zy-40").click(function () {
        $(".pop-box-40").removeClass("hidden");
    })




var pop42 = function () {
        var bh = $("body").height();
        $(".pop-box-42 .cover").css("height", bh + "px");

    }
    pop42();
    $(".pop-box-42 .to-close").click(function () {
        $(".pop-box-42").addClass("hidden");

    })
    $(".toup-zy-42").click(function () {
        $(".pop-box-42").removeClass("hidden");
    })



var pop43 = function () {
        var bh = $("body").height();
        $(".pop-box-43 .cover").css("height", bh + "px");

    }
    pop43();
    $(".pop-box-43 .to-close").click(function () {
        $(".pop-box-43").addClass("hidden");

    })
    $(".toup-zy-43").click(function () {
        $(".pop-box-43").removeClass("hidden");
    })



var pop44 = function () {
        var bh = $("body").height();
        $(".pop-box-44 .cover").css("height", bh + "px");

    }
    pop44();
    $(".pop-box-44 .to-close").click(function () {
        $(".pop-box-44").addClass("hidden");

    })
    $(".toup-zy-44").click(function () {
        $(".pop-box-44").removeClass("hidden");
    })



var pop45 = function () {
        var bh = $("body").height();
        $(".pop-box-45 .cover").css("height", bh + "px");

    }
    pop45();
    $(".pop-box-45 .to-close").click(function () {
        $(".pop-box-45").addClass("hidden");

    })
    $(".toup-zy-45").click(function () {
        $(".pop-box-45").removeClass("hidden");
    })



var pop46 = function () {
        var bh = $("body").height();
        $(".pop-box-46 .cover").css("height", bh + "px");

    }
    pop46();
    $(".pop-box-46 .to-close").click(function () {
        $(".pop-box-46").addClass("hidden");

    })
    $(".toup-zy-46").click(function () {
        $(".pop-box-46").removeClass("hidden");
    })


	
	$("#map_es").click(function () {
        $("#es").removeClass("hidden");
        $("#mm").addClass("hidden");
    });

    $("#map_es_mm1").click(function () {
        $("#mm").removeClass("hidden");
        $("#es").addClass("hidden");
    });

    $("#map_es_mm2").click(function () {
        $("#mm").removeClass("hidden");
        $("#es").addClass("hidden");
    });

    $("#map_es_mm3").click(function () {
        $("#mm").removeClass("hidden");
        $("#es").addClass("hidden");
    });

    $("#map_es_mm4").click(function () {
        $("#mm").removeClass("hidden");
        $("#es").addClass("hidden");
    });

    $("#map_xa").click(function () {
        $("#xn").removeClass("hidden");
        $("#xnmm").addClass("hidden");
    });

    $("#map_xa_mm1").click(function () {
        $("#xnmm").removeClass("hidden");
        $("#xn").addClass("hidden");
    });

    $("#map_xa_mm2").click(function () {
        $("#xnmm").removeClass("hidden");
        $("#xn").addClass("hidden");
    });

    $("#map_xa_mm3").click(function () {
        $("#xnmm").removeClass("hidden");
        $("#xn").addClass("hidden");
    });


	
    $("#map_xa_mm4").click(function () {
        $("#xnmm").addClass("hidden");
        $("#xn").removeClass("hidden");
        $("#xn4").addClass("hidden");
        $("#xn5").addClass("hidden");
        $("#xn6").addClass("hidden");
        $("#xn7").addClass("hidden");
        $("#xn8").addClass("hidden");
        $("#xn9").addClass("hidden");
        $("#xn10").addClass("hidden");
        $("#xn11").addClass("hidden");
    });
    $("#map_xa_mm5").click(function () {
        $("#xnmm").removeClass("hidden");
        $("#xn").addClass("hidden");
        $("#xn4").addClass("hidden");
        $("#xn5").addClass("hidden");
        $("#xn6").addClass("hidden");
        $("#xn7").addClass("hidden");
        $("#xn8").addClass("hidden");
        $("#xn9").addClass("hidden");
        $("#xn10").addClass("hidden");
        $("#xn11").addClass("hidden");
    });
    $("#map_xa_mm6").click(function () {
        $("#xnmm").addClass("hidden");
        $("#xn").addClass("hidden");
        $("#xn4").removeClass("hidden");
        $("#xn5").addClass("hidden");
        $("#xn6").addClass("hidden");
        $("#xn7").addClass("hidden");
        $("#xn8").addClass("hidden");
        $("#xn9").addClass("hidden");
        $("#xn10").addClass("hidden");
        $("#xn11").addClass("hidden");
    });
    $("#map_xa_mm7").click(function () {
        $("#xnmm").addClass("hidden");
        $("#xn").addClass("hidden");
        $("#xn4").addClass("hidden");
        $("#xn6").addClass("hidden");
        $("#xn5").removeClass("hidden");
        $("#xn7").addClass("hidden");
        $("#xn8").addClass("hidden");
        $("#xn9").addClass("hidden");
        $("#xn10").addClass("hidden");
        $("#xn11").addClass("hidden");
    });
    $("#map_xa_mm8").click(function () {
        $("#xnmm").addClass("hidden");
        $("#xn").addClass("hidden");
        $("#xn4").addClass("hidden");
        $("#xn5").addClass("hidden");
        $("#xn7").addClass("hidden");
        $("#xn6").removeClass("hidden");
        $("#xn8").addClass("hidden");
        $("#xn9").addClass("hidden");
        $("#xn10").addClass("hidden");
        $("#xn11").addClass("hidden");
    });
    $("#map_xa_mm9").click(function () {
        $("#xnmm").addClass("hidden");
        $("#xn").addClass("hidden");
        $("#xn4").addClass("hidden");
        $("#xn5").addClass("hidden");
        $("#xn6").addClass("hidden");
        $("#xn8").addClass("hidden");
        $("#xn7").removeClass("hidden");
        $("#xn9").addClass("hidden");
        $("#xn10").addClass("hidden");
        $("#xn11").addClass("hidden");
    });
    $("#map_xa_mm10").click(function () {
        $("#xnmm").addClass("hidden");
        $("#xn").addClass("hidden");
        $("#xn4").addClass("hidden");
        $("#xn5").addClass("hidden");
        $("#xn6").addClass("hidden");
        $("#xn7").addClass("hidden");
        $("#xn9").addClass("hidden");
        $("#xn8").removeClass("hidden");
        $("#xn10").addClass("hidden");
        $("#xn11").addClass("hidden");
    });
    $("#map_xa_mm11").click(function () {
        $("#xnmm").addClass("hidden");
        $("#xn").addClass("hidden");
        $("#xn4").addClass("hidden");
        $("#xn5").addClass("hidden");
        $("#xn6").addClass("hidden");
        $("#xn7").addClass("hidden");
        $("#xn8").addClass("hidden");
        $("#xn10").addClass("hidden");
        $("#xn9").removeClass("hidden");
        $("#xn11").addClass("hidden");
    });
    $("#map_xa_mm12").click(function () {
        $("#xnmm").addClass("hidden");
        $("#xn").addClass("hidden");
        $("#xn4").addClass("hidden");
        $("#xn10").removeClass("hidden");
        $("#xn6").addClass("hidden");
        $("#xn7").addClass("hidden");
        $("#xn8").addClass("hidden");
        $("#xn9").addClass("hidden");
        $("#xn5").addClass("hidden");
        $("#xn11").addClass("hidden");
    });
    $("#map_xa_mm13").click(function () {
        $("#xnmm").addClass("hidden");
        $("#xn").addClass("hidden");
        $("#xn4").addClass("hidden");
        $("#xn11").removeClass("hidden");
        $("#xn6").addClass("hidden");
        $("#xn7").addClass("hidden");
        $("#xn8").addClass("hidden");
        $("#xn9").addClass("hidden");
        $("#xn10").addClass("hidden");
        $("#xn5").addClass("hidden");
    });
	
	
	
	
    $("#map_es_mm6").click(function () {
        $("#mm").removeClass("hidden");
        $("#es").addClass("hidden");
        $("#mm1").addClass("hidden");
        $("#mm2").addClass("hidden");
        $("#mm3").addClass("hidden");
        $("#mm4").addClass("hidden");
    });
    $("#map_es_mm5").click(function () {
        $("#mm").addClass("hidden");
        $("#es").removeClass("hidden");
        $("#mm1").addClass("hidden");
        $("#mm2").addClass("hidden");
        $("#mm3").addClass("hidden");
        $("#mm4").addClass("hidden");
    });
    $("#map_es_mm7").click(function () {
        $("#mm").addClass("hidden");
        $("#es").addClass("hidden");
        $("#mm1").removeClass("hidden");
        $("#mm2").addClass("hidden");
        $("#mm3").addClass("hidden");
        $("#mm4").addClass("hidden");
    });
    $("#map_es_mm8").click(function () {
        $("#mm").addClass("hidden");
        $("#es").addClass("hidden");
        $("#mm1").addClass("hidden");
        $("#mm2").removeClass("hidden");
        $("#mm3").addClass("hidden");
        $("#mm4").addClass("hidden");
    });
    $("#map_es_mm9").click(function () {
        $("#mm").addClass("hidden");
        $("#es").addClass("hidden");
        $("#mm1").addClass("hidden");
        $("#mm2").addClass("hidden");
        $("#mm3").removeClass("hidden");
        $("#mm4").addClass("hidden");
    });
    $("#map_es_mm10").click(function () {
        $("#mm").addClass("hidden");
        $("#es").addClass("hidden");
        $("#mm1").addClass("hidden");
        $("#mm2").addClass("hidden");
        $("#mm3").addClass("hidden");
        $("#mm4").removeClass("hidden");
    });




})


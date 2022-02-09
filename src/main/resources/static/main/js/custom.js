    "use strict";

    //General function for all pages

    //Modernizr touch detect
    Modernizr.load({
            test: Modernizr.touch,
            yep :['/static/main/css/touch.css?v=1'],
            nope: [] 
    });

	//1. Scroll to top arrow
	// Scroll to top
    var $block =$('<div/>',{'class':'top-scroll'}).append('<a href="#"/>').hide().appendTo('body').click(function () {
        $('body,html').animate({scrollTop: 0}, 800);
        return false;
    });

    //initialization
    var $window = $(window);

    if ($window.scrollTop() > 35) {showElem();}
    else {hideElem();}

    //handlers
    $window.scroll(function () {
        if ($(this).scrollTop() > 35) {showElem();}
        else {hideElem();}
    });

    //functions
    function hideElem(){
        $block.fadeOut();
    }
    function showElem(){
        $block.fadeIn();
    }

    //2. Mobile menu
    //Init mobile menu
    $('#navigation').mobileMenu({
        triggerMenu:'#navigation-toggle',
        subMenuTrigger: ".sub-nav-toggle",
        animationSpeed:500  
    });

    //3. Search bar dropdown
    //search bar
    $("#search-sort").selectbox({
        onChange: function (val, inst) {

            $(inst.input[0]).children().each(function(item){
                $(this).removeAttr('selected');
            })
            $(inst.input[0]).find('[value="'+val+'"]').attr('selected','selected');
        }

    });

    //4. Login window pop up
    //Login pop up
    $('.login-window').click(function (e){
        e.preventDefault();
        $('.overlay').removeClass('close').addClass('open');
    });

    $('.overlay-close').click(function (e) {
        e.preventDefault;
        $('.overlay').removeClass('open').addClass('close');

        setTimeout(function(){
            $('.overlay').removeClass('close');}, 500);
    });

function init_Elements () {
    "use strict";

	//1. Accodions
	//Init 2 type accordions
        $('#accordion').collapse();
        $('#accordion-dark').collapse();

    //2. Dropdown
    //select
    $("#select-sort").selectbox({
            onChange: function (val, inst) {

                $(inst.input[0]).children().each(function(item){
                    $(this).removeAttr('selected');
                })
                $(inst.input[0]).find('[value="'+val+'"]').attr('selected','selected');
            }

        });

            

    //3. Datapicker init
    $( ".datepicker__input" ).datepicker({
        showOtherMonths: true,
        selectOtherMonths: true,
        showAnim:"fade"
    });

    $(document).click(function(e) { 
        var ele = $(e.target); 
        if (!ele.hasClass("datepicker__input") && !ele.hasClass("ui-datepicker") && !ele.hasClass("ui-icon") && !$(ele).parent().parents(".ui-datepicker").length){
             $(".datepicker__input").datepicker("hide");

        }
   });

   //4. Tabs
   //Init 2 type tabs
    $('#hTab a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    });

    $('#vTab a').click(function (e) {
        e.preventDefault()
        $(this).tab('show')
    }); 

    //5. Mega select with filters
    //Mega select interaction
            $('.mega-select__filter').click(function(e){
                //prevent the default behaviour of the link
                e.preventDefault();
                $('.select__field').val('');
   
                $('.mega-select__filter').removeClass('filter--active');
                $(this).addClass('filter--active');
                
                //get the data attribute of the clicked link(which is equal to value filter of our content
                var filter = $(this).attr('data-filter');

                //Filter buttoms
                //show all the list items(this is needed to get the hidden ones shown)
                $(".select__btn a").show();
                
                /*using the :not attribute and the filter class in it we are selecting
                only the list items that don't have that class and hide them '*/
                $('.select__btn a:not(.' + filter + ')').hide();

                //Filter dropdown
                //show all the list items(this is needed to get the hidden ones shown)
                $(".select__group").removeClass("active-dropdown");
                $(".select__group").show();
                
                /*using the :not attribute and the filter class in it we are selecting
                only the list items that don't have that class and hide them '*/
                $('.select__group.' + filter).addClass("active-dropdown");
                $('.select__group:not(.' + filter + ')').hide();
            });

             $('.filter--active').trigger('click');
                
                
            
            $('.select__field').focus(function() {
                $(this).parent().find('.active-dropdown').css("opacity", 1);
            });

            $('.select__field').blur(function() {
                $(this).parent().find('.active-dropdown').css("opacity", 0);
            });


            $('.select__variant').click( function () {
                var value = $(this).attr('data-value');

                $('.select__field').val(value);
            });

    //6. Progressbar
    		//Count function for progressbar
    		function init_progressBar(duration) {
                    $('.progress').each(function() {
                        var value = $(this).find('.progress__bar').attr('data-level');
                        var result = value + '%';
                        if(duration) {
                            $(this).find('.progress__current').animate({width : value + '%'}, duration);
                        }
                        else {
                            $(this).find('.progress__current').css({'width' : value + '%'});
                        }
                        
                    });
            }

            //inview progress bars
            // $('.progress').one('inview', function (event, visible) {
            //     if (visible == true) {
            //           
            //     }
            // });

            var inview = new Waypoint.Inview({
              element: $('.progress')[0],
              enter: function(direction) {
                init_progressBar(2000);
              }
            });

    //7. Dropdown for authorize button
    		//user list option
            $('.auth__show').click(function (e){
                e.preventDefault();
                $('.auth__function').toggleClass('open-function')
            })

            $('.btn--singin').click(function (e){
                e.preventDefault();
                $('.auth__function').toggleClass('open-function')
            });

}

function init_Home() {
    "use strict";

	//1. Init revolution slider and add arrows behaviour
    var api = $('.banner').show().revolution({
        delay:9000,
        startwidth:1170,
        startheight:500,

        navigation: {

            arrows: {
                enable: true,
                style: 'hebe',
                hide_onleave: false,
                tmp: '<span class="slider__info">{{title}}</span>'
            }
        },

        spinner: 'spinner2',
      });
	
	//2. Dropdown for authorize button
    //user list option
    $('.auth__show').click(function (e){
        e.preventDefault();
        $('.auth__function').toggleClass('open-function')
    })

    $('.btn--singin').click(function (e){
        e.preventDefault();
        $('.auth__function').toggleClass('open-function')
    });

    //3. Mega select with filters (and markers)
    //Mega select interaction
    $('.mega-select__filter').click(function(e){
        //prevent the default behaviour of the link
        e.preventDefault();
        $('.select__field').val('');

        $('.mega-select__filter').removeClass('filter--active');
        $(this).addClass('filter--active');

        //get the data attribute of the clicked link(which is equal to value filter of our content)
        var filter = $(this).attr('data-filter');
        $("#type_search").val(filter);

        //Filter buttons
        //show all the list items(this is needed to get the hidden ones shown)
        $(".select__btn a").show();
        $(".select__btn a").css('display', 'inline-block');

        /*using the :not attribute and the filter class in it we are selecting
        only the list items that don't have that class and hide them '*/
        $('.select__btn a:not(.' + filter + ')').hide();

        //Filter dropdown
        //show all the list items(this is needed to get the hidden ones shown)
        $(".select__group").removeClass("active-dropdown");
        $(".select__group").show();

        /*using the :not attribute and the filter class in it we are selecting
        only the list items that don't have that class and hide them '*/
        $('.select__group.' + filter).addClass("active-dropdown");
        $('.select__group:not(.' + filter + ')').hide();

        //Filter marker
        //show all the list items(this is needed to get the hidden ones shown)
        $(".marker-indecator").show();

        /*using the :not attribute and the filter class in it we are selecting
        only the list items that don't have that class and hide them '*/
        $('.marker-indecator:not(.' + filter + ')').hide();
    });

    $('.filter--active').trigger('click');
    $('.active-dropdown').css("z-index", '-1');

    $('.select__field').focus(function() {
        $(this).parent().find('.active-dropdown').css("opacity", 1);
        $(this).parent().find('.active-dropdown').css("z-index", '50');
    });

    $('.select__field').blur(function() {
        $(this).parent().find('.active-dropdown').css("opacity", 0);
        $(this).parent().find('.active-dropdown').css("z-index", '-1');
    });

    $('.select__variant').click( function (e) {
        e.preventDefault();
        $(this).parent().find('.active-dropdown').css("z-index", '50');
        var value = $(this).attr('data-value');
        $('.select__field').val(value);
        $(this).parent().find('.active-dropdown').css("z-index", '-1');
    });

    //4. Rating scrore init
    //Rating star
    $('.score').raty({
        width:130,
        score: 0,
        path: '/static/main/images/rate/',
        starOff : 'star-off.svg',
        starOn  : 'star-on.svg'
    });

    //5. Scroll down navigation function
    //scroll down
    $('.movie-best__check').click(function (ev) {
        ev.preventDefault();
        $('html, body').stop().animate({'scrollTop': $('#target').offset().top-30}, 900, 'swing');
    });
}

function init_Profile() {
    "use strict";

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $("#imagePreview").css(
                    "background-image",
                    "url(" + e.target.result + ")"
                );
                $("#imagePreview").hide();
                $("#imagePreview").fadeIn(650);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
    $("#imageUpload").change(function () {
        readURL(this);
    });
}

function init_BookingOne() {
    "use strict";

	//1. Buttons for choose order method
	//order factor
    $('.order__control-btn').click(function (e) {
        e.preventDefault();

        $('.order__control-btn').removeClass('active');
        $(this).addClass('active');
    })

    //2. Init vars for order data
    // var for booking;
                var movie = $('.choosen-movie'),
                    city = $('.choosen-city'),
                    date = $('.choosen-date'),
                    cinema = $('.choosen-cinema'),
                    time = $('.choosen-time');

    //3. Swiper slider
    //init employee sliders
                var mySwiper = new Swiper('.swiper-container',{
                    slidesPerView:10,
                    loop:true
                  });

                $('.swiper-slide-active').css({'marginLeft':'-2px'});
                //media swipe visible slide
                //Onload detect
                    if ($(window).width() > 1930 ){
                         mySwiper.params.slidesPerView=13;
                         //mySwiper.resizeFix();         
                    }else

                    if ($(window).width() >993 & $(window).width() <  1199  ){
                         mySwiper.params.slidesPerView=6;
                         //mySwiper.resizeFix();         
                    }
                    else
                    if ($(window).width() >768 & $(window).width() <  992  ){
                         mySwiper.params.slidesPerView=5;
                         //mySwiper.resizeFix();         
                    }

                    else
                    if ($(window).width() < 767 & $(window).width() > 481){
                         mySwiper.params.slidesPerView=4;
                         //mySwiper.resizeFix();    
                    
                    } else
                     if ($(window).width() < 480){
                         mySwiper.params.slidesPerView=2;
                         //mySwiper.resizeFix();    
                    }

                    else{
                        mySwiper.params.slidesPerView=10;
                        // mySwiper.resizeFix();
                    }

                //Resize detect
                $(window).resize(function(){
                    if ($(window).width() > 1930 ){
                         mySwiper.params.slidesPerView=13;
                         mySwiper.update();          
                    }

                    if ($(window).width() >993 & $(window).width() <  1199  ){
                         mySwiper.params.slidesPerView=6;
                         mySwiper.update();          
                    }
                    else
                     if ($(window).width() >768 & $(window).width() <  992  ){
                         mySwiper.params.slidesPerView=5;
                         mySwiper.update();         
                    }

                    else
                    if ($(window).width() < 767 & $(window).width() > 481){
                         mySwiper.params.slidesPerView=4;
                          mySwiper.update();    
                    
                    } else
                     if ($(window).width() < 480){
                         mySwiper.params.slidesPerView=2;
                         mySwiper.update();   
                    }

                    else{
                        mySwiper.params.slidesPerView=10;
                        mySwiper.update();
                    }
                 });
	
	//4. Dropdown init 
				//select
                $("#select-sort").selectbox({
                        onChange: function (val, inst) {

                            $(inst.input[0]).children().each(function(item){
                                $(this).removeAttr('selected');
                            })
                            $(inst.input[0]).find('[value="'+val+'"]').attr('selected','selected');
                        }

                    });

    
    //5. Datepicker init
                $( ".datepicker__input" ).datepicker({
                  showOtherMonths: true,
                  selectOtherMonths: true,
                  showAnim:"fade"
                });

                $(document).click(function(e) { 
                    var ele = $(e.target); 
                    if (!ele.hasClass("datepicker__input") && !ele.hasClass("ui-datepicker") && !ele.hasClass("ui-icon") && !$(ele).parent().parents(".ui-datepicker").length){
                       $(".datepicker__input").datepicker("hide");
                     }
                });

	//6. Choose variant proccess
				//choose film
                $('.film-images').click(function (e) {
                	 //visual iteractive for choose
                     $('.film-images').removeClass('film--choosed');
                     $(this).addClass('film--choosed');

                     //data element init
                     var chooseFilm = $(this).parent().attr('data-film');
                     $('.choose-indector--film').find('.choosen-area').text(chooseFilm);

                     //data element set
                     movie.val(chooseFilm);

                })

                //choose time
                $('.time-select__item').click(function (){
                	//visual iteractive for choose
                    $('.time-select__item').removeClass('active');
                    $(this).addClass('active');

                    //data element init
                    var chooseTime = $(this).attr('data-time');
                     $('.choose-indector--time').find('.choosen-area').text(chooseTime);

                    //data element init
                    var chooseCinema = $(this).parent().parent().find('.time-select__place').text(); 

                    //data element set
                    time.val(chooseTime);
                    cinema.val(chooseCinema);
                });

                // choose (change) city and date for film

                //data element init (default)
                var chooseCity = $('.select .sbSelector').text();
                var chooseDate = $('.datepicker__input').val();

                //data element set (default)
                city.val(chooseCity);
                date.val(chooseDate);


                $('.select .sbOptions').click(function (){
                	//data element change
                    var chooseCity = $('.select .sbSelector').text();
                    //data element set change
                    city.val(chooseCity);
                });

                $('.datepicker__input').change(function () {
                	//data element change
                    var chooseDate = $('.datepicker__input').val();
                    //data element set change
                    date.val(chooseDate);
                });

                // --- Step for data - serialize and send to next page---//
                $('.booking-form').submit( function () {
                    var bookData = $(this).serialize();
                    $.get( $(this).attr('action'), bookData );
                })

    //7. Visibility block on page control
    			//control block display on page
                $('.choose-indector--film').click(function (e) {
                    e.preventDefault();
                    $(this).toggleClass('hide-content');
                    $('.choose-film').slideToggle(400);
                })

                $('.choose-indector--time').click(function (e) {
                    e.preventDefault();
                    $(this).toggleClass('hide-content');
                    $('.time-select').slideToggle(400);
                })
}

function init_BookingTwo () {
    "use strict";

	//1. Buttons for choose order method
	//order factor
    $('.order__control-btn').click(function (e) {
        e.preventDefault();

        $('.order__control-btn').removeClass('active');
        $(this).addClass('active');
    })

    //2. Init vars for order data
    // var for booking;
    var sits = $('.choosen-sits');

    //3. Choose sits (and count price for them)
    //users choose sits

    //data elements init
    var sum = 0;

    $('.sits__place').click(function (e) {
        e.preventDefault();
        var id = $(this).attr('data-id');
        var place = $(this).attr('data-place');
        var ticketPrice = parseInt($(this).attr('data-price'));
        var num = $(".choosen-place").length;

        if(!$(e.target).hasClass('sits-state--your')){
            if (!$(this).hasClass('sits-state--not') ) {
                if(num !== 10) {
                    $(this).addClass('sits-state--your');
                    $('.checked-place').prepend('<span class="choosen-place ' + place + '" data-id="' + id + '">' + place + '</span>');
                    sum += ticketPrice;
                    $('.checked-result').text('$' + sum);
                }
            }
        } else{
            $(this).removeClass('sits-state--your');
            $('.'+place+'').remove();
            sum -= ticketPrice;
            $('.checked-result').text('$'+sum)
        }

        //data element init
        var chooseSits = '';
        $('.choosen-place').each( function () {
            chooseSits += ', '+ $(this).attr("data-id");
        });

        //data element set
        sits.val(chooseSits.substr(2));
    });

    $('.top-scroll').parent().find('.top-scroll').remove();
}

function init_CinemaList () {
    "use strict";

	//1. Dropdowns
    //select
    $(".select__sort").selectbox({
        onChange: function (val, inst) {
            $("#select").submit();
        }
    });

    //2. Sorting buy category
    // sorting function
    $('.tags__item').click(function (e) {
        //prevent the default behaviour of the link
        e.preventDefault();

        var filter = $(this).attr('data-filter');

        $("#select input[name='sort']").val(filter);
        $("#select").submit();
    });
}

function init_Contact () {
    "use strict";

	//1. Fullscreen map init
				//Init map
                    var mapOptions = {
                        scaleControl: true,
                        center: new google.maps.LatLng(51.509708, -0.130539),
                        zoom: 15,
                        navigationControl: false,
                        streetViewControl: false,
                        mapTypeControl: false,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    };
                    var map = new google.maps.Map(document.getElementById('location-map'),mapOptions);
                    var marker = new google.maps.Marker({
                        map: map,
                        position: map.getCenter() 
                    });

                    //Custome map style
                    var map_style = [{stylers:[{saturation:-100},{gamma:3}]},{elementType:"labels.text.stroke",stylers:[{visibility:"off"}]},{featureType:"poi.business",elementType:"labels.text",stylers:[{visibility:"off"}]},{featureType:"poi.business",elementType:"labels.icon",stylers:[{visibility:"off"}]},{featureType:"poi.place_of_worship",elementType:"labels.text",stylers:[{visibility:"off"}]},{featureType:"poi.place_of_worship",elementType:"labels.icon",stylers:[{visibility:"off"}]},{featureType:"road",elementType:"geometry",stylers:[{visibility:"simplified"}]},{featureType:"water",stylers:[{visibility:"on"},{saturation:0},{gamma:2},{hue:"#aaaaaa"}]},{featureType:"administrative.neighborhood",elementType:"labels.text.fill",stylers:[{visibility:"off"}]},{featureType:"road.local",elementType:"labels.text",stylers:[{visibility:"off"}]},{featureType:"transit.station",elementType:"labels.icon",stylers:[{visibility:"off"}]}]

                    //Then we use this data to create the styles.
                    var styled_map = new google.maps.StyledMapType(map_style, {name: "Cusmome style"});

                    map.mapTypes.set('map_styles', styled_map);
                    map.setMapTypeId('map_styles');


                    //=====================================

                    // Maker

                    //=====================================

                    //Creates the information to go in the pop-up info box.
                    var boxTextA = document.createElement("div");
                    boxTextA.innerHTML = '<span class="pop_up_box_text">Leicester Sq, London, WC2H 7LP</span>';

                    //Sets up the configuration options of the pop-up info box.
                    var infoboxOptionsA = {
                     content: boxTextA
                     ,disableAutoPan: false
                     ,maxWidth: 0
                     ,pixelOffset: new google.maps.Size(30, -50)
                     ,zIndex: null
                     ,boxStyle: {
                     background: "#4c4145"
                     ,opacity: 1
                     ,width: "300px"
                     ,color: " #b4b1b2"
                     ,fontSize:"13px"
                     ,padding:'14px 20px 15px'
                     }
                     ,closeBoxMargin: "6px 2px 2px 2px"
                     ,infoBoxClearance: new google.maps.Size(1, 1)
                     ,closeBoxURL: "images/components/close.svg"
                     ,isHidden: false
                     ,pane: "floatPane"
                     ,enableEventPropagation: false
                    };

                    
                    //Creates the pop-up infobox for Glastonbury, adding the configuration options set above.
                    var infoboxA = new InfoBox(infoboxOptionsA);


                    //Add an 'event listener' to the Glastonbury map marker to listen out for when it is clicked.
                    google.maps.event.addListener(marker, "click", function (e) {
                     //Open the Glastonbury info box.
                     infoboxA.open(map, this);
                     //Sets the Glastonbury marker to be the center of the map.
                     map.setCenter(marker.getPosition());
                    });
}

function init_Gallery () {
    "use strict";
	//1. Pop up fuction for gallery elements

				//pop up for photo (object - images)
                $('.gallery-item--photo').magnificPopup({
                    type: 'image',
                    closeOnContentClick: true,
                    mainClass: 'mfp-fade',
                    image: {
                        verticalFit: true
                    },
                    gallery: {
                        enabled: true,
                        navigateByImgClick: true,
                        preload: [0,1] // Will preload 0 - before current, and 1 after the current image
                    }
                    
                });

                //pop up for photo (object - title link)
                $('.gallery-item--photo-link').magnificPopup({
                    type: 'image',
                    closeOnContentClick: true,
                    mainClass: 'mfp-fade',
                    image: {
                        verticalFit: true
                    },
                    gallery: {
                        enabled: true,
                        navigateByImgClick: true,
                        preload: [0,1] // Will preload 0 - before current, and 1 after the current image
                    }
                    
                });

                //pop up for video (object - images)
                 $('.gallery-item--video').magnificPopup({
                    disableOn: 700,
                    type: 'iframe',
                    mainClass: 'mfp-fade',
                    removalDelay: 160,
                    preloader: false,

                    fixedContentPos: false,
                    gallery: {
                        enabled: true,
                        preload: [0,1] // Will preload 0 - before current, and 1 after the current image
                    }
                });

                //pop up for video (object - title link)
                 $('.gallery-item--video-link').magnificPopup({
                    disableOn: 700,
                    type: 'iframe',
                    mainClass: 'mfp-fade',
                    removalDelay: 160,
                    preloader: false,

                    fixedContentPos: false,
                    gallery: {
                        enabled: true,
                        preload: [0,1] // Will preload 0 - before current, and 1 after the current image
                    }
                });
}

function init_MovieList () {
    "use strict";

	//1. Dropdown init 
    //select
    $(".select__sort").selectbox({
        onChange: function (val, inst) {

            $(inst.input[0]).children().each(function(item){
                $(this).removeAttr('selected');
            })
            $(inst.input[0]).find('[value="'+val+'"]').attr('selected','selected');
        }

    });

    
    //2. Datepicker init
    $( ".datepicker__input" ).datepicker({
      showOtherMonths: true,
      selectOtherMonths: true,
      showAnim:"fade"
    });

    $(document).click(function(e) {
        var ele = $(e.target);
        if (!ele.hasClass("datepicker__input") && !ele.hasClass("ui-datepicker") && !ele.hasClass("ui-icon") && !$(ele).parent().parents(".ui-datepicker").length){
           $(".datepicker__input").datepicker("hide");
         }
    });

    //3. Rating scrore init
    //Rating star
    $('.score').raty({
        width:130, 
        score: 0,
        path: 'images/rate/',
        starOff : 'star-off.svg',
        starOn  : 'star-on.svg' 
    });

    //4. Sorting by category
    // sorting function
    $('.tags__item').click(function (e) {
        console.log($(this));
        //active sorted item
        $('.tags__item').removeClass('item-active');
        $(this).addClass('item-active');

        var filter = $(this).attr('data-filter');

        $("#filter_from input[name='sort']").val(filter);
        $("#filter_from").submit();
    });

	//5. Toggle function for additional content
    //toggle timetable show
    $('.movie__show-btn').click(function (ev) {
        ev.preventDefault();

        $(this).parents('.movie--preview').find('.time-select').slideToggle(500);
    });

    $('.time-select__item').click(function (){
        $('.time-select__item').removeClass('active');
        $(this).addClass('active');
    });
}

function init_Star(){
    "use strict";

    $('.tags__item').click(function (e) {
        //prevent the default behaviour of the link
        e.preventDefault();

        //active sorted item
        $('.tags__item').removeClass('item-active');
        $(this).addClass('item-active');

        var filter = $(this).attr('data-filter');

        //show all the list items(this is needed to get the hidden ones shown)
        $(".movie--preview").show();

        /*using the :not attribute and the filter class in it we are selecting
            only the list items that don't have that class and hide them '*/
        if ( filter.toLowerCase()!=='all'){
            $('.movie--preview:not(.' + filter + ')').hide();
        }
    });
}

function init_MoviePage () {
    "use strict";

    $(".select--date .select__sort").selectbox({
        onChange: function (val, inst) {
            $(inst.input[0]).children().each(function(item){
                $(this).removeAttr('selected');
            })
            $(inst.input[0]).find('[value="'+val+'"]').attr('selected','selected');
            $(inst.input[0]).prev().val($("#select-city").val());
            $(inst.input[0]).parent().submit();
        }

    });

    $(".select--city .select__sort").selectbox({
        onChange: function (val, inst) {
            $(inst.input[0]).children().each(function(item){
                $(this).removeAttr('selected');
            })
            $(inst.input[0]).find('[value="'+val+'"]').attr('selected','selected');
            $("#select-date").prev().val(val);
            $("#select-date").parent().submit();
        }

    });

	//1. Rating scrore init
    //Rating star
    $('.score').raty({
        width: 300,
        score: 10,
        path: '/static/main/images/rate/',
        starOff : 'star-off.svg',
        starOn  : 'star-on.svg' 
    });

    //2. Swiper slider
    //Media slider
    //init employee sliders
    var mySwiper = new Swiper('.swiper-container',{
        slidesPerView:4,
    });

    $('.swiper-slide-active').css({'marginLeft':'-1px'});

    //Media switch
    $('.list--photo').click(function (e){
        e.preventDefault();

        var mediaFilter = $(this).attr('data-filter');

        $('.swiper-slide').hide();
        $('.' + mediaFilter).show();

        $('.swiper-wrapper').css('transform','translate3d(0px, 0px, 0px)')
        mySwiper.params.slideClass = mediaFilter;

        mySwiper.update();
        $('.swiper-slide-active').css({'marginLeft':'-1px'});
    })

    $('.list--video').click(function (e){
        e.preventDefault();

        var mediaFilter = $(this).attr('data-filter');
        $('.swiper-slide').hide();
        $('.' + mediaFilter).show();

        $('.swiper-wrapper').css('transform','translate3d(0px, 0px, 0px)')
        mySwiper.params.slideClass = mediaFilter;

        mySwiper.update();
        $('.swiper-slide-active').css({'marginLeft':'-1px'});
    });

    //media swipe visible slide
    //Onload detect

    if ($(window).width() >760 & $(window).width() <  992  ){
         mySwiper.params.slidesPerView=2;
         //mySwiper.resizeFix();
    } else if ($(window).width() < 767 & $(window).width() > 481){
         mySwiper.params.slidesPerView=3;
         //mySwiper.resizeFix();
    } else if ($(window).width() < 480 & $(window).width() > 361){
         mySwiper.params.slidesPerView=2;
         //mySwiper.resizeFix();
    } else if ($(window).width() < 360){
         mySwiper.params.slidesPerView=1;
         //mySwiper.resizeFix();
    } else{
        mySwiper.params.slidesPerView=4;
        //mySwiper.resizeFix();
    }

    if ($('.swiper-container').width() > 900 ){
        mySwiper.params.slidesPerView=5;
        //mySwiper.resizeFix();
    }

    //Resize detect
    $(window).resize(function(){
         if ($(window).width() >760 & $(window).width() <  992  ){
             mySwiper.params.slidesPerView=2;
             mySwiper.update();
         }
         else if ($(window).width() < 767 & $(window).width() > 481){
             mySwiper.params.slidesPerView=3;
             mySwiper.update();
         } else
         if ($(window).width() < 480 & $(window).width() > 361){
             mySwiper.params.slidesPerView=2;
             mySwiper.update();
         } else if ($(window).width() < 360){
             mySwiper.params.slidesPerView=1;
             mySwiper.update();
         } else{
            mySwiper.params.slidesPerView=4;
            mySwiper.update();
         }

     });

    //3. Slider item pop up
    //boolian var
    var toggle = true;

    //pop up video media element
    $('.media-video .movie__media-item').magnificPopup({
        //disableOn: 700,
        type: 'iframe',
        mainClass: 'mfp-fade',
        removalDelay: 160,
        preloader: false,

        fixedContentPos: false,

        gallery: {
            enabled: true,
            preload: [0,1] // Will preload 0 - before current, and 1 after the current image
        },

        disableOn:function () {
            return toggle;
        }
    });

    //pop up photo media element
    $('.media-photo .movie__media-item').magnificPopup({
        type: 'image',
        closeOnContentClick: true,
        mainClass: 'mfp-fade',
        image: {
            verticalFit: true
        },

        gallery: {
            enabled: true,
            navigateByImgClick: true,
            preload: [0,1] // Will preload 0 - before current, and 1 after the current image
        },

        disableOn:function () {
            return toggle;
        }

    });

    //detect if was move after click
    $('.movie__media .swiper-slide').on('mousedown', function(e){
        toggle = true;
        $(this).on('mousemove', function testMove(){
              toggle = false;
        });
    });

    //4. Dropdown init 
    //select
    $("#select-sort").selectbox({
        onChange: function (val, inst) {

            $(inst.input[0]).children().each(function(item){
                $(this).removeAttr('selected');
            })
            $(inst.input[0]).find('[value="'+val+'"]').attr('selected','selected');
        }

    });

    //5. Datepicker init
    $( ".datepicker__input" ).datepicker({
      showOtherMonths: true,
      selectOtherMonths: true,
      showAnim:"fade"
    });

    $(document).click(function(e) {
        var ele = $(e.target);
        if (!ele.hasClass("datepicker__input") && !ele.hasClass("ui-datepicker") && !ele.hasClass("ui-icon") && !$(ele).parent().parents(".ui-datepicker").length){
           $(".datepicker__input").datepicker("hide");
         }
    });

    //6. Reply comment form
    // button more comments
    $('#hide-comments').hide();

    $('.comment-more').click(function (e) {
        e.preventDefault();
        $('#hide-comments').slideDown(400);
        $(this).hide();
    })

    //reply comment function

    //7. Timetable active element
    $('.time-select__item').click(function (){
        $('.time-select__item').removeClass('active');
        $(this).addClass('active');
    });


    //10. Scroll down navigation function
    //scroll down
    $('.comment-link').click(function (ev) {
        ev.preventDefault();
        $('html, body').stop().animate({'scrollTop': $('.comment-wrapper').offset().top-90}, 900, 'swing');
    });

    $('#map-switch').click(function(ev){
        ev.preventDefault();

        $('.time-select').slideToggle(500);
        $('.map').slideToggle(500);

        $('.show-map').toggle();
        $('.show-time').toggle();
        $(this).blur();
    });

    /*$(window).load(function() {
        $('.map').addClass('hide-map');
    });*/
}

function init_MoviePageFull () {
    "use strict";

            //init employee sliders
                var mySwiper = new Swiper('.swiper-container',{
                    slidesPerView:5,
                  });

                $('.swiper-slide-active').css({'marginLeft':'-1px'});

                //Media switch
                $('.list--photo').click(function (e){
                    e.preventDefault();

                    var mediaFilter = $(this).attr('data-filter');

                    $('.swiper-slide').hide();
                    $('.' + mediaFilter).show();

                    $('.swiper-wrapper').css('transform','translate3d(0px, 0px, 0px)')
                    mySwiper.params.slideClass = mediaFilter;
         
                    mySwiper.update();
                    $('.swiper-slide-active').css({'marginLeft':'-1px'});
                })

                $('.list--video').click(function (e){
                    e.preventDefault();

                    var mediaFilter = $(this).attr('data-filter');
                    $('.swiper-slide').hide();
                    $('.' + mediaFilter).show();

                    $('.swiper-wrapper').css('transform','translate3d(0px, 0px, 0px)')
                    mySwiper.params.slideClass = mediaFilter;

                    mySwiper.update();
                    $('.swiper-slide-active').css({'marginLeft':'-1px'});
                });
                    //media swipe visible slide
                    //Onload detect

                    if ($(window).width() >768 & $(window).width() <  992  ){
                         mySwiper.params.slidesPerView=3;
                         //mySwiper.resizeFix();         
                    }

                    else
                    if ($(window).width() < 767 & $(window).width() > 481){
                         mySwiper.params.slidesPerView=3;
                         //mySwiper.resizeFix();    
                    
                    } else
                     if ($(window).width() < 480 & $(window).width() > 361){
                         mySwiper.params.slidesPerView=2;
                         //mySwiper.resizeFix();    
                    } else
                    if ($(window).width() < 360){
                         mySwiper.params.slidesPerView=1;
                         //mySwiper.resizeFix();    
                    }

                    else{
                        mySwiper.params.slidesPerView=5;
                        //mySwiper.resizeFix();
                    }

                     if ($('.swiper-container').width() > 900 ){
                        mySwiper.params.slidesPerView=5;
                        //mySwiper.resizeFix();
                     }

                  //Resize detect
                $(window).resize(function(){
                  if ($(window).width() > 993 & $('.swiper-container').width() > 900 ){
                        mySwiper.params.slidesPerView=5;
                        mySwiper.update(); 
                     }

                     if ($(window).width() >768 & $(window).width() <  992  ){
                         mySwiper.params.slidesPerView=3;
                         mySwiper.update();         
                    }

                    else
                    if ($(window).width() < 767 & $(window).width() > 481){
                         mySwiper.params.slidesPerView=3;
                          mySwiper.update();    
                    
                    } else
                     if ($(window).width() < 480 & $(window).width() > 361){
                         mySwiper.params.slidesPerView=2;
                         mySwiper.update();   
                    } else 
                    if ($(window).width() < 360){
                         mySwiper.params.slidesPerView=1;
                         mySwiper.update();   
                    }

                    else{
                        mySwiper.params.slidesPerView=5;
                        mySwiper.update();
                    }


                 });
}

function init_Rates () {
    "use strict";

    $('.tags__item').click(function (e) {
        console.log($(this));
        //active sorted item
        $('.tags__item').removeClass('item-active');
        $(this).addClass('item-active');

        var filter = $(this).attr('data-filter');

        $("#filter_from input[name='sort']").val(filter);
        $("#filter_from").submit();
    });
}

function init_Cinema () {
    "use strict";

	//1. Swiper slider
    //init cinema sliders
    var mySwiper = new Swiper('.swiper-container',{
        slidesPerView:8,
        loop:true,
      });

    $(".select__sort").selectbox({
        onChange: function (val, inst) {
            $(inst.input[0]).children().each(function(item){
                $(this).removeAttr('selected');
            })
            $(inst.input[0]).find('[value="'+val+'"]').attr('selected','selected');
            $(inst.input[0]).parent().submit();
        }

    });

    $('.swiper-slide-active').css({'marginLeft':'-1px'});
    //media swipe visible slide

    //onload detect
    if ($(window).width() >993 & $(window).width() <  1199  ){
         mySwiper.params.slidesPerView=6;
         //mySwiper.resizeFix();
    }
    else
    if ($(window).width() >768 & $(window).width() <  992  ){
         mySwiper.params.slidesPerView=5;
         //mySwiper.resizeFix();
    }

    else
    if ($(window).width() < 767 & $(window).width() > 481){
         mySwiper.params.slidesPerView=4;
         //mySwiper.resizeFix();

    } else
     if ($(window).width() < 480){
         mySwiper.params.slidesPerView=2;
         //mySwiper.resizeFix();
    }

    else{
        mySwiper.params.slidesPerView=8;
        // mySwiper.resizeFix();
    }

    //resize detect
    $(window).resize(function(){
        if ($(window).width() >993 & $(window).width() <  1199  ){
             mySwiper.params.slidesPerView=6;
             mySwiper.update();
        }
        else
         if ($(window).width() >768 & $(window).width() <  992  ){
             mySwiper.params.slidesPerView=5;
             mySwiper.update();
        }

        else
        if ($(window).width() < 767 & $(window).width() > 481){
             mySwiper.params.slidesPerView=4;
              mySwiper.update();

        } else
         if ($(window).width() < 480){
             mySwiper.params.slidesPerView=2;
             mySwiper.update();
        }

        else{
            mySwiper.params.slidesPerView=8;
            mySwiper.update();
        }
     });

	//2. Datepicker
    //datepicker
    $( ".datepicker__input" ).datepicker({
      showOtherMonths: true,
      selectOtherMonths: true,
      showAnim:"fade"
    });

    $(document).click(function(e) {
        var ele = $(e.target);
        if (!ele.hasClass("datepicker__input") && !ele.hasClass("ui-datepicker") && !ele.hasClass("ui-icon") && !$(ele).parent().parents(".ui-datepicker").length){
           $(".datepicker__input").datepicker("hide");

         }

    });

    //3. Comment area control
    // button more comments
    $('#hide-comments').hide();

    $('.comment-more').click(function (e) {
        e.preventDefault();
        $('#hide-comments').slideDown(400);
        $(this).hide();
    })

    //reply comment function

    $('.comment__reply').click( function (e) {
        e.preventDefault();

        $('.comment').find('.comment-form').remove();


        $(this).parent().append("<form id='comment-form' class='comment-form' method='post'>\
            <textarea class='comment-form__text' placeholder='Add you comment here'></textarea>\
            <label class='comment-form__info'>250 characters left</label>\
            <button type='submit' class='btn btn-md btn--danger comment-form__btn'>add comment</button>\
        </form>");
    });
}

function init_SinglePage () {
    "use strict";

	//1. Swiper slider (with arrow behaviur).
				//init images sliders
                var mySwiper = new Swiper('.swiper-container',{
                    slidesPerView:1,
                    onSlideChangeStart:function change(index){
                        var i = mySwiper.activeIndex;
                        var prev = i-1;
                        var next = i+1;

                        var prevSlide = $('.post__preview .swiper-slide').eq(prev).attr('data-text');
                             $('.arrow-left').find('.slider__info').text(prevSlide);
                        var nextSlide = $('.post__preview .swiper-slide').eq(next).attr('data-text');
                            $('.arrow-right').find('.slider__info').text(nextSlide);

                        //condition first-last slider
                        $('.arrow-left , .arrow-right').removeClass('no-hover');

                        if(i == 0){
                            $('.arrow-left').find('.slider__info').text('');
                            $('.arrow-left').addClass('no-hover');
                        }

                        if(i == last){
                            $('.arrow-right').find('.slider__info').text('');
                            $('.arrow-right').addClass('no-hover');
                        }
                    }
                  });

                //var init and put onload value
                var i = mySwiper.activeIndex;
                var last =mySwiper.slides.length - 1; 
                var prev = i-1;
                var next = i+1;

                var prevSlide = $('.post__preview .swiper-slide').eq(prev).attr('data-text');
                var nextSlide = $('.post__preview .swiper-slide').eq(next).attr('data-text');

                //put onload value for slider navigation
                $('.arrow-left').find('.slider__info').text(prevSlide);
                $('.arrow-right').find('.slider__info').text(nextSlide);

                //condition first-last slider
                if(i == 0){
                    $('.arrow-left').find('.slider__info').text('');
                }

                if(i == last){
                    $('.arrow-right').find('.slider__info').text('');
                }

                //init slider navigation arrow

                  $('.arrow-left').on('click', function(e){
                    e.preventDefault();
                    mySwiper.slidePrev();
                  })
                  $('.arrow-right').on('click', function(e){
                    e.preventDefault();
                    mySwiper.slideNext();
                  })

	//2. Comment area control
				// button more comments
                  $('#hide-comments').hide();

                  $('.comment-more').click(function (e) {
                        e.preventDefault();
                        $('#hide-comments').slideDown(400);
                        $(this).hide();
                  })

                  //reply comment function

                  $('.comment__reply').click( function (e) {
                        e.preventDefault();

                        $('.comment').find('.comment-form').remove();


                        $(this).parent().append("<form id='comment-form' class='comment-form' method='post'>\
                            <textarea class='comment-form__text' placeholder='Add you comment here'></textarea>\
                            <label class='comment-form__info'>250 characters left</label>\
                            <button type='submit' class='btn btn-md btn--danger comment-form__btn'>add comment</button>\
                        </form>");
                  });
}

function init_Trailer () {
    "use strict";

	//1. Element controls
				//pop up element
                $('.trailer-sample').magnificPopup({
                    disableOn: 700,
                    type: 'iframe',
                    mainClass: 'mfp-fade',
                    removalDelay: 160,
                    preloader: false,

                    fixedContentPos: false
                });

                //show hide content
                $('.trailer-btn').click(function (e) {
                    e.preventDefault();

                    $(this).hide();
                    $(this).parent().addClass('trailer-block--short').find('.hidden-content').slideDown(500);
                })
}

<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">


<@c.page>
    <#include "../../parts/search.ftlh">

    <!-- Main content -->
    <section class="cinema-container">
        <div class="cinema cinema--full">
            <p class="cinema__title">${cinema.name}</p>
            <div class="cinema__rating">${cinema.rating}</div>
            <div class="cinema__gallery">
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <#list cinema.gallery as item>
                            <div class="swiper-slide">
                                <img alt='' src="${item.imageUrl}" style="height: 130px">
                            </div>
                        </#list>
                    </div>
                </div>
            </div>
            <div class="cinema__info">
                <p class="cinema__info-item"><strong>Address:</strong> ${cinema.address}</p>
                <p class="cinema__info-item"><strong>Phone:</strong> ${cinema.phone}</p>
            </div>
        </div>

        <div class="tabs tabs--horisontal">
            <!-- Nav tabs -->
            <div class="container">
                <ul class="nav nav-tabs" id="hTab">
                    <li class="active"><a href="#movie1" data-toggle="tab">Movies</a></li>
                    <li><a href="#comment1" data-toggle="tab">Comments</a></li>
                    <li><a href="#map1" data-toggle="tab">Map</a></li>
                </ul>
            </div>

            <!-- Tab panes -->
            <div class="tab-content">
                <div class="tab-pane active" id="movie1">
                    <div class="container">
                        <div class="movie-time-wrap">
                            <#if dates?has_content>
                                <div class="col-sm-6">
                                    <form class="select select--date" method='get'>
                                        <select name="date" class="select__sort" tabindex="0">
                                            <#list dates as d>
                                                <option <#if date?? && date?string["yyyy-MM-dd"] == d?string["yyyy-MM-dd"]>selected</#if> value="${d?string["yyyy-MM-dd"]}">${d}</option>
                                            </#list>
                                        </select>
                                    </form>
                                </div>
                            </#if>

                            <div class="clearfix"></div>

                            <#list movie_seances as item>
                                <div class="col-sm-6">
                                    <!-- Movie variant with time -->
                                    <div class="movie movie--time">
                                        <div class="row">
                                            <div class="col-sm-6 col-md-5">
                                                <div class="movie__images">
                                                    <#if item.movie.rating??>
                                                        <span class="movie__rating">${item.movie.rating}</span>
                                                    </#if>
                                                    <img alt='' src="${item.movie.posterUrl}" style="height: 285px">

                                                    <#if name != "unknown">
                                                        <div class="item_watchlist" style="position: absolute; top: 6px; right: 10px;">
                                                            <a onclick="watchlist(this, ${item.movie.id})" style="font-size: 30px">
                                                                <#if item.movie.inWatchlist>
                                                                    <i class="fas fa-bookmark"></i>
                                                                <#else>
                                                                    <i class="far fa-bookmark"></i>
                                                                </#if>
                                                            </a>
                                                        </div>
                                                    </#if>
                                                </div>
                                            </div>

                                            <div class="col-sm-6 col-md-7" style="padding-left: 2px">
                                                <a href='/item/${item.movie.id}' style="padding-top: 0" class="movie__title">${item.movie.title} (${item.movie.year?c}) </a>

                                                <p class="movie__time">${item.movie.time} min</p>

                                                <p class="movie__option"><strong>Genres: </strong>
                                                    <#list item.movie.genres as genre>
                                                        <a href="/navigator?genre=${genre}">${genre}</a><#sep>, </#sep>
                                                    </#list>
                                                </p>
                                                <p class="movie__option"><strong>Release date: </strong>${item.movie.release?string["dd.MM.yyyy"]}</p>
                                                <p class="movie__option"><strong>Directors: </strong>
                                                    <#list item.movie.directors as director>
                                                        <a href="/star/${director.id}">${director.fullName()}</a><#sep>, </#sep>
                                                    </#list>
                                                </p>
                                                <p class="movie__option"><strong>Actors: </strong>
                                                    <#list item.movie.cast as actor>
                                                        <a href="/star/${actor.id}">${actor.fullName()}</a><#sep>, </#sep>
                                                    </#list>
                                                </p>
                                                <p class="movie__option"><strong>Age restriction: </strong>
                                                    <a href="#">${item.movie.mpaa.getLabel()}</a>
                                                </p>
                                            </div>
                                            <div class="time-select">
                                                <ul class="items-wrap">
                                                    <#list item.seances as seance>
                                                        <li class="time-select__item" onclick="location.href='/seance/${seance.id}'">
                                                            ${seance.startTime?string["HH:mm"]}
                                                        </li>
                                                    </#list>
                                                </ul>
                                            </div>

                                        </div>
                                    </div>
                                    <!-- Movie variant with time -->
                                </div>
                            </#list>
                        </div>
                    </div>
                </div>
                <#--<div class="tab-pane" id="comment1">
                    <div class="container">
                        <div class="comment-wrapper">
                            <form id="comment-form" class="comment-form" method='post'>
                                <textarea class="comment-form__text" placeholder='Add you comment here'></textarea>
                                <label class="comment-form__info">250 characters left</label>
                                <button type='submit' class="btn btn-md btn--danger comment-form__btn">add comment</button>
                            </form>

                            <div class="comment-sets comment--light">

                                <div class="comment">
                                    <div class="comment__images">
                                        <img alt='' src="/static/main/images/comment/avatar.jpg">
                                    </div>

                                    <a href='#' class="comment__author"><span class="social-used fa fa-facebook"></span>Roberta Inetti</a>
                                    <p class="comment__date">today | 03:04</p>
                                    <p class="comment__message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae enim sollicitudin, euismod erat id, fringilla lacus. Cras ut rutrum lectus. Etiam ante justo, volutpat at viverra a, mattis in velit. Morbi molestie rhoncus enim, vitae sagittis dolor tristique et.</p>
                                    <a href='#' class="comment__reply">Reply</a>
                                </div>

                                <div class="comment">
                                    <div class="comment__images">
                                        <img alt='' src="/static/main/images/comment/avatar-olia.jpg">
                                    </div>

                                    <a href='#' class="comment__author"><span class="social-used fa fa-vk"></span>Olia Gozha</a>
                                    <p class="comment__date">22.10.2013 | 14:40</p>
                                    <p class="comment__message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae enim sollicitudin, euismod erat id, fringilla lacus. Cras ut rutrum lectus. Etiam ante justo, volutpat at viverra a, mattis in velit. Morbi molestie rhoncus enim, vitae sagittis dolor tristique et.</p>
                                    <a href='#' class="comment__reply">Reply</a>
                                </div>

                                <div class="comment comment--answer">
                                    <div class="comment__images">
                                        <img alt='' src="/static/main/images/comment/avatar-dmitriy.jpg">
                                    </div>

                                    <a href='#' class="comment__author"><span class="social-used fa fa-vk"></span>Dmitriy Pustovalov</a>
                                    <p class="comment__date">today | 10:19</p>
                                    <p class="comment__message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae enim sollicitudin, euismod erat id, fringilla lacus. Cras ut rutrum lectus. Etiam ante justo, volutpat at viverra a, mattis in velit. Morbi molestie rhoncus enim, vitae sagittis dolor tristique et.</p>
                                    <a href='#' class="comment__reply">Reply</a>
                                </div>

                                <div class="comment comment--last">
                                    <div class="comment__images">
                                        <img alt='' src="/static/main/images/comment/avatar-sia.jpg">
                                    </div>

                                    <a href='#' class="comment__author"><span class="social-used fa fa-facebook"></span>Sia Andrews</a>
                                    <p class="comment__date"> 22.10.2013 | 12:31 </p>
                                    <p class="comment__message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae enim sollicitudin, euismod erat id, fringilla lacus. Cras ut rutrum lectus. Etiam ante justo, volutpat at viverra a, mattis in velit. Morbi molestie rhoncus enim, vitae sagittis dolor tristique et.</p>
                                    <a href='#' class="comment__reply">Reply</a>
                                </div>

                                <div id='hide-comments' class="hide-comments">
                                    <div class="comment">
                                        <div class="comment__images">
                                            <img alt='' src="/static/main/images/comment/avatar.jpg">
                                        </div>

                                        <a href='#' class="comment__author"><span class="social-used fa fa-facebook"></span>Roberta Inetti</a>
                                        <p class="comment__date">today | 03:04</p>
                                        <p class="comment__message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae enim sollicitudin, euismod erat id, fringilla lacus. Cras ut rutrum lectus. Etiam ante justo, volutpat at viverra a, mattis in velit. Morbi molestie rhoncus enim, vitae sagittis dolor tristique et.</p>
                                        <a href='#' class="comment__reply">Reply</a>
                                    </div>

                                    <div class="comment">
                                        <div class="comment__images">
                                            <img alt='' src="/static/main/images/comment/avatar-olia.jpg">
                                        </div>

                                        <a href='#' class="comment__author"><span class="social-used fa fa-vk"></span>Olia Gozha</a>
                                        <p class="comment__date">22.10.2013 | 14:40</p>
                                        <p class="comment__message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae enim sollicitudin, euismod erat id, fringilla lacus. Cras ut rutrum lectus. Etiam ante justo, volutpat at viverra a, mattis in velit. Morbi molestie rhoncus enim, vitae sagittis dolor tristique et.</p>
                                        <a href='#' class="comment__reply">Reply</a>
                                    </div>
                                </div>

                                <div class="comment-more">
                                    <a href="#" class="watchlist">Show more comments</a>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>-->

                <div class="tab-pane" id="map1">
                    <div id='cinema-map' class="map"></div>
                </div>
            </div>
        </div>

    </section>

    <div class="clearfix"></div>

    <!-- JavaScript-->
    <!-- jQuery 3.1.1-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="/static/main/js/external/jquery-3.1.1.min.js"><\/script>')</script>
    <!-- Migrate -->
    <script src="/static/main/js/external/jquery-migrate-1.2.1.min.js"></script>
    <!-- jQuery UI -->
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <!-- Bootstrap 3-->
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script>

    <!-- Mobile menu -->
    <script src="/static/main/js/jquery.mobile.menu.js"></script>
    <!-- Select -->
    <script src="/static/main/js/external/jquery.selectbox-0.2.min.js"></script>

    <!-- Slider Revolution core JavaScript files -->
    <script type="text/javascript" src="/static/main/revolution/js/jquery.themepunch.tools.min.js"></script>
    <script type="text/javascript" src="/static/main/revolution/js/jquery.themepunch.revolution.min.js"></script>

    <!-- Slider Revolution extension scripts. -->
    <script type="text/javascript" src="/static/main/revolution/js/extensions/revolution.extension.actions.min.js"></script>
    <script type="text/javascript" src="/static/main/revolution/js/extensions/revolution.extension.carousel.min.js"></script>
    <script type="text/javascript" src="/static/main/revolution/js/extensions/revolution.extension.kenburn.min.js"></script>
    <script type="text/javascript" src="/static/main/revolution/js/extensions/revolution.extension.layeranimation.min.js"></script>
    <script type="text/javascript" src="/static/main/revolution/js/extensions/revolution.extension.migration.min.js"></script>
    <script type="text/javascript" src="/static/main/revolution/js/extensions/revolution.extension.navigation.min.js"></script>
    <script type="text/javascript" src="/static/main/revolution/js/extensions/revolution.extension.parallax.min.js"></script>
    <script type="text/javascript" src="/static/main/revolution/js/extensions/revolution.extension.slideanims.min.js"></script>
    <script type="text/javascript" src="/static/main/revolution/js/extensions/revolution.extension.video.min.js"></script>

    <!-- Stars rate -->
    <script src="/static/main/js/external/jquery.raty.js"></script>
    <!-- Swiper slider -->
    <script src="/static/main/js/external/idangerous.swiper.min.js"></script>
    <!-- Magnific-popup -->
    <script src="/static/main/js/external/jquery.magnific-popup.min.js"></script>
    <!--*** Google map  ***-->
    <script src="https://maps.google.com/maps/api/js?key=AIzaSyDmTU3PdXiLiXqNDbHDOeEfCU4iq7UShDE&language=en"></script>
    <!--*** Google map infobox  ***-->
    <script src="/static/main/js/external/infobox.js"></script>
    <!-- Form element -->
    <script src="/static/main/js/external/form-element.js"></script>

    <!-- Custom -->
    <script src="/static/main/js/custom.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            init_Home();
            init_Cinema();
        });
        <#if name != "unknown">
        function watchlist(e, itemId){
            $.post({
                url: '/watchlist',
                data: JSON.stringify(itemId),
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': '${_csrf.token}'
                },
                success: function (data, status) {
                    if (status === 'success') {
                        if(data == 0) {
                            $(e).find("i").removeClass("fas fa-bookmark");
                            $(e).find("i").addClass("far fa-bookmark");
                            console.log("Item was removed from watchlist");
                        }
                        else {
                            $(e).find("i").removeClass("far fa-bookmark");
                            $(e).find("i").addClass("fas fa-bookmark");
                            console.log("Item was added to watchlist");
                        }
                    }
                },
                error: function (error) {
                    var err = error.responseJSON.message;
                    alert(err);
                    location.reload();
                }
            });
        }
        </#if>
    </script>

    <script>
        //4. Init map

        var mapOptions = {
            scaleControl: true,
            center: new google.maps.LatLng(${cinema.latitude?c}, ${cinema.longitude?c}),
            zoom: 16,
            navigationControl: false,
            streetViewControl: false,
            mapTypeControl: false,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(document.getElementById('cinema-map'),mapOptions);
        var marker = new google.maps.Marker({
            map: map,
            position: map.getCenter()
        });

        // Maker

        //Creates the information to go in the pop-up info box.
        var boxTextA = document.createElement("div");
        boxTextA.innerHTML = '<span class="pop_up_box_text">${cinema.name}</span>';

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
            ,closeBoxURL: "/static/main/images/components/close.svg"
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
    </script>
</@c.page>
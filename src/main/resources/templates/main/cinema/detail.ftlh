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

                            <div class="datepicker">
                                <span class="datepicker__marker"><i class="fa fa-calendar"></i>Date</span>
                                <input type="text" id="datepicker" value='03/10/2014' class="datepicker__input">
                            </div>

                            <div class="clearfix"></div>

                            <div class="col-sm-6">
                                <!-- Movie variant with time -->
                                <div class="movie movie--time">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-5">
                                            <div class="movie__images">
                                                <span class="movie__rating">4.1</span>
                                                <img alt='' src="https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/cinemas%2Fdefault.png?alt=media">
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-md-7">
                                            <a href='movie-page-left.html' class="movie__title">Gravity (2013) </a>

                                            <p class="movie__time">91 min</p>

                                            <p class="movie__option"><a href="#">Drama</a> | <a href="#">Sci-Fi</a> | <a href="#">Thriller</a></p>
                                        </div>
                                        <div class="time-select">
                                            <ul class="items-wrap">
                                                <li class="time-select__item" data-time='09:40'>09:40</li>
                                                <li class="time-select__item" data-time='13:45'>13:45</li>
                                                <li class="time-select__item" data-time='15:45'>15:45</li>
                                                <li class="time-select__item" data-time='19:50'>19:50</li>
                                                <li class="time-select__item" data-time='21:50'>21:50</li>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
                                <!-- Movie variant with time -->
                            </div>

                            <div class="col-sm-6">

                                <!-- Movie variant with time -->
                                <div class="movie movie--time">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-5">
                                            <div class="movie__images">
                                                <span class="movie__rating">5.0</span>
                                                <img alt='' src="https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/cinemas%2Fdefault.png?alt=media">
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-md-7">
                                            <a href='movie-page-left.html' class="movie__title">The Hobbit:  The Desolation of Smaug (2013) </a>

                                            <p class="movie__time">169 min</p>

                                            <p class="movie__option"><a href="#">Adventure</a> | <a href="#">Fantazy</a> | <a href="#">Drama</a></p>
                                        </div>

                                        <div class="time-select">
                                            <ul class="items-wrap">
                                                <li class="time-select__item" data-time='09:40'>09:40</li>
                                                <li class="time-select__item" data-time='13:45'>13:45</li>
                                                <li class="time-select__item" data-time='15:45'>15:45</li>
                                                <li class="time-select__item" data-time='19:50'>19:50</li>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
                                <!-- Movie variant with time -->
                            </div>

                            <div class="clearfix"></div>

                            <div class="col-sm-6">

                                <!-- Movie variant with time -->
                                <div class="movie movie--time">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-5">
                                            <div class="movie__images">
                                                <span class="movie__rating">4.9</span>
                                                <img alt='' src="https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/cinemas%2Fdefault.png?alt=media">
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-md-7">
                                            <a href='movie-page-left.html' class="movie__title">The Hunger Games:  Catching Fire (2013)</a>

                                            <p class="movie__time">149 min</p>

                                            <p class="movie__option"><a href="#">Adventure</a> | <a href="#">Action</a> | <a href="#">Sci-Fi</a></p>
                                        </div>

                                        <div class="time-select">
                                            <ul class="items-wrap">
                                                <li class="time-select__item" data-time='09:40'>09:40</li>
                                                <li class="time-select__item" data-time='13:45'>13:45</li>
                                                <li class="time-select__item" data-time='15:45'>15:45</li>
                                                <li class="time-select__item" data-time='19:50'>19:50</li>
                                                <li class="time-select__item" data-time='21:50'>21:50</li>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
                                <!-- Movie variant with time -->
                            </div>

                            <div class="col-sm-6">

                                <!-- Movie variant with time -->
                                <div class="movie movie--time">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-5">
                                            <div class="movie__images">
                                                <span class="movie__rating">4.9</span>
                                                <img alt='' src="https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/cinemas%2Fdefault.png?alt=media">
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-md-7">
                                            <a href='movie-page-left.html' class="movie__title">Thor: The Dark World  (2013) </a>

                                            <p class="movie__time">112 min</p>

                                            <p class="movie__option"><a href="#">Action</a> | <a href="#">Adventure</a> | <a href="#">Fantazy</a></p>
                                        </div>

                                        <div class="time-select">
                                            <ul class="items-wrap">
                                                <li class="time-select__item" data-time='09:40'>09:40</li>
                                                <li class="time-select__item" data-time='13:45'>13:45</li>
                                                <li class="time-select__item" data-time='15:45'>15:45</li>
                                                <li class="time-select__item" data-time='19:50'>19:50</li>
                                                <li class="time-select__item" data-time='21:50'>21:50</li>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
                                <!-- Movie variant with time -->
                            </div>

                            <div class="clearfix"></div>

                            <div class="col-sm-6">

                                <!-- Movie variant with time -->
                                <div class="movie movie--time">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-5">
                                            <div class="movie__images">
                                                <span class="movie__rating">4.1</span>
                                                <img alt='' src="https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/cinemas%2Fdefault.png?alt=media">
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-md-7">
                                            <a href='movie-page-left.html' class="movie__title">World War Z (2013) </a>

                                            <p class="movie__time">116 min</p>

                                            <p class="movie__option"><a href="#">Adventure</a> | <a href="#">Horror</a> | <a href="#">Action</a></p>
                                        </div>

                                        <div class="time-select">
                                            <ul class="items-wrap">
                                                <li class="time-select__item" data-time='09:40'>09:40</li>
                                                <li class="time-select__item" data-time='13:45'>13:45</li>
                                                <li class="time-select__item" data-time='15:45'>15:45</li>
                                                <li class="time-select__item" data-time='19:50'>19:50</li>
                                                <li class="time-select__item" data-time='21:50'>21:50</li>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
                                <!-- Movie variant with time -->
                            </div>

                            <div class="col-sm-6">

                                <!-- Movie variant with time -->
                                <div class="movie movie--time">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-5">
                                            <div class="movie__images">
                                                <span class="movie__rating">4.9</span>
                                                <img alt='' src="https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/cinemas%2Fdefault.png?alt=media">
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-md-7">
                                            <a href='movie-page-left.html' class="movie__title">Prisoners (2013) </a>

                                            <p class="movie__time">153 min</p>

                                            <p class="movie__option"><a href="#">Crime</a> | <a href="#">Thriller</a> | <a href="#">Drama</a></p>
                                        </div>

                                        <div class="time-select">
                                            <ul class="items-wrap">
                                                <li class="time-select__item" data-time='09:40'>09:40</li>
                                                <li class="time-select__item" data-time='13:45'>13:45</li>
                                                <li class="time-select__item" data-time='15:45'>15:45</li>
                                                <li class="time-select__item" data-time='19:50'>19:50</li>
                                                <li class="time-select__item" data-time='21:50'>21:50</li>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
                                <!-- Movie variant with time -->
                            </div>

                            <div class="clearfix"></div>

                            <div class="col-sm-6">

                                <!-- Movie variant with time -->
                                <div class="movie movie--time">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-5">
                                            <div class="movie__images">
                                                <span class="movie__rating">4.6</span>
                                                <img alt='' src="https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/cinemas%2Fdefault.png?alt=media">
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-md-7">
                                            <a href='movie-page-left.html' class="movie__title">This Is the End (2013)  </a>

                                            <p class="movie__time">107 min</p>

                                            <p class="movie__option"><a href="#">Comedy</a> | <a href="#">Fantazy</a></p>
                                        </div>

                                        <div class="time-select">
                                            <ul class="items-wrap">
                                                <li class="time-select__item" data-time='09:40'>09:40</li>
                                                <li class="time-select__item" data-time='13:45'>13:45</li>
                                                <li class="time-select__item" data-time='15:45'>15:45</li>
                                                <li class="time-select__item" data-time='19:50'>19:50</li>
                                                <li class="time-select__item" data-time='21:50'>21:50</li>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
                                <!-- Movie variant with time -->
                            </div>

                        </div>
                    </div>
                </div>
                <div class="tab-pane" id="comment1">
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
                                        <img alt='' src="images/comment/avatar.jpg">
                                    </div>

                                    <a href='#' class="comment__author"><span class="social-used fa fa-facebook"></span>Roberta Inetti</a>
                                    <p class="comment__date">today | 03:04</p>
                                    <p class="comment__message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae enim sollicitudin, euismod erat id, fringilla lacus. Cras ut rutrum lectus. Etiam ante justo, volutpat at viverra a, mattis in velit. Morbi molestie rhoncus enim, vitae sagittis dolor tristique et.</p>
                                    <a href='#' class="comment__reply">Reply</a>
                                </div>

                                <div class="comment">
                                    <div class="comment__images">
                                        <img alt='' src="images/comment/avatar-olia.jpg">
                                    </div>

                                    <a href='#' class="comment__author"><span class="social-used fa fa-vk"></span>Olia Gozha</a>
                                    <p class="comment__date">22.10.2013 | 14:40</p>
                                    <p class="comment__message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae enim sollicitudin, euismod erat id, fringilla lacus. Cras ut rutrum lectus. Etiam ante justo, volutpat at viverra a, mattis in velit. Morbi molestie rhoncus enim, vitae sagittis dolor tristique et.</p>
                                    <a href='#' class="comment__reply">Reply</a>
                                </div>

                                <div class="comment comment--answer">
                                    <div class="comment__images">
                                        <img alt='' src="images/comment/avatar-dmitriy.jpg">
                                    </div>

                                    <a href='#' class="comment__author"><span class="social-used fa fa-vk"></span>Dmitriy Pustovalov</a>
                                    <p class="comment__date">today | 10:19</p>
                                    <p class="comment__message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae enim sollicitudin, euismod erat id, fringilla lacus. Cras ut rutrum lectus. Etiam ante justo, volutpat at viverra a, mattis in velit. Morbi molestie rhoncus enim, vitae sagittis dolor tristique et.</p>
                                    <a href='#' class="comment__reply">Reply</a>
                                </div>

                                <div class="comment comment--last">
                                    <div class="comment__images">
                                        <img alt='' src="images/comment/avatar-sia.jpg">
                                    </div>

                                    <a href='#' class="comment__author"><span class="social-used fa fa-facebook"></span>Sia Andrews</a>
                                    <p class="comment__date"> 22.10.2013 | 12:31 </p>
                                    <p class="comment__message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae enim sollicitudin, euismod erat id, fringilla lacus. Cras ut rutrum lectus. Etiam ante justo, volutpat at viverra a, mattis in velit. Morbi molestie rhoncus enim, vitae sagittis dolor tristique et.</p>
                                    <a href='#' class="comment__reply">Reply</a>
                                </div>

                                <div id='hide-comments' class="hide-comments">
                                    <div class="comment">
                                        <div class="comment__images">
                                            <img alt='' src="images/comment/avatar.jpg">
                                        </div>

                                        <a href='#' class="comment__author"><span class="social-used fa fa-facebook"></span>Roberta Inetti</a>
                                        <p class="comment__date">today | 03:04</p>
                                        <p class="comment__message">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae enim sollicitudin, euismod erat id, fringilla lacus. Cras ut rutrum lectus. Etiam ante justo, volutpat at viverra a, mattis in velit. Morbi molestie rhoncus enim, vitae sagittis dolor tristique et.</p>
                                        <a href='#' class="comment__reply">Reply</a>
                                    </div>

                                    <div class="comment">
                                        <div class="comment__images">
                                            <img alt='' src="images/comment/avatar-olia.jpg">
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
                </div>

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

    <!-- Form element -->
    <script src="/static/main/js/external/form-element.js"></script>

    <!-- Custom -->
    <script src="/static/main/js/custom.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            init_Home();
            init_Cinema();
        });
    </script>
</@c.page>
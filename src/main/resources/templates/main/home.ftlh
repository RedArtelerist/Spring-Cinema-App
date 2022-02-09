<#import "../parts/common.ftlh" as c>
<#include "../parts/security.ftlh">

<@c.page>
    <!-- Main content -->
    <section class="container">
        <div class="movie-best">
            <div class="col-sm-10 col-sm-offset-1 movie-best__rating">Today Best choice</div>
            <div class="col-sm-12 change--col">
                <#list top as movie>
                    <div class="movie-beta__item ">
                        <img alt='' src="${movie.posterUrl}" style="height: 295px">
                        <span class="best-rate"><#if movie.rating??>${movie.rating}<#else>-</#if></span>

                        <ul class="movie-beta__info" style="width: 185px; height: 237px">
                            <li><span class="best-voted">${movie.numVotes} people voted</span></li>
                            <li>
                                <p class="movie__time">${movie.time} min</p>

                                <p>
                                    <#list movie.genres as genre>
                                        ${genre}<#sep> |</#sep>
                                    </#list>
                                </p>
                                <p>${movie.numComments} comments</p>
                            </li>
                            <li class="last-block">
                                <a href="/item/${movie.id}" class="slide__link">more</a>
                            </li>
                        </ul>
                    </div>

                </#list>
            </div>
            <div class="col-sm-10 col-sm-offset-1 movie-best__check">check all movies now playing</div>
        </div>

        <div class="col-sm-12">
            <div class="mega-select-present mega-select-top mega-select--full">
                <div class="mega-select-marker">
                    <div class="marker-indecator location">
                        <p class="select-marker"><span>movie to watch now</span> <br>in your city</p>
                    </div>

                    <div class="marker-indecator movie-title">
                        <p class="select-marker"><span>find movie/series by </span> <br>title</p>
                    </div>

                    <div class="marker-indecator cinema">
                        <p class="select-marker"><span>find your </span> <br>cinema</p>
                    </div>

                    <div class="marker-indecator film-category">
                        <p class="select-marker"><span>find movie due to </span> <br> your mood</p>
                    </div>

                    <div class="marker-indecator actors">
                        <p class="select-marker"><span> like particular stars</span> <br>find them</p>
                    </div>

                    <div class="marker-indecator director">
                        <p class="select-marker"><span>admire personalities - find </span> <br>by director</p>
                    </div>

                    <div class="marker-indecator country">
                        <p class="select-marker"><span>search for movie from certain </span> <br>country?</p>
                    </div>
                </div>

                <div class="mega-select pull-right">
                    <form id="search-form" action="/search" method="get">
                        <span class="mega-select__point">Search by</span>
                        <ul class="mega-select__sort">
                            <li class="filter-wrap"><a href="#" class="mega-select__filter filter--active" data-filter='location'>Location</a></li>
                            <li class="filter-wrap"><a href="#" class="mega-select__filter" data-filter='movie-title'>Title</a></li>
                            <li class="filter-wrap"><a href="#" class="mega-select__filter" data-filter='cinema'>Cinema</a></li>
                            <li class="filter-wrap"><a href="#" class="mega-select__filter" data-filter='film-category'>Category</a></li>
                            <li class="filter-wrap"><a href="#" class="mega-select__filter" data-filter='actors'>Stars</a></li>
                            <li class="filter-wrap"><a href="#" class="mega-select__filter" data-filter='country'>Country</a></li>
                        </ul>

                        <input id="type_search" name="type" type="hidden">
                        <input name="search" type='text' class="select__field">

                        <div class="select__btn">
                            <a href="#" onclick="$('#search-form').submit();" class="btn btn-md btn--danger location">find <span class="hidden-exrtasm">your city</span></a>
                            <a href="#" onclick="$('#search-form').submit();" class="btn btn-md btn--danger movie-title">find <span class="hidden-exrtasm">by title</span></a>
                            <a href="#" onclick="$('#search-form').submit();" class="btn btn-md btn--danger cinema">find <span class="hidden-exrtasm">suitable cinema</span></a>
                            <a href="#" onclick="$('#search-form').submit();" class="btn btn-md btn--danger film-category">find <span class="hidden-exrtasm">best category</span></a>
                            <a href="#" onclick="$('#search-form').submit();" class="btn btn-md btn--danger actors">find <span class="hidden-exrtasm">talented stars</span></a>
                            <a href="#" onclick="$('#search-form').submit();" class="btn btn-md btn--danger country">find <span class="hidden-exrtasm">produced country</span></a>
                        </div>

                        <div class="select__dropdowns">
                            <ul class="select__group location">
                                <#list cities as city>
                                    <li class="select__variant" data-value='${city}'>${city}</li>
                                </#list>
                            </ul>

                            <ul class="select__group cinema">
                                <#list cinemas as cinema>
                                    <li class="select__variant" data-value='${cinema.name}'>${cinema.name}</li>
                                </#list>
                            </ul>

                            <ul class="select__group film-category">
                                <#list genres as genre>
                                    <li class="select__variant" data-value="${genre}">${genre}</li>
                                </#list>
                            </ul>

                            <ul class="select__group country">
                                <li class="select__variant" data-value='USA'>USA</li>
                                <li class="select__variant" data-value='UnitedKingdom'>United Kingdom</li>
                                <li class="select__variant" data-value='NorthKorea'>North Korea</li>
                                <li class="select__variant" data-value='Germany'>Germany</li>
                                <li class="select__variant" data-value='Australia'>Australia</li>
                                <li class="select__variant" data-value='Spain'>Spain</li>
                            </ul>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="clearfix"></div>

        <h2 id='target' class="page-heading heading--outcontainer">Now in the cinema</h2>

        <div class="col-sm-12">
            <div class="row">
                <div class="col-sm-12 col-md-12">
                    <#list movies as item>
                        <div class="movie movie--test movie--test--dark movie--test--left">
                            <div class="movie__images">
                                <a href="/item/${item.id}" class="movie-beta__link">
                                    <img style="height: 370px" alt='' src="${item.posterUrl}">
                                </a>
                            </div>

                            <div class="movie__info" data-id="${item?index}">
                                <#if name != "unknown">
                                    <div class="item_watchlist" style="position: absolute; top: 6px; right: 10px;">
                                        <a onclick="watchlist(this, ${item.id})" style="font-size: 30px">
                                            <#if item.inWatchlist>
                                                <i class="fas fa-bookmark"></i>
                                            <#else>
                                                <i class="far fa-bookmark"></i>
                                            </#if>
                                        </a>
                                    </div>
                                </#if>
                                <a href='/item/${item.id}' class="movie__title" style="max-width: 250px">${item.title} (${item.year?c})  </a>

                                <p class="movie__time">${item.time} min</p>

                                <p class="movie__option">
                                    <#list item.genres as genre>
                                        <a href="/navigator?genre=${genre}">${genre}</a><#sep> | </#sep>
                                    </#list>
                                </p>
                                <p class="movie__option"><strong>Release: </strong>${item.release?string["dd.MM.yyyy"]}</p>
                                <p class="movie__option"><strong>Directors: </strong>
                                    <#list item.directors as director>
                                        <a href="/star/${director.id}">${director.fullName()}</a><#sep>, </#sep>
                                    </#list>
                                </p>
                                <p class="movie__option"><strong>Actors: </strong>
                                    <#list item.cast as actor>
                                        <a href="/star/${actor.id}">${actor.fullName()}</a><#sep>, </#sep>
                                    </#list>
                                </p>
                                <p class="movie__option"><strong>Age restriction: </strong>
                                    <a href="#">${item.mpaa.getLabel()}</a>
                                </p>

                                <div class="preview-footer">
                                    <div class="movie__rate">
                                        <#if name != "unknown" && item.release lte .now>
                                            <div class="star-rating list">
                                                <div class="star-input">
                                                    <input type="radio" value="10" name="item-${item?index}-rating" id="item-${item?index}-rating-10"
                                                           <#if item.myRate != 0 && item.myRate == 10>checked</#if> onchange="vote(this, ${item.id})">
                                                    <label for="item-${item?index}-rating-10" class="fas fa-star"></label>
                                                    <input type="radio" value="9" name="item-${item?index}-rating" id="item-${item?index}-rating-9"
                                                           <#if item.myRate != 0 && item.myRate == 9>checked</#if> onchange="vote(this, ${item.id})">
                                                    <label for="item-${item?index}-rating-9" class="fas fa-star"></label>
                                                    <input type="radio" value="8" name="item-${item?index}rating" id="item-${item?index}-rating-8"
                                                           <#if item.myRate != 0 && item.myRate == 8>checked</#if> onchange="vote(this, ${item.id})">
                                                    <label for="item-${item?index}-rating-8" class="fas fa-star"></label>
                                                    <input type="radio" value="7" name="item-${item?index}rating" id="item-${item?index}-rating-7"
                                                           <#if item.myRate != 0 && item.myRate == 7>checked</#if> onchange="vote(this, ${item.id})">
                                                    <label for="item-${item?index}-rating-7" class="fas fa-star"></label>
                                                    <input type="radio" value="6" name="item-${item?index}rating" id="item-${item?index}-rating-6"
                                                           <#if item.myRate != 0 && item.myRate == 6>checked</#if> onchange="vote(this, ${item.id})">
                                                    <label for="item-${item?index}-rating-6" class="fas fa-star"></label>
                                                    <input type="radio" value="5" name="item-${item?index}rating" id="item-${item?index}-rating-5"
                                                           <#if item.myRate != 0 && item.myRate == 5>checked</#if> onchange="vote(this, ${item.id})">
                                                    <label for="item-${item?index}-rating-5" class="fas fa-star"></label>
                                                    <input type="radio" value="4" name="item-${item?index}rating" id="item-${item?index}-rating-4"
                                                           <#if item.myRate != 0 && item.myRate == 4>checked</#if> onchange="vote(this, ${item.id})">
                                                    <label for="item-${item?index}-rating-4" class="fas fa-star"></label>
                                                    <input type="radio" value="3" name="item-${item?index}rating" id="item-${item?index}-rating-3"
                                                           <#if item.myRate != 0 && item.myRate == 3>checked</#if> onchange="vote(this, ${item.id})">
                                                    <label for="item-${item?index}-rating-3" class="fas fa-star"></label>
                                                    <input type="radio" value="2" name="item-${item?index}rating" id="item-${item?index}-rating-2"
                                                           <#if item.myRate != 0 && item.myRate == 2>checked</#if> onchange="vote(this, ${item.id})">
                                                    <label for="item-${item?index}-rating-2" class="fas fa-star"></label>
                                                    <input type="radio" value="1" name="item-${item?index}rating" id="item-${item?index}-rating-1"
                                                           <#if item.myRate != 0 && item.myRate == 1>checked</#if> onchange="vote(this, ${item.id})">
                                                    <label for="item-${item?index}-rating-1" class="fas fa-star"></label>
                                                </div>
                                            </div>
                                        </#if>
                                        <#if item.release lte .now>
                                            <span class="movie__rate-number" <#if name == "unknown">style="margin: 20px 0 0 0" </#if>>
                                        <#if item.myRate != 0>
                                            <div class="my_rate"><span>${item.myRate}</span>/10</div>
                                        <#else>
                                            <div class="my_rate" style="display: none"><span></span>/10</div>
                                        </#if>
                                        <#if name != "unknown">
                                            <div style="margin-left: 150px;width: 100px">${item.numVotes} votes</div>
                                        <#else>
                                            <div style="width: 100px">${item.numVotes} votes</div>
                                        </#if>
                                    </span>
                                        </#if>
                                        <#if item.rating??>
                                            <span class="movie__rating" style="left: <#if name != "unknown">220px;<#else>70px;</#if>top: 10px">${item.rating}</span>
                                        </#if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </#list>
                </div>
            </div>
        </div>

        <div class="col-sm-12">
            <h2 class="page-heading">Latest news</h2>

            <div class="col-sm-4 similar-wrap col--remove">
                <div class="post post--preview post--preview--wide">
                    <div class="post__image">
                        <img alt='' src="/static/main/images/client-photo/post-thor.jpg">
                        <div class="social social--position social--hide">
                            <span class="social__name">Share:</span>
                            <a href='#' class="social__variant social--first fa fa-facebook"></a>
                            <a href='#' class="social__variant social--second fa fa-twitter"></a>
                            <a href='#' class="social__variant social--third fa fa-vk"></a>
                        </div>
                    </div>
                    <p class="post__date">22 October 2013 </p>
                    <a href="single-page-left.html" class="post__title">"Thor: The Dark World" - World Premiere</a>
                    <a href="single-page-left.html" class="btn read-more post--btn">read more</a>
                </div>
            </div>
            <div class="col-sm-4 similar-wrap col--remove">
                <div class="post post--preview post--preview--wide">
                    <div class="post__image">
                        <img alt='' src="/static/main/images/client-photo/post-annual.jpg">
                        <div class="social social--position social--hide">
                            <span class="social__name">Share:</span>
                            <a href='#' class="social__variant social--first fa fa-facebook"></a>
                            <a href='#' class="social__variant social--second fa fa-twitter"></a>
                            <a href='#' class="social__variant social--third fa fa-vk"></a>
                        </div>
                    </div>
                    <p class="post__date">22 October 2013 </p>
                    <a href="single-page-left.html" class="post__title">30th Annual Night Of Stars Presented By The Fashion Group International</a>
                    <a href="single-page-left.html" class="btn read-more post--btn">read more</a>
                </div>
            </div>
            <div class="col-sm-4 similar-wrap col--remove">
                <div class="post post--preview post--preview--wide">
                    <div class="post__image">
                        <img alt='' src="/static/main/images/client-photo/post-awards.jpg">
                        <div class="social social--position social--hide">
                            <span class="social__name">Share:</span>
                            <a href='#' class="social__variant social--first fa fa-facebook"></a>
                            <a href='#' class="social__variant social--second fa fa-twitter"></a>
                            <a href='#' class="social__variant social--third fa fa-vk"></a>
                        </div>
                    </div>
                    <p class="post__date">22 October 2013 </p>
                    <a href="single-page-left.html" class="post__title">Hollywood Film Awards 2013</a>
                    <a href="single-page-left.html" class="btn read-more post--btn">read more</a>
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
    <!-- Bootstrap 3-->
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script>

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

    <!-- Mobile menu -->
    <script src="/static/main/js/jquery.mobile.menu.js"></script>
    <!-- Select -->
    <script src="/static/main/js/external/jquery.selectbox-0.2.min.js"></script>
    <!-- Stars rate -->
    <script src="/static/main/js/external/jquery.raty.js"></script>

    <!-- Form element -->
    <script src="/static/main/js/external/form-element.js"></script>
    <!-- Form validation -->
    <script src="/static/main/js/form.js"></script>

    <!-- Twitter feed -->
    <script src="/static/main/js/external/twitterfeed.js"></script>

    <!-- Custom -->
    <script src="/static/main/js/custom.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            init_Home();
        });

        <#if name != "unknown">
        function vote(e, itemId){
            var value = $(e).val();

            if(value < 1 || value > 10){
                rating = null;
            } else {
                rating = {'item': itemId, 'value': value};
            }

            console.log($(e).parent().parent().next().find(".my_rate span"));

            if(rating != null) {
                $.post({
                    url: '/rate',
                    data: JSON.stringify(rating),
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': '${_csrf.token}'
                    },
                    success: function (data, status) {
                        if (status === 'success') {
                            var my_rate = $(e).parent().parent().next().find(".my_rate");
                            my_rate.find("span").text(value);
                            my_rate.show()
                        }
                    },
                    error: function (error) {
                        var err = error.responseJSON.message;
                        alert(err);
                        location.reload();
                    }
                });
            }
        }
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
</@c.page>
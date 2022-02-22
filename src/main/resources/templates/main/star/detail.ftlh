<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">

<@c.page>
    <#include "../../parts/search.ftlh">

    <section class="container">
        <div class="col-sm-8 col-md-9">
            <div class="movie">
                <h2 class="page-heading">${star.fullName()}</h2>

                <div class="movie__info">
                    <div class="col-sm-6 col-md-4 movie-mobile">
                        <div class="movie__images">
                            <img alt='' src="${star.imgUrl}" style="max-height: 400px">
                        </div>
                    </div>

                    <div class="col-sm-6 col-md-8">
                        <p class="movie__option">
                            <strong>First name: </strong>
                            ${star.firstName}
                        </p>
                        <p class="movie__option">
                            <strong>Last name: </strong>
                            ${star.lastName}
                        </p>
                        <p class="movie__option">
                            <strong>Gender: </strong>
                            ${star.gender}
                        </p>
                        <p class="movie__option">
                            <strong>Birthday: </strong>
                            ${star.birthday?string["dd.MM.yyyy"]}
                        </p>
                        <p class="movie__option">
                            <strong>Age: </strong>
                            ${star.getAge()}
                        </p>
                        <#if star.death??>
                            <p class="movie__option">
                                <strong>Death: </strong>
                                ${star.death?string["dd.MM.yyyy"]}}
                            </p>
                        </#if>
                        <p class="movie__option">
                            <strong>Birth place: </strong>
                            ${star.birthPlace}
                        </p>
                        <p class="movie__option">
                            <strong>Best movies: </strong>
                            <#list best_movies as item>
                                <a href="/item/${item.id}">${item.title}</a><#sep>, </#sep>
                            </#list>
                        </p>
                    </div>
                </div>

                <div class="clearfix"></div>

                <h2 class="page-heading">Movies</h2>

                <div class="tags-area" style="margin-top: 0">
                    <div class="tags tags--unmarked">
                        <span class="tags__label">Sorted by:</span>
                        <ul>
                            <li class="item-wrap"><a href="#" class="tags__item <#if movies_actor?has_content>item-active</#if>" data-filter='actor'>as actor</a></li>
                            <li class="item-wrap"><a href="#" class="tags__item <#if movies_actor?has_content = false && movies_director?has_content>item-active</#if>" data-filter='director'>as director</a></li>
                        </ul>
                    </div>
                </div>

                <#list movies_actor as item>
                    <!-- Movie preview item -->
                    <div class="movie movie--preview actor">
                        <div class="col-sm-5 col-md-3">
                            <div class="movie__images">
                                <img alt='' src="${item.posterUrl}">
                            </div>
                            <div class="movie__feature">
                                <a href="#" class="movie__feature-item movie__feature--comment">${item.numComments}</a>
                                <a href="#" class="movie__feature-item movie__feature--favourite">${item.numFavourites}</a>
                                <a href="#" class="movie__feature-item movie__feature--photo">${item.gallery?size}</a>
                            </div>
                        </div>

                        <div class="col-sm-7 col-md-9">
                            <a href='/item/${item.id}' class="movie__title link--huge">${item.title} (${item.year?c})</a>

                            <p class="movie__time">${item.time} min</p>

                            <p class="movie__option">
                                <strong>Country: </strong>
                                <#list item.countries as country>
                                    <a href="/navigator?country=${country}">${country.getLabel()}</a><#sep>, </#sep>
                                </#list>
                            </p>
                            <p class="movie__option">
                                <strong>Companies: </strong>
                                <#list item.companies as company>
                                    <a href="/navigator?company=${company.id}">${company.name}</a><#sep>, </#sep>
                                </#list>
                            </p>
                            <p class="movie__option"><strong>Genres: </strong>
                                <#list item.genres as genre>
                                    <a href="/navigator?genre=${genre}">${genre}</a><#sep>, </#sep>
                                </#list>
                            </p>
                            <p class="movie__option"><strong>Release date: </strong>${item.release?string["dd.MM.yyyy"]}</p>
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

                            <#if name != "unknown">
                                <div class="movie__btns">
                                    <a id="watchlist-btn" onclick="watchlist(this, ${item.id})"
                                       class="watchlist <#if item.inWatchlist>checked</#if>">
                                        <#if item.inWatchlist>Remove from watchlist<#else>Add to watchlist</#if>
                                    </a>
                                </div>
                            </#if>

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
                                                <div style="margin-left: 220px">${item.numVotes} votes</div>
                                        <#else>
                                                <div>${item.numVotes} votes</div>
                                            </#if>
                                    </span>
                                    </#if>
                                    <#if item.rating??>
                                        <span class="movie__rating" style="left: <#if name != "unknown">280px<#else>70px</#if>">${item.rating}</span>
                                    </#if>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>
                    </div>
                    <!-- end movie preview item -->
                </#list>

                <#list movies_director as item>
                    <!-- Movie preview item -->
                    <div class="movie movie--preview director">
                        <div class="col-sm-5 col-md-3">
                            <div class="movie__images">
                                <img alt='' src="${item.posterUrl}">
                            </div>
                            <div class="movie__feature">
                                <a href="#" class="movie__feature-item movie__feature--comment">${item.numComments}</a>
                                <a href="#" class="movie__feature-item movie__feature--favourite">${item.numFavourites}</a>
                                <a href="#" class="movie__feature-item movie__feature--photo">${item.gallery?size}</a>
                            </div>
                        </div>

                        <div class="col-sm-7 col-md-9">
                            <a href='/item/${item.id}' class="movie__title link--huge">${item.title} (${item.year?c})</a>

                            <p class="movie__time">${item.time} min</p>

                            <p class="movie__option">
                                <strong>Country: </strong>
                                <#list item.countries as country>
                                    <a href="/navigator?country=${country}">${country.getLabel()}</a><#sep>, </#sep>
                                </#list>
                            </p>
                            <p class="movie__option">
                                <strong>Companies: </strong>
                                <#list item.companies as company>
                                    <a href="/navigator?company=${company.id}">${company.name}</a><#sep>, </#sep>
                                </#list>
                            </p>
                            <p class="movie__option"><strong>Genres: </strong>
                                <#list item.genres as genre>
                                    <a href="/navigator?genre=${genre}">${genre}</a><#sep>, </#sep>
                                </#list>
                            </p>
                            <p class="movie__option"><strong>Release date: </strong>${item.release?string["dd.MM.yyyy"]}</p>
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

                            <#if name != "unknown">
                                <div class="movie__btns">
                                    <a id="watchlist-btn" onclick="watchlist(this, ${item.id})"
                                       class="watchlist <#if item.inWatchlist>checked</#if>">
                                        <#if item.inWatchlist>Remove from watchlist<#else>Add to watchlist</#if>
                                    </a>
                                </div>
                            </#if>

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
                                                <div style="margin-left: 220px">${item.numVotes} votes</div>
                                        <#else>
                                                <div>${item.numVotes} votes</div>
                                            </#if>
                                    </span>
                                    </#if>
                                    <#if item.rating??>
                                        <span class="movie__rating" style="left: <#if name != "unknown">280px<#else>70px</#if>">${item.rating}</span>
                                    </#if>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>
                    </div>
                    <!-- end movie preview item -->
                </#list>
            </div>

            <div class="choose-container">
                <div class="clearfix"></div>
            </div>
        </div>

        <aside class="col-sm-4 col-md-3">
            <div class="sitebar">
                <div class="category category--discuss category--count marginb-sm mobile-category ls-cat">
                    <h3 class="category__title">the Most <br><span class="title-edition">discussed posts</span></h3>
                    <ol>
                        <li><a href="#" class="category__item">Gravity</a></li>
                        <li><a href="#" class="category__item">The Counselor</a></li>
                        <li><a href="#" class="category__item">Bad Grandpa</a></li>
                        <li><a href="#" class="category__item">Blue Is the Warmest Color</a></li>
                        <li><a href="#" class="category__item">Rush</a></li>
                        <li><a href="#" class="category__item">Captain Phillips</a></li>
                        <li><a href="#" class="category__item">Escape Plan</a></li>
                        <li><a href="#" class="category__item">Cloudy with a Chance of Meatballs 2</a></li>
                        <li><a href="#" class="category__item">Prisoners</a></li>
                        <li><a href="#" class="category__item">The Fifth Estate</a></li>
                    </ol>
                </div>

                <div class="category category--cooming category--count marginb-sm mobile-category rs-cat">
                    <h3 class="category__title">coming soon<br><span class="title-edition">movies</span></h3>
                    <ol>
                        <#list movies_coming as movie>
                            <li><a href="/item/${movie.id}" class="category__item">${movie.title}</a></li>
                        </#list>
                    </ol>
                </div>

            </div>
        </aside>

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
            init_Star()
        });
    </script>

    <#if name != "unknown">
        <script>
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
                                $(e).removeClass("checked");
                                $(e).text("Add to watchlist");
                                console.log("Item was removed from watchlist");
                            }
                            else {
                                $(e).addClass("checked");
                                $(e).text("Remove from watchlist");
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
        </script>
    </#if>


</@c.page>
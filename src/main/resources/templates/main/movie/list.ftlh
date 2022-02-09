<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">


<@c.page>
    <#include "../../parts/search.ftlh">

    <!-- Main content -->
    <section class="container">
        <div class="col-sm-8 col-md-9">
            <h2 class="page-heading">Navigator</h2>

            <div class="tags-area">
                <div class="tags tags--unmarked">
                    <span class="tags__label">Sorted by:</span>
                    <ul>
                        <li class="item-wrap">
                            <a href="#" class="tags__item
                            <#if sort != "rating" && sort != "release" &&
                            sort != "popularity" && sort != "comments" &&
                            sort != "coming">item-active</#if>" data-filter='all'>all</a>
                        </li>
                        <li class="item-wrap"><a href="#" class="tags__item <#if sort == "rating">item-active</#if>" data-filter='rating'>rating</a></li>
                        <li class="item-wrap"><a href="#" class="tags__item <#if sort == "release">item-active</#if>" data-filter='release'>release date</a></li>
                        <li class="item-wrap"><a href="#" class="tags__item <#if sort == "popularity">item-active</#if>" data-filter='popularity'>popularity</a></li>
                        <li class="item-wrap"><a href="#" class="tags__item <#if sort == "comments">item-active</#if>" data-filter='comments'>comments</a></li>
                        <li class="item-wrap"><a href="#" class="tags__item <#if sort == "coming">item-active</#if>" data-filter='coming'>coming soon</a></li>
                    </ul>
                </div>
            </div>

            <#list page.content as item>
                <!-- Movie preview item -->
                <div class="movie movie--preview release">
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
                                <a href="#">${country.getLabel()}</a><#sep>, </#sep>
                            </#list>
                        </p>
                        <p class="movie__option">
                            <strong>Companies: </strong>
                            <#list item.companies as company>
                                <a href="#">${company.name}</a><#sep>, </#sep>
                            </#list>
                        </p>
                        <p class="movie__option"><strong>Genres: </strong>
                            <#list item.genres as genre>
                                <a href="#">${genre}</a><#sep>, </#sep>
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

            <#if page.hasContent()>
                <div class="coloum-wrapper">
                    <div class="pagination paginatioon--full">
                        <#if page.hasPrevious()>
                            <a href='${url}?page=${page.getNumber()}<#if sort?has_content>&sort=${sort}</#if><#if search?has_content>&search=${sort}</#if><#if category?has_content>&category=${category}</#if><#if company??>&company=${company}</#if><#if genre?has_content>&genre=${genre}</#if><#if country?has_content>&country=${country}</#if><#if from_year?has_content>&from_year=${from_year?c}</#if><#if to_year?has_content>&to_year=${to_year?c}</#if>' class="pagination__prev">prev</a>
                        </#if>

                        <#if page.hasNext()>
                            <a href='${url}?page=${page.getNumber() + 2}<#if sort?has_content>&sort=${sort}</#if><#if search?has_content>&search=${sort}</#if><#if category?has_content>&category=${category}</#if><#if company??>&company=${company}</#if><#if genre?has_content>&genre=${genre}</#if><#if country?has_content>&country=${country}</#if><#if from_year?has_content>&from_year=${from_year?c}</#if><#if to_year?has_content>&to_year=${to_year?c}</#if>' class="pagination__next">next</a>
                        </#if>
                    </div>
                </div>
            </#if>
        </div>

        <aside class="col-sm-4 col-md-3">
            <div class="sitebar">
                <div class="product-categori">
                    <form id="filter_from" method="get">
                        <input name="sort" value="${sort}" type="hidden">
                        <div class="filter-sidebar-left">
                            <div class="title-left">
                                <h3>Category</h3>
                            </div>
                            <div class="brand-box">
                                <div class="form_radio_btn">
                                    <input name="category" id="category0" value="all" type="radio" checked>
                                    <label for="category0"> All </label>
                                </div>
                                <#list categories as elem>
                                    <div class="form_radio_btn">
                                        <input name="category" id="category${elem?index + 1}" value="${elem}" type="radio" <#if category == elem>checked</#if>>
                                        <label for="category${elem?index + 1}"> ${elem.getLabel()} </label>
                                    </div>
                                </#list>
                            </div>
                        </div>
                        <div class="filter-sidebar-left">
                            <div class="title-left">
                                <h3>Company</h3>
                            </div>
                            <div class="list-group list-group-collapse list-group-sm list-group-tree" id="list-group-men" data-children=".sub-men">
                                <select name="company" class="custom-select">
                                    <option value="" <#if company?? == false>selected</#if>>All</option>
                                    <#list companies as elem>
                                        <option value="${elem.id}" <#if company?? && company == elem.id>selected</#if>>${elem.name}</option>
                                    </#list>
                                </select>
                            </div>
                        </div>
                        <div class="filter-sidebar-left">
                            <div class="title-left">
                                <h3>Genre</h3>
                            </div>
                            <div class="list-group list-group-collapse list-group-sm list-group-tree" id="list-group-men" data-children=".sub-men">
                                <select name="genre" class="custom-select">
                                    <option value="" <#if genre?? == false>selected</#if>>All</option>
                                    <#list genres as elem>
                                        <option value="${elem}" <#if genre?? && genre == elem>selected</#if>>${elem}</option>
                                    </#list>
                                </select>
                            </div>
                        </div>
                        <div class="filter-sidebar-left">
                            <div class="title-left">
                                <h3>Country</h3>
                            </div>
                            <div class="list-group list-group-collapse list-group-sm list-group-tree" id="list-group-men" data-children=".sub-men">
                                <select name="country" class="custom-select">
                                    <option value="" <#if country?? == false>selected</#if>>All</option>
                                    <#list countries as elem>
                                        <option value="${elem}" <#if country?? && country == elem>selected</#if>>${elem.getLabel()}</option>
                                    </#list>
                                </select>
                            </div>
                        </div>
                        <div class="filter-price-left">
                            <div class="title-left">
                                <h3>Year</h3>
                            </div>
                            <div class="price-box-slider">
                                <div id="year-range"></div>
                                <p>
                                    <input id="from_year" name="from_year" type="hidden" value="${from_year?c}">
                                    <input id="to_year" name="to_year" type="hidden" value="${to_year?c}">
                                    <input type="text" id="amount" readonly style="border:0; color:#fbb714; font-weight:bold;">
                                    <button type="submit" class="btn btn-md btn--danger">Apply</button>
                                </p>
                            </div>
                        </div>
                    </form>
                </div>

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
                        <li><a href="#" class="category__item">Ender's Game</a></li>
                        <li><a href="#" class="category__item">About Time</a></li>
                        <li><a href="#" class="category__item">Last Vegas</a></li>
                        <li><a href="#" class="category__item">Free Birds</a></li>
                        <li><a href="#" class="category__item">The Wolf of Wall Street</a></li>
                        <li><a href="#" class="category__item">The Best Man Holiday</a></li>
                        <li><a href="#" class="category__item">The Book Thief</a></li>
                        <li><a href="#" class="category__item">The Hunger Games: Catching Fire</a></li>
                        <li><a href="#" class="category__item">Delivery Man</a></li>
                        <li><a href="#" class="category__item">Nebraska</a></li>
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
            init_MovieList();
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

            $(function() {
                var min_year = ${min_year?c};
                var max_year = ${max_year?c};

                var from_year = ${from_year?c};
                var to_year = ${to_year?c};

                $("#year-range").slider({
                    range: true,
                    min: min_year,
                    max: max_year,
                    values: [from_year, to_year],
                    slide: function(event, ui) {
                        $("#amount").val(ui.values[0] + " - " + ui.values[1]);
                        $("#from_year").val(ui.values[0]);
                        $("#to_year").val(ui.values[1]);
                    }
                });
                $("#amount").val($("#year-range").slider("values", 0) +
                    " - " + $("#year-range").slider("values", 1));
            });
        </script>
    </#if>
</@c.page>
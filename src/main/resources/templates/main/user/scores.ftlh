<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">

<@c.page>
    <#include "../../parts/search.ftlh">

    <section class="container">
        <div class="col-sm-12">
            <div class="row">
                <div class="col-sm-8 col-md-9">
                    <h2 class="page-heading">
                        <a class="user-span" href="/user/${userId}">${username}</a> > <span class="user-list">Scores</span>
                    </h2>

                    <div class="tags-area" style="margin-bottom: 20px">
                        <div class="tags tags--unmarked">
                            <span class="tags__label">Sorted by:</span>
                            <ul>
                                <li class="item-wrap">
                                    <a href="#" class="tags__item item-active <#if sort != "rating" && sort != "date-asc" && sort != "score">item-active</#if>" data-filter='date'>date desc</a>
                                </li>
                                <li class="item-wrap"><a href="#" class="tags__item <#if sort == "date-asc">item-active</#if>" data-filter='date-asc'>date asc</a></li>
                                <li class="item-wrap"><a href="#" class="tags__item <#if sort == "rating">item-active</#if>" data-filter='rating'>rating</a></li>
                                <li class="item-wrap"><a href="#" class="tags__item <#if sort == "score">item-active</#if>" data-filter='score'>score</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="rates-wrapper">
                        <table>
                            <colgroup class="col-width-lg">
                            <colgroup class="col-width">
                            <colgroup class="col-width-sm">
                            <#if name != "unknown">
                                <colgroup class="col-width-sm">
                                <colgroup class="col-width-sm">
                                <colgroup class="col-width-sm">
                            </#if>

                            <#if page.hasContent()>
                                <tr class="rates rates--top">
                                    <th>Item</th>
                                    <th>Data and time</th>
                                    <th>Score</th>
                                    <#if name != "unknown">
                                        <#if userId != currentUserId>
                                            <th>My score</th>
                                        </#if>
                                        <th>Rate</th>
                                        <th>Watch</th>
                                    </#if>
                                    <#if userId == currentUserId>
                                        <th></th>
                                    </#if>
                                </tr>

                                <#list page.content as vote>
                                    <tr class="rates">
                                        <td class="rates__obj">
                                            <a href="/item/${vote.item.id}" class="rates__obj-name">${vote?index + (page.size * page.number) + 1}. ${vote.item.title} (${vote.item.year?c})</a>
                                            <span class="item_rating">${vote.item.rating}</span>
                                            <span class="item_votes">(${vote.item.numVotes} votes)</span>
                                            <span class="item_time">${vote.item.time} min</span>
                                        </td>
                                        <td class="rates__vote">${vote.updatedAt?string["dd.MM.yyyy, HH:mm"]}</td>
                                        <td id="score${vote?index}" class="rates__<#if userId == currentUserId>my__</#if>result">${vote.value}</td>
                                        <#if userId != currentUserId && name != "unknown">
                                            <td id="my_score${vote?index}" class="rates__my__result">
                                                <#if vote.item.myRate != 0>
                                                    ${vote.item.myRate}
                                                <#else> -
                                                </#if>
                                            </td>
                                        </#if>
                                        <#if name != "unknown">
                                            <td class="rates__stars">
                                                <a onclick="openModalRate(${vote?index})">
                                                    <i class="far fa-star"></i>
                                                </a>
                                            </td>
                                            <td class="item_watchlist">
                                                <a onclick="watchlist(this, ${vote.item.id})">
                                                    <#if vote.item.inWatchlist>
                                                        <i class="fas fa-bookmark"></i>
                                                    <#else>
                                                        <i class="far fa-bookmark"></i>
                                                    </#if>
                                                </a>
                                            </td>

                                            <#if userId == currentUserId>
                                                <td class="item_delete">
                                                    <form action="/score/${vote.id}/delete" method="post">
                                                        <input type="hidden" value="${_csrf.token}" name="_csrf">
                                                        <a onclick="$(this).parent().submit();"><i class="fas fa-trash-alt"></i></a>
                                                    </form>
                                                </td>
                                            </#if>
                                        </#if>
                                    </tr>
                                </#list>
                            <#else>
                                <h1 class="position-center text-center">No items</h1>
                            </#if>
                        </table>
                    </div>

                    <#if page.hasContent()>
                        <div class="pagination paginatioon--full coloum-wrapper">
                            <#if page.hasPrevious()>
                                <a href='${url}?page=${page.getNumber()}<#if sort?has_content>&sort=${sort}</#if><#if category?has_content>&category=${category}</#if><#if genre?has_content>&genre=${genre}</#if><#if from_year?has_content>&from_year=${from_year?c}</#if><#if to_year?has_content>&to_year=${to_year?c}</#if>' class="pagination__prev">prev</a>
                            </#if>

                            <#if page.hasNext()>
                                <a href='${url}?page=${page.getNumber() + 2}<#if sort?has_content>&sort=${sort}</#if><#if category?has_content>&category=${category}</#if><#if genre?has_content>&genre=${genre}</#if><#if from_year?has_content>&from_year=${from_year?c}</#if><#if to_year?has_content>&to_year=${to_year?c}</#if>' class="pagination__next">next</a>
                            </#if>
                        </div>
                    </#if>
                </div>

                <aside class="col-sm-4 col-md-3">
                    <div class="sitebar">
                        <#if page.hasContent()>
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
                        </#if>

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
            </div>
        </div>
    </section>

    <#if name != "unknown">
        <#list page.content as vote>
            <div id="modal-rate${vote?index}" class="overlay overlay-hugeinc">
                <section class="container" style="margin-top: 20%">
                    <div class="col-sm-4 col-sm-offset-4">
                        <button type="button" class="overlay-close">Close</button>
                        <div class="login">
                            <p class="login__title">Rate ${vote.item.title}</p>

                            <div class="field-wrap">
                                <div class="star-rating">
                                    <div class="star-input">
                                        <input type="radio" value="10" name="item-${vote.item.id}-rating" id="item-${vote.item.id}-rating-10" class="rating-10"
                                               <#if vote.item.myRate != 0 && vote.item.myRate == 10>checked</#if>>
                                        <label for="item-${vote.item.id}-rating-10" class="fas fa-star"></label>
                                        <input type="radio" value="9" name="item-${vote.item.id}-rating" id="item-${vote.item.id}-rating-9" class="rating-9"
                                               <#if vote.item.myRate != 0 && vote.item.myRate == 9>checked</#if>>
                                        <label for="item-${vote.item.id}-rating-9" class="fas fa-star"></label>
                                        <input type="radio" value="8" name="item-${vote.item.id}-rating" id="item-${vote.item.id}-rating-8" class="rating-8"
                                               <#if vote.item.myRate != 0 && vote.item.myRate == 8>checked</#if>>
                                        <label for="item-${vote.item.id}-rating-8" class="fas fa-star"></label>
                                        <input type="radio" value="7" name="item-${vote.item.id}-rating" id="item-${vote.item.id}-rating-7" class="rating-7"
                                               <#if vote.item.myRate != 0 && vote.item.myRate == 7>checked</#if>>
                                        <label for="item-${vote.item.id}-rating-7" class="fas fa-star"></label>
                                        <input type="radio" value="6" name="item-${vote.item.id}-rating" id="item-${vote.item.id}-rating-6" class="rating-6"
                                               <#if vote.item.myRate != 0 && vote.item.myRate == 6>checked</#if>>
                                        <label for="item-${vote.item.id}-rating-6" class="fas fa-star"></label>
                                        <input type="radio" value="5" name="item-${vote.item.id}-rating" id="item-${vote.item.id}-rating-5" class="rating-5"
                                               <#if vote.item.myRate != 0 && vote.item.myRate == 5>checked</#if>>
                                        <label for="item-${vote.item.id}-rating-5" class="fas fa-star"></label>
                                        <input type="radio" value="4" name="item-${vote.item.id}-rating" id="item-${vote.item.id}-rating-4" class="rating-4"
                                               <#if vote.item.myRate != 0 && vote.item.myRate == 4>checked</#if>>
                                        <label for="item-${vote.item.id}-rating-4" class="fas fa-star"></label>
                                        <input type="radio" value="3" name="item-${vote.item.id}-rating" id="item-${vote.item.id}-rating-3" class="rating-3"
                                               <#if vote.item.myRate != 0 && vote.item.myRate == 3>checked</#if>>
                                        <label for="item-${vote.item.id}-rating-3" class="fas fa-star"></label>
                                        <input type="radio" value="2" name="item-${vote.item.id}-rating" id="item-${vote.item.id}-rating-2" class="rating-2"
                                               <#if vote.item.myRate != 0 && vote.item.myRate == 2>checked</#if>>
                                        <label for="item-${vote.item.id}-rating-2" class="fas fa-star"></label>
                                        <input type="radio" value="1" name="item-${vote.item.id}-rating" id="item-${vote.item.id}-rating-1" class="rating-1"
                                               <#if vote.item.myRate != 0 && vote.item.myRate == 1>checked</#if>>
                                        <label for="item-${vote.item.id}-rating-1" class="fas fa-star"></label>

                                        <!-- Rating Submit Form -->
                                        <form action="" id="rating-form${vote.item.id}" <#if vote.item.myRate?? && vote.item.myRate != 0>style="display: inline-block;"</#if>>
                                            <span class="rating-reaction"></span>
                                            <a class="submit-rating" onclick="vote(this, ${vote?index}, ${vote.item.id})">Submit</a>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </#list>
    </#if>

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
            init_Rates();
        });
    </script>

    <#if name != "unknown">
        <script>
            function openModalRate(id){
                $("#modal-rate" + id).addClass("open");
            }

            function deleteVote(e){
                $(e).parent().submit();
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

            function vote(e, index, itemId){
                var form = $("#modal-rate" + index);
                var value = form.find(".star-input input[type='radio']:checked").val();
                console.log(value);

                if(value < 1 || value > 10){
                    rating = null;
                } else {
                    rating = {'item': itemId, 'value': value};
                }

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
                                console.log("You rate " + itemId + " item with " + value + " score");
                                var span = null;
                                <#if userId != currentUserId>
                                    span = $("#my_score" + index);
                                <#else>
                                    span = $("#score" + index);
                                </#if>
                                span.text(value);

                                $('#modal-rate' + index).removeClass('open').addClass('close');

                                setTimeout(function(){
                                    $('#modal-rate' + index).removeClass('close');}, 500);
                            }
                        },
                        error: function (error) {
                            var err = error.responseJSON.message;
                            alert(err);
                            location.reload();
                        }
                    });
                }
                return false;
            }
        </script>
    </#if>

    <#if page.hasContent()>
        <script>
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
<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">

<@c.page>
    <#include "../../parts/search.ftlh">

    <section class="container">
        <div class="col-sm-12">
            <div class="row">
                <div class="col-sm-8 col-md-9">
                    <h2 class="page-heading">
                        <a class="user-span" href="/user/${userId}">${username}</a> > <span class="user-list">Watchlist</span>
                    </h2>

                    <div class="rates-wrapper">
                        <table>
                            <colgroup class="col-width-lg">
                            <colgroup class="col-width">
                            <colgroup class="col-width-sm">

                            <#if name != "unknown">
                                <#if userId != currentUserId>
                                    <colgroup class="col-width-sm">
                                </#if>
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
                            </tr>

                                <#list page.content as watch>
                                <tr class="rates">
                                    <td class="rates__obj">
                                        <a href="/item/${watch.item.id}" class="rates__obj-name">${watch?index + (page.size * page.number) + 1}. ${watch.item.title} (${watch.item.year?c})</a>
                                        <span class="item_rating"><#if watch.item.rating??>${watch.item.rating}<#else>-</#if></span>
                                        <span class="item_votes">(${watch.item.numVotes} votes)</span>
                                        <span class="item_time">${watch.item.time} min</span>
                                    </td>
                                    <td class="rates__vote">${watch.createdAt?string["dd.MM.yyyy, HH:mm"]}</td>
                                    <td id="score${watch?index}" class="rates__<#if userId == currentUserId>my__</#if>result">
                                        <#if watch.hisRate != 0>
                                            ${watch.hisRate}
                                        <#else> -
                                        </#if>
                                    </td>
                                    <#if userId != currentUserId && name != "unknown">
                                        <td id="my_score${watch?index}" class="rates__my__result">
                                            <#if watch.item.myRate != 0>
                                                ${watch.item.myRate}
                                            <#else> -
                                            </#if>
                                        </td>
                                    </#if>
                                    <#if name != "unknown">
                                        <td class="rates__stars">
                                            <#if watch.item.release lte .now>
                                                <a onclick="openModalRate(${watch?index})">
                                                    <i class="far fa-star"></i>
                                                </a>
                                            </#if>
                                        </td>
                                        <td class="item_watchlist">
                                            <a onclick="watchlist(this, ${watch.item.id})">
                                                <#if watch.item.inWatchlist>
                                                    <i class="fas fa-bookmark"></i>
                                                <#else>
                                                    <i class="far fa-bookmark"></i>
                                                </#if>
                                            </a>
                                        </td>
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
                                <a href='${url}?page=${page.getNumber()}' class="pagination__prev">prev</a>
                            </#if>

                            <#if page.hasNext()>
                                <a href='${url}?page=${page.getNumber() + 2}' class="pagination__next">next</a>
                            </#if>
                        </div>
                    </#if>
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
            </div>
        </div>
    </section>

    <#if name != "unknown">
        <#list page.content as watch>
            <#if watch.item.release lte .now>
            <div id="modal-rate${watch?index}" class="overlay overlay-hugeinc">
                <section class="container" style="margin-top: 20%">
                    <div class="col-sm-4 col-sm-offset-4">
                        <button type="button" class="overlay-close">Close</button>
                        <div class="login">
                            <p class="login__title">Rate ${watch.item.title}</p>

                            <div class="field-wrap">
                                <div class="star-rating">
                                    <div class="star-input">
                                        <input type="radio" value="10" name="item-${watch.item.id}-rating" id="item-${watch.item.id}-rating-10" class="rating-10"
                                               <#if watch.item.myRate != 0 && watch.item.myRate == 10>checked</#if>>
                                        <label for="item-${watch.item.id}-rating-10" class="fas fa-star"></label>
                                        <input type="radio" value="9" name="item-${watch.item.id}-rating" id="item-${watch.item.id}-rating-9" class="rating-9"
                                               <#if watch.item.myRate != 0 && watch.item.myRate == 9>checked</#if>>
                                        <label for="item-${watch.item.id}-rating-9" class="fas fa-star"></label>
                                        <input type="radio" value="8" name="item-${watch.item.id}-rating" id="item-${watch.item.id}-rating-8" class="rating-8"
                                               <#if watch.item.myRate != 0 && watch.item.myRate == 8>checked</#if>>
                                        <label for="item-${watch.item.id}-rating-8" class="fas fa-star"></label>
                                        <input type="radio" value="7" name="item-${watch.item.id}-rating" id="item-${watch.item.id}-rating-7" class="rating-7"
                                               <#if watch.item.myRate != 0 && watch.item.myRate == 7>checked</#if>>
                                        <label for="item-${watch.item.id}-rating-7" class="fas fa-star"></label>
                                        <input type="radio" value="6" name="item-${watch.item.id}-rating" id="item-${watch.item.id}-rating-6" class="rating-6"
                                               <#if watch.item.myRate != 0 && watch.item.myRate == 6>checked</#if>>
                                        <label for="item-${watch.item.id}-rating-6" class="fas fa-star"></label>
                                        <input type="radio" value="5" name="item-${watch.item.id}-rating" id="item-${watch.item.id}-rating-5" class="rating-5"
                                               <#if watch.item.myRate != 0 && watch.item.myRate == 5>checked</#if>>
                                        <label for="item-${watch.item.id}-rating-5" class="fas fa-star"></label>
                                        <input type="radio" value="4" name="item-${watch.item.id}-rating" id="item-${watch.item.id}-rating-4" class="rating-4"
                                               <#if watch.item.myRate != 0 && watch.item.myRate == 4>checked</#if>>
                                        <label for="item-${watch.item.id}-rating-4" class="fas fa-star"></label>
                                        <input type="radio" value="3" name="item-${watch.item.id}-rating" id="item-${watch.item.id}-rating-3" class="rating-3"
                                               <#if watch.item.myRate != 0 && watch.item.myRate == 3>checked</#if>>
                                        <label for="item-${watch.item.id}-rating-3" class="fas fa-star"></label>
                                        <input type="radio" value="2" name="item-${watch.item.id}-rating" id="item-${watch.item.id}-rating-2" class="rating-2"
                                               <#if watch.item.myRate != 0 && watch.item.myRate == 2>checked</#if>>
                                        <label for="item-${watch.item.id}-rating-2" class="fas fa-star"></label>
                                        <input type="radio" value="1" name="item-${watch.item.id}-rating" id="item-${watch.item.id}-rating-1" class="rating-1"
                                               <#if watch.item.myRate != 0 && watch.item.myRate == 1>checked</#if>>
                                        <label for="item-${watch.item.id}-rating-1" class="fas fa-star"></label>

                                        <!-- Rating Submit Form -->
                                        <form action="" id="rating-form${watch.item.id}" <#if watch.item.myRate?? && watch.item.myRate != 0>style="display: inline-block;"</#if>>
                                            <span class="rating-reaction"></span>
                                            <a class="submit-rating" onclick="vote(this, ${watch?index}, ${watch.item.id})">Submit</a>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            </#if>
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
</@c.page>
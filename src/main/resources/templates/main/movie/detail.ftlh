<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">

<@c.page>
<#include "../../parts/search.ftlh">

    <section class="container">
        <div class="col-sm-8 col-md-9">
            <div class="movie">
                <h2 class="page-heading">${item.title}</h2>

                <div class="movie__info">
                    <div class="col-sm-6 col-md-4 movie-mobile">
                        <div class="movie__images">
                            <#if item.rating??><span class="movie__rating">${item.rating}</span></#if>
                            <img alt='' src="${item.posterUrl}">
                        </div>
                        <#if name != "unknown" && item.release lte .now>
                            <div class="movie__rate">Your vote:
                                <span id="my-rate"><#if item.myRate != 0>${item.myRate}<#else>-</#if></span>
                                <div class="favourite <#if favourite>active</#if>">
                                    <span class="<#if favourite>fas fa-heart<#else>far fa-heart</#if>"></span>
                                    <div class="ring"></div>
                                    <div class="ring2"></div>
                                    <p class="info">Added to favourites!</p>
                                </div>
                            </div>
                        </#if>
                    </div>

                    <div class="col-sm-6 col-md-8">
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
                        <p class="movie__option"><strong>Year: </strong>
                            <a href="/navigator?from_year=${item.year?c}&to_year=${item.year?c}">${item.year?c}</a>
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
                        <p class="movie__option"><strong>Age restriction: </strong>${item.mpaa.getLabel()}</p>
                        <p class="movie__option"><strong>Budget: </strong>
                            <#if item.budget??>$${item.budget}<#else>-</#if>
                        </p>

                        <#if item.boxOffice??>
                            <p class="movie__option"><strong>Box office: </strong>
                                $${item.boxOffice}
                            </p>
                        </#if>

                        <p class="movie__option"><strong>Total votes: </strong>${item.numVotes}</p>

                        <a href="#" class="comment-link">Comments:  ${item.numComments}</a>

                        <#if name != "unknown">
                            <div class="movie__btns">
                                <#if item.release lte .now>
                                    <a class="btn btn-md btn--warning login-window">rate</a>
                                </#if>
                                <a id="watchlist-btn" class="watchlist <#if item.inWatchlist>checked</#if>">
                                    <#if item.inWatchlist>Remove from watchlist<#else>Add to watchlist</#if>
                                </a>
                            </div>

                        </#if>
                    </div>
                </div>

                <div class="clearfix"></div>

                <h2 class="page-heading">The plot</h2>

                <p class="movie__describe">${item.description}</p>

                <h2 class="page-heading">photos &amp; videos</h2>

                <div class="movie__media">
                    <div class="movie__media-switch">
                        <a href="#" class="watchlist list--photo" data-filter='media-photo'>${item.gallery?size} photos</a>
                        <a href="#" class="watchlist list--video" data-filter='media-video'>videos</a>
                    </div>


                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <#list item.gallery as image>
                                <div class="swiper-slide media-photo">
                                    <a href="${image.imageUrl}" class="movie__media-item">
                                        <img alt='' src="${image.imageUrl}">
                                    </a>
                                </div>
                            </#list>

                            <#if item.trailer?? && item.trailer != "">
                                <#assign video_id = item.trailer?keep_after_last("=")>
                                <div class="swiper-slide media-video">
                                    <a href='${item.trailer}' class="movie__media-item ">
                                        <img alt='' src="https://img.youtube.com/vi/${video_id}/0.jpg">
                                    </a>
                                </div>
                            </#if>
                        </div>
                    </div>

                </div>

            </div>

            <div class="choose-container">
                <#if cinema_seances??>

                    <h2 class="page-heading">showtime &amp; tickets</h2>
                    <form id='select' class="select select--city">
                        <select id="select-city" class="select__sort" tabindex="0">
                            <#list cities as c>
                                <option value="${c}" <#if city?? && city == c>selected</#if>>${c}</option>
                            </#list>
                        </select>
                    </form>

                    <form class="select select--date" method='get'>
                        <input name="city" type="hidden" value="<#if city??>${city}</#if>">
                        <select id="select-date" name="date" class="select__sort" tabindex="0">
                            <#list dates as d>
                                <option <#if date?? && date?string["yyyy-MM-dd"] == d?string["yyyy-MM-dd"]>selected</#if> value="${d?string["yyyy-MM-dd"]}">${d}</option>
                            </#list>
                        </select>
                    </form>
                    <a href="#" id="map-switch" class="watchlist watchlist--map watchlist--map-full"><span class="show-map">Show cinemas on map</span><span class="hide-cinemas_map">Hide map</span></a>

                    <div class="clearfix"></div>

                    <div class="time-select">
                        <#list cinema_seances as cinema, seances>
                            <div class="time-select__group">
                                <div class="col-sm-4">
                                    <p class="time-select__place">${cinema.name}</p>
                                </div>
                                <ul class="col-sm-8 items-wrap">
                                    <#list seances as seance>
                                        <li class="time-select__item" onclick="location.href='/seance/${seance.id}'">${seance.startTime?string["HH:mm"]}</li>
                                    </#list>
                                </ul>
                            </div>
                        </#list>
                    </div>
                </#if>

                <!-- hiden maps with multiple locator-->
                <div class="map hide-map">
                    <div id='cimenas-map'></div>
                </div>

                <h2 class="page-heading">comments (${item.numComments})</h2>

                <div class="comment-wrapper">
                    <#if name != "unknown">
                        <form action="/comment/create" method='post' id="comment-form" class="comment-form">
                            <input type="hidden" value="${_csrf.token}" name="_csrf">
                            <input name="movie" type="hidden" value="${item.id}">
                            <textarea name="text" class="comment-form__text" placeholder='Add you comment here'></textarea>
                            <label class="comment-form__info">1000 characters left</label>
                            <button type='submit' class="btn btn-md btn--danger comment-form__btn">add comment</button>
                        </form>
                    </#if>

                    <div class="comment-sets">
                        <#if comments?size gt 10>
                            <#list comments[0..9] as comment>
                                <div class="comment">
                                    <div class="comment__images">
                                        <img alt='' src="${comment.user.imgUrl}">
                                    </div>

                                    <a href='/user/${comment.user.id}' class="comment__author">${comment.user.fullName()}</a>
                                    <p class="comment__date">${comment.createdAt?string["dd.MM.yyyy"]} | ${comment.createdAt?string["HH:mm"]}</p>
                                    <p class="comment__message">${comment.text}</p>
                                    <a class="comment__reply" data-id="${comment.id}">Reply</a>
                                    <#if name != "unknown" && currentUserId == comment.user.id>
                                        <form action="/item/${item.id}/comment/${comment.id}/delete" method="post">
                                            <input type="hidden" value="${_csrf.token}" name="_csrf">
                                            <button type="submit" class="comment__delete"></button>
                                        </form>
                                    </#if>
                                    <ul class="list-unstyled list-inline media-detail-com">
                                        <li title="Like">
                                            <span data-icon="like" class="like <#if comment.meLiked(user)>liked<#else>default</#if>">
                                                <i class="fa fa-thumbs-up" onclick="like(this, ${comment.id})"></i>
                                            </span>
                                            <span data-count="like">${comment.countLikes()}</span>
                                        </li>
                                        <li title="Dislike">
                                            <span data-icon="dislike" class="dislike <#if comment.meDisliked(user)>disliked<#else>default</#if>">
                                                <i class="fa fa-thumbs-down" onclick="dislike(this, ${comment.id})"></i>
                                            </span>
                                            <span data-count="dislike">${comment.countDislikes()}</span>
                                        </li>
                                    </ul>
                                </div>

                                <#list comment.replies as reply>
                                    <div class="comment comment--answer">
                                        <div class="comment__images">
                                            <img alt='' src="${reply.user.imgUrl}">
                                        </div>

                                        <a href='/user/${reply.user.id}' class="comment__author">${reply.user.fullName()}</a>
                                        <p class="comment__date">${reply.createdAt?string["dd.MM.yyyy"]} | ${reply.createdAt?string["HH:mm"]}</p>
                                        <p class="comment__message">${reply.text}</p>
                                        <#if name != "unknown" && currentUserId == reply.user.id>
                                            <form action="/item/${item.id}/comment/${reply.id}/delete" method="post">
                                                <input type="hidden" value="${_csrf.token}" name="_csrf">
                                                <button type="submit" class="comment__delete"></button>
                                            </form>
                                        </#if>
                                        <ul class="list-unstyled list-inline media-detail-com">
                                            <li title="Like">
                                            <span data-icon="like" class="like <#if reply.meLiked(user)>liked<#else>default</#if>">
                                                <i class="fa fa-thumbs-up" onclick="like(this, ${reply.id})"></i>
                                            </span>
                                                <span data-count="like">${reply.countLikes()}</span>
                                            </li>
                                            <li title="Dislike">
                                            <span data-icon="dislike" class="dislike <#if reply.meDisliked(user)>disliked<#else>default</#if>">
                                                <i class="fa fa-thumbs-down" onclick="dislike(this, ${reply.id})"></i>
                                            </span>
                                                <span data-count="dislike">${reply.countDislikes()}</span>
                                            </li>
                                        </ul>
                                    </div>
                                </#list>
                            </#list>

                            <div id='hide-comments' class="hide-comments">
                                <#list comments[10..] as comment>
                                    <div class="comment">
                                        <div class="comment__images">
                                            <img alt='' src="${comment.user.imgUrl}">
                                        </div>

                                        <a href='/user/${comment.user.id}' class="comment__author">${comment.user.fullName()}</a>
                                        <p class="comment__date">${comment.createdAt?string["dd.MM.yyyy"]} | ${comment.createdAt?string["HH:mm"]}</p>
                                        <p class="comment__message">${comment.text}</p>
                                        <a class="comment__reply" data-id="${comment.id}">Reply</a>
                                        <#if name != "unknown" && currentUserId == comment.user.id>
                                            <form action="/item/${item.id}/comment/${comment.id}/delete" method="post">
                                                <input type="hidden" value="${_csrf.token}" name="_csrf">
                                                <button type="submit" class="comment__delete"></button>
                                            </form>
                                        </#if>

                                        <ul class="list-unstyled list-inline media-detail-com">
                                            <li title="Like">
                                            <span data-icon="like" class="like <#if comment.meLiked(user)>liked<#else>default</#if>">
                                                <i class="fa fa-thumbs-up" onclick="like(this, ${comment.id})"></i>
                                            </span>
                                                <span data-count="like">${comment.countLikes()}</span>
                                            </li>
                                            <li title="Dislike">
                                            <span data-icon="dislike" class="dislike <#if comment.meDisliked(user)>disliked<#else>default</#if>">
                                                <i class="fa fa-thumbs-down" onclick="dislike(this, ${comment.id})"></i>
                                            </span>
                                                <span data-count="dislike">${comment.countDislikes()}</span>
                                            </li>
                                        </ul>
                                    </div>
                                    <#list comment.replies as reply>
                                        <div class="comment comment--answer">
                                            <div class="comment__images">
                                                <img alt='' src="${reply.user.imgUrl}">
                                            </div>

                                            <a href='/user/${reply.user.id}' class="comment__author">${reply.user.fullName()}</a>
                                            <p class="comment__date">${reply.createdAt?string["dd.MM.yyyy"]} | ${reply.createdAt?string["HH:mm"]}</p>
                                            <p class="comment__message">${reply.text}</p>
                                            <#if name != "unknown" && currentUserId == reply.user.id>
                                                <form action="/item/${item.id}/comment/${reply.id}/delete" method="post">
                                                    <input type="hidden" value="${_csrf.token}" name="_csrf">
                                                    <button type="submit" class="comment__delete"></button>
                                                </form>
                                            </#if>
                                            <ul class="list-unstyled list-inline media-detail-com">
                                                <li title="Like">
                                            <span data-icon="like" class="like <#if reply.meLiked(user)>liked<#else>default</#if>">
                                                <i class="fa fa-thumbs-up" onclick="like(this, ${reply.id})"></i>
                                            </span>
                                                    <span data-count="like">${reply.countLikes()}</span>
                                                </li>
                                                <li title="Dislike">
                                            <span data-icon="dislike" class="dislike <#if reply.meDisliked(user)>disliked<#else>default</#if>">
                                                <i class="fa fa-thumbs-down" onclick="dislike(this, ${reply.id})"></i>
                                            </span>
                                                    <span data-count="dislike">${reply.countDislikes()}</span>
                                                </li>
                                            </ul>
                                        </div>
                                    </#list>
                                </#list>
                            </div>

                            <div class="comment-more">
                                <a href="#" class="watchlist">Show all comments</a>
                            </div>
                        <#else>
                            <#list comments as comment>
                                <div class="comment">
                                    <div class="comment__images">
                                        <img alt='' src="${comment.user.imgUrl}">
                                    </div>

                                    <a href='/user/${comment.user.id}' class="comment__author">${comment.user.fullName()}</a>
                                    <p class="comment__date">${comment.createdAt?string["dd.MM.yyyy"]} | ${comment.createdAt?string["HH:mm"]}</p>
                                    <p class="comment__message">${comment.text}</p>
                                    <a class="comment__reply" data-id="${comment.id}">Reply</a>
                                    <ul class="list-unstyled list-inline media-detail-com">
                                        <li title="Like">
                                            <span data-icon="like" class="like <#if comment.meLiked(user)>liked<#else>default</#if>">
                                                <i class="fa fa-thumbs-up" onclick="like(this, ${comment.id})"></i>
                                            </span>
                                            <span data-count="like">${comment.countLikes()}</span>
                                        </li>
                                        <li title="Dislike">
                                            <span data-icon="dislike" class="dislike <#if comment.meDisliked(user)>disliked<#else>default</#if>">
                                                <i class="fa fa-thumbs-down" onclick="dislike(this, ${comment.id})"></i>
                                            </span>
                                            <span data-count="dislike">${comment.countDislikes()}</span>
                                        </li>
                                    </ul>
                                    <#if name != "unknown" && currentUserId == comment.user.id>
                                        <form action="/item/${item.id}/comment/${comment.id}/delete" method="post">
                                            <input type="hidden" value="${_csrf.token}" name="_csrf">
                                            <button type="submit" class="comment__delete"></button>
                                        </form>
                                    </#if>
                                </div>
                                <#list comment.replies as reply>
                                    <div class="comment comment--answer">
                                        <div class="comment__images">
                                            <img alt='' src="${reply.user.imgUrl}">
                                        </div>

                                        <a href='/user/${reply.user.id}' class="comment__author">${reply.user.fullName()}</a>
                                        <p class="comment__date">${reply.createdAt?string["dd.MM.yyyy"]} | ${reply.createdAt?string["HH:mm"]}</p>
                                        <p class="comment__message">${reply.text}</p>
                                        <#if name != "unknown" && currentUserId == reply.user.id>
                                            <form action="/item/${item.id}/comment/${reply.id}/delete" method="post">
                                                <input type="hidden" value="${_csrf.token}" name="_csrf">
                                                <button type="submit" class="comment__delete"></button>
                                            </form>
                                        </#if>
                                        <ul class="list-unstyled list-inline media-detail-com">
                                            <li title="Like">
                                            <span data-icon="like" class="like <#if reply.meLiked(user)>liked<#else>default</#if>">
                                                <i class="fa fa-thumbs-up" onclick="like(this, ${reply.id})"></i>
                                            </span>
                                                <span data-count="like">${reply.countLikes()}</span>
                                            </li>
                                            <li title="Dislike">
                                            <span data-icon="dislike" class="dislike <#if reply.meDisliked(user)>disliked<#else>default</#if>">
                                                <i class="fa fa-thumbs-down" onclick="dislike(this, ${reply.id})"></i>
                                            </span>
                                                <span data-count="dislike">${reply.countDislikes()}</span>
                                            </li>
                                        </ul>
                                    </div>
                                </#list>
                            </#list>
                        </#if>
                    </div>
                </div>
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

    <!-- open/close -->
    <#if name != "unknown" && item.release lte .now>
        <div class="overlay overlay-hugeinc">
            <section class="container" style="margin-top: 20%">
                <div class="col-sm-4 col-sm-offset-4">
                    <button type="button" class="overlay-close">Close</button>
                    <div class="login">
                        <p class="login__title">Rate this movie</p>

                        <div class="field-wrap">
                            <div class="star-rating">
                                <div class="star-input">
                                    <input type="radio" value="10" name="rating" id="rating-10"
                                           <#if item.myRate?? && item.myRate != 0 && item.myRate == 10>checked</#if>>
                                    <label for="rating-10" class="fas fa-star"></label>
                                    <input type="radio" value="9" name="rating" id="rating-9"
                                           <#if item.myRate?? && item.myRate != 0 && item.myRate == 9>checked</#if>>
                                    <label for="rating-9" class="fas fa-star"></label>
                                    <input type="radio" value="8" name="rating" id="rating-8"
                                           <#if item.myRate?? && item.myRate != 0 && item.myRate == 8>checked</#if>>
                                    <label for="rating-8" class="fas fa-star"></label>
                                    <input type="radio" value="7" name="rating" id="rating-7"
                                           <#if item.myRate?? && item.myRate != 0 && item.myRate == 7>checked</#if>>
                                    <label for="rating-7" class="fas fa-star"></label>
                                    <input type="radio" value="6" name="rating" id="rating-6"
                                           <#if item.myRate?? && item.myRate != 0 && item.myRate == 6>checked</#if>>
                                    <label for="rating-6" class="fas fa-star"></label>
                                    <input type="radio" value="5" name="rating" id="rating-5"
                                           <#if item.myRate?? && item.myRate != 0 && item.myRate == 5>checked</#if>>
                                    <label for="rating-5" class="fas fa-star"></label>
                                    <input type="radio" value="4" name="rating" id="rating-4"
                                           <#if item.myRate?? && item.myRate != 0 && item.myRate == 4>checked</#if>>
                                    <label for="rating-4" class="fas fa-star"></label>
                                    <input type="radio" value="3" name="rating" id="rating-3"
                                           <#if item.myRate?? && item.myRate != 0 && item.myRate == 3>checked</#if>>
                                    <label for="rating-3" class="fas fa-star"></label>
                                    <input type="radio" value="2" name="rating" id="rating-2"
                                           <#if item.myRate?? && item.myRate != 0 && item.myRate == 2>checked</#if>>
                                    <label for="rating-2" class="fas fa-star"></label>
                                    <input type="radio" value="1" name="rating" id="rating-1"
                                           <#if item.myRate?? && item.myRate != 0 && item.myRate == 1>checked</#if>>
                                    <label for="rating-1" class="fas fa-star"></label>

                                    <!-- Rating Submit Form -->
                                    <form id="rating-form" <#if item.myRate?? && item.myRate != 0>style="display: inline-block;"</#if>>
                                        <span class="rating-reaction"></span>
                                        <button class="submit-rating">Submit</button>
                                        <#if item.myRate??>
                                            <button class="delete-rating">Delete</button>
                                        </#if>
                                    </form>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

            </section>
        </div>
    </#if>

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
            init_MoviePage();
        });
        <#if name != "unknown">
            $('input[name=rating]').change(function() {
                if(this.checked) {
                    $("#rating-form").show();
                }
            });

            $(".submit-rating").click(function (e){
                var value = $('.star-rating input[name=rating]:checked').val();
                var item = ${item.id};

                if(value < 1 || value > 10){
                    rating = null;
                } else {
                    rating = {'item': item, 'value': value};
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
                                $("#my-rate").text(value);

                                $('.overlay').removeClass('open').addClass('close');

                                setTimeout(function(){
                                    $('.overlay').removeClass('close');}, 500);

                                if ($('.delete-rating').length === 0) {
                                    $("#rating-form").append("<button class='delete-rating'>Delete</button>");
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
                return false;
            });

            $("#rating-form").on('click', '.delete-rating', function (e){
                var input = $('.star-rating input[name=rating]:checked');
                var item = ${item.id};

                $.post({
                    url: '/rate/delete',
                    data: JSON.stringify(item),
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': '${_csrf.token}'
                    },
                    success: function (data, status) {
                        if (status === 'success') {
                            $("#my-rate").text("-");
                            input.prop('checked', false);
                            $("#rating-form").hide();
                            $(".delete-rating").remove();
                            $('.overlay').removeClass('open').addClass('close');

                            setTimeout(function(){
                                $('.overlay').removeClass('close');}, 500);
                        }
                    },
                    error: function (error) {
                        var err = error.responseJSON.message;
                        alert(err);
                        location.reload();
                    }
                });
                return false;

            });

            $(".movie__btns").on('click', '#watchlist-btn', function (e){
                var item = ${item.id};

                $.post({
                    url: '/watchlist',
                    data: JSON.stringify(item),
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': '${_csrf.token}'
                    },
                    success: function (data, status) {
                        if (status === 'success') {
                            if(data == 0) {
                                $("#watchlist-btn").removeClass("checked");
                                $("#watchlist-btn").text("Add to watchlist");
                                console.log("Item was removed from watchlist");
                            }
                            else {
                                $("#watchlist-btn").addClass("checked");
                                $("#watchlist-btn").text("Remove from watchlist");
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
                return false;
            });

            $(".favourite").click(function (e){
                var item = ${item.id};

                $.post({
                    url: '/favourite',
                    data: JSON.stringify(item),
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': '${_csrf.token}'
                    },
                    success: function (data, status) {
                        if (status === 'success') {
                            if (data == 0) {
                                $('.favourite').removeClass('active')
                                setTimeout(function() {
                                    $('.favourite').removeClass('active-2')
                                }, 30)
                                $('.favourite').removeClass('active-3')
                                setTimeout(function() {
                                    $('.favourite span').removeClass('fas fa-heart')
                                    $('.favourite span').addClass('far fa-heart')
                                }, 15)
                            } else {
                                $('.favourite').addClass('active')
                                $('.favourite').addClass('active-2')
                                setTimeout(function() {
                                    $('.favourite span').removeClass('far fa-heart')
                                    $('.favourite span').addClass('fas fa-heart')
                                }, 150)
                                setTimeout(function() {
                                    $('.favourite').addClass('active-3')
                                }, 150)
                                $('.favourite .info').addClass('info-tog')
                                setTimeout(function(){
                                    $('.favourite .info').removeClass('info-tog')
                                },1000)
                            }
                        }
                    },
                    error: function (error) {
                        var err = error.responseJSON.message;
                        alert(err);
                        location.reload();
                    }
                });
                return false;
            });

            $('.comment__reply').click( function (e) {
                e.preventDefault();
                var parent_id = $(this).data("id");
                $('.comment').find('.comment-form').remove();
                $(this).parent().append("<form action='/comment/create' method='post' id='reply-form' class='comment-form'>\
                    <input type=\"hidden\" value=\"${_csrf.token}\" name=\"_csrf\">\
                    <input name=\"movie\" type=\"hidden\" value=\"${item.id}\">\
                    <input name=\"parent\" type=\"hidden\" value=\"" + parent_id + "\">\
                    <textarea name='text' class='comment-form__text' placeholder='Add you comment here'></textarea>\
                    <label class='comment-form__info'>1000 characters left</label>\
                    <button type='submit' class='btn btn-md btn--danger comment-form__btn'>add comment</button>\
                </form>");

                $("#reply-form").submit(function(e) {
                    e.preventDefault();
                    var error = 0;
                    var self = $(this);

                    var $text = self.find('textarea');

                    if($text.val().length > 10 && $text.val().length < 1000 &&  $text.val()!= $text.attr('placeholder')  ) {
                        $text.removeClass('invalid_field');
                    }
                    else {
                        createErrTult('Comment must be between 10 and 1000 characters!', $text)
                        error++;
                    }

                    if (error != 0)
                        return;

                    self.unbind("submit").submit();
                });
            });

            $("#comment-form").submit(function(e) {
                e.preventDefault();
                var error = 0;
                var self = $(this);

                var $text = self.find('textarea');

                if($text.val().length > 10 && $text.val().length < 1000 &&  $text.val()!= $text.attr('placeholder')  ) {
                    $text.removeClass('invalid_field');
                }
                else {
                    createErrTult('Comment must be between 10 and 1000 characters!', $text)
                    error++;
                }

                if (error != 0)
                    return;

                self.unbind("submit").submit();
            });

            function createErrTult(text, $elem){
                $elem.focus();
                $('<p />', {
                    'class':'inv-em alert alert-danger',
                    'html':'<span class="icon-warning"></span>' + text + ' <a class="close" data-dismiss="alert" href="#" aria-hidden="true"></a>',
                })
                    .appendTo($elem.addClass('invalid_field').parent())
                    .insertAfter($elem)
                    .delay(4000).animate({'opacity':0},300, function(){ $(this).slideUp(400,function(){ $(this).remove() }) });
            }

            function like(e, id){
                var like = $(e).parent().parent();
                var dislike = like.next();
                $.post({
                    url: '/comment/' + id + '/like',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': '${_csrf.token}'
                    },
                    success: function (data, status) {
                        if (status === 'success') {
                            if(data.result == true) {
                                $(e).parent().removeClass("default");
                                dislike.find("span.dislike").removeClass("disliked");
                                dislike.find("span.dislike").addClass("default");
                                $(e).parent().addClass("liked");
                                console.log("Comment " + id + " was liked");
                            }
                            else {
                                $(e).parent().removeClass("liked");
                                $(e).parent().addClass("default");
                                console.log("Like was removed from comment " + id);
                            }
                            console.log("likes: " + data.likes_count);
                            console.log("dislikes: " + data.dislikes_count);

                            like.find("[data-count='like']").text(data.likes_count);
                            dislike.find("[data-count='dislike']").text(data.dislikes_count);
                        }
                    },
                    error: function (error) {
                        var err = error.responseJSON.message;
                        alert(err);
                        location.reload();
                    }
                });
            }

            function dislike(e, id){
                var dislike = $(e).parent().parent();
                var like = dislike.prev();
                $.post({
                    url: '/comment/' + id + '/dislike',
                    headers: {
                        'Content-Type': 'application/json',
                        'X-CSRF-TOKEN': '${_csrf.token}'
                    },
                    success: function (data, status) {
                        if (status === 'success') {
                            if(data.result == true) {
                                $(e).parent().removeClass("default");
                                like.find("span.like").removeClass("liked");
                                like.find("span.like").addClass("default");
                                $(e).parent().addClass("disliked");
                                console.log("Comment " + id + " was disliked");
                            }
                            else {
                                $(e).parent().removeClass("disliked");
                                $(e).parent().addClass("default");
                                console.log("Dislike was removed from comment " + id);
                            }
                            console.log("likes: " + data.likes_count);
                            console.log("dislikes: " + data.dislikes_count);

                            like.find("[data-count='like']").text(data.likes_count);
                            dislike.find("[data-count='dislike']").text(data.dislikes_count);
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

    <#if cinema_seances??>
    <script>
        <#assign center = cinema_seances?keys[0]>

        //Map start init
        var mapOptions = {
            scaleControl: true,
            center: new google.maps.LatLng(${center.latitude?c}, ${center.longitude?c}),
            zoom: 12,
            navigationControl: false,
            streetViewControl: false,
            mapTypeControl: false,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        var map = new google.maps.Map(document.getElementById('cimenas-map'),mapOptions);

        <#list cinema_seances?keys as cinema>
            var marker${cinema?index} = new google.maps.Marker({
                map: map,
                position: new google.maps.LatLng(${cinema.latitude?c}, ${cinema.longitude?c})
            });

            var boxText${cinema?index} = document.createElement("div");
            boxText${cinema?index}.innerHTML = '<span class="pop_up_box_text">${cinema.name}</span>';

            //Sets up the configuration options of the pop-up info box.
            var infoboxOptions${cinema?index} = {
                content: boxText${cinema?index}
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
            var infobox${cinema?index} = new InfoBox(infoboxOptions${cinema?index});


            //Add an 'event listener' to the Glastonbury map marker to listen out for when it is clicked.
            google.maps.event.addListener(marker${cinema?index}, "click", function (e) {
                //Open the Glastonbury info box.
                infobox${cinema?index}.open(map, this);
                //Sets the Glastonbury marker to be the center of the map.
                map.setCenter(marker${cinema?index}.getPosition());
            });
        </#list>
    </script>
    </#if>

</@c.page>
<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">

<@c.page>
    <#include "../../parts/search.ftlh">

    <section class="container">
        <div class="col-sm-12">
            <div class="row">
                <div class="col-sm-8 col-md-9">
                    <h2 class="page-heading">
                        <a class="user-span" href="/user/${userId}">${username}</a> > <span class="user-list">Comments</span>
                    </h2>

                    <div class="tags-area" style="margin-bottom: 20px">
                        <div class="tags tags--unmarked">
                            <span class="tags__label">Sorted by:</span>
                            <ul>
                                <li class="item-wrap">
                                    <a href="?sort=date-desc" class="tags__item item-active <#if sort != "date-asc">item-active</#if>" data-filter='date'>date desc</a>
                                </li>
                                <li class="item-wrap">
                                    <a href="?sort=date-asc" class="tags__item <#if sort == "date-asc">item-active</#if>" data-filter='date-asc'>date asc</a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="rates-wrapper">
                        <div class="comment-sets">
                            <#list page.content as comment>
                                <div class="comment">
                                    <div class="comment__images">
                                        <img alt='' src="${comment.user.imgUrl}">
                                    </div>

                                    <a href='/user/${comment.user.id}' class="comment__author">${comment.user.fullName()}</a><br>
                                    <a href='/item/${comment.movie.id}' class="comment__item">${comment.movie.title}</a>

                                    <p class="comment__date">${comment.createdAt?string["dd.MM.yyyy"]} | ${comment.createdAt?string["HH:mm"]}</p>
                                    <p class="comment__message">${comment.text}</p>
                                    <#if name != "unknown" && currentUserId == comment.user.id>
                                        <form action="/comment/${comment.id}/delete" method="post">
                                            <input type="hidden" value="${_csrf.token}" name="_csrf">
                                            <button type="submit" class="comment__delete" style="right: 0"></button>
                                        </form>
                                    </#if>
                                </div>
                            </#list>
                        </div>
                    </div>

                    <#if page.hasContent()>
                        <div class="pagination paginatioon--full coloum-wrapper">
                            <#if page.hasPrevious()>
                                <a href='${url}?page=${page.getNumber()}<#if sort?has_content>&sort=${sort}</#if>' class="pagination__prev">prev</a>
                            </#if>

                            <#if page.hasNext()>
                                <a href='${url}?page=${page.getNumber() + 2}<#if sort?has_content>&sort=${sort}</#if>' class="pagination__next">next</a>
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
        });
    </script>
</@c.page>
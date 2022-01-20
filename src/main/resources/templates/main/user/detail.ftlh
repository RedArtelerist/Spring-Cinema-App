<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">

<@c.page>
    <#include "../../parts/search.ftlh">

    <section class="container">
        <div class="section about-section gray-bg" id="about">
            <div class="row" style="margin: 0 10px">
                <div class="col-lg-4">
                    <div class="about-avatar">
                        <img src="${owner.imgUrl}" title="" alt="">
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="about-text go-to">
                        <h3 class="dark-color">${owner.username}</h3>
                        <div class="row about-list">
                            <div class="col-md-6">
                                <div class="media">
                                    <label>Full Name</label>
                                    <p>${owner.fullName()}</p>
                                </div>
                                <div class="media">
                                    <label>E-mail</label>
                                    <p>${owner.email}</p>
                                </div>
                                <div class="media">
                                    <label>Birthday</label>
                                    <p><#if owner.birthDay??>${owner.birthDay?string["dd.MM.yyyy"]}, ${owner.getAge()} y.o<#else>-</#if></p>
                                </div>
                                <div class="media">
                                    <label>Registered</label>
                                    <p>${owner.createdAt?string["dd.MM.yyyy"]}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <#if name != "unknown">
                    <div class="col-lg-2">
                        <#if currentUserId == owner.id>
                            <a href="/profile" class="btn btn-md btn--default">
                                <i class="fas fa-user-edit"></i>
                            </a>
                        <#else>
                            <#if isSubscriber>
                                <a href="/unsubscribe/${owner.id}" class="btn btn-md btn--default">
                                    Unsubscribe
                                </a>
                            <#else>
                                <a href="/subscribe/${owner.id}" class="btn btn-md btn--default">
                                    Subscribe
                                </a>
                            </#if>
                        </#if>
                    </div>
                </#if>
            </div>
            <div class="counter">
                <div class="row">
                    <div class="col-2 col-lg-2">
                        <div class="count-data text-center">
                            <h6 class="count h2" data-to="500" data-speed="500">${owner.ratings?size}</h6>
                            <a href="/user/${owner.id}/scores" class="m-0px font-w-600">Scores</a>
                        </div>
                    </div>

                    <div class="col-2 col-lg-2">
                        <div class="count-data text-center">
                            <h6 class="count h2" data-to="500" data-speed="500">${owner.watchList?size}</h6>
                            <a href="/user/${owner.id}/watchlist" class="m-0px font-w-600">Watchlist</a>
                        </div>
                    </div>
                    <div class="col-2 col-lg-2">
                        <div class="count-data text-center">
                            <h6 class="count h2" data-to="500" data-speed="500">${owner.favourites?size}</h6>
                            <a href="/user/${owner.id}/favourites" class="m-0px font-w-600">Favourites</a>
                        </div>
                    </div>
                    <div class="col-2 col-lg-2">
                        <div class="count-data text-center">
                            <h6 class="count h2" data-to="500" data-speed="500">${owner.comments?size}</h6>
                            <a href="/user/${owner.id}/comments" class="m-0px font-w-600">Comments</a>
                        </div>
                    </div>
                    <div class="col-2 col-lg-2">
                        <div class="count-data text-center">
                            <h6 class="count h2" data-to="500" data-speed="500">${owner.subscriptions?size}</h6>
                            <a href="/user/${owner.id}/subscriptions" class="m-0px font-w-600">Subscriptions</a>
                        </div>
                    </div>
                    <div class="col-2 col-lg-2">
                        <div class="count-data text-center">
                            <h6 class="count h2" data-to="500" data-speed="500">${owner.subscribers?size}</h6>
                            <a href="/user/${owner.id}/subscribers" class="m-0px font-w-600">Subscribers</a>
                        </div>
                    </div>
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
        });
    </script>
</@c.page>
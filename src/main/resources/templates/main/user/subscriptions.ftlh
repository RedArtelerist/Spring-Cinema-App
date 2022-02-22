<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">

<@c.page>
    <#include "../../parts/search.ftlh">

    <section class="container">
        <div class="col-sm-12">
            <div class="row">
                <div class="col-sm-8 col-md-9">
                    <h2 class="page-heading">
                        <a class="user-span" href="/user/${userChannel.id}">${userChannel.username}</a> > <span class="user-list">${title}</span>
                    </h2>
                    <div class="row user-list">
                        <div class="col-md-10">
                            <div class="people-nearby">
                                <#list users as us>
                                    <div class="nearby-user">
                                        <div class="row">
                                            <div class="col-md-2 col-sm-2">
                                                <img src="${us.imgUrl}" alt="user" class="profile-photo-lg">
                                            </div>
                                            <div class="col-md-7 col-sm-7">
                                                <h5><a href="/user/${us.id}" class="profile-link">${us.username}</a></h5>
                                                <p>${us.fullName()}</p>
                                            </div>
                                            <#if name != "unknown" && currentUserId == userChannel.id>
                                                <#if title == "subscriptions">
                                                    <div class="col-md-3 col-sm-3">
                                                        <a href="/unsubscribe/${us.id}" class="btn btn-md btn--default">
                                                            Unsubscribe
                                                        </a>
                                                    </div>
                                                <#else>
                                                    <#if userChannel.isSubscribed(us)>
                                                        <div class="col-md-3 col-sm-3">
                                                            <a href="/unsubscribe/${us.id}" class="btn btn-md btn--default">
                                                                Unsubscribe
                                                            </a>
                                                        </div>
                                                    <#else>
                                                        <div class="col-md-3 col-sm-3">
                                                            <a href="/subscribe/${us.id}" class="btn btn-md btn--default">
                                                                Subscribe
                                                            </a>
                                                        </div>
                                                    </#if>
                                                </#if>
                                            </#if>
                                        </div>
                                    </div>
                                </#list>
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

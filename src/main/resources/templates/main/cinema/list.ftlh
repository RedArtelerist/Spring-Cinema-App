<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">


<@c.page>
    <#include "../../parts/search.ftlh">

    <!-- Main content -->
    <section class="container">

        <div class="col-sm-12">
            <h2 class="page-heading">cinemas</h2>

            <div class="tags-area tags-area--thin">
                <form id='select' class="select">
                    <select name="city" id="select-sort" class="select__sort" tabindex="0">
                        <#list cities as item>
                            <option value="${item}" <#if city == item>selected</#if>>${item}</option>
                        </#list>
                    </select>
                    <input type="hidden" name="sort" value="${sort}">
                </form>

                <div class="tags tags--unmarked tags--aside">
                    <span class="tags__label">Sorted by:</span>
                    <ul>
                        <li class="item-wrap">
                            <a href="#" class="tags__item <#if sort != 'rating'>item-active</#if>" data-filter='name'>name</a>
                        </li>
                        <li class="item-wrap">
                            <a href="#" class="tags__item <#if sort == 'rating'>item-active</#if>" data-filter='rating'>rating</a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="cinema-wrap">
                <div class="row">
                    <#list cinemas as cinema>
                        <div class="col-xs-6 col-sm-3 cinema-item">
                            <div class="cinema">
                                <a href='/cinema/${cinema.id}' class="cinema__images">
                                    <img alt='' src="${cinema.imageUrl}">
                                    <span class="cinema-rating">${cinema.rating}</span>
                                </a>
                                <a href="/cinema/${cinema.id}" class="cinema-title">${cinema.name}</a>
                            </div>
                        </div>
                    </#list>
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
            init_CinemaList();
        });
    </script>
</@c.page>
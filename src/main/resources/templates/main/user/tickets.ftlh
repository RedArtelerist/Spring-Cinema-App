<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">

<@c.page>
    <link href='http://fonts.googleapis.com/css?family=PT+Mono' rel='stylesheet' type='text/css'>
    <#include "../../parts/search.ftlh">

    <section class="container">
        <h2 class="page-heading">
            <a class="user-span" href="/user/${currentUserId}">User page</a> > <span class="user-list">My tickets</span>
        </h2>
        <hr>
        <div class="row">
            <!-- edit form column -->
            <div class="col-sm-12 col-md-12">
                <div class="rates-wrapper">
                    <table>
                        <colgroup class="col-width-sm">
                        <colgroup class="col-width">
                        <colgroup class="col-width" style="width: 12%">
                        <colgroup class="col-width-sm">
                        <colgroup class="col-width-sm">
                        <colgroup class="col-width-sm">
                        <colgroup style="width: 3%">
                        <colgroup style="width: 3%">

                        <#if page.hasContent()>
                            <tr class="rates rates--top">
                                <th>Number</th>
                                <th>Movie</th>
                                <th>Cinema</th>
                                <th>Date</th>
                                <th>Price</th>
                                <th>Booked date</th>
                                <th></th>
                                <th></th>
                            </tr>

                            <#list page.content as ticket>
                                <tr class="rates">
                                    <td class="rates__vote">${ticket.number}</td>

                                    <td class="rates__obj">
                                        <a href="/item/${ticket.movie.id}" class="rates__obj-name" style="padding: 0">${ticket.movie.title} (${ticket.movie.year?c})</a>
                                    </td>
                                    <td class="rates__obj">
                                        <a href="/cinema/${ticket.hall.cinema.id}" class="rates__obj-name" style="padding: 0">${ticket.hall.cinema.name}</a>
                                    </td>
                                    <td class="rates__vote">${ticket.date?string["dd.MM.yyyy HH:mm"]}</td>
                                    <td class="rates__vote">₴${ticket.price?c}</td>
                                    <td class="rates__vote">${ticket.createdAt?string["dd.MM.yyyy HH:mm"]}</td>
                                    <td class="item_delete">
                                        <a href="/ticket/${ticket.number}"><i class="fas fa-eye"></i></a>
                                    </td>
                                    <#assign dateToday = .now?long />
                                    <#assign dateNow = dateToday + (60 * 60 * 1000) />
                                    <td class="item_delete">
                                        <#if ticket.date gte dateNow?number_to_datetime>
                                            <form action="/ticket/${ticket.number}/delete" method="post">
                                                <input type="hidden" value="${_csrf.token}" name="_csrf">
                                                <a onclick="$(this).parent().submit();"><i class="fas fa-trash-alt"></i></a>
                                            </form>
                                        </#if>
                                    </td>
                                </tr>
                            </#list>
                        <#else>
                            <h1 class="position-center text-center">No Tickets</h1>
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
    </section>

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
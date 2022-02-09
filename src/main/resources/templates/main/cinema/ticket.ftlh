<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">


<@c.page>
    <link href='http://fonts.googleapis.com/css?family=PT+Mono' rel='stylesheet' type='text/css'>

    <#include "../../parts/search.ftlh">

    <!-- Main content -->

    <section class="container">
        <div class="order-container">
            <div class="order">
                <img class="order__images" alt='' src="/static/main/images/tickets.png">
                <#if title?? && title == "myTicket">
                    <p class="order__title"></p>
                    <a href="/tickets" class="btn btn-md btn--warning">view all tickets</a>
                <#else>
                    <p class="order__title">Thank you <br><span class="order__descript">you have successfully purchased tickets</span></p>
                    <a href="/cinema/${ticket.hall.cinema.id}" class="btn btn-md btn--warning">return to cinema</a>
                </#if>

            </div>

            <div class="ticket">
                <div class="ticket-position">
                    <div class="ticket__indecator indecator--pre"><div class="indecator-text pre--text">online ticket</div> </div>
                    <div class="ticket__inner">

                        <div class="ticket-secondary">
                            <span class="ticket__item">Ticket number <strong class="ticket__number">${ticket.number}</strong></span>
                            <span class="ticket__item ticket__date">${ticket.date?string["dd/MM/yyyy"]}</span>
                            <span class="ticket__item ticket__time">${ticket.date?string["HH:mm"]}</span>
                            <span class="ticket__item">Cinema: <span class="ticket__cinema">${ticket.hall.cinema.name}</span></span>
                            <span class="ticket__item">Hall: <span class="ticket__hall">${ticket.hall.name}</span></span>
                            <span class="ticket__item ticket__price">price: <strong class="ticket__cost">₴${ticket.price?c}</strong></span>
                        </div>

                        <div class="ticket-primery">
                            <span class="ticket__item ticket__item--primery ticket__film">Film<br><strong class="ticket__movie">${ticket.movie.title}</strong></span>
                            <span class="ticket__item ticket__item--primery">Sits: <span class="ticket__place">${ticket.seats}</span></span>
                        </div>


                    </div>
                    <div class="ticket__indecator indecator--post"><div class="indecator-text post--text">online ticket</div></div>
                </div>
            </div>

            <div class="ticket-control">
                <a href="#" class="watchlist list--download">Download</a>
                <a href="#" class="watchlist list--print">Print</a>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.1.62/jquery.inputmask.bundle.js"></script>

    <!-- Custom -->
    <script src="/static/main/js/custom.js"></script>
    <script src="/static/main/js/form.js"></script>

    <script>
        $(document).ready(function() {
            init_Home();
        });
    </script>
</@c.page>
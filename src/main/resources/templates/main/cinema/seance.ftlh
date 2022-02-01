<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">


<@c.page>
    <#include "../../parts/search.ftlh">

    <!-- Main content -->
    <div class="place-form-area">
        <section class="container">
            <div class="order-container">
                <div class="order">
                    <img class="order__images" alt='' src="/static/main/images/tickets.png">
                    <p class="order__title">${seance.movie.title} <br>
                        <span class="order__descript">
                            ${hall.name}, ${hall.cinema.name}, <#list seance.technologies as tech>${tech.getLabel()} </#list><br> ${seance.date?string["dd.MM.yyyy"]} ${seance.startTime?string["HH:mm"]}-${seance.endTime?string["HH:mm"]}
                        </span>
                    </p>

                </div>
            </div>
            <div class="order-step-area">
                <div class="order-step first--step order-step--disable ">1. What &amp; Where &amp; When</div>
                <div class="order-step second--step">2. Choose a sit</div>
            </div>

            <div class="choose-sits">
                <div class="choose-sits__info choose-sits__info--first" style="margin-bottom: 20px">
                    <ul>
                        <li class="sits-price marker--none"><strong>Price</strong></li>
                        <li class="sits-price sits-price--cheap">₴${seance.price}</li>
                        <li class="sits-price sits-price--middle">₴${seance.price * 1.5}</li>
                        <li class="sits-price sits-price--expensive">₴${seance.price * 2}</li>
                    </ul>
                </div>

                <div class="choose-sits__info" style="margin-bottom: 100px">
                    <ul>
                        <li class="sits-state sits-state--not">Not available</li>
                        <li class="sits-state sits-state--your">Your choice</li>
                    </ul>
                </div>

                <div>
                    <div class="sits-area">
                        <div class="sits-anchor">screen</div>

                        <div class="sits">
                            <aside class="sits__line">
                                <#list rows as row>
                                    <span class="sits__indecator">${row.name}</span>
                                </#list>
                            </aside>

                            <#list rows as row>
                                <div class="sits__row">
                                    <#list row.seats as seat>
                                        <span class="sits__place <#if seance.seatReserved(seat)>sits-state--not<#else><#if seat.type == 'Standard'>sits-price--cheap<#elseif seat.type == 'Vip'>sits-price--middle<#else>sits-price--expensive</#if></#if>"
                                              data-id="${seat.id?c}" data-place='${row.name}${seat.number}' data-price="<#if seat.type == 'Standard'>${seance.price}<#elseif seat.type == 'Vip'>${seance.price * 1.5}<#else>${seance.price * 2}</#if>">
                                            ${row.name}${seat.number}
                                        </span>
                                    </#list>
                                </div>
                            </#list>

                            <aside style="height: 100%" class="sits__checked">
                                <div class="checked-place">

                                </div>
                                <div class="checked-result">
                                    ₴0
                                </div>
                            </aside>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <div class="clearfix"></div>

    <form id='film-and-time' class="booking-form">
        <input type='text' name='choosen-sits' class="choosen-sits">


        <div class="booking-pagination booking-pagination--margin">
            <a href="/cinema/${seance.hall.cinema.id}" class="booking-pagination__prev">
                <span class="arrow__text arrow--prev">prev step</span>
                <span class="arrow__info">what&amp;where&amp;when</span>
            </a>
            <a href="#" class="booking-pagination__next" onclick="submitForm(this)">
                <span class="arrow__text arrow--next">next step</span>
                <span class="arrow__info">checkout</span>
            </a>
        </div>
    </form>

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
            init_BookingTwo();
        });

        function submitForm(e){
            $(".booking-form").submit();
        }

        $('.booking-form').submit(function (e) {
            e.preventDefault();
            var seats = $(this).find("input").val().split(',').map(function(item) {
                return parseInt(item, 10);
            });

            console.log(seats);

            if(seats.length == 0)
                return;

            for(var i = 0; i < seats.length; i++){
                if(isNaN(seats[i]))
                    return;
            }

            $.post({
                url: '/seance/' + ${seance.id} +'/reserve',
                data: JSON.stringify(seats),
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': '${_csrf.token}'
                },
                success: function(data, status){
                    console.log(data);
                    console.log(status);
                    if(status=='success'){
                        alert("Reservation:" + data);
                        //location.reload();
                        window.location.replace('/reservation/' + data);
                    }
                },
                error: function(error) {
                    var err = error.responseJSON.message;
                    alert(err);
                    location.reload();
                }
            })
        });
    </script>
</@c.page>
<#import "../../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">
<#setting locale="en_US">


<@c.page>
    <#include "../../parts/search.ftlh">

    <!-- Main content -->
    <section class="container">
        <div class="order-container">
            <div class="order">
                <img class="order__images" alt='' src="/static/main/images/tickets.png">
                <p class="order__title">Book a ticket <br><span class="order__descript">and have fun movie time</span></p>
            </div>
        </div>
        <div class="order-step-area">
            <div class="order-step first--step order-step--disable ">1. What &amp; Where &amp; When</div>
            <div class="order-step second--step order-step--disable">2. Choose a sit</div>
            <div class="order-step third--step">3. Check out</div>
        </div>

        <p id="timer" style="font-size: 40px; position: absolute; right: 30px; top: 30%"></p>


        <div class="col-sm-12">
            <div class="checkout-wrapper">

                <h2 class="page-heading">Order information</h2>
                <ul class="book-result">
                    <li class="book-result__item">Movie: <span class="book-result__count booking-ticket">${reservation.seance.movie.title}</span></li>
                    <br><li class="book-result__item">Date: <span class="book-result__count booking-price" style="margin-left: 8px">${reservation.seance.date?string["dd.MM.yyyy"]}, ${reservation.seance.startTime?string["HH:mm"]}</span></li>
                    <br><li class="book-result__item">Cinema: <span class="book-result__count booking-ticket" style="margin-left: -9px">${reservation.seance.hall.cinema.name}</span></li>
                    <li class="book-result__item">Hall: <span class="book-result__count booking-ticket">${reservation.seance.hall.name}</span></li>

                </ul>

                <h2 class="page-heading">price</h2>
                <ul class="book-result">
                    <li class="book-result__item">Tickets: <span class="book-result__count booking-ticket" style="margin-left: -12px">${reservation.seats?size}</span></li>
                    <#if standardCount gt 0>
                        <br>
                        <li class="book-result__item" style="margin-left: 50px">Standard: <span class="book-result__count booking-price">${standardCount}</span></li>
                        <li class="book-result__item">One item price: <span class="book-result__count booking-price">₴${standardPrice}</span></li>
                    </#if>
                    <#if vipCount gt 0>
                        <br>
                        <li class="book-result__item" style="margin-left: 50px">Vip: <span class="book-result__count booking-price" style="margin-left: 33px">${vipCount}</span></li>
                        <li class="book-result__item">One item price: <span class="book-result__count booking-price">₴${vipPrice}</span></li>
                    </#if>
                    <#if premiumCount gt 0>
                        <br>
                        <li class="book-result__item" style="margin-left: 50px">Premium: <span class="book-result__count booking-price">${premiumCount}</span></li>
                        <li class="book-result__item">One item price: <span class="book-result__count booking-price">₴${premiumPrice}</span></li>
                    </#if>
                    <br><li class="book-result__item">Total: <span class="book-result__count booking-cost" style="margin-left: -12px">₴${reservation.totalPrice()?c}</span></li>
                </ul>

                <h2 class="page-heading">Contact information</h2>

                <form id='contact-info' method='post' novalidate="" class="form contact-info">
                    <div class="contact-info__field contact-info__field-mail">
                        <input type='email' name='email' placeholder='Your email' class="form__mail"
                               <#if name != "unknown">value="${user.email}" </#if>>
                    </div>
                    <div class="contact-info__field contact-info__field-tel">
                        <input id="phone" type='tel' name='phone' placeholder='Phone number' class="form__mail">
                    </div>
                    <div class="contact-info__field contact-info__field-name">
                        <input type='text' name='firstName' placeholder='First name' class="form__mail"
                               <#if name != "unknown">value="${user.firstName}" </#if>>
                    </div>
                    <div class="contact-info__field contact-info__field-name">
                        <input type='text' name='lastName' placeholder='Last name' class="form__mail"
                               <#if name != "unknown">value="${user.lastName}" </#if>>
                    </div>
                </form>
            </div>

            <div class="order">
                <button onclick="$('#contact-info').submit();" class="btn btn-md btn--warning btn--wide">purchase</button>
            </div>
        </div>

    </section>


    <div class="clearfix"></div>

    <div class="booking-pagination">
        <button onclick="cancelReservation()" class="booking-pagination__prev">
            <p class="arrow__text arrow--prev">prev step</p>
            <span class="arrow__info">choose a sit</span>
        </button>
    </div>

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

    <script type="text/javascript">
        $(document).ready(function() {
            init_Home();

            var phones = [{ "mask": "+38(###) ###-##-##"}];
            $('#phone').inputmask({
                mask: phones,
                greedy: false,
                definitions: { '#': { validator: "[0-9]", cardinality: 1}}
            });
        });

        function cancelReservation(){
            $.post({
                url: '/reservation/' + ${reservation.id} +'/cancel',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': '${_csrf.token}'
                },
                success: function(data, status){
                    console.log(data);
                    console.log(status);
                    if(status=='success'){
                        window.location.replace('/seance/' + data);
                    }
                },
                error: function(error) {
                    var err = error.responseJSON.message;
                    location.reload();
                }
            })
        }
    </script>

    <script>
        var datetime = '${reservation.expired?string['MMM dd, yyyy HH:mm:ss']}';
        var countDownDate = new Date(datetime).getTime();

        // Update the count down every 1 second
        var x = setInterval(function() {
            // Get today's date and time
            var now = new Date();

            // Find the distance between now and the count down date
            var distance = countDownDate - now;

            // Time calculations for days, hours, minutes and seconds
            var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((distance % (1000 * 60)) / 1000);

            // Output the result in an element with id="demo"
            document.getElementById("timer").innerHTML = minutes + ":" + seconds;

            // If the count down is over, write some text
            if (distance < 0) {
                clearInterval(x);
                document.getElementById("timer").innerHTML = "EXPIRED";
                cancelReservation();
            }
        }, 1000);
    </script>
</@c.page>
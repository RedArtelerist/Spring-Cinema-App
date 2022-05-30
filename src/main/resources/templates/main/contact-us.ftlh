<#import "../parts/common.ftlh" as c>


<@c.page>
    <#include "../parts/search.ftlh">

    <!-- Main content -->
    <section class="container">
        <h2 class="page-heading heading--outcontainer">Contact</h2>
        <div class="contact">
            <p class="contact__title">You have any questions or need help, <br><span class="contact__describe">don’t be shy and contact us</span></p>
            <span class="contact__mail">support@amovie.com</span>
            <span class="contact__tel">support@amovie.com</span>
        </div>
    </section>

    <div class="contact-form-wrapper">
        <div class="container">
            <div class="col-sm-12 col-md-10 col-md-offset-1 col-lg-8 col-lg-offset-2">
                <form id='contact-form' class="form row" method='post' novalidate="">
                    <p class="form__title">Drop us a line</p>
                    <div class="col-sm-6">
                        <input type='text' placeholder='Your name' name='name' class="form__name">
                    </div>
                    <div class="col-sm-6">
                        <input type='email' placeholder='Your email' name='email' class="form__mail">
                    </div>
                    <div class="col-sm-12">
                        <textarea placeholder="Your message" name="text" class="form__message"></textarea>
                    </div>
                    <button type="submit" class='btn btn-md btn--danger'>send message</button>
                </form>
            </div>
        </div>
    </div>

    <section class="container">
        <div class="contact">
            <p class="contact__title">Trying to find our location? <br> <span class="contact__describe">we are here</span></p>
        </div>
    </section>

    <div id='location-map' class="map"></div>

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
    <script src="/static/main/js/form.js"></script>
    <script src="https://maps.google.com/maps/api/js?key=AIzaSyDmTU3PdXiLiXqNDbHDOeEfCU4iq7UShDE&language=en"></script>

    <!-- Custom -->
    <script src="/static/main/js/custom.js"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            init_Home();
            init_Contact();
        });

        $('#contact-form').submit(function(e) {
            e.preventDefault();
            var error = 0;
            var self = $(this);

            var $name = self.find('[name=name]');
            var $email = self.find('[type=email]');
            var $message = self.find('[name=text]');

            var nameRegex = /^[a-zA-Z ]{3,30}$/;
            var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;

            if(!emailRegex.test($email.val())) {
                createErrTult('Error! Wrong email!', $email)
                error++;
            }

            if(nameRegex.test($name.val()) && $name.val()!= $name.attr('placeholder')) {
                $name.removeClass('invalid_field');
            }
            else {
                createErrTult('Only letters and from 3 to 30 characters', $name)
                error++;
            }

            if($message.val().length >= 10 && $message.val().length <= 1000 && $message.val()!= $message.attr('placeholder')) {
                $message.removeClass('invalid_field');
            }
            else {
                createErrTult('Message must be between 10 and 1000 characters', $message)
                error++;
            }

            if (error!=0)
                return;

            var contactUsMessage = {
                name: $name.val(),
                email: $email.val(),
                text: $message.val()
            };

            $.post({
                url: '/contact-us',
                data: JSON.stringify(contactUsMessage),
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-TOKEN': '${_csrf.token}'
                },
                success: function (data, status) {
                    self.find('[type=submit]').attr('disabled', 'disabled');

                    self.children().fadeOut(300,function(){ $(this).remove() })
                    $('<p class="success"><span class="success-huge">Thank you!</span> <br> your message successfully sent</p>').appendTo(self)
                        .hide().delay(300).fadeIn();
                },
                error: function (error) {
                    location.reload();
                }
            });
        }); // end submit

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
    </script>
</@c.page>
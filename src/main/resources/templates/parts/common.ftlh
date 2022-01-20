<#macro page>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>CinemaMovie</title>

        <!-- Mobile Specific Metas-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="telephone=no" name="format-detection">

        <!-- Fonts -->
        <!-- Font awesome - icon font -->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.10.2/css/all.css" />

        <!-- Roboto -->
        <link href='http://fonts.googleapis.com/css?family=Roboto:400,700' rel='stylesheet' type='text/css'>
        <!-- Stylesheets -->
        <link href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" rel="stylesheet">

        <!-- Mobile menu -->
        <link href="/static/main/css/gozha-nav.css" rel="stylesheet" />
        <!-- Select -->
        <link href="/static/main/css/external/jquery.selectbox.css" rel="stylesheet" />
        <!-- Swiper slider -->
        <link href="/static/main/css/external/idangerous.swiper.css" rel="stylesheet" />
        <!-- Magnific-popup -->
        <link href="/static/main/css/external/magnific-popup.css" rel="stylesheet" />

        <!-- Custom -->
        <link href="/static/main/css/style.css?v=1" rel="stylesheet" />

        <!-- Modernizr -->
        <script src="/static/main/js/external/modernizr.custom.js"></script>

        <style>
            .turbolinks-progress-bar {
                height: 2px;
                background-color: navy;
            }
        </style>

        <script>
            document.addEventListener("DOMContentLoaded", function(event) {
                var scrollpos = sessionStorage.getItem('scrollpos');
                if (scrollpos) {window.scrollTo(0, scrollpos);
                    sessionStorage.removeItem('scrollpos');}

            });

            window.onbeforeunload = function(e) {
                localStorage.setItem('scrollpos', window.scrollY);
            };
        </script>
    </head>
    <body>

        <div class="wrapper">
            <#include "header.ftlh">

            <#nested>

            <#include "footer.ftlh">
        </div>

    </body>

    </html>
</#macro>
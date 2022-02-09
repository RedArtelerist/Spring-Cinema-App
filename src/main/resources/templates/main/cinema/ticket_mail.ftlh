<!doctype html>
<html>
<head>
    <!-- Basic Page Needs -->
    <meta charset="utf-8">
    <!-- Fonts -->
    <!-- Font awesome - icon font -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- Mono font -->
    <link href='http://fonts.googleapis.com/css?family=PT+Mono' rel='stylesheet' type='text/css'>
    <!-- Roboto -->
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700' rel='stylesheet' type='text/css'>

    <!-- Stylesheets -->
    <!-- jQuery UI -->
    <link href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css" rel="stylesheet">
    <!-- Custom -->
    <style>
        /* cyrillic-ext */
        @font-face {
            font-family: 'PT Mono';
            font-style: normal;
            font-weight: 400;
            src: url(https://fonts.gstatic.com/s/ptmono/v11/9oRONYoBnWILk-9AnCIzM-Py.woff2) format('woff2');
            unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF, U+A640-A69F, U+FE2E-FE2F;
        }
        /* cyrillic */
        @font-face {
            font-family: 'PT Mono';
            font-style: normal;
            font-weight: 400;
            src: url(https://fonts.gstatic.com/s/ptmono/v11/9oRONYoBnWILk-9AnCszM-Py.woff2) format('woff2');
            unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
        }
        /* latin-ext */
        @font-face {
            font-family: 'PT Mono';
            font-style: normal;
            font-weight: 400;
            src: url(https://fonts.gstatic.com/s/ptmono/v11/9oRONYoBnWILk-9AnCEzM-Py.woff2) format('woff2');
            unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB, U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
        }
        /* latin */
        @font-face {
            font-family: 'PT Mono';
            font-style: normal;
            font-weight: 400;
            src: url(https://fonts.gstatic.com/s/ptmono/v11/9oRONYoBnWILk-9AnC8zMw.woff2) format('woff2');
            unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
        }
        /* cyrillic-ext */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 400;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOmCnqEu92Fr1Mu72xKOzY.woff2) format('woff2');
            unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF, U+A640-A69F, U+FE2E-FE2F;
        }
        /* cyrillic */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 400;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOmCnqEu92Fr1Mu5mxKOzY.woff2) format('woff2');
            unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
        }
        /* greek-ext */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 400;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOmCnqEu92Fr1Mu7mxKOzY.woff2) format('woff2');
            unicode-range: U+1F00-1FFF;
        }
        /* greek */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 400;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOmCnqEu92Fr1Mu4WxKOzY.woff2) format('woff2');
            unicode-range: U+0370-03FF;
        }
        /* vietnamese */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 400;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOmCnqEu92Fr1Mu7WxKOzY.woff2) format('woff2');
            unicode-range: U+0102-0103, U+0110-0111, U+0128-0129, U+0168-0169, U+01A0-01A1, U+01AF-01B0, U+1EA0-1EF9, U+20AB;
        }
        /* latin-ext */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 400;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOmCnqEu92Fr1Mu7GxKOzY.woff2) format('woff2');
            unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB, U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
        }
        /* latin */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 400;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOmCnqEu92Fr1Mu4mxK.woff2) format('woff2');
            unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
        }
        /* cyrillic-ext */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 700;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOlCnqEu92Fr1MmWUlfCRc4EsA.woff2) format('woff2');
            unicode-range: U+0460-052F, U+1C80-1C88, U+20B4, U+2DE0-2DFF, U+A640-A69F, U+FE2E-FE2F;
        }
        /* cyrillic */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 700;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOlCnqEu92Fr1MmWUlfABc4EsA.woff2) format('woff2');
            unicode-range: U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
        }
        /* greek-ext */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 700;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOlCnqEu92Fr1MmWUlfCBc4EsA.woff2) format('woff2');
            unicode-range: U+1F00-1FFF;
        }
        /* greek */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 700;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOlCnqEu92Fr1MmWUlfBxc4EsA.woff2) format('woff2');
            unicode-range: U+0370-03FF;
        }
        /* vietnamese */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 700;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOlCnqEu92Fr1MmWUlfCxc4EsA.woff2) format('woff2');
            unicode-range: U+0102-0103, U+0110-0111, U+0128-0129, U+0168-0169, U+01A0-01A1, U+01AF-01B0, U+1EA0-1EF9, U+20AB;
        }
        /* latin-ext */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 700;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOlCnqEu92Fr1MmWUlfChc4EsA.woff2) format('woff2');
            unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB, U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
        }
        /* latin */
        @font-face {
            font-family: 'Roboto';
            font-style: normal;
            font-weight: 700;
            src: url(https://fonts.gstatic.com/s/roboto/v29/KFOlCnqEu92Fr1MmWUlfBBc4.woff2) format('woff2');
            unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
        }
        body {
            font-family: 'PT Mono', sans-serif;
        }
        .ticket {
            width: 1170px;
            position: relative;
            padding: 37px 0;
            text-align: center;
            background-repeat: no-repeat;
            font-family: 'PT Mono', sans-serif;
        }
        .ticket .ticket__inner {
            border: 3px solid #dbdee1;
            overflow: hidden;
            float: left;
            height: 300px;
            width: 820px;
        }
        .ticket .ticket__indecator {
            position: relative;
            border: 3px solid #dbdee1;
            width: 50px;
            float: left;
            height: 300px;
            font-family: 'PT Mono', sans-serif;
            font-size: 12px;
            color: #dbdee1;
        }
        .ticket .indecator-text {
            position: absolute;
            width: 100px;
        }
        .ticket .indecator-text:before {
            content: '';
            background-repeat: no-repeat;
            width: 80px;
            height: 16px;
            position: absolute;
            top: 0px;
            left: -95px;
        }
        .ticket .indecator-text:after {
            content: '';
            background-repeat: no-repeat;
            width: 80px;
            height: 16px;
            position: absolute;
            top: 0px;
            right: -95px;
        }
        .ticket .indecator--pre {
            margin-right: -3px;
        }
        .ticket .indecator--post {
            margin-left: -3px;
        }
        .ticket .pre--text {
            -webkit-transform: rotate(90deg) translateZ(0);
            -moz-transform: rotate(90deg) translateZ(0);
            -o-transform: rotate(90deg) translateZ(0);
            -ms-transform: rotate(90deg) translateZ(0);
            transform: rotate(90deg) translateZ(0);
            margin-top: 137px;
            left: -26px;
        }
        .ticket .post--text {
            -webkit-transform: rotate(-90deg) translateZ(0);
            -moz-transform: rotate(-90deg) translateZ(0);
            -o-transform: rotate(-90deg) translateZ(0);
            -ms-transform: rotate(-90deg) translateZ(0);
            transform: rotate(-90deg) translateZ(0);
            margin-top: 137px;
            left: -29px;
        }
        .ticket .ticket__place {
            color: #fe505a;
        }
        .ticket .ticket__item {
            display: block;
            margin-bottom: 10px;
            font-family: 'PT Mono', sans-serif;
            font-size: 14px;
            text-transform: uppercase;
            text-align: left;
        }
        .ticket .ticket__item--primery {
            font-size: 20px;
            font-family: 'PT Mono', sans-serif;
        }
        .ticket .ticket__date,
        .ticket .ticket__time {
            display: inline-block;
            margin-right: 30px;
            margin-top: 30px;
            font-family: 'PT Mono', sans-serif;
        }
        .ticket .ticket__price {
            margin-top: 40px;
            font-family: 'PT Mono', sans-serif;
        }
        .ticket .ticket__film {
            border-bottom: 1px solid #dbdee1;
            padding-bottom: 44px;
            margin-bottom: 28px;
            font-family: 'PT Mono', sans-serif;
        }
        .ticket .ticket__movie {
            text-transform: none;
        }
        .ticket-primery {
            overflow: hidden;
            border-left: 3px double #dbdee1;
            margin-top: 37px;
            padding: 27px 35px 22px 30px;
            font-family: 'PT Mono', sans-serif;
        }
        .ticket-secondary {
            float: left;
            text-align: left;
            padding: 47px 80px 30px 60px;
            font-family: 'PT Mono', sans-serif;
        }
        .ticket-position {
            display: inline-block;
            overflow: hidden;
        }
        .order-container {
            margin-top: 48px;
            margin-bottom: 78px;
        }
        .order {
            text-align: center;
        }
        .order .order__images {
            width: 76px;
        }
        .order .order__title {
            font: 30px 'aleobold', sans-serif;
            text-transform: uppercase;
            line-height: 26px;
            margin-top: 5px;
        }
        .order .order__descript {
            font-size: 16px;
            text-transform: none;
            font-weight: normal;
            font-family: 'aleoitalic', sans-serif;
        }
        .btn {
            display: inline-block;
            margin-bottom: 0;
            font-weight: normal;
            text-align: center;
            vertical-align: middle;
            touch-action: manipulation;
            cursor: pointer;
            background-image: none;
            border: 1px solid transparent;
            white-space: nowrap;
            padding: 6px 12px;
            font-size: 14px;
            line-height: 1.42857143;
            border-radius: 4px;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }
        .btn:focus,
        .btn:active:focus,
        .btn.active:focus,
        .btn.focus,
        .btn:active.focus,
        .btn.active.focus {
            outline: 5px auto -webkit-focus-ring-color;
            outline-offset: -2px;
        }
        .btn:hover,
        .btn:focus,
        .btn.focus {
            color: #333333;
            text-decoration: none;
        }
        .btn-md {
            color: #ffffff;
            padding: 11px 17px;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
            -webkit-box-shadow: 0 0 10px rgba(0, 0, 0, 0.16), inset 0 2px rgba(255, 255, 255, 0.2);
            -moz-box-shadow: 0 0 10px rgba(0, 0, 0, 0.16), inset 0 2px rgba(255, 255, 255, 0.2);
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.16), inset 0 2px rgba(255, 255, 255, 0.2);
            font: 12px 'aleobold', sans-serif;
            text-transform: uppercase;
            -webkit-transition: 0.3s;
            -o-transition: 0.3s;
            transition: 0.3s;
        }
        .btn-md:hover {
            color: #ffffff;
        }
        .btn--warning {
            color: #4c4145;
            background-color: #ffd564;
            border: solid 1px #ffc936;
        }
        .btn--warning:hover {
            color: #4c4145;
            background-color: #ffe08d;
            border-color: transparent;
        }
        a{
            text-decoration: none;
        }
    </style>
</head>

<body>
<div class="wrapper place-wrapper">
    <section class="container">
        <div class="order-container">
            <div class="order">
                <img class="order__images" alt='' src="https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/cinemas%2Ficons%2Ftickets.png?alt=media">
                <p class="order__title">Thank you <br><span class="order__descript">you have successfully booked tickets, ${ticket.firstName} ${ticket.lastName}</span></p>
                <a href="${url}" class="btn btn-md btn--warning">view our site</a>
            </div>

            <div class="ticket">
                <div class="ticket-position">
                    <div class="ticket__indecator indecator--pre"><div class="indecator-text pre--text"></div> </div>
                    <div class="ticket__inner">

                        <div class="ticket-secondary">
                            <span class="ticket__item">Ticket number <strong class="ticket__number">${ticket.number}</strong></span>
                            <span class="ticket__item ticket__date">${ticket.date?string["dd/MM/yyyy"]}</span>
                            <span class="ticket__item ticket__time">${ticket.date?string["HH:mm"]}</span>
                            <span class="ticket__item">Cinema: <span class="ticket__cinema">${ticket.hall.cinema.name}</span></span>
                            <span class="ticket__item">Hall: <span class="ticket__hall">${ticket.hall.name}</span></span>
                            <span class="ticket__item ticket__price">price: <strong class="ticket__cost">&#8372;${ticket.price?c}</strong></span>
                        </div>

                        <div class="ticket-primery">
                            <span class="ticket__item ticket__item--primery ticket__film">Film<br><strong class="ticket__movie">${ticket.movie.title}</strong></span>
                            <span class="ticket__item ticket__item--primery">Sits: <span class="ticket__place">${ticket.seats}</span></span>
                        </div>


                    </div>
                    <div class="ticket__indecator indecator--post"><div class="indecator-text post--text"></div></div>
                </div>
            </div>
        </div>
    </section>
</div>


</body>
</html>

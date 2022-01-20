<#import "parts/common.ftlh" as c>

<@c.page>
    <#include "parts/search.ftlh">

    <!-- Main content -->
    <form id="login-form" action="/login" class="login" method='post' novalidate=''>
        <p class="login__title">sign in <br><span class="login-edition">welcome to A.Movie</span></p>

        <div class="social social--colored">
            <a href='#' class="social__variant fa fa-facebook"></a>
            <a href='#' class="social__variant fa fa-twitter"></a>
            <a href='#' class="social__variant fa fa-tumblr"></a>
        </div>

        <p class="login__tracker">or</p>

        <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION?? && RequestParameters.error??>
            <div class="field-wrap">
                <div class="alert alert-danger">
                    <span class="icon-warning"></span>
                    ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
                    <a class="close" data-dismiss="alert" aria-hidden="true"></a>
                </div>
            </div>
        </#if>
        <#if message??>
            <div class="field-wrap">
                <div class="alert alert-${messageType}">
                    <span class="icon-warning"></span>
                    ${message}
                    <a class="close" data-dismiss="alert" aria-hidden="true"></a>
                </div>
            </div>
        </#if>

        <div class="field-wrap">
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <input type='text' placeholder='Username' name='username' class="login__input">
            <input type='password' placeholder='Password' name='password' class="login__input">
        </div>

        <div class="login__control">
            <button type='submit' class="btn btn-md btn--warning btn--wider">sign in</button>
            <a href="/forgot-password" class="login__tracker form__tracker">Forgot password?</a>
        </div>
    </form>

    <div class="clearfix"></div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="/static/main/js/external/jquery-3.1.1.min.js"><\/script>')</script>
    <!-- Migrate -->
    <script src="/static/main/js/external/jquery-migrate-1.2.1.min.js"></script>
    <!-- Bootstrap 3-->
    <script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min.js"></script>

    <!-- Mobile menu -->
    <script src="/static/main/js/jquery.mobile.menu.js"></script>
    <!-- Select -->
    <script src="/static/main/js/external/jquery.selectbox-0.2.min.js"></script>
    <!-- Form element -->
    <script src="/static/main/js/external/form-element.js"></script>
    <!-- Form validation -->
    <script src="/static/main/js/form.js"></script>

    <!-- Custom -->
    <script src="/static/main/js/custom.js"></script>
</@c.page>
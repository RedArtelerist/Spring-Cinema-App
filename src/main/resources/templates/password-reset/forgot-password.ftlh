<#import "../parts/common.ftlh" as c>

<@c.page>
    <#include "../parts/search.ftlh">

    <form id="forgot-form" action="/forgot-password" method="post" class="login" novalidate=''>
        <p class="login__title">Forgot password</p>

        <div class="field-wrap">
            <div class="alert alert-success">
                <span class="icon-warning"></span>
                Enter your email address and we'll send you a link to reset your password
            </div>
        </div>

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

            <input type='email' placeholder='Email' name='email'
                   class="login__input ${(emailError??)?string('invalid_field', '')}"
                   value="<#if user??>${user.email}</#if>">

            <#if emailError??>
                <div class="invalid-feedback">
                    ${emailError}
                </div>
            </#if>

        </div>

        <div class="login__control">
            <button type='submit' class="btn btn-md btn--warning btn--wider">send</button>
            <a href="/login" class="login__tracker form__tracker">Return to login</a>
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
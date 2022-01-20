<#import "parts/common.ftlh" as c>

<@c.page>
    <#include "parts/search.ftlh">

    <form id="register-form" action="/registration" method="post" class="login" novalidate=''>
        <p class="login__title">sign up <br><span class="login-edition">welcome to A.Movie</span></p>

        <div class="field-wrap">
            <input type="hidden" name="_csrf" value="${_csrf.token}" />


            <input type='text' placeholder='Username' name='username'
                   class="login__input ${(usernameError??)?string('invalid_field', '')}"
                   value="<#if user??>${user.username}</#if>">

            <#if usernameError??>
                <div class="invalid-feedback">
                    ${usernameError}
                </div>
            </#if>

            <input type='email' placeholder='Email' name='email'
                   class="login__input ${(emailError??)?string('invalid_field', '')}"
                   value="<#if user??>${user.email}</#if>">

            <#if emailError??>
                <div class="invalid-feedback">
                    ${emailError}
                </div>
            </#if>

            <input type='text' placeholder='First Name' name='firstName'
                   class="login__input ${(firstNameError??)?string('invalid_field', '')}"
                   value="<#if user??>${user.firstName}</#if>">

            <#if firstNameError??>
                <div class="invalid-feedback">
                    ${firstNameError}
                </div>
            </#if>

            <input type='text' placeholder='Last Name' name='lastName'
                   class="login__input ${(lastNameError??)?string('invalid_field', '')}"
                   value="<#if user??>${user.lastName}</#if>">

            <#if firstNameError??>
                <div class="invalid-feedback">
                    ${lastNameError}
                </div>
            </#if>

            <input type='password' placeholder='Password' name='password'
                   class="login__input ${(passwordError??)?string('invalid_field', '')}">

            <#if passwordError??>
                <#list passwordError?split(",") as err>
                    <div class="invalid-feedback">
                        ${err}
                    </div>
                </#list>
            </#if>

            <input type='password' placeholder='Retype password' name='password2'
                   class="login__input ${(password2Error??)?string('invalid_field', '')}">

            <#if password2Error??>
                <div class="inv-em invalid-feedback">
                    ${password2Error}
                </div>
            </#if>

        </div>

        <div class="login__control">
            <button type='submit' class="btn btn-md btn--warning btn--wider">sign up</button>
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
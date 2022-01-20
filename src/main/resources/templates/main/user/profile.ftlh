<#import "../../parts/common.ftlh" as c>

<@c.page>
    <#include "../../parts/search.ftlh">

    <section class="container">
        <h2 class="page-heading">
            <a class="user-span" href="/user/${userId}">User page</a> > <span class="user-list">Edit profile</span>
        </h2>
        <hr>
        <div class="row">
            <#if message??>
                <div class="field-wrap">
                    <div class="alert alert-${messageType}">
                        <span class="icon-warning"></span>
                        ${message}
                        <a class="close" data-dismiss="alert" aria-hidden="true"></a>
                    </div>
                </div>
            </#if>
            <!-- edit form column -->
            <form action="/profile" method="post" enctype="multipart/form-data">
                <div class="col-md-3">
                    <div class="text-center">
                        <div class="avatar-upload">
                            <div class="avatar-edit">
                                <input type='file' name="image" id="imageUpload" accept=".png, .jpg, .jpeg" />
                                <label for="imageUpload"></label>
                            </div>
                            <div class="avatar-preview">
                                <div id="imagePreview" style="background-image: url('${user.imgUrl}');"></div>
                            </div>
                        </div>
                        <h6>Upload a different photo...Maximum size 2mb</h6>
                    </div>
                </div>

                <div class="col-md-4 personal-info">
                    <h1 class="title">Personal info</h1>

                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                    <div class="form-group row">
                        <label class="col-sm-6 col-form-label">Username:</label>
                        <input type="text" name="username" placeholder="Username"
                               value="${user.username}"
                               class="form-control ${(usernameError??)?string('invalid_field', '')}"/>
                        <#if usernameError??>
                            <div class="invalid-feedback">
                                ${usernameError}
                            </div>
                        </#if>
                    </div>

                    <div class="form-group row mb-2">
                        <label class="col-sm-6 col-form-label">Email:</label>
                        <input type="email" name="email" placeholder="Email"
                               value="${user.email}"
                               class="form-control ${(emailError??)?string('invalid_field', '')}" />

                        <#if emailError??>
                            <div class="invalid-feedback">
                                ${emailError}
                            </div>
                        </#if>

                    </div>

                    <div class="form-group row mb-2">
                        <label class="col-sm-6 col-form-label">First Name:</label>
                        <input type="text" name="firstName" placeholder="First name"
                               value="${user.firstName}"
                               class="form-control ${(firstNameError??)?string('invalid_field', '')}"/>
                        <#if firstNameError??>
                            <div class="invalid-feedback">
                                ${firstNameError}
                            </div>
                        </#if>
                    </div>

                    <div class="form-group row mb-2">
                        <label class="col-sm-6 col-form-label">Last Name:</label>
                        <input type="text" name="lastName" placeholder="Last name"
                               value="${user.lastName}"
                               class="form-control ${(lastNameError??)?string('invalid_field', '')}"/>
                        <#if lastNameError??>
                            <div class="invalid-feedback">
                                ${lastNameError}
                            </div>
                        </#if>
                    </div>

                    <div class="form-group row mb-2">
                        <label class="col-sm-6 col-form-label">Birthday:</label>
                        <input type="date" name="birthDay" placeholder="Birthday"
                               value="${(user.birthDay?string["yyyy-MM-dd"])!''}"
                               class="form-control ${(birthDayError??)?string('invalid_field', '')}"/>
                        <#if birthDayError??>
                            <div class="invalid-feedback">
                                ${birthDayError}
                            </div>
                        </#if>
                    </div>

                    <div class="form-group row mb-2">
                        <label class="col-sm-6 col-form-label">Gender:</label>
                        <div style="display: flex; margin-left: 12px">
                            <#list genders as gender>
                                <div class="form_radio_btn">
                                    <input type="radio" name="gender" id="gender${gender?index}" value="${gender}" <#if user.gender == gender>checked</#if>>
                                    <label for="gender${gender?index}" style="padding: 8px">${gender}</label>
                                </div>
                            </#list>
                        </div>
                    </div>

                    <div class="row">
                        <button type="submit" class="btn btn-md btn--danger" style="width: 100px; margin-left: 12px">Save</button>
                    </div>
                </div>
            </form>
            <form action="/change_password" method="post">
                <div class="col-md-4 change-password" style="margin-left: 20px">
                    <h1 class="title">Change password</h1>

                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                    <div class="form-group row">
                        <label class="col-sm-6 col-form-label">New password:</label>
                        <input type="password" name="password" placeholder="Password"
                               class="form-control ${(passwordError??)?string('invalid_field', '')}"/>

                        <#if passwordError??>
                            <#list passwordError?split(",") as err>
                                <div class="invalid-feedback">
                                    ${err}
                                </div>
                            </#list>
                        </#if>
                    </div>

                    <div class="form-group row">
                        <label class="col-sm-6 col-form-label">Confirm password:</label>
                        <input type="password" name="password2" placeholder="Password"
                               class="form-control ${(password2Error??)?string('invalid_field', '')}"/>

                        <#if password2Error??>
                            <div class="invalid-feedback">
                                ${password2Error}
                            </div>
                        </#if>
                    </div>

                    <div class="row">
                        <button type="submit" class="btn btn-md btn--danger" style="width: 100px; margin: 10px 0 0 12px;">Change</button>
                    </div>
                </div>
            </form>
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
            init_Profile();
        });
    </script>
</@c.page>
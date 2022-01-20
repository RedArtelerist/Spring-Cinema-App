<#import "../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">

<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <h2>Edit user</h2>
                </div>
            </div>
            <!-- end main title -->

            <#include "profile_header.ftlh">

            <#if errors??>
                <#list errors as error>
                    <div class="alert fade_${messageType} .fade" style="margin-left: 15px;">
                        <strong>${error}</strong>
                        <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    </div>
                </#list>
            </#if>

            <!-- content tabs -->
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="tab-1" role="tabpanel" aria-labelledby="1-tab">
                    <div class="col-12">
                        <div class="sign__wrap">
                            <div class="row">
                                <!-- details form -->
                                <div class="col-12 col-lg-12">
                                    <form <#if canEdit>action="/admin/user/${id}/edit" method="post"</#if>
                                          class="sign__form sign__form--profile sign__form--first">

                                        <input type="hidden" value="${_csrf.token}" name="_csrf">

                                        <div class="row">
                                            <div class="col-12">
                                                <h4 class="sign__title">Profile details</h4>
                                            </div>

                                            <div class="col-12 col-md-5 form__cover">
                                                <div class="row">
                                                    <div class="col-12 col-sm-6 col-md-12">
                                                        <div class="form__img_profile">
                                                            <img id="form__img" src="${uuser.imgUrl}" alt="">
                                                        </div>
                                                    </div>
                                                </div>

                                                <#if canEdit && uuser.imageName??>
                                                    <a href="#modal-delete-img" class="main__table-btn main__table-btn--delete open-modal" style="position: absolute; margin-top: -90%; margin-left: 73%; z-index: 1000">
                                                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                                            <path d="M10,18a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,10,18ZM20,6H16V5a3,3,0,0,0-3-3H11A3,3,0,0,0,8,5V6H4A1,1,0,0,0,4,8H5V19a3,3,0,0,0,3,3h8a3,3,0,0,0,3-3V8h1a1,1,0,0,0,0-2ZM10,5a1,1,0,0,1,1-1h2a1,1,0,0,1,1,1V6H10Zm7,14a1,1,0,0,1-1,1H8a1,1,0,0,1-1-1V8H17Zm-3-1a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,14,18Z"/>
                                                        </svg>
                                                    </a>
                                                </#if>
                                            </div>

                                            <div class="col-12 col-md-7 form__content">
                                                <div class="row">
                                                    <div class="col-6 col-md-6 col-lg-6 col-xl-6">
                                                        <div class="sign__group">
                                                            <label class="sign__label" for="username">Login</label>
                                                            <input id="username" type="text" name="username" class="sign__input" value="${uuser.username}" <#if !canEdit>disabled</#if>>
                                                        </div>
                                                    </div>

                                                    <div class="col-6 col-md-6 col-lg-6 col-xl-6">
                                                        <div class="sign__group">
                                                            <label class="sign__label" for="email">Email</label>
                                                            <input id="email" type="text" name="email" class="sign__input" value="${uuser.email}" <#if !canEdit>disabled</#if>>
                                                        </div>
                                                    </div>

                                                    <div class="col-6 col-md-6 col-lg-6 col-xl-6">
                                                        <div class="sign__group">
                                                            <label class="sign__label" for="firstName">First name</label>
                                                            <input id="firstName" type="text" name="firstName" class="sign__input" value="${uuser.firstName}" <#if !canEdit>disabled</#if>>
                                                        </div>
                                                    </div>

                                                    <div class="col-6 col-md-6 col-lg-6 col-xl-6">
                                                        <div class="sign__group">
                                                            <label class="sign__label" for="lastName">Last name</label>
                                                            <input id="lastName" type="text" name="lastName" class="sign__input" value="${uuser.lastName}" <#if !canEdit>disabled</#if>>
                                                        </div>
                                                    </div>

                                                    <div class="col-6 col-md-6 col-lg-6 col-xl-6">
                                                        <div class="sign__group">
                                                            <label class="sign__label" for="subscription">Gender</label>
                                                            <select class="js-example-basic-single" id="subscription" name="gender" <#if !canEdit>disabled</#if>>
                                                                <#list genders as gender>
                                                                    <option value="${gender}" <#if uuser?? && uuser.gender == gender>selected</#if>>${gender}</option>
                                                                </#list>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="col-6 col-md-6 col-lg-6 col-xl-6">
                                                        <div class="sign__group">
                                                            <label class="sign__label" for="birthDay">BirthDay</label>
                                                            <input id="birthDay" type="date" name="birthDay" class="sign__input" value="<#if uuser??>${(uuser.birthDay?string["yyyy-MM-dd"])!''}</#if>" <#if !canEdit>disabled</#if>>
                                                        </div>
                                                    </div>

                                                    <div class="col-12 col-md-6 col-lg-12 col-xl-12">
                                                        <div class="sign__group">
                                                            <label class="sign__label" for="rights">Rights</label>
                                                            <select name="roles" class="js-example-basic-multiple" multiple="multiple" id="rights" <#if !canEdit>disabled</#if>>
                                                                <#list roles as role>
                                                                    <#if canEdit>
                                                                        <#if isOwner && role != "OWNER">
                                                                            <option value="${role}"
                                                                                    <#if user??>${uuser.roles?seq_contains(role)?string("selected", "")}</#if>>
                                                                                ${role}
                                                                            </option>
                                                                        <#elseif isAdmin && role != "ADMIN" && role != "OWNER">
                                                                            <option value="${role}"
                                                                                    <#if user??>${uuser.roles?seq_contains(role)?string("selected", "")}</#if>>
                                                                                ${role}
                                                                            </option>
                                                                        </#if>
                                                                    <#else>
                                                                        <option value="${role}"
                                                                                <#if user??>${uuser.roles?seq_contains(role)?string("selected", "")}</#if>>
                                                                            ${role}
                                                                        </option>
                                                                    </#if>

                                                                </#list>
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <#if canEdit>
                                                        <div class="col-12">
                                                            <button class="sign__btn" type="submit">Save</button>
                                                        </div>
                                                    </#if>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <!-- end details form -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end content tabs -->
        </div>
    </div>
</@c.page>
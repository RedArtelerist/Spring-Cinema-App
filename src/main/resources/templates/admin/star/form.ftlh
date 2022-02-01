<#import "../parts/common.ftlh" as c>

<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <#if star?? && star.id??>
                        <h2>Edit star</h2>
                    <#else>
                        <h2>Add new star</h2>
                    </#if>
                    <div class="main__title-wrap">
                        <a href="/admin/stars" class="main__title-link">all stars</a>
                    </div>
                </div>
            </div>
            <!-- end main title -->

            <!-- form -->
            <div class="col-12">
                <form method="post" class="form" enctype="multipart/form-data">
                    <input type="hidden" value="${_csrf.token}" name="_csrf">

                    <div class="row">
                        <div class="col-12 col-md-5 form__cover">
                            <div class="row">
                                <div class="col-12 col-sm-6 col-md-12">
                                    <div class="form__img">
                                        <label for="form__img-upload">Upload cover (190 x 270)</label>
                                        <input name="image" id="form__img-upload" name="form__img-upload" type="file" accept=".png, .jpg, .jpeg">
                                        <img id="form__img" src="<#if star?? && star.imgName??>${star.imgUrl}</#if>" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-7 form__content">
                            <div class="row">
                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="firstName" type="text" class="form__input ${(firstNameError??)?string('is-invalid', '')}"
                                               placeholder="First name" value="<#if star??>${star.firstName}</#if>">

                                        <#if firstNameError??>
                                            <#list firstNameError?split(",") as err>
                                                <div class="invalid-feedback">
                                                    ${err}
                                                </div>
                                            </#list>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="lastName" type="text" class="form__input ${(lastNameError??)?string('is-invalid', '')}"
                                               placeholder="Last name" value="<#if star??>${star.lastName}</#if>">

                                        <#if lastNameError??>
                                            <div class="invalid-feedback">
                                                ${lastNameError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>


                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="birthPlace" type="text" class="form__input ${(birthPlaceError??)?string('is-invalid', '')}"
                                               placeholder="Birth place" value="<#if star??>${star.birthPlace}</#if>">

                                        <#if birthPlaceError??>
                                            <div class="invalid-feedback">
                                                ${birthPlaceError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="birthday" type="date" class="form__input ${(birthdayError??)?string('is-invalid', '')}"
                                               placeholder="Birthday" value="<#if star??>${(star.birthday?string["yyyy-MM-dd"])!''}</#if>">

                                        <#if birthPlaceError??>
                                            <div class="invalid-feedback">
                                                ${birthdayError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>


                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="death" type="date" class="form__input ${(deathError??)?string('is-invalid', '')}"
                                               placeholder="Death" value="<#if star??>${(star.death?string["yyyy-MM-dd"])!''}</#if>">

                                        <#if deathError??>
                                            <div class="invalid-feedback">
                                                ${deathError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-3">
                                    <div class="form__group">
                                        <select name="gender" class="js-example-basic-single" id="quality">
                                            <#list genders as gender>
                                                <option value="${gender}" <#if star?? && star.gender == gender>selected</#if>>${gender}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <ul class="form__radio">
                                        <li>
                                            <span>Star status:</span>
                                        </li>
                                        <li>
                                            <input id="type1" value="true" type="radio" name="status" <#if star?? && star.status>checked<#else>checked</#if>>
                                            <label for="type1">Visible</label>
                                        </li>
                                        <li>
                                            <input id="type2" value="false" type="radio" name="status" <#if star?? && !star.status>checked</#if>>
                                            <label for="type2">Hidden</label>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="row">
                                <div class="col-12">
                                    <button type="submit" class="form__btn">publish</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- end form -->
        </div>
    </div>
</@c.page>




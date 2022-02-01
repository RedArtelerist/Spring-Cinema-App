<#import "../parts/common.ftlh" as c>

<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <#if seance?? && seance.id??>
                        <h2>Edit new seance</h2>
                    <#else>
                        <h2>Add new seance</h2>
                    </#if>
                    <div class="main__title-wrap">
                        <a href="/admin/cinema/${cinema.id}/seances" class="main__title-link">all seances</a>
                    </div>
                </div>
            </div>
            <!-- end main title -->

            <!-- form -->
            <div class="col-9">
                <#if message??>
                    <div class="alert fade_${messageType} .fade">
                        <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                        <strong>${message}</strong>
                    </div>
                </#if>
                <form method="post" class="form" enctype="multipart/form-data">
                    <input type="hidden" value="${_csrf.token}" name="_csrf">

                    <div class="row">
                        <div class="col-12">
                            <div class="row">
                                <div class="col-12 col-sm-9 col-lg-9">
                                    <div class="form__group">
                                        <select name="movie" class="js-example-basic-single" id="movie">
                                            <#list movies as movie>
                                                <option value="${movie.id}" <#if seance?? && seance.movie.id == movie.id>selected</#if>>${movie.title}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-3 col-lg-3">
                                    <div class="form__group">
                                        <select name="hall" class="js-example-basic-single" id="hall">
                                            <#list halls as hall>
                                                <option value="${hall.id}" <#if seance?? && seance.hall.id == hall.id>selected</#if>>${hall.name}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="date" type="text" class="form__input ${(dateError??)?string('is-invalid', '')}" onfocus="(this.type='date')"
                                               placeholder="Date" value="<#if seance??>${(seance.date?string["yyyy-MM-dd"])!''}</#if>">

                                        <#if dateError??>
                                            <div class="invalid-feedback">
                                                ${dateError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="startTime" type="text" class="form__input ${(startTimeError??)?string('is-invalid', '')}" onfocus="(this.type='time')"
                                               placeholder="Start time" value="<#if seance??>${(seance.startTime?string["HH:mm"])!''}</#if>">

                                        <#if startTimeError??>
                                            <div class="invalid-feedback">
                                                ${startTimeError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="endTime" type="text" class="form__input ${(endTimeError??)?string('is-invalid', '')}" onfocus="(this.type='time')"
                                               placeholder="End time" value="<#if seance??>${(seance.endTime?string["HH:mm"])!''}</#if>">

                                        <#if endTimeError??>
                                            <div class="invalid-feedback">
                                                ${endTimeError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="price" type="number" class="form__input ${(priceError??)?string('is-invalid', '')}"
                                               placeholder="Price" value="<#if seance??>${(seance.price?c)!''}</#if>">

                                        <#if priceError??>
                                            <div class="invalid-feedback">
                                                ${priceError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-lg-12">
                                    <div class="form__group">
                                        <select name="technologies" class="js-example-basic-multiple" id="technologies" multiple="multiple">
                                            <#list technologies as tech>
                                                <option value="${tech}" <#if seance??>${seance.technologies?seq_contains(tech)?string("selected", "")}</#if>>${tech.getLabel()}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <ul class="form__radio">
                                        <li>
                                            <span>Seance status:</span>
                                        </li>
                                        <li>
                                            <input id="type1" value="false" type="radio" name="available" <#if seance?? && !seance.available>checked<#else>checked</#if>>
                                            <label for="type1">Hidden</label>
                                        </li>
                                        <li>
                                            <input id="type2" value="true" type="radio" name="available" <#if seance?? && seance.available>checked</#if>>
                                            <label for="type2">Visible</label>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="row">
                                <button type="submit" class="form__btn">publish</button>
                            </div>
                        </div>

                    </div>

                </form>
            </div>
            <!-- end form -->
        </div>
    </div>
</@c.page>

<#import "../parts/common.ftlh" as c>

<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <#if seance?? && seance.id??>
                        <h2>Edit seance</h2>
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
        <#if seance?? && seance.id??>
            <div class="row">
                <div class="main__table-wrap">
                    <table class="main__table">
                        <tbody>
                        <tr>
                            <td>
                                <div class="choose-sits">

                                    <div class="choose-sits__info choose-sits__info--first" style="margin-bottom: 20px">
                                        <ul>
                                            <li class="sits-price marker--none"><strong>Price</strong></li>
                                            <li class="sits-price sits-price--cheap">₴${seance.price}</li>
                                            <li class="sits-price sits-price--middle">₴${seance.price * 1.5}</li>
                                            <li class="sits-price sits-price--expensive">₴${seance.price * 2}</li>
                                        </ul>
                                    </div>

                                    <div class="choose-sits__info" style="margin-bottom: 100px">
                                        <ul>
                                            <li class="sits-state sits-state--not">Not available</li>
                                            <li class="sits-state sits-state--your">Your choice</li>
                                        </ul>
                                    </div>

                                    <div class="col-sm-12 col-lg-10 col-lg-offset-1">
                                        <div class="sits-area hidden-xs">
                                            <div class="sits-anchor">screen</div>

                                            <div class="sits">
                                                <aside class="sits__line">
                                                    <#list rows as row>
                                                        <span class="sits__indecator">${row.name}</span>
                                                    </#list>
                                                </aside>

                                                <#list rows as row>
                                                    <div class="sits__row">
                                                        <#list row.seats as seat>
                                                            <span class="sits__place <#if seance.seatReserved(seat)>sits-state--not<#else><#if seat.type == 'Standard'>sits-price--cheap<#elseif seat.type == 'Vip'>sits-price--middle<#else>sits-price--expensive</#if></#if>"
                                                                  data-id="${seat.id?c}" data-place='${row.name}${seat.number}' data-price="<#if seat.type == 'Standard'>${seance.price}<#elseif seat.type == 'Vip'>${seance.price * 1.5}<#else>${seance.price * 2}</#if>">
                                                                ${row.name}${seat.number}
                                                            </span>
                                                        </#list>
                                                    </div>
                                                </#list>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </#if>
    </div>
</@c.page>

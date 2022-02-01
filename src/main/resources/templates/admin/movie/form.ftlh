<#import "../parts/common.ftlh" as c>

<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <#if movie?? && movie.id??>
                        <h2>Edit item</h2>
                    <#else>
                        <h2>Add new item</h2>
                    </#if>
                    <div class="main__title-wrap">
                        <a href="/admin/movies" class="main__title-link">all items</a>
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
                                        <input name="poster" id="form__img-upload" type="file" accept=".png, .jpg, .jpeg">
                                        <img id="form__img" src="<#if movie?? && movie.posterName??>${movie.posterUrl}</#if>" alt="">
                                    </div>
                                </div>
                                <div class="col-12">
                                    <ul class="form__radio">
                                        <li>
                                            <span>Item type:</span>
                                        </li>
                                        <#list categories as category>
                                            <li>
                                                <input id="type${category?counter}" type="radio" name="category" value="${category}" <#if movie?? && movie.category == category>checked<#elseif category == "Movie">checked</#if>>
                                                <label for="type${category?counter}">${category.getLabel()}</label>
                                            </li>
                                        </#list>
                                    </ul>
                                </div>

                                <div class="col-12">
                                    <ul class="form__radio">
                                        <li>
                                            <span>Movie status:</span>
                                        </li>
                                        <li>
                                            <input id="type3" value="true" type="radio" name="status" <#if movie?? && movie.status>checked<#else>checked</#if>>
                                            <label for="type3">Visible</label>
                                        </li>
                                        <li>
                                            <input id="type4" value="false" type="radio" name="status" <#if movie?? && !movie.status>checked</#if>>
                                            <label for="type4">Hidden</label>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-7 form__content">
                            <div class="row">
                                <div class="col-12">
                                    <div class="form__group">
                                        <input name="title" type="text" class="form__input ${(titleError??)?string('is-invalid', '')}"
                                               placeholder="Title" value="<#if movie??>${movie.title}</#if>">

                                        <#if titleError??>
                                            <div class="invalid-feedback">
                                                ${titleError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>


                                <div class="col-12">
                                    <div class="form__group">
                                        <textarea id="text" name="description" class="form__textarea ${(descriptionError??)?string('is-invalid', '')}"
                                                  placeholder="Description"><#if movie??>${movie.description}</#if></textarea>

                                        <#if descriptionError??>
                                            <div class="invalid-feedback">
                                                ${descriptionError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-3">
                                    <div class="form__group">
                                        <input name="release" type="text" class="form__input ${(releaseError??)?string('is-invalid', '')}" onfocus="(this.type='date')"
                                               placeholder="Release date" value="<#if movie??>${(movie.release?string["yyyy-MM-dd"])!''}</#if>">

                                        <#if releaseError??>
                                            <div class="invalid-feedback">
                                                ${releaseError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-3">
                                    <div class="form__group">
                                        <input name="time" type="text" class="form__input ${(timeError??)?string('is-invalid', '')}"
                                               placeholder="Running timed in minutes" value="<#if movie??>${movie.time}</#if>">

                                        <#if timeError??>
                                            <div class="invalid-feedback">
                                                ${timeError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-3">
                                    <div class="form__group">
                                        <select name="mpaa" class="js-example-basic-single" id="mpaa">
                                            <#list rates as mpaa>
                                                <option value="${mpaa}" <#if movie?? && movie.mpaa == mpaa>selected</#if>>${mpaa.getLabel()}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-3">
                                    <div class="form__group">
                                        <input name="year" type="number" class="form__input ${(yearError??)?string('is-invalid', '')}"
                                               placeholder="Year" value="<#if movie??>${(movie.year?c)!'0'}</#if>">

                                        <#if yearError??>
                                            <div class="invalid-feedback">
                                                ${yearError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-3">
                                    <div class="form__group">
                                        <input name="budget" type="number" class="form__input ${(budgetError??)?string('is-invalid', '')}"
                                               placeholder="Budget" value="<#if movie??>${(movie.budget?c)!''}</#if>">

                                        <#if budgetError??>
                                            <div class="invalid-feedback">
                                                ${budgetError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-3">
                                    <div class="form__group">
                                        <input name="boxOffice" type="number" class="form__input ${(boxOfficeError??)?string('is-invalid', '')}"
                                               placeholder="Box office" value="<#if movie??>${(movie.boxOffice?c)!''}</#if>">

                                        <#if boxOfficeError??>
                                            <div class="invalid-feedback">
                                                ${boxOfficeError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-lg-6">
                                    <div class="form__group form__group--link">
                                        <input name="trailer" type="text" class="form__input" placeholder="add a trailer link" value="<#if movie??>${movie.trailer}</#if>">
                                    </div>
                                </div>

                                <div class="col-12 col-lg-6">
                                    <div class="form__group">
                                        <select name="countries" class="js-example-basic-multiple" id="country" multiple="multiple">
                                            <#list countries as country>
                                                <option value="${country}" <#if movie??>${movie.countries?seq_contains(country)?string("selected", "")}</#if>>${country.getLabel()}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-12 col-lg-6">
                                    <div class="form__group">
                                        <select name="genres" class="js-example-basic-multiple" id="genre" multiple="multiple">
                                            <#list genres as genre>
                                                <option value="${genre}" <#if movie??>${movie.genres?seq_contains(genre)?string("selected", "")}</#if>>${genre}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form__group">
                                        <select name="companies" class="js-example-basic-multiple" id="company" multiple="multiple">
                                            <#list companies as company>
                                                <option value="${company.id}" <#if movie?? && movie.companies??>${movie.companies?seq_contains(company)?string("selected", "")}</#if>>${company.name}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form__group">
                                        <select name="directors" class="js-example-basic-multiple" id="director" multiple="multiple">
                                            <#list stars as director>
                                                <option value="${director.id}" <#if movie?? && movie.directors??>${movie.directors?seq_contains(director)?string("selected", "")}</#if>>${director.fullName()}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="row">
                                <div class="col-12">
                                    <div class="form__group">
                                        <select name="cast" class="js-example-basic-multiple actor-select" id="actor" multiple="multiple">
                                            <#list stars as actor>
                                                <option value="${actor.id}" <#if movie?? && movie.cast??>${movie.cast?seq_contains(actor)?string("selected", "")}</#if>>${actor.fullName()}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="form__gallery">
                                        <label id="gallery1" for="form__gallery-upload">Upload photos</label>
                                        <input data-name="#gallery1" id="form__gallery-upload" name="images" class="form__gallery-upload" type="file" accept=".png, .jpg, .jpeg" multiple>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <button type="submit" class="form__btn">publish</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- end form -->
            <#if movie?? && movie.gallery?size gt 0>
                <div class="container-fluid">
                    <div class="row">
                        <!-- main title -->
                        <div class="col-12">
                            <div class="main__title">
                                <h2>Gallery</h2>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="row">
                                <#list movie.gallery as item>
                                    <div class="col-12 col-md-5 form__cover">
                                        <div class="row">
                                            <form id="img_item_gallery" method="post" action="/admin/movie/${movie.id}/image/${item.id}/delete">
                                                <input type="hidden" value="${_csrf.token}" name="_csrf">
                                                <button type="submit" class="main__table-btn main__table-btn--delete">
                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                                        <path d="M10,18a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,10,18ZM20,6H16V5a3,3,0,0,0-3-3H11A3,3,0,0,0,8,5V6H4A1,1,0,0,0,4,8H5V19a3,3,0,0,0,3,3h8a3,3,0,0,0,3-3V8h1a1,1,0,0,0,0-2ZM10,5a1,1,0,0,1,1-1h2a1,1,0,0,1,1,1V6H10Zm7,14a1,1,0,0,1-1,1H8a1,1,0,0,1-1-1V8H17Zm-3-1a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,14,18Z"/>
                                                    </svg>
                                                </button>
                                            </form>
                                            <div class="col-12 col-sm-6 col-md-12">
                                                <div class="form__img" style="max-height: 300px">
                                                    <img id="form__img" src="${item.imageUrl}" alt="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </#list>
                            </div>
                        </div>
                    </div>
                </div>
            </#if>
        </div>
    </div>
</@c.page>




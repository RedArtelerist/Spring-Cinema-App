<#import "../parts/common.ftlh" as c>

<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <#if company?? && company.id??>
                        <h2>Edit company</h2>
                    <#else>
                        <h2>Add new company</h2>
                    </#if>
                    <div class="main__title-wrap">
                        <a href="/admin/companies" class="main__title-link">all companies</a>
                    </div>
                </div>
            </div>
            <!-- end main title -->

            <!-- form -->
            <div class="col-9">
                <form class="form" method="post">
                    <input type="hidden" value="${_csrf.token}" name="_csrf">
                    <div class="row">
                        <div class="col-12 col-md-7 form__content">
                            <div class="row">
                                <div class="col-12">
                                    <div class="form__group">
                                        <input name="name" type="text" placeholder="Name"
                                               class="form__input ${(nameError??)?string('is-invalid', '')}"
                                               value="<#if company??>${company.name}</#if>">

                                        <#if nameError??>
                                            <div class="invalid-feedback">
                                                ${nameError}
                                            </div>
                                        </#if>
                                    </div>
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

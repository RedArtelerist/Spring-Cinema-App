<#import "../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">
<#import "../parts/pager.ftlh" as p>


<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <h2>Catalog</h2>

                    <span class="main__title-stat">${total} total</span>

                    <div class="main__title-wrap">
                        <a href="/admin/cinema/create" class="main__title-link">add cinema</a>
                    </div>

                    <div class="main__title-wrap">
                        <!-- filter sort -->
                        <div class="filter" id="filter__sort">
                            <span class="filter__item-label">Sort by:</span>

                            <div class="filter__item-btn dropdown-toggle" role="navigation" id="filter-sort" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <input type="button" value="<#if sort??>${sort}<#else>name</#if>">
                                <span></span>
                            </div>

                            <ul class="filter__item-menu dropdown-menu scrollbar-dropdown" aria-labelledby="filter-sort">
                                <li>name</li>
                                <li>rating</li>
                            </ul>
                        </div>
                        <!-- end filter sort -->

                        <!-- search -->
                        <form id="filter-form" method="get" class="main__title-form">
                            <input name="sort" type="hidden" value="${sort!('')}">
                            <input name="search" type="text" value="${search!('')}" placeholder="Find cinema..">
                            <button type="submit">
                                <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="8.25998" cy="8.25995" r="7.48191" stroke="#2F80ED" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></circle><path d="M13.4637 13.8523L16.3971 16.778" stroke="#2F80ED" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path></svg>
                            </button>
                        </form>
                        <!-- end search -->
                    </div>
                </div>
            </div>
            <!-- end main title -->

            <#if message??>
                <div class="alert fade_${messageType} .fade">
                    <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>${message}</strong>
                </div>
            </#if>

            <!-- users -->
            <div class="col-12">
                <div class="main__table-wrap">
                    <table class="main__table">
                        <thead>
                        <tr>
                            <th>Id</th>
                            <th>Name</th>
                            <th>City</th>
                            <th>Address</th>
                            <th>Status</th>
                        </tr>
                        </thead>

                        <tbody>
                        <#list page.content as cinema>
                            <tr>
                                <td>
                                    <div class="main__table-text">${cinema.id}</div>
                                </td>
                                <td>
                                    <div class="main__user">
                                        <div class="main__avatar">
                                            <img src="${cinema.imageUrl}" alt="">
                                        </div>
                                        <div class="main__meta">
                                            <h3>${cinema.name}</h3>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="main__table-text main__table-text--rate"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M22,9.67A1,1,0,0,0,21.14,9l-5.69-.83L12.9,3a1,1,0,0,0-1.8,0L8.55,8.16,2.86,9a1,1,0,0,0-.81.68,1,1,0,0,0,.25,1l4.13,4-1,5.68A1,1,0,0,0,6.9,21.44L12,18.77l5.1,2.67a.93.93,0,0,0,.46.12,1,1,0,0,0,.59-.19,1,1,0,0,0,.4-1l-1-5.68,4.13-4A1,1,0,0,0,22,9.67Zm-6.15,4a1,1,0,0,0-.29.88l.72,4.2-3.76-2a1.06,1.06,0,0,0-.94,0l-3.76,2,.72-4.2a1,1,0,0,0-.29-.88l-3-3,4.21-.61a1,1,0,0,0,.76-.55L12,5.7l1.88,3.82a1,1,0,0,0,.76.55l4.21.61Z"/></svg>
                                        ${cinema.rating}
                                    </div>
                                </td>
                                <td>
                                    <div class="main__table-text">${cinema.city}</div>
                                </td>
                                <td>
                                    <div class="main__table-text">${cinema.address}</div>
                                </td>
                                <td>
                                    <#if cinema.active>
                                        <div class="main__table-text main__table-text--green">Visible</div>
                                    <#else>
                                        <div class="main__table-text main__table-text--red">Hidden</div>
                                    </#if>
                                </td>
                                <td>
                                    <div class="main__table-btns">

                                        <a href="/admin/cinema/${cinema.id}/edit" class="main__table-btn main__table-btn--edit">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M22,7.24a1,1,0,0,0-.29-.71L17.47,2.29A1,1,0,0,0,16.76,2a1,1,0,0,0-.71.29L13.22,5.12h0L2.29,16.05a1,1,0,0,0-.29.71V21a1,1,0,0,0,1,1H7.24A1,1,0,0,0,8,21.71L18.87,10.78h0L21.71,8a1.19,1.19,0,0,0,.22-.33,1,1,0,0,0,0-.24.7.7,0,0,0,0-.14ZM6.83,20H4V17.17l9.93-9.93,2.83,2.83ZM18.17,8.66,15.34,5.83l1.42-1.41,2.82,2.82Z"/></svg>
                                        </a>

                                        <form id="del-form-${cinema.id}" method="post" action="/admin/cinema/${cinema.id}/delete">
                                            <input type="hidden" value="${_csrf.token}" name="_csrf">
                                        </form>

                                        <a href="#modal-delete" class="main__table-btn main__table-btn--delete open-modal" data-id="${cinema.id}">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                                <path d="M10,18a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,10,18ZM20,6H16V5a3,3,0,0,0-3-3H11A3,3,0,0,0,8,5V6H4A1,1,0,0,0,4,8H5V19a3,3,0,0,0,3,3h8a3,3,0,0,0,3-3V8h1a1,1,0,0,0,0-2ZM10,5a1,1,0,0,1,1-1h2a1,1,0,0,1,1,1V6H10Zm7,14a1,1,0,0,1-1,1H8a1,1,0,0,1-1-1V8H17Zm-3-1a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,14,18Z"/>
                                            </svg>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- end users -->

            <!-- paginator -->
            <div class="col-12">
                <div class="paginator">
                    <span class="paginator__pages">${page.getNumberOfElements()} from ${page.getSize()} </span>

                    <#if page.hasContent()>
                        <@p.pager url page />
                    </#if>
                </div>
            </div>
            <!-- end paginator -->
        </div>
    </div>


    <!-- modal delete -->
    <div id="modal-delete" class="zoom-anim-dialog mfp-hide modal">
        <h6 class="modal__title">Cinema delete</h6>

        <p class="modal__text">Are you sure to permanently delete this cinema?</p>

        <div class="modal__btns">
            <button class="modal__btn modal__btn--apply" type="button">Delete</button>
            <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
        </div>
    </div>
</@c.page>
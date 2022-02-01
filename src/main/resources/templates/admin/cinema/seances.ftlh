<#import "../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">
<#import "../parts/pager.ftlh" as p>


<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <h2>Seances in <a href="/admin/cinema/${cinema.id}/edit">${cinema.name}</a></h2>

                    <span class="main__title-stat">${total} total</span>

                    <div class="main__title-wrap">
                        <div style="display: flex">
                        <!-- filter sort -->
                            <div class="filter" id="filter__sort">
                                <span class="filter__item-label">Sort by:</span>

                                <div class="filter__item-btn dropdown-toggle" role="navigation" id="filter-sort" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <input type="button" value="<#if sort??>${sort}<#else>datetime</#if>">

                                    <span></span>
                                </div>

                                <ul class="filter__item-menu dropdown-menu scrollbar-dropdown" aria-labelledby="filter-sort">
                                    <li>datetime</li>
                                    <li>status</li>
                                </ul>
                            </div>
                            <!-- end filter sort -->

                            <div class="filter" id="filter__date" style="margin-left: 20px">
                                <span class="filter__item-label">Filter by date:</span>

                                <div class="filter__item-btn dropdown-toggle" role="navigation" id="filter-date" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <input type="button" value="<#if date??>${date}<#else>all</#if>">

                                    <span></span>
                                </div>

                                <ul class="filter__item-menu dropdown-menu scrollbar-dropdown" aria-labelledby="filter-date">
                                    <li>all</li>
                                    <#list dates as item>
                                        <li>${item?string["dd.MM.yyyy"]}</li>
                                    </#list>
                                </ul>
                            </div>

                            <div class="filter" id="filter__movie" style="margin-left: 20px">
                            <span class="filter__item-label">Filter by movie:</span>

                            <div class="filter__item-btn dropdown-toggle" role="navigation" id="filter-movie" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <input type="button" value="<#if movie??>${movie.title}<#else>all</#if>" style="max-width: 100px">

                                <span></span>
                            </div>

                            <ul class="filter__item-menu dropdown-menu scrollbar-dropdown" aria-labelledby="filter-movie">
                                <li date-id="0">all</li>
                                <#list movies as movie>
                                    <li data-id="${movie.id}">${movie.title}</li>
                                </#list>
                            </ul>
                        </div>
                        </div>

                        <!-- search -->
                        <form id="filter-form" method="get">
                            <input name="sort" type="hidden" value="${sort!('')}">
                            <input name="date" type="hidden" value="${date!('')}">
                            <input name="movieId" type="hidden" value="<#if movie??>${movie.id!('')}</#if>">
                        </form>
                        <!-- end search -->
                        <div class="main__title-wrap">
                            <a href="/admin/cinema/${cinema.id}/seance/create" class="main__title-link" style="margin-right: 10px">add seance</a>
                        </div>
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
                                <th>Movie</th>
                                <th>Hall</th>
                                <th>Date</th>
                                <th>StarTime</th>
                                <th>EndTime</th>
                                <th>Price</th>
                                <th>Status</th>
                            </tr>
                        </thead>

                        <tbody>
                        <#list page.content as seance>
                            <tr>
                                <td>
                                    <div class="main__table-text">${seance.id}</div>
                                </td>
                                <td>
                                    <div class="main__table-text">${seance.movie.title}</div>
                                </td>
                                <td>
                                    <div class="main__table-text">${seance.hall.name}</div>
                                </td>
                                <td>
                                    <div class="main__table-text">${seance.date?string["dd.MM.yyyy"]}</div>
                                </td>
                                <td>
                                    <div class="main__table-text">${seance.startTime?string["HH:mm"]}</div>
                                </td>
                                <td>
                                    <div class="main__table-text">${seance.endTime?string["HH:mm"]}</div>
                                </td>
                                <td>
                                    <div class="main__table-text">${seance.price}</div>
                                </td>
                                <td>
                                    <#if seance.available>
                                        <div class="main__table-text main__table-text--green">Visible</div>
                                    <#else>
                                        <div class="main__table-text main__table-text--red">Hidden</div>
                                    </#if>
                                </td>
                                <td>
                                    <div class="main__table-btns">
                                        <a href="/admin/cinema/${cinema.id}/seance/${seance.id}" class="main__table-btn main__table-btn--edit">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M22,7.24a1,1,0,0,0-.29-.71L17.47,2.29A1,1,0,0,0,16.76,2a1,1,0,0,0-.71.29L13.22,5.12h0L2.29,16.05a1,1,0,0,0-.29.71V21a1,1,0,0,0,1,1H7.24A1,1,0,0,0,8,21.71L18.87,10.78h0L21.71,8a1.19,1.19,0,0,0,.22-.33,1,1,0,0,0,0-.24.7.7,0,0,0,0-.14ZM6.83,20H4V17.17l9.93-9.93,2.83,2.83ZM18.17,8.66,15.34,5.83l1.42-1.41,2.82,2.82Z"/></svg>
                                        </a>

                                        <form id="del-form-${seance.id}" method="post" action="/admin/cinema/${cinema.id}/seance/${seance.id}/delete">
                                            <input type="hidden" value="${_csrf.token}" name="_csrf">
                                        </form>

                                        <a href="#modal-delete" class="main__table-btn main__table-btn--delete open-modal" data-id="${seance.id}">
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
        <h6 class="modal__title">Seance delete</h6>

        <p class="modal__text">Are you sure to permanently delete this seance?</p>

        <div class="modal__btns">
            <button class="modal__btn modal__btn--apply" type="button">Delete</button>
            <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
        </div>
    </div>
</@c.page>
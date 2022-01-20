<#import "../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">
<#import "../parts/pager.ftlh" as p>


<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <h2>Users</h2>

                    <span class="main__title-stat">${total} total</span>

                    <div class="main__title-wrap">
                        <!-- filter sort -->
                        <div class="filter" id="filter__sort">
                            <span class="filter__item-label">Sort by:</span>

                            <div class="filter__item-btn dropdown-toggle" role="navigation" id="filter-sort" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <input type="button" value="<#if sort??>${sort}<#else>created-desc</#if>">
                                <span></span>
                            </div>

                            <ul class="filter__item-menu dropdown-menu scrollbar-dropdown" aria-labelledby="filter-sort">
                                <li>created-asc</li>
                                <li>created-desc</li>
                                <li>status</li>
                                <li>username</li>
                            </ul>
                        </div>
                        <!-- end filter sort -->

                        <!-- search -->
                        <form id="filter-form" method="get" class="main__title-form">
                            <input name="sort" type="hidden" value="${sort!('')}">
                            <input name="search" type="text" value="${search!('')}" placeholder="Find user..">
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
                <div class="alert fade_${messageType} .fade"> <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>${message}</strong>
                </div>
            </#if>

            <!-- users -->
            <div class="col-12">
                <div class="main__table-wrap">
                    <table class="main__table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>BASIC INFO</th>
                            <th>USERNAME</th>
                            <th>COMMENTS</th>
                            <th>STATUS</th>
                            <th>Active</th>
                            <th>CREATED DATE</th>
                            <th>UPDATED DATE</th>
                            <th>ACTIONS</th>
                        </tr>
                        </thead>

                        <tbody>
                        <#list page.content as user>
                            <tr>
                                <td>
                                    <div class="main__table-text">${user.id}</div>
                                </td>
                                <td>
                                    <div class="main__user">
                                        <div class="main__avatar">
                                            <img src="${user.imgUrl}" alt="">
                                        </div>
                                        <div class="main__meta">
                                            <h3>${user.fullName()}</h3>
                                            <span>${user.email}</span>
                                            <span style="size: 3px!important;">
                                                <#list user.roles as role>${role}<#sep>, </#list>
                                            </span>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="main__table-text">${user.username}</div>
                                </td>
                                <td>
                                    <div class="main__table-text">0</div>
                                </td>
                                <td>
                                    <#if user.locked>
                                        <div class="main__table-text main__table-text--red">Banned</div>
                                    <#else>
                                        <div class="main__table-text main__table-text--green">Approved</div>
                                    </#if>
                                </td>
                                <td>
                                    <#if user.active>
                                        <div class="main__table-text main__table-text--green">Yes</div>
                                    <#else>
                                        <div class="main__table-text main__table-text--red">No</div>
                                    </#if>
                                </td>
                                <td>
                                    <div class="main__table-text">${user.createdAt?string["dd.MM.yyyy HH:mm"]}</div>
                                </td>
                                <td>
                                    <div class="main__table-text">${user.updatedAt?string["dd.MM.yyyy HH:mm"]}</div>
                                </td>
                                <td>
                                    <div class="main__table-btns">
                                        <#if isOwner && user.id != currentUserId || (isAdmin && user.isAdmin()=false && !user.isOwner())>
                                                <form id="ban-form-${user.id}" method="post" action="/admin/user/${user.id}/ban">
                                                    <input type="hidden" value="${_csrf.token}" name="_csrf">
                                                </form>

                                                <a href="#modal-status" class="main__table-btn main__table-btn--banned open-modal" data-id="${user.id}">
                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                                        <path d="M12,13a1.49,1.49,0,0,0-1,2.61V17a1,1,0,0,0,2,0V15.61A1.49,1.49,0,0,0,12,13Zm5-4V7A5,5,0,0,0,7,7V9a3,3,0,0,0-3,3v7a3,3,0,0,0,3,3H17a3,3,0,0,0,3-3V12A3,3,0,0,0,17,9ZM9,7a3,3,0,0,1,6,0V9H9Zm9,12a1,1,0,0,1-1,1H7a1,1,0,0,1-1-1V12a1,1,0,0,1,1-1H17a1,1,0,0,1,1,1Z"/>
                                                    </svg>
                                                </a>

                                                <a href="/admin/user/${user.id}" class="main__table-btn main__table-btn--edit">
                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M22,7.24a1,1,0,0,0-.29-.71L17.47,2.29A1,1,0,0,0,16.76,2a1,1,0,0,0-.71.29L13.22,5.12h0L2.29,16.05a1,1,0,0,0-.29.71V21a1,1,0,0,0,1,1H7.24A1,1,0,0,0,8,21.71L18.87,10.78h0L21.71,8a1.19,1.19,0,0,0,.22-.33,1,1,0,0,0,0-.24.7.7,0,0,0,0-.14ZM6.83,20H4V17.17l9.93-9.93,2.83,2.83ZM18.17,8.66,15.34,5.83l1.42-1.41,2.82,2.82Z"/></svg>
                                                </a>

                                                <form id="del-form-${user.id}" method="post" action="/admin/user/${user.id}/delete">
                                                    <input type="hidden" value="${_csrf.token}" name="_csrf">
                                                </form>

                                                <a href="#modal-delete" class="main__table-btn main__table-btn--delete open-modal" data-id="${user.id}">
                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                                        <path d="M10,18a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,10,18ZM20,6H16V5a3,3,0,0,0-3-3H11A3,3,0,0,0,8,5V6H4A1,1,0,0,0,4,8H5V19a3,3,0,0,0,3,3h8a3,3,0,0,0,3-3V8h1a1,1,0,0,0,0-2ZM10,5a1,1,0,0,1,1-1h2a1,1,0,0,1,1,1V6H10Zm7,14a1,1,0,0,1-1,1H8a1,1,0,0,1-1-1V8H17Zm-3-1a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,14,18Z"/>
                                                    </svg>
                                                </a>
                                        </div>
                                    <#else>
                                        <a href="/admin/user/${user.id}" class="main__table-btn main__table-btn--edit">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M21.92,11.6C19.9,6.91,16.1,4,12,4S4.1,6.91,2.08,11.6a1,1,0,0,0,0,.8C4.1,17.09,7.9,20,12,20s7.9-2.91,9.92-7.6A1,1,0,0,0,21.92,11.6ZM12,18c-3.17,0-6.17-2.29-7.9-6C5.83,8.29,8.83,6,12,6s6.17,2.29,7.9,6C18.17,15.71,15.17,18,12,18ZM12,8a4,4,0,1,0,4,4A4,4,0,0,0,12,8Zm0,6a2,2,0,1,1,2-2A2,2,0,0,1,12,14Z"/></svg>
                                        </a>
                                    </#if>
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
                    </#if>                </div>
            </div>
            <!-- end paginator -->
        </div>
    </div>

    <div id="modal-status" class="zoom-anim-dialog mfp-hide modal">
        <h6 class="modal__title">Status change</h6>

        <p class="modal__text">Are you sure about immediately change status?</p>

        <div class="modal__btns">
            <button class="modal__btn modal__btn--apply" type="button" data-id="0">Apply</button>
            <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
        </div>
    </div>
    <!-- end modal status -->

    <!-- modal delete -->
    <div id="modal-delete" class="zoom-anim-dialog mfp-hide modal">
        <h6 class="modal__title">User delete</h6>

        <p class="modal__text">Are you sure to permanently delete this user?</p>

        <div class="modal__btns">
            <button class="modal__btn modal__btn--apply" type="button">Delete</button>
            <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
        </div>
    </div>
</@c.page>
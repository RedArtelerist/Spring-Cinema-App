<#import "../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">
<#import "../parts/pager.ftlh" as p>

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
                        <div class="main__table-wrap">
                            <table class="main__table">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>ITEM</th>
                                    <th>AUTHOR</th>
                                    <th>TEXT</th>
                                    <th>LIKE / DISLIKE</th>
                                    <th>CREATED DATE</th>
                                    <th>ACTIONS</th>
                                </tr>
                                </thead>

                                <tbody>
                                <#list page.content as comment>
                                    <tr>
                                        <td>
                                            <div class="main__table-text">${comment.id}</div>
                                        </td>
                                        <td>
                                            <div class="main__table-text" style="min-width: 250px">
                                                <a href="/admin/movie/${comment.movie.id}/edit">${comment.movie.title}</a>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="main__table-text">
                                                <a href="/admin/user/${comment.user.id}">${comment.user.fullName()}</a>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="main__table-text comment_text">${comment.text}</div>
                                        </td>
                                        <td>
                                            <div class="main__table-text">${comment.countLikes()} / ${comment.countDislikes()}</div>
                                        </td>
                                        <td>
                                            <div class="main__table-text">${comment.createdAt?string["dd.MM.yyyy HH:mm"]}</div>
                                        </td>
                                        <td>
                                            <div class="main__table-btns">
                                                <a href="#modal-view${comment?index}" class="main__table-btn main__table-btn--view open-modal">
                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M21.92,11.6C19.9,6.91,16.1,4,12,4S4.1,6.91,2.08,11.6a1,1,0,0,0,0,.8C4.1,17.09,7.9,20,12,20s7.9-2.91,9.92-7.6A1,1,0,0,0,21.92,11.6ZM12,18c-3.17,0-6.17-2.29-7.9-6C5.83,8.29,8.83,6,12,6s6.17,2.29,7.9,6C18.17,15.71,15.17,18,12,18ZM12,8a4,4,0,1,0,4,4A4,4,0,0,0,12,8Zm0,6a2,2,0,1,1,2-2A2,2,0,0,1,12,14Z"/></svg>
                                                </a>
                                                <form id="del-form-${comment.id}" method="post" action="/admin/comment/${comment.id}/delete">
                                                    <input type="hidden" value="${_csrf.token}" name="_csrf">
                                                </form>
                                                <a href="#modal-delete" class="main__table-btn main__table-btn--delete open-modal" data-id="${comment.id}">
                                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M10,18a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,10,18ZM20,6H16V5a3,3,0,0,0-3-3H11A3,3,0,0,0,8,5V6H4A1,1,0,0,0,4,8H5V19a3,3,0,0,0,3,3h8a3,3,0,0,0,3-3V8h1a1,1,0,0,0,0-2ZM10,5a1,1,0,0,1,1-1h2a1,1,0,0,1,1,1V6H10Zm7,14a1,1,0,0,1-1,1H8a1,1,0,0,1-1-1V8H17Zm-3-1a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,14,18Z"/></svg>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>

                                </#list>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- end companies -->

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
            <!-- end content tabs -->
        </div>
    </div>

    <#list page.content as comment>
        <!-- modal view -->
        <div id="modal-view${comment?index}" class="zoom-anim-dialog mfp-hide modal modal--view">
            <div class="comments__autor">
                <img class="comments__avatar" src="${comment.user.imgUrl}" alt="">
                <span class="comments__name">${comment.user.fullName()}</span>
                <span class="comments__time">${comment.createdAt?string["dd.MM.yyyy, HH:mm"]}</span>
            </div>
            <p class="comments__text">${comment.text}</p>
            <div class="comments__actions">
                <div class="comments__rate">
                    <span><svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M11 7.3273V14.6537" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M14.6667 10.9905H7.33333" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path fill-rule="evenodd" clip-rule="evenodd" d="M15.6857 1H6.31429C3.04762 1 1 3.31208 1 6.58516V15.4148C1 18.6879 3.0381 21 6.31429 21H15.6857C18.9619 21 21 18.6879 21 15.4148V6.58516C21 3.31208 18.9619 1 15.6857 1Z" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg> ${comment.countLikes()}</span>

                    <span>${comment.countDislikes()}<svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M14.6667 10.9905H7.33333" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path fill-rule="evenodd" clip-rule="evenodd" d="M15.6857 1H6.31429C3.04762 1 1 3.31208 1 6.58516V15.4148C1 18.6879 3.0381 21 6.31429 21H15.6857C18.9619 21 21 18.6879 21 15.4148V6.58516C21 3.31208 18.9619 1 15.6857 1Z" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg></span>
                </div>
            </div>
        </div>
        <!-- end modal view -->
    </#list>

    <!-- modal delete -->
    <div id="modal-delete" class="zoom-anim-dialog mfp-hide modal">
        <h6 class="modal__title">Comment delete</h6>

        <p class="modal__text">Are you sure to permanently delete this comment?</p>

        <div class="modal__btns">
            <button class="modal__btn modal__btn--apply" type="button">Delete</button>
            <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
        </div>
    </div>
</@c.page>
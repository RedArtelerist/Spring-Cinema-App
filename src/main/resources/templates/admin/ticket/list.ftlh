<#import "../parts/common.ftlh" as c>
<#include "../../parts/security.ftlh">
<#import "../parts/pager.ftlh" as p>

<link href='http://fonts.googleapis.com/css?family=PT+Mono' rel='stylesheet' type='text/css'>
<!-- Roboto -->
<link href='http://fonts.googleapis.com/css?family=Roboto:400,700' rel='stylesheet' type='text/css'>

<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <h2>Tickets</h2>

                    <span class="main__title-stat">${total} total</span>

                    <div class="main__title-wrap">
                        <!-- search -->
                        <form id="filter-form" method="get" class="main__title-form">
                            <input name="search" type="text" value="${search!('')}" placeholder="Find ticket..">
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
                            <th>Number</th>
                            <th>Basic info</th>
                            <th>Personal info</th>
                            <th>Price</th>
                            <th>Booked date</th>
                            <th>User</th>
                        </tr>
                        </thead>

                        <tbody>
                        <#list page.content as ticket>
                            <tr>
                                <td>
                                    <div class="main__table-text">${ticket.number}</div>
                                </td>
                                <td>
                                    <div class="main__user">
                                        <div class="main__meta">
                                            <h3><a href="/admin/movie/${ticket.movie.id}/edit" style="color: white">${ticket.movie.title}</a></h3>
                                            <span><a href="/admin/cinema/${ticket.hall.cinema.id}/edit" style="color: rgba(255,255,255,0.7);">${ticket.hall.cinema.name}</a></span>
                                            <span>${ticket.date?string["dd.MM.yyyy HH:mm"]}</span>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="main__user">
                                        <div class="main__meta">
                                            <h3>${ticket.firstName} ${ticket.lastName}</h3>
                                            <span>${ticket.email}</span>
                                            <span>${ticket.phone}</span>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="main__table-text">₴${ticket.price?c}</div>
                                </td>
                                <td>
                                    <div class="main__table-text">${ticket.createdAt?string["dd.MM.yyyy HH:mm"]}</div>
                                </td>
                                <td>
                                    <div class="main__table-text"><#if ticket.user??><a href="/admin/user/${ticket.user.id}">${ticket.user.username}</a><#else>-</#if></div>
                                </td>
                                <td>
                                    <div class="main__table-btns">
                                        <a href="#modal-view${ticket?index}" class="main__table-btn main__table-btn--view open-modal">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M21.92,11.6C19.9,6.91,16.1,4,12,4S4.1,6.91,2.08,11.6a1,1,0,0,0,0,.8C4.1,17.09,7.9,20,12,20s7.9-2.91,9.92-7.6A1,1,0,0,0,21.92,11.6ZM12,18c-3.17,0-6.17-2.29-7.9-6C5.83,8.29,8.83,6,12,6s6.17,2.29,7.9,6C18.17,15.71,15.17,18,12,18ZM12,8a4,4,0,1,0,4,4A4,4,0,0,0,12,8Zm0,6a2,2,0,1,1,2-2A2,2,0,0,1,12,14Z"/></svg>
                                        </a>
                                        <form id="del-form-${ticket.number}" method="post" action="/admin/ticket/${ticket.number}/delete">
                                            <input type="hidden" value="${_csrf.token}" name="_csrf">
                                        </form>
                                        <a href="#modal-delete" class="main__table-btn main__table-btn--delete open-modal" data-id="${ticket.number}">
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

    <#list page.content as ticket>
        <!-- modal view -->
        <div id="modal-view${ticket?index}" class="zoom-anim-dialog mfp-hide modal modal--view" style="color: white; max-width: 800px">
            <div class="ticket">
                <div class="ticket-position">
                    <div class="ticket__indecator indecator--pre"><div class="indecator-text pre--text">online ticket</div> </div>
                    <div class="ticket__inner">

                        <div class="ticket-secondary">
                            <span class="ticket__item">Ticket number <strong class="ticket__number">${ticket.number}</strong></span>
                            <span class="ticket__item ticket__date">${ticket.date?string["dd/MM/yyyy"]}</span>
                            <span class="ticket__item ticket__time">${ticket.date?string["HH:mm"]}</span>
                            <span class="ticket__item">Cinema: <span class="ticket__cinema">${ticket.hall.cinema.name}</span></span>
                            <span class="ticket__item">Hall: <span class="ticket__hall">${ticket.hall.name}</span></span>
                            <span class="ticket__item ticket__price">price: <strong class="ticket__cost">₴${ticket.price?c}</strong></span>
                        </div>

                        <div class="ticket-primery">
                            <span class="ticket__item ticket__item--primery ticket__film">Film<br><strong class="ticket__movie">${ticket.movie.title}</strong></span>
                            <span class="ticket__item ticket__item--primery">Sits: <span class="ticket__place">${ticket.seats}</span></span>
                        </div>


                    </div>
                    <div class="ticket__indecator indecator--post"><div class="indecator-text post--text">online ticket</div></div>
                </div>
            </div>
        </div>
        <!-- end modal view -->
    </#list>

    <!-- modal delete -->
    <div id="modal-delete" class="zoom-anim-dialog mfp-hide modal">
        <h6 class="modal__title">Ticket delete</h6>

        <p class="modal__text">Are you sure to permanently delete this user?</p>

        <div class="modal__btns">
            <button class="modal__btn modal__btn--apply" type="button">Delete</button>
            <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
        </div>
    </div>
</@c.page>
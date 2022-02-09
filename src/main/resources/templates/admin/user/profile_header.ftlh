<#assign canEdit = isOwner && uuser.id != currentUserId || (isAdmin && uuser.isAdmin()=false && uuser.roles?seq_contains("OWNER")=false)>

<!-- profile -->
<div class="col-12">
    <div class="profile__content">
        <!-- profile user -->
        <div class="profile__user">
            <div class="profile__avatar">
                <img src="${uuser.imgUrl}" alt="">
            </div>
            <!-- or red -->
            <div class="profile__meta profile__meta--<#if uuser.locked>red<#else>green</#if>">
                <h3>${uuser.username} <span><#if uuser.locked>(Banned)<#else>(Approved)</#if></span></h3>
                <span>ID: ${uuser.id}</span>
            </div>
        </div>
        <!-- end profile user -->

        <!-- profile tabs nav -->
        <ul class="nav nav-tabs profile__tabs" id="profile__tabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link <#if title_user == "profile">active</#if>" href="/admin/user/${uuser.id}">Profile</a>
            </li>

            <li class="nav-item">
                <a class="nav-link <#if title_user == "comments">active</#if>" href="/admin/user/${uuser.id}/comments">Comments</a>
            </li>

            <li class="nav-item">
                <a class="nav-link <#if title_user == "tickets">active</#if>" href="/admin/user/${uuser.id}/tickets">Tickets</a>
            </li>
        </ul>
        <!-- end profile tabs nav -->

        <!-- profile mobile tabs nav -->
        <div class="profile__mobile-tabs" id="profile__mobile-tabs">
            <div class="profile__mobile-tabs-btn dropdown-toggle" role="navigation" id="mobile-tabs" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <input type="button" value="Profile">
                <span></span>
            </div>

            <div class="profile__mobile-tabs-menu dropdown-menu" aria-labelledby="mobile-tabs">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item"><a class="nav-link <#if title == "profile">active</#if>" id="1-tab" href="/admin/user/${uuser.id}">Profile</a></li>

                    <li class="nav-item"><a class="nav-link <#if title == "comments">active</#if>" id="2-tab" href="/admin/user/${uuser.id}/comments">Comments</a></li>

                    <li class="nav-item"><a class="nav-link <#if title == "tickets">active</#if>" id="3-tab" href="/admin/user/${uuser.id}/tickets">Tickets</a></li>
                </ul>
            </div>
        </div>
        <!-- end profile mobile tabs nav -->

        <!-- profile btns -->
        <#if canEdit>
            <div class="profile__actions">
                <a href="#modal-status3" class="profile__action profile__action--banned open-modal"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M12,13a1.49,1.49,0,0,0-1,2.61V17a1,1,0,0,0,2,0V15.61A1.49,1.49,0,0,0,12,13Zm5-4V7A5,5,0,0,0,7,7V9a3,3,0,0,0-3,3v7a3,3,0,0,0,3,3H17a3,3,0,0,0,3-3V12A3,3,0,0,0,17,9ZM9,7a3,3,0,0,1,6,0V9H9Zm9,12a1,1,0,0,1-1,1H7a1,1,0,0,1-1-1V12a1,1,0,0,1,1-1H17a1,1,0,0,1,1,1Z"/></svg></a>
                <a href="#modal-delete3" class="profile__action profile__action--delete open-modal"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M10,18a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,10,18ZM20,6H16V5a3,3,0,0,0-3-3H11A3,3,0,0,0,8,5V6H4A1,1,0,0,0,4,8H5V19a3,3,0,0,0,3,3h8a3,3,0,0,0,3-3V8h1a1,1,0,0,0,0-2ZM10,5a1,1,0,0,1,1-1h2a1,1,0,0,1,1,1V6H10Zm7,14a1,1,0,0,1-1,1H8a1,1,0,0,1-1-1V8H17Zm-3-1a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,14,18Z"/></svg></a>
            </div>
        </#if>
        <!-- end profile btns -->
    </div>
</div>
<!-- end profile -->

<#if canEdit>
    <div id="modal-status3" class="zoom-anim-dialog mfp-hide modal">
        <h6 class="modal__title">Status change</h6>

        <p class="modal__text">Are you sure about immediately change status?</p>

        <div class="modal__btns">
            <form action="/admin/user/${uuser.id}/ban" method="post" style="width: 165px">
                <input type="hidden" value="${_csrf.token}" name="_csrf">
                <button style="width: 100%" class="modal__btn modal__btn--apply" type="submit">Apply</button>
            </form>
            <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
        </div>
    </div>
    <!-- end modal status -->

    <!-- modal delete -->
    <div id="modal-delete3" class="zoom-anim-dialog mfp-hide modal">
        <h6 class="modal__title">User delete</h6>

        <p class="modal__text">Are you sure to permanently delete this user?</p>

        <div class="modal__btns">
            <form action="/admin/user/${uuser.id}/delete" method="post" style="width: 165px">
                <input type="hidden" value="${_csrf.token}" name="_csrf">
                <button style="width: 100%" class="modal__btn modal__btn--apply" type="submit">Delete</button>
            </form>
            <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
        </div>
    </div>


    <#if uuser.imageName??>
        <div id="modal-delete-img" class="zoom-anim-dialog mfp-hide modal">
            <h6 class="modal__title">Image delete</h6>

            <p class="modal__text">Are you sure to permanently delete user's image?</p>

            <div class="modal__btns">
                <form action="/admin/user/${uuser.id}/delete_img" method="post" style="width: 165px">
                    <input type="hidden" value="${_csrf.token}" name="_csrf">
                    <button style="width: 100%" class="modal__btn modal__btn--apply" type="submit">Delete</button>
                </form>
                <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
            </div>
        </div>
    </#if>
</#if>
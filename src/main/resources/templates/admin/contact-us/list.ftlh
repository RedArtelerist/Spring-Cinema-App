<#import "../parts/common.ftlh" as c>
<#import "../parts/pager.ftlh" as p>


<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <h2>Messages</h2>

                    <span class="main__title-stat">${total} total</span>
                </div>
            </div>
            <!-- end main title -->

            <#if message??>
                <div class="alert fade_${messageType} .fade"> <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                    <strong>${message}</strong>
                </div>
            </#if>

            <!-- companies -->
            <div class="col-12">
                <div class="main__table-wrap">
                    <table class="main__table">
                        <thead>
                        <tr>
                            <th>Id</th>
                            <th>Email</th>
                            <th>Name</th>
                            <th>Text</th>
                            <th>Created date</th>
                            <th>Action</th>
                        </tr>
                        </thead>

                        <tbody>
                        <#list page.content as msg>
                            <tr>
                                <td>
                                    <div class="main__table-text">${msg.id}</div>
                                </td>
                                <td>
                                    <div class="main__table-text">${msg.email}</div>
                                </td>
                                <td>
                                    <div class="main__table-text" style="width: 265px">${msg.name}</div>
                                </td>
                                <td>
                                    <div class="main__table-text comment_text">${msg.text}</div>
                                </td>
                                <td>
                                    <div class="main__table-text">${msg.createdAt?string["dd.MM.yyyy HH:mm"]}</div>
                                </td>
                                <td>
                                    <div class="main__table-btns">
                                        <a href="#modal-view${msg?index}" class="main__table-btn main__table-btn--view open-modal">
                                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M21.92,11.6C19.9,6.91,16.1,4,12,4S4.1,6.91,2.08,11.6a1,1,0,0,0,0,.8C4.1,17.09,7.9,20,12,20s7.9-2.91,9.92-7.6A1,1,0,0,0,21.92,11.6ZM12,18c-3.17,0-6.17-2.29-7.9-6C5.83,8.29,8.83,6,12,6s6.17,2.29,7.9,6C18.17,15.71,15.17,18,12,18ZM12,8a4,4,0,1,0,4,4A4,4,0,0,0,12,8Zm0,6a2,2,0,1,1,2-2A2,2,0,0,1,12,14Z"/></svg>
                                        </a>
                                        <form id="del-form-${msg.id}" method="post" action="/admin/message/${msg.id}/delete">
                                            <input type="hidden" value="${_csrf.token}" name="_csrf">
                                        </form>
                                        <a href="#modal-delete" class="main__table-btn main__table-btn--delete open-modal" data-id="${msg.id}">
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

    <#list page.content as msg>
        <!-- modal view -->
        <div id="modal-view${msg?index}" class="zoom-anim-dialog mfp-hide modal modal--view">
            <div class="comments__autor">
                <img class="comments__avatar" src="https://firebasestorage.googleapis.com/v0/b/spring-project-31341.appspot.com/o/users%2Fdefault.png?alt=media" alt="">
                <span class="comments__name">${msg.name}</span>
                <span class="comments__name">${msg.email}</span>
                <span class="comments__time">${msg.createdAt?string["dd.MM.yyyy, HH:mm"]}</span>
            </div>
            <p class="comments__text">${msg.text}</p>
            <div class="col-12">
                <form action="/admin/message/${msg.id}/answer" method="post" class="answer-form">
                    <input type="hidden" value="${_csrf.token}" name="_csrf">
                    <div class="form__group">
                        <textarea id="text" name="text" class="form__textarea" style="background-color: #131720" placeholder="Answer"></textarea>
                    </div>
                    <button type="submit" class="form__btn" style="margin-top: -10px; margin-bottom: 10px; float: right">Answer</button>
                </form>
            </div>
        </div>
        <!-- end modal view -->
    </#list>

    <!-- modal delete -->
    <div id="modal-delete" class="zoom-anim-dialog mfp-hide modal">
        <h6 class="modal__title">Message delete</h6>

        <p class="modal__text">Are you sure to permanently delete this message?</p>

        <div class="modal__btns">
            <button class="modal__btn modal__btn--apply" type="button">Delete</button>
            <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
        </div>
    </div>
</@c.page>

<script>
    $("form").on('submit', function(e){
        console.log("Validate");
        var text = $(this).find("#text");
        var value = text.val().trim();
        if(value < 10 || value > 1000){
            $(text).addClass("is-invalid");
            if(!$(text).next().hasClass("invalid-feedback"))
                $(text).after("<div class='invalid-feedback'>Answer must be between 10 and 1000 characters</div>")
            return false;
        }
    });
</script>
<#import "../parts/common.ftlh" as c>

<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <h2>Hall detail</h2>
                    <div class="main__title-wrap">
                        <a href="/admin/cinema/${hall.cinema.id}/edit" class="main__title-link">return</a>
                    </div>
                </div>
            </div>

            <div class="col-12">
                <div class="profile__content">
                    <!-- profile user -->
                    <div class="profile__user">
                        <!-- or red -->
                        <div class="profile__meta profile__meta--green">
                            <h3>Cinema: ${hall.cinema.name}, Hall: ${hall.name} <#if hall.active><span>(Visible)</span><#else><span style="color: #eb5757">(Hidden)</span></#if></h3>
                            <span>Capacity: ${hall.numSeats} seats</span>
                            <span>Amount of seats: ${hall.countSeats()}</span>
                        </div>
                    </div>

                    <!-- profile btns -->
                    <div class="profile__actions">
                        <a href="#modal-delete" class="profile__action profile__action--delete open-modal">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M10,18a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,10,18ZM20,6H16V5a3,3,0,0,0-3-3H11A3,3,0,0,0,8,5V6H4A1,1,0,0,0,4,8H5V19a3,3,0,0,0,3,3h8a3,3,0,0,0,3-3V8h1a1,1,0,0,0,0-2ZM10,5a1,1,0,0,1,1-1h2a1,1,0,0,1,1,1V6H10Zm7,14a1,1,0,0,1-1,1H8a1,1,0,0,1-1-1V8H17Zm-3-1a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,14,18Z"/></svg>
                        </a>
                    </div>
                    <!-- end profile btns -->

                    <div id="modal-delete" class="zoom-anim-dialog mfp-hide modal">
                        <h6 class="modal__title">Hall delete</h6>

                        <p class="modal__text">Are you sure to permanently delete this hall?</p>

                        <div class="modal__btns">
                            <form action="/admin/hall/${hall.id}/delete" method="post" style="width: 165px">
                                <input type="hidden" value="${_csrf.token}" name="_csrf">
                                <button style="width: 100%" class="modal__btn modal__btn--apply" type="submit">Delete</button>
                            </form>
                            <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- end main title -->

            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="tab-1" role="tabpanel" aria-labelledby="1-tab">
                    <div class="col-12">
                        <div class="sign__wrap">
                            <div class="row">
                                <!-- details form -->
                                <div class="col-12 col-lg-6">
                                    <form id="row_form" method="post" class="sign__form sign__form--profile sign__form--first">
                                        <input id="id" type="hidden" value="<#if row?? && row.id??>${row.id}</#if>" name="id">
                                        <input type="hidden" value="${_csrf.token}" name="_csrf">

                                        <div class="row">
                                            <div class="col-12">
                                                <#if row?? && row.id??>
                                                    <h4 class="sign__title">Edit row</h4>
                                                <#else>
                                                    <h4 class="sign__title">Add row</h4>
                                                </#if>
                                            </div>

                                            <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                                <div class="sign__group">
                                                    <label class="sign__label" for="name">Name</label>
                                                    <input id="name" name="name" type="text" class="form__input ${(nameError??)?string('is-invalid', '')}"
                                                           value="<#if row??>${row.name}</#if>">

                                                    <#if nameError??>
                                                        <div class="invalid-feedback">
                                                            ${nameError}
                                                        </div>
                                                    </#if>
                                                </div>
                                            </div>

                                            <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                                <div class="sign__group">
                                                    <label class="sign__label" for="numSeats">Amount of seats</label>
                                                    <input id="numSeats" name="numSeats" type="number" class="form__input ${(numSeatsError??)?string('is-invalid', '')}"
                                                           value="<#if row??>${(row.numSeats?c)!''}</#if>">

                                                    <#if numSeatsError??>
                                                        <div class="invalid-feedback">
                                                            ${numSeatsError}
                                                        </div>
                                                    </#if>
                                                </div>
                                            </div>


                                            <div class="col-12 col-md-6 col-lg-12 col-xl-6">
                                                <div class="sign__group">
                                                    <label class="sign__label" for="type">Row type</label>
                                                    <select name="type" class="js-example-basic-single" id="type">
                                                        <#list types as type>
                                                            <option value="${type}" <#if row?? && row.type == type>selected</#if>>${type}</option>
                                                        </#list>
                                                    </select>
                                                </div>
                                            </div>


                                            <div class="col-12">
                                                <div class="row">
                                                    <div class="col-6">
                                                        <button class="sign__btn" type="submit">Submit</button>
                                                    </div>
                                                    <#if row?? && row.id??>
                                                        <div class="col-6">
                                                            <a href="/admin/hall/${hall.id}" style="float: right" class="sign__btn">Cancel</a>
                                                        </div>
                                                    </#if>
                                                </div>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </div>

                            <div class="row">
                                <div class="main__table-wrap">
                                    <table class="main__table">
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <div class="choose-sits">

                                                        <div class="choose-sits__info choose-sits__info--first">
                                                            <ul>
                                                                <li class="sits-price marker--none"><strong>Seat type:</strong></li>
                                                                <li class="sits-price sits-price--cheap">Standard</li>
                                                                <li class="sits-price sits-price--middle">Vip</li>
                                                                <li class="sits-price sits-price--expensive">Premium</li>
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
                                                                                <span class="sits__place <#if seat.type == 'Standard'>sits-price--cheap<#elseif seat.type == 'Vip'>sits-price--middle<#else>sits-price--expensive</#if>" data-place='${row.name}${seat.number}'>${row.name}${seat.number}</span>
                                                                            </#list>
                                                                        </div>
                                                                    </#list>

                                                                    <aside class="sits__line__right">
                                                                        <#list rows as row>
                                                                            <div style="display: flex">
                                                                            <span class="sits__indecator">
                                                                                <form method="post" action="/admin/row/${row.id}/delete">
                                                                                    <input type="hidden" value="${_csrf.token}" name="_csrf">
                                                                                    <button type="submit">
                                                                                        <svg style="width: 20px; height: auto; margin-top: -4px; fill: #eb5757;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M10,18a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,10,18ZM20,6H16V5a3,3,0,0,0-3-3H11A3,3,0,0,0,8,5V6H4A1,1,0,0,0,4,8H5V19a3,3,0,0,0,3,3h8a3,3,0,0,0,3-3V8h1a1,1,0,0,0,0-2ZM10,5a1,1,0,0,1,1-1h2a1,1,0,0,1,1,1V6H10Zm7,14a1,1,0,0,1-1,1H8a1,1,0,0,1-1-1V8H17Zm-3-1a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,14,18Z"/></svg>
                                                                                    </button>
                                                                                </form>
                                                                            </span>

                                                                            <span class="sits__indecator">
                                                                                <a style="cursor: pointer" onclick="edit(this, ${row.id}, '${row.name}', ${row.numSeats}, '${row.type}')">
                                                                                    <svg style="width: 20px; height: auto; margin-top: -4px; fill: #2f80ed" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M22,7.24a1,1,0,0,0-.29-.71L17.47,2.29A1,1,0,0,0,16.76,2a1,1,0,0,0-.71.29L13.22,5.12h0L2.29,16.05a1,1,0,0,0-.29.71V21a1,1,0,0,0,1,1H7.24A1,1,0,0,0,8,21.71L18.87,10.78h0L21.71,8a1.19,1.19,0,0,0,.22-.33,1,1,0,0,0,0-.24.7.7,0,0,0,0-.14ZM6.83,20H4V17.17l9.93-9.93,2.83,2.83ZM18.17,8.66,15.34,5.83l1.42-1.41,2.82,2.82Z"/></svg>
                                                                                </a>
                                                                            </span>
                                                                            </div>
                                                                        </#list>
                                                                    </aside>

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
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</@c.page>

<script>
    function edit(e, id, name, num, type){
        $("#id").val(id);
        $("#name").val(name);
        $("#numSeats").val(num);
        $("#type").val(type).change();

        $("#row_form .sign__title").text("Edit row");
        var row = $("#row_form .col-12").last().children()[0];

        var btn = $("<div class='col-6'><a href='/admin/hall/" + ${hall.id} + "' style='float: right' class='sign__btn'>Cancel</a></div>")
        console.log($(row).find("a"));
        if($(row).find("a").length == 0)
            $(btn).appendTo($(row));
    }
</script>
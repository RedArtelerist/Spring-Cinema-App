<#import "../parts/common.ftlh" as c>

<@c.page>
    <div class="container-fluid">
        <div class="row">
            <!-- main title -->
            <div class="col-12">
                <div class="main__title">
                    <#if cinema?? && cinema.id??>
                        <h2>Edit cinema</h2>
                    <#else>
                        <h2>Add new cinema</h2>
                    </#if>
                    <div class="main__title-wrap">
                        <a href="/admin/cinemas" class="main__title-link">all cinemas</a>
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
                                    <div class="form__img" style="height: 270px">
                                        <label for="form__img-upload">Upload cover (200 x 200)</label>
                                        <input name="image" id="form__img-upload" type="file" accept=".png, .jpg, .jpeg">
                                        <img id="form__img" src="<#if cinema??>${cinema.imageUrl}</#if>" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-7 form__content">
                            <div class="row">
                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="name" type="text" class="form__input ${(nameError??)?string('is-invalid', '')}"
                                               placeholder="Name" value="<#if cinema??>${cinema.name}</#if>">

                                        <#if nameError??>
                                            <div class="invalid-feedback">
                                                ${nameError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <select name="city" class="js-example-basic-single" id="city">
                                            <#list cities as city>
                                                <option value="${city}" <#if cinema?? && cinema.city == city>selected</#if>>${city}</option>
                                            </#list>
                                        </select>
                                    </div>
                                </div>


                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="address" type="text" class="form__input ${(addressError??)?string('is-invalid', '')}"
                                               placeholder="Address" value="<#if cinema??>${cinema.address}</#if>">

                                        <#if addressError??>
                                            <div class="invalid-feedback">
                                                ${addressError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input id="phone" name="phone" type="text" class="form__input ${(phoneError??)?string('is-invalid', '')}"
                                               placeholder="Phone" value="<#if cinema??>${cinema.phone}</#if>">

                                        <#if phoneError??>
                                            <div class="invalid-feedback">
                                                ${phoneError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="latitude" type="number" step="0.0000000000000001" class="form__input ${(latitudeError??)?string('is-invalid', '')}"
                                               placeholder="Latitude" value="<#if cinema??>${(cinema.latitude?c)!''}</#if>">

                                        <#if latitudeError??>
                                            <div class="invalid-feedback">
                                                ${latitudeError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>


                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="longitude" type="number" step="0.0000000000000001" class="form__input ${(longitudeError??)?string('is-invalid', '')}"
                                               placeholder="Longitude" value="<#if cinema??>${(cinema.longitude?c)!''}</#if>">

                                        <#if longitudeError??>
                                            <div class="invalid-feedback">
                                                ${longitudeError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12 col-sm-6 col-lg-6">
                                    <div class="form__group">
                                        <input name="rating" type="number" step="0.1" min="1.0" max="5.0" class="form__input ${(ratingError??)?string('is-invalid', '')}"
                                               placeholder="Rating" value="<#if cinema??>${(cinema.rating?c)!''}</#if>">

                                        <#if ratingError??>
                                            <div class="invalid-feedback">
                                                ${ratingError}
                                            </div>
                                        </#if>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <ul class="form__radio">
                                        <li>
                                            <span>Cinema status:</span>
                                        </li>
                                        <li>
                                            <input id="type1" value="true" type="radio" name="active" <#if cinema?? && cinema.active>checked<#else>checked</#if>>
                                            <label for="type1">Visible</label>
                                        </li>
                                        <li>
                                            <input id="type2" value="false" type="radio" name="active" <#if cinema?? && !cinema.active>checked</#if>>
                                            <label for="type2">Hidden</label>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="row">
                                <div class="col-12">
                                    <div id='cinema-map'></div>

                                    <div class="form__gallery">
                                        <label id="gallery1" for="form__gallery-upload">Upload photos</label>
                                        <input data-name="#gallery1" id="form__gallery-upload" name="images" class="form__gallery-upload" type="file" accept=".png, .jpg, .jpeg" multiple>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="row">
                                        <button type="submit" class="form__btn">publish</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </form>
            </div>
            <!-- end form -->
            <#if cinema?? && cinema.id??>
                <div class="container-fluid">
                    <div class="row">
                        <!-- main title -->
                        <div class="col-12">
                            <div class="main__title">
                                <h2>Halls</h2>
                                <div class="main__title-wrap">
                                    <a href="/admin/cinema/${cinema.id}/seances" class="main__title-link">seances</a>
                                </div>
                                <div class="main__title-wrap">
                                    <a id="btn-hall-open-modal" href="#modal-hall" class="main__title-link open-modal">add hall</a>
                                </div>
                            </div>
                        </div>
                        <#if message??>
                            <div class="alert fade_${messageType} .fade">
                                <button aria-hidden="true" data-dismiss="alert" class="close" type="button">×</button>
                                <strong>${message}</strong>
                            </div>
                        </#if>
                        <div class="col-12">
                            <div class="row">
                                <div class="main__table-wrap">
                                    <table class="main__table">
                                        <thead>
                                        <tr>
                                            <th>Id</th>
                                            <th>Name</th>
                                            <th>Num seats</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                        </thead>

                                        <tbody id="halls">
                                        <#if cinema.halls?has_content>
                                            <#list cinema.halls as hall>
                                                <tr>
                                                    <td>
                                                        <div class="main__table-text">${hall.id}</div>
                                                    </td>
                                                    <td>
                                                        <div class="main__table-text">${hall.name}</div>
                                                    </td>
                                                    <td>
                                                        <div class="main__table-text">${hall.numSeats}</div>
                                                    </td>
                                                    <td>
                                                        <#if hall.active>
                                                            <div class="main__table-text main__table-text--green">Visible</div>
                                                        <#else>
                                                            <div class="main__table-text main__table-text--red">Hidden</div>
                                                        </#if>
                                                    </td>
                                                    <td>
                                                        <div class="main__table-btns">
                                                            <a href="/admin/hall/${hall.id}" class="main__table-btn main__table-btn--view">
                                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M21.92,11.6C19.9,6.91,16.1,4,12,4S4.1,6.91,2.08,11.6a1,1,0,0,0,0,.8C4.1,17.09,7.9,20,12,20s7.9-2.91,9.92-7.6A1,1,0,0,0,21.92,11.6ZM12,18c-3.17,0-6.17-2.29-7.9-6C5.83,8.29,8.83,6,12,6s6.17,2.29,7.9,6C18.17,15.71,15.17,18,12,18ZM12,8a4,4,0,1,0,4,4A4,4,0,0,0,12,8Zm0,6a2,2,0,1,1,2-2A2,2,0,0,1,12,14Z"/></svg>
                                                            </a>

                                                            <a href="#modal-hall" class="main__table-btn main__table-btn--edit open-modal" onclick="edit(this, '${hall.id}', '${hall.name}', '${hall.numSeats}', <#if hall.active>true<#else>false</#if>)">
                                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="M22,7.24a1,1,0,0,0-.29-.71L17.47,2.29A1,1,0,0,0,16.76,2a1,1,0,0,0-.71.29L13.22,5.12h0L2.29,16.05a1,1,0,0,0-.29.71V21a1,1,0,0,0,1,1H7.24A1,1,0,0,0,8,21.71L18.87,10.78h0L21.71,8a1.19,1.19,0,0,0,.22-.33,1,1,0,0,0,0-.24.7.7,0,0,0,0-.14ZM6.83,20H4V17.17l9.93-9.93,2.83,2.83ZM18.17,8.66,15.34,5.83l1.42-1.41,2.82,2.82Z"/></svg>
                                                            </a>

                                                            <form id="del-form-${hall.id}" method="post" action="/admin/hall/${hall.id}/delete">
                                                                <input type="hidden" value="${_csrf.token}" name="_csrf">
                                                            </form>

                                                            <a href="#modal-delete" class="main__table-btn main__table-btn--delete open-modal" data-id="${hall.id}">
                                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                                                                    <path d="M10,18a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,10,18ZM20,6H16V5a3,3,0,0,0-3-3H11A3,3,0,0,0,8,5V6H4A1,1,0,0,0,4,8H5V19a3,3,0,0,0,3,3h8a3,3,0,0,0,3-3V8h1a1,1,0,0,0,0-2ZM10,5a1,1,0,0,1,1-1h2a1,1,0,0,1,1,1V6H10Zm7,14a1,1,0,0,1-1,1H8a1,1,0,0,1-1-1V8H17Zm-3-1a1,1,0,0,0,1-1V11a1,1,0,0,0-2,0v6A1,1,0,0,0,14,18Z"/>
                                                                </svg>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </#list>
                                        </#if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- modal delete -->
                <div id="modal-hall" class="zoom-anim-dialog mfp-hide modal" style="background-color: #414c65">
                    <h6 class="modal__title">Add/Edit hall</h6>
                    <form method="post" action="/admin/hall/create" id="hall_form">
                        <input type="hidden" value="${_csrf.token}" name="_csrf">
                        <input type="hidden" value="${cinema.id}" name="cinema">
                        <input type="hidden" value="<#if hallId??>${hallId}</#if>" name="id">

                        <div class="col-12">
                            <div class="form__group">
                                <input name="name" type="text" class="form__input ${(hallNameError??)?string('is-invalid', '')}"
                                       placeholder="Name" value="<#if hallName??>${hallName}</#if>">

                                <#if hallNameError??>
                                    <div class="invalid-feedback">
                                        ${hallNameError}
                                    </div>
                                </#if>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="form__group">
                                <input name="numSeats" type="number" class="form__input ${(numSeatsError??)?string('is-invalid', '')}"
                                       placeholder="Num seats" value="<#if hallNum??>${(hallNum?c)!''}</#if>">

                                <#if numSeatsError??>
                                    <div class="invalid-feedback">
                                        ${numSeatsError}
                                    </div>
                                </#if>
                            </div>
                        </div>

                        <div class="col-12">
                            <div class="sign__group sign__group--checkbox">
                                <input id="remember" name="active" type="checkbox" <#if hallActive?? && hallActive>checked</#if>>
                                <label for="remember">Active?</label>
                            </div>
                        </div>

                        <div class="modal__btns">
                            <button id="create_hall_btn" class="modal__btn modal__btn--apply" type="submit">Submit</button>
                            <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
                        </div>
                    </form>
                </div>

                <div id="modal-delete" class="zoom-anim-dialog mfp-hide modal">
                    <h6 class="modal__title">Hall delete</h6>

                    <p class="modal__text">Are you sure to permanently delete this hall?</p>

                    <div class="modal__btns">
                        <button class="modal__btn modal__btn--apply" type="button">Delete</button>
                        <button class="modal__btn modal__btn--dismiss" type="button">Dismiss</button>
                    </div>
                </div>
            </#if>

            <#if cinema?? && cinema.gallery?size gt 0>
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
                                <#list cinema.gallery as item>
                                    <div class="col-12 col-md-5 form__cover">
                                        <div class="row">
                                            <form id="img_item_gallery" method="post" action="/admin/cinema/${cinema.id}/image/${item.id}/delete">
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

<#if hallNameError?? || numSeatsError??>
    <script>
        $(document).ready(function() {
            $("#btn-hall-open-modal").click();
        });
    </script>
</#if>

<script>
    function edit(e, id, name, numSeats, active){
        clear();
        console.log(id, name, numSeats, active);
        $("#hall_form input[name='id']").val(id);
        $("#hall_form input[name='name']").val(name);
        $("#hall_form input[name='numSeats']").val(numSeats);
        $("#hall_form input[name='active']").prop("checked", active);
    }

    $("#modal-hall").on("click", ".modal__btn--dismiss", function (e){
        console.log("dismiss");
        clear();
    });

    function clear(){
        var idField = $("#hall_form [name='id']");
        var nameField = $("#hall_form [name='name']");
        var numSeats = $("#hall_form [name='numSeats']");
        var activeField = $("#hall_form [name='active']");

        idField.val('');

        nameField.val('');
        nameField.removeClass("is-invalid");
        nameField.next().text('').css("display", "none");

        numSeats.val('');
        numSeats.removeClass("is-invalid");
        numSeats.next().text('').css("display", "none");

        activeField.prop("checked", false);
    }
</script>

<script>
    function initialize() {
        var slat, slng;
        <#if cinema?? && cinema.latitude?? && cinema.longitude??>
            slat = ${cinema.latitude?c};
            slng = ${cinema.longitude?c};
        <#else>
            slat = 50.4385;
            slng = 30.5334;
        </#if>
        console.log(slat, " ", slng);
        var mapOptions, map, marker, searchBox,
            infoWindow = '',
            addressEl = document.querySelector('input[name="address"]' ),
            latEl = document.querySelector('input[name="latitude"]'),
            longEl = document.querySelector('input[name="longitude"]'),
            element = document.getElementById('cinema-map');

        mapOptions = {
            zoom: 10,
            center: new google.maps.LatLng(slat, slng),
            navigationControl: false,
            streetViewControl: false,
            mapTypeControl: false,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };

        map = new google.maps.Map(element, mapOptions);

        marker = new google.maps.Marker({
            position: mapOptions.center,
            map: map,
            draggable: true
        });

        searchBox = new google.maps.places.SearchBox( addressEl );

        google.maps.event.addListener( searchBox, 'places_changed', function () {
            var places = searchBox.getPlaces(),
                bounds = new google.maps.LatLngBounds(),
                i, place, lat, long;
                addresss = places[0].formatted_address;

            for(i = 0; place = places[i]; i++ ) {
                bounds.extend( place.geometry.location );
                marker.setPosition( place.geometry.location );
            }

            map.fitBounds( bounds );
            map.setZoom( 15 );

            lat = marker.getPosition().lat();
            long = marker.getPosition().lng();
            latEl.value = lat;
            longEl.value = long;

            if (infoWindow){
                infoWindow.close();
            }

            infoWindow = new google.maps.InfoWindow({
                content: addresss
            });

            infoWindow.open(map, marker);
        });

        google.maps.event.addListener(marker, "dragend", function (event) {
            var lat, long, address, resultArray;

            lat = marker.getPosition().lat();
            long = marker.getPosition().lng();

            var geocoder = new google.maps.Geocoder();
            geocoder.geocode( { latLng: marker.getPosition() }, function (result, status) {
                if ('OK' === status){
                    address = result[0].formatted_address;
                    resultArray =  result[0].address_components;
                    addressEl.value = address;
                    latEl.value = lat;
                    longEl.value = long;
                } else {
                    console.log('Geocode was not successful for the following reason: ' + status );
                }

                if (infoWindow) {
                    infoWindow.close();
                }

                infoWindow = new google.maps.InfoWindow({
                    content: address
                });

                infoWindow.open(map, marker);
            });
        });
    }
</script>

<script async defer src="https://maps.google.com/maps/api/js?key=AIzaSyDmTU3PdXiLiXqNDbHDOeEfCU4iq7UShDE&libraries=places&callback=initialize&language=en"></script>

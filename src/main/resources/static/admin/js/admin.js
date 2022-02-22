$(document).ready(function () {
	"use strict"; // start of use strict

	/*==============================
	Menu
	==============================*/
	$('.header__btn').on('click', function() {
		$(this).toggleClass('header__btn--active');
		$('.header').toggleClass('header--active');
		$('.sidebar').toggleClass('sidebar--active');
	});

	/*==============================
	Filter
	==============================*/
	$('.filter__item-menu li').each( function() {
		$(this).attr('data-value', $(this).text().toLowerCase());
	});

	$('#filter__sort .filter__item-menu li').on('click', function() {
		var text = $(this).text();
		var item = $(this);
		var id = item.closest('.filter').attr('id');
		$('#'+id).find('.filter__item-btn input').val(text);
		$('#filter-form').find('input[name="sort"]').val(text);

		$('#filter-form').submit();
	});

	$('#filter__date .filter__item-menu li').on('click', function() {
		var text = $(this).text();
		var item = $(this);
		var id = item.closest('.filter').attr('id');
		$('#'+id).find('.filter__item-btn input').val(text);
		$('#filter-form').find('input[name="date"]').val(text);

		$('#filter-form').submit();
	});

	$('#filter__movie .filter__item-menu li').on('click', function() {
		var movieId = $(this).data("id");
		var text = $(this).text();
		var item = $(this);
		var id = item.closest('.filter').attr('id');
		$('#'+id).find('.filter__item-btn input').val(text);
		$('#filter-form').find('input[name="movieId"]').val(movieId);

		$('#filter-form').submit();
	});

	/*==============================
	Tabs
	==============================*/
	$('.profile__mobile-tabs-menu li').each( function() {
		$(this).attr('data-value', $(this).text().toLowerCase());
	});

	$('.profile__mobile-tabs-menu li').on('click', function() {
		var text = $(this).text();
		var item = $(this);
		var id = item.closest('.profile__mobile-tabs').attr('id');
		$('#'+id).find('.profile__mobile-tabs-btn input').val(text);
	});

	/*==============================
	Modal
	==============================*/
	$('.open-modal').magnificPopup({
		fixedContentPos: true,
		fixedBgPos: true,
		overflowY: 'auto',
		type: 'inline',
		preloader: false,
		focus: '#username',
		modal: false,
		removalDelay: 300,
		mainClass: 'my-mfp-zoom-in',
	});

	$('a.main__table-btn--banned').on("click",function(){
		var id = $(this).data("id");
		$('#modal-status .modal__btn--apply').eq(0).attr('data-id', id);
	});

	$('a.main__table-btn--delete').on("click",function(){
		var id = $(this).data("id");
		$('#modal-delete .modal__btn--apply').eq(0).attr('data-id', id);
	});

	$('#modal-status .modal__btn--apply').on("click",function(){
		var id = $(this).data("id");
		$('#ban-form-' + id).submit();
	});

	$('#modal-delete .modal__btn--apply').on("click",function(){
		var id = $(this).data("id");
		$('#del-form-' + id).submit();
	});

	$('#modal-delete-row .modal__btn--apply').on("click",function(){
		var id = $(this).data("id");
		$('#del-row-form-' + id).submit();
	});

	$('.modal__btn--dismiss').on('click', function (e) {
		e.preventDefault();
		$.magnificPopup.close();
	});

	/*==============================
	Select2
	==============================*/
	$('#quality').select2({
		placeholder: "Choose quality",
		allowClear: true
	});

	$('#country').select2({
		placeholder: "Choose country / countries",
		maximumSelectionLength: 3
	});

	$('#mpaa').select2({
		placeholder: "Choose mpaa rate",
		allowClear: true
	});

	$('#city').select2({
		placeholder: "Choose city",
		allowClear: true
	});

	$('#type').select2({
		placeholder: "Choose type",
		allowClear: true
	});

	$('#genre').select2({
		placeholder: "Choose genre / genres",
		maximumSelectionLength: 4
	});

	$('#technologies').select2({
		placeholder: "Choose technology / technologies",
		maximumSelectionLength: 3
	});

	$('#hall').select2({
		placeholder: "Choose hall",
		allowClear: true
	});

	$('#movie').select2({
		placeholder: "Choose movie",
		minimumResultsForSearch: 1
	});

	$('#company').select2({
		placeholder: "Choose company / companies",
		maximumSelectionLength: 3
	});

	$('#director').select2({
		placeholder: "Choose director / directors",
		maximumSelectionLength: 3
	});

	$('#actor').select2({
		placeholder: "Choose actor / actors",
		maximumSelectionLength: 8
	});

	$('#subscription, #rights').select2();

	$("select").on("select2:select", function (evt) {
		var element = evt.params.data.element;
		var $element = $(element);

		$element.detach();
		$(this).append($element);
		$(this).trigger("change");
	});

	/*==============================
	Upload cover
	==============================*/
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				$('#form__img').attr('src', e.target.result);
			}
		
			reader.readAsDataURL(input.files[0]);
		}
	}

	$('#form__img-upload').on('change', function() {
		readURL(this);
	});

	/*==============================
	Upload video
	==============================*/
	$('.form__video-upload').on('change', function() {
		var videoLabel  = $(this).attr('data-name');

		if ($(this).val() != '') {
			$(videoLabel).text($(this)[0].files[0].name);
		} else {
			$(videoLabel).text('Upload video');
		}
	});

	/*==============================
	Upload gallery
	==============================*/
	$('.form__gallery-upload').on('change', function() {
		var length = $(this).get(0).files.length;
		var galleryLabel  = $(this).attr('data-name');

		if( length > 1 ){
			$(galleryLabel).text(length + " files selected");
		} else {
			$(galleryLabel).text($(this)[0].files[0].name);
		}
	});

	/*==============================
	Scrollbar
	==============================*/
	var Scrollbar = window.Scrollbar;

	if ($('.sidebar__nav').length) {
		Scrollbar.init(document.querySelector('.sidebar__nav'), {
			damping: 0.1,
			renderByPixels: true,
			alwaysShowTracks: true,
			continuousScrolling: true
		});
	}

	if ($('.dashbox__table-wrap--1').length) {
		Scrollbar.init(document.querySelector('.dashbox__table-wrap--1'), {
			damping: 0.1,
			renderByPixels: true,
			alwaysShowTracks: true,
			continuousScrolling: true
		});
	}

	if ($('.dashbox__table-wrap--2').length) {
		Scrollbar.init(document.querySelector('.dashbox__table-wrap--2'), {
			damping: 0.1,
			renderByPixels: true,
			alwaysShowTracks: true,
			continuousScrolling: true
		});
	}

	if ($('.dashbox__table-wrap--3').length) {
		Scrollbar.init(document.querySelector('.dashbox__table-wrap--3'), {
			damping: 0.1,
			renderByPixels: true,
			alwaysShowTracks: true,
			continuousScrolling: true
		});
	}

	if ($('.dashbox__table-wrap--4').length) {
		Scrollbar.init(document.querySelector('.dashbox__table-wrap--4'), {
			damping: 0.1,
			renderByPixels: true,
			alwaysShowTracks: true,
			continuousScrolling: true
		});
	}

	if ($('.main__table-wrap').length) {
		Scrollbar.init(document.querySelector('.main__table-wrap'), {
			damping: 0.1,
			renderByPixels: true,
			alwaysShowTracks: true,
			continuousScrolling: true
		});
	}

	/*==============================
	Bg
	==============================*/
	$('.section--bg').each( function() {
		if ($(this).attr("data-bg")){
			$(this).css({
				'background': 'url(' + $(this).data('bg') + ')',
				'background-position': 'center center',
				'background-repeat': 'no-repeat',
				'background-size': 'cover'
			});
		}
	});

	var phones = [{ "mask": "+38(###) ###-##-##"}];
	$('#phone').inputmask({
		mask: phones,
		greedy: false,
		definitions: { '#': { validator: "[0-9]", cardinality: 1}}
	});

});
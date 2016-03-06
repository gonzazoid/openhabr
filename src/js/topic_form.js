window.form_changed = false;
window.poll_id = 0;
window.variant_id = 0;

/* #       CONFIG       # */

var MAX_HUBS_COUNT = 5;           // максимальное кол-во хабов, которое может выбрать пользователь.




var PostForm = function(form){
			this.form = form
			this.id = $('input[name="id"]', this.form).val()
			this.key = 'v_2_'+this.id+form.attr('id')
			this.timestamp = new Date().getTime()
		}
		PostForm.prototype.getData = function(){
			this.hubs = $('select#hubs', this.form).val()
			this.title = $('input[name="title"]', this.form).val()
			this.text = $('textarea[name="text"]', this.form).val()
			this.userformat = $('input[name="userformat"]', this.form).attr('checked')
			this.tags_string = $('input[name="tags_string"]', this.form).val()
			this.timestamp = new Date().getTime()
			// опросы
			var polls = [];
			$('#pollsList .poll').each(function(i, poll){
				var variants = [];
				$('.poll_variants .variant', poll).each(function(i, variant){
					variants.push({
						text: $('input.variant_text', variant).val()
					})
				})
				polls.push({
					title: $('input.poll_title', poll).val(),
					type: $('input.answers_type:checked', poll).val(),
					variants: variants,
					set_time_elapsed: $('.set_time_elapsed input[type="checkbox"]', poll).attr('checked'),
					time_elapsed: new Date(
						$('select[name*="year"]',poll).val(),
						$('select[name*="month"]',poll).val()-1,
						$('select[name*="day"]',poll).val(),
						$('select[name*="hour"]',poll).val(),
						$('select[name*="minute"]',poll).val() ).getTime() / 1000

				})
			})
			this.polls = polls;
			//console.log('get data', this)
		}
		PostForm.prototype.setData = function(){
			$('select#hubs', this.form).val(this.hubs).trigger("change")
			$('input[name="title"]', this.form).val(this.title)
			$('textarea[name="text"]', this.form).val(this.text)
			$('input[name="userformat"]', this.form).attr('checked', this.userformat)
			$('input[name="tags_string"]', this.form).val(this.tags_string)
			//console.log('set data', this)
			// add polls
			for(k in this.polls){
				var poll = this.polls[k];
				add_poll(poll);
			}
		}
		PostForm.prototype.setLS = function(){
			var data = this.serialize()
			$.jStorage.set(this.key, data)
		}
		PostForm.prototype.getLS = function(){
			return $.jStorage.get(this.key)
		}
		PostForm.prototype.fetch = function(){

			var data = this.getLS()

			if(data){
				this.hubs = data.hubs
				this.title = data.title
				this.text = data.text
				this.userformat = data.userformat
				this.tags_string = data.tags_string
				this.timestamp = data.timestamp
				this.polls = data.polls
			}
			//console.log('fetch data', data)
			return data
		}

		PostForm.prototype.serialize = function(){
			return {
				hubs : this.hubs,
				title : this.title,
				text : this.text,
				userformat : this.userformat,
				tags_string : this.tags_string,
				timestamp : this.timestamp,
				polls: this.polls
			}
		}
		PostForm.prototype.clearLS = function(){
			$.jStorage.deleteKey(this.key)
		}
		PostForm.prototype.showNotify = function(){
			var self = this;
			var time = new Date(this.timestamp)

			this.form.prepend('<div id="global_notify" class="">\
													<div class="inner_notice" id="notification_autosave">\
														У вас есть автосохранение от <b>'+ _getDate(time)  + "  " + _getTime(time) + '</b>, <a href="#reset" class="reset_form_from_autosave dotted">восстановить форму</a>?\
													</div>\
											 	</div>')
			$('.reset_form_from_autosave').live('click', function(event){
				event.preventDefault()
				self.fetch()
				self.setData()
				$('#notification_autosave').remove()
			})
		}








$(document).ready(function () {

	window.postForm = new PostForm( $('#post_form, #question_form') )

	var autosave = window.postForm.fetch()

	if( autosave ){
		//console.log('autosave', autosave)
		// Нарисовать уведомление о том, что имеется сохраненная копия
		window.postForm.showNotify()
	}


	/**
	 * Если форма была изменена - необходимо спросить юзера, действительно ли он хочет уйти со страницы (закрыть).
	 */
	$(window).unload(function(event) {
	  if(window.form_changed) {
		  // Сохраним форму в LocalStorage
		  //console.log('go save')
			window.postForm.getData()
			window.postForm.setLS()
	  }
	});

	// Запустим автосохранение каждые N (10) секунд
	setInterval(function(){
		if(window.form_changed) {
			$('#notification_autosave').remove()
			window.postForm.getData() // обновляем объект
			window.postForm.setLS() // сохраняем объект в локалсторадже
			//console.log('setTimeout', postForm)
		}
	},2000)





	// Если хотя бы одно поле формы было изменено, пометим окно...
	$('input, select, textarea').live('change keyup', function(){
		window.form_changed=true;
	});

	// инициализируем автокомлпит для формы ввода пользовательских тегов
	$('input[name="tags_string"]').autocomplete({
		serviceUrl: '/json/suggest/',
		minChars: 2,
		delimiter: /(,|;)\s*/, // Разделитель для нескольких запросов, символ или регулярное выражение
		maxHeight: 400,
		width: 300,
		zIndex: 9999,
		deferRequestBy: 500,
		params: { type: 'tags'}
	});







		/**
		 * Клик по ссылке "Добавить вопрос"
		 */
		$('#addPoll').click(function(){
			window.poll_id++;

			add_poll({ id: window.poll_id });
			return false;
		});


		/**
		 * Обработка элемента мультиселекта хабов.
		 */

		function change(select){

			var has_singleton = false; // есть ли выбранные синглтоны? (пока это тока "я пиарюсь")
			var has_offtop = false;  // есть ли выбранные офтокпики?
			var has_corp = false;  // есть ли выбранные компании?

			$('option:selected', select).each(function(index, option){
				if( $(option).data('is_singleton') == 1 ){
					has_singleton = true;
				}
				if( $(option).data('is_offtop') == 1 ){
					has_offtop = true;
				}

				if( $(option).data('type') == 'corporate' ){
					has_corp = true;

				}
			})

			if( has_offtop ){
				$('.is_offtopic').show()
			}else{
				$('.is_offtopic').hide()
			}

			if( has_corp && $('option:selected', select).length == 1){
				$('.select_tree_hubs').show()
			}else{
				$('.select_tree_hubs').hide()
			}

			// если выбран хаб синглтон (я пиарюсь)
			if(has_singleton){
				// покажем уведомление


				if( $('option[data-is_singleton!="1"]:selected', select).size() ) {
					$.jGrowl('Вместе с хабом &laquo;Я пиарюсь&raquo; нельзя выбирать другие хабы.', { theme: 'error' })
				}
				$('option[data-is_singleton!="1"]:selected', select).attr('selected',false)
			}

			$(select).trigger("liszt:updated")

		}

		$("select.chzn-select").chosen({no_results_text: "Не удалось найти хаб по запросу", max_selected_options: 5, search_contains: true }).bind('change', function(){
			change(this)
		});
		$("select.chzn-select").each(function(index, select){
			change(select)
		});



    /**
     * обработка сабмитов формы
     */
    var post_form = $('#post_form');

    /**
     * Предпросмотр поста
     */
    $('input[name="preview"]', post_form).click(function(){
    	var button = $(this);
    	button.addClass('loading');

    	post_form.ajaxSubmit({
    		dataType: 'json',
	      url: '/json/topic/?action=preview',
	      success: function(json){

	        $('.error', post_form).text('').hide();

	        if(json.messages == 'ok'){
	          $('#preview_placeholder').html(json.preview_html).removeClass('hidden');
              $('.spoiler_text').hide();

						$('pre code').each(function(i, e) {hljs.highlightBlock(e, '    ')});
						$.scrollTo( 0 , 800,	{ axis: 'y' } );
	        }else{
	          show_form_errors(json);
	        }

	        button.removeClass('loading');
	      }
    	});
    	return false;
    });

    /**
     * Сохранение поста в черновики
     */
    $('input[name="draft"]', post_form).click(function(){
    	var button = $(this);
    	button.addClass('loading');

    	post_form.ajaxSubmit({
    		dataType: 'json',
    		data: { draft: 1 },
	      url: '/json/topic/?action=save',
	      success: function(json){

	        $('.error', post_form).text('').hide();

	        if(json.messages == 'ok'){
	        	window.form_changed=false;

	        	window.postForm.clearLS();

	          if(typeof(json.redirect) !== 'undefined'){
	            document.location.href = json.redirect;
	          }else{
	            $.jGrowl('SYSTEM redirect to: <a href="'+json.redirect_debug+'">'+json.redirect_debug+'</a>', { theme: 'error', sticky: true });
	          }
	        }else{
		        $.scrollTo( $('#post_form') , 800,	{ axis: 'y' } );
	          show_form_errors(json);
	        }

	        button.removeClass('loading');
	      }
    	});
    	return false;
    });

    /**
     * Сохранение поста
     */
    $('input[name="submit"]', post_form).click(function(){
    	var button = $(this);
    	button.addClass('loading');

    	if( $('textarea[name="text"]', post_form).size() > 0 ){
	    	var text = $('textarea[name="text"]', post_form).val()

	    	if( ( text.length > 1000 ) && !has_habracut(text) ){
	    		// хабраката нет и пост больше 600 символов
	    		$.jGrowl('Текст публикации содержит '+text.length+' символов. Вам необходимо вставить &lt;cut/&gt;, если текст публикации содержит больше 1000 символов.', { theme: 'error' });
	    		button.removeClass('loading');
	    		return false;
	    	}
    	}

    	post_form.ajaxSubmit({
    		dataType: 'json',
	      url: '/json/topic/?action=save',

	      success: function(json){

	        $('.error', post_form).text('').hide();

	        if(json.messages == 'ok'){

	        	window.form_changed=false;

	        	window.postForm.clearLS();

	          if(typeof(json.redirect) !== 'undefined'){
	            document.location.href = json.redirect;
	          }else{
	            $.jGrowl('SYSTEM redirect to: '+json.redirect_debug, { theme: 'error', sticky: true });
	          }
	        }else{

	          show_form_errors(json);
	          //$.scrollTo( $('.error:visible', post_form) , 800,	{ axis: 'y', offset: -150 }   );
	        }

	        button.removeClass('loading');
	      }
    	});
    	return false;
    });

    function has_habracut(text){
    	if( text.search('<cut') != -1 || text.search('<habracut') != -1){
    		return true;
    	}else{
    		return false;
    	}
    }


});








/** функция добаляет опрос в список опросов */
		var add_poll = function(options){

			var defaults = {
          id:"0",
          title:"",
          type: 'radio',
          poll_id: "",
          time_elapsed: 0,
          variants: [],
          votes_count: 0
      }

      var options = $.extend(defaults, options);

			var tpl = $('#pollTpl').html();
					tpl = tpl.replace(/POLL_ID/g, options.id);
					tpl = tpl.replace(/POLL_TITLE/g, options.title);
					tpl = tpl.replace(/ORIGINAL_POLLID/g, options.poll_id);

					$('#pollsList').append(tpl);

					if( options.type == 'radio'){
						$('#poll_'+options.id+'_type_radio').attr('checked', true);
					}else{
						$('#poll_'+options.id+'_type_checkbox').attr('checked', true);
					}

			var $poll_variants = $('#poll_'+options.id+' .poll_variants');

					$poll_variants.addClass(options.type);

					if(options.votes_count > 0){
						$('#poll_'+options.id+'_type_radio, #poll_'+options.id+'_type_checkbox').attr('disabled',true)
						$('#poll_'+options.id+'').append('<input name="polling['+options.id+'][answers_type]" value="'+options.type+'" type="hidden"/>')
					}else{
						$('#poll_'+options.id+'_type_radio, #poll_'+options.id+'_type_checkbox').change(function(){
							var type = $(this).val();
							$poll_variants.removeClass('radio').removeClass('checkbox').addClass( type );
						})
					}

					// add variants
					if( options.variants.length > 0 ){
						for(k in options.variants){
							var variant = options.variants[k]
									variant.id = k
							add_poll_variant(variant)
						}
					}else{
							add_poll_variant({poll_id: options.id})
					}

					// delete poll handler
					$('#poll_'+options.id+' .delete_poll').click(function(){
						$('#poll_'+options.id+'').append('<input type="hidden" name="polling['+options.id+'][deleted]" value="'+options.poll_id+'">');
						$('#poll_'+options.id+'').hide();
						return false;
					})

					// чекбокс включающий ограничение даты
					$('#poll_'+options.id+' .set_time_elapsed input').change(function(){
						if( $(this).attr('checked') ){
							$('#poll_'+options.id+' .time_elapsed').show()
						}else{
							$('#poll_'+options.id+' .time_elapsed').hide()
						}
					})

					// актуален "до"…
					if( options.time_elapsed > 0 ){

						var date = new Date( options.time_elapsed * 1000 )
						var day = date.getDate()  // день от 1 до 31
						var month = date.getMonth() + 1 // от 0 до 11 // прибавим +1 - что бы начинать с 1 месяца
						var year =  date.getFullYear()
						var hour = date.getHours()
						var minute = date.getMinutes()

						$('#poll_'+options.id+' select[name*="day"]').val(day)
						$('#poll_'+options.id+' select[name*="month"]').val(month)
						$('#poll_'+options.id+' select[name*="year"]').val(year)
						$('#poll_'+options.id+' select[name*="hour"]').val(hour)
						$('#poll_'+options.id+' select[name*="minute"]').val(minute)

						$('#poll_'+options.id+' .set_time_elapsed input').attr('checked', true)
						$('#poll_'+options.id+' .time_elapsed').show()

					}




		}

		/** функция добавляет вариант ответа в опрос */
		var add_poll_variant = function(options){



			var defaults = {
          id:"0",
          poll_id: "0",
          variant_id: '',
          text:""
      }

      var options = $.extend(defaults, options);

			var tpl = $('#pollVariantsTpl').html();
					tpl = tpl.replace(/POLL_ID/g, options.poll_id);
					tpl = tpl.replace(/VARIANT_ID/g, options.id);
					tpl = tpl.replace(/VARIANT_TEXT/g, options.text);
					tpl = tpl.replace(/ORIGINAL_VARIANTID/g, options.variant_id);

			var $poll_variants = $('#poll_'+options.poll_id+' .poll_variants')

			$poll_variants.append(tpl);

			var variant = $('#poll_'+options.poll_id+'_variant_'+options.id+'')

			$('input[type="text"]', variant).bind('keyup blur change', function(){
				// Проверим - если текущий вариант ответа, не пустой - то
				if(empty($('input[type="text"]', variant).val())){
					//console.log('текущий инпут пустой :) ни чего делать не надо')
				}else{
					//console.log('текущий инпут не пустой')
					// проверим последний вариант ответа - если тот не пустой - то добавим пустой.
					var last_variant = $('.variant', $poll_variants).last();

					if( empty($('input[type="text"]', last_variant).val()) ){
						//console.log('последний вариант пустой')
					}else{

						window.variant_id++;
						//console.log('последний вариант не пустой, добавим пустой вариант в конец :)', options)
						add_poll_variant({poll_id: options.poll_id, id: window.variant_id })
					}

				}

			})
			$('input[type="text"]', variant).live('keydown', function (e) {

				//console.log( e.keyCode )

				// если текущее значение пустое
				if( empty($(this).val()) ){
					// и юзер жмет delete - то надо удалить текущий вариант и перекинуть фокус не предыдущий :)
					/********* DELETE ***********
					if (e.keyCode == 8) {        // delete
						e.preventDefault();
						// надо проверить сколько всего - если остался всего один - то вообще ни чо делать не надо 5)
						if( $('.variant', $poll_variants).size() > 1 ){
							var prev = variant.prev()
							if( prev.size() ){ // если есть предыдущий - то все ок
								$('input[type="text"]', prev).focus()
							}else{            // если предыдущего нет, то просто удалим текущий и поставим фокус на следующий
								var next = variant.next()
								if(next.size()){   // если следующий конечно есть :)
									$('input[type="text"]', next).focus()
								}
							}
							variant.hide()
							variant.append('<input type="hidden" name="polling['+options.poll_id+'][variants]['+options.id+'][deleted]" value="'+options.variant_id+'">')
						}
					}
					*/
				// если текущее значение не пустое
				}else{



				}

				// если нажат вверх - переходим фокусом на пред вариант :)
				if(  e.keyCode == 38 ){ // up
					e.preventDefault();
					var prev = variant.prev()
					if(prev.size()){
						$('input[type="text"]', prev).focus()
					}
				}

				// если нажат enter | tab | вниз - переходим фокусом на след вариант :)
				if( e.keyCode == 13 || e.keyCode == 9 || e.keyCode == 40 ){ // down | enter | tab
					e.preventDefault();
					var next = variant.next()
					if(next.size()){
						$('input[type="text"]', next).focus()
					}
				}
			})

		}



$(function(){
	mention_autocomplete($('#post_form #text_textarea'))
})

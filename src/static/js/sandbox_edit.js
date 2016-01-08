window.form_changed = false;

var PostForm = function(form){
			this.form = form
			this.id = $('input[name="id"]', this.form).val()
			this.key = 'v_2_'+this.id+form.attr('id')
			this.timestamp = new Date().getTime()
		}
		PostForm.prototype.getData = function(){
			this.hubs = $('input[name="hubs"]', this.form).size() ? $('input[name="hubs"]', this.form).tokenInput("get") : false
			this.title = $('input[name="title"]', this.form).val()
			this.text = $('textarea[name="text"]', this.form).val()
			this.userformat = $('input[name="userformat"]', this.form).attr('checked')
			this.tags_string = $('input[name="tags_string"]', this.form).val()
			this.timestamp = new Date().getTime()
		}
		PostForm.prototype.setData = function(){
			if( $('input[name="hubs"]', this.form).size() ) {
				$('input[name="hubs"]', this.form).tokenInput("clear")
				$.each(this.hubs, function(index, hub) {
					$('input[name="hubs"]', this.form).tokenInput("add", hub)
				})
			}
			$('input[name="title"]', this.form).val(this.title)
			$('textarea[name="text"]', this.form).val(this.text)
			$('input[name="userformat"]', this.form).attr('checked', this.userformat)
			$('input[name="tags_string"]', this.form).val(this.tags_string)
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
			}
			return data
		}

		PostForm.prototype.serialize = function(){
			return {
				hubs : this.hubs,
				title : this.title,
				text : this.text,
				userformat : this.userformat,
				tags_string : this.tags_string,
				timestamp : this.timestamp
			}
		}
		PostForm.prototype.clearLS = function(){
			$.jStorage.deleteKey(this.key)
		}
		PostForm.prototype.showNotify = function(){
			var self = this;
			var time = new Date(this.timestamp)
			this.form.prepend('<div id="global_notify" class="">\
													<div class="inner" id="notification_autosave">\
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

/**
 * Если форма была изменена - необходимо спросить юзера, действительно ли он хочет уйти со страницы (закрыть).
 */
$(window).unload(function(event) {
  if(window.form_changed) {
	  // Сохраним форму в LocalStorage
	  //console.log('go save')
	 	var post = new PostForm( $('#sandbox_post_form') )
				post.getData()
				post.setLS()
  }
});





$(document).ready(function () {

		var postForm = new PostForm( $('#sandbox_post_form') )



	var autosave = postForm.fetch()




	if( autosave ){
		//console.log('autosave', autosave)
		// Нарисовать уведомление о том, что имеется сохраненная копия
		postForm.showNotify()
	}



	// Запустим автосохранение каждые N (10) секунд
	setInterval(function(){

		if(window.form_changed) {
			$('#notification_autosave').remove()
			postForm.getData() // обновляем объект

			postForm.setLS() // сохраняем объект в локалсторадже
			//console.log('setTimeout', postForm)
		}
	},2000)


	// Если хотя бы одно поле формы было изменено, пометим окно...
	$('input, select, textarea').bind('change keyup', function(){
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
     * обработка сабмитов формы
     */
    var post_form = $('#sandbox_post_form');

    /**
     * Предпросмотр поста
     */
    $('input[name="preview"]', post_form).click(function(){


    	if( $('textarea[name="text_textarea"]', post_form).size() > 0 ){
	    	var text = $('textarea[name="text_textarea"]', post_form).val()
	    	if( ( text.length > 1000 ) && !has_habracut(text) ){
	    		// хабраката нет и пост больше 600 символов
	    		$.jGrowl('Текст публикации содержит '+text.length+' символов. Вам необходимо вставить &lt;cut/&gt;, если текст публикации содержит больше 1000 символов.', { theme: 'error', sticky: true });
	    		$('input[name="submit"]', post_form).removeClass('loading');
	    		return false;
	    	}
    	}
    	post_form.ajaxSubmit({
    		form: post_form,
    		dataType: 'json',
    		beforeSubmit: function(formData, jqForm, options){
    			$('#preview_placeholder').html('').addClass('hidden')
    			return ajaxFormBeforSubmit(formData, jqForm, options)
    		},
				error: ajaxFormError,
	      url: '/json/sandbox/preview/',
	      success: ajaxFormSuccess(function(json, statusText, xhr, jqForm){
					$('#preview_placeholder').html(json.preview_html).removeClass('hidden')
					$('pre code').each(function(i, e) {hljs.highlightBlock(e, '    ')})
				})
    	})
    	return false
    })



    /**
     * Сохранение поста
     */
    $('input[name="submit"]', post_form).click(function(){

    	if( !confirm('Вы уверены, что хотите отправить текст на модерацию?') ) {
      	return false;
    	}

    	if( $('textarea[name="text"]', post_form).size() > 0 ){
	    	var text = $('textarea[name="text"]', post_form).val()

	    	if( ( text.length > 1000 ) && !has_habracut(text) ){
	    		// хабраката нет и пост больше 600 символов
	    		$.jGrowl('Текст публикации содержит '+text.length+' символов. Вам необходимо вставить &lt;habracut/&gt;, если текст публикации содержит больше 1000 символов.', { theme: 'error', sticky: true });
	    		$('input[name="submit"]', post_form).removeClass('loading');
	    		return false;
	    	}
    	}

    	post_form.ajaxSubmit({
    		form: post_form,
    		dataType: 'json',
    		beforeSubmit: function(formData, jqForm, options){
    			$('#preview_placeholder').html('').addClass('hidden')
    			return ajaxFormBeforSubmit(formData, jqForm, options)
    		},
				error: ajaxFormError,
	      url: '/json/sandbox/save/',
	      success: ajaxFormSuccess(function(json, statusText, xhr, jqForm){
		      	window.form_changed=false;
	        	postForm.clearLS();
	      		ajaxFormRedirect(json, statusText, xhr, jqForm)
	      })
    	})
    	return false
    })

    function has_habracut(text){
    	if( text.search('<habracut') != -1){
    		return true
    	}else if ( text.search('<cut') != -1){
            return true
    	}else{
    		return false
    	}
    }
});

<!DOCTYPE html>
<html lang="ru">
<head>
<title>{{article.title}}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link href="/css/post_common_css.css" rel="stylesheet" media="all" />
<link href="/css/posts.css" rel="stylesheet" media="all" />
<link href="/css/main.css" rel="stylesheet" media="all" />

<script type="text/javascript">
  // global vars
  var g_base_url = 'openhabr.net';
  var g_show_xpanel = true;
  var g_base_fullurl = 'http://openhabr.net/';
  var g_is_guest = true;
  var g_user_login = 'gearbox';
  var g_user_id = 377385;
  var g_user_avatar = '//openhabr.net/i/avatars/stub-user-middle.gif';   
</script> 

<script type="text/javascript" src="/js/global_main.js"></script>
<script type="text/javascript" src="/js/company_post_show_common.js"></script>
<script type="text/javascript" src="/js/shortcuts.js"></script>
<style>
.hub:after {
    content: ","
}
.hub:last-of-type:after {
    content: ""
}
</style>
</head>
<body>
<div id="layout">
<div id="navbar"></div>
<div class="inner">

<div class="profile-header">
  <div class="profile-header__summary author-info author-info_profile ">
    <a href="/users/{{article.nickname}}/" class="author-info__image">
        <img src="/img/avatars/{{article.nickname}}.jpg" class="author-info__image-pic">
    </a>

    <div class="author-info__desc">
      <div class="author-info__username">
         <a href="/users/{{article.nickname}}/" class="author-info__name">{{article.fullname}}</a> 
        <a href="/users/{{article.nickname}}/" class="author-info__nickname">@{{article.nickname}}</a>
        
      </div>
        <div class="author-info__specialization">
         {{article.u_status}} 
        </div>
    </div>
  </div>

    <div class="profile-header__stats">

      <div class="karma__widjet voting-wjt js-karma  ">

        <div class="voting-wjt__counter js-karma-mark voting-wjt__counter_positive " title="971 голос">
          <div class="voting-wjt__counter-score js-karma_num">{{article.carma}}</div>
          <div class="voting-wjt__label">карма</div>
        </div>

      </div>

      <div class="user-rating" title="Рейтинг пользователя">
        <div class="user-rating__value">{{article.u_rating}}</div>
        <div class="user-rating__label">рейтинг</div>
      </div>

    </div>
    <div class="profile-header__buttons" style="display: inline-block;">
          <button type="button" class="btn btn_blue btn_large " id="followUser" title="Подписаться на пользователя" data-login="{{article.nickname}}">Подписаться</button>

          <button type="button" class="btn btn_blue btn_subscribed btn_large hidden" id="unfollowUser" title="Вы подписаны на пользователя" data-login="{{article.nickname}}">Подписан</button>
    </div>
</div>

<div class="column-wrapper">

<div class="tabs">
    <ul class="tabs-menu tabs-menu_habrahabr">
          <li class="tabs-menu__item tabs-menu__item_user-profile tabs-menu__item_inline">
            <a href="/users/{{article.nickname}}/" class="tab-item tab-item_stacked ">
              <span class="tab-item__value stats">
                <span class="stats__counters stats__counters_big">
                  <strong class="counter"></strong>
                </span>
                <span class="stats__value">Профиль</span>
            </span></a>
          </li>
          <li class="tabs-menu__item tabs-menu__item_user-profile tabs-menu__item_inline">
            <a href="/users/{{article.nickname}}/topics/" class="tab-item tab-item_stacked tab-item_current">
              <span class="tab-item__value stats">
                <span class="stats__counters stats__counters_big">
                  <strong class="counter">199</strong>
                </span>
                <span class="stats__value">Публикации</span>
            </span></a>
          </li>
          <li class="tabs-menu__item tabs-menu__item_user-profile tabs-menu__item_inline">
            <a href="/users/{{article.nickname}}/comments/" class="tab-item tab-item_stacked ">
              <span class="tab-item__value stats">
                <span class="stats__counters stats__counters_big">
                  <strong class="counter">1,4k</strong>
                </span>
                <span class="stats__value todo">Комментарии</span>
            </span></a>
          </li>
          <li class="tabs-menu__item tabs-menu__item_user-profile tabs-menu__item_inline">
            <a href="/users/{{article.nickname}}/favorites/" class="tab-item tab-item_stacked ">
              <span class="tab-item__value stats">
                <span class="stats__counters stats__counters_big">
                  <strong class="counter">53</strong>
                </span>
                <span class="stats__value todo">Избранное</span>
            </span></a>
          </li>
          <li class="tabs-menu__item tabs-menu__item_user-profile tabs-menu__item_inline">
            <a href="/users/{{article.nickname}}/subscription/followers/" class="tab-item tab-item_stacked ">
              <span class="tab-item__value stats">
                <span class="stats__counters stats__counters_big">
                  <strong class="counter">274</strong>
                </span>
                <span class="stats__value todo">Подписчики</span>
            </span></a>
          </li>
    </ul>

  </div>

  <div class="post shortcuts_item" id="post_274219">
    <div class="published">28 декабря в 19:14</div>
      <h1 class="title">
        <span class="post_title">{{article.title}}</span>
      </h1>
      <div class="hubs">
        {{#article.hubs}}
          <a href="/hub/{{name}}/" class="hub " title="Вы не подписаны на этот хаб" >{{title}}</a> 
        {{/article.hubs}}
      </div>
      <div class="content html_format">
        {{{article.body}}}      
        <div class="clear"></div>
      </div>
      <ul class="tags icon_tag">
        <li ><a href="/search/?q=%5B%D1%85%D0%B0%D0%B1%D1%80%D0%B0%D1%85%D0%B0%D0%B1%D1%80%5D&target_type=posts" rel="tag">хабрахабр</a>, </li>
        <li ><a href="/search/?q=%5B%D0%BC%D0%B8%D0%BD%D1%83%D1%81%D1%8F%D1%82%D0%BE%D1%80%D1%81%D1%82%D0%B2%D0%BE%5D&target_type=posts" rel="tag">минусяторство</a></li>
      </ul>
      <div class="infopanel_wrapper">
        <ul class="postinfo-panel postinfo-panel_post" id="infopanel_post_274219">
          <li class="postinfo-panel__item">
            <div class="voting-wjt voting-wjt_infopanel js-voting  ">
                <button type="button" disabled class="voting-wjt__button voting-wjt__button_plus js-plus" title="Read-only пользователи не могут голосовать">
                  <span>&uarr;</span>
                </button>
                <div class="voting-wjt__counter js-mark">
                  <span class="voting-wjt__result-score js-score" title="Оценка будет видна после завершения голосования">&mdash;</span>
                </div>
                <button type="button" disabled class="voting-wjt__button voting-wjt__button_minus js-minus" title="Read-only пользователи не могут голосовать">
                  <span>&darr;</span>
                </button>
              </div>
            </li>
            <li class="postinfo-panel__item">
              <div class="views-count_post" title="Просмотры публикации">{{article.views}}</div>
            </li>
            <li class="postinfo-panel__item">
              <div class="favorite-wjt favorite">
                <button type="button" class="favorite-wjt__button add" title="Добавить в избранное" onclick="return posts_add_to_favorite(this, '2', 274219);">
                  <span>В избранное</span>
                </button>
                <span class="favorite-wjt__counter js-favs_count" title="Количество пользователей, добавивших публикацию в избранное">{{article.favorites}}</span>
              </div>
            </li>
            <!-- шеринг в соцсети -->
            <li class="postinfo-panel__item postinfo-panel__item_socials  postinfo-panel__item_socials_right ">
              <ul class="post-share">
                <li class="post-share__item">
                  <a href="http://twitter.com/intent/tweet?text=%D0%9F%D0%BE%D1%87%D0%B5%D0%BC%D1%83+%D0%A5%D0%B0%D0%B1%D1%80%D0%B0%D1%85%D0%B0%D0%B1%D1%80+%D0%BF%D1%80%D0%B5%D0%B2%D1%80%D0%B0%D1%82%D0%B8%D0%BB%D1%81%D1%8F+%D0%B2+%D0%BB%D0%B5%D0%BD%D1%82%D1%83+%D0%BA%D0%BE%D1%80%D0%BF%D0%BE%D1%80%D0%B0%D1%82%D0%B8%D0%B2%D0%BD%D1%8B%D1%85+%D0%B1%D0%BB%D0%BE%D0%B3-%D0%BF%D0%BE%D1%81%D1%82%D0%BE%D0%B2+http://habr.ru/p/274219/+via+%40habrahabr+%23habr" class="post-share__item-link twitter" title="Опубликовать ссылку в Twitter" target="_blank"></a>
                </li>
                <li class="post-share__item">
                  <a href="https://vk.com/share.php?url=http://openhabr.net/post/274219/" class="post-share__item-link vkontakte" title="Опубликовать ссылку во ВКонтакте" onclick="window.open(this.href, 'Опубликовать ссылку во Вконтакте', 'width=800,height=300'); return false"></a>
                </li>
                <li class="post-share__item">
                  <a href="https://www.facebook.com/sharer/sharer.php?u=http://openhabr.net/post/274219/" class="post-share__item-link facebook" title="Опубликовать ссылку в Facebook" onclick="window.open(this.href, 'Опубликовать ссылку в Facebook', 'width=640,height=436,toolbar=0,status=0'); return false"></a>
                </li>
                <li class="post-share__item">
                  <a href="https://getpocket.com/edit?url=http://openhabr.net/post/274219/" target="_blank" class="post-share__item-link pocket" title="Добавить ссылку в Pocket"></a>
                </li>
              </ul>
            </li>
          </ul>
        </div>

        <div class="author-info ">
          <a href="/users/{{article.nickname}}/" class="author-info__image">
            <img src="/img/avatars/{{article.nickname}}.jpg" class="author-info__image-pic"/>
          </a>
          <div class="author-info__desc">
            <div class="author-info__username">
              <a href="/users/{{article.nickname}}/" class="author-info__nickname">@{{article.nickname}}</a>
              <div class="karma__widjet voting-wjt voting-wjt_small js-karma  " title="Карма пользователя">
                <div class="voting-wjt__counter voting-wjt__counter_positive">
                  <span class="voting-wjt__label">карма</span>
                  <span class="voting-wjt__counter-score js-karma_num">{{article.carma}}</span>
                </div>
              </div>
              <div class="user-rating" title="Рейтинг пользователя">
                <span class="user-rating__label">рейтинг</span>
                <span class="user-rating__value">{{article.u_rating}}</span>
              </div>
            </div>
          </div>



        </div>

 <div class="column-wrapper column-wrapper_comments">
    <div class="content_left">
      <div class="comments_list " id="comments">
        <h2 class="title ">Комментарии (<span id="comments_count">{{article.comments_count}}</span>)
          <span class="subscribe_comments"> отслеживать новые: 
	    <label ><input type="checkbox" id="subscribe_comments" rel="{target_type:'2',target_id:250569 }"  /> в почте</label>
	    <label ><input type="checkbox" id="tracker_comments" rel="{target_type:'2',target_id:250569 }"  /> в трекере</label>
          </span>
        </h2>
<!-- comments -->
{{#article.comments}}
{{>comments}}
{{/article.comments}}
<!-- comments -->
      </div>
    </div>
  </div>

  <div class="clear"></div>
  
{{#user}}
<div class="comments_form" id="comments_form_placeholder">
{{#article.comments_count}}
              <h2 class="title"><a href="#" onclick="return comment_show_form()">Написать комментарий</a></h2>
{{/article.comments_count}}
              <form action="/json/comment/" method="post" id="comments_form">

                <div id="preview_placeholder" class="hidden html_format"></div>
                <input type="hidden" name="ti" value="{{article.id}}">
                <input type="hidden" name="parent_id" value="0">

                <div class="editor">
                  <div class="panel">
                      <div class="wysiwyg_wrapper">
	<div class="can_use_html"><a href="#html_help" onclick="$(this).parents('.wysiwyg_wrapper').find('.help_holder').toggleClass('hidden');return false;">html-теги</a></div>
	<a class="btn" title="Жирный" onclick="return habraWYG.insertTagWithText(this, 'b');" href="#" tabindex="-1"><span class="g-icon g-icon-bold"></span></a>
	<a class="btn" title="Курсив" onclick="return habraWYG.insertTagWithText(this, 'i');" href="#" tabindex="-1"><span class="g-icon g-icon-italic"></span></a>
	<a class="btn" title="Подчёркнутый" onclick="return habraWYG.insertTagWithText(this, 'u');" href="#" tabindex="-1"><span class="g-icon g-icon-underline"></span></a>
	<a class="btn" title="Зачёркнутый" onclick="return habraWYG.insertTagWithText(this, 's');" href="#" tabindex="-1"><span class="g-icon g-icon-strike"></span></a>
	<a class="btn" title="Цитата" onclick="return habraWYG.insertTagWithText(this, 'blockquote');" href="#" tabindex="-1"><span class="g-icon g-icon-quote"></span></a>
	
	<a class="btn" title="Пользователь" onclick="return habraWYG.insertUser(this);" href="#" tabindex="-1"><span class="g-icon g-icon-users"></span></a>
	<a class="btn" title="Вставить ссылку" onclick="return habraWYG.insertLink(this);" href="#" tabindex="-1"><span class="g-icon g-icon-link"></span></a>
	<a class="btn" title="Вставить изображение" onclick="return habraWYG.insertImage(this);" href="#" tabindex="-1"><span class="g-icon g-icon-images"></span></a>
	<a class="btn" title="Вставить видео" onclick="return habraWYG.insertTagWithText(this, 'video');" href="#" tabindex="-1"><span class="g-icon g-icon-video"></span></a>
	<a class="btn" title="Вставить твит" onclick="return habraWYG.insertTagWithText(this, 'twitter');" href="#" tabindex="-1"><span class="g-icon g-icon-twitter"></span></a>
	<a class="btn" title="Вставить спойлер" onclick="return habraWYG.insertSpoiler(this);" href="#" tabindex="-1"><span class="g-icon g-icon-spoiler"></span></a>
	


	<div class="clear"></div>

		<div class="help_holder hidden">
          <h4>Теги</h4>
					<dl class="block_semi">
						<dt>&lt;cut&gt;</dt>
						<dd class="description">Используется только в текстах публикаций, скрывает под кат часть текста, следующую за тегом (будет написано «Читать дальше»).</dd>
					</dl>
					<dl class="block_semi">

						<dt>&lt;cut text="Подробности" /&gt;</dt>
						<dd class="description">Так можно превратить надпись «Читать дальше» в любой текст.</dd>
					</dl>
					<dl class="block_semi">
						<dt>&lt;source lang="Язык"&gt;&lt;/source&gt;</dt>
						<dd class="description">Подсвечивает исходный код (на выбор:
						Bash,  C#,  C++,  CSS,  Diff,  HTML, XML,  Ini,  Java,  JavaScript,  PHP,  Perl,  Python,  Ruby,  SQL,
						1C,  AVR Assembler,  ActionScript,  Apache,  Axapta,  CMake,  CoffeeScript,  DOS, .bat,  Delphi,  Django,  Erlang,  Erlang REPL,  Go,  Haskell,  Lisp,  Lua,  MEL,  Markdown,  Matlab,  Nginx,  Objective C,  Parser3,  Python profile,  RenderMan,  Rust,  Scala,  Smalltalk,  TeX,  VBScript,  VHDL,  Vala
						).</dd>
					</dl>
					<dl class="block_semi">
						<dt>&lt;video&gt;http://...&lt;/video&gt;</dt>

						<dd class="description">Добавляет в публикацию видео со следующих хостингов: YouTube, RuTube, Google video, Vimeo, Я.Видео, Ivideon и Видео@Mail.ru<br>Вставляйте между тегами только прямую ссылку на видеоролик.</dd>
					</dl>
					<dl class="block_semi">
						<dt>&lt;twitter&gt;http://...&lt;/twitter&gt;</dt>

						<dd class="description">Добавляет в публикацию твит. Необходимо указать полную ссылку на твит. Например: &lt;twitter&gt;https://twitter.com/habrahabr/status/522334394175213568&lt;/twitter&gt;</dd>
					</dl>

					<dl class="block_semi">
						<dt>&lt;slideshow&gt;http://...&lt;/slideshow&gt;</dt>

						<dd class="description">Вставка интерактивного слайд-шоу. Пока поддерживается только сервис Slideshare.net.</dd>
					</dl>

					<dl class="block_semi">
						<dt>@username</dt>

						<dd class="description">
							Выводит имя пользователя в тексте и отправляет пользователю уведомление о том, что его упомянули в публикации/комментарии.
							Вы можете использовать конструкцию <b>@username</b>, где <b>username</b> — это имя пользователя.
						</dd>
					</dl>

					<dl class="block_semi">
						<dt>&lt;spoiler title="Заголовок"&gt;Содержимое&lt;/spoiler&gt;</dt>

						<dd class="description">Вставка спойлера (разворачиваемый блок информации).</dd>
					</dl>




					<h4>Стандартные</h4>
					<table class="wide">
						<tbody><tr>
							<td>

								<dl class="block_semi">
									<dt>&lt;h1&gt;&lt;/h1&gt;<br>
										...<br>
										&lt;h6&gt;&lt;/h6&gt;
									</dt>
									<dd class="description">Заголовки разного уровня.</dd>
								</dl>
								<dl class="block_semi">

									<dt>&lt;img src="" /&gt;</dt>
									<dd class="description">Вставка изображения, в атрибуте src нужно указывать полный путь к изображению. Возможно выравнивание картинки атрибутом align.</dd>
								</dl>
								<dl class="block_semi">
									<dt>&lt;a href="http://..."&gt;Ссылка&lt;/a&gt;</dt>

									<dd class="description">Вставка ссылки, в атрибуте href указывается желаемый интернет-адрес или якорь (anchor) для навигации по странице.</dd>
								</dl>
								<dl class="block_semi">
									<dt>&lt;anchor&gt;Example1&lt;/anchor&gt;</dt>

									<dd class="description">Тег для указания якоря. Для вызова используйте тег вставки ссылок (&lt;a href="#Example1"&gt;Текст&lt;/a&gt;).</dd>
								</dl>
								<dl class="block_semi">
									<dt>&lt;b&gt;&lt;/b&gt;<br>
										&lt;strong&gt;&lt;/strong&gt;</dt>
									<dd class="description">Выделение важного текста, на странице выделяется жирным начертанием.</dd>
								</dl>
								<dl class="block_semi">

									<dt>&lt;i&gt;&lt;/i&gt;<br>
										&lt;em&gt;&lt;/em&gt;</dt>
									<dd class="description">Выделение важного текста, на странице выделяется курсивом.</dd>
								</dl>
								<dl class="block_semi">
									<dt>
										&lt;s&gt;&lt;/s&gt;<br>
										&lt;strike&gt;&lt;/strike&gt;
									</dt>
									<dd class="description">Текст между этими тегами будет отображаться как зачеркнутый.</dd>
								</dl>

								<dl class="block_semi">
									<dt>
										&lt;u&gt;&lt;/u&gt;
									</dt>
									<dd class="description">Текст между этими тегами будет отображаться как подчеркнутый.</dd>
								</dl>


							</td>

							<td width="5%"></td>

							<td>
							<dl class="block_semi">
								<dt>
									&lt;hr /&gt;
								</dt>
								<dd class="description">Тег для вставки горизонтальной линии.</dd>
							</dl>
								<dl class="block_semi">
									<dt>
										&lt;blockquote&gt;&lt;/blockquote&gt;
									</dt>
									<dd class="description">Используйте этот тег для выделения цитат.</dd>

								</dl>
								<dl class="block_semi">
									<dt>
										&lt;table&gt;&lt;/table&gt;<br>
										&lt;th&gt;&lt;/th&gt;<br>
										&lt;td&gt;&lt;/td&gt;<br>

										&lt;tr&gt;&lt;/tr&gt;
									</dt>
									<dd class="description">Набор тегов для создания таблицы. Тег &lt;td&gt; обозначает ячейку таблицы, тег &lt;th&gt; - ячейку в заголовке, &lt;tr&gt; - строчку таблицы. Все содержимое таблицы помещайте в тег &lt;table&gt;.</dd>

								</dl>
								<dl class="block_semi">
									<dt>
										&lt;sup&gt;&lt;/sup&gt;<br>
										&lt;sub&gt;&lt;/sub&gt;
									</dt>
									<dd class="description">Текст, заключенный в тег &lt;sup&gt; отображается в виде верхнего индекса, &lt;sub&gt; - в виде нижнего.</dd>

								</dl>
								<dl class="block_semi">
									<dt>
										&lt;abbr title="" &gt;&lt;/abbr&gt;<br>
										&lt;acronym title="" &gt;&lt;/acronym&gt;
									</dt>

									<dd class="description">Тегом &lt;abbr&gt; выделяется аббревиатура, в атрибуте title указывайте её расшифровку. Используйте тег &lt;acronym&gt; для устоявшихся аббревиатур.</dd>
								</dl>
								<dl class="block_semi">
									<dt>
										&lt;pre&gt;&lt;/pre&gt;

									</dt>
									<dd class="description">Текст в теге &lt;pre&gt; не форматируется автоматически.</dd>
								</dl>
								<dl class="block_semi">
									<dt>
										&lt;nobr&gt;&lt;/nobr&gt;<br>

										&lt;br clear="all|left||right" /&gt;
									</dt>
									<dd class="description">Текст, помещенный в тег &lt;nobr&gt;, не переносится на странице; для принудительного переноса текста используйте тег &lt;br /&gt;; для аккуратного выравнивания изображений используйте атрибут clear="all|left||right" в теге &lt;br /&gt;.</dd>
								</dl>

								<dl class="block_semi">
									<dt>
										&lt;ul&gt;&lt;/ul&gt;<br>
										&lt;li&gt;&lt;/li&gt;
									</dt>
									<dd class="description">Ненумерованный список; каждый элемент списка задается тегом &lt;li&gt;, набор элементов списка помещайте в тег &lt;ul&gt;.</dd>

								</dl>
								<dl class="block_semi">
									<dt>
										&lt;ol&gt;&lt;/ol&gt;<br>
										&lt;li&gt;&lt;/li&gt;
									</dt>
									<dd class="description">Нумерованный список; каждый элемент списка задается тегом &lt;li&gt;, набор элементов списка помещайте в тег &lt;ol&gt;.</dd>

								</dl>
							</td>
						</tr>

					</tbody></table>

					<div class="close_html"><a href="#html_help_close" onclick="$(this).parents('.wysiwyg_wrapper').find('.help_holder').toggleClass('hidden');return false;">закрыть</a></div>

		</div>
</div>
                  </div>
                  <div class="text-holder">
                    <textarea cols="30" rows="10" name="text" id="comment_text"></textarea>
                  </div>
                  <span id="error_text" class="error"></span>
                </div>
                <div class="buttons">
                  <input type="button" class="preview disableble" value="Предпросмотр" disabled="disabled" onclick="comment_preview(this.form, this)">
                  <input type="button" class="submit disableble" value="Написать" disabled="disabled" onclick="comment_send(this.form, this)">
                  <input type="button" class="edit hidden disableble" value="Сохранить" disabled="disabled" onclick="comment_update(this.form, this)">
                  
                  <span class="time_left" title="Оставшееся время редактирования комментария"></span>
                </div>
              </form>
            </div> 
{{/user}}
      </div>
    </div>
{{>footer}}
  </div>

 

</div>
</div>
</div>
</div>
</body>
</html>

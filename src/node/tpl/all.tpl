<!DOCTYPE html>
<html lang="ru">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- это для постов -->
<link href="/css/post_common_css.css" rel="stylesheet" media="all" />

<link href="/css/forms.css" rel="stylesheet" media="all" />
<link href="/css/posts.css" rel="stylesheet" media="all" />
<link href="/css/hubs_all.css" rel="stylesheet" media="all" />
<link href="/css/main.css" rel="stylesheet" media="all" />
</head>
<body>
<div id="layout">
<div id="navbar"></div>
<div class="inner">
<div class="column-wrapper">
<div class="posts_list">
{{#articles}}
    <div class="posts shortcuts_items">
      <div class="post shortcuts_item" id="post_270673">
        <div class="published">сегодня в 20:15</div>
          <h1 class="title">
            <a href="/post/{{id}}/" class="post_title">{{title}}</a>
          </h1>
          <div class="hubs">
            {{#hubs}}
            <a href="/hub/{{name}}/" class="hub " title="Вы не подписаны на этот хаб" >{{title}}</a><span class="profiled_hub" title="Профильный хаб">*</span>
            {{/hubs}}
          </div>
          <div class="content html_format">
            {{cut}} 
            <div class="buttons">
              <a class="button habracut" href="/post/{{id}}/#habracut">{{cut_title}}</a>
            </div>
            <div class="clear"></div>
          </div>
          <div class="infopanel_wrapper">
            <ul class="postinfo-panel " id="infopanel_post_270673">
              <li class="postinfo-panel__item">
                <div class="voting-wjt voting-wjt_infopanel js-voting  ">
                <button type="button" disabled class="voting-wjt__button voting-wjt__button_plus js-plus" title="Read-only пользователи не могут голосовать">
                  <span>&uarr;</span>
                </button>

                <div class="voting-wjt__counter js-mark">
                  <span class="voting-wjt__result-score js-score" title="Оценка статьи пользователями">{{rating}}</span>
                </div>

                <button type="button" disabled class="voting-wjt__button voting-wjt__button_minus js-minus" title="Read-only пользователи не могут голосовать">
                  <span>&darr;</span>
                </button>
              </div>
            </li>
            <li class="postinfo-panel__item">
              <div class="views-count_post" title="Просмотры публикации">{{views}}</div>
            </li>
            <li class="postinfo-panel__item">
              <div class="favorite-wjt favorite">
                <button type="button" class="favorite-wjt__button add" data-id="{{id}}" title="Добавить в избранное" onclick="return posts_add_to_favorite(this);">
                  <span>В избранное</span>
                </button>
                <span class="favorite-wjt__counter js-favs_count" title="Количество пользователей, добавивших публикацию в избранное">{{favorites}}</span>
              </div>
            </li>
            <li class="postinfo-panel__item post-author">
              <a title="Автор публикации" class="post-author__link" href="/users/{{nickname}}/" >
                <img src="/img/avatars/{{nickname}}.jpg" class="post-author__pic"/>@{{nickname}}
              </a>
            </li>
            <li class="postinfo-panel__item postinfo-panel__item_comments">
              <div class="post-comments">
                <a href="/post/{{id}}/#comments" class="post-comments__link" title="Комментировать">
                  <span class="post-comments_all">Комментировать</span>
                </a>
              </div>
            </li>
          </ul>
        </div>
      </div>
{{/articles}}
</div>
</div>
</div>

<div class="footer_panel">
            <div id="footer">
  <dl>
    <dd><a href="/auth/">Войти</a></dd>
    <dd><a href="/register/">Регистрация</a></dd>
  </dl>
  <dl>
    <dt>Разделы</dt>
    <dd><a href="/posts/top/">Публикации</a></dd>
    <dd><a href="/hubs/">Хабы</a></dd>
    <dd><a href="/companies/">Компании</a></dd>
    <dd><a href="/users/">Пользователи</a></dd>
    <dd><a href="/sandbox/">Песочница</a></dd>

  </dl>
  <dl>
    <dt>Инфо</dt>
    <dd><a href="/info/about/">О сайте</a></dd>
    <dd><a href="/info/help/rules/">Правила</a></dd>
    <dd><a href="/info/help/">Помощь</a></dd>
    <dd><a href="/info/agreement/">Соглашение</a></dd>
  </dl>
  <dl>
    <dt>Услуги</dt>
    <dd><a href="/advertising/">Реклама</a></dd>
      <dd><a href="/content/">Контент</a></dd>
  </dl>

  <dl>
    <dt>Разное</dt>
    <dd><a href="/apps/">Приложения</a></dd>
    <dd><a href="/hh/">Работа в IT</a></dd>
  </dl>
  <div class="copyright">

    <div class="about">
      <a href="http:///">openHabr</a>

      <br><br>
      <a href="/feedback/">Служба поддержки</a><br><br>


      <div class="social_accounts">
        <a href="https://twitter.com/habrahabr" class="tw"></a>
        <a href="https://www.facebook.com/habrahabr.ru" class="fb"></a>
        <a href="http://vk.com/habr" class="vk"></a>
        <!-- <a href="" class="gp"></a> //-->
      </div>

    </div>
  </div>
</div>
          </div>

</div>
</body>
</html>

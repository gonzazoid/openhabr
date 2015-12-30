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
<b>hella, {{user.name}}</b>
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
            <a href="/post/270673/" class="post_title">{{title}}</a>
          </h1>
          <div class="hubs">
            <a href="/hub/programming/" class="hub " title="Вы не подписаны на этот хаб" >Программирование</a><span class="profiled_hub" title="Профильный хаб">*</span>, 
            <a href="/hub/ui/" class="hub " title="Вы не подписаны на этот хаб" >Интерфейсы</a><span class="profiled_hub" title="Профильный хаб">*</span>, 
            <a href="/hub/webdev/" class="hub subscribed" title="Вы подписаны на этот хаб" >Веб-разработка</a><span class="profiled_hub" title="Профильный хаб">*</span>, 
            <a href="/hub/ReactJS/" class="hub " title="Вы не подписаны на этот хаб" >ReactJS</a><span class="profiled_hub" title="Профильный хаб">*</span>, 
            <a href="/hub/javascript/" class="hub " title="Вы не подписаны на этот хаб" >JavaScript</a><span class="profiled_hub" title="Профильный хаб">*</span>
          </div>
          <div class="content html_format">
            {{cut}} 
            <div class="buttons">
              <a class="button habracut" href="/post/270673/#habracut">И как его правильно использовать?</a>
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
                  <span class="voting-wjt__result-score js-score" title="Оценка будет видна после завершения голосования">&mdash;</span>
                </div>

                <button type="button" disabled class="voting-wjt__button voting-wjt__button_minus js-minus" title="Read-only пользователи не могут голосовать">
                  <span>&darr;</span>
                </button>
              </div>
            </li>
            <li class="postinfo-panel__item">
              <div class="views-count_post" title="Просмотры публикации">109</div>
            </li>
            <li class="postinfo-panel__item">
              <div class="favorite-wjt favorite">
                <button type="button" class="favorite-wjt__button add" title="Добавить в избранное" onclick="return posts_add_to_favorite(this, '2', 270673);">
                  <span>В избранное</span>
                </button>
                <span class="favorite-wjt__counter js-favs_count" title="Количество пользователей, добавивших публикацию в избранное">4</span>
              </div>
            </li>
            <li class="postinfo-panel__item post-author">
              <a title="Автор публикации" class="post-author__link" href="/users/ekubyshin/" >
                <img src="/getpro/habr/avatars/a15/01d/305/a1501d305b24b29765a9a63b93970230.jpg" class="post-author__pic"/>@ekubyshin
              </a>
            </li>
            <li class="postinfo-panel__item postinfo-panel__item_comments">
              <div class="post-comments">
                <a href="/post/270673/#comments" class="post-comments__link" title="Комментировать">
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
</div>
</body>
</html>

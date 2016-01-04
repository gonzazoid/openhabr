<!DOCTYPE html>
<html lang="ru">
<head>
<title>{{article.title}}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link href="/css/users_index.css" rel="stylesheet" media="all" />
<link href="/css/post_common_css.css" rel="stylesheet" media="all" />
<link href="/css/posts.css" rel="stylesheet" media="all" />
<link href="/css/main.css" rel="stylesheet" media="all" />
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

  <div class="page_head">
    <h2 class="title">Пользователи</h2>
  </div>
  <div class="content_left js-content_left">
    <div class="peoples_list">
      <div class="users_header">
        <div class="rating">рейтинг</div>
        <div class="karma">карма</div>
      </div>
      <div class="users peoples" id="peoples">
{{#users}}
        <div class="user " id="user_{{id}}">
          <div class="rating">{{rating}}</div>
          <div class="karma">{{carma}}</div>
          <div class="rating_change"></div>

          <div class="avatar"><a href="/users/{{nickname}}/">
<img src="/img/avatars/{{nickname}}.jpg">
    </a>
  </div>

  <div class="info">
    <div class="userlogin">
        <div class="username"><a href="/users/{{nickname}}/">{{nickname}}</a></div>

          <div class="buttons">
            <input type="button" class="btn btn_subscribe  subscribeUser" value="Подписаться" data-id="{{id}}" data-login="{{nickname}}">
            <input type="button" class="btn btn_subscribe btn_subscribed hidden unsubscribeUser" value="Отписаться" data-id="{{id}}" data-login="{{nickname}}">
          </div>
    </div>

    <div class="lifetime">1 месяц на сайте</div>
    <div class="last_post">последняя публикация: <a href="http://habrahabr.ru/post/273249/" class="grey">Как попасть на дачу президента в пять часов утра</a></div>


  </div>
  <div class="clear"></div>
</div>
{{/users}}

      </div>
    </div>
  </div>
{{>footer}}

</div>
</div>
</div>
</body>
</html>

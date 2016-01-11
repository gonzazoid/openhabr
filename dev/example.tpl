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
  <div id="navbar" style="bottom: 29px;">
    <div class="nav_panel">
      <a href="/users/{{user.nickname}}/" class="tab tab_user" data-tab="user_tab" title="{{user.nickname}}">

          <img src="/img/avatars/{{user.nickname}}.jpg" class="author-info__image-pic">
                <span class="count navbar_count_new_messages"></span>
            </a>
<!-- если пользователь read-only - ссылка на публикацию в песочницу иначе - на новый пост -->
{{#user.readonly}}
            <a href="/sandbox/add/" class="tab tab_add_post" title="Новая публикация в песочницу">+</a>
{{/user.readonly}}
{{^user.readonly}}
            <a href="/posts/add/" class="tab tab_add_post" title="Новая публикация в общую ленту">+</a>
{{/user.readonly}}
    </div>

  </div>
<div class="inner">
<div class="column-wrapper">
<div class="posts_list">

{{your workflow}}

</div>
</div>
</div>
{{>footer}}
</div>
</body>
</html>

<!DOCTYPE html>
<html lang="ru">
<head>
<title>{{article.title}}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

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
          Редактор Хабрахабра
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
                <span class="stats__value">Комментарии</span>
            </span></a>
          </li>
          <li class="tabs-menu__item tabs-menu__item_user-profile tabs-menu__item_inline">
            <a href="/users/{{article.nickname}}/favorites/" class="tab-item tab-item_stacked ">
              <span class="tab-item__value stats">
                <span class="stats__counters stats__counters_big">
                  <strong class="counter">53</strong>
                </span>
                <span class="stats__value">Избранное</span>
            </span></a>
          </li>
          <li class="tabs-menu__item tabs-menu__item_user-profile tabs-menu__item_inline">
            <a href="/users/{{article.nickname}}/subscription/followers/" class="tab-item tab-item_stacked ">
              <span class="tab-item__value stats">
                <span class="stats__counters stats__counters_big">
                  <strong class="counter">274</strong>
                </span>
                <span class="stats__value">Подписчики</span>
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
        {{article.body}}      
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
          <a href="/users/{{article.nickname}}" class="author-info__image">
            <img src="/img/avatars/{{article.nickname}}.jpg" class="author-info__image-pic"/>
          </a>
          <div class="author-info__desc">
            <div class="author-info__username">
              <a href="/users/{{article.nickname}}" class="author-info__nickname">@{{article.nickname}}</a>
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
{{> comment}}
{{>comments}}
{{/article.comments}}
<!-- comments -->
      </div>
    </div>
  </div>

      </div>
    </div>
  </div>

 

</div>
</div>
</div>
</div>
</body>
</html>

<!DOCTYPE html>
<html lang="ru">
<head>
<title>{{user.nickname}}</title>
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
        <a href="/users/{{profile.nickname}}/" class="author-info__image">
          <img src="/img/avatars/{{profile.nickname}}.jpg" class="author-info__image-pic">
        </a>
        <div class="author-info__desc">
          <div class="author-info__username">
            <a href="/users/{{profile.nickname}}/" class="author-info__name">{{profile.fullname}}</a> 
            <a href="/users/{{profile.nickname}}/" class="author-info__nickname">@{{profile.nickname}}</a>
          </div>
          <div class="author-info__specialization">
              {{profile.status}}
          </div>
        </div>
      </div>
      <div class="profile-header__stats">
        <div class="karma__widjet voting-wjt js-karma  ">
          <div class="voting-wjt__counter js-karma-mark voting-wjt__counter_positive " title="TODO х голосов">
            <div class="voting-wjt__counter-score js-karma_num">{{profile.carma}}</div>
            <div class="voting-wjt__label">карма</div>
          </div>
        </div>
        <div class="user-rating" title="Рейтинг пользователя">
          <div class="user-rating__value">{{profile.rating}}</div>
          <div class="user-rating__label">рейтинг</div>
        </div>
      </div>
      <div class="profile-header__buttons" style="display: inline-block;">
          <button type="button" class="btn btn_blue btn_large " id="followUser" title="Подписаться на пользователя" data-login="{{profile.nickname}}">Подписаться</button>
          <button type="button" class="btn btn_blue btn_subscribed btn_large hidden" id="unfollowUser" title="Вы подписаны на пользователя" data-login="{{profile.nickname}}">Подписан</button>
      </div>
    </div>
    
<div class="column-wrapper">
<div class="tabs">
    <ul class="tabs-menu tabs-menu_habrahabr">
          <li class="tabs-menu__item tabs-menu__item_user-profile tabs-menu__item_inline">
            <a href="/users/{{profile.nickname}}/" class="tab-item tab-item_stacked ">
              <span class="tab-item__value stats">
                <span class="stats__counters stats__counters_big">
                  <strong class="counter"></strong>
                </span>
                <span class="stats__value">Профиль</span>
            </span></a>
          </li>
          <li class="tabs-menu__item tabs-menu__item_user-profile tabs-menu__item_inline">
            <a href="/users/{{profile.nickname}}/topics/" class="tab-item tab-item_stacked tab-item_current">
              <span class="tab-item__value stats">
                <span class="stats__counters stats__counters_big">
                  <strong class="counter">199</strong>
                </span>
                <span class="stats__value">Публикации</span>
            </span></a>
          </li>
          <li class="tabs-menu__item tabs-menu__item_user-profile tabs-menu__item_inline">
            <a href="/users/{{profile.nickname}}/comments/" class="tab-item tab-item_stacked ">
              <span class="tab-item__value stats">
                <span class="stats__counters stats__counters_big">
                  <strong class="counter">1,4k</strong>
                </span>
                <span class="stats__value">Комментарии</span>
            </span></a>
          </li>
          <li class="tabs-menu__item tabs-menu__item_user-profile tabs-menu__item_inline">
            <a href="/users/{{profile.nickname}}/favorites/" class="tab-item tab-item_stacked ">
              <span class="tab-item__value stats">
                <span class="stats__counters stats__counters_big">
                  <strong class="counter">53</strong>
                </span>
                <span class="stats__value">Избранное</span>
            </span></a>
          </li>
          <li class="tabs-menu__item tabs-menu__item_user-profile tabs-menu__item_inline">
            <a href="/users/{{profile.nickname}}/subscription/followers/" class="tab-item tab-item_stacked ">
              <span class="tab-item__value stats">
                <span class="stats__counters stats__counters_big">
                  <strong class="counter">274</strong>
                </span>
                <span class="stats__value">Подписчики</span>
            </span></a>
          </li>
    </ul>

  </div>
</div>
{{>footer}}

  </div>
</div>
</body>
</html>

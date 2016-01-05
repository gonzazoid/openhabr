<!DOCTYPE html>
<html lang="ru">
<head>
<title>{{user.nickname}}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link href="/css/post_common_css.css" rel="stylesheet" media="all" />
<link href="/css/posts.css" rel="stylesheet" media="all" />
<link href="/css/main.css" rel="stylesheet" media="all" />
<link href="/css/profile.css" rel="stylesheet" media="all" />
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
<div class="user_profile">

          


              <dl>
                <dt>Место в рейтинге:</dt>
                <dd>

                    Не участвует
                </dd>
              </dl>

              <dl>
                <dt>Заметка:</dt>
                <dd class="note" id="private_note">
                  <span class="current_note"></span>
                  <span class="add_note">Написать заметку</span>
                  <form id="edit_note" method="post" class="edit_note hidden">
                    <input type="hidden" name="login" value="Vilyx">
                    <input id="note_text" class="text" name="note" value="">
                    <div class="description">Комментарий к пользователю (он виден только вам).</div>
                    <div class="buttons"><input type="submit" value="Сохранить"> или <span class="cancel_note">отменить</span></div>
                  </form>
                </dd>
              </dl>



              <dl>
                <dt>Значки:</dt>
                <dd>
                  <ul id="people-tags">
                  {{#profile.medals}}
                    <li>
                     <a title="description" class="habred"><span>title</span></a>
                    </li>
                   {{/profile.medals}}
                    <li>
                     
                     <a title="Пользователь, зарегистрированный более 3-х лет назад, с кармой больше 50." class="oldresident"><span>Старожил</span></a>
                    </li>
                  </ul>
                </dd>
              </dl>









            <dl class="hubs_list">
              <dt>Состоит в:</dt>
              <dd>
                <ul class="grey" id="hubs_data_items">
                    <li class="">
                      <a class="" href="/hub/flash_platform/">Adobe Flash</a>
                    </li>
                    <li class="">
                      <a class="" href="/hub/Dart/">Dart</a>
                    </li>
                    <li class="">
                      <a class="" href="/hub/erlang/">Erlang/OTP</a>
                    </li>
                    <li class="">
                      <a class="" href="/hub/gdev/">Game Development</a>
                    </li>
                    <li class="">
                      <a class="" href="/hub/perl/">Perl</a>
                    </li>
                    <li class="">
                      <a class="" href="/hub/unity3d/">Unity3D</a>
                    </li>
                    <li class="">
                      <a class="" href="/hub/vs/">Visual Studio</a>
                    </li>
                    <li class="">
                      <a class="" href="/hub/algorithms/">Алгоритмы</a>
                    </li>
                    <li class="">
                      <a class="" href="/hub/programming/">Программирование</a>
                    </li>
                </ul>
              </dd>
            </dl>

          <dl>
            <dt>
              
               Зарегистрирован: 
            </dt>
            <dd class="grey">
              15 ноября 2011 в  16:40
            </dd>
          </dl>

            <dl>
              <dt>
                
                 Приглашен: 
              </dt>
              <dd class="grey">07 декабря 2012 в  13:39
                   по приглашению <a href="http://habrahabr.ru/">НЛО</a>
              </dd>
            </dl>


            <dl>
              <dt>Активность:</dt>
              <dd>
                  Последний раз был на сайте 05 января 2016 в  16:50
              </dd>
            </dl>
      </div>
</div>
{{>footer}}

  </div>
</div>
</body>
</html>

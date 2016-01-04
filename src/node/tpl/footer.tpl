<div class="footer_panel">
  <div id="footer">
{{#user}}
    <dl class="user">
      <dt><a href="/users/{{user.nickname}}/">{{user.nickname}}</a></dt>
      <dd><a href="/auth/logout/">logout</a></dd>
      <dd><a href="/feed/">Лента</a></dd>
      <dd><a href="/tracker/">Трекер</a></dd>
      <dd><a href="/sandbox/add/">Написать</a></dd>
      <dd><a href="/auth/settings/upgrade/">Read-only</a></dd>
      <dd><a href="/auth/settings/">Настройки</a></dd>
    </dl>
{{/user}}
{{^user}}
  <dl>
    <dd><a href="/auth/">Войти</a></dd>
    <dd><a href="/register/">Регистрация</a></dd>
  </dl>
{{/user}}
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

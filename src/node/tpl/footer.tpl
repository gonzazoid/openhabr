<div class="footer_panel">
  <div id="footer">
{{#user}}
    <dl class="user">
      <dt><a href="/users/{{user.nickname}}/">{{user.nickname}}</a></dt>
      <dd><a href="/auth/logout/">logout</a></dd>
      <dd><a class="todo" href="/feed/">Лента</a></dd>
      <dd><a class="todo" href="/tracker/">Трекер</a></dd>
      <dd><a class="todo" href="/sandbox/add/">Написать</a></dd>
      <dd><a class="todo" href="/auth/settings/upgrade/">Read-only</a></dd>
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
    <dd><a class="todo" href="/posts/top/">Публикации</a></dd>
    <dd><a class="todo" href="/hubs/">Хабы</a></dd>
    <dd><a class="todo" href="/companies/">Компании</a></dd>
    <dd><a href="/users/">Пользователи</a></dd>
    <dd><a class="todo" href="/sandbox/">Песочница</a></dd>

  </dl>
  <dl>
    <dt>Инфо</dt>
    <dd><a class="todo" href="/info/about/">О сайте</a></dd>
    <dd><a class="todo" href="/info/help/rules/">Правила</a></dd>
    <dd><a class="todo" href="/info/help/">Помощь</a></dd>
    <dd><a class="todo" href="/info/agreement/">Соглашение</a></dd>
  </dl>
  <dl>
    <dt>Услуги</dt>
    <dd><a class="todo" href="/advertising/">Реклама</a></dd>
      <dd><a class="todo" href="/content/">Контент</a></dd>
  </dl>

  <dl>
    <dt>Разное</dt>
    <dd><a class="todo" href="/apps/">Приложения</a></dd>
    <dd><a class="todo" href="/hh/">Работа в IT</a></dd>
  </dl>
  <div class="copyright">
    <div class="about">
      <a class="todo" href="http:///">openHabr</a>
      <br><br>
      <a class="todo" href="/feedback/">Служба поддержки</a><br><br>
      <div class="social_accounts">
        <a href="https://twitter.com/openhabr" class="tw"></a>
        <a href="https://www.facebook.com/openhabr.ru" class="fb"></a>
        <a href="http://vk.com/openhabr" class="vk"></a>
        <!-- <a href="" class="gp"></a> //-->
      </div>
    </div>
  </div>
</div>
</div>

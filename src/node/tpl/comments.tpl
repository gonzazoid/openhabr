<div class="comment_item" id="comment_8281181" >
  <span class="parent_id" data-parent_id="0"></span>
  <div class="comment_body ">
    <div class="info comments-list__item comment-item  is_topic_starter  " rel="8281983">
      <div class="folding-dot-holder"><div class="folding-dot"></div></div>
      <a href="http://habrahabr.ru/users/{{nickname}}/" class="comment-item__avatar">
        <img src="/img/avatars/{{nickname}}.jpg" alt="" class="comment-item__avatar-img"/>
      </a>
      <a href="/users/{{nickname}}/" class="comment-item__username">{{nickname}}</a>
      <time class="comment-item__time_published">15 февраля 2015 в 19:14</time>
      <span class="comment-item__controls">
        <a href="#comment_{{id}}" class="icon_comment-anchor" title="Ссылка на комментарий"></a>
        <a href="#" class="icon_comment-favorite add" onclick="return comments_add_to_favorite(this, '3', 8281983 )" title="В избранное"></a>
        <span class="icon_comment-tree js-comment_tree" data-id="8281983" data-parent_id="8281885" title="Показать ветку комментариев"></span>
        <a href="#comment_8281885" class="icon_comment-parent js-comment_parent" data-id="8281983" data-parent_id="8281885" title="Показать предыдущий комментарий"></a>
        <span class="js-comment_chidren" title="Вернуться к ответу"></span>
      </span>
      <div id="voting_8281983" class="voting-wjt voting-wjt_comments js-voting   ">
        <div class="voting-wjt__counter js-mark voting-wjt__counter_positive ">
          <span class="voting-wjt__counter-score js-score" title="Всего 2: &uarr;2 и &darr;0">+2</span>
        </div>
        <button type="button" disabled class="voting-wjt__button voting-wjt__button_plus js-plus" title="Read-only не могут голосовать"><span>&uarr;</span></button>
        <button type="button" disabled class="voting-wjt__button voting-wjt__button_minus js-minus" title="Read-only не могут голосовать"><span>&darr;</span></button>
      </div>
    </div>
    <div class="message html_format ">
         {{body}} 
    </div>
    <div class="reply_form_placeholder"></div>
    <div class="reply">
    </div>
  </div>
  <div class="reply_comments" id="reply_comments_8281983">
{{#comments}}
  {{> comment}}
{{/comments}}
  </div>
</div>

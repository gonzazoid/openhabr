<!DOCTYPE html>
<html lang="ru">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- это для постов -->
<link href="/css/post_common_css.css" rel="stylesheet" media="all" />


<link href="/css/highlightjs_github.css" rel="stylesheet" media="all" />
<link href="/css/libs_chosen.css" rel="stylesheet" media="all" />
<link href="/css/sandbox_edit.css" rel="stylesheet" media="all" />
<link href="/css/forms.css" rel="stylesheet" media="all" />
<link href="/css/posts.css" rel="stylesheet" media="all" />
<link href="/css/hubs_all.css" rel="stylesheet" media="all" />
<link href="/css/main.css" rel="stylesheet" media="all" />

<script type="text/javascript" src="/js/global_main.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/libs_wysiwyg.js"></script>
<script type="text/javascript" src="/js/sandbox_edit.js"></script>
<script type="text/javascript" src="/js/topic_form.js"></script>

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
<div class="content_left">
    

    <div class="sandbox_edit">
      <h1>Публикация</h1>

        <form action="#" method="post" id="sandbox_post_form">


          <div id="preview_placeholder" class="hidden"></div>
          <input type="hidden" name="id" value="">
          
<div class="item hubs required">
	<label for="hubs"> 
		В какой хаб?<sup class="required_field">*</sup> 
	</label>
	
	<div class="chosen_multiselect">
	
		<select data-placeholder=" " class="chzn-select chzn-done" multiple="" style="width: 100%; display: none;" name="hubs[]" id="hubs">


      <optgroup label="Тематические">
	      <option value="7289" data-subscribers="102403" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">*nix</option> 
	      <option value="546" data-subscribers="93017" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">.NET</option> 
	      <option value="17703" data-subscribers="68474" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">1С-Битрикс</option> 
	      <option value="17690" data-subscribers="76985" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">API</option> 
	      <option value="7149" data-subscribers="83288" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">ASP</option> 
	      <option value="17871" data-subscribers="63722" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Accessibility</option> 
	      <option value="17705" data-subscribers="67796" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Action Script</option> 
	      <option value="6258" data-subscribers="83461" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Adobe Flash</option> 
	      <option value="13" data-subscribers="92218" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Ajax</option> 
	      <option value="17682" data-subscribers="74652" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Amazon Web Services</option> 
	      <option value="18109" data-subscribers="46501" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">AngularJS</option> 
	      <option value="17697" data-subscribers="82955" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Apache</option> 
	      <option value="17706" data-subscribers="66564" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Apache Flex</option> 
	      <option value="595" data-subscribers="86332" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Assembler</option> 
	      <option value="17707" data-subscribers="73710" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Asterisk</option> 
	      <option value="17795" data-subscribers="66987" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Big Data</option> 
	      <option value="19041" data-subscribers="19136" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Bitbucket</option> 
	      <option value="17397" data-subscribers="79548" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Brainfuck</option> 
	      <option value="17717" data-subscribers="84812" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">C</option> 
	      <option value="17718" data-subscribers="88306" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">C#</option> 
	      <option value="559" data-subscribers="101432" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">C++</option> 
	      <option value="17698" data-subscribers="76053" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">CAD/CAM</option> 
	      <option value="21" data-subscribers="83201" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">CMS</option> 
	      <option value="17739" data-subscribers="69022" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">CRM-системы</option> 
	      <option value="307" data-subscribers="100690" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">CSS</option> 
	      <option value="412" data-subscribers="72190" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">CakePHP</option> 
	      <option value="17187" data-subscribers="80737" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Canvas</option> 
	      <option value="6900" data-subscribers="85985" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Cisco</option> 
	      <option value="17710" data-subscribers="71238" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Cobol</option> 
	      <option value="17711" data-subscribers="73384" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Cocoa</option> 
	      <option value="564" data-subscribers="73424" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">CodeIgniter</option> 
	      <option value="16995" data-subscribers="81329" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Creative Commons</option> 
	      <option value="17222" data-subscribers="73287" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Cubrid</option> 
	      <option value="18298" data-subscribers="32932" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">D</option> 
	      <option value="17708" data-subscribers="77640" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">DNS</option> 
	      <option value="17712" data-subscribers="73137" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Dart</option> 
	      <option value="7152" data-subscribers="84950" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Data Mining</option> 
	      <option value="604" data-subscribers="82710" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Delphi</option> 
	      <option value="18282" data-subscribers="33641" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Derby.js</option> 
	      <option value="403" data-subscribers="78264" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Django</option> 
	      <option value="9699" data-subscribers="75935" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Doctrine ORM</option> 
	      <option value="314" data-subscribers="76615" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Drupal</option> 
	      <option value="18278" data-subscribers="33899" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">ECM/СЭД</option> 
	      <option value="17699" data-subscribers="78020" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">ERP-системы</option> 
	      <option value="427" data-subscribers="77227" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Eclipse</option> 
	      <option value="17869" data-subscribers="57069" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Emacs</option> 
	      <option value="8238" data-subscribers="82118" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Erlang/OTP</option> 
	      <option value="19733" data-subscribers="11897" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">FPGA</option> 
	      <option value="17691" data-subscribers="73103" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Facebook API</option> 
	      <option value="9291" data-subscribers="79073" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Fidonet</option> 
	      <option value="18574" data-subscribers="33300" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Firebird/Interbase</option> 
	      <option value="49" data-subscribers="103355" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Firefox</option> 
	      <option value="19069" data-subscribers="15339" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Forth</option> 
	      <option value="17713" data-subscribers="71858" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Fortran</option> 
	      <option value="9233" data-subscribers="93998" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">GPGPU</option> 
	      <option value="350" data-subscribers="86996" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">GPS</option> 
	      <option value="17451" data-subscribers="68437" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">GTK+</option> 
	      <option value="7773" data-subscribers="100801" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Game Development</option> 
	      <option value="7151" data-subscribers="99034" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Git</option> 
	      <option value="18790" data-subscribers="34990" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">GitHub</option> 
	      <option value="17748" data-subscribers="70508" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Go</option> 
	      <option value="17692" data-subscribers="78079" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Google API</option> 
	      <option value="9659" data-subscribers="84172" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Google App Engine</option> 
	      <option value="6103" data-subscribers="233728" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Google Chrome</option> 
	      <option value="467" data-subscribers="85876" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Google Web Toolkit</option> 
	      <option value="5996" data-subscribers="73639" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">GreaseMonkey</option> 
	      <option value="5688" data-subscribers="72154" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Groovy &amp; Grails</option> 
	      <option value="17103" data-subscribers="99816" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">HTML</option> 
	      <option value="8424" data-subscribers="82288" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Haskell</option> 
	      <option value="17702" data-subscribers="76634" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Help Desk Software</option> 
	      <option value="18288" data-subscribers="38205" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">I2P</option> 
	      <option value="17701" data-subscribers="77129" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">IIS</option> 
	      <option value="92" data-subscribers="83184" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">IM</option> 
	      <option value="5906" data-subscribers="75753" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">INFOLUST</option> 
	      <option value="8711" data-subscribers="84223" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">IPTV</option> 
	      <option value="18754" data-subscribers="34693" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">IPv6</option> 
	      <option value="17189" data-subscribers="103544" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">IT-стандарты</option> 
	      <option value="598" data-subscribers="91672" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Internet Explorer</option> 
	      <option value="375" data-subscribers="102271" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">JAVA</option> 
	      <option value="357" data-subscribers="103160" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">JavaScript</option> 
	      <option value="17704" data-subscribers="70863" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Joomla</option> 
	      <option value="18840" data-subscribers="23597" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Julia</option> 
	      <option value="7080" data-subscribers="72845" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Kohana</option> 
	      <option value="19441" data-subscribers="3035" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Kotlin</option> 
	      <option value="7589" data-subscribers="75206" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">LaTeX</option> 
	      <option value="17418" data-subscribers="78505" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">LabVIEW</option> 
	      <option value="18812" data-subscribers="27453" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Laravel</option> 
	      <option value="642" data-subscribers="81431" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Lisp</option> 
	      <option value="6346" data-subscribers="72792" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">LiveStreet</option> 
	      <option value="17720" data-subscribers="74770" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Lua</option> 
	      <option value="361" data-subscribers="73710" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">MODX</option> 
	      <option value="17419" data-subscribers="77090" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Maps API</option> 
	      <option value="18919" data-subscribers="22632" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Mediawiki</option> 
	      <option value="17721" data-subscribers="74758" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Mercurial</option> 
	      <option value="18290" data-subscribers="38951" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Mesh-сети</option> 
	      <option value="18732" data-subscribers="30109" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Meteor.JS</option> 
	      <option value="17680" data-subscribers="69575" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Microsoft Access</option> 
	      <option value="17851" data-subscribers="55324" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Microsoft Azure</option> 
	      <option value="19581" data-subscribers="1174" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Microsoft Edge</option> 
	      <option value="17378" data-subscribers="80506" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Microsoft SQL Server</option> 
	      <option value="17192" data-subscribers="83014" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">MongoDB</option> 
	      <option value="11272" data-subscribers="82355" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Mono и Moonlight</option> 
	      <option value="6341" data-subscribers="72575" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">MooTools</option> 
	      <option value="306" data-subscribers="96744" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">MySQL</option> 
	      <option value="6659" data-subscribers="93204" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Nginx</option> 
	      <option value="16848" data-subscribers="86040" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">NoSQL</option> 
	      <option value="17110" data-subscribers="29485" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Node.JS</option> 
	      <option value="17714" data-subscribers="78899" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Objective C</option> 
	      <option value="144" data-subscribers="100648" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Open source</option> 
	      <option value="17153" data-subscribers="84256" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">OpenStreetMap</option> 
	      <option value="93" data-subscribers="95784" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Opera</option> 
	      <option value="312" data-subscribers="81679" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Oracle</option> 
	      <option value="260" data-subscribers="105013" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">PHP</option> 
	      <option value="33" data-subscribers="88835" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Peer-to-Peer</option> 
	      <option value="12" data-subscribers="83174" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Perl</option> 
	      <option value="358" data-subscribers="85260" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">PostgreSQL</option> 
	      <option value="6065" data-subscribers="84068" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">PowerShell</option> 
	      <option value="17461" data-subscribers="73529" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Prolog</option> 
	      <option value="340" data-subscribers="99965" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Python</option> 
	      <option value="7330" data-subscribers="79522" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Qt</option> 
	      <option value="17939" data-subscribers="53587" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">R</option> 
	      <option value="19327" data-subscribers="10100" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">ReactJS</option> 
	      <option value="224" data-subscribers="88096" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Ruby</option> 
	      <option value="8279" data-subscribers="77787" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Ruby on Rails</option> 
	      <option value="18961" data-subscribers="20370" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Rust</option> 
	      <option value="18937" data-subscribers="23772" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">SAN</option> 
	      <option value="18818" data-subscribers="24461" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">SCADA</option> 
	      <option value="594" data-subscribers="93015" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">SQL</option> 
	      <option value="18554" data-subscribers="38655" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">SQLite</option> 
	      <option value="12365" data-subscribers="83609" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">SaaS / S+S</option> 
	      <option value="376" data-subscribers="91066" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Safari</option> 
	      <option value="16263" data-subscribers="82215" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Scala</option> 
	      <option value="19369" data-subscribers="6595" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Service Desk</option> 
	      <option value="486" data-subscribers="81138" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">SharePoint</option> 
	      <option value="533" data-subscribers="81915" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Silverlight</option> 
	      <option value="146" data-subscribers="92460" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Skype</option> 
	      <option value="7233" data-subscribers="78599" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Small Basic</option> 
	      <option value="18869" data-subscribers="21981" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Smalltalk</option> 
	      <option value="7929" data-subscribers="82729" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Sphinx</option> 
	      <option value="19039" data-subscribers="19769" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Swift</option> 
	      <option value="477" data-subscribers="74832" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Symfony</option> 
	      <option value="7606" data-subscribers="87172" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">TDD</option> 
	      <option value="8738" data-subscribers="72217" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Twisted</option> 
	      <option value="17694" data-subscribers="72270" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Twitter API</option> 
	      <option value="17715" data-subscribers="77154" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">UML Design</option> 
	      <option value="17831" data-subscribers="65068" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Unity3D</option> 
	      <option value="19367" data-subscribers="7200" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Unreal Engine</option> 
	      <option value="17463" data-subscribers="95948" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Usability</option> 
	      <option value="609" data-subscribers="87867" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">VIM</option> 
	      <option value="11606" data-subscribers="91979" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Visual Studio</option> 
	      <option value="18768" data-subscribers="30764" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">WebGL</option> 
	      <option value="17307" data-subscribers="75138" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Wiki-технология</option> 
	      <option value="73" data-subscribers="85866" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">WordPress</option> 
	      <option value="7026" data-subscribers="84317" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">XML</option> 
	      <option value="7860" data-subscribers="76712" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">XSLT</option> 
	      <option value="18794" data-subscribers="28473" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Xcode</option> 
	      <option value="9554" data-subscribers="77553" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Yii</option> 
	      <option value="603" data-subscribers="75593" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Zend Framework</option> 
	      <option value="538" data-subscribers="93706" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">jQuery</option> 
	      <option value="17681" data-subscribers="81829" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Администрирование баз данных</option> 
	      <option value="8000" data-subscribers="235558" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Алгоритмы</option> 
	      <option value="397" data-subscribers="86098" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Анализ и проектирование систем</option> 
	      <option value="17201" data-subscribers="96446" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Беспроводные технологии</option> 
	      <option value="602" data-subscribers="76786" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Библиотека ExtJS/Sencha</option> 
	      <option value="19257" data-subscribers="17817" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Браузеры</option> 
	      <option value="47" data-subscribers="238458" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Веб-дизайн</option> 
	      <option value="91" data-subscribers="504767" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Веб-разработка</option> 
	      <option value="449" data-subscribers="96862" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Векторная графика</option> 
	      <option value="19261" data-subscribers="12771" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Верстка писем</option> 
	      <option value="18202" data-subscribers="48099" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Визуализация данных</option> 
	      <option value="7312" data-subscribers="93090" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Виртуализация</option> 
	      <option value="332" data-subscribers="102462" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Вирусы и антивирусы</option> 
	      <option value="17693" data-subscribers="77210" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Вконтакте API</option> 
	      <option value="17351" data-subscribers="94205" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Восстановление данных</option> 
	      <option value="4" data-subscribers="100918" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Высокая производительность</option> 
	      <option value="17158" data-subscribers="84917" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">ГЛОНАСС</option> 
	      <option value="17783" data-subscribers="66100" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Геоинформационные сервисы</option> 
	      <option value="640" data-subscribers="95528" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Графические оболочки</option> 
	      <option value="19465" data-subscribers="3531" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Дизайн мобильных приложений</option> 
	      <option value="183" data-subscribers="88169" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Домены</option> 
	      <option value="6398" data-subscribers="92958" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">ИТ-инфраструктура</option> 
	      <option value="9188" data-subscribers="239239" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Интерфейсы</option> 
	      <option value="50" data-subscribers="501962" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Информационная безопасность</option> 
	      <option value="530" data-subscribers="94941" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Клиентская оптимизация</option> 
	      <option value="617" data-subscribers="91681" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Кодобред</option> 
	      <option value="17188" data-subscribers="91487" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Компиляторы</option> 
	      <option value="118" data-subscribers="102607" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Криптография</option> 
	      <option value="19341" data-subscribers="7981" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Локализация продуктов</option> 
	      <option value="17812" data-subscribers="76183" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Математика</option> 
	      <option value="19439" data-subscribers="6012" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Машинное обучение</option> 
	      <option value="19" data-subscribers="78351" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Микроформаты</option> 
	      <option value="229" data-subscribers="90030" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Мобильный веб</option> 
	      <option value="36" data-subscribers="501058" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Настройка Linux</option> 
	      <option value="84" data-subscribers="100994" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Ненормальное программирование</option> 
	      <option value="17719" data-subscribers="98357" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">ООП</option> 
	      <option value="16120" data-subscribers="92594" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Облачные вычисления</option> 
	      <option value="7875" data-subscribers="93516" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Оболочки</option> 
	      <option value="17175" data-subscribers="97236" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Обработка изображений</option> 
	      <option value="18081" data-subscribers="51827" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Открытые данные</option> 
	      <option value="17716" data-subscribers="83834" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Отладка</option> 
	      <option value="17822" data-subscribers="70994" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Параллельное программирование</option> 
	      <option value="233" data-subscribers="105332" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Платежные системы</option> 
	      <option value="126" data-subscribers="93382" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Поисковые технологии</option> 
	      <option value="359" data-subscribers="239256" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Программирование</option> 
	      <option value="19737" data-subscribers="92077" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Программирование микроконтроллеров</option> 
	      <option value="7504" data-subscribers="99152" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Проектирование и рефакторинг</option> 
	      <option value="18816" data-subscribers="30212" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Промышленное программирование</option> 
	      <option value="19309" data-subscribers="15889" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Профессиональная литература</option> 
	      <option value="643" data-subscribers="101208" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Работа с анимацией и 3D-графикой</option> 
	      <option value="262" data-subscribers="94022" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Работа с видео</option> 
	      <option value="302" data-subscribers="96229" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Работа с иконками</option> 
	      <option value="8745" data-subscribers="94227" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Работа со звуком</option> 
	      <option value="469" data-subscribers="136359" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка</option> 
	      <option value="19681" data-subscribers="336" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка для Office 365</option> 
	      <option value="19739" data-subscribers="25089" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка для интернета вещей</option> 
	      <option value="6345" data-subscribers="95018" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка мобильных приложений</option> 
	      <option value="17107" data-subscribers="105606" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка под Android</option> 
	      <option value="17747" data-subscribers="66719" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка под Bada</option> 
	      <option value="6801" data-subscribers="83397" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка под Java ME</option> 
	      <option value="19727" data-subscribers="251" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка под Linux</option> 
	      <option value="19253" data-subscribers="12132" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка под OS X</option> 
	      <option value="18180" data-subscribers="39153" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка под Tizen</option> 
	      <option value="19255" data-subscribers="14145" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка под Windows</option> 
	      <option value="17468" data-subscribers="79585" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка под Windows Phone</option> 
	      <option value="18810" data-subscribers="27162" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка под e-commerce</option> 
	      <option value="548" data-subscribers="96894" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка под iOS</option> 
	      <option value="19735" data-subscribers="6466" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка робототехники</option> 
	      <option value="19397" data-subscribers="7326" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка систем передачи данных</option> 
	      <option value="19395" data-subscribers="89342" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Разработка систем связи</option> 
	      <option value="18921" data-subscribers="27725" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Расширения для браузеров</option> 
	      <option value="19011" data-subscribers="23276" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Реверс-инжиниринг</option> 
	      <option value="9457" data-subscribers="98005" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Регулярные выражения</option> 
	      <option value="18792" data-subscribers="35839" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Резервное копирование</option> 
	      <option value="345" data-subscribers="89343" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Семантика</option> 
	      <option value="8880" data-subscribers="93530" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Серверная оптимизация</option> 
	      <option value="17350" data-subscribers="93380" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Серверное администрирование</option> 
	      <option value="17123" data-subscribers="100792" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Сетевые технологии</option> 
	      <option value="19203" data-subscribers="16396" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Сжатие данных</option> 
	      <option value="221" data-subscribers="101691" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Системное администрирование</option> 
	      <option value="5767" data-subscribers="96639" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Системное программирование</option> 
	      <option value="7414" data-subscribers="97455" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Системы управления версиями</option> 
	      <option value="524" data-subscribers="233110" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Совершенный код</option> 
	      <option value="28" data-subscribers="94747" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Спам и антиспам</option> 
	      <option value="89" data-subscribers="91628" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Спортивное программирование</option> 
	      <option value="19429" data-subscribers="93516" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Стандарты связи</option> 
	      <option value="19657" data-subscribers="707" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Телефония</option> 
	      <option value="210" data-subscribers="98026" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Тестирование IT-систем</option> 
	      <option value="19279" data-subscribers="14547" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Тестирование веб-сервисов</option> 
	      <option value="19289" data-subscribers="10493" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Тестирование игр</option> 
	      <option value="19281" data-subscribers="13220" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Тестирование мобильных приложений</option> 
	      <option value="348" data-subscribers="99735" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Типографика</option> 
	      <option value="19583" data-subscribers="2159" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Управление разработкой</option> 
	      <option value="17853" data-subscribers="68420" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Функциональное программирование</option> 
	      <option value="19275" data-subscribers="12919" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Хакатоны</option> 
	      <option value="20" data-subscribers="92378" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Хостинг</option> 
	      <option value="19197" data-subscribers="22112" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Хранение данных</option> 
	      <option value="17696" data-subscribers="75263" data-is_singleton="" data-is_offtop="0" data-is_profiled="1" data-is_rateless="0" data-type="collective">Яндекс API</option> 
      </optgroup>
			
    </select><div id="hubs_chzn" class="chzn-container chzn-container-multi" style="width: 926px;"><ul class="chzn-choices"><li class="search-field"><input type="text" value=" " class="default" autocomplete="off" style="width:25px;"></li></ul><div class="chzn-drop" style="left: -9000px; width: 924px; top: 27px;"><ul class="chzn-results"><li id="hubs_chzn_g_0" class="group-result"><span class="name">Тематические</span><span class="subscribers">Подписчики</span></li><li id="hubs_chzn_o_1" class="active-result group-option" style="">*nix</li><li id="hubs_chzn_o_2" class="active-result group-option" style="">.NET</li><li id="hubs_chzn_o_3" class="active-result group-option" style="">1С-Битрикс</li><li id="hubs_chzn_o_4" class="active-result group-option" style="">API</li><li id="hubs_chzn_o_5" class="active-result group-option" style="">ASP</li><li id="hubs_chzn_o_6" class="active-result group-option" style="">Accessibility</li><li id="hubs_chzn_o_7" class="active-result group-option" style="">Action Script</li><li id="hubs_chzn_o_8" class="active-result group-option" style="">Adobe Flash</li><li id="hubs_chzn_o_9" class="active-result group-option" style="">Ajax</li><li id="hubs_chzn_o_10" class="active-result group-option" style="">Amazon Web Services</li><li id="hubs_chzn_o_11" class="active-result group-option" style="">AngularJS</li><li id="hubs_chzn_o_12" class="active-result group-option" style="">Apache</li><li id="hubs_chzn_o_13" class="active-result group-option" style="">Apache Flex</li><li id="hubs_chzn_o_14" class="active-result group-option" style="">Assembler</li><li id="hubs_chzn_o_15" class="active-result group-option" style="">Asterisk</li><li id="hubs_chzn_o_16" class="active-result group-option" style="">Big Data</li><li id="hubs_chzn_o_17" class="active-result group-option" style="">Bitbucket</li><li id="hubs_chzn_o_18" class="active-result group-option" style="">Brainfuck</li><li id="hubs_chzn_o_19" class="active-result group-option" style="">C</li><li id="hubs_chzn_o_20" class="active-result group-option" style="">C#</li><li id="hubs_chzn_o_21" class="active-result group-option" style="">C++</li><li id="hubs_chzn_o_22" class="active-result group-option" style="">CAD/CAM</li><li id="hubs_chzn_o_23" class="active-result group-option" style="">CMS</li><li id="hubs_chzn_o_24" class="active-result group-option" style="">CRM-системы</li><li id="hubs_chzn_o_25" class="active-result group-option" style="">CSS</li><li id="hubs_chzn_o_26" class="active-result group-option" style="">CakePHP</li><li id="hubs_chzn_o_27" class="active-result group-option" style="">Canvas</li><li id="hubs_chzn_o_28" class="active-result group-option" style="">Cisco</li><li id="hubs_chzn_o_29" class="active-result group-option" style="">Cobol</li><li id="hubs_chzn_o_30" class="active-result group-option" style="">Cocoa</li><li id="hubs_chzn_o_31" class="active-result group-option" style="">CodeIgniter</li><li id="hubs_chzn_o_32" class="active-result group-option" style="">Creative Commons</li><li id="hubs_chzn_o_33" class="active-result group-option" style="">Cubrid</li><li id="hubs_chzn_o_34" class="active-result group-option" style="">D</li><li id="hubs_chzn_o_35" class="active-result group-option" style="">DNS</li><li id="hubs_chzn_o_36" class="active-result group-option" style="">Dart</li><li id="hubs_chzn_o_37" class="active-result group-option" style="">Data Mining</li><li id="hubs_chzn_o_38" class="active-result group-option" style="">Delphi</li><li id="hubs_chzn_o_39" class="active-result group-option" style="">Derby.js</li><li id="hubs_chzn_o_40" class="active-result group-option" style="">Django</li><li id="hubs_chzn_o_41" class="active-result group-option" style="">Doctrine ORM</li><li id="hubs_chzn_o_42" class="active-result group-option" style="">Drupal</li><li id="hubs_chzn_o_43" class="active-result group-option" style="">ECM/СЭД</li><li id="hubs_chzn_o_44" class="active-result group-option" style="">ERP-системы</li><li id="hubs_chzn_o_45" class="active-result group-option" style="">Eclipse</li><li id="hubs_chzn_o_46" class="active-result group-option" style="">Emacs</li><li id="hubs_chzn_o_47" class="active-result group-option" style="">Erlang/OTP</li><li id="hubs_chzn_o_48" class="active-result group-option" style="">FPGA</li><li id="hubs_chzn_o_49" class="active-result group-option" style="">Facebook API</li><li id="hubs_chzn_o_50" class="active-result group-option" style="">Fidonet</li><li id="hubs_chzn_o_51" class="active-result group-option" style="">Firebird/Interbase</li><li id="hubs_chzn_o_52" class="active-result group-option" style="">Firefox</li><li id="hubs_chzn_o_53" class="active-result group-option" style="">Forth</li><li id="hubs_chzn_o_54" class="active-result group-option" style="">Fortran</li><li id="hubs_chzn_o_55" class="active-result group-option" style="">GPGPU</li><li id="hubs_chzn_o_56" class="active-result group-option" style="">GPS</li><li id="hubs_chzn_o_57" class="active-result group-option" style="">GTK+</li><li id="hubs_chzn_o_58" class="active-result group-option" style="">Game Development</li><li id="hubs_chzn_o_59" class="active-result group-option" style="">Git</li><li id="hubs_chzn_o_60" class="active-result group-option" style="">GitHub</li><li id="hubs_chzn_o_61" class="active-result group-option" style="">Go</li><li id="hubs_chzn_o_62" class="active-result group-option" style="">Google API</li><li id="hubs_chzn_o_63" class="active-result group-option" style="">Google App Engine</li><li id="hubs_chzn_o_64" class="active-result group-option" style="">Google Chrome</li><li id="hubs_chzn_o_65" class="active-result group-option" style="">Google Web Toolkit</li><li id="hubs_chzn_o_66" class="active-result group-option" style="">GreaseMonkey</li><li id="hubs_chzn_o_67" class="active-result group-option" style="">Groovy &amp; Grails</li><li id="hubs_chzn_o_68" class="active-result group-option" style="">HTML</li><li id="hubs_chzn_o_69" class="active-result group-option" style="">Haskell</li><li id="hubs_chzn_o_70" class="active-result group-option" style="">Help Desk Software</li><li id="hubs_chzn_o_71" class="active-result group-option" style="">I2P</li><li id="hubs_chzn_o_72" class="active-result group-option" style="">IIS</li><li id="hubs_chzn_o_73" class="active-result group-option" style="">IM</li><li id="hubs_chzn_o_74" class="active-result group-option" style="">INFOLUST</li><li id="hubs_chzn_o_75" class="active-result group-option" style="">IPTV</li><li id="hubs_chzn_o_76" class="active-result group-option" style="">IPv6</li><li id="hubs_chzn_o_77" class="active-result group-option" style="">IT-стандарты</li><li id="hubs_chzn_o_78" class="active-result group-option" style="">Internet Explorer</li><li id="hubs_chzn_o_79" class="active-result group-option" style="">JAVA</li><li id="hubs_chzn_o_80" class="active-result group-option" style="">JavaScript</li><li id="hubs_chzn_o_81" class="active-result group-option" style="">Joomla</li><li id="hubs_chzn_o_82" class="active-result group-option" style="">Julia</li><li id="hubs_chzn_o_83" class="active-result group-option" style="">Kohana</li><li id="hubs_chzn_o_84" class="active-result group-option" style="">Kotlin</li><li id="hubs_chzn_o_85" class="active-result group-option" style="">LaTeX</li><li id="hubs_chzn_o_86" class="active-result group-option" style="">LabVIEW</li><li id="hubs_chzn_o_87" class="active-result group-option" style="">Laravel</li><li id="hubs_chzn_o_88" class="active-result group-option" style="">Lisp</li><li id="hubs_chzn_o_89" class="active-result group-option" style="">LiveStreet</li><li id="hubs_chzn_o_90" class="active-result group-option" style="">Lua</li><li id="hubs_chzn_o_91" class="active-result group-option" style="">MODX</li><li id="hubs_chzn_o_92" class="active-result group-option" style="">Maps API</li><li id="hubs_chzn_o_93" class="active-result group-option" style="">Mediawiki</li><li id="hubs_chzn_o_94" class="active-result group-option" style="">Mercurial</li><li id="hubs_chzn_o_95" class="active-result group-option" style="">Mesh-сети</li><li id="hubs_chzn_o_96" class="active-result group-option" style="">Meteor.JS</li><li id="hubs_chzn_o_97" class="active-result group-option" style="">Microsoft Access</li><li id="hubs_chzn_o_98" class="active-result group-option" style="">Microsoft Azure</li><li id="hubs_chzn_o_99" class="active-result group-option" style="">Microsoft Edge</li><li id="hubs_chzn_o_100" class="active-result group-option" style="">Microsoft SQL Server</li><li id="hubs_chzn_o_101" class="active-result group-option" style="">MongoDB</li><li id="hubs_chzn_o_102" class="active-result group-option" style="">Mono и Moonlight</li><li id="hubs_chzn_o_103" class="active-result group-option" style="">MooTools</li><li id="hubs_chzn_o_104" class="active-result group-option" style="">MySQL</li><li id="hubs_chzn_o_105" class="active-result group-option" style="">Nginx</li><li id="hubs_chzn_o_106" class="active-result group-option" style="">NoSQL</li><li id="hubs_chzn_o_107" class="active-result group-option" style="">Node.JS</li><li id="hubs_chzn_o_108" class="active-result group-option" style="">Objective C</li><li id="hubs_chzn_o_109" class="active-result group-option" style="">Open source</li><li id="hubs_chzn_o_110" class="active-result group-option" style="">OpenStreetMap</li><li id="hubs_chzn_o_111" class="active-result group-option" style="">Opera</li><li id="hubs_chzn_o_112" class="active-result group-option" style="">Oracle</li><li id="hubs_chzn_o_113" class="active-result group-option" style="">PHP</li><li id="hubs_chzn_o_114" class="active-result group-option" style="">Peer-to-Peer</li><li id="hubs_chzn_o_115" class="active-result group-option" style="">Perl</li><li id="hubs_chzn_o_116" class="active-result group-option" style="">PostgreSQL</li><li id="hubs_chzn_o_117" class="active-result group-option" style="">PowerShell</li><li id="hubs_chzn_o_118" class="active-result group-option" style="">Prolog</li><li id="hubs_chzn_o_119" class="active-result group-option" style="">Python</li><li id="hubs_chzn_o_120" class="active-result group-option" style="">Qt</li><li id="hubs_chzn_o_121" class="active-result group-option" style="">R</li><li id="hubs_chzn_o_122" class="active-result group-option" style="">ReactJS</li><li id="hubs_chzn_o_123" class="active-result group-option" style="">Ruby</li><li id="hubs_chzn_o_124" class="active-result group-option" style="">Ruby on Rails</li><li id="hubs_chzn_o_125" class="active-result group-option" style="">Rust</li><li id="hubs_chzn_o_126" class="active-result group-option" style="">SAN</li><li id="hubs_chzn_o_127" class="active-result group-option" style="">SCADA</li><li id="hubs_chzn_o_128" class="active-result group-option" style="">SQL</li><li id="hubs_chzn_o_129" class="active-result group-option" style="">SQLite</li><li id="hubs_chzn_o_130" class="active-result group-option" style="">SaaS / S+S</li><li id="hubs_chzn_o_131" class="active-result group-option" style="">Safari</li><li id="hubs_chzn_o_132" class="active-result group-option" style="">Scala</li><li id="hubs_chzn_o_133" class="active-result group-option" style="">Service Desk</li><li id="hubs_chzn_o_134" class="active-result group-option" style="">SharePoint</li><li id="hubs_chzn_o_135" class="active-result group-option" style="">Silverlight</li><li id="hubs_chzn_o_136" class="active-result group-option" style="">Skype</li><li id="hubs_chzn_o_137" class="active-result group-option" style="">Small Basic</li><li id="hubs_chzn_o_138" class="active-result group-option" style="">Smalltalk</li><li id="hubs_chzn_o_139" class="active-result group-option" style="">Sphinx</li><li id="hubs_chzn_o_140" class="active-result group-option" style="">Swift</li><li id="hubs_chzn_o_141" class="active-result group-option" style="">Symfony</li><li id="hubs_chzn_o_142" class="active-result group-option" style="">TDD</li><li id="hubs_chzn_o_143" class="active-result group-option" style="">Twisted</li><li id="hubs_chzn_o_144" class="active-result group-option" style="">Twitter API</li><li id="hubs_chzn_o_145" class="active-result group-option" style="">UML Design</li><li id="hubs_chzn_o_146" class="active-result group-option" style="">Unity3D</li><li id="hubs_chzn_o_147" class="active-result group-option" style="">Unreal Engine</li><li id="hubs_chzn_o_148" class="active-result group-option" style="">Usability</li><li id="hubs_chzn_o_149" class="active-result group-option" style="">VIM</li><li id="hubs_chzn_o_150" class="active-result group-option" style="">Visual Studio</li><li id="hubs_chzn_o_151" class="active-result group-option" style="">WebGL</li><li id="hubs_chzn_o_152" class="active-result group-option" style="">Wiki-технология</li><li id="hubs_chzn_o_153" class="active-result group-option" style="">WordPress</li><li id="hubs_chzn_o_154" class="active-result group-option" style="">XML</li><li id="hubs_chzn_o_155" class="active-result group-option" style="">XSLT</li><li id="hubs_chzn_o_156" class="active-result group-option" style="">Xcode</li><li id="hubs_chzn_o_157" class="active-result group-option" style="">Yii</li><li id="hubs_chzn_o_158" class="active-result group-option" style="">Zend Framework</li><li id="hubs_chzn_o_159" class="active-result group-option" style="">jQuery</li><li id="hubs_chzn_o_160" class="active-result group-option" style="">Администрирование баз данных</li><li id="hubs_chzn_o_161" class="active-result group-option" style="">Алгоритмы</li><li id="hubs_chzn_o_162" class="active-result group-option" style="">Анализ и проектирование систем</li><li id="hubs_chzn_o_163" class="active-result group-option" style="">Беспроводные технологии</li><li id="hubs_chzn_o_164" class="active-result group-option" style="">Библиотека ExtJS/Sencha</li><li id="hubs_chzn_o_165" class="active-result group-option" style="">Браузеры</li><li id="hubs_chzn_o_166" class="active-result group-option" style="">Веб-дизайн</li><li id="hubs_chzn_o_167" class="active-result group-option" style="">Веб-разработка</li><li id="hubs_chzn_o_168" class="active-result group-option" style="">Векторная графика</li><li id="hubs_chzn_o_169" class="active-result group-option" style="">Верстка писем</li><li id="hubs_chzn_o_170" class="active-result group-option" style="">Визуализация данных</li><li id="hubs_chzn_o_171" class="active-result group-option" style="">Виртуализация</li><li id="hubs_chzn_o_172" class="active-result group-option" style="">Вирусы и антивирусы</li><li id="hubs_chzn_o_173" class="active-result group-option" style="">Вконтакте API</li><li id="hubs_chzn_o_174" class="active-result group-option" style="">Восстановление данных</li><li id="hubs_chzn_o_175" class="active-result group-option" style="">Высокая производительность</li><li id="hubs_chzn_o_176" class="active-result group-option" style="">ГЛОНАСС</li><li id="hubs_chzn_o_177" class="active-result group-option" style="">Геоинформационные сервисы</li><li id="hubs_chzn_o_178" class="active-result group-option" style="">Графические оболочки</li><li id="hubs_chzn_o_179" class="active-result group-option" style="">Дизайн мобильных приложений</li><li id="hubs_chzn_o_180" class="active-result group-option" style="">Домены</li><li id="hubs_chzn_o_181" class="active-result group-option" style="">ИТ-инфраструктура</li><li id="hubs_chzn_o_182" class="active-result group-option" style="">Интерфейсы</li><li id="hubs_chzn_o_183" class="active-result group-option" style="">Информационная безопасность</li><li id="hubs_chzn_o_184" class="active-result group-option" style="">Клиентская оптимизация</li><li id="hubs_chzn_o_185" class="active-result group-option" style="">Кодобред</li><li id="hubs_chzn_o_186" class="active-result group-option" style="">Компиляторы</li><li id="hubs_chzn_o_187" class="active-result group-option" style="">Криптография</li><li id="hubs_chzn_o_188" class="active-result group-option" style="">Локализация продуктов</li><li id="hubs_chzn_o_189" class="active-result group-option" style="">Математика</li><li id="hubs_chzn_o_190" class="active-result group-option" style="">Машинное обучение</li><li id="hubs_chzn_o_191" class="active-result group-option" style="">Микроформаты</li><li id="hubs_chzn_o_192" class="active-result group-option" style="">Мобильный веб</li><li id="hubs_chzn_o_193" class="active-result group-option" style="">Настройка Linux</li><li id="hubs_chzn_o_194" class="active-result group-option" style="">Ненормальное программирование</li><li id="hubs_chzn_o_195" class="active-result group-option" style="">ООП</li><li id="hubs_chzn_o_196" class="active-result group-option" style="">Облачные вычисления</li><li id="hubs_chzn_o_197" class="active-result group-option" style="">Оболочки</li><li id="hubs_chzn_o_198" class="active-result group-option" style="">Обработка изображений</li><li id="hubs_chzn_o_199" class="active-result group-option" style="">Открытые данные</li><li id="hubs_chzn_o_200" class="active-result group-option" style="">Отладка</li><li id="hubs_chzn_o_201" class="active-result group-option" style="">Параллельное программирование</li><li id="hubs_chzn_o_202" class="active-result group-option" style="">Платежные системы</li><li id="hubs_chzn_o_203" class="active-result group-option" style="">Поисковые технологии</li><li id="hubs_chzn_o_204" class="active-result group-option" style="">Программирование</li><li id="hubs_chzn_o_205" class="active-result group-option" style="">Программирование микроконтроллеров</li><li id="hubs_chzn_o_206" class="active-result group-option" style="">Проектирование и рефакторинг</li><li id="hubs_chzn_o_207" class="active-result group-option" style="">Промышленное программирование</li><li id="hubs_chzn_o_208" class="active-result group-option" style="">Профессиональная литература</li><li id="hubs_chzn_o_209" class="active-result group-option" style="">Работа с анимацией и 3D-графикой</li><li id="hubs_chzn_o_210" class="active-result group-option" style="">Работа с видео</li><li id="hubs_chzn_o_211" class="active-result group-option" style="">Работа с иконками</li><li id="hubs_chzn_o_212" class="active-result group-option" style="">Работа со звуком</li><li id="hubs_chzn_o_213" class="active-result group-option" style="">Разработка</li><li id="hubs_chzn_o_214" class="active-result group-option" style="">Разработка для Office 365</li><li id="hubs_chzn_o_215" class="active-result group-option" style="">Разработка для интернета вещей</li><li id="hubs_chzn_o_216" class="active-result group-option" style="">Разработка мобильных приложений</li><li id="hubs_chzn_o_217" class="active-result group-option" style="">Разработка под Android</li><li id="hubs_chzn_o_218" class="active-result group-option" style="">Разработка под Bada</li><li id="hubs_chzn_o_219" class="active-result group-option" style="">Разработка под Java ME</li><li id="hubs_chzn_o_220" class="active-result group-option" style="">Разработка под Linux</li><li id="hubs_chzn_o_221" class="active-result group-option" style="">Разработка под OS X</li><li id="hubs_chzn_o_222" class="active-result group-option" style="">Разработка под Tizen</li><li id="hubs_chzn_o_223" class="active-result group-option" style="">Разработка под Windows</li><li id="hubs_chzn_o_224" class="active-result group-option" style="">Разработка под Windows Phone</li><li id="hubs_chzn_o_225" class="active-result group-option" style="">Разработка под e-commerce</li><li id="hubs_chzn_o_226" class="active-result group-option" style="">Разработка под iOS</li><li id="hubs_chzn_o_227" class="active-result group-option" style="">Разработка робототехники</li><li id="hubs_chzn_o_228" class="active-result group-option" style="">Разработка систем передачи данных</li><li id="hubs_chzn_o_229" class="active-result group-option" style="">Разработка систем связи</li><li id="hubs_chzn_o_230" class="active-result group-option" style="">Расширения для браузеров</li><li id="hubs_chzn_o_231" class="active-result group-option" style="">Реверс-инжиниринг</li><li id="hubs_chzn_o_232" class="active-result group-option" style="">Регулярные выражения</li><li id="hubs_chzn_o_233" class="active-result group-option" style="">Резервное копирование</li><li id="hubs_chzn_o_234" class="active-result group-option" style="">Семантика</li><li id="hubs_chzn_o_235" class="active-result group-option" style="">Серверная оптимизация</li><li id="hubs_chzn_o_236" class="active-result group-option" style="">Серверное администрирование</li><li id="hubs_chzn_o_237" class="active-result group-option" style="">Сетевые технологии</li><li id="hubs_chzn_o_238" class="active-result group-option" style="">Сжатие данных</li><li id="hubs_chzn_o_239" class="active-result group-option" style="">Системное администрирование</li><li id="hubs_chzn_o_240" class="active-result group-option" style="">Системное программирование</li><li id="hubs_chzn_o_241" class="active-result group-option" style="">Системы управления версиями</li><li id="hubs_chzn_o_242" class="active-result group-option" style="">Совершенный код</li><li id="hubs_chzn_o_243" class="active-result group-option" style="">Спам и антиспам</li><li id="hubs_chzn_o_244" class="active-result group-option" style="">Спортивное программирование</li><li id="hubs_chzn_o_245" class="active-result group-option" style="">Стандарты связи</li><li id="hubs_chzn_o_246" class="active-result group-option" style="">Телефония</li><li id="hubs_chzn_o_247" class="active-result group-option" style="">Тестирование IT-систем</li><li id="hubs_chzn_o_248" class="active-result group-option" style="">Тестирование веб-сервисов</li><li id="hubs_chzn_o_249" class="active-result group-option" style="">Тестирование игр</li><li id="hubs_chzn_o_250" class="active-result group-option" style="">Тестирование мобильных приложений</li><li id="hubs_chzn_o_251" class="active-result group-option" style="">Типографика</li><li id="hubs_chzn_o_252" class="active-result group-option" style="">Управление разработкой</li><li id="hubs_chzn_o_253" class="active-result group-option" style="">Функциональное программирование</li><li id="hubs_chzn_o_255" class="active-result group-option" style="">Хакатоны</li><li id="hubs_chzn_o_256" class="active-result group-option" style="">Хостинг</li><li id="hubs_chzn_o_257" class="active-result group-option" style="">Хранение данных</li><li id="hubs_chzn_o_258" class="active-result group-option" style="">Яндекс API</li></ul></div></div>
    
    
    
    
    
	</div>
	
	<!--	
	<div class="hubs_multiselector" data-type="">
	
		<input type="text" name="hubs" id="hubs"  />
		<input type="hidden" name="hubs_value" value='' />
		
		<div class="tokens"></div>
	</div>
	//-->
	
	<div class="error">
		 
		
	</div>
	<div class="description">Укажите от 1 до 3 хабов.</div>
</div>


		
<div class="is_offtopic hidden" style="display: none;">
  Публикации из хабов-оффтопиков не участвуют в рейтинге и имеют <a href="/info/help/hubs/#hubs">ещё ряд ограничений</a>
</div>
		
<div class="select_tree_hubs hidden" style="display: none;">
    Чтобы увеличить аудиторию публикации, выберите несколько дополнительных тематических хабов
</div>

	 
          
<div class="item title required">

	<label for="title">
		Заголовок:<sup class="required_field">*</sup>
	</label>
	<input type="text" name="title" value="">

	<div class="error">
		
		
	</div>

	<div class="description">Заголовок должен быть наполнен смыслом, чтобы можно было понять, о чем будет публикация.</div>

</div>
          
<div class="item text required">
	<label for="text"> 
		Текст:<sup class="required_field">*</sup> 
	</label>
	<div class="editor">
		<div class="panel">
			<div class="wysiwyg_wrapper">
	<div class="can_use_html"><a href="#html_help" onclick="$(this).parents('.wysiwyg_wrapper').find('.help_holder').toggleClass('hidden');return false;">html-теги</a></div>
		<div class="btn btn-dropdown">
			<span class="g-icon g-icon-paragraph"></span>
			<select class="with-title" name="h" onchange="habraWYG.insertTagFromDropBox(this);" tabindex="-1">
				<option value="" class="title">Заголовки:</option>
				<option value="h4">Заголовок</option>
				<option value="h5">Подзаголовок</option>
				<option value="h6">Подподзаголовок</option>
			</select>
		</div>
	<a class="btn" title="Жирный" onclick="return habraWYG.insertTagWithText(this, 'b');" href="#" tabindex="-1"><span class="g-icon g-icon-bold"></span></a>
	<a class="btn" title="Курсив" onclick="return habraWYG.insertTagWithText(this, 'i');" href="#" tabindex="-1"><span class="g-icon g-icon-italic"></span></a>
	<a class="btn" title="Подчёркнутый" onclick="return habraWYG.insertTagWithText(this, 'u');" href="#" tabindex="-1"><span class="g-icon g-icon-underline"></span></a>
	<a class="btn" title="Зачёркнутый" onclick="return habraWYG.insertTagWithText(this, 's');" href="#" tabindex="-1"><span class="g-icon g-icon-strike"></span></a>
	<a class="btn" title="Цитата" onclick="return habraWYG.insertTagWithText(this, 'blockquote');" href="#" tabindex="-1"><span class="g-icon g-icon-quote"></span></a>
	<div class="btn btn-dropdown">
		<span class="g-icon g-icon-list"></span>
		<select name="list" onchange="habraWYG.insertList(this);" onclick="return false;" tabindex="-1">
			<option value="" class="title">Список:</option>
			<option value="ul">UL LI</option>
			<option value="ol">OL LI</option>
		</select>
	</div>
	<a class="btn" title="Пользователь" onclick="return habraWYG.insertUser(this);" href="#" tabindex="-1"><span class="g-icon g-icon-users"></span></a>
	<a class="btn" title="Вставить ссылку" onclick="return habraWYG.insertLink(this);" href="#" tabindex="-1"><span class="g-icon g-icon-link"></span></a>
	<a class="btn" title="Вставить изображение" onclick="return habraWYG.insertImage(this);" href="#" tabindex="-1"><span class="g-icon g-icon-images"></span></a>
	<a class="btn" title="Вставить видео" onclick="return habraWYG.insertTagWithText(this, 'video');" href="#" tabindex="-1"><span class="g-icon g-icon-video"></span></a>
	<a class="btn" title="Вставить спойлер" onclick="return habraWYG.insertSpoiler(this);" href="#" tabindex="-1"><span class="g-icon g-icon-spoiler"></span></a>
		<a class="btn" title="Кат" onclick="return habraWYG.insertHabracut(this);" href="#" tabindex="-1"><span class="g-icon g-icon-cut"></span></a>
	<div class="btn btn-dropdown">
		<span class="g-icon g-icon-code"></span>
		<select class="with-title" name="source" title="Используйте этот тэг для вставки кода" onchange="habraWYG.insertSource(this);" tabindex="-1">
			<option value="" class="title">Source:</option>
			<option value="code">Code</option>
            <option value="bash">Bash</option>
			<option value="cs">C#</option>
			<option value="cpp">C++</option>
			<option value="css">CSS</option>
			<option value="diff">Diff</option>
			<option value="html">HTML</option>
			<option value="xml">XML</option>
			<option value="java">Java</option>
			<option value="javascript">JavaScript</option>
			<option value="php">PHP</option>
			<option value="perl">Perl</option>
			<option value="python">Python</option>
			<option value="ruby">Ruby</option>
			<option value="sql">SQL</option>
			<option value="1c">1C</option>
			<option value="actionscript">ActionScript</option>
			<option value="apache">Apache</option>
			<option value="axapta">Axapta</option>
			<option value="cmake">CMake</option>
			<option value="coffeescript">CoffeeScript</option>
			<option value="dos">DOS</option>
			<option value="delphi">Delphi</option>
			<option value="django">Django</option>
			<option value="erlang">Erlang</option>
			<option value="erlang_repl">Erlang REPL</option>
      <option value="glsl">GLSL</option>
			<option value="go">Go</option>
			<option value="haskell">Haskell</option>
			<option value="lisp">Lisp</option>
			<option value="lua">Lua</option>
			<option value="mel">MEL</option>
			<option value="markdown">Markdown</option>
			<option value="matlab">Matlab</option>
			<option value="nginx">Nginx</option>
			<option value="objectivec">Objective C</option>
			<option value="rust">Rust</option>
			<option value="scala">Scala</option>
			<option value="smalltalk">Smalltalk</option>
			<option value="tex">TeX</option>
			<option value="vbscript">VBScript</option>
			<option value="vhdl">VHDL</option>
			<option value="vala">Vala</option>
		</select>
	</div>


	<div class="clear"></div>

		<div class="help_holder hidden">
          <h4>Теги хабра</h4>
					<dl class="block_semi">
						<dt>&lt;cut&gt;</dt>
						<dd class="description">Используется только в текстах публикаций, скрывает под кат часть текста, следующую за тегом (будет написано «Читать дальше»).</dd>
					</dl>
					<dl class="block_semi">

						<dt>&lt;cut text="Подробности" /&gt;</dt>
						<dd class="description">Так можно превратить надпись «Читать дальше» в любой текст.</dd>
					</dl>
					<dl class="block_semi">
						<dt>&lt;source lang="Язык"&gt;&lt;/source&gt;</dt>
						<dd class="description">Подсвечивает исходный код (на выбор:
						Bash,  C#,  C++,  CSS,  Diff,  HTML, XML,  Ini,  Java,  JavaScript,  PHP,  Perl,  Python,  Ruby,  SQL,
						1C,  AVR Assembler,  ActionScript,  Apache,  Axapta,  CMake,  CoffeeScript,  DOS, .bat,  Delphi,  Django,  Erlang,  Erlang REPL,  Go,  Haskell,  Lisp,  Lua,  MEL,  Markdown,  Matlab,  Nginx,  Objective C,  Parser3,  Python profile,  RenderMan,  Rust,  Scala,  Smalltalk,  TeX,  VBScript,  VHDL,  Vala
						).</dd>
					</dl>
					<dl class="block_semi">
						<dt>&lt;video&gt;http://...&lt;/video&gt;</dt>

						<dd class="description">Добавляет в публикацию видео со следующих хостингов: YouTube, RuTube, Google video, Vimeo, Я.Видео, Ivideon и Видео@Mail.ru<br>Вставляйте между тегами только прямую ссылку на видеоролик.</dd>
					</dl>

					<dl class="block_semi">
						<dt>&lt;twitter&gt;http://...&lt;/twitter&gt;</dt>

						<dd class="description">Добавляет в публикацию твит. Необходимо указать полную ссылку на твит. Например: &lt;twitter&gt;https://twitter.com/openhabr/status/522334394175213568&lt;/twitter&gt;</dd>
					</dl>

					<dl class="block_semi">
						<dt>&lt;slideshow&gt;http://...&lt;/slideshow&gt;</dt>

						<dd class="description">Вставка интерактивного слайд-шоу. Пока поддерживается только сервис Slideshare.net.</dd>
					</dl>

					<dl class="block_semi">
						<dt>@username</dt>

						<dd class="description">
							Выводит имя пользователя в тексте и отправляет пользователю уведомление о том, что его упомянули в публикации/комментарии.
							Вы можете использовать конструкцию <b>@username</b>, где <b>username</b> — это имя пользователя.
						</dd>
					</dl>

					<dl class="block_semi">
						<dt>&lt;spoiler title="Заголовок"&gt;Содержимое&lt;/spoiler&gt;</dt>

						<dd class="description">Вставка спойлера (разворачиваемый блок информации).</dd>
					</dl>




					<h4>Стандартные</h4>
					<table class="wide">
						<tbody><tr>
							<td>

								<dl class="block_semi">
									<dt>&lt;h1&gt;&lt;/h1&gt;<br>
										...<br>
										&lt;h6&gt;&lt;/h6&gt;
									</dt>
									<dd class="description">Заголовки разного уровня.</dd>
								</dl>
								<dl class="block_semi">

									<dt>&lt;img src="" /&gt;</dt>
									<dd class="description">Вставка изображения, в атрибуте src нужно указывать полный путь к изображению. Возможно выравнивание картинки атрибутом align.</dd>
								</dl>
								<dl class="block_semi">
									<dt>&lt;a href="http://..."&gt;Ссылка&lt;/a&gt;</dt>

									<dd class="description">Вставка ссылки, в атрибуте href указывается желаемый интернет-адрес или якорь (anchor) для навигации по странице.</dd>
								</dl>
								<dl class="block_semi">
									<dt>&lt;anchor&gt;Example1&lt;/anchor&gt;</dt>

									<dd class="description">Тег для указания якоря. Для вызова используйте тег вставки ссылок (&lt;a href="#Example1"&gt;Текст&lt;/a&gt;).</dd>
								</dl>
								<dl class="block_semi">
									<dt>&lt;b&gt;&lt;/b&gt;<br>
										&lt;strong&gt;&lt;/strong&gt;</dt>
									<dd class="description">Выделение важного текста, на странице выделяется жирным начертанием.</dd>
								</dl>
								<dl class="block_semi">

									<dt>&lt;i&gt;&lt;/i&gt;<br>
										&lt;em&gt;&lt;/em&gt;</dt>
									<dd class="description">Выделение важного текста, на странице выделяется курсивом.</dd>
								</dl>
								<dl class="block_semi">
									<dt>
										&lt;s&gt;&lt;/s&gt;<br>
										&lt;strike&gt;&lt;/strike&gt;
									</dt>
									<dd class="description">Текст между этими тегами будет отображаться как зачеркнутый.</dd>
								</dl>

								<dl class="block_semi">
									<dt>
										&lt;u&gt;&lt;/u&gt;
									</dt>
									<dd class="description">Текст между этими тегами будет отображаться как подчеркнутый.</dd>
								</dl>


							</td>

							<td width="5%"></td>

							<td>
							<dl class="block_semi">
								<dt>
									&lt;hr /&gt;
								</dt>
								<dd class="description">Тег для вставки горизонтальной линии.</dd>
							</dl>
								<dl class="block_semi">
									<dt>
										&lt;blockquote&gt;&lt;/blockquote&gt;
									</dt>
									<dd class="description">Используйте этот тег для выделения цитат.</dd>

								</dl>
								<dl class="block_semi">
									<dt>
										&lt;table&gt;&lt;/table&gt;<br>
										&lt;th&gt;&lt;/th&gt;<br>
										&lt;td&gt;&lt;/td&gt;<br>

										&lt;tr&gt;&lt;/tr&gt;
									</dt>
									<dd class="description">Набор тегов для создания таблицы. Тег &lt;td&gt; обозначает ячейку таблицы, тег &lt;th&gt; - ячейку в заголовке, &lt;tr&gt; - строчку таблицы. Все содержимое таблицы помещайте в тег &lt;table&gt;.</dd>

								</dl>
								<dl class="block_semi">
									<dt>
										&lt;sup&gt;&lt;/sup&gt;<br>
										&lt;sub&gt;&lt;/sub&gt;
									</dt>
									<dd class="description">Текст, заключенный в тег &lt;sup&gt; отображается в виде верхнего индекса, &lt;sub&gt; - в виде нижнего.</dd>

								</dl>
								<dl class="block_semi">
									<dt>
										&lt;abbr title="" &gt;&lt;/abbr&gt;<br>
										&lt;acronym title="" &gt;&lt;/acronym&gt;
									</dt>

									<dd class="description">Тегом &lt;abbr&gt; выделяется аббревиатура, в атрибуте title указывайте её расшифровку. Используйте тег &lt;acronym&gt; для устоявшихся аббревиатур.</dd>
								</dl>
								<dl class="block_semi">
									<dt>
										&lt;pre&gt;&lt;/pre&gt;

									</dt>
									<dd class="description">Текст в теге &lt;pre&gt; не форматируется автоматически.</dd>
								</dl>
								<dl class="block_semi">
									<dt>
										&lt;nobr&gt;&lt;/nobr&gt;<br>

										&lt;br clear="all|left||right" /&gt;
									</dt>
									<dd class="description">Текст, помещенный в тег &lt;nobr&gt;, не переносится на странице; для принудительного переноса текста используйте тег &lt;br /&gt;; для аккуратного выравнивания изображений используйте атрибут clear="all|left||right" в теге &lt;br /&gt;.</dd>
								</dl>

								<dl class="block_semi">
									<dt>
										&lt;ul&gt;&lt;/ul&gt;<br>
										&lt;li&gt;&lt;/li&gt;
									</dt>
									<dd class="description">Ненумерованный список; каждый элемент списка задается тегом &lt;li&gt;, набор элементов списка помещайте в тег &lt;ul&gt;.</dd>

								</dl>
								<dl class="block_semi">
									<dt>
										&lt;ol&gt;&lt;/ol&gt;<br>
										&lt;li&gt;&lt;/li&gt;
									</dt>
									<dd class="description">Нумерованный список; каждый элемент списка задается тегом &lt;li&gt;, набор элементов списка помещайте в тег &lt;ol&gt;.</dd>

								</dl>
							</td>
						</tr>

					</tbody></table>

					<div class="close_html"><a href="#html_help_close" onclick="$(this).parents('.wysiwyg_wrapper').find('.help_holder').toggleClass('hidden');return false;">закрыть</a></div>

		</div>
</div>
		</div>
		<div class="text-holder">
		 <textarea cols="30" rows="7" id="text_textarea" name="text"></textarea>
		</div>
	</div>
	<div class="error">
		
		
	</div>
	<div class="description"></div>
</div>
          
<div class="item userformat">
	<div class="checkbox_single">
			<label for="userformat">
				<input type="checkbox" name="userformat" id="userformat">
				  Отключить автоматические переносы строк и создание ссылок.  
			</label>
	</div>
	<div class="error"></div>
	<div class="description"></div>
</div>
          
<div class="item tags_string required">

	<label for="tags_string">
		Метки:<sup class="required_field">*</sup>
	</label>
	<input type="text" name="tags_string" value="" autocomplete="off">

	<div class="error">
		
		
	</div>

	<div class="description"></div>

</div>
          <div class="buttons blue_buttons_panel">
              <input type="submit" class="btn btn_huge btn_green" name="submit" value="Отправить на модерацию">
            <input type="button" class="btn btn_medium btn_grey" name="preview" value="Предпросмотр">
          </div>
        </form>
</div>
    </div>
  </div>
</div>
<div class="clear"></div>
<div class="clear"></div>
{{>footer}}
</div>
</body>
</html>

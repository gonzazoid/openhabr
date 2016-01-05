<!DOCTYPE html>
<html lang="ru">
<head>
<title>{{user.nickname}}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link href="/css/post_common_css.css" rel="stylesheet" media="all" />
<link href="/css/posts.css" rel="stylesheet" media="all" />
<link href="/css/forms.css" rel="stylesheet" media="all" />
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

    <div class="page_head">
      <h2 class="title">Настройки</h2>
    </div>

<div class="content_left">
      <div class="tabs">
    <ul class="tabs-menu tabs-menu_habrahabr">
        <li class="tabs-menu__item tabs-menu__item_inline">
          <a href="/auth/settings/profile/" class="tab-item tab-item_current">
            <span class="tab-item__value">
              Профиль&nbsp;
              <strong class="counter"></strong>
              
            </span>
          </a>
        </li>
        <li class="tabs-menu__item tabs-menu__item_inline">
          <a href="/auth/settings/account/" class="tab-item " target="_blank">
            <span class="tab-item__value">
              Аккаунт&nbsp;
              <strong class="counter"></strong>
              
            </span>
          </a>
        </li>
        <li class="tabs-menu__item tabs-menu__item_inline">
          <a href="/auth/settings/notifications/" class="tab-item ">
            <span class="tab-item__value">
              Уведомления&nbsp;
              <strong class="counter"></strong>
              
            </span>
          </a>
        </li>
        <li class="tabs-menu__item tabs-menu__item_inline">
          <a href="/auth/settings/upgrade/" class="tab-item ">
            <span class="tab-item__value">
              Апгрейд&nbsp;
              <strong class="counter"></strong>
              
            </span>
          </a>
        </li>
        <li class="tabs-menu__item tabs-menu__item_inline">
          <a href="https://habrahabr.ru/auth/apps/" class="tab-item ">
            <span class="tab-item__value">
              Приложения&nbsp;
              <strong class="counter"></strong>
              
            </span>
          </a>
        </li>
        <li class="tabs-menu__item tabs-menu__item_inline">
          <a href="/auth/settings/others/" class="tab-item ">
            <span class="tab-item__value">
              Разные&nbsp;
              <strong class="counter"></strong>
              
            </span>
          </a>
        </li>
    </ul>

  </div>


    <div class="user_settings">
        <h2>Персональная информация</h2>
        <form id="profile_settings_form" class="profile_settings_form" action="/json/settings/profile/" method="post">

          
<div class="item fullname ">

	<label for="fullname">
		Настоящее имя:
	</label>
	<input type="text" name="fullname" maxlength="40" value="">

	<div class="error">
		
		
	</div>

	<div class="description">Укажите ваши имя и фамилию, чтобы другие пользователи смогли узнать, как вас зовут.</div>

<div class="count" title="Доступное количество символов для ввода">40</div></div>

          <div id="user_specializm">
            
<div class="item specializm ">

	<label for="specializm">
		Специализация:
	</label>
	<input type="text" name="specializm" maxlength="50" value="Пользователь">

	<div class="error">
		
		
	</div>

	<div class="description">Укажите свою специализацию. Например: <i>Администратор баз данных</i>.</div>

<div class="count" title="Доступное количество символов для ввода">38</div></div>
          </div>

          
<div class="item sex ">
	<label for="sex">
		Пол:
	</label>
	<select name="sex">
			<option value="0">другой</option>
			<option selected="selected" value="1">мужской</option>
			<option value="2">женский</option>
	</select>
	<div class="error">
		
		
	</div>
	<div class="description"></div>
</div>

          
<div class="item birthdate">
	<label for="birthdate">  Дата рождения:  </label>

	<select name="birthdate[day]">
		<option value="0">Число</option>  
			<option value="1">1</option>  
			<option value="2">2</option>  
			<option value="3">3</option>  
			<option value="4">4</option>  
			<option value="5">5</option>  
			<option value="6">6</option>  
			<option value="7">7</option>  
			<option value="8">8</option>  
			<option value="9">9</option>  
			<option value="10">10</option>  
			<option value="11">11</option>  
			<option value="12">12</option>  
			<option value="13">13</option>  
			<option value="14">14</option>  
			<option value="15">15</option>  
			<option value="16">16</option>  
			<option value="17">17</option>  
			<option value="18">18</option>  
			<option value="19">19</option>  
			<option value="20">20</option>  
			<option value="21">21</option>  
			<option value="22">22</option>  
			<option value="23">23</option>  
			<option value="24">24</option>  
			<option value="25">25</option>  
			<option value="26">26</option>  
			<option value="27">27</option>  
			<option value="28">28</option>  
			<option value="29">29</option>  
			<option value="30">30</option>  
			<option value="31">31</option>  
	</select>
	
	<select name="birthdate[month]">
		<option value="0">Месяц</option>  
			<option value="1">январь</option>  
			<option value="2">февраль</option>  
			<option value="3">март</option>  
			<option value="4">апрель</option>  
			<option value="5">май</option>  
			<option value="6">июнь</option>  
			<option value="7">июль</option>  
			<option value="8">август</option>  
			<option value="9">сентябрь</option>  
			<option value="10">октябрь</option>  
			<option value="11">ноябрь</option>  
			<option value="12">декабрь</option>  
	</select>
	
	<select name="birthdate[year]">
		<option value="0">Год</option>  
			<option value="2006">2006</option>  
			<option value="2005">2005</option>  
			<option value="2004">2004</option>  
			<option value="2003">2003</option>  
			<option value="2002">2002</option>  
			<option value="2001">2001</option>  
			<option value="2000">2000</option>  
			<option value="1999">1999</option>  
			<option value="1998">1998</option>  
			<option value="1997">1997</option>  
			<option value="1996">1996</option>  
			<option value="1995">1995</option>  
			<option value="1994">1994</option>  
			<option value="1993">1993</option>  
			<option value="1992">1992</option>  
			<option value="1991">1991</option>  
			<option value="1990">1990</option>  
			<option value="1989">1989</option>  
			<option value="1988">1988</option>  
			<option value="1987">1987</option>  
			<option value="1986">1986</option>  
			<option value="1985">1985</option>  
			<option value="1984">1984</option>  
			<option value="1983">1983</option>  
			<option value="1982">1982</option>  
			<option value="1981">1981</option>  
			<option value="1980">1980</option>  
			<option value="1979">1979</option>  
			<option value="1978">1978</option>  
			<option value="1977">1977</option>  
			<option value="1976">1976</option>  
			<option value="1975">1975</option>  
			<option value="1974">1974</option>  
			<option value="1973">1973</option>  
			<option value="1972">1972</option>  
			<option value="1971">1971</option>  
			<option value="1970">1970</option>  
			<option value="1969">1969</option>  
			<option value="1968">1968</option>  
			<option value="1967">1967</option>  
			<option value="1966">1966</option>  
			<option value="1965">1965</option>  
			<option value="1964">1964</option>  
			<option value="1963">1963</option>  
			<option value="1962">1962</option>  
			<option value="1961">1961</option>  
			<option value="1960">1960</option>  
			<option value="1959">1959</option>  
			<option value="1958">1958</option>  
			<option value="1957">1957</option>  
			<option value="1956">1956</option>  
			<option value="1955">1955</option>  
			<option value="1954">1954</option>  
			<option value="1953">1953</option>  
			<option value="1952">1952</option>  
			<option value="1951">1951</option>  
			<option value="1950">1950</option>  
			<option value="1949">1949</option>  
			<option value="1948">1948</option>  
			<option value="1947">1947</option>  
			<option value="1946">1946</option>  
			<option value="1945">1945</option>  
			<option value="1944">1944</option>  
			<option value="1943">1943</option>  
			<option value="1942">1942</option>  
			<option value="1941">1941</option>  
			<option value="1940">1940</option>  
			<option value="1939">1939</option>  
			<option value="1938">1938</option>  
			<option value="1937">1937</option>  
			<option value="1936">1936</option>  
			<option value="1935">1935</option>  
			<option value="1934">1934</option>  
			<option value="1933">1933</option>  
			<option value="1932">1932</option>  
			<option value="1931">1931</option>  
			<option value="1930">1930</option>  
			<option value="1929">1929</option>  
			<option value="1928">1928</option>  
			<option value="1927">1927</option>  
			<option value="1926">1926</option>  
			<option value="1925">1925</option>  
			<option value="1924">1924</option>  
			<option value="1923">1923</option>  
			<option value="1922">1922</option>  
			<option value="1921">1921</option>  
			<option value="1920">1920</option>  
			<option value="1919">1919</option>  
			<option value="1918">1918</option>  
			<option value="1917">1917</option>  
			<option value="1916">1916</option>  
			<option value="1915">1915</option>  
			<option value="1914">1914</option>  
			<option value="1913">1913</option>  
			<option value="1912">1912</option>  
			<option value="1911">1911</option>  
			<option value="1910">1910</option>  
			<option value="1909">1909</option>  
			<option value="1908">1908</option>  
			<option value="1907">1907</option>  
			<option value="1906">1906</option>  
			<option value="1905">1905</option>  
			<option value="1904">1904</option>  
			<option value="1903">1903</option>  
			<option value="1902">1902</option>  
			<option value="1901">1901</option>  
	</select>
		
	<div class="error"></div>
	<div class="description"></div>
</div>

          

<div class="item location">
	<label for="location">  Местоположение:  </label>
	
	<div class="select_date" id="location">
	  <select class="country" name="location[country]">
	  	<option>Страна</option>
	  		<option value="168">Россия</option>
	  		<option value="216">Украина</option>
	  		<option value="22">Беларусь</option>
	  		<option value="1">Австралия</option>
	  		<option value="2">Австрия</option>
	  		<option value="3">Азербайджан</option>
	  		<option value="4">Албания</option>
	  		<option value="5">Алжир</option>
	  		<option value="6">Ангола</option>
	  		<option value="7">Ангуилья</option>
	  		<option value="8">Андорра</option>
	  		<option value="9">Антарктика</option>
	  		<option value="10">Антигуа и Барбуда</option>
	  		<option value="11">Антильские о-ва</option>
	  		<option value="12">Аргентина</option>
	  		<option value="13">Армения</option>
	  		<option value="14">Арулько</option>
	  		<option value="15">Афганистан</option>
	  		<option value="16">Ашмор и Картьер о-ва</option>
	  		<option value="17">Багамские о-ва</option>
	  		<option value="18">Бангладеш</option>
	  		<option value="19">Барбадос</option>
	  		<option value="20">Бассас да Индия</option>
	  		<option value="21">Бахрейн</option>
	  		<option value="23">Белиз</option>
	  		<option value="24">Бельгия</option>
	  		<option value="25">Бенин</option>
	  		<option value="26">Бермуды</option>
	  		<option value="27">Болгария</option>
	  		<option value="28">Боливия</option>
	  		<option value="29">Босния/Герцеговина</option>
	  		<option value="30">Ботсвана</option>
	  		<option value="31">Бразилия</option>
	  		<option value="32">Британская Океания</option>
	  		<option value="33">Британские Виргинские о-ва</option>
	  		<option value="34">Бруней</option>
	  		<option value="35">Буркина Фасо</option>
	  		<option value="36">Бурунди</option>
	  		<option value="37">Бутан</option>
	  		<option value="38">Валлис и Футуна о-ва</option>
	  		<option value="39">Вануату</option>
	  		<option value="40">Великобритания</option>
	  		<option value="41">Венгрия</option>
	  		<option value="42">Венесуэла</option>
	  		<option value="43">Восточный Тимор</option>
	  		<option value="44">Вьетнам</option>
	  		<option value="45">Габон</option>
	  		<option value="46">Гаити</option>
	  		<option value="47">Гайана</option>
	  		<option value="48">Гамбия</option>
	  		<option value="49">Гана</option>
	  		<option value="50">Гваделупа</option>
	  		<option value="51">Гватемала</option>
	  		<option value="52">Гвинея</option>
	  		<option value="53">Гвинея-Бисау</option>
	  		<option value="54">Германия</option>
	  		<option value="55">Гернси о-в</option>
	  		<option value="56">Гибралтар</option>
	  		<option value="57">Глориосо о-ва</option>
	  		<option value="58">Гондурас</option>
	  		<option value="59">Гонконг</option>
	  		<option value="60">Гренада</option>
	  		<option value="61">Гренландия</option>
	  		<option value="62">Греция</option>
	  		<option value="63">Грузия</option>
	  		<option value="64">Д.Р. Конго</option>
	  		<option value="65">Дания</option>
	  		<option value="66">Джерси о-в</option>
	  		<option value="67">Джибути</option>
	  		<option value="68">Джон Майен о-ва</option>
	  		<option value="69">Доминика</option>
	  		<option value="70">Доминиканская республика</option>
	  		<option value="71">Европы о-в</option>
	  		<option value="72">Египет</option>
	  		<option value="73">Еретриа</option>
	  		<option value="74">Замбия</option>
	  		<option value="75">Западная Сахара</option>
	  		<option value="76">Зимбабве</option>
	  		<option value="77">Израиль</option>
	  		<option value="78">Индия</option>
	  		<option value="79">Индонезия</option>
	  		<option value="80">Иордания</option>
	  		<option value="81">Ирак</option>
	  		<option value="82">Иран</option>
	  		<option value="83">Ирландия</option>
	  		<option value="84">Исландия</option>
	  		<option value="85">Испания</option>
	  		<option value="86">Италия</option>
	  		<option value="87">Йемен</option>
	  		<option value="88">Кабо-Верде</option>
	  		<option value="89">Казахстан</option>
	  		<option value="90">Кайманские о-ва</option>
	  		<option value="91">Камбоджа</option>
	  		<option value="92">Камерун</option>
	  		<option value="93">Канада</option>
	  		<option value="94">Катар</option>
	  		<option value="95">Кения</option>
	  		<option value="96">Кипр</option>
	  		<option value="97">Кирибати</option>
	  		<option value="98">Китай</option>
	  		<option value="99">Клипертона о-в</option>
	  		<option value="100">Кокосовы (Килинг) о-ва</option>
	  		<option value="101">Колумбия</option>
	  		<option value="102">Коморские о-ва</option>
	  		<option value="103">Конго (Brazzaville)</option>
	  		<option value="104">Конго (Kinshasa)</option>
	  		<option value="105">Кораловое море о-ва</option>
	  		<option value="106">Коста-Рика</option>
	  		<option value="107">Кот-д'Ивуар</option>
	  		<option value="108">Куба</option>
	  		<option value="109">Кувейт</option>
	  		<option value="110">Кука о-ва</option>
	  		<option value="111">Кыргызстан</option>
	  		<option value="112">Лаос</option>
	  		<option value="113">Латвия</option>
	  		<option value="114">Лесото</option>
	  		<option value="115">Либерия</option>
	  		<option value="116">Ливан</option>
	  		<option value="117">Ливия</option>
	  		<option value="118">Литва</option>
	  		<option value="119">Лихтенштейн</option>
	  		<option value="120">Люксембург</option>
	  		<option value="121">Маврикий</option>
	  		<option value="122">Мавритания</option>
	  		<option value="123">Мадагаскар</option>
	  		<option value="124">Майотт</option>
	  		<option value="125">Макао</option>
	  		<option value="126">Македония</option>
	  		<option value="127">Малави</option>
	  		<option value="128">Малайзия</option>
	  		<option value="129">Мали</option>
	  		<option value="130">Мальдивские о-ва</option>
	  		<option value="131">Мальта</option>
	  		<option value="132">Мартиника о-в</option>
	  		<option value="133">Мексика</option>
	  		<option value="134">Мозамбик</option>
	  		<option value="135">Молдова</option>
	  		<option value="136">Монако</option>
	  		<option value="137">Монголия</option>
	  		<option value="138">Монтсерат</option>
	  		<option value="139">Морокко</option>
	  		<option value="140">Мьянма (Бирма)</option>
	  		<option value="141">Мэн о-в</option>
	  		<option value="142">Намибия</option>
	  		<option value="143">Науру</option>
	  		<option value="144">Непал</option>
	  		<option value="145">Нигер</option>
	  		<option value="146">Нигерия</option>
	  		<option value="147">Нидерланды</option>
	  		<option value="148">Никарагуа</option>
	  		<option value="149">Новая Зеландия</option>
	  		<option value="150">Новая Каледония о-в</option>
	  		<option value="151">Норвегия</option>
	  		<option value="152">Норфолк о-в</option>
	  		<option value="153">Нюэ</option>
	  		<option value="154">О.А.Э.</option>
	  		<option value="155">Оман</option>
	  		<option value="156">Пакистан</option>
	  		<option value="157">Панама</option>
	  		<option value="158">Папуа Новая Гвинея</option>
	  		<option value="159">Парагвай</option>
	  		<option value="160">Парасел о-ва</option>
	  		<option value="161">Перу</option>
	  		<option value="162">Питкэрн о-в</option>
	  		<option value="163">Польша</option>
	  		<option value="164">Португалия</option>
	  		<option value="165">Пуэрто Рико</option>
	  		<option value="166">Реюньон</option>
	  		<option value="167">Рождественские о-ва</option>
	  		<option value="169">Руанда</option>
	  		<option value="170">Румыния</option>
	  		<option value="171">Сальвадор</option>
	  		<option value="172">Самоа</option>
	  		<option value="173">Сан-Марино</option>
	  		<option value="174">Сан-Томе и Принсипи</option>
	  		<option value="175">Саудовская Аравия</option>
	  		<option value="176">Свазиленд</option>
	  		<option value="177">Свальбэрд</option>
	  		<option value="178">Святая земля</option>
	  		<option value="179">Святая Люсия</option>
	  		<option value="180">Святой Елены о-в</option>
	  		<option value="181">Северная Корея</option>
	  		<option value="182">Сейшеллы</option>
	  		<option value="183">Сектор Газа</option>
	  		<option value="184">Сен-Пьер и Микелон</option>
	  		<option value="185">Сенегал</option>
	  		<option value="186">Сент Китс и Невис</option>
	  		<option value="187">Сент-Винсент и Гренадины</option>
	  		<option value="188">Сербия</option>
	  		<option value="189">Сингапур</option>
	  		<option value="190">Сирия</option>
	  		<option value="191">Словакия</option>
	  		<option value="192">Словения</option>
	  		<option value="193">Соломоновы о-ва</option>
	  		<option value="194">Сомали</option>
	  		<option value="195">Спратли о-ва</option>
	  		<option value="196">Судан</option>
	  		<option value="197">Суринам</option>
	  		<option value="198">США</option>
	  		<option value="199">Сьерра-Леоне</option>
	  		<option value="200">Таджикистан</option>
	  		<option value="201">Таиланд</option>
	  		<option value="202">Тайвань</option>
	  		<option value="203">Танзания</option>
	  		<option value="204">Того</option>
	  		<option value="205">Токелау о-ва</option>
	  		<option value="206">Тонга</option>
	  		<option value="207">Тринидад и Тобаго</option>
	  		<option value="208">Тромелин о-в</option>
	  		<option value="209">Тувалу</option>
	  		<option value="210">Тунис</option>
	  		<option value="211">Туркменистан</option>
	  		<option value="212">Туркс и Кейкос</option>
	  		<option value="213">Турция</option>
	  		<option value="214">Уганда</option>
	  		<option value="215">Узбекистан</option>
	  		<option value="217">Уругвай</option>
	  		<option value="218">Фалькийские о-ва</option>
	  		<option value="219">Фарерские о-ва</option>
	  		<option value="220">Фиджи</option>
	  		<option value="221">Филиппины</option>
	  		<option value="222">Финляндия</option>
	  		<option value="223">Франция</option>
	  		<option value="224">Французская Гвинея</option>
	  		<option value="225">Французская Полинезия</option>
	  		<option value="226">Французские юж. и антаркт. о-ва</option>
	  		<option value="227">Херд и Мак Дональнд о-ва</option>
	  		<option value="228">Хорватия</option>
	  		<option value="229">Центральная Африка</option>
	  		<option value="230">Чад</option>
	  		<option value="231">Чехия</option>
	  		<option value="247">Черногория</option>
	  		<option value="232">Чили</option>
	  		<option value="233">Швейцария</option>
	  		<option value="234">Швеция</option>
	  		<option value="235">Шри-Ланка</option>
	  		<option value="236">Эквадор</option>
	  		<option value="237">Экваториальная Гвинея</option>
	  		<option value="238">Эритрея</option>
	  		<option value="239">Эстония</option>
	  		<option value="240">Эфиопия</option>
	  		<option value="241">ЮАР</option>
	  		<option value="242">Южная Корея</option>
	  		<option value="243">Южные Сандвичевы о-ва</option>
	  		<option value="244">Ямайка</option>
	  		<option value="245">Ян де нова о-ва</option>
	  		<option value="246">Япония</option>
	  </select>
	  <select class="region" name="location[region]" disabled="disabled">
	  	<option>Регион</option>
	  </select>
	  <select class="city" name="location[city]" disabled="disabled">
	  	<option>Город</option>
	  </select>
	</div>

	<div class="error"></div>
	<div class="description"></div>
</div>

          <div class="item contacts" id="user_contacts">
            <label for="contacts">У меня есть:</label>
            <div class="error"></div>
            <div class="description">Укажите имя пользователя или ID — мы сами сделаем ссылку.<br> Отметьте нужный контакт галочкой, чтобы он появился в информационной панели автора публикации.<br><br></div>

            <div class="contacts_list" id="contacts_list">
            </div>

            <div class="add_contact">
                Контактные данные недоступны для read-only
            </div>
          </div>

          
<div class="item description ">
	<label for="description"> 
		Расскажите о себе: 
	</label>
	<div class="editor">
		<div class="text-holder">
		 <textarea cols="30" rows="7" id="description_textarea" name="description" disabled="disabled"></textarea>
		</div>
	</div>
	<div class="error"></div>
	<div class="description">Не более 65000 символов, пожалуйста.</div>
</div>

          
<div class="item interests ">

	<label for="interests">
		Интересы:
	</label>
	<input type="text" name="interests" value="">

	<div class="error">
		
		
	</div>

	<div class="description">Например: веб-дизайн, музыка, "художественная литература".</div>

</div>

          <h2>Аватар</h2>

          
<div class="item avatar ">
		<label for="avatar">Выберите изображение: </label>
		<iframe src="/uploader/?t=avatar_image&amp;name=avatar" frameborder="0" width="100%" height="30" class="iframe_uploader" scrolling="no">

		</iframe>
		<input type="hidden" name="avatar" value="0">
		
		<input type="hidden" name="avatar_token" value="">
				
		<div class="iframe_uploader_preview"><div class="image"><img src="/i/avatars/stub-user-middle.gif" alt=""><div class="delete" data-name="avatar" title="Удалить изображение?">x</div></div></div>
		
		<div class="error">
		</div>
		<div class="description">Формат: jpg, gif, png. Максимальный размер файла: 1Mb.</div>
	</div>

          <div class="buttons">
            <input type="submit" value="Сохранить">
          </div>
        </form>
    </div>
  </div>

{{>footer}}

  </div>
</div>
</body>
</html>

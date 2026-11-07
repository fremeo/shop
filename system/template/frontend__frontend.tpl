{block name="navigation_top" prepend}
	<a href="{SCRIPT_NAME}basket" title="Warenkorb" class="link-body-emphasis text-decoration-none"><i class="fas fa-shopping-basket" aria-hidden="true"></i><span class="visually-hidden">Warenkorb</span> <span class="badge text-bg-secondary">{count($D.SESSION.BASKET.ORDER.D[$D.SESSION.OrderId|default:''].ARTICLE.D|default:[])}</span></a>
	
	{*if $D.SESSION.UserId}
	{else}	
	{/if*}
{/block}

{block name="account_navi_left" prepend}ff
	<a class="nav-link" href="account/order"><i class="fas fa-clipboard-list"></i> Meine Bestellungen</a>
	<a class="nav-link" href="account/address"><i class="fas fa-address-book"></i> Meine Adressen</a>
	<a class="nav-link" href="account/memo"><i class="far fa-list-alt"></i> Meine Merkzetel</a>
	<a class="nav-link" href="account/user"><i class="fas fa-users"></i> Benutzer</a>
{/block}
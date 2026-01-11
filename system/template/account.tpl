{block name="body" prepend}
<div class="row">
	<div class="col-3">
		<div class="nav flex-column nav-pills">
			<a class="nav-link" href="{$D.BasePath}account"><i class="fas fa-user-circle"></i> Meine Übersicht</a>
			<a class="nav-link" href="{$D.BasePath}account/order"><i class="fas fa-clipboard-list"></i> Meine Bestellungen</a>
			<a class="nav-link" href="{$D.BasePath}account/address"><i class="fas fa-address-book"></i> Meine Adressen</a>
			<a class="nav-link" href="{$D.BasePath}account/memo"><i class="far fa-list-alt"></i> Meine Merkzetel</a>
			<a class="nav-link" href="{$D.BasePath}account/user"><i class="fas fa-users"></i> Benutzer</a>
		</div>
	</div>
	<div class="col-9">
	{block name="account_body"}
		
	{/block}
	</div>
</div>
{/block}
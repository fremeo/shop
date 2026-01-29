{block name="account_body"}
	<form method="post">
	{foreach from=$D.ACCOUNT.D[$D.SESSION.AccountId].MEMO.D key="kMEM" item="MEM"}
		<div class="card">
		  <div class="card-header">
			{$MEM.Name}
		  </div>
		  <div class="card-body">
			{foreach from=$D.ACCOUNT.D[$D.SESSION.AccountId].MEMO.D['A'].ARTICLE.D key="kART" item="ART"}
			 Artikel {$kART} <br>
			{/foreach}
		  </div>
		</div>
		
	{/foreach}
	</form>
{/block}

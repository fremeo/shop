
{block name="account_body"}
	<form method="post">

	{foreach from=$D.ACCOUNT.D key="kACC" item="ACC"}
		<table class="table">
			<tr>
				<th>#</th>
				<th>Datum</th>
				<th>Bestellnummer</th>
				<th>Preis</th>
				<th>Status</th>
			</tr>
		{foreach from=$ACC.ORDER.D key="kD" item="D" name="D"}
			{foreach from=$D.ARTICLE.D key="kD2" item="D2" name="D2"}
				{$_Sum_Price = $_Sum_Price + $D2.Price}
			{/foreach}
			<tr>
				<td>{$smarty.foreach.D.iteration}</td>
				<td>{date('d.m.Y',$D.DateTime)}</td>
				<td>{$D.Number}</td>
				<td>{$_Sum_Price+0} €</td>
				<td>Offen</td>
			</tr>
		{/foreach}
		</table>
		
		
	{/foreach}
	</form>
	{/block}

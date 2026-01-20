
{block name="account_body"}
	<form method="post">
	<table class="table">
	<tr>
	<th>Id</th>
	<th>Active</th>
	<th>Name</th>
	<th>E-Mail</th>
	</tr>
	
	{foreach from=$D.USER.D key="kUSR" item="USR"}
	<tr>
	<td>{$kUSR}</td>
	<td>{$USR.Active}</td>
	<td>{$USR.Name}</td>
	<td>{$USR.Mail}</td>
	</tr>
	{/foreach}
	</table>
	</form>
{/block}

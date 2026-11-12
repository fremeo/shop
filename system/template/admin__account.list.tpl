{block name="inner_body"}
	<div class="d-flex flex-wrap gap-2 justify-content-between align-items-center mb-3">
		<h1 class="h4 mb-0"><i class="fa-solid fa-users me-1" aria-hidden="true"></i> {i18n key="account_list_title"} <span class="badge text-bg-secondary">{$D.R.AccountAdmin.Total}</span></h1>
	</div>
	{foreach $D.R.AccountAdmin.Errors as $error}
		<div class="alert alert-danger" role="alert">
			{if $error == 'account_list_error_orders'}{i18n key="account_list_error_orders"}
			{elseif $error == 'account_list_error_missing'}{i18n key="account_list_error_missing"}
			{else}{i18n key="account_list_error_data"}{/if}
		</div>
	{/foreach}
	{if $D.R.AccountAdmin.Saved}
		<div class="alert alert-success" role="status">{i18n key="account_list_saved"}</div>
	{/if}
	{if $D.ACCOUNT.D|default:[]}
		<form method="post" id="accountListForm">
			<input type="hidden" name="{$D.C.Security->registerSecurityD('D[ACTION]')|escape}" value="save">
			<div class="table-responsive">
				<table class="table table-striped table-hover align-middle">
					<thead class="table-light">
						<tr>
							<th scope="col">{i18n key="account_list_id"}</th>
							<th scope="col">{i18n key="account_list_number"}</th>
							<th scope="col">{i18n key="account_list_name"}</th>
							<th scope="col" class="text-center">{i18n key="account_list_active"}</th>
							<th scope="col">{i18n key="account_list_addresses"}</th>
							<th scope="col" class="text-center">{i18n key="account_list_users"}</th>
							<th scope="col" class="text-center">{i18n key="account_list_memos"}</th>
							<th scope="col" class="text-center">{i18n key="account_list_orders"}</th>
							<th scope="col" class="text-end">{i18n key="account_list_actions"}</th>
						</tr>
					</thead>
					<tbody>
						{foreach $D.ACCOUNT.D as $accountId => $account}
							<tr data-account-id="{$accountId|escape}">
								<th scope="row" class="text-break">{$accountId|escape}</th>
								<td class="text-break">{$account.Number|default:''|escape}</td>
								<td class="text-break">{$account.Name|default:''|escape}</td>
								<td class="text-center">
									{if !isset($D.R.AccountAdmin.InvalidIds[$accountId])}
										{capture assign="activeTitle"}{i18n key="account_list_active"}{/capture}
										{input p=['type' => 'checkbox', 'name' => "D[ACCOUNT][D][{$accountId}][Active]", 'value' => $account.Active|default:0, 'title' => $activeTitle|escape]}
									{else}
										&mdash;
									{/if}
								</td>
								<td class="text-break">
									{foreach $account.ADDRESS.D|default:[] as $address}
										<div class="mb-1">
											<div>{$address.FName|default:''|escape} {$address.LName|default:''|escape}</div>
											<div>{$address.Street|default:''|escape} {$address.HNumber|default:''|escape}</div>
											<div>{$address.Postcode|default:''|escape} {$address.City|default:''|escape} {$address.CountryId|default:''|escape}</div>
											{if $address.Mail|default:''}<div>{$address.Mail|escape}</div>{/if}
											{if $address.Phone|default:''}<div>{$address.Phone|escape}</div>{/if}
										</div>
									{/foreach}
								</td>
								<td class="text-center">{$account.USER.COUNT|default:0}</td>
								<td class="text-center">{$account.MEMO.COUNT|default:0}</td>
								<td class="text-center">{$account.ORDER.COUNT|default:0}</td>
								<td class="text-end text-nowrap">
									{capture assign="editTitle"}{i18n key="account_list_edit"}{/capture}
									{if !isset($D.R.AccountAdmin.InvalidIds[$accountId])}
										<a class="btn btn-outline-primary btn-sm" href="?R[ModuleId]=fremeo/shop&amp;R[Page]=admin__account.edit&amp;R[Id]={$accountId|escape:'url'}" title="{$editTitle|escape}" aria-label="{$editTitle|escape}"><i class="fa-solid fa-pen" aria-hidden="true"></i></a>
									{/if}
									{if !$account.ORDER.D|default:[] && !isset($D.R.AccountAdmin.InvalidIds[$accountId])}
										{capture assign="deleteTitle"}{i18n key="account_list_delete"}{/capture}
										{capture assign="deleteConfirm"}{i18n key="account_list_delete_confirm"}{/capture}
										<input type="hidden" data-account-delete name="{$D.C.Security->registerSecurityD("D[ACCOUNT][D][{$accountId}][__DELETE__]")|escape}" value="1" disabled>
										<button type="button" class="btn btn-outline-danger btn-sm" title="{$deleteTitle|escape}" aria-label="{$deleteTitle|escape}" data-confirm="{$deleteConfirm|escape}" onclick="if (confirm(this.dataset.confirm)) { var row = this.closest('tr'); row.querySelector('[data-account-delete]').disabled = false; row.classList.add('d-none'); }"><i class="fa-solid fa-trash" aria-hidden="true"></i></button>
									{/if}
								</td>
							</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
		</form>
	{else}
		<div class="alert alert-info">{i18n key="account_list_empty"}</div>
	{/if}
{/block}

{block name="inner_footer"}
	{if $D.ACCOUNT.D|default:[]}
		<div class="bg-body-tertiary border-top p-2 d-flex flex-wrap justify-content-between align-items-center gap-2">
			<div class="d-flex flex-wrap gap-2">
				<button type="submit" form="accountListForm" class="btn btn-primary btn-sm">{i18n key="account_list_save"}</button>
				<a class="btn btn-outline-secondary btn-sm" href="?R[ModuleId]=fremeo/shop&amp;R[Page]=admin__account.list&amp;R[P]={$D.R.AccountAdmin.Page}">{i18n key="account_list_cancel"}</a>
			</div>
			<div class="d-flex flex-wrap align-items-center gap-2">
				<small class="text-body-secondary">{i18n key="account_list_range" values=['from' => $D.R.AccountAdmin.From, 'to' => $D.R.AccountAdmin.To, 'total' => $D.R.AccountAdmin.Total]}</small>
				{if $D.R.AccountAdmin.Pages > 1}
					{capture assign="pagesTitle"}{i18n key="account_list_pages"}{/capture}
					<nav aria-label="{$pagesTitle|escape}">
						<ul class="pagination pagination-sm flex-wrap mb-0">
							{if $D.R.AccountAdmin.Page > 1}
								<li class="page-item"><a class="page-link" href="?R[ModuleId]=fremeo/shop&amp;R[Page]=admin__account.list&amp;R[P]={$D.R.AccountAdmin.Page - 1}" aria-label="{$pagesTitle|escape}">&laquo;</a></li>
							{/if}
							<li class="page-item active"><span class="page-link">{$D.R.AccountAdmin.Page} / {$D.R.AccountAdmin.Pages}</span></li>
							{if $D.R.AccountAdmin.Page < $D.R.AccountAdmin.Pages}
								<li class="page-item"><a class="page-link" href="?R[ModuleId]=fremeo/shop&amp;R[Page]=admin__account.list&amp;R[P]={$D.R.AccountAdmin.Page + 1}" aria-label="{$pagesTitle|escape}">&raquo;</a></li>
							{/if}
						</ul>
					</nav>
				{/if}
			</div>
		</div>
	{/if}
{/block}

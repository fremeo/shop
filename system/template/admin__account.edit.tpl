{block name="inner_body"}
	<h1 class="h4 mb-3">{i18n key="account_edit_title"}</h1>
	{if $D.R.AccountEdit.Error}
		<div class="alert alert-danger" role="alert">
			{if $D.R.AccountEdit.Error == 'account_edit_error_id'}{i18n key="account_edit_error_id"}
			{elseif $D.R.AccountEdit.Error == 'account_edit_error_missing'}{i18n key="account_edit_error_missing"}
			{else}{i18n key="account_edit_error_data"}{/if}
		</div>
	{/if}
	{if $D.R.AccountEdit.Saved}
		<div class="alert alert-success" role="status">{i18n key="account_list_saved"}</div>
	{/if}
	{if $D.R.AccountEdit.Id !== null}
		{$accountId = $D.R.AccountEdit.Id}
		{$account = $D.ACCOUNT.D[$accountId]}
		<div class="mb-3 text-break">
			<strong>{$account.Name|default:''|escape}</strong>
			<span class="text-body-secondary">{i18n key="account_list_number"}: {$account.Number|default:''|escape} · {i18n key="account_list_id"}: {$accountId|escape}</span>
		</div>
		<form method="post" id="accountEditForm">
			<input type="hidden" name="{$D.C.Security->registerSecurityD('D[ACTION]')|escape}" value="save">
			<h2 class="h5">{i18n key="account_edit_addresses"}</h2>
			{foreach $account.ADDRESS.D|default:[] as $addressId => $address}
				<fieldset class="border rounded p-3 mb-3" data-address-id="{$addressId|escape}">
					<legend class="float-none w-auto fs-6 px-1 text-break">{$addressId|escape}</legend>
					<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-2">
						<label>
							{input p=['type' => 'checkbox', 'name' => "D[ACCOUNT][D][{$accountId}][ADDRESS][D][{$addressId}][Active]", 'value' => $address.Active|default:0]}
							{i18n key="account_list_active"}
						</label>
						{capture assign="deleteTitle"}{i18n key="account_list_delete"}{/capture}
						{capture assign="deleteConfirm"}{i18n key="account_edit_delete_address_confirm"}{/capture}
						<input type="hidden" data-address-delete name="{$D.C.Security->registerSecurityD("D[ACCOUNT][D][{$accountId}][ADDRESS][D][{$addressId}][__DELETE__]")|escape}" value="1" disabled>
						<button type="button" class="btn btn-outline-danger btn-sm" title="{$deleteTitle|escape}" aria-label="{$deleteTitle|escape}" data-confirm="{$deleteConfirm|escape}" onclick="if (confirm(this.dataset.confirm)) { var address = this.closest('fieldset'); address.querySelector('[data-address-delete]').disabled = false; address.classList.add('d-none'); }"><i class="fa-solid fa-trash" aria-hidden="true"></i></button>
					</div>
					<div class="row g-3 mx-0">
						{foreach ['FName', 'LName', 'Street', 'HNumber', 'Postcode', 'City', 'CountryId', 'Phone', 'Mail'] as $field}
							<div class="col-12 col-md-6 col-xl-4">
								<label class="form-label" for="account-address-{$addressId|escape}-{$field}">
									{if $field == 'FName'}{i18n key="account_edit_first_name"}
									{elseif $field == 'LName'}{i18n key="account_edit_last_name"}
									{elseif $field == 'Street'}{i18n key="account_edit_street"}
									{elseif $field == 'HNumber'}{i18n key="account_edit_house_number"}
									{elseif $field == 'Postcode'}{i18n key="account_edit_postcode"}
									{elseif $field == 'City'}{i18n key="account_edit_city"}
									{elseif $field == 'CountryId'}{i18n key="account_edit_country"}
									{elseif $field == 'Phone'}{i18n key="account_edit_phone"}
									{else}{i18n key="account_edit_mail"}{/if}
								</label>
								{input p=['type' => 'text', 'id' => "account-address-{$addressId}-{$field}"|escape, 'name' => "D[ACCOUNT][D][{$accountId}][ADDRESS][D][{$addressId}][{$field}]", 'value' => $address[$field]|default:''|escape]}
							</div>
						{/foreach}
					</div>
				</fieldset>
			{foreachelse}
				<div class="alert alert-info">{i18n key="account_edit_no_addresses"}</div>
			{/foreach}

			<h2 class="h5 mt-4">{i18n key="account_list_users"}</h2>
			{if $account.USER.D|default:[]}
				<div class="table-responsive">
					<table class="table table-striped align-middle">
						<thead class="table-light">
							<tr>
								<th scope="col">{i18n key="account_list_id"}</th>
								<th scope="col">{i18n key="account_list_name"}</th>
								<th scope="col">{i18n key="account_edit_mail"}</th>
								<th scope="col">{i18n key="account_edit_login_status"}</th>
								<th scope="col">{i18n key="account_edit_membership_active"}</th>
							</tr>
						</thead>
						<tbody>
							{foreach $account.USER.D as $userId => $membership}
								<tr data-user-id="{$userId|escape}">
									<th scope="row" class="text-break">{$userId|escape}</th>
									<td class="text-break">{$D.USER.D[$userId].Name|default:''|escape}</td>
									<td class="text-break">{$D.USER.D[$userId].Mail|default:''|escape}</td>
									<td>
										{if !isset($D.USER.D[$userId])}{i18n key="account_edit_user_missing"}
										{elseif $D.USER.D[$userId].Active|default:0 > 0}{i18n key="account_list_active"}
										{else}{i18n key="account_edit_inactive"}{/if}
									</td>
									<td>
										<label>{input p=['type' => 'checkbox', 'name' => "D[ACCOUNT][D][{$accountId}][USER][D][{$userId}][Active]", 'value' => $membership.Active|default:0]} <span class="visually-hidden">{i18n key="account_edit_membership_active"}</span></label>
									</td>
								</tr>
							{/foreach}
						</tbody>
					</table>
				</div>
			{else}
				<div class="alert alert-info">{i18n key="account_edit_no_users"}</div>
			{/if}
		</form>
	{/if}
{/block}

{block name="inner_footer"}
	<div class="bg-body-tertiary border-top p-2 d-flex flex-wrap gap-2">
		{if $D.R.AccountEdit.Id !== null}
			<button type="submit" form="accountEditForm" class="btn btn-primary btn-sm">{i18n key="account_list_save"}</button>
		{/if}
		<a class="btn btn-outline-secondary btn-sm" href="?R[ModuleId]=fremeo/shop&amp;R[Page]=admin__account.list">{i18n key="account_list_cancel"}</a>
	</div>
{/block}

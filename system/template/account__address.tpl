{function name=address_fields accountId='' addressId='' address=[]}
	<div class="row g-3">
		{foreach ['FName', 'LName', 'Street', 'HNumber', 'Postcode', 'City', 'CountryId', 'Phone', 'Mail'] as $field}
			{$inputId = "address-{$addressId}-{$field}"}
			{$inputName = "D[ACCOUNT][D][{$accountId}][ADDRESS][D][{$addressId}][{$field}]"}
			<div class="col-12 col-md-6">
				<label class="form-label" for="{$inputId|escape}">
					{if $field == 'FName'}{i18n key="address_first_name"}
					{elseif $field == 'LName'}{i18n key="address_last_name"}
					{elseif $field == 'Street'}{i18n key="address_street"}
					{elseif $field == 'HNumber'}{i18n key="address_house_number"}
					{elseif $field == 'Postcode'}{i18n key="address_postcode"}
					{elseif $field == 'City'}{i18n key="address_city"}
					{elseif $field == 'CountryId'}{i18n key="address_country"}
					{elseif $field == 'Phone'}{i18n key="address_phone"}
					{else}{i18n key="address_mail"}{/if}
					{if !in_array($field, ['Phone', 'Mail'])}<span aria-hidden="true">*</span>{else}<span class="text-body-secondary">({i18n key="address_optional"})</span>{/if}
				</label>
				{if $field == 'Mail'}{$fieldType = 'email'}{elseif $field == 'Phone'}{$fieldType = 'tel'}{else}{$fieldType = 'text'}{/if}
				{input p=['type' => $fieldType, 'id' => $inputId|escape, 'name' => $inputName, 'value' => $address[$field]|default:''|escape, 'required' => !in_array($field, ['Phone', 'Mail']), 'placeholder' => ($field == 'CountryId') ? 'DE' : '']}
			</div>
		{/foreach}
	</div>
{/function}

{function name=address_action}
	<input type="hidden" name="R[Action]" value="save">
{/function}

{block name="account_body"}
	<h1 class="h3 mb-3">{i18n key="address_title"}</h1>
	{if $D.R.AddressPage.Error}
		<div class="alert alert-danger" role="alert">
			{if $D.R.AddressPage.Error == 'address_error_account'}{i18n key="address_error_account"}
			{elseif $D.R.AddressPage.Error == 'address_error_invoice'}{i18n key="address_error_invoice"}
			{elseif $D.R.AddressPage.Error == 'address_error_invoice_delete'}{i18n key="address_error_invoice_delete"}
			{else}{i18n key="address_error_data"}{/if}
		</div>
	{/if}
	{if $D.R.AddressPage.Saved}
		<div class="alert alert-success" role="status">{i18n key="address_saved"}</div>
	{/if}
	{if !$D.R.AddressPage.Error || $D.R.AddressPage.Error != 'address_error_account'}
		{$accountId = $D.SESSION.AccountId}
		{$account = $D.ACCOUNT.D[$accountId]}
		{$invoiceId = $account.InvoiceAddressId|default:''}
		{if $account.ADDRESS.D|default:[]}
			<div class="row g-3 mb-4">
				{foreach $account.ADDRESS.D as $addressId => $address}
					<div class="col-12 col-xl-6">
						<section class="card h-100" data-address-id="{$addressId|escape}">
							<div class="card-body">
								<h2 class="h5 card-title">{$address.FName|default:''|escape} {$address.LName|default:''|escape}</h2>
								<p class="mb-2">
									{$address.Street|default:''|escape} {$address.HNumber|default:''|escape}<br>
									{$address.Postcode|default:''|escape} {$address.City|default:''|escape}<br>
									{$address.CountryId|default:''|escape}
									{if $address.Phone|default:''}<br>{$address.Phone|escape}{/if}
									{if $address.Mail|default:''}<br>{$address.Mail|escape}{/if}
								</p>
								<p>
									{if $address.Active|default:0}<span class="badge text-bg-success">{i18n key="address_active"}</span>
									{else}<span class="badge text-bg-secondary">{i18n key="address_inactive"}</span>{/if}
									{if $invoiceId !== '' && (string)$invoiceId === (string)$addressId}<span class="badge text-bg-primary">{i18n key="address_invoice_default"}</span>{/if}
								</p>
								<details>
									<summary class="btn btn-outline-primary btn-sm mb-2">{i18n key="address_edit"}</summary>
									<form method="post" class="border rounded p-3 mb-3">
										{address_action}
										{address_fields accountId=$accountId addressId=$addressId address=$address}
										<p class="small mt-2">{i18n key="address_required_hint"}</p>
										<button type="submit" class="btn btn-primary btn-sm">{i18n key="address_save"}</button>
									</form>
								</details>
								<div class="d-flex flex-wrap gap-2">
									<form method="post">
										{address_action}
										<label>{input p=['type' => 'checkbox', 'name' => "D[ACCOUNT][D][{$accountId}][ADDRESS][D][{$addressId}][Active]", 'value' => $address.Active|default:0]} {i18n key="address_active"}</label>
										<button type="submit" class="btn btn-outline-secondary btn-sm">{i18n key="address_save_status"}</button>
									</form>
									{if $address.Active|default:0 && (string)$invoiceId !== (string)$addressId}
										<form method="post">
											{address_action}
											{input p=['type' => 'hidden', 'name' => "D[ACCOUNT][D][{$accountId}][InvoiceAddressId]", 'value' => $addressId|escape, 'ischanged' => 1]}
											<button type="submit" class="btn btn-outline-primary btn-sm">{i18n key="address_set_invoice"}</button>
										</form>
									{/if}
									<form method="post" data-address-delete-form>
										{address_action}
										<input type="hidden" data-address-delete disabled name="{$D.C.Security->registerSecurityD("D[ACCOUNT][D][{$accountId}][ADDRESS][D][{$addressId}][__DELETE__]")|escape}" value="1">
										{capture assign=deleteConfirm}{i18n key="address_delete_confirm"}{/capture}
										<button type="button" class="btn btn-outline-danger btn-sm" data-address-mark data-confirm="{$deleteConfirm|escape}">{i18n key="address_delete"}</button>
										<span class="d-none" data-address-delete-pending role="status">{i18n key="address_delete_pending"}</span>
										<button type="submit" class="btn btn-danger btn-sm d-none" data-address-delete-save>{i18n key="address_save_delete"}</button>
									</form>
								</div>
							</div>
						</section>
					</div>
				{/foreach}
			</div>
		{else}
			<div class="alert alert-info">{i18n key="address_empty"}</div>
		{/if}
		<details>
			<summary class="btn btn-primary">{i18n key="address_add"}</summary>
			<form method="post" class="border rounded p-3 mt-3">
				{address_action}
				{address_fields accountId=$accountId addressId='__NEW__' address=[]}
				<p class="small mt-2">{i18n key="address_required_hint"}</p>
				<button type="submit" class="btn btn-primary">{i18n key="address_save"}</button>
			</form>
		</details>
	{/if}
	<script>
	{literal}
	document.addEventListener('click', function (event) {
		const button = event.target.closest('[data-address-mark]');
		if (!button || !confirm(button.dataset.confirm)) return;
		const form = button.closest('[data-address-delete-form]');
		const card = form.closest('[data-address-id]');
		card.querySelectorAll('.card-body > h2, .card-body > p, .card-body > details, .card-body > div > form:not([data-address-delete-form])').forEach(function (element) {
			element.classList.add('d-none');
			element.querySelectorAll('input, button').forEach(function (input) { input.disabled = true; });
		});
		form.querySelector('[data-address-delete]').disabled = false;
		form.querySelector('[data-address-delete-pending]').classList.remove('d-none');
		form.querySelector('[data-address-delete-save]').classList.remove('d-none');
		button.classList.add('d-none');
	});
	{/literal}
	</script>
{/block}

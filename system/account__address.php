<?php

$addressAccountId = $D['SESSION']['AccountId'] ?? null;
$addressUserId = $D['SESSION']['UserId'] ?? null;
$addressPosted = $D['ACCOUNT'] ?? [];
$addressFilter = [];
$addressUpdate = [];
$R['AddressPage'] = ['Error' => null, 'Saved' => false];
unset($D['ACCOUNT']);

if ((!is_string($addressAccountId) && !is_int($addressAccountId))
	|| !preg_match('/^[A-Za-z0-9_-]+$/D', (string)$addressAccountId)
	|| (!is_string($addressUserId) && !is_int($addressUserId))
	|| !preg_match('/^[A-Za-z0-9_-]+$/D', (string)$addressUserId)) {
	$R['AddressPage']['Error'] = 'address_error_account';
	return;
}

$addressAccountId = (string)$addressAccountId;
$addressFilter['ACCOUNT']['W'][0]['ID'] = $addressAccountId;
$addressFilter['ACCOUNT']['ADDRESS'] = [];
$addressFilter['ACCOUNT']['USER'] = [];
$C['fremeo/shop']['CData']->get_object($D, $addressFilter);
if (empty($D['ACCOUNT']['D'][$addressAccountId]['Active'])
	|| empty($D['ACCOUNT']['D'][$addressAccountId]['USER']['D'][$addressUserId]['Active'])) {
	unset($D['ACCOUNT']);
	$R['AddressPage']['Error'] = 'address_error_account';
	return;
}

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST' && ($R['Action'] ?? null) === 'save') {
	$addressAccount = $D['ACCOUNT']['D'][$addressAccountId];
	$addressInput = $addressPosted['D'][$addressAccountId] ?? [];
	if ($addressPosted !== [] && (!is_array($addressPosted) || array_diff(array_keys($addressPosted), ['D'])
		|| !is_array($addressPosted['D'] ?? null) || array_diff(array_keys($addressPosted['D']), [$addressAccountId])
		|| !is_array($addressInput) || array_diff(array_keys($addressInput), ['ADDRESS', 'InvoiceAddressId'])
		|| (isset($addressInput['ADDRESS']) && (!is_array($addressInput['ADDRESS'])
			|| array_diff(array_keys($addressInput['ADDRESS']), ['D']) || !is_array($addressInput['ADDRESS']['D'] ?? null))))) {
		$R['AddressPage']['Error'] = 'address_error_data';
	} else {
		foreach ($addressInput['ADDRESS']['D'] ?? [] as $addressId => $addressRow) {
			if (!preg_match('/^[A-Za-z0-9_-]+$/D', (string)$addressId) || !is_array($addressRow)
				|| ($addressId !== '__NEW__' && !isset($addressAccount['ADDRESS']['D'][$addressId]))
				|| array_filter($addressRow, static fn ($value) => !is_string($value))
				|| (isset($addressRow['Active']) && !in_array($addressRow['Active'], ['0', '1'], true))
				|| (isset($addressRow['__DELETE__']) && ($addressRow['__DELETE__'] !== '1' || $addressId === '__NEW__'))) {
				$R['AddressPage']['Error'] = 'address_error_data';
				break;
			}
			if (isset($addressRow['__DELETE__'])) {
				$addressUpdate['ACCOUNT']['D'][$addressAccountId]['ADDRESS']['D'][$addressId] = '__DELETE__';
			} elseif ($addressRow) {
				if ($addressId === '__NEW__') {
					do {
						$addressId = (string)crc32((string)(int)(microtime(true) * 1000));
					} while (isset($addressAccount['ADDRESS']['D'][$addressId]));
					$addressRow['Active'] = '1';
				}
				$addressUpdate['ACCOUNT']['D'][$addressAccountId]['ADDRESS']['D'][$addressId] = $addressRow;
			}
		}
		if (array_key_exists('InvoiceAddressId', $addressInput)) {
			$addressInvoice = $addressInput['InvoiceAddressId'];
			if (!is_string($addressInvoice) || empty($addressAccount['ADDRESS']['D'][$addressInvoice]['Active'])
				|| isset($addressUpdate['ACCOUNT']['D'][$addressAccountId]['ADDRESS']['D'][$addressInvoice])) {
				$R['AddressPage']['Error'] = 'address_error_invoice';
			} else {
				$addressUpdate['ACCOUNT']['D'][$addressAccountId]['InvoiceAddressId'] = $addressInvoice;
			}
		}
		$addressInvoice = $addressAccount['InvoiceAddressId'] ?? '';
		if ($addressInvoice !== '' && ($addressUpdate['ACCOUNT']['D'][$addressAccountId]['ADDRESS']['D'][$addressInvoice] ?? null) === '__DELETE__') {
			foreach ($addressAccount['ADDRESS']['D'] as $addressId => $addressRow) {
				if ((string)$addressId !== (string)$addressInvoice && !empty($addressRow['Active'])) {
					$R['AddressPage']['Error'] = 'address_error_invoice_delete';
					break;
				}
			}
			if (!$R['AddressPage']['Error']) $addressUpdate['ACCOUNT']['D'][$addressAccountId]['InvoiceAddressId'] = '';
		}
	}
	if (!$R['AddressPage']['Error'] && $addressUpdate) {
		$C['fremeo/shop']['CData']->set_object($addressUpdate);
		$R['AddressPage']['Saved'] = true;
		unset($D['ACCOUNT']);
		$C['fremeo/shop']['CData']->get_object($D, $addressFilter);
	}
}

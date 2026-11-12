<?php

$accountDb = $C['fremeo/shop']['CData'];
$R['AccountAdmin'] = ['Errors' => [], 'Saved' => false];

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST' && ($D['ACTION'] ?? null) === 'save') {
	$accountPosted = $D['ACCOUNT']['D'] ?? [];
	$accountUpdate = [];
	if (!is_array($accountPosted)) {
		$R['AccountAdmin']['Errors'][] = 'account_list_error_data';
	} else {
		foreach ($accountPosted as $accountId => $accountRow) {
			if (!preg_match('/^[A-Za-z0-9_-]+$/D', (string)$accountId) || !is_array($accountRow)
				|| array_diff(array_keys($accountRow), ['Active', '__DELETE__'])
				|| array_filter($accountRow, fn ($value) => !in_array($value, [0, 1, '0', '1'], true))) {
				$R['AccountAdmin']['Errors'][] = 'account_list_error_data';
				break;
			}
		}
		if ($accountPosted && !$R['AccountAdmin']['Errors']) {
			$accountFilter = ['ACCOUNT' => ['W' => [['ID' => array_keys($accountPosted)]], 'ORDER' => []]];
			$accountExisting = null;
			$accountDb->get_object($accountExisting, $accountFilter);
			foreach ($accountPosted as $accountId => $accountRow) {
				$accountOld = $accountExisting['ACCOUNT']['D'][$accountId] ?? null;
				$accountError = $accountOld === null ? 'account_list_error_missing'
					: (!empty($accountRow['__DELETE__']) && !empty($accountOld['ORDER']['D']) ? 'account_list_error_orders' : null);
				if ($accountError) {
					$R['AccountAdmin']['Errors'][] = $accountError;
				} elseif (!empty($accountRow['__DELETE__']) || isset($accountRow['Active'])) {
					$accountUpdate['ACCOUNT']['D'][$accountId] = !empty($accountRow['__DELETE__'])
						? '__DELETE__' : ['Active' => (int)$accountRow['Active']];
				}
			}
		}
	}
	if (!$R['AccountAdmin']['Errors'] && $accountUpdate) {
		$accountDb->set_object($accountUpdate);
		$R['AccountAdmin']['Saved'] = true;
	}
	$R['AccountAdmin']['Errors'] = array_values(array_unique($R['AccountAdmin']['Errors']));
}

$accountPerPage = 50;
$accountPage = filter_var($R['P'] ?? 1, FILTER_VALIDATE_INT, ['options' => [
	'min_range' => 1, 'max_range' => intdiv(PHP_INT_MAX, $accountPerPage),
]]) ?: 1;
$accountFilter = ['ACCOUNT' => [
	'USER' => [], 'ADDRESS' => [], 'MEMO' => [], 'ORDER' => [],
	'O' => [['ID' => 'ASC']],
]];
do {
	$accountFilter['ACCOUNT']['L'] = ['START' => ($accountPage - 1) * $accountPerPage, 'STEP' => $accountPerPage];
	unset($D['ACCOUNT']);
	$accountDb->get_object($D, $accountFilter);
	$accountTotal = (int)($D['ACCOUNT']['COUNT'] ?? 0);
	$accountPages = max(1, (int)ceil($accountTotal / $accountPerPage));
	$accountRequestedPage = $accountPage;
	$accountPage = min($accountPage, $accountPages);
} while ($accountRequestedPage !== $accountPage);
$R['AccountAdmin'] += [
	'Total' => $accountTotal,
	'Page' => $accountPage,
	'Pages' => $accountPages,
	'From' => $accountTotal ? ($accountPage - 1) * $accountPerPage + 1 : 0,
	'To' => ($accountPage - 1) * $accountPerPage + count($D['ACCOUNT']['D'] ?? []),
	'InvalidIds' => [],
];
foreach ($D['ACCOUNT']['D'] ?? [] as $accountId => $accountRow) {
	if (!preg_match('/^[A-Za-z0-9_-]+$/D', (string)$accountId)) {
		$R['AccountAdmin']['InvalidIds'][$accountId] = true;
	}
}

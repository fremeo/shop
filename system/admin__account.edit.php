<?php

$accountDb = $C['fremeo/shop']['CData'];
$accountId = $R['Id'] ?? null;
$R['AccountEdit'] = ['Id' => null, 'Error' => null, 'Saved' => false];
$accountPosted = $D['ACCOUNT']['D'] ?? [];
unset($D['ACCOUNT'], $D['USER']);
if ((!is_string($accountId) && !is_int($accountId)) || !preg_match('/^[A-Za-z0-9_-]+$/D', (string)$accountId)) {
	$R['AccountEdit']['Error'] = 'account_edit_error_id';
	return;
}
$accountId = (string)$accountId;
$accountFilter = ['ACCOUNT' => ['W' => [['ID' => $accountId]], 'ADDRESS' => [], 'USER' => []]];
$accountDb->get_object($D, $accountFilter);
if (!isset($D['ACCOUNT']['D'][$accountId])) {
	$R['AccountEdit']['Error'] = 'account_edit_error_missing';
	return;
}
$R['AccountEdit']['Id'] = $accountId;

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST' && ($D['ACTION'] ?? null) === 'save') {
	$accountUpdate = [];
	if (!is_array($accountPosted) || array_diff(array_keys($accountPosted), [$accountId])
		|| !is_array($accountPosted[$accountId] ?? [])
		|| array_diff(array_keys($accountPosted[$accountId] ?? []), ['ADDRESS', 'USER'])) {
		$R['AccountEdit']['Error'] = 'account_edit_error_data';
	} else {
		$accountPattern = (static fn (string $file): array => include $file)(__DIR__ . '/default/default.pattern.php');
		foreach ($accountPosted[$accountId] ?? [] as $accountType => $accountChildren) {
			if (!is_array($accountChildren) || array_diff(array_keys($accountChildren), ['D'])
				|| !is_array($accountChildren['D'] ?? [])) {
				$R['AccountEdit']['Error'] = 'account_edit_error_data';
				break;
			}
			foreach ($accountChildren['D'] ?? [] as $accountChildId => $accountRow) {
				$accountFields = $accountType === 'USER' ? ['Active']
					: [...array_keys($accountPattern['ACCOUNT']['D']['ADDRESS']), '__DELETE__'];
				if (!preg_match('/^[A-Za-z0-9_-]+$/D', (string)$accountChildId)
					|| !isset($D['ACCOUNT']['D'][$accountId][$accountType]['D'][$accountChildId])
					|| !is_array($accountRow) || array_diff(array_keys($accountRow), $accountFields)) {
					$R['AccountEdit']['Error'] = 'account_edit_error_data';
					break 2;
				}
				foreach ($accountRow as $accountField => $accountValue) {
					if (in_array($accountField, ['Active', '__DELETE__'], true)
						? !in_array($accountValue, [0, 1, '0', '1'], true) : !is_string($accountValue)) {
						$R['AccountEdit']['Error'] = 'account_edit_error_data';
						break 3;
					}
				}
				if (!empty($accountRow['__DELETE__'])) {
					$accountUpdate['ACCOUNT']['D'][$accountId][$accountType]['D'][$accountChildId] = '__DELETE__';
				} else {
					unset($accountRow['__DELETE__']);
					if ($accountRow) $accountUpdate['ACCOUNT']['D'][$accountId][$accountType]['D'][$accountChildId] = $accountRow;
				}
			}
		}
	}
	if (!$R['AccountEdit']['Error'] && $accountUpdate) {
		$accountDb->set_object($accountUpdate);
		$R['AccountEdit']['Saved'] = true;
	}
	unset($D['ACCOUNT']);
	$accountDb->get_object($D, $accountFilter);
}

$accountUserIds = array_keys($D['ACCOUNT']['D'][$accountId]['USER']['D'] ?? []);
if ($accountUserIds) {
	$accountUserFilter = ['USER' => ['W' => [['ID' => $accountUserIds]]]];
	$C['fremeo/core']['CData']->get_object($D, $accountUserFilter);
	foreach ($D['USER']['D'] ?? [] as $accountUserId => $accountUser) {
		$D['USER']['D'][$accountUserId] = array_intersect_key($accountUser, array_flip(['Active', 'Name', 'Mail']));
	}
}

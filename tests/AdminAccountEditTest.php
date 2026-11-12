<?php
namespace fremeo\shop\tests;

use fremeo\core\Container;
use fremeo\core\LanguageVariable;
use fremeo\core\Security;
use fremeo\core\Template;
use phploader\CData;
use PHPUnit\Framework\TestCase;
use Symfony\Component\Filesystem\Filesystem;

class AdminAccountEditTest extends TestCase {
	private string $tmp;
	private Container $C;
	private ?string $method;

	protected function setUp(): void {
		$this->tmp = sys_get_temp_dir() . '/fremeo_shop_account_edit_' . bin2hex(random_bytes(6));
		$this->method = $_SERVER['REQUEST_METHOD'] ?? null;
		$this->C = new Container();
		$this->C->set('Filesystem', new Filesystem());
		foreach (['shop', 'core'] as $module) {
			$db = new CData(['DB' => ['FILENAME' => $this->tmp . "/$module/data.db", 'FILENAME_C' => $this->tmp . "/$module/cache.db"]]);
			$db->registerPattern(require __DIR__ . '/../../core/system/default/default.global.pattern.php');
			$db->registerPattern(require __DIR__ . "/../../$module/system/default/default.pattern.php");
			$this->C->set('CData', $db, "fremeo/$module");
		}
		$data = ['ACCOUNT' => ['D' => [
			'company' => [
				'Active' => 1, 'Name' => 'Firma <A>', 'Number' => '100',
				'ADDRESS' => ['D' => [
					'office' => ['Active' => 1, 'FName' => 'Anna', 'LName' => 'Muster', 'Street' => 'Straße', 'City' => 'Berlin', 'Mail' => '"<mail>'],
					'inactive' => ['Active' => 0, 'City' => 'Bonn'],
				]],
				'USER' => ['D' => [
					'employee' => ['Active' => 1], 'disabled' => ['Active' => 0], 'missing' => ['Active' => 1],
				]],
				'ORDER' => ['D' => ['order' => ['Active' => 1, 'FName' => 'Historisch', 'Street' => 'Alte Straße']]],
			],
			'other' => [
				'Active' => 1, 'Name' => 'Andere Firma',
				'ADDRESS' => ['D' => ['foreign' => ['City' => 'Hamburg']]],
				'USER' => ['D' => ['employee' => ['Active' => 1]]],
			],
			0 => ['Active' => 1],
		]]];
		$this->C['fremeo/shop']['CData']->set_object($data);
		$data = ['USER' => ['D' => [
			'employee' => ['Active' => 1, 'Name' => 'Anna <Test>', 'Mail' => 'anna@example.test', 'Password' => 'must-not-leak'],
			'disabled' => ['Active' => 0, 'Name' => 'Bob', 'Mail' => 'bob@example.test'],
			'unassigned' => ['Active' => 1, 'Name' => 'Not a member'],
		]]];
		$this->C['fremeo/core']['CData']->set_object($data);
	}

	protected function tearDown(): void {
		if ($this->method === null) unset($_SERVER['REQUEST_METHOD']);
		else $_SERVER['REQUEST_METHOD'] = $this->method;
		foreach (['shop', 'core'] as $module) unset($this->C["fremeo/$module"]['CData']);
		unset($this->C);
		gc_collect_cycles();
		(new Filesystem())->remove($this->tmp);
	}

	private function page(array $posted = [], string $method = 'GET', mixed $id = 'company'): array {
		$_SERVER['REQUEST_METHOD'] = $method;
		$C = $this->C;
		$D = ['ACTION' => 'save', 'ACCOUNT' => ['D' => $posted], 'USER' => ['D' => ['injected' => ['Name' => 'fake']]]];
		$R = ['Id' => $id];
		$F = ['PAGE' => []];
		include __DIR__ . '/../system/admin__account.edit.php';
		$this->assertSame(['PAGE' => []], $F);
		$D['R'] = $R;
		return $D;
	}

	public function testGetLoadsAllAddressesAndOnlyAssignedCoreUsersWithoutSecrets(): void {
		$data = $this->page(['company' => ['ADDRESS' => ['D' => ['office' => ['City' => 'Injected']]]]]);
		$this->assertSame('Berlin', $data['ACCOUNT']['D']['company']['ADDRESS']['D']['office']['City']);
		$this->assertCount(2, $data['ACCOUNT']['D']['company']['ADDRESS']['D']);
		$this->assertCount(3, $data['ACCOUNT']['D']['company']['USER']['D']);
		$this->assertSame(['disabled', 'employee'], array_keys($data['USER']['D']));
		$this->assertSame('Anna <Test>', $data['USER']['D']['employee']['Name']);
		$this->assertStringNotContainsString('must-not-leak', serialize($data));
		$this->assertFalse($data['R']['AccountEdit']['Saved']);
	}

	public function testPartialAddressSaveAndMembershipToggleDoNotChangeCoreOrOtherAccounts(): void {
		$data = $this->page(['company' => [
			'ADDRESS' => ['D' => ['office' => ['City' => 'Köln', 'Mail' => '', 'Active' => '0']]],
			'USER' => ['D' => ['employee' => ['Active' => '0'], 'disabled' => ['Active' => '1']]],
		]], 'POST');
		$this->assertTrue($data['R']['AccountEdit']['Saved']);
		$account = $data['ACCOUNT']['D']['company'];
		$this->assertSame('Köln', $account['ADDRESS']['D']['office']['City']);
		$this->assertEmpty($account['ADDRESS']['D']['office']['Mail'] ?? '');
		$this->assertSame('Anna', $account['ADDRESS']['D']['office']['FName']);
		$this->assertSame(0, (int)($account['ADDRESS']['D']['office']['Active'] ?? 0));
		$this->assertSame(0, (int)($account['USER']['D']['employee']['Active'] ?? 0));
		$this->assertSame(1, (int)$account['USER']['D']['disabled']['Active']);
		$this->assertSame(1, (int)$data['USER']['D']['employee']['Active']);
		$other = $this->page([], 'GET', 'other');
		$this->assertSame(1, (int)$other['ACCOUNT']['D']['other']['USER']['D']['employee']['Active']);
		$this->assertSame('Hamburg', $other['ACCOUNT']['D']['other']['ADDRESS']['D']['foreign']['City']);
	}

	public function testAddressDeletionPreservesHistoricalOrderAddresses(): void {
		$data = $this->page(['company' => ['ADDRESS' => ['D' => ['office' => ['__DELETE__' => 1, 'City' => 'ignored']]]]], 'POST');
		$this->assertTrue($data['R']['AccountEdit']['Saved']);
		$this->assertArrayNotHasKey('office', $data['ACCOUNT']['D']['company']['ADDRESS']['D']);
		$filter = ['ACCOUNT' => ['W' => [['ID' => 'company']], 'ORDER' => []]];
		$saved = null;
		$this->C['fremeo/shop']['CData']->get_object($saved, $filter);
		$this->assertSame('Alte Straße', $saved['ACCOUNT']['D']['company']['ORDER']['D']['order']['Street']);
	}

	public function testInvalidUpdatesAreRejectedAsAWholeWithoutCreatingRecords(): void {
		foreach ([
			['other' => ['ADDRESS' => ['D' => ['foreign' => ['City' => 'Injected']]]]],
			['company' => ['Name' => 'Injected']],
			['company' => ['ADDRESS' => ['D' => ['new' => ['City' => 'Injected']]]]],
			['company' => ['ADDRESS' => ['D' => ['foreign' => ['City' => 'Injected']]]]],
			['company' => ['ADDRESS' => ['D' => ['office' => ['Company' => 'Injected']]]]],
			['company' => ['ADDRESS' => ['D' => ['office' => ['City' => []]]]]],
			['company' => ['ADDRESS' => ['D' => ['office' => ['Active' => null]]]]],
			['company' => ['USER' => ['D' => ['employee' => ['__DELETE__' => 1]]]]],
			['company' => ['USER' => ['D' => ['unassigned' => ['Active' => 1]]]]],
			['company' => ['USER' => ['D' => ['employee' => ['Active' => false]]]]],
			['company' => ['USER' => ['D' => ['employee' => ['Name' => 'Injected']]]]],
			['company' => ['ADDRESS' => 'invalid']],
			['company' => ['ADDRESS' => ['D' => 'invalid']]],
			['company' => 'invalid'],
		] as $posted) {
			if (is_array($posted['company'] ?? null) && is_array($posted['company']['ADDRESS'] ?? [])
				&& is_array($posted['company']['ADDRESS']['D'] ?? [])) {
				$posted['company']['ADDRESS']['D']['inactive'] = ['City' => 'Must not change'];
			}
			$data = $this->page($posted, 'POST');
			$this->assertSame('account_edit_error_data', $data['R']['AccountEdit']['Error']);
			$this->assertFalse($data['R']['AccountEdit']['Saved']);
			$this->assertSame('Bonn', $data['ACCOUNT']['D']['company']['ADDRESS']['D']['inactive']['City']);
			$this->assertSame('Firma <A>', $data['ACCOUNT']['D']['company']['Name']);
		}
	}

	public function testInvalidMissingAndZeroAccountIds(): void {
		foreach ([null, '', [], 'invalid/id'] as $id) {
			$data = $this->page([], 'POST', $id);
			$this->assertSame('account_edit_error_id', $data['R']['AccountEdit']['Error']);
			$this->assertNull($data['R']['AccountEdit']['Id']);
			$this->assertArrayNotHasKey('ACCOUNT', $data);
		}
		$data = $this->page([], 'POST', 'unknown');
		$this->assertSame('account_edit_error_missing', $data['R']['AccountEdit']['Error']);
		$data = $this->page([], 'GET', '0');
		$this->assertSame('0', $data['R']['AccountEdit']['Id']);
		$data = $this->page([], 'GET', 0);
		$this->assertSame('0', $data['R']['AccountEdit']['Id']);
	}

	public function testInvalidFlagTypesDoNotPartiallyUpdateAddresses(): void {
		foreach ([null, false, true, 0.0, 1.0, -1, 2, '', 'true', [], ['1']] as $value) {
			foreach (['ADDRESS' => '__DELETE__', 'USER' => 'Active'] as $type => $field) {
				$id = $type === 'ADDRESS' ? 'office' : 'employee';
				$posted = ['ADDRESS' => ['D' => ['inactive' => ['City' => 'Must not change']]]];
				$posted[$type]['D'][$id] = [$field => $value];
				$data = $this->page(['company' => $posted], 'POST');
				$this->assertSame('account_edit_error_data', $data['R']['AccountEdit']['Error']);
				$this->assertFalse($data['R']['AccountEdit']['Saved']);
				$this->assertSame('Bonn', $data['ACCOUNT']['D']['company']['ADDRESS']['D']['inactive']['City']);
			}
		}
	}

	public function testZeroChildIdsAndEmptyUpdates(): void {
		$data = ['ACCOUNT' => ['D' => [0 => [
			'ADDRESS' => ['D' => [0 => ['Active' => 1, 'City' => 'Berlin']]],
			'USER' => ['D' => [0 => ['Active' => 1]]],
		]]]];
		$this->C['fremeo/shop']['CData']->set_object($data);
		$data = $this->page([], 'POST', '0');
		$this->assertNull($data['R']['AccountEdit']['Error']);
		$this->assertFalse($data['R']['AccountEdit']['Saved']);
		$data = $this->page([0 => ['ADDRESS' => ['D' => [0 => ['__DELETE__' => '0']]]]], 'POST', '0');
		$this->assertFalse($data['R']['AccountEdit']['Saved']);
		$this->assertSame('Berlin', $data['ACCOUNT']['D'][0]['ADDRESS']['D'][0]['City']);
		$data = $this->page([0 => [
			'ADDRESS' => ['D' => [0 => ['__DELETE__' => '1']]],
			'USER' => ['D' => [0 => ['Active' => '0']]],
		]], 'POST', '0');
		$this->assertTrue($data['R']['AccountEdit']['Saved']);
		$this->assertArrayNotHasKey(0, $data['ACCOUNT']['D'][0]['ADDRESS']['D'] ?? []);
		$this->assertSame(0, (int)($data['ACCOUNT']['D'][0]['USER']['D'][0]['Active'] ?? 0));
	}

	#[\PHPUnit\Framework\Attributes\WithoutErrorHandler]
	public function testTemplateRendersSecureEscapedInputsAndExternalFooterActions(): void {
		$data = $this->page();
		$this->C->set('Security', new Security());
		$data['C'] = $this->C;
		$data['MODULE']['D']['fremeo/shop'] = ['Active' => 1, 'INFO' => [
			'Type' => 'module', 'ModulDir' => dirname(__DIR__), 'DataDir' => $this->tmp . '/shop',
		]];
		$this->C->set('Template', new Template($this->C, $data));
		$smarty = new \Smarty();
		$smarty->setCompileDir($this->tmp . '/compiled');
		$smarty->setCacheDir($this->tmp . '/html-cache');
		$smarty->registerPlugin(\Smarty::PLUGIN_MODIFIER, 'strstr', 'strstr');
		$smarty->error_reporting = E_ALL & ~E_WARNING & ~E_NOTICE & ~E_DEPRECATED;
		$this->C->set('Smarty', $smarty);
		$language = new LanguageVariable($this->C, $data);
		$language->configure($smarty);
		$smarty->assign('D', $data);
		$html = $smarty->fetch('extends:' . dirname(__DIR__) . '/system/template/admin__account.edit.tpl|'
			. __DIR__ . '/../../core/system/template/include/input.tpl');
		$previous = libxml_use_internal_errors(true);
		try {
			$document = new \DOMDocument();
			$document->loadHTML('<?xml encoding="UTF-8">' . $html);
			$xpath = new \DOMXPath($document);
			$this->assertSame(2, $xpath->query('//fieldset[@data-address-id]')->length);
			$this->assertSame(18, $xpath->query('//fieldset//input[@type="text"]')->length);
			$this->assertSame(3, $xpath->query('//tr[@data-user-id]')->length);
			$this->assertSame(1, $xpath->query('//button[@form="accountEditForm"][@type="submit"]')->length);
			$this->assertSame(0, $xpath->query('//form//button[@type="submit"]')->length);
			$this->assertSame(2, $xpath->query('//input[@data-address-delete][@disabled]')->length);
			$this->assertSame(0, $xpath->query('//input[starts-with(@name,"D[")]')->length);
			$this->assertSame('"<mail>', $xpath->query('//input[@id="account-address-office-Mail"]')->item(0)->getAttribute('value'));
			$this->assertStringContainsString('Firma &lt;A&gt;', $html);
			$this->assertStringContainsString('Anna &lt;Test&gt;', $html);
			$this->assertStringContainsString('Benutzer nicht mehr vorhanden', $html);
			$this->assertStringNotContainsString('must-not-leak', $html);
			$this->assertContains('D[ACCOUNT][D][company][USER][D][employee][Active]', $_SESSION['Security']['Map']);
			$this->assertContains('D[ACCOUNT][D][company][ADDRESS][D][office][__DELETE__]', $_SESSION['Security']['Map']);
		} finally {
			libxml_clear_errors();
			libxml_use_internal_errors($previous);
			$smarty->clearAllAssign();
			unset($language, $smarty);
		}
	}
}

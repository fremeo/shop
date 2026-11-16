<?php
namespace fremeo\shop\tests;

use fremeo\core\Container;
use fremeo\core\LanguageVariable;
use fremeo\core\Security;
use fremeo\core\Template;
use phploader\CData;
use PHPUnit\Framework\TestCase;
use Symfony\Component\Filesystem\Filesystem;

class AccountAddressTest extends TestCase {
	private string $tmp;
	private Container $C;
	private ?string $method;

	protected function setUp(): void {
		$this->tmp = sys_get_temp_dir() . '/fremeo_shop_address_' . bin2hex(random_bytes(6));
		$this->method = $_SERVER['REQUEST_METHOD'] ?? null;
		$this->C = new Container();
		$this->C->set('Filesystem', new Filesystem());
		$db = new CData(['DB' => ['FILENAME' => $this->tmp . '/shop/data.db', 'FILENAME_C' => $this->tmp . '/shop/cache.db']]);
		$db->registerPattern(require __DIR__ . '/../../core/system/default/default.global.pattern.php');
		$db->registerPattern(require __DIR__ . '/../system/default/default.pattern.php');
		$this->C->set('CData', $db, 'fremeo/shop');
		$data = ['ACCOUNT' => ['D' => [
			'company' => [
				'Active' => 1,
				'USER' => ['D' => ['employee' => ['Active' => 1], 'disabled' => ['Active' => 0]]],
				'InvoiceAddressId' => 'office',
				'ADDRESS' => ['D' => [
					'office' => $this->fields('Berlin') + ['Active' => 1],
					'warehouse' => $this->fields('Bonn') + ['Active' => 1],
					'inactive' => $this->fields('Köln') + ['Active' => 0],
				]],
				'ORDER' => ['D' => ['order' => [
					'FName' => 'Historisch', 'Street' => 'Alte Straße',
					'DELIVERY' => ['D' => ['delivery' => ['City' => 'Historischer Ort']]],
				]]],
			],
			'other' => ['Active' => 1, 'ADDRESS' => ['D' => ['foreign' => $this->fields('Hamburg') + ['Active' => 1]]]],
		]]];
		$db->set_object($data);
	}

	protected function tearDown(): void {
		if ($this->method === null) unset($_SERVER['REQUEST_METHOD']);
		else $_SERVER['REQUEST_METHOD'] = $this->method;
		unset($this->C['fremeo/shop']['CData']);
		unset($this->C);
		gc_collect_cycles();
		(new Filesystem())->remove($this->tmp);
	}

	private function fields(string $city): array {
		return ['FName' => 'Anna', 'LName' => 'Muster', 'Street' => 'Straße', 'HNumber' => '1',
			'Postcode' => '12345', 'City' => $city, 'CountryId' => 'DE', 'Phone' => '', 'Mail' => ''];
	}

	private function page(array $input = [], string $method = 'GET', mixed $accountId = 'company', mixed $userId = 'employee', ?string $action = 'save'): array {
		$_SERVER['REQUEST_METHOD'] = $method;
		$C = $this->C;
		$D = $input;
		$D['SESSION'] = ['UserId' => $userId, 'AccountId' => $accountId];
		$R = ['Action' => $action];
		$D['R'] = &$R;
		$F = ['SETTING' => []];
		include __DIR__ . '/../system/account__address.php';
		$this->assertSame(['SETTING' => []], $F);
		return $D;
	}

	private function request(string $action, string $id, ?array $row = null, string $account = 'company'): array {
		$data = [];
		if ($action === 'delete' && $row === null) $row = ['__DELETE__' => '1'];
		if ($action === 'activate' || $action === 'deactivate') $row = ['Active' => $action === 'activate' ? '1' : '0'];
		if ($action === 'invoice') $data['ACCOUNT']['D'][$account]['InvoiceAddressId'] = $id;
		if ($row !== null) $data['ACCOUNT']['D'][$account]['ADDRESS']['D'][$id] = $row;
		return $this->page($data, 'POST');
	}

	public function testCreateEditAndStatusActionsPreserveOrders(): void {
		$before = (int)(microtime(true) * 1000);
		$data = $this->request('create', '__NEW__', $this->fields('Leipzig'));
		$after = (int)(microtime(true) * 1000);
		$this->assertTrue($data['R']['AddressPage']['Saved']);
		$addresses = $data['ACCOUNT']['D']['company']['ADDRESS']['D'];
		$ids = array_diff(array_keys($addresses), ['office', 'warehouse', 'inactive']);
		$this->assertCount(1, $ids);
		$id = (string)reset($ids);
		$this->assertMatchesRegularExpression('/^[0-9]+$/D', $id);
		$expectedIds = [];
		for ($timestamp = $before; $timestamp <= $after; $timestamp++) $expectedIds[] = (string)crc32((string)$timestamp);
		$this->assertContains($id, $expectedIds);
		$this->assertSame('Leipzig', $addresses[$id]['City']);
		$this->assertSame(1, (int)$addresses[$id]['Active']);
		$data = $this->request('edit', $id, $this->fields('Dresden'));
		$this->assertSame('Dresden', $data['ACCOUNT']['D']['company']['ADDRESS']['D'][$id]['City']);
		$data = $this->request('deactivate', $id);
		$this->assertSame(0, (int)$data['ACCOUNT']['D']['company']['ADDRESS']['D'][$id]['Active']);
		$data = $this->request('activate', $id);
		$this->assertSame(1, (int)$data['ACCOUNT']['D']['company']['ADDRESS']['D'][$id]['Active']);
		$data = $this->request('delete', $id);
		$this->assertArrayNotHasKey($id, $data['ACCOUNT']['D']['company']['ADDRESS']['D']);
		$filter = ['ACCOUNT' => ['W' => [['ID' => 'company']], 'ORDER' => ['DELIVERY' => []]]];
		$this->C['fremeo/shop']['CData']->get_object($orders, $filter);
		$order = $orders['ACCOUNT']['D']['company']['ORDER']['D']['order'];
		$this->assertSame('Alte Straße', $order['Street']);
		$this->assertSame('Historischer Ort', $order['DELIVERY']['D']['delivery']['City']);
	}

	public function testInvoiceSelectionAndDeletingLastDefault(): void {
		$data = $this->request('invoice', 'inactive');
		$this->assertSame('address_error_invoice', $data['R']['AddressPage']['Error']);
		$data = $this->request('delete', 'office');
		$this->assertSame('address_error_invoice_delete', $data['R']['AddressPage']['Error']);
		$data = $this->request('invoice', 'warehouse');
		$this->assertSame('warehouse', $data['ACCOUNT']['D']['company']['InvoiceAddressId']);
		$data = $this->request('delete', 'office');
		$this->assertArrayNotHasKey('office', $data['ACCOUNT']['D']['company']['ADDRESS']['D']);
		$data = $this->request('deactivate', 'warehouse');
		$this->assertSame('warehouse', $data['ACCOUNT']['D']['company']['InvoiceAddressId']);
		$data = $this->request('delete', 'warehouse');
		$this->assertTrue($data['R']['AddressPage']['Saved']);
		$this->assertEmpty($data['ACCOUNT']['D']['company']['InvoiceAddressId'] ?? null);
		$this->assertArrayNotHasKey('warehouse', $data['ACCOUNT']['D']['company']['ADDRESS']['D']);
	}

	public function testInvalidRequestsNeverWriteOtherData(): void {
		$invalid = $this->fields('Injected');
		$invalid['City'] = [];
		$data = $this->request('edit', 'office', $invalid);
		$this->assertSame('address_error_data', $data['R']['AddressPage']['Error']);
		$data = $this->request('edit', 'foreign', $this->fields('Injected'), 'other');
		$this->assertSame('address_error_data', $data['R']['AddressPage']['Error']);
		$data = $this->request('edit', 'missing', $this->fields('Injected'));
		$this->assertSame('address_error_data', $data['R']['AddressPage']['Error']);
		foreach (['invalid', 1, ['D' => 'invalid'], ['D' => ['company' => ['ADDRESS' => 'invalid']]]] as $postedAccount) {
			$data = $this->page(['ACCOUNT' => $postedAccount], 'POST');
			$this->assertSame('address_error_data', $data['R']['AddressPage']['Error']);
			$this->assertSame('Berlin', $data['ACCOUNT']['D']['company']['ADDRESS']['D']['office']['City']);
		}
		$data = $this->page(['ACCOUNT' => ['D' => ['company' => ['ORDER' => ['D' => ['order' => '__DELETE__']]]]]], 'POST');
		$this->assertSame('address_error_data', $data['R']['AddressPage']['Error']);
		$this->assertArrayHasKey('office', $data['ACCOUNT']['D']['company']['ADDRESS']['D']);
		foreach ([null, '', [], 'invalid/id'] as $accountId) {
			$data = $this->page(['ADDRESS_ACTION' => 'delete', 'ADDRESS_ID' => 'office'], 'POST', $accountId);
			$this->assertSame('address_error_account', $data['R']['AddressPage']['Error']);
			$this->assertArrayNotHasKey('ACCOUNT', $data);
		}
		$data = $this->page(['ADDRESS_ACTION' => 'delete', 'ADDRESS_ID' => 'office'], 'POST', 'company', null);
		$this->assertSame('address_error_account', $data['R']['AddressPage']['Error']);
		$this->assertArrayNotHasKey('ACCOUNT', $data);
		$data = $this->page(['ADDRESS_ACTION' => 'delete', 'ADDRESS_ID' => 'office'], 'GET');
		$this->assertArrayHasKey('office', $data['ACCOUNT']['D']['company']['ADDRESS']['D']);
	}

	public function testPatternFiltersUnknownFieldsWhileRequiredFieldsAreOnlyCheckedByTheForm(): void {
		$data = $this->request('edit', 'office', ['City' => '', 'Unknown' => 'ignored']);
		$this->assertTrue($data['R']['AddressPage']['Saved']);
		$this->assertEmpty($data['ACCOUNT']['D']['company']['ADDRESS']['D']['office']['City'] ?? '');
		$this->assertArrayNotHasKey('Unknown', $data['ACCOUNT']['D']['company']['ADDRESS']['D']['office']);
		$data = $this->request('edit', 'office', ['Active' => '-2']);
		$this->assertSame('address_error_data', $data['R']['AddressPage']['Error']);
		$this->assertArrayHasKey('office', $data['ACCOUNT']['D']['company']['ADDRESS']['D']);
		foreach (['2', 'true', [], null] as $invalid) {
			$data = $this->request('edit', 'office', ['Active' => $invalid]);
			$this->assertSame('address_error_data', $data['R']['AddressPage']['Error']);
		}
		$data = $this->request('edit', '__NEW__', ['__DELETE__' => '1']);
		$this->assertSame('address_error_data', $data['R']['AddressPage']['Error']);
	}

	public function testRequiresActiveAccountAndMembership(): void {
		foreach ([['new-account', 'employee'], ['other', 'employee'], ['company', 'disabled']] as [$accountId, $userId]) {
			$data = $this->page([], 'GET', $accountId, $userId);
			$this->assertSame('address_error_account', $data['R']['AddressPage']['Error']);
			$this->assertArrayNotHasKey('ACCOUNT', $data);
		}
		$update = ['ACCOUNT' => ['D' => ['company' => ['Active' => 0]]]];
		$this->C['fremeo/shop']['CData']->set_object($update);
		$data = $this->page([], 'GET');
		$this->assertSame('address_error_account', $data['R']['AddressPage']['Error']);
		$this->assertArrayNotHasKey('ACCOUNT', $data);
	}

	public function testPartialEditAndDeletionRequireSaveAction(): void {
		$data = $this->request('edit', 'office', ['City' => 'Dresden', 'Mail' => '']);
		$this->assertTrue($data['R']['AddressPage']['Saved']);
		$this->assertSame('Anna', $data['ACCOUNT']['D']['company']['ADDRESS']['D']['office']['FName']);
		$this->assertSame('Dresden', $data['ACCOUNT']['D']['company']['ADDRESS']['D']['office']['City']);
		$data = $this->page(['ACCOUNT' => ['D' => ['company' => ['ADDRESS' => ['D' => ['warehouse' => ['__DELETE__' => '1']]]]]]], 'POST', 'company', 'employee', null);
		$this->assertSame(null, $data['R']['AddressPage']['Error']);
		$this->assertArrayHasKey('warehouse', $data['ACCOUNT']['D']['company']['ADDRESS']['D']);
		$data = $this->request('delete', 'warehouse', []);
		$this->assertFalse($data['R']['AddressPage']['Saved']);
		$data = $this->page([], 'POST');
		$this->assertSame(null, $data['R']['AddressPage']['Error']);
		$this->assertSame('Dresden', $data['ACCOUNT']['D']['company']['ADDRESS']['D']['office']['City']);
	}

	#[\PHPUnit\Framework\Attributes\WithoutErrorHandler]
	public function testTemplateRendersSecureFormsAndEscapesValues(): void {
		$row = $this->fields('Bonn');
		$row['FName'] = '<Anna>';
		$this->request('edit', 'warehouse', $row);
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
		$smarty->error_reporting = E_ALL & ~E_WARNING & ~E_NOTICE & ~E_DEPRECATED;
		$smarty->registerPlugin(\Smarty::PLUGIN_MODIFIER, 'strstr', 'strstr');
		$policy = new \Smarty_Security($smarty);
		$policy->php_functions = ['max', 'round', 'hrtime', 'rtrim', 'dirname', 'mail', 'base64_encode', 'mb_convert_encoding', 'hash', 'header', 'json_decode', 'json_encode', 'serialize', 'COUNT', 'file_get_contents', 'substr', 'array_key_exists', 'array_merge_recursive', 'array_diff_key', 'str_pad', 'strtotime', 'date', 'ceil', 'array_keys', 'current', 'count', 'strlen', 'strtolower', 'number_format', 'md5', 'in_array', 'is_array', 'time', 'nl2br', 'print_r', 'array_key_first', 'strpos', 'strrpos', 'str_replace', 'isset', 'empty', 'sizeof', 'trim', 'explode', 'implode'];
		$policy->php_modifiers = ['in_array', 'strlen', 'strstr', 'array_keys', 'count', 'COUNT', 'number_format'];
		$policy->secure_dir = [dirname(__DIR__) . '/system/template', __DIR__ . '/../../core/system/template/include'];
		$smarty->enableSecurity($policy);
		$this->C->set('Smarty', $smarty);
		$language = new LanguageVariable($this->C, $data);
		$language->configure($smarty);
		$smarty->assign('D', $data);
		$template = 'extends:' . dirname(__DIR__) . '/system/template/account__address.tpl|' . __DIR__ . '/../../core/system/template/include/input.tpl';
		$html = $smarty->fetch($template);
		$this->assertStringContainsString('&lt;Anna&gt;', $html);
		$this->assertStringContainsString('Standard-Rechnungsadresse', $html);
		$this->assertStringContainsString('Adresse hinzufügen', $html);
		$this->assertStringNotContainsString('name="D[', $html);
		$this->assertContains('D[ACCOUNT][D][company][ADDRESS][D][__NEW__][City]', $_SESSION['Security']['Map']);
		$this->assertContains('D[ACCOUNT][D][company][ADDRESS][D][office][Active]', $_SESSION['Security']['Map']);
		$this->assertStringContainsString('name="R[Action]"', $html);
		$this->assertStringNotContainsString('D[ADDRESS_ACTION]', serialize($_SESSION['Security']['Map']));
		$security = $this->C['Security'];
		$securePost = [];
		foreach ($this->fields('Leipzig') as $field => $value) {
			$securePost[$security->getSecurityD("D[ACCOUNT][D][company][ADDRESS][D][__NEW__][$field]")] = $value;
		}
		$saved = $this->page($security->resolveSecureData($securePost), 'POST');
		$this->assertTrue($saved['R']['AddressPage']['Saved']);
		$activePath = 'D[ACCOUNT][D][company][ADDRESS][D][office][Active]';
		$saved = $this->page($security->resolveSecureData([$security->getSecurityD($activePath) => '0']), 'POST');
		$this->assertSame(0, (int)$saved['ACCOUNT']['D']['company']['ADDRESS']['D']['office']['Active']);
		$security->SecurityActive = false;
		$htmlWithoutHashing = $smarty->fetch($template);
		$this->assertStringContainsString('name="D[ACCOUNT][D][company][ADDRESS][D][__NEW__][City]"', $htmlWithoutHashing);
		$document = new \DOMDocument();
		$previous = libxml_use_internal_errors(true);
		try {
			$document->loadHTML('<?xml encoding="UTF-8">' . $html);
			$xpath = new \DOMXPath($document);
			$this->assertSame(3, $xpath->query('//*[@data-address-id]')->length);
			$this->assertSame(0, $xpath->query('//form//form')->length);
			$this->assertSame(4, $xpath->query('//input[contains(@id,"-City")][@required]')->length);
			$this->assertSame(3, $xpath->query('//input[@data-address-delete][@disabled]')->length);
			$this->assertSame(3, $xpath->query('//input[@type="checkbox"]')->length);
			$this->assertSame(0, $xpath->query('//input[contains(@name,"ADDRESS_ACTION")]')->length);
		} finally {
			libxml_clear_errors();
			libxml_use_internal_errors($previous);
		}
	}
}

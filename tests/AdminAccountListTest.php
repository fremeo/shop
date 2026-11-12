<?php
namespace fremeo\shop\tests;

use fremeo\core\Container;
use fremeo\core\LanguageVariable;
use fremeo\core\Security;
use fremeo\core\Template;
use phploader\CData;
use PHPUnit\Framework\TestCase;
use Symfony\Component\Filesystem\Filesystem;

class AdminAccountListTest extends TestCase {
	private string $tmp;
	private Container $C;
	private ?string $method;

	protected function setUp(): void {
		$this->tmp = sys_get_temp_dir() . '/fremeo_shop_accounts_' . bin2hex(random_bytes(6));
		$this->method = $_SERVER['REQUEST_METHOD'] ?? null;
		$this->C = new Container();
		$this->C->set('Filesystem', new Filesystem());
		foreach (['shop', 'core'] as $module) {
			$db = new CData(['DB' => ['FILENAME' => $this->tmp . "/$module/data.db", 'FILENAME_C' => $this->tmp . "/$module/cache.db"]]);
			$db->registerPattern(require __DIR__ . '/../../core/system/default/default.global.pattern.php');
			$db->registerPattern(require __DIR__ . "/../../$module/system/default/default.pattern.php");
			$this->C->set('CData', $db, "fremeo/$module");
		}
		$accounts = ['ACCOUNT' => ['D' => [
			'company' => [
				'Active' => 1, 'Name' => 'Firma <A>', 'Number' => '100',
				'USER' => ['D' => ['employee' => ['Active' => 1]]],
				'ADDRESS' => ['D' => ['office' => ['Active' => 1, 'FName' => 'Anna', 'LName' => 'Muster', 'City' => 'Berlin', 'Mail' => 'mail@example.test']]],
				'MEMO' => ['D' => ['list' => ['Active' => 1, 'Name' => 'Liste']]],
				'ORDER' => ['D' => ['order' => ['Active' => 0, 'Number' => 'O-1']]],
			],
			'empty' => [
				'Active' => 1, 'Name' => 'Ohne Bestellung', 'Number' => '200',
				'ADDRESS' => ['D' => ['address' => ['Active' => 1, 'City' => 'Hamburg']]],
				'USER' => ['D' => ['employee' => ['Active' => 1]]],
				'MEMO' => ['D' => ['list' => ['Active' => 1, 'Name' => 'Liste']]],
			],
		]]];
		$this->C['fremeo/shop']['CData']->set_object($accounts);
		$users = ['USER' => ['D' => ['employee' => ['Active' => 1, 'Name' => 'Anna', 'Mail' => 'anna@example.test']]]];
		$this->C['fremeo/core']['CData']->set_object($users);
	}

	protected function tearDown(): void {
		if ($this->method === null) unset($_SERVER['REQUEST_METHOD']);
		else $_SERVER['REQUEST_METHOD'] = $this->method;
		foreach (['shop', 'core'] as $module) unset($this->C["fremeo/$module"]['CData']);
		unset($this->C);
		gc_collect_cycles();
		(new Filesystem())->remove($this->tmp);
	}

	private function page(array $posted = [], string $method = 'GET', array $request = []): array {
		$_SERVER['REQUEST_METHOD'] = $method;
		$C = $this->C;
		$D = ['ACTION' => 'save', 'ACCOUNT' => ['D' => $posted]];
		$R = $request;
		$F = ['PAGE' => []];
		include __DIR__ . '/../system/admin__account.list.php';
		$this->assertSame(['PAGE' => []], $F);
		$D['R'] = $R;
		return $D;
	}

	public function testGetCannotWriteAndLoadsOnlyCurrentPatternData(): void {
		$data = $this->page(['company' => ['Active' => 0, '__DELETE__' => 1]]);
		$this->assertSame('Firma <A>', $data['ACCOUNT']['D']['company']['Name']);
		$this->assertSame('100', $data['ACCOUNT']['D']['company']['Number']);
		$this->assertSame(1, (int)$data['ACCOUNT']['D']['company']['Active']);
		$this->assertCount(1, $data['ACCOUNT']['D']['company']['USER']['D']);
		$this->assertCount(1, $data['ACCOUNT']['D']['company']['MEMO']['D']);
		$this->assertCount(1, $data['ACCOUNT']['D']['company']['ORDER']['D']);
		$this->assertSame([], $data['R']['AccountAdmin']['Errors']);
		$this->assertFalse($data['R']['AccountAdmin']['Saved']);
	}

	public function testPartialActiveChangesPreserveAccountAndOrderData(): void {
		$data = $this->page(['company' => ['Active' => '0']], 'POST');
		$this->assertTrue($data['R']['AccountAdmin']['Saved']);
		$this->assertSame(0, (int)$data['ACCOUNT']['D']['company']['Active']);
		$this->assertSame('Firma <A>', $data['ACCOUNT']['D']['company']['Name']);
		$this->assertSame('O-1', $data['ACCOUNT']['D']['company']['ORDER']['D']['order']['Number']);
		$this->assertSame(1, (int)$data['ACCOUNT']['D']['empty']['Active']);
		$data = $this->page(['company' => ['Active' => 1]], 'POST');
		$this->assertSame(1, (int)$data['ACCOUNT']['D']['company']['Active']);
	}

	public function testDeletionWithOrdersIsRejectedWithoutAnyPartialWrite(): void {
		$data = $this->page(['company' => ['__DELETE__' => 1], 'empty' => ['Active' => 0]], 'POST');
		$this->assertSame(['account_list_error_orders'], $data['R']['AccountAdmin']['Errors']);
		$this->assertFalse($data['R']['AccountAdmin']['Saved']);
		$this->assertSame(1, (int)$data['ACCOUNT']['D']['empty']['Active']);
		$this->assertSame(1, (int)$data['ACCOUNT']['D']['company']['Active']);
	}

	public function testDeletingAccountRemovesChildrenButKeepsCoreUser(): void {
		$data = $this->page(['empty' => ['__DELETE__' => 1]], 'POST');
		$this->assertArrayNotHasKey('empty', $data['ACCOUNT']['D']);
		$this->assertTrue($data['R']['AccountAdmin']['Saved']);
		$filter = ['USER' => []];
		$users = null;
		$this->C['fremeo/core']['CData']->get_object($users, $filter);
		$this->assertSame('Anna', $users['USER']['D']['employee']['Name']);
		// Neu angelegter gleicher Account darf keine verwaisten Kinder zurueckbekommen.
		$account = ['ACCOUNT' => ['D' => ['empty' => ['Active' => 1]]]];
		$this->C['fremeo/shop']['CData']->set_object($account);
		$data = $this->page();
		foreach (['ADDRESS', 'USER', 'MEMO'] as $type) {
			$this->assertEmpty($data['ACCOUNT']['D']['empty'][$type]['D'] ?? []);
		}
	}

	public function testInvalidOrUnexpectedInputDoesNotWrite(): void {
		foreach ([
			['company' => ['Active' => 2]],
			['company' => ['Active' => []]],
			['company' => ['Active' => null]],
			['company' => ['Active' => false]],
			['company' => ['Active' => 1.0]],
			['company' => ['Name' => 'injected']],
			['company' => ['__DELETE__' => []]],
			['invalid/id' => ['Active' => 0]],
			['missing' => ['Active' => 0]],
			['empty' => ['Active' => 0], 'company' => ['Active' => 2]],
		] as $posted) {
			$data = $this->page($posted, 'POST');
			$this->assertNotEmpty($data['R']['AccountAdmin']['Errors']);
			$this->assertFalse($data['R']['AccountAdmin']['Saved']);
			$this->assertSame(1, (int)$data['ACCOUNT']['D']['company']['Active']);
			$this->assertSame(1, (int)$data['ACCOUNT']['D']['empty']['Active']);
			$this->assertArrayNotHasKey('missing', $data['ACCOUNT']['D']);
		}
	}

	public function testEmptyUpdatesDoNotSaveAndZeroIdRemainsValid(): void {
		foreach ([[], ['company' => []], ['company' => ['__DELETE__' => '0']]] as $posted) {
			$data = $this->page($posted, 'POST');
			$this->assertSame([], $data['R']['AccountAdmin']['Errors']);
			$this->assertFalse($data['R']['AccountAdmin']['Saved']);
		}
		$update = ['ACCOUNT' => ['D' => [0 => ['Active' => 1]]]];
		$this->C['fremeo/shop']['CData']->set_object($update);
		$data = $this->page([0 => ['Active' => '0']], 'POST');
		$this->assertTrue($data['R']['AccountAdmin']['Saved']);
		$this->assertSame(0, (int)$data['ACCOUNT']['D'][0]['Active']);
	}

	public function testPagingClampsToLastExistingPage(): void {
		$rows = [];
		for ($i = 0; $i < 55; $i++) $rows["account_$i"] = ['Active' => 1, 'Name' => "Account $i"];
		$update = ['ACCOUNT' => ['D' => $rows]];
		$this->C['fremeo/shop']['CData']->set_object($update);
		$data = $this->page([], 'GET', ['P' => 999]);
		$this->assertSame(2, $data['R']['AccountAdmin']['Page']);
		$this->assertSame(57, $data['R']['AccountAdmin']['Total']);
		$this->assertCount(7, $data['ACCOUNT']['D']);
		$this->assertSame(51, $data['R']['AccountAdmin']['From']);
		$this->assertSame(57, $data['R']['AccountAdmin']['To']);
		$data = $this->page([], 'GET', ['P' => (string)PHP_INT_MAX]);
		$this->assertSame(1, $data['R']['AccountAdmin']['Page']);
	}

	public function testEmptyListAndInvalidExistingIdsAreHandledWithoutWrites(): void {
		$update = ['ACCOUNT' => ['D' => ['company' => '__DELETE__', 'empty' => '__DELETE__']]];
		$this->C['fremeo/shop']['CData']->set_object($update);
		$data = $this->page();
		$this->assertEmpty($data['ACCOUNT']['D'] ?? []);
		$this->assertSame(0, $data['R']['AccountAdmin']['Total']);
		$this->assertSame(0, $data['R']['AccountAdmin']['From']);
		$this->assertSame(0, $data['R']['AccountAdmin']['To']);
		$update = ['ACCOUNT' => ['D' => ['' => ['Name' => 'Legacy']]]];
		$this->C['fremeo/shop']['CData']->set_object($update);
		$data = $this->page();
		$this->assertSame(['' => true], $data['R']['AccountAdmin']['InvalidIds']);
	}

	#[\PHPUnit\Framework\Attributes\WithoutErrorHandler]
	public function testTemplateUsesTranslationsSecureControlsAndOrderAwareActions(): void {
		$data = $this->page();
		$security = new Security();
		$security->SecurityActive = true;
		$this->C->set('Security', $security);
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
		$template = 'extends:' . dirname(__DIR__) . '/system/template/admin__account.list.tpl|'
			. __DIR__ . '/../../core/system/template/include/input.tpl';
		$html = $smarty->fetch($template);
		$previous = libxml_use_internal_errors(true);
		try {
			$document = new \DOMDocument();
			$document->loadHTML('<?xml encoding="UTF-8">' . $html);
			$xpath = new \DOMXPath($document);
			$this->assertSame(1, $xpath->query('//form[@id="accountListForm"]')->length);
			$this->assertSame(1, $xpath->query('//button[@form="accountListForm"][@type="submit"]')->length);
			$this->assertSame(0, $xpath->query('//form//button[@type="submit"]')->length);
			$this->assertSame(0, $xpath->query('//tr[@data-account-id="company"]//input[@data-account-delete]')->length);
			$this->assertSame(1, $xpath->query('//tr[@data-account-id="empty"]//input[@data-account-delete][@disabled]')->length);
			$this->assertSame(2, $xpath->query('//a[contains(@href,"admin__account.edit")]//i[contains(@class,"fa-pen")]')->length);
			$this->assertSame(0, $xpath->query('//input[starts-with(@name,"D[")]')->length);
			$this->assertStringContainsString('Firma &lt;A&gt;', $html);
			$this->assertStringContainsString('Kundennummer', $html);
			$this->assertStringNotContainsString('CustomerGroupId', $html);
			$this->assertStringContainsString('admin__account.edit&amp;R[Id]=company', $html);
			$this->assertStringNotContainsString('Zum Deaktivieren den Aktiv-Haken', $html);
			$this->assertStringNotContainsString('Bestandsdaten müssen gesondert geprüft werden', $html);
			$this->assertContains('D[ACCOUNT][D][empty][__DELETE__]', $_SESSION['Security']['Map']);
			$this->assertContains('D[ACTION]', $_SESSION['Security']['Map']);
		} finally {
			libxml_clear_errors();
			libxml_use_internal_errors($previous);
			$smarty->clearAllAssign();
			unset($language, $smarty);
		}
	}
}

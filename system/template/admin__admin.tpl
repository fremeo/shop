{block name="sidebar" append}
	<li class="nav-item">
		<a class="nav-link" data-bs-toggle="collapse" href="#shop_submenu0" aria-expanded="false"><i class="far fa-file-alt"></i><span> Shop</span></a>
		<div class="collapse ps-3" id="shop_submenu0">
			<ul class="nav flex-column">
				
				<li class="nav-item">
					<a class="nav-link " data-bs-toggle="collapse" href="#shop_submenu10" aria-expanded="false">
						<i class="fas fa-box"></i><span> Artikel</span>
					</a>
					<div class="collapse ps-3" id="shop_submenu10">
						<ul class="nav flex-column">
							<li class="nav-item"><a class="nav-link" href="?R[Page]=admin__attribute.list&R[ModuleId]=papp/shop#shop_submenu10"><i class="fas fa-th"></i> Attribute</a></li>
							<li class="nav-item"><a class="nav-link" href="?R[Page]=admin__article.list&R[ModuleId]=papp/shop#shop_submenu10"><i class="fas fa-box"></i> Article</a></li>
						</ul>
					</div>
				</li>

				<li class="nav-item">
					<a class="nav-link" data-bs-toggle="collapse" href="#shop_submenu00" aria-expanded="false"><i class="far fa-file-alt"></i><span> Bestellungen</span></a>
					<div class="collapse ps-3" id="shop_submenu00">
						<ul class="nav flex-column">
							<li class="nav-item"><a class="nav-link" href="?R[Page]=admin__order.list&R[ModuleId]=papp/shop#shop_submenu00"><i class="fas fa-clipboard"></i> Bestellungen</a></li>
						</ul>
					</div>
				</li>

			</ul>
		</div>
	</li>
{/block}

{block name="sidebar_system" append}
	<li class="nav-item">
		<a class="nav-link" data-bs-toggle="collapse" href="#shop_submenu4" aria-expanded="false">
			<i class="fas fa-user"></i><span> Shop</span>
		</a>
		<div class="collapse ps-3" id="shop_submenu4">
			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link" href="?R[Page]=admin__shipping.list&R[ModuleId]=papp/shop#shop_submenu4"><i class="fas fa-shipping-fast"></i> Versandarten</a></li>
				<li class="nav-item"><a class="nav-link" href="?R[Page]=admin__payment.list&R[ModuleId]=papp/shop#shop_submenu4"><i class="far fa-money-bill-alt"></i> Zahlungsarten</a></li>
			</ul>
		</div>
	</li>
{/block}
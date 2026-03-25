
{block name="user.register_form_bodyX" prepend}
		<div class="col col-md-4 col-12">
			<div class="h3">Kundendaten</div>
		</div>
		<div class="col col-md-8">
		
			<div class="mb-3">
				<div class="row">
					<div class="col">
						{input p=['placeholder' => 'Vorname','required' => 1]}
					</div>
					<div class="col">
						{input p=['placeholder' => 'Nachname','required' => 1]}
					</div>
				</div>
			</div>
			
			<div class="mb-3">
				<div class="row">
					<div class="col">
						{input p=['placeholder' => 'Firmenname']}
					</div>
					<div class="col">
						{input p=['placeholder' => 'UstID']}
					</div>
				</div>
			</div>
		
		
			<div class="mb-3">
				<div class="row">
					<div class="col">
						{input p=['placeholder' => 'Straße','required' => 1]}
					</div>
					<div class="col">
						{input p=['placeholder' => 'Hausnummer','required' => 1]}
					</div>
				</div>
			</div>

			<div class="mb-3">
			{input p=['type'=>'select', 'placeholder' => 'Land','required' => 1]}
			</div>
			
			<div class="mb-3">
				<div class="row">
					<div class="col">
						{input p=['placeholder' => 'PLZ','required' => 1]}
					</div>
					<div class="col">
						{input p=['placeholder' => 'Ort','required' => 1]}
					</div>
				</div>
			</div>
			
			<div class="mb-3">
			{input p=['placeholder' => 'Telefonnummer']}
			</div>
			
		</div>
{/block}

{block name="body" prepend}
<div class="row">
	<div class="col-6">
		<form method="post">
			<h2>Login: Ich bin bereits Kunde</h2>
			<input name="D[Action]" type="hidden" value="login">
			<div class="form-floating mb-2">
			{input p=[ 'name'=>'D[_Login][Mail]', 'value' => $D._Login.Mail]}
				<label>E-Mail</label>
			</div>
			<div class="form-floating mb-2">
			{input p=[ 'name'=>'D[_Login][Password]']}
				<label>Passwort</label>
			</div>
			
			
			<button class="btn btn-success" type="sbumit">Login</button>
		</form>
	</div>
	<div class="col-6">
		<form method="post">
			<h2>Registrieren: Ich bin ein Neukunde</h2>
			<input name="D[Action]" type="hidden" value="register">
			
			<div class="form-floating mb-2">
				{input p=[ 'name'=>'D[_Login][Company]', 'value' => $D._Login.Company]}
				<label>Firma</label>
			</div>
			<div class="row">
				<div class="col-md">
					<div class="form-floating mb-2">
						{input p=[ 'name'=>'D[_Login][FName]', 'required' => 1, 'value' => $D._Login.FName]}
						<label>Vorname</label>
					</div>
				</div>
				<div class="col-md">
					<div class="form-floating mb-2">
						{input p=[ 'name'=>'D[_Login][LName]', 'required' => 1, 'value' => $D._Login.LName]}
						<label>Nachname</label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-9">
					<div class="form-floating mb-2">
						{input p=[ 'name'=>'D[_Login][Street]', 'required' => 1, 'value' => $D._Login.Street]}
						<label>Straße</label>
					</div>
				</div>
				<div class="col-md-3">
					<div class="form-floating mb-2">
						{input p=[ 'name'=>'D[_Login][HNumber]', 'required' => 1, 'value' => $D._Login.HNumber]}
						<label>Nr</label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<div class="form-floating mb-2">
						{input p=[ 'name'=>'D[_Login][Postcode]', 'required' => 1, 'value' => $D._Login.Postcode]}
						<label>Plz</label>
					</div>
				</div>
				<div class="col-md-9">
					<div class="form-floating mb-2">
						{input p=[  'name'=>'D[_Login][City]', 'required' => 1, 'value' => $D._Login.City]}
						<label>Ort</label>
					</div>
				</div>
			</div>
			<div class="form-floating mb-2">
				{input p=['name'=>'D[_Login][CountryId]', 'required' => 1, 'type' => 'select', 'option' => ['DE|Deutschland'], 'value' => $D._Login.CountryId]}
				<label>Land</label>
			</div>
			<div class="row">
				<div class="col-md-6">
					<div class="form-floating mb-2">
						{input p=[ 'name'=>'D[_Login][Mail]', 'required' => 1, 'value' => $D._Login.Mail]}
						<label>E-Mail</label>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-floating mb-2">
						{input p=[ 'name'=>'D[_Login][Telephone]', 'value' => $D._Login.Telephone]}
						<label>Telefon (optional)</label>
					</div>
				</div>
			</div>
			
			
			

			<div class="form-floating mb-2">
				{input p=[ 'name'=>'D[_Login][Password]']}
				<label>Passwort</label>
			</div>

			<button class="btn btn-success" type="sbumit">Registrieren</button>
		</form>
	</div>
</div>
{/block}
<?php
return [
	'ATTRIBUTE_SET' => [
		'Active' => ['Type' => 'checkbox'],
		'D' => [
			'LANGUAGE' => [
				'Title' => ['Type' => 'text'],
			],
			'ATTRIBUTE_GROUP' => [
				'Active' => ['Type' => 'checkbox'],
				'CustomerGroup' => ['Type' => 'multiselect'],
				'D' => [
					'LANGUAGE' => [
						'Title' => ['Type' => 'text'],
					],
					'ATTRIBUTE' => ['D' => ['PROPERTY' => [
						'Active' => ['Type' => 'checkbox'],
						'Required' => ['Type' => 'checkbox'],
						'Enum' => ['Type' => 'json'],
						'EnumState' => ['Type' => 'text', 'Enum' => ['prepend', 'append', 'overwrite']],
						'D' => ['LANGUAGE' => [
							'Enum' => ['Type' => 'json'],
						]],
					]]],
				],
			],
		],
	],
	'ATTRIBUTE' => [
		'Active' => ['Type' => 'checkbox'],
		'Sort' => ['Type' => 'number'],
		'Type' => ['Type' => 'text'],
		'I18n' => ['Type' => 'checkbox'],
		'Enum' => ['Type' => 'json'],
		'D' => [
			'PROPERTY' => [
				'Active' => ['Type' => 'checkbox'],
				'Sort' => ['Type' => 'number'],
				'Type' => ['Type' => 'text'],
				'I18n' => ['Type' => 'checkbox'],
				'Enum' => ['Type' => 'json'],
				'D' => ['LANGUAGE' => [
					'Title' => ['Type' => 'text'],
					'Description' => ['Type' => 'text'],
					'Enum' => ['Type' => 'json'],
				]],
			],
			'LANGUAGE' => [
				'Title' => ['Type' => 'text'],
				'Description' => ['Type' => 'text'],
				'Enum' => ['Type' => 'json'],
			],
		],
	],
	'ARTICLE' => [
		'Active' => ['Type' => 'checkbox'],
		'ParentId' => ['Type' => 'id', 'ForeignKey' => 1],
		'D' => [
			'STOCK' => [
				'Active' => ['Type' => 'checkbox'],
				'WAREHOUSE' => ['Type' => 'id'],
				'Stock' => ['Type' => 'number'],
			],
			'CUSTOMERGROUP' => [
				'Active' => ['Type' => 'checkbox'],
				'Value' => ['Type' => 'text'],
				'D' => ['ATTRIBUTE' => ['D' => ['ITEM' => ['D' => ['PROPERTY' => [
					'Active' => ['Type' => 'checkbox'],
					'Value' => ['Type' => 'text'],
				]]]]]],
			],
			'ATTRIBUTE' => [
				'Active' => ['Type' => 'checkbox'],
				'Value' => ['Type' => 'text'],
				'D' => [
					'ITEM' => ['D' => ['PROPERTY' => [
						'Active' => ['Type' => 'checkbox'],
						'Value' => ['Type' => 'text'],
						'D' => ['LANGUAGE' => [
							'Value' => ['Type' => 'text'],
						]],
					]]],
					'LANGUAGE' => [
						'Value' => ['Type' => 'text'],
					],
				],
			],
		],
	],
	'ACCOUNT' => [
		'Active' => ['Type' => 'checkbox'],
		'Name' => ['Type' => 'text'],
		'Number' => ['Type' => 'text'],
		'D' => [
		'USER' => [
			'Active' => ['Type' => 'checkbox'],
		],
		'ADDRESS' => [
			'Active' => ['Type' => 'checkbox'],
			'FName' => ['Type' => 'text'],
			'LName' => ['Type' => 'text'],
			'Street' => ['Type' => 'text'],
			'HNumber' => ['Type' => 'text'],
			'Postcode' => ['Type' => 'text'],
			'City' => ['Type' => 'text'],
			'CountryId' => ['Type' => 'id'],
			'Phone' => ['Type' => 'text'],
			'Mail' => ['Type' => 'text'],
		],
		'MEMO' => [
			'Active' => ['Type' => 'checkbox'],
			'Name' => ['Type' => 'text'],
			'D' => ['ARTICLE' => [
				'Active' => ['Type' => 'checkbox'],
				'Quantity' => ['Type' => 'number']
			]],
		],
		'ORDER' => [
			'Active' => ['Type' => 'checkbox'],
			'CustomerId' => ['Type' => 'id'],
			'Number' => ['Type' => 'text'],
			'DateTime' => ['Type' => 'text'],
			'PaymentId' => ['Type' => 'id'],
			'FName' => ['Type' => 'text'],
			'LName' => ['Type' => 'text'],
			'Street' => ['Type' => 'text'],
			'HNumber' => ['Type' => 'text'],
			'Postcode' => ['Type' => 'text'],
			'City' => ['Type' => 'text'],
			'CountryId' => ['Type' => 'id'],
			'Phone' => ['Type' => 'text'],
			'Mail' => ['Type' => 'text'],
			'D' => [
				'ARTICLE' => [
					'Active' => ['Type' => 'checkbox'],
					'Number' => ['Type' => 'text'],
					'Title' => ['Type' => 'text'],
					'Stock' => ['Type' => 'text'],
					'Price' => ['Type' => 'text'],
				],
				'DELIVERY' => [
					'Active' => ['Type' => 'checkbox'],
					'FName' => ['Type' => 'text'],
					'LName' => ['Type' => 'text'],
					'Street' => ['Type' => 'text'],
					'HNumber' => ['Type' => 'text'],
					'Postcode' => ['Type' => 'text'],
					'City' => ['Type' => 'text'],
					'CountryId' => ['Type' => 'id'],
					'Phone' => ['Type' => 'text'],
					'Mail' => ['Type' => 'text'],
					'ShippingId' => ['Type' => 'id'],
					'Status' => ['Type' => 'text'],
					'ShippedDate' => ['Type' => 'text'],
					'TrackingNumber' => ['Type' => 'text'],
					'D' => ['ARTICLE' => [
						'Active' => ['Type' => 'checkbox'],
						'Number' => ['Type' => 'text'],
						'Title' => ['Type' => 'text'],
						'Stock' => ['Type' => 'text'],
						'Weight' => ['Type' => 'text'],
					]],
				],
			],
		],
		],
	],
];

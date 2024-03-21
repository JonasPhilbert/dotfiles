function getCountry() {
	var countries = {
		GB: "United Kingdom",
		US: "United States of America"
	};
	var timezones = {
		"America/Adak": {
			u: -600,
			d: -540,
			c: ["US"]
		},
		"America/Anchorage": {
			u: -540,
			d: -480,
			c: ["US"]
		},
		"America/Boise": {
			u: -420,
			d: -360,
			c: ["US"]
		},
		"America/Chicago": {
			u: -360,
			d: -300,
			c: ["US"]
		},
		"America/Denver": {
			u: -420,
			d: -360,
			c: ["US"]
		},
		"America/Detroit": {
			u: -300,
			d: -240,
			c: ["US"]
		},
		"America/Indiana/Indianapolis": {
			u: -300,
			d: -240,
			c: ["US"]
		},
		"America/Indiana/Knox": {
			u: -360,
			d: -300,
			c: ["US"]
		},
		"America/Indiana/Marengo": {
			u: -300,
			d: -240,
			c: ["US"]
		},
		"America/Indiana/Petersburg": {
			u: -300,
			d: -240,
			c: ["US"]
		},
		"America/Indiana/Tell_City": {
			u: -360,
			d: -300,
			c: ["US"]
		},
		"America/Indiana/Vevay": {
			u: -300,
			d: -240,
			c: ["US"]
		},
		"America/Indiana/Vincennes": {
			u: -300,
			d: -240,
			c: ["US"]
		},
		"America/Indiana/Winamac": {
			u: -300,
			d: -240,
			c: ["US"]
		},
		"America/Juneau": {
			u: -540,
			d: -480,
			c: ["US"]
		},
		"America/Kentucky/Louisville": {
			u: -300,
			d: -240,
			c: ["US"]
		},
		"America/Kentucky/Monticello": {
			u: -300,
			d: -240,
			c: ["US"]
		},
		"America/Los_Angeles": {
			u: -480,
			d: -420,
			c: ["US"]
		},
		"America/Menominee": {
			u: -360,
			d: -300,
			c: ["US"]
		},
		"America/Metlakatla": {
			u: -540,
			d: -480,
			c: ["US"]
		},
		"America/New_York": {
			u: -300,
			d: -240,
			c: ["US"]
		},
		"America/Nome": {
			u: -540,
			d: -480,
			c: ["US"]
		},
		"America/North_Dakota/Beulah": {
			u: -360,
			d: -300,
			c: ["US"]
		},
		"America/North_Dakota/Center": {
			u: -360,
			d: -300,
			c: ["US"]
		},
		"America/North_Dakota/New_Salem": {
			u: -360,
			d: -300,
			c: ["US"]
		},
		"America/Phoenix": {
			u: -420,
			c: ["US", "CA"]
		},
		"America/Sitka": {
			u: -540,
			d: -480,
			c: ["US"]
		},
		"America/Yakutat": {
			u: -540,
			d: -480,
			c: ["US"]
		},
		"Europe/Belfast": {
			a: "Europe/London",
			c: ["GB"],
			r: 1
		},
		"Europe/London": {
			u: 0,
			d: 60,
			c: ["GB", "GG", "IM", "JE"]
		},
		GB: {
			a: "Europe/London",
			c: ["GB"],
			r: 1
		},
		"GB-Eire": {
			a: "Europe/London",
			c: ["GB"],
			r: 1
		},
		"Pacific/Honolulu": {
			u: -600,
			c: ["US", "UM"]
		},
		"US/Alaska": {
			a: "America/Anchorage",
			r: 1
		},
		"US/Aleutian": {
			a: "America/Adak",
			r: 1
		},
		"US/Arizona": {
			a: "America/Phoenix",
			c: ["US"],
			r: 1
		},
		"US/Central": {
			a: "America/Chicago",
			r: 1
		},
		"US/East-Indiana": {
			a: "America/Indiana/Indianapolis",
			r: 1
		},
		"US/Eastern": {
			a: "America/New_York",
			r: 1
		},
		"US/Hawaii": {
			a: "Pacific/Honolulu",
			c: ["US"],
			r: 1
		},
		"US/Indiana-Starke": {
			a: "America/Indiana/Knox",
			r: 1
		},
		"US/Michigan": {
			a: "America/Detroit",
			r: 1
		},
		"US/Mountain": {
			a: "America/Denver",
			r: 1
		},
		"US/Pacific": {
			a: "America/Los_Angeles",
			r: 1
		},
		"US/Samoa": {
			a: "Pacific/Pago_Pago",
			c: ["WS"],
			r: 1
		}
	};

	const timezone = Intl.DateTimeFormat().resolvedOptions().timeZone;
	if (timezone === "" || !timezone) {
		return null;
	}

	const country = timezones[timezone]?.c[0];
  return country;
}
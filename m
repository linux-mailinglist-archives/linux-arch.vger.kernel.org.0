Return-Path: <linux-arch+bounces-12883-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FB7B0CAF9
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 21:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3495A4E5C71
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 19:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6173B1F418E;
	Mon, 21 Jul 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EYEOmTrq"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010022.outbound.protection.outlook.com [52.103.12.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5BBA36;
	Mon, 21 Jul 2025 19:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753126248; cv=fail; b=qWVMn+ql0ONtIfeEuFr+qyWXw+lo9Z4jX3M5jnAv1kq5sPWfHrwtiLuKMYSVwZu7tqq0ux+8rviCAzDDsGX+OvEXgCFswSMjPHQ775rovRP5+ByXMKp+pPdVLj4l4TNqn766wLmUvolpNOg2/5jkSzHzBCE3wOsqiWDgVBZyu2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753126248; c=relaxed/simple;
	bh=ePtnuutXgl1rqpgn2cwSjOSkIrNwh/9WKnu1BJENgjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CgwashlfmX+XGFJZorBSeGzoj5gtXvCXzfeXdiN3V6Fa5rlPQC4+P6cKJSYOyyEzc2MQZxuD2hyjgnFvGrfpEomkNLfJ/zlIlokDQ7WpEl/tJntZOXpCXAoAVxbSi0xtSnOs6RQLV9qTSAqMWDZld+Czwl7QKqvKTOtM7CoiKsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EYEOmTrq; arc=fail smtp.client-ip=52.103.12.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUqOvGE85R9vxVS0J2AkE8zO0eln/0odjQzo0C4jCFObJsPhaZv5P4nu35diSetUQKbT8meptLphD4pfWgyjWVCwoIDFLuKTKbRG6ZcVvcI31ESdTh8hk9RDtNj8dHpYdpJxWwzG1VYKJcBhSLZ440yVQ6U9qPk5Cg0juDHFWkUjFpWln8CehiY4LDiDj7GYq/TD3jOfYDptUwtQABtZb/enhH21sadJGjFCzInoYSIyqCvfm8ZlPiXdVvv7K1jGRclRySXCHlCSzsSjo2vNwqNL+nNhKSHFjXiIfWtS84vga16ZJvQx9NBUztmsBQ78wN5Ejg3dCET9TArz6/82Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePtnuutXgl1rqpgn2cwSjOSkIrNwh/9WKnu1BJENgjA=;
 b=SqTjimCHtD/qAJHlRHp90dSbfxiol9qu8lzrTcUCsnxrbF++VJ+IGcQgGrqdJfCc9KMka8UA7GzQaupJH5wVfQl2rYxBRkst/TliuRu4unFFYLvANHiSxH0diiNGwzF2KLaQtiRj78kRSQZ08KXBsysqZ59yniq5gIK/dKasbjH8EY8ON1hVFAXiqNsINe8AHhbWHaafVaZj9HyYtVnszOhsAAgf3wxfPp2eqojPQr5qU88URAVXT9zKpC7+3JFo3wuYYgjvYXZxY4APH3gLnOqru2r7AopBlDVgBMUe3uxgik8gFTRBvbW+v8G0yLWnbb4lQh5cM1KPUjV484RV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePtnuutXgl1rqpgn2cwSjOSkIrNwh/9WKnu1BJENgjA=;
 b=EYEOmTrq3Eyb9fFt3KIjHtsfUuGrUdJ98YnQM/lgTmdzrA56O41o6AsSu7dV4RDSXb+Lgrartg50Z90mJZSR0PToD8saMAfPyQDd5IyQKhDJudZ83kKbY7nklFsWPoRVmZ8qgOSQdHHrVUGzkUfeMz6FUo7bsJ4WkgxyqEl92XeTuLprQpYEMA9YtT5l+nGoomo6SwuOFQCoXw6nOG5UZzkmEyIgMPjtZlWijCX0CiYF6WzKT5RdKkx0CCBnKDT2V2+YghmGKATJlnaFne9XRkcnofOUQFmAB6DihMG5GzhNslTsMFVBII6nTT8VLt9D+Bm7AlCkzDanPXcSWl+RoQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7076.namprd02.prod.outlook.com (2603:10b6:a03:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 19:30:43 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 19:30:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, Easwar Hariharan
	<eahariha@linux.microsoft.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, Naman Jain <namjain@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "x86@kernel.org"
	<x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v4 0/7] hyperv: Introduce new way to manage hypercall args
Thread-Topic: [PATCH v4 0/7] hyperv: Introduce new way to manage hypercall
 args
Thread-Index:
 AQHb96BLaxI7ZKQtcEykvxaiGfmaJ7Q4FA6AgAAJxBCAADcfgIAAURsAgAMyUgCAAP5XAIAAIJcA
Date: Mon, 21 Jul 2025 19:30:42 +0000
Message-ID:
 <SN6PR02MB4157F92B7DB9369F23D2F35FD45DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <c5d4d351-a7ff-4762-8bb3-61554d4f9731@linux.microsoft.com>
 <SN6PR02MB41570625E2F061C5E494C7F4D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <43f8be57-a330-455f-8f9e-f5718ff1aa1a@linux.microsoft.com>
 <ed1e8508-7085-4620-af25-3a8795c1afe8@linux.microsoft.com>
 <SN6PR02MB4157A2A90910918AE9B6327BD45DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <5264d73d-ae1b-4173-b304-b92e18a3befb@linux.microsoft.com>
In-Reply-To: <5264d73d-ae1b-4173-b304-b92e18a3befb@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7076:EE_
x-ms-office365-filtering-correlation-id: fb422a9f-790e-42dc-3adc-08ddc88d1524
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTlVRVpOMzlyOGNZWmwra0RseFlUakUvTlR5Y1AydkxXbUNjYjBSd0NaelMx?=
 =?utf-8?B?bmRRUUxuV1ZNOEUycDRwbDlaYitvekphSGJkVW9vM0hyUExzRkdDd2lJck9h?=
 =?utf-8?B?clRIcDBSbXJaR3FXUVZleGFjV0RCaDBUcGJ2OE5qd2daRGV5YXVYTm45UG5n?=
 =?utf-8?B?SXFNRHNJSXhtTWFzT21zTlZUV09HRVdNUVdORkV4M3dobWg5QzB0S2p4eHJE?=
 =?utf-8?B?SEQzN1hOa29tc3Zwd28xNE5GLzRuTUZSd0NkNGw5Tng4YUZCOHpoSlBydnV2?=
 =?utf-8?B?dU5mazhrb1JsUlFPdnlNM0kvaWhoTjFCaFB2TlIzTTZ3WmFWVUt4N1VSYWE0?=
 =?utf-8?B?STA3cVYwVy9RWnNpUktxOWtySytvUmV6RVpLSjFGd2lOcFpKcExYNVh0alEv?=
 =?utf-8?B?Z2pKNTZCRHZ0L2p1ZTFmMi9TL1YrNUZsYStrRXp4Zm9vdGF2VnQ2TC9BOEha?=
 =?utf-8?B?Mkc1SnFvM0gyUlBWakZIMER5ME5nZVo2aE95bVdJSWNZZ0piM1dBNVVqVmhR?=
 =?utf-8?B?S0lpRUlscVBjc09xYnZiclUraUNOZllQMldXOFZNTWlzK1h4OUIreVpwTXVz?=
 =?utf-8?B?SENwbGlmR3k0a3VUUkFSMVVSTkJKalF1eVd2OW1nTlh3UmJIdkUzb3BHQjl0?=
 =?utf-8?B?NDRqNGxTRU9VeDFzZWNjUWRITFdSeGw3Y2VlY3MzOXU5Y3ZDdGEvK29ldFVV?=
 =?utf-8?B?dGgxc1hzUHlMeTYzK3Z2SUtyamltL2N3RlRhb3FjakNhUkE2YnMxSWh1QU16?=
 =?utf-8?B?R0t1MnloSUI2bWwycmJBdFp6bWlCK2VRTGozb1YzUWV1YzlWaWtjcGFwQU9i?=
 =?utf-8?B?OXJzQ2NRN2k4ZmhseVJoMlhlN2lKTzJZc0FJeUJWM09oaStpOVRMdldlOHdK?=
 =?utf-8?B?N2hFUTVKN2s2OGt2NW56SEE5bHgrYnQ3SHkvb29jTDl0TFQ3Tng1UnBobjI2?=
 =?utf-8?B?VDEvMmRiZVJEMGtMRGVZMUIzV253TUV4Wk0vY1dEV0E0T3ZJbkFNSW9YRGFa?=
 =?utf-8?B?aGhwV2p3ZjhDQ2c4TjNub1RMWjY1Zk9sdGVaK1FvM2lvTjhHbERkTlFYWjVI?=
 =?utf-8?B?L1JDU09ncmp6UkZFd1dOcmw2WTlFZCtHNVgwMUxSWk9oV3IzVElOWXdZZDVl?=
 =?utf-8?B?REtCZGQyQmlxNWp2V1Q0Y0llbVZZZW9HR2pxczA0Nis3Y0ZnMS9uRWV1YVo4?=
 =?utf-8?B?OFp4dlVrQ3h6N1JWZmt1SnRGYmQyaUIycWtpVTNFL0dZTGJyMy9zRnVmdHRi?=
 =?utf-8?B?ZFZjZDdBODZPYVhuWjJXUzRKMG0xWEZzaEpPWEdheU9XTnlXTi9pZHVMUmNN?=
 =?utf-8?B?VWFwRmFCdkd6cTk0c2JtanFMelR4ZStRZFczTFdTWFJBLyt1dlhqYUdnNW9C?=
 =?utf-8?B?WmxSZWJMMUkrRGc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUVCdEZOa0FscTYzNHFMbGxwV0ZXU01uZEt5bnoyVEluTmFSZldicklyOUhJ?=
 =?utf-8?B?TnFtb3NtUmM2NXoxb1NhWHU5b21ucCt0NFJLMzI1Q3ZkbjhQNEdnbTRtcjdJ?=
 =?utf-8?B?RlIzYmcwSWJ4aGFWNGJtb1hGUEoxcGpaRTFRdVJlSjdpTzFrYjF4dE1uMThZ?=
 =?utf-8?B?MS82L1lEQm5KS05YWHJuaUwvR1Vlb2VRTW9qSkRMb2RIdHV5Y1daUXZIY0xx?=
 =?utf-8?B?N0VSaFY5VnF4THg5V3VQc0xqV0xmL09BWjdoSGl6TmRLMjh3RUpzbG5qNTVs?=
 =?utf-8?B?NGVpeXpHaTFrN0FGd09ML0JQOUZHN3EvYkN5Zko0OVJwbjIzNTFKYzFEd005?=
 =?utf-8?B?cDRVS3UwNjl2akc5QTVRV0NmS1NrbmdiSGhKV3NBWVRVZVJ6U21oOHRwdXBV?=
 =?utf-8?B?am5sdWpTanNJYXRtN2tJNkJXbi9aaWd0a0RQTVlsUWZ6N1F5NEZrcVNoa2dT?=
 =?utf-8?B?SEI3YlpzMTAyZzU2NmtMSWZVYWJLMllucmFKbHk0RUFkYllaNjgxWHRsaVlB?=
 =?utf-8?B?SkhicHR2VzdJU011T1VQWjBVcmhEMnJHdHNFVzZ1djlhdW1vZHJRVzVCSFBO?=
 =?utf-8?B?REtmMDAvRk9UemNQMjgwOVRUZ1JtMC9EMGJaRHY4eFpMTmhXZS9ncFdRQnZk?=
 =?utf-8?B?M2tRSFJ5SExaeWxiV1dkUS9WcU4xblRqcUZIZUU2bTFNc3kwN1BUVi93MjFM?=
 =?utf-8?B?cFZwMlVua2t0WW1ySjRVTFhjRmhoSkpNa0pmZFNVZW5maG52ek9jT1dRaUZt?=
 =?utf-8?B?Vkd6bEU3dWRZTU54TDM0Mmp5M1dlZXhCQ1o2c2pRYlNybDNLbzh2WUpFcVJ3?=
 =?utf-8?B?bnMyWFpBTW5Ga1kwQyt3dGZKc3hNbUxHb1lVdHBmTTE0eHFhSjZlYm14OGlC?=
 =?utf-8?B?NXlMSVRvL3ZVSkl0OVo2bVZTVmZZRExkRlNEdEFwQjZLUG9Bd2NrczZIcERR?=
 =?utf-8?B?b3B0Sm5JdllRQStWVjR4dTVLaldHblcyNGFnVW5FQzNFYkxPRVo5YTJxclRS?=
 =?utf-8?B?NjAxQkw4WWltMGxTL0Rhd3FnWDJVY3NUdCtHdmNHMkZLV0FyNGZMWTc1b3lp?=
 =?utf-8?B?UkRtbDlTaTJ6MG5ieERocldaWm1GWkJ4YUU2L2VYMDlMcnVXOXVmSy8rZitK?=
 =?utf-8?B?TVoyb21rU2xCdGNJYThERzEzNnQ3bW42Z0ZOR01sVkNwWjhESlA3dDdTdFlK?=
 =?utf-8?B?eUpyYVRJMFpaSXFCWDkxb0pEWGNTOHhOWlF4WFFOZ1R3blUySDUvVVBxajFX?=
 =?utf-8?B?OEJ2ekFySUJDMnRUdHo1dDI3TmhNQklUeWJCYTBNZ1luUFV0TUhrTFlJUHlt?=
 =?utf-8?B?cXlYazlhQ0MwYy8rbyt2Q3dPS3V2SVdIcHdYei9ncEtweDJ5WGY1TTQ4Z1JH?=
 =?utf-8?B?VUhwS1lsU2FaSXRPV3BvTFQwZGNRektEY3ZReGhBVEhHSEJCajFSYXBYYXZR?=
 =?utf-8?B?bmpHaUg4RmhGRVFEcldWOVlsWFE1NTAyNWE4eVg0NDd1cWJic3VCNTVZcFp6?=
 =?utf-8?B?VEM5R3VBZXB5cUZOR3NuWnZ1M3AyR3FiZXpiT1RER2lRV01yc2FvTHgvRHJx?=
 =?utf-8?B?N3FlM0hRVTVoSjQrOGZ6MS9ybFRUL3dYVWo0cjgzbTdxQmxyVWVCQmJveDNC?=
 =?utf-8?Q?fVol+waM33DPhmFzXt917g7LlokMnyhjTO00VYzgu7C4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fb422a9f-790e-42dc-3adc-08ddc88d1524
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 19:30:42.6932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7076

RnJvbTogUm9tYW4gS2lzZWwgPHJvbWFua0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIEp1bHkgMjEsIDIwMjUgMTA6MTUgQU0NCj4gDQo+IE9uIDcvMjAvMjAyNSA3OjE5IFBNLCBN
aWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBSb21hbiBLaXNlbCA8cm9tYW5rQGxpbnV4
Lm1pY3Jvc29mdC5jb20+IFNlbnQ6IEZyaWRheSwgSnVseSAxOCwgMjAyNSA2OjE2DQo+IFBNDQo+
IA0KPiBbLi4uXQ0KPiANCj4gPg0KPiA+IFRoYW5rcyBmb3IgYW55IHRlc3RpbmcgeW91IGNhbiBk
byBvbiBzdGFuZGFsb25lIHRlc3QgbWFjaGluZXMgd2l0aG91dA0KPiA+IG5lZWRpbmcgdGVzdCBj
bHVzdGVycyBpbiBBenVyZS4gSXQgd2lsbCBiZSBoYXJkIHRvIGdldCB0ZXN0IGNvdmVyYWdlIG9u
DQo+ID4gKmV2ZXJ5KiBoeXBlcmNhbGwgY2FsbCBzaXRlIHRoYXQgaXMgbW9kaWZpZWQgYnkgdGhl
IHBhdGNoIHNldCwgYnV0IGRvaW5nDQo+ID4gYmFzaWMgc21va2UgdGVzdGluZyBvZiBydW5uaW5n
IGluIHRoZSByb290IHBhcnRpdGlvbiBhbmQgaW4gVlRMMiB3aWxsDQo+ID4gY292ZXIgbW9yZSB0
aGFuIEkgY2FuIGNvdmVyIHJ1bm5pbmcgaW4gYSBWVEwwIGd1ZXN0IG9uIG15IGxhcHRvcCBvcg0K
PiA+IGluIEF6dXJlLiBGb3J0dW5hdGVseSwgdGhlIGNoYW5nZXMgb3ZlcmFsbCBpbiB0aGlzIHBh
dGNoIHNldCBhcmUgcHJldHR5DQo+ID4gc3RyYWlnaHRmb3J3YXJkLCBhbmQgbXkgdGVzdGluZyBv
ZiBWVEwwIGd1ZXN0cyBkaWRu4oCZdCB0dXJuIHVwIGFueSBidWdzLg0KPiA+IEknbSBob3Bpbmcg
dGhhdCBhZGRpdGlvbmFsIHNtb2tlIHRlc3RpbmcgaXMgbW9yZSBhYm91dCBnYWluaW5nDQo+ID4g
Y29uZmlkZW5jZSB0aGFuIGZpbmRpbmcgYWN0dWFsIGJ1Z3MuICAoRmFtb3VzIGxhc3Qgd29yZHMg
Li4uLikNCj4gPg0KPiANCj4gVGhhbmsgeW91IGEgbWlsbGlvbiB0aW1lcyBmb3IgcHVzaGluZyB0
aGUgYmFyIGhpZ2hlciBhbmQgc3VwcG9ydGluZyB0aGUNCj4gY29kZSA6KQ0KPiANCj4gPj4gVlRM
MiBjdXJyZW50bHkgdXNlcyBhIGxpbWl0ZWQgbnVtYmVyIGh5cGVyY2FsbHMgdGhhdCBhcmUgc2V0
IGFzIGVuYWJsZWQNCj4gPj4gaW4gdGhlIE9wZW5WTU0gY29kZSAoYHNldF9hbGxvd2VkX2h5cGVy
Y2FsbHNgKS4gWW91IGNvdWxkIHRha2UgYSBsb29rDQo+ID4+IGFuZCBjb25jbHVkZSBpZiB0aGVz
ZSBoeXBlcmNhbGxzIHJlcXVpcmUgYW55IGFkanVzdG1lbnRzIGluIHRoZSBwYXRjaGVzLg0KPiA+
DQo+ID4gTXkgcGF0Y2ggc2V0IGFscmVhZHkgY292ZXJzIGFsbCB0aGUgaHlwZXJjYWxsIGNhbGwg
c2l0ZXMgdGhhdCBvcmlnaW5hdGUgaW4NCj4gPiBWVEwyIGNvZGUuIEFnYWluLCBhIGJhc2ljIHNt
b2tlIHRlc3Qgc2hvdWxkIGhlbHAgZ2FpbiBjb25maWRlbmNlLCBvcg0KPiA+IHNob3cgdGhhdCBh
bnkgY29uZmlkZW5jZSBpcyBtaXNwbGFjZWQgOi0pDQo+ID4NCj4gDQo+IFZlcnkgbmljZSwgc2hv
dWxkIGJlIHNtb290aCBzYWlsaW5nIHRoZW4gOikNCj4gDQo+ID4+IE15IG9waW5pb24gaGFzIGJl
ZW4gdG8gaGF2ZSB0d28gcGFnZXMgKGlucHV0IGFuZCBvdXRwdXQgb25lcykuIEFzIHRoZQ0KPiA+
PiBuZXcgY29kZSBpbnRyb2R1Y2VzIGp1c3Qgb25lIHBhZ2UgSSBkbyBmZWVsIGEgYml0IGFwcHJl
aGVuc2l2ZSwgZ290IG5vDQo+ID4+IGhhcmQgZXZpZGVuY2UgdGhhdCB0aGlzIGlzIGEgYmFkIGFw
cHJvYWNoIHRob3VnaC4gSWYgd2UgdHdlYWsgdGhlIGNvZGUNCj4gPj4gdG8gaGF2ZSAyIHBhZ2Vz
LCBwZXJoYXBzIHRoZXJlIHdvdWxkIGJlIG5vIG5lZWQgdG8gcnVuIGEgZnVsbC1ibG93bg0KPiA+
PiB2YWxpZGF0aW9uLCBhbmQgZXZlbiBzbW9rZSB0ZXN0cyB3aWxsIHN1ZmZpY2U/DQo+ID4NCj4g
PiBNeSB2aWV3IGlzIHRoYXQgdGhlIDEgcGFnZSB2cy4gMiBwYWdlcyBpcyBtdWNoIGxlc3Mgb2Yg
YSByaXNrIHRoYW4ganVzdA0KPiA+IHNvbWUgY29kaW5nIGVycm9yIGluIGludHJvZHVjaW5nIHRo
ZSBuZXcgaW50ZXJmYWNlcy4gVGhlIDEgcGFnZSB2cy4NCj4gPiAyIHBhZ2VzIHNob3VsZCBvbmx5
IGFmZmVjdCB0aGUgYmF0Y2ggc2l6ZSBmb3IgcmVwIGh5cGVyY2FsbHMsIGFuZCB0aGUNCj4gPiBl
eGlzdGluZyBjb2RlIGFscmVhZHkgaGFuZGxlcyBkaWZmZXJlbnQgYmF0Y2ggc2l6ZXMuIFNvIEkn
bSBub3QgYXMNCj4gPiBjb25jZXJuZWQgYWJvdXQgdGhhdCByaXNrLiBXZWkgTGl1IGluIHRoZSBt
YWludGFpbmVyIGhlcmUsIHNvIEknbGwNCj4gPiBjZXJ0YWlubHkgZm9sbG93IGhpcyBqdWRnbWVu
dCBhbmQgZ3VpZGFuY2Ugb24gd2hhdCBpcyBuZWVkZWQgdG8NCj4gPiBiZSBjb25maWRlbnQgaW4g
dGhpcyBwYXRjaCBzZXQuDQo+ID4NCj4gDQo+IEkgYWdyZWUgd2l0aCB5b3VyIHJpc2sgYXNzZXNz
bWVudC4gUGVyaGFwcyBJIGFtIHBsYXlpbmcgdG9vIG11Y2ggb2YNCj4gYSBzcGVjIGxhd3llciB5
ZXQgaXQgc3RhdGVzDQo+IA0KPiAxKSBJbnB1dCBhbmQgb3V0cHV0IGFyZWEgbWF5IG5vdCBpbnRl
cnNlY3QsDQo+IDIpIEVpdGhlciBjYW4gYmUgdXAgdG8gNEtpQiBvZiBzaXplLg0KPiANCj4gSGVu
Y2UsIG9uZSAoYmUgdGhhdCBmb3IgZmVhdHVyZSBkZXZlbG9wbWVudCBvciBvbmUtb2ZmIGRlYnVn
Z2luZykgd291bGQNCj4gYmUgd2l0aGluIHRoZWlyIHJpZ2h0IHRvIGltcGxlbWVudCBhIGh5cGVy
Y2FsbCB0aGF0IGFjY2VwdHMgNEtpQiBvZg0KPiBkYXRhIGFuZCByZXR1cm5zIDRLaUIgb2YgZGF0
YS4gTXkgdW5kZXJzdGFuZGluZyB0aGF0IGFmdGVyIHRoaXMgcGF0Y2gsDQo+IHRoYXQgd29uJ3Qg
d29yayBvdXQtb2YtdGhlLWJveCwgYW5kIHdvdWxkIG5lZWQgc29tZSBmaXhpbmcgaW4gdGhlDQo+
IGtlcm5lbC4NCj4gDQo+IFBlcmhhcHMsIHdlIGNvdWxkIGhhdmUgYSBLQ29uZmlnIG9wdGlvbiB0
byBsZXQgdGhlIHVzZXIgY2hvb3NlIGlmIHRoZXkNCj4gbmVlZCAyIHBhZ2VzIGluc3RlYWQgb2Yg
bWFraW5nIHRoZSB1c2VyIGZpZ3VyZSBvdXQgd2hhdCBuZWVkcyB0byBiZQ0KPiBmaXhlZCBpbiB0
aGUga2VybmVsPw0KPiANCg0KSSdtIG5vdCBzZWVpbmcgdGhlIHNjZW5hcmlvIHdoZXJlIGEgS2Nv
bmZpZyBvcHRpb24gaXMgdXNlZnVsLiBIZXJlJ3MNCm15IHRoaW5raW5nOg0KDQpBIHB1dGF0aXZl
IG5ldyBoeXBlcmNhbGwgdGhhdCByZXF1aXJlcyBtb3JlIHRoYW4gNEsgZm9yIHRoZSBzdW0gb2YN
CnRoZSBpbnB1dCBhbmQgb3V0cHV0IHdvdWxkIG5vdCBiZSBhIHJlcCBoeXBlcmNhbGwuIFNvIHRo
ZSBoeXBlcmNhbGwNCmhhcyBzb21lIGxhcmdlIHN0cnVjdHVyZSBmb3IgdGhlIGlucHV0IGFuZC9v
ciB0aGUgb3V0cHV0LiBTdWNoIGENCmh5cGVyY2FsbCB3b3VsZCBiZSBoYW5kbGVkIG9uZSBvZiB0
d28gd2F5cyBpbiB0aGUga2VybmVsOg0KDQooMSkgTmV3IGNvZGUgbXVzdCBiZSBhZGRlZCBpbiB0
aGUga2VybmVsIHRoYXQgaW5jbHVkZXMgYSBoeXBlcmNhbGwNCmNhbGwgc2l0ZSB0byBpbnZva2Ug
dGhpcyBoeXBlcmNhbGwuIFRoZSBuZXcgY29kZSBwb3B1bGF0ZXMgdGhlIGxhcmdlDQppbnB1dCBz
dHJ1Y3R1cmUsIGFuZC9vciBwcm9jZXNzZXMgdGhlIGxhcmdlIG91dHB1dCBzdHJ1Y3R1cmUgaW4g
b3JkZXINCnRvIGFjY29tcGxpc2ggd2hhdGV2ZXIgdGhlIExpbnV4IGtlcm5lbCBuZWVkcyBkb25l
IHRoYXQgdGhlDQpoeXBlcmNhbGwgaGVscHMgd2l0aC4NCg0KKDIpIFRoZSBoeXBlcmNhbGwgaXMg
aW52b2tlZCBmb3IgdGhlIHJvb3QgcGFydGl0aW9uIG9yIFZUTDIgdmlhIG9uZQ0Kb2YgdGhlIGV4
aXN0aW5nIGlvY3RsJ3MgdGhhdCBhbGxvdyB1c2VyIHNwYWNlIGluIHRoZSByb290IHBhcnRpdGlv
biBvcg0KVlRMMiB0byBpbnZva2UgYXJiaXRyYXJ5IGh5cGVyY2FsbHMgYW5kIGdldCB0aGUgcmVz
dWx0cy4NCg0KRm9yICgxKSwgbmV3IGNvZGUgaXMgYmVpbmcgYWRkZWQgdG8gdGhlIGtlcm5lbC4g
U28gY2hhbmdpbmcgdGhlDQojZGVmaW5lIEhWX0hWQ0FMTF9BUkdfUEFHRVMgZnJvbSAiMSIgdG8g
IjIiIGlzIGp1c3QgcGFydA0Kb2YgdGhlIGNvZGUgY2hhbmdlcyBuZWVkZWQgZm9yIHRoZSBuZXcg
aHlwZXJjYWxsLg0KDQpGb3IgKDIpLCB0aGUgaW9jdGxzLCBzdWNoIGFzIG1zaHZfaW9jdGxfcGFz
c3RocnVfaHZjYWxsKCksIGRvbid0DQp1c2UgdGhlIHByZS1hbGxvY2F0ZWQgaHlwZXJ2X3BjcHVf
aW5wdXQvb3V0cHV0X2FyZy4gVGhleSBkbw0KYSBzZXBhcmF0ZSBhbGxvY2F0aW9uIG9mIGEgZnVs
bCBwYWdlIGZvciBpbnB1dCBhbmQgYSBmdWxsIHBhZ2UgZm9yDQpvdXRwdXQgYmVjYXVzZSBvZiB0
aGUgY29tcGxleGl0aWVzIG9mIGNvcHlpbmcgdGhlIGlucHV0DQphbmQgb3V0cHV0IGFyZ3MgZnJv
bS90byB1c2VyIHNwYWNlLiBTbyBpZiB0aGUgcHV0YXRpdmUgbmV3DQpoeXBlcmNhbGwgaXMgaW52
b2tlZCB2aWEgdGhlIGlvY3RsLCBpdCB3aWxsIGp1c3Qgd29yay4NCg0KSSBkb24ndCBzZWUgYSBz
Y2VuYXJpbyB3aGVyZSBhIEtjb25maWcgb3B0aW9uIHByb3ZpZGVzIGFueQ0KdmFsdWUgdG8gc29t
ZW9uZSBidWlsZGluZyB0aGUga2VybmVsLiBMaW51eCBrZXJuZWwgY29kZSBhbHNvDQpnZW5lcmFs
bHkgZXNjaGV3cyBhZGRpbmcgbWVjaGFuaXNtIHRvIHN1cHBvcnQgZnV0dXJlDQpzY2VuYXJpb3Mg
dGhhdCBtaWdodCBvciBtaWdodCBub3QgaGFwcGVuLiBTdXJlLCB3ZSBkZXNpZ24NCmNvZGUgdG8g
YmUgZXh0ZW5zaWJsZSwgYnV0IHdlIGRvbid0IGdlbmVyYWxseSBhZGQgb3B0aW9ucyBvcg0KQVBJ
cyB0aGF0IGFyZW4ndCBjdXJyZW50bHkgbmVlZGVkLiBJJ3ZlIGNvbnNpc3RlbnRseSBnb3R0ZW4N
CmZlZWRiYWNrIHRvIGFkZCBzdWNoIHdoZW4vaWYgdGhlIG5lZWQgYWN0dWFsbHkgYXJpc2VzLiBJ
DQp0aGluayB0aGUgI2RlZmluZSBIVl9IVkNBTExfQVJHX1BBR0VTIDEgcHJvdmlkZXMgdGhlDQpy
aWdodCBiYWxhbmNlLg0KDQpNaWNoYWVsDQo=


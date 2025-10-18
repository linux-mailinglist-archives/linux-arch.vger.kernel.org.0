Return-Path: <linux-arch+bounces-14190-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B83BEC62A
	for <lists+linux-arch@lfdr.de>; Sat, 18 Oct 2025 04:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ECE14E85A5
	for <lists+linux-arch@lfdr.de>; Sat, 18 Oct 2025 02:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174BE26CE25;
	Sat, 18 Oct 2025 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JZbG3FoU"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010006.outbound.protection.outlook.com [52.103.12.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448526F2AB;
	Sat, 18 Oct 2025 02:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760756057; cv=fail; b=a0H4ik8tGsl3tJso9Ll3/58mUPibjnleJSPSecy9YcPN+6jTSnk18adeSTQMyhVKmFezGieeTgKdHZrbBjc+asmtftofo4APxMVK8ZkwN/i7of61RhtnumKKGVK0xGqOlnb6SCoyTFsr69laIS6lRrYS+P5gsUxfdsZxB2RkYKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760756057; c=relaxed/simple;
	bh=jJ3mLUb1gy5wurrs0SpllqLOKeShe5CN/U63T3PrREM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A6ZVaZQ6omKcHive301W7jEROxmePEHd+4E/dmMYg7AKCe1Q+N8Pbzr0XZ99MW2uQ+Jy3eVU0wRtSdKwUgl9V1I2bQz7Oaj3VRIqcTlPEB4mGBVKPmsYpJB2eJjryHX2LMvrzNlWvyqHTsZqwlPR4i3cZMQpzLyC3jefOTKt8y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JZbG3FoU; arc=fail smtp.client-ip=52.103.12.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCgImE/U7mjwE3wWLDcCnUB+sepmM3JI4TBzIrHOdf1f2eYmrWxEx373jYXZztk/9BFZLAI9h2eJan/PflyAd6ZHJANyyts0cgU0cb71sE+imn6nO6XRErHSEGM1lzq/aBJjV4lbBjXcDRNDRVwMXwBBoLPYRvNOzxjdjgHFYuIbf6D7HkzSNF4NVKFxjAht2m6Ksdh3Hadx2ScYdSbwdNSjbB5L2IEuvDiWtadLi2eqsWSKzM7eyKvYFhtpxg9yagC1TwyaHKWV94bOmyySmP4LcU13LhSiEyk7DRlk5K05eV7Vo9lKiRz+KYcGT0UgdWWKyr6RuZqX88gwIUvdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ3mLUb1gy5wurrs0SpllqLOKeShe5CN/U63T3PrREM=;
 b=O6EUGJ98bxceWpEy8G4YdMnz0M4Wd7FXOBtYAy95OG3CW2qeuelJ3NUqQ4n3UDzsDVrK9Ufb1z3WnoqNyQqI37ioiDjEI19kdxwlB91xX4/23AyzINGh/i31KJzYTQupsKu1XHKjJoxFlwSnVcJslKzCldpes11t81Ja/YffF18LXcVuaJX2wFItIlYveiKzr/FTcAxx2EamYdejqSXsxTlfW3Pg/Ncx2iih6gb9UArF4FP/KFmYJbwkuZyBVVNt0Z2XNsYm6PdAFga8yCmKHZdL/lR428TuEj3QbSD3wtC6Wzzecx/9z+h3hqBH5G5BuJfiAtZpNVPvAvrbvm2U2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ3mLUb1gy5wurrs0SpllqLOKeShe5CN/U63T3PrREM=;
 b=JZbG3FoUyuWqm7qVhVVLBMXbuelVtpTvMSEkgjZwe/d7ZdPGU6wKFJn6szzJv8+8IDR5z+1Eifo6sG3sSVpO1rcupXjsjE2dgR941KoPg7XN0OKX0T1fx3NgjM2JO16NHZEDONc7ldrXPlE14AtM8jaj51DsCPBb4Iijf220pbG6lrx26Clo3kJHukMK1qkRmgKZS+wOwaFZ18I5ZyTQE5RaVTvqIZ7w37cIu2st7BYLmfe1MaFBu3xqKYjmtguGmFLhGXM9/YYOiTLs/5Dv0v/MHW9SqAwm6wCr1yu0HM9v8VXW98b1hhfpLcY4RIQOM3SoQRjFfeX93m6sCIlErA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8159.namprd02.prod.outlook.com (2603:10b6:408:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Sat, 18 Oct
 2025 02:54:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.9228.011; Sat, 18 Oct 2025
 02:54:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>
Subject: RE: [PATCH v3 0/6] Hyper-V: Implement hypervisor core collection
Thread-Topic: [PATCH v3 0/6] Hyper-V: Implement hypervisor core collection
Thread-Index: AQHcNxKFJe9CtDp5jESMFQcachlQQLTG/dcAgAAG2wCAABEBAIAAKKEg
Date: Sat, 18 Oct 2025 02:54:11 +0000
Message-ID:
 <SN6PR02MB4157C70EBD25315F098DB3A1D4F7A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251006224208.1060990-1-mrathor@linux.microsoft.com>
 <20251017223300.GB632885@liuwe-devbox-debian-v2.local>
 <20251017225732.GC632885@liuwe-devbox-debian-v2.local>
 <74e019ac-afc7-3178-0f0a-dc903af5c4ca@linux.microsoft.com>
In-Reply-To: <74e019ac-afc7-3178-0f0a-dc903af5c4ca@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8159:EE_
x-ms-office365-filtering-correlation-id: adf79421-981b-4dcb-0054-08de0df19d86
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|461199028|31061999003|8060799015|15080799012|13091999003|8062599012|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXNidmkrTEhNVm1wVzE2ODN6Y293dVBpTk5CdWdNbXEwRGp2VmZnb3JGd1RW?=
 =?utf-8?B?THhURWo1MW9OWGdwVUxpK3lJSHdGV3BMNEpJMEFOczRxWXRELythZmR0UzNm?=
 =?utf-8?B?UnNTOE9zMDVJaVplZFFrZkErWUhCdzVoY09xSlVUbWtHbmtWNG5oMjF3VlVD?=
 =?utf-8?B?SERra1JidVAxK0hONHBPbisycFN2Mk9OY1lMQWVTUm5DRzljK0ZycE5vQmN6?=
 =?utf-8?B?OFQrMDBhY3hFbXgwWGw3Wm1qQVpWc2U5c28yRG45Mnc1akxvdU4wL3JEOXZ0?=
 =?utf-8?B?bE1zMkFoMUJEd2NKekg3NVJyeFliOGJNUXZRdS9yaTdqVVorNzkxSHlkT2Iv?=
 =?utf-8?B?Y0JaMU5oeHczQkh6V0FFVmZRVEJiaHlBZzY2U3BneDNXT0FwQ0pBRWJ2SUdI?=
 =?utf-8?B?eFZVN3ZzbEIycjE4cE5DT21ZT1F3MkRTcWp6K2FDRGE0TkhxNUYwMU9ZbVky?=
 =?utf-8?B?L3B1NisxWmRDRTFHUHJJRWRQNE0yY1l0c1pITXFFSnQzb1MvaS9ieUQ2N3BV?=
 =?utf-8?B?aHB6MWx3T2h4M0hyUmhOQW9IUWxZOVVkVEl5czRsSlJaUVZ6L0xSbE15cjh4?=
 =?utf-8?B?LzhnNmRZa0xMRm5KY2p1WEEzaTQySnBKbHE5a2JlWGhjUGVQMjNjYytPcDB1?=
 =?utf-8?B?Ry9JcEdsNUxhTzYxZk5YTld0Y01sN2FGTmRyYVA2UTBWZVpYVThTSGtabFAx?=
 =?utf-8?B?b1d5RGMxU29uUmlCOGc4UzcyRUdTQW1xaVN4ZjBjdHpocXNGMXBqYk03Uito?=
 =?utf-8?B?NnZjWkc3S3dtS3pBV1BOVHozc1puR2xLMng4MXViUUlaU2FrQVNoeGlubmIx?=
 =?utf-8?B?ZUNkZ1BVU3llL1JrdWtwUGZLajB5Lyt0bjRzQ3lvWVlkYjVMOSs3RzRhWlVR?=
 =?utf-8?B?dm14RXo4dDM5aERiVU1nQzFSMTZIQ01MOGF5TVpHYktvNmJleVN0MjRQQ1VC?=
 =?utf-8?B?V0lJRjhDNlpZSzZoVTV3azZZSStrendnTzBPbk13MzlVK3pCWXJjeDdHNFB0?=
 =?utf-8?B?V0xsRjlZRFVFcFdsNzVXU0Iza2pkZjlkN0d4S2JqOWsvZHVrQWxhMXllMDhC?=
 =?utf-8?B?TEF6T1hEMjBHODFVQ1lHMlFqT0ZpNzhFZTNHWXlZQ1Vqc1hTenRiekFjQnFl?=
 =?utf-8?B?V0FNYXlYOHVnbjh2RlJpRU5WM1JQWWpqZHJDWUd1WDR3TzhldmpncXpBRnBN?=
 =?utf-8?B?L3cwSXV6WlF2cUV0V0V1d1Naa2o3TVRoTHFQL1RaODVjWWhjSHlYUVJjME03?=
 =?utf-8?B?Z2REempkbk5XWExrY1BZTm5wcUJiYk1SNGZtL29YUDNiNjJjY2R2cGwxQlJo?=
 =?utf-8?B?ekNKYkIxaFlVNW1Ca2FWaUI1a3EvaFRQWDNMT2JHTHoyRytpbGhJTUtuNjVS?=
 =?utf-8?B?SmlIMnl3QVdCeHFwU284T2tKVjlYWlBzUUV0Q3NhY29pZUgzemhBVW1oWUtp?=
 =?utf-8?B?a2pMcnR4YWZTcmdEcDVJUEJFeU9DalBwU3JEVERkSlp3WjVyalNtZHNsRFlD?=
 =?utf-8?B?cEpHd0poeXBhYjUvL2tBdnQ4RGpxOHNNSUZiWVFKWGdIRjI2Y3BkdlZtWm9V?=
 =?utf-8?Q?EckbfbMasJwy3dkzjs8B7Ap6I=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUZVUzQ2SWNnZCtEUXczZU5ZUC9jbHNNOHB0MExRN1ZselpEM2hTbzRVRlly?=
 =?utf-8?B?SldXM2U4QjJqK01Nd2NzeEF4aHY3Y3kyZ25jeno5eEZqeU5MRjFoQ2RyQ2lW?=
 =?utf-8?B?MHdDMHZET0taMmZ3cHhSSlBUaHR0bnYrRittM0p2ZExHbWVaWitKb2hVbzF3?=
 =?utf-8?B?OUp4eS9Fd1RLbGk2R1grSGNPSy9iNW5VTGlCVE0yM2xmcDQ2VFRvU2hMWmhC?=
 =?utf-8?B?WmpvOHNhQy9mQlBxc1pHWlVoaFpZV29TbWZzekF1ZEFhMnJVS2FBV2ZtbjFQ?=
 =?utf-8?B?RUpzRUFCcFBkR3lJRzA0ekhiZ0RlYUtPc3d1T09qVjFjb1ZiNEhtV3d5Nm95?=
 =?utf-8?B?TkdKNXQ1RTJzME1RNmJQUjJRRDNoNmdmOWx1eGo2SjBjVHo5VStFL3Q3L0Ju?=
 =?utf-8?B?STdYVk9JTGFJZDFHRWpnRnE4SG5JVkQvL204MmhzK2k2dGFoUVo1VkxqTFdS?=
 =?utf-8?B?U0c5RGIxTVg1eFN4ek5vMjM4Q3JmZGtYMC9VcEc4UDZMb25qb29EY3lncDAz?=
 =?utf-8?B?bjZJbzFIT0p2QTBteG5tZG9kRk15U00xVjVNQTZsWW5NZFJCM2l4UmU1K2hE?=
 =?utf-8?B?eTZDdkFRRURVZnU1ZXArSzlsWHVjaEF0MHZsV0IzWnpRME0xeDdyRXk0emhi?=
 =?utf-8?B?bUZXYmlvNUVVQVNBZTZlYTNydnVHbzBYVUR1SDNGSDFoQjJ3bEFYZmxNZFpW?=
 =?utf-8?B?T0p6R2gvUjNBYm4yMjJnNU16R0hyb1VXNFNPVW5uMXU4c3RrWjNvOU5zeGla?=
 =?utf-8?B?MDVQMEx3VWMzc3l0ZzFpUkdPN2JiSG1xd3RrUlJUSk0xWFRJbHkrR2dyZWo0?=
 =?utf-8?B?cUhsait4NGxSSzZvTlAyS2JKWHRoM3dzT2d4NXp2a05YTjJ1aGJROEFxaXNT?=
 =?utf-8?B?bWl4ZXRSdWg3eHBTRXl1Nmw2aHdUVTk2NVYva2MvWWJKMk94NHFoaWFsVTBs?=
 =?utf-8?B?TVJpZy92ajkyNFZBOU1MZmVqVmJzVDUvSjJ0VTE1QUZXQWJBZWNBa2c5YlhJ?=
 =?utf-8?B?TTByZzF0YVp0NlBiYytrNnY1SkpwQVNHQ0hobXJiWnZ6cHVIeE5yZzBqdlli?=
 =?utf-8?B?cjArM0RRVGhTNmlaSmdIaHRHSGVFYzd4NTJKc3BubE5vVmkvM2RFS1REcktO?=
 =?utf-8?B?YTBJVjM5ZE45dnA0QS9SY0xjZ3MvazI0QWpnSE1CR1pDVW1PUEhTQnJHdUZ4?=
 =?utf-8?B?dUlDdEt6cEdLSUwwRFpEZEVrZWFCVFFRc2Z4R1VSbEJnTi8ySUNJVHVsMTRQ?=
 =?utf-8?B?NWxkNm5pOGw0dGd0dlhMdXM3UnUwQWNlODFrcS9LeFRFV2J6RUI5NEEvQ3gy?=
 =?utf-8?B?S2U3YlJWQmp4UmpEN0tvbTZxc2sxUUY1bGFmK045eGxMUDRjTlJicVdtS2kv?=
 =?utf-8?B?UmJFZzRWVUg0WXF3bmo1aTQ1RE5naW9OZVNVRXM5cTBuWXRFTlRsZVJ0bVJy?=
 =?utf-8?B?VTEzZmVWakNFMEJOcEJVS085WXBzWnBXdW9kR3NhQXV3N28wN2N2REZCN2tZ?=
 =?utf-8?B?TzlaZG03aGVSVllSaHNEdjUwS01rZ2hVWEZWekE1V1NJOTl5WUVOZW80LzJQ?=
 =?utf-8?B?TW4xWkRYMHdicTdMUUlvK0NBeWo1QWtldzNRdmJGTjdIL1VMRXlOc3dDK21T?=
 =?utf-8?Q?dG4U1PRme/73X568k0BPoKtlV12aBnRLa4S76FhI2di8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: adf79421-981b-4dcb-0054-08de0df19d86
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 02:54:11.4226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8159

RnJvbTogTXVrZXNoIFIgPG1yYXRob3JAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogRnJpZGF5
LCBPY3RvYmVyIDE3LCAyMDI1IDQ6NTggUE0NCj4gDQo+IE9uIDEwLzE3LzI1IDE1OjU3LCBXZWkg
TGl1IHdyb3RlOg0KPiA+IE9uIEZyaSwgT2N0IDE3LCAyMDI1IGF0IDEwOjMzOjAwUE0gKzAwMDAs
IFdlaSBMaXUgd3JvdGU6DQo+ID4+IE9uIE1vbiwgT2N0IDA2LCAyMDI1IGF0IDAzOjQyOjAyUE0g
LTA3MDAsIE11a2VzaCBSYXRob3Igd3JvdGU6DQo+ID4+IFsuLi5dDQo+ID4+PiBNdWtlc2ggUmF0
aG9yICg2KToNCj4gPj4+ICAgeDg2L2h5cGVydjogUmVuYW1lIGd1ZXN0IGNyYXNoIHNodXRkb3du
IGZ1bmN0aW9uDQo+ID4+PiAgIGh5cGVydjogQWRkIHR3byBuZXcgaHlwZXJjYWxsIG51bWJlcnMg
dG8gZ3Vlc3QgQUJJIHB1YmxpYyBoZWFkZXINCj4gPj4+ICAgaHlwZXJ2OiBBZGQgZGVmaW5pdGlv
bnMgZm9yIGh5cGVydmlzb3IgY3Jhc2ggZHVtcCBzdXBwb3J0DQo+ID4+PiAgIHg4Ni9oeXBlcnY6
IEFkZCB0cmFtcG9saW5lIGFzbSBjb2RlIHRvIHRyYW5zaXRpb24gZnJvbSBoeXBlcnZpc29yDQo+
ID4+PiAgIHg4Ni9oeXBlcnY6IEltcGxlbWVudCBoeXBlcnZpc29yIFJBTSBjb2xsZWN0aW9uIGlu
dG8gdm1jb3JlDQo+ID4+PiAgIHg4Ni9oeXBlcnY6IEVuYWJsZSBidWlsZCBvZiBoeXBlcnZpc29y
IGNyYXNoZHVtcCBjb2xsZWN0aW9uIGZpbGVzDQo+ID4+Pg0KPiA+Pg0KPiA+PiBBcHBsaWVkIHRv
IGh5cGVydi1uZXh0LiBUaGFua3MuDQo+ID4NCj4gPiBUaGlzIGJyZWFrcyBpMzg2IGJ1aWxkLg0K
PiA+DQo+ID4gL3dvcmsvbGludXgtb24taHlwZXJ2L2xpbnV4LmdpdC9hcmNoL3g4Ni9oeXBlcnYv
aHZfaW5pdC5jOiBJbiBmdW5jdGlvbiA/aHlwZXJ2X2luaXQ/Og0KPiA+IC93b3JrL2xpbnV4LW9u
LWh5cGVydi9saW51eC5naXQvYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYzo1NTc6MTc6IGVycm9y
OiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiA/aHZfcm9vdF9jcmFzaF9pbml0PyBb
LVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4gPiAgIDU1NyB8ICAgICAg
ICAgICAgICAgICBodl9yb290X2NyYXNoX2luaXQoKTsNCj4gPiAgICAgICB8ICAgICAgICAgICAg
ICAgICBefn5+fn5+fn5+fn5+fn5+fn4NCj4gPg0KPiA+IFRoYXQncyBiZWNhdXNlIENPTkZJR19N
U0hWX1JPT1QgaXMgb25seSBhdmFpbGFibGUgb24geDg2XzY0LiBBbmQgdGhlDQo+ID4gY3Jhc2gg
ZmVhdHVyZSBpcyBndWFyZGVkIGJ5IENPTkZJR19NU0hWX1JPT1QuDQo+ID4NCj4gPiBBcHBseWlu
ZyB0aGUgZm9sbG93aW5nIGRpZmYgZml4ZXMgdGhlIGJ1aWxkLg0KPiANCj4gDQo+IFRoYW5rcy4g
QSBiaXQgc3VycHJpc2luZyB0aG8gdGhhdCBDT05GSUdfTVNIVl9ST09UIGRvZXNuJ3QgaGF2ZQ0K
PiBoYXJkIGRlcGVuZGVuY3kgb24geDg2XzY0LiBJdCBzaG91bGQsIG5vPw0KDQpDT05GSUdfTVNI
Vl9ST09UICpkb2VzKiBoYXZlIGEgaGFyZCBkZXBlbmRlbmN5IG9uIFg4Nl82NC4NCg0KQnV0IHRo
ZSBwcm9ibGVtIGlzIGFjdHVhbGx5IG1vcmUgcGVydmFzaXZlIHRoYW4ganVzdCAzMi1iaXQgYnVp
bGRzLiBCZWNhdXNlDQpvZiB0aGUgaGFyZCBkZXBlbmRlbmN5LCAzMi1iaXQgYnVpbGRzIGltcGx5
IENPTkZJR19NU0hWX1JPT1Q9biwgd2hpY2ggaXMNCnRoZSByZWFsIHByb2JsZW0uIEluIGFyY2gv
eDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmggdGhlIGRlY2xhcmF0aW9uIGZvcg0KaHZfcm9vdF9j
cmFzaF9pbml0KCkgaXMgYXZhaWxhYmxlIG9ubHkgd2hlbiBDT05GSUdfTVNIVl9ST09UIGlzIGRl
ZmluZWQNCihtIG9yIHkpLiBUaGVyZSdzIGEgc3R1YiBodl9yb290X2NyYXNoX2luaXQoKSBpZiBD
T05GSUdfTVNIVl9ST09UIGlzIGRlZmluZWQNCmFuZCBDT05GSUdfQ1JBU0hfRFVNUD1uLCBidXQg
bm90IGlmIENPTkZJR19NU0hWX1JPT1Q9bi4gVGhlIHNvbHV0aW9uDQppcyB0byBhZGQgYSBzdHVi
IHdoZW4gQ09ORklHX01TSFZfUk9PVD1uLCBhcyBiZWxvdzoNCg0KZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmggYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc2h5cGVy
di5oDQppbmRleCA3NjU4MmFmZmVmYTguLmE1YjI1OGQyNjhlZCAxMDA2NDQNCi0tLSBhL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2LmgNCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21z
aHlwZXJ2LmgNCkBAIC0yNDgsNiArMjQ4LDggQEAgdm9pZCBodl9jcmFzaF9hc21fZW5kKHZvaWQp
Ow0KIHN0YXRpYyBpbmxpbmUgdm9pZCBodl9yb290X2NyYXNoX2luaXQodm9pZCkge30NCiAjZW5k
aWYgIC8qIENPTkZJR19DUkFTSF9EVU1QICovDQoNCisjZWxzZSAgIC8qIENPTkZJR19NU0hWX1JP
T1QgKi8NCitzdGF0aWMgaW5saW5lIHZvaWQgaHZfcm9vdF9jcmFzaF9pbml0KHZvaWQpIHt9DQog
I2VuZGlmICAvKiBDT05GSUdfTVNIVl9ST09UICovDQoNCiAjZWxzZSAvKiBDT05GSUdfSFlQRVJW
ICovDQoNCkFubm95aW5nbHksIHRoaXMgc29sdXRpb24gZHVwbGljYXRlcyB0aGUgaHZfcm9vdF9j
cmFzaF9pbml0KCkgc3R1Yi4gIFNvDQphbiBhbHRlcm5hdGUgYXBwcm9hY2ggdGhhdCBjaGFuZ2Vz
IGEgZmV3IG1vcmUgbGluZXMgb2YgY29kZSBpcyB0aGlzOg0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zaHlwZXJ2
LmgNCmluZGV4IDc2NTgyYWZmZWZhOC4uMTM0MmQ1NWMyNTQ1IDEwMDY0NA0KLS0tIGEvYXJjaC94
ODYvaW5jbHVkZS9hc20vbXNoeXBlcnYuaA0KKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbXNo
eXBlcnYuaA0KQEAgLTIzNywxOCArMjM3LDE0IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdTY0
IGh2X3Jhd19nZXRfbXNyKHVuc2lnbmVkIGludCByZWcpDQogfQ0KIGludCBodl9hcGljaWRfdG9f
dnBfaW5kZXgodTMyIGFwaWNfaWQpOw0KDQotI2lmIElTX0VOQUJMRUQoQ09ORklHX01TSFZfUk9P
VCkNCi0NCi0jaWZkZWYgQ09ORklHX0NSQVNIX0RVTVANCisjaWYgSVNfRU5BQkxFRChDT05GSUdf
TVNIVl9ST09UKSAmJiBJU19FTkFCTEVEKENPTkZJR19DUkFTSF9EVU1QKQ0KIHZvaWQgaHZfcm9v
dF9jcmFzaF9pbml0KHZvaWQpOw0KIHZvaWQgaHZfY3Jhc2hfYXNtMzIodm9pZCk7DQogdm9pZCBo
dl9jcmFzaF9hc202NCh2b2lkKTsNCiB2b2lkIGh2X2NyYXNoX2FzbV9lbmQodm9pZCk7DQotI2Vs
c2UgICAvKiBDT05GSUdfQ1JBU0hfRFVNUCAqLw0KKyNlbHNlICAgLyogQ09ORklHX01TSFZfUk9P
VCAmJiBDT05GSUdfQ1JBU0hfRFVNUCAqLw0KIHN0YXRpYyBpbmxpbmUgdm9pZCBodl9yb290X2Ny
YXNoX2luaXQodm9pZCkge30NCi0jZW5kaWYgIC8qIENPTkZJR19DUkFTSF9EVU1QICovDQotDQot
I2VuZGlmICAvKiBDT05GSUdfTVNIVl9ST09UICovDQorI2VuZGlmICAvKiBDT05GSUdfTVNIVl9S
T09UICYmIENPTkZJR19DUkFTSF9EVU1QICovDQoNCiAjZWxzZSAvKiBDT05GSUdfSFlQRVJWICov
DQogc3RhdGljIGlubGluZSB2b2lkIGh5cGVydl9pbml0KHZvaWQpIHt9DQoNCk1pY2hhZWwNCg==


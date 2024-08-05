Return-Path: <linux-arch+bounces-6000-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E516E948308
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 22:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F661C21507
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 20:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D63D16C699;
	Mon,  5 Aug 2024 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pghyOCSn"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2055.outbound.protection.outlook.com [40.92.19.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD6616BE3A;
	Mon,  5 Aug 2024 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888805; cv=fail; b=ZWcGHotKPS1vC5K2pkROUaqGbv6kQYvQDawzyW8rBlMrogUaSmdwuUXZGnLECIFDg7u+Wh6jT3k+dp9/ZGE9iBLNjkgzaxp0DuzkZDGqZB6JJtZYjJRoNiBfr11qnDozN0DBA44lq8rcAxOBe/vjQoT6iCSgAUzl7f7pJyl51Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888805; c=relaxed/simple;
	bh=a65IxjY6e72HTmx186bF3gYghuxgOuB6K0s215mY0lg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZN2jdO3mnjYnLuSiJYHYGy1qNAse1poXnRq8TMBwb76I5cY52LqybcrAM3KLZLfibtvWhMu6RJ/f73MMWIi+opENkv7Gm+Fbv1n68MSe11aF9RhJoXYZQb+jgxgBBA6iFRO5UY1f4mZwduVWCa7tfLqtWUJB7iQbjDNfC46+a5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pghyOCSn; arc=fail smtp.client-ip=40.92.19.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbfk09cK98LWA0yxNtijNGM2kqa+J4kfe2p6lG/572ZFaLReKH2h1to73EOYKzyhKIv0fVCGgXSvVefKf+0PPAaR6SjAoVzFrGx4AY0v7u7aPBJ+U5H5QTMLbjbA+57mDQ5xv9ri+t4pcll6ijdehyuD4//oRrqT9oL6ryA+1rkOKk0zYsz2vUXdhdehZXZ6QXtxXB9Yhg5w0C8ycEx8epODCKxWVIyZAZol2yABlK3gcLg0nzD6juF6TxacwbOnRTtOgxPzMD1ci97nbgY5Y1q8dUzDik51RI5QKvI0jkBLViaTQqNDJT2H6b1a4aeQt6n6oGC7sYqoMfpGWLYSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a65IxjY6e72HTmx186bF3gYghuxgOuB6K0s215mY0lg=;
 b=FMKpwz9yCT01/a5P9uOt9mtP0OALRjjB1de0qI9Kb4YcOFk1X7MhyncU0sZxiG0bZbqE7xHyH67YSqImlIq0WE6ETDEHGQq50NN3OCTfVLZUslgfGEQS0ezyu/Ciyf2cY18FadPDR+GlxjkJx8pLI5sOsKfTRTaWbuMaeQ4p9cuWVKr2V0MZsGPj7+gEuaBTighX9CdLcg/wYvxtPBvRjvB79kd13Rpx7L++0GhX7hbgDk1dXO14lG2j6PzB24LwCGv81hhIc4UfBwiB3jrVy0M4NnLfUEhh75u46q7Hzy4SxosbnRdvSVBxqd9pp67YFCfcW+Nu3t/IpkXidisVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a65IxjY6e72HTmx186bF3gYghuxgOuB6K0s215mY0lg=;
 b=pghyOCSndzAgFoRcHV4WnWsu1uDEW9eauO73wQEkJkueXQe5jjXFLyuHdT1ZpOSItm2Xg03RstmsPGSRSv3sG6z1O9FO8vsg7cGZHEAndYFgIDHolRaf+g6wt3q4L0ZHEUjODhjBYGEdnnOYe77TWkbJ9aMd5csqxLv10VTxmukruhuObZ5ZfXgiooezDpyrG9hmRpO+OULkgdTa76cd4dhKk+ysJivn844ba04JmY1vcWG5Tp+vonMPlj0ymAimFVUhxaf1Aea2GOtR0GnzvNPfJDOjxJZ3mhS53aT15Iqc9u2kHZzoZ3PrqOhadXVhND1xc7Ckxb2mWJ5Uzr2wcA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB9089.namprd02.prod.outlook.com (2603:10b6:610:153::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 20:13:20 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 20:13:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, "kw@linux.com"
	<kw@linux.com>, "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "will@kernel.org" <will@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "ssengar@microsoft.com" <ssengar@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>, "vdso@hexbites.dev"
	<vdso@hexbites.dev>
Subject: RE: [PATCH v3 3/7] Drivers: hv: Provide arch-neutral implementation
 of get_vtl()
Thread-Topic: [PATCH v3 3/7] Drivers: hv: Provide arch-neutral implementation
 of get_vtl()
Thread-Index: AQHa36+rCNifEohEckuGLNQ9pio1DrIXTyywgAGYAYCAAD2PIA==
Date: Mon, 5 Aug 2024 20:13:19 +0000
Message-ID:
 <SN6PR02MB415780EB5A50A1AB769CA657D4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-4-romank@linux.microsoft.com>
 <SN6PR02MB415759676AEF931F030430FDD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <8df77874-0852-4bc2-bf8d-aa7dca031736@linux.microsoft.com>
In-Reply-To: <8df77874-0852-4bc2-bf8d-aa7dca031736@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [Rfr39EcAnnXJFm4i7DV3oW0lr/4XY5uk]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB9089:EE_
x-ms-office365-filtering-correlation-id: b40a4e0b-1f2a-4764-c2d0-08dcb58b0cb1
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 T302Xo/VtY9qubD8UkGdyNMfZzmEjgIbo25v28TatGeCC8vSMX6dFJdmql/xChuSKiuoiQZYWeVOA5Q/qX9VwyihDLGM+NfRiOOo85Iu3O5MKQUt3/9STL5OOQEiXVr74cxVLrosjNf8DXOfzc5jVlE/OiCIZhR54DNsVgdiZfXv3sHNKkFfpyM/Ijyd21DwNJ2hkZJrU+H0350ecQOJaX+n8VjlXUoqvbu6xc8ZssWLRRdSUJEhg1RBKM+F2kRANav/9mDYbyL+rDaFRaXrbIozlnRSYOGK48DbHnSCLkFmHsF89208d34+805elt744t2fpaWOXQA5yvTk3ceO/aUl1LaLkf69BjBnH9oyG/my+YLm9TR3zxvaFcWfn5fR2RWJUGidoLuMQe7/PSrd9UzTXLJAScjM5kp6z7oZ5dlLff6+xtK9CoCdBsCrBDGt9YhU4Mn47U2iO8XoTcj2Ihgx9n6sxj1Z0uJWBUdULkWmeXlklaObrwuIKeEphHrcwJSdjLQG7obveK/CWpEoRWny2tsHeeu5K73zNnG8B4heIZpmnB3wUwwZZnJXibLDLlal6PR+H8H8i6s9zlwAb65zYW5Nl258M3WlX8+oxox3vt7OUg3oFpoiIF7xdUvYPTGNZMfRG/JK/BMI3cLf1A==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXJTbXRDNWVuU05MaVArRUNIZDFjT2VGcnBWbjJzb3N5amhYZWxyN1hUdW1O?=
 =?utf-8?B?MkprMzNZeEFGelorWFNwQllUUnNKbUllZENtUEVlR2xrMGhxYWFWTDMzblJI?=
 =?utf-8?B?eHZURVRwR2JXdGQ1cUFTR0M5V3kvTGtVU2RDZFp5NnJuc1RrQUx4RUFNY09m?=
 =?utf-8?B?VnVaNmdOMXBDcUYza0ZOQXhyNEMwcEFKRk9vbE93ai90bHh1bWZVbjBDeEwv?=
 =?utf-8?B?cXdrQnhJd09iWGVkWnNES2FNR0g2Ti9nSHRiV2IyVlMwczEzRlpLVTQ0V1BU?=
 =?utf-8?B?UTJacjkwRExGc0YyU1hmQ3hZNjhHYzkxY1o0UVhwK2t1MjBOTkpPRmRkSE1F?=
 =?utf-8?B?Q3RlK0lRVjFuSWtOd0hqalE0OTdQY1laeU5pNjdWbkpSTUVBSzVZTDVNL1VD?=
 =?utf-8?B?eE5CZnVmQnlJcGdYeGpsZlJBT21IdHlEd3JFWGtWVVlUc2FNSGRVYUFLRnNi?=
 =?utf-8?B?VzIvS0VDVlMxcm8wNzhPY3VoUE8zMU01ME9JMFVCakkvM3NKTjFBd0g0QVIw?=
 =?utf-8?B?RXhPaitRWlZ6NCs4cGV0TVRIRXY1RzJ4WGVxNjk3MnlaNGpzNXVjTC82eTBS?=
 =?utf-8?B?aEFjazNxSDhQUVJIb1dWREZ5bE56VTl1TEVUajlwQ3pPZmVuUEU5Q2EzV2t1?=
 =?utf-8?B?aTZ4aE4vYUhMYzhCNWZ4T25wVmpnaTRvVjRRdDdIMy9RazJOT1NaWGxtTGFt?=
 =?utf-8?B?MzN5aUpuck4xcFNZdGVBU2ZHMnpSbVJMSG5CUTRWL2pLSXhjaGZmRGh0Yitu?=
 =?utf-8?B?ZnBoTUNOc0Y1VkJQbkI5S1lkTnhTS3RuYW85OUlmaTB5UlpOV3dkUWN4WHdF?=
 =?utf-8?B?QmZKYy9hZ2hscjZRMTB3SXFkMVAwUjE0ZUhJaDhqZkI3eUJzd3JTVUN2NVVt?=
 =?utf-8?B?MitJU3RKTUErekFSQVI4UTdYQ0g3dnhWSkxPcU5FQ21HMWFqQmQzWFRDRS9t?=
 =?utf-8?B?bkszNVJyVTE3SkQwbmpnRWRrUGQ4Y2c2bEhUTkNMbENHRENxaTdKMmRVUHVL?=
 =?utf-8?B?ajl1akhPK2NzSWdjN2VBczZWOUVmR1VVdkhjK3Z3SFBvazRmSGF1UFNoeEJO?=
 =?utf-8?B?cW9CV0gxay94WFVGQ1dFRzZ2Y015S3JTYmlKUHRNY1ZSenpHeXZDYWc3dm53?=
 =?utf-8?B?d2puWFpTQXFabFJ3K09RMDFVVUVhUGFkUHdYMzBJc1B5VUlEZS9LQWZRM3lS?=
 =?utf-8?B?K3ArcTZBSkFwbURKeXhlQ1NrdlNQSENVT21lUmhGekF6U1FoUmY4L3JweWc3?=
 =?utf-8?B?UVpKamdsczdKSk04cm9KNXhIdzJCb1FtOWRNVUx1TVllby9jUHVwQkVvUGFN?=
 =?utf-8?B?NjZiMHFZTlk3MnI5QU83WDA4Zk9mRS9GOG1pY1FPdDdoRWxKWk1rcGhwVEVt?=
 =?utf-8?B?ZzJncFJhQlRkOFdBcHhROHBYR0xFZ2h5Qmx4R01RUTFOSDhtNUpRWktyaDAx?=
 =?utf-8?B?YlZZd2dNMkZYSjQ3dTFjNlNoUzlqY1NKcUF1NmJVOHpabDI0MUNuQURMSGxn?=
 =?utf-8?B?V3c0clhKaFk3aDFGZ3AxWldlU0tEdC9rSGRZbjNBS0pRKytlcTh5TlFLNVRN?=
 =?utf-8?B?dmIxZnM2WEhST2NFWkd3aTUvNjU3TC9IeUNiYWRlQXhRUTFIYmU2ZU8wQ3Z6?=
 =?utf-8?Q?IIseMlHBnkiihiXynJz1Fu/NWSWlXtpnGId2S3ljhRt0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b40a4e0b-1f2a-4764-c2d0-08dcb58b0cb1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 20:13:19.7408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9089

RnJvbTogUm9tYW4gS2lzZWwgPHJvbWFua0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIEF1Z3VzdCA1LCAyMDI0IDk6MjAgQU0NCj4gDQo+IE9uIDgvNC8yMDI0IDg6MDIgUE0sIE1p
Y2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IFJvbWFuIEtpc2VsIDxyb21hbmtAbGludXgu
bWljcm9zb2Z0LmNvbT4gU2VudDogRnJpZGF5LCBKdWx5IDI2LCAyMDI0IDM6NTkNCj4gUE0NCj4g
Pj4NCj4gPj4gVG8gcnVuIGluIHRoZSBWVEwgbW9kZSwgSHlwZXItViBkcml2ZXJzIGhhdmUgdG8g
a25vdyB3aGF0DQo+ID4+IFZUTCB0aGUgc3lzdGVtIGJvb3RzIGluLCBhbmQgdGhlIGFybTY0L2h5
cGVydiBjb2RlIGRvZXMgbm90DQo+ID4+IGhhdmUgdGhlIG1lYW5zIHRvIGNvbXB1dGUgdGhhdC4N
Cj4gPj4NCj4gPj4gUmVmYWN0b3IgdGhlIGNvZGUgdG8gaG9pc3QgdGhlIGZ1bmN0aW9uIHRoYXQg
ZGV0ZWN0cyBWVEwsDQo+ID4+IG1ha2UgaXQgYXJjaC1uZXV0cmFsIHRvIGJlIGFibGUgdG8gZW1w
bG95IGl0IHRvIGdldCB0aGUgVlRMDQo+ID4+IG9uIGFybTY0LiBGaXggdGhlIGh5cGVyY2FsbCBv
dXRwdXQgYWRkcmVzcyBpbiBgZ2V0X3Z0bCh2b2lkKWANCj4gPj4gbm90IHRvIG92ZXJsYXAgd2l0
aCB0aGUgaHlwZXJjYWxsIGlucHV0IGFyZWEgdG8gYWRoZXJlIHRvDQo+ID4+IHRoZSBIeXBlci1W
IFRMRlMuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFJvbWFuIEtpc2VsIDxyb21hbmtAbGlu
dXgubWljcm9zb2Z0LmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgYXJjaC94ODYvaHlwZXJ2L2h2X2lu
aXQuYyAgICAgICAgICB8IDM0IC0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+PiAgIGFyY2gveDg2
L2luY2x1ZGUvYXNtL2h5cGVydi10bGZzLmggfCAgNyAtLS0tLQ0KPiA+PiAgIGRyaXZlcnMvaHYv
aHZfY29tbW9uLmMgICAgICAgICAgICAgfCA0NyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0NCj4gPj4gICBpbmNsdWRlL2FzbS1nZW5lcmljL2h5cGVydi10bGZzLmggIHwgIDcgKysrKysN
Cj4gPj4gICBpbmNsdWRlL2FzbS1nZW5lcmljL21zaHlwZXJ2LmggICAgIHwgIDYgKysrKw0KPiA+
PiAgIDUgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKSwgNDMgZGVsZXRpb25zKC0pDQo+
ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jIGIvYXJjaC94
ODYvaHlwZXJ2L2h2X2luaXQuYw0KPiA+PiBpbmRleCAxN2E3MWU5MmEzNDMuLmMzNTBmYTA1ZWU1
OSAxMDA2NDQNCj4gPj4gLS0tIGEvYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYw0KPiA+PiArKysg
Yi9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jDQo+ID4+IEBAIC00MTMsNDAgKzQxMyw2IEBAIHN0
YXRpYyB2b2lkIF9faW5pdCBodl9nZXRfcGFydGl0aW9uX2lkKHZvaWQpDQo+ID4+ICAgCWxvY2Fs
X2lycV9yZXN0b3JlKGZsYWdzKTsNCj4gPj4gICB9DQo+ID4+DQo+ID4+IC0jaWYgSVNfRU5BQkxF
RChDT05GSUdfSFlQRVJWX1ZUTF9NT0RFKQ0KPiA+PiAtc3RhdGljIHU4IF9faW5pdCBnZXRfdnRs
KHZvaWQpDQo+ID4+IC17DQo+ID4+IC0JdTY0IGNvbnRyb2wgPSBIVl9IWVBFUkNBTExfUkVQX0NP
TVBfMSB8IEhWQ0FMTF9HRVRfVlBfUkVHSVNURVJTOw0KPiA+PiAtCXN0cnVjdCBodl9nZXRfdnBf
cmVnaXN0ZXJzX2lucHV0ICppbnB1dDsNCj4gPj4gLQlzdHJ1Y3QgaHZfZ2V0X3ZwX3JlZ2lzdGVy
c19vdXRwdXQgKm91dHB1dDsNCj4gPj4gLQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+PiAtCXU2
NCByZXQ7DQo+ID4+IC0NCj4gPj4gLQlsb2NhbF9pcnFfc2F2ZShmbGFncyk7DQo+ID4+IC0JaW5w
dXQgPSAqdGhpc19jcHVfcHRyKGh5cGVydl9wY3B1X2lucHV0X2FyZyk7DQo+ID4+IC0Jb3V0cHV0
ID0gKHN0cnVjdCBodl9nZXRfdnBfcmVnaXN0ZXJzX291dHB1dCAqKWlucHV0Ow0KPiA+PiAtDQo+
ID4+IC0JbWVtc2V0KGlucHV0LCAwLCBzdHJ1Y3Rfc2l6ZShpbnB1dCwgZWxlbWVudCwgMSkpOw0K
PiA+PiAtCWlucHV0LT5oZWFkZXIucGFydGl0aW9uaWQgPSBIVl9QQVJUSVRJT05fSURfU0VMRjsN
Cj4gPj4gLQlpbnB1dC0+aGVhZGVyLnZwaW5kZXggPSBIVl9WUF9JTkRFWF9TRUxGOw0KPiA+PiAt
CWlucHV0LT5oZWFkZXIuaW5wdXR2dGwgPSAwOw0KPiA+PiAtCWlucHV0LT5lbGVtZW50WzBdLm5h
bWUwID0gSFZfWDY0X1JFR0lTVEVSX1ZTTV9WUF9TVEFUVVM7DQo+ID4+IC0NCj4gPj4gLQlyZXQg
PSBodl9kb19oeXBlcmNhbGwoY29udHJvbCwgaW5wdXQsIG91dHB1dCk7DQo+ID4+IC0JaWYgKGh2
X3Jlc3VsdF9zdWNjZXNzKHJldCkpIHsNCj4gPj4gLQkJcmV0ID0gb3V0cHV0LT5hczY0LmxvdyAm
IEhWX1g2NF9WVExfTUFTSzsNCj4gPj4gLQl9IGVsc2Ugew0KPiA+PiAtCQlwcl9lcnIoIkZhaWxl
ZCB0byBnZXQgVlRMKGVycm9yOiAlbGxkKSBleGl0aW5nLi4uXG4iLCByZXQpOw0KPiA+PiAtCQlC
VUcoKTsNCj4gPj4gLQl9DQo+ID4+IC0NCj4gPj4gLQlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7
DQo+ID4+IC0JcmV0dXJuIHJldDsNCj4gPj4gLX0NCj4gPj4gLSNlbHNlDQo+ID4+IC1zdGF0aWMg
aW5saW5lIHU4IGdldF92dGwodm9pZCkgeyByZXR1cm4gMDsgfQ0KPiA+PiAtI2VuZGlmDQo+ID4+
IC0NCj4gPj4gICAvKg0KPiA+PiAgICAqIFRoaXMgZnVuY3Rpb24gaXMgdG8gYmUgaW52b2tlZCBl
YXJseSBpbiB0aGUgYm9vdCBzZXF1ZW5jZSBhZnRlciB0aGUNCj4gPj4gICAgKiBoeXBlcnZpc29y
IGhhcyBiZWVuIGRldGVjdGVkLg0KPiA+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9h
c20vaHlwZXJ2LXRsZnMuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZzLmgNCj4g
Pj4gaW5kZXggMzc4N2QyNjgxMGMxLi45ZWU2OGViOGU2ZmYgMTAwNjQ0DQo+ID4+IC0tLSBhL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2h5cGVydi10bGZzLmgNCj4gPj4gKysrIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vaHlwZXJ2LXRsZnMuaA0KPiA+PiBAQCAtMzA5LDEzICszMDksNiBAQCBlbnVtIGh2
X2lzb2xhdGlvbl90eXBlIHsNCj4gPj4gICAjZGVmaW5lIEhWX01TUl9TVElNRVIwX0NPTkZJRwko
SFZfWDY0X01TUl9TVElNRVIwX0NPTkZJRykNCj4gPj4gICAjZGVmaW5lIEhWX01TUl9TVElNRVIw
X0NPVU5UCShIVl9YNjRfTVNSX1NUSU1FUjBfQ09VTlQpDQo+ID4+DQo+ID4+IC0vKg0KPiA+PiAt
ICogUmVnaXN0ZXJzIGFyZSBvbmx5IGFjY2Vzc2libGUgdmlhIEhWQ0FMTF9HRVRfVlBfUkVHSVNU
RVJTIGh2Y2FsbCBhbmQNCj4gPj4gLSAqIHRoZXJlIGlzIG5vdCBhc3NvY2lhdGVkIE1TUiBhZGRy
ZXNzLg0KPiA+PiAtICovDQo+ID4+IC0jZGVmaW5lCUhWX1g2NF9SRUdJU1RFUl9WU01fVlBfU1RB
VFVTCTB4MDAwRDAwMDMNCj4gPj4gLSNkZWZpbmUJSFZfWDY0X1ZUTF9NQVNLCQkJR0VOTUFTSygz
LCAwKQ0KPiA+PiAtDQo+ID4+ICAgLyogSHlwZXItViBtZW1vcnkgaG9zdCB2aXNpYmlsaXR5ICov
DQo+ID4+ICAgZW51bSBodl9tZW1faG9zdF92aXNpYmlsaXR5IHsNCj4gPj4gICAJVk1CVVNfUEFH
RV9OT1RfVklTSUJMRQkJPSAwLA0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi9odl9jb21t
b24uYyBiL2RyaXZlcnMvaHYvaHZfY29tbW9uLmMNCj4gPj4gaW5kZXggOWM0NTJiZmJkNTcxLi43
ZDZjMTUyM2IwYjUgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvaHYvaHZfY29tbW9uLmMNCj4g
Pj4gKysrIGIvZHJpdmVycy9odi9odl9jb21tb24uYw0KPiA+PiBAQCAtMzM5LDggKzMzOSw4IEBA
IGludCBfX2luaXQgaHZfY29tbW9uX2luaXQodm9pZCkNCj4gPj4gICAJaHlwZXJ2X3BjcHVfaW5w
dXRfYXJnID0gYWxsb2NfcGVyY3B1KHZvaWQgICopOw0KPiA+PiAgIAlCVUdfT04oIWh5cGVydl9w
Y3B1X2lucHV0X2FyZyk7DQo+ID4+DQo+ID4+IC0JLyogQWxsb2NhdGUgdGhlIHBlci1DUFUgc3Rh
dGUgZm9yIG91dHB1dCBhcmcgZm9yIHJvb3QgKi8NCj4gPj4gLQlpZiAoaHZfcm9vdF9wYXJ0aXRp
b24pIHsNCj4gPj4gKwkvKiBBbGxvY2F0ZSB0aGUgcGVyLUNQVSBzdGF0ZSBmb3Igb3V0cHV0IGFy
ZyBmb3Igcm9vdCBvciBhIFZUTCAqLw0KPiA+PiArCWlmIChodl9yb290X3BhcnRpdGlvbiB8fCBJ
U19FTkFCTEVEKENPTkZJR19IWVBFUlZfVlRMX01PREUpKSB7DQo+ID4+ICAgCQloeXBlcnZfcGNw
dV9vdXRwdXRfYXJnID0gYWxsb2NfcGVyY3B1KHZvaWQgKik7DQo+ID4+ICAgCQlCVUdfT04oIWh5
cGVydl9wY3B1X291dHB1dF9hcmcpOw0KPiA+PiAgIAl9DQo+ID4+IEBAIC02NTYsMyArNjU2LDQ2
IEBAIHU2NCBfX3dlYWsgaHZfdGR4X2h5cGVyY2FsbCh1NjQgY29udHJvbCwgdTY0IHBhcmFtMSwg
dTY0IHBhcmFtMikNCj4gPj4gICAJcmV0dXJuIEhWX1NUQVRVU19JTlZBTElEX1BBUkFNRVRFUjsN
Cj4gPj4gICB9DQo+ID4+ICAgRVhQT1JUX1NZTUJPTF9HUEwoaHZfdGR4X2h5cGVyY2FsbCk7DQo+
ID4+ICsNCj4gPj4gKyNpZiBJU19FTkFCTEVEKENPTkZJR19IWVBFUlZfVlRMX01PREUpDQo+ID4+
ICt1OCBfX2luaXQgZ2V0X3Z0bCh2b2lkKQ0KPiA+PiArew0KPiA+PiArCXU2NCBjb250cm9sID0g
SFZfSFlQRVJDQUxMX1JFUF9DT01QXzEgfCBIVkNBTExfR0VUX1ZQX1JFR0lTVEVSUzsNCj4gPj4g
KwlzdHJ1Y3QgaHZfZ2V0X3ZwX3JlZ2lzdGVyc19pbnB1dCAqaW5wdXQ7DQo+ID4+ICsJc3RydWN0
IGh2X2dldF92cF9yZWdpc3RlcnNfb3V0cHV0ICpvdXRwdXQ7DQo+ID4+ICsJdW5zaWduZWQgbG9u
ZyBmbGFnczsNCj4gPj4gKwl1NjQgcmV0Ow0KPiA+PiArDQo+ID4+ICsJbG9jYWxfaXJxX3NhdmUo
ZmxhZ3MpOw0KPiA+PiArCWlucHV0ID0gKnRoaXNfY3B1X3B0cihoeXBlcnZfcGNwdV9pbnB1dF9h
cmcpOw0KPiA+PiArCW91dHB1dCA9ICp0aGlzX2NwdV9wdHIoaHlwZXJ2X3BjcHVfb3V0cHV0X2Fy
Zyk7DQo+ID4NCj4gPiBSYXRoZXIgdGhhbiB1c2UgdGhlIGh5cGVydl9wY3B1X291dHB1dF9hcmcg
aGVyZSwgaXQncyBPSyB0bw0KPiA+IHVzZSBhIGRpZmZlcmVudCBhcmVhIG9mIHRoZSBoeXBlcnZf
cGNwdV9pbnB1dF9hcmcgcGFnZS4gIEZvcg0KPiA+IGV4YW1wbGUsDQo+ID4NCj4gPiAJb3V0cHV0
ID0gKHZvaWQgKilpbnB1dCArIEhWX0hZUF9QQUdFX1NJWkUvMjsNCj4gPg0KPiA+IFRoZSBUTEZT
IGRvZXMgbm90IHJlcXVpcmUgdGhhdCB0aGUgaW5wdXQgYW5kIG91dHB1dCBiZSBpbg0KPiA+IHNl
cGFyYXRlIHBhZ2VzLg0KPiA+DQo+ID4gV2hpbGUgdXNpbmcgdGhlIGh5cGVydl9wY3B1X291dHB1
dF9hcmcgaXMgY29uY2VwdHVhbGx5IGENCj4gPiBiaXQgY2xlYW5lciwgZG9pbmcgc28gcmVxdWly
ZXMgYWxsb2NhdGluZyBhIDRLIHBhZ2UgcGVyIENQVSB0aGF0DQo+ID4gaXMgbm90IG90aGVyd2lz
ZSB1c2VkLiBUaGUgVlRMIDIgY29kZSB3YW50cyB0byBiZSBmcnVnYWwgd2l0aA0KPiA+IG1lbW9y
eSwgYW5kIHRoaXMgc2VlbXMgbGlrZSBhIGdvb2Qgc3RlcCBpbiB0aGF0IGRpcmVjdGlvbi4gOi0p
DQo+ID4NCj4gSSBhZ3JlZSBvbiB0aGUgYm90aCBjb3VudHM6IHRoZSBjb2RlIGxvb2tzIGNvbmNl
cHR1YWxseSBjbGVhbmVyIG5vdyBhbmQNCj4gVlRMMiB3YW50cyB0byBiZSBmcnVnYWwgd2l0aCBt
ZW1vcnksIGVzcCB0aGF0IHRoZSBvdXRwdXQgaHlwZXJjYWxsIHBhZ2UNCj4gaXMgcGVyLUNQVSBz
byB3ZSBoYXZlIE8obikgYXMgdGhlIENQVSBjb3VudCBpbmNyZWFzZXMuIFN0aWxsLCB0aGUgb3V0
cHV0DQo+IHBhZ2Ugd2lsbCBiZSBuZWVkZWQgZm9yIFZUTDIgKHNheSB0byBnZXQvc2V0IHJlZ2lz
dGVycyBqdXN0IGFzIGRvbmUNCj4gaGVyZSkuIFRoYXQgc2FpZCwgd2l0aCB0aGlzIHBhdGNoIHdl
IGNhbiBhY2hpZXZlIGJvdGggdGhlIGNvbmNlcHR1YWwNCj4gY2xlYW5saW5lc3MgYW5kIGJlaW5n
IHJlYWR5IHRvIGdyb3cgbW9yZSBvbiB0aGUgcHJpbWl0aXZlcyBiZWluZyBidWlsdA0KPiBvdXQg
aW4gdGhlIFZUTCBzdXBwb3J0IHBhdGNoZXMuDQo+IA0KDQpDb3VsZCB5b3UgZWxhYm9yYXRlIGZ1
cnRoZXIgb24gd2h5IHRoZSBvdXRwdXQgcGFnZSBpcyBuZWVkZWQgZm9yDQpWVEwyPyBUaGUgZ2V0
L3NldCByZWdpc3RlciBoeXBlcmNhbGxzIGNhbiBvcGVyYXRlIHdpdGgganVzdCB0aGUgaW5wdXQN
CnBhZ2UgKGFnYWluLCBzcGxpdHRpbmcgaXQgaW50byB0d28gaGFsdmVzIGZvciBpbnB1dCBhbmQg
b3V0cHV0IGFyZ3MpIGFzDQpsb25nIGFzIHRoZSBudW1iZXIgb2YgcmVnaXN0ZXJzIGFjdGVkIG9u
IGJ5IGEgc2luZ2xlIGh5cGVyY2FsbCBpc24ndA0KbW9yZSB0aGFuIGEgZmV3IGRvemVuLg0KDQpJ
ZiB5b3UgcmVhbGx5ICpkbyogbmVlZCB0aGUgb3V0cHV0IHBhZ2UgaW4gVlRMMiBmb3Igb3RoZXIg
cmVhc29ucw0KdGhhdCBJJ20gbm90IGF3YXJlIG9mLCB0aGVuIG15IHN1Z2dlc3Rpb24gaXNuJ3Qg
cmVsZXZhbnQgYW5kIHRoZXJlJ3MNCm5vIG1lbW9yeSB0byBiZSBzYXZlZC4NCg0KTWljaGFlbA0K


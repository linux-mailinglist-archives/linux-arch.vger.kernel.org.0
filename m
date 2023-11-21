Return-Path: <linux-arch+bounces-297-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05A77F2346
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 02:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310DAB21490
	for <lists+linux-arch@lfdr.de>; Tue, 21 Nov 2023 01:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B54579D1;
	Tue, 21 Nov 2023 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="w5qGAQHj"
X-Original-To: linux-arch@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A784C7;
	Mon, 20 Nov 2023 17:44:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8mL5xn/VL10GPjqsuroWjcaFPOVNyOzy92OdupKVksXWsTsFGUfk8XvF1kT+8Bm8x0+/Ap2kfXoadhb5bln45nKuoz040aqJFHegzkXJgKbp1FqulqoHCEMVubU3sXZTnAwkCRBbRP6ffisgKaJ5PbO2NLxUNPvx94jbmHCHZrWnsHXEAq2qB4O8OTtQF5kfCqj5ubFnSW28Uio+SE1ZCL7avKgqZQJhnhb/scaiNlIQPt8Rc+orJ7sot+wzQX6dgPlyDpJchA/jI6SbE8SGoLpZYwRRjsBBDPH4aHeVKdexZdLrNrdnONLA17XRonTjG0g1Ndzjx6mSNGNIRj2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeV99m1vCdLYWgl2U9ol+duFBCt5rPx4NUJan21Hf0Y=;
 b=IekfI6qPZCMq0f+cXVyWjjOYFMJwHJWj24U332oSVYx9fTVbtQ7jH/N8AblOKD0MqwPYI8W8vqqSSfsXcMKk1ujOzOpscETalImkJtPwRPgItLRbVFJDedIKqC4hti8OJqkpOvxa+XR9S3nvj8x0xhRqGEGlwGczGMl4teJR9X1GgeshITk40bzxb9lE6j3X/Uma01WkPYG/zGlXQjmNxIOpyeRbDTINvBHvSuZ5gUAdOduIU1CsWXy90hyPE+NMLSN1UqBUEwcF+P/VY+sQgMCKx6q/crKD4D2AgDnXtwPxo4mGREGxzbYjt8x7EXbHDZpRA/AkJusBlc0mOEygPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeV99m1vCdLYWgl2U9ol+duFBCt5rPx4NUJan21Hf0Y=;
 b=w5qGAQHj+uexYTZTQH0wnX/6YJMb0+esWVxgeLYLx5S2hP37avwQcAQHOZkPXBQNKI+hhQbzPj30bZIKXVwXgon7GYYfYumslMSQREnyWHDLsN7DNKs4jTJ78ISYxOnBDOnM8vR6l5tXmi9+yX/FR3p2k7nwvU5FSqiknpqJCr0=
Received: from DB9PR08MB7511.eurprd08.prod.outlook.com (2603:10a6:10:302::21)
 by DB9PR08MB6444.eurprd08.prod.outlook.com (2603:10a6:10:23c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 01:44:20 +0000
Received: from DB9PR08MB7511.eurprd08.prod.outlook.com
 ([fe80::ed8d:8ab6:c458:5b29]) by DB9PR08MB7511.eurprd08.prod.outlook.com
 ([fe80::ed8d:8ab6:c458:5b29%6]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 01:44:20 +0000
From: Jianyong Wu <Jianyong.Wu@arm.com>
To: Russell King <linux@armlinux.org.uk>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, Salil Mehta
	<salil.mehta@huawei.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Justin He <Justin.He@arm.com>, James Morse <James.Morse@arm.com>, Catalin
 Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Mark
 Rutland <Mark.Rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: RE: [PATCH 34/39] arm64: psci: Ignore DENIED CPUs
Thread-Topic: [PATCH 34/39] arm64: psci: Ignore DENIED CPUs
Thread-Index: AQHaBo11gHYttES/S0yWYrYSBJZEoLB8s2AggAZmR4CAAAIx4IAAByeAgAEH5DA=
Date: Tue, 21 Nov 2023 01:44:20 +0000
Message-ID:
 <DB9PR08MB7511C861A96B1206ED685AD8F4BBA@DB9PR08MB7511.eurprd08.prod.outlook.com>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
 <E1qvJBQ-00AqS8-8B@rmk-PC.armlinux.org.uk>
 <DB9PR08MB7511B178CA811C412766FDBAF4B0A@DB9PR08MB7511.eurprd08.prod.outlook.com>
 <ZVsl1ZQ9JRXPf4qH@shell.armlinux.org.uk>
 <DB9PR08MB7511C8825028074748FBB967F4B4A@DB9PR08MB7511.eurprd08.prod.outlook.com>
 <ZVstq+vhQSP73Nua@shell.armlinux.org.uk>
In-Reply-To: <ZVstq+vhQSP73Nua@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ts-tracking-id: 0F087C03B5B76740A2DB7146F83F6C3A.0
x-checkrecipientchecked: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR08MB7511:EE_|DB9PR08MB6444:EE_
x-ms-office365-filtering-correlation-id: e412b7dd-6f59-4eb8-6c37-08dbea3361d3
nodisclaimer: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ae/byACqSBX+Dc4j2pPyamqnUs0Rvf1iS0FlSHynXXkQTEvDq3u4kDsr7sEKjz0gDAsR4C821vS4UfYKWegFbdOjBpbakP9DI7Vs8fQUz+6SrjD+NrOeka1srWTwhlNtFkeP3D9CHGMlmi76HuwAKFX9j65iKAwrKBabMOSfm3CR4Ml7DRFWyzN22RBksjRggk4pDSh6ksRHYSx2Oo656LoPVHRq8+RM2k+JXMywJNJtjrBaJSfhtkNcBN7B+It+6XYxIHhuRT05vMYaGJDO98g3KzEfEuYx8ah8UX/H7ymFkIblcvSvcMMw938dFAjNdENLN5fICxgAyMtoWBwU6jV6r9SMEJ1Z1yzf5KTRFBYJqCnYo0n3K0SqgKHrkNCUY1Z2hwJxRMUI7S1Pz8p3tUTKtaFNN7u7cYNNgS6DL3FnNAaoLxlzu7Y0RXKS+wE8IJGPsP9vBrFopdopxxWkoJXZucJlzjcBQ/EujEDKfRF0VqlpfjsbdaCz9d8BSJsXCLuudjg/VVvYQH6rx5P8l9D8RHqLWUd8IRuYA8PnouyWM2RpT0Yr6ltDQECInca34GdoZsRjZcPWTo0JCUMKp9vtuXg9zrQJpZ4BIcer4/k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7511.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(76116006)(66946007)(66556008)(316002)(6916009)(64756008)(66446008)(66476007)(54906003)(26005)(52536014)(8936002)(4326008)(8676002)(38070700009)(38100700002)(41300700001)(122000001)(33656002)(86362001)(2906002)(5660300002)(7416002)(966005)(83380400001)(478600001)(55016003)(9686003)(53546011)(7696005)(6506007)(45080400002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlZDYU9KdTdFeTRENkhKMDNKZmloWHRid2NkZmdxNEg5NFJFQlJrZGc1VTdz?=
 =?utf-8?B?ajJvcytubkprTDYvNmVFdWcyR0d6K0lZS2hZMUxVODJlWHgxWUkzYUZHS0xt?=
 =?utf-8?B?TnJHdTVDYWIxUmZtNUlld2ZmUWlFQU1vTVRsQVVOOUtVZGVPNklGbmF5NG1U?=
 =?utf-8?B?RnZDdllObHZMcVd1T2k4QXhXOVJaVXpQSWN0NHpGSU15dHQvaGQ3SGJBVDhQ?=
 =?utf-8?B?Y2JpMUtZMGtHa3ZyUTd6RU13bWh6M0c2cTBET2dxTnk1S25ZdHhhQnRKQnEz?=
 =?utf-8?B?S2F3SXFZOEJSeDRsbE4wSlpSKzVBQVVZSm54cENyYk53U2g0UmVsTUl0a2dy?=
 =?utf-8?B?WXFaZFk0NEFmc3RGU3BzWkpNNVVhdWRZYWFHb1g4MWJBZURraHVaOFFlanlC?=
 =?utf-8?B?UzVVYWYyQVdyakxoWldUN0lCQ2pqeFJ3Y2loOFhTN2kvYklLeW9MN2JoRCtI?=
 =?utf-8?B?VThNd0RsVWsxdXREMVdvdFFYakxmQ21DQ1IvTnZ1aDF2NlV1Q1IxUjdmbndU?=
 =?utf-8?B?aCtTQnFVTUlPZDF1RzR2MkpQcnU2dE5uOWFOWFVabDV5WVNSQ29uUkNpbUVw?=
 =?utf-8?B?cTM2MUQ4bnMrK2pYOTZWemNkdXJldVZDbE5HYnZvUXdhYmJPTnFoMEhmYVFi?=
 =?utf-8?B?aFpyKzgrNSttVUNWTHdMVlE0c3FiWXR5cTkzNjd5SGZQdnhxcDZaWTNCWUNa?=
 =?utf-8?B?UWZGdEl6ZnQ5amhKT0xYWFQwS3VsNHcxOHB2aXlXbE8ybnh2djBxYk93MXFX?=
 =?utf-8?B?dHRlMXdzZG9mSEtnYmVPb1VCQ0F4OUV3a0RFOGdwRTJXTzdvd2tka1FiM3Bk?=
 =?utf-8?B?eFpYR2tEQVk4MVdqMWVpSklqL1Z5Vm9uSGV3VnRzZzQ2ME9qMCtnYUdRQ2tq?=
 =?utf-8?B?MzFGRXNweGJKRjc5T25Nd2Q0ODVWOUtJbzNwUytLNklHV1NWR3k4N3VhTmo3?=
 =?utf-8?B?L2hIOGpGQ2dYOHEvdXI2bFo1ZnhLRXdYOXRNeWNMT1lJZDhFb2xRTnBvaXIw?=
 =?utf-8?B?cHhueDhLaUhBNE91SVNxUXI5aEZvaWxpTUxrcVVDWnRYU2dtZXJ6MjZ5Tzla?=
 =?utf-8?B?Mmk1My9sVUNmZmRuMFlGL2RCL0l6eUUzOE80N1hzbWN4K3NWdzM3cEVJVnZ3?=
 =?utf-8?B?bEI2QXY4QTVGL3ZzMldkMlhwdDBDS0dnS25FcGg5QWo0OU90dzZNSmhKTmY2?=
 =?utf-8?B?bjJmSDVPckE4ZUQ0ckhaaXZmZnJnNEdURzBUbVNPdHJqWjdNUE9lZTc0NFVC?=
 =?utf-8?B?RGowMlhrMk1rYmlnV3UyRVVRMG95ZmpaK2NXQzg3MnZSZ2huek5qTC9uSXh2?=
 =?utf-8?B?K1BmTWloZUloZmd4alFXaFFTVTF6alZmMy9CazNwNWw3b0hvSmNXa2VJdGlv?=
 =?utf-8?B?TldaNzR5ekFkYmx6YjByVnlzeDJaamwzMDJ5UDBNcWlNVnVkbHFhanJ5Qk9Q?=
 =?utf-8?B?c2U2bGZQeFdaeFhmeFZjWjZVUGF5bFFCSHhmSGxwdnNFTWxiNnVpV2w3bzZm?=
 =?utf-8?B?clFrV3h3YnRBZmZkRnVsTFhmRzBxZW01SGRkRDVjWmhzRGpOdkFIcmVqTWhY?=
 =?utf-8?B?WjI0TVRYMzlSbExjeGNpZTVHdit4YmhmVWY5ejVQQlM2WmNqMXhqYURLQjA2?=
 =?utf-8?B?b2tEeCs1ck83R081RlNhTmdCVyt4bElXZ2gyanM1Z0IxRytsWTFLQjZlcWRx?=
 =?utf-8?B?UDVJU1J5ZnF5QlU1L0QxUlh3dHpBNG9sSjNsVGU3eXBZTkNNdXRjY0VPRWFv?=
 =?utf-8?B?aE1WckdnTXEydkJyWTRJKzU5K09GUVdrajhod1FydEI1L3ZIZEpVb1pzS2M0?=
 =?utf-8?B?TjNPa3R0Z3ZwODFLR3J1bms3Sk1sVEZNRlRXdlF5NnB3eDJtcENsZit1ZVJv?=
 =?utf-8?B?YVJUNUdoMGY4SURjcFMxR1hHM0pVMkVldEg0ZzV4VGlUUnBwZUNpVFJZUkV4?=
 =?utf-8?B?SU1BOENNUG1jLy9HTW01cU00WnlFbzRVTU1nVzJiYVZMMFYrL2t3NllKZ1c0?=
 =?utf-8?B?UlV0QklYYThaM0dJaXpnMlFWR1J5azVycEhhUmFaNVFYczJpZkdCKzUrSzJB?=
 =?utf-8?B?d3MrRHBpZDZudUNJamt3Zmx0TkdTUjcwcnk2bHRValJFYi9NYSt3S0cwU1Rr?=
 =?utf-8?Q?NXntFfz9Okgoglm2LwML32hXB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB7511.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e412b7dd-6f59-4eb8-6c37-08dbea3361d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 01:44:20.8370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vbboXnN8zPTGRoZKUm5qVeKWecQJvzdcEi66GvmE6zJrzUoCpVihSu50tN32wYzV+nRxfnl8yW0Z95qu52dwaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6444

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUnVzc2VsbCBLaW5nIDxs
aW51eEBhcm1saW51eC5vcmcudWs+DQo+IFNlbnQ6IDIwMjPlubQxMeaciDIw5pelIDE3OjU4DQo+
IFRvOiBKaWFueW9uZyBXdSA8SmlhbnlvbmcuV3VAYXJtLmNvbT4NCj4gQ2M6IGxpbnV4LXBtQHZn
ZXIua2VybmVsLm9yZzsgbG9vbmdhcmNoQGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgtYWNwaUB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGt2bWFybUBsaXN0cy5saW51eC5k
ZXY7IHg4NkBrZXJuZWwub3JnOw0KPiBsaW51eC1jc2t5QHZnZXIua2VybmVsLm9yZzsgbGludXgt
ZG9jQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtaWE2NEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXBhcmlzY0B2Z2VyLmtlcm5lbC5vcmc7IFNhbGlsIE1laHRhDQo+IDxzYWxpbC5tZWh0YUBodWF3
ZWkuY29tPjsgSmVhbi1QaGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+
Ow0KPiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPjsgSmFtZXMgTW9yc2UgPEphbWVzLk1v
cnNlQGFybS5jb20+Ow0KPiBDYXRhbGluIE1hcmluYXMgPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29t
PjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47DQo+IE1hcmsgUnV0bGFuZCA8TWFyay5S
dXRsYW5kQGFybS5jb20+OyBMb3JlbnpvIFBpZXJhbGlzaQ0KPiA8bHBpZXJhbGlzaUBrZXJuZWwu
b3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDM0LzM5XSBhcm02NDogcHNjaTogSWdub3JlIERF
TklFRCBDUFVzDQo+IA0KPiBPbiBNb24sIE5vdiAyMCwgMjAyMyBhdCAwOTozNjowNUFNICswMDAw
LCBKaWFueW9uZyBXdSB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogUnVzc2VsbCBLaW5nIDxsaW51eEBhcm1saW51eC5vcmcudWs+
DQo+ID4gPiBTZW50OiAyMDIz5bm0MTHmnIgyMOaXpSAxNzoyNQ0KPiA+ID4gVG86IEppYW55b25n
IFd1IDxKaWFueW9uZy5XdUBhcm0uY29tPg0KPiA+ID4gQ2M6IGxpbnV4LXBtQHZnZXIua2VybmVs
Lm9yZzsgbG9vbmdhcmNoQGxpc3RzLmxpbnV4LmRldjsNCj4gPiA+IGxpbnV4LWFjcGlAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsN
Cj4gPiA+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGt2bWFybUBsaXN0cy5saW51
eC5kZXY7DQo+ID4gPiB4ODZAa2VybmVsLm9yZzsgbGludXgtY3NreUB2Z2VyLmtlcm5lbC5vcmc7
DQo+ID4gPiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1pYTY0QHZnZXIua2VybmVs
Lm9yZzsNCj4gPiA+IGxpbnV4LXBhcmlzY0B2Z2VyLmtlcm5lbC5vcmc7IFNhbGlsIE1laHRhIDxz
YWxpbC5tZWh0YUBodWF3ZWkuY29tPjsNCj4gPiA+IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVh
bi1waGlsaXBwZUBsaW5hcm8ub3JnPjsgSnVzdGluIEhlDQo+ID4gPiA8SnVzdGluLkhlQGFybS5j
b20+OyBKYW1lcyBNb3JzZSA8SmFtZXMuTW9yc2VAYXJtLmNvbT47IENhdGFsaW4NCj4gPiA+IE1h
cmluYXMgPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFjb24gPHdpbGxAa2VybmVs
Lm9yZz47DQo+ID4gPiBNYXJrIFJ1dGxhbmQgPE1hcmsuUnV0bGFuZEBhcm0uY29tPjsgTG9yZW56
byBQaWVyYWxpc2kNCj4gPiA+IDxscGllcmFsaXNpQGtlcm5lbC5vcmc+DQo+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIDM0LzM5XSBhcm02NDogcHNjaTogSWdub3JlIERFTklFRCBDUFVzDQo+ID4g
Pg0KPiA+ID4gT24gVGh1LCBOb3YgMTYsIDIwMjMgYXQgMDc6NDU6NTFBTSArMDAwMCwgSmlhbnlv
bmcgV3Ugd3JvdGU6DQo+ID4gPiA+IEhpIFJ1c3NlbGwsDQo+ID4gPiA+DQo+ID4gPiA+IE9uZSBp
bmxpbmUgY29tbWVudC4NCj4gPiA+IC4uLg0KPiA+ID4gPiA+IENoYW5nZXMgc2luY2UgUkZDIHYy
DQo+ID4gPiA+ID4gICogQWRkIHNwZWNpZmljYXRpb24gcmVmZXJlbmNlDQo+ID4gPiA+ID4gICog
VXNlIEVQRVJNIHJhdGhlciB0aGFuIEVQUk9CRV9ERUZFUg0KPiA+ID4gLi4uDQo+ID4gPiA+ID4g
QEAgLTQwLDcgKzQwLDcgQEAgc3RhdGljIGludCBjcHVfcHNjaV9jcHVfYm9vdCh1bnNpZ25lZCBp
bnQgY3B1KSAgew0KPiA+ID4gPiA+ICAJcGh5c19hZGRyX3QgcGFfc2Vjb25kYXJ5X2VudHJ5ID0g
X19wYV9zeW1ib2woc2Vjb25kYXJ5X2VudHJ5KTsNCj4gPiA+ID4gPiAgCWludCBlcnIgPSBwc2Np
X29wcy5jcHVfb24oY3B1X2xvZ2ljYWxfbWFwKGNwdSksDQo+IHBhX3NlY29uZGFyeV9lbnRyeSk7
DQo+ID4gPiA+ID4gLQlpZiAoZXJyKQ0KPiA+ID4gPiA+ICsJaWYgKGVyciAmJiBlcnIgIT0gLUVQ
Uk9CRV9ERUZFUikNCj4gPiA+ID4NCj4gPiA+ID4gU2hvdWxkIHRoaXMgYmUgRVBFUk0/IEFzIHRo
ZSBmb2xsb3dpbmcgcHNjaSBjcHVfb24gb3Agd2lsbCByZXR1cm4gaXQuDQo+ID4gPiA+IEkgdGhp
bmsgeW91IG1pc3MgdG8gY2hhbmdlIHRoaXMgd2hlbiBhcHBseSBKZWFuLVBoaWxpcHBlJ3MgcGF0
Y2guDQo+ID4gPg0KPiA+ID4gSXQgbG9va3MgbGlrZSBKYW1lcyBkaWRuJ3QgcHJvcGVybHkgdXBk
YXRlIGFsbCBwbGFjZXMuIEFsc28sDQo+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5jDQo+ID4gPiA+ID4gYi9kcml2ZXJzL2Zpcm13YXJlL3Bz
Y2kvcHNjaS5jIGluZGV4IGQ5NjI5ZmY4Nzg2MS4uZWU4MmU3ODgwZDhjDQo+ID4gPiA+ID4gMTAw
NjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYw0KPiA+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvcHNjaS9wc2NpLmMNCj4gPiA+ID4gPiBAQCAtMjE4
LDYgKzIxOCw4IEBAIHN0YXRpYyBpbnQgX19wc2NpX2NwdV9vbih1MzIgZm4sIHVuc2lnbmVkDQo+
ID4gPiA+ID4gbG9uZyBjcHVpZCwgdW5zaWduZWQgbG9uZyBlbnRyeV9wb2ludCkNCj4gPiA+ID4g
PiAgCWludCBlcnI7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgCWVyciA9IGludm9rZV9wc2NpX2Zu
KGZuLCBjcHVpZCwgZW50cnlfcG9pbnQsIDApOw0KPiA+ID4gPiA+ICsJaWYgKGVyciA9PSBQU0NJ
X1JFVF9ERU5JRUQpDQo+ID4gPiA+ID4gKwkJcmV0dXJuIC1FUEVSTTsNCj4gPiA+ID4gPiAgCXJl
dHVybiBwc2NpX3RvX2xpbnV4X2Vycm5vKGVycik7DQo+ID4gPg0KPiA+ID4gVGhpcyBjaGFuZ2Ug
aXMgdW5uZWNlc3NhcnkgLSBwcm9iYWJseSBjb21lcyBmcm9tIHdoZW4gLUVQUk9CRV9ERUZFUg0K
PiA+ID4gd2FzIGJlaW5nIHVzZWQuIHBzY2lfdG9fbGludXhfZXJybm8oKSBhbHJlYWR5IGRvZXM6
DQo+ID4NCj4gPiBCdXQgbWF5IHByaW50IGxvdHMgb2Ygbm9pc2UgbGlrZToNCj4gPg0KPiA+IFsg
ICAgMC4wMDg5NTVdIHNtcDogQnJpbmdpbmcgdXAgc2Vjb25kYXJ5IENQVXMgLi4uDQo+ID4gWyAg
ICAwLjAwOTY2MV0gcHNjaTogZmFpbGVkIHRvIGJvb3QgQ1BVMSAoLTEpDQo+ID4gWyAgICAwLjAx
MDM2MF0gcHNjaTogZmFpbGVkIHRvIGJvb3QgQ1BVMiAoLTEpDQo+ID4gWyAgICAwLjAxMTE2NF0g
cHNjaTogZmFpbGVkIHRvIGJvb3QgQ1BVMyAoLTEpDQo+ID4gWyAgICAwLjAxMTk0Nl0gcHNjaTog
ZmFpbGVkIHRvIGJvb3QgQ1BVNCAoLTEpDQo+ID4gWyAgICAwLjAxMjc2NF0gcHNjaTogZmFpbGVk
IHRvIGJvb3QgQ1BVNSAoLTEpDQo+ID4gWyAgICAwLjAxMzUzNF0gcHNjaTogZmFpbGVkIHRvIGJv
b3QgQ1BVNiAoLTEpDQo+ID4gWyAgICAwLjAxNDM0OV0gcHNjaTogZmFpbGVkIHRvIGJvb3QgQ1BV
NyAoLTEpDQo+ID4gWyAgICAwLjAxNDgyMF0gc21wOiBCcm91Z2h0IHVwIDEgbm9kZSwgMSBDUFUN
Cj4gPg0KPiA+IElzIHRoaXMgZXhwZWN0ZWQ/DQo+IA0KPiBQbGVhc2UgcmVhZCBteSBlbWFpbCBh
Z2FpbiwgYW5kIHRha2Ugbm90ZSBvZiB0aGUgX2NvbnRleHRfIGFib3ZlIHRoZSBwbGFjZXMNCj4g
dGhhdCBJJ3ZlIGNvbW1lbnRlZC4gQ29udGV4dCBtYXR0ZXJzLg0KPiANCj4gV2hhdCBJJ20gc2F5
aW5nIGlzIHRoYXQgdGhpcyBjaGFuZ2U6DQo+IA0KPiAgCWVyciA9IGludm9rZV9wc2NpX2ZuKGZu
LCBjcHVpZCwgZW50cnlfcG9pbnQsIDApOw0KPiArCWlmIChlcnIgPT0gUFNDSV9SRVRfREVOSUVE
KQ0KPiArCQlyZXR1cm4gLUVQRVJNOw0KPiAgCXJldHVybiBwc2NpX3RvX2xpbnV4X2Vycm5vKGVy
cik7DQo+IA0KPiBJcyB1bm5lY2Vzc2FyeSB3aGVuIHBzY2lfdG9fbGludXhfZXJybm8oKSBhbHJl
YWR5IGRvZXM6DQo+IA0KPiBzdGF0aWMgX19hbHdheXNfaW5saW5lIGludCBwc2NpX3RvX2xpbnV4
X2Vycm5vKGludCBlcnJubykgew0KPiAJc3dpdGNoIChlcnJubykgew0KPiAJLi4uDQo+IAljYXNl
IFBTQ0lfUkVUX0RFTklFRDoNCj4gCQlyZXR1cm4gLUVQRVJNOw0KPiANCj4gU28sIGEgcmV0dXJu
IG9mIFBTQ0lfUkVUX0RFTklFRCBmcm9tIGludm9rZV9wc2NpX2ZuKCkgYWJvdmUgd2lsbCBfYWxy
ZWFkeV8gYmUNCj4gdHJhbnNsYXRlZCB0byAtRVBFUk0gKHdoaWNoIGlzIC0xKSBieSBwc2NpX3Rv
X2xpbnV4X2Vycm5vKCkuIFRoZXJlIGlzIG5vIG5lZWQgdG8NCj4gYWRkIHRoYXQgZXh0cmEgaWYo
KSBzdGF0ZW1lbnQgaW4gX19wc2NpX2NwdV9vbigpLg0KPiANCj4gSSB3YXMgX25vdF8gc2F5aW5n
IHRoYXQgdGhlIGVudGlyZSBwYXRjaCB3YXMgdW5uZWNlc3NhcnkuDQo+IA0KPiBDb250ZXh0IG1h
dHRlcnMuIFRoYXQncyB3aHkgd2UgaW5jbHVkZSBjb250ZXh0IGluIHJlcGxpZXMuDQo+IA0KPiBT
dGFuZGFyZCBlbWFpbCBldGlxdWV0dGUgKGJlZm9yZSBNaWNyb3NvZnQgbWVzc2VkIGl0IHVwKSBp
cyB0byBxdW90ZSB0aGUgZW1haWwNCj4gdGhhdCBpcyBiZWluZyByZXBsaWVkIHRvLCB0cmltbWlu
ZyBoYXJkIGlycmVsZXZhbnQgY29udGVudCwgYW5kIHRvIHBsYWNlIHRoZSByZXBseQ0KPiBjb21t
ZW50cyBpbW1lZGlhdGVseSBiZWxvdyB0aGUgb3JpZ2luYWwgY29udGVudCB0byB3aGljaCB0aGUg
Y29tbWVudHMNCj4gcmVsYXRlLCB0byBnaXZlIHRoZSByZXBseSBjb21tZW50cyB0aGUgY29udGV4
dCBuZWNlc3NhcnkgZm9yIGNvcnJlY3QNCj4gaW50ZXJwcmV0YXRpb24uDQo+IA0KDQpPaCwgc29y
cnksIG15IG1pc3Rha2UuIElnbm9yZSBteSBsYXN0IGNvbW1lbnQuDQoNClRoYW5rcw0KSmlhbnlv
bmcNCg0KPiBUaGFua3MuDQo+IA0KPiAtLQ0KPiBSTUsncyBQYXRjaCBzeXN0ZW06IGh0dHBzOi8v
d3d3LmFybWxpbnV4Lm9yZy51ay9kZXZlbG9wZXIvcGF0Y2hlcy8NCj4gRlRUUCBpcyBoZXJlISA4
ME1icHMgZG93biAxME1icHMgdXAuIERlY2VudCBjb25uZWN0aXZpdHkgYXQgbGFzdCENCg==


Return-Path: <linux-arch+bounces-282-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA1A7F0F2B
	for <lists+linux-arch@lfdr.de>; Mon, 20 Nov 2023 10:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC721C20EB2
	for <lists+linux-arch@lfdr.de>; Mon, 20 Nov 2023 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6722B11724;
	Mon, 20 Nov 2023 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tJAZzwmX"
X-Original-To: linux-arch@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D0A98;
	Mon, 20 Nov 2023 01:36:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvpur09gJa6P0/MnCOoHufa9JpYHUJudL3kzKzJbTOSer33+JksF7/wvuSKE0TAa2J7P/kANExA8tnwWB3ocobc8fDmjoqdEtk09tkgleANc4wZb2OBEKx/SevxLXVY/+nH73QLdogDsfTikmwddGckTzidPOu9Kbu6LcP0c0PjLKUovGqFLxAMyb2QrRpDunMfknjpIyG8fvP8f7S3qdrL56/4McFYjoHV7rxnI/aC/kZDFRZlKqIphTA1GisTvnR3YWWrSSMTkMVFP598d97UZq5Z8Uq8fpNZzjUPcnj8c4pps46TV1xzRbRcx8VXVStAhNfncsDNUja+HbQEx/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrjivY9bJ+3yIyZug1daWSegq0aYDuFqE98MRZrCtPs=;
 b=Xc5hXFPXm2v5CiqVvjA2LENEgeyoHSxzMYEyFghyNFf7tpUmVvO1j8gn1oywXhF1xZVcD93Vy1k+7mmIUgiMU7ahP9Cjq2Jy3hwRZH7AkOHBdF741OXotpnho8BmRZML/w/eNgMs6Um2wQXqhqebDcF5hU+7U2uBbojnr8LS/L1uo+jXoGelrjVqsT7NqNe7+njvGsLuPQ6wbbh1nqD+YtVDcLVUWHIKQk1Hvo8EgfRBugbJUfEiMzPf5r9DsoIU5PMFnwzR7o9wTNkuPD6V96TAhCDelfMT1OUkjKymnasBkLNe2G68eLWAk8RneGMdHuwoJHQfEZBWHOP8Fe+qpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrjivY9bJ+3yIyZug1daWSegq0aYDuFqE98MRZrCtPs=;
 b=tJAZzwmX5TPOAcbkoDJa/hqhJ7shsOISzzRk80KvsQvneBABv3gv7gePkVxL8gDyNVVHZ5BHHTtWgbkYjui++MJAXv410hu3EftZDv2OIuMPZt49T7VTiJlGBlF4CkdPnyOtHFnJhY1rjTiKkAtCotiRUDEONsR18jUN7gsrZOA=
Received: from DB9PR08MB7511.eurprd08.prod.outlook.com (2603:10a6:10:302::21)
 by AS2PR08MB9125.eurprd08.prod.outlook.com (2603:10a6:20b:5e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 09:36:06 +0000
Received: from DB9PR08MB7511.eurprd08.prod.outlook.com
 ([fe80::ed8d:8ab6:c458:5b29]) by DB9PR08MB7511.eurprd08.prod.outlook.com
 ([fe80::ed8d:8ab6:c458:5b29%6]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 09:36:05 +0000
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
Thread-Index: AQHaBo11gHYttES/S0yWYrYSBJZEoLB8s2AggAZmR4CAAAIx4A==
Date: Mon, 20 Nov 2023 09:36:05 +0000
Message-ID:
 <DB9PR08MB7511C8825028074748FBB967F4B4A@DB9PR08MB7511.eurprd08.prod.outlook.com>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
 <E1qvJBQ-00AqS8-8B@rmk-PC.armlinux.org.uk>
 <DB9PR08MB7511B178CA811C412766FDBAF4B0A@DB9PR08MB7511.eurprd08.prod.outlook.com>
 <ZVsl1ZQ9JRXPf4qH@shell.armlinux.org.uk>
In-Reply-To: <ZVsl1ZQ9JRXPf4qH@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ts-tracking-id: 6992F3CC4D8F4248B1176ADA37813AF9.0
x-checkrecipientchecked: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR08MB7511:EE_|AS2PR08MB9125:EE_
x-ms-office365-filtering-correlation-id: 70f61cf3-6c66-4892-9f13-08dbe9ac1e7d
nodisclaimer: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z04n5YmL5MC1uejyty/Jebqp9pBrwLfzTFrKwjw2ln2KRviEqpO18TshbEVNecsYuaDFrz3sHwsR11wx61VEAaiMRDvSkYAzq2YE08nIEC8zGudgACxU4XH3U2gjp9k7AAKa0sgES42/Nh7DzEGaOLpsBeDB6zHq6TavYFWe34dTCnu+M4Z2kSHlK+bc6fEe8QSe9vAX9I7MCj+I09YXkJx1dNb41oKd9eINST4o7n/dhWzUpFP9n2Corea01Yio8/dEFsY9mSh47PZIrJoRFQ74DhBm75V59OvwnEULGjFaQkZccGQ1P03uG2JYuU/0n8lPEg8lZ+Fjz/misCDJCnc+klRyhtwYmgiY7LnhpYZZLWFNxlkDHY2Zepk9jyUvnz+svF2Gzpsdktwwb+qTmwJWvMLYpxlTtx7dmCJWP8yqG3PyyvcCnQR/44zbehUHUAFRw/98OBX1yynJQTxZajs0BPPqNtm8GdLhjwC7o4Pk6rzq4rGdoEnymTKUvnzQSYRJknzbljqgzOfzSfXMJMwip5uZ5t0xuHAjncxRVu2FqIRaseIPOs3/AB79dchlwV9fubzK/rSOU2dnN6Pc7YJPzX1xZf0dtEReQ+u9Fz4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7511.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(4326008)(8676002)(8936002)(52536014)(86362001)(7416002)(5660300002)(38070700009)(41300700001)(33656002)(55016003)(26005)(122000001)(83380400001)(53546011)(7696005)(9686003)(6506007)(38100700002)(316002)(66476007)(66446008)(66556008)(64756008)(54906003)(6916009)(66946007)(76116006)(478600001)(71200400001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UlR0RktSRHd2eHFKL1d1cXdwSWg5cnE4VjgxdG9wc2lHQmw3TWJJUmNFTkgy?=
 =?gb2312?B?THhtSXkzMlRxNlNQYTFnandBS3l6K2NLSTI2WG1iMVBmYWh3NkZyZzZLSXFR?=
 =?gb2312?B?Nkg3bnd1MzZDbDltT3YwdGZCRW1aMUtwR21pd0srVjkzRFZCaTFZczM2Yys1?=
 =?gb2312?B?RUVHdElpdlhaZDhOWjB1Y2ZqbmxoWmsyTHliZk9XWDVSbzRBYzRtNDFxWTVl?=
 =?gb2312?B?VkJyMk9nTS9vS254S2lFNHZSakdCOHEyRngyT1RTdUREMTJXaFJTdjM2dmxj?=
 =?gb2312?B?S2k0RzFjdUNoZ2lmbHFpNXZIWDUrQ3Z2L0wxdTJ1VTdrSGtqdVhmZTNhK25G?=
 =?gb2312?B?VmNiMHpJeXRyNytPYlNqQXhZamwwSmowdjFFZk5lZitYTHFHVnpDL1NZOW1S?=
 =?gb2312?B?cW96MzBWSGlnSUhQNjY3SENxL04xOXBWOVBpWUl3dEFuSzViTG10d25nMTR5?=
 =?gb2312?B?VlovZXdZVTREemFVcmJPbWNRdjVNaE0zTlB2V2QxWFA4ek9nQXYxUmF0d01u?=
 =?gb2312?B?V1cyZG1SdXpzTUV4SFBFTEFXbFl3N3JMQ2J1M2Q3OHFwWm9yZmVlSmtqWWxN?=
 =?gb2312?B?MVNhRkxqTGo3cGVQRitzV054VjRRaE81bERkL0ZYNWtwUlY2aFFKcjgrdGFw?=
 =?gb2312?B?bGw5MTI3NXp3T3NoVDluOXJvbUtYRTdKMGRvVG9tTzhlWXhiM0pwNXJQRDFW?=
 =?gb2312?B?R0ZzN2I5MmM5SzJacmFWMTYzOVhHNzdnVngxOE1SMWFnVTk5WW9RUVNDak9Y?=
 =?gb2312?B?eWtuSXpWbVVhbzdCbkxOeWJTSkdsazYvVXFSdm5iaFU3QXJMeUVSejRaNU9I?=
 =?gb2312?B?OE1sc2Z3RGlGN1RLdlNWQlFZOWpCVkpycU9OTWNYL0VFVTJLcVFaMEM4YTBM?=
 =?gb2312?B?Si9MOGRHcDRLYlBYUXNWZlpvT0d6Z1hnSWk0QXo3c3NOMjlaUVF3MlVSamV6?=
 =?gb2312?B?T2ZJc0lPUm43YUJRZUlGdnBYZEk4d2FsQjkvVUJDMjhuZVhZMGRqSzh6TGpE?=
 =?gb2312?B?M0hGaEIvaVRETjVQbVlJUndNOXJxanFkVGpzaVVRcGJrTjFHQXlWMWI1aDhI?=
 =?gb2312?B?Qi9ZUXIxQU5zdlV1ZXhNbnRhN044dlhIMk1waHA0enZTMW9tNkF4K1NXWUNx?=
 =?gb2312?B?cjViYlQ3SU8rVjFPbTdmNitjL3VsSG9SSExYandzcHdRMTRZNEswei8yenBj?=
 =?gb2312?B?UU5tWEpWd0RzQ2dENmF2TklNZjVnK2VlOU5rYXZtVXBpeUkwUEdNZEpYS1ln?=
 =?gb2312?B?TTdCc3pBV2xrTWszK2g2L0VwUlFJWUNBSStObllOd1ZNd0JTWmRVUWc4aEQ0?=
 =?gb2312?B?eHJhZ3ZxdEU0NXZrMllRMncyOVRjYWJYeUJPWW54TzZXdVhaRVAzS3o4aSt0?=
 =?gb2312?B?Qmh4eHpCb0pHTnBJaGRKQUhTQWNVSlRJNjRyM0NZdzRDZzQxNjkxbndQc0E4?=
 =?gb2312?B?NTlPWVFGZHhrYXYrUVpjdlNZcTZ1NUppa1E0QURsT0hFT2pjR2hONzQ2WDFF?=
 =?gb2312?B?Ym0vV0J3Ny9CVDFqNW5PRDZPMFNQd0dueUU0bGxkTUd0dmpQTmRoQWYrWGpT?=
 =?gb2312?B?Y1dZUjIzV2hGTHdKUTNEbFNLR2FLZjVqdk9WYldQUjRSbjZWOXNsTlhtNitV?=
 =?gb2312?B?aXNOS2NRWCszNUxkWVQzdXhKbUd6eWhiTWdDUHUyUCsrRURpZTBrM0h3eEUy?=
 =?gb2312?B?VUVjbEw4bFdCTmkyTXFpOGJoNXByVE9aZmNSVnlwRks5enduRFlDM0V0SklN?=
 =?gb2312?B?c2duZzRLL2RiVm9HZEM5Ui9wTlBTb0IxSDdkMlJRbVV5a3BXMXhSOWJVQndo?=
 =?gb2312?B?ZkRKZ0V6emZoT1FSQmE4akFJVW5yTmVMMVVIQW1ad0x1dGVvYnBVeUE2QVhV?=
 =?gb2312?B?TTRFbXIreXlKaGJCbHRNaGZZZHVsZTdTdUNMSGVHbXFxT2J0QzMycGtncW01?=
 =?gb2312?B?ZXdPSTdCcUdZZ1ZXV2Y4WVJYUVFpY2oybFVxVG4ya081bzZzdTJ0YWRLQlNP?=
 =?gb2312?B?V2pZNDFCUEZoRGgvRnBFeTA0NTFteFdwT0VsT1JpNDQyNFNxb291bk93OHZ3?=
 =?gb2312?B?RXA0Q2cyWmFTQVNzb1JsY0d5TVBKaXQzUTRLQThYVHhydkYyNmRLWFA4N0hR?=
 =?gb2312?Q?W1Pg10WI4Ft/HwFt+LCAmItAy?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f61cf3-6c66-4892-9f13-08dbe9ac1e7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 09:36:05.7930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJ7HTXt+oYGObxi7guNnt1hxcXM8LLtAXT0tYL1hOArRsXX3rQV+T/mQVdNb+9KspzriUQnNW7IfpkAYmub1Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9125

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUnVzc2VsbCBLaW5nIDxs
aW51eEBhcm1saW51eC5vcmcudWs+DQo+IFNlbnQ6IDIwMjPE6jEx1MIyMMjVIDE3OjI1DQo+IFRv
OiBKaWFueW9uZyBXdSA8SmlhbnlvbmcuV3VAYXJtLmNvbT4NCj4gQ2M6IGxpbnV4LXBtQHZnZXIu
a2VybmVsLm9yZzsgbG9vbmdhcmNoQGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgtYWNwaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGt2bWFybUBsaXN0cy5saW51eC5kZXY7
IHg4NkBrZXJuZWwub3JnOw0KPiBsaW51eC1jc2t5QHZnZXIua2VybmVsLm9yZzsgbGludXgtZG9j
QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtaWE2NEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBh
cmlzY0B2Z2VyLmtlcm5lbC5vcmc7IFNhbGlsIE1laHRhDQo+IDxzYWxpbC5tZWh0YUBodWF3ZWku
Y29tPjsgSmVhbi1QaGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+Ow0K
PiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPjsgSmFtZXMgTW9yc2UgPEphbWVzLk1vcnNl
QGFybS5jb20+Ow0KPiBDYXRhbGluIE1hcmluYXMgPENhdGFsaW4uTWFyaW5hc0Bhcm0uY29tPjsg
V2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz47DQo+IE1hcmsgUnV0bGFuZCA8TWFyay5SdXRs
YW5kQGFybS5jb20+OyBMb3JlbnpvIFBpZXJhbGlzaQ0KPiA8bHBpZXJhbGlzaUBrZXJuZWwub3Jn
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDM0LzM5XSBhcm02NDogcHNjaTogSWdub3JlIERFTklF
RCBDUFVzDQo+IA0KPiBPbiBUaHUsIE5vdiAxNiwgMjAyMyBhdCAwNzo0NTo1MUFNICswMDAwLCBK
aWFueW9uZyBXdSB3cm90ZToNCj4gPiBIaSBSdXNzZWxsLA0KPiA+DQo+ID4gT25lIGlubGluZSBj
b21tZW50Lg0KPiAuLi4NCj4gPiA+IENoYW5nZXMgc2luY2UgUkZDIHYyDQo+ID4gPiAgKiBBZGQg
c3BlY2lmaWNhdGlvbiByZWZlcmVuY2UNCj4gPiA+ICAqIFVzZSBFUEVSTSByYXRoZXIgdGhhbiBF
UFJPQkVfREVGRVINCj4gLi4uDQo+ID4gPiBAQCAtNDAsNyArNDAsNyBAQCBzdGF0aWMgaW50IGNw
dV9wc2NpX2NwdV9ib290KHVuc2lnbmVkIGludCBjcHUpICB7DQo+ID4gPiAgCXBoeXNfYWRkcl90
IHBhX3NlY29uZGFyeV9lbnRyeSA9IF9fcGFfc3ltYm9sKHNlY29uZGFyeV9lbnRyeSk7DQo+ID4g
PiAgCWludCBlcnIgPSBwc2NpX29wcy5jcHVfb24oY3B1X2xvZ2ljYWxfbWFwKGNwdSksIHBhX3Nl
Y29uZGFyeV9lbnRyeSk7DQo+ID4gPiAtCWlmIChlcnIpDQo+ID4gPiArCWlmIChlcnIgJiYgZXJy
ICE9IC1FUFJPQkVfREVGRVIpDQo+ID4NCj4gPiBTaG91bGQgdGhpcyBiZSBFUEVSTT8gQXMgdGhl
IGZvbGxvd2luZyBwc2NpIGNwdV9vbiBvcCB3aWxsIHJldHVybiBpdC4NCj4gPiBJIHRoaW5rIHlv
dSBtaXNzIHRvIGNoYW5nZSB0aGlzIHdoZW4gYXBwbHkgSmVhbi1QaGlsaXBwZSdzIHBhdGNoLg0K
PiANCj4gSXQgbG9va3MgbGlrZSBKYW1lcyBkaWRuJ3QgcHJvcGVybHkgdXBkYXRlIGFsbCBwbGFj
ZXMuIEFsc28sDQo+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvcHNjaS9w
c2NpLmMNCj4gPiA+IGIvZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYyBpbmRleCBkOTYyOWZm
ODc4NjEuLmVlODJlNzg4MGQ4Yw0KPiA+ID4gMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2Zp
cm13YXJlL3BzY2kvcHNjaS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNj
aS5jDQo+ID4gPiBAQCAtMjE4LDYgKzIxOCw4IEBAIHN0YXRpYyBpbnQgX19wc2NpX2NwdV9vbih1
MzIgZm4sIHVuc2lnbmVkIGxvbmcNCj4gPiA+IGNwdWlkLCB1bnNpZ25lZCBsb25nIGVudHJ5X3Bv
aW50KQ0KPiA+ID4gIAlpbnQgZXJyOw0KPiA+ID4NCj4gPiA+ICAJZXJyID0gaW52b2tlX3BzY2lf
Zm4oZm4sIGNwdWlkLCBlbnRyeV9wb2ludCwgMCk7DQo+ID4gPiArCWlmIChlcnIgPT0gUFNDSV9S
RVRfREVOSUVEKQ0KPiA+ID4gKwkJcmV0dXJuIC1FUEVSTTsNCj4gPiA+ICAJcmV0dXJuIHBzY2lf
dG9fbGludXhfZXJybm8oZXJyKTsNCj4gDQo+IFRoaXMgY2hhbmdlIGlzIHVubmVjZXNzYXJ5IC0g
cHJvYmFibHkgY29tZXMgZnJvbSB3aGVuIC1FUFJPQkVfREVGRVIgd2FzDQo+IGJlaW5nIHVzZWQu
IHBzY2lfdG9fbGludXhfZXJybm8oKSBhbHJlYWR5IGRvZXM6DQoNCkJ1dCBtYXkgcHJpbnQgbG90
cyBvZiBub2lzZSBsaWtlOg0KDQpbICAgIDAuMDA4OTU1XSBzbXA6IEJyaW5naW5nIHVwIHNlY29u
ZGFyeSBDUFVzIC4uLg0KWyAgICAwLjAwOTY2MV0gcHNjaTogZmFpbGVkIHRvIGJvb3QgQ1BVMSAo
LTEpDQpbICAgIDAuMDEwMzYwXSBwc2NpOiBmYWlsZWQgdG8gYm9vdCBDUFUyICgtMSkNClsgICAg
MC4wMTExNjRdIHBzY2k6IGZhaWxlZCB0byBib290IENQVTMgKC0xKQ0KWyAgICAwLjAxMTk0Nl0g
cHNjaTogZmFpbGVkIHRvIGJvb3QgQ1BVNCAoLTEpDQpbICAgIDAuMDEyNzY0XSBwc2NpOiBmYWls
ZWQgdG8gYm9vdCBDUFU1ICgtMSkNClsgICAgMC4wMTM1MzRdIHBzY2k6IGZhaWxlZCB0byBib290
IENQVTYgKC0xKQ0KWyAgICAwLjAxNDM0OV0gcHNjaTogZmFpbGVkIHRvIGJvb3QgQ1BVNyAoLTEp
DQpbICAgIDAuMDE0ODIwXSBzbXA6IEJyb3VnaHQgdXAgMSBub2RlLCAxIENQVQ0KDQpJcyB0aGlz
IGV4cGVjdGVkPw0KDQpUaGFua3MNCkppYW55b25nIA0KPiANCj4gICAgICAgIGNhc2UgUFNDSV9S
RVRfREVOSUVEOg0KPiAgICAgICAgICAgICAgICByZXR1cm4gLUVQRVJNOw0KPiANCj4gVGhhbmtz
Lg0KPiANCj4gLS0NCj4gUk1LJ3MgUGF0Y2ggc3lzdGVtOiBodHRwczovL3d3dy5hcm1saW51eC5v
cmcudWsvZGV2ZWxvcGVyL3BhdGNoZXMvDQo+IEZUVFAgaXMgaGVyZSEgODBNYnBzIGRvd24gMTBN
YnBzIHVwLiBEZWNlbnQgY29ubmVjdGl2aXR5IGF0IGxhc3QhDQo=


Return-Path: <linux-arch+bounces-232-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0563C7EDC29
	for <lists+linux-arch@lfdr.de>; Thu, 16 Nov 2023 08:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1206E1C20832
	for <lists+linux-arch@lfdr.de>; Thu, 16 Nov 2023 07:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DA6FBFD;
	Thu, 16 Nov 2023 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OUBwmQo+"
X-Original-To: linux-arch@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A782E192;
	Wed, 15 Nov 2023 23:45:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddWiQjjxwhDAn1M+qXLIPEnpQ+7J42jHn92Jh47kE9iwez9OXDzkb655qvrI5NMi1P2LaKd0rndAICAUMQ/GikuNviJqnQ/VkJjzVVttbq0NrtiQAdAgQcJAED3T4/0ObyCw+L/02VlN7lkYBljNLpEqdYoAsXAFt/9tRMKBBbndmaow2zPj4FT/5O9xIP53YlRgvPt4Z1bQp0DdGyFtCaMhO+XUS8iJMWb+QoeWGFD6/VfWJ7GMZJR4KBREyPHR+WBj4huoo7SwOoTsH0OUsb0qVckF4Er9PTK+wkRrNLe12kZviC9JLaN9uETTLSChCoUsbmQZGCGTTL86MP5n4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq7hyeddcA1wPrix41s7ThrQJ8gYuug0dRaqNvgPxu0=;
 b=IGcjqgNtPx8XvaZX1sRtBtpd1oE9bhJlgIxDNYObjeN4Vnj4OfdqfJaaOSyvtGzxgAQqJjIeHS+zmeoaDoc8KYWHYjfI6evOxdD2hU/mYACHJnNYVkATIHy1PD3QJIpAUMAHZdhCVUKycgFzwzXHqY1eEr2epRHXdyr7JpImY/wel4r3cpyQfxbAROIV6fx7SbF+R1fym92heK14/Url8fq+7wTVKvnfSXCIFsYgcUjshp2IHZ9Y3OWPLqDvw10mJDmmwmfoAxYy8wrj0A6nJFYOJN2so4D2PnYeZ2/xC/MUvER3k5D/luNhcwyygoJ022t6yAeCwz0qmzjZufMRUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq7hyeddcA1wPrix41s7ThrQJ8gYuug0dRaqNvgPxu0=;
 b=OUBwmQo+riJiWf5FaF9JJhgZHnbLFPwMkfQyvH639X+jcvc35UpcoEkaO/qLfOgRRAozawLRfhws3UIm3GcND6KQMN3HTBmx1gyNOlMdZH9UxX9amn6ts+7Esn7oLBP7euSRjPXtBt4AGfGBz1lk3JtP8OtRaVikFUrl9B+qwvM=
Received: from DB9PR08MB7511.eurprd08.prod.outlook.com (2603:10a6:10:302::21)
 by VI1PR08MB5501.eurprd08.prod.outlook.com (2603:10a6:803:138::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28; Thu, 16 Nov
 2023 07:45:51 +0000
Received: from DB9PR08MB7511.eurprd08.prod.outlook.com
 ([fe80::ed8d:8ab6:c458:5b29]) by DB9PR08MB7511.eurprd08.prod.outlook.com
 ([fe80::ed8d:8ab6:c458:5b29%6]) with mapi id 15.20.7002.018; Thu, 16 Nov 2023
 07:45:51 +0000
From: Jianyong Wu <Jianyong.Wu@arm.com>
To: Russell King <rmk+kernel@armlinux.org.uk>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
CC: Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, Justin He <Justin.He@arm.com>, James Morse
	<James.Morse@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon
	<will@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>
Subject: RE: [PATCH 34/39] arm64: psci: Ignore DENIED CPUs
Thread-Topic: [PATCH 34/39] arm64: psci: Ignore DENIED CPUs
Thread-Index: AQHaBo11gHYttES/S0yWYrYSBJZEoLB8s2Ag
Date: Thu, 16 Nov 2023 07:45:51 +0000
Message-ID:
 <DB9PR08MB7511B178CA811C412766FDBAF4B0A@DB9PR08MB7511.eurprd08.prod.outlook.com>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
 <E1qvJBQ-00AqS8-8B@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qvJBQ-00AqS8-8B@rmk-PC.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ts-tracking-id: AD4F53164E821D4ABBC18A92A1883324.0
x-checkrecipientchecked: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR08MB7511:EE_|VI1PR08MB5501:EE_
x-ms-office365-filtering-correlation-id: 383a97e6-8cb9-41f2-e82f-08dbe6780e6f
nodisclaimer: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 J67Quwvd8inWMlmxfJ3EQytByHgsDHxLbE41VRIRy2lKoTX+zn88qI2otFYyzj6w8h1UT6efntBBoaH5AifwjjqsdhFlBLVrkkfkevNsizXuyk5uLyy4hVkdbJHcq8YdTrciwlOpL1bJGGIKCXjmqSZFgqQx40cUo+ZkPjquIdf59D9mikBQsY3P1jNbUrYw9AswhcL6iDCIA5sB1sZ5gcvQjLtiaWIN7hw8y5NdFzXEL+QVtcLvXEAvwRKRYu10kMDvW8KUI+DJYccRJamlNSJXgb93SKy1iOAbeb7IblD5rV2yE9kRgaEMshXK22qVeUAZnbY3c1gUD+46NiVf8MCI1KPMhEmJBqsEmis65xo9KWbBt0HZlHUAB8x5H3Xv+0AflouX5yQ8uXDqAZLojH2UO+RxuLrox8GJo1xpJ6X+A6EglOPXUrP+jQE218rSjUsqQRZjckRcRRWo9HDfUjqC3vwTb0nAP8xPlAUz/UWpSDZLnxpGVc3/Njb80IHG9DLdqNQaFLL8JHjSNPwqo6imPCvNyoYqf9bhD/EkCqQ9Li/EqzSdGWBVZrJwKuZFYEJPwk3lSCMIQlmc8knKT3sxoWZTzyN7XXLLHYHq9s5HVVTxwLKQ35y7l1sc8lBq
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7511.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39850400004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(54906003)(921008)(66476007)(66946007)(66446008)(110136005)(76116006)(66556008)(33656002)(38100700002)(38070700009)(64756008)(86362001)(9686003)(83380400001)(4326008)(122000001)(6506007)(2906002)(53546011)(71200400001)(7696005)(478600001)(316002)(7416002)(966005)(41300700001)(26005)(5660300002)(8936002)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFFtWmZRYnZqSkQ3N1BrMGMxZ3ZCV1VxcUJOMmNZWU1ocVZLNnlNdmxDcUhi?=
 =?utf-8?B?NmZrSERNbjAzbUZ5SEgyOXRvZ0Y5N2ptT0J1U1k3RWNYTFhCL2gyTlJGT0Zp?=
 =?utf-8?B?aVpzNnJ0MzVoNFRJUjNoOHEyalB4TXB5eksyQ1RiNmRDUlI0N214RWhFZGV3?=
 =?utf-8?B?R0padUxQVXdTZjlZQjl6emVmajdJQytSS3pvcDUxZGRUZXFiS2d2Y3cxZ2RY?=
 =?utf-8?B?OHc4YSt6RmlJY2VXQVFsNHVVU3BLNzhOTzhBTHdtT0dsMG1Ec08vZEJCMXBx?=
 =?utf-8?B?ODV3b3hrK2w3YUY0bHVUdU90aFltVVdNOHZrTk9YVytIdUNuQTExQml6Y0ZI?=
 =?utf-8?B?QTI5Q1dXVXdXOVUwUGxJS29DeXB2TGRhZDJneFFQQ2w4dEVRRVJVUUxzN1Fz?=
 =?utf-8?B?ekRXQmJqZHFZYkx0S2E5dXRhSXRNSjQ4dXphdVRja056RGhZd0J1TXpyNVNR?=
 =?utf-8?B?L1I4UktENHFvNGptNzZrUlZCbnI0VDFSZTdqZHpIbkRidUorUExTQlgybDJC?=
 =?utf-8?B?SWpQRTNTVUJIL2tTaDRpVW8yMWRMS2thNmdPeXRKT0hpM0RjaHpraDg4akE3?=
 =?utf-8?B?ZHBUa0VSYVdSc0k3OUIyVE4veUZ4NlpKTHdFR3BqdE5sb2l2aGtOcHVvN1FM?=
 =?utf-8?B?YzNRaWJhcE1ZT3I0SDFDZUdHWFgyZ2lUNWdVRElyc0N6aXZUSDY5SWhSbXJU?=
 =?utf-8?B?eitKeThxTzIxTjZZVlI1NWJMbEZFcGUrWk8rYjUxa1RHYWdiZitCdXNaMWkv?=
 =?utf-8?B?RndZUGYxY1dQTUhMOUJ1NW5Sb3A1VEZoWUN3UXQxM2FieU1jems5dGtEN1dC?=
 =?utf-8?B?dUwvWU9RUllRU2RRdW9yNUt5ZTh6RlZiV25kQ3BzUHhhMS9aeVh3U2tOV3lP?=
 =?utf-8?B?emRXRENDWFQyWmcvZlBUVUx5UzVWU0dnOTU5YWIzVTk2K1VmMVRYV2V3K3pn?=
 =?utf-8?B?ZkJqVHB4VjIvMmlBZ3JkZndjQ3R1cXFCMWRJQ0xJaE92NCthNUptdVpEQjA3?=
 =?utf-8?B?c3ZZVkpLWDZnWHJzSXMreTdpMjBqTDZoT25wRExES1FUaGxZVFZCWGkwS3hV?=
 =?utf-8?B?OUNZR0pGbTRLK3RQcnhaN1NqUW9Dc25GNXNBbDV6ekJoNTBXcHV2ZGtBR1lo?=
 =?utf-8?B?Mld0enZPcnUxRFdyOEp3ZzFWdi84WjZkTTllM3o3M2srd0xzcWRySTRtNEh5?=
 =?utf-8?B?WTIwRTFVRllydVVaREpNUzNncHM4N1RYTUR4Ty9IMHJTWTB5TTl2R1ArOUly?=
 =?utf-8?B?V21zaTVaaUtVNk1BTzNxOUhvTy9hb2JpR3Z3OURKeFkxNEpvNnMxUmRNYUZh?=
 =?utf-8?B?bG0yMy9mNXpaUDh1Z1I2V1RSK2lOUWZLUmdGTnJVcnI4alJzTlkwdW5ZcjN3?=
 =?utf-8?B?dUo5ZWpac0pHcERYdVFjSXRrOFlmUlRaYlo3T25qS0JubWJENUNkUjFXWTdo?=
 =?utf-8?B?SUJZRzBtMTR3cXRBOTlXRGtpN2NxMXBJWWI3dWhhSzhjTkR4VVRkTWFFV2Vk?=
 =?utf-8?B?VWNuNFVGOWx5T1dZd0RzM3VJc05TZ0g2Q2FIc2pLaWtIWjA0NW1ZTWhJUzJw?=
 =?utf-8?B?cXVwMjNablJycWF0OVNLUk9WYmp1SW1ZOFA2cElQdlk1N25FQ2JIN2kyN3Fw?=
 =?utf-8?B?d0Z1UUpLZkVQS0FwNzlpRW16UTlsT0xiMEFjbDBUd3RzOURYWW9HWXUrSFps?=
 =?utf-8?B?ZnNhREJaNytCYkU3OE1NODAwdDlYaS92dmRleEJ1MC85bTZUT0w3d2pPczBh?=
 =?utf-8?B?Y0JJazF6MG5uZHcvYndZREhBWlNlSEFzbjM5bGZLMU0zTVI3TVpBeUprM1Nj?=
 =?utf-8?B?OC9DcGRudlVRWlJjcWJGbHdGdHZrZllJd2JydFhxcFB0NTNsSU12c1pQNFlR?=
 =?utf-8?B?RC9oWjU0WjhGTkV0OGk1WmJNMVMzTHVSc3ZEQjNFNjRPYlRWaHNtUzhMVjVJ?=
 =?utf-8?B?dlNheVloMWlkbitUTnJNcUFrRkxyTzcxaDlZMnMrWFhzNzFYb1JmdGlEM0x2?=
 =?utf-8?B?aHJkOUVrTFJMN2NxOTljeW9zUC9BTjRLclVMTjl0N3VkK01PUmJIckpZYVdk?=
 =?utf-8?B?SE1FSmtVM2l5SHRQdGpiZEJYVjRhT2piT01saUpPOXNCVEhyVkVYZDRkTHlw?=
 =?utf-8?Q?Q1xCSvXelNNfTbfwWLnwXZRaG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 383a97e6-8cb9-41f2-e82f-08dbe6780e6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 07:45:51.5279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdyo830wv/AY6KGQeU1c0Fj13iAKslaVYELm4zQJUOhdR4AfWBuDjG0eGb8B5wwistDRW39dLd5mP1x/S6CDEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5501

SGkgUnVzc2VsbCwNCg0KT25lIGlubGluZSBjb21tZW50Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IFJ1c3NlbGwgS2luZyA8cm1rQGFybWxpbnV4Lm9yZy51az4gT24g
QmVoYWxmIE9mIFJ1c3NlbGwgS2luZw0KPiBTZW50OiAyMDIz5bm0MTDmnIgyNOaXpSAyMzoxOQ0K
PiBUbzogbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsb29uZ2FyY2hAbGlzdHMubGludXguZGV2
Ow0KPiBsaW51eC1hY3BpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJjaEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsga3Zt
YXJtQGxpc3RzLmxpbnV4LmRldjsgeDg2QGtlcm5lbC5vcmc7DQo+IGxpbnV4LWNza3lAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1pYTY0QHZnZXIu
a2VybmVsLm9yZzsgbGludXgtcGFyaXNjQHZnZXIua2VybmVsLm9yZw0KPiBDYzogU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+OyBKZWFuLVBoaWxpcHBlIEJydWNrZXINCj4gPGpl
YW4tcGhpbGlwcGVAbGluYXJvLm9yZz47IEppYW55b25nIFd1IDxKaWFueW9uZy5XdUBhcm0uY29t
PjsgSnVzdGluIEhlDQo+IDxKdXN0aW4uSGVAYXJtLmNvbT47IEphbWVzIE1vcnNlIDxKYW1lcy5N
b3JzZUBhcm0uY29tPjsgQ2F0YWxpbg0KPiBNYXJpbmFzIDxDYXRhbGluLk1hcmluYXNAYXJtLmNv
bT47IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+OyBNYXJrDQo+IFJ1dGxhbmQgPE1hcmsu
UnV0bGFuZEBhcm0uY29tPjsgTG9yZW56byBQaWVyYWxpc2kgPGxwaWVyYWxpc2lAa2VybmVsLm9y
Zz4NCj4gU3ViamVjdDogW1BBVENIIDM0LzM5XSBhcm02NDogcHNjaTogSWdub3JlIERFTklFRCBD
UFVzDQo+IA0KPiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGlu
YXJvLm9yZz4NCj4gDQo+IFdoZW4gYSBDUFUgaXMgbWFya2VkIGFzIGRpc2FibGVkLCBidXQgb25s
aW5lIGNhcGFibGUgaW4gdGhlIE1BRFQsIFBTQ0kgYXBwbGllcw0KPiBzb21lIGZpcm13YXJlIHBv
bGljeSB0byBjb250cm9sIHdoZW4gaXQgY2FuIGJlIGJyb3VnaHQgb25saW5lLg0KPiBQU0NJIHJl
dHVybnMgREVOSUVEIHRvIGEgQ1BVX09OIHJlcXVlc3QgaWYgdGhpcyBpcyBub3QgY3VycmVudGx5
IHBlcm1pdHRlZC4gVGhlDQo+IE9TIGNhbiBsZWFybiB0aGUgY3VycmVudCBwb2xpY3kgZnJvbSB0
aGUgX1NUQSBlbmFibGVkIGJpdC4NCj4gDQo+IEhhbmRsZSB0aGUgUFNDSSBERU5JRUQgcmV0dXJu
IGNvZGUgZ3JhY2VmdWxseSBpbnN0ZWFkIG9mIHByaW50aW5nIGFuIGVycm9yLg0KPiANCj4gU2Vl
IGh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRhdGlvbi9kZW4wMDIyL2YvP2xhbmc9
ZW4gcGFnZSA1OC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8
amVhbi1waGlsaXBwZUBsaW5hcm8ub3JnPiBbIG1vcnNlOg0KPiBSZXdyb3RlIGNvbW1pdCBtZXNz
YWdlIF0NCj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgTW9yc2UgPGphbWVzLm1vcnNlQGFybS5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IFJ1c3NlbGwgS2luZyAoT3JhY2xlKSA8cm1rK2tlcm5lbEBhcm1s
aW51eC5vcmcudWs+DQo+IC0tLQ0KPiBDaGFuZ2VzIHNpbmNlIFJGQyB2Mg0KPiAgKiBBZGQgc3Bl
Y2lmaWNhdGlvbiByZWZlcmVuY2UNCj4gICogVXNlIEVQRVJNIHJhdGhlciB0aGFuIEVQUk9CRV9E
RUZFUg0KPiAtLS0NCj4gIGFyY2gvYXJtNjQva2VybmVsL3BzY2kuYyAgICAgfCAyICstDQo+ICBh
cmNoL2FybTY0L2tlcm5lbC9zbXAuYyAgICAgIHwgMyArKy0NCj4gIGRyaXZlcnMvZmlybXdhcmUv
cHNjaS9wc2NpLmMgfCAyICsrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5lbC9wc2Np
LmMgYi9hcmNoL2FybTY0L2tlcm5lbC9wc2NpLmMgaW5kZXgNCj4gMjlhOGU0NDRkYjgzLi40ZmNj
MGNkZDc1N2IgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQva2VybmVsL3BzY2kuYw0KPiArKysg
Yi9hcmNoL2FybTY0L2tlcm5lbC9wc2NpLmMNCj4gQEAgLTQwLDcgKzQwLDcgQEAgc3RhdGljIGlu
dCBjcHVfcHNjaV9jcHVfYm9vdCh1bnNpZ25lZCBpbnQgY3B1KSAgew0KPiAgCXBoeXNfYWRkcl90
IHBhX3NlY29uZGFyeV9lbnRyeSA9IF9fcGFfc3ltYm9sKHNlY29uZGFyeV9lbnRyeSk7DQo+ICAJ
aW50IGVyciA9IHBzY2lfb3BzLmNwdV9vbihjcHVfbG9naWNhbF9tYXAoY3B1KSwgcGFfc2Vjb25k
YXJ5X2VudHJ5KTsNCj4gLQlpZiAoZXJyKQ0KPiArCWlmIChlcnIgJiYgZXJyICE9IC1FUFJPQkVf
REVGRVIpDQoNClNob3VsZCB0aGlzIGJlIEVQRVJNPyBBcyB0aGUgZm9sbG93aW5nIHBzY2kgY3B1
X29uIG9wIHdpbGwgcmV0dXJuIGl0LiBJIHRoaW5rIHlvdSBtaXNzIHRvIGNoYW5nZSB0aGlzIHdo
ZW4gYXBwbHkgSmVhbi1QaGlsaXBwZSdzIHBhdGNoLg0KDQpUaGFua3MNCkppYW55b25nDQo+ICAJ
CXByX2VycigiZmFpbGVkIHRvIGJvb3QgQ1BVJWQgKCVkKVxuIiwgY3B1LCBlcnIpOw0KPiANCj4g
IAlyZXR1cm4gZXJyOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJuZWwvc21wLmMgYi9h
cmNoL2FybTY0L2tlcm5lbC9zbXAuYyBpbmRleA0KPiA4YzhmNTU3MjE3ODYuLjY4ZWM3ZmJlMTY2
ZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvc21wLmMNCj4gKysrIGIvYXJjaC9h
cm02NC9rZXJuZWwvc21wLmMNCj4gQEAgLTEyNCw3ICsxMjQsOCBAQCBpbnQgX19jcHVfdXAodW5z
aWduZWQgaW50IGNwdSwgc3RydWN0IHRhc2tfc3RydWN0ICppZGxlKQ0KPiAgCS8qIE5vdyBicmlu
ZyB0aGUgQ1BVIGludG8gb3VyIHdvcmxkICovDQo+ICAJcmV0ID0gYm9vdF9zZWNvbmRhcnkoY3B1
LCBpZGxlKTsNCj4gIAlpZiAocmV0KSB7DQo+IC0JCXByX2VycigiQ1BVJXU6IGZhaWxlZCB0byBi
b290OiAlZFxuIiwgY3B1LCByZXQpOw0KPiArCQlpZiAocmV0ICE9IC1FUEVSTSkNCj4gKwkJCXBy
X2VycigiQ1BVJXU6IGZhaWxlZCB0byBib290OiAlZFxuIiwgY3B1LCByZXQpOw0KPiAgCQlyZXR1
cm4gcmV0Ow0KPiAgCX0NCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL3BzY2kv
cHNjaS5jIGIvZHJpdmVycy9maXJtd2FyZS9wc2NpL3BzY2kuYyBpbmRleA0KPiBkOTYyOWZmODc4
NjEuLmVlODJlNzg4MGQ4YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9wc2NpL3Bz
Y2kuYw0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL3BzY2kvcHNjaS5jDQo+IEBAIC0yMTgsNiAr
MjE4LDggQEAgc3RhdGljIGludCBfX3BzY2lfY3B1X29uKHUzMiBmbiwgdW5zaWduZWQgbG9uZyBj
cHVpZCwNCj4gdW5zaWduZWQgbG9uZyBlbnRyeV9wb2ludCkNCj4gIAlpbnQgZXJyOw0KPiANCj4g
IAllcnIgPSBpbnZva2VfcHNjaV9mbihmbiwgY3B1aWQsIGVudHJ5X3BvaW50LCAwKTsNCj4gKwlp
ZiAoZXJyID09IFBTQ0lfUkVUX0RFTklFRCkNCj4gKwkJcmV0dXJuIC1FUEVSTTsNCj4gIAlyZXR1
cm4gcHNjaV90b19saW51eF9lcnJubyhlcnIpOw0KPiAgfQ0KPiANCj4gLS0NCj4gMi4zMC4yDQoN
Cg==


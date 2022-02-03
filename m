Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61B24A7F93
	for <lists+linux-arch@lfdr.de>; Thu,  3 Feb 2022 08:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiBCHFS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Feb 2022 02:05:18 -0500
Received: from mail-eopbgr120074.outbound.protection.outlook.com ([40.107.12.74]:4016
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229550AbiBCHFQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Feb 2022 02:05:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjdnShbkS3e/hgyqaExZrlF5AXRTJNB3uAi2UmHA1ONP/BSRJVeem7ZYiBEJYL8xsUpHQG5p9jsm4Kcav8/U5AqiF4EBms07sArqycogeQRS2EfKHjXd+jqaNcWPonaanfx6INpwOggQGuJSqIg/dcy7etjFj2PcyfM7LG5yYJ8czmdGxEXckfLZ7QijnHjTm1m0+/VAvyZ9FzA4+DWnkAS9OsPWTazJNE/BHl8GnqULTIqpFmSW/dvb92YBBy8oiQr66RG/B8z0IpJ4VeSnwd+LGoNfVXuv83ECVjSISh5KjdPtSY8N2xm33Sz067VYlOpLXX3gc2awybnH3Re1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMhnRh6gbka+zQmbVEuSnoeIUGa17AJwtCOeF0V1CyY=;
 b=U4tMjFfKF8bxtvatSkGsOsdrwbyWAcIs4ihL9iVNCn/xPzdnyflUv2zMBo+XLJVsoD9u5bfwTG2nLjOI06l3SqPSR2tRMGyNj0QQ+wrbuxeF4Enoje1Fb8VYv4PY8XrKf97yVve1pyHp5C2cqfKchcGHCA6V/Q84SNbOvYOIYSrOwsgHlBfVEmzRrva7HzmxiofYfKAiJzDQZ6cqj10dKobFpV4pUxgr+8lPW0UKZerriCKeqvlqa0L/rOgpybTOb09nVV1wdLMXVWut9YdVSkwPLD3r+1z3Zf1po8TRmvHQ8kvlyrPpaZD32Lb6wniO7t7t01gmj9kns+zNX7rT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAYP264MB3783.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:119::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 07:05:13 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 07:05:13 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>
CC:     Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 4/6] modules: Add
 CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
Thread-Topic: [PATCH v3 4/6] modules: Add
 CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
Thread-Index: AQHYFTH0u+jifZZUEUq40HXmKIXLk6yA+ByAgAB2R4A=
Date:   Thu, 3 Feb 2022 07:05:13 +0000
Message-ID: <228849f5-f6a4-eb45-5e1e-a9b3eccb28b3@csgroup.eu>
References: <cover.1643475473.git.christophe.leroy@csgroup.eu>
 <b59ed8781ef9af995c5bfa762de1f42fdfc57c74.1643475473.git.christophe.leroy@csgroup.eu>
 <YfsbcXD74BwJ9ci2@bombadil.infradead.org>
In-Reply-To: <YfsbcXD74BwJ9ci2@bombadil.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6c7ecf2-d7b4-4565-d220-08d9e6e3866a
x-ms-traffictypediagnostic: PAYP264MB3783:EE_
x-microsoft-antispam-prvs: <PAYP264MB3783823288905B96F2F7357FED289@PAYP264MB3783.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iJkK6NWzK8uL5IPebl5JnIDDiQmt52RaoaqwsZmPTiqunEsuTmi/D95kAsO3hyvetBx7P4OZMCII2ewEreO+X21mkH94CEgGJr7r2/E6WxyjcVRhC8xpN7FEHP7zV2bjV3x6zMvPKMI0ahJqacE+Iqin5MR+aexmLlE6yO9kkqEOVrSnIOz6f2O0P0zTuKK9zUaQcJyq+T3BC7MKrOZ8zJywXb1Ttx7JcmzkLRisI3jvhskr3F8txgQYy6epbtAwZhgJfBf/p4X1WAIM+7J31URz31l83vfZhHz5T1H3E1iKwb1Gw8YhMuPndNWwFF2RaVcnn0jXnv7xKYaCRtnCc3GXQKzFOefAEZ89z7bUbcrinHu9X8OAJZhMwExjFYn0HO8XOft8g75FIG9JHa//flGzitdJDYuJveUqCOtxX/00vQg6Z+SbcHfB4S0KNfZzALofsiUt+D2orcjhzgNstGipZeh5oQcqYK4oZUy5uAXk96CwrjY5TDDqx7yQh5K6ozn4JJnwjSDjfyjGBilWkK4aOe2s92M14TpBB+BQUnQTWGQUMBS+XcerPmPqcgK9VeGguossQBNnLgW3QpPwv67YfyRfWmml6pa2RlgUBt2XNI41TTL0IPC/Qmg1kp3o/IE+M9I87FZfKlWT36wZxrHLQ39pgmGl7J84MZHjmNaY9y4YJ9Nd54w3jt7rYTA02YjkFCvC63VCmfOTN1s25NbVVhAGAdwk8zcQ+gZ3lnR+rW18mVrmYXtny4NnoLiSDn0IZ81c9698bU+5W5q6i6CE9jqD7VpqiXhn4AMYhJqv2QAsjk4V/cSrYnYwdUv0jG31rBpwZdnnETnsWE9iZ0MA3p6HiqGiXbIqChpjJOQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(110136005)(76116006)(54906003)(31686004)(316002)(66946007)(66556008)(8936002)(8676002)(66476007)(2616005)(66446008)(6506007)(4326008)(6512007)(7416002)(71200400001)(2906002)(44832011)(36756003)(5660300002)(508600001)(966005)(6486002)(64756008)(38070700005)(186003)(26005)(122000001)(31696002)(38100700002)(83380400001)(86362001)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWdqTFVZcExNajRPZmlRQzFPNjFLSHVudW9CendZMy9xa1AzZTVyM1V0SjBJ?=
 =?utf-8?B?NllHYWhRTVVVd2g5ZC9LaW1WbFlwa0tNRlQ0bXk3TU9TN0k0NlNCVXdwVHBH?=
 =?utf-8?B?NkpCNnVZOGZEQ1UwZDhYZG5ZbXhaT012NHV1L0ppdEs5RjFlTlFmNUYyb1dH?=
 =?utf-8?B?RnNOMjBGWFkyY1NWaWpCdVl5bFdRRXhTbVNSL0Y1dVY1cGlMTDRQS0c3R0Vk?=
 =?utf-8?B?R3N4aDB5T0RZc0loNXdRNDRVMENOQ0dycVRFSitXNUdTK1IzaENwK3llNGxp?=
 =?utf-8?B?aGc5S3hoNk9EM3l5ZEhDTWxJdm9YQlNySno3emRKeFdhRnVYamdVRjMyZVhM?=
 =?utf-8?B?WXBPYWJvb0tneTE2SGQ4MGVFZnJWdXA4dW1RYTJtdjl6ZkxTWjA3SWw3NWpo?=
 =?utf-8?B?YVY1UTJFQmpXNGptMlNTNmtBRlVodC9DbzV4aGVvRkVHaVUxMXpOTmZEZ2Na?=
 =?utf-8?B?Ung5amkrRjBLQkJtb095NW1jckVUMnpTUmoyMHZpS08rbEVXQkdwWGtEdHls?=
 =?utf-8?B?S1NDbmJOVWJ3dWtWNSs2RW16ZXJiUjFEZm1LNkdpN1VFSVZ6azNpTFVaaGht?=
 =?utf-8?B?am9RMHpXWWI1OHM1eWZuNHl5aGNzOENaWnQzc2RSUVExRHNMelo0OU00ZHVU?=
 =?utf-8?B?Y0FZZ1R0bU1oQUIyV21idTlML3RocHVMVUtyNlg4U21sUGFHbHpVa01wcWo4?=
 =?utf-8?B?bjRvbGpmcThhVlh0aWNJK3hXNmRQMEd0eHpSamkwWW5tU0ZiNXN3dHRic2ZW?=
 =?utf-8?B?VS85OUF5MjVaVHp0NkZ2d3VvcjZpSFhPY1ltdkZxbk5RemNNQTBqcmhVVkVJ?=
 =?utf-8?B?YUtNZk12ZTZnR1BadHFsNy8vUklnTFZuZSttOWNOc3JLeFVCSTJWbldIalJF?=
 =?utf-8?B?dTRFWTlWYTE3OE1IZHMxalBWaU5pVFF0b1Z0WWhzSW15aHRvYks0eDh4S3l0?=
 =?utf-8?B?bWFiRUNXKzBabC9uRVdXYWNJN0JHSHVFRG0vRzdCVTk4Unk5RUdGTlBxQXJ5?=
 =?utf-8?B?dWt0bHc4eUFwY3ZMRDRzbHBhZnNROFR5L1YrMlh6OUEwbC9YbnA1aUF4bEk3?=
 =?utf-8?B?aWRuQVNsdmhMTERJZEVLMERxK3dzVEVVTHI3VUZhck1SZytnVEprcTloZHUr?=
 =?utf-8?B?TWxlWnNmTXRPTFVoRVNURjQ0Ym9SQzBFNG16azNHekhSVVJxU1R6UHdqRjNZ?=
 =?utf-8?B?NGtrMnVrN2U5Q1hRdGJML0xPNFViQlNMQXVRTm4vVCtIaCtWazhwR1JJK0Nw?=
 =?utf-8?B?MXJDRlN0NlhiV1hvWGRDMWZHOTI4dDNycDlwRklmYnZUUnVYYVBoaG5vb1Qw?=
 =?utf-8?B?ZVlzelI3NWY0TkZGV0hsQjJTKzdqSlA2Z0F4dllaam8zTEFCOVQvdUNGNDNN?=
 =?utf-8?B?TEsrcytLckM4WkRKaHhaSno4czhmSGJobCtSWERFRUgwdDdqQXRBTWtIOUl3?=
 =?utf-8?B?Z1VGOHNVWjVnaVJvWkY3VVBiSGQvQ0NVNys4MGNzM2NmL20vT0FzUGxqbzEx?=
 =?utf-8?B?QXRPYlVJUllLQTFmZHBDWG8rS2N5bHpFdU5IOUFSZ3poYnhyNVgrYVpzaWIv?=
 =?utf-8?B?MEFlalNOYjhRYi9BNHBtYVNlZ1J5cy9BYW5lYm1JclV0eHpTMVJVdDBlRzRj?=
 =?utf-8?B?OG55cmFvWnI4bmpzTm5JNmkxMWkwbm9RdGhMNWc5MmFmZjlXL2prelJtRUY3?=
 =?utf-8?B?OUROUzRhZ2VsVXI1Q1I0a3JYSnlxRmJFcGNzelVPZ2FxK1ZEaVRPV3JMSWpx?=
 =?utf-8?B?QzVWaXY3a1grM3hXSjJXV21WcW4rOHd4N3M3QmdrcW5OOU5RVC9wVmk2cllK?=
 =?utf-8?B?UDN4b01pNVlJYy95RzdSd1VJakFZMG9yaHBoNGFtZ2VWc1FOcGsyMVAxMnBp?=
 =?utf-8?B?cjBLQ0podU9HYjB1K1pONk9lYUd0OTB6VXhBU0Z0Y1BnMXdHZG02TWpWdmhq?=
 =?utf-8?B?amJTODYyR1g3WWJZMGkrTFBhc2ZZWHBTQUNhenJTcDRxbGZjYzk2Qm5lZGRV?=
 =?utf-8?B?YkdpVWo0azVkWTljRFdxenhwMU0rTnZCUmdFdHBKTElHK3BOTzljbFlOdVEx?=
 =?utf-8?B?Y0VRb1NYU3lFWFF1ZWg3NTNBdFJ1T2xDa2ZGSGI3eXA0VlBQelBveWdkSG9F?=
 =?utf-8?B?UUlDdXJXdjdhR3J0em45QkE2aCtFVUhheUFwU0RrNC9jaGhrUy91OUJOMmJW?=
 =?utf-8?B?WGs3eHQ1dzJobEVqaFpzb0FoaW9ZOVV2Zmllcmk2Rm1Qc05YY0NZYXVRYkY2?=
 =?utf-8?Q?XnTKC7q7uksR/wrG6I49qiCC0jNX7upzWPMpB7FpWk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2D43755BB3A3C4CB671B067190A6719@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c7ecf2-d7b4-4565-d220-08d9e6e3866a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 07:05:13.6122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sdGKrNfStTpXhEvpYFLW2hSsVm2/IGBKfLgXgk5ZRZmDaSDH7Q1HGLrYDxVNGLWaEwP3FfNMKO8zrXO4ZdumzS6ij1xIi/0boCWlNB3rdSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB3783
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDAzLzAyLzIwMjIgw6AgMDE6MDEsIEx1aXMgQ2hhbWJlcmxhaW4gYSDDqWNyaXTCoDoN
Cj4gT24gU2F0LCBKYW4gMjksIDIwMjIgYXQgMDU6MDI6MDlQTSArMDAwMCwgQ2hyaXN0b3BoZSBM
ZXJveSB3cm90ZToNCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlLmMgYi9rZXJuZWwvbW9k
dWxlLmMNCj4+IGluZGV4IDExZjUxZTE3ZmI5Zi4uZjM3NTgxMTVlYmFhIDEwMDY0NA0KPj4gLS0t
IGEva2VybmVsL21vZHVsZS5jDQo+PiArKysgYi9rZXJuZWwvbW9kdWxlLmMNCj4+IEBAIC04MSw3
ICs4MSw5IEBADQo+PiAgIC8qIElmIHRoaXMgaXMgc2V0LCB0aGUgc2VjdGlvbiBiZWxvbmdzIGlu
IHRoZSBpbml0IHBhcnQgb2YgdGhlIG1vZHVsZSAqLw0KPj4gICAjZGVmaW5lIElOSVRfT0ZGU0VU
X01BU0sgKDFVTCA8PCAoQklUU19QRVJfTE9ORy0xKSkNCj4+ICAgDQo+PiArI2lmbmRlZiBDT05G
SUdfQVJDSF9XQU5UU19NT0RVTEVTX0RBVEFfSU5fVk1BTExPQw0KPj4gICAjZGVmaW5lCWRhdGFf
bGF5b3V0IGNvcmVfbGF5b3V0DQo+PiArI2VuZGlmDQo+PiAgIA0KPj4gICAvKg0KPj4gICAgKiBN
dXRleCBwcm90ZWN0czoNCj4+IEBAIC0xMTEsNiArMTEzLDEyIEBAIHN0YXRpYyBzdHJ1Y3QgbW9k
X3RyZWVfcm9vdCB7DQo+PiAgICNkZWZpbmUgbW9kdWxlX2FkZHJfbWluIG1vZF90cmVlLmFkZHJf
bWluDQo+PiAgICNkZWZpbmUgbW9kdWxlX2FkZHJfbWF4IG1vZF90cmVlLmFkZHJfbWF4DQo+PiAg
IA0KPj4gKyNpZmRlZiBDT05GSUdfQVJDSF9XQU5UU19NT0RVTEVTX0RBVEFfSU5fVk1BTExPQw0K
Pj4gK3N0YXRpYyBzdHJ1Y3QgbW9kX3RyZWVfcm9vdCBtb2RfZGF0YV90cmVlIF9fY2FjaGVsaW5l
X2FsaWduZWQgPSB7DQo+PiArCS5hZGRyX21pbiA9IC0xVUwsDQo+PiArfTsNCj4+ICsjZW5kaWYN
Cj4+ICsNCj4+ICAgI2lmZGVmIENPTkZJR19NT0RVTEVTX1RSRUVfTE9PS1VQDQo+PiAgIA0KPj4g
ICAvKg0KPj4gQEAgLTE4Niw2ICsxOTQsMTEgQEAgc3RhdGljIHZvaWQgbW9kX3RyZWVfaW5zZXJ0
KHN0cnVjdCBtb2R1bGUgKm1vZCkNCj4+ICAgCV9fbW9kX3RyZWVfaW5zZXJ0KCZtb2QtPmNvcmVf
bGF5b3V0Lm10biwgJm1vZF90cmVlKTsNCj4+ICAgCWlmIChtb2QtPmluaXRfbGF5b3V0LnNpemUp
DQo+PiAgIAkJX19tb2RfdHJlZV9pbnNlcnQoJm1vZC0+aW5pdF9sYXlvdXQubXRuLCAmbW9kX3Ry
ZWUpOw0KPj4gKw0KPj4gKyNpZmRlZiBDT05GSUdfQVJDSF9XQU5UU19NT0RVTEVTX0RBVEFfSU5f
Vk1BTExPQw0KPj4gKwltb2QtPmRhdGFfbGF5b3V0Lm10bi5tb2QgPSBtb2Q7DQo+PiArCV9fbW9k
X3RyZWVfaW5zZXJ0KCZtb2QtPmRhdGFfbGF5b3V0Lm10biwgJm1vZF9kYXRhX3RyZWUpOw0KPj4g
KyNlbmRpZg0KPiANCj4gDQo+IGtlcm5lbC8gZGlyZWN0b3J5IGhhcyBxdWl0ZSBhIGZldyBmaWxl
cywgbW9kdWxlLmMgaXMgdGhlIHNlY29uZCB0bw0KPiBsYXJnZXN0IGZpbGUsIGFuZCBpdCBoYXMg
dG9ucyBvZiBzdHVmZi4gQWFyb24gaXMgZG9pbmcgd29yayB0bw0KPiBzcGxpdCB0aGluZ3Mgb3V0
IHRvIG1ha2UgY29kZSBlYXNpZXIgdG8gcmVhZCBhbmQgc28gdGhhdCBpdHMgZWFzaWVyDQo+IHRv
IHJldmlldyBjaGFuZ2VzLiBTZWU6DQo+IA0KPiBodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIw
MjIwMTMwMjEzMjE0LjEwNDI0OTctMS1hdG9tbGluQHJlZGhhdC5jb20NCj4gDQo+IEkgdGhpbmsg
dGhpcyBpcyBhIGdvb2QgcGF0Y2ggZXhhbXBsZSB3aGljaCBjb3VsZCBiZW5lZml0IGZyb20gdGhh
dCB3b3JrLg0KPiBTbyBJJ2QgbXVjaCBwcmVmZXIgdG8gc2VlIHRoYXQgd29yayBnbyBpbiBmaXJz
dCB0aGFuIHRoaXMsIHNvIHRvIHNlZSBpZg0KPiB3ZSBjYW4gbWFrZSB0aGUgYmVsb3cgY2hhbmdl
cyBtb3JlIGNvbXBhcnRhbWVudGFsaXplZC4NCj4gDQo+IEN1cmlvdXMsIGhvdyBtdWNoIHRlc3Rp
bmcgaGFzIGJlZW4gcHV0IGludG8gdGhpcyBzZXJpZXM/DQoNCg0KSSB0ZXN0ZWQgdGhlIGNoYW5n
ZSB1cCB0byAoaW5jbHVkaW5nKSBwYXRjaCA0IHRvIHZlcmlmeSBpdCBkb2Vzbid0IA0KaW50cm9k
dWNlIHJlZ3Jlc3Npb24gd2hlbiBub3QgdXNpbmcgDQpDT05GSUdfQVJDSF9XQU5UU19NT0RVTEVT
X0RBVEFfSU5fVk1BTExPQywNCg0KVGhlbiBJIHRlc3RlZCB3aXRoIHBhdGNoIDUuIEkgZmlyc3Qg
dHJpZWQgd2l0aCB0aGUgJ2hlbGxvIHdvcmxkJyB0ZXN0IA0KbW9kdWxlLiBBZnRlciB0aGF0IEkg
bG9hZGVkIHNldmVyYWwgaW1wb3J0YW50IG1vZHVsZXMgYW5kIGNoZWNrZWQgSSANCmRpZG4ndCBn
ZXQgYW55IHJlZ3Jlc3Npb24sIGJvdGggd2l0aCBhbmQgd2l0aG91dCBTVFJJQ1RfTU9EVUxFU19S
V1ggYW5kIA0KSSBjaGVja2VkIHRoZSBjb25zaXN0ZW5jeSBpbiAvcHJvYy92bWFsbG9jaW5mbw0K
ICAvcHJvYy9tb2R1bGVzIC9zeXMvY2xhc3MvbW9kdWxlcy8qDQoNCkkgYWxzbyB0ZXN0ZWQgd2l0
aCBhIGhhY2tlZCBtb2R1bGVfYWxsb2MoKSB0byBmb3JjZSBicmFuY2ggdHJhbXBvbGluZXMuDQoN
CkNocmlzdG9waGU=

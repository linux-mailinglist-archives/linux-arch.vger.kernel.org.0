Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B104A7F85
	for <lists+linux-arch@lfdr.de>; Thu,  3 Feb 2022 07:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiBCG64 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Feb 2022 01:58:56 -0500
Received: from mail-eopbgr120071.outbound.protection.outlook.com ([40.107.12.71]:5280
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229550AbiBCG64 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Feb 2022 01:58:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2ucP7DKUMu/P9CFwH6cl1/ZHfu8lqdtQBcTJCVqWLTdCEg/kiYM2sX4ciZQzb1J4Nzp9CLv0vSmPFasIJCibFIDUBtaJyIv4qLeSKYS67q5SlBlPFv1gZpeb0SG5zyEPuos4QLp0tumK6HY6m6wLdRloCcIvxl3d2qM0eGxqaz665XO2CVYCG67NOZ995VLuGdBaN4h8oMZxHuovxjyCr+XBEnjlyy5zxlhOA/po5BR1BdO7ziYPXwmPq0UA8mp8QkQm3SJsVW89WJM7oI/wYDksAwAvnPabVLshRpLcp1hOJS29YPzZBsKPbvPMsrDb4o/kfLXYR69BsTvEHLKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6MrWBQvLM0nclGedBbkKHr/ZmXT1xUaFjvlVlLhrz0=;
 b=UZ+3WKQhQtA7YGhSVtSoGNh2Fz5PYC5gOwLxdb0wrLn+ArsgE0E/EJlb3dwR1n92rR3p2KLkY38nXb6VoKz08d2n7PZJEyFHsl2rjgVY3Uid2bIEsGM3MV0DQifOQ0nLsF7rIKiK8fGC0Y24gnjssTrSg2pzidHCk6FAxNQ54blklRAl28uo6eiZgKOO9UMp+1r+3zajsGxh9ezmvfwI+l0UHxT7+/mYE1TIbmQ7vcy7QEricau9osgQkSnxqNNcdk1itLEq7Ldp+IUrB+GNadO/CEUoc12SQ49KDzjzbClcqVUtG/hmNsLJfFRh7vTpB8aYEKBZcx/3s9oKjIgSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3474.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 06:58:54 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%9]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 06:58:53 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] modules: Introduce data_layout
Thread-Topic: [PATCH v3 3/6] modules: Introduce data_layout
Thread-Index: AQHYFTHy2PWsHrGmbE6uWGTz7rHarqyA9H0AgAB4IYA=
Date:   Thu, 3 Feb 2022 06:58:53 +0000
Message-ID: <afa2c3be-3c08-5c0b-1cdf-2bb843498cbb@csgroup.eu>
References: <cover.1643475473.git.christophe.leroy@csgroup.eu>
 <230bfd896f24ca7a9281783aaa8c0ebfebd0bc7e.1643475473.git.christophe.leroy@csgroup.eu>
 <YfsYaDyqrFyVypkv@bombadil.infradead.org>
In-Reply-To: <YfsYaDyqrFyVypkv@bombadil.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f39808b-33e8-4148-c773-08d9e6e2a416
x-ms-traffictypediagnostic: MR1P264MB3474:EE_
x-microsoft-antispam-prvs: <MR1P264MB34746923BC13A5421A19921CED289@MR1P264MB3474.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+xr+TGmpepQqunVFT6p5mql5fdjsJ1ZThk82gO2vRoLO46NAzm5xGykd5A65QqOh8qsbD04igzSHGq94WQogaiiEBeb1JsoU0nWQTWXDHeyNErhpYKqdfcaEZatU3ywwqOJBaibshTtZ1KpDP60wIiP99MrrLk73jA7RxgCvFPHaAfNHHBJVuTN92txEqkK8SSVoXjwZkMTlCsnqWV7781/mL3miaDkNWiS3FK9GDOvBvWVrXnTPvtRt2jnf+NHx1hupP/EFLxnv+Iciwu87Aa+0/o6o6ADu4cK/OK1QBn1Kk8aah7JLJM482/t8J86XH2nUxu6SobQz1StAmqW+Ms+PyB0b6U0e139bdUcDRbPH1ef356B47fSEKECinUCAqy4xswFsojFIXNdBECgbB8AIjgBQPIXgUuE28jRjqLU7Uj7OTcLAomztWIictlFH44+lkKU0czaF5B5/UwkgGfq03zAuOh6WSan4Z7id8J0hAuenm4WDXQa/OqwgNVR1+blzsAgY+bnAAJDstxdaYYMK7QK7Yd8nZ6SX/W3xD5X8bbVMkm8vXEwmqZoHDe5m0gEOtuqr0+szikZN4pDh+7+S5dKsdoib7ZTUeQPZB9bo+Mzmb/MOEugXAWinDoLCe5vwi0gvkEzzzxwP63qVRSqed5hRoTSbakeudIDWsrP+Ye/LLVf6t5J0JW22dSAEN7YpgnlEaRx8jCYw7y44KXIlcLlR/tBs0pQ77hfASzHej0PzxQ7LlPFkNiuxnvAeZ4R+jYScMtYZouhU2haTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(91956017)(6506007)(186003)(8676002)(66476007)(66556008)(66946007)(66446008)(64756008)(8936002)(76116006)(86362001)(6512007)(4326008)(26005)(31696002)(44832011)(5660300002)(2906002)(122000001)(36756003)(66574015)(2616005)(508600001)(54906003)(316002)(6916009)(38070700005)(38100700002)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWw0VkdMS0x0OFBmM2hmVFg5RjZLbTJuUW1Hb2RVMjZ5Q2VPbnMzMlNKOGdI?=
 =?utf-8?B?T0pnazh4eDhQakRmUzY3Ly94RW9vRzAzTVVKL1ZHTWpFSXRhWUdmZVlqVzlw?=
 =?utf-8?B?N0tsWnpiM3JiTWxoYWZJdHB6eFZLcmhER1VQT0xPVkJ4UjJ2VFA0ZHIxYnVk?=
 =?utf-8?B?Tmx0eEdqVGdGUVFSZElac242UjdGZjF1aFZrbmxkRVRNK1Z6VzlWRkd6dURC?=
 =?utf-8?B?OHk5QmQ2cEVRN0hianl1MTZDa0ROQktxb01mRVQ1elBaMlJzd1FuSGFJUSsy?=
 =?utf-8?B?ck8xcHZuVFRXUHprdXd1aDNhVCtNUEdiSmpzZ3VJeS9qeGozeW9HNW52ajZW?=
 =?utf-8?B?ZVdDd3doa3huZ29nOHc3VnVaUmJ1QkhjV2c3dUFZcFNpYXFObXRpK0cwQkZQ?=
 =?utf-8?B?UkdxcjdiNWFqUFhLSTRqRG95bEFMUnZKeGJPL1k2eTJGOUIrU1dpTEdaS2xj?=
 =?utf-8?B?em0wSXJBcThNL2RpdmtKbkZBU0VoMStGWHF0d0xFYzFFb0k3SFRBUkthdzdm?=
 =?utf-8?B?THRxY3F3ZVZrRzhMbkNBc3lhTzcvUTY3MDZyczhhVkN3eVhpRkhZeVMxb3Zu?=
 =?utf-8?B?dDNHZ2sxY3FHUWNrZHlIaVJPaW5vcUpZcmxkTWhiUFZpMS9ZNzExejRTcitP?=
 =?utf-8?B?WEM2T1JFbGw0WWlZbmswMlhGOWNTSG1nc1JqUy9NYy9MSG9iR1VYcVYxTXpE?=
 =?utf-8?B?WjVYVlc2SzdiZjRkU0kwcndpN0ljUG5PQ2xNYmhUR2hHVnBDR1pENXphRlcx?=
 =?utf-8?B?djU2RDhLRjhXZmNUQjlYOTZYazVGYkM0aW9SRWNqcjFNeTBFb2VnZHQ2QVlQ?=
 =?utf-8?B?T3d3RUdjczlmSkRQcFZubWpmakhZN0lPOUVySTc3Ukp3VFBFcGh5Ly8zVncw?=
 =?utf-8?B?QWxMait5cGROckNIQVhQcG51WGxmenJCdHpnQ3NveVJlRWh6T1lWTVl6YmVy?=
 =?utf-8?B?bGhqbHdQQm43aFhnbFZrUmtQRVdoRThyMHg2WG9UTG9zcTVWVjYvMVJBSUxK?=
 =?utf-8?B?Q1hYMTkrL2ZnYmlQanJ5TTdPZDRKMy92WWJNTXdnZFIxUGRmU01FTEpudjRJ?=
 =?utf-8?B?eU80eTdUQjJBbnpBaGlURE55Y3lBS1JxT2l3R0NZSm84dFV3MFQ3V0FmNE1x?=
 =?utf-8?B?b1YrbndacHpJRnZHdVlLSGlYdWJ4ZnBVSmtxRG9aYW5yWmV5alhlTm1Zd1hV?=
 =?utf-8?B?WFpGVWFhM0JTZHpTRUNqZEtJaHM5bzloR1lrcHA4UEg2TzJhK3pLcFpOM2RX?=
 =?utf-8?B?b1EyV0NQcEdkbFNDSzE4d3g2UEVHRjB4eVZ1cTh5cGl4azJvOE5vdnpZRGZo?=
 =?utf-8?B?RHljM3VxOFpkNk9HZFlaaEpSVXFkbGYxSGxXUzUzT1lxYlBCam04UVNLaUkz?=
 =?utf-8?B?d0g4Nm40UFJDTTI2bXZUNzZSNzk3UW8vbWc5VG11VVJJRHNqbk9saTE2Yktx?=
 =?utf-8?B?UHpVUHlvN3FseGg3SVZlZldweGN6SzZ6MXprUHh5ay9zSE56N2VSMUMyUHR6?=
 =?utf-8?B?aXBmaHljT0pDczU1WFk5a0tiZmlzSGxOd3lRdHpvUUFOcDZ0aGFMN0JtRFlV?=
 =?utf-8?B?emgwZC9IRmMzblZsWWZNYzJQSGNyWmR2bUtpR2FZVVYzRXZkVS9aMFU0ZXZu?=
 =?utf-8?B?WS93RmRodUt3VkpHVW0ra1orUVRFVmkxaHNkZldNM1JtR1hqN2w5RUVWR05v?=
 =?utf-8?B?SVl0aWp5Y2NJRHFQcExRTldOUmwxa2dtajNFWlMzSVFXSE1Kek11b08yb1BO?=
 =?utf-8?B?TnBxWVRIQ2VvSjQ4SldrNGhnbGZ2YWRzOUVDZDZLTnVQeTY3NU5ieVoyekxP?=
 =?utf-8?B?di9aaFlxOUtkTVZVY1FUZmVlNVBWMGdmc1BEaVFCbG9XcTd3clc1ZGJ0R3Yv?=
 =?utf-8?B?NXdudEQrRFhUdHNMc2c1aXJEY3VOeldoT1N4Nkd0anJ6TG5pUTVPekxHaVk5?=
 =?utf-8?B?MkNwSThSdFhHSnpSUmVCa1haKytGaHBpODV5OStjWmszWG54Y2Jhcnd5Ui8r?=
 =?utf-8?B?UEExYitsQUhEZHowemRpdUU2bzdCOTB1KzVEQUtwU2Q0eHdTSUdLZFNWdlF1?=
 =?utf-8?B?NC8vMmx5Vnk4elA5bXgyRG92elA4dTNRNlAwNzBYRkNBOVlCeHRneXJGMlJ3?=
 =?utf-8?B?bG1KMW5HaG1UQzJJTjlxc2tVTXlrUFRtZXA5YkdLM01wVHlmeGJEc25lZ0pM?=
 =?utf-8?B?d1V4anhwWkYxbDF5MjdsejBNYTNPanhXZVNHN01ocU9mTmNvMis5WEVXVXpS?=
 =?utf-8?Q?Tx2TrDah2Rz7cK6b5X7nR66rQh125eG3arYRRDqrq0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C5A3E745B372F41AF387F73BC4FF018@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f39808b-33e8-4148-c773-08d9e6e2a416
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 06:58:53.8338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+7ncscTHXjjIRs912cMjHJ5lj6i0ZLpVPWtbg48N22jdhcgXrIYxnhEMJsmGczacAL2J19FYvabTodjw5nH/Wl+uwzB3N5iElvkBgaOb0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3474
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDAzLzAyLzIwMjIgw6AgMDA6NDgsIEx1aXMgQ2hhbWJlcmxhaW4gYSDDqWNyaXTCoDoN
Cj4gT24gU2F0LCBKYW4gMjksIDIwMjIgYXQgMDU6MDI6MDdQTSArMDAwMCwgQ2hyaXN0b3BoZSBM
ZXJveSB3cm90ZToNCj4+IGRpZmYgLS1naXQgYS9rZXJuZWwvbW9kdWxlLmMgYi9rZXJuZWwvbW9k
dWxlLmMNCj4+IGluZGV4IDE2M2UzMmUzOTA2NC4uMTFmNTFlMTdmYjlmIDEwMDY0NA0KPj4gLS0t
IGEva2VybmVsL21vZHVsZS5jDQo+PiArKysgYi9rZXJuZWwvbW9kdWxlLmMNCj4+IEBAIC04MSw2
ICs4MSw4IEBADQo+PiAgIC8qIElmIHRoaXMgaXMgc2V0LCB0aGUgc2VjdGlvbiBiZWxvbmdzIGlu
IHRoZSBpbml0IHBhcnQgb2YgdGhlIG1vZHVsZSAqLw0KPj4gICAjZGVmaW5lIElOSVRfT0ZGU0VU
X01BU0sgKDFVTCA8PCAoQklUU19QRVJfTE9ORy0xKSkNCj4+ICAgDQo+PiArI2RlZmluZQlkYXRh
X2xheW91dCBjb3JlX2xheW91dA0KPj4gKw0KPj4gICAvKg0KPj4gICAgKiBNdXRleCBwcm90ZWN0
czoNCj4+ICAgICogMSkgTGlzdCBvZiBtb2R1bGVzIChhbHNvIHNhZmVseSByZWFkYWJsZSB3aXRo
IHByZWVtcHRfZGlzYWJsZSksDQo+PiBAQCAtMjQ1MSw3ICsyNDU0LDEwIEBAIHN0YXRpYyB2b2lk
IGxheW91dF9zZWN0aW9ucyhzdHJ1Y3QgbW9kdWxlICptb2QsIHN0cnVjdCBsb2FkX2luZm8gKmlu
Zm8pDQo+PiAgIAkJCSAgICB8fCBzLT5zaF9lbnRzaXplICE9IH4wVUwNCj4+ICAgCQkJICAgIHx8
IG1vZHVsZV9pbml0X2xheW91dF9zZWN0aW9uKHNuYW1lKSkNCj4+ICAgCQkJCWNvbnRpbnVlOw0K
Pj4gLQkJCXMtPnNoX2VudHNpemUgPSBnZXRfb2Zmc2V0KG1vZCwgJm1vZC0+Y29yZV9sYXlvdXQu
c2l6ZSwgcywgaSk7DQo+PiArCQkJaWYgKG0pDQo+PiArCQkJCXMtPnNoX2VudHNpemUgPSBnZXRf
b2Zmc2V0KG1vZCwgJm1vZC0+ZGF0YV9sYXlvdXQuc2l6ZSwgcywgaSk7DQo+PiArCQkJZWxzZQ0K
Pj4gKwkJCQlzLT5zaF9lbnRzaXplID0gZ2V0X29mZnNldChtb2QsICZtb2QtPmNvcmVfbGF5b3V0
LnNpemUsIHMsIGkpOw0KPj4gICAJCQlwcl9kZWJ1ZygiXHQlc1xuIiwgc25hbWUpOw0KPiANCj4g
SHVoIHdoeSBpcyB0aGlzIGJyYW5jaGluZyBoZXJlLCBnaXZlbiB5b3UganVzdCB1c2VkIG1vZC0+
ZGF0YV9sYXlvdXQgaW4NCj4gYWxsIG90aGVyIGFyZWFzPw0KDQpUaGUgbW9kdWxlIHRleHQgcmVt
YWlucyBpbiBjb3JlX2xheW91dCwgc28gdGhlIHRleHQgc2VjdGlvbiBzdGlsbCBuZWVkcyANCmNv
cmVfbGF5b3V0LiBJbiB0aGUgbWFza3NbXVtdIHRhYmxlLCBpdCBjb3JyZXNwb25kcyB0byB0aGUg
Zmlyc3QgbGluZSwgDQp3aGljaCBoYXMgZmxhZyAgU0hGX0VYRUNJTlNUUi4gSW4gdGhlIGxvb3Ag
dGhhdCdzIHdoZW4gJ20nIGlzIDAuDQoNCkluIHRoZSBmb2xsb3dpbmcgc3dpdGNoL2Nhc2UsIGNh
c2UgMCBzdGlsbCB1c2VzIGNvcmVfbGF5b3V0Lg0KDQo+IA0KPj4gQEAgLTM0NjgsNiArMzQ3NCw4
IEBAIHN0YXRpYyBpbnQgbW92ZV9tb2R1bGUoc3RydWN0IG1vZHVsZSAqbW9kLCBzdHJ1Y3QgbG9h
ZF9pbmZvICppbmZvKQ0KPj4gICAJCWlmIChzaGRyLT5zaF9lbnRzaXplICYgSU5JVF9PRkZTRVRf
TUFTSykNCj4+ICAgCQkJZGVzdCA9IG1vZC0+aW5pdF9sYXlvdXQuYmFzZQ0KPj4gICAJCQkJKyAo
c2hkci0+c2hfZW50c2l6ZSAmIH5JTklUX09GRlNFVF9NQVNLKTsNCj4+ICsJCWVsc2UgaWYgKCEo
c2hkci0+c2hfZmxhZ3MgJiBTSEZfRVhFQ0lOU1RSKSkNCj4+ICsJCQlkZXN0ID0gbW9kLT5kYXRh
X2xheW91dC5iYXNlICsgc2hkci0+c2hfZW50c2l6ZTsNCj4+ICAgCQllbHNlDQo+PiAgIAkJCWRl
c3QgPSBtb2QtPmNvcmVfbGF5b3V0LmJhc2UgKyBzaGRyLT5zaF9lbnRzaXplOw0KPj4gICANCj4g
DQo+IExpa2V3aXNlIGhlcmUuDQoNClNhbWUgaGVyZSwgdGhlIHNlY3Rpb24gd2l0aCBmbGFnIFNI
Rl9FWEVDSU5TVFIgaXMgYSB0ZXh0IHNlY3Rpb24sIGl0IA0Kc3RheXMgaW4gY29yZV9sYXlvdXQu
DQoNCkNocmlzdG9waGU=

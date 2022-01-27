Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259A249E128
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jan 2022 12:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiA0LeV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jan 2022 06:34:21 -0500
Received: from mail-eopbgr120058.outbound.protection.outlook.com ([40.107.12.58]:32640
        "EHLO FRA01-PR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240625AbiA0Ld7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jan 2022 06:33:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIGhJQIALoN2PAi3/e7U1gyAUzbA0nbzP18WzzgDK61CQ1sVYri/OX52e5ij1W0Jttfvw+p/4V2YovfKY1BlWv5QGbjEeArlPyMGO/GZg1NIYh7IdFuGpigJBL49JIeiVP6apubIZsgwuR3wDjBEDP1iQ4IDOEX6PeMMoh5GV/0csHFFYBQmOGAjxARqFpaye3DJxvSgDsbe1xAHqlkAR5rRXq+Lc21s9mSsjDfrGPprGGVmLwKGBnH17aKmmeT7DqUPWIT4jU6PyLTgtLPDPTt4yI+ZkaALLAdJzbkhps2vJ1G0ahd5834i5s7qC/QFEsuoWhaz1BDzyBsq8FM9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx2+eC1uf8wtEnfA7YJvh3x5o5ME8WVtTUIDGDCPg3k=;
 b=ieCdYMSlVON9g/zv19PUOt/A4yljlx7xgTmbtgOnbKKP3oAPMpnKfqFm5UaF7Mp5Ivac6KTJwAO7sclk1lp75cgDNjedECqcaYfbBqugp7X2+2lS8Gg69FlwDSC6igmBdh1f3Pb2WCie2na5dxeZaxhyfIZ8l3So8quqbk6xaxBvFYqFUfXeuzIS68zVLe3iby8lAsGhJqv88WyvgiGh+y/ZkBoKRxzHXGj2s/ceQO+B8dRYPhOnHiAPjxMnLW4DGVavT2Gj7tXLR9OGWJwB9z173ED0Ul44fZlfLIH82xHkTcKOn8+5/hOanXNUasHXUf1Y9eGosVbe224Mv3u58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1645.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 11:33:57 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 11:33:57 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/7] modules: Refactor within_module_core() and
 within_module_init()
Thread-Topic: [PATCH 1/7] modules: Refactor within_module_core() and
 within_module_init()
Thread-Index: AQHYEQPgKgdjFmN/j0GzHm/ZB6XnTKx113OAgADqDgA=
Date:   Thu, 27 Jan 2022 11:33:57 +0000
Message-ID: <6fff45a4-aed1-ada1-43cd-cea270c12ce1@csgroup.eu>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
 <e5e58875bd15551d0386552d3f9fa9ee8bc183a2.1643015752.git.christophe.leroy@csgroup.eu>
 <YfG+zVl8aV+UszoE@kernel.org>
In-Reply-To: <YfG+zVl8aV+UszoE@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37621692-29f8-4f91-f188-08d9e188e83e
x-ms-traffictypediagnostic: PR1P264MB1645:EE_
x-microsoft-antispam-prvs: <PR1P264MB16450C368461BDBCE637E1F1ED219@PR1P264MB1645.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xJZ44ckgr+zoiCxs/3zCBa2FY6BwyZwu62mn1QaT951yeL5T0IoFFbKX6S5bG7j0KOY+pOGibQLcR9tq7SUBlbR/Swh86wUlPEquwfbT8VVo8JW/W/hP8IrGXtOBom8TpJAVINs3YoF5o2sqK+DpW3buDyVpQb6ESLaqiWOEsnye6ssGV02j4KI0I1DnjjiHffZ9YEJ7zUihQJsP6qjLuhM3tyQdjRH3bjKRUKtsEdnGyL7w9SuN61xf+b5veSYJj7dm5Z2mjjHj3F+DNeyNlck51Lyac/y25QiaQuR0YbZ5f+DyeJh21e32dlf3nzU8ChVTe0q+PVLghmbnpjGc7Jm5XHw7wBlCZ2rkDDJ1HU014dXaMk3pMQixxXJ3A9IatdSzw+rLnVI+GEXPP3XyUGzn8KnX/jevJMU3tB8MU9QYKPAG769gdNPhwMbiFjDxJTMgf7hoejazxYF8YgQS8RbdMFHyTPh3tWG25ZwjnE47govCoKbd+3mZZhX0hEQOM14E8fHpmrYPvg89gbaM2ES3y/eIZ2SaG/OFE1izE56f95QiGoxLvY2tk6fJ8638t6MviD7ctIa0hYzGM3Z8WtB1rohvMZ/ks4/4RYoYJnvWaSTl7pvL+lkUFDKTHRq3WNSdPCn68usAhKX1sxwmCY7ND3iIfzDLau2SpfXMNKpmI2FUtu9m847xdSdai5bww7dPBMN+EXF6QfbG650YoRT61rF8f7q4no+Hcl3bezQxtwZqWGwsSuqI2fW4dk6OQvU/j9xmTAvUf54g/17u5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(76116006)(66556008)(64756008)(66476007)(66446008)(44832011)(91956017)(8936002)(8676002)(36756003)(38100700002)(5660300002)(122000001)(2906002)(71200400001)(54906003)(6916009)(4326008)(316002)(2616005)(6506007)(31686004)(6512007)(83380400001)(186003)(508600001)(38070700005)(31696002)(86362001)(6486002)(26005)(66574015)(43740500002)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2hraHpkenFudEtLcStYOWx6c01DWGlkRmwrQ1Q4Mk5nekNjQmY2cHE3OXNz?=
 =?utf-8?B?KzIyTmhpNEZ5R3hwY3FEK3pvRXdibGNNNWh0aXBzeWd5UVRVOUVBVE9xVlVh?=
 =?utf-8?B?T3pqbHVOeTltS25lNUpIbllKeWRBdXMzVG54bEFQeS9PcFA5cytjWnpSTmww?=
 =?utf-8?B?Z1BZWnhoN1JMb1Znem1BaXR3Si9CbDBkRmV3MXM5dC9tWERCM2hld0N5Z0xM?=
 =?utf-8?B?OWJHOVNHRXZJcEo3d1p2UCt6SDZIYjN3RzVGdHpBZlc1NzBacXlOTERWNk5G?=
 =?utf-8?B?L3o1TVZuQnNkdmRHdVVwL093WWFlQzRYNlJSWnphV2Q2Si9DbzhyOE5SaWJi?=
 =?utf-8?B?SmVTQmN6WmN2NU9sVjJZMXQ3bTlWMDNIS3pQTi8zM0VCYkIrMGtZS3pOdU5x?=
 =?utf-8?B?Q283ZjhZdUlHcm5DRjJZOVVVK3RWMlFYRTlLNUJxclZMQW94dEhvNXh4REdx?=
 =?utf-8?B?Z1dKV0RWV3FnTGZ1OW1kdDVQY0E5ZUxxVDZIMEtFKzJ1MEdzRTUycS9TVGZE?=
 =?utf-8?B?UnJ0eGpXR3pwRmNjTHcvNnIzNUxTMVVaaUdyZ1EyRlRrWGpQRHNYaHE5WG83?=
 =?utf-8?B?emdpK3ZlQ2xWbHlRYWFSNDRlaG5DcE5XM1hvVlBRNDh3ZHh0SXEzV0k1R0lI?=
 =?utf-8?B?SVlET3N0NnU5dXBMWFZCbERpT0x4blNwYXcvbHFtSXh0Mzk5L3dMaEFwZXUy?=
 =?utf-8?B?TjI4c2lYaHVJS1Y4Qm5aQXA4NmxmNWV4ZlAyN0ZuZkxJcVNmeDV4Ynp3RXl5?=
 =?utf-8?B?YjJGaU9iU1JwTHJ3Z3FZcGVQdk1lVWRia3FxUG8xOXQ5dnNjSXNjZHJ4Tk1a?=
 =?utf-8?B?VEljSkw1cUhkVUlXbzRLY0g0VG9DbjhXclFPazlrNFYzV3pFUkJTQ3M0eXpE?=
 =?utf-8?B?NXRoQU8zUVpRQzQzUTFWMGZXVTFZcWFhQ2ZDNTg2MUdQeUY0YXp5aldGQXNQ?=
 =?utf-8?B?ejl4d00yZllab1V2TmRBUklHdkdCdTZicUFuL2pzWWYzNjBUNnE0NTVmNmZ1?=
 =?utf-8?B?RHdzdFQveXk2MWNGSzRlZjduUVZQdURqUUhQVTBpWkR0MVpMMzk3OHREUGZG?=
 =?utf-8?B?aXZFVGpqMnBtdzdyUjhjdStkblJpSTFGSFZseHVkWWx5Uk54V2dUMDZnZ0U3?=
 =?utf-8?B?dDljWXVWdWx4dUEyRU44dHRYZ094MEYzbGlFRmZPYlJQREFxeG0zRk1ZOFpw?=
 =?utf-8?B?TmxLZEJuRkswTGtlbDUxaFE5blpDMXNnTWtPUlQxUncyenF2TW5PN0hJcjlM?=
 =?utf-8?B?RzV1VWt5Rk96MFhCZ2JOaTd1eFM5eHZNL0g2VXR0cEFKelFHUXNCcGRyamZN?=
 =?utf-8?B?bGJBSEl5cHdobXlURytycXl6bWZUc0xRZ1RSZjNiNzhoQ1cwS3hWWWowTk00?=
 =?utf-8?B?OXBtUWo5aXNsOEp1QW5SMDA3b1RId1Zxb05neWFkb0VWaXRmbnFNdFlwTUZP?=
 =?utf-8?B?SUxJTGlyOHdBTXRLQXp1Q0RsaWhnd2RKb1lvRTlSMFdkWk1ncEFzeFpSR3ZS?=
 =?utf-8?B?RWFjOHhKdkk4R0RLTndFUUJXeWxVNFNmS1A4UHlBT282b1JzWVh6bnIwVVI2?=
 =?utf-8?B?ZGdSbjV2LzR6T3MyTUpoVlptT25hU3VvNUlwZmh6RCtpVjJ1ZHY4R3B2TzFI?=
 =?utf-8?B?VEtQNmdFY21qNko3TVVmS2U4UUEzQ3ErREtQYmZIN01zWUx6YVpRUDYzNVhj?=
 =?utf-8?B?MHJ0dHJMdTUvcmY4WWFsRUZjTTVJYmo4aDR4MGllUHJmV3Z1eUdneEQvdWZy?=
 =?utf-8?B?bVlQMDhudzNjOGpVbkh4QVZOQkFyM3J5YXNoUjJVamQ1aVhuUE16Zm1MaEVs?=
 =?utf-8?B?UlBqQmhncGFoeFNYb3hMYTNwVDBIS2lQZWxWZXNEUGJ5ZURObzlTMUVHVDNW?=
 =?utf-8?B?SDJHRm1MWnN0azVmb2E4LzV6ejBTSWNnZ3RQUUxwWHJaVkVxdHpWV1FGazRp?=
 =?utf-8?B?Z0xsYlZwZUwxT05JUDZ2WndZN0drbWIwanM1TW5IbXJDTWY0N2Z2cjAyK0pM?=
 =?utf-8?B?aklUdmhqSTJuQWJWQkZxQWZWaWEzK2psWm5EYXBRcThNV042UytReDBZYktG?=
 =?utf-8?B?YmZxSkxVK0VtSTV5QTc4bHpJYjBJOHc5Yko0MWpadm5pUHJIdUVSZ250TXBP?=
 =?utf-8?B?WDdGRklGYWtWYnVZNVBQZjFBdVJEbzJ0VkVZQXZ3eGg2RkRIM0VzZ2Z6SHFz?=
 =?utf-8?B?dVpKWlJFVXEvaTAvQkppSGJQUXlzRHB5L2ZXWTBTc3UrVTJYczBwMkFMNnhv?=
 =?utf-8?Q?0j16I5oLIkvSo5gW/ycyFVWHbAOk+X9Np60C+xWwVU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C02C8DC313140143A6D9FC0C859ACF10@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 37621692-29f8-4f91-f188-08d9e188e83e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 11:33:57.7252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7SmXRT80R343hZILRh2C/0qRpfJHUgVV93bEZj+FrRLux541HhhJ4fgneIYFUj3XSXmGl9Oi/RJA2Fiv5gPED3YIawuOBGb2eljV1kTNu0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1645
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI2LzAxLzIwMjIgw6AgMjI6MzYsIE1pa2UgUmFwb3BvcnQgYSDDqWNyaXTCoDoNCj4g
T24gTW9uLCBKYW4gMjQsIDIwMjIgYXQgMDk6MjI6MTVBTSArMDAwMCwgQ2hyaXN0b3BoZSBMZXJv
eSB3cm90ZToNCj4+IHdpdGhpbl9tb2R1bGVfY29yZSgpIGFuZCB3aXRoaW5fbW9kdWxlX2luaXQo
KSBhcmUgZG9pbmcgdGhlIGV4YWN0IHNhbWUNCj4+IHRlc3QsIG9uZSBvbiBjb3JlX2xheW91dCwg
dGhlIHNlY29uZCBvbiBpbml0X2xheW91dC4NCj4+DQo+PiBJbiBwcmVwYXJhdGlvbiBvZiBpbmNy
ZWFzaW5nIHRoZSBjb21wbGV4aXR5IG9mIHRoYXQgdmVyaWZpY2F0aW9uLA0KPj4gcmVmYWN0b3Ig
aXQgaW50byBhIHNpbmdsZSBmdW5jdGlvbiBjYWxsZWQgd2l0aGluX21vZHVsZV9sYXlvdXQoKS4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95
QGNzZ3JvdXAuZXU+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9saW51eC9tb2R1bGUuaCB8IDE3ICsr
KysrKysrKysrKystLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21vZHVsZS5o
IGIvaW5jbHVkZS9saW51eC9tb2R1bGUuaA0KPj4gaW5kZXggYzlmMTIwMGIyMzEyLi4zM2I0ZGI4
ZjVjYTUgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L21vZHVsZS5oDQo+PiArKysgYi9p
bmNsdWRlL2xpbnV4L21vZHVsZS5oDQo+PiBAQCAtNTY1LDE4ICs1NjUsMjcgQEAgYm9vbCBfX2lz
X21vZHVsZV9wZXJjcHVfYWRkcmVzcyh1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcg
KmNhbl9hZGRyKTsNCj4+ICAgYm9vbCBpc19tb2R1bGVfcGVyY3B1X2FkZHJlc3ModW5zaWduZWQg
bG9uZyBhZGRyKTsNCj4+ICAgYm9vbCBpc19tb2R1bGVfdGV4dF9hZGRyZXNzKHVuc2lnbmVkIGxv
bmcgYWRkcik7DQo+PiAgIA0KPj4gK3N0YXRpYyBpbmxpbmUgYm9vbCB3aXRoaW5fcmFuZ2UodW5z
aWduZWQgbG9uZyBhZGRyLCB2b2lkICpiYXNlLCB1bnNpZ25lZCBpbnQgc2l6ZSkNCj4+ICt7DQo+
PiArCXJldHVybiBhZGRyID49ICh1bnNpZ25lZCBsb25nKWJhc2UgJiYgYWRkciA8ICh1bnNpZ25l
ZCBsb25nKWJhc2UgKyBzaXplOw0KPj4gK30NCj4gDQo+IFRoZXJlJ3MgYWxzbyAnd2l0aGluJyBh
dCBsZWFzdCBpbiBhcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jIGFuZCBzdXJlbHkNCj4gdG9u
cyBvZiBvcGVuLWNvZGVkICJhZGRyZXNzIHdpdGhpbiIgY29kZS4NCj4gDQo+IFNob3VsZCBpdCBs
aXZlIGluLCBzYXksIGluY2x1ZGUvbGludXgvcmFuZ2UuaD8NCj4gDQoNCmluY2x1ZGUvbGludXgv
cmFuZ2UuaCBoYXMgZnVuY3Rpb25zIHRoYXQgd29yayB3aXRoIHN0cnVjdCByYW5nZXMuDQpJdCBt
aWdodCBiZSBhbiBhbHRlcm5hdGl2ZSwgdG8gYmUgaW52ZXN0aWdhdGVkIGEgYml0IG1vcmUuDQoN
CkF0IHRoZSB0aW1lIGJlaW5nLCB0aGlzIGNoYW5nZSBmaW5hbGx5IGJyaW5ncyBsaXR0bGUgYWRk
ZWQgdmFsdWUgc28NCkkgZHJvcCB0aGUgdHdvIGZpcnN0IHBhdGNoZXMgZnJvbSB0aGUgc2VyaWVz
Lg0KDQpUaGFua3MNCkNocmlzdG9waGU=

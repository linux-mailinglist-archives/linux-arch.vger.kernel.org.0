Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 508AB42C77
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2019 18:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438344AbfFLQh0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jun 2019 12:37:26 -0400
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:13447
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438342AbfFLQh0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Jun 2019 12:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQbqrJiISLa4uI+tR3Az4GTEGy3aPlGznHpcP/BLjOw=;
 b=jpcYyBpRvXHXGJW+ds2BHG3uEO6ViklqATgjygElrZZQVfNMmzW5f33jWollfbLypTF2YbxuH3pQ4gqTMoYCFSKKMDwOlNSvtYgdJo/tbbmqXalCT7NmQelg6T6M6qlpFQJ6RKYNwvh0Sk8e6mzQbzgvgYmGWeTAvXXwRR3FOAE=
Received: from VE1PR08MB4637.eurprd08.prod.outlook.com (10.255.27.14) by
 VE1PR08MB4895.eurprd08.prod.outlook.com (10.255.113.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Wed, 12 Jun 2019 16:37:20 +0000
Received: from VE1PR08MB4637.eurprd08.prod.outlook.com
 ([fe80::6574:1efb:6972:2b37]) by VE1PR08MB4637.eurprd08.prod.outlook.com
 ([fe80::6574:1efb:6972:2b37%6]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 16:37:20 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 2/2] arm64: Relax
 Documentation/arm64/tagged-pointers.txt
Thread-Topic: [PATCH v4 2/2] arm64: Relax
 Documentation/arm64/tagged-pointers.txt
Thread-Index: AQHVIS/qgxSPAZqYS0apbOMTIFAdLaaYN9IA
Date:   Wed, 12 Jun 2019 16:37:20 +0000
Message-ID: <ebe4fffd-c8a5-35d4-9370-a6573b2a7c87@arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190612142111.28161-1-vincenzo.frascino@arm.com>
 <20190612142111.28161-3-vincenzo.frascino@arm.com>
In-Reply-To: <20190612142111.28161-3-vincenzo.frascino@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P265CA0101.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::17) To VE1PR08MB4637.eurprd08.prod.outlook.com
 (2603:10a6:802:b1::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fbc98d2-bb72-4fbf-3bbe-08d6ef543d41
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4895;
x-ms-traffictypediagnostic: VE1PR08MB4895:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4895AD6CA6AB833ECD306246EDEC0@VE1PR08MB4895.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(136003)(189003)(199004)(99286004)(64126003)(6486002)(81166006)(65826007)(7736002)(53936002)(2906002)(66446008)(14444005)(6512007)(256004)(8676002)(66946007)(2201001)(64756008)(229853002)(478600001)(66556008)(14454004)(66476007)(6436002)(305945005)(8936002)(2501003)(5660300002)(72206003)(81156014)(71190400001)(6506007)(58126008)(186003)(11346002)(316002)(2616005)(102836004)(386003)(110136005)(44832011)(54906003)(73956011)(52116002)(4326008)(486006)(71200400001)(65956001)(25786009)(446003)(476003)(53546011)(31696002)(36756003)(6246003)(66066001)(68736007)(31686004)(65806001)(26005)(6116002)(3846002)(86362001)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4895;H:VE1PR08MB4637.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ArZcTyYDkh4Z7xUs60YEzHWJP6LZxH/M83BeKyobfcMkD0rM0j0OXX38PHpnekSqaNpVHu1m0FnQTPiHp83NqC7kqJyimE1E3LerE5teGYkqeCW6d6q/EhbG11Ugfu+fobIML+DQKY+2ETWI2x36APPL6dI91zs3D1o7GZCtAWI+BXupLe6cLLNbC8v8ZMgYt3E5HYzoGSxdHGgAFRlo02PZaJOPH8UT7Lf7eG5oQQOHV/NHdGyb9l64oGqYqjqEX9nQ7al00lDw0cm0aRvGr4kNr7HToGH/HwA1X1RHtRMFVfA1spzf2jV+Oq8z73p6wndUHbXsm4ZAYyxU65Kmb7ch9J8Eld5eALaR+i/1foPVNnp+MWJedToB/ixFM7nI5QQt4qc8uOn/l+1y5mnVa7TZChVe8r8zZdbNSrvHajo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA99E85AC8B5C34B87124BD326392332@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbc98d2-bb72-4fbf-3bbe-08d6ef543d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 16:37:20.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Szabolcs.Nagy@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4895
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMTIvMDYvMjAxOSAxNToyMSwgVmluY2Vuem8gRnJhc2Npbm8gd3JvdGU6DQo+IE9uIGFybTY0
IHRoZSBUQ1JfRUwxLlRCSTAgYml0IGhhcyBiZWVuIGFsd2F5cyBlbmFibGVkIGhlbmNlDQo+IHRo
ZSB1c2Vyc3BhY2UgKEVMMCkgaXMgYWxsb3dlZCB0byBzZXQgYSBub24temVybyB2YWx1ZSBpbiB0
aGUNCj4gdG9wIGJ5dGUgYnV0IHRoZSByZXN1bHRpbmcgcG9pbnRlcnMgYXJlIG5vdCBhbGxvd2Vk
IGF0IHRoZQ0KPiB1c2VyLWtlcm5lbCBzeXNjYWxsIEFCSSBib3VuZGFyeS4NCj4gDQo+IFdpdGgg
dGhlIHJlbGF4ZWQgQUJJIHByb3Bvc2VkIGluIHRoaXMgc2V0LCBpdCBpcyBub3cgcG9zc2libGUg
dG8gcGFzcw0KPiB0YWdnZWQgcG9pbnRlcnMgdG8gdGhlIHN5c2NhbGxzLCB3aGVuIHRoZXNlIHBv
aW50ZXJzIGFyZSBpbiBtZW1vcnkNCj4gcmFuZ2VzIG9idGFpbmVkIGJ5IGFuIGFub255bW91cyAo
TUFQX0FOT05ZTU9VUykgbW1hcCgpLg0KPiANCj4gUmVsYXggdGhlIHJlcXVpcmVtZW50cyBkZXNj
cmliZWQgaW4gdGFnZ2VkLXBvaW50ZXJzLnR4dCB0byBiZSBjb21wbGlhbnQNCj4gd2l0aCB0aGUg
YmVoYXZpb3VycyBndWFyYW50ZWVkIGJ5IHRoZSBBUk02NCBUYWdnZWQgQWRkcmVzcyBBQkkuDQo+
IA0KPiBDYzogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4NCj4gQ2M6
IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPg0KPiBDQzogQW5kcmV5IEtvbm92YWxv
diA8YW5kcmV5a252bEBnb29nbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBWaW5jZW56byBGcmFz
Y2lubyA8dmluY2Vuem8uZnJhc2Npbm9AYXJtLmNvbT4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9u
L2FybTY0L3RhZ2dlZC1wb2ludGVycy50eHQgfCAyMyArKysrKysrKysrKysrKysrLS0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hcm02NC90YWdnZWQtcG9pbnRlcnMudHh0IGIv
RG9jdW1lbnRhdGlvbi9hcm02NC90YWdnZWQtcG9pbnRlcnMudHh0DQo+IGluZGV4IGEyNWE5OWU4
MmJiMS4uZGI1OGE3ZTk1ODA1IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FybTY0L3Rh
Z2dlZC1wb2ludGVycy50eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9hcm02NC90YWdnZWQtcG9p
bnRlcnMudHh0DQo+IEBAIC0xOCw3ICsxOCw4IEBAIFBhc3NpbmcgdGFnZ2VkIGFkZHJlc3NlcyB0
byB0aGUga2VybmVsDQo+ICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiAgDQo+ICBBbGwgaW50ZXJwcmV0YXRpb24gb2YgdXNlcnNwYWNlIG1lbW9yeSBhZGRyZXNzZXMg
YnkgdGhlIGtlcm5lbCBhc3N1bWVzDQo+IC1hbiBhZGRyZXNzIHRhZyBvZiAweDAwLg0KPiArYW4g
YWRkcmVzcyB0YWcgb2YgMHgwMCwgdW5sZXNzIHRoZSB1c2Vyc3BhY2Ugb3B0cy1pbiB0aGUgQVJN
NjQgVGFnZ2VkDQo+ICtBZGRyZXNzIEFCSSB2aWEgdGhlIFBSX1NFVF9UQUdHRURfQUREUl9DVFJM
IHByY3RsKCkuDQo+ICANCj4gIFRoaXMgaW5jbHVkZXMsIGJ1dCBpcyBub3QgbGltaXRlZCB0bywg
YWRkcmVzc2VzIGZvdW5kIGluOg0KPiAgDQo+IEBAIC0zMSwxOCArMzIsMjMgQEAgVGhpcyBpbmNs
dWRlcywgYnV0IGlzIG5vdCBsaW1pdGVkIHRvLCBhZGRyZXNzZXMgZm91bmQgaW46DQo+ICAgLSB0
aGUgZnJhbWUgcG9pbnRlciAoeDI5KSBhbmQgZnJhbWUgcmVjb3JkcywgZS5nLiB3aGVuIGludGVy
cHJldGluZw0KPiAgICAgdGhlbSB0byBnZW5lcmF0ZSBhIGJhY2t0cmFjZSBvciBjYWxsIGdyYXBo
Lg0KPiAgDQo+IC1Vc2luZyBub24temVybyBhZGRyZXNzIHRhZ3MgaW4gYW55IG9mIHRoZXNlIGxv
Y2F0aW9ucyBtYXkgcmVzdWx0IGluIGFuDQo+IC1lcnJvciBjb2RlIGJlaW5nIHJldHVybmVkLCBh
IChmYXRhbCkgc2lnbmFsIGJlaW5nIHJhaXNlZCwgb3Igb3RoZXIgbW9kZXMNCj4gLW9mIGZhaWx1
cmUuDQo+ICtVc2luZyBub24temVybyBhZGRyZXNzIHRhZ3MgaW4gYW55IG9mIHRoZXNlIGxvY2F0
aW9ucyB3aGVuIHRoZQ0KPiArdXNlcnNwYWNlIGFwcGxpY2F0aW9uIGRpZCBub3Qgb3B0LWluIHRv
IHRoZSBBUk02NCBUYWdnZWQgQWRkcmVzcyBBQkksDQo+ICttYXkgcmVzdWx0IGluIGFuIGVycm9y
IGNvZGUgYmVpbmcgcmV0dXJuZWQsIGEgKGZhdGFsKSBzaWduYWwgYmVpbmcgcmFpc2VkLA0KPiAr
b3Igb3RoZXIgbW9kZXMgb2YgZmFpbHVyZS4NCj4gIA0KPiAtRm9yIHRoZXNlIHJlYXNvbnMsIHBh
c3Npbmcgbm9uLXplcm8gYWRkcmVzcyB0YWdzIHRvIHRoZSBrZXJuZWwgdmlhDQo+IC1zeXN0ZW0g
Y2FsbHMgaXMgZm9yYmlkZGVuLCBhbmQgdXNpbmcgYSBub24temVybyBhZGRyZXNzIHRhZyBmb3Ig
c3AgaXMNCj4gLXN0cm9uZ2x5IGRpc2NvdXJhZ2VkLg0KPiArRm9yIHRoZXNlIHJlYXNvbnMsIHdo
ZW4gdGhlIHVzZXJzcGFjZSBhcHBsaWNhdGlvbiBkaWQgbm90IG9wdC1pbiwgcGFzc2luZw0KPiAr
bm9uLXplcm8gYWRkcmVzcyB0YWdzIHRvIHRoZSBrZXJuZWwgdmlhIHN5c3RlbSBjYWxscyBpcyBm
b3JiaWRkZW4sIGFuZCB1c2luZw0KPiArYSBub24temVybyBhZGRyZXNzIHRhZyBmb3Igc3AgaXMg
c3Ryb25nbHkgZGlzY291cmFnZWQuDQo+ICANCj4gIFByb2dyYW1zIG1haW50YWluaW5nIGEgZnJh
bWUgcG9pbnRlciBhbmQgZnJhbWUgcmVjb3JkcyB0aGF0IHVzZSBub24temVybw0KPiAgYWRkcmVz
cyB0YWdzIG1heSBzdWZmZXIgaW1wYWlyZWQgb3IgaW5hY2N1cmF0ZSBkZWJ1ZyBhbmQgcHJvZmls
aW5nDQo+ICB2aXNpYmlsaXR5Lg0KPiAgDQo+ICtBIGRlZmluaXRpb24gb2YgdGhlIG1lYW5pbmcg
b2YgQVJNNjQgVGFnZ2VkIEFkZHJlc3MgQUJJIGFuZCBvZiB0aGUNCj4gK2d1YXJhbnRlZXMgdGhh
dCB0aGUgQUJJIHByb3ZpZGVzIHdoZW4gdGhlIHVzZXJzcGFjZSBvcHRzLWluIHZpYSBwcmN0bCgp
DQo+ICtjYW4gYmUgZm91bmQgaW46IERvY3VtZW50YXRpb24vYXJtNjQvdGFnZ2VkLWFkZHJlc3Mt
YWJpLnR4dC4NCj4gKw0KDQpPSy4NCg0KPiAgDQo+ICBQcmVzZXJ2aW5nIHRhZ3MNCj4gIC0tLS0t
LS0tLS0tLS0tLQ0KPiBAQCAtNTcsNiArNjMsOSBAQCBiZSBwcmVzZXJ2ZWQuDQo+ICBUaGUgYXJj
aGl0ZWN0dXJlIHByZXZlbnRzIHRoZSB1c2Ugb2YgYSB0YWdnZWQgUEMsIHNvIHRoZSB1cHBlciBi
eXRlIHdpbGwNCj4gIGJlIHNldCB0byBhIHNpZ24tZXh0ZW5zaW9uIG9mIGJpdCA1NSBvbiBleGNl
cHRpb24gcmV0dXJuLg0KPiAgDQo+ICtUaGlzIGJlaGF2aW91cnMgYXJlIHByZXNlcnZlZCBldmVu
IHdoZW4gdGhlIHRoZSB1c2Vyc3BhY2Ugb3B0cy1pbiB0aGUgQVJNNjQNCg0KdGhlc2UgYmVoYXZp
b3Vycy4NCg0KPiArVGFnZ2VkIEFkZHJlc3MgQUJJIHZpYSB0aGUgUFJfU0VUX1RBR0dFRF9BRERS
X0NUUkwgcHJjdGwoKS4NCj4gKw0KPiAgDQo+ICBPdGhlciBjb25zaWRlcmF0aW9ucw0KPiAgLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gDQoNCg==

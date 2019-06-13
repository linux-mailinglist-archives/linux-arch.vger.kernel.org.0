Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 509A343C9E
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfFMPg4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:36:56 -0400
Received: from mail-eopbgr00063.outbound.protection.outlook.com ([40.107.0.63]:2210
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726864AbfFMKQZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 06:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsnuP9uN7znKdLcsYUNs05zri06zOnYXJFfiQuCxCzo=;
 b=6fP79K0Zd+t5ZKKUDbW1RQE05uDoAkqMGosfl0o7LTUl5dqQdvo+vV2jcn0IogKP8q1p1OAf2ccZ2nHoHSIicjO64jDyv6obG9SEEYWue70MC7l+EQNzmeSEoNekcrqBs1wT4qH1ZRM87GjnW3oTYj8u6YgLJHuitK58LSQxK20=
Received: from VE1PR08MB4637.eurprd08.prod.outlook.com (10.255.27.14) by
 VE1PR08MB4880.eurprd08.prod.outlook.com (10.255.113.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Thu, 13 Jun 2019 10:14:39 +0000
Received: from VE1PR08MB4637.eurprd08.prod.outlook.com
 ([fe80::6574:1efb:6972:2b37]) by VE1PR08MB4637.eurprd08.prod.outlook.com
 ([fe80::6574:1efb:6972:2b37%6]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 10:14:39 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>
CC:     nd <nd@arm.com>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v4 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.txt
Thread-Topic: [PATCH v4 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.txt
Thread-Index: AQHVIS/jNTMPiNHftkW5Mto9lMl3oKaYRrOAgAEJjYCAAA78gA==
Date:   Thu, 13 Jun 2019 10:14:39 +0000
Message-ID: <dee7f192-d0f0-558e-3007-eba805c6f2da@arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190612142111.28161-1-vincenzo.frascino@arm.com>
 <20190612142111.28161-2-vincenzo.frascino@arm.com>
 <a90da586-8ff6-4bed-d940-9306d517a18c@arm.com>
 <20190613092054.GO28951@C02TF0J2HF1T.local>
In-Reply-To: <20190613092054.GO28951@C02TF0J2HF1T.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LNXP265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::19) To VE1PR08MB4637.eurprd08.prod.outlook.com
 (2603:10a6:802:b1::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fe878f3-90c3-40d7-96ad-08d6efe7f18d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4880;
x-ms-traffictypediagnostic: VE1PR08MB4880:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4880FE3C5989AB8E22672E57EDEF0@VE1PR08MB4880.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(346002)(136003)(376002)(189003)(199004)(37006003)(99286004)(316002)(44832011)(81166006)(65826007)(478600001)(6512007)(26005)(2906002)(486006)(6436002)(31696002)(14454004)(71190400001)(7736002)(58126008)(72206003)(64126003)(54906003)(81156014)(229853002)(86362001)(53936002)(8936002)(8676002)(66476007)(66446008)(65956001)(305945005)(6246003)(186003)(5660300002)(36756003)(66066001)(66556008)(65806001)(64756008)(66946007)(76176011)(6486002)(68736007)(2616005)(14444005)(25786009)(386003)(3846002)(52116002)(71200400001)(6116002)(6506007)(31686004)(53546011)(73956011)(446003)(11346002)(6636002)(256004)(6862004)(102836004)(4326008)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4880;H:VE1PR08MB4637.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n1uLWJnaW6tml/Jq1ihcLP5qMpaj60lgri3jTuf0WS1WvifIOe04A/mowWrlwipNbODswYGcpWlTUrD5s5DFzmNbvkT8BhDUBoM8B7I+gQQAlpaN05GaWQVZXtLV0dKbjwb+ItE5iJFcgoGTW+9lYboILJi7/IiW43XE51v1nNQjCDHkvrtIZeGj/Ihpjgv0ZR5UTrGn1WT1Zj5kgqsInPeZZggpKQ+baQOpa8d3dtzfE/4zy6/lVoKULtmbCU5l4E6TMQ4K1eDVs9YZ843FlL4FRmVtXrglr7wopao4oujhlhEr6H/vsdJ1sjxq4Rch0acPTdhrgeuiBpppkNjYj6CAfd/2mR2jOMlZxPzHP+a5ueMuIdbcs/3wrZidsvmJiZAPnNZ6z1hYrBpkQ3dHxIbAzcayZsyaP4Vix0DX0/o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50012C68520D6547A2B2174AAC3FFA16@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe878f3-90c3-40d7-96ad-08d6efe7f18d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 10:14:39.1554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Szabolcs.Nagy@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4880
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMTMvMDYvMjAxOSAxMDoyMCwgQ2F0YWxpbiBNYXJpbmFzIHdyb3RlOg0KPiBIaSBTemFib2xj
cywNCj4gDQo+IE9uIFdlZCwgSnVuIDEyLCAyMDE5IGF0IDA1OjMwOjM0UE0gKzAxMDAsIFN6YWJv
bGNzIE5hZ3kgd3JvdGU6DQo+PiBPbiAxMi8wNi8yMDE5IDE1OjIxLCBWaW5jZW56byBGcmFzY2lu
byB3cm90ZToNCj4+PiArMi4gQVJNNjQgVGFnZ2VkIEFkZHJlc3MgQUJJDQo+Pj4gKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+ICsNCj4+PiArRnJvbSB0aGUga2VybmVsIHN5c2NhbGwg
aW50ZXJmYWNlIHByb3NwZWN0aXZlLCB3ZSBkZWZpbmUsIGZvciB0aGUgcHVycG9zZXMNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeXl5eXl5eXl5eXg0KPj4gcGVyc3Bl
Y3RpdmUNCj4+DQo+Pj4gK29mIHRoaXMgZG9jdW1lbnQsIGEgInZhbGlkIHRhZ2dlZCBwb2ludGVy
IiBhcyBhIHBvaW50ZXIgdGhhdCBlaXRoZXIgaXQgaGFzDQo+Pj4gK2EgemVybyB2YWx1ZSBzZXQg
aW4gdGhlIHRvcCBieXRlIG9yIGl0IGhhcyBhIG5vbi16ZXJvIHZhbHVlLCBpdCBpcyBpbiBtZW1v
cnkNCj4+PiArcmFuZ2VzIHByaXZhdGVseSBvd25lZCBieSBhIHVzZXJzcGFjZSBwcm9jZXNzIGFu
ZCBpdCBpcyBvYnRhaW5lZCBpbiBvbmUgb2YNCj4+PiArdGhlIGZvbGxvd2luZyB3YXlzOg0KPj4+
ICsgIC0gbW1hcCgpIGRvbmUgYnkgdGhlIHByb2Nlc3MgaXRzZWxmLCB3aGVyZSBlaXRoZXI6DQo+
Pj4gKyAgICAqIGZsYWdzID0gTUFQX1BSSVZBVEUgfCBNQVBfQU5PTllNT1VTDQo+Pj4gKyAgICAq
IGZsYWdzID0gTUFQX1BSSVZBVEUgYW5kIHRoZSBmaWxlIGRlc2NyaXB0b3IgcmVmZXJzIHRvIGEg
cmVndWxhcg0KPj4+ICsgICAgICBmaWxlIG9yICIvZGV2L3plcm8iDQo+Pg0KPj4gdGhpcyBkb2Vz
IG5vdCBtYWtlIGl0IGNsZWFyIGlmIE1BUF9GSVhFRCBvciBvdGhlciBmbGFncyBhcmUgdmFsaWQN
Cj4+ICh0aGVyZSBhcmUgbWFueSBtYXAgZmxhZ3MgaSBkb24ndCBrbm93LCBidXQgYXQgbGVhc3Qg
Zml4ZWQgc2hvdWxkIHdvcmsNCj4+IGFuZCBzdGFjay9ncm93c2Rvd24uIGknZCBleHBlY3QgYW55
dGhpbmcgdGhhdCdzIG5vdCBpbmNvbXBhdGlibGUgd2l0aA0KPj4gcHJpdmF0ZXxhbm9uIHRvIHdv
cmspLg0KPiANCj4gSnVzdCB0byBjbGFyaWZ5LCB0aGlzIGRvY3VtZW50IHRyaWVzIHRvIGRlZmlu
ZSB0aGUgbWVtb3J5IHJhbmdlcyBmcm9tDQo+IHdoZXJlIHRhZ2dlZCBhZGRyZXNzZXMgY2FuIGJl
IHBhc3NlZCBpbnRvIHRoZSBrZXJuZWwgaW4gdGhlIGNvbnRleHQNCj4gb2YgVEJJIG9ubHkgKG5v
dCBNVEUpOyB0aGF0IGlzIGZvciBod2FzYW4gc3VwcG9ydC4gRklYRUQgb3IgR1JPV1NET1dODQo+
IHNob3VsZCBub3QgYWZmZWN0IHRoaXMuDQoNCnllcywgc28gZWl0aGVyIHRoZSB0ZXh0IHNob3Vs
ZCBsaXN0IE1BUF8qIGZsYWdzIHRoYXQgZG9uJ3QgYWZmZWN0DQp0aGUgcG9pbnRlciB0YWdnaW5n
IHNlbWFudGljcyBvciBzcGVjaWZ5IHByaXZhdGV8YW5vbiBtYXBwaW5nDQp3aXRoIGRpZmZlcmVu
dCB3b3JkaW5nLg0KDQo+Pj4gKyAgLSBhIG1hcHBpbmcgYmVsb3cgc2JyaygwKSBkb25lIGJ5IHRo
ZSBwcm9jZXNzIGl0c2VsZg0KPj4NCj4+IGRvZXNuJ3QgdGhlIG1tYXAgcnVsZSBjb3ZlciB0aGlz
Pw0KPiANCj4gSUlVQyBpdCBkb2Vzbid0IGNvdmVyIGl0IGFzIHRoYXQncyBtZW1vcnkgbWFwcGVk
IGJ5IHRoZSBrZXJuZWwNCj4gYXV0b21hdGljYWxseSBvbiBhY2Nlc3MgdnMgYSBwb2ludGVyIHJl
dHVybmVkIGJ5IG1tYXAoKS4gVGhlIHN0YXRlbWVudA0KPiBhYm92ZSB0YWxrcyBhYm91dCBob3cg
dGhlIGFkZHJlc3MgaXMgb2J0YWluZWQgYnkgdGhlIHVzZXIuDQoNCm9rIGkgcmVhZCAnbWFwcGlu
ZyBiZWxvdyBzYnJrJyBhcyBhbiBtbWFwIChwb3NzaWJseSBNQVBfRklYRUQpDQp0aGF0IGhhcHBl
bnMgdG8gYmUgYmVsb3cgdGhlIGhlYXAgYXJlYS4NCg0KaSB0aGluayAiYmVsb3cgc2JyaygwKSIg
aXMgbm90IHRoZSBiZXN0IHRlcm0gdG8gdXNlOiB0aGVyZQ0KbWF5IGJlIGFkZHJlc3MgcmFuZ2Ug
YmVsb3cgdGhlIGhlYXAgYXJlYSB0aGF0IGNhbiBiZSBtbWFwcGVkDQphbmQgdGh1cyBiZWxvdyBz
YnJrKDApIGFuZCBzYnJrIGlzIGEgcG9zaXggYXBpIG5vdCBhIGxpbnV4DQpzeXNjYWxsLCB0aGUg
bGliYyBjYW4gaW1wbGVtZW50IGl0IHdpdGggbW1hcCBvciB3aGF0ZXZlci4NCg0KaSdtIG5vdCBz
dXJlIHdoYXQgdGhlIHJpZ2h0IHRlcm0gZm9yICdoZWFwIGFyZWEnIGlzDQoodGhlIGFkZHJlc3Mg
cmFuZ2UgYmV0d2VlbiBzeXNjYWxsKF9fTlJfYnJrLDApIGF0DQpwcm9ncmFtIHN0YXJ0dXAgYW5k
IGl0cyBjdXJyZW50IHZhbHVlPykNCg0KPj4+ICsgIC0gYW55IG1lbW9yeSBtYXBwZWQgYnkgdGhl
IGtlcm5lbCBpbiB0aGUgcHJvY2VzcydzIGFkZHJlc3Mgc3BhY2UgZHVyaW5nDQo+Pj4gKyAgICBj
cmVhdGlvbiBhbmQgZm9sbG93aW5nIHRoZSByZXN0cmljdGlvbnMgcHJlc2VudGVkIGFib3ZlIChp
LmUuIGRhdGEsIGJzcywNCj4+PiArICAgIHN0YWNrKS4NCj4+DQo+PiBPSy4NCj4+DQo+PiBDYW4g
YSBudWxsIHBvaW50ZXIgaGF2ZSBhIHRhZz8NCj4+IChpbiBjYXNlIE5VTEwgaXMgdmFsaWQgdG8g
cGFzcyB0byBhIHN5c2NhbGwpDQo+IA0KPiBHb29kIHBvaW50LiBJIGRvbid0IHRoaW5rIGl0IGNh
bi4gV2UgbWF5IGNoYW5nZSB0aGlzIGZvciBNVEUgd2hlcmUgd2UNCj4gZ2l2ZSBhIGhpbnQgdGFn
IGJ1dCBubyBoaW50IGFkZHJlc3MsIGhvd2V2ZXIsIHRoaXMgZG9jdW1lbnQgb25seSBjb3ZlcnMN
Cj4gVEJJIGZvciBub3cuDQoNCk9LLg0KDQo+Pj4gK1RoZSBBUk02NCBUYWdnZWQgQWRkcmVzcyBB
QkkgaXMgYW4gb3B0LWluIGZlYXR1cmUsIGFuZCBhbiBhcHBsaWNhdGlvbiBjYW4NCj4+PiArY29u
dHJvbCBpdCB1c2luZyB0aGUgZm9sbG93aW5nIHByY3RsKClzOg0KPj4+ICsgIC0gUFJfU0VUX1RB
R0dFRF9BRERSX0NUUkw6IGNhbiBiZSB1c2VkIHRvIGVuYWJsZSB0aGUgVGFnZ2VkIEFkZHJlc3Mg
QUJJLg0KPj4+ICsgIC0gUFJfR0VUX1RBR0dFRF9BRERSX0NUUkw6IGNhbiBiZSB1c2VkIHRvIGNo
ZWNrIHRoZSBzdGF0dXMgb2YgdGhlIFRhZ2dlZA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEFkZHJlc3MgQUJJLg0KPj4+ICsNCj4+PiArQXMgYSBjb25zZXF1ZW5jZSBvZiBpbnZv
a2luZyBQUl9TRVRfVEFHR0VEX0FERFJfQ1RSTCBwcmN0bCgpIGJ5IGFuIGFwcGxpY2F0aW9ucywN
Cj4+PiArdGhlIEFCSSBndWFyYW50ZWVzIHRoZSBmb2xsb3dpbmcgYmVoYXZpb3VyczoNCj4+PiAr
DQo+Pj4gKyAgLSBFdmVyeSBjdXJyZW50IG9yIG5ld2x5IGludHJvZHVjZWQgc3lzY2FsbCBjYW4g
YWNjZXB0IGFueSB2YWxpZCB0YWdnZWQNCj4+PiArICAgIHBvaW50ZXJzLg0KPj4+ICsNCj4+PiAr
ICAtIElmIGEgbm9uIHZhbGlkIHRhZ2dlZCBwb2ludGVyIGlzIHBhc3NlZCB0byBhIHN5c2NhbGwg
dGhlbiB0aGUgYmVoYXZpb3VyDQo+Pj4gKyAgICBpcyB1bmRlZmluZWQuDQo+Pj4gKw0KPj4+ICsg
IC0gRXZlcnkgdmFsaWQgdGFnZ2VkIHBvaW50ZXIgaXMgZXhwZWN0ZWQgdG8gd29yayBhcyBhbiB1
bnRhZ2dlZCBvbmUuDQo+Pj4gKw0KPj4+ICsgIC0gVGhlIGtlcm5lbCBwcmVzZXJ2ZXMgYW55IHZh
bGlkIHRhZ2dlZCBwb2ludGVycyBhbmQgcmV0dXJucyB0aGVtIHRvIHRoZQ0KPj4+ICsgICAgdXNl
cnNwYWNlIHVuY2hhbmdlZCBpbiBhbGwgdGhlIGNhc2VzIGV4Y2VwdCB0aGUgb25lcyBkb2N1bWVu
dGVkIGluIHRoZQ0KPj4+ICsgICAgIlByZXNlcnZpbmcgdGFncyIgcGFyYWdyYXBoIG9mIHRhZ2dl
ZC1wb2ludGVycy50eHQuDQo+Pg0KPj4gT0suDQo+Pg0KPj4gaSBndWVzcyBwb2ludGVycyBvZiBh
bm90aGVyIHByb2Nlc3MgYXJlIG5vdCAidmFsaWQgdGFnZ2VkIHBvaW50ZXJzIg0KPj4gZm9yIHRo
ZSBjdXJyZW50IG9uZSwgc28gZS5nLiBpbiBwdHJhY2UgdGhlIHB0cmFjZXIgaGFzIHRvIGNsZWFy
IHRoZQ0KPj4gdGFncyBiZWZvcmUgUEVFSyBldGMuDQo+IA0KPiBBbm90aGVyIGdvb2QgcG9pbnQu
IEFyZSB0aGVyZSBhbnkgcHJvcy9jb25zIGhlcmUgb3IgdXNlLWNhc2VzPyBXaGVuIHdlDQo+IGFk
ZCBNVEUgc3VwcG9ydCwgc2hvdWxkIHdlIGhhbmRsZSB0aGlzIGRpZmZlcmVudGx5Pw0KDQppJ20g
bm90IHN1cmUgd2hhdCBnZGIgZG9lcyBjdXJyZW50bHksIGJ1dCBpdCBoYXMNCmFuICdhZGRyZXNz
X3NpZ25pZmljYW50JyBob29rIHVzZWQgYXQgYSBmZXcgcGxhY2VzDQp0aGF0IGRyb3BzIHRoZSB0
YWcgb24gYWFyY2g2NCwgc28gaXQgcHJvYmFibHkNCmF2b2lkcyBwYXNzaW5nIHRhZ2dlZCBwb2lu
dGVyIHRvIHB0cmFjZS4NCg0KaSB3YXMgd29ycmllZCBhYm91dCBzdHJhY2Ugd2hpY2ggdHJpZXMg
dG8gcHJpbnQNCnN0cnVjdHMgcGFzc2VkIHRvIHN5c2NhbGxzIGFuZCBmb2xsb3cgcG9pbnRlcnMg
aW4NCnRoZW0gd2hpY2ggY3VycmVudGx5IHdvdWxkIHdvcmssIGJ1dCBpZiB3ZSBhbGxvdw0KdGFn
cyBpbiBzeXNjYWxscyB0aGVuIGl0IG5lZWRzIHNvbWUgdXBkYXRlLg0KKGkgaGF2ZW4ndCBjaGVj
a2VkIHRoZSBzdHJhY2UgY29kZSB0aG91Z2gpDQoNCj4+PiArQSBkZWZpbml0aW9uIG9mIHRoZSBt
ZWFuaW5nIG9mIHRhZ2dlZCBwb2ludGVycyBvbiBhcm02NCBjYW4gYmUgZm91bmQgaW46DQo+Pj4g
K0RvY3VtZW50YXRpb24vYXJtNjQvdGFnZ2VkLXBvaW50ZXJzLnR4dC4NCj4+PiArDQo+Pj4gKzMu
IEFSTTY0IFRhZ2dlZCBBZGRyZXNzIEFCSSBFeGNlcHRpb25zDQo+Pj4gKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4gKw0KPj4+ICtUaGUgYmVoYXZpb3VycyBkZXNj
cmliZWQgaW4gcGFyYWdyYXBoIDIsIHdpdGggcGFydGljdWxhciByZWZlcmVuY2UgdG8gdGhlDQo+
Pj4gK2FjY2VwdGFuY2UgYnkgdGhlIHN5c2NhbGxzIG9mIGFueSB2YWxpZCB0YWdnZWQgcG9pbnRl
ciBhcmUgbm90IGFwcGxpY2FibGUNCj4+PiArdG8gdGhlIGZvbGxvd2luZyBjYXNlczoNCj4+PiAr
ICAtIG1tYXAoKSBhZGRyIHBhcmFtZXRlci4NCj4+PiArICAtIG1yZW1hcCgpIG5ld19hZGRyZXNz
IHBhcmFtZXRlci4NCj4+PiArICAtIHByY3RsX3NldF9tbSgpIHN0cnVjdCBwcmN0bF9tYXAgZmll
bGRzLg0KPj4+ICsgIC0gcHJjdGxfc2V0X21tX21hcCgpIHN0cnVjdCBwcmN0bF9tYXAgZmllbGRz
Lg0KPj4NCj4+IGkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgZXhjZXB0aW9uOiBkb2VzIGl0IG1lYW4g
dGhhdCBwYXNzaW5nIGEgdGFnZ2VkDQo+PiBhZGRyZXNzIHRvIHRoZXNlIHN5c2NhbGxzIGlzIHVu
ZGVmaW5lZD8NCj4gDQo+IEknZCBzYXkgaXQncyBhcyB1bmRlZmluZWQgYXMgaXQgaXMgcmlnaHQg
bm93IHdpdGhvdXQgdGhlc2UgcGF0Y2hlcy4gV2UNCj4gbWF5IGJlIGFibGUgdG8gZXhwbGFpbiB0
aGlzIGJldHRlciBpbiB0aGUgZG9jdW1lbnQuDQo+IA0KDQo=

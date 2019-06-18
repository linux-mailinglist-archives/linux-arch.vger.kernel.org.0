Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA19549EE2
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2019 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfFRLCx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jun 2019 07:02:53 -0400
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:22598
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729635AbfFRLCx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Jun 2019 07:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW/hBqkNFFXTJDBiCVNfBU3Jrfa8uXWKit8npAvY+5E=;
 b=U8UNpGAJONO3/qtwOdS5pYGNsqrf7tNShycQMjhQMuZHakwu/XRjx0iEuDR6bulx5jMErrQaaYbSFw/GGT30xCPaf06Bpu/jkJK2ggJX0ZnLOgnCvQnjOsiAna1USeE2x/0pPdc085XXBuJD1HaRI1wcgLcrFyj7dKzO1Cj9nfI=
Received: from AM5PR0801MB1763.eurprd08.prod.outlook.com (10.169.247.17) by
 AM5PR0801MB1921.eurprd08.prod.outlook.com (10.168.154.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Tue, 18 Jun 2019 11:02:48 +0000
Received: from AM5PR0801MB1763.eurprd08.prod.outlook.com
 ([fe80::9987:96a6:6dd9:f4a2]) by AM5PR0801MB1763.eurprd08.prod.outlook.com
 ([fe80::9987:96a6:6dd9:f4a2%4]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 11:02:48 +0000
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
Subject: Re: [PATCH v5 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.txt
Thread-Topic: [PATCH v5 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.txt
Thread-Index: AQHVIgFS0u0DCr9uG0KMva1a4RDbs6ahRrUA
Date:   Tue, 18 Jun 2019 11:02:48 +0000
Message-ID: <397f0460-9ecf-f8f9-a8ea-42959be580ae@arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190613155137.47675-1-vincenzo.frascino@arm.com>
 <20190613155137.47675-2-vincenzo.frascino@arm.com>
In-Reply-To: <20190613155137.47675-2-vincenzo.frascino@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0333.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::33) To AM5PR0801MB1763.eurprd08.prod.outlook.com
 (2603:10a6:203:3b::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d27c8fd1-1fbf-44f1-b7fa-08d6f3dc7fa8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM5PR0801MB1921;
x-ms-traffictypediagnostic: AM5PR0801MB1921:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM5PR0801MB1921F1F814B4B375FFBE950EEDEA0@AM5PR0801MB1921.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(189003)(199004)(71200400001)(25786009)(53546011)(81166006)(66066001)(14454004)(31696002)(6506007)(478600001)(65806001)(81156014)(65956001)(66476007)(2616005)(66556008)(386003)(66446008)(66946007)(73956011)(6512007)(8936002)(44832011)(476003)(36756003)(486006)(446003)(6116002)(2501003)(110136005)(186003)(102836004)(68736007)(65826007)(58126008)(72206003)(64756008)(86362001)(5660300002)(8676002)(6486002)(76176011)(2201001)(3846002)(6246003)(11346002)(64126003)(53936002)(7736002)(229853002)(6436002)(316002)(31686004)(256004)(52116002)(305945005)(4326008)(2906002)(14444005)(99286004)(26005)(54906003)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0801MB1921;H:AM5PR0801MB1763.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mHLRPAHRCg++ux05SV7CY/o/UJTVt74r8g9OxgVMRAi6GM/+kLXS+kU47HmLfpUHnjSKrOx4YIEq8FzrIoq8eet+qBj0K+gJWkSujOoM62cV5/eenatmfSHTbIRWWfMYGnjqvTXKuYfeLeuI1Y4p8+XzBB3jBTFsYYHHy1qv5CgR7zggJUEMiJybLJG1rtWjOw26yilNUcVoUsrSdutmBnB4eSmaLhG1eOEpcPhyFFvJxNOdvofRMcJud6T/9LJpdhvRdHwtkcjBhiV83kUvl4erpsA6doo2GLolKVpF1CMvezrfcXocZTeSBm5Ip9ekxjFS81cPyqOUE+oSmK5fuEmkxtTPvP0EXZQw7LrgwWXRqN3vVYygKYIT5xzJ2WsWkQjnK1vmzfHtGafZq5p6Lz1Vrm0WkzzKptJYzyR4mRk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <003D0C41A93AA241BE8BCFC79F9E2FB8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27c8fd1-1fbf-44f1-b7fa-08d6f3dc7fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 11:02:48.5146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Szabolcs.Nagy@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1921
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMTMvMDYvMjAxOSAxNjo1MSwgVmluY2Vuem8gRnJhc2Npbm8gd3JvdGU6DQo+IE9uIGFybTY0
IHRoZSBUQ1JfRUwxLlRCSTAgYml0IGhhcyBiZWVuIGFsd2F5cyBlbmFibGVkIGhlbmNlDQo+IHRo
ZSB1c2Vyc3BhY2UgKEVMMCkgaXMgYWxsb3dlZCB0byBzZXQgYSBub24temVybyB2YWx1ZSBpbiB0
aGUNCj4gdG9wIGJ5dGUgYnV0IHRoZSByZXN1bHRpbmcgcG9pbnRlcnMgYXJlIG5vdCBhbGxvd2Vk
IGF0IHRoZQ0KPiB1c2VyLWtlcm5lbCBzeXNjYWxsIEFCSSBib3VuZGFyeS4NCj4gDQo+IFdpdGgg
dGhlIHJlbGF4ZWQgQUJJIHByb3Bvc2VkIHRocm91Z2ggdGhpcyBkb2N1bWVudCwgaXQgaXMgbm93
IHBvc3NpYmxlDQo+IHRvIHBhc3MgdGFnZ2VkIHBvaW50ZXJzIHRvIHRoZSBzeXNjYWxscywgd2hl
biB0aGVzZSBwb2ludGVycyBhcmUgaW4NCj4gbWVtb3J5IHJhbmdlcyBvYnRhaW5lZCBieSBhbiBh
bm9ueW1vdXMgKE1BUF9BTk9OWU1PVVMpIG1tYXAoKS4NCj4gDQo+IFRoaXMgY2hhbmdlIGluIHRo
ZSBBQkkgcmVxdWlyZXMgYSBtZWNoYW5pc20gdG8gcmVxdWlyZXMgdGhlIHVzZXJzcGFjZQ0KPiB0
byBvcHQtaW4gdG8gc3VjaCBhbiBvcHRpb24uDQo+IA0KPiBTcGVjaWZ5IGFuZCBkb2N1bWVudCB0
aGUgd2F5IGluIHdoaWNoIHN5c2N0bCBhbmQgcHJjdGwoKSBjYW4gYmUgdXNlZA0KPiBpbiBjb21i
aW5hdGlvbiB0byBhbGxvdyB0aGUgdXNlcnNwYWNlIHRvIG9wdC1pbiB0aGlzIGZlYXR1cmUuDQo+
IA0KPiBDYzogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4NCj4gQ2M6
IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPg0KPiBDQzogQW5kcmV5IEtvbm92YWxv
diA8YW5kcmV5a252bEBnb29nbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBWaW5jZW56byBGcmFz
Y2lubyA8dmluY2Vuem8uZnJhc2Npbm9AYXJtLmNvbT4NCg0KQWNrZWQtYnk6IFN6YWJvbGNzIE5h
Z3kgPHN6YWJvbGNzLm5hZ3lAYXJtLmNvbT4NCg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vYXJt
NjQvdGFnZ2VkLWFkZHJlc3MtYWJpLnR4dCB8IDEzNCArKysrKysrKysrKysrKysrKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxMzQgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vYXJtNjQvdGFnZ2VkLWFkZHJlc3MtYWJpLnR4dA0KPiANCj4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vYXJtNjQvdGFnZ2VkLWFkZHJlc3MtYWJpLnR4dCBiL0RvY3Vt
ZW50YXRpb24vYXJtNjQvdGFnZ2VkLWFkZHJlc3MtYWJpLnR4dA0KPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjBhZTkwMGQ0YmIyZA0KPiAtLS0gL2Rldi9udWxs
DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vYXJtNjQvdGFnZ2VkLWFkZHJlc3MtYWJpLnR4dA0KPiBA
QCAtMCwwICsxLDEzNCBAQA0KPiArQVJNNjQgVEFHR0VEIEFERFJFU1MgQUJJDQo+ICs9PT09PT09
PT09PT09PT09PT09PT09PT0NCj4gKw0KPiArVGhpcyBkb2N1bWVudCBkZXNjcmliZXMgdGhlIHVz
YWdlIGFuZCBzZW1hbnRpY3Mgb2YgdGhlIFRhZ2dlZCBBZGRyZXNzDQo+ICtBQkkgb24gYXJtNjQu
DQo+ICsNCj4gKzEuIEludHJvZHVjdGlvbg0KPiArLS0tLS0tLS0tLS0tLS0tDQo+ICsNCj4gK09u
IGFybTY0IHRoZSBUQ1JfRUwxLlRCSTAgYml0IGhhcyBiZWVuIGFsd2F5cyBlbmFibGVkIG9uIHRo
ZSBrZXJuZWwsIGhlbmNlDQo+ICt0aGUgdXNlcnNwYWNlIChFTDApIGlzIGVudGl0bGVkIHRvIHBl
cmZvcm0gYSB1c2VyIG1lbW9yeSBhY2Nlc3MgdGhyb3VnaCBhDQo+ICs2NC1iaXQgcG9pbnRlciB3
aXRoIGEgbm9uLXplcm8gdG9wIGJ5dGUgYnV0IHRoZSByZXN1bHRpbmcgcG9pbnRlcnMgYXJlIG5v
dA0KPiArYWxsb3dlZCBhdCB0aGUgdXNlci1rZXJuZWwgc3lzY2FsbCBBQkkgYm91bmRhcnkuDQo+
ICsNCj4gK1RoaXMgZG9jdW1lbnQgZGVzY3JpYmVzIGEgcmVsYXhhdGlvbiBvZiB0aGUgQUJJIHRo
YXQgbWFrZXMgaXQgcG9zc2libGUgdG8NCj4gK3RvIHBhc3MgdGFnZ2VkIHBvaW50ZXJzIHRvIHRo
ZSBzeXNjYWxscywgd2hlbiB0aGVzZSBwb2ludGVycyBhcmUgaW4gbWVtb3J5DQo+ICtyYW5nZXMg
b2J0YWluZWQgYXMgZGVzY3JpYmVkIGluIHNlY3Rpb24gMi4NCj4gKw0KPiArU2luY2UgaXQgaXMg
bm90IGRlc2lyYWJsZSB0byByZWxheCB0aGUgQUJJIHRvIGFsbG93IHRhZ2dlZCB1c2VyIGFkZHJl
c3Nlcw0KPiAraW50byB0aGUga2VybmVsIGluZGlzY3JpbWluYXRlbHksIGFybTY0IHByb3ZpZGVz
IGEgbmV3IHN5c2N0bCBpbnRlcmZhY2UNCj4gKygvcHJvYy9zeXMvYWJpL3RhZ2dlZF9hZGRyKSB0
aGF0IGlzIHVzZWQgdG8gcHJldmVudCB0aGUgYXBwbGljYXRpb25zIGZyb20NCj4gK2VuYWJsaW5n
IHRoZSByZWxheGVkIEFCSSBhbmQgYSBuZXcgcHJjdGwoKSBpbnRlcmZhY2UgdGhhdCBjYW4gYmUg
dXNlZCB0bw0KPiArZW5hYmxlIG9yIGRpc2FibGUgdGhlIHJlbGF4ZWQgQUJJLg0KPiArQSBkZXRh
aWxlZCBkZXNjcmlwdGlvbiBvZiB0aGUgbmV3bHkgaW50cm9kdWNlZCBtZWNoYW5pc21zIHdpbGwg
YmUgcHJvdmlkZWQNCj4gK2luIHNlY3Rpb24gMi4NCj4gKw0KPiArMi4gQVJNNjQgVGFnZ2VkIEFk
ZHJlc3MgQUJJDQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gKw0KPiArRnJvbSB0
aGUga2VybmVsIHN5c2NhbGwgaW50ZXJmYWNlIHBlcnNwZWN0aXZlLCB3ZSBkZWZpbmUsIGZvciB0
aGUgcHVycG9zZXMNCj4gK29mIHRoaXMgZG9jdW1lbnQsIGEgInZhbGlkIHRhZ2dlZCBwb2ludGVy
IiBhcyBhIHBvaW50ZXIgdGhhdCBlaXRoZXIgaGFzIGENCj4gK3plcm8gdmFsdWUgc2V0IGluIHRo
ZSB0b3AgYnl0ZSBvciBoYXMgYSBub24temVybyB2YWx1ZSwgaXQgaXMgaW4gbWVtb3J5DQo+ICty
YW5nZXMgcHJpdmF0ZWx5IG93bmVkIGJ5IGEgdXNlcnNwYWNlIHByb2Nlc3MgYW5kIGl0IGlzIG9i
dGFpbmVkIGluIG9uZSBvZg0KPiArdGhlIGZvbGxvd2luZyB3YXlzOg0KPiArICAtIG1tYXAoKSBk
b25lIGJ5IHRoZSBwcm9jZXNzIGl0c2VsZiwgd2hlcmUgZWl0aGVyOg0KPiArICAgICogZmxhZ3Mg
aGF2ZSBNQVBfUFJJVkFURSBhbmQgTUFQX0FOT05ZTU9VUw0KPiArICAgICogZmxhZ3MgaGF2ZSBN
QVBfUFJJVkFURSBhbmQgdGhlIGZpbGUgZGVzY3JpcHRvciByZWZlcnMgdG8gYSByZWd1bGFyDQo+
ICsgICAgICBmaWxlIG9yICIvZGV2L3plcm8iDQo+ICsgIC0gYnJrKCkgc3lzdGVtIGNhbGwgZG9u
ZSBieSB0aGUgcHJvY2VzcyBpdHNlbGYgKGkuZS4gdGhlIGhlYXAgYXJlYSBiZXR3ZWVuDQo+ICsg
ICAgdGhlIGluaXRpYWwgbG9jYXRpb24gb2YgdGhlIHByb2dyYW0gYnJlYWsgYXQgcHJvY2VzcyBj
cmVhdGlvbiBhbmQgaXRzDQo+ICsgICAgY3VycmVudCBsb2NhdGlvbikuDQo+ICsgIC0gYW55IG1l
bW9yeSBtYXBwZWQgYnkgdGhlIGtlcm5lbCBpbiB0aGUgcHJvY2VzcydzIGFkZHJlc3Mgc3BhY2Ug
ZHVyaW5nDQo+ICsgICAgY3JlYXRpb24gYW5kIGZvbGxvd2luZyB0aGUgcmVzdHJpY3Rpb25zIHBy
ZXNlbnRlZCBhYm92ZSAoaS5lLiBkYXRhLCBic3MsDQo+ICsgICAgc3RhY2spLg0KPiArDQo+ICtU
aGUgQVJNNjQgVGFnZ2VkIEFkZHJlc3MgQUJJIGlzIGFuIG9wdC1pbiBmZWF0dXJlLCBhbmQgYW4g
YXBwbGljYXRpb24gY2FuDQo+ICtjb250cm9sIGl0IHVzaW5nIHRoZSBmb2xsb3dpbmc6DQo+ICsg
LSAvcHJvYy9zeXMvYWJpL3RhZ2dlZF9hZGRyOiBhIG5ldyBzeXNjdGwgaW50ZXJmYWNlIHRoYXQg
Y2FuIGJlIHVzZWQgdG8NCj4gKyAgICAgICAgcHJldmVudCB0aGUgYXBwbGljYXRpb25zIGZyb20g
ZW5hYmxpbmcgdGhlIHJlbGF4ZWQgQUJJLg0KPiArICAgICAgICBUaGUgc3lzY3RsIGlzIG1lYW50
IGFsc28gZm9yIHRlc3RpbmcgcHVycG9zZXMgaW4gb3JkZXIgdG8gcHJvdmlkZSBhDQo+ICsgICAg
ICAgIHNpbXBsZSB3YXkgZm9yIHRoZSB1c2Vyc3BhY2UgdG8gdmVyaWZ5IHRoZSByZXR1cm4gZXJy
b3IgY2hlY2tpbmcgb2YNCj4gKyAgICAgICAgdGhlIHByY3RsKCkgY29tbWFuZHMgd2l0aG91dCBo
YXZpbmcgdG8gcmVjb25maWd1cmUgdGhlIGtlcm5lbC4NCj4gKyAgICAgICAgVGhlIHN5c2N0bCBz
dXBwb3J0cyB0aGUgZm9sbG93aW5nIGNvbmZpZ3VyYXRpb24gb3B0aW9uczoNCj4gKyAgICAgICAg
IC0gMDogRGlzYWJsZSBBUk02NCBUYWdnZWQgQWRkcmVzcyBBQkkgZm9yIGFsbCB0aGUgYXBwbGlj
YXRpb25zLg0KPiArICAgICAgICAgLSAxIChEZWZhdWx0KTogRW5hYmxlIEFSTTY0IFRhZ2dlZCBB
ZGRyZXNzIEFCSSBmb3IgYWxsIHRoZQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgYXBwbGlj
YXRpb25zLg0KPiArICAgICAgICBJZiB0aGUgQVJNNjQgVGFnZ2VkIEFkZHJlc3MgQUJJIGlzIGRp
c2FibGVkIGF0IGEgY2VydGFpbiBwb2ludCBpbg0KPiArICAgICAgICB0aW1lLCBhbGwgdGhlIGFw
cGxpY2F0aW9ucyB0aGF0IHdlcmUgdXNpbmcgdGFnZ2luZyBiZWZvcmUgdGhpcyBldmVudA0KPiAr
ICAgICAgICBvY2N1cnMsIHdpbGwgY29udGludWUgdG8gdXNlIHRhZ2dpbmcuDQo+ICsNCj4gKyAt
IHByY3RsKClzOg0KPiArICAtIFBSX1NFVF9UQUdHRURfQUREUl9DVFJMOiBjYW4gYmUgdXNlZCB0
byBlbmFibGUgb3IgZGlzYWJsZSB0aGUgVGFnZ2VkDQo+ICsgICAgICAgIEFkZHJlc3MgQUJJLg0K
PiArICAgICAgICBUaGUgKHVuc2lnbmVkIGludCkgYXJnMiBhcmd1bWVudCBpcyBhIGJpdCBtYXNr
IGRlc2NyaWJpbmcgdGhlDQo+ICsgICAgICAgIGNvbnRyb2wgbW9kZSB1c2VkOg0KPiArICAgICAg
ICAgIC0gUFJfVEFHR0VEX0FERFJfRU5BQkxFOiBFbmFibGUgQVJNNjQgVGFnZ2VkIEFkZHJlc3Mg
QUJJLg0KPiArICAgICAgICBUaGUgYXJndW1lbnRzIGFyZzMsIGFyZzQsIGFuZCBhcmc1IGFyZSBp
Z25vcmVkLg0KPiArDQo+ICsgIC0gUFJfR0VUX1RBR0dFRF9BRERSX0NUUkw6IGNhbiBiZSB1c2Vk
IHRvIGNoZWNrIHRoZSBzdGF0dXMgb2YgdGhlIFRhZ2dlZA0KPiArICAgICAgICBBZGRyZXNzIEFC
SS4NCj4gKyAgICAgICAgVGhlIGFyZ3VtZW50cyBhcmcyLCBhcmczLCBhcmc0LCBhbmQgYXJnNSBh
cmUgaWdub3JlZC4NCj4gKw0KPiArVGhlIEFCSSBwcm9wZXJ0aWVzIHNldCBieSB0aGUgbWVjaGFu
aXNtcyBkZXNjcmliZWQgYWJvdmUgYXJlIGluaGVyaXRlZCBieSB0aHJlYWRzDQo+ICtvZiB0aGUg
c2FtZSBhcHBsaWNhdGlvbiBhbmQgZm9yaygpJ2VkIGNoaWxkcmVuIGJ1dCBjbGVhcmVkIGJ5IGV4
ZWN2ZSgpLg0KPiArDQo+ICtBcyBhIGNvbnNlcXVlbmNlIG9mIGludm9raW5nIFBSX1NFVF9UQUdH
RURfQUREUl9DVFJMIHByY3RsKCkgYnkgYW4gYXBwbGljYXRpb25zLA0KPiArdGhlIEFCSSBndWFy
YW50ZWVzIHRoZSBmb2xsb3dpbmcgYmVoYXZpb3VyczoNCj4gKw0KPiArICAtIEV2ZXJ5IGN1cnJl
bnQgb3IgbmV3bHkgaW50cm9kdWNlZCBzeXNjYWxsIGNhbiBhY2NlcHQgYW55IHZhbGlkIHRhZ2dl
ZA0KPiArICAgIHBvaW50ZXJzLg0KPiArDQo+ICsgIC0gSWYgYSBub24gdmFsaWQgdGFnZ2VkIHBv
aW50ZXIgaXMgcGFzc2VkIHRvIGEgc3lzY2FsbCB0aGVuIHRoZSBiZWhhdmlvdXINCj4gKyAgICBp
cyB1bmRlZmluZWQuDQo+ICsNCj4gKyAgLSBFdmVyeSB2YWxpZCB0YWdnZWQgcG9pbnRlciBpcyBl
eHBlY3RlZCB0byB3b3JrIGFzIGFuIHVudGFnZ2VkIG9uZS4NCj4gKw0KPiArICAtIFRoZSBrZXJu
ZWwgcHJlc2VydmVzIGFueSB2YWxpZCB0YWdnZWQgcG9pbnRlcnMgYW5kIHJldHVybnMgdGhlbSB0
byB0aGUNCj4gKyAgICB1c2Vyc3BhY2UgdW5jaGFuZ2VkIChpLmUuIG9uIHN5c2NhbGwgcmV0dXJu
KSBpbiBhbGwgdGhlIGNhc2VzIGV4Y2VwdCB0aGUNCj4gKyAgICBvbmVzIGRvY3VtZW50ZWQgaW4g
dGhlICJQcmVzZXJ2aW5nIHRhZ3MiIHNlY3Rpb24gb2YgdGFnZ2VkLXBvaW50ZXJzLnR4dC4NCj4g
Kw0KPiArQSBkZWZpbml0aW9uIG9mIHRoZSBtZWFuaW5nIG9mIHRhZ2dlZCBwb2ludGVycyBvbiBh
cm02NCBjYW4gYmUgZm91bmQgaW46DQo+ICtEb2N1bWVudGF0aW9uL2FybTY0L3RhZ2dlZC1wb2lu
dGVycy50eHQuDQo+ICsNCj4gKzMuIEFSTTY0IFRhZ2dlZCBBZGRyZXNzIEFCSSBFeGNlcHRpb25z
DQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiArDQo+ICtUaGUg
YmVoYXZpb3VycyBkZXNjcmliZWQgaW4gc2VjdGlvbiAyLCB3aXRoIHBhcnRpY3VsYXIgcmVmZXJl
bmNlIHRvIHRoZQ0KPiArYWNjZXB0YW5jZSBieSB0aGUgc3lzY2FsbHMgb2YgYW55IHZhbGlkIHRh
Z2dlZCBwb2ludGVyIGFyZSBub3QgYXBwbGljYWJsZQ0KPiArdG8gdGhlIGZvbGxvd2luZyBjYXNl
czoNCj4gKyAgLSBtbWFwKCkgYWRkciBwYXJhbWV0ZXIuDQo+ICsgIC0gbXJlbWFwKCkgbmV3X2Fk
ZHJlc3MgcGFyYW1ldGVyLg0KPiArICAtIHByY3RsX3NldF9tbSgpIHN0cnVjdCBwcmN0bF9tYXAg
ZmllbGRzLg0KPiArICAtIHByY3RsX3NldF9tbV9tYXAoKSBzdHJ1Y3QgcHJjdGxfbWFwIGZpZWxk
cy4NCj4gKw0KPiArQW55IGF0dGVtcHQgdG8gdXNlIG5vbi16ZXJvIHRhZ2dlZCBwb2ludGVycyB3
aWxsIGxlYWQgdG8gdW5kZWZpbmVkIGJlaGF2aW91ci4NCj4gKw0KPiArNC4gRXhhbXBsZSBvZiBj
b3JyZWN0IHVzYWdlDQo+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gKw0KPiArdm9p
ZCBtYWluKHZvaWQpDQo+ICt7DQo+ICsJc3RhdGljIGludCB0YmlfZW5hYmxlZCA9IDA7DQo+ICsJ
dW5zaWduZWQgbG9uZyB0YWcgPSAwOw0KPiArDQo+ICsJY2hhciAqcHRyID0gbW1hcChOVUxMLCBQ
QUdFX1NJWkUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsDQo+ICsJCQkgTUFQX0FOT05ZTU9VUywg
LTEsIDApOw0KPiArDQo+ICsJaWYgKHByY3RsKFBSX1NFVF9UQUdHRURfQUREUl9DVFJMLCBQUl9U
QUdHRURfQUREUl9FTkFCTEUsDQo+ICsJCSAgMCwgMCwgMCkgPT0gMCkNCj4gKwkJdGJpX2VuYWJs
ZWQgPSAxOw0KPiArDQo+ICsJaWYgKHB0ciA9PSAodm9pZCAqKS0xKSAvKiBNQVBfRkFJTEVEICov
DQo+ICsJCXJldHVybiAtMTsNCj4gKw0KPiArCWlmICh0YmlfZW5hYmxlZCkNCj4gKwkJdGFnID0g
cmFuZCgpICYgMHhmZjsNCj4gKw0KPiArCXB0ciA9IChjaGFyICopKCh1bnNpZ25lZCBsb25nKXB0
ciB8ICh0YWcgPDwgVEFHX1NISUZUKSk7DQo+ICsNCj4gKwkqcHRyID0gJ2EnOw0KPiArDQo+ICsJ
Li4uDQo+ICt9DQo+ICsNCj4gDQoNCg==

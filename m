Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6B543ABF
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbfFMPXP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:23:15 -0400
Received: from mail-eopbgr50070.outbound.protection.outlook.com ([40.107.5.70]:47680
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731873AbfFMM2O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 08:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edX6WZIwfCoMixU8vLHwERAxZnEN4T1K5/0Q6vpMK6Y=;
 b=mmRYnm9ZpnhsS5gLDPpvZSU9GNGrBSl5EEkFkycmZeo40XR3GpHqA55KFAmtDsa0ZJq4t4ccfyqkQ9xc/odqdaqR+y+bZ1cwCJoHTqTB9p5uV8d4oUrFL5ARan4A4jtmE/f3gqOjH9xzaCc+4iX+m2yjsBYph9WWch2Tc1w9gQ8=
Received: from VE1PR08MB4637.eurprd08.prod.outlook.com (10.255.27.14) by
 VE1PR08MB4720.eurprd08.prod.outlook.com (10.255.115.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Thu, 13 Jun 2019 12:28:08 +0000
Received: from VE1PR08MB4637.eurprd08.prod.outlook.com
 ([fe80::6574:1efb:6972:2b37]) by VE1PR08MB4637.eurprd08.prod.outlook.com
 ([fe80::6574:1efb:6972:2b37%6]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 12:28:08 +0000
From:   Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To:     Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>
CC:     nd <nd@arm.com>,
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
Thread-Index: AQHVIS/jNTMPiNHftkW5Mto9lMl3oKaYRrOAgAEJjYCAAA78gIAAEUMAgAAUCAA=
Date:   Thu, 13 Jun 2019 12:28:08 +0000
Message-ID: <8e3c9537-de10-0d0d-f5bb-c33bde92443f@arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190612142111.28161-1-vincenzo.frascino@arm.com>
 <20190612142111.28161-2-vincenzo.frascino@arm.com>
 <a90da586-8ff6-4bed-d940-9306d517a18c@arm.com>
 <20190613092054.GO28951@C02TF0J2HF1T.local>
 <dee7f192-d0f0-558e-3007-eba805c6f2da@arm.com>
 <6ebbda37-5dd9-d0d5-d9cb-286c7a5b7f8e@arm.com>
In-Reply-To: <6ebbda37-5dd9-d0d5-d9cb-286c7a5b7f8e@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LNXP123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::21) To VE1PR08MB4637.eurprd08.prod.outlook.com
 (2603:10a6:802:b1::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df5cd2c2-5d23-4b73-7988-08d6effa9767
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4720;
x-ms-traffictypediagnostic: VE1PR08MB4720:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4720AE4EEA4831A8B50D84F4EDEF0@VE1PR08MB4720.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(376002)(346002)(199004)(189003)(305945005)(6486002)(25786009)(36756003)(229853002)(44832011)(486006)(6512007)(31696002)(6436002)(256004)(11346002)(58126008)(476003)(2616005)(54906003)(66476007)(14454004)(86362001)(71200400001)(71190400001)(68736007)(3846002)(6116002)(5660300002)(446003)(66556008)(73956011)(64756008)(66446008)(66946007)(110136005)(186003)(7736002)(76176011)(53546011)(386003)(316002)(64126003)(53936002)(6506007)(102836004)(6246003)(14444005)(2906002)(8676002)(6636002)(26005)(72206003)(65826007)(66066001)(478600001)(8936002)(52116002)(65956001)(31686004)(81166006)(81156014)(65806001)(4326008)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4720;H:VE1PR08MB4637.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F1BF2ilopA/pFZ8tgYbyo6ZZHZ9HTbQH7QqEVn+pCqpsdA8IYhQmHUax8L4vRoie3zJ+wOSf/9RTOWWy/u7TleLdPCku26Adx94r8w95jp+rJvRB2fu00RVlAR7lr4WaiHoms/AhJpaXj3PQ3cN5qdTR6F4T8AOrEeyfE/OzgvJcmKHjAfJO8FQWlGB7cYPzyBHk0RYZw5ZT7FVKQ42wxJWPFxXIueyLj8hGIFAErgpQ9yImMYj3LFsPePLngPGgNohBq+dr9m4xwjIlcTki3JPRJ8UY95fgROwzjLc2eniPP8hUBdSP41R5WKz8dC2csxP5nsJrypNRaVuvottxgauz8sQfYkRTAElD2Mvn/qU7Pq7G9hRroHkS4KWRTM3JvlpeWsAhhq0D8ZesuC9CZBAhgkNYzp2uQ5AhTCsJ9SY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2C0B65BEF78924CA305C7B3274335E1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5cd2c2-5d23-4b73-7988-08d6effa9767
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 12:28:08.3985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Szabolcs.Nagy@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4720
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMTMvMDYvMjAxOSAxMjoxNiwgVmluY2Vuem8gRnJhc2Npbm8gd3JvdGU6DQo+IEhpIFN6YWJv
bGNzLA0KPiANCj4gdGhhbmsgeW91IGZvciB5b3VyIHJldmlldy4NCj4gDQo+IE9uIDEzLzA2LzIw
MTkgMTE6MTQsIFN6YWJvbGNzIE5hZ3kgd3JvdGU6DQo+PiBPbiAxMy8wNi8yMDE5IDEwOjIwLCBD
YXRhbGluIE1hcmluYXMgd3JvdGU6DQo+Pj4gSGkgU3phYm9sY3MsDQo+Pj4NCj4+PiBPbiBXZWQs
IEp1biAxMiwgMjAxOSBhdCAwNTozMDozNFBNICswMTAwLCBTemFib2xjcyBOYWd5IHdyb3RlOg0K
Pj4+PiBPbiAxMi8wNi8yMDE5IDE1OjIxLCBWaW5jZW56byBGcmFzY2lubyB3cm90ZToNCj4+Pj4+
ICsyLiBBUk02NCBUYWdnZWQgQWRkcmVzcyBBQkkNCj4+Pj4+ICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4+Pj4+ICsNCj4+Pj4+ICtGcm9tIHRoZSBrZXJuZWwgc3lzY2FsbCBpbnRlcmZh
Y2UgcHJvc3BlY3RpdmUsIHdlIGRlZmluZSwgZm9yIHRoZSBwdXJwb3Nlcw0KPj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl5eXl5eXl4NCj4+Pj4gcGVyc3BlY3Rp
dmUNCj4+Pj4NCj4+Pj4+ICtvZiB0aGlzIGRvY3VtZW50LCBhICJ2YWxpZCB0YWdnZWQgcG9pbnRl
ciIgYXMgYSBwb2ludGVyIHRoYXQgZWl0aGVyIGl0IGhhcw0KPj4+Pj4gK2EgemVybyB2YWx1ZSBz
ZXQgaW4gdGhlIHRvcCBieXRlIG9yIGl0IGhhcyBhIG5vbi16ZXJvIHZhbHVlLCBpdCBpcyBpbiBt
ZW1vcnkNCj4+Pj4+ICtyYW5nZXMgcHJpdmF0ZWx5IG93bmVkIGJ5IGEgdXNlcnNwYWNlIHByb2Nl
c3MgYW5kIGl0IGlzIG9idGFpbmVkIGluIG9uZSBvZg0KPj4+Pj4gK3RoZSBmb2xsb3dpbmcgd2F5
czoNCj4+Pj4+ICsgIC0gbW1hcCgpIGRvbmUgYnkgdGhlIHByb2Nlc3MgaXRzZWxmLCB3aGVyZSBl
aXRoZXI6DQo+Pj4+PiArICAgICogZmxhZ3MgPSBNQVBfUFJJVkFURSB8IE1BUF9BTk9OWU1PVVMN
Cj4+Pj4+ICsgICAgKiBmbGFncyA9IE1BUF9QUklWQVRFIGFuZCB0aGUgZmlsZSBkZXNjcmlwdG9y
IHJlZmVycyB0byBhIHJlZ3VsYXINCj4+Pj4+ICsgICAgICBmaWxlIG9yICIvZGV2L3plcm8iDQo+
Pj4+DQo+Pj4+IHRoaXMgZG9lcyBub3QgbWFrZSBpdCBjbGVhciBpZiBNQVBfRklYRUQgb3Igb3Ro
ZXIgZmxhZ3MgYXJlIHZhbGlkDQo+Pj4+ICh0aGVyZSBhcmUgbWFueSBtYXAgZmxhZ3MgaSBkb24n
dCBrbm93LCBidXQgYXQgbGVhc3QgZml4ZWQgc2hvdWxkIHdvcmsNCj4+Pj4gYW5kIHN0YWNrL2dy
b3dzZG93bi4gaSdkIGV4cGVjdCBhbnl0aGluZyB0aGF0J3Mgbm90IGluY29tcGF0aWJsZSB3aXRo
DQo+Pj4+IHByaXZhdGV8YW5vbiB0byB3b3JrKS4NCj4+Pg0KPj4+IEp1c3QgdG8gY2xhcmlmeSwg
dGhpcyBkb2N1bWVudCB0cmllcyB0byBkZWZpbmUgdGhlIG1lbW9yeSByYW5nZXMgZnJvbQ0KPj4+
IHdoZXJlIHRhZ2dlZCBhZGRyZXNzZXMgY2FuIGJlIHBhc3NlZCBpbnRvIHRoZSBrZXJuZWwgaW4g
dGhlIGNvbnRleHQNCj4+PiBvZiBUQkkgb25seSAobm90IE1URSk7IHRoYXQgaXMgZm9yIGh3YXNh
biBzdXBwb3J0LiBGSVhFRCBvciBHUk9XU0RPV04NCj4+PiBzaG91bGQgbm90IGFmZmVjdCB0aGlz
Lg0KPj4NCj4+IHllcywgc28gZWl0aGVyIHRoZSB0ZXh0IHNob3VsZCBsaXN0IE1BUF8qIGZsYWdz
IHRoYXQgZG9uJ3QgYWZmZWN0DQo+PiB0aGUgcG9pbnRlciB0YWdnaW5nIHNlbWFudGljcyBvciBz
cGVjaWZ5IHByaXZhdGV8YW5vbiBtYXBwaW5nDQo+PiB3aXRoIGRpZmZlcmVudCB3b3JkaW5nLg0K
Pj4NCj4gDQo+IEdvb2QgcG9pbnQuIENvdWxkIHlvdSBwbGVhc2UgcHJvcG9zZSBhIHdvcmRpbmcg
dGhhdCB3b3VsZCBiZSBzdWl0YWJsZSBmb3IgdGhpcyBjYXNlPw0KDQppIGRvbid0IGtub3cgYWxs
IHRoZSBNQVBfIG1hZ2ljLCBidXQgaSB0aGluayBpdCdzIGVub3VnaCB0byBjaGFuZ2UNCnRoZSAi
ZmxhZ3MgPSIgdG8NCg0KKiBmbGFncyBoYXZlIE1BUF9QUklWQVRFIGFuZCBNQVBfQU5PTllNT1VT
IHNldCBvcg0KKiBmbGFncyBoYXZlIE1BUF9QUklWQVRFIHNldCBhbmQgdGhlIGZpbGUgZGVzY3Jp
cHRvciByZWZlcnMgdG8uLi4NCg0KDQo+Pj4+PiArICAtIGEgbWFwcGluZyBiZWxvdyBzYnJrKDAp
IGRvbmUgYnkgdGhlIHByb2Nlc3MgaXRzZWxmDQo+Pj4+DQo+Pj4+IGRvZXNuJ3QgdGhlIG1tYXAg
cnVsZSBjb3ZlciB0aGlzPw0KPj4+DQo+Pj4gSUlVQyBpdCBkb2Vzbid0IGNvdmVyIGl0IGFzIHRo
YXQncyBtZW1vcnkgbWFwcGVkIGJ5IHRoZSBrZXJuZWwNCj4+PiBhdXRvbWF0aWNhbGx5IG9uIGFj
Y2VzcyB2cyBhIHBvaW50ZXIgcmV0dXJuZWQgYnkgbW1hcCgpLiBUaGUgc3RhdGVtZW50DQo+Pj4g
YWJvdmUgdGFsa3MgYWJvdXQgaG93IHRoZSBhZGRyZXNzIGlzIG9idGFpbmVkIGJ5IHRoZSB1c2Vy
Lg0KPj4NCj4+IG9rIGkgcmVhZCAnbWFwcGluZyBiZWxvdyBzYnJrJyBhcyBhbiBtbWFwIChwb3Nz
aWJseSBNQVBfRklYRUQpDQo+PiB0aGF0IGhhcHBlbnMgdG8gYmUgYmVsb3cgdGhlIGhlYXAgYXJl
YS4NCj4+DQo+PiBpIHRoaW5rICJiZWxvdyBzYnJrKDApIiBpcyBub3QgdGhlIGJlc3QgdGVybSB0
byB1c2U6IHRoZXJlDQo+PiBtYXkgYmUgYWRkcmVzcyByYW5nZSBiZWxvdyB0aGUgaGVhcCBhcmVh
IHRoYXQgY2FuIGJlIG1tYXBwZWQNCj4+IGFuZCB0aHVzIGJlbG93IHNicmsoMCkgYW5kIHNicmsg
aXMgYSBwb3NpeCBhcGkgbm90IGEgbGludXgNCj4+IHN5c2NhbGwsIHRoZSBsaWJjIGNhbiBpbXBs
ZW1lbnQgaXQgd2l0aCBtbWFwIG9yIHdoYXRldmVyLg0KPj4NCj4+IGknbSBub3Qgc3VyZSB3aGF0
IHRoZSByaWdodCB0ZXJtIGZvciAnaGVhcCBhcmVhJyBpcw0KPj4gKHRoZSBhZGRyZXNzIHJhbmdl
IGJldHdlZW4gc3lzY2FsbChfX05SX2JyaywwKSBhdA0KPj4gcHJvZ3JhbSBzdGFydHVwIGFuZCBp
dHMgY3VycmVudCB2YWx1ZT8pDQo+Pg0KPiANCj4gSSB1c2VkIHNicmsoMCkgd2l0aCB0aGUgbWVh
bmluZyBvZiAiZW5kIG9mIHRoZSBwcm9jZXNzJ3MgZGF0YSBzZWdtZW50IiBub3QNCj4gaW1wbHlp
bmcgdGhhdCB0aGlzIGlzIGEgc3lzY2FsbCwgYnV0IGp1c3QgYXMgYSB1c2VmdWwgd2F5IHRvIGlk
ZW50aWZ5IHRoZSBtYXBwaW5nLg0KPiBJIGFncmVlIHRoYXQgaXQgaXMgYSBwb3NpeCBmdW5jdGlv
biBpbXBsZW1lbnRlZCBieSBsaWJjIGJ1dCB3aGVuIGl0IGlzIHVzZWQgd2l0aA0KPiAwIGZpbmRz
IHRoZSBjdXJyZW50IGxvY2F0aW9uIG9mIHRoZSBwcm9ncmFtIGJyZWFrLCB3aGljaCBjYW4gYmUg
Y2hhbmdlZCBieSBicmsoKQ0KPiBhbmQgZGVwZW5kaW5nIG9uIHRoZSBuZXcgYWRkcmVzcyBwYXNz
ZWQgdG8gdGhpcyBzeXNjYWxsIGNhbiBoYXZlIHRoZSBlZmZlY3Qgb2YNCj4gYWxsb2NhdGluZyBv
ciBkZWFsbG9jYXRpbmcgbWVtb3J5Lg0KPiANCj4gV2lsbCBjaGFuZ2luZyBzYnJrKDApIHdpdGgg
ImVuZCBvZiB0aGUgcHJvY2VzcydzIGRhdGEgc2VnbWVudCIgbWFrZSBpdCBtb3JlIGNsZWFyPw0K
DQppIGRvbid0IHVuZGVyc3RhbmQgd2hhdCdzIHRoZSByZWxldmFuY2Ugb2YgdGhlICplbmQqDQpv
ZiB0aGUgZGF0YSBzZWdtZW50Lg0KDQppJ2QgZXhwZWN0IHRoZSB0ZXh0IHRvIHNheSBzb21ldGhp
bmcgYWJvdXQgdGhlIGFkZHJlc3MNCnJhbmdlIG9mIHRoZSBkYXRhIHNlZ21lbnQuDQoNCmkgY2Fu
IGRvDQoNCm1tYXAoKHZvaWQqKTY1NTM2LCA2NTUzNiwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1B
UF9GSVhFRHxNQVBfU0hBUkVEfE1BUF9BTk9OLCAtMSwgMCk7DQoNCmFuZCBpdCB3aWxsIGJlIGJl
bG93IHRoZSBlbmQgb2YgdGhlIGRhdGEgc2VnbWVudC4NCg0KPiANCj4gSSB3aWxsIGFkZCB3aGF0
IHlvdSBhcmUgc3VnZ2VzdGluZyBhYm91dCB0aGUgaGVhcCBhcmVhLg0KPiANCg==

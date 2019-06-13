Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B443BF5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfFMPcu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:32:50 -0400
Received: from mail-eopbgr50072.outbound.protection.outlook.com ([40.107.5.72]:55105
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726773AbfFMPcr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 11:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQIiHoxFuhWL5xQCcL23HsooGu/TPVjlJNUJdPXXg28=;
 b=a2KwrV1STRGRMuKvQcvB8oZuK+gqOCVAhfntNm0qjCm4TVPxrSwVhjdWn521LPdm3zlfTxGwef5AeXsv/UsvAHzzB76h75h2RA+Dz36F0Uv92I/+DsvlX02kPxLHWozhACUEQbt48ToiV49QP4jYyWS/uU7y34lunta754lq95k=
Received: from VE1PR08MB4637.eurprd08.prod.outlook.com (10.255.27.14) by
 VE1PR08MB5247.eurprd08.prod.outlook.com (20.179.31.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Thu, 13 Jun 2019 15:32:42 +0000
Received: from VE1PR08MB4637.eurprd08.prod.outlook.com
 ([fe80::6574:1efb:6972:2b37]) by VE1PR08MB4637.eurprd08.prod.outlook.com
 ([fe80::6574:1efb:6972:2b37%6]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 15:32:42 +0000
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
Thread-Index: AQHVIS/jNTMPiNHftkW5Mto9lMl3oKaYRrOAgAEJjYCAAA78gIAAEUMAgAAkzACAAAnOAIAAGP8A
Date:   Thu, 13 Jun 2019 15:32:42 +0000
Message-ID: <ba822b33-a822-02ef-9b85-725f4353596a@arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190612142111.28161-1-vincenzo.frascino@arm.com>
 <20190612142111.28161-2-vincenzo.frascino@arm.com>
 <a90da586-8ff6-4bed-d940-9306d517a18c@arm.com>
 <20190613092054.GO28951@C02TF0J2HF1T.local>
 <dee7f192-d0f0-558e-3007-eba805c6f2da@arm.com>
 <6ebbda37-5dd9-d0d5-d9cb-286c7a5b7f8e@arm.com>
 <8e3c9537-de10-0d0d-f5bb-c33bde92443f@arm.com>
 <5963d144-be9b-78d8-9130-ef92bc66b1fd@arm.com>
In-Reply-To: <5963d144-be9b-78d8-9130-ef92bc66b1fd@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LNXP265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::30) To VE1PR08MB4637.eurprd08.prod.outlook.com
 (2603:10a6:802:b1::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ec55c83-d349-48b3-152c-08d6f014601e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5247;
x-ms-traffictypediagnostic: VE1PR08MB5247:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB5247C1B5EF80C97DB7F49188EDEF0@VE1PR08MB5247.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(376002)(136003)(346002)(189003)(199004)(476003)(26005)(66946007)(2616005)(65826007)(6246003)(25786009)(53936002)(65956001)(65806001)(66066001)(31686004)(8936002)(11346002)(66446008)(66476007)(64756008)(6506007)(73956011)(486006)(81156014)(186003)(53546011)(229853002)(478600001)(5660300002)(66556008)(2906002)(72206003)(86362001)(6636002)(386003)(31696002)(52116002)(8676002)(446003)(44832011)(4326008)(99286004)(102836004)(68736007)(256004)(71200400001)(64126003)(316002)(58126008)(7736002)(54906003)(71190400001)(3846002)(305945005)(6512007)(110136005)(36756003)(76176011)(14454004)(14444005)(6436002)(6486002)(81166006)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5247;H:VE1PR08MB4637.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9ZUd4le6lIhT2Zk8V//g6Vd6uo9Z23/KavAhSwjbuDtv9G5m+9zOrCH1HP/nXdSTQJlODuTWPmQlu6ToAJ42fluyO9UyHZ5E3qp2temFJVDJ4IjqqsIWD5e4IseNvc0JoIjHxtsb+0b5+80WDkrX/W5kn5WUPppYFaK2GVNVykhBhpbS/h2+fLOBe3dc81EOz8zZyEUV0Rq0L8wi/gU5/7+fZDMrosVGxC9YwDe0EIgU24HSAK/QViTuQI5uoTOxT4WjbIinYAbeeeg4IrIGh8KoZxdnkc2ewQOWujLjGXqJ+wOwtrtHvDixz6XQAFSBDXSgAclvJ7hRgYk8NwFapGApuG3SiOuCQVieoLqXaNIWj6w12Tz1IHKN+lHDqixs5KPPSLMiWj9w6IHLoRW9cpyvlpypk8X6+ApqADpCcc4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7B0C8D67B5DD5449F2A217A59B054BE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec55c83-d349-48b3-152c-08d6f014601e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 15:32:42.6357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Szabolcs.Nagy@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5247
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMTMvMDYvMjAxOSAxNTowMywgVmluY2Vuem8gRnJhc2Npbm8gd3JvdGU6DQo+IE9uIDEzLzA2
LzIwMTkgMTM6MjgsIFN6YWJvbGNzIE5hZ3kgd3JvdGU6DQo+PiBPbiAxMy8wNi8yMDE5IDEyOjE2
LCBWaW5jZW56byBGcmFzY2lubyB3cm90ZToNCj4+PiBPbiAxMy8wNi8yMDE5IDExOjE0LCBTemFi
b2xjcyBOYWd5IHdyb3RlOg0KPj4+PiBPbiAxMy8wNi8yMDE5IDEwOjIwLCBDYXRhbGluIE1hcmlu
YXMgd3JvdGU6DQo+Pj4+PiBPbiBXZWQsIEp1biAxMiwgMjAxOSBhdCAwNTozMDozNFBNICswMTAw
LCBTemFib2xjcyBOYWd5IHdyb3RlOg0KPj4+Pj4+IE9uIDEyLzA2LzIwMTkgMTU6MjEsIFZpbmNl
bnpvIEZyYXNjaW5vIHdyb3RlOg0KPj4+Pj4+PiArICAtIGEgbWFwcGluZyBiZWxvdyBzYnJrKDAp
IGRvbmUgYnkgdGhlIHByb2Nlc3MgaXRzZWxmDQo+Pj4+Pj4NCj4+Pj4+PiBkb2Vzbid0IHRoZSBt
bWFwIHJ1bGUgY292ZXIgdGhpcz8NCj4+Pj4+DQo+Pj4+PiBJSVVDIGl0IGRvZXNuJ3QgY292ZXIg
aXQgYXMgdGhhdCdzIG1lbW9yeSBtYXBwZWQgYnkgdGhlIGtlcm5lbA0KPj4+Pj4gYXV0b21hdGlj
YWxseSBvbiBhY2Nlc3MgdnMgYSBwb2ludGVyIHJldHVybmVkIGJ5IG1tYXAoKS4gVGhlIHN0YXRl
bWVudA0KPj4+Pj4gYWJvdmUgdGFsa3MgYWJvdXQgaG93IHRoZSBhZGRyZXNzIGlzIG9idGFpbmVk
IGJ5IHRoZSB1c2VyLg0KPj4+Pg0KPj4+PiBvayBpIHJlYWQgJ21hcHBpbmcgYmVsb3cgc2Jyaycg
YXMgYW4gbW1hcCAocG9zc2libHkgTUFQX0ZJWEVEKQ0KPj4+PiB0aGF0IGhhcHBlbnMgdG8gYmUg
YmVsb3cgdGhlIGhlYXAgYXJlYS4NCj4+Pj4NCj4+Pj4gaSB0aGluayAiYmVsb3cgc2JyaygwKSIg
aXMgbm90IHRoZSBiZXN0IHRlcm0gdG8gdXNlOiB0aGVyZQ0KPj4+PiBtYXkgYmUgYWRkcmVzcyBy
YW5nZSBiZWxvdyB0aGUgaGVhcCBhcmVhIHRoYXQgY2FuIGJlIG1tYXBwZWQNCj4+Pj4gYW5kIHRo
dXMgYmVsb3cgc2JyaygwKSBhbmQgc2JyayBpcyBhIHBvc2l4IGFwaSBub3QgYSBsaW51eA0KPj4+
PiBzeXNjYWxsLCB0aGUgbGliYyBjYW4gaW1wbGVtZW50IGl0IHdpdGggbW1hcCBvciB3aGF0ZXZl
ci4NCj4+Pj4NCj4+Pj4gaSdtIG5vdCBzdXJlIHdoYXQgdGhlIHJpZ2h0IHRlcm0gZm9yICdoZWFw
IGFyZWEnIGlzDQo+Pj4+ICh0aGUgYWRkcmVzcyByYW5nZSBiZXR3ZWVuIHN5c2NhbGwoX19OUl9i
cmssMCkgYXQNCj4+Pj4gcHJvZ3JhbSBzdGFydHVwIGFuZCBpdHMgY3VycmVudCB2YWx1ZT8pDQo+
Pj4+DQo+Pj4NCj4+PiBJIHVzZWQgc2JyaygwKSB3aXRoIHRoZSBtZWFuaW5nIG9mICJlbmQgb2Yg
dGhlIHByb2Nlc3MncyBkYXRhIHNlZ21lbnQiIG5vdA0KPj4+IGltcGx5aW5nIHRoYXQgdGhpcyBp
cyBhIHN5c2NhbGwsIGJ1dCBqdXN0IGFzIGEgdXNlZnVsIHdheSB0byBpZGVudGlmeSB0aGUgbWFw
cGluZy4NCj4+PiBJIGFncmVlIHRoYXQgaXQgaXMgYSBwb3NpeCBmdW5jdGlvbiBpbXBsZW1lbnRl
ZCBieSBsaWJjIGJ1dCB3aGVuIGl0IGlzIHVzZWQgd2l0aA0KPj4+IDAgZmluZHMgdGhlIGN1cnJl
bnQgbG9jYXRpb24gb2YgdGhlIHByb2dyYW0gYnJlYWssIHdoaWNoIGNhbiBiZSBjaGFuZ2VkIGJ5
IGJyaygpDQo+Pj4gYW5kIGRlcGVuZGluZyBvbiB0aGUgbmV3IGFkZHJlc3MgcGFzc2VkIHRvIHRo
aXMgc3lzY2FsbCBjYW4gaGF2ZSB0aGUgZWZmZWN0IG9mDQo+Pj4gYWxsb2NhdGluZyBvciBkZWFs
bG9jYXRpbmcgbWVtb3J5Lg0KPj4+DQo+Pj4gV2lsbCBjaGFuZ2luZyBzYnJrKDApIHdpdGggImVu
ZCBvZiB0aGUgcHJvY2VzcydzIGRhdGEgc2VnbWVudCIgbWFrZSBpdCBtb3JlIGNsZWFyPw0KPj4N
Cj4+IGkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0J3MgdGhlIHJlbGV2YW5jZSBvZiB0aGUgKmVuZCoN
Cj4+IG9mIHRoZSBkYXRhIHNlZ21lbnQuDQo+Pg0KPj4gaSdkIGV4cGVjdCB0aGUgdGV4dCB0byBz
YXkgc29tZXRoaW5nIGFib3V0IHRoZSBhZGRyZXNzDQo+PiByYW5nZSBvZiB0aGUgZGF0YSBzZWdt
ZW50Lg0KPj4NCj4+IGkgY2FuIGRvDQo+Pg0KPj4gbW1hcCgodm9pZCopNjU1MzYsIDY1NTM2LCBQ
Uk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX0ZJWEVEfE1BUF9TSEFSRUR8TUFQX0FOT04sIC0xLCAw
KTsNCj4+DQo+PiBhbmQgaXQgd2lsbCBiZSBiZWxvdyB0aGUgZW5kIG9mIHRoZSBkYXRhIHNlZ21l
bnQuDQo+Pg0KPiANCj4gQXMgZmFyIGFzIEkgdW5kZXJzdGFuZCB0aGUgZGF0YSBzZWdtZW50ICJs
aXZlcyIgYmVsb3cgdGhlIHByb2dyYW0gYnJlYWssIGhlbmNlDQo+IGl0IGlzIGEgd2F5IG9mIGRl
c2NyaWJpbmcgdGhlIHJhbmdlIGZyb20gd2hpY2ggdGhlIHVzZXIgY2FuIG9idGFpbiBhIHZhbGlk
DQo+IHRhZ2dlZCBwb2ludGVyLj4NCj4gU2FpZCB0aGF0LCBJIGFtIG5vdCByZWFsbHkgc3VyZSBv
biBob3cgZG8geW91IHdhbnQgbWUgdG8gZG9jdW1lbnQgdGhpcyAobXkgYWltDQo+IGlzIGZvciB0
aGlzIHRvIGJlIGNsZWFyIHRvIHRoZSB1c2Vyc3BhY2UgZGV2ZWxvcGVycykuIENvdWxkIHlvdSBw
bGVhc2UgcHJvcG9zZQ0KPiBzb21ldGhpbmc/DQoNClsuLi5dLCBpdCBpcyBpbiB0aGUgbWVtb3J5
IHJhbmdlcyBwcml2YXRlbHkgb3duZWQgYnkgYQ0KdXNlcnNwYWNlIHByb2Nlc3MgYW5kIGl0IGlz
IG9idGFpbmVkIGluIG9uZSBvZiB0aGUNCmZvbGxvd2luZyB3YXlzOg0KDQotIG1tYXAgZG9uZSBi
eSB0aGUgcHJvY2VzcyBpdHNlbGYsIFsuLi5dDQoNCi0gYnJrIHN5c2NhbGwgZG9uZSBieSB0aGUg
cHJvY2VzcyBpdHNlbGYuDQogIChpLmUuIHRoZSBoZWFwIGFyZWEgYmV0d2VlbiB0aGUgaW5pdGlh
bCBsb2NhdGlvbg0KICBvZiB0aGUgcHJvZ3JhbSBicmVhayBhdCBwcm9jZXNzIGNyZWF0aW9uIGFu
ZCBpdHMNCiAgY3VycmVudCBsb2NhdGlvbi4pDQoNCi0gYW55IG1lbW9yeSBtYXBwZWQgYnkgdGhl
IGtlcm5lbCBbLi4uXQ0KDQp0aGUgZGF0YSBzZWdtZW50IHRoYXQncyBwYXJ0IG9mIHRoZSBwcm9j
ZXNzIGltYWdlIGlzDQphbHJlYWR5IGNvdmVyZWQgYnkgdGhlIGxhc3QgcG9pbnQuDQo=

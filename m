Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEF58EBBD6
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2019 02:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfKAB5f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 31 Oct 2019 21:57:35 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:50998 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfKAB5e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 31 Oct 2019 21:57:34 -0400
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id A8870B4F52DF28840A32;
        Fri,  1 Nov 2019 09:57:31 +0800 (CST)
Received: from DGGEMI529-MBS.china.huawei.com ([169.254.5.176]) by
 dggemi403-hub.china.huawei.com ([10.3.17.136]) with mapi id 14.03.0439.000;
 Fri, 1 Nov 2019 09:57:23 +0800
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "alistair@popple.id.au" <alistair@popple.id.au>,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        Xiexiuqi <xiexiuqi@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oss@buserror.net" <oss@buserror.net>,
        "paulus@samba.org" <paulus@samba.org>,
        "Libin (Huawei)" <huawei.libin@huawei.com>,
        "agust@denx.de" <agust@denx.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IGxvb3AgbmVzdGluZyBpbiBhbGlnbm1lbnQgZXhj?=
 =?utf-8?Q?eption_and_machine_check?=
Thread-Topic: =?utf-8?B?562U5aSNOiBsb29wIG5lc3RpbmcgaW4gYWxpZ25tZW50IGV4Y2VwdGlvbiBh?=
 =?utf-8?Q?nd_machine_check?=
Thread-Index: AdWLzOb7zyHoVFoiQIWRpEOzZEjVL///vrgA//yweICACykWAP/+hnzQ
Date:   Fri, 1 Nov 2019 01:57:22 +0000
Message-ID: <D44062DC474617438D5181ADFE2B2C21016ED78D@dggemi529-mbs.china.huawei.com>
References: <D44062DC474617438D5181ADFE2B2C21016DE42A@dggemi529-mbs.china.huawei.com>
 <8215aeb3-57dd-223a-29d3-45ca22b0543c@c-s.fr>
 <D44062DC474617438D5181ADFE2B2C21016E9EAA@dggemi529-mbs.china.huawei.com>
 <ef93fa2f-d98f-2e94-322e-0ae095626e75@c-s.fr>
In-Reply-To: <ef93fa2f-d98f-2e94-322e-0ae095626e75@c-s.fr>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.195.37]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGksIENocmlzdG9waGUNCg0KCUkgYW0gc29ycnkgdGhhdCB3ZSBhcmUgaW4gc29tZSB0cm91Ymxl
cyBmb3Igc29tZSB1bnByZWRpY3RhYmxlIHByb2JsZW1zIHdoZW4gd2UgcmVwbGF5IGFuZCBoYXZl
bid0IGdpdmVuIHlvdSBhIHF1aWNrIHJlcGx5Lg0KCQ0KCUkgYWxzbyB3YW50IHRvIGFzayBkb2Vz
IHRoZSBwaGVub21lb24odXNlIG1lbWNweV90b2lvIHdoZW4gY29weSBpb3JlbWFwX2FkZHJlc3Mp
IG9ubHkgb2NjdXJzIGluIHBvd2VycGMgPyBkb2VzIGFueSBvdGhlciANCmFyY2ggYWxzbyBoYXMg
dGhlIHNhbWUgcHJvYmxlbSA/IHdlIGFyZSBpbiBwZXJzdWl0IG9mIGFza2luZyB3aHkgdGhpcyBw
aGVub21lbm9uIGhhcHBlbmVkLiBPdXIgbGludXgga2VybmVsIHZlcnNpb24gaXMgNC40Lg0KCQ0K
CXRoYW5rcyB2ZXJ5IG11Y2guDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujog
Q2hyaXN0b3BoZSBMZXJveSBbbWFpbHRvOmNocmlzdG9waGUubGVyb3lAYy1zLmZyXSANCuWPkemA
geaXtumXtDogMjAxOeW5tDEw5pyIMzHml6UgMTk6MTMNCuaUtuS7tuS6ujogV2FuZ3NoYW9ibyAo
Ym9ibykgPGJvYm8uc2hhb2Jvd2FuZ0BodWF3ZWkuY29tPg0K5oqE6YCBOiBjaGVuZ2ppYW4gKEQp
IDxjai5jaGVuZ2ppYW5AaHVhd2VpLmNvbT47IExpYmluIChIdWF3ZWkpIDxodWF3ZWkubGliaW5A
aHVhd2VpLmNvbT47IFhpZXhpdXFpIDx4aWV4aXVxaUBodWF3ZWkuY29tPjsgemhhbmd5aSAoRikg
PHlpLnpoYW5nQGh1YXdlaS5jb20+DQrkuLvpopg6IFJlOiDnrZTlpI06IGxvb3AgbmVzdGluZyBp
biBhbGlnbm1lbnQgZXhjZXB0aW9uIGFuZCBtYWNoaW5lIGNoZWNrDQoNCkhpLA0KDQpEaWQgeW91
IHRyeSA/IERvZXMgaXQgd29yayA/DQoNCkNocmlzdG9waGUNCg0KTGUgMjgvMTAvMjAxOSDDoCAw
Njo1NywgV2FuZ3NoYW9ibyAoYm9ibykgYSDDqWNyaXTCoDoNCj4gSGksQ2hyaXN0b3BoZQ0KPiAN
Cj4gVGhhbmsgeW91IGZvciB5b3VyIHF1aWNrIHJlcGx5LiBJIHdpbGwgdHJ5IHRvIHVzZSBtZW1j
cHlfdG9pbygpIGluc3RlYWQgb2YgbWVtY3B5KCkuDQo+IA0KPiAtLS0tLemCruS7tuWOn+S7ti0t
LS0tDQo+IOWPkeS7tuS6ujogQ2hyaXN0b3BoZSBMZXJveSBbbWFpbHRvOmNocmlzdG9waGUubGVy
b3lAYy1zLmZyXQ0KPiDlj5HpgIHml7bpl7Q6IDIwMTnlubQxMOaciDI25pelIDE5OjIwDQo+IOaU
tuS7tuS6ujogV2FuZ3NoYW9ibyAoYm9ibykgPGJvYm8uc2hhb2Jvd2FuZ0BodWF3ZWkuY29tPg0K
PiDmioTpgIE6IGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnOyBhbGlzdGFpckBwb3BwbGUuaWQu
YXU7IGNoZW5namlhbiAoRCkgDQo+IDxjai5jaGVuZ2ppYW5AaHVhd2VpLmNvbT47IFhpZXhpdXFp
IDx4aWV4aXVxaUBodWF3ZWkuY29tPjsgDQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IG9zc0BidXNlcnJvci5uZXQ7IHBhdWx1c0BzYW1iYS5vcmc7IA0KPiBMaWJpbiAoSHVhd2VpKSA8
aHVhd2VpLmxpYmluQGh1YXdlaS5jb20+OyBhZ3VzdEBkZW54LmRlOyANCj4gbGludXhwcGMtZGV2
QGxpc3RzLm96bGFicy5vcmcNCj4g5Li76aKYOiBSZTogbG9vcCBuZXN0aW5nIGluIGFsaWdubWVu
dCBleGNlcHRpb24gYW5kIG1hY2hpbmUgY2hlY2sNCj4gDQo+IEhpLA0KPiANCj4gTGUgMjYvMTAv
MjAxOSDDoCAwOToyMywgV2FuZ3NoYW9ibyAoYm9ibykgYSDDqWNyaXTCoDoNCj4+IEhpLA0KPj4N
Cj4+IEkgZW5jb3VudGVyZWQgYSBwcm9ibGVtIGFib3V0IGEgbG9vcCBuZXN0aW5nIG9jY3VycmVk
IGluIA0KPj4gbWFudWZhY3R1cmluZyB0aGUgYWxpZ25tZW50IGV4Y2VwdGlvbiBpbiBtYWNoaW5l
IGNoZWNrLCB0cmlnZ2VyIGJhY2tncm91bmQgaXMgOg0KPj4NCj4+IHByb2JsZW06DQo+Pg0KPj4g
bWFjaGluZSBjaGVja291dCBvciBjcml0aWNhbCBpbnRlcnJ1cHQgLT7igKYtPmtib3hfd3JpdGVb
Zm9yIHJlY29yZGluZyANCj4+IGxhc3Qgd29yZHNdIC0+IG1lbWNweShpcnJlbWFwX2FkZHIsIHNy
YyxzaXplKTpfR0xPQkFMKG1lbWNweSnigKYNCj4+DQo+PiB3aGVuIHdlIGVudGVyIG1lbWNweSxh
IGNvbW1hbmQg4oCYZGNieiByMTEscjbigJkgd2lsbCBjYXVzZSBhIGFsaWdubWVudCANCj4+IGV4
Y2VwdGlvbiwgaW4gdGhpcyBzaXR1YXRpb24scjExIGxvYWRzIHRoZSBpb3JlbWFwIGFkZHJlc3Ms
d2hpY2ggDQo+PiBsZWFkcyB0byB0aGUgYWxpZ25tZW50IGV4Y2VwdGlvbiwNCj4gDQo+IFlvdSBj
YW4ndCB1c2UgbWVtY3B5KCkgb24gc29tZXRoaW5nIGVsc2UgdGhhbiBtZW1vcnkuDQo+IA0KPiBG
b3IgYW4gaW9yZW1hcHBlZCBhcmVhLCB5b3UgaGF2ZSB0byB1c2UgbWVtY3B5X3RvaW8oKQ0KPiAN
Cj4gQ2hyaXN0b3BoZQ0KPiANCj4+DQo+PiB0aGVuIHRoZSBjb21tYW5kIGNhbiBub3QgYmUgcHJv
Y2VzcyBzdWNjZXNzZnVsbHksYXMgd2Ugc3RpbGwgaW4gDQo+PiBtYWNoaW5lIGNoZWNrLmF0IHRo
ZSBlbmQgLGl0IHRyaWdnZXJzIGEgbmV3IGlycSBtYWNoaW5lIGNoZWNrIGluIGlycSANCj4+IGhh
bmRsZXIgZnVuY3Rpb24sYSBsb29wIG5lc3RpbmcgYmVnaW5zLg0KPj4NCj4+IGFuYWx5c2lzOg0K
Pj4NCj4+IFdlIGhhdmUgYW5hbHlzZWQgYSBsb3QsYnV0IGl0IHN0aWxsIGNhbiBub3QgY29tZSB0
byBhIHJlYXNvbmFibGUgDQo+PiBkZXNjcmlwdGlvbixpbiBjb21tb24sdGhlIGFsaWdubWVudCB0
cmlnZ2VyZWQgaW4gbWFjaGluZSBjaGVjayANCj4+IGNvbnRleHQgY2FuIHN0aWxsIGJlIGNvbGxl
Y3RlZCBpbnRvIHRoZSBLYm94DQo+Pg0KPj4gYWZ0ZXIgYWxpZ25tZW50IGV4Y2VwdGlvbiBiZSBo
YW5kbGVkIGJ5IGhhbmRsZXIgZnVuY3Rpb24sIGJ1dCBob3cgDQo+PiBkb2VzIHRoZSBtYWNoaW5l
IGNoZWNrb3V0IGNhbiBiZSB0cmlnZ2VyZWQgaW4gdGhlIGhhbmRsZXIgZnVjbnRpb24gDQo+PiBm
b3IgYW55IGNhdXNlcz8gV2UgcHJpbnQgcmVsZXZhbnQgcmVnaXN0ZXJzDQo+Pg0KPj4gYXMgZm9s
bG93IHdoZW4gZmlyc3QgZW50ZXIgbWFjaGluZSBjaGVjayBhbmQgYWxpZ25tZW50IGV4Y2VwdGlv
biANCj4+IGhhbmRsZXINCj4+IGZ1bmN0aW9uOg0KPj4NCj4+ICAgwqDCoMKgwqDCoMKgwqDCoCBN
U1I6MHgywqDCoMKgwqDCoCBNU1I6MHgwDQo+Pg0KPj4gICDCoMKgwqDCoMKgwqDCoMKgIFNSUjE6
MHgywqDCoMKgwqDCoCBTUlIxOjB4MjEwMDINCj4+DQo+PiAgIMKgwqDCoMKgwqDCoMKgwqAgQnV0
IHRoZSBtYW51YWwgc2F5cyBTUlIxIHNob3VsZCBiZSBzZXQgdG8gTVNSKDB4Miksd2h5IA0KPj4g
dGhhdCBoYXBwZW5lZCA/DQo+Pg0KPj4gICDCoMKgwqDCoMKgwqDCoMKgIFRoZW4gYSBicmFuY2gg
aW4gaGFuZGxlciBmdW5jdGlvbiBjb3B5IHRoZSBTUlIxIHRvIA0KPj4gTVNSLHRoaXMgZW5ibGUg
TVNSW01FXSBhbmQgTVNSW0NFXSxzeXN0ZW0gY29sbGFwc2VzLg0KPj4NCj4+IENvbmNsdXNpb246
DQo+Pg0KPj4gICDCoMKgwqDCoMKgwqDCoMKgIDEpwqAgd2h5IHRoZSBhbGlnbm1lbnQgZXhjZXB0
aW9uIGNhbiBub3QgYmUgaGFuZGxlZCBpbiANCj4+IG1hY2hpbmUgY2hlY2sgPw0KPj4NCj4+ICAg
wqDCoMKgwqDCoMKgwqDCoCAyKcKgIGJlc2lkZXMgbWVtY3B5LGFueSBvdGhlciBmdW5jdGlvbiBj
YW4gY2F1c2UgdGhlIA0KPj4gYWxpZ25tZW50IGV4Y2VwdGlvbiA/DQo+Pg0KPj4gV2Ugc3RpbGwg
cmVjdXJyZW50IGl0LCB0aGUgbGluZSBhcyBmb2xsb3dzOg0KPj4NCj4+ICAgwqDCoMKgwqDCoMKg
wqDCoCBDcHUgZGVhZCBsb2NrLT53YXRjaCBsb2ctPnRyaWdnZXINCj4+IGZpcS0+a2JveF93cml0
ZS0+bWVtY3B5LT5hbGlnbm1lbnQgZXhjZXB0aW9uLT5wcmludCBsYXN0IHdvcmRzLg0KPj4NCj4+
ICAgwqDCoMKgwqDCoMKgwqDCoCBidXQgZm9yIHRob3NlIHByb2JsZW1zIGFzIGJlbG93LHdoYXQg
dGhlIGtib3ggcHJpbnRlZCBpcyBlbXB0eS4NCj4+DQo+PiAtLS0tLS0tLS0tLS0tLS0tLS1rYm94
IHJlc3RhcnQ6W8KgwqAgMTAuMTQ3NTk0XS0tLS0tLS0tLS0tLS0tLS0NCj4+DQo+PiBrYm94IHZl
cmlmeSBmcyBtYWdpYyBmYWlsDQo+Pg0KPj4ga2JveCBtZW0gbWFieWUgZGVzdHJveWVkLCBmb3Jt
YXQgaXQNCj4+DQo+PiBrYm94OiBsb2FkIE9LDQo+Pg0KPj4gbG9jay10YXNrOiBtYWpvclsyNDld
IG1pbm9yWzBdDQo+Pg0KPj4gLS0tLS1zdGFydCBzaG93X2Rlc3Ryb3llZF9rYm94X21lbV9oZWFk
LS0tLQ0KPj4NCj4+IDAwMDAwMDAwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MMKgIC4uLi4uLi4uLi4uLi4uLi4NCj4+DQo+PiAwMDAwMDAxMDogMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDAgMDAwMDAwMDDCoCAuLi4uLi4uLi4uLi4uLi4uDQo+Pg0KPj4gMDAwMDAwMjA6IDAw
MDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwwqAgLi4uLi4uLi4uLi4uLi4uLg0KPj4N
Cj4+IDAwMDAwMDMwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMMKgIC4uLi4u
Li4uLi4uLi4uLi4NCj4+DQo+PiAwMDAwMDA0MDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDDCoCAuLi4uLi4uLi4uLi4uLi4uDQo+Pg0KPj4gMDAwMDAwNTA6IDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwwqAgLi4uLi4uLi4uLi4uLi4uLg0KPj4NCj4+IDAwMDAw
MDYwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMMKgIC4uLi4uLi4uLi4uLi4u
Li4NCj4+DQo+PiAwMDAwMDA3MDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDDC
oCAuLi4uLi4uLi4uLi4uLi4uDQo+Pg0KPj4gMDAwMDAwODA6IDAwMDAwMDAwIDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAwwqAgLi4uLi4uLi4uLi4uLi4uLg0KPj4NCj4+IDAwMDAwMDkwOiAwMDAw
MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMMKgIC4uLi4uLi4uLi4uLi4uLi4NCj4+DQo=

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE19CFBE6E
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2019 04:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKNDrP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Nov 2019 22:47:15 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2085 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfKNDrP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Nov 2019 22:47:15 -0500
Received: from dggemi406-hub.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id B8ADC355815EDE64857F;
        Thu, 14 Nov 2019 11:47:07 +0800 (CST)
Received: from DGGEMI529-MBS.china.huawei.com ([169.254.5.47]) by
 dggemi406-hub.china.huawei.com ([10.3.17.144]) with mapi id 14.03.0439.000;
 Thu, 14 Nov 2019 11:47:00 +0800
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        "Libin (Huawei)" <huawei.libin@huawei.com>,
        Xiexiuqi <xiexiuqi@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IGxvb3AgbmVzdGluZyBpbiBhbGlnbm1lbnQgZXhj?=
 =?utf-8?Q?eption_and_machine_check?=
Thread-Topic: =?utf-8?B?562U5aSNOiBsb29wIG5lc3RpbmcgaW4gYWxpZ25tZW50IGV4Y2VwdGlvbiBh?=
 =?utf-8?Q?nd_machine_check?=
Thread-Index: AdWLzOb7zyHoVFoiQIWRpEOzZEjVL///vrgA//yweICACykWAP/qCgEQ
Date:   Thu, 14 Nov 2019 03:46:59 +0000
Message-ID: <D44062DC474617438D5181ADFE2B2C2101701C71@dggemi529-mbs.china.huawei.com>
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

SGkgQ2hyaXN0b3BoZSwNCglJdCB0ZXN0aWZ5cyBwcm9ibGVtIGZpeGVkIHdoZW4gd2UgdXNlIG1l
bWNweV90b2lvKCkgaW5zdGVhZCBvZiBtZW1jcHkgSW4gb3VyIHByYWN0aWNlLCB3ZSBmb3VuZCBl
dmVyeXRoaW5nIGlzIG9rIGJlZm9yZSB0aGUgY2FjaGVfbWVtY3B5IGJlY29tZXMgbWVtY3B5IGlu
IHRoZSANClBhdGNoIDBiMDVlMmQ2NzFjNDBjZmI1N2U2NmU0ZTQwMjMyMGQ2ZTA1NmIyZjggYWRv
cHRlZCwgaXQgYWNjZWxlcmF0ZXMgdGhlIG1lbWNweSBidXQgaW50cm9kdWNlcyBpbXBsaWNpdCB0
cm91YmxlLCBvdXIgcHJvZHVjdHMgY29tbW9ubHkgdXNlZCBtZW1jcHkgZm9yIGNvbnRpbnVvdXMg
DQptYXRhaW5hbmNlIGZvciBhIGxvbmcgdGltZSAsIGJ1dCBub3cgdGhvc2UgYmVjb21lIGEgYmln
IHByb2JsZW0gZm9yIHVzIHRvIGNoZWNrIHdoZXJlIHdlIHVzZSBpcyBjb3JyZWN0IGFuZCB3aGVy
ZSBpcyB3cm9uZywgd2l0aCByZXNwZWN0IHRvIGNhY2hhYmxlX21lbWNweSBhbmQgbWVtY3B5X3Rv
aW8uDQoJU28sIEkgYWxzbyB3YW50IHRvIGFzaywNCglob3cgY2FuIHdlIHRydXN0bHkgYW5kIHVu
aWZpZWQgZmlsbCB0aGUgZ2FwIHJlc3VsdGVkIGJ5IHRob3NlIGNoYW5nZXMgaW4gbWVtY3B5IGlu
IHZlcnNpb24gbWFudGFpbmFuY2UsIGlmIHlvdSBoYXZlIHNvbWUgdGlwcyBwbHMgdGVsbCBtZS4N
CglUdGhhbmtzLCB5b3VyIFNoYW9ibyBXYW5nDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWP
keS7tuS6ujogQ2hyaXN0b3BoZSBMZXJveSBbbWFpbHRvOmNocmlzdG9waGUubGVyb3lAYy1zLmZy
XSANCuWPkemAgeaXtumXtDogMjAxOeW5tDEw5pyIMzHml6UgMTk6MTMNCuaUtuS7tuS6ujogV2Fu
Z3NoYW9ibyAoYm9ibykgPGJvYm8uc2hhb2Jvd2FuZ0BodWF3ZWkuY29tPg0K5oqE6YCBOiBjaGVu
Z2ppYW4gKEQpIDxjai5jaGVuZ2ppYW5AaHVhd2VpLmNvbT47IExpYmluIChIdWF3ZWkpIDxodWF3
ZWkubGliaW5AaHVhd2VpLmNvbT47IFhpZXhpdXFpIDx4aWV4aXVxaUBodWF3ZWkuY29tPjsgemhh
bmd5aSAoRikgPHlpLnpoYW5nQGh1YXdlaS5jb20+DQrkuLvpopg6IFJlOiDnrZTlpI06IGxvb3Ag
bmVzdGluZyBpbiBhbGlnbm1lbnQgZXhjZXB0aW9uIGFuZCBtYWNoaW5lIGNoZWNrDQoNCkhpLA0K
DQpEaWQgeW91IHRyeSA/IERvZXMgaXQgd29yayA/DQoNCkNocmlzdG9waGUNCg0KTGUgMjgvMTAv
MjAxOSDDoCAwNjo1NywgV2FuZ3NoYW9ibyAoYm9ibykgYSDDqWNyaXTCoDoNCj4gSGksQ2hyaXN0
b3BoZQ0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHF1aWNrIHJlcGx5LiBJIHdpbGwgdHJ5IHRv
IHVzZSBtZW1jcHlfdG9pbygpIGluc3RlYWQgb2YgbWVtY3B5KCkuDQo+IA0KPiAtLS0tLemCruS7
tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogQ2hyaXN0b3BoZSBMZXJveSBbbWFpbHRvOmNocmlz
dG9waGUubGVyb3lAYy1zLmZyXQ0KPiDlj5HpgIHml7bpl7Q6IDIwMTnlubQxMOaciDI25pelIDE5
OjIwDQo+IOaUtuS7tuS6ujogV2FuZ3NoYW9ibyAoYm9ibykgPGJvYm8uc2hhb2Jvd2FuZ0BodWF3
ZWkuY29tPg0KPiDmioTpgIE6IGxpbnV4LWFyY2hAdmdlci5rZXJuZWwub3JnOyBhbGlzdGFpckBw
b3BwbGUuaWQuYXU7IGNoZW5namlhbiAoRCkgDQo+IDxjai5jaGVuZ2ppYW5AaHVhd2VpLmNvbT47
IFhpZXhpdXFpIDx4aWV4aXVxaUBodWF3ZWkuY29tPjsgDQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IG9zc0BidXNlcnJvci5uZXQ7IHBhdWx1c0BzYW1iYS5vcmc7IA0KPiBMaWJpbiAo
SHVhd2VpKSA8aHVhd2VpLmxpYmluQGh1YXdlaS5jb20+OyBhZ3VzdEBkZW54LmRlOyANCj4gbGlu
dXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4g5Li76aKYOiBSZTogbG9vcCBuZXN0aW5nIGlu
IGFsaWdubWVudCBleGNlcHRpb24gYW5kIG1hY2hpbmUgY2hlY2sNCj4gDQo+IEhpLA0KPiANCj4g
TGUgMjYvMTAvMjAxOSDDoCAwOToyMywgV2FuZ3NoYW9ibyAoYm9ibykgYSDDqWNyaXTCoDoNCj4+
IEhpLA0KPj4NCj4+IEkgZW5jb3VudGVyZWQgYSBwcm9ibGVtIGFib3V0IGEgbG9vcCBuZXN0aW5n
IG9jY3VycmVkIGluIA0KPj4gbWFudWZhY3R1cmluZyB0aGUgYWxpZ25tZW50IGV4Y2VwdGlvbiBp
biBtYWNoaW5lIGNoZWNrLCB0cmlnZ2VyIGJhY2tncm91bmQgaXMgOg0KPj4NCj4+IHByb2JsZW06
DQo+Pg0KPj4gbWFjaGluZSBjaGVja291dCBvciBjcml0aWNhbCBpbnRlcnJ1cHQgLT7igKYtPmti
b3hfd3JpdGVbZm9yIHJlY29yZGluZyANCj4+IGxhc3Qgd29yZHNdIC0+IG1lbWNweShpcnJlbWFw
X2FkZHIsIHNyYyxzaXplKTpfR0xPQkFMKG1lbWNweSnigKYNCj4+DQo+PiB3aGVuIHdlIGVudGVy
IG1lbWNweSxhIGNvbW1hbmQg4oCYZGNieiByMTEscjbigJkgd2lsbCBjYXVzZSBhIGFsaWdubWVu
dCANCj4+IGV4Y2VwdGlvbiwgaW4gdGhpcyBzaXR1YXRpb24scjExIGxvYWRzIHRoZSBpb3JlbWFw
IGFkZHJlc3Msd2hpY2ggDQo+PiBsZWFkcyB0byB0aGUgYWxpZ25tZW50IGV4Y2VwdGlvbiwNCj4g
DQo+IFlvdSBjYW4ndCB1c2UgbWVtY3B5KCkgb24gc29tZXRoaW5nIGVsc2UgdGhhbiBtZW1vcnku
DQo+IA0KPiBGb3IgYW4gaW9yZW1hcHBlZCBhcmVhLCB5b3UgaGF2ZSB0byB1c2UgbWVtY3B5X3Rv
aW8oKQ0KPiANCj4gQ2hyaXN0b3BoZQ0KPiANCj4+DQo+PiB0aGVuIHRoZSBjb21tYW5kIGNhbiBu
b3QgYmUgcHJvY2VzcyBzdWNjZXNzZnVsbHksYXMgd2Ugc3RpbGwgaW4gDQo+PiBtYWNoaW5lIGNo
ZWNrLmF0IHRoZSBlbmQgLGl0IHRyaWdnZXJzIGEgbmV3IGlycSBtYWNoaW5lIGNoZWNrIGluIGly
cSANCj4+IGhhbmRsZXIgZnVuY3Rpb24sYSBsb29wIG5lc3RpbmcgYmVnaW5zLg0KPj4NCj4+IGFu
YWx5c2lzOg0KPj4NCj4+IFdlIGhhdmUgYW5hbHlzZWQgYSBsb3QsYnV0IGl0IHN0aWxsIGNhbiBu
b3QgY29tZSB0byBhIHJlYXNvbmFibGUgDQo+PiBkZXNjcmlwdGlvbixpbiBjb21tb24sdGhlIGFs
aWdubWVudCB0cmlnZ2VyZWQgaW4gbWFjaGluZSBjaGVjayANCj4+IGNvbnRleHQgY2FuIHN0aWxs
IGJlIGNvbGxlY3RlZCBpbnRvIHRoZSBLYm94DQo+Pg0KPj4gYWZ0ZXIgYWxpZ25tZW50IGV4Y2Vw
dGlvbiBiZSBoYW5kbGVkIGJ5IGhhbmRsZXIgZnVuY3Rpb24sIGJ1dCBob3cgDQo+PiBkb2VzIHRo
ZSBtYWNoaW5lIGNoZWNrb3V0IGNhbiBiZSB0cmlnZ2VyZWQgaW4gdGhlIGhhbmRsZXIgZnVjbnRp
b24gDQo+PiBmb3IgYW55IGNhdXNlcz8gV2UgcHJpbnQgcmVsZXZhbnQgcmVnaXN0ZXJzDQo+Pg0K
Pj4gYXMgZm9sbG93IHdoZW4gZmlyc3QgZW50ZXIgbWFjaGluZSBjaGVjayBhbmQgYWxpZ25tZW50
IGV4Y2VwdGlvbiANCj4+IGhhbmRsZXINCj4+IGZ1bmN0aW9uOg0KPj4NCj4+ICAgwqDCoMKgwqDC
oMKgwqDCoCBNU1I6MHgywqDCoMKgwqDCoCBNU1I6MHgwDQo+Pg0KPj4gICDCoMKgwqDCoMKgwqDC
oMKgIFNSUjE6MHgywqDCoMKgwqDCoCBTUlIxOjB4MjEwMDINCj4+DQo+PiAgIMKgwqDCoMKgwqDC
oMKgwqAgQnV0IHRoZSBtYW51YWwgc2F5cyBTUlIxIHNob3VsZCBiZSBzZXQgdG8gTVNSKDB4Miks
d2h5IA0KPj4gdGhhdCBoYXBwZW5lZCA/DQo+Pg0KPj4gICDCoMKgwqDCoMKgwqDCoMKgIFRoZW4g
YSBicmFuY2ggaW4gaGFuZGxlciBmdW5jdGlvbiBjb3B5IHRoZSBTUlIxIHRvIA0KPj4gTVNSLHRo
aXMgZW5ibGUgTVNSW01FXSBhbmQgTVNSW0NFXSxzeXN0ZW0gY29sbGFwc2VzLg0KPj4NCj4+IENv
bmNsdXNpb246DQo+Pg0KPj4gICDCoMKgwqDCoMKgwqDCoMKgIDEpwqAgd2h5IHRoZSBhbGlnbm1l
bnQgZXhjZXB0aW9uIGNhbiBub3QgYmUgaGFuZGxlZCBpbiANCj4+IG1hY2hpbmUgY2hlY2sgPw0K
Pj4NCj4+ICAgwqDCoMKgwqDCoMKgwqDCoCAyKcKgIGJlc2lkZXMgbWVtY3B5LGFueSBvdGhlciBm
dW5jdGlvbiBjYW4gY2F1c2UgdGhlIA0KPj4gYWxpZ25tZW50IGV4Y2VwdGlvbiA/DQo+Pg0KPj4g
V2Ugc3RpbGwgcmVjdXJyZW50IGl0LCB0aGUgbGluZSBhcyBmb2xsb3dzOg0KPj4NCj4+ICAgwqDC
oMKgwqDCoMKgwqDCoCBDcHUgZGVhZCBsb2NrLT53YXRjaCBsb2ctPnRyaWdnZXINCj4+IGZpcS0+
a2JveF93cml0ZS0+bWVtY3B5LT5hbGlnbm1lbnQgZXhjZXB0aW9uLT5wcmludCBsYXN0IHdvcmRz
Lg0KPj4NCj4+ICAgwqDCoMKgwqDCoMKgwqDCoCBidXQgZm9yIHRob3NlIHByb2JsZW1zIGFzIGJl
bG93LHdoYXQgdGhlIGtib3ggcHJpbnRlZCBpcyBlbXB0eS4NCj4+DQo+PiAtLS0tLS0tLS0tLS0t
LS0tLS1rYm94IHJlc3RhcnQ6W8KgwqAgMTAuMTQ3NTk0XS0tLS0tLS0tLS0tLS0tLS0NCj4+DQo+
PiBrYm94IHZlcmlmeSBmcyBtYWdpYyBmYWlsDQo+Pg0KPj4ga2JveCBtZW0gbWFieWUgZGVzdHJv
eWVkLCBmb3JtYXQgaXQNCj4+DQo+PiBrYm94OiBsb2FkIE9LDQo+Pg0KPj4gbG9jay10YXNrOiBt
YWpvclsyNDldIG1pbm9yWzBdDQo+Pg0KPj4gLS0tLS1zdGFydCBzaG93X2Rlc3Ryb3llZF9rYm94
X21lbV9oZWFkLS0tLQ0KPj4NCj4+IDAwMDAwMDAwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MCAwMDAwMDAwMMKgIC4uLi4uLi4uLi4uLi4uLi4NCj4+DQo+PiAwMDAwMDAxMDogMDAwMDAwMDAg
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDDCoCAuLi4uLi4uLi4uLi4uLi4uDQo+Pg0KPj4gMDAw
MDAwMjA6IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwwqAgLi4uLi4uLi4uLi4u
Li4uLg0KPj4NCj4+IDAwMDAwMDMwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAw
MMKgIC4uLi4uLi4uLi4uLi4uLi4NCj4+DQo+PiAwMDAwMDA0MDogMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDAgMDAwMDAwMDDCoCAuLi4uLi4uLi4uLi4uLi4uDQo+Pg0KPj4gMDAwMDAwNTA6IDAw
MDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwwqAgLi4uLi4uLi4uLi4uLi4uLg0KPj4N
Cj4+IDAwMDAwMDYwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMMKgIC4uLi4u
Li4uLi4uLi4uLi4NCj4+DQo+PiAwMDAwMDA3MDogMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDDCoCAuLi4uLi4uLi4uLi4uLi4uDQo+Pg0KPj4gMDAwMDAwODA6IDAwMDAwMDAwIDAw
MDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwwqAgLi4uLi4uLi4uLi4uLi4uLg0KPj4NCj4+IDAwMDAw
MDkwOiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMMKgIC4uLi4uLi4uLi4uLi4u
Li4NCj4+DQo=

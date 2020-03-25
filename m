Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71AF1191ED9
	for <lists+linux-arch@lfdr.de>; Wed, 25 Mar 2020 03:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCYCKv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Mar 2020 22:10:51 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3045 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727212AbgCYCKu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 22:10:50 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id F278CAC235422688F1C5;
        Wed, 25 Mar 2020 10:10:47 +0800 (CST)
Received: from DGGEML421-HUB.china.huawei.com (10.1.199.38) by
 dggeml405-hub.china.huawei.com (10.3.17.49) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 25 Mar 2020 10:10:47 +0800
Received: from DGGEML533-MBS.china.huawei.com ([169.254.10.196]) by
 dggeml421-hub.china.huawei.com ([10.1.199.38]) with mapi id 14.03.0487.000;
 Wed, 25 Mar 2020 10:10:40 +0800
From:   "yezhenyu (A)" <yezhenyu2@huawei.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org" <maz@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Xiexiangyou <xiexiangyou@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>
Subject: RE: [RFC PATCH v4 4/6] mm: Add page table level flags to vm_flags
Thread-Topic: [RFC PATCH v4 4/6] mm: Add page table level flags to vm_flags
Thread-Index: AQHWAeKVXiq19lnJ+0q/54z19KSbo6hXjqYAgAD+HPA=
Date:   Wed, 25 Mar 2020 02:10:40 +0000
Message-ID: <10338CF38D9A684EA38E1CF7D8D3411B045BA207@dggeml533-mbs.china.huawei.com>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
        <20200324134534.1570-5-yezhenyu2@huawei.com>
 <20200324144436.043659c2@gandalf.local.home>
In-Reply-To: <20200324144436.043659c2@gandalf.local.home>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.25]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgU3RldmUsDQoNCk9uIFdlZCwgMjUgTWFyIDIwMjAgMjo0NSwgU3RldmUgd3JvdGU6DQo+IE9u
IFR1ZSwgMjQgTWFyIDIwMjAgMjE6NDU6MzIgKzA4MDANCj4gWmhlbnl1IFllIDx5ZXpoZW55dTJA
aHVhd2VpLmNvbT4gd3JvdGU6DQo+IA0KPiA+IC0tLSBhL2luY2x1ZGUvdHJhY2UvZXZlbnRzL21t
ZmxhZ3MuaA0KPiA+ICsrKyBiL2luY2x1ZGUvdHJhY2UvZXZlbnRzL21tZmxhZ3MuaA0KPiA+IEBA
IC0xMzAsNiArMTMwLDE2IEBAIElGX0hBVkVfUEdfSURMRShQR19pZGxlLAkJImlkbGUiCQkpDQo+
ID4gICNkZWZpbmUgSUZfSEFWRV9WTV9TT0ZURElSVFkoZmxhZyxuYW1lKQ0KPiA+ICAjZW5kaWYN
Cj4gPg0KPiA+ICsjaWZkZWYgQ09ORklHXzY0QklUDQo+ID4gKyNkZWZpbmUgSUZfSEFWRV9WTV9M
RVZFTF9QVUQoZmxhZyxuYW1lKQl7ZmxhZywgbmFtZX0NCj4gPiArI2RlZmluZSBJRl9IQVZFX1ZN
X0xFVkVMX1BNRChmbGFnLG5hbWUpCXtmbGFnLCBuYW1lfQ0KPiA+ICsjZGVmaW5lIElGX0hBVkVf
Vk1fTEVWRUxfUFRFKGZsYWcsbmFtZSkJe2ZsYWcsIG5hbWV9DQo+ID4gKyNlbHNlDQo+ID4gKyNk
ZWZpbmUgSUZfSEFWRV9WTV9MRVZFTF9QVUQoZmxhZyxuYW1lKQ0KPiA+ICsjZGVmaW5lIElGX0hB
VkVfVk1fTEVWRUxfUE1EKGZsYWcsbmFtZSkNCj4gPiArI2RlZmluZSBJRl9IQVZFX1ZNX0xFVkVM
X1BURShmbGFnLG5hbWUpDQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAgI2RlZmluZSBfX2RlZl92
bWFmbGFnX25hbWVzCQkJCQkJXA0KPiA+ICAJe1ZNX1JFQUQsCQkJInJlYWQiCQl9LAkJXA0KPiA+
ICAJe1ZNX1dSSVRFLAkJCSJ3cml0ZSIJCX0sCQlcDQo+ID4gQEAgLTE2MSw3ICsxNzEsMTAgQEAg
SUZfSEFWRV9WTV9TT0ZURElSVFkoVk1fU09GVERJUlRZLA0KPiAJInNvZnRkaXJ0eSIJKQkJXA0K
PiA+ICAJe1ZNX01JWEVETUFQLAkJCSJtaXhlZG1hcCIJfSwJCVwNCj4gPiAgCXtWTV9IVUdFUEFH
RSwJCQkiaHVnZXBhZ2UiCX0sCQlcDQo+ID4gIAl7Vk1fTk9IVUdFUEFHRSwJCQkibm9odWdlcGFn
ZSIJfSwJCVwNCj4gPiAtCXtWTV9NRVJHRUFCTEUsCQkJIm1lcmdlYWJsZSIJfQkJXA0KPiA+ICsJ
e1ZNX01FUkdFQUJMRSwJCQkibWVyZ2VhYmxlIgl9LAkJXA0KPiA+ICtJRl9IQVZFX1ZNX0xFVkVM
X1BVRChWTV9MRVZFTF9QVUQsCSJwdWQtbGV2ZWwiCSksCQlcDQo+ID4gK0lGX0hBVkVfVk1fTEVW
RUxfUE1EKFZNX0xFVkVMX1BNRCwJInBtZC1sZXZlbCIJKSwJCVwNCj4gPiArSUZfSEFWRV9WTV9M
RVZFTF9QVEUoVk1fTEVWRUxfUFRFLAkicHRlLWxldmVsIgkpCQlcDQo+ID4NCj4gDQo+IEhhdmUg
eW91IHRlc3RlZCB0aGlzIG9uIDMyYml0PyBJdCBsb29rcyBsaWtlIHlvdSdsbCBnZXQgZW1wdHkg
Y29tbWFzIHRoZXJlLg0KPiBQZXJoYXBzIHRoZSBkZWZpbmVzIG5lZWQgdG8gYmU6DQo+IA0KPiAj
aWZkZWYgQ09ORklHXzY0QklUDQo+ICNkZWZpbmUgSUZfSEFWRV9WTV9MRVZFTF9QVUQoZmxhZyxu
YW1lKQl7ZmxhZywgbmFtZX0sDQo+ICNkZWZpbmUgSUZfSEFWRV9WTV9MRVZFTF9QTUQoZmxhZyxu
YW1lKQl7ZmxhZywgbmFtZX0sDQo+ICNkZWZpbmUgSUZfSEFWRV9WTV9MRVZFTF9QVEUoZmxhZyxu
YW1lKQl7ZmxhZywgbmFtZX0NCj4gI2Vsc2UNCj4gI2RlZmluZSBJRl9IQVZFX1ZNX0xFVkVMX1BV
RChmbGFnLG5hbWUpDQo+ICNkZWZpbmUgSUZfSEFWRV9WTV9MRVZFTF9QTUQoZmxhZyxuYW1lKQ0K
PiAjZGVmaW5lIElGX0hBVkVfVk1fTEVWRUxfUFRFKGZsYWcsbmFtZSkNCj4gI2VuZGlmDQo+IA0K
PiBBbmQgbGVhdmUgb3V0IHRoZSBjb21tYXMgaW4gdGhlIGxpc3QuDQo+IA0KPiAtLSBTdGV2ZQ0K
DQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LiBJIHdpbGwgZml4IHRoaXMgaW4gbmV4dCB2ZXJzaW9u
LCBpZiBJIGNvdWxkIHN0aWxsIHVzZSB2bV9mbGFncw0KYXQgdGhhdCB0aW1lIDopLg0KDQpaaGVu
eXUNCg0K

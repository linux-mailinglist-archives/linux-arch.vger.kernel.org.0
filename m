Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9617B7A1A9F
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 11:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjIOJez (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 05:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjIOJey (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 05:34:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE6E1FDE;
        Fri, 15 Sep 2023 02:34:49 -0700 (PDT)
Received: from lhrpeml100004.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rn86g6pjjz6D9DT;
        Fri, 15 Sep 2023 17:30:03 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 10:34:46 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.031;
 Fri, 15 Sep 2023 10:34:46 +0100
From:   Salil Mehta <salil.mehta@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        James Morse <james.morse@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "jianyong.wu@arm.com" <jianyong.wu@arm.com>,
        "justin.he@arm.com" <justin.he@arm.com>
Subject: RE: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields [code
 first?]
Thread-Topic: [RFC PATCH v2 27/35] ACPICA: Add new MADT GICC flags fields
 [code first?]
Thread-Index: AQHZ5mDqpYLh+nkhC0mj9mPBt3XEBLAZ5MMAgAB0lICAAAsFgIAAEfIQgADzSoCAABq9gIAAG4DQ
Date:   Fri, 15 Sep 2023 09:34:46 +0000
Message-ID: <80e36ff513504a0382a1cbce83e42295@huawei.com>
References: <20230913163823.7880-1-james.morse@arm.com>
        <20230913163823.7880-28-james.morse@arm.com>
        <CAMj1kXHRAt7ecB9p_dm3MjDL5wZkAsVh30hMY2SV_XUe=bm6Vg@mail.gmail.com>
        <20230914155459.00002dba@Huawei.com>
        <CAMj1kXFquiLGCMow3iujHUU4GBZx2t9KfKy1R9iqjBFjY+acaA@mail.gmail.com>
        <f5d9beea95e149ab89364dcdb0f8bf69@huawei.com>
        <ZQQDJT6MOaIOPmq5@shell.armlinux.org.uk>
 <CAJZ5v0jUQ+4G5ArYAtu1gvYF4356CK_QVTO4oWn0ukwdOiZaHA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jUQ+4G5ArYAtu1gvYF4356CK_QVTO4oWn0ukwdOiZaHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.174.239]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQo+IEZyb206IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz4NCj4gU2VudDog
RnJpZGF5LCBTZXB0ZW1iZXIgMTUsIDIwMjMgOTo0NSBBTQ0KPiBUbzogUnVzc2VsbCBLaW5nIChP
cmFjbGUpIDxsaW51eEBhcm1saW51eC5vcmcudWs+DQo+IENjOiBTYWxpbCBNZWh0YSA8c2FsaWwu
bWVodGFAaHVhd2VpLmNvbT47IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+Ow0KPiBK
b25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBKYW1lcyBNb3Jz
ZQ0KPiA8amFtZXMubW9yc2VAYXJtLmNvbT47IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgbG9v
bmdhcmNoQGxpc3RzLmxpbnV4LmRldjsNCj4gbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFyY2hAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gcmlzY3ZA
bGlzdHMuaW5mcmFkZWFkLm9yZzsga3ZtYXJtQGxpc3RzLmxpbnV4LmRldjsgeDg2QGtlcm5lbC5v
cmc7IEplYW4tDQo+IFBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz47
IGppYW55b25nLnd1QGFybS5jb207DQo+IGp1c3Rpbi5oZUBhcm0uY29tDQo+IFN1YmplY3Q6IFJl
OiBbUkZDIFBBVENIIHYyIDI3LzM1XSBBQ1BJQ0E6IEFkZCBuZXcgTUFEVCBHSUNDIGZsYWdzIGZp
ZWxkcw0KPiBbY29kZSBmaXJzdD9dDQo+IA0KPiBPbiBGcmksIFNlcCAxNSwgMjAyMyBhdCA5OjA5
4oCvQU0gUnVzc2VsbCBLaW5nIChPcmFjbGUpDQo+IDxsaW51eEBhcm1saW51eC5vcmcudWs+IHdy
b3RlOg0KPiA+DQo+ID4gT24gRnJpLCBTZXAgMTUsIDIwMjMgYXQgMDI6Mjk6MTNBTSArMDAwMCwg
U2FsaWwgTWVodGEgd3JvdGU6DQo+ID4gPiBPbiB4ODYsIGR1cmluZyBpbml0LCBpZiB0aGUgTUFE
VCBlbnRyeSBmb3IgTEFQSUMgaXMgZm91bmQgdG8gYmUNCj4gPiA+IG9ubGluZS1jYXBhYmxlIGFu
ZCBpcyBlbmFibGVkIGFzIHdlbGwgdGhlbiBwb3NzaWJsZSBhbmQgcHJlc2VudA0KPiA+DQo+ID4g
Tm90ZSB0aGF0IHRoZSBBQ1BJIHNwZWMgc2F5cyBlbmFibGVkICsgb25saW5lLWNhcGFibGUgaXNu
J3QgZGVmaW5lZC4NCj4gPg0KPiA+ICJUaGUgaW5mb3JtYXRpb24gY29udmV5ZWQgYnkgdGhpcyBi
aXQgZGVwZW5kcyBvbiB0aGUgdmFsdWUgb2YgdGhlDQo+ID4gRW5hYmxlZCBiaXQuIElmIHRoZSBF
bmFibGVkIGJpdCBpcyBzZXQsIHRoaXMgYml0IGlzIHJlc2VydmVkIGFuZA0KPiA+IG11c3QgYmUg
emVyby4iDQo+ID4NCj4gPiBTbywgaWYgeDg2IGlzIGRvaW5nIHNvbWV0aGluZyB3aXRoIHRoZSBl
bmFibGVkICYmIG9ubGluZS1jYXBhYmxlDQo+ID4gc3RhdGUgKG90aGVyIHRoYW4gaWdub3Jpbmcg
dGhlIG9ubGluZS1jYXBhYmxlKSB0aGVuIHRlY2huaWNhbGx5IGl0DQo+ID4gaXMgZG9pbmcgc29t
ZXRoaW5nIHRoYXQgdGhlIHNwZWMgZG9lc24ndCBkZWZpbmUNCj4gDQo+IEFuZCBzbyBpdCBpcyB3
cm9uZy4NCg0KDQpPciBtYXliZSwgc3BlY2lmaWNhdGlvbiBoYXMgbm90IGJlZW4gdXBkYXRlZCB5
ZXQuIGNvZGUtZmlyc3Q/DQoNCg0KPiANCj4gPiAtIGFuZCBpdCdzDQo+ID4gY29tcGxldGVseSBm
aW5lIGlmIGFhcmNoNjQgZG9lcyBzb21ldGhpbmcgZWxzZSAobWF5YmUgdHJlYXRpbmcgaXQNCj4g
PiBzdHJpY3RseSBhcyBwZXIgdGhlIHNwZWMgYW5kIGlnbm9yaW5nIG9ubGluZS1jYXBhYmxlLikN
Cj4gDQo+IFRoYXQgYWN0dWFsbHkgaXMgdGhlIG9ubHkgY29tcGxpYW50IHRoaW5nIHRoYXQgY2Fu
IGJlIGRvbmUuDQoNClllcywgYnV0IHRoZSBxdWVzdGlvbiBpcyBpdCB3aGF0IGlzIHJlcXVpcmVk
IGFuZCBkb2VzIGl0IHNvbHZlcw0KdGhlIHByb2JsZW0gb2YgSG90cGx1Zy4gSSB0aGluayBuby4g
DQoNCkJ5IGNvbXBseWluZyB3aXRoIHdoYXQgaXMgdGhlcmUgaW4gdGhlIHNwZWMgbWVhbnMgd2Ug
aGF2ZSB0bw0KZG8gdGhlIHRyYWRlb2ZmIGJldHdlZW4gaGF2aW5nIG5vdCB0byBzdXBwb3J0IGhv
dCh1bilwbHVnZ2luZw0Kb2YgdGhlIGNvbGQtcGx1Z2dlZCBDUFVzIFZzIHJpc2sgb2YgYnJlYWtp
bmcgdGhlIGxlZ2FjeSBPUw0KYXR0ZW1wdGluZyB0byB1c2UgbmV3ZXIgcGxhdGZvcm1zIHdpdGgg
SG90cGx1ZyBzdXBwb3J0LiBMYXRlcg0KaXMgbW9yZSBvZiBhIEFSTSBwcm9ibGVtIGFzIHdlIGFy
ZSBub3QgYWxsb3dlZCB0byB0d2VhayB0aGUNCkFDUEkgdGFibGVzIG9uY2UgdGhlIHN5c3RlbSBo
YXMgYm9vdGVkLg0KDQoNCj4gDQo+IEFzIHBlciB0aGUgc3BlYyAocXVvdGVkIGFib3ZlKSwgYSBw
bGF0Zm9ybSBmaXJtd2FyZSBzZXR0aW5nDQo+IG9ubGluZS1jYXBhYmxlIHRvIDEgd2hlbiBFbmFi
bGVkIGlzIHNldCBpcyBub3QgY29tcGxpYW50IGFuZCBpdCBpcw0KPiBpbnZhbGlkIHRvIHRyZWF0
IHRoaXMgYXMgbWVhbmluZ2Z1bCBkYXRhLg0KDQpDb3JyZWN0LiBidXQgaXMgaXQgcmVhbGx5IHdo
YXQgd2UgbmVlZD8gV2UgbmVlZCBib3RoIG9mIHRoZQ0KQml0cyB0byBiZSBzZXQgZm9yIHN1cHBv
cnRpbmcgaG90KHVuKXBsdWdnaW5nIG9mIGNvbGQgYm9vdGVkDQpDUFVzLg0KDQoNCj4gDQo+IEFz
IGN1cnJlbnRseSBkZWZpbmVkLCBvbmxpbmUtY2FwYWJsZSBpcyBvbmx5IGFwcGxpY2FibGUgdG8g
Q1BVcyB0aGF0DQo+IGFyZSBub3QgZW5hYmxlZCB0byBzdGFydCB3aXRoIGFuZCBpdHMgcm9sZSBp
cyB0byBtYWtlIGl0IGNsZWFyIHdoZXRoZXINCj4gb3Igbm90IHRoZXkgY2FuIGJlIGVuYWJsZWQg
bGF0ZXIgQUZBSUNTLg0KDQpDb3JyZWN0Lg0KDQo+IA0KPiBJZiB0aGVyZSBpcyBhIG5lZWQgdG8g
cmVwcmVzZW50IHRoZSBjYXNlIGluIHdoaWNoIGEgQ1BJIHRoYXQgaXMNCj4gZW5hYmxlZCB0byBz
dGFydCB3aXRoIGNhbiBiZSBkaXNhYmxlZCwgYnV0IGNhbm5vdCBiZSBlbmFibGVkIGFnYWluLA0K
PiB0aGUgc3BlYyBuZWVkcyB0byBiZSB1cGRhdGVkLg0KDQpBYnNvbHV0ZWx5LiBBbmQgdGhhdOKA
mXMgd2hhdCBteSBodW1ibGUgc3VnZ2VzdGlvbiBpcyBhcyB3ZWxsLg0KDQoNClRoYW5rcw0KU2Fs
aWwuDQoNCg==

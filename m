Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0572C34E329
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 10:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhC3Icb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 04:32:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:35015 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230415AbhC3IcE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Mar 2021 04:32:04 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-228-1J3o_GQdNMSaHrENW9vpNw-1; Tue, 30 Mar 2021 09:32:01 +0100
X-MC-Unique: 1J3o_GQdNMSaHrENW9vpNw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 30 Mar 2021 09:31:59 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.012; Tue, 30 Mar 2021 09:31:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guo Ren' <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Guo Ren" <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: RE: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Thread-Topic: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Thread-Index: AQHXJRLqafLiHQrxhUmfjrWfh9X/MKqcMq2w
Date:   Tue, 30 Mar 2021 08:31:59 +0000
Message-ID: <d21f5915f9e54a20b39a4fbc2941b0b6@AcuMS.aculab.com>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
In-Reply-To: <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogR3VvIFJlbg0KPiBTZW50OiAzMCBNYXJjaCAyMDIxIDA0OjE0DQouLi4NCj4gPiBTdGVw
IDEgd291bGQgYmUgdG8gZ2V0IHlvdXIgYXJjaGl0ZWN1dGUgZml4ZWQgc3VjaCB0aGF0IGl0IGNh
biBwcm92aWRlDQo+ID4gZndkIHByb2dyZXNzIGd1YXJhbnRlZXMgZm9yIExML1NDLiBPdGhlcndp
c2UgdGhlcmUncyBhYnNvbHV0ZWx5IG5vIHBvaW50DQo+ID4gaW4gYnVpbGRpbmcgY29tcGxleCBz
eXN0ZW1zIHdpdGggaXQuDQo+IA0KPiBRdW90ZSBXYWltYW4ncyBjb21tZW50IFsxXSBvbiB4Y2hn
MTYgb3B0aW1pemF0aW9uOg0KPiANCj4gIlRoaXMgb3B0aW1pemF0aW9uIGlzIG5lZWRlZCB0byBt
YWtlIHRoZSBxc3BpbmxvY2sgYWNoaWV2ZSBwZXJmb3JtYW5jZQ0KPiBwYXJpdHkgd2l0aCB0aWNr
ZXQgc3BpbmxvY2sgYXQgbGlnaHQgbG9hZC4iDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcva3ZtLzE0Mjk5MDE4MDMtMjk3NzEtNi1naXQtc2VuZC1lbWFpbC1XYWltYW4uTG9uZ0Bo
cC5jb20vDQo+IA0KPiBTbyBmb3IgYSBub24teGhnMTYgbWFjaGluZToNCj4gIC0gdGlja2V0LWxv
Y2sgZm9yIHNtYWxsIG51bWJlcnMgb2YgQ1BVcw0KPiAgLSBxc3BpbmxvY2sgZm9yIGxhcmdlIG51
bWJlcnMgb2YgQ1BVcw0KPiANCj4gT2theSwgSSdsbCBwdXQgYWxsIG9mIHRoZW0gaW50byB0aGUg
bmV4dCBwYXRjaCA6UA0KDQpEb2Vzbid0IHRoYXQgYWxzbyBpbXBseSB0aGF0IHlvdSBuZWVkIHRp
Y2tldC1sb2NrcyBmb3INCmxpZ2h0bHkgY29udGVuZGVkIGxvY2tzIGV2ZW4gd2l0aCBhIGxvdCBv
ZiBDUFVzPw0KDQpJZiB5b3UgYWN0dWFsbHkgZ2V0IGEgbG90IG9mIENQVXMgd2FpdGluZyBvbiB0
aGUgc2FtZSBzcGlubG9jaw0KeW91IHByb2JhYmx5IG91Z2h0IHRvIGNoYW5nZSB0aGUgY29kZSB0
byByZWR1Y2UgbG9jayBjb250ZW50aW9uLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


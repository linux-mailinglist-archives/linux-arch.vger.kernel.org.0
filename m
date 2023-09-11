Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9221579B8F3
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 02:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbjIKVFc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjIKKio (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 06:38:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DF2DE69
        for <linux-arch@vger.kernel.org>; Mon, 11 Sep 2023 03:38:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-IzkOUA4zNlKP5UCAOsRxDw-1; Mon, 11 Sep 2023 11:38:10 +0100
X-MC-Unique: IzkOUA4zNlKP5UCAOsRxDw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 11 Sep
 2023 11:37:59 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 11 Sep 2023 11:37:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mateusz Guzik' <mjguzik@gmail.com>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: RE: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
Thread-Topic: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
Thread-Index: AQHZ23Vdq8Esj5k0zUGYupOb09r6RrAF7nHAgAAb1ICAABQQEIANxBwAgAGZkGA=
Date:   Mon, 11 Sep 2023 10:37:58 +0000
Message-ID: <ed0ac0937cdf4bb99b273fc0396b46b9@AcuMS.aculab.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com>
 <27ba3536633c4e43b65f1dcd0a82c0de@AcuMS.aculab.com>
 <CAGudoHHUWZNz0OU5yCqOBkeifSYKhm4y6WO1x+q5pDPt1j3+GA@mail.gmail.com>
 <9a5dd401bf154a0aace0e5f781a3580c@AcuMS.aculab.com>
 <CAGudoHEuY1cMFStdRAjb8aWbHNqy8Pbeavk6tPB+u=rYzFDF+Q@mail.gmail.com>
In-Reply-To: <CAGudoHEuY1cMFStdRAjb8aWbHNqy8Pbeavk6tPB+u=rYzFDF+Q@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: multipart/mixed;
        boundary="_002_ed0ac0937cdf4bb99b273fc0396b46b9AcuMSaculabcom_"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--_002_ed0ac0937cdf4bb99b273fc0396b46b9AcuMSaculabcom_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTWF0ZXVzeiBHdXppaw0KPiBTZW50OiAxMCBTZXB0ZW1iZXIgMjAyMyAxMTo1NA0KPiAN
Cj4gT24gOS8zLzIzLCBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBhY3VsYWIuY29tPiB3cm90
ZToNCj4gPiAuLi4NCj4gPj4gV2hlbiBJIHdhcyBwbGF5aW5nIHdpdGggdGhpcyBzdHVmZiBhYm91
dCA1IHllYXJzIGFnbyBJIGZvdW5kIDMyLWJ5dGUNCj4gPj4gbG9vcHMgdG8gYmUgb3B0aW1hbCBm
b3IgdWFyY2hzIG9mIHRoZSBwcmlvZCAoU2t5bGFrZSwgQnJvYWR3ZWxsLA0KPiA+PiBIYXN3ZWxs
IGFuZCBzbyBvbiksIGJ1dCBvbmx5IHVwIHRvIGEgcG9pbnQgd2hlcmUgcmVwIHdpbnMuDQo+ID4N
Cj4gPiBEb2VzIHRoZSAncmVwIG1vdnNxJyBldmVyIGFjdHVhbGx5IHdpbj8NCj4gPiAoVW5sZXNz
IHlvdSBmaW5kIG9uZSBvZiB0aGUgRU1SUyAob3Igc2ltaWxhcikgdmVyc2lvbnMuKQ0KPiA+IElJ
UkMgaXQgb25seSBldmVyIGRvZXMgb25lIGl0ZXJhdGlvbiBwZXIgY2xvY2sgLSBhbmQgeW91DQo+
ID4gc2hvdWxkIGJlIGFibGUgdG8gbWF0Y2ggdGhhdCB3aXRoIGEgY2FyZWZ1bGx5IGNvbnN0cnVj
dGVkIGxvb3AuDQo+ID4NCj4gDQo+IFNvcnJ5IGZvciBsYXRlIHJlcGx5LCBJIG1pc3NlZCB5b3Vy
IGUtbWFpbCBkdWUgdG8gYWxsIHRoZSB1bnJlbGF0ZWQNCj4gdHJhZmZpYyBpbiB0aGUgdGhyZWFk
IGFuZCB1c2luZyBnbWFpbCBjbGllbnQuIDspDQo+IA0KPiBJIGFtIHNvbWV3aGF0IGNvbmZ1c2Vk
IGJ5IHRoZSBxdWVzdGlvbiB0aG91Z2guIEluIHRoaXMgdmVyeSBwYXRjaCBJJ20NCj4gc2hvd2lu
ZyBudW1iZXJzIGZyb20gYW4gRVJNUy1sZXNzIHVhcmNoIGdldHRpbmcgYSB3aW4gZnJvbSBzd2l0
Y2hpbmcNCj4gZnJvbSBoYW5kLXJvbGxlZCBtb3YgbG9vcCB0byByZXAgbW92c3EsIHdoaWxlIGRv
aW5nIDRLQiBjb3BpZXMuDQoNCkkndmUganVzdCBkb21lIHNvbWUgbWVhc3VyZW1lbnRzIG9uIGFu
IGk3LTc3MDAuDQpUaGF0IGRvZXMgaGF2ZSBFUk1TIChmYXN0ICdyZXAgbW92c2InKSBidXQgc2hv
d3Mgc29tZSBpbnRlcmVzdGluZyBpbmZvLg0KDQpUaGUgb3ZlcmhlYWQgb2YgJ3JlcCBtb3Zicycg
aXMgYWJvdXQgMzYgY2xvY2tzLCAncmVwIG1vdnNxJyBvbmx5IDE2Lg0KKGV4Y2VwdCBpdCBoYXMg
anVzdCBjaGFuZ2VkIGl0cyBtaW5kLi4uKQ0KJ3JlcCBtb3ZzYicgd2lsbCBjb3B5IChhYm91dCkg
MzIgYnl0ZXMvY2xvY2sgcHJvdmlkZWQgdGhlDQpkZXN0aW5hdGlvbiBidWZmZXIgaXMgMzJieXRl
IGFsaWduZWQsIGJ1dCBvbmx5IDE2IGJ5dGVzL2Nsb2NrDQpvdGhlcndpc2UuIFRoZSBzb3VyY2Ug
YnVmZmVyIGFsaWdubWVudCBkb2Vzbid0IHNlZW0gdG8gbWF0dGVyLg0KDQpPbiB0aGlzIHN5c3Rl
bSAncmVwIG1vdnNxJyBzZWVtcyB0byBiZWhhdmUgdGhlIHNhbWUgd2F5Lg0KDQpTbyB0aGF0IGlz
IGZhc3RlciB0aGFuIGFuIGNvcHkgbG9vcCAtIGxpbWl0ZWQgdG8gb25lIHJlZ2lzdGVyDQp3cml0
ZSBwZXIgY2xvY2suDQoNClRlc3QgcHJvZ3JhbSBhdHRhY2hlZC4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==
--_002_ed0ac0937cdf4bb99b273fc0396b46b9AcuMSaculabcom_
Content-Type: text/plain; name=memcpy_perf.c; charset=WINDOWS-1252
Content-Description: memcpy_perf.c
Content-Disposition: attachment; filename="memcpy_perf.c"; size=2972;
	creation-date="Mon, 11 Sep 2023 10:18:55 GMT";
	modification-date="Mon, 11 Sep 2023 10:18:55 GMT"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHVuaXN0ZC5o
PgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxlcnJuby5oPgoKI2luY2x1ZGUgPGxpbnV4
L3BlcmZfZXZlbnQuaD4KI2luY2x1ZGUgPHN5cy9tbWFuLmg+CiNpbmNsdWRlIDxzeXMvc3lzY2Fs
bC5oPgoKc3RhdGljIGludCBpbml0X3BtYyh2b2lkKQp7CglzdGF0aWMgc3RydWN0IHBlcmZfZXZl
bnRfYXR0ciBwZXJmX2F0dHIgPSB7CgkJLnR5cGUgPSBQRVJGX1RZUEVfSEFSRFdBUkUsCgkJLmNv
bmZpZyA9IFBFUkZfQ09VTlRfSFdfQ1BVX0NZQ0xFUywKCQkucGlubmVkID0gMSwKCX07CglzdHJ1
Y3QgcGVyZl9ldmVudF9tbWFwX3BhZ2UgKnBjOwoKCWludCBwZXJmX2ZkOwoJcGVyZl9mZCA9IHN5
c2NhbGwoX19OUl9wZXJmX2V2ZW50X29wZW4sICZwZXJmX2F0dHIsIDAsIC0xLCAtMSwgMCk7Cglp
ZiAocGVyZl9mZCA8IDApIHsKCQlmcHJpbnRmKHN0ZGVyciwgInBlcmZfZXZlbnRfb3BlbiBmYWls
ZWQ6IGVycm5vICVkXG4iLCBlcnJubyk7CgkJZXhpdCgxKTsKCX0KCXBjID0gbW1hcChOVUxMLCA0
MDk2LCBQUk9UX1JFQUQsIE1BUF9TSEFSRUQsIHBlcmZfZmQsIDApOwoJaWYgKHBjID09IE1BUF9G
QUlMRUQpIHsKCQlmcHJpbnRmKHN0ZGVyciwgInBlcmZfZXZlbnQgbW1hcCgpIGZhaWxlZDogZXJy
bm8gJWRcbiIsIGVycm5vKTsKCQlleGl0KDEpOwoJfQoJcmV0dXJuIHBjLT5pbmRleCAtIDE7Cn0K
CnN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHJkcG1jKHVuc2lnbmVkIGludCBjb3VudGVyKQp7
CiAgICAgICAgdW5zaWduZWQgaW50IGxvdywgaGlnaDsKCgkvLyBhc20gdm9sYXRpbGUoInJkdHNj
IiA6ICI9YSIgKGxvdyksICI9ZCIgKGhpZ2gpKTsKCWFzbSB2b2xhdGlsZSgibGZlbmNlIik7Cglh
c20gdm9sYXRpbGUoInJkcG1jIiA6ICI9YSIgKGxvdyksICI9ZCIgKGhpZ2gpIDogImMiIChjb3Vu
dGVyKSk7CgoJLy8gcmV0dXJuIGxvdyBiaXRzLCBjb3VudGVyIG1pZ2h0IHRvIDMyIG9yIDQwIGJp
dHMgd2lkZS4KCXJldHVybiBsb3c7Cn0KCiNpZm5kZWYgTU9ERQojZGVmaW5lIE1PREUgMAojZW5k
aWYKCl9fYXR0cmlidXRlX18oKG5vaW5saW5lKSkKdm9pZCBtZW1jcHlfcGVyZih1bnNpZ25lZCBj
aGFyICpkX2J1ZmYsIGNvbnN0IHVuc2lnbmVkIGNoYXIgKnNfYnVmZiwgdW5zaWduZWQgbG9uZyBs
ZW4pCnsKCiNpZiBNT0RFID09IC0xCi8vICdObyBjb3B5JyBsb29wIGZvciBiYXNlbGluZSBvdmVy
aGVhZAoJYXNtIHZvbGF0aWxlKCIJbm9wXG4iCgkJOiAiKyZEIiAoZF9idWZmKSwgICIrJlMiIChz
X2J1ZmYpLCAgIismYyIgKGxlbikKCQk6IDogIm1lbW9yeSIpOwojZW5kaWYKCiNpZiBNT0RFID09
IDAKLy8gU2ltcGxlICdyZXAgbW92cycgbG9vcAoJYXNtIHZvbGF0aWxlKCIJcmVwIG1vdnNiXG4i
CgkJOiAiKyZEIiAoZF9idWZmKSwgICIrJlMiIChzX2J1ZmYpLCAgIismYyIgKGxlbikKCQk6IDog
Im1lbW9yeSIpOwojZW5kaWYKCiNpZiBNT0RFID09IDEKLy8gU2ltcGxlICdyZXAgbW92cScgbG9v
cAoJbGVuIC89IDg7Cglhc20gdm9sYXRpbGUoIglyZXAgbW92c3FcbiIKCQk6ICIrJkQiIChkX2J1
ZmYpLCAgIismUyIgKHNfYnVmZiksICAiKyZjIiAobGVuKQoJCTogOiAibWVtb3J5Iik7CiNlbmRp
ZgoKfQoKdW5zaWduZWQgY2hhciBzX2J1ZmZbODE5Ml0gX19hdHRyaWJ1dGVfXygoYWxpZ25lZCg0
MDk2KSkpOwp1bnNpZ25lZCBjaGFyIGRfYnVmZls4MTkyICsgMV0gX19hdHRyaWJ1dGVfXygoYWxp
Z25lZCg0MDk2KSkpOwoKI2lmbmRlZiBQQVNTRVMKI2RlZmluZSBQQVNTRVMgNQojZW5kaWYKCiNp
Zm5kZWYgT0ZGU0VUCiNkZWZpbmUgT0ZGU0VUIDAKI2VuZGlmCgppbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpCnsKCXVuc2lnbmVkIGludCB0aWNrOwoJdW5zaWduZWQgaW50IHRpY2tzW1BB
U1NFU107Cgl1bnNpZ25lZCBpbnQgbGVuLCBzX29mZiA9IDAsIGRfb2ZmID0gMDsKCXVuc2lnbmVk
IGludCBpOwoJdW5zaWduZWQgaW50IGlkID0gaW5pdF9wbWMoKTsKCXVuc2lnbmVkIGludCBvZmZz
ZXQgPSBPRkZTRVQ7CgoJbGVuID0gc2l6ZW9mIHNfYnVmZjsKCWZvciAoOzspIHsKCQlzd2l0Y2gg
KGdldG9wdChhcmdjLCBhcmd2LCAibDpzOmQ6bzoiKSkgewoJCWNhc2UgLTE6CgkJCWJyZWFrOwoJ
CWRlZmF1bHQ6CgkJCWV4aXQoMSk7CgkJY2FzZSAnbCc6IGxlbiA9IGF0b2kob3B0YXJnKTsgY29u
dGludWU7CgkJY2FzZSAncyc6IHNfb2ZmID0gYXRvaShvcHRhcmcpOyBjb250aW51ZTsKCQljYXNl
ICdkJzogZF9vZmYgPSBhdG9pKG9wdGFyZyk7IGNvbnRpbnVlOwoJCWNhc2UgJ28nOiBvZmZzZXQg
PSBhdG9pKG9wdGFyZyk7IGNvbnRpbnVlOwoJCX0KCQlicmVhazsKCX0KCglpZiAoc19vZmYgKyBs
ZW4gPiBzaXplb2Ygc19idWZmIHx8IGRfb2ZmICsgbGVuID4gc2l6ZW9mIGRfYnVmZiAtIDEpIHsK
CQlmcHJpbnRmKHN0ZGVyciwgInRvbyBsb25nXG4iKTsKCQlleGl0KDEpOwoJfQoKCWZvciAoaSA9
IDA7IGkgPCBsZW47IGkrKykKCQlzX2J1ZmZbaV0gPSByYW5kKCk7CgoJZm9yIChpID0gMDsgaSA8
IFBBU1NFUzsgaSsrKSB7CgkJdGljayA9IHJkcG1jKGlkKTsKCQltZW1jcHlfcGVyZihkX2J1ZmYg
KyBkX29mZiwgc19idWZmICsgc19vZmYsIGxlbik7CgkJdGlja3NbaV0gPSByZHBtYyhpZCkgLSB0
aWNrOwoJfQoKCXByaW50ZigiICAgdGlja3MgICAgcmF0ZSBtb2RlICVkXG4iLCBNT0RFKTsKCWZv
ciAoaSA9IDA7IGkgPCBQQVNTRVM7IGkrKykKCQlwcmludGYoIiAlN3UgJTd1XG4iLCB0aWNrc1tp
XSwgMTAwICogbGVuIC8gKHRpY2tzW2ldIC0gb2Zmc2V0KSk7CgoJaWYgKG1lbWNtcChkX2J1ZmYg
KyBkX29mZiwgc19idWZmICsgc19vZmYsIGxlbikgfHwgZF9idWZmW2Rfb2ZmICsgbGVuXSkgewoJ
CWZwcmludGYoc3RkZXJyLCAiY29weSBtaXNtYXRjaFxuIik7CgkJZXhpdCgxKTsKCX0KCXJldHVy
biAwOwp9Cgo=
--_002_ed0ac0937cdf4bb99b273fc0396b46b9AcuMSaculabcom_--


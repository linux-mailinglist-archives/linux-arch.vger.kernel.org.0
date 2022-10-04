Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58DF5F40A9
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 12:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiJDKSH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJDKSF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 06:18:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ED92C663
        for <linux-arch@vger.kernel.org>; Tue,  4 Oct 2022 03:18:03 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-234-vpaXn1vgMYacXBGVntZ1PA-1; Tue, 04 Oct 2022 11:18:00 +0100
X-MC-Unique: vpaXn1vgMYacXBGVntZ1PA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Tue, 4 Oct
 2022 11:17:57 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Tue, 4 Oct 2022 11:17:57 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Dave Hansen' <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, "Jann Horn" <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "joao.moreira@intel.com" <joao.moreira@intel.com>,
        John Allen <john.allen@amd.com>,
        "kcc@google.com" <kcc@google.com>,
        "eranian@google.com" <eranian@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: RE: [PATCH v2 24/39] x86/cet/shstk: Add user-mode shadow stack
 support
Thread-Topic: [PATCH v2 24/39] x86/cet/shstk: Add user-mode shadow stack
 support
Thread-Index: AQHY12Njz3/HZpf9jkaO+WwIiUYgJ63+BXng
Date:   Tue, 4 Oct 2022 10:17:57 +0000
Message-ID: <4b9c6208d1174c27a795cef487eb97b5@AcuMS.aculab.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-25-rick.p.edgecombe@intel.com>
 <202210031203.EB0DC0B7DD@keescook>
 <474d3aca-0cf0-8962-432b-77ac914cc563@intel.com>
In-Reply-To: <474d3aca-0cf0-8962-432b-77ac914cc563@intel.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogRGF2ZSBIYW5zZW4NCj4gU2VudDogMDMgT2N0b2JlciAyMDIyIDIxOjA1DQo+IA0KPiBP
biAxMC8zLzIyIDEyOjQzLCBLZWVzIENvb2sgd3JvdGU6DQo+ID4+ICtzdGF0aWMgaW5saW5lIHZv
aWQgc2V0X2Nscl9iaXRzX21zcmwodTMyIG1zciwgdTY0IHNldCwgdTY0IGNsZWFyKQ0KPiA+PiAr
ew0KPiA+PiArCXU2NCB2YWwsIG5ld192YWw7DQo+ID4+ICsNCj4gPj4gKwlyZG1zcmwobXNyLCB2
YWwpOw0KPiA+PiArCW5ld192YWwgPSAodmFsICYgfmNsZWFyKSB8IHNldDsNCj4gPj4gKw0KPiA+
PiArCWlmIChuZXdfdmFsICE9IHZhbCkNCj4gPj4gKwkJd3Jtc3JsKG1zciwgbmV3X3ZhbCk7DQo+
ID4+ICt9DQo+ID4gSSBhbHdheXMgZ2V0IHVuY29tZm9ydGFibGUgd2hlbiBJIHNlZSB0aGVzZSBr
aW5kcyBvZiBnZW5lcmFsaXplZCBoZWxwZXINCj4gPiBmdW5jdGlvbnMgZm9yIHRvdWNoaW5nIGNw
dSBiaXRzLCBldGMuIEl0IGp1c3QgYmVncyBmb3IgZnV0dXJlIGF0dGFja2VyDQo+ID4gYWJ1c2Ug
dG8gbXVjayB3aXRoIGFyYml0cmFyeSBiaXRzIC0tIGV2ZW4gbWFya2VkIGlubGluZSB0aGVyZSBp
cyBhIHJpc2sNCj4gPiB0aGUgY29tcGlsZXIgd2lsbCBpZ25vcmUgdGhhdCBpbiBzb21lIGNpcmN1
bXN0YW5jZXMgKG5vdCBhcyBjdXJyZW50bHkNCj4gPiB1c2VkIGluIHRoZSBjb2RlLCBidXQgSSdt
IGltYWdpbmluZyBmdXR1cmUgY2hhbmdlcyBsZWFkaW5nIHRvIHN1Y2ggYQ0KPiA+IGNvbmRpdGlv
bikuIFdpbGwgeW91IGh1bW9yIG1lIGFuZCBjaGFuZ2UgdGhpcyB0byBhIG1hY3JvIGluc3RlYWQ/
IFRoYXQnbGwNCj4gPiBmb3JjZSBpdCBhbHdheXMgaW5saW5lIChldmVuIF9fYWx3YXlzX2lubGlu
ZSBpc24ndCBhbHdheXMgaW5saW5lKToNCj4gDQo+IE9oLCBhcmUgeW91IHRoaW5raW5nIHRoYXQg
dGhpcyBpcyBkYW5nZXJvdXMgYmVjYXVzZSBpdCdzIHNvIHN1cmdpY2FsIGFuZA0KPiBub24taW50
cnVzaXZlPyAgSXQncyBldmVuIG1vcmUgcG93ZXJmdWwgdG8gYW4gYXR0YWNrZXIgdGhhbiwgc2F5
DQo+IHdybXNybCgpLCBiZWNhdXNlIHRoZXJlIHRoZXkgYWN0dWFsbHkgaGF2ZSB0byBrbm93IHdo
YXQgdGhlIGV4aXN0aW5nDQo+IHZhbHVlIGlzIHRvIHVwZGF0ZSBpdC4gIFdpdGggdGhpcyBoZWxw
ZXIsIGl0J3MgcXVpdGUgZWFzeSB0byBmbGlwIGFuDQo+IGluZGl2aWR1YWwgYml0IHdpdGhvdXQg
ZGlzdHVyYmluZyB0aGUgbmVpZ2hib3JpbmcgYml0cy4NCj4gDQo+IElzIHRoYXQgaXQ/DQo+IA0K
PiBJIGRvbid0IF9saWtlXyB0aGUgI2RlZmluZXMsIGJ1dCBkb2luZyBvbmUgaGVyZSBkb2Vzbid0
IHNlZW0gdG9vIG9uZXJvdXMNCj4gY29uc2lkZXJpbmcgaG93IGNyaXRpY2FsIE1TUnMgYXJlLg0K
DQpIb3cgb2Z0ZW4gaXMgdGhlICdtc3InIG51bWJlciBub3QgYSBjb21waWxlLXRpbWUgY29uc3Rh
bnQ/DQpBZGRpbmcgcmQvd3Jtc3IgdmFyaWFudHMgdGhhdCB2ZXJpZnkgdGhpcyB3b3VsZCByZWR1
Y2UgdGhlDQphdHRhY2sgc3VyZmFjZSBhcyB3ZWxsLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


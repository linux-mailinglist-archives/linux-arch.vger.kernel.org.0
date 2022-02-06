Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4BD4AAF8F
	for <lists+linux-arch@lfdr.de>; Sun,  6 Feb 2022 14:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbiBFNtS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Feb 2022 08:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbiBFNtN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Feb 2022 08:49:13 -0500
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 05:49:07 PST
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C94D7C043182
        for <linux-arch@vger.kernel.org>; Sun,  6 Feb 2022 05:49:07 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-2-UlNFSu5EPwWiWKwZdJvkSg-1; Sun, 06 Feb 2022 13:42:45 +0000
X-MC-Unique: UlNFSu5EPwWiWKwZdJvkSg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Sun, 6 Feb 2022 13:42:42 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Sun, 6 Feb 2022 13:42:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Edgecombe, Rick P'" <rick.p.edgecombe@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: RE: [PATCH 00/35] Shadow stacks for userspace
Thread-Topic: [PATCH 00/35] Shadow stacks for userspace
Thread-Index: AQHYFh9orVaVUe6rNECZu4edjJzhZqyCV/wAgABDLwCAAl19kIAABAWAgABxL4CAARiJ8A==
Date:   Sun, 6 Feb 2022 13:42:42 +0000
Message-ID: <782f27dbe6fc419a8946eeb426253e28@AcuMS.aculab.com>
References: <87fsozek0j.ffs@tglx>
         <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
         <3421da7fc8474b6db0e265b20ffd28d0@AcuMS.aculab.com>
         <CAMe9rOonepEiRyoAyTGkDMQQhuyuoP4iTZJJhKGxgnq9vv=dLQ@mail.gmail.com>
 <9f948745435c4c9273131146d50fe6f328b91a78.camel@intel.com>
In-Reply-To: <9f948745435c4c9273131146d50fe6f328b91a78.camel@intel.com>
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
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

RnJvbTogRWRnZWNvbWJlLCBSaWNrIFANCj4gU2VudDogMDUgRmVicnVhcnkgMjAyMiAyMDoxNQ0K
PiANCj4gT24gU2F0LCAyMDIyLTAyLTA1IGF0IDA1OjI5IC0wODAwLCBILkouIEx1IHdyb3RlOg0K
PiA+IE9uIFNhdCwgRmViIDUsIDIwMjIgYXQgNToyNyBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEZyb206IEVkZ2Vjb21i
ZSwgUmljayBQDQo+ID4gPiA+IFNlbnQ6IDA0IEZlYnJ1YXJ5IDIwMjIgMDE6MDgNCj4gPiA+ID4g
SGkgVGhvbWFzLA0KPiA+ID4gPg0KPiA+ID4gPiBUaGFua3MgZm9yIGZlZWRiYWNrIG9uIHRoZSBw
bGFuLg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBUaHUsIDIwMjItMDItMDMgYXQgMjI6MDcgKzAxMDAs
IFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gPiA+ID4gPiA+IFVudGlsIG5vdywgdGhlIGVuYWJs
aW5nIGVmZm9ydCB3YXMgdHJ5aW5nIHRvIHN1cHBvcnQgYm90aA0KPiA+ID4gPiA+ID4gU2hhZG93
DQo+ID4gPiA+ID4gPiBTdGFjayBhbmQgSUJULg0KPiA+ID4gPiA+ID4gVGhpcyBoaXN0b3J5IHdp
bGwgZm9jdXMgb24gYSBmZXcgYXJlYXMgb2YgdGhlIHNoYWRvdyBzdGFjaw0KPiA+ID4gPiA+ID4g
ZGV2ZWxvcG1lbnQgaGlzdG9yeQ0KPiA+ID4gPiA+ID4gdGhhdCBJIHRob3VnaHQgc3Rvb2Qgb3V0
Lg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICAgICBTaWduYWxzDQo+ID4gPiA+ID4gPiAg
ICAgICAgLS0tLS0tLQ0KPiA+ID4gPiA+ID4gICAgICAgIE9yaWdpbmFsbHkgc2lnbmFscyBwbGFj
ZWQgdGhlIGxvY2F0aW9uIG9mIHRoZSBzaGFkb3cNCj4gPiA+ID4gPiA+IHN0YWNrDQo+ID4gPiA+
ID4gPiByZXN0b3JlDQo+ID4gPiA+ID4gPiAgICAgICAgdG9rZW4gaW5zaWRlIHRoZSBzYXZlZCBz
dGF0ZSBvbiB0aGUgc3RhY2suIFRoaXMgd2FzDQo+ID4gPiA+ID4gPiBwcm9ibGVtYXRpYyBmcm9t
IGENCj4gPiA+ID4gPiA+ICAgICAgICBwYXN0IEFCSSBwcm9taXNlcyBwZXJzcGVjdGl2ZS4gU28g
dGhlIHJlc3RvcmUgbG9jYXRpb24NCj4gPiA+ID4gPiA+IHdhcw0KPiA+ID4gPiA+ID4gaW5zdGVh
ZCBqdXN0DQo+ID4gPiA+ID4gPiAgICAgICAgYXNzdW1lZCBmcm9tIHRoZSBzaGFkb3cgc3RhY2sg
cG9pbnRlci4gVGhpcyB3b3Jrcw0KPiA+ID4gPiA+ID4gYmVjYXVzZSBpbg0KPiA+ID4gPiA+ID4g
bm9ybWFsDQo+ID4gPiA+ID4gPiAgICAgICAgYWxsb3dlZCBjYXNlcyBvZiBjYWxsaW5nIHNpZ3Jl
dHVybiwgdGhlIHNoYWRvdyBzdGFjaw0KPiA+ID4gPiA+ID4gcG9pbnRlcg0KPiA+ID4gPiA+ID4g
c2hvdWxkIGJlDQo+ID4gPiA+ID4gPiAgICAgICAgcmlnaHQgYXQgdGhlIHJlc3RvcmUgdG9rZW4g
YXQgdGhhdCB0aW1lLiBUaGVyZSBpcyBubw0KPiA+ID4gPiA+ID4gYWx0ZXJuYXRlIHNoYWRvdw0K
PiA+ID4gPiA+ID4gICAgICAgIHN0YWNrIHN1cHBvcnQuIElmIGFuIGFsdCBzaGFkb3cgc3RhY2sg
aXMgYWRkZWQgbGF0ZXINCj4gPiA+ID4gPiA+IHdlDQo+ID4gPiA+ID4gPiB3b3VsZA0KPiA+ID4g
PiA+ID4gICAgICAgIG5lZWQgdG8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNvIGhvdyBpcyB0aGF0
IGdvaW5nIHRvIHdvcms/IGFsdHN0YWNrIGlzIG5vdCBhbiBlc290ZXJpYw0KPiA+ID4gPiA+IGNv
cm5lcg0KPiA+ID4gPiA+IGNhc2UuDQo+ID4gPiA+DQo+ID4gPiA+IE15IHVuZGVyc3RhbmRpbmcg
aXMgdGhhdCB0aGUgbWFpbiB1c2FnZXMgZm9yIHRoZSBzaWduYWwgc3RhY2sNCj4gPiA+ID4gd2Vy
ZQ0KPiA+ID4gPiBoYW5kbGluZyBzdGFjayBvdmVyZmxvd3MgYW5kIGNvcnJ1cHRpb24uIFNpbmNl
IHRoZSBzaGFkb3cgc3RhY2sNCj4gPiA+ID4gb25seQ0KPiA+ID4gPiBjb250YWlucyByZXR1cm4g
YWRkcmVzc2VzIHJhdGhlciB0aGFuIGxhcmdlIHN0YWNrIGFsbG9jYXRpb25zLA0KPiA+ID4gPiBh
bmQgaXMNCj4gPiA+ID4gbm90IGdlbmVyYWxseSB3cml0YWJsZSBvciBwaXZvdGFibGUsIEkgdGhv
dWdodCB0aGVyZSB3YXMgYSBnb29kDQo+ID4gPiA+IHBvc3NpYmlsaXR5IGFuIGFsdCBzaGFkb3cg
c3RhY2sgd291bGQgbm90IGVuZCB1cCBiZWluZyBlc3BlY2lhbGx5DQo+ID4gPiA+IHVzZWZ1bC4g
RG9lcyBpdCBzZWVtIGxpa2UgcmVhc29uYWJsZSBndWVzc3dvcms/DQo+ID4gPg0KPiA+ID4gVGhl
IG90aGVyICdwcm9ibGVtJyBpcyB0aGF0IGl0IGlzIHZhbGlkIHRvIGxvbmdqdW1wIG91dCBvZiBh
IHNpZ25hbA0KPiA+ID4gaGFuZGxlci4NCj4gPiA+IFRoZXNlIGRheXMgeW91IGhhdmUgdG8gdXNl
IHNpZ2xvbmdqbXAoKSBub3QgbG9uZ2ptcCgpIGJ1dCBpdCBpcw0KPiA+ID4gc3RpbGwgdXNlZC4N
Cj4gPiA+DQo+ID4gPiBJdCBpcyBwcm9iYWJseSBhbHNvIHZhbGlkIHRvIHVzZSBzaWdsb25nam1w
KCkgdG8ganVtcCBmcm9tIGEgbmVzdGVkDQo+ID4gPiBzaWduYWwgaGFuZGxlciBpbnRvIHRoZSBv
dXRlciBoYW5kbGVyLg0KPiA+ID4gR2l2ZW4gYm90aCBzaWduYWwgaGFuZGxlcnMgY2FuIGhhdmUg
dGhlaXIgb3duIHN0YWNrLCB0aGVyZSBjYW4gYmUNCj4gPiA+IHRocmVlDQo+ID4gPiBzdGFja3Mg
aW52b2x2ZWQuDQo+IA0KPiBTbyB0aGUgc2NlbmFyaW8gaXM/DQo+IA0KPiAxLiBIYW5kbGUgc2ln
bmFsIDENCj4gMi4gc2lnc2V0am1wKCkNCj4gMy4gc2lnbmFsc3RhY2soKQ0KPiA0LiBIYW5kbGUg
c2lnbmFsIDIgb24gYWx0IHN0YWNrDQo+IDUuIHNpZ2xvbmdqbXAoKQ0KPiANCj4gSSdsbCBjaGVj
ayB0aGF0IGl0IGlzIGNvdmVyZWQgYnkgdGhlIHRlc3RzLCBidXQgSSB0aGluayBpdCBzaG91bGQg
d29yaw0KPiBpbiB0aGlzIHNlcmllcyB0aGF0IGhhcyBubyBhbHQgc2hhZG93IHN0YWNrLiBJIGhh
dmUgb25seSBkb25lIGEgaGlnaA0KPiBsZXZlbCBvdmVydmlldyBvZiBob3cgdGhlIHNoYWRvdyBz
dGFjayBzdHVmZiwgdGhhdCBkb2Vzbid0IGludm9sdmUgdGhlDQo+IGtlcm5lbCwgd29ya3MgaW4g
Z2xpYmMuIFNvdW5kcyBsaWtlIEknbGwgbmVlZCB0byBkbyBhIGRlZXBlciBkaXZlLg0KDQpUaGUg
cG9zaXgveG9wZW4gZGVmaW5pdGlvbiBmb3Igc2V0am1wL2xvbmdqbXAgZG9lc24ndCByZXF1aXJl
IHN1Y2gNCmxvbmdqbXAgcmVxdWVzdHMgdG8gd29yay4NCg0KQWx0aG91Z2ggdGhleSBzdGlsbCBo
YXZlIHRvIGRvIHNvbWV0aGluZyB0aGF0IGRvZXNuJ3QgYnJlYWsgYmFkbHkuDQpBYm9ydGluZyB0
aGUgcHJvY2VzcyBpcyBwcm9iYWJseSBmaW5lIQ0KDQo+ID4gPiBJIHRoaW5rIHRoZSBzaGFkb3cg
c3RhY2sgcG9pbnRlciBoYXMgdG8gYmUgaW4gdWNvbnRleHQgLSB3aGljaCBhbHNvDQo+ID4gPiBt
ZWFucyB0aGUgYXBwbGljYXRpb24gY2FuIGNoYW5nZSBpdCBiZWZvcmUgcmV0dXJuaW5nIGZyb20g
YSBzaWduYWwuDQo+IA0KPiBZZXMgd2UgbWlnaHQgbmVlZCB0byBjaGFuZ2UgaXQgdG8gc3VwcG9y
dCBhbHQgc2hhZG93IHN0YWNrcy4gQ2FuIHlvdQ0KPiBlbGFib3JhdGUgd2h5IHlvdSB0aGluayBp
dCBoYXMgdG8gYmUgaW4gdWNvbnRleHQ/IEkgd2FzIHRoaW5raW5nIG9mDQo+IGxvb2tpbmcgYXQg
dGhyZWUgb3B0aW9ucyBmb3Igc3RvcmluZyB0aGUgc3NwOg0KPiAgLSBTdG9yZWQgaW4gdGhlIHNo
YWRvdyBzdGFjayBsaWtlIGEgdG9rZW4gdXNpbmcgV1JVU1MgZnJvbSB0aGUga2VybmVsLg0KPiAg
LSBTdG9yZWQgb24gdGhlIGtlcm5lbCBzaWRlIHVzaW5nIGEgaGFzaG1hcCB0aGF0IG1hcHMgdWNv
bnRleHQgb3INCj4gICAgc2lnZnJhbWUgdXNlcnNwYWNlIGFkZHJlc3MgdG8gc3NwICh0aGlzIGlz
IG9mIGNvdXJzZSBzaW1pbGFyIHRvDQo+ICAgIHN0b3JpbmcgaW4gdWNvbnRleHQsIGV4Y2VwdCB0
aGF0IHRoZSB1c2VyIGNhbuKAmXQgY2hhbmdlIHRoZSBzc3ApLg0KPiAgLSBTdG9yZWQgd3JpdGFi
bGUgaW4gdXNlcnNwYWNlIGluIHVjb250ZXh0Lg0KPiANCj4gQnV0IGluIHRoaXMgdmVyc2lvbiwg
d2l0aG91dCBhbHQgc2hhZG93IHN0YWNrcywgdGhlIHNoYWRvdyBzdGFjaw0KPiBwb2ludGVyIGlz
IG5vdCBzdG9yZWQgaW4gdWNvbnRleHQuIFRoaXMgY2F1c2VzIHRoZSBsaW1pdGF0aW9uIHRoYXQN
Cj4gdXNlcnNwYWNlIGNhbiBvbmx5IGNhbGwgc2lncmV0dXJuIHdoZW4gaXQgaGFzIHJldHVybmVk
IGJhY2sgdG8gYSBwb2ludA0KPiB3aGVyZSB0aGVyZSBpcyBhIHJlc3RvcmUgdG9rZW4gb24gdGhl
IHNoYWRvdyBzdGFjayAod2hpY2ggd2FzIHBsYWNlZA0KPiB0aGVyZSBieSB0aGUga2VybmVsKS4g
VGhpcyBkb2VzbuKAmXQgbWVhbiBpdCBjYW7igJl0IHN3aXRjaCB0byBhIGRpZmZlcmVudA0KPiBz
aGFkb3cgc3RhY2sgb3IgaGFuZGxlIGEgbmVzdGVkIHNpZ25hbCwgYnV0IGl0IGxpbWl0cyB0aGUg
cG9zc2liaWxpdHkNCj4gZm9yIGNhbGxpbmcgc2lncmV0dXJuIHdpdGggYSB0b3RhbGx5IGRpZmZl
cmVudCBzaWdmcmFtZSAobGlrZSBDUklVIGFuZA0KPiBTUk9QIGF0dGFja3MgZG8pLiBJdCBzaG91
bGQgaG9wZWZ1bGx5IGJlIGEgaGVscGZ1bCwgcHJvdGVjdGl2ZQ0KPiBsaW1pdGF0aW9uIGZvciBt
b3N0IGFwcHMgYW5kIEknbSBob3BpbmcgQ1JJVSBjYW4gYmUgZml4ZWQgd2l0aG91dA0KPiByZW1v
dmluZyBpdC4NCj4gDQo+IEkgYW0gbm90IGF3YXJlIG9mIG90aGVyIGxpbWl0YXRpb25zIHRvIHNp
Z25hbHMgKGJlc2lkZXMgbm9ybWFsIHNoYWRvdw0KPiBzdGFjayBlbmZvcmNlbWVudCksIGJ1dCBJ
IGNvdWxkIGJlIG1pc3NpbmcgaXQuIEFuZCBwZW9wbGUncyBza2VwdGljaXNtDQo+IGlzIG1ha2lu
ZyBtZSB3YW50IHRvIGdvIGJhY2sgb3ZlciBpdCB3aXRoIG1vcmUgc2NydXRpbnkuDQo+IA0KPiA+
ID4gSW4gbXVjaCB0aGUgc2FtZSB3YXkgYXMgYWxsIHRoZSBzZWdtZW50IHJlZ2lzdGVycyBjYW4g
YmUgY2hhbmdlZA0KPiA+ID4gbGVhZGluZyB0byBhbGwgdGhlIG5hc3R5IGJ1Z3Mgd2hlbiB0aGUg
ZmluYWwgJ3JldHVybiB0byB1c2VyJyBjb2RlDQo+ID4gPiB0cmFwcyBpbiBrZXJuZWwgd2hlbiBs
b2FkaW5nIGludmFsaWQgc2VnbWVudCByZWdpc3RlcnMgb3IgZXhlY3V0aW5nDQo+ID4gPiBpcmV0
Lg0KPiANCj4gSSBkb24ndCB0aGluayB0aGlzIGlzIGFzIGRpZmZpY3VsdCB0byBhdm9pZCBiZWNh
dXNlIHVzZXJzcGFjZSBzc3AgaGFzDQo+IGl0cyBvd24gcmVnaXN0ZXIgdGhhdCBzaG91bGQgbm90
IGJlIGFjY2Vzc2VkIGF0IHRoYXQgcG9pbnQsIGJ1dCBJIGhhdmUNCj4gbm90IGdpdmVuIHRoaXMg
YXNwZWN0IGVub3VnaCBhbmFseXNpcy4gVGhhbmtzIGZvciBicmluZ2luZyBpdCB1cC4NCg0KU28g
dGhlIHVzZXIgc3NwIGlzbid0IHNhdmVkIChvciByZXN0b3JlZCkgYnkgdGhlIHRyYXAgZW50cnkv
ZXhpdC4NClNvIGl0IG5lZWRzIHRvIGJlIHNhdmVkIGJ5IHRoZSBjb250ZXh0IHN3aXRjaCBjb2Rl
Pw0KTXVjaCBsaWtlIHRoZSB1c2VyIHNlZ21lbnQgcmVnaXN0ZXJzPw0KU28geW91IGFyZSBsaWtl
bHkgdG8gZ2V0IHRoZSBzYW1lIHByb2JsZW1zIGlmIHJlc3RvcmluZyBpdCBjYW4gZmF1bHQNCmlu
IGtlcm5lbCAoZWcgZm9yIGEgbm9uLWNhbm9uaWNhbCBhZGRyZXNzKS4NCg0KPiA+ID4gSG1tbS4u
LiBkbyBzaGFkb3cgc3RhY2tzIG1lYW4gdGhhdCBsb25nam1wKCkgaGFzIHRvIGJlIGEgc3lzdGVt
DQo+ID4gPiBjYWxsPw0KPiA+DQo+ID4gTm8uICBzZXRqbXAvbG9uZ2ptcCBzYXZlIGFuZCByZXN0
b3JlIHNoYWRvdyBzdGFjayBwb2ludGVyLg0KDQpPaywgSSB3YXMgdGhpbmtpbmcgdGhhdCBkaXJl
Y3QgYWNjZXNzIHRvIHRoZSB1c2VyIHNzcCB3b3VsZCBiZQ0KYSBwcml2aWxlZ2VkIG9wZXJhdGlv
bi4NCklmIGl0IGNhbiBiZSB3cml0dGVuIHlvdSBkb24ndCByZWFsbHkgaGF2ZSB0byB3b3JyeSBh
Ym91dCB3aGF0IGNvZGUNCmlzIHRyeWluZyB0byBkbyAtIGl0IGNhbiBhY3R1YWxseSBkbyB3aGF0
IGl0IGxpa2VzLg0KSXQganVzdCBjYXRjaGVzIHVuaW50ZW50aW9uYWwgb3BlcmF0aW9ucyAobGlr
ZSBidWZmZXIgb3ZlcmZsb3dzKS4NCg0KV2FzIHRoZXJlIGFueSAnc3BhcmUnIHNwYWNlIGluIHN0
cnVjdCBqbXBidWYgPw0KT3RoZXJ3aXNlIHlvdSBjYW4gb25seSBlbmFibGUgc2hhZG93IHN0YWNr
cyBpZiBldmVyeXRoaW5nIGhhcyBiZWVuDQpyZWNvbXBpbGVkIC0gaW5jbHVkaW5nIGFueSBzaGFy
ZWQgbGlicmFyaWVzIHRoZSBtaWdodCBiZSBkbG9wZW4oKWVkLg0KKG9yIGRvZXMgdGhlIGNvbXBp
bGVyIGludmVudCBhbiBhbGxvY2EoKSBjYWxsIHNvbWVob3cgZm9yIGENCnNpemUgdGhhdCBjb21l
cyBiYWNrIGZyb20gZ2xpYmM/KQ0KDQpJJ3ZlIG5ldmVyIHJlYWxseSBjb25zaWRlcmVkIGhvdyBz
ZXRqbXAvbG9uZ2ptcCBoYW5kbGUgY2FsbGVlIHNhdmVkDQpyZWdpc3RlciB2YXJpYWJsZXMgKGFw
YXJ0IGZyb20gaXQgYmVpbmcgaGFyZCkuDQpUaGUgb3JpZ2luYWwgcGRwMTEgaW1wbGVtZW50YXRp
b24gcHJvYmFibHkgb25seSBuZWVkZWQgdG8gc2F2ZSByNiBhbmQgcjcuDQoNCldoYXQgZG9lcyBo
YXBwZW4gdG8gYWxsIHRoZSAnZXh0ZW5kZWQgc3RhdGUnIHRoYXQgWFNBVkUgaGFuZGxlcz8NCklJ
UkMgYWxsIHRoZSBBVlggcmVnaXN0ZXJzIGFyZSBjYWxsZXIgc2F2ZWQgKHNvIHNob3VsZCBwcm9i
YWJseQ0KYmUgemVyb2QpLCBidXQgc29tZSBvZiB0aGUgU1NFIG9uZXMgYXJlIGNhbGxlZSBzYXZl
ZCwgYW5kIG9uZSBvcg0KdHdvIG9mIHRoZSBmcHUgZmxhZ3MgYXJlIHN0aWNreSBhbmQgYW5ub3lp
bmcgZW5vdWdoIHRoZSBzYXZlL3Jlc3RvcmUNCmF0IHRoZSBiZXN0IG9mIHRpbWVzLg0KDQo+IEl0
IHNvdW5kcyBsaWtlIGl0IHdvdWxkIGhlbHAgdG8gd3JpdGUgdXAgaW4gYSBsb3QgbW9yZSBkZXRh
aWwgZXhhY3RseQ0KPiBob3cgYWxsIHRoZSBzaWduYWwgYW5kIHNwZWNpYWxlciBzdGFjayBtYW5p
cHVsYXRpb24gc2NlbmFyaW9zIHdvcmsgaW4NCj4gZ2xpYmMuDQoNClNvbWUgY3Jvc3MgcmVmZXJl
bmNlcyBtaWdodCBoYXZlIG1hZGUgcGVvcGxlIG5vdGljZSB0aGF0IHRoZSB1Y29udGV4dA0KZXh0
ZW5zaW9ucyBmb3IgQVZYNTEyIChpZiBub3QgZWFybGllciBvbmVzKSBicm9rZSB0aGUgbWluaW1h
bC9kZWZhdWx0DQpzaWduYWwgc3RhY2sgc2l6ZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


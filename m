Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC3048B2E8
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 18:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238538AbiAKRIl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 12:08:41 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:26353 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233747AbiAKRIl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Jan 2022 12:08:41 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-219-tzai68rZMR-Hpy3XsG8n2Q-1; Tue, 11 Jan 2022 17:08:39 +0000
X-MC-Unique: tzai68rZMR-Hpy3XsG8n2Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Tue, 11 Jan 2022 17:08:38 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Tue, 11 Jan 2022 17:08:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>
CC:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: RE: [ANNOUNCE] "Fast Kernel Headers" Tree -v2
Thread-Topic: [ANNOUNCE] "Fast Kernel Headers" Tree -v2
Thread-Index: AQHYBweW0OrsoDgxJUCiqDDZHkb62KxeDSCg
Date:   Tue, 11 Jan 2022 17:08:37 +0000
Message-ID: <01788b4c521e4e018b9bee9b54384bde@AcuMS.aculab.com>
References: <Ydm7ReZWQPrbIugn@gmail.com>
 <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
 <CAK8P3a3SpYe101RSFD5rzbTQNyQyfG1eb1sCY+rBO-DKVqBdBw@mail.gmail.com>
In-Reply-To: <CAK8P3a3SpYe101RSFD5rzbTQNyQyfG1eb1sCY+rBO-DKVqBdBw@mail.gmail.com>
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

UmVsYXRlZDoNCg0KSWYgSSByZWRlZmluZSBfSU9XIEkgZ2V0IHRoaXMgc3BsYXQ6DQpJbiBmaWxl
IGluY2x1ZGVkIGZyb20gLi4vaW5jbHVkZS9hc20tZ2VuZXJpYy9pb2N0bC5oOjU6MCwNCiAgICAg
ICAgICAgICAgICAgZnJvbSAuL2FyY2gveDg2L2luY2x1ZGUvZ2VuZXJhdGVkL3VhcGkvYXNtL2lv
Y3RsLmg6MSwNCiAgICAgICAgICAgICAgICAgZnJvbSAuLi9pbmNsdWRlL3VhcGkvbGludXgvaW9j
dGwuaDo1LA0KICAgICAgICAgICAgICAgICBmcm9tIC4uL2luY2x1ZGUvdWFwaS9saW51eC9hcG1f
Ymlvcy5oOjEzMywNCiAgICAgICAgICAgICAgICAgZnJvbSAuLi9pbmNsdWRlL2xpbnV4L2FwbV9i
aW9zLmg6OSwNCiAgICAgICAgICAgICAgICAgZnJvbSAuLi9hcmNoL3g4Ni9pbmNsdWRlL3VhcGkv
YXNtL2Jvb3RwYXJhbS5oOjQ0LA0KICAgICAgICAgICAgICAgICBmcm9tIC4uL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL21lbV9lbmNyeXB0Lmg6MTgsDQogICAgICAgICAgICAgICAgIGZyb20gLi4vaW5j
bHVkZS9saW51eC9tZW1fZW5jcnlwdC5oOjE3LA0KICAgICAgICAgICAgICAgICBmcm9tIC4uL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3BhZ2VfdHlwZXMuaDo3LA0KICAgICAgICAgICAgICAgICBmcm9t
IC4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BhZ2UuaDo5LA0KICAgICAgICAgICAgICAgICBmcm9t
IC4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmg6MTIsDQogICAgICAgICAgICAg
ICAgIGZyb20gLi4vaW5jbHVkZS9saW51eC90aHJlYWRfaW5mby5oOjYwLA0KICAgICAgICAgICAg
ICAgICBmcm9tIC4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ByZWVtcHQuaDo3LA0KICAgICAgICAg
ICAgICAgICBmcm9tIC4uL2luY2x1ZGUvbGludXgvcHJlZW1wdC5oOjc4LA0KICAgICAgICAgICAg
ICAgICBmcm9tIC4uL2luY2x1ZGUvbGludXgvc21wLmg6MTEwLA0KICAgICAgICAgICAgICAgICBm
cm9tIC4uL2luY2x1ZGUvbGludXgvbG9ja2RlcC5oOjE0LA0KICAgICAgICAgICAgICAgICBmcm9t
IC4uL2luY2x1ZGUvbGludXgvbXV0ZXguaDoxNywNCiAgICAgICAgICAgICAgICAgZnJvbSAuLi9p
bmNsdWRlL2xpbnV4L2tlcm5mcy5oOjEyLA0KICAgICAgICAgICAgICAgICBmcm9tIC4uL2luY2x1
ZGUvbGludXgvc3lzZnMuaDoxNiwNCiAgICAgICAgICAgICAgICAgZnJvbSAuLi9pbmNsdWRlL2xp
bnV4L2tvYmplY3QuaDoyMCwNCiAgICAgICAgICAgICAgICAgZnJvbSAuLi9pbmNsdWRlL2xpbnV4
L2NkZXYuaDo1LA0KDQpJIGNhbid0IGhlbHAgZmVlbGluZyB0aGF0IGluY2x1ZGUgY2hhaW4gaXMg
c3ViLW9wdGltYWwuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


Return-Path: <linux-arch+bounces-1103-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC43816155
	for <lists+linux-arch@lfdr.de>; Sun, 17 Dec 2023 18:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6238A1C209B3
	for <lists+linux-arch@lfdr.de>; Sun, 17 Dec 2023 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B5C4653C;
	Sun, 17 Dec 2023 17:40:43 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E544C9A
	for <linux-arch@vger.kernel.org>; Sun, 17 Dec 2023 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-7-Jk6djIywNsumAmg5dYKSIA-1; Sun, 17 Dec 2023 17:40:38 +0000
X-MC-Unique: Jk6djIywNsumAmg5dYKSIA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Dec
 2023 17:40:19 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Dec 2023 17:40:19 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Steven Rostedt
	<rostedt@goodmis.org>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux Trace Kernel
	<linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>
Subject: RE: [PATCH] ring-buffer: Remove 32bit timestamp logic
Thread-Topic: [PATCH] ring-buffer: Remove 32bit timestamp logic
Thread-Index: AQHaLs9iaE2zzzBpbUiUb4MLlBIx7bCtvF7A
Date: Sun, 17 Dec 2023 17:40:19 +0000
Message-ID: <d3e5ab37839047a483212c8b3fc667e5@AcuMS.aculab.com>
References: <20231213211126.24f8c1dd@gandalf.local.home>
 <20231213214632.15047c40@gandalf.local.home>
 <CAHk-=whESMW2v0cd0Ye+AnV0Hp9j+Mm4BO2xJo93eQcC1xghUA@mail.gmail.com>
 <20231214115614.2cf5a40e@gandalf.local.home>
 <CAHk-=wjjGEc0f4LLDxCTYvgD98kWqKy=89u=42JLRz5Qs3KKyA@mail.gmail.com>
 <20231214153636.655e18ce@gandalf.local.home>
 <CAHk-=wieVSfyjTpe8L5kmwC4mk9dRge9dvyJiMZEkyz4-tOvow@mail.gmail.com>
In-Reply-To: <CAHk-=wieVSfyjTpe8L5kmwC4mk9dRge9dvyJiMZEkyz4-tOvow@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

Li4uDQo+IE15IGd1ZXNzIGlzIHRoYXQgKm1vc3QqIDMyLWJpdCBhcmNoaXRlY3R1cmVzIGRvIG5v
dCBoYXZlIGEgNjQtYml0DQo+IGNtcHhjaGcgLSBub3QgZXZlbiB0aGUgaXJxLXNhZmUgb25lLg0K
DQpEb2VzIGFueSBzcGFyYzMyIGV2ZW4gaGF2ZSBhIDMyLWJpdCBjbXB4Y2hnPw0KVGhlIG9yaWdp
bmFsIHZlcnNpb25zICh3aGljaCB3ZXJlIGRlZmluaXRlbHkgU01QIGNhcGFibGUpDQpvbmx5IGhh
ZCBhIGJ5dGUgc2l6ZWQgYXRvbWljIGV4Y2hhbmdlIHRoYXQgYWx3YXlzIHdyb3RlIDB4ZmYuDQoN
ClNwYXJjMzIgZG9lcyBoYXZlICdsb2FkL3N0b3JlIGRvdWJsZScgKHR3byAzMmJpdCByZWdpc3Rl
cnMpDQpidXQgMzJiaXQgY3B1IGxpa2UgbmlvczIgYW5kIChJIHRoaW5rKSBSSVNDViAoYW5kIHBy
b2JhYmx5DQphbnl0aGluZyBlbHNlIGxvb3NlbHkgYmFzZWQgb24gTUlQUykgb25seSBoYXZlIHNp
bmdsZSByZWdpc3Rlcg0KbG9hZC9zdG9yZSBpbnN0cnVjdGlvbnMuDQpUaGV5J2xsIG1haW5seSBi
ZSBVUCBvbmx5LCBJJ3ZlIG5vdCBsb29rZWQgYXQgUklTQ1YgZW5vdWdoIHRvDQpzZWUgd2hhdCBp
dCBoYXMgd2hlbiBzdXBwb3J0aW5nIFNNUC4NCg0KPiBGb3IgdGhlIFVQIGNhc2UgeW91IGNhbiBk
byB5b3VyIG93biwgb2YgY291cnNlLg0KDQpBIGdlbmVyaWMgdmVyc2lvbiBvZiB0aGUgc29mdCBp
bnRlcnJ1cHQgZGlzYWJsZSBjb2RlIHdvdWxkIGhlbHAuDQpUaGVuIGl0IHdvdWxkIGp1c3QgYmUg
YW4gaW5jL2RlYyBvZiBtZW1vcnkgcmF0aGVyIHRoYW4gaGF2aW5nDQp0byBzYXZlIHRoZSBjdXJy
ZW50IGludGVycnVwdCBlbmFibGUgc3RhdGUuDQpFc3BlY2lhbGx5IGZvciBjb2RlIHRoYXQgb25s
eSBkaXNhYmxlcyBpbnRlcnJ1cHRzIGZvciBhIGZldw0KaW5zdHJ1Y3Rpb25zIC0gc28gdGhlIGNv
c3RzIG9mIGRlZmVycmluZyB0aGUgaW50ZXJydXB0IGRvbid0DQpoYXBwZW4gb2Z0ZW4uDQoNCglE
YXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91
bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5
NzM4NiAoV2FsZXMpDQo=



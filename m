Return-Path: <linux-arch+bounces-7124-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFB497099D
	for <lists+linux-arch@lfdr.de>; Sun,  8 Sep 2024 21:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7C51C2096E
	for <lists+linux-arch@lfdr.de>; Sun,  8 Sep 2024 19:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813AE176251;
	Sun,  8 Sep 2024 19:59:27 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB917554A
	for <linux-arch@vger.kernel.org>; Sun,  8 Sep 2024 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725825567; cv=none; b=Xz/NB3GwXTp8IJYi8B/JyU+YXGBAWjvct9jt5c8dY4NpWtDFJbjqN5/tzhC1J8zCMO9NxvXw3/9mS74ZuQHv3EJxB9FOELD/W3cTrKILfIHTrdYtcMBImPmciGDJb7ZKgJX3hZEWmNEjSoKtOzRHEHz3N/IG2MACq7Yfm2bzR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725825567; c=relaxed/simple;
	bh=VWa+VuWxEr4chYv5590B0BLqcgbZUprsswlSpAmZjuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=SutI4ODX2i8f7BiJvrkK6tbqALy98uBcVgehZODUm5Z/SNnXMOlujTHkYKE86MZAL2iyYteIWXQiTrVEBdYANHH6Z32N3NoQPfDW2tE8Hd8u7gFvtJJ+BuHI7Uhyk5JTxt+8yfwoo4cIPkU2f1mpAgbqqhrqfPYJjt+l+Jmy4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-231-KzG2DeCpP5-7FmGTxaYhAQ-1; Sun, 08 Sep 2024 20:59:23 +0100
X-MC-Unique: KzG2DeCpP5-7FmGTxaYhAQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 8 Sep
 2024 20:58:32 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 8 Sep 2024 20:58:32 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Vincenzo Frascino' <vincenzo.frascino@arm.com>, Arnd Bergmann
	<arnd@arndb.de>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch
	<linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao
	<naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>, Andrew Morton
	<akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>
Subject: RE: [PATCH 5/9] vdso: Split linux/minmax.h
Thread-Topic: [PATCH 5/9] vdso: Split linux/minmax.h
Thread-Index: AQHbAFGj6anFtpX/JkyngSSwmyUx4rJOUXIA
Date: Sun, 8 Sep 2024 19:58:32 +0000
Message-ID: <79a350d94d754a16864b55336e50bce6@AcuMS.aculab.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-6-vincenzo.frascino@arm.com>
 <b78eab34-61f5-4c9e-b080-d2524cd30eb8@csgroup.eu>
 <780d969f-8057-41aa-901f-08a5fbebcba9@app.fastmail.com>
 <1d86a38b-dd57-48ac-875b-4d9d2f645d47@arm.com>
In-Reply-To: <1d86a38b-dd57-48ac-875b-4d9d2f645d47@arm.com>
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

RnJvbTogVmluY2Vuem8gRnJhc2Npbm8NCj4gU2VudDogMDYgU2VwdGVtYmVyIDIwMjQgMTI6NDEN
Cj4gDQo+IE9uIDA0LzA5LzIwMjQgMTg6MjMsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+ID4gT24g
V2VkLCBTZXAgNCwgMjAyNCwgYXQgMTc6MTcsIENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+ID4+
IExlIDAzLzA5LzIwMjQgw6AgMTc6MTQsIFZpbmNlbnpvIEZyYXNjaW5vIGEgw6ljcml0wqA6DQo+
ID4+PiBUaGUgVkRTTyBpbXBsZW1lbnRhdGlvbiBpbmNsdWRlcyBoZWFkZXJzIGZyb20gb3V0c2lk
ZSBvZiB0aGUNCj4gPj4+IHZkc28vIG5hbWVzcGFjZS4NCj4gPj4+DQo+ID4+PiBTcGxpdCBsaW51
eC9taW5tYXguaCB0byBtYWtlIHN1cmUgdGhhdCB0aGUgZ2VuZXJpYyBsaWJyYXJ5DQo+ID4+PiB1
c2VzIG9ubHkgdGhlIGFsbG93ZWQgbmFtZXNwYWNlLg0KPiA+Pg0KPiA+PiBJdCBpcyBwcm9iYWJs
eSBlYXNpZXIgdG8ganVzdCBkb24ndCB1c2UgbWluX3QoKSBpbiBWRFNPLiBDYW4gYmUgb3Blbg0K
PiA+PiBjb2RlZCB3aXRob3V0IGltcGVlZGluZyByZWFkYWJpbGl0eS4NCj4gPg0KPiA+IFJpZ2h0
LCBvciBwb3NzaWJseSB0aGUgZXZlbiBzaW1wbGVyIE1JTigpL01BWCgpIGlmIHRoZSBhcmd1bWVu
dHMNCj4gPiBoYXZlIG5vIHNpZGUtZWZmZWN0cy4NCj4gPg0KPiANCj4gQWdyZWVkLCBnZW5lcmFs
bHkgSSBkbyBub3QgbGlrZSBvcGVuLWNvZGluZyBzaW5jZSBpdCB0ZW5kcyB0byBpbnRyb2R1Y2UN
Cj4gZHVwbGljYXRpb24sIGJ1dCB0aGVzZSBjYXNlcyBhcmUgc2ltcGxlIGVzcGVjaWFsbHkgaWYg
d2UgY2FuIHVzZSBNSU4oKS9NQVgoKS4NCg0KQXJlbid0IE1JTigpL01BWCgpIGxpa2VseSB0byBn
ZXQgZGVmaW5lZCBpbiBtaW5tYXguaCBmb3IgY2FzZXMgd2hlcmUgdGhlDQphcmd1bWVudHMgYXJl
IGNvbnN0YW50cyAtIGFuZCBtYXliZSBoYXZlIGNoZWNrcyB0aGF0IHRoZXkgYXJlIGNvbnN0YW50
cy4NClNvIHlvdSBkb24ndCB3YW50IHRvIGRlZmluZSB0aGVtIGluIHRoZSBWRFNPIGhlYWRlciBl
aXRoZXIuDQoNCk9wZW4gY29kaW5nIHNpbXBsZSBjYXNlcyBpcyBhY3R1YWxseSBlYXNpZXIgdG8g
cmVhZCA6LSkNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==



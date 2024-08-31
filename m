Return-Path: <linux-arch+bounces-6885-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AFF9672B4
	for <lists+linux-arch@lfdr.de>; Sat, 31 Aug 2024 18:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D4F1F22574
	for <lists+linux-arch@lfdr.de>; Sat, 31 Aug 2024 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7760A42A91;
	Sat, 31 Aug 2024 16:31:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B573381C8
	for <linux-arch@vger.kernel.org>; Sat, 31 Aug 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725121882; cv=none; b=dAI8m3OLwDpxyS5Fi+4sGPsNU0jR27hJv3HGaKknQUvqzsC5TmNya6oq9vEfHZhjZl6V3PLqXwJlcsph3VoajGiEhCAeU0HFWSBAXshlv4uTKgP8Y7mGK3+t6SXiBygm6Q01zxGMjeGQT1Cp2WP0G3SkjaAonxi6eztxrhPZkHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725121882; c=relaxed/simple;
	bh=AuLfZzUmtglWqwz48TCd9lAiPu5sOPRAyVJ52ZHkrxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DgOJA5A98akRETQFWQqGaKq6uM5QlNL9dhDWq80ravwPE31BSh9FGeZa/hmVlJ7pPdBC1hHbPZGE42AtjjRmAjwR7pbp11zirqFxdlnYEKp32FPIN9KGCuAOuZWkReP0KNQ9L8j8uUPJDzyIFvSSg9o13vDdBaJsOKhkOtNG6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-262-wK_tsTO6PIqyGgtMlXpe8w-1; Sat, 31 Aug 2024 17:31:14 +0100
X-MC-Unique: wK_tsTO6PIqyGgtMlXpe8w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 31 Aug
 2024 17:30:28 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 31 Aug 2024 17:30:28 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christophe Leroy' <christophe.leroy@csgroup.eu>, Charlie Jenkins
	<charlie@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Muchun Song
	<muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
	"Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Huacai Chen
	<chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Russell King
	<linux@armlinux.org.uk>, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller
	<deller@gmx.de>, Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "Yoshinori
 Sato" <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, "David S. Miller"
	<davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Shuah Khan
	<shuah@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH 07/16] powerpc: mm: Support MAP_BELOW_HINT
Thread-Topic: [PATCH 07/16] powerpc: mm: Support MAP_BELOW_HINT
Thread-Index: AQHa+RRTN/GnVgA7wEmCsX6Cdbuah7JBk7Rw
Date: Sat, 31 Aug 2024 16:30:28 +0000
Message-ID: <7011cb340586473dac83efbbe84c4a05@AcuMS.aculab.com>
References: <20240827-patches-below_hint_mmap-v1-0-46ff2eb9022d@rivosinc.com>
 <20240827-patches-below_hint_mmap-v1-7-46ff2eb9022d@rivosinc.com>
 <a43c52c6-c1ac-4ef3-b511-08f0459bddad@csgroup.eu>
In-Reply-To: <a43c52c6-c1ac-4ef3-b511-08f0459bddad@csgroup.eu>
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

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAyOCBBdWd1c3QgMjAyNCAwNzozNQ0KPiBI
aSBDaGFybGllLA0KPiANCj4gTGUgMjgvMDgvMjAyNCDDoCAwNzo0OSwgQ2hhcmxpZSBKZW5raW5z
IGEgw6ljcml0wqA6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIE1BUF9CRUxPV19ISU5UIHRvIGFyY2hf
Z2V0X21tYXBfYmFzZSgpIGFuZA0KPiA+IGFyY2hfZ2V0X21tYXBfZW5kKCkuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBDaGFybGllIEplbmtpbnMgPGNoYXJsaWVAcml2b3NpbmMuY29tPg0KPiA+
IC0tLQ0KPiA+ICAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3Rhc2tfc2l6ZV82NC5oIHwgMzYg
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwg
MzAgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9h
cmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vdGFza19zaXplXzY0LmggYi9hcmNoL3Bvd2VycGMvaW5j
bHVkZS9hc20vdGFza19zaXplXzY0LmgNCj4gPiBpbmRleCAyMzliMzYzODQxYWEuLmEzN2E1YTgx
MzY1ZCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vdGFza19zaXpl
XzY0LmgNCj4gPiArKysgYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vdGFza19zaXplXzY0LmgN
Cj4gPiBAQCAtNzIsMTIgKzcyLDM2IEBADQo+ID4gICAjZGVmaW5lIFNUQUNLX1RPUF9NQVggVEFT
S19TSVpFX1VTRVI2NA0KPiA+ICAgI2RlZmluZSBTVEFDS19UT1AgKGlzXzMyYml0X3Rhc2soKSA/
IFNUQUNLX1RPUF9VU0VSMzIgOiBTVEFDS19UT1BfVVNFUjY0KQ0KPiA+DQo+ID4gLSNkZWZpbmUg
YXJjaF9nZXRfbW1hcF9iYXNlKGFkZHIsIGxlbiwgYmFzZSwgZmxhZ3MpIFwNCj4gPiAtCSgoKGFk
ZHIpID4gREVGQVVMVF9NQVBfV0lORE9XKSA/IChiYXNlKSArIFRBU0tfU0laRSAtIERFRkFVTFRf
TUFQX1dJTkRPVyA6IChiYXNlKSkNCj4gPiArI2RlZmluZSBhcmNoX2dldF9tbWFwX2Jhc2UoYWRk
ciwgbGVuLCBiYXNlLCBmbGFncykJCQkJCVwNCj4gDQo+IFRoaXMgbWFjcm8gbG9va3MgcXVpdGUg
YmlnIGZvciBhIG1hY3JvLCBjYW4gaXQgYmUgYSBzdGF0aWMgaW5saW5lDQo+IGZ1bmN0aW9uIGlu
c3RlYWQgPyBTYW1lIGZvciB0aGUgb3RoZXIgbWFjcm8gYmVsb3cuDQoNCk9yIGV2ZW4gYSByZWFs
IGZ1bmN0aW9uPw0KR2l2ZW4gdGhlIGFjdHVhbCBjb3N0IG9mIG1hcHBpbmcgbWVtb3J5IGFuIGV4
dHJhIGZ1bmN0aW9uIGNhbGwNCmlzbid0IGdvaW5nIHRvIGJlIG1hc3VyYWJsZS4NCg0KCURhdmlk
DQoNCj4gDQo+ID4gKyh7CQkJCQkJCQkJCQlcDQo+ID4gKwl1bnNpZ25lZCBsb25nIG1tYXBfYmFz
ZTsJCQkJCQkJXA0KPiA+ICsJdHlwZW9mKGZsYWdzKSBfZmxhZ3MgPSAoZmxhZ3MpOwkJCQkJCQlc
DQo+ID4gKwl0eXBlb2YoYWRkcikgX2FkZHIgPSAoYWRkcik7CQkJCQkJCVwNCj4gPiArCXR5cGVv
ZihiYXNlKSBfYmFzZSA9IChiYXNlKTsJCQkJCQkJXA0KPiA+ICsJdHlwZW9mKGxlbikgX2xlbiA9
IChsZW4pOwkJCQkJCQlcDQo+ID4gKwl1bnNpZ25lZCBsb25nIHJuZF9nYXAgPSBERUZBVUxUX01B
UF9XSU5ET1cgLSAoX2Jhc2UpOwkJCQlcDQo+ID4gKwlpZiAoX2ZsYWdzICYgTUFQX0JFTE9XX0hJ
TlQgJiYgX2FkZHIgIT0gMCAmJiAoKF9hZGRyICsgX2xlbikgPiBCSVQoVkFfQklUUyAtIDEpKSlc
DQo+ID4gKwkJbW1hcF9iYXNlID0gKF9hZGRyICsgX2xlbikgLSBybmRfZ2FwOwkJCQkJXA0KPiA+
ICsJZWxzZQkJCQkJCQkJCQlcDQo+ID4gKwkJbW1hcF9lbmQgPSAoKF9hZGRyID4gREVGQVVMVF9N
QVBfV0lORE9XKSA/CQkJCVwNCj4gPiArCQkJCV9iYXNlICsgVEFTS19TSVpFIC0gREVGQVVMVF9N
QVBfV0lORE9XIDoJCVwNCj4gPiArCQkJCV9iYXNlKTsJCQkJCQkJXA0KPiA+ICsJbW1hcF9lbmQ7
CQkJCQkJCQkJXA0KPiANCj4gbW1hcF9lbmQgZG9lc24ndCBleGlzdCwgZGlkIHlvdSBtZWFuIG1t
YXBfYmFzZSA/DQo+IA0KPiA+ICt9KQ0KPiA+DQo+ID4gLSNkZWZpbmUgYXJjaF9nZXRfbW1hcF9l
bmQoYWRkciwgbGVuLCBmbGFncykgXA0KPiA+IC0JKCgoYWRkcikgPiBERUZBVUxUX01BUF9XSU5E
T1cpIHx8IFwNCj4gPiAtCSAoKChmbGFncykgJiBNQVBfRklYRUQpICYmICgoYWRkcikgKyAobGVu
KSA+IERFRkFVTFRfTUFQX1dJTkRPVykpID8gVEFTS19TSVpFIDogXA0KPiA+IC0JCQkJCQkJCQkg
ICAgREVGQVVMVF9NQVBfV0lORE9XKQ0KPiA+ICsjZGVmaW5lIGFyY2hfZ2V0X21tYXBfZW5kKGFk
ZHIsIGxlbiwgZmxhZ3MpCQkJCQkJCVwNCj4gPiArKHsJCQkJCQkJCQkJCQlcDQo+ID4gKwl1bnNp
Z25lZCBsb25nIG1tYXBfZW5kOwkJCQkJCQkJCVwNCj4gPiArCXR5cGVvZihmbGFncykgX2ZsYWdz
ID0gKGZsYWdzKTsJCQkJCQkJCVwNCj4gPiArCXR5cGVvZihhZGRyKSBfYWRkciA9IChhZGRyKTsJ
CQkJCQkJCVwNCj4gPiArCXR5cGVvZihsZW4pIF9sZW4gPSAobGVuKTsJCQkJCQkJCVwNCj4gPiAr
CWlmIChfZmxhZ3MgJiBNQVBfQkVMT1dfSElOVCAmJiBfYWRkciAhPSAwICYmICgoX2FkZHIgKyBf
bGVuKSA+IEJJVChWQV9CSVRTIC0gMSkpKQlcDQo+ID4gKwkJbW1hcF9lbmQgPSAoX2FkZHIgKyBf
bGVuKTsJCQkJCQkJXA0KPiA+ICsJZWxzZQkJCQkJCQkJCQkJXA0KPiA+ICsJCW1tYXBfZW5kID0g
KCgoX2FkZHIpID4gREVGQVVMVF9NQVBfV0lORE9XKSB8fAkJCQkJXA0KPiA+ICsJCQkJKCgoX2Zs
YWdzKSAmIE1BUF9GSVhFRCkgJiYgKChfYWRkcikgKyAoX2xlbikgPiBERUZBVUxUX01BUF9XSU5E
T1cpKVwNCj4gPiArCQkJCT8gVEFTS19TSVpFIDogREVGQVVMVF9NQVBfV0lORE9XKQkJCQlcDQo+
ID4gKwltbWFwX2VuZDsJCQkJCQkJCQkJXA0KPiA+ICt9KQ0KPiA+DQo+ID4gICAjZW5kaWYgLyog
X0FTTV9QT1dFUlBDX1RBU0tfU0laRV82NF9IICovDQo+ID4NCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K



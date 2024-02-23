Return-Path: <linux-arch+bounces-2694-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E50886101C
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 12:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D12C1C23347
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 11:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31699657D5;
	Fri, 23 Feb 2024 11:05:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E64263121
	for <linux-arch@vger.kernel.org>; Fri, 23 Feb 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686338; cv=none; b=Hg7DvF/tJTLJsrMC9oRxJe0WWsspppne4L7St5Yz7V/YBLnrsU4JMX/RB6zBcjUMXN28rEgTeKucfO82tRCVXFJNx2SpuPm/RtabREelAa5963/7a5rfSgrYYMeM6EbwZjR2FBL1eh2FIZvNlgQaBsDBI/5fsuMTfMvrfBNBPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686338; c=relaxed/simple;
	bh=f8K7B4fWzAJ9S0HMWxpxdex4kiotuVYmwyxdYOKndxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=lKEs5KMvz7dbZq+sRPMgYbQZ0SGPxP5e9J8oenqrN3I81/wibZiynC06uGCISuywMzj5nPS0S9p77mv2PmN3I370cg1froCG6o/XQFWyDb+4exroVlORFxwdIbU9qlnUX6JGqwvDVVy/iQqmfKrlxS0z3Y8X/rq8n20fMxx9Mik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-130-H-3Osv-SP7aTaorVWrPjmg-1; Fri, 23 Feb 2024 11:05:31 +0000
X-MC-Unique: H-3Osv-SP7aTaorVWrPjmg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 23 Feb
 2024 11:05:29 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 23 Feb 2024 11:05:29 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Niklas Schnelle' <schnelle@linux.ibm.com>, 'Jason Gunthorpe'
	<jgg@nvidia.com>
CC: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Justin Stitt
	<justinstitt@google.com>, Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Ingo Molnar
	<mingo@redhat.com>, Bill Wendling <morbo@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Salil Mehta <salil.mehta@huawei.com>, Jijie Shao
	<shaojijie@huawei.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Yisen Zhuang
	<yisen.zhuang@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Leon Romanovsky <leonro@mellanox.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Thread-Topic: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Thread-Index: AQHaZGPOOI9/P4jwQk+N+/Phnt6M8bEW6XcggAAM2oCAAKwjYIAAJAwAgAABBTA=
Date: Fri, 23 Feb 2024 11:05:29 +0000
Message-ID: <3227d5224a9745e388738d016fdae87a@AcuMS.aculab.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
	 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
	 <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
	 <20240222223617.GC13330@nvidia.com>
	 <efc727fbb8de45c8b669b6ec174f95ce@AcuMS.aculab.com>
 <61931c626d9bc54369d73fda8f8ee59bbb5e95bc.camel@linux.ibm.com>
In-Reply-To: <61931c626d9bc54369d73fda8f8ee59bbb5e95bc.camel@linux.ibm.com>
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

Li4uDQo+ID4gPiA+ID4gKwkJaWYgKChfY291bnQgJSA4KSA+PSA0KSB7DQo+ID4gPiA+DQo+ID4g
PiA+IElmIChfY291bnQgJiA0KSB7DQo+ID4gPg0KPiA+ID4gVGhhdCB3b3VsZCBiZSBvYmZ1c2Nh
dGluZywgSU1ITy4gVGhlIGNvbXBpbGVyIGRvZXNuJ3QgbmVlZCBzdWNoIHRoaW5ncw0KPiA+ID4g
dG8gZ2VuZXJhdGUgb3B0aW1hbCBjb2RlLg0KPiA+DQo+ID4gVHJ5IGl0OiBodHRwczovL2dvZGJv
bHQub3JnL3ovRXZ2R3JUeHYzDQo+ID4gQW5kIGl0IGlzbid0IHRoYXQgb2JmdXNjYXRlZCAtIG5v
IG1vcmUgc28gdGhhbiB5b3VyIHZlcnNpb24uDQo+IA0KPiBUaGUgZ29kYm9sdCBsaW5rIGRvZXMg
Im4gJSA4ID4gNCIgaW5zdGVhZCBvZiAiLi4uID49IDQiIGFzIGluIEphc29uJ3MNCj4gb3JpZ2lu
YWwgY29kZS4gV2l0aCAiPj0iIHRoZSBjb21waWxlZCBjb2RlIG1hdGNoZXMgdGhhdCBmb3IgIm4g
JiA0Ii4NCg0KQnVnZ2VyIDotKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K



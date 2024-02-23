Return-Path: <linux-arch+bounces-2703-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E57861361
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 14:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E151C21C6E
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8B880033;
	Fri, 23 Feb 2024 13:52:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048947F492
	for <linux-arch@vger.kernel.org>; Fri, 23 Feb 2024 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696365; cv=none; b=nFCU8Wt4NuqYRwPFrgFSgw99P/sALvNlJpVhG79tjS6RtO82POn4EeKJRkF8sdJcpOXekPsygiGKy53MSyadjuvmTnYhfeCGZMX1o4lkT1L/99JGgPcZjMwgrVrZ7KQxINoKysVLioh0cdnVwBMo81MBk4V0gAyvsKh+tMJsGsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696365; c=relaxed/simple;
	bh=F+dE5PSi2nh33bOrlLn9Liq7cqW9uBp/B7QQSXRWOZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=XaNm4zFTQ0lDKHPGM06Ex2XyahTrBEWkoPCTwKHUr5MEbfrohkX/osNexjsgKUP/orObqUSrqs6ciND4+wg4xh+be47z1GU83yOMnEpRungCyYGEf8TdyBr7bnunKL4I5OFUKdWNZ6ueiqiuowYuRffCGNS8Y3FQ/kSMXSOAj0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-220-N0YvSLKYPYycpbumIvGJWw-1; Fri, 23 Feb 2024 13:52:39 +0000
X-MC-Unique: N0YvSLKYPYycpbumIvGJWw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 23 Feb
 2024 13:52:38 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 23 Feb 2024 13:52:38 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jason Gunthorpe' <jgg@nvidia.com>
CC: 'Niklas Schnelle' <schnelle@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Gerald Schaefer
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
Thread-Index: AQHaZGPOOI9/P4jwQk+N+/Phnt6M8bEW6XcggAAM2oCAAKwjYIAALlsAgAACWrCAABVaAIAABEPg
Date: Fri, 23 Feb 2024 13:52:37 +0000
Message-ID: <18248cc6f411441c8a68a55f68416150@AcuMS.aculab.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
 <20240222223617.GC13330@nvidia.com>
 <efc727fbb8de45c8b669b6ec174f95ce@AcuMS.aculab.com>
 <e78f6e6294c31d889ace4de3a3c3cebad04f4213.camel@linux.ibm.com>
 <d4150af74d7c45b79c770cd1c5d8eed7@AcuMS.aculab.com>
 <20240223130308.GF13330@nvidia.com>
In-Reply-To: <20240223130308.GF13330@nvidia.com>
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
Content-Transfer-Encoding: quoted-printable

From: Jason Gunthorpe
> Sent: 23 February 2024 13:03
>=20
> On Fri, Feb 23, 2024 at 12:19:24PM +0000, David Laight wrote:
>=20
> > Since writes get 'posted' all over the place.
> > How many writes do you need to do before write-combining makes a
> > difference?
>=20
> The issue is that the HW can optimize if the entire transaction is
> presented in one TLP, if it has to reassemble the transaction it takes
> a big slow path hit.

Ah, so you aren't optimising to reduce the number of TLP for
(effectively) a write to a memory buffer, but have a pcie slave
that really want to see (for example) the writes for a ring buffer
entry in a single TLP?

So you really want something that (should) generate a 16 (or 32)
byte TLP? Rather than abusing the function that is expected to
generate multiple 8 byte TLP to generate larger TLP.

I'm guessing that on arm64 the ldp/stp instructions will generate
a single 16 byte TLP regardless of write combining?
They would definitely help memcpy_fromio().

Are they enough for arm64?
Getting but TLP on x86 is probably harder.
(Unless you use AVX512 registers and aligned accesses.)

It is rather a shame that there isn't an efficient way to get
access to a couple of large SIMD registers.
(eg save on stack and have the fpu code where they are for
a lazy fpu switch.)
There is quite a bit of code that would benefit, but kernel_fpu_begin()
is just too expensive.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



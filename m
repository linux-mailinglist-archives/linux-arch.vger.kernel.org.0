Return-Path: <linux-arch+bounces-2687-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E83860560
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 23:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F502860AA
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 22:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FBA13BAC9;
	Thu, 22 Feb 2024 22:05:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6853212D20E
	for <linux-arch@vger.kernel.org>; Thu, 22 Feb 2024 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639514; cv=none; b=lWqVZKF/kjcRYDjG1fXboIIoo9aZPxTt4xNo6Pw98vLvYZ0LYqg29toUnNdYkN9/vlLLphCSOzv+0SpxFSFRTsLPASpjlAQxAsUh7k0tvuycs7r4nEK21PZtf5kVP8UhQ/GmNBiT1ymltN51jEcnV7bJ2KWGWVHGthqNuK+74Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639514; c=relaxed/simple;
	bh=Ns8POw5Unk7S6TWI/lYpd3ryYdEastG5Bp71gPxYe3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BaFoAKLO3wT2uE2liuj8NrKHnk/2Ckr/Uh1dm81bA94/QPKLDXJXZLMpY4yRy9+gdy2ZOLgyMRLX9RVQriVvArv2Qy8pdGIy2N70c+eI1awRM3v3Qv+eYCYNvlWOY13qvLJBAJwyDCRrOMnXTprDcJIc5e5o/xxget5/XjaQxHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-267-WbNjfvPePtanToAnPgxbaA-1; Thu, 22 Feb 2024 22:05:07 +0000
X-MC-Unique: WbNjfvPePtanToAnPgxbaA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 22 Feb
 2024 22:05:05 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 22 Feb 2024 22:05:04 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jason Gunthorpe' <jgg@nvidia.com>, Alexander Gordeev
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
	<yisen.zhuang@huawei.com>
CC: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
	Leon Romanovsky <leonro@mellanox.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>,
	Michael Guralnik <michaelgur@mellanox.com>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, Niklas Schnelle <schnelle@linux.ibm.com>, "Will
 Deacon" <will@kernel.org>
Subject: RE: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Thread-Topic: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Thread-Index: AQHaZGPOOI9/P4jwQk+N+/Phnt6M8bEW6Xcg
Date: Thu, 22 Feb 2024 22:05:04 +0000
Message-ID: <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
In-Reply-To: <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
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
> Sent: 21 February 2024 01:17
>=20
> The kernel provides driver support for using write combining IO memory
> through the __iowriteXX_copy() API which is commonly used as an optional
> optimization to generate 16/32/64 byte MemWr TLPs in a PCIe environment.
>=20
...
> Implement __iowrite32/64_copy() specifically for ARM64 and use inline
> assembly to build consecutive blocks of STR instructions. Provide direct
> support for 64/32/16 large TLP generation in this manner. Optimize for
> common constant lengths so that the compiler can directly inline the stor=
e
> blocks.
...
> +/*
> + * This generates a memcpy that works on a from/to address which is alig=
ned to
> + * bits. Count is in terms of the number of bits sized quantities to cop=
y. It
> + * optimizes to use the STR groupings when possible so that it is WC fri=
endly.
> + */
> +#define memcpy_toio_aligned(to, from, count, bits)                      =
  \
> +=09({                                                                \
> +=09=09volatile u##bits __iomem *_to =3D to;                       \
> +=09=09const u##bits *_from =3D from;                              \
> +=09=09size_t _count =3D count;                                    \
> +=09=09const u##bits *_end_from =3D _from + ALIGN_DOWN(_count, 8); \
> +                                                                        =
  \
> +=09=09for (; _from < _end_from; _from +=3D 8, _to +=3D 8)           \
> +=09=09=09__const_memcpy_toio_aligned##bits(_to, _from, 8); \
> +=09=09if ((_count % 8) >=3D 4) {   =20

If (_count & 4) {
                              \
> +=09=09=09__const_memcpy_toio_aligned##bits(_to, _from, 4); \
> +=09=09=09_from +=3D 4;                                       \
> +=09=09=09_to +=3D 4;                                         \
> +=09=09}                                                         \
> +=09=09if ((_count % 4) >=3D 2) {                                  \
Ditto
> +=09=09=09__const_memcpy_toio_aligned##bits(_to, _from, 2); \
> +=09=09=09_from +=3D 2;                                       \
> +=09=09=09_to +=3D 2;                                         \
> +=09=09}                                                         \
> +=09=09if (_count % 2)                                           \
and again
> +=09=09=09__const_memcpy_toio_aligned##bits(_to, _from, 1); \
> +=09})

But that looks bit a bit large to be inlined.
Except, perhaps, for small constant lengths.
I'd guess that even with write-combining and posted PCIe writes it
doesn't take much for it to be PCIe limited rather than cpu limited?

Is there a sane way to do the same for reads - they are far worse
than writes.

I solved the problem a few years back on a little ppc by using an on-cpu
DMA controller that could do PCIe master accesses and spinning until
the transfer completed.
But that sort of DMA controller seems uncommon.
We now initiate most of the transfers from the slave (an fpga) - after
writing a suitable/sane dma controller for that end.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



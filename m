Return-Path: <linux-arch+bounces-2692-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FE3860D90
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 10:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D881F25F9A
	for <lists+linux-arch@lfdr.de>; Fri, 23 Feb 2024 09:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8114D210EE;
	Fri, 23 Feb 2024 09:07:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E665241E0
	for <linux-arch@vger.kernel.org>; Fri, 23 Feb 2024 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679273; cv=none; b=hmWiW+9eAZu69Zpx8UMZDNLKKY7j3NQvHn/yh7T56n6Ykw46v7gf/ol1Tuno9Hkjo9XwLfzKXr8wiRGwXGwFCVR+ZZjVaTjIjhkxWqXRMMPuhf2z8vk1QWFkPDGEnzGBqgl4E2/bMvPkTMzF8F3J3NQzK9HZ5ruL1Y6pyjZ/YIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679273; c=relaxed/simple;
	bh=HicMqPuP0z9kAN9RI1DRLqxYLPpRsSSu0aExBQ/IKhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=kdQBMSV06dKGdGqr8ECvqj5aGGgYtDwweV3w28sz8/3y3hPYMScJpRjJW8JpuORs8iRJzFdoHQZ2ZWBEgw/FM693NqtUAcmJu4CyOzGpxYxiOzF4ekFtMwgJdLE5FRcjZE+Kkd6sOyK8OeJeG7r2ALDcAWb+i42gcEkdVDZDstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-284-PjVkpfHkNiSprLivrGQVxg-1; Fri, 23 Feb 2024 09:07:29 +0000
X-MC-Unique: PjVkpfHkNiSprLivrGQVxg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 23 Feb
 2024 09:07:27 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 23 Feb 2024 09:07:27 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jason Gunthorpe' <jgg@nvidia.com>
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
	<patches@lists.linux.dev>, Niklas Schnelle <schnelle@linux.ibm.com>, "Will
 Deacon" <will@kernel.org>
Subject: RE: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Thread-Topic: [PATCH 4/6] arm64/io: Provide a WC friendly __iowriteXX_copy()
Thread-Index: AQHaZGPOOI9/P4jwQk+N+/Phnt6M8bEW6XcggAAM2oCAAKwjYA==
Date: Fri, 23 Feb 2024 09:07:27 +0000
Message-ID: <efc727fbb8de45c8b669b6ec174f95ce@AcuMS.aculab.com>
References: <0-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <4-v1-38290193eace+5-mlx5_arm_wc_jgg@nvidia.com>
 <6d335e8701334a15b220b75d49b98d77@AcuMS.aculab.com>
 <20240222223617.GC13330@nvidia.com>
In-Reply-To: <20240222223617.GC13330@nvidia.com>
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
> Sent: 22 February 2024 22:36
> To: David Laight <David.Laight@ACULAB.COM>
>=20
> On Thu, Feb 22, 2024 at 10:05:04PM +0000, David Laight wrote:
> > From: Jason Gunthorpe
> > > Sent: 21 February 2024 01:17
> > >
> > > The kernel provides driver support for using write combining IO memor=
y
> > > through the __iowriteXX_copy() API which is commonly used as an optio=
nal
> > > optimization to generate 16/32/64 byte MemWr TLPs in a PCIe environme=
nt.
> > >
> > ...
> > > Implement __iowrite32/64_copy() specifically for ARM64 and use inline
> > > assembly to build consecutive blocks of STR instructions. Provide dir=
ect
> > > support for 64/32/16 large TLP generation in this manner. Optimize fo=
r
> > > common constant lengths so that the compiler can directly inline the =
store
> > > blocks.
> > ...
> > > +/*
> > > + * This generates a memcpy that works on a from/to address which is =
aligned to
> > > + * bits. Count is in terms of the number of bits sized quantities to=
 copy. It
> > > + * optimizes to use the STR groupings when possible so that it is WC=
 friendly.
> > > + */
> > > +#define memcpy_toio_aligned(to, from, count, bits)                  =
      \
> > > +=09({                                                               =
 \
> > > +=09=09volatile u##bits __iomem *_to =3D to;                       \
> > > +=09=09const u##bits *_from =3D from;                              \
> > > +=09=09size_t _count =3D count;                                    \
> > > +=09=09const u##bits *_end_from =3D _from + ALIGN_DOWN(_count, 8); \
> > > +                                                                    =
      \
> > > +=09=09for (; _from < _end_from; _from +=3D 8, _to +=3D 8)           =
\
> > > +=09=09=09__const_memcpy_toio_aligned##bits(_to, _from, 8); \
> > > +=09=09if ((_count % 8) >=3D 4) {
> >
> > If (_count & 4) {
>=20
> That would be obfuscating, IMHO. The compiler doesn't need such things
> to generate optimal code.

Try it: https://godbolt.org/z/EvvGrTxv3=20
And it isn't that obfuscated - no more so than your version.

> > > +=09=09=09__const_memcpy_toio_aligned##bits(_to, _from, 1); \
> > > +=09})
> >
> > But that looks bit a bit large to be inlined.
>=20
> You trimmed alot, this #define is in a C file and it is a template to
> generate the 32 and 64 bit out of line functions. Things are done like
> this because the 32/64 version are exactly the same logic except just
> with different types and sizes.

I missed that in a quick read at 11pm :-(

Although I doubt that generating long TLP from byte writes is
really necessary.
IIRC you were merging at most 4 writes.
So better to do a single 32bit write instead.
(Unless you have misaligned source data - unlikely.)

While write-combining to generate long TLP is probably mostly
safe for PCIe targets, there are some that will only handle
TLP for single 32bit data items.
Which might be why the code is explicitly requesting 4 byte copies.
So it may be entirely wrong to write-combine anything except
the generic memcpy_toio().

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



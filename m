Return-Path: <linux-arch+bounces-803-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E862480A7FA
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 16:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1351F2102C
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 15:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF50932C92;
	Fri,  8 Dec 2023 15:56:47 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A32EBD
	for <linux-arch@vger.kernel.org>; Fri,  8 Dec 2023 07:56:44 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-272-xAJojC2tP_KYEh9QIaiPUQ-1; Fri, 08 Dec 2023 15:56:41 +0000
X-MC-Unique: xAJojC2tP_KYEh9QIaiPUQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 8 Dec
 2023 15:56:27 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 8 Dec 2023 15:56:27 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Al Viro' <viro@zeniv.linux.org.uk>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "gus
 Gusenleitner Klaus" <gus@keba.com>, Al Viro <viro@ftp.linux.org.uk>, "Thomas
 Gleixner" <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>
Subject: RE: [RFC][PATCHES v2] checksum stuff
Thread-Topic: [RFC][PATCHES v2] checksum stuff
Thread-Index: AQHaJyGyb9WP/snuGU2gdqpp5IxoMLCcGsYAgADCXYCAAmhtsIAALqUAgAATlYA=
Date: Fri, 8 Dec 2023 15:56:27 +0000
Message-ID: <ce18effbe40c47bfb48f87e7ee4f8141@AcuMS.aculab.com>
References: <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV> <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV> <20231022194020.GA972254@ZenIV>
 <20231205022100.GB1674809@ZenIV>
 <602ab11ffa2c4cc49bb9ecae2f0540b0@AcuMS.aculab.com>
 <20231206224359.GR1674809@ZenIV>
 <46711b57a62348059cfe798c8acea941@AcuMS.aculab.com>
 <20231208141712.GA1674809@ZenIV>
In-Reply-To: <20231208141712.GA1674809@ZenIV>
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

From: Al Viro
> Sent: 08 December 2023 14:17
>=20
> On Fri, Dec 08, 2023 at 12:04:24PM +0000, David Laight wrote:
> > I've just read RFC 792 and done some experiments.
> > The kernel ICMP checksum code is just plain broken.
> >
> > RFC 792 is quite clear that the checksum is the 16-bit ones's
> > complement of the one's complement sum of the ICMP message
> > starting with the ICMP Type.
> >
> > The one's complement sum of 0xfffe and 0x0001 is zero (not the 0xffff
>=20
> It is not.  FYI, N-bit one's complement sum is defined as
>=20
> X + Y <=3D MAX_N_BIT ? X + Y : X + Y - MAX_N_BIT,
>=20
> where MAX_N_BIT is 2^N - 1.

If that is true (I did bump into that RFC earlier) I can't help
feeling that someone has decided to call an 'adc sum' 1's compliment!
I've never used a computer with native 1's compliment integers
(only sign over-punch) so I'm not really sure what might be expected
to happen when you wrap from +MAXINT (+32767) to -MAXINT (-32767).

> You add them as natural numbers.  If there is no carry and result
> fits into N bits, that's it.  If there is carry, you add it to
> the lower N bits of sum.
>=20
> Discussion of properties of that operation is present e.g. in
> RFC1071, titled "Computing the Internet Checksum".
>=20
> May I politely suggest that some basic understanding of the
> arithmetics involved might be useful for this discussion?

Well 0x0000 is +0 and 0xffff is -0, mathematically they are (mostly)
equal.

Most code validating checksums just sums the buffer and expects 0xffff.

RFC 768 (UDP) aays:
If the computed  checksum  is zero,  it is transmitted  as all ones (the
equivalent  in one's complement  arithmetic).   An all zero  transmitted
checksum  value means that the transmitter  generated  no checksum  (for
debugging or for higher level protocols that don't care).

RFC 8200 (IPv6) makes the zero checksum illegal.

So those paths (at least) really need to initialise the chechsum to 1
and then increment after the invert.

I bet that ICMP response (with id =3D=3D 0 and seq =3D=3D 0) is the only
place it is possible to get an ip-checksum of a zero buffer.
So it will be pretty moot for copy+checksum with can return 0xffff
(or lots of other values) for an all-zero buffer.

In terms of copy+checksum returning an error, why not reduce the
32bit wcsum once (to 17 bits) and return -1 (or ~0u) on error?
Much simpler than your patch and it won't have the lurking problem
of the result being assigned to a 32bit variable.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



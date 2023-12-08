Return-Path: <linux-arch+bounces-797-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3AA80A2C4
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 13:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9019028176D
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 12:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986C1A73D;
	Fri,  8 Dec 2023 12:04:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CF61716
	for <linux-arch@vger.kernel.org>; Fri,  8 Dec 2023 04:04:41 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-284-wk_94Km3M2aShqPoVa8iQA-1; Fri, 08 Dec 2023 12:04:38 +0000
X-MC-Unique: wk_94Km3M2aShqPoVa8iQA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 8 Dec
 2023 12:04:24 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 8 Dec 2023 12:04:24 +0000
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
Thread-Index: AQHaJyGyb9WP/snuGU2gdqpp5IxoMLCcGsYAgADCXYCAAmhtsA==
Date: Fri, 8 Dec 2023 12:04:24 +0000
Message-ID: <46711b57a62348059cfe798c8acea941@AcuMS.aculab.com>
References: <20231019050250.GV800259@ZenIV> <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV> <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV> <20231022194020.GA972254@ZenIV>
 <20231205022100.GB1674809@ZenIV>
 <602ab11ffa2c4cc49bb9ecae2f0540b0@AcuMS.aculab.com>
 <20231206224359.GR1674809@ZenIV>
In-Reply-To: <20231206224359.GR1674809@ZenIV>
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
> Sent: 06 December 2023 22:44
>=20
> On Wed, Dec 06, 2023 at 11:10:45AM +0000, David Laight wrote:
>=20
> > Do we?
> > I've not seen any justification for this at all.
> > IIRC the ICMPv4 reply code needs the checksum function return 0xffff
> > for all-zero input.
> >
> > So the correct and simple fix is to initialise the sum to 0xffff
> > in the checksum function.
>=20
> You do realize that ICMPv4 reply code is not the only user of those,
> right?  Sure, we can special-case it there.  And audit the entire
> call tree, proving that no other call chains need the same.
>=20
> Care to post the analysis?  I have the beginnings of that and it's alread=
y
> long and convoluted and touches far too many places, all of which will
> have to be watched indefinitely, so that changes in there don't introduce
> new breakage.
>=20
> I could be wrong.  About many things, including the depth of your
> aversion to RTFS.  But frankly, until that analysis shows up somewhere,
> I'm going to ignore your usual handwaving.

I've just read RFC 792 and done some experiments.
The kernel ICMP checksum code is just plain broken.

RFC 792 is quite clear that the checksum is the 16-bit ones's
complement of the one's complement sum of the ICMP message
starting with the ICMP Type.

The one's complement sum of 0xfffe and 0x0001 is zero (not the 0xffff
that the adc loop generates.
So it's one's complement is 0xffff not 0x0000.
So the checksum field in an ICMP message should never contain zero.

Now for the experiments...

Run: 'tcpdump -n -x icmp' in one window to trace the icmp messages.
Elsewhere run 'ping -c1 -s2 -p 0000 host'
The last 6 bytes of the ICMP echo request are the ICMP data eg:
=090800 c381 347d 0001 0000
=09cmd   sum  id   seq data
If you repeat the request the 'id' will increase by one or two.
Replace data with the checksum - so ping -c1 -s2 -p c381
You won't be quick enough, the checksum will probably be fffd.
But nearly there...
Repeat but subtract (say) 8 from the old checksum.
Then issue the command a few times and the packet checksum
should go from 0004 down to 0001 then jump to ffff.
But you'll see a 0000 instead of the 0xffff.

Note that the buffer being summed isn't all zeros but the
checksum field is still wrong.

I suspect that the real problem is that the value returned
by csum_fold() should never be put into a packet that is being
transmitted because the domain is [0..0xfffe] not [1..0xffff].

I bet ICMP isn't the only place where a transmitted checksum
ends up being zero.
As I've said before UDP4 treats is as no-checksum (so assume valid)
and UDP6 states the field must not be zero.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



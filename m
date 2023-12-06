Return-Path: <linux-arch+bounces-711-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8842E806D80
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 12:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2F31C209BA
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 11:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8885931590;
	Wed,  6 Dec 2023 11:11:07 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62A7D44
	for <linux-arch@vger.kernel.org>; Wed,  6 Dec 2023 03:11:03 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-4-2hKIkG_FPuSAvM53S8Wr_w-1; Wed, 06 Dec 2023 11:10:59 +0000
X-MC-Unique: 2hKIkG_FPuSAvM53S8Wr_w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Dec
 2023 11:10:45 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 6 Dec 2023 11:10:45 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Al Viro' <viro@zeniv.linux.org.uk>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: gus Gusenleitner Klaus <gus@keba.com>, Al Viro <viro@ftp.linux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuba@kernel.org"
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>
Subject: RE: [RFC][PATCHES v2] checksum stuff
Thread-Topic: [RFC][PATCHES v2] checksum stuff
Thread-Index: AQHaJyGyb9WP/snuGU2gdqpp5IxoMLCcGsYA
Date: Wed, 6 Dec 2023 11:10:45 +0000
Message-ID: <602ab11ffa2c4cc49bb9ecae2f0540b0@AcuMS.aculab.com>
References: <20231018154205.GT800259@ZenIV>
 <VI1PR0702MB3840F2D594B9681BF2E0CD81D9D4A@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20231019050250.GV800259@ZenIV> <20231019061427.GW800259@ZenIV>
 <20231019063925.GX800259@ZenIV>
 <CANn89iJre=VQ6J=UuD0d2J5t=kXr2b9Dk9b=SwzPX1CM+ph60A@mail.gmail.com>
 <20231019080615.GY800259@ZenIV> <20231021071525.GA789610@ZenIV>
 <20231021222203.GA800259@ZenIV> <20231022194020.GA972254@ZenIV>
 <20231205022100.GB1674809@ZenIV>
In-Reply-To: <20231205022100.GB1674809@ZenIV>
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
> Sent: 05 December 2023 02:21
>=20
> We need a way for csum_and_copy_{from,to}_user() to report faults.
> The approach taken back in 2020 (avoid 0 as return value by starting
> summing from ~0U, use 0 to report faults) had been broken; it does
> yield the right value modulo 2^16-1, but the case when data is
> entirely zero-filled is not handled right.  It almost works, since
> for most of the codepaths we have a non-zero value added in
> and there 0 is not different from anything divisible by 0xffff.
> However, there are cases (ICMPv4 replies, for example) where we
> are not guaranteed that.
>=20
> In other words, we really need to have those primitives return 0
> on filled-with-zeroes input.

Do we?
I've not seen any justification for this at all.
IIRC the ICMPv4 reply code needs the checksum function return 0xffff
for all-zero input.

So the correct and simple fix is to initialise the sum to 0xffff
in the checksum function.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



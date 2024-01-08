Return-Path: <linux-arch+bounces-1298-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C51826C0B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 12:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EA9BB20E15
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 11:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28E214019;
	Mon,  8 Jan 2024 11:03:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146414294
	for <linux-arch@vger.kernel.org>; Mon,  8 Jan 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-253-EyLyuJXtPwmi8cp329UFpQ-1; Mon, 08 Jan 2024 11:03:47 +0000
X-MC-Unique: EyLyuJXtPwmi8cp329UFpQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 8 Jan
 2024 11:03:22 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 8 Jan 2024 11:03:22 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, Arnd Bergmann
	<arnd@arndb.de>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>
Subject: RE: [PATCH] asm-generic: make sparse happy with odd-sized
 put_unaligned_*()
Thread-Topic: [PATCH] asm-generic: make sparse happy with odd-sized
 put_unaligned_*()
Thread-Index: AQHaQfo/rBE9iMqwLUOx80/L8Ll8bLDPvnqw
Date: Mon, 8 Jan 2024 11:03:22 +0000
Message-ID: <12d88da48f6947ab86a845e8d02319ff@AcuMS.aculab.com>
References: <ZZuTTRCUFqWzA1y-@google.com>
In-Reply-To: <ZZuTTRCUFqWzA1y-@google.com>
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

From: Dmitry Torokhov
> Sent: 08 January 2024 06:17
>=20
> __put_unaligned_be24() and friends use implicit casts to convert
> larger-sized data to bytes, which trips sparse truncation warnings when
> the argument is a constant:
>=20
>   CC [M]  drivers/input/touchscreen/hynitron_cstxxx.o
>   CHECK   drivers/input/touchscreen/hynitron_cstxxx.c
> drivers/input/touchscreen/hynitron_cstxxx.c: note: in included file (thro=
ugh
> arch/x86/include/generated/asm/unaligned.h):
> ./include/asm-generic/unaligned.h:119:16: warning: cast truncates bits fr=
om constant value (aa01a0
> becomes a0)
> ./include/asm-generic/unaligned.h:120:20: warning: cast truncates bits fr=
om constant value (aa01
> becomes 1)
> ./include/asm-generic/unaligned.h:119:16: warning: cast truncates bits fr=
om constant value (ab00d0
> becomes d0)
> ./include/asm-generic/unaligned.h:120:20: warning: cast truncates bits fr=
om constant value (ab00
> becomes 0)
>=20
> To avoid this let's mask off upper bits explicitly, the resulting code
> should be exactly the same, but it will keep sparse happy.

Maybe someone should fix sparse?
I have seen a compiler generate two explicit masks with 0xff
followed by a byte write for:
=09*p =3D (char)(x & 0xff);
but I expect modern gcc is ok.

> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401070147.gqwVulOn-lkp@i=
ntel.com/
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  include/asm-generic/unaligned.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unalig=
ned.h
> index 699650f81970..a84c64e5f11e 100644
> --- a/include/asm-generic/unaligned.h
> +++ b/include/asm-generic/unaligned.h
> @@ -104,9 +104,9 @@ static inline u32 get_unaligned_le24(const void *p)
>=20
>  static inline void __put_unaligned_be24(const u32 val, u8 *p)
>  {
> -=09*p++ =3D val >> 16;
> -=09*p++ =3D val >> 8;
> -=09*p++ =3D val;
> +=09*p++ =3D (val >> 16) & 0xff;
> +=09*p++ =3D (val >> 8) & 0xff;
> +=09*p++ =3D val & 0xff;
>  }

What happens if you implement the as (eg):
=09*p =3D val >> 16;
=09put_unaligned_be16(p + 1, val);
I think that should generate better code.
And it may stop sparse bleating.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



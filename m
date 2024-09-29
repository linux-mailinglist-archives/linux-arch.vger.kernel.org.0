Return-Path: <linux-arch+bounces-7484-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2A5989796
	for <lists+linux-arch@lfdr.de>; Sun, 29 Sep 2024 23:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED091F21703
	for <lists+linux-arch@lfdr.de>; Sun, 29 Sep 2024 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7C0178CCA;
	Sun, 29 Sep 2024 21:19:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037C343AAE
	for <linux-arch@vger.kernel.org>; Sun, 29 Sep 2024 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727644744; cv=none; b=TTbIN5a3K5+KCfAxVQq5qrxvbCW6eWrzhJkTkDfbHS4D8tregW8fi1odaX5LycjDnHRoVkg5WNMQNGw87Im/D7NAZV7LCl3RaXSDXuskwwdMN/bhIdt/rbZ0TP+r6R96dzmHaw1/NQb3EfMb/ZsO4h7GkYdmU9TuyVX8J0/tFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727644744; c=relaxed/simple;
	bh=CnLQ5uQpXbBPCYzLAFh5wCZggo1nx9nXYZKgDefw4x0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=K4Wz/XMCk0EFh67bPfBJmpmFRpSzO6mpz7uIAPO89l+4S2GmwcuQRebXzz9cilRuUdhQLqf/U7s1u/GBFbyhI9zxaIo63A1K6GQz7DUrYbCM6fUw5AXDXlVLoFNbT271R1LRFcb+Wnf034r9GiDjZFP2XPlkxspz8hr6Bvq2pR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-256-NQcG79MeP9qOesbpHn9Sjw-1; Sun, 29 Sep 2024 22:17:42 +0100
X-MC-Unique: NQcG79MeP9qOesbpHn9Sjw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 29 Sep
 2024 22:16:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 29 Sep 2024 22:16:49 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'marius.cristea@microchip.com'" <marius.cristea@microchip.com>,
	"arnd@arndb.de" <arnd@arndb.de>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Thread-Topic: [PATCH v1] asm-generic: introduce be56 unaligned accessors
Thread-Index: AQHbELg4aDeytMgGcUifSLsY4O8Q9LJvRwDw
Date: Sun, 29 Sep 2024 21:16:49 +0000
Message-ID: <207733c7c25e4e09b0774eb21322e7e5@AcuMS.aculab.com>
References: <20240927083543.80275-1-marius.cristea@microchip.com>
In-Reply-To: <20240927083543.80275-1-marius.cristea@microchip.com>
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

From: marius.cristea@microchip.com
> Sent: 27 September 2024 09:36
>=20
> The PAC194X, IIO driver, is using some unaligned 56 bit registers.
> Provide some helper accessors in preparation for the new driver.

Someone please shoot the hardware engineer ;-)

Do separate unaligned access of the first 4 bytes and last four bytes.
It can't matter if the middle byte is accessed twice.

Or, for reads read 8 bytes from 'p & ~1ul' and then fixup
the value.

=09David

>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  include/asm-generic/unaligned.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unalig=
ned.h
> index a84c64e5f11e..d171a9f2377a 100644
> --- a/include/asm-generic/unaligned.h
> +++ b/include/asm-generic/unaligned.h
> @@ -152,4 +152,31 @@ static inline u64 get_unaligned_be48(const void *p)
>  =09return __get_unaligned_be48(p);
>  }
>=20
> +static inline void __put_unaligned_be56(const u64 val, u8 *p)
> +{
> +=09*p++ =3D (val >> 48) & 0xff;
> +=09*p++ =3D (val >> 40) & 0xff;
> +=09*p++ =3D (val >> 32) & 0xff;
> +=09*p++ =3D (val >> 24) & 0xff;
> +=09*p++ =3D (val >> 16) & 0xff;
> +=09*p++ =3D (val >> 8) & 0xff;
> +=09*p++ =3D val & 0xff;
> +}
> +
> +static inline void put_unaligned_be56(const u64 val, void *p)
> +{
> +=09__put_unaligned_be56(val, p);
> +}
> +
> +static inline u64 __get_unaligned_be56(const u8 *p)
> +{
> +=09return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
> +=09=09(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
> +}
> +
> +static inline u64 get_unaligned_be56(const void *p)
> +{
> +=09return __get_unaligned_be56(p);
> +}
> +
>  #endif /* __ASM_GENERIC_UNALIGNED_H */
>=20
> base-commit: b82c1d235a30622177ce10dcb94dfd691a49922f
> --
> 2.43.0
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)



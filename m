Return-Path: <linux-arch+bounces-15852-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FAAD3A425
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 11:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A9343015D04
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB7A34DB56;
	Mon, 19 Jan 2026 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNId2tL4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25703346E73
	for <linux-arch@vger.kernel.org>; Mon, 19 Jan 2026 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817184; cv=none; b=O6+HlFPFAsor8z0Pgc6oM5BTsSX66CH/xXJstXCkdppG5u7fW7xsmUNvUsuWKrS+hCBOIzeaNHdgzlUhyTJQAYjPV6zutHrD85EIVAgYZr+KONzqHJ9s6ZKA3VmLWldWPbtwx3qc2zm405WgbEVRjyL66VGe6MBa2ovtEWUtMiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817184; c=relaxed/simple;
	bh=1JkATqi5wAX+Tb/87K06CYv0cw7OmX176NC/mF093QE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIzwKgVVTfI3kcZbhmk3RwSl4wVhH+jjz2d78tF9pZcj3mBEtdUCo6t0+b7odufUUoJ9yma3WX37AETTPqHihQ0ydB940aK2tzOHA//G7KT5SVmvWyzc3STeQnaU1ovq5m5bL8a/NLAkE6TnM2oo0axHfrUXHFVncEjGAjvdZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNId2tL4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48039fdc8aeso1230955e9.3
        for <linux-arch@vger.kernel.org>; Mon, 19 Jan 2026 02:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768817181; x=1769421981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqVWadMkJ0xV7b+9+R2K7XfNBOxyor4uthrrFNDywHI=;
        b=GNId2tL4UUadX1eRxP+Jav/HOUdQyFp8nhdDul70ZA7S7Us41CtEWt9VRcJg4nKhdn
         uPxukOVDj0Wq0KtfC9SZxdVEksPnLerG0W07HYK9SPp4w7rDoTOO0ynmwMA4GlbOqIoP
         ZGaRp5oCLyQBRCAv9LX3KgM1apjp9JT9BvI6WcXt8+6ZC+jvsVLCqkr2nhzP0TCF9P1X
         LWsncDVpjX10Equ2qlufyi9LDiAx8gd9JVE1vchGqVXgksD2vFfFz3NELiV1IKRHk4XI
         l0ZPXxqbiwZ0uXOi3xYcbXzyuFWai5zF0SnyyFiyRVk5KAa31l1M6/1bREstapugS3hK
         FuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817181; x=1769421981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sqVWadMkJ0xV7b+9+R2K7XfNBOxyor4uthrrFNDywHI=;
        b=GFDQV1//5E8IXkYceKeTYfdHoDyBCFE3TJG10IBf6jDy7pQ4PPHdhh+hxm6qVyZMbi
         dqCBC9V8b8M+MURJpv0CXI1tSS0tUd0SzKd0LCrdbUYmH7yGoLRP1XV1Y3hT+U2oYmQ5
         ORgXBNoGJcmQ2GyYT968GnT541uO+FcG7P9FI3FVITLGuMd/uoqlnfoKOuPkrxuxAdXP
         B81AIk4zTHU6eETKbLvxEvyb5EMlavCvk6FSmBdx6E4UOEhaVhFzDtMRUZR+4oLqhTYp
         6Ij/8kISbedp+/QL9kOT9a2mkvdI+JasdqSn6Zm2RvxYew0lPumDeIt2WtUit8mtEzHr
         Ovqw==
X-Forwarded-Encrypted: i=1; AJvYcCULXU8qcIfddSOg5vbjtdj+CMN/lKW5W727DM/7MTK0IvANNs/sGoxGLMjVPjolFNdaONH9DTsKU9lT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0u4AdBPLlhMDItNC3Wm6W2d4b9SWchuv2155gzh1dpxsTFUKR
	U7RHyxBU3gQ9kXRxNlgVvakpmNrspf6Tm3t9FjENjJnXxtkzaFXY5rpZ
X-Gm-Gg: AY/fxX6M7pQemd5vi6rZOxQqazOC3tI+8WLHDUvQV06IciJnoEG+rbdTCvYaBuvtfZz
	zKNkoUZo2HBiaQxn7hLF9iSKPJP1JiPfueadR+gl2nnSSq52AmaY/pv0beRwumDscd3Thtypn0r
	2Y/grhQDwrQoGKvIevNue9zJPkMElWs0NnMKkSH2dZzQOUkDxB3yl2EOmrBbL1njP5pYydHSRj0
	GFfTPswT0+855Kr3CMXkFC+A80pRrRrckW6xqR9O9BSVvRzRjM5eoGDonf+sKCbfFXCnarXPU96
	YY/yhXAhcSjrwzB1xqLP6EkSqGRY/CqlwqqeuzRXtPRWgUeR8OMpSmiFAxsldl3Kqs5JHikqpIQ
	aDdHFt5QK+sHTnY4cWXjlnsb/mrFwHatWhc/QUaseMk3dd8O6xLR/ew7rLFsUhRAV9D1DzHceuX
	XuUYvLfIfq1W31isLXzOnh6PBmY6zq1w67pk3URac/J0cEcXSbviGI
X-Received: by 2002:a05:600c:5285:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-4801e33c1e1mr121349185e9.21.1768817181059;
        Mon, 19 Jan 2026 02:06:21 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e80c477sm213350375e9.0.2026.01.19.02.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:06:20 -0800 (PST)
Date: Mon, 19 Jan 2026 10:06:19 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andreas Larsson
 <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260119100619.479bcff3@pumpkin>
In-Reply-To: <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
	<20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Jan 2026 08:40:27 +0100
Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:

> The value of __BITS_PER_LONG from architecture-specific logic should
> always match the generic one if that is available. It should also match
> the actual C type 'long'.
>=20
> Mismatches can happen for example when building the compat vDSO. Either
> during the compilation, see commit 9a6d3ff10f7f ("arm64: uapi: Provide
> correct __BITS_PER_LONG for the compat vDSO"), or when running sparse
> when mismatched CHECKFLAGS are inherited from the kernel build.
>=20
> Add some consistency checks which detect such issues early and clearly.
> The tests are added to the UAPI header to make sure it is also used when
> building the vDSO as that is not supposed to use regular kernel headers.
>=20
> The kernel-interal BITS_PER_LONG is not checked as it is derived from
> CONFIG_64BIT and therefore breaks for the compat vDSO. See the similar,
> deactivated check in include/asm-generic/bitsperlong.h.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/uapi/asm-generic/bitsperlong.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-ge=
neric/bitsperlong.h
> index fadb3f857f28..9d762097ae0c 100644
> --- a/include/uapi/asm-generic/bitsperlong.h
> +++ b/include/uapi/asm-generic/bitsperlong.h
> @@ -28,4 +28,18 @@
>  #define __BITS_PER_LONG_LONG 64
>  #endif
> =20
> +/* Consistency checks */
> +#ifdef __KERNEL__
> +#if defined(__CHAR_BIT__) && defined(__SIZEOF_LONG__)
> +#if __BITS_PER_LONG !=3D (__CHAR_BIT__ * __SIZEOF_LONG__)
> +#error Inconsistent word size. Check uapi/asm/bitsperlong.h
> +#endif
> +#endif
> +
> +#ifndef __ASSEMBLER__
> +_Static_assert(sizeof(long) * 8 =3D=3D __BITS_PER_LONG,
> +	       "Inconsistent word size. Check uapi/asm/bitsperlong.h");

nak...

You can't assume the compiler has _Static_assert().
All the ones that do probably define __SIZEOF_LONG__.
You could use something 'old-school' like:
typedef char __inconsistent_long_size[1 - 2 * (sizeof(long) * 8 !=3D __BITS=
_PER_LONG))];

	David

> +#endif
> +#endif /* __KERNEL__ */
> +
>  #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
>=20



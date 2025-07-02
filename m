Return-Path: <linux-arch+bounces-12552-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C24E0AF1158
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jul 2025 12:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD9C3BD273
	for <lists+linux-arch@lfdr.de>; Wed,  2 Jul 2025 10:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3411237172;
	Wed,  2 Jul 2025 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TswbjYw0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955D78F5D;
	Wed,  2 Jul 2025 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451110; cv=none; b=ea/BWe/Gk8fZbBMNenUIvACSmT0+sDxs1I+OeXyh1DW9pcDIVNgY/JdKz6BOyb/nsjUumCeDHHI058L9PyIaa5Cv6dsSPB/F6znWmV3h5OSJJTpfu+maEYxAH7mSV6Pq70wTULgruAHYnyggw7pqYOyNvOQ0X7V36eu5UwzGrC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451110; c=relaxed/simple;
	bh=hA4/iZufk20OeTrgRBxstEQK9yPV2RJw3w8p1R0j53w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/NgeCF/IaDYmk5k7p/piBMQEZvKH894FUdV/AS7eCwVIUuGjjVByDUzF7yvog5TV8qZ5LRFqGuUG8Q7BxJG64WahvBqZ7Mr+BqBMkukgzYDJ0eSo9pE/pbfdXWYygd94IW3agI8pXdhSCQAZN6+ZK9z7ACOJ0/IDY/cE857E4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TswbjYw0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso3832318f8f.2;
        Wed, 02 Jul 2025 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751451107; x=1752055907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EXIKYt3Y003wfDpZ6+F8d2uM2XWqrreiBlGE5vL5FA=;
        b=TswbjYw0qBcwVcA3BX8xa/KrAR8GlG8ltvKqGiO6hzGcdRoqVsDzUbp1pQR2BQG4NQ
         0s7ekJYVU8Gpt+Qea421aICSwKLfY7Fd+jqq+HCMtfK669VqxclY8HEVKv6K/4WlcJeY
         DSn4wT90Mwju+XL7kjqs4A/UzzzbElqzJ2WPOr0jDDiRUfMinSBDhIF0cyMOawC/6j22
         9K0898wnlsWR8FDPyAY1xji2CMDsE2VKi4xgRK9q0ZFxPyYsrvN0GR5Bi3X36upfziMK
         CJARzUZuZC99ChKXUX0wx99ZQ3YaX7mADgTYRCh1AnIWij2pyk/TAonvEuQoDOZU6bEa
         9j3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751451107; x=1752055907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EXIKYt3Y003wfDpZ6+F8d2uM2XWqrreiBlGE5vL5FA=;
        b=oyDiK7C44Y2hGC7VmAl05kPgACD3wGYHuKAU0wyXm/gUC6TSl+dnp20rujvawYv1f4
         BduIK6PY8YQDCbELnplALdeM7CnHDvjxvnWFAC0BiPO41VRD0IZlgacuArS59hGHPqxf
         FQpnj/AQiOBhDNicBx5XWuZm/XVIkdJpi+w4Ezut2OdmRjDq4XBd19DYilTgR21tVaUU
         3kJ9/sHzPJHxxdo4XTrU/FOJyFT26xKLK+RW90YGUz4CraJ+UschC/wGxbMMxLqJjlz5
         PfPk9iQ4oC+039Jbefx1+2R0/KXFsm+zdwImfmSIpFkNkzycO8btrgBPX2IrS9tFsdFO
         9mbA==
X-Forwarded-Encrypted: i=1; AJvYcCVbLAROCSHVssv+SmvQqzs9QsgMSbeQHs0tMEJiNiCmGsYOhKzhZckPqr0jgpPBiVjCuUy1+SMkj5nXfM62@vger.kernel.org, AJvYcCWFfFbD+k7mbEsX6tsPeGIrWjl8YLzxKfkzhzPXJN2pZXrxKPyasyeOhiv1kOVQ5Nsm69jlAQ7QZRsT@vger.kernel.org
X-Gm-Message-State: AOJu0YzYMWoVTTFA9H2eRfxa2522N8NwUX1rwcGY0Lc4xooYy1q/zY21
	UvZeSBYHzeOsUiFOuoJIj7BWVsp5r30xTEYRt/Yk210Vqy8GXCZyMHI2
X-Gm-Gg: ASbGncueCf029PRKTIRN77q5ygrwPzuBfULx/quP5KUZwy4tl3Ieo1UmsHHfYVrhUa5
	cS3cBR+hQ5ivWeGnpCdzpeCgY/1xF2ueTtiVeauC9lE7ixIdBtQeVgysYADtvJTjz8kq79U5bpY
	lJmGt6TAZiyiuwSH65IW5kTo3T69MO6tOBJb27aBLjeBjmaS0iGZVUUFeTpsVNXRreQW1UuEI60
	omDi7kNuh4gygwa71rsfDMeFfPhFzu/rbp/IEL7pSij6Mmo5+1v8fWlTDYSPQk4IUoihoswE+B4
	dnv0CbR7CSK1z/89QniRFsSIIhdsAd2uksb0estP4rYP7tnEOIAvszovAHC1+OEuSrBfDieAmQK
	uO8AUzKMPsWFBwcI9qQ==
X-Google-Smtp-Source: AGHT+IE5o/lCRhHaBkNRDZxdR5z+1LVjickMfAb9sK5WBxxBVNG0nGn1OFJE4sJnm4XT7L9Mxa4FVw==
X-Received: by 2002:a05:6000:41dc:b0:3a4:e387:c0bb with SMTP id ffacd0b85a97d-3b2012f7f91mr1677072f8f.59.1751451106691;
        Wed, 02 Jul 2025 03:11:46 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a407743sm192874035e9.33.2025.07.02.03.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:11:46 -0700 (PDT)
Date: Wed, 2 Jul 2025 11:11:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: cp0613@linux.alibaba.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
 arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux@rasmusvillemoes.dk,
 palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 2/2] bitops: rotate: Add riscv implementation using Zbb
 extension
Message-ID: <20250702111135.37854d1b@pumpkin>
In-Reply-To: <aGQprv3HTplw9r-q@yury>
References: <aGLA78usaJOnpols@yury>
	<20250701124737.687-1-cp0613@linux.alibaba.com>
	<aGQprv3HTplw9r-q@yury>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Jul 2025 14:32:14 -0400
Yury Norov <yury.norov@gmail.com> wrote:

> On Tue, Jul 01, 2025 at 08:47:01PM +0800, cp0613@linux.alibaba.com wrote:
> > On Mon, 30 Jun 2025 12:53:03 -0400, yury.norov@gmail.com wrote:
> >  =20
> > > > > 1. The most trivial compile-case is actually evaluated at compile=
 time; and
> > > > > 2. Any arch-specific code is well explained; and
> > > > > 3. legacy case optimized just as well as non-legacy. =20
> > > >=20
> > > > 1. As in the above reply, use the generic implementation when compi=
le-time evaluation
> > > >    is possible=E3=80=82
> > > > 2. I will improve the comments later. =20
> > >=20
> > > I'm particularly interested in ror8/rol8 case:
> > >=20
> > >         u32 word32 =3D ((u32)word << 24) | ((u32)word << 16) | ((u32)=
word << 8) | word;
> > >=20
> > > When you expand it to 32-bit word, and want to rotate, you obviously
> > > need to copy lower quarterword to the higher one:
> > >=20
> > >         0xab >> 0xab0000ab
> > >=20
> > > That way generic (u8)ror32(0xab, shift) would work. But I don't under=
stand
> > > why you copy the lower 8 bits to inner quarterwords. Is that a hardwa=
re
> > > requirement? Can you point to any arch documentation=20
> > >  =20
> > > > 3. As mentioned before, only 8-bit rotation should have no optimiza=
tion effect, and
> > > >    16-bit and above will have significant optimization. =20
> > >=20
> > > I asked you about the asm goto ("legacy") thing: you calculate that
> > > complex word32 _before_ evaluating the goto. So this word32 may get
> > > unused, and you waste cycles. I want to make sure this isn't the case=
. =20
> >=20
> > Thank you for your suggestion and reminder. This is not a hardware requ=
irement, but it =20
>=20
> Sure. Please add
>=20
> Suggested-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>=20
> > is somewhat related because the zbb instruction only supports word-size=
d rotate [1].
> > Considering the case where the shift is greater than 8, if the modulus =
of the shift is
> > not taken, it is required to continuously concatenate 8-bit data into 3=
2 bits.

I'd not worry about rotates of 8 bits or more (for ror8).
They can be treated as 'undefined behaviour' under the assumption they don'=
t happen.
The 'generic' version needs them to get gcc to generate a 'rorb' on x86.
The negated shift needs masking so that clang doesn't throw the code away w=
hen
the value is constant.

> >=20
> > So, I considered the case of taking the remainder of shift and found th=
at this
> > implementation would have one less instruction, so the final implementa=
tion is as follows:
> > ```
> > static inline u8 variable_rol8(u8 word, unsigned int shift) =20
>=20
> Now that it has assembler inlines, would it help to add the __pure
> qualifier?
>=20
> > {
> > 	u32 word32;
> >=20
> > 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> > 				      RISCV_ISA_EXT_ZBB, 1)
> > 			  : : : : legacy);
> >=20
> > 	word32 =3D ((u32)word << 24) | word;
> > 	shift =3D shift % 8; =20
>=20
>         shift %=3D 8;
>=20
> >=20
> > 	asm volatile(
> > 		".option push\n"
> > 		".option arch,+zbb\n"
> > 		"rolw %0, %1, %2\n"
> > 		".option pop\n"
> > 		: "=3Dr" (word32) : "r" (word32), "r" (shift) :);
> >=20
> > 	return (u8)word32;
> >=20
> > legacy:
> > 	return generic_rol8(word, shift);
> > }
> >=20
> > static inline u8 variable_ror8(u8 word, unsigned int shift)
> > {
> > 	u32 word32;
> >=20
> > 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> > 				      RISCV_ISA_EXT_ZBB, 1)
> > 			  : : : : legacy);
> >=20
> > 	word32 =3D ((u32)word << 8) | word;
> > 	shift =3D shift % 8;
> >=20
> > 	asm volatile(
> > 		".option push\n"
> > 		".option arch,+zbb\n"
> > 		"rorw %0, %1, %2\n"
> > 		".option pop\n"
> > 		: "=3Dr" (word32) : "r" (word32), "r" (shift) :);
> >=20
> > 	return (u8)word32;
> >=20
> > legacy:
> > 	return generic_ror8(word, shift);
> > }
> > ``` =20
>=20
> OK, this looks better.
>=20
> > I compared the performance of ror8 (zbb optimized) and generic_ror8 on =
the XUANTIE C908
> > by looping them. ror8 is better, and the advantage of ror8 becomes more=
 obvious as the
> > number of iterations increases. The test code is as follows:
> > ```
> > 	u8 word =3D 0x5a;
> > 	u32 shift =3D 9;
> > 	u32 i, loop =3D 100;
> > 	u8 ret1, ret2;
> >=20
> > 	u64 t1 =3D ktime_get_ns();
> > 	for (i =3D 0; i < loop; i++) {
> > 		ret2 =3D generic_ror8(word, shift);
> > 	}
> > 	u64 t2 =3D ktime_get_ns();
> > 	for (i =3D 0; i < loop; i++) {
> > 		ret1 =3D ror8(word, shift);
> > 	}
> > 	u64 t3 =3D ktime_get_ns();
> >=20
> > 	pr_info("t2-t1=3D%lld t3-t2=3D%lld\n", t2 - t1, t3 - t2);
> > ``` =20
>=20
> Please do the following:
>=20
> 1. Drop the generic_ror8() and keep only ror/l8()
> 2. Add ror/l16, 34 and 64 tests.
> 3. Adjust the 'loop' so that each subtest will take 1-10 ms on your hw.

That is far too many iterations.
You'll get interrupts dominating the tests.
The best thing is to do 'just enough' iterations to get a meaningful result,
and then repeat a few times and report the fastest (or average excluding
any large outliers).

You also need to ensure the compiler doesn't (or isn't allowed to) pull
the contents of the inlined function outside the loop - and then throw
the loop away,

The other question is whether any of it is worth the effort.
How many ror8() and ror16() calls are there?
I suspect not many.

Improving the generic ones might be worth while.
Perhaps moving the current versions to x86 only.
(I suspect the only other cpu with byte/short rotates is m68k)

	David



> 4. Name the function like test_rorl(), and put it next to the test_fns()
>    in lib/test_bitops.c. Refer the 0a2c6664e56f0 for implementation.
> 5. Prepend the series with the benchmark patch, just as with const-eval
>    one, and report before/after for your series.=20
>=20
> > > Please find attached a test for compile-time ror/rol evaluation.
> > > Please consider prepending your series with it. =20
> >=20
> > Okay, I'll bring it to the next series. =20
>=20
> Still waiting for bloat-o-meter results.
>=20
> Thanks,
> Yury
>=20
> >=20
> > [1] https://github.com/riscv/riscv-bitmanip =20
>=20



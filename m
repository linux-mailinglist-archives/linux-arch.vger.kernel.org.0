Return-Path: <linux-arch+bounces-5470-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99C933FB0
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 17:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130481F21636
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jul 2024 15:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD84381DE;
	Wed, 17 Jul 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NecC90Xe"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30D1CF8A;
	Wed, 17 Jul 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230188; cv=none; b=lLyxmJOAXEXSBTlG2bbyfO3MPH6jFNYNdDvE9iB/E5pw/l6zlW8JWYYcB9d0gX8fFRQtbUfVBnkMEF1S1EaFE+w6WdkGL8lf80LnsoDka2SEfzmUrYpvcaG5xq4r3kbdN8DV/Pmy51UbfOA5SJUiQu56lEtNRtOl1FEqi1JsVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230188; c=relaxed/simple;
	bh=3y6J4/IWm8k/uSeOISrjXuhjwcWCcnKSS8UTJoDbyRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gj/e8oR1sey0t6V/2ZvZtc9qwlMGKYJX/RVTv9UThYJ9L0n9ZYZsIBim609PSaPGffFsy3DIf7J8vYRAlLnhX/aRH6BOqcJwRCr/ge87OtFxIBNsJ/+jo30a49HuLcP7Gdt6HtnbPyADNDgKIeDAUOwvHYglTZhXFrmFHKNXo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NecC90Xe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203A6C4AF0D;
	Wed, 17 Jul 2024 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721230188;
	bh=3y6J4/IWm8k/uSeOISrjXuhjwcWCcnKSS8UTJoDbyRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NecC90XexhGoyFhzFxrlcWTvnpYVtoqz/haenUdhAM1tUHYwL2QvnIDokC5JL/IFj
	 LTcONI2qs57x1+JT8oC8wwAF/yLog3atHfbwNsqaDo/tjMiMeiA/zrtUdooRhjJY8/
	 ZclSG+F1yYWlCHVQupgwzV20IedJXDKFzeSfbhLah/S06XErDyqLIcJEGZXrDLgHJL
	 6i4aZYMAajymRGkMre1vdzBOxJXYfSKHvWQGw9iSjkfejUX7ioa8NsZsWMzQ/M8P9l
	 Ema8B/GGA9GZen3Y1rgO/zjo66BGuswiolVlvJxNZngrSL2JUZMZP87wOoJ2OO4Vz/
	 kfNRIj9nqkevA==
Date: Wed, 17 Jul 2024 16:29:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 03/11] riscv: Implement cmpxchg8/16() using Zabha
Message-ID: <20240717-enroll-snowless-e722e367789b@spud>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-4-alexghiti@rivosinc.com>
 <20240717-e7104dac172d9f2cbc25d9c6@orel>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DKnFDS9hDsllBOMu"
Content-Disposition: inline
In-Reply-To: <20240717-e7104dac172d9f2cbc25d9c6@orel>


--DKnFDS9hDsllBOMu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 10:26:34AM -0500, Andrew Jones wrote:
> On Wed, Jul 17, 2024 at 08:19:49AM GMT, Alexandre Ghiti wrote:
> > -#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)	\
> > +#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, =
o, n)	\
> >  ({									\
> > +	__label__ no_zabha_zacas, end;					\
> > +									\
> > +	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&			\
> > +	    IS_ENABLED(CONFIG_RISCV_ISA_ZACAS)) {			\
> > +		asm goto(ALTERNATIVE("j %[no_zabha_zacas]", "nop", 0,	\
> > +				     RISCV_ISA_EXT_ZABHA, 1)		\
> > +			 : : : : no_zabha_zacas);			\
> > +		asm goto(ALTERNATIVE("j %[no_zabha_zacas]", "nop", 0,	\
> > +				     RISCV_ISA_EXT_ZACAS, 1)		\
> > +			 : : : : no_zabha_zacas);			\
>=20
> I came late to the call, but I guess trying to get rid of these asm gotos
> was the topic of the discussion. The proposal was to try and use static
> branches, but keep in mind that we've had trouble with static branches
> inside macros in the past when those macros are used in many places[1]
>=20
> [1] commit 0b1d60d6dd9e ("riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SI=
ZE=3Dy")

The other half of the suggestion was not using an asm goto, but instead
trying to patch the whole thing in the alternative, for the problematic
section with llvm < 17.

>=20
> > +									\
> > +		__asm__ __volatile__ (					\
> > +			prepend						\
> > +			"	amocas" cas_sfx " %0, %z2, %1\n"	\
> > +			append						\
> > +			: "+&r" (r), "+A" (*(p))			\
> > +			: "rJ" (n)					\
> > +			: "memory");					\
> > +		goto end;						\
> > +	}								\
> > +									\
> > +no_zabha_zacas:;							\
>=20
> unnecessary ;
>=20
> >  	u32 *__ptr32b =3D (u32 *)((ulong)(p) & ~0x3);			\
> >  	ulong __s =3D ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
> >  	ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
> > @@ -133,6 +155,8 @@
> >  		: "memory");						\
> >  									\
> >  	r =3D (__typeof__(*(p)))((__retx & __mask) >> __s);		\
> > +									\
> > +end:;									\
> >  })
> > =20
> >  #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, =
o, n)	\

--DKnFDS9hDsllBOMu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpfjZQAKCRB4tDGHoIJi
0jmTAP0dEPFTp/z1/WjfXISimZGtZLdRe3vvDV8JgqZQi53RggD/ZBBpVOJzd6N0
fF1PJI/P3vzXi3Ey9CSl+w1GE1dOgAM=
=6ofA
-----END PGP SIGNATURE-----

--DKnFDS9hDsllBOMu--


Return-Path: <linux-arch+bounces-4564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180D68D207C
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 17:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EE01C23327
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7882E17165A;
	Tue, 28 May 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNXJaHrK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC97171653;
	Tue, 28 May 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910494; cv=none; b=aJ6N1DBQ3i2IT7bdiO6XbBARCkgIX0zif9mp9EClwEIvus3rhXIdp52wVYH+9BAQSX+F3W+Kmg59af0usbfVhHxlu+e/h0Ahl/tdUtwuwafjKCldAV73Uz6sVwRMb88FTnLYd+tnEo51uaRl+4vf5NoGIa5nvgFPQZREFhSePKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910494; c=relaxed/simple;
	bh=Y8FneghY/F4qg3k//k5iTQvpIK9AhJXd3ejvwp4sfg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtlatW4cL68HV/6soZShJ+worYItzhEQ9Yqpu/mphn4nxAf1onWKpn2iTujNCKvDX8qjnsH1jquRSsUsnKnyCjeqdcWiDpbw36V5MAawV6F5P00JjK0+/GCswDFBUpaAt/FqIAgK7z/y+SaSR2OmuXd59BdTqqu11xtodPJaTBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNXJaHrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826BAC32789;
	Tue, 28 May 2024 15:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716910493;
	bh=Y8FneghY/F4qg3k//k5iTQvpIK9AhJXd3ejvwp4sfg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNXJaHrKc6uzl5of2judQay4AKFy9V0Lxi2Lse5n5azczhWHvYAdX+BEmGaywnHor
	 2rAaTepYaQiBcJgA0u9wNAM07oJ8FbPBCqx+vWi90DmwXhCrUSw+SegF0wazGKsH8o
	 jaG9QgJ2BxbFq6RBeIKQfJzmLRhbkQeerqUqiBtMxAfKLuei9gks0Qg0CvKD3PZpwl
	 Cp1heThgVvCAj96K7A3OqmXhtbZONUXKYG8rV1HTXvpwoc6uiYDjTUfH1b30mkxUOY
	 ub6jrEwj+0SEtQNLXcAQYiIX+amL/r8+wcKj1un5RH0KAErnEHEUjDbjZ7DaqDRKFu
	 cLC0+mvMPD1/A==
Date: Tue, 28 May 2024 16:34:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/7] riscv: Implement cmpxchg32/64() using Zacas
Message-ID: <20240528-repaint-graffiti-ec4f0e038e5a@spud>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-2-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NeJreBi+Wntza5KK"
Content-Disposition: inline
In-Reply-To: <20240528151052.313031-2-alexghiti@rivosinc.com>


--NeJreBi+Wntza5KK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 05:10:46PM +0200, Alexandre Ghiti wrote:
> This adds runtime support for Zacas in cmpxchg operations.
>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/Kconfig               | 17 +++++++++++++++++
>  arch/riscv/Makefile              | 11 +++++++++++
>  arch/riscv/include/asm/cmpxchg.h | 23 ++++++++++++++++++++---
>  3 files changed, 48 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8a0f403432e8..b443def70139 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -579,6 +579,23 @@ config RISCV_ISA_V_PREEMPTIVE
>  	  preemption. Enabling this config will result in higher memory
>  	  consumption due to the allocation of per-task's kernel Vector context.
> =20
> +config TOOLCHAIN_HAS_ZACAS
> +	bool
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=3Dlp64 -march=3Drv64ima_zacas)
> +	depends on !32BIT || $(cc-option,-mabi=3Dilp32 -march=3Drv32ima_zacas)
> +	depends on AS_HAS_OPTION_ARCH
> +
> +config RISCV_ISA_ZACAS
> +	bool "Zacas extension support for atomic CAS"
> +	depends on TOOLCHAIN_HAS_ZACAS
> +	default y
> +	help
> +	  Adds support to use atomic CAS instead of LR/SC to implement kernel
> +	  atomic cmpxchg operation.

If you were a person compiling a kernel, would you be able to read this
and realise that this is safe to enable when their system does not
support atomic CAS? Please take a look at other how other extensions
handle this, or the patch that I have been sending that tries to make
things clearer:
https://patchwork.kernel.org/project/linux-riscv/patch/20240528-varnish-sta=
tus-9c22973093a0@spud/

> +
> +	  If you don't know what to do here, say Y.
> +
>  config TOOLCHAIN_HAS_ZBB
>  	bool
>  	default y
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 5b3115a19852..d5b60b87998c 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -78,6 +78,17 @@ endif
>  # Check if the toolchain supports Zihintpause extension
>  riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) :=3D $(riscv-march-y)_zi=
hintpause
> =20
> +# Check if the toolchain supports Zacas
> +ifdef CONFIG_AS_IS_LLVM
> +# Support for experimental Zacas was merged in LLVM 17, but the removal =
of
> +# the "experimental" was merged in LLVM 19.
> +KBUILD_CFLAGS +=3D -menable-experimental-extensions
> +KBUILD_AFLAGS +=3D -menable-experimental-extensions
> +riscv-march-y :=3D $(riscv-march-y)_zacas1p0
> +else
> +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) :=3D $(riscv-march-y)_zacas
> +endif

I'm almost certain that we discussed this before for vector and it was
decided to not enable experimental extensions (particularly as it is a
global option), and instead require the non-experimental versions.
This isn't even consistent with your TOOLCHAIN_HAS_ZACAS checks, that
will only enable the option for the ratified version. I think we should
continue to avoid enabling experimental extensions, even if that imposes
a requirement of having a bleeding edge toolchain to actually use the
extension.

Thanks,
Conor.

--NeJreBi+Wntza5KK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlX5mAAKCRB4tDGHoIJi
0t2PAP9Q9RDTWJECIVJQNiS2KS4k5svrPYctaW5tBkJNyH24aQD+KGIH/FYhPYH0
hA4/1t59deBmh2eK/putul6XEIEytAA=
=zNv0
-----END PGP SIGNATURE-----

--NeJreBi+Wntza5KK--


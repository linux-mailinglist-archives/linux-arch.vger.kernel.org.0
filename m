Return-Path: <linux-arch+bounces-4563-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDE38D2045
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 17:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB4D0B21179
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 15:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDFA16D4DA;
	Tue, 28 May 2024 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuA4epHx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B31E507;
	Tue, 28 May 2024 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909768; cv=none; b=XN3UuXUh9XZE+O+G0iDzgzSm4a9JBZLk3p3YuQJgLfFo9KzdzBTqg0PKJtBkbamPONDji3zTR1JLwEbtyndm1+PlregbPX1yHKcwPl1EhLiSb2LMDgo78qaS/DJCuyXqt+1owWXCA4DVWuuGmQOyFIFqYponYi/MTWh47Ob0UOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909768; c=relaxed/simple;
	bh=wTi+xli6HcY+dE5hQHt0HIl1zh3+zE9RZPz4hC45DyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vdxn6+nFH3LPMwXSvH3dYdko7GmTiC1WJg0fmHT4t1InnIN3mthYjCBLyzUYKENAIsErMoq6jgxAWFAXQnjDyIQ0ESTKmQh8DF5NIEHPLOsRccH2GGB1NR2lJxGOQoXoXGjY30ezb/ItfttAb3eGUx50YVa9tyyAGadc9dSm7Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuA4epHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790DFC3277B;
	Tue, 28 May 2024 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716909767;
	bh=wTi+xli6HcY+dE5hQHt0HIl1zh3+zE9RZPz4hC45DyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UuA4epHx7egvOMi6jS4ZFmmTgKjt6C8CCa53rcRGHKIPR412VllMWvVkZbaDkvoWj
	 3FkvUL8WAl9S4zn3SEeyDluFFw/JitsAmjoE3CmfHJbLPz6ESeiG1jjYczZziStLgv
	 KExtuJnx51AZoVIaBAtnx2IdzIOZE5OZaqB8ptkTMEC1TjE7h5RjUqBHe+uMvANf55
	 QoradKfdNj6SGZX/myb9j13ziGOCuwftMv25MuAD93JYzvgOZombc8hqH0E9hOpy3v
	 /2V6zIG2k+2bW+Od6tt1/jlYV8MMWwxRvvzOQTkf6UQ1PWWu678fqXejcMW8l95RrX
	 Q3kyQYMUsrHwQ==
Date: Tue, 28 May 2024 16:22:42 +0100
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
Subject: Re: [PATCH 4/7] riscv: Implement xchg8/16() using Zabha
Message-ID: <20240528-prenatal-grating-2b6096cc2a1b@spud>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-5-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0GTOFQLtWJu+ErMd"
Content-Disposition: inline
In-Reply-To: <20240528151052.313031-5-alexghiti@rivosinc.com>


--0GTOFQLtWJu+ErMd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 05:10:49PM +0200, Alexandre Ghiti wrote:
	\
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index e17d0078a651..f71ddd2ca163 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -81,6 +81,7 @@
>  #define RISCV_ISA_EXT_ZTSO		72
>  #define RISCV_ISA_EXT_ZACAS		73
>  #define RISCV_ISA_EXT_XANDESPMU		74
> +#define RISCV_ISA_EXT_ZABHA		75
> =20
>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
> =20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 3ed2359eae35..8d0f56dd2f53 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -257,6 +257,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
>  	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
> +	__RISCV_ISA_EXT_DATA(zabha, RISCV_ISA_EXT_ZABHA),
>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
>  	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),

You're missing a dt-binding patch in this series adding zabha.

Thanks,
Conor.

--0GTOFQLtWJu+ErMd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlX2wgAKCRB4tDGHoIJi
0sMPAQDF0+IXL0mMgc3HglnXcCxaxr8V2FlJsd42Fa3JmGHPNAEAwEvb+htVAMAp
Oz7amAHz+PXP7m/FfiQEjyXQXz+PsQg=
=ven9
-----END PGP SIGNATURE-----

--0GTOFQLtWJu+ErMd--


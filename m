Return-Path: <linux-arch+bounces-1668-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2125B83CA83
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 19:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40C9B230D0
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3866B133982;
	Thu, 25 Jan 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8+ilI+r"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A5133431;
	Thu, 25 Jan 2024 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205882; cv=none; b=eHBSep7+/xffUslDL2WRdZv+xu+mkBjm59EJjEFoKopcdqIyFcuHfD7eWrFapoLYhYVTcZxEz3NUJ3mmaWbmNxKZhxXzVWybhoJ8q4AKKWtrE1HRYTO/f8zQVspPZw82XBlvTOVpiEB+s2Y70sAJKJnk+28yHXbbZE1v6+i57aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205882; c=relaxed/simple;
	bh=WDKiWZF/CO1jOYkvrWCm5fjBFh98x/VbgkhxOL64aJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTHbZPwm6qSmyew+qz2gjewbpR21inMDMq5OtgSc9ETdIG5s+CUld/Utwf7mKkbeE/PWXRM3VwSe8ae4W0vb7GBmggxIHjAc5BLhtZeXRtgB4NfQ2A6CbPsS0AfK4mmkOvHLsOInOaukMi+3SMIitimTlRiE/N7eSUQvV6XQUIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8+ilI+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A08C433F1;
	Thu, 25 Jan 2024 18:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706205881;
	bh=WDKiWZF/CO1jOYkvrWCm5fjBFh98x/VbgkhxOL64aJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8+ilI+rArrGEQzPOKxpm2KS3wnWPXl81DIQIIVlFks4XkUWeCCYLnv2W1QOtXMH7
	 vxZxdNzGTgI5Ck6OrV+3PtZNm8Cr5WmRLPPVQcrGnWkkUSAu1d3v3XE2hVMJZ0m9He
	 iD1f44ZRSJJgs0xN+T5HI7H5rxVDgR/KYt90fxsf1ZKe9ZQZMRjMC418rbZF1Jcup/
	 jSkG8NJUt5s3pNBKI69IhDV3sAr3XfzL+Cq4zJGEx4bc4nPpBECZySU7/hCjLo8m9L
	 32n4SQxsAE7RgeGLlnFvEweH44zMFp5oX7ZMLwG65JW0diChuZZSzVja0gYDOCJ15k
	 mVK8beInkEYYw==
Date: Thu, 25 Jan 2024 18:04:26 +0000
From: Conor Dooley <conor@kernel.org>
To: debug@rivosinc.com
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, david@redhat.com, charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, chenjiahao16@huawei.com,
	ruscur@russell.cc, bgray@linux.ibm.com, alx@kernel.org,
	baruch@tkos.co.il, zhangqing@loongson.cn, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, joey.gouly@arm.com,
	shr@devkernel.io, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 24/28] riscv: select config for shadow stack and
 landing pad instr support
Message-ID: <20240125-snitch-boogieman-5b4a0b142e61@spud>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-25-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NUnGWzqhiv75TmQp"
Content-Disposition: inline
In-Reply-To: <20240125062739.1339782-25-debug@rivosinc.com>


--NUnGWzqhiv75TmQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 10:21:49PM -0800, debug@rivosinc.com wrote:
> From: Deepak Gupta <debug@rivosinc.com>
>=20
> This patch selects config shadow stack support and landing pad instr
> support. Shadow stack support and landing instr support is hidden behind
> `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires up path
> to enumerate CPU support and if cpu support exists, kernel will support
> cpu assisted user mode cfi.
>=20
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/Kconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 9d386e9edc45..437b2f9abf3e 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -163,6 +163,7 @@ config RISCV
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
>  	select TRACE_IRQFLAGS_SUPPORT
> +	select RISCV_USER_CFI

This select makes no sense to me, it will unconditionally enable
RISCV_USER_CFI. I don't think that that is your intent, since you have a
detailed option below that allows the user to turn it on or off.

If you remove it, the commit message will need to change too FYI.

Thanks,
Conor.

>  	select UACCESS_MEMCPY if !MMU
>  	select ZONE_DMA32 if 64BIT
> =20
> @@ -182,6 +183,20 @@ config HAVE_SHADOW_CALL_STACK
>  	# https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e=
6eeb51f0cb7b8819e50da6d2444d769
>  	depends on $(ld-option,--no-relax-gp)
> =20
> +config RISCV_USER_CFI
> +	bool "riscv userspace control flow integrity"
> +	help
> +	  Provides CPU assisted control flow integrity to userspace tasks.
> +	  Control flow integrity is provided by implementing shadow stack for
> +	  backward edge and indirect branch tracking for forward edge in progra=
m.
> +	  Shadow stack protection is a hardware feature that detects function
> +	  return address corruption. This helps mitigate ROP attacks.
> +	  Indirect branch tracking enforces that all indirect branches must land
> +	  on a landing pad instruction else CPU will fault. This mitigates agai=
nst
> +	  JOP / COP attacks. Applications must be enabled to use it, and old us=
er-
> +	  space does not get protection "for free".
> +	  default y
> +
>  config ARCH_MMAP_RND_BITS_MIN
>  	default 18 if 64BIT
>  	default 8
> --=20
> 2.43.0
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--NUnGWzqhiv75TmQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKiqgAKCRB4tDGHoIJi
0vKGAQDVTVByG7JLLR+gPjsKjLHdPRWsvjnTta2HP7StCen6fgD9Eq3Uv1oej4Qh
QiRGb9e3PxfM9z73zB+grxPynuwKxg4=
=TScR
-----END PGP SIGNATURE-----

--NUnGWzqhiv75TmQp--


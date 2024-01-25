Return-Path: <linux-arch+bounces-1673-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD9283CB76
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 19:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350F91C221FA
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC82813475F;
	Thu, 25 Jan 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6tH+ufY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A567131E40;
	Thu, 25 Jan 2024 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208303; cv=none; b=ALeJM8qR2YkyLjWcvibFz12NK4nruQeTrwH16SNx7NMUkjhxbu3gimqhR871qJ3Zo780jw7gQBi639ZWRHPX/I2fJtXky1I06oWHTkBdrsT0MyLm6oBYabioB7zMX2E5nh6BF7LBPrBs4vQ9aq7C+UuXbqrqoI5BP4k+ze9dK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208303; c=relaxed/simple;
	bh=YOmQgkz1P+8Zi0uUakZsNY3tJ1wB079WwZ+pgQHgPOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhLSRKFyZcidVzBZRcWtIIlZOP1Dm7GokLdaEcXqvD9KTF9CSSzNaXEaIYiisgQr+ONkIpDE+U+cBahx4NnBAtGAP0Qraw6h5bprvl1+wp6GNQlS1FIGpEjsgkx4uXFAhF4tlIYN6MuQF9ut4FGThDWuok8XupFAUhosuwo8Jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6tH+ufY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85938C433F1;
	Thu, 25 Jan 2024 18:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706208303;
	bh=YOmQgkz1P+8Zi0uUakZsNY3tJ1wB079WwZ+pgQHgPOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6tH+ufYN63e0ec9n24c1FtjKPLogyll3pPVDTlBw5IyIKQC21WfMzoutf7aFwp1Z
	 xe1NAaXx662qjwLMcjlFuhZjalF6dGCmXAC1FHFz0ddkNaiHUOfDhJM6x6DmmMmkUw
	 7S2cKN4hWcysnuC7LU/m2G6zl5xoPsA2LUzDZ6X2QgRaLeccd/2B/tBSEGFoXdT8Vc
	 NNsI2SDXMeBpu23AB23V7I3NydxCuDXf3g8idaSoTYDRd534DYw2vQHNfYHKMfd9gl
	 AdBHKLvMPFSwVsq8AlJP48Qc0Sf21tREDkJm1q+KjsG+y7BIQJy2bKH7eFVzDH2xSV
	 2m8nlYs+rsSkQ==
Date: Thu, 25 Jan 2024 18:44:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
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
Message-ID: <20240125-implement-coagulant-3058e743a098@spud>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-25-debug@rivosinc.com>
 <20240125-snitch-boogieman-5b4a0b142e61@spud>
 <ZbKkgNX7xfU5KO8X@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e/FrbnVtGEexHgLP"
Content-Disposition: inline
In-Reply-To: <ZbKkgNX7xfU5KO8X@debug.ba.rivosinc.com>


--e/FrbnVtGEexHgLP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:12:16AM -0800, Deepak Gupta wrote:
> On Thu, Jan 25, 2024 at 06:04:26PM +0000, Conor Dooley wrote:
> > On Wed, Jan 24, 2024 at 10:21:49PM -0800, debug@rivosinc.com wrote:
> > > From: Deepak Gupta <debug@rivosinc.com>
> > >=20
> > > This patch selects config shadow stack support and landing pad instr
> > > support. Shadow stack support and landing instr support is hidden beh=
ind
> > > `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires up p=
ath
> > > to enumerate CPU support and if cpu support exists, kernel will suppo=
rt
> > > cpu assisted user mode cfi.
> > >=20
> > > Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> > > ---
> > >  arch/riscv/Kconfig | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >=20
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 9d386e9edc45..437b2f9abf3e 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -163,6 +163,7 @@ config RISCV
> > >  	select SYSCTL_EXCEPTION_TRACE
> > >  	select THREAD_INFO_IN_TASK
> > >  	select TRACE_IRQFLAGS_SUPPORT
> > > +	select RISCV_USER_CFI
> >=20
> > This select makes no sense to me, it will unconditionally enable
> > RISCV_USER_CFI. I don't think that that is your intent, since you have a
> > detailed option below that allows the user to turn it on or off.
> >=20
> > If you remove it, the commit message will need to change too FYI.
> >=20
>=20
> Selecting this config puts support in Kernel so that it can run tasks who=
 wants
> to enable hardware assisted control flow integrity for themselves. But ap=
ps still
> always need to optin using `prctls`. Those prctls are stubs and return EI=
NVAL when
> this config is not selected. Not selecting this config means, kernel will=
 not support
> enabling this feature for user mode.

I don't think you understand me. "select RISCV_USER_CFI" will
unconditionally build it into the kernel, making stubs etc useless.
You're talking like (and the rest of your commit implements it!) that
this feature can be enabled in menuconfig etc. Having this select
will always enable the config option, rendering the choice below
redundant. Try turning it off in menuconfig.

Oh and if it were valid to have here, you put it in out of order. That's
an alphanumerically sorted list :)

Cheers,
Conor.


--e/FrbnVtGEexHgLP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKsIAAKCRB4tDGHoIJi
0s4rAPwLj36cq4OCVYXidwGHQqrZUowdECj4uRLcWI43EFSS4AEAt/7J8GXw81Mv
lW2W0+1Wk7ntO8Qb5WDzqbK7NusmQwo=
=Mape
-----END PGP SIGNATURE-----

--e/FrbnVtGEexHgLP--


Return-Path: <linux-arch+bounces-5321-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD3192C24D
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jul 2024 19:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7891C22F9C
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jul 2024 17:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6715A34;
	Tue,  9 Jul 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwPgrXPW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693DD15886B;
	Tue,  9 Jul 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720545833; cv=none; b=JpJEbAieb4WUe/sHbm0cM9pj9yuhbLDmB8QxZYoLfbRyQ6t1OU6JfleiTrKi37mgf7rWx9gfAmUp41yJuK9vZnUhXEqLcjHHwCAeZL1ctTsGdj3f6w9q+6xoBN3M+BidczbsRis42yKhvUal85+J+7+vzpgzPeMc6sQY4FWQL0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720545833; c=relaxed/simple;
	bh=6JR7YL5dHcTXqmUfNm6ulP4+0whK4Ux4ulJpM4dDEes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3hRGI+CI1m2r6LbbtBUWWLOTCD4CuJ1UcY+PtykKp7oRPtYtr5GtJMl3f4ASGTuhbZmTimuDqw9i3chCjF5fhNmCUFLmcx71pp3YZsw1wrt6NUkoZMMBMQmEqhmx1sB+Pog/BzQdFqVKPe2mCMH0wo6x+Z6w1uxNHo0vXyyBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwPgrXPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73D9C3277B;
	Tue,  9 Jul 2024 17:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720545832;
	bh=6JR7YL5dHcTXqmUfNm6ulP4+0whK4Ux4ulJpM4dDEes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwPgrXPW3JfSlpe46zAqPpRmk67PjUPgvKmiUQjJg6uvcyMPVWuu5e5QNiuViEwTY
	 umK0995F6a5PS1q171iZzBn7MkFAbMR1M49fRNmmou84XeBTnLTh7hjQxPCMhNugP0
	 VbWdKqpGAMDyQn0ta/D/sfOmUqKMGKYNLbk3Z5s2olmuPoFKKEMbXb0G/0xHKg7MjA
	 SlOvh+HlJkvcRSSYEnGJDIeXCK6ZAL4UTk/eUKUIPXZT1L5reo8onxjdpCvcVwXHSs
	 qIn1Z9HZ6XXUHbOYbnpCKH5HWbVMfRyEEKGUip6ynNrB/i17jwY0/ougN9eXr4Vgun
	 sPm1+k6XgCKXg==
Date: Tue, 9 Jul 2024 18:23:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-openrisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	Aishwarya.TCV@arm.com, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 10/17] arm64: generate 64-bit syscall.tbl
Message-ID: <c8c882ad-d508-40b7-9af5-b2a2ddf777c1@sirena.org.uk>
References: <20240704143611.2979589-1-arnd@kernel.org>
 <20240704143611.2979589-11-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qf0YYqoW3KQMZ1o1"
Content-Disposition: inline
In-Reply-To: <20240704143611.2979589-11-arnd@kernel.org>
X-Cookie: Your step will soil many countries.


--Qf0YYqoW3KQMZ1o1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 04:36:04PM +0200, Arnd Bergmann wrote:

>  #define __ARCH_WANT_SYS_CLONE
> +#define __ARCH_WANT_NEW_STAT
> =20
> -#ifndef __COMPAT_SYSCALL_NR
> -#include <uapi/asm/unistd.h>
> -#endif
> +#include <asm/unistd_64.h>

It looks like this is causing widespread build breakage in kselftest in
-next for arm64, there are *many* errors in the form:

In file included from test_signals_utils.c:14:
/build/stage/build-work/usr/include/asm/unistd.h:2:10: fatal error: unistd_=
64.h: No such file or directory
    2 | #include <unistd_64.h>
      |          ^~~~~~~~~~~~~

which obviously looks like it's tied to the above but I've not fully
understood the patch/series yet.  Build log at:

   https://builds.sirena.org.uk/82d01fe6ee52086035b201cfa1410a3b04384257/ar=
m64/defconfig/build.log

A bisect appears to confirm that it's this commit, which is in -next as
6e4a077c0b607c674536908c5b68f1c31e4e26ec.

git bisect start
# status: waiting for both good and bad commits
# bad: [82d01fe6ee52086035b201cfa1410a3b04384257] Add linux-next specific f=
iles for 20240709
git bisect bad 82d01fe6ee52086035b201cfa1410a3b04384257
# status: waiting for good commit(s), bad commit known
# good: [037206cd4cb43d535453723140fde1bcde0b296e] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
git bisect good 037206cd4cb43d535453723140fde1bcde0b296e
# bad: [2ae3e655fc40f1b6620194b90dcf9a4515257918] Merge branch 'master' of =
git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect bad 2ae3e655fc40f1b6620194b90dcf9a4515257918
# bad: [4f2a367612d46dff2068582feadfbdd8e1c0443f] Merge branch 'fs-next' of=
 linux-next
git bisect bad 4f2a367612d46dff2068582feadfbdd8e1c0443f
# bad: [d3da7ed72840f3660f90966490adfd499d96ea8f] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect bad d3da7ed72840f3660f90966490adfd499d96ea8f
# good: [6355edbb3dfe322f0748b1eb3987973a568bbb42] Merge tag 'v6.11-rockchi=
p-dts64-2' of https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-r=
ockchip into soc/dt
git bisect good 6355edbb3dfe322f0748b1eb3987973a568bbb42
# good: [2073cda629a47f2ebe2afcd3cb8b3000d5cd13d1] mm: optimization on page=
 allocation when CMA enabled
git bisect good 2073cda629a47f2ebe2afcd3cb8b3000d5cd13d1
# good: [91a2b5b12867f77dc68d2d15ec7381e6e43820cb] Merge branch 'perf-tools=
-next' of git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git
git bisect good 91a2b5b12867f77dc68d2d15ec7381e6e43820cb
# bad: [b8c38a39b6ee44b02ee563b60439f417fec441ad] Merge branch 'for-next/pe=
rf' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git
git bisect bad b8c38a39b6ee44b02ee563b60439f417fec441ad
# good: [c100216635e922f43d9e783da918a749995350ca] Merge branch 'for-next/v=
cpu-hotplug' into for-next/core
git bisect good c100216635e922f43d9e783da918a749995350ca
# bad: [fafb823fc82dfb746cc9043b1573c4b29ef1d52a] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/rmk/linux.git
git bisect bad fafb823fc82dfb746cc9043b1573c4b29ef1d52a
# bad: [8d46f9dd06378e346a562c75bc2a260a03abe807] csky: convert to generic =
syscall table
git bisect bad 8d46f9dd06378e346a562c75bc2a260a03abe807
# good: [57029ba74296a4dafe35f147e88d56d8ae7b69da] kbuild: add syscall tabl=
e generation to scripts/Makefile.asm-headers
git bisect good 57029ba74296a4dafe35f147e88d56d8ae7b69da
# good: [ea0130bf3c45f276b1f9e005eeb255a80a10358b] arm64: convert unistd_32=
=2Eh to syscall.tbl format
git bisect good ea0130bf3c45f276b1f9e005eeb255a80a10358b
# bad: [b2595bdb3eb3fe24137d0bd07a51bc622f068a81] arm64: rework compat sysc=
all macros
git bisect bad b2595bdb3eb3fe24137d0bd07a51bc622f068a81
# bad: [6e4a077c0b607c674536908c5b68f1c31e4e26ec] arm64: generate 64-bit sy=
scall.tbl
git bisect bad 6e4a077c0b607c674536908c5b68f1c31e4e26ec
# first bad commit: [6e4a077c0b607c674536908c5b68f1c31e4e26ec] arm64: gener=
ate 64-bit syscall.tbl

--Qf0YYqoW3KQMZ1o1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaNch4ACgkQJNaLcl1U
h9D3rQf8CZ9gPfX054uMomNs1xS6dBXwr9es5isGNpgMC9ccGAhNPLutJvRWDgKW
pl3YBDyLIoQHGQtB/r9DIQuPQg0xF5ZI80itka6yRvmgnCcTovgdRGgBc9Z549Dl
epxlzSquqEILa8rpTPxywHpu8pFGCNaQhZ/e5shUH1gOWDaOE8WU7jI2MDRD9sLa
I5OD24mUtFHH1kpgNBJRESf4bYcVgM7EYm9spMdd0lb8zjIIUqTJiUKyInyKTNIt
qEAIsEdOMoMTi/9FPetku+lxZQgd78juowTgoODixlanZuEnMqVPQYpeX2UZegOe
cpcjrctAmtncTMv6mtWg5YwE3OQSNA==
=WV1l
-----END PGP SIGNATURE-----

--Qf0YYqoW3KQMZ1o1--


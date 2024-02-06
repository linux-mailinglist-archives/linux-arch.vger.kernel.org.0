Return-Path: <linux-arch+bounces-2100-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE78D84BA7C
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 17:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A485B290717
	for <lists+linux-arch@lfdr.de>; Tue,  6 Feb 2024 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4241339AB;
	Tue,  6 Feb 2024 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV0B3eTO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C414134CE4;
	Tue,  6 Feb 2024 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235293; cv=none; b=ckmQvChR15+fdLewK1QxLdz1hQEbjxBXaHrPn+1NLFbncAp0Be0oUxOxqvTiuzBhDZMVw88rREtuxk5BMF65NfBYrxMQh+3gibFE6o0Ff6nREbP+ahkZR5giFH4Rm/OUA+i4tKdm1+aL7X1CbBTWuhsP0rezI9LESdhoLdvKAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235293; c=relaxed/simple;
	bh=aRQxl0C0V0705HuiquTkhHHqPboA18NaqgotYv9rCA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2mEI0WOsEOiPXPLgognY8Zh6RFkqDX+qNFVO+7CLVQ03VCs+rs2Ua3ll4yHAFFyOXsykoY3AVnsZvc+IfcmJ8MBV85E2sMqchT13eS+84NGZ5HJ6RWNnCGMjzoblEmyGCiUfKZifi63Kf3C7swE/LBFIgtBZsfQx9p83BqxR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV0B3eTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2BAC433F1;
	Tue,  6 Feb 2024 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707235291;
	bh=aRQxl0C0V0705HuiquTkhHHqPboA18NaqgotYv9rCA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PV0B3eTOaNjzcvWs65Me6RDLhFj8YGByJ83V31ytWUnS8qhWSmRMRl0l5zr6Ky/HI
	 V8VB3bU4h1IvUqAnjW+GixZAPSitutZKlnNNQsb3zhPpetctNotMxhcs+16kpERvcI
	 QJlKVt1MUAwmmTLtRKPv+7kMaAaYKnrgHOiLqelYjBoBJh2c90qyMuKpsBQaLV4ixc
	 x4u/dAvjHm8aNECN3GpgyoQDyFjLJi59680J1T/oC03fzuisXQvW2y2jFqQGwm715y
	 2X7DJSP2x6Oz8DlvjQGm4xWPmxiPaAXHidpqbvV2Qg4SWxurgjdXViSVHc8zyfhu2V
	 +S947qR7PCFqA==
Date: Tue, 6 Feb 2024 16:01:28 +0000
From: Mark Brown <broonie@kernel.org>
To: debug@rivosinc.com
Cc: rick.p.edgecombe@intel.com, Szabolcs.Nagy@arm.com,
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
Subject: Re: [RFC PATCH v1 15/28] riscv/mm: Implement map_shadow_stack()
 syscall
Message-ID: <ZcJX2IJb0hOM5RF5@finisterre.sirena.org.uk>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-16-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ywwgCSX0zhXuCNZ"
Content-Disposition: inline
In-Reply-To: <20240125062739.1339782-16-debug@rivosinc.com>
X-Cookie: You might have mail.


--3ywwgCSX0zhXuCNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 10:21:40PM -0800, debug@rivosinc.com wrote:

> As discussed extensively in the changelog for the addition of this
> syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
> existing mmap() and madvise() syscalls do not map entirely well onto the
> security requirements for guarded control stacks since they lead to
> windows where memory is allocated but not yet protected or stacks which
> are not properly and safely initialised. Instead a new syscall
> map_shadow_stack() has been defined which allocates and initialises a
> shadow stack page.

While I agree that this is very well written you probably want to update
the references to guarded control stacks to whatever the RISC-V term is :P

> --- a/include/uapi/asm-generic/mman.h
> +++ b/include/uapi/asm-generic/mman.h
> @@ -19,4 +19,5 @@
>  #define MCL_FUTURE	2		/* lock all future mappings */
>  #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
> =20
> +#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token=
 in the shadow stack */
>  #endif /* __ASM_GENERIC_MMAN_H */

For arm64 I also added a SHADOW_STACK_SET_MARKER for adding a top of
stack marker, did you have any thoughts on that for RISC-V?  I think x86
were considering adding it too, it'd be good if we could get things
consistent.

--3ywwgCSX0zhXuCNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXCV9cACgkQJNaLcl1U
h9DovAf+LgWdOKedTbffoEJgm3iDVrzzlW/jko7UF4Sjg6Gv0ngCJGWQIzvYEk/w
B/3v/8xatJ9n+VbKX606intt/LsnRYDNTB3OVDKogBCeRo6NPl26QjEqt8lQQtSa
po1FZcEIfdjmxWOCphm0MYLR97sxtDs+07Y6SOdoEFyowqDP9y7VIHR4juOy0RyJ
tpKpA1fORTVxP50RQT+V9GZ9zuV6FL2C5ULfahB+o6W6r/wmVlSWdsFkwdnayCKv
9DqlaPDQoklRZRy6bgUPTHyc1b6suEgg2G6Om/Pzd7Z3snoiyeDBoqMgMWOhAa1r
XYbr9H4oCPUEs0ONOGZmAcXzGu7kIQ==
=mDMz
-----END PGP SIGNATURE-----

--3ywwgCSX0zhXuCNZ--


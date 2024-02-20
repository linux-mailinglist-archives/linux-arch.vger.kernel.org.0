Return-Path: <linux-arch+bounces-2513-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C9B85C3E7
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 19:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80C01F23D87
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAAE1353E0;
	Tue, 20 Feb 2024 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ev2f7jnX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC529130AD9;
	Tue, 20 Feb 2024 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454752; cv=none; b=IGfDcPvzvECtlz1Xb1dSYBTIyQiapvNKGaaHHDXxF1X1tgdDETjb/3zv9Wa/6ayHXc1DfpI5FACo01oMVYtaK7JTCt0/lX0fJr7cofnbLAcGyHcHNLSo0o+FILm6p7gM/y++c5GOiNOw2Wg1QGoWWrRZIJPr7pjF7Ix9D9He5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454752; c=relaxed/simple;
	bh=WTrXf4SbMFDefrf4t0yXfJ+Qx9gR2qrGFB/qrjo+/UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEfUiRqkdpKlReHvyVYs5dtSfpEhKJlrZEQJKQfGugSxtxjKTDP/i1Gjj7epwCdzuB3Pi3ziuPEMN2E52f8huDv7CT+iXCqaqr1+f2TNO+rVKwWllw81JAc8UXxIMnU+i+Zos0ruWM7ZkYk6wa6D28k7HI1pkdvCgjw9SGCMOtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ev2f7jnX reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A89EF40E0192;
	Tue, 20 Feb 2024 18:45:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7SLPSg4QRKna; Tue, 20 Feb 2024 18:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708454738; bh=M5JyPXMACvJDaoY+/xJBALRa25X6wvkga3r70XUpxdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ev2f7jnXwAUt0ub/SLZVKPipxoDAEpL6j+bWEC9DDMKiixTTpnFZgXCRvxQ5lLu8I
	 locy+RvHh/r5FQReiCaoe5R9/d4cOFG7YCQWxmmN2TCHbKl6E52UkoIK9N2eyU2U7L
	 CF1DWmLKEN9G0sytRXX9DvzXclYaq6gHdw7MynBS3nzY5RAbBuL0vfkgRx3cHCIeeh
	 wxqVVzkkJWsCK5WmtSvls8JqbhRVnpCIbosa32022myuucg7SOVu1tRvhX2VL6vPjs
	 1HBxCcdKDSFs6TRtxmvTaBCALulRF74c0B0M8fbzxwPSyDQ54EFmSMjLsd7akdIJzP
	 +DEOLtQzXPUi1M4729nWia7bSm7QsO/Cc9iZ05IGGvE10KYJvrzcn7Mq2kYRlQQ1n0
	 5rPkjgscnRF67PkChNhBwZli2Jkz+Do0cFl/c04Omaiun4BsrhORUeFxOkQDCQ5eWd
	 uC5DA7kxzfXQ1Bu7+Dk81WH92zi3eL0135xjSiiYGPD8p4AGcRoKgRE4zmSLO255B/
	 oSVHUCtx+wnS3fwKjuvjcNy5Z+sGdV/vlKt0t6RJyDHjlYNtMVLJNBm1TTFT6LowXw
	 wjWkTEJeBDk9oNDB9P4aIGmnPLPtWq1kuW2yJp/dd5JTuDa8GWAoJw3Rhmi0uVFZJa
	 FEC5IeloOusbjbL1Qx7YFQgw=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AFABB40E01BB;
	Tue, 20 Feb 2024 18:45:19 +0000 (UTC)
Date: Tue, 20 Feb 2024 19:45:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 04/11] x86/startup_64: Defer assignment of 5-level
 paging global variables
Message-ID: <20240220184513.GAZdTzOQN33Nccwkno@fat_crate.local>
References: <20240213124143.1484862-13-ardb+git@google.com>
 <20240213124143.1484862-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240213124143.1484862-17-ardb+git@google.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 01:41:48PM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>=20
> Assigning the 5-level paging related global variables from the earliest
> C code using explicit references that use the 1:1 translation of memory
> is unnecessary, as the startup code itself does not rely on them to
> create the initial page tables, and this is all it should be doing. So
> defer these assignments to the primary C entry code that executes via
> the ordinary kernel virtual mapping.
>=20
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/kernel/head64.c | 44 +++++++-------------
>  1 file changed, 14 insertions(+), 30 deletions(-)

Whoops:

arch/x86/kernel/head64.c: In function =E2=80=98x86_64_start_kernel=E2=80=99=
:
arch/x86/kernel/head64.c:442:17: error: =E2=80=98__pgtable_l5_enabled=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98pgtabl=
e_l5_enabled=E2=80=99?
  442 |                 __pgtable_l5_enabled    =3D 1;
      |                 ^~~~~~~~~~~~~~~~~~~~
      |                 pgtable_l5_enabled
arch/x86/kernel/head64.c:442:17: note: each undeclared identifier is repo=
rted only once for each function it appears in
make[4]: *** [scripts/Makefile.build:243: arch/x86/kernel/head64.o] Error=
 1
make[3]: *** [scripts/Makefile.build:481: arch/x86/kernel] Error 2
make[2]: *** [scripts/Makefile.build:481: arch/x86] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/2nd/linux/Makefile:1921: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


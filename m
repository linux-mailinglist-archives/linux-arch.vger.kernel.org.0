Return-Path: <linux-arch+bounces-10740-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F5A5FC1B
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 17:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECFE3A91E6
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E5267B77;
	Thu, 13 Mar 2025 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXsvsd/l"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12AF26138E;
	Thu, 13 Mar 2025 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883991; cv=none; b=KhwbwWqMWRm0fTT47asWkw6iFJA0taVVZjmIxa5hdKi+F0wu6gYp0k2LyF07N7WGbPVfPNihF0tWaGcLcFvddtBNBCbpRWsN805B3ToRGYw7X/9a8qUlQAiA3OC6sOChcMBfco8BennWNfHFI3VpFT6pRfFY7EQh24OSAoC8E08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883991; c=relaxed/simple;
	bh=SJIh4TOyAnLQgRaND+z2LtBYQ5hvnSYhcxMltVARNHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+1b24Se3NuAf3wUSTzIYAGpvk7IeLMCrMrce5qqLvr3ixHgtMkHf9caXcuLpeqcDC4MLAgVLwl3m+8gQTmeGZgk3PxtbjngM1cHZHcYIWjxN2uq6C1qJKtP+R6R2XRadtwxi27rjm3YZlNgaOO9HquW01ojwDpxQzD9ltrS7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXsvsd/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112F0C4CEDD;
	Thu, 13 Mar 2025 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741883990;
	bh=SJIh4TOyAnLQgRaND+z2LtBYQ5hvnSYhcxMltVARNHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXsvsd/lxGJNEoAX6HtYBN5kSEz6YHB6jkvfmSGlAYkaC6zejLPn/jhjOGbnxowV9
	 G4ObNvl3IBz4OwYO2TlZ/bLh8DZduHi5CkgzYMn1CVOppgH6xx0HzA9IMhHkCryYCY
	 ZnelQtcYuqYVLCo8RDAfcA5wrN0rilAxNY4bxJB3K1CqJlX1tG+a3qgJkkTCsPFO7h
	 mIMi9CWIvAGiys0Idmh6XXVvAFEOzxC+aoae1uw6WzZghXN98gnejmZ33szJK51KlP
	 WWbGYBsBTpQxs6TW4o+VUbqyqW8YHpq93CdsecoGwYUTU6EUH46GDnnPb9iVFpOFP+
	 OQMV0Bj8JCyMQ==
Date: Thu, 13 Mar 2025 16:39:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 00/13] arch, mm: reduce code duplication in mem_init()
Message-ID: <5de71a98-d87f-4bfd-83a1-3f6e11c84d7d@sirena.org.uk>
Mail-Followup-To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
References: <20250313135003.836600-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2QbfUHTxTDOlgUSw"
Content-Disposition: inline
In-Reply-To: <20250313135003.836600-1-rppt@kernel.org>
X-Cookie: A beer delayed is a beer denied.


--2QbfUHTxTDOlgUSw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2025 at 03:49:50PM +0200, Mike Rapoport wrote:

> v2 changes:
> * don't use generic version for setting high_memory on architectures
>   that use that varialble earlier than free_area_init()
> * use memblock_alloc_or_panig() to allocate zero pages on MIPS and s390
> * fix alignment in allocation of zero pages on s390
> * add Acked-by

This resolves the issues for 32 bit arm, at least the v7 boards:

Tested-by: Mark Brown <broonie@kernel.org>

My v5 and v6 boards are having issues but I think that's unrelated
infrastructure (in one case definitely so).

--2QbfUHTxTDOlgUSw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfTCkgACgkQJNaLcl1U
h9BPbAf/SDBWCt481g26uw69KoHpeH2cGq0Z5NH3zUIIBiu3gpRrex/BeLXVuY79
d57+lsymFEsgnNbhXNvzjAzmaRTSMBu9C1S5o4Jo3+sz8kEnBS/myycnCrbU+lVy
9R4LmwA4hhMZw2+UhgRPVFMTjd7fsFFLAsxmHyCheEOGfLGKMTKleusqFbK2phbu
IrDc/IU6mCxqGrgZ3lO0fV7w2SfpkBANi9bXJz7aeAbqsOBeVyLCKgAL/gsbZxDZ
g6Y0lOdm1gfigEHb8d5DiireqslCdgHnoH90rRI+3YBQiT8QOJLd/3W3G7YrKPNy
/ufJa9n1CuXbfkYbynfJxmTOHNUPHw==
=M7tK
-----END PGP SIGNATURE-----

--2QbfUHTxTDOlgUSw--


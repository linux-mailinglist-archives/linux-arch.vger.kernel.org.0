Return-Path: <linux-arch+bounces-10681-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190CDA5E04B
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 16:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B22A175B56
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 15:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D924DFF8;
	Wed, 12 Mar 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky/BCax3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581F23E33F;
	Wed, 12 Mar 2025 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793180; cv=none; b=aqil8AIHOJDD1Km5UqTL/ph0h2l6lzt8KRkfKj5UCCVWxUS5Qck+E/RzuNsUTID9x38DqjObD9G4N0w9Fx2FWqtxYiu2Jl7HffQ8SaRScfCYVgCZgLppM1kp1/ZKTtCT4sBZ0CJne26G5mmisGwVziSsrlkAzdnfs8zq34FEyVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793180; c=relaxed/simple;
	bh=Q7awIL7HKUND4G5BgT8sxgfvPYxZ5dldw9MgDhs69ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvlOj8xDiy39wtexLiuc8/e4guuSZNCJajkCPIUiGsXCuvTJfAvU/OqX55lXa7SLnO0gg7EmZ0Y7gquwiS8n/T+OPIng0G1VLYGngXzlpdLRJ431baq8zeUnUXeqTNzXFZu+jLknrh9LrbUGdSTVNkFiT+zrWb/sDtI7jwFGOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky/BCax3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2A9C4CEDD;
	Wed, 12 Mar 2025 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741793179;
	bh=Q7awIL7HKUND4G5BgT8sxgfvPYxZ5dldw9MgDhs69ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ky/BCax3DFeowvZEZBaSvHz/FRjz1Ff2w3mZvorveefBQ9QItq7spH+9lPk04kMHc
	 XFcWV+q8BLDxTsMg3kWEEMrJvLlM02Ov9qT4y5J6eushhPAVsWOV5ed7v5on6xpI5H
	 t1Jida96hvmMXnQmaaYU62DS/XhHnkqgw1xy5aAbcXTY7h92ihBZ7RpuPzMnvvZIID
	 4Llux6n6amMPvoDVic/J1BHmAr19Dq0COPgBWULz9Gberd6x0wlqoRfavURfSg5lJv
	 0Xm3eB6wpryKJveHw8pu/I7JXnt8N5CGgjBp/ANgLyo/AFa/GXs+sbZv0RiHoWV9rf
	 Q6NAbrOOruTNw==
Date: Wed, 12 Mar 2025 15:26:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
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
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <6d3be692-3dc3-400c-8eeb-3d378adc8dbe@sirena.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
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
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	Mike Rapoport <rppt@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
 <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk>
 <Z9Cl8JKkRGhaRrgM@kernel.org>
 <5e40219b-f149-4e0f-aa10-c09fa183945e@sirena.org.uk>
 <CAMuHMdUGnBeo69NkYsv35YHp6H9GJSu-hoES2A8_0WhpX1zFhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="auPMsTU3HApbt9PI"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUGnBeo69NkYsv35YHp6H9GJSu-hoES2A8_0WhpX1zFhQ@mail.gmail.com>
X-Cookie: You will outgrow your usefulness.


--auPMsTU3HApbt9PI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2025 at 10:41:28PM +0100, Geert Uytterhoeven wrote:
> On Tue, 11 Mar 2025 at 22:33, Mark Brown <broonie@kernel.org> wrote:

> > [    0.000000] efi: UEFI not found.
> > [    0.000000] cma: Reserved 64 MiB at 0x00000000

> > - I'd only been sampling the logs for the physical platforms, none of
> > which had shown anything.

> Hangs that early need "earlycon", which the qemu boot above does have.

Indeed, the physical platforms either don't support earlycon or I just
don't wire it up as standard in my CI.  I see a fix should already be on
the way, but FWIW the physical platforms do seem to have bisected to the
same commit.

--auPMsTU3HApbt9PI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfRp40ACgkQJNaLcl1U
h9ClrAf9FHrCQNmJXN4iyTK9lTj/btaMWsS34HTwQo5atjLix3MlaM4Oe1X8wWdQ
rSJgppPAE2cv7YjUDvJGyXeNJEiBsMtnourIYIcXwHIlSknwUTW93aLuOShlc+KF
iC2gJoynMVm1M0mcCvUSxVXjQXN1rxY3pcXLx99UJqFnR+uWkHqfKq18AdWJzzrD
MwKz6EmBguL6eE0EstxjYPLlpJ3iYWORVdj2/2h3DYrRMLDlV+dm/xW9xGlq5sxJ
c/3bxdgHyKWQqTxjQsPQKSz99U2Amjx1VloV+6yG9htGbdo+yNQv+tUP20dHw9c8
ECZ91Jtf4LTcMPjk/IfIVIr0Hu3V3w==
=0Ulf
-----END PGP SIGNATURE-----

--auPMsTU3HApbt9PI--


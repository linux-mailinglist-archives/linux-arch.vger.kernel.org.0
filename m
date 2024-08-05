Return-Path: <linux-arch+bounces-6006-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99982948386
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 22:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6691F236B1
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 20:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAD8145FE2;
	Mon,  5 Aug 2024 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd1QNmGh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C193D1422D3;
	Mon,  5 Aug 2024 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890003; cv=none; b=dvPMpvUA7mF4XUO9HcNudPArvBL2sQ58qsJPLwIHjO04whKlAnjg+MM6RPisvB6VNbiIvqsunotRpEctYwVbBWtHa9htRNeIFOwWsvSQciSIvalMAOVd9Io5PKUYcbvdvYxnwobp45VNHwjD/TF2jrnLs0oQsgAgdYUvH0TBmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890003; c=relaxed/simple;
	bh=WsM7t+wQZsJ9S/+ASKwjmeDyYoTIHz5SBNGINBoSOuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/hPMUli5A61AHo5EVk7wbO244PvOIAsbi5CXR6SnKJhl9hOAGtmUQuWoav+Cz2j7JoVFpNjMh2OGyd4BFGqfKZ+Ty7T/YzH99EXSQywl/w99PnCrMJBM435o9EPTn624586lNu1/IY2lIyPL1L6wICHZx6ft4XBcqmhgyyKf3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bd1QNmGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7F0C32782;
	Mon,  5 Aug 2024 20:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722890003;
	bh=WsM7t+wQZsJ9S/+ASKwjmeDyYoTIHz5SBNGINBoSOuQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bd1QNmGhqizx1N751/MDe3BwJ5eBe0NEkA1Rr9ZhC+eoKCB7ItNpl8AQ+V3nx8Zo0
	 R4FzjtwIhnEONdOTdxHMHvBlRal9Gl9d6xbPnf9m+/xNSnrXPCOtS+ISQwpdE+oqvT
	 EQLI2vbby9JFVlMiTINdm1eyjvxtjK+Qqi19H1bumnvKGUMN3mjuLjghctOfYyxKZ7
	 peqQ7EpcMm/mJ3OMspP/e+6opST+C2D1kvgCgPGinENVrRGBCwV8RpJwib72ZpAFJt
	 HoWEvX5GLpcA9P3DXldxQanhVroc/OQw43vqdDX3e4x/cRX4L5chUx3Fsgr3ddvO07
	 QLQ2+2IOOyrRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D4443CE0A34; Mon,  5 Aug 2024 13:33:22 -0700 (PDT)
Date: Mon, 5 Aug 2024 13:33:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, torvalds@linux-foundation.org, arnd@arndb.de,
	geert@linux-m68k.org, palmer@rivosinc.com, mhiramat@kernel.org,
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: Re: [PATCH cmpxchg 3/3] sh: Emulate one-byte cmpxchg
Message-ID: <3f62ef41-aa71-4483-b0bd-cdd5e1caab38@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <c1b7f3a2-da50-4dfb-af6f-a1898eaf2b79@paulmck-laptop>
 <20240805192119.56816-3-paulmck@kernel.org>
 <d36d1c197bed83f91299e5cf211ecc4169d3b7a1.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d36d1c197bed83f91299e5cf211ecc4169d3b7a1.camel@physik.fu-berlin.de>

On Mon, Aug 05, 2024 at 10:13:38PM +0200, John Paul Adrian Glaubitz wrote:
> On Mon, 2024-08-05 at 12:21 -0700, Paul E. McKenney wrote:
> > Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on sh.
> > 
> > [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
> > [ paulmck: Apply feedback from Naresh Kamboju. ]
> > [ Apply Geert Uytterhoeven feedback. ]
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Andi Shyti <andi.shyti@linux.intel.com>
> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: <linux-sh@vger.kernel.org>
> > ---
> >  arch/sh/Kconfig               | 1 +
> >  arch/sh/include/asm/cmpxchg.h | 3 +++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > index 1aa3c4a0c5b27..e9103998cca91 100644
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -14,6 +14,7 @@ config SUPERH
> >  	select ARCH_HIBERNATION_POSSIBLE if MMU
> >  	select ARCH_MIGHT_HAVE_PC_PARPORT
> >  	select ARCH_WANT_IPC_PARSE_VERSION
> > +	select ARCH_NEED_CMPXCHG_1_EMU
> >  	select CPU_NO_EFFICIENT_FFS
> >  	select DMA_DECLARE_COHERENT
> >  	select GENERIC_ATOMIC64
> > diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
> > index 5d617b3ef78f7..1e5dc5ccf7bf5 100644
> > --- a/arch/sh/include/asm/cmpxchg.h
> > +++ b/arch/sh/include/asm/cmpxchg.h
> > @@ -9,6 +9,7 @@
> >  
> >  #include <linux/compiler.h>
> >  #include <linux/types.h>
> > +#include <linux/cmpxchg-emu.h>
> >  
> >  #if defined(CONFIG_GUSA_RB)
> >  #include <asm/cmpxchg-grb.h>
> > @@ -56,6 +57,8 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
> >  		unsigned long new, int size)
> >  {
> >  	switch (size) {
> > +	case 1:
> > +		return cmpxchg_emu_u8(ptr, old, new);
> >  	case 4:
> >  		return __cmpxchg_u32(ptr, old, new);
> >  	}
> 
> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thank you very much!  I will apply this on my next rebase.

							Thanx, Paul


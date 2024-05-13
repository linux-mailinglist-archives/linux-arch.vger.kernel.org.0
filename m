Return-Path: <linux-arch+bounces-4358-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8D18C4473
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 17:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640E11F21671
	for <lists+linux-arch@lfdr.de>; Mon, 13 May 2024 15:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3A154425;
	Mon, 13 May 2024 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwVQaCAv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00678154423;
	Mon, 13 May 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614889; cv=none; b=P9vDlcs3xR3XU+wGLF+Vga2OEMVb/K6cjbW76K8ffpfGEV0WH9c2f5lFZzzn4nj90Z+Fw/yXQDtj+54/cXvCnhcaOxMgAw8ESDVPcJTDUlP6WHKmsent2NimpbWqFARXAKZnYFMdixOPkMEb1rAS5qouH3vRukmw6mvlClh6EXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614889; c=relaxed/simple;
	bh=Hvp9K3Nukx7bFs9dk3v6vlcgXi38ZnEEGAY0iMIbTeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUA+oDwBXC4RJ3GciJSu4rf/iPgA+VZrWM3n/wuYAFMFd6QuaT0BqmjSeQo8/pufNVAU/t9C+eBXK+f1A3xAuRoEL+Ze2FHK7x/geaEmAx3923rJKqD/RMUbWe+wji6+LZUSiHml4jDWTMkEsw166xPSI7KHy2ktJxDdM6XON40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwVQaCAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA4AC113CC;
	Mon, 13 May 2024 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715614888;
	bh=Hvp9K3Nukx7bFs9dk3v6vlcgXi38ZnEEGAY0iMIbTeU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=TwVQaCAvDx8oLwMz9CvJqgDmjTriYTfvi8aIhNUKMejXqOFgTakr2zKQzKChPxavs
	 cJt7YgqjhUtJv8QjivcnZZoQpam0F2SZJCAhjAjE20P7+v0viX5c4VOqx4SUV4yVEF
	 2aQKrmIx+vOFoVj0e4rESMO/4Zcd1wjwrnHIMBv0q7Bt+x66QoLvL4sG9tav8uFq6b
	 R5ZUU8XQjDuBkWPGdzQMap6qZGTPrhuxZh1sc9uQ3avsaticKJBPFDzmHmqDxSJMPE
	 8LzgwP4qmeAOM59AMctT4DdVDmuYLx9oyamtwDs3MX+e3fJAE2zj4tqjUyd11lggcH
	 CPIAEFjUdJtlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 01950CE0448; Mon, 13 May 2024 08:41:27 -0700 (PDT)
Date: Mon, 13 May 2024 08:41:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com
Subject: Re: [PATCH v2 cmpxchg 09/13] lib: Add one-byte emulation function
Message-ID: <9f0ff126-2806-488e-97cc-7258eff0c574@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-9-paulmck@kernel.org>
 <ZkInMNOsLO5XbDj5@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkInMNOsLO5XbDj5@boqun-archlinux>

On Mon, May 13, 2024 at 07:44:00AM -0700, Boqun Feng wrote:
> On Wed, May 01, 2024 at 04:01:26PM -0700, Paul E. McKenney wrote:
> > Architectures are required to provide four-byte cmpxchg() and 64-bit
> > architectures are additionally required to provide eight-byte cmpxchg().
> > However, there are cases where one-byte cmpxchg() would be extremely
> > useful.  Therefore, provide cmpxchg_emu_u8() that emulates one-byte
> > cmpxchg() in terms of four-byte cmpxchg().
> > 
> > Note that this emulations is fully ordered, and can (for example) cause
> > one-byte cmpxchg_relaxed() to incur the overhead of full ordering.
> > If this causes problems for a given architecture, that architecture is
> > free to provide its own lighter-weight primitives.
> > 
> > [ paulmck: Apply Marco Elver feedback. ]
> > [ paulmck: Apply kernel test robot feedback. ]
> > [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
> > 
> > Link: https://lore.kernel.org/all/0733eb10-5e7a-4450-9b8a-527b97c842ff@paulmck-laptop/
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Acked-by: Marco Elver <elver@google.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: <linux-arch@vger.kernel.org>
> > ---
> >  arch/Kconfig                |  3 +++
> >  include/linux/cmpxchg-emu.h | 15 +++++++++++++
> >  lib/Makefile                |  1 +
> >  lib/cmpxchg-emu.c           | 45 +++++++++++++++++++++++++++++++++++++
> >  4 files changed, 64 insertions(+)
> >  create mode 100644 include/linux/cmpxchg-emu.h
> >  create mode 100644 lib/cmpxchg-emu.c
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 9f066785bb71d..284663392eef8 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1609,4 +1609,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
> >  	# strict alignment always, even with -falign-functions.
> >  	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
> >  
> > +config ARCH_NEED_CMPXCHG_1_EMU
> > +	bool
> > +
> >  endmenu
> > diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
> > new file mode 100644
> > index 0000000000000..998deec67740a
> > --- /dev/null
> > +++ b/include/linux/cmpxchg-emu.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Emulated 1-byte and 2-byte cmpxchg operations for architectures
> > + * lacking direct support for these sizes.  These are implemented in terms
> > + * of 4-byte cmpxchg operations.
> > + *
> > + * Copyright (C) 2024 Paul E. McKenney.
> > + */
> > +
> > +#ifndef __LINUX_CMPXCHG_EMU_H
> > +#define __LINUX_CMPXCHG_EMU_H
> > +
> > +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> > +
> > +#endif /* __LINUX_CMPXCHG_EMU_H */
> > diff --git a/lib/Makefile b/lib/Makefile
> > index ffc6b2341b45a..cc3d52fdb477d 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -236,6 +236,7 @@ obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
> >  lib-$(CONFIG_GENERIC_BUG) += bug.o
> >  
> >  obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> > +obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_EMU) += cmpxchg-emu.o
> >  
> >  obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
> >  #ensure exported functions have prototypes
> > diff --git a/lib/cmpxchg-emu.c b/lib/cmpxchg-emu.c
> > new file mode 100644
> > index 0000000000000..27f6f97cb60dd
> > --- /dev/null
> > +++ b/lib/cmpxchg-emu.c
> > @@ -0,0 +1,45 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Emulated 1-byte cmpxchg operation for architectures lacking direct
> > + * support for this size.  This is implemented in terms of 4-byte cmpxchg
> > + * operations.
> > + *
> > + * Copyright (C) 2024 Paul E. McKenney.
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/export.h>
> > +#include <linux/instrumented.h>
> > +#include <linux/atomic.h>
> > +#include <linux/panic.h>
> > +#include <linux/bug.h>
> > +#include <asm-generic/rwonce.h>
> > +#include <linux/cmpxchg-emu.h>
> > +
> > +union u8_32 {
> > +	u8 b[4];
> > +	u32 w;
> > +};
> > +
> > +/* Emulate one-byte cmpxchg() in terms of 4-byte cmpxchg. */
> > +uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new)
> > +{
> > +	u32 *p32 = (u32 *)(((uintptr_t)p) & ~0x3);
> > +	int i = ((uintptr_t)p) & 0x3;
> > +	union u8_32 old32;
> > +	union u8_32 new32;
> > +	u32 ret;
> > +
> > +	ret = READ_ONCE(*p32);
> > +	do {
> > +		old32.w = ret;
> > +		if (old32.b[i] != old)
> > +			return old32.b[i];
> > +		new32.w = old32.w;
> > +		new32.b[i] = new;
> > +		instrument_atomic_read_write(p, 1);
> > +		ret = data_race(cmpxchg(p32, old32.w, new32.w)); // Overridden above.
> 
> Just out of curiosity, why is this `data_race` needed? cmpxchg is atomic
> so there should be no chance for a data race?

That is what I thought, too.  ;-)

The problem is that the cmpxchg() covers 32 bits, and so without that
data_race(), KCSAN would complain about data races with perfectly
legitimate concurrent accesses to the other three bytes.

The instrument_atomic_read_write(p, 1) beforehand tells KCSAN to complain
about concurrent accesses, but only to that one byte.

							Thanx, Paul

> Regards,
> Boqun
> 
> > +	} while (ret != old32.w);
> > +	return old;
> > +}
> > +EXPORT_SYMBOL_GPL(cmpxchg_emu_u8);
> > -- 
> > 2.40.1
> > 


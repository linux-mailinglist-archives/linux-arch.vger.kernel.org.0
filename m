Return-Path: <linux-arch+bounces-4328-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF698C31ED
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 16:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE0F281D4B
	for <lists+linux-arch@lfdr.de>; Sat, 11 May 2024 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A50553373;
	Sat, 11 May 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/lQUeb4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8D651034;
	Sat, 11 May 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715438998; cv=none; b=b64zNpQWSYZ9l0f+2R/aq24A2tDMpBoxIuvZP7llBRNChn71vsuUpuFXO8da2eJrzhnW0+3E4xRMfE22QMwLlBxXCkFEnWiBMztJnI1RNaDRfck/MGabD4tL20QKvKqADZnpOG1bNKxuxcXVegfI1mXLaH4tTkTTM0+qNlFeiVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715438998; c=relaxed/simple;
	bh=QbbdrQveR5xbMbt67/DpPuiLYhLi955nnL7HY0R44nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGRxFnPVpE3LiKevZlw76k0NQK7hSBk6Dmb0cyZu8ZlaM2AhmbrVf1d6piY3O9gXSmRKp5cgs9oJ/WOHQUsLOHhmHgC741V3KCGzYjYywXrns22D0OKCnc8VjXROVoBPqF6SDFMnPlOxQ4AMIFGKoN0m1/3kllIHszgUu89ReaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/lQUeb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EE8C2BBFC;
	Sat, 11 May 2024 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715438997;
	bh=QbbdrQveR5xbMbt67/DpPuiLYhLi955nnL7HY0R44nE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=G/lQUeb48/utL53AUg3ouEfD29EcUaDkgrTde+SsHUCbtSirckCkGGSRqUqHbPyVs
	 ca23txNLpT0+LvuQRtKlGYzne7+NWVFr/FYbIl7yUkli72wWparmtnSSrg9WjnzcKr
	 2NcbFWd7mg5rY+gE0jGJiWvqvITCQgnsEXzk1YC6k+Xam42tGBzqdeFjxKjduCNDqi
	 BnpA/dBi/6jrRnxuD400ApXRQQqlygZip5qmyccRRe4xo+XHfPkq21tLI7PT2PR4fQ
	 TJV3UDwMUtokAjJ7Q13uWmINJevbdSAwfngcY7r7bEfdGNAu/B6rFa1/zegJQQHP/I
	 locwagLJkcd/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1A564CE0F8E; Sat, 11 May 2024 07:49:57 -0700 (PDT)
Date: Sat, 11 May 2024 07:49:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Yujie Liu <yujie.liu@intel.com>, linux-csky@vger.kernel.org
Subject: Re: [PATCH v2 cmpxchg 11/13] csky: Emulate one-byte cmpxchg
Message-ID: <e04e1fec-1e05-4ec7-baf9-63c5ad4061dd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-11-paulmck@kernel.org>
 <CAJF2gTQb1qW_GUiQBWiogBLX2geNGMFhOJK55ZKWJYyFqu-SSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTQb1qW_GUiQBWiogBLX2geNGMFhOJK55ZKWJYyFqu-SSQ@mail.gmail.com>

On Sat, May 11, 2024 at 02:42:17PM +0800, Guo Ren wrote:
> On Thu, May 2, 2024 at 7:01 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on csky.
> >
> > [ paulmck: Apply kernel test robot feedback. ]
> > [ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
> >
> > Co-developed-by: Yujie Liu <yujie.liu@intel.com>
> > Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Tested-by: Yujie Liu <yujie.liu@intel.com>
> > Cc: Guo Ren <guoren@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: <linux-csky@vger.kernel.org>
> > ---
> >  arch/csky/Kconfig               |  1 +
> >  arch/csky/include/asm/cmpxchg.h | 10 ++++++++++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> > index d3ac36751ad1f..5479707eb5d10 100644
> > --- a/arch/csky/Kconfig
> > +++ b/arch/csky/Kconfig
> > @@ -37,6 +37,7 @@ config CSKY
> >         select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
> >         select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
> >         select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
> > +       select ARCH_NEED_CMPXCHG_1_EMU
> >         select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
> >         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> >         select COMMON_CLK
> > diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
> > index 916043b845f14..db6dda47184e4 100644
> > --- a/arch/csky/include/asm/cmpxchg.h
> > +++ b/arch/csky/include/asm/cmpxchg.h
> > @@ -6,6 +6,7 @@
> >  #ifdef CONFIG_SMP
> >  #include <linux/bug.h>
> >  #include <asm/barrier.h>
> > +#include <linux/cmpxchg-emu.h>
> >
> >  #define __xchg_relaxed(new, ptr, size)                         \
> >  ({                                                             \
> > @@ -61,6 +62,9 @@
> >         __typeof__(old) __old = (old);                          \
> >         __typeof__(*(ptr)) __ret;                               \
> >         switch (size) {                                         \
> > +       case 1:                                                 \
> > +               __ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> > +               break;                                          \
> >         case 4:                                                 \
> >                 asm volatile (                                  \
> >                 "1:     ldex.w          %0, (%3) \n"            \
> > @@ -91,6 +95,9 @@
> >         __typeof__(old) __old = (old);                          \
> >         __typeof__(*(ptr)) __ret;                               \
> >         switch (size) {                                         \
> > +       case 1:                                                 \
> > +               __ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> > +               break;                                          \
> >         case 4:                                                 \
> >                 asm volatile (                                  \
> >                 "1:     ldex.w          %0, (%3) \n"            \
> > @@ -122,6 +129,9 @@
> >         __typeof__(old) __old = (old);                          \
> >         __typeof__(*(ptr)) __ret;                               \
> >         switch (size) {                                         \
> > +       case 1:                                                 \
> > +               __ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
> > +               break;                                          \
> >         case 4:                                                 \
> >                 asm volatile (                                  \
> >                 RELEASE_FENCE                                   \
> > --
> > 2.40.1
> >
> Reviewed-by: Guo Ren <guoren@kernel.org>
> 
> I will optimize it after ARCH_NEED_CMPXCHG_1_EMU is merged.

Thank you very much!  I have applied this and added it to my pull
request for the upcoming merge window.

							Thanx, Paul


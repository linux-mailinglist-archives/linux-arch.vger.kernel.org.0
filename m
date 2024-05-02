Return-Path: <linux-arch+bounces-4129-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 693088B941D
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 07:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7201C21225
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 05:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30951F941;
	Thu,  2 May 2024 05:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnSMxQW8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C41CD2D;
	Thu,  2 May 2024 05:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714626419; cv=none; b=DsLN3TTxL/aRY6Lg6V18CxvxqoeX/qEKEaxXb/jZWaBcjiPZNu1qvOwJVURBI20t+FsKU3RAsVKUUVkCoLgjHA6vZwhn5hH39WKS8wXZMbAnAvS7X0pf4rBFffOjTe9rVSwBNSkOiWSbGI3WGGFZyMejWWQO6mgrKCcQotAWLiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714626419; c=relaxed/simple;
	bh=E7hJC5ZIIkCJLDzLl6XTgvU7+hlkT0mW1ai+1Wl/Kn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4TLOFHRZBmpoKLtSbb+S1ajD2YXzmV873Z3zvC9NX7VKIaGIsPnNsFCJ/U0jifacVd0CiNt/cOOaXCNfmpswNgKh/C0+eyhwEQ7JL8K5L+V+kVfPzeJ9oEd6pHlR+Vfl3lKEsQkX8j0rA2R/7Ixd+eIh6rsG/GU2GWZrb1jGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnSMxQW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFE6C116B1;
	Thu,  2 May 2024 05:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714626419;
	bh=E7hJC5ZIIkCJLDzLl6XTgvU7+hlkT0mW1ai+1Wl/Kn8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gnSMxQW86lyw4bC7kidm+imxxPMXM7NAPf1aq6G8F8jnGqmif128wIocH4fc4QXln
	 VWivrS8So+wiASlffzJe+PYqSBv+fVtOv4QOAMPjubNtH4QQRPAxaV9pEttbssJc6C
	 QiMtWbPVSORwiVXRkcaoLueNOf7JqQ9GhsjPMRvHoWxf7hZ99Egf2/3TZD517OAPHg
	 YsB1wEhn6JLAc+F8R+N7XCFiXzbUW1y4j/4D0iD7ueyrypVnaWoYPS8Yj/FDgx0sjC
	 vKaCgQqlarO/3/MZ/3vTPbePj+SLt84VWdzgWrIfL5YtQ4otJBjN6qBdYPDgcRkQDE
	 lcc9eSBfjwF3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DBC29CE1073; Wed,  1 May 2024 22:06:58 -0700 (PDT)
Date: Wed, 1 May 2024 22:06:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Message-ID: <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org>
 <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>

On Thu, May 02, 2024 at 06:52:53AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Paul,
> 
> On Wed, 2024-05-01 at 16:01 -0700, Paul E. McKenney wrote:
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
> > index 2ad3e29f0ebec..f47e9ccf4efd2 100644
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -16,6 +16,7 @@ config SUPERH
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
> Thanks for the patch. However, I don't quite understand its purpose.
> 
> There is already a case for 8-byte cmpxchg in the switch statement below:
> 
>         case 1:                                         \
>                 __xchg__res = xchg_u8(__xchg_ptr, x);   \
>                 break;
> 
> Does cmpxchg_emu_u8() have any advantages over the native xchg_u8()?

That would be 8-bit xchg() rather than 8-byte cmpxchg(), correct?

Or am I missing something subtle here that makes sh also support one-byte
(8-bit) cmpxchg()?

							Thanx, Paul


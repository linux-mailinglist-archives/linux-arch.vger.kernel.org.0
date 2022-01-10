Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452F548A09F
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 21:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245463AbiAJUDx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jan 2022 15:03:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57814 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243444AbiAJUDw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2022 15:03:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A41461188;
        Mon, 10 Jan 2022 20:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5878EC36AE9;
        Mon, 10 Jan 2022 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641845032;
        bh=hD4mpAS69xuPCy7YISmoK+8+EVJhB9YWQdEtGX21PAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tN3d1jDo/TNRMNUSgQPGRf/NvMZR3tRfOr01Qt9FOs9baEGsqV2JkSUKvOhO5oUYg
         pu7Xb5Owk79VCouUxm0+rsN4wG/J2crjNG4PCsoHPdaT6JhYY0vdv08S1JXZCF3PwH
         BHx8tCZrmYAa3nsJDOV5mNBw7unq2vI5dC3I5x5se+yXkv6NaxX4I2u3CzY3igIce/
         3VNIj/SyGvqOPr4mLoDuizftbGKW88pARGbNNGmnczGsOvTVFALzfyhFdKJVd+5Ure
         ANtl6eo2LpUMvTMcC2vGuywgcYXdwLsETglBS3Qxnb+mNs6OgWFmqIAKUUiNVoIbn7
         rmThEIqKmGNhg==
Date:   Mon, 10 Jan 2022 13:03:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdyRIgnG6jlL0HHx@archlinux-ax161>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdSI9LmZE+FZAi1K@archlinux-ax161>
 <YdTpAJxgI+s9Wwgi@gmail.com>
 <YdTvXkKFzA0pOjFf@gmail.com>
 <YdYQu9YxNw0CxJRn@archlinux-ax161>
 <Ydl6MATrfA1GA0G+@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydl6MATrfA1GA0G+@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 08, 2022 at 12:49:04PM +0100, Ingo Molnar wrote:
> 
> * Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > 5. Build error in arch/arm64/kvm/hyp/nvhe with LTO
> > 
> > With arm64 + CONFIG_LTO_CLANG_THIN=y, I see:
> > 
> > $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 defconfig
> > 
> > $ scripts/config -e LTO_CLANG_THIN
> > 
> > $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 olddefconfig arch/arm64/kvm/hyp/nvhe/
> > ld.lld: error: arch/arm64/kvm/hyp/nvhe/hyp.lds:2: unknown directive: .macro
> > >>> .macro __put, val, name
> > >>> ^
> > make[5]: *** [arch/arm64/kvm/hyp/nvhe/Makefile:51: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.tmp.o] Error 1
> > 
> > I was not able to figure out the exact include chain but CONFIG_LTO
> > causes asm/alternative-macros.h to be included in asm/rwonce.h, which
> > eventually gets included in either asm/cache.h or asm/memory.h.
> > 
> > I managed to solve this with the following diff but I am not sure if
> > there is a better or cleaner way to do that.
> > 
> > diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
> > index 1bce62fa908a..e19572a205d0 100644
> > --- a/arch/arm64/include/asm/rwonce.h
> > +++ b/arch/arm64/include/asm/rwonce.h
> > @@ -5,7 +5,7 @@
> >  #ifndef __ASM_RWONCE_H
> >  #define __ASM_RWONCE_H
> >  
> > -#ifdef CONFIG_LTO
> > +#if defined(CONFIG_LTO) && !defined(LINKER_SCRIPT)
> >  
> >  #include <linux/compiler_types.h>
> >  #include <asm/alternative-macros.h>
> > @@ -66,7 +66,7 @@
> >  })
> >  
> >  #endif	/* !BUILD_VDSO */
> > -#endif	/* CONFIG_LTO */
> > +#endif	/* CONFIG_LTO && !LINKER_SCRIPT */
> 
> So the error message suggests that the linker script somehow ends up 
> including asm-generic/export.h:
> 
>   kepler:~/mingo.tip.git> git grep 'macro __put'
>   include/asm-generic/export.h:.macro __put, val, name
> 
> ?

Correct.

> But I'd guess that similar to the __ASSEMBLY__ patterns we have in headers, 
> not including the rwonce.h bits if LINKER_SCRIPT is defined is probably 
> close to the right solution - but it would also know how such a low level 
> header ended up in a linker script. Might have been to pick up some offset 
> or size definition somewhere?
> 
> I.e. how did the build end up including asm/rwonce.h?
> 
> You can generally debug such weird dependency chains by putting a
> debug #warning into the affected header - such as the patch below.
> 
> This prints a stack of the header dependencies:
> 
>     CC      kernel/sched/core.o
>   In file included from ./include/linux/compiler.h:263,
>                  from ./include/linux/static_call_types.h:7,
>                  from ./include/linux/kernel.h:6,
>                  from ./include/linux/highmem.h:5,
>                  from kernel/sched/core.c:9:
>   ./arch/arm64/include/asm/rwonce.h:8:2: warning: #warning debug [-Wcpp]
>       8 | #warning debug
> 
> ... and should in principle also work in the linker script context.

Neat trick! I added

#ifdef LINKER_SCRIPT
#warning debug
#endif

to arch/arm64/include/asm/rwonce.h and built with ThinLTO, which reveals:

$ make -skj"$(nproc)" ARCH=arm64 LLVM=1 defconfig

$ scripts/config -d LTO_NONE -e LTO_CLANG_THIN

$ make -skj"$(nproc)" ARCH=arm64 LLVM=1 olddefconfig arch/arm64/kvm/hyp/
In file included from arch/arm64/kvm/hyp/nvhe/hyp.lds.S:12:
In file included from ./arch/arm64/include/asm/memory.h:18:
In file included from ./arch/arm64/include/asm/thread_info.h:11:
In file included from ./include/linux/compiler.h:263:
./arch/arm64/include/asm/rwonce.h:9:2: warning: debug [-W#warnings]
#warning debug
 ^
1 warning generated.

I wonder if the compiler.h include could be broken up? I removed it
altogether just to see what would break and defconfig, defconfig +
CONFIG_LTO_CLANG_THIN=y, and allmodconfig all continue to build.

Cheers,
Nathan

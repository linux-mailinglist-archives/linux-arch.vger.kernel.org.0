Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1428D5656B0
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 15:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiGDNN6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiGDNN4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 09:13:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CA8F19;
        Mon,  4 Jul 2022 06:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97D5BB80EEB;
        Mon,  4 Jul 2022 13:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49578C341C7;
        Mon,  4 Jul 2022 13:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656940432;
        bh=CnKu3pTL9ZV3Laktxm3fz0s92pUc309Wza4i12uMZA0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EaaC/y+r08Ug4xq29Xnk/jjaBHSJIPDNoaCHC0b/bAx+JVx+f6YzaqsG8YO83diLS
         SFPYAoVDfMfXJQJD/W0LOBBXmwmJ3jrrjjaLojBlkNg1fEXBr/3IY6eghs3NMv6lkp
         z8NkcUWQDBMIBJp0HnyYDQTuKk/rLTWDumEsc8EJXMGYBWqYdBWk1esVPkRU0LUwSl
         zTWobsK706iNXOcqoaIANgtvgS859Raf4+f+hrFhfoPuyTQIG/jieterfpUTViPfIp
         zE9jYjjlHi0Repf0ncUxtmQ8Ec1naa9T9avVRirfX130JYXgQpXc1sS3d7YjNpT4qT
         SqmqvEFiPDG6g==
Received: by mail-vs1-f52.google.com with SMTP id o190so8981228vsc.5;
        Mon, 04 Jul 2022 06:13:52 -0700 (PDT)
X-Gm-Message-State: AJIora+s8hlUp1YsS/bFAWx2bdRwfr16xgbjdi9QGM4TYSuEcn5MJBjX
        R9B06H7jZ4d2QF9bs1f4XWfYfrpGVoAAP3YJkAc=
X-Google-Smtp-Source: AGRyM1tD+SQ1O1/eCXYDM8ZsBci+DT3mFEDYXzJs0l8d77mK4FOk06vvvdrUL72SOGsiGSdxG0ZUKNYexmkzw5KcMLI=
X-Received: by 2002:a67:ae0e:0:b0:356:c48b:401d with SMTP id
 x14-20020a67ae0e000000b00356c48b401dmr2244055vse.51.1656940431259; Mon, 04
 Jul 2022 06:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220628081707.1997728-1-guoren@kernel.org> <20220628081707.1997728-5-guoren@kernel.org>
 <YsK5o8eiVHeS+7Iw@hirez.programming.kicks-ass.net>
In-Reply-To: <YsK5o8eiVHeS+7Iw@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 4 Jul 2022 21:13:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ0cmGJHPR=TzeDJDigiEgBL5-KabbR2WkS=dGJV7jSJA@mail.gmail.com>
Message-ID: <CAJF2gTQ0cmGJHPR=TzeDJDigiEgBL5-KabbR2WkS=dGJV7jSJA@mail.gmail.com>
Subject: Re: [PATCH V7 4/5] asm-generic: spinlock: Add combo spinlock (ticket
 & queued)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 4, 2022 at 5:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 28, 2022 at 04:17:06AM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Some architecture has a flexible requirement on the type of spinlock.
> > Some LL/SC architectures of ISA don't force micro-arch to give a strong
> > forward guarantee. Thus different kinds of memory model micro-arch would
> > come out in one ISA. The ticket lock is suitable for exclusive monitor
> > designed LL/SC micro-arch with limited cores and "!NUMA". The
> > queue-spinlock could deal with NUMA/large-scale scenarios with a strong
> > forward guarantee designed LL/SC micro-arch.
> >
> > So, make the spinlock a combo with feature.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> >  include/asm-generic/spinlock.h | 43 ++++++++++++++++++++++++++++++++--
> >  kernel/locking/qspinlock.c     |  2 ++
> >  2 files changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> > index f41dc7c2b900..a9b43089bf99 100644
> > --- a/include/asm-generic/spinlock.h
> > +++ b/include/asm-generic/spinlock.h
> > @@ -28,34 +28,73 @@
> >  #define __ASM_GENERIC_SPINLOCK_H
> >
> >  #include <asm-generic/ticket_spinlock.h>
> > +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > +#include <linux/jump_label.h>
> > +#include <asm-generic/qspinlock.h>
> > +
> > +DECLARE_STATIC_KEY_TRUE(use_qspinlock_key);
> > +#endif
> > +
> > +#undef arch_spin_is_locked
> > +#undef arch_spin_is_contended
> > +#undef arch_spin_value_unlocked
> > +#undef arch_spin_lock
> > +#undef arch_spin_trylock
> > +#undef arch_spin_unlock
> >
> >  static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> >  {
> > -     ticket_spin_lock(lock);
> > +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > +     if (static_branch_likely(&use_qspinlock_key))
> > +             queued_spin_lock(lock);
> > +     else
> > +#endif
> > +             ticket_spin_lock(lock);
> >  }
> >
> >  static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> >  {
> > +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > +     if (static_branch_likely(&use_qspinlock_key))
> > +             return queued_spin_trylock(lock);
> > +#endif
> >       return ticket_spin_trylock(lock);
> >  }
> >
> >  static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
> >  {
> > -     ticket_spin_unlock(lock);
> > +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > +     if (static_branch_likely(&use_qspinlock_key))
> > +             queued_spin_unlock(lock);
> > +     else
> > +#endif
> > +             ticket_spin_unlock(lock);
> >  }
> >
> >  static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
> >  {
> > +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > +     if (static_branch_likely(&use_qspinlock_key))
> > +             return queued_spin_is_locked(lock);
> > +#endif
> >       return ticket_spin_is_locked(lock);
> >  }
> >
> >  static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> >  {
> > +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > +     if (static_branch_likely(&use_qspinlock_key))
> > +             return queued_spin_is_contended(lock);
> > +#endif
> >       return ticket_spin_is_contended(lock);
> >  }
> >
> >  static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> >  {
> > +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > +     if (static_branch_likely(&use_qspinlock_key))
> > +             return queued_spin_value_unlocked(lock);
> > +#endif
> >       return ticket_spin_value_unlocked(lock);
> >  }
>
> Urggghhhh....
>
> I really don't think you want this in generic code. Also, I'm thinking
> any arch that does this wants to make sure it doesn't inline any of this
Your advice is the same with Arnd, I would move static_branch out of generic.

> stuff. That is, said arch must not have ARCH_INLINE_SPIN_*
What do you mean? I've tested with ARCH_INLINE_SPIN_* and it's okay
with EXPORT_SYMBOL(use_qspinlock_key).

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 47e12ab9c822..4587fb544326 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -32,6 +32,32 @@ config RISCV
        select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
        select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
        select ARCH_HAS_UBSAN_SANITIZE_ALL
+       select ARCH_INLINE_READ_LOCK if !PREEMPTION
+       select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
+       select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
+       select ARCH_INLINE_READ_LOCK_IRQSAVE if !PREEMPTION
+       select ARCH_INLINE_READ_UNLOCK if !PREEMPTION
+       select ARCH_INLINE_READ_UNLOCK_BH if !PREEMPTION
+       select ARCH_INLINE_READ_UNLOCK_IRQ if !PREEMPTION
+       select ARCH_INLINE_READ_UNLOCK_IRQRESTORE if !PREEMPTION
+       select ARCH_INLINE_WRITE_LOCK if !PREEMPTION
+       select ARCH_INLINE_WRITE_LOCK_BH if !PREEMPTION
+       select ARCH_INLINE_WRITE_LOCK_IRQ if !PREEMPTION
+       select ARCH_INLINE_WRITE_LOCK_IRQSAVE if !PREEMPTION
+       select ARCH_INLINE_WRITE_UNLOCK if !PREEMPTION
+       select ARCH_INLINE_WRITE_UNLOCK_BH if !PREEMPTION
+       select ARCH_INLINE_WRITE_UNLOCK_IRQ if !PREEMPTION
+       select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE if !PREEMPTION
+       select ARCH_INLINE_SPIN_TRYLOCK if !PREEMPTION
+       select ARCH_INLINE_SPIN_TRYLOCK_BH if !PREEMPTION
+       select ARCH_INLINE_SPIN_LOCK if !PREEMPTION
+       select ARCH_INLINE_SPIN_LOCK_BH if !PREEMPTION
+       select ARCH_INLINE_SPIN_LOCK_IRQ if !PREEMPTION
+       select ARCH_INLINE_SPIN_LOCK_IRQSAVE if !PREEMPTION
+       select ARCH_INLINE_SPIN_UNLOCK if !PREEMPTION
+       select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
+       select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
+       select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
        select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
        select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
        select ARCH_STACKWALK

Shall I add the above diff in the next version of the patch series?

>
> And if you're going to force things out of line, then I think you can
> get better code using static_call().
Good point, thx.

>
> *shudder*...



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

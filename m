Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB4134BA61
	for <lists+linux-arch@lfdr.de>; Sun, 28 Mar 2021 03:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhC1Btl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Mar 2021 21:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhC1BtN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Mar 2021 21:49:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1242E619A6;
        Sun, 28 Mar 2021 01:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616896152;
        bh=r/CjWLOfQ/Cy98BD8/yfutAJhP32QSWIzkd5wFUy5ec=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J/3+nDTfzogk2FKUnPgpz7x3yL3yM3zZhpqDBfZpclg9rXjQWrm+G24m3YywmAymx
         Md0cKCkj/tvQwY44pxexcJxlHFJzGURRz+FJbj5hASyEdz1/kXigQDFvnCk5jYZUfd
         vyU1qhZfoeto/1OnQYsXNRZNx0payLHwBLIjWvNXz6msLBq6t2IIueJUNWIMKmvb0x
         pHaImY/VZzujOAiMdoXDTIIj2oT2uo8rdkxshBX1JF02cO0LfpMKwjLkI+UqMJ4HMy
         OwXuvDFwIJK9lnnsMMaS92OMJic8Hb9Ue7L86Avqlk14SIxSehfppjslyXrLMD4csT
         +XE6nuKmzeskA==
Received: by mail-lj1-f177.google.com with SMTP id f26so11834373ljp.8;
        Sat, 27 Mar 2021 18:49:11 -0700 (PDT)
X-Gm-Message-State: AOAM5327Oo0YpQtWcH+WHRKfXd3lT4yBrAOHA8yl1WZ113tPkmkAkXGT
        T8l/TP/NCdh9yi9+gTgkvmmX9lST+c45To1EtzI=
X-Google-Smtp-Source: ABdhPJyW6nHPZZw4sckD4eehDVI2/MTvmJEGaup03eXwH32xXeXXve1gtXcXfT8Prn4CK0frPQIN2pSq8Ty+SoZQm30=
X-Received: by 2002:a2e:9084:: with SMTP id l4mr13189914ljg.498.1616896150341;
 Sat, 27 Mar 2021 18:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <b6466a43-6fb3-dc47-e0ef-d493e0930ab2@redhat.com>
In-Reply-To: <b6466a43-6fb3-dc47-e0ef-d493e0930ab2@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 28 Mar 2021 09:48:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRROuZOFBM4UDtMCjG0M2Q7c2ZRxHkj2+13amN6jaqvtQ@mail.gmail.com>
Message-ID: <CAJF2gTRROuZOFBM4UDtMCjG0M2Q7c2ZRxHkj2+13amN6jaqvtQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Waiman Long <longman@redhat.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Mar 28, 2021 at 2:43 AM Waiman Long <longman@redhat.com> wrote:
>
> On 3/27/21 2:06 PM, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Some architectures don't have sub-word swap atomic instruction,
> > they only have the full word's one.
> >
> > The sub-word swap only improve the performance when:
> > NR_CPUS < 16K
> >   *  0- 7: locked byte
> >   *     8: pending
> >   *  9-15: not used
> >   * 16-17: tail index
> >   * 18-31: tail cpu (+1)
> >
> > The 9-15 bits are wasted to use xchg16 in xchg_tail.
> >
> > Please let architecture select xchg16/xchg32 to implement
> > xchg_tail.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Anup Patel <anup@brainfault.org>
> > ---
> >   kernel/Kconfig.locks       |  3 +++
> >   kernel/locking/qspinlock.c | 44 +++++++++++++++++++++-----------------
> >   2 files changed, 27 insertions(+), 20 deletions(-)
> >
> > diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
> > index 3de8fd11873b..d02f1261f73f 100644
> > --- a/kernel/Kconfig.locks
> > +++ b/kernel/Kconfig.locks
> > @@ -239,6 +239,9 @@ config LOCK_SPIN_ON_OWNER
> >   config ARCH_USE_QUEUED_SPINLOCKS
> >       bool
> >
> > +config ARCH_USE_QUEUED_SPINLOCKS_XCHG32
> > +     bool
> > +
> >   config QUEUED_SPINLOCKS
> >       def_bool y if ARCH_USE_QUEUED_SPINLOCKS
> >       depends on SMP
> > diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> > index cbff6ba53d56..54de0632c6a8 100644
> > --- a/kernel/locking/qspinlock.c
> > +++ b/kernel/locking/qspinlock.c
> > @@ -163,26 +163,6 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
> >       WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
> >   }
> >
> > -/*
> > - * xchg_tail - Put in the new queue tail code word & retrieve previous one
> > - * @lock : Pointer to queued spinlock structure
> > - * @tail : The new queue tail code word
> > - * Return: The previous queue tail code word
> > - *
> > - * xchg(lock, tail), which heads an address dependency
> > - *
> > - * p,*,* -> n,*,* ; prev = xchg(lock, node)
> > - */
> > -static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> > -{
> > -     /*
> > -      * We can use relaxed semantics since the caller ensures that the
> > -      * MCS node is properly initialized before updating the tail.
> > -      */
> > -     return (u32)xchg_relaxed(&lock->tail,
> > -                              tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
> > -}
> > -
> >   #else /* _Q_PENDING_BITS == 8 */
> >
> >   /**
> > @@ -206,6 +186,30 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
> >   {
> >       atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
> >   }
> > +#endif
> > +
> > +#if _Q_PENDING_BITS == 8 && !defined(CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32)
> > +/*
> > + * xchg_tail - Put in the new queue tail code word & retrieve previous one
> > + * @lock : Pointer to queued spinlock structure
> > + * @tail : The new queue tail code word
> > + * Return: The previous queue tail code word
> > + *
> > + * xchg(lock, tail), which heads an address dependency
> > + *
> > + * p,*,* -> n,*,* ; prev = xchg(lock, node)
> > + */
> > +static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
> > +{
> > +     /*
> > +      * We can use relaxed semantics since the caller ensures that the
> > +      * MCS node is properly initialized before updating the tail.
> > +      */
> > +     return (u32)xchg_relaxed(&lock->tail,
> > +                              tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
> > +}
> > +
> > +#else
> >
> >   /**
> >    * xchg_tail - Put in the new queue tail code word & retrieve previous one
>
> I don't have any problem adding a
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32 config option to control that.
Thx

>
> One minor nit:
>
> #endif /* _Q_PENDING_BITS == 8 */
>
> You should probably remove the comment at the trailing end of the
> corresponding "#endif" as it is now wrong.
I'll fix it in next patch

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

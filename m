Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6DC55F2B2
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 03:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiF2BRo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 21:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiF2BRo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 21:17:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A582CC86;
        Tue, 28 Jun 2022 18:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0621861C47;
        Wed, 29 Jun 2022 01:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60024C341CC;
        Wed, 29 Jun 2022 01:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656465462;
        bh=qwLxFYOuowxIe8KZeDT2ewzdtv2FMZ3tEfCQjPwD+r0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EDAetCCmvnZHcxyz0H1XLFh0XtVkVcZUDpSkexY/oY3ava9yp5Y9OFaWYO/z7bC3t
         goxVcYCawDgwDstnfUtkNRo0ZCKZNcSSD2YcLOoZ3PzVZAh8qA10coEWDEmipjlbMa
         Ftlct2aG7fLfKxDGAXd+AEg03+fDA39hLgyeEaOfpJjY91lSJ7zX7zvecJf/DYivTb
         0q42U1H4PL13VVSfvOk++cKE4iNXJTFKzA2yQCflUTODj6KySNelHBdnwQ7tKOprD/
         nTse+T9QdSXfi0hArQgygf1rC5fabJud30KQTLjg8Nae/hwm2Mp4e7+F1DLL7gKZKf
         KqPjafRUm1odA==
Received: by mail-ua1-f51.google.com with SMTP id k19so5191535uap.7;
        Tue, 28 Jun 2022 18:17:42 -0700 (PDT)
X-Gm-Message-State: AJIora8VFaX025N90t8OuW/vSzT8tZyyc7NMSJ64WrDe1Jjq3t01H+mi
        +VySTDm+TAS0L1gDHyJdNprCh+CTiJu8a3ungCY=
X-Google-Smtp-Source: AGRyM1st40hCRJVtOkY/GgEh2hf0RL+nbenkSflSWZSZDWsDeubLW9YCT+HEpSzX2QJvuFM4OduPHYtkSBkJGtts9uQ=
X-Received: by 2002:ab0:6704:0:b0:37c:c743:eebe with SMTP id
 q4-20020ab06704000000b0037cc743eebemr257481uam.84.1656465461345; Tue, 28 Jun
 2022 18:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220628081707.1997728-1-guoren@kernel.org> <20220628081707.1997728-5-guoren@kernel.org>
 <09abc75e-2ffb-1ab5-d0fc-1c15c943948d@redhat.com>
In-Reply-To: <09abc75e-2ffb-1ab5-d0fc-1c15c943948d@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 29 Jun 2022 09:17:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQZzOtOsq0DV48Gi76UtBSa+vdY7dLZmoPD_OFUZ0Wbrg@mail.gmail.com>
Message-ID: <CAJF2gTQZzOtOsq0DV48Gi76UtBSa+vdY7dLZmoPD_OFUZ0Wbrg@mail.gmail.com>
Subject: Re: [PATCH V7 4/5] asm-generic: spinlock: Add combo spinlock (ticket
 & queued)
To:     Waiman Long <longman@redhat.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 29, 2022 at 2:13 AM Waiman Long <longman@redhat.com> wrote:
>
> On 6/28/22 04:17, guoren@kernel.org wrote:
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
> >   include/asm-generic/spinlock.h | 43 ++++++++++++++++++++++++++++++++--
> >   kernel/locking/qspinlock.c     |  2 ++
> >   2 files changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> > index f41dc7c2b900..a9b43089bf99 100644
> > --- a/include/asm-generic/spinlock.h
> > +++ b/include/asm-generic/spinlock.h
> > @@ -28,34 +28,73 @@
> >   #define __ASM_GENERIC_SPINLOCK_H
> >
> >   #include <asm-generic/ticket_spinlock.h>
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
> >   static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> >   {
> > -     ticket_spin_lock(lock);
> > +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> > +     if (static_branch_likely(&use_qspinlock_key))
> > +             queued_spin_lock(lock);
> > +     else
> > +#endif
> > +             ticket_spin_lock(lock);
> >   }
>
> Why do you use a static key to control whether to use qspinlock or
> ticket lock? In the next patch, you have
>
> +#if !defined(CONFIG_NUMA) && defined(CONFIG_QUEUED_SPINLOCKS)
> +       static_branch_disable(&use_qspinlock_key);
> +#endif
>
> So the current config setting determines if qspinlock will be used, not
> some boot time parameter that user needs to specify. This patch will
> just add useless code to lock/unlock sites. I don't see any benefit of
> doing that.
This is a startup patch for riscv. next, we could let vendors make choices.
I'm not sure they like cmdline or vendor-specific errata style.

Eventually, we would let one riscv Image support all machines, some
use ticket-lock, and some use qspinlock.

>
> Cheers,
> Longman
>



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

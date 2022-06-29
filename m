Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B255F36B
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 04:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiF2CaF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 22:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiF2CaF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 22:30:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C3022506;
        Tue, 28 Jun 2022 19:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DBCD61CFD;
        Wed, 29 Jun 2022 02:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF03C341D1;
        Wed, 29 Jun 2022 02:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656469802;
        bh=yEaL8NGKkho+UZVTGWe8SLlug9pUXxj7ijAlf3AJkh4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hCGQVbMaUdjrMM4ER6tAsLFM5yXA7+721PupkbWvozMd5J5hhyecAa1rp888ZVWwA
         hfIs3v/cyIWd7RYmiSIWHKAAxEP3q1WAMlQrA4aRD2ysPIjvscc2ReQ14Lqudjohv3
         V8DxmDTpnccjEK5hIf1+nH93yzz8CK0tdF+WKKiqCbtftKUkhEfFEEpqDRu5lzzRPB
         89bGJcsdpZRUe9gEHVD2VlCMvtlnNvJBcCWn70T6JldJYCUE8KkhINrrfjVbg8U1nM
         db1bcS92xkHQsxl9N7+uDI+lTlLlPb/RUxEUQ2wadf6ulg7f3ygXOwcSio6KaiFr70
         /XjWrwm//8/aw==
Received: by mail-vs1-f48.google.com with SMTP id j6so13884425vsi.0;
        Tue, 28 Jun 2022 19:30:02 -0700 (PDT)
X-Gm-Message-State: AJIora9y8Y6UJbW/Vud1swTY5m/lMimQv66JVJZ6PnYtLzs5sfG7PwLb
        76pyGb7XszHPAeeT6rWkNht9LCo0HdNayYx2W3c=
X-Google-Smtp-Source: AGRyM1tK4JbZw8tkKtdzn/wlbaoTM5+glSDTRp/onWIuYl8MNGjlyV9YQOG4HsuC2eRkoKhGb6Tm1ozh7DPFobEY/1c=
X-Received: by 2002:a05:6102:3e91:b0:354:46ed:d1c3 with SMTP id
 m17-20020a0561023e9100b0035446edd1c3mr3274555vsv.51.1656469801524; Tue, 28
 Jun 2022 19:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220628081707.1997728-1-guoren@kernel.org> <20220628081707.1997728-5-guoren@kernel.org>
 <09abc75e-2ffb-1ab5-d0fc-1c15c943948d@redhat.com> <CAJF2gTQZzOtOsq0DV48Gi76UtBSa+vdY7dLZmoPD_OFUZ0Wbrg@mail.gmail.com>
 <5166750c-3dc6-9b09-4a1e-cd53141cdde8@redhat.com>
In-Reply-To: <5166750c-3dc6-9b09-4a1e-cd53141cdde8@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 29 Jun 2022 10:29:50 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRv6e0z_tYMcFQQUGb=5sfx-GHoQmtz-Rtm1kQXHTgw-g@mail.gmail.com>
Message-ID: <CAJF2gTRv6e0z_tYMcFQQUGb=5sfx-GHoQmtz-Rtm1kQXHTgw-g@mail.gmail.com>
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

On Wed, Jun 29, 2022 at 9:34 AM Waiman Long <longman@redhat.com> wrote:
>
> On 6/28/22 21:17, Guo Ren wrote:
> > On Wed, Jun 29, 2022 at 2:13 AM Waiman Long <longman@redhat.com> wrote:
> >> On 6/28/22 04:17, guoren@kernel.org wrote:
> >>> From: Guo Ren <guoren@linux.alibaba.com>
> >>>
> >>> Some architecture has a flexible requirement on the type of spinlock.
> >>> Some LL/SC architectures of ISA don't force micro-arch to give a strong
> >>> forward guarantee. Thus different kinds of memory model micro-arch would
> >>> come out in one ISA. The ticket lock is suitable for exclusive monitor
> >>> designed LL/SC micro-arch with limited cores and "!NUMA". The
> >>> queue-spinlock could deal with NUMA/large-scale scenarios with a strong
> >>> forward guarantee designed LL/SC micro-arch.
> >>>
> >>> So, make the spinlock a combo with feature.
> >>>
> >>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> >>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> >>> ---
> >>>    include/asm-generic/spinlock.h | 43 ++++++++++++++++++++++++++++++++--
> >>>    kernel/locking/qspinlock.c     |  2 ++
> >>>    2 files changed, 43 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> >>> index f41dc7c2b900..a9b43089bf99 100644
> >>> --- a/include/asm-generic/spinlock.h
> >>> +++ b/include/asm-generic/spinlock.h
> >>> @@ -28,34 +28,73 @@
> >>>    #define __ASM_GENERIC_SPINLOCK_H
> >>>
> >>>    #include <asm-generic/ticket_spinlock.h>
> >>> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> >>> +#include <linux/jump_label.h>
> >>> +#include <asm-generic/qspinlock.h>
> >>> +
> >>> +DECLARE_STATIC_KEY_TRUE(use_qspinlock_key);
> >>> +#endif
> >>> +
> >>> +#undef arch_spin_is_locked
> >>> +#undef arch_spin_is_contended
> >>> +#undef arch_spin_value_unlocked
> >>> +#undef arch_spin_lock
> >>> +#undef arch_spin_trylock
> >>> +#undef arch_spin_unlock
> >>>
> >>>    static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> >>>    {
> >>> -     ticket_spin_lock(lock);
> >>> +#ifdef CONFIG_ARCH_USE_QUEUED_SPINLOCKS
> >>> +     if (static_branch_likely(&use_qspinlock_key))
> >>> +             queued_spin_lock(lock);
> >>> +     else
> >>> +#endif
> >>> +             ticket_spin_lock(lock);
> >>>    }
> >> Why do you use a static key to control whether to use qspinlock or
> >> ticket lock? In the next patch, you have
> >>
> >> +#if !defined(CONFIG_NUMA) && defined(CONFIG_QUEUED_SPINLOCKS)
> >> +       static_branch_disable(&use_qspinlock_key);
> >> +#endif
> >>
> >> So the current config setting determines if qspinlock will be used, not
> >> some boot time parameter that user needs to specify. This patch will
> >> just add useless code to lock/unlock sites. I don't see any benefit of
> >> doing that.
> > This is a startup patch for riscv. next, we could let vendors make choices.
> > I'm not sure they like cmdline or vendor-specific errata style.
> >
> > Eventually, we would let one riscv Image support all machines, some
> > use ticket-lock, and some use qspinlock.
>
> OK. Maybe you can postpone this combo spinlock until there is a good use
> case for it. Upstream usually don't accept patches that have no good use
> case yet.
>
> Cheers,
> Longman
>

I would add a cmdline to control the choice of qspinlock/ticket-lock
in the next version.

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index b9b234157a66..5ade490c2f27 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -270,6 +270,10 @@ void __init setup_arch(char **cmdline_p)

        early_ioremap_setup();
        jump_label_init();
+
+#if !defined(CONFIG_NUMA) && defined(CONFIG_QUEUED_SPINLOCKS)
+       static_branch_disable(&use_qspinlock_key);
+#endif
        parse_early_param();

        efi_init();
@@ -295,10 +299,6 @@ void __init setup_arch(char **cmdline_p)
        setup_smp();
 #endif

-#if !defined(CONFIG_NUMA) && defined(CONFIG_QUEUED_SPINLOCKS)
-       static_branch_disable(&use_qspinlock_key);
-#endif
-
        riscv_fill_hwcap();
        apply_boot_alternatives();
 }
@@ -330,3 +330,13 @@ void free_initmem(void)

        free_initmem_default(POISON_FREE_INITMEM);
 }
+
+#ifdef CONFIG_QUEUED_SPINLOCKS
+static int __init disable_qspinlock(char *p)
+{
+       static_branch_disable(&use_qspinlock_key);
+       return 0;
+}
+
+early_param("disable_qspinlock", disable_qspinlock);
+#endif


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

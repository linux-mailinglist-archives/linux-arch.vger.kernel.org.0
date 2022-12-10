Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D90648E2B
	for <lists+linux-arch@lfdr.de>; Sat, 10 Dec 2022 11:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiLJK1s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Dec 2022 05:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiLJK1q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Dec 2022 05:27:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1965EE6F;
        Sat, 10 Dec 2022 02:27:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7EFA60303;
        Sat, 10 Dec 2022 10:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045FDC4339C;
        Sat, 10 Dec 2022 10:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670668064;
        bh=Mdz8RUBKtZSqhDXWmWhXs1hxqSCd3eah7I+k/KBibAU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fyia8Yw0j50M3N4ZjN9mkh3kA4Ko9vMpXNjtUqtldhDm8v7HWirOrxWpAnpf8FYrR
         WiDUbaLhvQuTBZd0lZW0ZfqEOX90Y7J7AzDi2BvPVrZQB5qbdsr46PC8Sv93+Oo8aJ
         7pMUR5+ZMkSZijQLboex4vlvu94h6It/2gPLscwwyzioCte1esJvotO2MNXh67idU4
         3GTrqBGG5pgHPS6eN7UgaXjlt61LZewMmFyCifV46zYRzKENY/J4gXHmLkvF5psMbu
         Uz8EcUTVRS+DRW5G6vm/07uQoR00rT7JjkoSftG93zEl1LgwkUtHufsETGMCd4YE8U
         Rh6NSg5Y+nDfw==
Received: by mail-ed1-f46.google.com with SMTP id c66so6387016edf.5;
        Sat, 10 Dec 2022 02:27:43 -0800 (PST)
X-Gm-Message-State: ANoB5pn+hTvtat9cAeLYIHYt0p1DtbSecv6S5m5ui0t4PsaRfDs2Cuta
        TVZfILPRI+n8WFfDmI05HGH1v6n83Nf3aDmEaco=
X-Google-Smtp-Source: AA0mqf5Gjk7IIhV2NfbhD3LwNHreZo3C6l0uKNZ1ltwuUDfi8ijlL0vCBE23MaBWsMSReHAv2BPTCodSmEyRgeGKFs0=
X-Received: by 2002:aa7:c046:0:b0:461:54f0:f7dc with SMTP id
 k6-20020aa7c046000000b0046154f0f7dcmr84737630edo.117.1670668062036; Sat, 10
 Dec 2022 02:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20221208025816.138712-1-guoren@kernel.org> <20221208025816.138712-5-guoren@kernel.org>
 <87tu26w6gn.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87tu26w6gn.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 10 Dec 2022 18:27:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTE_ZtKR6YTDEpF5uXHxUkuZ1PsZoL2Nf3NXpJWca9W7Q@mail.gmail.com>
Message-ID: <CAJF2gTTE_ZtKR6YTDEpF5uXHxUkuZ1PsZoL2Nf3NXpJWca9W7Q@mail.gmail.com>
Subject: Re: [PATCH -next V10 04/10] riscv: entry: Convert to generic entry
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 8, 2022 at 6:11 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wro=
te:
>
> guoren@kernel.org writes:
>
> The RISC-V entry.S is much more paletable after this patch! :-)
>
> Some minor things...
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This patch converts riscv to use the generic entry infrastructure from
> > kernel/entry/*. The generic entry makes maintainers' work easier and
> > codes more elegant. Here are the changes than before:
>
> s/changes than before/changes/
Okay

>
> >  - More clear entry.S with handle_exception and ret_from_exception
> >  - Get rid of complex custom signal implementation
> >  - More readable syscall procedure
>
> Maybe reword this a bit? It's a move from assembly to C (which, is much
> more readable!).
Okay.

>
> >  - Little modification on ret_from_fork & ret_from_kernel_thread
>
> What changes?
 ENTRY(ret_from_fork)
+       call schedule_tail
+       move a0, sp /* pt_regs */
        la ra, ret_from_exception
-       tail schedule_tail
+       tail syscall_exit_to_user_mode
 ENDPROC(ret_from_fork)

 ENTRY(ret_from_kernel_thread)
        call schedule_tail
        /* Call fn(arg) */
-       la ra, ret_from_exception
        move a0, s1
-       jr s0
+       jalr s0
+       move a0, sp /* pt_regs */
+       la ra, ret_from_exception
+       tail syscall_exit_to_user_mode
 ENDPROC(ret_from_kernel_thread)

>
> >  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
> >  - Use the standard preemption code instead of custom
>
> > Suggested-by: Huacai Chen <chenhuacai@kernel.org>
> > Tested-by: Yipeng Zou <zouyipeng@huawei.com>
> > Tested-by: Jisheng Zhang <jszhang@kernel.org>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Ben Hutchings <ben@decadent.org.uk>
> > ---
> >  arch/riscv/Kconfig                    |   1 +
> >  arch/riscv/include/asm/csr.h          |   1 -
> >  arch/riscv/include/asm/entry-common.h |   8 +
> >  arch/riscv/include/asm/ptrace.h       |  10 +-
> >  arch/riscv/include/asm/stacktrace.h   |   5 +
> >  arch/riscv/include/asm/syscall.h      |   6 +
> >  arch/riscv/include/asm/thread_info.h  |  13 +-
> >  arch/riscv/kernel/entry.S             | 237 ++++----------------------
> >  arch/riscv/kernel/irq.c               |  15 ++
> >  arch/riscv/kernel/ptrace.c            |  43 -----
> >  arch/riscv/kernel/signal.c            |  21 +--
> >  arch/riscv/kernel/sys_riscv.c         |  29 ++++
> >  arch/riscv/kernel/traps.c             |  70 ++++++--
> >  arch/riscv/mm/fault.c                 |  16 +-
> >  14 files changed, 175 insertions(+), 300 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/entry-common.h
>
> [...]
>
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index da44fe2d0d82..69097dfffdc9 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -14,10 +14,6 @@
> >  #include <asm/asm-offsets.h>
> >  #include <asm/errata_list.h>
> >
> > -#if !IS_ENABLED(CONFIG_PREEMPTION)
> > -.set resume_kernel, restore_all
> > -#endif
> > -
> >  ENTRY(handle_exception)
> >       /*
> >        * If coming from userspace, preserve the user thread pointer and=
 load
> > @@ -106,19 +102,8 @@ _save_context:
> >  .option norelax
> >       la gp, __global_pointer$
> >  .option pop
> > -
> > -#ifdef CONFIG_TRACE_IRQFLAGS
> > -     call __trace_hardirqs_off
> > -#endif
> > -
> > -#ifdef CONFIG_CONTEXT_TRACKING_USER
> > -     /* If previous state is in user mode, call user_exit_callable(). =
*/
> > -     li   a0, SR_PP
> > -     and a0, s1, a0
> > -     bnez a0, skip_context_tracking
> > -     call user_exit_callable
> > -skip_context_tracking:
> > -#endif
> > +     move a0, sp /* pt_regs */
> > +     la ra, ret_from_exception
>
> Not for this series, but at some point it would be nice to get rid of
> the "move" pseudoinsn in favor of "mv".
>
> [...]
>
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index f7fa973558bc..ee9a0ef672e9 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/module.h>
> >  #include <linux/irq.h>
> >  #include <linux/kexec.h>
> > +#include <linux/entry-common.h>
> >
> >  #include <asm/asm-prototypes.h>
> >  #include <asm/bug.h>
> > @@ -99,10 +100,19 @@ static void do_trap_error(struct pt_regs *regs, in=
t signo, int code,
> >  #else
> >  #define __trap_section noinstr
> >  #endif
> > -#define DO_ERROR_INFO(name, signo, code, str)                         =
       \
> > -asmlinkage __visible __trap_section void name(struct pt_regs *regs)  \
> > -{                                                                    \
> > -     do_trap_error(regs, signo, code, regs->epc, "Oops - " str);     \
> > +#define DO_ERROR_INFO(name, signo, code, str)                         =
               \
> > +asmlinkage __visible __trap_section void name(struct pt_regs *regs)   =
       \
> > +{                                                                     =
       \
> > +     if (user_mode(regs)) {                                           =
       \
> > +             irqentry_enter_from_user_mode(regs);                     =
       \
> > +             do_trap_error(regs, signo, code, regs->epc, "Oops - " str=
);     \
> > +             irqentry_exit_to_user_mode(regs);                        =
       \
> > +     } else {                                                         =
       \
> > +             irqentry_state_t irq_state =3D irqentry_nmi_enter(regs); =
         \
> > +             do_trap_error(regs, signo, code, regs->epc, "Oops - " str=
);     \
> > +             irqentry_nmi_exit(regs, irq_state);                      =
       \
> > +     }                                                                =
       \
> > +     BUG_ON(!irqs_disabled());                                        =
       \
> >  }
> >
> >  DO_ERROR_INFO(do_trap_unknown,
> > @@ -126,18 +136,38 @@ int handle_misaligned_store(struct pt_regs *regs)=
;
> >
> >  asmlinkage void __trap_section do_trap_load_misaligned(struct pt_regs =
*regs)
> >  {
> > -     if (!handle_misaligned_load(regs))
> > -             return;
> > -     do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> > -                   "Oops - load address misaligned");
> > +     if (user_mode(regs)) {
> > +             irqentry_enter_from_user_mode(regs);
> > +             if (handle_misaligned_load(regs))
> > +                     do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc=
,
> > +                           "Oops - load address misaligned");
> > +             irqentry_exit_to_user_mode(regs);
> > +     } else {
> > +             irqentry_state_t irq_state =3D irqentry_nmi_enter(regs);
>
> Please add a newline.
okay
>
> > +             if (handle_misaligned_load(regs))
> > +                     do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc=
,
> > +                           "Oops - load address misaligned");
> > +             irqentry_nmi_exit(regs, irq_state);
> > +     }
> > +     BUG_ON(!irqs_disabled());
> >  }
> >
> >  asmlinkage void __trap_section do_trap_store_misaligned(struct pt_regs=
 *regs)
> >  {
> > -     if (!handle_misaligned_store(regs))
> > -             return;
> > -     do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
> > -                   "Oops - store (or AMO) address misaligned");
> > +     if (user_mode(regs)) {
> > +             irqentry_enter_from_user_mode(regs);
> > +             if (handle_misaligned_store(regs))
> > +                     do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc=
,
> > +                             "Oops - store (or AMO) address misaligned=
");
> > +             irqentry_exit_to_user_mode(regs);
> > +     } else {
> > +             irqentry_state_t irq_state =3D irqentry_nmi_enter(regs);
>
> Please add a newline.
okay
>
> > +             if (handle_misaligned_store(regs))
> > +                     do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc=
,
> > +                             "Oops - store (or AMO) address misaligned=
");
> > +             irqentry_nmi_exit(regs, irq_state);
> > +     }
> > +     BUG_ON(!irqs_disabled());
> >  }
> >  #endif
> >  DO_ERROR_INFO(do_trap_store_fault,
> > @@ -159,7 +189,7 @@ static inline unsigned long get_break_insn_length(u=
nsigned long pc)
> >       return GET_INSN_LENGTH(insn);
> >  }
> >
> > -asmlinkage __visible __trap_section void do_trap_break(struct pt_regs =
*regs)
> > +static void __do_trap_break(struct pt_regs *regs)
> >  {
> >  #ifdef CONFIG_KPROBES
> >       if (kprobe_single_step_handler(regs))
> > @@ -189,6 +219,20 @@ asmlinkage __visible __trap_section void do_trap_b=
reak(struct pt_regs *regs)
> >       else
> >               die(regs, "Kernel BUG");
> >  }
> > +
> > +asmlinkage __visible __trap_section void do_trap_break(struct pt_regs =
*regs)
> > +{
> > +     if (user_mode(regs)) {
> > +             irqentry_enter_from_user_mode(regs);
> > +             __do_trap_break(regs);
> > +             irqentry_exit_to_user_mode(regs);
> > +     } else {
> > +             irqentry_state_t irq_state =3D irqentry_nmi_enter(regs);
>
> Please add a newline.
okay
>
>
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren

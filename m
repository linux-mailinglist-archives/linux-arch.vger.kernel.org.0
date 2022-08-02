Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B9A5876F9
	for <lists+linux-arch@lfdr.de>; Tue,  2 Aug 2022 08:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiHBGJX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Aug 2022 02:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiHBGJW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Aug 2022 02:09:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B75BD100;
        Mon,  1 Aug 2022 23:09:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46A12B8188E;
        Tue,  2 Aug 2022 06:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FA0C43140;
        Tue,  2 Aug 2022 06:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659420557;
        bh=EtnTwiGnu4HXQ9Ajm3QFxagD2pw2qahfshy7dOh36ls=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XuJv1FjJJhESBQNK/rbwjWz1hSf46Jyy/N98IPoFZuLePEz+Qbofv2pnjUlbj1RxB
         jx3hcRpJWZUn6bwLgrBlwIfKYehV4s8uDDj66OFFO1EGVvByw1R8dZDRnnaGB/LEAN
         n6WXmQZh7aj9GJ2hyc1i8TsUeajXrDV3QhGtk6u0kTE9Bm8rRxYXxXMnfkQg4VNB/p
         hnfzSj8TI9vK+lqkqRsWjS64BHqmbCrQ9K5SZi08DRqcy9tYNkQMUu4jyqP8ktVVNS
         3SXvDZK2vOpG7NQuVZmz04slz8m7Z8mYDs2SkR7kFuyNi7wdQYBsVqf1qfsreFLMh5
         xhytxNTBPsnbQ==
Received: by mail-vs1-f48.google.com with SMTP id j2so7035076vsp.1;
        Mon, 01 Aug 2022 23:09:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo3iMh4u41bf1aDJcuqst/bnzgr1RF7fZokR2fMKqe8HPuHFLqlI
        cwaSkFaJuoeMgcklYe2E9fFQ6opAv06aH8IRkQM=
X-Google-Smtp-Source: AA6agR6j61B+NJ3XBdxdJflIlHm8f5slQ+DzX3WG0PxUB1DsIcuiKtnbh3IMcK1OYrz/i6ueMTYs7kZf0FDxw8QgX74=
X-Received: by 2002:a67:d487:0:b0:385:1a6b:6f33 with SMTP id
 g7-20020a67d487000000b003851a6b6f33mr3002902vsj.59.1659420556640; Mon, 01 Aug
 2022 23:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220802053818.18051-1-zhangqing@loongson.cn> <20220802053818.18051-4-zhangqing@loongson.cn>
In-Reply-To: <20220802053818.18051-4-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 2 Aug 2022 14:09:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7NLgM4zWkhsmMtx8uL1AwC28=YxFvQPo1LbppHHHHRtQ@mail.gmail.com>
Message-ID: <CAAhV-H7NLgM4zWkhsmMtx8uL1AwC28=YxFvQPo1LbppHHHHRtQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] LoongArch: Add stacktrace support
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jinyang He <hejinyang@loongson.cn>,
        Youling Tang <tangyouling@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Qing,

On Tue, Aug 2, 2022 at 1:38 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> Use common arch_stack_walk infrastructure to avoid duplicated code and
> avoid taking care of the stack storage and filtering.
> Add sra (means __schedule return address) and scfa (means __schedule call
I think you want to say sched_ra and sched_cfa here. :)

Huacai
> frame address) to thread_info and store it in switch_to().
>
> Now we can print the process stack by cat /proc/*/stack and can better
> support ftrace.
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/Kconfig                 |  5 ++++
>  arch/loongarch/include/asm/processor.h |  9 +++++++
>  arch/loongarch/include/asm/switch_to.h | 14 ++++++----
>  arch/loongarch/kernel/Makefile         |  1 +
>  arch/loongarch/kernel/asm-offsets.c    |  2 ++
>  arch/loongarch/kernel/process.c        |  3 +++
>  arch/loongarch/kernel/stacktrace.c     | 37 ++++++++++++++++++++++++++
>  arch/loongarch/kernel/switch.S         |  2 ++
>  8 files changed, 68 insertions(+), 5 deletions(-)
>  create mode 100644 arch/loongarch/kernel/stacktrace.c
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 62b5b07fa4e1..85d0fa3147cd 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -38,6 +38,7 @@ config LOONGARCH
>         select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
>         select ARCH_MIGHT_HAVE_PC_PARPORT
>         select ARCH_MIGHT_HAVE_PC_SERIO
> +       select ARCH_STACKWALK
>         select ARCH_SPARSEMEM_ENABLE
>         select ARCH_SUPPORTS_ACPI
>         select ARCH_SUPPORTS_ATOMIC_RMW
> @@ -140,6 +141,10 @@ config LOCKDEP_SUPPORT
>         bool
>         default y
>
> +config STACKTRACE_SUPPORT
> +       bool
> +       default y
> +
>  # MACH_LOONGSON32 and MACH_LOONGSON64 are delibrately carried over from the
>  # MIPS Loongson code, to preserve Loongson-specific code paths in drivers that
>  # are shared between architectures, and specifically expecting the symbols.
> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch/include/asm/processor.h
> index 57ec45aa078e..1c4b4308378d 100644
> --- a/arch/loongarch/include/asm/processor.h
> +++ b/arch/loongarch/include/asm/processor.h
> @@ -101,6 +101,10 @@ struct thread_struct {
>         unsigned long reg23, reg24, reg25, reg26; /* s0-s3 */
>         unsigned long reg27, reg28, reg29, reg30, reg31; /* s4-s8 */
>
> +       /* __schedule() return address / call frame address */
> +       unsigned long sched_ra;
> +       unsigned long sched_cfa;
> +
>         /* CSR registers */
>         unsigned long csr_prmd;
>         unsigned long csr_crmd;
> @@ -129,6 +133,9 @@ struct thread_struct {
>         struct loongarch_fpu fpu FPU_ALIGN;
>  };
>
> +#define thread_saved_ra(tsk)   (tsk->thread.sched_ra)
> +#define thread_saved_fp(tsk)   (tsk->thread.sched_cfa)
> +
>  #define INIT_THREAD  {                                         \
>         /*                                                      \
>          * Main processor registers                             \
> @@ -145,6 +152,8 @@ struct thread_struct {
>         .reg29                  = 0,                            \
>         .reg30                  = 0,                            \
>         .reg31                  = 0,                            \
> +       .sched_ra               = 0,                            \
> +       .sched_cfa              = 0,                            \
>         .csr_crmd               = 0,                            \
>         .csr_prmd               = 0,                            \
>         .csr_euen               = 0,                            \
> diff --git a/arch/loongarch/include/asm/switch_to.h b/arch/loongarch/include/asm/switch_to.h
> index 2a8d04375574..43a5ab162d38 100644
> --- a/arch/loongarch/include/asm/switch_to.h
> +++ b/arch/loongarch/include/asm/switch_to.h
> @@ -15,12 +15,15 @@ struct task_struct;
>   * @prev:      The task previously executed.
>   * @next:      The task to begin executing.
>   * @next_ti:   task_thread_info(next).
> + * @sched_ra:  __schedule return address.
> + * @sched_cfa: __schedule call frame address.
>   *
>   * This function is used whilst scheduling to save the context of prev & load
>   * the context of next. Returns prev.
>   */
>  extern asmlinkage struct task_struct *__switch_to(struct task_struct *prev,
> -                       struct task_struct *next, struct thread_info *next_ti);
> +                       struct task_struct *next, struct thread_info *next_ti,
> +                       void *sched_ra, void *sched_cfa);
>
>  /*
>   * For newly created kernel threads switch_to() will return to
> @@ -28,10 +31,11 @@ extern asmlinkage struct task_struct *__switch_to(struct task_struct *prev,
>   * That is, everything following __switch_to() will be skipped for new threads.
>   * So everything that matters to new threads should be placed before __switch_to().
>   */
> -#define switch_to(prev, next, last)                                    \
> -do {                                                                   \
> -       lose_fpu_inatomic(1, prev);                                     \
> -       (last) = __switch_to(prev, next, task_thread_info(next));       \
> +#define switch_to(prev, next, last)                                            \
> +do {                                                                           \
> +       lose_fpu_inatomic(1, prev);                                             \
> +       (last) = __switch_to(prev, next, task_thread_info(next),                \
> +                __builtin_return_address(0), __builtin_frame_address(0));      \
>  } while (0)
>
>  #endif /* _ASM_SWITCH_TO_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 918600e7b30f..7449513eb08d 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_EFI)             += efi.o
>  obj-$(CONFIG_CPU_HAS_FPU)      += fpu.o
>
>  obj-$(CONFIG_MODULES)          += module.o module-sections.o
> +obj-$(CONFIG_STACKTRACE)        += stacktrace.o
>
>  obj-$(CONFIG_PROC_FS)          += proc.o
>
> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
> index 20cd9e16a95a..eb350f3ffae5 100644
> --- a/arch/loongarch/kernel/asm-offsets.c
> +++ b/arch/loongarch/kernel/asm-offsets.c
> @@ -103,6 +103,8 @@ void output_thread_defines(void)
>         OFFSET(THREAD_REG29, task_struct, thread.reg29);
>         OFFSET(THREAD_REG30, task_struct, thread.reg30);
>         OFFSET(THREAD_REG31, task_struct, thread.reg31);
> +       OFFSET(THREAD_SCHED_RA, task_struct, thread.sched_ra);
> +       OFFSET(THREAD_SCHED_CFA, task_struct, thread.sched_cfa);
>         OFFSET(THREAD_CSRCRMD, task_struct,
>                thread.csr_crmd);
>         OFFSET(THREAD_CSRPRMD, task_struct,
> diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
> index 709b7a1664f8..34c3f2148714 100644
> --- a/arch/loongarch/kernel/process.c
> +++ b/arch/loongarch/kernel/process.c
> @@ -135,6 +135,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>         childregs = (struct pt_regs *) childksp - 1;
>         /*  Put the stack after the struct pt_regs.  */
>         childksp = (unsigned long) childregs;
> +       p->thread.sched_cfa = 0;
>         p->thread.csr_euen = 0;
>         p->thread.csr_crmd = csr_read32(LOONGARCH_CSR_CRMD);
>         p->thread.csr_prmd = csr_read32(LOONGARCH_CSR_PRMD);
> @@ -145,6 +146,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>                 p->thread.reg23 = (unsigned long)args->fn;
>                 p->thread.reg24 = (unsigned long)args->fn_arg;
>                 p->thread.reg01 = (unsigned long)ret_from_kernel_thread;
> +               p->thread.sched_ra = (unsigned long)ret_from_kernel_thread;
>                 memset(childregs, 0, sizeof(struct pt_regs));
>                 childregs->csr_euen = p->thread.csr_euen;
>                 childregs->csr_crmd = p->thread.csr_crmd;
> @@ -161,6 +163,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>
>         p->thread.reg03 = (unsigned long) childregs;
>         p->thread.reg01 = (unsigned long) ret_from_fork;
> +       p->thread.sched_ra = (unsigned long) ret_from_fork;
>
>         /*
>          * New tasks lose permission to use the fpu. This accelerates context
> diff --git a/arch/loongarch/kernel/stacktrace.c b/arch/loongarch/kernel/stacktrace.c
> new file mode 100644
> index 000000000000..f4f4b8ad3917
> --- /dev/null
> +++ b/arch/loongarch/kernel/stacktrace.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Stack trace management functions
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +#include <linux/sched.h>
> +#include <linux/stacktrace.h>
> +
> +#include <asm/stacktrace.h>
> +#include <asm/unwind.h>
> +
> +void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> +                    struct task_struct *task, struct pt_regs *regs)
> +{
> +       struct pt_regs dummyregs;
> +       struct unwind_state state;
> +       unsigned long addr;
> +
> +       regs = &dummyregs;
> +
> +       if (task == current) {
> +               regs->csr_era = (unsigned long)__builtin_return_address(0);
> +               regs->regs[3] = (unsigned long)__builtin_frame_address(0);
> +       } else {
> +               regs->csr_era = thread_saved_ra(task);
> +               regs->regs[3] = thread_saved_fp(task);
> +       }
> +
> +       regs->regs[1] = 0;
> +       for (unwind_start(&state, task, regs);
> +             !unwind_done(&state); unwind_next_frame(&state)) {
> +               addr = unwind_get_return_address(&state);
> +               if (!addr || !consume_entry(cookie, addr))
> +                       break;
> +       }
> +}
> diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
> index 37e84ac8ffc2..43ebbc3990f7 100644
> --- a/arch/loongarch/kernel/switch.S
> +++ b/arch/loongarch/kernel/switch.S
> @@ -21,6 +21,8 @@ SYM_FUNC_START(__switch_to)
>
>         cpu_save_nonscratch a0
>         stptr.d ra, a0, THREAD_REG01
> +       stptr.d a3, a0, THREAD_SCHED_RA
> +       stptr.d a4, a0, THREAD_SCHED_CFA
>         move    tp, a2
>         cpu_restore_nonscratch a1
>
> --
> 2.20.1
>

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85BB68B029
	for <lists+linux-arch@lfdr.de>; Sun,  5 Feb 2023 15:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjBEOFE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Feb 2023 09:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBEOE6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Feb 2023 09:04:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C8635AE;
        Sun,  5 Feb 2023 06:04:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DEC060BAF;
        Sun,  5 Feb 2023 14:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A88C433EF;
        Sun,  5 Feb 2023 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675605881;
        bh=qeBlf/QHuK6X7DN7GHboVr8pp0QLqSPWX3mq2nAP39c=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=dgNGVYsvpKSib2jIbsXKA/bIo58a/IVBj5rxze7wAK889lv43welK6zUFTsp092VP
         VZNvyth8ejZC8WtNNhXYy3c6NqPna50au0kNEfBeE6z5N1j+GrvQ9GmX4k1jg9ILrk
         P6GnIc80ycWqGG9X6K0qpJ18956W4CDu27Zef/S2r6JYysEdfy856wH8zQn+RtsyIN
         B8KaQtq0RzwwKD7AU/Y/ns5RXz8plo/OsYbE7X6r/RY0hG+NjnQLuAvSg6S6djpvUw
         AWccD8VdTnKWcGUVcODdXf0C3Rcj9CoCc0AJkcG8Bimksm34mtynnlfeWgcHzPgrks
         d0WAuLwBUuJWg==
Date:   Sun, 05 Feb 2023 15:04:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Guo Ren <guoren@kernel.org>
CC:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, miguel.ojeda.sandonis@gmail.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>
Subject: Re: [PATCH -next V16 4/7] riscv: entry: Convert to generic entry
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJF2gTTFb+h-tzTiwj=SBjEqjRwbsRvCn=vpvdW26aEaqc_Z3A@mail.gmail.com>
References: <20230204070213.753369-1-guoren@kernel.org> <20230204070213.753369-5-guoren@kernel.org> <D6D12456-3A6F-4AD2-B5D8-4DD83C8D0DE6@kernel.org> <CAJF2gTTFb+h-tzTiwj=SBjEqjRwbsRvCn=vpvdW26aEaqc_Z3A@mail.gmail.com>
Message-ID: <A1D7112B-5738-4DF5-906B-76535647EF28@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 5 February 2023 14:56:01 GMT+01:00, Guo Ren <guoren@kernel=2Eorg> wrote=
:
>On Sun, Feb 5, 2023 at 6:43 PM Conor Dooley <conor@kernel=2Eorg> wrote:
>>
>> Hey Guo Ren,
>>
>> On 4 February 2023 08:02:10 GMT+01:00, guoren@kernel=2Eorg wrote:
>> >From: Guo Ren <guoren@linux=2Ealibaba=2Ecom>
>> >
>> >This patch converts riscv to use the generic entry infrastructure from
>> >kernel/entry/*=2E The generic entry makes maintainers' work easier and
>> >codes more elegant=2E Here are the changes:
>> >
>> > - More clear entry=2ES with handle_exception and ret_from_exception
>> > - Get rid of complex custom signal implementation
>> > - Move syscall procedure from assembly to C, which is much more
>> >   readable=2E
>> > - Connect ret_from_fork & ret_from_kernel_thread to generic entry=2E
>> > - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
>> > - Use the standard preemption code instead of custom
>> >
>> >Suggested-by: Huacai Chen <chenhuacai@kernel=2Eorg>
>> >Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc=2Ecom>
>> >Tested-by: Yipeng Zou <zouyipeng@huawei=2Ecom>
>> >Tested-by: Jisheng Zhang <jszhang@kernel=2Eorg>
>> >Signed-off-by: Guo Ren <guoren@linux=2Ealibaba=2Ecom>
>> >Signed-off-by: Guo Ren <guoren@kernel=2Eorg>
>> >Cc: Ben Hutchings <ben@decadent=2Eorg=2Euk>
>> >---
>>
>> Got some new errors added by this patch:
>> https://gist=2Egithub=2Ecom/conor-pwbot/3b300050a7a4a197bca809935584d80=
9
>>
>> Unfortunately I'm away from a computer at FOSDEM, so I haven't done any=
 investigation
>> of the warnings=2E
>> Should be reproduceable with gcc-12 allmodconfig=2E
>Thx for report, but:
>The spin_shadow_stack is from '7e1864332fbc ("riscv: fix race when
>vmap stack overflow")'=2E Not this patch=2E
>
>New errors added:
>--- /tmp/tmp=2EnyMxgc6CGx 2023-02-05 05:12:59=2E949595120 +0000
>+++ /tmp/tmp=2E5td5fIdaHX 2023-02-05 05:12:59=2E961595119 +0000
>@@ -10 +10 @@
>- 1 =2E=2E/arch/riscv/kernel/traps=2Ec:231:15: warning: symbol
>'spin_shadow_stack' was not declared=2E Should it be static?
>+ 1 =2E=2E/arch/riscv/kernel/traps=2Ec:335:15: warning: symbol
>'spin_shadow_stack' was not declared=2E Should it be static?
>@@ -9109 +9109 @@
>- 37 =2E=2E/include/linux/fortify-string=2Eh:522:25: warning: call to
>'__read_overflow2_field' declared with attribute warning: detected
>read beyond size of field (2nd parameter); maybe use struct_group()?
>[-Wattribute-warning]
>+ 38 =2E=2E/include/linux/fortify-string=2Eh:522:25: warning: call to
>'__read_overflow2_field' declared with attribute warning: detected
>read beyond size of field (2nd parameter); maybe use struct_group()?
>[-Wattribute-warning]
>Per-file breakdown
>--- /tmp/tmp=2EbHiHUVMzmZ 2023-02-05 05:13:00=2E109595117 +0000
>+++ /tmp/tmp=2EkUkOd6TrGj 2023-02-05 05:13:00=2E257595114 +0000
>@@ -1197 +1197 @@
>- 65 =2E=2E/include/linux/fortify-string=2Eh
>+ 66 =2E=2E/include/linux/fortify-string=2Eh
>
>Seems the line number change would cause your script to report old
>errors as new=2E So it would be best to improve the check script, such
>as ignoring the first column line number :)

I thought it already did!
I might've messed up in a refactoring of the script=2E
I'll fix it up when I get home so, sorry for the noise!

>
>>
>> Thanks,
>> Conor=2E
>>
>>
>> > arch/riscv/Kconfig                      |   1 +
>> > arch/riscv/include/asm/asm-prototypes=2Eh |   2 +
>> > arch/riscv/include/asm/csr=2Eh            |   1 -
>> > arch/riscv/include/asm/entry-common=2Eh   |  11 ++
>> > arch/riscv/include/asm/ptrace=2Eh         |  10 +-
>> > arch/riscv/include/asm/stacktrace=2Eh     |   5 +
>> > arch/riscv/include/asm/syscall=2Eh        |  21 ++
>> > arch/riscv/include/asm/thread_info=2Eh    |  13 +-
>> > arch/riscv/kernel/entry=2ES               | 242 ++++-----------------=
---
>> > arch/riscv/kernel/head=2Eh                |   1 -
>> > arch/riscv/kernel/ptrace=2Ec              |  43 -----
>> > arch/riscv/kernel/signal=2Ec              |  29 +--
>> > arch/riscv/kernel/traps=2Ec               | 140 ++++++++++++--
>> > arch/riscv/mm/fault=2Ec                   |   6 +-
>> > 14 files changed, 210 insertions(+), 315 deletions(-)
>> > create mode 100644 arch/riscv/include/asm/entry-common=2Eh
>> >
>> >diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> >index 7c814fbf9527=2E=2Ecbac7b4e3e06 100644
>> >--- a/arch/riscv/Kconfig
>> >+++ b/arch/riscv/Kconfig
>> >@@ -58,6 +58,7 @@ config RISCV
>> >       select GENERIC_ATOMIC64 if !64BIT
>> >       select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>> >       select GENERIC_EARLY_IOREMAP
>> >+      select GENERIC_ENTRY
>> >       select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
>> >       select GENERIC_IDLE_POLL_SETUP
>> >       select GENERIC_IOREMAP if MMU
>> >diff --git a/arch/riscv/include/asm/asm-prototypes=2Eh b/arch/riscv/in=
clude/asm/asm-prototypes=2Eh
>> >index ef386fcf3939=2E=2E61ba8ed43d8f 100644
>> >--- a/arch/riscv/include/asm/asm-prototypes=2Eh
>> >+++ b/arch/riscv/include/asm/asm-prototypes=2Eh
>> >@@ -27,5 +27,7 @@ DECLARE_DO_ERROR_INFO(do_trap_break);
>> >
>> > asmlinkage unsigned long get_overflow_stack(void);
>> > asmlinkage void handle_bad_stack(struct pt_regs *regs);
>> >+asmlinkage void do_page_fault(struct pt_regs *regs);
>> >+asmlinkage void do_irq(struct pt_regs *regs);
>> >
>> > #endif /* _ASM_RISCV_PROTOTYPES_H */
>> >diff --git a/arch/riscv/include/asm/csr=2Eh b/arch/riscv/include/asm/c=
sr=2Eh
>> >index 0e571f6483d9=2E=2E7c2b8cdb7b77 100644
>> >--- a/arch/riscv/include/asm/csr=2Eh
>> >+++ b/arch/riscv/include/asm/csr=2Eh
>> >@@ -40,7 +40,6 @@
>> > #define SR_UXL                _AC(0x300000000, UL) /* XLEN mask for U=
-mode */
>> > #define SR_UXL_32     _AC(0x100000000, UL) /* XLEN =3D 32 for U-mode =
*/
>> > #define SR_UXL_64     _AC(0x200000000, UL) /* XLEN =3D 64 for U-mode =
*/
>> >-#define SR_UXL_SHIFT  32
>> > #endif
>> >
>> > /* SATP flags */
>> >diff --git a/arch/riscv/include/asm/entry-common=2Eh b/arch/riscv/incl=
ude/asm/entry-common=2Eh
>> >new file mode 100644
>> >index 000000000000=2E=2E6e4dee49d84b
>> >--- /dev/null
>> >+++ b/arch/riscv/include/asm/entry-common=2Eh
>> >@@ -0,0 +1,11 @@
>> >+/* SPDX-License-Identifier: GPL-2=2E0 */
>> >+
>> >+#ifndef _ASM_RISCV_ENTRY_COMMON_H
>> >+#define _ASM_RISCV_ENTRY_COMMON_H
>> >+
>> >+#include <asm/stacktrace=2Eh>
>> >+
>> >+void handle_page_fault(struct pt_regs *regs);
>> >+void handle_break(struct pt_regs *regs);
>> >+
>> >+#endif /* _ASM_RISCV_ENTRY_COMMON_H */
>> >diff --git a/arch/riscv/include/asm/ptrace=2Eh b/arch/riscv/include/as=
m/ptrace=2Eh
>> >index 6ecd461129d2=2E=2Eb5b0adcc85c1 100644
>> >--- a/arch/riscv/include/asm/ptrace=2Eh
>> >+++ b/arch/riscv/include/asm/ptrace=2Eh
>> >@@ -53,6 +53,9 @@ struct pt_regs {
>> >       unsigned long orig_a0;
>> > };
>> >
>> >+#define PTRACE_SYSEMU                 0x1f
>> >+#define PTRACE_SYSEMU_SINGLESTEP      0x20
>> >+
>> > #ifdef CONFIG_64BIT
>> > #define REG_FMT "%016lx"
>> > #else
>> >@@ -121,8 +124,6 @@ extern unsigned long regs_get_kernel_stack_nth(str=
uct pt_regs *regs,
>> >
>> > void prepare_ftrace_return(unsigned long *parent, unsigned long self_=
addr,
>> >                          unsigned long frame_pointer);
>> >-int do_syscall_trace_enter(struct pt_regs *regs);
>> >-void do_syscall_trace_exit(struct pt_regs *regs);
>> >
>> > /**
>> >  * regs_get_register() - get register value from its offset
>> >@@ -172,6 +173,11 @@ static inline unsigned long regs_get_kernel_argum=
ent(struct pt_regs *regs,
>> >       return 0;
>> > }
>> >
>> >+static inline int regs_irqs_disabled(struct pt_regs *regs)
>> >+{
>> >+      return !(regs->status & SR_PIE);
>> >+}
>> >+
>> > #endif /* __ASSEMBLY__ */
>> >
>> > #endif /* _ASM_RISCV_PTRACE_H */
>> >diff --git a/arch/riscv/include/asm/stacktrace=2Eh b/arch/riscv/includ=
e/asm/stacktrace=2Eh
>> >index 3450c1912afd=2E=2Ef7e8ef2418b9 100644
>> >--- a/arch/riscv/include/asm/stacktrace=2Eh
>> >+++ b/arch/riscv/include/asm/stacktrace=2Eh
>> >@@ -16,4 +16,9 @@ extern void notrace walk_stackframe(struct task_stru=
ct *task, struct pt_regs *re
>> > extern void dump_backtrace(struct pt_regs *regs, struct task_struct *=
task,
>> >                          const char *loglvl);
>> >
>> >+static inline bool on_thread_stack(void)
>> >+{
>> >+      return !(((unsigned long)(current->stack) ^ current_stack_point=
er) & ~(THREAD_SIZE - 1));
>> >+}
>> >+
>> > #endif /* _ASM_RISCV_STACKTRACE_H */
>> >diff --git a/arch/riscv/include/asm/syscall=2Eh b/arch/riscv/include/a=
sm/syscall=2Eh
>> >index 384a63b86420=2E=2E736110e1fd78 100644
>> >--- a/arch/riscv/include/asm/syscall=2Eh
>> >+++ b/arch/riscv/include/asm/syscall=2Eh
>> >@@ -74,5 +74,26 @@ static inline int syscall_get_arch(struct task_stru=
ct *task)
>> > #endif
>> > }
>> >
>> >+typedef long (*syscall_t)(ulong, ulong, ulong, ulong, ulong, ulong, u=
long);
>> >+static inline void syscall_handler(struct pt_regs *regs, ulong syscal=
l)
>> >+{
>> >+      syscall_t fn;
>> >+
>> >+#ifdef CONFIG_COMPAT
>> >+      if ((regs->status & SR_UXL) =3D=3D SR_UXL_32)
>> >+              fn =3D compat_sys_call_table[syscall];
>> >+      else
>> >+#endif
>> >+              fn =3D sys_call_table[syscall];
>> >+
>> >+      regs->a0 =3D fn(regs->orig_a0, regs->a1, regs->a2,
>> >+                    regs->a3, regs->a4, regs->a5, regs->a6);
>> >+}
>> >+
>> >+static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *reg=
s)
>> >+{
>> >+      return false;
>> >+}
>> >+
>> > asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_=
t);
>> > #endif        /* _ASM_RISCV_SYSCALL_H */
>> >diff --git a/arch/riscv/include/asm/thread_info=2Eh b/arch/riscv/inclu=
de/asm/thread_info=2Eh
>> >index 67322f878e0d=2E=2E7de4fb96f0b5 100644
>> >--- a/arch/riscv/include/asm/thread_info=2Eh
>> >+++ b/arch/riscv/include/asm/thread_info=2Eh
>> >@@ -66,6 +66,7 @@ struct thread_info {
>> >       long                    kernel_sp;      /* Kernel stack pointer=
 */
>> >       long                    user_sp;        /* User stack pointer *=
/
>> >       int                     cpu;
>> >+      unsigned long           syscall_work;   /* SYSCALL_WORK_ flags =
*/
>> > };
>> >
>> > /*
>> >@@ -88,26 +89,18 @@ struct thread_info {
>> >  * - pending work-to-be-done flags are in lowest half-word
>> >  * - other flags in upper half-word(s)
>> >  */
>> >-#define TIF_SYSCALL_TRACE     0       /* syscall trace active */
>> > #define TIF_NOTIFY_RESUME     1       /* callback before returning to=
 user */
>> > #define TIF_SIGPENDING                2       /* signal pending */
>> > #define TIF_NEED_RESCHED      3       /* rescheduling necessary */
>> > #define TIF_RESTORE_SIGMASK   4       /* restore signal mask in do_si=
gnal() */
>> > #define TIF_MEMDIE            5       /* is terminating due to OOM ki=
ller */
>> >-#define TIF_SYSCALL_TRACEPOINT  6       /* syscall tracepoint instrum=
entation */
>> >-#define TIF_SYSCALL_AUDIT     7       /* syscall auditing */
>> >-#define TIF_SECCOMP           8       /* syscall secure computing */
>> > #define TIF_NOTIFY_SIGNAL     9       /* signal notifications exist *=
/
>> > #define TIF_UPROBE            10      /* uprobe breakpoint or singles=
tep */
>> > #define TIF_32BIT             11      /* compat-mode 32bit process */
>> >
>> >-#define _TIF_SYSCALL_TRACE    (1 << TIF_SYSCALL_TRACE)
>> > #define _TIF_NOTIFY_RESUME    (1 << TIF_NOTIFY_RESUME)
>> > #define _TIF_SIGPENDING               (1 << TIF_SIGPENDING)
>> > #define _TIF_NEED_RESCHED     (1 << TIF_NEED_RESCHED)
>> >-#define _TIF_SYSCALL_TRACEPOINT       (1 << TIF_SYSCALL_TRACEPOINT)
>> >-#define _TIF_SYSCALL_AUDIT    (1 << TIF_SYSCALL_AUDIT)
>> >-#define _TIF_SECCOMP          (1 << TIF_SECCOMP)
>> > #define _TIF_NOTIFY_SIGNAL    (1 << TIF_NOTIFY_SIGNAL)
>> > #define _TIF_UPROBE           (1 << TIF_UPROBE)
>> >
>> >@@ -115,8 +108,4 @@ struct thread_info {
>> >       (_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
>> >        _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
>> >
>> >-#define _TIF_SYSCALL_WORK \
>> >-      (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AU=
DIT | \
>> >-       _TIF_SECCOMP)
>> >-
>> > #endif /* _ASM_RISCV_THREAD_INFO_H */
>> >diff --git a/arch/riscv/kernel/entry=2ES b/arch/riscv/kernel/entry=2ES
>> >index 99d38fdf8b18=2E=2Ebc322f92ba34 100644
>> >--- a/arch/riscv/kernel/entry=2ES
>> >+++ b/arch/riscv/kernel/entry=2ES
>> >@@ -14,11 +14,7 @@
>> > #include <asm/asm-offsets=2Eh>
>> > #include <asm/errata_list=2Eh>
>> >
>> >-#if !IS_ENABLED(CONFIG_PREEMPTION)
>> >-=2Eset resume_kernel, restore_all
>> >-#endif
>> >-
>> >-ENTRY(handle_exception)
>> >+SYM_CODE_START(handle_exception)
>> >       /*
>> >        * If coming from userspace, preserve the user thread pointer a=
nd load
>> >        * the kernel thread pointer=2E  If we came from the kernel, th=
e scratch
>> >@@ -106,19 +102,8 @@ _save_context:
>> > =2Eoption norelax
>> >       la gp, __global_pointer$
>> > =2Eoption pop
>> >-
>> >-#ifdef CONFIG_TRACE_IRQFLAGS
>> >-      call __trace_hardirqs_off
>> >-#endif
>> >-
>> >-#ifdef CONFIG_CONTEXT_TRACKING_USER
>> >-      /* If previous state is in user mode, call user_exit_callable()=
=2E */
>> >-      li   a0, SR_PP
>> >-      and a0, s1, a0
>> >-      bnez a0, skip_context_tracking
>> >-      call user_exit_callable
>> >-skip_context_tracking:
>> >-#endif
>> >+      move a0, sp /* pt_regs */
>> >+      la ra, ret_from_exception
>> >
>> >       /*
>> >        * MSB of cause differentiates between
>> >@@ -126,38 +111,13 @@ skip_context_tracking:
>> >        */
>> >       bge s4, zero, 1f
>> >
>> >-      la ra, ret_from_exception
>> >-
>> >       /* Handle interrupts */
>> >-      move a0, sp /* pt_regs */
>> >-      la a1, generic_handle_arch_irq
>> >-      jr a1
>> >-1:
>> >-      /*
>> >-       * Exceptions run with interrupts enabled or disabled depending=
 on the
>> >-       * state of SR_PIE in m/sstatus=2E
>> >-       */
>> >-      andi t0, s1, SR_PIE
>> >-      beqz t0, 1f
>> >-      /* kprobes, entered via ebreak, must have interrupts disabled=
=2E */
>> >-      li t0, EXC_BREAKPOINT
>> >-      beq s4, t0, 1f
>> >-#ifdef CONFIG_TRACE_IRQFLAGS
>> >-      call __trace_hardirqs_on
>> >-#endif
>> >-      csrs CSR_STATUS, SR_IE
>> >-
>> >+      tail do_irq
>> > 1:
>> >-      la ra, ret_from_exception
>> >-      /* Handle syscalls */
>> >-      li t0, EXC_SYSCALL
>> >-      beq s4, t0, handle_syscall
>> >-
>> >       /* Handle other exceptions */
>> >       slli t0, s4, RISCV_LGPTR
>> >       la t1, excp_vect_table
>> >       la t2, excp_vect_table_end
>> >-      move a0, sp /* pt_regs */
>> >       add t0, t1, t0
>> >       /* Check if exception code lies within bounds */
>> >       bgeu t0, t2, 1f
>> >@@ -165,95 +125,17 @@ skip_context_tracking:
>> >       jr t0
>> > 1:
>> >       tail do_trap_unknown
>> >+SYM_CODE_END(handle_exception)
>> >
>> >-handle_syscall:
>> >-#ifdef CONFIG_RISCV_M_MODE
>> >-      /*
>> >-       * When running is M-Mode (no MMU config), MPIE does not get se=
t=2E
>> >-       * As a result, we need to force enable interrupts here because
>> >-       * handle_exception did not do set SR_IE as it always sees SR_P=
IE
>> >-       * being cleared=2E
>> >-       */
>> >-      csrs CSR_STATUS, SR_IE
>> >-#endif
>> >-#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING=
_USER)
>> >-      /* Recover a0 - a7 for system calls */
>> >-      REG_L a0, PT_A0(sp)
>> >-      REG_L a1, PT_A1(sp)
>> >-      REG_L a2, PT_A2(sp)
>> >-      REG_L a3, PT_A3(sp)
>> >-      REG_L a4, PT_A4(sp)
>> >-      REG_L a5, PT_A5(sp)
>> >-      REG_L a6, PT_A6(sp)
>> >-      REG_L a7, PT_A7(sp)
>> >-#endif
>> >-       /* save the initial A0 value (needed in signal handlers) */
>> >-      REG_S a0, PT_ORIG_A0(sp)
>> >-      /*
>> >-       * Advance SEPC to avoid executing the original
>> >-       * scall instruction on sret
>> >-       */
>> >-      addi s2, s2, 0x4
>> >-      REG_S s2, PT_EPC(sp)
>> >-      /* Trace syscalls, but only if requested by the user=2E */
>> >-      REG_L t0, TASK_TI_FLAGS(tp)
>> >-      andi t0, t0, _TIF_SYSCALL_WORK
>> >-      bnez t0, handle_syscall_trace_enter
>> >-check_syscall_nr:
>> >-      /* Check to make sure we don't jump to a bogus syscall number=
=2E */
>> >-      li t0, __NR_syscalls
>> >-      la s0, sys_ni_syscall
>> >-      /*
>> >-       * Syscall number held in a7=2E
>> >-       * If syscall number is above allowed value, redirect to ni_sys=
call=2E
>> >-       */
>> >-      bgeu a7, t0, 3f
>> >-#ifdef CONFIG_COMPAT
>> >-      REG_L s0, PT_STATUS(sp)
>> >-      srli s0, s0, SR_UXL_SHIFT
>> >-      andi s0, s0, (SR_UXL >> SR_UXL_SHIFT)
>> >-      li t0, (SR_UXL_32 >> SR_UXL_SHIFT)
>> >-      sub t0, s0, t0
>> >-      bnez t0, 1f
>> >-
>> >-      /* Call compat_syscall */
>> >-      la s0, compat_sys_call_table
>> >-      j 2f
>> >-1:
>> >-#endif
>> >-      /* Call syscall */
>> >-      la s0, sys_call_table
>> >-2:
>> >-      slli t0, a7, RISCV_LGPTR
>> >-      add s0, s0, t0
>> >-      REG_L s0, 0(s0)
>> >-3:
>> >-      jalr s0
>> >-
>> >-ret_from_syscall:
>> >-      /* Set user a0 to kernel a0 */
>> >-      REG_S a0, PT_A0(sp)
>> >-      /*
>> >-       * We didn't execute the actual syscall=2E
>> >-       * Seccomp already set return value for the current task pt_reg=
s=2E
>> >-       * (If it was configured with SECCOMP_RET_ERRNO/TRACE)
>> >-       */
>> >-ret_from_syscall_rejected:
>> >-#ifdef CONFIG_DEBUG_RSEQ
>> >-      move a0, sp
>> >-      call rseq_syscall
>> >-#endif
>> >-      /* Trace syscalls, but only if requested by the user=2E */
>> >-      REG_L t0, TASK_TI_FLAGS(tp)
>> >-      andi t0, t0, _TIF_SYSCALL_WORK
>> >-      bnez t0, handle_syscall_trace_exit
>> >-
>> >+/*
>> >+ * The ret_from_exception must be called with interrupt disabled=2E H=
ere is the
>> >+ * caller list:
>> >+ *  - handle_exception
>> >+ *  - ret_from_fork
>> >+ *  - ret_from_kernel_thread
>> >+ */
>> > SYM_CODE_START_NOALIGN(ret_from_exception)
>> >       REG_L s0, PT_STATUS(sp)
>> >-      csrc CSR_STATUS, SR_IE
>> >-#ifdef CONFIG_TRACE_IRQFLAGS
>> >-      call __trace_hardirqs_off
>> >-#endif
>> > #ifdef CONFIG_RISCV_M_MODE
>> >       /* the MPP value is too large to be used as an immediate arg fo=
r addi */
>> >       li t0, SR_MPP
>> >@@ -261,17 +143,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>> > #else
>> >       andi s0, s0, SR_SPP
>> > #endif
>> >-      bnez s0, resume_kernel
>> >-SYM_CODE_END(ret_from_exception)
>> >-
>> >-      /* Interrupts must be disabled here so flags are checked atomic=
ally */
>> >-      REG_L s0, TASK_TI_FLAGS(tp) /* current_thread_info->flags */
>> >-      andi s1, s0, _TIF_WORK_MASK
>> >-      bnez s1, resume_userspace_slow
>> >-resume_userspace:
>> >-#ifdef CONFIG_CONTEXT_TRACKING_USER
>> >-      call user_enter_callable
>> >-#endif
>> >+      bnez s0, 1f
>> >
>> >       /* Save unwound kernel stack pointer in thread_info */
>> >       addi s0, sp, PT_SIZE_ON_STACK
>> >@@ -282,18 +154,7 @@ resume_userspace:
>> >        * structures again=2E
>> >        */
>> >       csrw CSR_SCRATCH, tp
>> >-
>> >-restore_all:
>> >-#ifdef CONFIG_TRACE_IRQFLAGS
>> >-      REG_L s1, PT_STATUS(sp)
>> >-      andi t0, s1, SR_PIE
>> >-      beqz t0, 1f
>> >-      call __trace_hardirqs_on
>> >-      j 2f
>> > 1:
>> >-      call __trace_hardirqs_off
>> >-2:
>> >-#endif
>> >       REG_L a0, PT_STATUS(sp)
>> >       /*
>> >        * The current load reservation is effectively part of the proc=
essor's
>> >@@ -356,47 +217,10 @@ restore_all:
>> > #else
>> >       sret
>> > #endif
>> >-
>> >-#if IS_ENABLED(CONFIG_PREEMPTION)
>> >-resume_kernel:
>> >-      REG_L s0, TASK_TI_PREEMPT_COUNT(tp)
>> >-      bnez s0, restore_all
>> >-      REG_L s0, TASK_TI_FLAGS(tp)
>> >-      andi s0, s0, _TIF_NEED_RESCHED
>> >-      beqz s0, restore_all
>> >-      call preempt_schedule_irq
>> >-      j restore_all
>> >-#endif
>> >-
>> >-resume_userspace_slow:
>> >-      /* Enter slow path for supplementary processing */
>> >-      move a0, sp /* pt_regs */
>> >-      move a1, s0 /* current_thread_info->flags */
>> >-      call do_work_pending
>> >-      j resume_userspace
>> >-
>> >-/* Slow paths for ptrace=2E */
>> >-handle_syscall_trace_enter:
>> >-      move a0, sp
>> >-      call do_syscall_trace_enter
>> >-      move t0, a0
>> >-      REG_L a0, PT_A0(sp)
>> >-      REG_L a1, PT_A1(sp)
>> >-      REG_L a2, PT_A2(sp)
>> >-      REG_L a3, PT_A3(sp)
>> >-      REG_L a4, PT_A4(sp)
>> >-      REG_L a5, PT_A5(sp)
>> >-      REG_L a6, PT_A6(sp)
>> >-      REG_L a7, PT_A7(sp)
>> >-      bnez t0, ret_from_syscall_rejected
>> >-      j check_syscall_nr
>> >-handle_syscall_trace_exit:
>> >-      move a0, sp
>> >-      call do_syscall_trace_exit
>> >-      j ret_from_exception
>> >+SYM_CODE_END(ret_from_exception)
>> >
>> > #ifdef CONFIG_VMAP_STACK
>> >-handle_kernel_stack_overflow:
>> >+SYM_CODE_START_LOCAL(handle_kernel_stack_overflow)
>> >       /*
>> >        * Takes the psuedo-spinlock for the shadow stack, in case mult=
iple
>> >        * harts are concurrently overflowing their kernel stacks=2E  W=
e could
>> >@@ -505,23 +329,25 @@ restore_caller_reg:
>> >       REG_S s5, PT_TP(sp)
>> >       move a0, sp
>> >       tail handle_bad_stack
>> >+SYM_CODE_END(handle_kernel_stack_overflow)
>> > #endif
>> >
>> >-END(handle_exception)
>> >-
>> >-ENTRY(ret_from_fork)
>> >+SYM_CODE_START(ret_from_fork)
>> >+      call schedule_tail
>> >+      move a0, sp /* pt_regs */
>> >       la ra, ret_from_exception
>> >-      tail schedule_tail
>> >-ENDPROC(ret_from_fork)
>> >+      tail syscall_exit_to_user_mode
>> >+SYM_CODE_END(ret_from_fork)
>> >
>> >-ENTRY(ret_from_kernel_thread)
>> >+SYM_CODE_START(ret_from_kernel_thread)
>> >       call schedule_tail
>> >       /* Call fn(arg) */
>> >-      la ra, ret_from_exception
>> >       move a0, s1
>> >-      jr s0
>> >-ENDPROC(ret_from_kernel_thread)
>> >-
>> >+      jalr s0
>> >+      move a0, sp /* pt_regs */
>> >+      la ra, ret_from_exception
>> >+      tail syscall_exit_to_user_mode
>> >+SYM_CODE_END(ret_from_kernel_thread)
>> >
>> > /*
>> >  * Integer register context switch
>> >@@ -533,7 +359,7 @@ ENDPROC(ret_from_kernel_thread)
>> >  * The value of a0 and a1 must be preserved by this function, as that=
's how
>> >  * arguments are passed to schedule_tail=2E
>> >  */
>> >-ENTRY(__switch_to)
>> >+SYM_FUNC_START(__switch_to)
>> >       /* Save context into prev->thread */
>> >       li    a4,  TASK_THREAD_RA
>> >       add   a3, a0, a4
>> >@@ -570,7 +396,7 @@ ENTRY(__switch_to)
>> >       /* The offset of thread_info in task_struct is zero=2E */
>> >       move tp, a1
>> >       ret
>> >-ENDPROC(__switch_to)
>> >+SYM_FUNC_END(__switch_to)
>> >
>> > #ifndef CONFIG_MMU
>> > #define do_page_fault do_trap_unknown
>> >@@ -579,7 +405,7 @@ ENDPROC(__switch_to)
>> >       =2Esection "=2Erodata"
>> >       =2Ealign LGREG
>> >       /* Exception vector table */
>> >-ENTRY(excp_vect_table)
>> >+SYM_CODE_START(excp_vect_table)
>> >       RISCV_PTR do_trap_insn_misaligned
>> >       ALT_INSN_FAULT(RISCV_PTR do_trap_insn_fault)
>> >       RISCV_PTR do_trap_insn_illegal
>> >@@ -588,7 +414,7 @@ ENTRY(excp_vect_table)
>> >       RISCV_PTR do_trap_load_fault
>> >       RISCV_PTR do_trap_store_misaligned
>> >       RISCV_PTR do_trap_store_fault
>> >-      RISCV_PTR do_trap_ecall_u /* system call, gets intercepted */
>> >+      RISCV_PTR do_trap_ecall_u /* system call */
>> >       RISCV_PTR do_trap_ecall_s
>> >       RISCV_PTR do_trap_unknown
>> >       RISCV_PTR do_trap_ecall_m
>> >@@ -598,11 +424,11 @@ ENTRY(excp_vect_table)
>> >       RISCV_PTR do_trap_unknown
>> >       RISCV_PTR do_page_fault   /* store page fault */
>> > excp_vect_table_end:
>> >-END(excp_vect_table)
>> >+SYM_CODE_END(excp_vect_table)
>> >
>> > #ifndef CONFIG_MMU
>> >-ENTRY(__user_rt_sigreturn)
>> >+SYM_CODE_START(__user_rt_sigreturn)
>> >       li a7, __NR_rt_sigreturn
>> >       scall
>> >-END(__user_rt_sigreturn)
>> >+SYM_CODE_END(__user_rt_sigreturn)
>> > #endif
>> >diff --git a/arch/riscv/kernel/head=2Eh b/arch/riscv/kernel/head=2Eh
>> >index 726731ada534=2E=2Ea556fdaafed9 100644
>> >--- a/arch/riscv/kernel/head=2Eh
>> >+++ b/arch/riscv/kernel/head=2Eh
>> >@@ -10,7 +10,6 @@
>> >
>> > extern atomic_t hart_lottery;
>> >
>> >-asmlinkage void do_page_fault(struct pt_regs *regs);
>> > asmlinkage void __init setup_vm(uintptr_t dtb_pa);
>> > #ifdef CONFIG_XIP_KERNEL
>> > asmlinkage void __init __copy_data(void);
>> >diff --git a/arch/riscv/kernel/ptrace=2Ec b/arch/riscv/kernel/ptrace=
=2Ec
>> >index 44f4b1ca315d=2E=2E23c48b14a0e7 100644
>> >--- a/arch/riscv/kernel/ptrace=2Ec
>> >+++ b/arch/riscv/kernel/ptrace=2Ec
>> >@@ -19,9 +19,6 @@
>> > #include <linux/sched=2Eh>
>> > #include <linux/sched/task_stack=2Eh>
>> >
>> >-#define CREATE_TRACE_POINTS
>> >-#include <trace/events/syscalls=2Eh>
>> >-
>> > enum riscv_regset {
>> >       REGSET_X,
>> > #ifdef CONFIG_FPU
>> >@@ -228,46 +225,6 @@ long arch_ptrace(struct task_struct *child, long =
request,
>> >       return ret;
>> > }
>> >
>> >-/*
>> >- * Allows PTRACE_SYSCALL to work=2E  These are called from entry=2ES =
in
>> >- * {handle,ret_from}_syscall=2E
>> >- */
>> >-__visible int do_syscall_trace_enter(struct pt_regs *regs)
>> >-{
>> >-      if (test_thread_flag(TIF_SYSCALL_TRACE))
>> >-              if (ptrace_report_syscall_entry(regs))
>> >-                      return -1;
>> >-
>> >-      /*
>> >-       * Do the secure computing after ptrace; failures should be fas=
t=2E
>> >-       * If this fails we might have return value in a0 from seccomp
>> >-       * (via SECCOMP_RET_ERRNO/TRACE)=2E
>> >-       */
>> >-      if (secure_computing() =3D=3D -1)
>> >-              return -1;
>> >-
>> >-#ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
>> >-      if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>> >-              trace_sys_enter(regs, syscall_get_nr(current, regs));
>> >-#endif
>> >-
>> >-      audit_syscall_entry(regs->a7, regs->a0, regs->a1, regs->a2, reg=
s->a3);
>> >-      return 0;
>> >-}
>> >-
>> >-__visible void do_syscall_trace_exit(struct pt_regs *regs)
>> >-{
>> >-      audit_syscall_exit(regs);
>> >-
>> >-      if (test_thread_flag(TIF_SYSCALL_TRACE))
>> >-              ptrace_report_syscall_exit(regs, 0);
>> >-
>> >-#ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
>> >-      if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>> >-              trace_sys_exit(regs, regs_return_value(regs));
>> >-#endif
>> >-}
>> >-
>> > #ifdef CONFIG_COMPAT
>> > static int compat_riscv_gpr_get(struct task_struct *target,
>> >                               const struct user_regset *regset,
>> >diff --git a/arch/riscv/kernel/signal=2Ec b/arch/riscv/kernel/signal=
=2Ec
>> >index bfb2afa4135f=2E=2E2e365084417e 100644
>> >--- a/arch/riscv/kernel/signal=2Ec
>> >+++ b/arch/riscv/kernel/signal=2Ec
>> >@@ -12,6 +12,7 @@
>> > #include <linux/syscalls=2Eh>
>> > #include <linux/resume_user_mode=2Eh>
>> > #include <linux/linkage=2Eh>
>> >+#include <linux/entry-common=2Eh>
>> >
>> > #include <asm/ucontext=2Eh>
>> > #include <asm/vdso=2Eh>
>> >@@ -274,7 +275,7 @@ static void handle_signal(struct ksignal *ksig, st=
ruct pt_regs *regs)
>> >       signal_setup_done(ret, ksig, 0);
>> > }
>> >
>> >-static void do_signal(struct pt_regs *regs)
>> >+void arch_do_signal_or_restart(struct pt_regs *regs)
>> > {
>> >       struct ksignal ksig;
>> >
>> >@@ -311,29 +312,3 @@ static void do_signal(struct pt_regs *regs)
>> >        */
>> >       restore_saved_sigmask();
>> > }
>> >-
>> >-/*
>> >- * Handle any pending work on the resume-to-userspace path, as indica=
ted by
>> >- * _TIF_WORK_MASK=2E Entered from assembly with IRQs off=2E
>> >- */
>> >-asmlinkage __visible void do_work_pending(struct pt_regs *regs,
>> >-                                        unsigned long thread_info_fla=
gs)
>> >-{
>> >-      do {
>> >-              if (thread_info_flags & _TIF_NEED_RESCHED) {
>> >-                      schedule();
>> >-              } else {
>> >-                      local_irq_enable();
>> >-                      if (thread_info_flags & _TIF_UPROBE)
>> >-                              uprobe_notify_resume(regs);
>> >-                      /* Handle pending signal delivery */
>> >-                      if (thread_info_flags & (_TIF_SIGPENDING |
>> >-                                               _TIF_NOTIFY_SIGNAL))
>> >-                              do_signal(regs);
>> >-                      if (thread_info_flags & _TIF_NOTIFY_RESUME)
>> >-                              resume_user_mode_work(regs);
>> >-              }
>> >-              local_irq_disable();
>> >-              thread_info_flags =3D read_thread_flags();
>> >-      } while (thread_info_flags & _TIF_WORK_MASK);
>> >-}
>> >diff --git a/arch/riscv/kernel/traps=2Ec b/arch/riscv/kernel/traps=2Ec
>> >index 96ec76c54ff2=2E=2E69d619ddbcd5 100644
>> >--- a/arch/riscv/kernel/traps=2Ec
>> >+++ b/arch/riscv/kernel/traps=2Ec
>> >@@ -17,12 +17,14 @@
>> > #include <linux/module=2Eh>
>> > #include <linux/irq=2Eh>
>> > #include <linux/kexec=2Eh>
>> >+#include <linux/entry-common=2Eh>
>> >
>> > #include <asm/asm-prototypes=2Eh>
>> > #include <asm/bug=2Eh>
>> > #include <asm/csr=2Eh>
>> > #include <asm/processor=2Eh>
>> > #include <asm/ptrace=2Eh>
>> >+#include <asm/syscall=2Eh>
>> > #include <asm/thread_info=2Eh>
>> >
>> > int show_unhandled_signals =3D 1;
>> >@@ -99,10 +101,18 @@ static void do_trap_error(struct pt_regs *regs, i=
nt signo, int code,
>> > #else
>> > #define __trap_section noinstr
>> > #endif
>> >-#define DO_ERROR_INFO(name, signo, code, str)                        =
 \
>> >-asmlinkage __visible __trap_section void name(struct pt_regs *regs)  =
 \
>> >-{                                                                    =
 \
>> >-      do_trap_error(regs, signo, code, regs->epc, "Oops - " str);    =
 \
>> >+#define DO_ERROR_INFO(name, signo, code, str)                        =
         \
>> >+asmlinkage __visible __trap_section void name(struct pt_regs *regs)  =
         \
>> >+{                                                                    =
         \
>> >+      if (user_mode(regs)) {                                         =
         \
>> >+              irqentry_enter_from_user_mode(regs);                   =
         \
>> >+              do_trap_error(regs, signo, code, regs->epc, "Oops - " s=
tr);     \
>> >+              irqentry_exit_to_user_mode(regs);                      =
         \
>> >+      } else {                                                       =
         \
>> >+              irqentry_state_t state =3D irqentry_nmi_enter(regs);   =
           \
>> >+              do_trap_error(regs, signo, code, regs->epc, "Oops - " s=
tr);     \
>> >+              irqentry_nmi_exit(regs, state);                        =
         \
>> >+      }                                                              =
         \
>> > }
>> >
>> > DO_ERROR_INFO(do_trap_unknown,
>> >@@ -124,26 +134,50 @@ DO_ERROR_INFO(do_trap_store_misaligned,
>> > int handle_misaligned_load(struct pt_regs *regs);
>> > int handle_misaligned_store(struct pt_regs *regs);
>> >
>> >-asmlinkage void __trap_section do_trap_load_misaligned(struct pt_regs=
 *regs)
>> >+asmlinkage __visible __trap_section void do_trap_load_misaligned(stru=
ct pt_regs *regs)
>> > {
>> >-      if (!handle_misaligned_load(regs))
>> >-              return;
>> >-      do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
>> >-                    "Oops - load address misaligned");
>> >+      if (user_mode(regs)) {
>> >+              irqentry_enter_from_user_mode(regs);
>> >+
>> >+              if (handle_misaligned_load(regs))
>> >+                      do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->e=
pc,
>> >+                            "Oops - load address misaligned");
>> >+
>> >+              irqentry_exit_to_user_mode(regs);
>> >+      } else {
>> >+              irqentry_state_t state =3D irqentry_nmi_enter(regs);
>> >+
>> >+              if (handle_misaligned_load(regs))
>> >+                      do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->e=
pc,
>> >+                            "Oops - load address misaligned");
>> >+
>> >+              irqentry_nmi_exit(regs, state);
>> >+      }
>> > }
>> >
>> >-asmlinkage void __trap_section do_trap_store_misaligned(struct pt_reg=
s *regs)
>> >+asmlinkage __visible __trap_section void do_trap_store_misaligned(str=
uct pt_regs *regs)
>> > {
>> >-      if (!handle_misaligned_store(regs))
>> >-              return;
>> >-      do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
>> >-                    "Oops - store (or AMO) address misaligned");
>> >+      if (user_mode(regs)) {
>> >+              irqentry_enter_from_user_mode(regs);
>> >+
>> >+              if (handle_misaligned_store(regs))
>> >+
>
>
>

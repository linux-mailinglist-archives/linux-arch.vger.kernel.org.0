Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CD940351A
	for <lists+linux-arch@lfdr.de>; Wed,  8 Sep 2021 09:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348951AbhIHHRQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Sep 2021 03:17:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348183AbhIHHRM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Sep 2021 03:17:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FF9E61175;
        Wed,  8 Sep 2021 07:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631085365;
        bh=1/IFokHOQ1uuA15hbhe9wXzJbAJFvWB7ePHuPLxg7v8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B0a7CUuGfDv2m9rXB24G5dzTbduwNsd+3QyoiIOuarViTacZYcTysWqrf0huM5qv5
         OL+ywiXiuQR/NS0/jYIWwfu2U5Awgomw334vkaouvqnjEzrjQ3ZoPHb248SIPUCf25
         2CoHeEHdrb2yIgeqhD0l4BfpsjYrUl+XXSsP3FJoeJfaknP1aI1W70zFQWBij1mEZ6
         2qyTqxtUuKuaoAlB/4GuRfDp7vpZFYI84Tr/EZDTLfH2GfcNMnis6mRiCIUtCuhavZ
         3v0geFfir+vVcSg0bUY36uTc9TjVLAcWs6GKUcseqlG4DUVXRLM+bmjzcmMDt/7IKC
         k5JRxSkiueNrA==
Received: by mail-vk1-f172.google.com with SMTP id h13so420072vkc.12;
        Wed, 08 Sep 2021 00:16:05 -0700 (PDT)
X-Gm-Message-State: AOAM5328Q1Z8PpEufs0xJQfefQu5b5AzOpqW0zzS7isCW8uxuGZEl8WS
        1J2HyR+f1eyJD8uvgBEArmLj+n83pNJ7HYRvMgI=
X-Google-Smtp-Source: ABdhPJw7eTkygZB0bXanELCk14o9H10//FESokujLPCyQpAw+a1XVIMJKP9Q7qapxCYW9nDKjEiAae++3o6QdWAjmTk=
X-Received: by 2002:a1f:72cb:: with SMTP id n194mr1101568vkc.11.1631085363632;
 Wed, 08 Sep 2021 00:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1630929519.git.chenfeiyang@loongson.cn> <ec14e242a73227bf5314bbc1b585919500e6fbc7.1630929519.git.chenfeiyang@loongson.cn>
 <59feb382-a4ab-c94e-8f71-10ad0c0ceceb@flygoat.com> <CACWXhKnA24KuJo33+OitPQVRRd3g_05DWRC2Dsnm7w8hVyKjNQ@mail.gmail.com>
In-Reply-To: <CACWXhKnA24KuJo33+OitPQVRRd3g_05DWRC2Dsnm7w8hVyKjNQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 8 Sep 2021 15:15:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4dfJH-a7=X8Kj0TgOjXs9jGLmSYmLj=U9VbuMm7+Gdmw@mail.gmail.com>
Message-ID: <CAAhV-H4dfJH-a7=X8Kj0TgOjXs9jGLmSYmLj=U9VbuMm7+Gdmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mips: convert syscall to generic entry
To:     =?UTF-8?B?6ZmI6aOe5oms?= <chris.chenfeiyang@gmail.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>

On Wed, Sep 8, 2021 at 10:08 AM =E9=99=88=E9=A3=9E=E6=89=AC <chris.chenfeiy=
ang@gmail.com> wrote:
>
> On Tue, 7 Sept 2021 at 21:49, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote=
:
> >
> >
> > =E5=9C=A8 2021/9/7 14:16, FreeFlyingSheep =E5=86=99=E9=81=93:
> > > From: Feiyang Chen <chenfeiyang@loongson.cn>
> > >
> > > Convert mips syscall to use the generic entry infrastructure from
> > > kernel/entry/*.
> > >
> > > There are a few special things on mips:
> > >
> > > - There is one type of syscall on mips32 (scall32-o32) and three type=
s
> > > of syscalls on mips64 (scall64-o32, scall64-n32 and scall64-n64). Now
> > > convert to C code to handle different types of syscalls.
> > >
> > > - For some special syscalls (e.g. fork, clone, clone3 and sysmips),
> > > save_static_function() wrapper is used to save static registers. Now
> > > SAVE_STATIC is used in handle_sys before calling do_syscall(), so the
> > > save_static_function() wrapper can be removed.
> > >
> > > - For sigreturn/rt_sigreturn and sysmips, inline assembly is used to
> > > jump to syscall_exit directly for skipping setting the error flag and
> > > restoring all registers. Now use regs->regs[27] to mark whether to
> > > handle the error flag and always restore all registers in handle_sys,
> > > so these functions can return normally as other architecture.
> >
> > Hmm, that would give us overhead of register context on these syscalls.
> >
> > I guess it's worthy?
> >
>
> Hi, Jiaxun,
>
> Saving and restoring registers against different system calls can be
> difficult due to the use of generic entry.
> To avoid a lot of duplicate code, I think the overhead is worth it.
>
> > >
> > > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> >
> > For the code,
> >
> > Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >
> > After spending 3hrs diving into syscall handling hell, I must say you'v=
e
> > done a good job. I'll start a LTP run to see if we miss any corner
> > cases. And left IRQ part for another trial.
> >
>
> Thank you for your review. I've already run tests in Unixbench.
> It's more reassuring to run tests in LTP, so I'll do that too.
>
> Thanks,
> Feiyang
>
> > Thanks.
> >
> > Jiaxun
> >
> > > ---
> > >   arch/mips/Kconfig                         |   1 +
> > >   arch/mips/include/asm/entry-common.h      |  13 ++
> > >   arch/mips/include/asm/ptrace.h            |   8 +-
> > >   arch/mips/include/asm/sim.h               |  70 -------
> > >   arch/mips/include/asm/syscall.h           |   5 +
> > >   arch/mips/include/asm/thread_info.h       |  17 +-
> > >   arch/mips/include/uapi/asm/ptrace.h       |   7 +-
> > >   arch/mips/kernel/Makefile                 |  14 +-
> > >   arch/mips/kernel/entry.S                  |  75 ++------
> > >   arch/mips/kernel/linux32.c                |   1 -
> > >   arch/mips/kernel/ptrace.c                 |  78 --------
> > >   arch/mips/kernel/scall.S                  | 135 +++++++++++++
> > >   arch/mips/kernel/scall32-o32.S            | 223 -------------------=
---
> > >   arch/mips/kernel/scall64-n32.S            | 107 -----------
> > >   arch/mips/kernel/scall64-n64.S            | 116 -----------
> > >   arch/mips/kernel/scall64-o32.S            | 221 -------------------=
--
> > >   arch/mips/kernel/signal.c                 |  35 ++--
> > >   arch/mips/kernel/signal_n32.c             |  15 +-
> > >   arch/mips/kernel/signal_o32.c             |  29 +--
> > >   arch/mips/kernel/syscall.c                | 147 +++++++++++---
> > >   arch/mips/kernel/syscalls/syscall_n32.tbl |   8 +-
> > >   arch/mips/kernel/syscalls/syscall_n64.tbl |   8 +-
> > >   arch/mips/kernel/syscalls/syscall_o32.tbl |   8 +-
> > >   23 files changed, 346 insertions(+), 995 deletions(-)
> > >   create mode 100644 arch/mips/include/asm/entry-common.h
> > >   delete mode 100644 arch/mips/include/asm/sim.h
> > >   create mode 100644 arch/mips/kernel/scall.S
> > >   delete mode 100644 arch/mips/kernel/scall32-o32.S
> > >   delete mode 100644 arch/mips/kernel/scall64-n32.S
> > >   delete mode 100644 arch/mips/kernel/scall64-n64.S
> > >   delete mode 100644 arch/mips/kernel/scall64-o32.S
> > >
> > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > index 0cf31a6cbee1..61aa125aa2da 100644
> > > --- a/arch/mips/Kconfig
> > > +++ b/arch/mips/Kconfig
> > > @@ -32,6 +32,7 @@ config MIPS
> > >       select GENERIC_ATOMIC64 if !64BIT
> > >       select GENERIC_CMOS_UPDATE
> > >       select GENERIC_CPU_AUTOPROBE
> > > +     select GENERIC_ENTRY
> > >       select GENERIC_GETTIMEOFDAY
> > >       select GENERIC_IOMAP
> > >       select GENERIC_IRQ_PROBE
> > > diff --git a/arch/mips/include/asm/entry-common.h b/arch/mips/include=
/asm/entry-common.h
> > > new file mode 100644
> > > index 000000000000..0fe2a098ded9
> > > --- /dev/null
> > > +++ b/arch/mips/include/asm/entry-common.h
> > > @@ -0,0 +1,13 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef ARCH_LOONGARCH_ENTRY_COMMON_H
> > > +#define ARCH_LOONGARCH_ENTRY_COMMON_H
> > > +
> > > +#include <linux/sched.h>
> > > +#include <linux/processor.h>
> > > +
> > > +static inline bool on_thread_stack(void)
> > > +{
> > > +     return !(((unsigned long)(current->stack) ^ current_stack_point=
er) & ~(THREAD_SIZE - 1));
> > > +}
> > > +
> > > +#endif
> > > diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/p=
trace.h
> > > index daf3cf244ea9..1b8f9d2ddc44 100644
> > > --- a/arch/mips/include/asm/ptrace.h
> > > +++ b/arch/mips/include/asm/ptrace.h
> > > @@ -51,6 +51,11 @@ struct pt_regs {
> > >       unsigned long __last[0];
> > >   } __aligned(8);
> > >
> > > +static inline int regs_irqs_disabled(struct pt_regs *regs)
> > > +{
> > > +     return arch_irqs_disabled_flags(regs->cp0_status);
> > > +}
> > > +
> > >   static inline unsigned long kernel_stack_pointer(struct pt_regs *re=
gs)
> > >   {
> > >       return regs->regs[29];
> > > @@ -156,9 +161,6 @@ static inline long regs_return_value(struct pt_re=
gs *regs)
> > >   #define instruction_pointer(regs) ((regs)->cp0_epc)
> > >   #define profile_pc(regs) instruction_pointer(regs)
> > >
> > > -extern asmlinkage long syscall_trace_enter(struct pt_regs *regs, lon=
g syscall);
> > > -extern asmlinkage void syscall_trace_leave(struct pt_regs *regs);
> > > -
> > >   extern void die(const char *, struct pt_regs *) __noreturn;
> > >
> > >   static inline void die_if_kernel(const char *str, struct pt_regs *r=
egs)
> > > diff --git a/arch/mips/include/asm/sim.h b/arch/mips/include/asm/sim.=
h
> > > deleted file mode 100644
> > > index 59f31a95facd..000000000000
> > > --- a/arch/mips/include/asm/sim.h
> > > +++ /dev/null
> > > @@ -1,70 +0,0 @@
> > > -/*
> > > - * This file is subject to the terms and conditions of the GNU Gener=
al Public
> > > - * License.  See the file "COPYING" in the main directory of this ar=
chive
> > > - * for more details.
> > > - *
> > > - * Copyright (C) 1999, 2000, 2003 Ralf Baechle
> > > - * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> > > - */
> > > -#ifndef _ASM_SIM_H
> > > -#define _ASM_SIM_H
> > > -
> > > -
> > > -#include <asm/asm-offsets.h>
> > > -
> > > -#define __str2(x) #x
> > > -#define __str(x) __str2(x)
> > > -
> > > -#ifdef CONFIG_32BIT
> > > -
> > > -#define save_static_function(symbol)                                =
 \
> > > -__asm__(                                                            =
 \
> > > -     ".text\n\t"                                                    =
 \
> > > -     ".globl\t__" #symbol "\n\t"                                    =
 \
> > > -     ".align\t2\n\t"                                                =
 \
> > > -     ".type\t__" #symbol ", @function\n\t"                          =
 \
> > > -     ".ent\t__" #symbol ", 0\n__"                                   =
 \
> > > -     #symbol":\n\t"                                                 =
 \
> > > -     ".frame\t$29, 0, $31\n\t"                                      =
 \
> > > -     "sw\t$16,"__str(PT_R16)"($29)\t\t\t# save_static_function\n\t" =
 \
> > > -     "sw\t$17,"__str(PT_R17)"($29)\n\t"                             =
 \
> > > -     "sw\t$18,"__str(PT_R18)"($29)\n\t"                             =
 \
> > > -     "sw\t$19,"__str(PT_R19)"($29)\n\t"                             =
 \
> > > -     "sw\t$20,"__str(PT_R20)"($29)\n\t"                             =
 \
> > > -     "sw\t$21,"__str(PT_R21)"($29)\n\t"                             =
 \
> > > -     "sw\t$22,"__str(PT_R22)"($29)\n\t"                             =
 \
> > > -     "sw\t$23,"__str(PT_R23)"($29)\n\t"                             =
 \
> > > -     "sw\t$30,"__str(PT_R30)"($29)\n\t"                             =
 \
> > > -     "j\t" #symbol "\n\t"                                           =
 \
> > > -     ".end\t__" #symbol "\n\t"                                      =
 \
> > > -     ".size\t__" #symbol",. - __" #symbol)
> > > -
> > > -#endif /* CONFIG_32BIT */
> > > -
> > > -#ifdef CONFIG_64BIT
> > > -
> > > -#define save_static_function(symbol)                                =
 \
> > > -__asm__(                                                            =
 \
> > > -     ".text\n\t"                                                    =
 \
> > > -     ".globl\t__" #symbol "\n\t"                                    =
 \
> > > -     ".align\t2\n\t"                                                =
 \
> > > -     ".type\t__" #symbol ", @function\n\t"                          =
 \
> > > -     ".ent\t__" #symbol ", 0\n__"                                   =
 \
> > > -     #symbol":\n\t"                                                 =
 \
> > > -     ".frame\t$29, 0, $31\n\t"                                      =
 \
> > > -     "sd\t$16,"__str(PT_R16)"($29)\t\t\t# save_static_function\n\t" =
 \
> > > -     "sd\t$17,"__str(PT_R17)"($29)\n\t"                             =
 \
> > > -     "sd\t$18,"__str(PT_R18)"($29)\n\t"                             =
 \
> > > -     "sd\t$19,"__str(PT_R19)"($29)\n\t"                             =
 \
> > > -     "sd\t$20,"__str(PT_R20)"($29)\n\t"                             =
 \
> > > -     "sd\t$21,"__str(PT_R21)"($29)\n\t"                             =
 \
> > > -     "sd\t$22,"__str(PT_R22)"($29)\n\t"                             =
 \
> > > -     "sd\t$23,"__str(PT_R23)"($29)\n\t"                             =
 \
> > > -     "sd\t$30,"__str(PT_R30)"($29)\n\t"                             =
 \
> > > -     "j\t" #symbol "\n\t"                                           =
 \
> > > -     ".end\t__" #symbol "\n\t"                                      =
 \
> > > -     ".size\t__" #symbol",. - __" #symbol)
> > > -
> > > -#endif /* CONFIG_64BIT */
> > > -
> > > -#endif /* _ASM_SIM_H */
> > > diff --git a/arch/mips/include/asm/syscall.h b/arch/mips/include/asm/=
syscall.h
> > > index 25fa651c937d..02ca0d659428 100644
> > > --- a/arch/mips/include/asm/syscall.h
> > > +++ b/arch/mips/include/asm/syscall.h
> > > @@ -157,4 +157,9 @@ static inline int syscall_get_arch(struct task_st=
ruct *task)
> > >       return arch;
> > >   }
> > >
> > > +static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *re=
gs)
> > > +{
> > > +     return false;
> > > +}
> > > +
> > >   #endif      /* __ASM_MIPS_SYSCALL_H */
> > > diff --git a/arch/mips/include/asm/thread_info.h b/arch/mips/include/=
asm/thread_info.h
> > > index 0b17aaa9e012..5a5237413065 100644
> > > --- a/arch/mips/include/asm/thread_info.h
> > > +++ b/arch/mips/include/asm/thread_info.h
> > > @@ -29,7 +29,8 @@ struct thread_info {
> > >       __u32                   cpu;            /* current CPU */
> > >       int                     preempt_count;  /* 0 =3D> preemptable, =
<0 =3D> BUG */
> > >       struct pt_regs          *regs;
> > > -     long                    syscall;        /* syscall number */
> > > +     unsigned long           syscall;        /* syscall number */
> > > +     unsigned long           syscall_work;   /* SYSCALL_WORK_ flags =
*/
> > >   };
> > >
> > >   /*
> > > @@ -69,6 +70,8 @@ static inline struct thread_info *current_thread_in=
fo(void)
> > >       return __current_thread_info;
> > >   }
> > >
> > > +register unsigned long current_stack_pointer __asm__("$29");
> > > +
> > >   #endif /* !__ASSEMBLY__ */
> > >
> > >   /* thread information allocation */
> > > @@ -149,22 +152,10 @@ static inline struct thread_info *current_threa=
d_info(void)
> > >   #define _TIF_MSA_CTX_LIVE   (1<<TIF_MSA_CTX_LIVE)
> > >   #define _TIF_SYSCALL_TRACEPOINT     (1<<TIF_SYSCALL_TRACEPOINT)
> > >
> > > -#define _TIF_WORK_SYSCALL_ENTRY      (_TIF_NOHZ | _TIF_SYSCALL_TRACE=
 |       \
> > > -                              _TIF_SYSCALL_AUDIT | \
> > > -                              _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP=
)
> > > -
> > > -/* work to do in syscall_trace_leave() */
> > > -#define _TIF_WORK_SYSCALL_EXIT       (_TIF_NOHZ | _TIF_SYSCALL_TRACE=
 |       \
> > > -                              _TIF_SYSCALL_AUDIT | _TIF_SYSCALL_TRAC=
EPOINT)
> > > -
> > >   /* work to do on interrupt/exception return */
> > >   #define _TIF_WORK_MASK              \
> > >       (_TIF_SIGPENDING | _TIF_NEED_RESCHED | _TIF_NOTIFY_RESUME |    =
 \
> > >        _TIF_UPROBE | _TIF_NOTIFY_SIGNAL)
> > > -/* work to do on any return to u-space */
> > > -#define _TIF_ALLWORK_MASK    (_TIF_NOHZ | _TIF_WORK_MASK |          =
 \
> > > -                              _TIF_WORK_SYSCALL_EXIT |              =
 \
> > > -                              _TIF_SYSCALL_TRACEPOINT)
> > >
> > >   /*
> > >    * We stash processor id into a COP0 register to retrieve it fast
> > > diff --git a/arch/mips/include/uapi/asm/ptrace.h b/arch/mips/include/=
uapi/asm/ptrace.h
> > > index f3c025445e45..27e2c85398bc 100644
> > > --- a/arch/mips/include/uapi/asm/ptrace.h
> > > +++ b/arch/mips/include/uapi/asm/ptrace.h
> > > @@ -102,8 +102,9 @@ struct pt_watch_regs {
> > >       };
> > >   };
> > >
> > > -#define PTRACE_GET_WATCH_REGS        0xd0
> > > -#define PTRACE_SET_WATCH_REGS        0xd1
> > > -
> > > +#define PTRACE_SYSEMU                        0x1f
> > > +#define PTRACE_SYSEMU_SINGLESTEP     0x20
> > > +#define PTRACE_GET_WATCH_REGS                0xd0
> > > +#define PTRACE_SET_WATCH_REGS                0xd1
> > >
> > >   #endif /* _UAPI_ASM_PTRACE_H */
> > > diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> > > index 814b3da30501..44875660f6ae 100644
> > > --- a/arch/mips/kernel/Makefile
> > > +++ b/arch/mips/kernel/Makefile
> > > @@ -5,10 +5,10 @@
> > >
> > >   extra-y             :=3D head.o vmlinux.lds
> > >
> > > -obj-y                +=3D branch.o cmpxchg.o elf.o entry.o genex.o i=
dle.o irq.o \
> > > -                process.o prom.o ptrace.o reset.o setup.o signal.o \
> > > -                syscall.o time.o topology.o traps.o unaligned.o watc=
h.o \
> > > -                vdso.o cacheinfo.o
> > > +obj-y                +=3D branch.o cacheinfo.o cmpxchg.o elf.o entry=
.o genex.o \
> > > +                idle.o irq.o process.o prom.o ptrace.o reset.o scall=
.o \
> > > +                setup.o signal.o syscall.o time.o topology.o traps.o=
 \
> > > +                unaligned.o watch.o vdso.o
> > >
> > >   ifdef CONFIG_CPU_R3K_TLB
> > >   obj-y               +=3D cpu-r3k-probe.o
> > > @@ -76,11 +76,9 @@ obj-$(CONFIG_IRQ_TXX9)             +=3D irq_txx9.o
> > >   obj-$(CONFIG_IRQ_GT641XX)   +=3D irq-gt641xx.o
> > >
> > >   obj-$(CONFIG_KPROBES)               +=3D kprobes.o
> > > -obj-$(CONFIG_32BIT)          +=3D scall32-o32.o
> > > -obj-$(CONFIG_64BIT)          +=3D scall64-n64.o
> > >   obj-$(CONFIG_MIPS32_COMPAT) +=3D linux32.o ptrace32.o signal32.o
> > > -obj-$(CONFIG_MIPS32_N32)     +=3D scall64-n32.o signal_n32.o
> > > -obj-$(CONFIG_MIPS32_O32)     +=3D scall64-o32.o signal_o32.o
> > > +obj-$(CONFIG_MIPS32_N32)     +=3D signal_n32.o
> > > +obj-$(CONFIG_MIPS32_O32)     +=3D signal_o32.o
> > >
> > >   obj-$(CONFIG_KGDB)          +=3D kgdb.o
> > >   obj-$(CONFIG_PROC_FS)               +=3D proc.o
> > > diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
> > > index 4b896f5023ff..1a2aec9dab1b 100644
> > > --- a/arch/mips/kernel/entry.S
> > > +++ b/arch/mips/kernel/entry.S
> > > @@ -72,49 +72,32 @@ FEXPORT(ret_from_kernel_thread)
> > >       jal     schedule_tail           # a0 =3D struct task_struct *pr=
ev
> > >       move    a0, s1
> > >       jal     s0
> > > -     j       syscall_exit
> > > +     move    a0, sp
> > > +     jal     syscall_exit_to_user_mode
> > > +
> > > +     .set    noat
> > > +     RESTORE_STATIC
> > > +     RESTORE_SOME
> > > +     RESTORE_SP_AND_RET
> > > +     .set    at
> > >
> > >   FEXPORT(ret_from_fork)
> > >       jal     schedule_tail           # a0 =3D struct task_struct *pr=
ev
> > > -
> > > -FEXPORT(syscall_exit)
> > > -#ifdef CONFIG_DEBUG_RSEQ
> > >       move    a0, sp
> > > -     jal     rseq_syscall
> > > -#endif
> > > -     local_irq_disable               # make sure need_resched and
> > > -                                     # signals dont change between
> > > -                                     # sampling and return
> > > -     LONG_L  a2, TI_FLAGS($28)       # current->work
> > > -     li      t0, _TIF_ALLWORK_MASK
> > > -     and     t0, a2, t0
> > > -     bnez    t0, syscall_exit_work
> > > +     jal     syscall_exit_to_user_mode
> > >
> > > -restore_all:                         # restore full frame
> > >       .set    noat
> > > -     RESTORE_TEMP
> > > -     RESTORE_AT
> > >       RESTORE_STATIC
> > > -restore_partial:             # restore partial frame
> > > -#ifdef CONFIG_TRACE_IRQFLAGS
> > > -     SAVE_STATIC
> > > -     SAVE_AT
> > > -     SAVE_TEMP
> > > -     LONG_L  v0, PT_STATUS(sp)
> > > -#if defined(CONFIG_CPU_R3000) || defined(CONFIG_CPU_TX39XX)
> > > -     and     v0, ST0_IEP
> > > -#else
> > > -     and     v0, ST0_IE
> > > -#endif
> > > -     beqz    v0, 1f
> > > -     jal     trace_hardirqs_on
> > > -     b       2f
> > > -1:   jal     trace_hardirqs_off
> > > -2:
> > > +     RESTORE_SOME
> > > +     RESTORE_SP_AND_RET
> > > +     .set    at
> > > +
> > > +restore_all:                         # restore full frame
> > > +     .set    noat
> > >       RESTORE_TEMP
> > >       RESTORE_AT
> > >       RESTORE_STATIC
> > > -#endif
> > > +restore_partial:                     # restore partial frame
> > >       RESTORE_SOME
> > >       RESTORE_SP_AND_RET
> > >       .set    at
> > > @@ -143,32 +126,6 @@ work_notifysig:                          # deal =
with pending signals and
> > >       jal     do_notify_resume        # a2 already loaded
> > >       j       resume_userspace_check
> > >
> > > -FEXPORT(syscall_exit_partial)
> > > -#ifdef CONFIG_DEBUG_RSEQ
> > > -     move    a0, sp
> > > -     jal     rseq_syscall
> > > -#endif
> > > -     local_irq_disable               # make sure need_resched doesn'=
t
> > > -                                     # change between and return
> > > -     LONG_L  a2, TI_FLAGS($28)       # current->work
> > > -     li      t0, _TIF_ALLWORK_MASK
> > > -     and     t0, a2
> > > -     beqz    t0, restore_partial
> > > -     SAVE_STATIC
> > > -syscall_exit_work:
> > > -     LONG_L  t0, PT_STATUS(sp)               # returning to kernel m=
ode?
> > > -     andi    t0, t0, KU_USER
> > > -     beqz    t0, resume_kernel
> > > -     li      t0, _TIF_WORK_SYSCALL_EXIT
> > > -     and     t0, a2                  # a2 is preloaded with TI_FLAGS
> > > -     beqz    t0, work_pending        # trace bit set?
> > > -     local_irq_enable                # could let syscall_trace_leave=
()
> > > -                                     # call schedule() instead
> > > -     TRACE_IRQS_ON
> > > -     move    a0, sp
> > > -     jal     syscall_trace_leave
> > > -     b       resume_userspace
> > > -
> > >   #if defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR5) || \
> > >       defined(CONFIG_CPU_MIPSR6) || defined(CONFIG_MIPS_MT)
> > >
> > > diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
> > > index 6b61be486303..2b4b1fc1ff1b 100644
> > > --- a/arch/mips/kernel/linux32.c
> > > +++ b/arch/mips/kernel/linux32.c
> > > @@ -38,7 +38,6 @@
> > >   #include <net/scm.h>
> > >
> > >   #include <asm/compat-signal.h>
> > > -#include <asm/sim.h>
> > >   #include <linux/uaccess.h>
> > >   #include <asm/mmu_context.h>
> > >   #include <asm/mman.h>
> > > diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
> > > index db7c5be1d4a3..04c08e41cfd3 100644
> > > --- a/arch/mips/kernel/ptrace.c
> > > +++ b/arch/mips/kernel/ptrace.c
> > > @@ -46,9 +46,6 @@
> > >   #include <asm/bootinfo.h>
> > >   #include <asm/reg.h>
> > >
> > > -#define CREATE_TRACE_POINTS
> > > -#include <trace/events/syscalls.h>
> > > -
> > >   /*
> > >    * Called by kernel/ptrace.c when detaching..
> > >    *
> > > @@ -1305,78 +1302,3 @@ long arch_ptrace(struct task_struct *child, lo=
ng request,
> > >    out:
> > >       return ret;
> > >   }
> > > -
> > > -/*
> > > - * Notification of system call entry/exit
> > > - * - triggered by current->work.syscall_trace
> > > - */
> > > -asmlinkage long syscall_trace_enter(struct pt_regs *regs, long sysca=
ll)
> > > -{
> > > -     user_exit();
> > > -
> > > -     current_thread_info()->syscall =3D syscall;
> > > -
> > > -     if (test_thread_flag(TIF_SYSCALL_TRACE)) {
> > > -             if (tracehook_report_syscall_entry(regs))
> > > -                     return -1;
> > > -             syscall =3D current_thread_info()->syscall;
> > > -     }
> > > -
> > > -#ifdef CONFIG_SECCOMP
> > > -     if (unlikely(test_thread_flag(TIF_SECCOMP))) {
> > > -             int ret, i;
> > > -             struct seccomp_data sd;
> > > -             unsigned long args[6];
> > > -
> > > -             sd.nr =3D syscall;
> > > -             sd.arch =3D syscall_get_arch(current);
> > > -             syscall_get_arguments(current, regs, args);
> > > -             for (i =3D 0; i < 6; i++)
> > > -                     sd.args[i] =3D args[i];
> > > -             sd.instruction_pointer =3D KSTK_EIP(current);
> > > -
> > > -             ret =3D __secure_computing(&sd);
> > > -             if (ret =3D=3D -1)
> > > -                     return ret;
> > > -             syscall =3D current_thread_info()->syscall;
> > > -     }
> > > -#endif
> > > -
> > > -     if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
> > > -             trace_sys_enter(regs, regs->regs[2]);
> > > -
> > > -     audit_syscall_entry(syscall, regs->regs[4], regs->regs[5],
> > > -                         regs->regs[6], regs->regs[7]);
> > > -
> > > -     /*
> > > -      * Negative syscall numbers are mistaken for rejected syscalls,=
 but
> > > -      * won't have had the return value set appropriately, so we do =
so now.
> > > -      */
> > > -     if (syscall < 0)
> > > -             syscall_set_return_value(current, regs, -ENOSYS, 0);
> > > -     return syscall;
> > > -}
> > > -
> > > -/*
> > > - * Notification of system call entry/exit
> > > - * - triggered by current->work.syscall_trace
> > > - */
> > > -asmlinkage void syscall_trace_leave(struct pt_regs *regs)
> > > -{
> > > -        /*
> > > -      * We may come here right after calling schedule_user()
> > > -      * or do_notify_resume(), in which case we can be in RCU
> > > -      * user mode.
> > > -      */
> > > -     user_exit();
> > > -
> > > -     audit_syscall_exit(regs);
> > > -
> > > -     if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
> > > -             trace_sys_exit(regs, regs_return_value(regs));
> > > -
> > > -     if (test_thread_flag(TIF_SYSCALL_TRACE))
> > > -             tracehook_report_syscall_exit(regs, 0);
> > > -
> > > -     user_enter();
> > > -}
> > > diff --git a/arch/mips/kernel/scall.S b/arch/mips/kernel/scall.S
> > > new file mode 100644
> > > index 000000000000..7b35969151de
> > > --- /dev/null
> > > +++ b/arch/mips/kernel/scall.S
> > > @@ -0,0 +1,135 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 1995, 96, 97, 98, 99, 2000, 01, 02 by Ralf Baechle
> > > + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> > > + * Copyright (C) 2001 MIPS Technologies, Inc.
> > > + * Copyright (C) 2004 Thiemo Seufer
> > > + * Copyright (C) 2014 Imagination Technologies Ltd.
> > > + */
> > > +#include <linux/errno.h>
> > > +#include <asm/asm.h>
> > > +#include <asm/asmmacro.h>
> > > +#include <asm/irqflags.h>
> > > +#include <asm/mipsregs.h>
> > > +#include <asm/regdef.h>
> > > +#include <asm/stackframe.h>
> > > +#include <asm/asm-offsets.h>
> > > +#include <asm/sysmips.h>
> > > +#include <asm/thread_info.h>
> > > +#include <asm/unistd.h>
> > > +#include <asm/war.h>
> > > +
> > > +     .align  5
> > > +NESTED(handle_sys, PT_SIZE, sp)
> > > +     .set    noat
> > > +     SAVE_SOME
> > > +     SAVE_STATIC
> > > +     CLI
> > > +     .set    at
> > > +
> > > +     move    a0, sp
> > > +     jal     do_syscall
> > > +
> > > +     .set    noat
> > > +     RESTORE_TEMP
> > > +     RESTORE_AT
> > > +     RESTORE_STATIC
> > > +     RESTORE_SOME
> > > +     RESTORE_SP_AND_RET
> > > +     .set    at
> > > +     END(handle_sys)
> > > +
> > > +#ifdef CONFIG_32BIT
> > > +LEAF(sys_syscall)
> > > +     subu    t0, a0, __NR_O32_Linux          # check syscall number
> > > +     sltiu   v0, t0, __NR_O32_Linux_syscalls
> > > +     beqz    t0, einval                      # do not recurse
> > > +     sll     t1, t0, 2
> > > +     beqz    v0, einval
> > > +     lw      t2, sys_call_table(t1)          # syscall routine
> > > +
> > > +     move    a0, a1                          # shift argument regist=
ers
> > > +     move    a1, a2
> > > +     move    a2, a3
> > > +     lw      a3, 16(sp)
> > > +     lw      t4, 20(sp)
> > > +     lw      t5, 24(sp)
> > > +     lw      t6, 28(sp)
> > > +     sw      t4, 16(sp)
> > > +     sw      t5, 20(sp)
> > > +     sw      t6, 24(sp)
> > > +     jr      t2
> > > +     /* Unreached */
> > > +
> > > +einval: li   v0, -ENOSYS
> > > +     jr      ra
> > > +     END(sys_syscall)
> > > +
> > > +#ifdef CONFIG_MIPS_MT_FPAFF
> > > +     /*
> > > +      * For FPU affinity scheduling on MIPS MT processors, we need t=
o
> > > +      * intercept sys_sched_xxxaffinity() calls until we get a prope=
r hook
> > > +      * in kernel/sched/core.c.  Considered only temporary we only s=
upport
> > > +      * these hooks for the 32-bit kernel - there is no MIPS64 MT pr=
ocessor
> > > +      * atm.
> > > +      */
> > > +#define sys_sched_setaffinity        mipsmt_sys_sched_setaffinity
> > > +#define sys_sched_getaffinity        mipsmt_sys_sched_getaffinity
> > > +#endif /* CONFIG_MIPS_MT_FPAFF */
> > > +
> > > +#define __SYSCALL_WITH_COMPAT(nr, native, compat)    __SYSCALL(nr, n=
ative)
> > > +#define __SYSCALL(nr, entry)         PTR entry
> > > +     .align  2
> > > +     .type   sys_call_table, @object
> > > +EXPORT(sys_call_table)
> > > +#include <asm/syscall_table_o32.h>
> > > +#endif /* CONFIG_32BIT */
> > > +
> > > +#ifdef CONFIG_64BIT
> > > +#ifdef CONFIG_MIPS32_O32
> > > +LEAF(sys32_syscall)
> > > +     subu    t0, a0, __NR_O32_Linux          # check syscall number
> > > +     sltiu   v0, t0, __NR_O32_Linux_syscalls
> > > +     beqz    t0, einval                      # do not recurse
> > > +     dsll    t1, t0, 3
> > > +     beqz    v0, einval
> > > +     ld      t2, sys32_call_table(t1)        # syscall routine
> > > +
> > > +     move    a0, a1                          # shift argument regist=
ers
> > > +     move    a1, a2
> > > +     move    a2, a3
> > > +     move    a3, a4
> > > +     move    a4, a5
> > > +     move    a5, a6
> > > +     move    a6, a7
> > > +     jr      t2
> > > +     /* Unreached */
> > > +
> > > +einval: li   v0, -ENOSYS
> > > +     jr      ra
> > > +     END(sys32_syscall)
> > > +
> > > +#define __SYSCALL_WITH_COMPAT(nr, native, compat)    __SYSCALL(nr, c=
ompat)
> > > +#define __SYSCALL(nr, entry) PTR entry
> > > +     .align  3
> > > +     .type   sys32_call_table,@object
> > > +EXPORT(sys32_call_table)
> > > +#include <asm/syscall_table_o32.h>
> > > +#endif /* CONFIG_MIPS32_O32 */
> > > +
> > > +#ifdef CONFIG_MIPS32_N32
> > > +#undef __SYSCALL
> > > +#define __SYSCALL(nr, entry) PTR entry
> > > +     .align  3
> > > +     .type   sysn32_call_table, @object
> > > +EXPORT(sysn32_call_table)
> > > +#include <asm/syscall_table_n32.h>
> > > +#endif /* CONFIG_MIPS32_N32 */
> > > +
> > > +#undef __SYSCALL
> > > +#define __SYSCALL(nr, entry) PTR entry
> > > +     .align  3
> > > +     .type   sys_call_table, @object
> > > +EXPORT(sys_call_table)
> > > +#include <asm/syscall_table_n64.h>
> > > +#endif /* CONFIG_64BIT */
> > > diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall3=
2-o32.S
> > > deleted file mode 100644
> > > index b1b2e106f711..000000000000
> > > --- a/arch/mips/kernel/scall32-o32.S
> > > +++ /dev/null
> > > @@ -1,223 +0,0 @@
> > > -/*
> > > - * This file is subject to the terms and conditions of the GNU Gener=
al Public
> > > - * License.  See the file "COPYING" in the main directory of this ar=
chive
> > > - * for more details.
> > > - *
> > > - * Copyright (C) 1995-99, 2000- 02, 06 Ralf Baechle <ralf@linux-mips=
.org>
> > > - * Copyright (C) 2001 MIPS Technologies, Inc.
> > > - * Copyright (C) 2004 Thiemo Seufer
> > > - * Copyright (C) 2014 Imagination Technologies Ltd.
> > > - */
> > > -#include <linux/errno.h>
> > > -#include <asm/asm.h>
> > > -#include <asm/asmmacro.h>
> > > -#include <asm/irqflags.h>
> > > -#include <asm/mipsregs.h>
> > > -#include <asm/regdef.h>
> > > -#include <asm/stackframe.h>
> > > -#include <asm/isadep.h>
> > > -#include <asm/sysmips.h>
> > > -#include <asm/thread_info.h>
> > > -#include <asm/unistd.h>
> > > -#include <asm/war.h>
> > > -#include <asm/asm-offsets.h>
> > > -
> > > -     .align  5
> > > -NESTED(handle_sys, PT_SIZE, sp)
> > > -     .set    noat
> > > -     SAVE_SOME
> > > -     TRACE_IRQS_ON_RELOAD
> > > -     STI
> > > -     .set    at
> > > -
> > > -     lw      t1, PT_EPC(sp)          # skip syscall on return
> > > -
> > > -     addiu   t1, 4                   # skip to next instruction
> > > -     sw      t1, PT_EPC(sp)
> > > -
> > > -     sw      a3, PT_R26(sp)          # save a3 for syscall restartin=
g
> > > -
> > > -     /*
> > > -      * More than four arguments.  Try to deal with it by copying th=
e
> > > -      * stack arguments from the user stack to the kernel stack.
> > > -      * This Sucks (TM).
> > > -      */
> > > -     lw      t0, PT_R29(sp)          # get old user stack pointer
> > > -
> > > -     /*
> > > -      * We intentionally keep the kernel stack a little below the to=
p of
> > > -      * userspace so we don't have to do a slower byte accurate chec=
k here.
> > > -      */
> > > -     addu    t4, t0, 32
> > > -     bltz    t4, bad_stack           # -> sp is bad
> > > -
> > > -     /*
> > > -      * Ok, copy the args from the luser stack to the kernel stack.
> > > -      */
> > > -
> > > -     .set    push
> > > -     .set    noreorder
> > > -     .set    nomacro
> > > -
> > > -load_a4: user_lw(t5, 16(t0))         # argument #5 from usp
> > > -load_a5: user_lw(t6, 20(t0))         # argument #6 from usp
> > > -load_a6: user_lw(t7, 24(t0))         # argument #7 from usp
> > > -load_a7: user_lw(t8, 28(t0))         # argument #8 from usp
> > > -loads_done:
> > > -
> > > -     sw      t5, 16(sp)              # argument #5 to ksp
> > > -     sw      t6, 20(sp)              # argument #6 to ksp
> > > -     sw      t7, 24(sp)              # argument #7 to ksp
> > > -     sw      t8, 28(sp)              # argument #8 to ksp
> > > -     .set    pop
> > > -
> > > -     .section __ex_table,"a"
> > > -     PTR     load_a4, bad_stack_a4
> > > -     PTR     load_a5, bad_stack_a5
> > > -     PTR     load_a6, bad_stack_a6
> > > -     PTR     load_a7, bad_stack_a7
> > > -     .previous
> > > -
> > > -     lw      t0, TI_FLAGS($28)       # syscall tracing enabled?
> > > -     li      t1, _TIF_WORK_SYSCALL_ENTRY
> > > -     and     t0, t1
> > > -     bnez    t0, syscall_trace_entry # -> yes
> > > -syscall_common:
> > > -     subu    v0, v0, __NR_O32_Linux  # check syscall number
> > > -     sltiu   t0, v0, __NR_O32_Linux_syscalls
> > > -     beqz    t0, illegal_syscall
> > > -
> > > -     sll     t0, v0, 2
> > > -     la      t1, sys_call_table
> > > -     addu    t1, t0
> > > -     lw      t2, (t1)                # syscall routine
> > > -
> > > -     beqz    t2, illegal_syscall
> > > -
> > > -     jalr    t2                      # Do The Real Thing (TM)
> > > -
> > > -     li      t0, -EMAXERRNO - 1      # error?
> > > -     sltu    t0, t0, v0
> > > -     sw      t0, PT_R7(sp)           # set error flag
> > > -     beqz    t0, 1f
> > > -
> > > -     lw      t1, PT_R2(sp)           # syscall number
> > > -     negu    v0                      # error
> > > -     sw      t1, PT_R0(sp)           # save it for syscall restartin=
g
> > > -1:   sw      v0, PT_R2(sp)           # result
> > > -
> > > -o32_syscall_exit:
> > > -     j       syscall_exit_partial
> > > -
> > > -/* -----------------------------------------------------------------=
------- */
> > > -
> > > -syscall_trace_entry:
> > > -     SAVE_STATIC
> > > -     move    a0, sp
> > > -
> > > -     /*
> > > -      * syscall number is in v0 unless we called syscall(__NR_###)
> > > -      * where the real syscall number is in a0
> > > -      */
> > > -     move    a1, v0
> > > -     subu    t2, v0,  __NR_O32_Linux
> > > -     bnez    t2, 1f /* __NR_syscall at offset 0 */
> > > -     lw      a1, PT_R4(sp)
> > > -
> > > -1:   jal     syscall_trace_enter
> > > -
> > > -     bltz    v0, 1f                  # seccomp failed? Skip syscall
> > > -
> > > -     RESTORE_STATIC
> > > -     lw      v0, PT_R2(sp)           # Restore syscall (maybe modifi=
ed)
> > > -     lw      a0, PT_R4(sp)           # Restore argument registers
> > > -     lw      a1, PT_R5(sp)
> > > -     lw      a2, PT_R6(sp)
> > > -     lw      a3, PT_R7(sp)
> > > -     j       syscall_common
> > > -
> > > -1:   j       syscall_exit
> > > -
> > > -/* -----------------------------------------------------------------=
------- */
> > > -
> > > -     /*
> > > -      * Our open-coded access area sanity test for the stack pointer
> > > -      * failed. We probably should handle this case a bit more drast=
ic.
> > > -      */
> > > -bad_stack:
> > > -     li      v0, EFAULT
> > > -     sw      v0, PT_R2(sp)
> > > -     li      t0, 1                           # set error flag
> > > -     sw      t0, PT_R7(sp)
> > > -     j       o32_syscall_exit
> > > -
> > > -bad_stack_a4:
> > > -     li      t5, 0
> > > -     b       load_a5
> > > -
> > > -bad_stack_a5:
> > > -     li      t6, 0
> > > -     b       load_a6
> > > -
> > > -bad_stack_a6:
> > > -     li      t7, 0
> > > -     b       load_a7
> > > -
> > > -bad_stack_a7:
> > > -     li      t8, 0
> > > -     b       loads_done
> > > -
> > > -     /*
> > > -      * The system call does not exist in this kernel
> > > -      */
> > > -illegal_syscall:
> > > -     li      v0, ENOSYS                      # error
> > > -     sw      v0, PT_R2(sp)
> > > -     li      t0, 1                           # set error flag
> > > -     sw      t0, PT_R7(sp)
> > > -     j       o32_syscall_exit
> > > -     END(handle_sys)
> > > -
> > > -     LEAF(sys_syscall)
> > > -     subu    t0, a0, __NR_O32_Linux  # check syscall number
> > > -     sltiu   v0, t0, __NR_O32_Linux_syscalls
> > > -     beqz    t0, einval              # do not recurse
> > > -     sll     t1, t0, 2
> > > -     beqz    v0, einval
> > > -     lw      t2, sys_call_table(t1)          # syscall routine
> > > -
> > > -     move    a0, a1                          # shift argument regist=
ers
> > > -     move    a1, a2
> > > -     move    a2, a3
> > > -     lw      a3, 16(sp)
> > > -     lw      t4, 20(sp)
> > > -     lw      t5, 24(sp)
> > > -     lw      t6, 28(sp)
> > > -     sw      t4, 16(sp)
> > > -     sw      t5, 20(sp)
> > > -     sw      t6, 24(sp)
> > > -     jr      t2
> > > -     /* Unreached */
> > > -
> > > -einval: li   v0, -ENOSYS
> > > -     jr      ra
> > > -     END(sys_syscall)
> > > -
> > > -#ifdef CONFIG_MIPS_MT_FPAFF
> > > -     /*
> > > -      * For FPU affinity scheduling on MIPS MT processors, we need t=
o
> > > -      * intercept sys_sched_xxxaffinity() calls until we get a prope=
r hook
> > > -      * in kernel/sched/core.c.  Considered only temporary we only s=
upport
> > > -      * these hooks for the 32-bit kernel - there is no MIPS64 MT pr=
ocessor
> > > -      * atm.
> > > -      */
> > > -#define sys_sched_setaffinity        mipsmt_sys_sched_setaffinity
> > > -#define sys_sched_getaffinity        mipsmt_sys_sched_getaffinity
> > > -#endif /* CONFIG_MIPS_MT_FPAFF */
> > > -
> > > -#define __SYSCALL_WITH_COMPAT(nr, native, compat)    __SYSCALL(nr, n=
ative)
> > > -#define __SYSCALL(nr, entry)         PTR entry
> > > -     .align  2
> > > -     .type   sys_call_table, @object
> > > -EXPORT(sys_call_table)
> > > -#include <asm/syscall_table_o32.h>
> > > diff --git a/arch/mips/kernel/scall64-n32.S b/arch/mips/kernel/scall6=
4-n32.S
> > > deleted file mode 100644
> > > index f650c55a17dc..000000000000
> > > --- a/arch/mips/kernel/scall64-n32.S
> > > +++ /dev/null
> > > @@ -1,107 +0,0 @@
> > > -/*
> > > - * This file is subject to the terms and conditions of the GNU Gener=
al Public
> > > - * License.  See the file "COPYING" in the main directory of this ar=
chive
> > > - * for more details.
> > > - *
> > > - * Copyright (C) 1995, 96, 97, 98, 99, 2000, 01 by Ralf Baechle
> > > - * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> > > - * Copyright (C) 2001 MIPS Technologies, Inc.
> > > - */
> > > -#include <linux/errno.h>
> > > -#include <asm/asm.h>
> > > -#include <asm/asmmacro.h>
> > > -#include <asm/irqflags.h>
> > > -#include <asm/mipsregs.h>
> > > -#include <asm/regdef.h>
> > > -#include <asm/stackframe.h>
> > > -#include <asm/thread_info.h>
> > > -#include <asm/unistd.h>
> > > -
> > > -#ifndef CONFIG_MIPS32_O32
> > > -/* No O32, so define handle_sys here */
> > > -#define handle_sysn32 handle_sys
> > > -#endif
> > > -
> > > -     .align  5
> > > -NESTED(handle_sysn32, PT_SIZE, sp)
> > > -#ifndef CONFIG_MIPS32_O32
> > > -     .set    noat
> > > -     SAVE_SOME
> > > -     TRACE_IRQS_ON_RELOAD
> > > -     STI
> > > -     .set    at
> > > -#endif
> > > -
> > > -     dsubu   t0, v0, __NR_N32_Linux  # check syscall number
> > > -     sltiu   t0, t0, __NR_N32_Linux_syscalls
> > > -
> > > -#ifndef CONFIG_MIPS32_O32
> > > -     ld      t1, PT_EPC(sp)          # skip syscall on return
> > > -     daddiu  t1, 4                   # skip to next instruction
> > > -     sd      t1, PT_EPC(sp)
> > > -#endif
> > > -     beqz    t0, not_n32_scall
> > > -
> > > -     sd      a3, PT_R26(sp)          # save a3 for syscall restartin=
g
> > > -
> > > -     li      t1, _TIF_WORK_SYSCALL_ENTRY
> > > -     LONG_L  t0, TI_FLAGS($28)       # syscall tracing enabled?
> > > -     and     t0, t1, t0
> > > -     bnez    t0, n32_syscall_trace_entry
> > > -
> > > -syscall_common:
> > > -     dsll    t0, v0, 3               # offset into table
> > > -     ld      t2, (sysn32_call_table - (__NR_N32_Linux * 8))(t0)
> > > -
> > > -     jalr    t2                      # Do The Real Thing (TM)
> > > -
> > > -     li      t0, -EMAXERRNO - 1      # error?
> > > -     sltu    t0, t0, v0
> > > -     sd      t0, PT_R7(sp)           # set error flag
> > > -     beqz    t0, 1f
> > > -
> > > -     ld      t1, PT_R2(sp)           # syscall number
> > > -     dnegu   v0                      # error
> > > -     sd      t1, PT_R0(sp)           # save it for syscall restartin=
g
> > > -1:   sd      v0, PT_R2(sp)           # result
> > > -
> > > -     j       syscall_exit_partial
> > > -
> > > -/* -----------------------------------------------------------------=
------- */
> > > -
> > > -n32_syscall_trace_entry:
> > > -     SAVE_STATIC
> > > -     move    a0, sp
> > > -     move    a1, v0
> > > -     jal     syscall_trace_enter
> > > -
> > > -     bltz    v0, 1f                  # seccomp failed? Skip syscall
> > > -
> > > -     RESTORE_STATIC
> > > -     ld      v0, PT_R2(sp)           # Restore syscall (maybe modifi=
ed)
> > > -     ld      a0, PT_R4(sp)           # Restore argument registers
> > > -     ld      a1, PT_R5(sp)
> > > -     ld      a2, PT_R6(sp)
> > > -     ld      a3, PT_R7(sp)
> > > -     ld      a4, PT_R8(sp)
> > > -     ld      a5, PT_R9(sp)
> > > -
> > > -     dsubu   t2, v0, __NR_N32_Linux  # check (new) syscall number
> > > -     sltiu   t0, t2, __NR_N32_Linux_syscalls
> > > -     beqz    t0, not_n32_scall
> > > -
> > > -     j       syscall_common
> > > -
> > > -1:   j       syscall_exit
> > > -
> > > -not_n32_scall:
> > > -     /* This is not an n32 compatibility syscall, pass it on to
> > > -        the n64 syscall handlers.  */
> > > -     j       handle_sys64
> > > -
> > > -     END(handle_sysn32)
> > > -
> > > -#define __SYSCALL(nr, entry) PTR entry
> > > -     .type   sysn32_call_table, @object
> > > -EXPORT(sysn32_call_table)
> > > -#include <asm/syscall_table_n32.h>
> > > diff --git a/arch/mips/kernel/scall64-n64.S b/arch/mips/kernel/scall6=
4-n64.S
> > > deleted file mode 100644
> > > index 5d7bfc65e4d0..000000000000
> > > --- a/arch/mips/kernel/scall64-n64.S
> > > +++ /dev/null
> > > @@ -1,116 +0,0 @@
> > > -/*
> > > - * This file is subject to the terms and conditions of the GNU Gener=
al Public
> > > - * License.  See the file "COPYING" in the main directory of this ar=
chive
> > > - * for more details.
> > > - *
> > > - * Copyright (C) 1995, 96, 97, 98, 99, 2000, 01, 02 by Ralf Baechle
> > > - * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> > > - * Copyright (C) 2001 MIPS Technologies, Inc.
> > > - */
> > > -#include <linux/errno.h>
> > > -#include <asm/asm.h>
> > > -#include <asm/asmmacro.h>
> > > -#include <asm/irqflags.h>
> > > -#include <asm/mipsregs.h>
> > > -#include <asm/regdef.h>
> > > -#include <asm/stackframe.h>
> > > -#include <asm/asm-offsets.h>
> > > -#include <asm/sysmips.h>
> > > -#include <asm/thread_info.h>
> > > -#include <asm/unistd.h>
> > > -#include <asm/war.h>
> > > -
> > > -#ifndef CONFIG_MIPS32_COMPAT
> > > -/* Neither O32 nor N32, so define handle_sys here */
> > > -#define handle_sys64 handle_sys
> > > -#endif
> > > -
> > > -     .align  5
> > > -NESTED(handle_sys64, PT_SIZE, sp)
> > > -#if !defined(CONFIG_MIPS32_O32) && !defined(CONFIG_MIPS32_N32)
> > > -     /*
> > > -      * When 32-bit compatibility is configured scall_o32.S
> > > -      * already did this.
> > > -      */
> > > -     .set    noat
> > > -     SAVE_SOME
> > > -     TRACE_IRQS_ON_RELOAD
> > > -     STI
> > > -     .set    at
> > > -#endif
> > > -
> > > -#if !defined(CONFIG_MIPS32_O32) && !defined(CONFIG_MIPS32_N32)
> > > -     ld      t1, PT_EPC(sp)          # skip syscall on return
> > > -     daddiu  t1, 4                   # skip to next instruction
> > > -     sd      t1, PT_EPC(sp)
> > > -#endif
> > > -
> > > -     sd      a3, PT_R26(sp)          # save a3 for syscall restartin=
g
> > > -
> > > -     li      t1, _TIF_WORK_SYSCALL_ENTRY
> > > -     LONG_L  t0, TI_FLAGS($28)       # syscall tracing enabled?
> > > -     and     t0, t1, t0
> > > -     bnez    t0, syscall_trace_entry
> > > -
> > > -syscall_common:
> > > -     dsubu   t2, v0, __NR_64_Linux
> > > -     sltiu   t0, t2, __NR_64_Linux_syscalls
> > > -     beqz    t0, illegal_syscall
> > > -
> > > -     dsll    t0, t2, 3               # offset into table
> > > -     dla     t2, sys_call_table
> > > -     daddu   t0, t2, t0
> > > -     ld      t2, (t0)                # syscall routine
> > > -     beqz    t2, illegal_syscall
> > > -
> > > -     jalr    t2                      # Do The Real Thing (TM)
> > > -
> > > -     li      t0, -EMAXERRNO - 1      # error?
> > > -     sltu    t0, t0, v0
> > > -     sd      t0, PT_R7(sp)           # set error flag
> > > -     beqz    t0, 1f
> > > -
> > > -     ld      t1, PT_R2(sp)           # syscall number
> > > -     dnegu   v0                      # error
> > > -     sd      t1, PT_R0(sp)           # save it for syscall restartin=
g
> > > -1:   sd      v0, PT_R2(sp)           # result
> > > -
> > > -n64_syscall_exit:
> > > -     j       syscall_exit_partial
> > > -
> > > -/* -----------------------------------------------------------------=
------- */
> > > -
> > > -syscall_trace_entry:
> > > -     SAVE_STATIC
> > > -     move    a0, sp
> > > -     move    a1, v0
> > > -     jal     syscall_trace_enter
> > > -
> > > -     bltz    v0, 1f                  # seccomp failed? Skip syscall
> > > -
> > > -     RESTORE_STATIC
> > > -     ld      v0, PT_R2(sp)           # Restore syscall (maybe modifi=
ed)
> > > -     ld      a0, PT_R4(sp)           # Restore argument registers
> > > -     ld      a1, PT_R5(sp)
> > > -     ld      a2, PT_R6(sp)
> > > -     ld      a3, PT_R7(sp)
> > > -     ld      a4, PT_R8(sp)
> > > -     ld      a5, PT_R9(sp)
> > > -     j       syscall_common
> > > -
> > > -1:   j       syscall_exit
> > > -
> > > -illegal_syscall:
> > > -     /* This also isn't a 64-bit syscall, throw an error.  */
> > > -     li      v0, ENOSYS                      # error
> > > -     sd      v0, PT_R2(sp)
> > > -     li      t0, 1                           # set error flag
> > > -     sd      t0, PT_R7(sp)
> > > -     j       n64_syscall_exit
> > > -     END(handle_sys64)
> > > -
> > > -#define __SYSCALL(nr, entry) PTR entry
> > > -     .align  3
> > > -     .type   sys_call_table, @object
> > > -EXPORT(sys_call_table)
> > > -#include <asm/syscall_table_n64.h>
> > > diff --git a/arch/mips/kernel/scall64-o32.S b/arch/mips/kernel/scall6=
4-o32.S
> > > deleted file mode 100644
> > > index cedc8bd88804..000000000000
> > > --- a/arch/mips/kernel/scall64-o32.S
> > > +++ /dev/null
> > > @@ -1,221 +0,0 @@
> > > -/*
> > > - * This file is subject to the terms and conditions of the GNU Gener=
al Public
> > > - * License.  See the file "COPYING" in the main directory of this ar=
chive
> > > - * for more details.
> > > - *
> > > - * Copyright (C) 1995 - 2000, 2001 by Ralf Baechle
> > > - * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> > > - * Copyright (C) 2001 MIPS Technologies, Inc.
> > > - * Copyright (C) 2004 Thiemo Seufer
> > > - *
> > > - * Hairy, the userspace application uses a different argument passin=
g
> > > - * convention than the kernel, so we have to translate things from o=
32
> > > - * to ABI64 calling convention.       64-bit syscalls are also proce=
ssed
> > > - * here for now.
> > > - */
> > > -#include <linux/errno.h>
> > > -#include <asm/asm.h>
> > > -#include <asm/asmmacro.h>
> > > -#include <asm/irqflags.h>
> > > -#include <asm/mipsregs.h>
> > > -#include <asm/regdef.h>
> > > -#include <asm/stackframe.h>
> > > -#include <asm/thread_info.h>
> > > -#include <asm/unistd.h>
> > > -#include <asm/sysmips.h>
> > > -
> > > -     .align  5
> > > -NESTED(handle_sys, PT_SIZE, sp)
> > > -     .set    noat
> > > -     SAVE_SOME
> > > -     TRACE_IRQS_ON_RELOAD
> > > -     STI
> > > -     .set    at
> > > -     ld      t1, PT_EPC(sp)          # skip syscall on return
> > > -
> > > -     dsubu   t0, v0, __NR_O32_Linux  # check syscall number
> > > -     sltiu   t0, t0, __NR_O32_Linux_syscalls
> > > -     daddiu  t1, 4                   # skip to next instruction
> > > -     sd      t1, PT_EPC(sp)
> > > -     beqz    t0, not_o32_scall
> > > -#if 0
> > > - SAVE_ALL
> > > - move a1, v0
> > > - ASM_PRINT("Scall %ld\n")
> > > - RESTORE_ALL
> > > -#endif
> > > -
> > > -     /* We don't want to stumble over broken sign extensions from
> > > -        userland. O32 does never use the upper half. */
> > > -     sll     a0, a0, 0
> > > -     sll     a1, a1, 0
> > > -     sll     a2, a2, 0
> > > -     sll     a3, a3, 0
> > > -
> > > -     sd      a3, PT_R26(sp)          # save a3 for syscall restartin=
g
> > > -
> > > -     /*
> > > -      * More than four arguments.  Try to deal with it by copying th=
e
> > > -      * stack arguments from the user stack to the kernel stack.
> > > -      * This Sucks (TM).
> > > -      *
> > > -      * We intentionally keep the kernel stack a little below the to=
p of
> > > -      * userspace so we don't have to do a slower byte accurate chec=
k here.
> > > -      */
> > > -     ld      t0, PT_R29(sp)          # get old user stack pointer
> > > -     daddu   t1, t0, 32
> > > -     bltz    t1, bad_stack
> > > -
> > > -load_a4: lw  a4, 16(t0)              # argument #5 from usp
> > > -load_a5: lw  a5, 20(t0)              # argument #6 from usp
> > > -load_a6: lw  a6, 24(t0)              # argument #7 from usp
> > > -load_a7: lw  a7, 28(t0)              # argument #8 from usp
> > > -loads_done:
> > > -
> > > -     .section __ex_table,"a"
> > > -     PTR     load_a4, bad_stack_a4
> > > -     PTR     load_a5, bad_stack_a5
> > > -     PTR     load_a6, bad_stack_a6
> > > -     PTR     load_a7, bad_stack_a7
> > > -     .previous
> > > -
> > > -     li      t1, _TIF_WORK_SYSCALL_ENTRY
> > > -     LONG_L  t0, TI_FLAGS($28)       # syscall tracing enabled?
> > > -     and     t0, t1, t0
> > > -     bnez    t0, trace_a_syscall
> > > -
> > > -syscall_common:
> > > -     dsll    t0, v0, 3               # offset into table
> > > -     ld      t2, (sys32_call_table - (__NR_O32_Linux * 8))(t0)
> > > -
> > > -     jalr    t2                      # Do The Real Thing (TM)
> > > -
> > > -     li      t0, -EMAXERRNO - 1      # error?
> > > -     sltu    t0, t0, v0
> > > -     sd      t0, PT_R7(sp)           # set error flag
> > > -     beqz    t0, 1f
> > > -
> > > -     ld      t1, PT_R2(sp)           # syscall number
> > > -     dnegu   v0                      # error
> > > -     sd      t1, PT_R0(sp)           # save it for syscall restartin=
g
> > > -1:   sd      v0, PT_R2(sp)           # result
> > > -
> > > -o32_syscall_exit:
> > > -     j       syscall_exit_partial
> > > -
> > > -/* -----------------------------------------------------------------=
------- */
> > > -
> > > -trace_a_syscall:
> > > -     SAVE_STATIC
> > > -     sd      a4, PT_R8(sp)           # Save argument registers
> > > -     sd      a5, PT_R9(sp)
> > > -     sd      a6, PT_R10(sp)
> > > -     sd      a7, PT_R11(sp)          # For indirect syscalls
> > > -
> > > -     move    a0, sp
> > > -     /*
> > > -      * absolute syscall number is in v0 unless we called syscall(__=
NR_###)
> > > -      * where the real syscall number is in a0
> > > -      * note: NR_syscall is the first O32 syscall but the macro is
> > > -      * only defined when compiling with -mabi=3D32 (CONFIG_32BIT)
> > > -      * therefore __NR_O32_Linux is used (4000)
> > > -      */
> > > -     .set    push
> > > -     .set    reorder
> > > -     subu    t1, v0,  __NR_O32_Linux
> > > -     move    a1, v0
> > > -     bnez    t1, 1f /* __NR_syscall at offset 0 */
> > > -     ld      a1, PT_R4(sp) /* Arg1 for __NR_syscall case */
> > > -     .set    pop
> > > -
> > > -1:   jal     syscall_trace_enter
> > > -
> > > -     bltz    v0, 1f                  # seccomp failed? Skip syscall
> > > -
> > > -     RESTORE_STATIC
> > > -     ld      v0, PT_R2(sp)           # Restore syscall (maybe modifi=
ed)
> > > -     ld      a0, PT_R4(sp)           # Restore argument registers
> > > -     ld      a1, PT_R5(sp)
> > > -     ld      a2, PT_R6(sp)
> > > -     ld      a3, PT_R7(sp)
> > > -     ld      a4, PT_R8(sp)
> > > -     ld      a5, PT_R9(sp)
> > > -     ld      a6, PT_R10(sp)
> > > -     ld      a7, PT_R11(sp)          # For indirect syscalls
> > > -
> > > -     dsubu   t0, v0, __NR_O32_Linux  # check (new) syscall number
> > > -     sltiu   t0, t0, __NR_O32_Linux_syscalls
> > > -     beqz    t0, not_o32_scall
> > > -
> > > -     j       syscall_common
> > > -
> > > -1:   j       syscall_exit
> > > -
> > > -/* -----------------------------------------------------------------=
------- */
> > > -
> > > -     /*
> > > -      * The stackpointer for a call with more than 4 arguments is ba=
d.
> > > -      */
> > > -bad_stack:
> > > -     li      v0, EFAULT
> > > -     sd      v0, PT_R2(sp)
> > > -     li      t0, 1                   # set error flag
> > > -     sd      t0, PT_R7(sp)
> > > -     j       o32_syscall_exit
> > > -
> > > -bad_stack_a4:
> > > -     li      a4, 0
> > > -     b       load_a5
> > > -
> > > -bad_stack_a5:
> > > -     li      a5, 0
> > > -     b       load_a6
> > > -
> > > -bad_stack_a6:
> > > -     li      a6, 0
> > > -     b       load_a7
> > > -
> > > -bad_stack_a7:
> > > -     li      a7, 0
> > > -     b       loads_done
> > > -
> > > -not_o32_scall:
> > > -     /*
> > > -      * This is not an o32 compatibility syscall, pass it on
> > > -      * to the 64-bit syscall handlers.
> > > -      */
> > > -#ifdef CONFIG_MIPS32_N32
> > > -     j       handle_sysn32
> > > -#else
> > > -     j       handle_sys64
> > > -#endif
> > > -     END(handle_sys)
> > > -
> > > -LEAF(sys32_syscall)
> > > -     subu    t0, a0, __NR_O32_Linux  # check syscall number
> > > -     sltiu   v0, t0, __NR_O32_Linux_syscalls
> > > -     beqz    t0, einval              # do not recurse
> > > -     dsll    t1, t0, 3
> > > -     beqz    v0, einval
> > > -     ld      t2, sys32_call_table(t1)                # syscall routi=
ne
> > > -
> > > -     move    a0, a1                  # shift argument registers
> > > -     move    a1, a2
> > > -     move    a2, a3
> > > -     move    a3, a4
> > > -     move    a4, a5
> > > -     move    a5, a6
> > > -     move    a6, a7
> > > -     jr      t2
> > > -     /* Unreached */
> > > -
> > > -einval: li   v0, -ENOSYS
> > > -     jr      ra
> > > -     END(sys32_syscall)
> > > -
> > > -#define __SYSCALL_WITH_COMPAT(nr, native, compat)    __SYSCALL(nr, c=
ompat)
> > > -#define __SYSCALL(nr, entry) PTR entry
> > > -     .align  3
> > > -     .type   sys32_call_table,@object
> > > -EXPORT(sys32_call_table)
> > > -#include <asm/syscall_table_o32.h>
> > > diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
> > > index f1e985109da0..1ec6a0cf1163 100644
> > > --- a/arch/mips/kernel/signal.c
> > > +++ b/arch/mips/kernel/signal.c
> > > @@ -32,7 +32,6 @@
> > >   #include <linux/bitops.h>
> > >   #include <asm/cacheflush.h>
> > >   #include <asm/fpu.h>
> > > -#include <asm/sim.h>
> > >   #include <asm/ucontext.h>
> > >   #include <asm/cpu-features.h>
> > >   #include <asm/war.h>
> > > @@ -627,7 +626,7 @@ SYSCALL_DEFINE3(sigaction, int, sig, const struct=
 sigaction __user *, act,
> > >   #endif
> > >
> > >   #ifdef CONFIG_TRAD_SIGNALS
> > > -asmlinkage void sys_sigreturn(void)
> > > +asmlinkage long sys_sigreturn(void)
> > >   {
> > >       struct sigframe __user *frame;
> > >       struct pt_regs *regs;
> > > @@ -649,22 +648,16 @@ asmlinkage void sys_sigreturn(void)
> > >       else if (sig)
> > >               force_sig(sig);
> > >
> > > -     /*
> > > -      * Don't let your children do this ...
> > > -      */
> > > -     __asm__ __volatile__(
> > > -             "move\t$29, %0\n\t"
> > > -             "j\tsyscall_exit"
> > > -             : /* no outputs */
> > > -             : "r" (regs));
> > > -     /* Unreached */
> > > +     regs->regs[27] =3D 1;     /* return directly */
> > > +     return regs->regs[2];
> > >
> > >   badframe:
> > >       force_sig(SIGSEGV);
> > > +     return 0;
> > >   }
> > >   #endif /* CONFIG_TRAD_SIGNALS */
> > >
> > > -asmlinkage void sys_rt_sigreturn(void)
> > > +asmlinkage long sys_rt_sigreturn(void)
> > >   {
> > >       struct rt_sigframe __user *frame;
> > >       struct pt_regs *regs;
> > > @@ -689,18 +682,12 @@ asmlinkage void sys_rt_sigreturn(void)
> > >       if (restore_altstack(&frame->rs_uc.uc_stack))
> > >               goto badframe;
> > >
> > > -     /*
> > > -      * Don't let your children do this ...
> > > -      */
> > > -     __asm__ __volatile__(
> > > -             "move\t$29, %0\n\t"
> > > -             "j\tsyscall_exit"
> > > -             : /* no outputs */
> > > -             : "r" (regs));
> > > -     /* Unreached */
> > > +     regs->regs[27] =3D 1;     /* return directly */
> > > +     return regs->regs[2];
> > >
> > >   badframe:
> > >       force_sig(SIGSEGV);
> > > +     return 0;
> > >   }
> > >
> > >   #ifdef CONFIG_TRAD_SIGNALS
> > > @@ -852,11 +839,11 @@ static void handle_signal(struct ksignal *ksig,=
 struct pt_regs *regs)
> > >       signal_setup_done(ret, ksig, 0);
> > >   }
> > >
> > > -static void do_signal(struct pt_regs *regs)
> > > +void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal=
)
> > >   {
> > >       struct ksignal ksig;
> > >
> > > -     if (get_signal(&ksig)) {
> > > +     if (has_signal && get_signal(&ksig)) {
> > >               /* Whee!  Actually deliver the signal.  */
> > >               handle_signal(&ksig, regs);
> > >               return;
> > > @@ -904,7 +891,7 @@ asmlinkage void do_notify_resume(struct pt_regs *=
regs, void *unused,
> > >
> > >       /* deal with pending signal delivery */
> > >       if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> > > -             do_signal(regs);
> > > +             arch_do_signal_or_restart(regs, thread_info_flags & _TI=
F_SIGPENDING);
> > >
> > >       if (thread_info_flags & _TIF_NOTIFY_RESUME) {
> > >               tracehook_notify_resume(regs);
> > > diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_=
n32.c
> > > index 7bd00fad61af..b52b995a8a9b 100644
> > > --- a/arch/mips/kernel/signal_n32.c
> > > +++ b/arch/mips/kernel/signal_n32.c
> > > @@ -19,7 +19,6 @@
> > >   #include <asm/asm.h>
> > >   #include <asm/cacheflush.h>
> > >   #include <asm/compat-signal.h>
> > > -#include <asm/sim.h>
> > >   #include <linux/uaccess.h>
> > >   #include <asm/ucontext.h>
> > >   #include <asm/fpu.h>
> > > @@ -51,7 +50,7 @@ struct rt_sigframe_n32 {
> > >       struct ucontextn32 rs_uc;
> > >   };
> > >
> > > -asmlinkage void sysn32_rt_sigreturn(void)
> > > +asmlinkage long sysn32_rt_sigreturn(void)
> > >   {
> > >       struct rt_sigframe_n32 __user *frame;
> > >       struct pt_regs *regs;
> > > @@ -76,18 +75,12 @@ asmlinkage void sysn32_rt_sigreturn(void)
> > >       if (compat_restore_altstack(&frame->rs_uc.uc_stack))
> > >               goto badframe;
> > >
> > > -     /*
> > > -      * Don't let your children do this ...
> > > -      */
> > > -     __asm__ __volatile__(
> > > -             "move\t$29, %0\n\t"
> > > -             "j\tsyscall_exit"
> > > -             : /* no outputs */
> > > -             : "r" (regs));
> > > -     /* Unreached */
> > > +     regs->regs[27] =3D 1;     /* return directly */
> > > +     return regs->regs[2];
> > >
> > >   badframe:
> > >       force_sig(SIGSEGV);
> > > +     return 0;
> > >   }
> > >
> > >   static int setup_rt_frame_n32(void *sig_return, struct ksignal *ksi=
g,
> > > diff --git a/arch/mips/kernel/signal_o32.c b/arch/mips/kernel/signal_=
o32.c
> > > index 299a7a28ca33..9245806e06f1 100644
> > > --- a/arch/mips/kernel/signal_o32.c
> > > +++ b/arch/mips/kernel/signal_o32.c
> > > @@ -17,7 +17,6 @@
> > >   #include <asm/abi.h>
> > >   #include <asm/compat-signal.h>
> > >   #include <asm/dsp.h>
> > > -#include <asm/sim.h>
> > >   #include <asm/unistd.h>
> > >
> > >   #include "signal-common.h"
> > > @@ -151,7 +150,7 @@ static int setup_frame_32(void *sig_return, struc=
t ksignal *ksig,
> > >       return 0;
> > >   }
> > >
> > > -asmlinkage void sys32_rt_sigreturn(void)
> > > +asmlinkage long sys32_rt_sigreturn(void)
> > >   {
> > >       struct rt_sigframe32 __user *frame;
> > >       struct pt_regs *regs;
> > > @@ -176,18 +175,12 @@ asmlinkage void sys32_rt_sigreturn(void)
> > >       if (compat_restore_altstack(&frame->rs_uc.uc_stack))
> > >               goto badframe;
> > >
> > > -     /*
> > > -      * Don't let your children do this ...
> > > -      */
> > > -     __asm__ __volatile__(
> > > -             "move\t$29, %0\n\t"
> > > -             "j\tsyscall_exit"
> > > -             : /* no outputs */
> > > -             : "r" (regs));
> > > -     /* Unreached */
> > > +     regs->regs[27] =3D 1;     /* return directly */
> > > +     return regs->regs[2];
> > >
> > >   badframe:
> > >       force_sig(SIGSEGV);
> > > +     return 0;
> > >   }
> > >
> > >   static int setup_rt_frame_32(void *sig_return, struct ksignal *ksig=
,
> > > @@ -253,7 +246,7 @@ struct mips_abi mips_abi_32 =3D {
> > >   };
> > >
> > >
> > > -asmlinkage void sys32_sigreturn(void)
> > > +asmlinkage long sys32_sigreturn(void)
> > >   {
> > >       struct sigframe32 __user *frame;
> > >       struct pt_regs *regs;
> > > @@ -275,16 +268,10 @@ asmlinkage void sys32_sigreturn(void)
> > >       else if (sig)
> > >               force_sig(sig);
> > >
> > > -     /*
> > > -      * Don't let your children do this ...
> > > -      */
> > > -     __asm__ __volatile__(
> > > -             "move\t$29, %0\n\t"
> > > -             "j\tsyscall_exit"
> > > -             : /* no outputs */
> > > -             : "r" (regs));
> > > -     /* Unreached */
> > > +     regs->regs[27] =3D 1;     /* return directly */
> > > +     return regs->regs[2];
> > >
> > >   badframe:
> > >       force_sig(SIGSEGV);
> > > +     return 0;
> > >   }
> > > diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
> > > index 2afa3eef486a..6dc78648b274 100644
> > > --- a/arch/mips/kernel/syscall.c
> > > +++ b/arch/mips/kernel/syscall.c
> > > @@ -8,6 +8,7 @@
> > >    * Copyright (C) 2001 MIPS Technologies, Inc.
> > >    */
> > >   #include <linux/capability.h>
> > > +#include <linux/entry-common.h>
> > >   #include <linux/errno.h>
> > >   #include <linux/linkage.h>
> > >   #include <linux/fs.h>
> > > @@ -35,9 +36,9 @@
> > >   #include <asm/cacheflush.h>
> > >   #include <asm/asm-offsets.h>
> > >   #include <asm/signal.h>
> > > -#include <asm/sim.h>
> > >   #include <asm/shmparam.h>
> > >   #include <asm/sync.h>
> > > +#include <asm/syscall.h>
> > >   #include <asm/sysmips.h>
> > >   #include <asm/switch_to.h>
> > >
> > > @@ -79,10 +80,6 @@ SYSCALL_DEFINE6(mips_mmap2, unsigned long, addr, u=
nsigned long, len,
> > >                              pgoff >> (PAGE_SHIFT - 12));
> > >   }
> > >
> > > -save_static_function(sys_fork);
> > > -save_static_function(sys_clone);
> > > -save_static_function(sys_clone3);
> > > -
> > >   SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
> > >   {
> > >       struct thread_info *ti =3D task_thread_info(current);
> > > @@ -182,28 +179,11 @@ static inline int mips_atomic_set(unsigned long=
 addr, unsigned long new)
> > >               return err;
> > >
> > >       regs =3D current_pt_regs();
> > > -     regs->regs[2] =3D old;
> > > -     regs->regs[7] =3D 0;      /* No error */
> > > -
> > > -     /*
> > > -      * Don't let your children do this ...
> > > -      */
> > > -     __asm__ __volatile__(
> > > -     "       move    $29, %0                                        =
 \n"
> > > -     "       j       syscall_exit                                   =
 \n"
> > > -     : /* no outputs */
> > > -     : "r" (regs));
> > > -
> > > -     /* unreached.  Honestly.  */
> > > -     unreachable();
> > > +     regs->regs[7] =3D 0;      /* no error */
> > > +     regs->regs[27] =3D 1;     /* return directly */
> > > +     return old;
> > >   }
> > >
> > > -/*
> > > - * mips_atomic_set() normally returns directly via syscall_exit pote=
ntially
> > > - * clobbering static registers, so be sure to preserve them.
> > > - */
> > > -save_static_function(sys_sysmips);
> > > -
> > >   SYSCALL_DEFINE3(sysmips, long, cmd, long, arg1, long, arg2)
> > >   {
> > >       switch (cmd) {
> > > @@ -249,3 +229,120 @@ asmlinkage void bad_stack(void)
> > >   {
> > >       do_exit(SIGSEGV);
> > >   }
> > > +
> > > +#if defined(CONFIG_32BIT) || defined(CONFIG_MIPS32_O32)
> > > +static inline int get_args(struct pt_regs *regs)
> > > +{
> > > +     int *usp =3D (int *)regs->regs[29];
> > > +
> > > +#ifdef CONFIG_MIPS32_O32
> > > +     /*
> > > +      * Hairy, the userspace application uses a different argument p=
assing
> > > +      * convention than the kernel, so we have to translate things f=
rom o32
> > > +      * to ABI64 calling convention.
> > > +      *
> > > +      * We don't want to stumble over broken sign extensions from us=
erland.
> > > +      * O32 does never use the upper half.
> > > +      */
> > > +     regs->regs[4] =3D (int)regs->regs[4];
> > > +     regs->regs[5] =3D (int)regs->regs[5];
> > > +     regs->regs[6] =3D (int)regs->regs[6];
> > > +     regs->regs[7] =3D (int)regs->regs[7];
> > > +#endif
> > > +
> > > +     /*
> > > +      * More than four arguments.  Try to deal with it by copying th=
e
> > > +      * stack arguments from the user stack to the kernel stack.
> > > +      * This Sucks (TM).
> > > +      *
> > > +      * We intentionally keep the kernel stack a little below the to=
p of
> > > +      * userspace so we don't have to do a slower byte accurate chec=
k here.
> > > +      */
> > > +     if (!access_ok(usp, 32))
> > > +             return -1;
> > > +
> > > +     get_user(regs->regs[8], usp + 4);
> > > +     get_user(regs->regs[9], usp + 5);
> > > +     get_user(regs->regs[10], usp + 6);
> > > +     get_user(regs->regs[11], usp + 7);
> > > +
> > > +     return 0;
> > > +}
> > > +#endif
> > > +
> > > +typedef long (*sys_call_fn)(unsigned long, unsigned long,
> > > +     unsigned long, unsigned long, unsigned long, unsigned long);
> > > +
> > > +void noinstr do_syscall(struct pt_regs *regs)
> > > +{
> > > +     unsigned long nr;
> > > +     unsigned long ret;
> > > +     sys_call_fn syscall_fn =3D NULL;
> > > +
> > > +     nr =3D regs->regs[2];
> > > +     current_thread_info()->syscall =3D nr;
> > > +     nr =3D syscall_enter_from_user_mode(regs, nr);
> > > +
> > > +     regs->cp0_epc +=3D 4;             /* skip syscall on return */
> > > +                                     /* skip to next instruction */
> > > +     regs->regs[26] =3D regs->regs[7]; /* save a3 for syscall restar=
ting */
> > > +     regs->regs[27] =3D 0;             /* do not return directly */
> > > +
> > > +#ifdef CONFIG_32BIT
> > > +     if (nr >=3D __NR_O32_Linux && nr < __NR_O32_Linux + __NR_O32_Li=
nux_syscalls) {
> > > +             if (get_args(regs) < 0) {
> > > +                     ret =3D EFAULT;
> > > +                     goto error;
> > > +             }
> > > +             syscall_fn =3D (sys_call_fn)sys_call_table[nr - __NR_O3=
2_Linux];
> > > +     }
> > > +#endif
> > > +
> > > +#ifdef CONFIG_MIPS32_O32
> > > +     if (nr >=3D __NR_O32_Linux && nr < __NR_O32_Linux + __NR_O32_Li=
nux_syscalls) {
> > > +             if (get_args(regs) < 0) {
> > > +                     ret =3D EFAULT;
> > > +                     goto error;
> > > +             }
> > > +             syscall_fn =3D (sys_call_fn)sys32_call_table[nr - __NR_=
O32_Linux];
> > > +     }
> > > +#endif
> > > +
> > > +#ifdef CONFIG_MIPS32_N32
> > > +     if (nr >=3D __NR_N32_Linux && nr < __NR_N32_Linux + __NR_N32_Li=
nux_syscalls)
> > > +             syscall_fn =3D (sys_call_fn)sysn32_call_table[nr - __NR=
_N32_Linux];
> > > +#endif
> > > +
> > > +#ifdef CONFIG_64BIT
> > > +     if (nr >=3D __NR_64_Linux && nr < __NR_64_Linux + __NR_64_Linux=
_syscalls)
> > > +             syscall_fn =3D (sys_call_fn)sys_call_table[nr - __NR_64=
_Linux];
> > > +#endif
> > > +
> > > +     if (!syscall_fn) {
> > > +             ret =3D ENOSYS;
> > > +             goto error;
> > > +     }
> > > +
> > > +     ret =3D syscall_fn(regs->regs[4], regs->regs[5], regs->regs[6],
> > > +                      regs->regs[7], regs->regs[8], regs->regs[9]);
> > > +
> > > +     if (regs->regs[27])             /* return directly? */
> > > +             goto out;
> > > +
> > > +     regs->regs[7] =3D 0;              /* clear error flag */
> > > +     if (ret >=3D -EMAXERRNO - 1) {    /* error? */
> > > +             regs->regs[0] =3D nr;     /* save syscall number */
> > > +                                     /* for syscall restarting */
> > > +             ret =3D -ret;
> > > +             goto error;
> > > +     }
> > > +
> > > +     goto out;
> > > +
> > > +error:
> > > +     regs->regs[7] =3D 1;              /* set error flag */
> > > +
> > > +out:
> > > +     regs->regs[2] =3D ret;
> > > +     syscall_exit_to_user_mode(regs);
> > > +}
> > > diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/ke=
rnel/syscalls/syscall_n32.tbl
> > > index 70e32de2bcaa..d9ae765e51f1 100644
> > > --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> > > +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> > > @@ -62,8 +62,8 @@
> > >   52  n32     socketpair                      sys_socketpair
> > >   53  n32     setsockopt                      sys_setsockopt
> > >   54  n32     getsockopt                      sys_getsockopt
> > > -55   n32     clone                           __sys_clone
> > > -56   n32     fork                            __sys_fork
> > > +55   n32     clone                           sys_clone
> > > +56   n32     fork                            sys_fork
> > >   57  n32     execve                          compat_sys_execve
> > >   58  n32     exit                            sys_exit
> > >   59  n32     wait4                           compat_sys_wait4
> > > @@ -207,7 +207,7 @@
> > >   196 n32     sched_getaffinity               compat_sys_sched_getaff=
inity
> > >   197 n32     cacheflush                      sys_cacheflush
> > >   198 n32     cachectl                        sys_cachectl
> > > -199  n32     sysmips                         __sys_sysmips
> > > +199  n32     sysmips                         sys_sysmips
> > >   200 n32     io_setup                        compat_sys_io_setup
> > >   201 n32     io_destroy                      sys_io_destroy
> > >   202 n32     io_getevents                    sys_io_getevents_time32
> > > @@ -373,7 +373,7 @@
> > >   432 n32     fsmount                         sys_fsmount
> > >   433 n32     fspick                          sys_fspick
> > >   434 n32     pidfd_open                      sys_pidfd_open
> > > -435  n32     clone3                          __sys_clone3
> > > +435  n32     clone3                          sys_clone3
> > >   436 n32     close_range                     sys_close_range
> > >   437 n32     openat2                         sys_openat2
> > >   438 n32     pidfd_getfd                     sys_pidfd_getfd
> > > diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/ke=
rnel/syscalls/syscall_n64.tbl
> > > index 1ca7bc337932..edec3e82d67a 100644
> > > --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> > > +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> > > @@ -62,8 +62,8 @@
> > >   52  n64     socketpair                      sys_socketpair
> > >   53  n64     setsockopt                      sys_setsockopt
> > >   54  n64     getsockopt                      sys_getsockopt
> > > -55   n64     clone                           __sys_clone
> > > -56   n64     fork                            __sys_fork
> > > +55   n64     clone                           sys_clone
> > > +56   n64     fork                            sys_fork
> > >   57  n64     execve                          sys_execve
> > >   58  n64     exit                            sys_exit
> > >   59  n64     wait4                           sys_wait4
> > > @@ -207,7 +207,7 @@
> > >   196 n64     sched_getaffinity               sys_sched_getaffinity
> > >   197 n64     cacheflush                      sys_cacheflush
> > >   198 n64     cachectl                        sys_cachectl
> > > -199  n64     sysmips                         __sys_sysmips
> > > +199  n64     sysmips                         sys_sysmips
> > >   200 n64     io_setup                        sys_io_setup
> > >   201 n64     io_destroy                      sys_io_destroy
> > >   202 n64     io_getevents                    sys_io_getevents
> > > @@ -349,7 +349,7 @@
> > >   432 n64     fsmount                         sys_fsmount
> > >   433 n64     fspick                          sys_fspick
> > >   434 n64     pidfd_open                      sys_pidfd_open
> > > -435  n64     clone3                          __sys_clone3
> > > +435  n64     clone3                          sys_clone3
> > >   436 n64     close_range                     sys_close_range
> > >   437 n64     openat2                         sys_openat2
> > >   438 n64     pidfd_getfd                     sys_pidfd_getfd
> > > diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/ke=
rnel/syscalls/syscall_o32.tbl
> > > index a61c35edaa74..89a1f267da6a 100644
> > > --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> > > +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> > > @@ -9,7 +9,7 @@
> > >   #
> > >   0   o32     syscall                         sys_syscall            =
         sys32_syscall
> > >   1   o32     exit                            sys_exit
> > > -2    o32     fork                            __sys_fork
> > > +2    o32     fork                            sys_fork
> > >   3   o32     read                            sys_read
> > >   4   o32     write                           sys_write
> > >   5   o32     open                            sys_open               =
         compat_sys_open
> > > @@ -131,7 +131,7 @@
> > >   117 o32     ipc                             sys_ipc                =
         compat_sys_ipc
> > >   118 o32     fsync                           sys_fsync
> > >   119 o32     sigreturn                       sys_sigreturn          =
         sys32_sigreturn
> > > -120  o32     clone                           __sys_clone
> > > +120  o32     clone                           sys_clone
> > >   121 o32     setdomainname                   sys_setdomainname
> > >   122 o32     uname                           sys_newuname
> > >   123 o32     modify_ldt                      sys_ni_syscall
> > > @@ -160,7 +160,7 @@
> > >   146 o32     writev                          sys_writev
> > >   147 o32     cacheflush                      sys_cacheflush
> > >   148 o32     cachectl                        sys_cachectl
> > > -149  o32     sysmips                         __sys_sysmips
> > > +149  o32     sysmips                         sys_sysmips
> > >   150 o32     unused150                       sys_ni_syscall
> > >   151 o32     getsid                          sys_getsid
> > >   152 o32     fdatasync                       sys_fdatasync
> > > @@ -422,7 +422,7 @@
> > >   432 o32     fsmount                         sys_fsmount
> > >   433 o32     fspick                          sys_fspick
> > >   434 o32     pidfd_open                      sys_pidfd_open
> > > -435  o32     clone3                          __sys_clone3
> > > +435  o32     clone3                          sys_clone3
> > >   436 o32     close_range                     sys_close_range
> > >   437 o32     openat2                         sys_openat2
> > >   438 o32     pidfd_getfd                     sys_pidfd_getfd

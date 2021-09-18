Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D472441049E
	for <lists+linux-arch@lfdr.de>; Sat, 18 Sep 2021 09:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241986AbhIRHOZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Sep 2021 03:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhIRHOV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Sep 2021 03:14:21 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C57C061574;
        Sat, 18 Sep 2021 00:12:50 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id e20so7535551uam.11;
        Sat, 18 Sep 2021 00:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FbIEYvj8jmT/B37N8Nb8x6Y+ROj0RkdYfAD1zw/97E=;
        b=ca0aGRxih/vCm4GRddTaqwCHyC6Rf3Jc0X7aE/WV//Ybcptok78IIU8v/muXmj60/7
         fiuaFPlXIQ/xX6tcgdf7QcNK/+PFfTNkho10meapa3GkJX3Gk79cRl6dwmUbD+9U2eY6
         Sj+cuPQGG3yQhNKJ8++RtjfApMxtuBmfQVhGJjKJabI2P5IPbqkjEJcYmTc/Azhf69PY
         IITc2MJhtvNBxa6eOxWtD+xAH1oKMVWXzEPFpvwgWNVwS4tG9Q7cqE+dVO+5tx+GdSF0
         uCXLkDrl9oguSfwWrInHBmdMnN3RAW0kA10pMdTQOE15w4jHM+uzZ7M0zi4JXS+oBX31
         vYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FbIEYvj8jmT/B37N8Nb8x6Y+ROj0RkdYfAD1zw/97E=;
        b=2UmJauurVyUtvTAFi5OHkgArXeZE2ib0m4ZfGKnuid2Svn9qVrgJnZmw5DggorhHB5
         rQ4r5V+dk7u5vViXA7R7QdSYROL4KAUBm3CbATTsNiX3X2x5kR6MgLxyFrXuQxPtpooW
         0hlpauEO3vIblppvKRM2BqGuHHgoqvnWX/iyg/Wg+eHYBrbf1/SOA4XEMBUR68V6a4Ef
         GAPbtEbCalezi8N58udOfIGFhtK3ntm/cwelScqwIbCv0jFnuZJf0Gm7xfaxjFp59wzi
         gPrX8j2j0/52uX4BxRTLk/mnOUAHf+qlx7h8Tvk34n9yq0D3NJsaeGVcKx1GoYX/yw+e
         f5Dg==
X-Gm-Message-State: AOAM530cUNzhrivyWr4hEpzX+/BsZkQEOg97RtePU5gzAV/gCbmFfct0
        /8BPVtZ8WA0PfMRI2krLI4HaTEy3Sn/yhr5zbXI=
X-Google-Smtp-Source: ABdhPJx7pN6sYa1Dq0pcjbtveb+kYZFBHGX5SAXJzorpjBbpM91Mjx81gBFIg2I9B45FZCYvGERjBZJcdLKOSJ9eDWQ=
X-Received: by 2002:ab0:31c1:: with SMTP id e1mr7400989uan.132.1631949169278;
 Sat, 18 Sep 2021 00:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-15-chenhuacai@loongson.cn> <87tuii52o2.fsf@disp2133>
In-Reply-To: <87tuii52o2.fsf@disp2133>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 18 Sep 2021 15:12:37 +0800
Message-ID: <CAAhV-H5MZ9uYyEnVoHXBXkrux1HdcPsKQ66zvB2oeMfq_AP7_A@mail.gmail.com>
Subject: Re: [PATCH V3 14/22] LoongArch: Add signal handling support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Eric,

On Sat, Sep 18, 2021 at 5:10 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Huacai Chen <chenhuacai@loongson.cn> writes:
>
> > This patch adds signal handling support for LoongArch.
>
> My overall impression is that it looks like this code has a lot of
> boilerplate code copied from mips that mips needs because of it's
> long history, but that a fresh architecture should not need.
>
> For example does LoongArch have a version without built in floating
> point support?
Some of these structures seems need rethinking, But we really have
LoongArch-based MCUs now (no FP, no SMP, and even no MMU).

>
> To the best of my knowledge it has been decades since anyone built
> a cpu capable of running Linux that doesn't have built in floating point
> support.
>
> Similarly this includes code for parameterize some of the userspace ABI.
> Since you only have a single userspace ABI there should not need to be
> any parameters.  So removing the unnecessary parameters should simplify
> the code.
>
> I have a few more comments inline along the same lines.
>
> Eric
>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/abi.h             |  27 ++
> >  arch/loongarch/include/uapi/asm/sigcontext.h |  40 ++
> >  arch/loongarch/include/uapi/asm/ucontext.h   |  35 ++
> >  arch/loongarch/kernel/signal-common.h        |  38 ++
> >  arch/loongarch/kernel/signal.c               | 467 +++++++++++++++++++
> >  5 files changed, 607 insertions(+)
> >  create mode 100644 arch/loongarch/include/asm/abi.h
> >  create mode 100644 arch/loongarch/include/uapi/asm/sigcontext.h
> >  create mode 100644 arch/loongarch/include/uapi/asm/ucontext.h
> >  create mode 100644 arch/loongarch/kernel/signal-common.h
> >  create mode 100644 arch/loongarch/kernel/signal.c
> >
> > diff --git a/arch/loongarch/include/asm/abi.h b/arch/loongarch/include/asm/abi.h
> > new file mode 100644
> > index 000000000000..ced8534db4df
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/abi.h
> > @@ -0,0 +1,27 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_ABI_H
> > +#define _ASM_ABI_H
> > +
> > +#include <linux/signal_types.h>
> > +
> > +#include <asm/signal.h>
> > +#include <asm/siginfo.h>
> > +#include <asm/vdso.h>
> > +
> > +struct loongarch_abi {
> > +     const unsigned long     restart;
> > +     const int               audit_arch;
> > +
> > +     unsigned int off_sc_fpregs;
> > +     unsigned int off_sc_fcc;
> > +     unsigned int off_sc_fcsr;
> > +     unsigned int off_sc_vcsr;
> > +     unsigned int off_sc_flags;
> > +
> > +     struct loongarch_vdso_info *vdso;
> > +};
>
> This header file is confusing.  It says ABI but it isn't under the uapi
> tree.  On mips with decades of history and a nabi, oabi, etc, the
> similar header file which includes function pointers makes a smidgen of
> sense.
>
> Since you aren't mips and your architecture is new you should be able to
> have a single userspace ABI and hard code everything.  At least to get
> started with.
>
> That should make for simpler code as well.
>
> > +
> > +#endif /* _ASM_ABI_H */
> > diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
> > new file mode 100644
> > index 000000000000..da0e5bac2d80
> > --- /dev/null
> > +++ b/arch/loongarch/include/uapi/asm/sigcontext.h
> > @@ -0,0 +1,40 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +/*
> > + * Author: Hanlu Li <lihanlu@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + *
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _UAPI_ASM_SIGCONTEXT_H
> > +#define _UAPI_ASM_SIGCONTEXT_H
> > +
> > +#include <linux/types.h>
> > +#include <asm/processor.h>
> > +
> > +/* scalar FP context was used */
> > +#define USED_FP                      (1 << 0)
> > +
> > +/* extended context was used, see struct extcontext for details */
> > +#define USED_EXTCONTEXT              (1 << 1)
> > +
> > +#include <linux/posix_types.h>
> > +/*
> > + * Keep this struct definition in sync with the sigcontext fragment
> > + * in arch/loongarch/kernel/asm-offsets.c
>
> If this is uapi this can't change (except for consuming the reserved
> fields).  Making this comment misleading.
>
> > + *
> > + */
> > +struct sigcontext {
> > +     __u64   sc_pc;
> > +     __u64   sc_regs[32];
> > +     __u32   sc_flags;
> > +
> > +     __u32   sc_fcsr;
> > +     __u32   sc_vcsr;
>
> You might want to document the 32bit hole in your structure here.
>
> > +     __u64   sc_fcc;
> > +     __u64   sc_scr[4];
> > +
> > +     union fpureg sc_fpregs[32] FPU_ALIGN;
> > +     __u8    sc_reserved[4096] __attribute__((__aligned__(16)));
> > +};
> > +
> > +#endif /* _UAPI_ASM_SIGCONTEXT_H */
> > diff --git a/arch/loongarch/include/uapi/asm/ucontext.h b/arch/loongarch/include/uapi/asm/ucontext.h
> > new file mode 100644
> > index 000000000000..12577e22b1c7
> > --- /dev/null
> > +++ b/arch/loongarch/include/uapi/asm/ucontext.h
> > @@ -0,0 +1,35 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef __LOONGARCH_UAPI_ASM_UCONTEXT_H
> > +#define __LOONGARCH_UAPI_ASM_UCONTEXT_H
> > +
> > +/**
> > + * struct ucontext - user context structure
> > + * @uc_flags:
> > + * @uc_link:
> > + * @uc_stack:
> > + * @uc_mcontext:     holds basic processor state
> > + * @uc_sigmask:
> > + * @uc_extcontext:   holds extended processor state
> > + */
> > +struct ucontext {
> > +     unsigned long           uc_flags;
> > +     struct ucontext         *uc_link;
> > +     stack_t                 uc_stack;
> > +     sigset_t                uc_sigmask;
> > +     /* There's some padding here to allow sigset_t to be expanded in the
> > +      * future.  Though this is unlikely, other architectures put uc_sigmask
> > +      * at the end of this structure and explicitly state it can be
> > +      * expanded, so we didn't want to box ourselves in here. */
> > +     __u8              __unused[1024 / 8 - sizeof(sigset_t)];
> > +     /* We can't put uc_sigmask at the end of this structure because we need
> > +      * to be able to expand sigcontext in the future.  For example, the
> > +      * vector ISA extension will almost certainly add ISA state.  We want
> > +      * to ensure all user-visible ISA state can be saved and restored via a
> > +      * ucontext, so we're putting this at the end in order to allow for
> > +      * infinite extensibility.  Since we know this will be extended and we
> > +      * assume sigset_t won't be extended an extreme amount, we're
> > +      * prioritizing this. */
> > +     struct sigcontext       uc_mcontext;
> > +};
> > +
> > +#endif /* __LOONGARCH_UAPI_ASM_UCONTEXT_H */
> > diff --git a/arch/loongarch/kernel/signal-common.h b/arch/loongarch/kernel/signal-common.h
> > new file mode 100644
> > index 000000000000..1693fbdedeaa
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/signal-common.h
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Author: Hanlu Li <lihanlu@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + *
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +
> > +#ifndef __SIGNAL_COMMON_H
> > +#define __SIGNAL_COMMON_H
> > +
> > +/* #define DEBUG_SIG */
> > +
> > +#ifdef DEBUG_SIG
> > +#  define DEBUGP(fmt, args...) printk("%s: " fmt, __func__, ##args)
> > +#else
> > +#  define DEBUGP(fmt, args...)
> > +#endif
>
> This is only used once in arch/loongarch/kernel/signal.c
> so you probably want to keep this define local to that file.
OK, thanks.

Huacai
>
> > +/*
> > + * Determine which stack to use..
> > + */
> > +extern void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
> > +                              size_t frame_size);
> > +/* Check and clear pending FPU exceptions in saved CSR */
> > +extern int fpcsr_pending(unsigned int __user *fpcsr);
> > +
> > +/* Make sure we will not lose FPU ownership */
> > +#define lock_fpu_owner()     ({ preempt_disable(); pagefault_disable(); })
> > +#define unlock_fpu_owner()   ({ pagefault_enable(); preempt_enable(); })
> > +
> > +/* Assembly functions to move context to/from the FPU */
> > +extern asmlinkage int
> > +_save_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
> > +extern asmlinkage int
> > +_restore_fp_context(void __user *fpregs, void __user *fcc, void __user *csr);
> > +
> > +#endif       /* __SIGNAL_COMMON_H */
> > diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
> > new file mode 100644
> > index 000000000000..78319d2575c6
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/signal.c
> > @@ -0,0 +1,467 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Author: Hanlu Li <lihanlu@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + *
> > + * Derived from MIPS:
> > + * Copyright (C) 1991, 1992  Linus Torvalds
> > + * Copyright (C) 1994 - 2000  Ralf Baechle
> > + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
> > + * Copyright (C) 2014, Imagination Technologies Ltd.
> > + */
> > +#include <linux/audit.h>
> > +#include <linux/cache.h>
> > +#include <linux/context_tracking.h>
> > +#include <linux/irqflags.h>
> > +#include <linux/sched.h>
> > +#include <linux/mm.h>
> > +#include <linux/personality.h>
> > +#include <linux/smp.h>
> > +#include <linux/kernel.h>
> > +#include <linux/signal.h>
> > +#include <linux/errno.h>
> > +#include <linux/wait.h>
> > +#include <linux/ptrace.h>
> > +#include <linux/unistd.h>
> > +#include <linux/uprobes.h>
> > +#include <linux/compiler.h>
> > +#include <linux/syscalls.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/tracehook.h>
> > +
> > +#include <asm/abi.h>
> > +#include <asm/asm.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/fpu.h>
> > +#include <asm/ucontext.h>
> > +#include <asm/cpu-features.h>
> > +
> > +#include "signal-common.h"
> > +
> > +static int (*save_fp_context)(void __user *sc);
> > +static int (*restore_fp_context)(void __user *sc);
> > +
> > +struct rt_sigframe {
> > +     struct siginfo rs_info;
> > +     struct ucontext rs_uctx;
> > +};
> > +
> > +/*
> > + * Thread saved context copy to/from a signal context presumed to be on the
> > + * user stack, and therefore accessed with appropriate macros from uaccess.h.
> > + */
> > +static int copy_fp_to_sigcontext(void __user *sc)
> > +{
> > +     struct loongarch_abi *abi = current->thread.abi;
> > +     uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
> > +     uint64_t __user *fcc = sc + abi->off_sc_fcc;
> > +     uint32_t __user *csr = sc + abi->off_sc_fcsr;
> > +     int i;
> > +     int err = 0;
> > +     int inc = 1;
> > +
> > +     for (i = 0; i < NUM_FPU_REGS; i += inc) {
> > +             err |=
> > +                 __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
> > +                            &fpregs[4*i]);
> > +     }
> > +     err |= __put_user(current->thread.fpu.fcsr, csr);
> > +     err |= __put_user(current->thread.fpu.fcc, fcc);
> > +
> > +     return err;
> > +}
> > +
> > +static int copy_fp_from_sigcontext(void __user *sc)
> > +{
> > +     struct loongarch_abi *abi = current->thread.abi;
> > +     uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
> > +     uint64_t __user *fcc = sc + abi->off_sc_fcc;
> > +     uint32_t __user *csr = sc + abi->off_sc_fcsr;
> > +     int i;
> > +     int err = 0;
> > +     int inc = 1;
> > +     u64 fpr_val;
> > +
> > +     for (i = 0; i < NUM_FPU_REGS; i += inc) {
> > +             err |= __get_user(fpr_val, &fpregs[4*i]);
> > +             set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
> > +     }
> > +     err |= __get_user(current->thread.fpu.fcsr, csr);
> > +     err |= __get_user(current->thread.fpu.fcc, fcc);
> > +
> > +     return err;
> > +}
> > +
> > +/*
> > + * Wrappers for the assembly _{save,restore}_fp_context functions.
> > + */
> > +static int save_hw_fp_context(void __user *sc)
> > +{
> > +     struct loongarch_abi *abi = current->thread.abi;
> > +     uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
> > +     uint64_t __user *fcc = sc + abi->off_sc_fcc;
> > +     uint32_t __user *fcsr = sc + abi->off_sc_fcsr;
> > +
> > +     return _save_fp_context(fpregs, fcc, fcsr);
> > +}
> > +
> > +static int restore_hw_fp_context(void __user *sc)
> > +{
> > +     struct loongarch_abi *abi = current->thread.abi;
> > +     uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
> > +     uint64_t __user *fcc = sc + abi->off_sc_fcc;
> > +     uint32_t __user *csr = sc + abi->off_sc_fcsr;
> > +
> > +     return _restore_fp_context(fpregs, fcc, csr);
> > +}
> > +
> > +/*
> > + * Helper routines
> > + */
> > +static int protected_save_fp_context(void __user *sc)
> > +{
> > +     int err = 0;
> > +     unsigned int used;
> > +     struct loongarch_abi *abi = current->thread.abi;
> > +     uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
> > +     uint32_t __user *fcc = sc + abi->off_sc_fcsr;
> > +     uint32_t __user *fcsr = sc + abi->off_sc_fcsr;
> > +     uint32_t __user *vcsr = sc + abi->off_sc_vcsr;
> > +     uint32_t __user *flags = sc + abi->off_sc_flags;
> > +
> > +     used = used_math() ? USED_FP : 0;
> > +     if (!used)
> > +             goto fp_done;
> > +
> > +     while (1) {
> > +             lock_fpu_owner();
> > +             if (is_fpu_owner())
> > +                     err = save_fp_context(sc);
> > +             else
> > +                     err |= copy_fp_to_sigcontext(sc);
> > +             unlock_fpu_owner();
> > +             if (likely(!err))
> > +                     break;
> > +             /* touch the sigcontext and try again */
> > +             err = __put_user(0, &fpregs[0]) |
> > +                     __put_user(0, &fpregs[32*4 - 1]) |
> > +                     __put_user(0, fcc) |
> > +                     __put_user(0, fcsr) |
> > +                     __put_user(0, vcsr);
> > +             if (err)
> > +                     return err;     /* really bad sigcontext */
> > +     }
> > +
> > +fp_done:
> > +     return __put_user(used, flags);
> > +}
> > +
> > +static int protected_restore_fp_context(void __user *sc)
> > +{
> > +     unsigned int used;
> > +     int err = 0, sig = 0, tmp __maybe_unused;
> > +     struct loongarch_abi *abi = current->thread.abi;
> > +     uint64_t __user *fpregs = sc + abi->off_sc_fpregs;
> > +     uint32_t __user *fcsr = sc + abi->off_sc_fcsr;
> > +     uint32_t __user *fcc = sc + abi->off_sc_fcsr;
> > +     uint32_t __user *vcsr = sc + abi->off_sc_vcsr;
> > +     uint32_t __user *flags = sc + abi->off_sc_flags;
> > +
> > +     err = __get_user(used, flags);
> > +     conditional_used_math(used & USED_FP);
> > +
> > +     /*
> > +      * The signal handler may have used FPU; give it up if the program
> > +      * doesn't want it following sigreturn.
> > +      */
> > +     if (err || !(used & USED_FP))
> > +             lose_fpu(0);
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     if (!(used & USED_FP))
> > +             goto fp_done;
> > +
> > +     err = sig = fpcsr_pending(fcsr);
> > +     if (err < 0)
> > +             return err;
> > +
> > +     while (1) {
> > +             lock_fpu_owner();
> > +             if (is_fpu_owner())
> > +                     err = restore_fp_context(sc);
> > +             else
> > +                     err |= copy_fp_from_sigcontext(sc);
> > +             unlock_fpu_owner();
> > +             if (likely(!err))
> > +                     break;
> > +             /* touch the sigcontext and try again */
> > +             err = __get_user(tmp, &fpregs[0]) |
> > +                     __get_user(tmp, &fpregs[32*4 - 1]) |
> > +                     __get_user(tmp, fcc) |
> > +                     __get_user(tmp, fcsr) |
> > +                     __get_user(tmp, vcsr);
> > +             if (err)
> > +                     break;  /* really bad sigcontext */
> > +     }
> > +
> > +fp_done:
> > +     return err ?: sig;
> > +}
> > +
> > +static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
> > +{
> > +     int err = 0;
> > +     int i;
> > +
> > +     err |= __put_user(regs->csr_epc, &sc->sc_pc);
> > +
> > +     err |= __put_user(0, &sc->sc_regs[0]);
> > +     for (i = 1; i < 32; i++)
> > +             err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
> > +
> > +     /*
> > +      * Save FPU state to signal context. Signal handler
> > +      * will "inherit" current FPU state.
> > +      */
> > +     err |= protected_save_fp_context(sc);
> > +
> > +     return err;
> > +}
> > +
> > +int fpcsr_pending(unsigned int __user *fpcsr)
> > +{
> > +     int err, sig = 0;
> > +     unsigned int csr, enabled;
> > +
> > +     err = __get_user(csr, fpcsr);
> > +     enabled = ((csr & FPU_CSR_ALL_E) << 24);
> > +     /*
> > +      * If the signal handler set some FPU exceptions, clear it and
> > +      * send SIGFPE.
> > +      */
> > +     if (csr & enabled) {
> > +             csr &= ~enabled;
> > +             err |= __put_user(csr, fpcsr);
> > +             sig = SIGFPE;
> > +     }
> > +     return err ?: sig;
> > +}
> > +
> > +static int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
> > +{
> > +     int err = 0;
> > +     int i;
> > +
> > +     /* Always make any pending restarted system calls return -EINTR */
> > +     current->restart_block.fn = do_no_restart_syscall;
> > +
> > +     err |= __get_user(regs->csr_epc, &sc->sc_pc);
> > +
> > +     for (i = 1; i < 32; i++)
> > +             err |= __get_user(regs->regs[i], &sc->sc_regs[i]);
> > +
> > +     return err ?: protected_restore_fp_context(sc);
> > +}
> > +
> > +void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
> > +                       size_t frame_size)
> > +{
> > +     unsigned long sp;
> > +
> > +     /* Default to using normal stack */
> > +     sp = regs->regs[3];
> > +     sp -= 32;   /* Reserve 32-bytes. */
> > +
> > +     sp = sigsp(sp, ksig);
> > +
> > +     return (void __user *)((sp - frame_size) & ALMASK);
> > +}
> > +
> > +/*
> > + * Atomically swap in the new signal mask, and wait for a signal.
> > + */
> > +
> > +asmlinkage long sys_rt_sigreturn(void)
> > +{
> > +     struct rt_sigframe __user *frame;
> > +     struct pt_regs *regs;
> > +     sigset_t set;
> > +     int sig;
> > +
> > +     regs = current_pt_regs();
> > +     frame = (struct rt_sigframe __user *)regs->regs[3];
> > +     if (!access_ok(frame, sizeof(*frame)))
> > +             goto badframe;
> > +     if (__copy_from_user(&set, &frame->rs_uctx.uc_sigmask, sizeof(set)))
> > +             goto badframe;
> > +
> > +     set_current_blocked(&set);
> > +
> > +     sig = restore_sigcontext(regs, &frame->rs_uctx.uc_mcontext);
> > +     if (sig < 0)
> > +             goto badframe;
> > +     else if (sig)
> > +             force_sig(sig);
> > +
> > +     if (restore_altstack(&frame->rs_uctx.uc_stack))
> > +             goto badframe;
> > +
> > +     return regs->regs[4];
> > +
> > +badframe:
> > +     force_sig(SIGSEGV);
> > +     return 0;
> > +}
> > +
> > +static int setup_rt_frame(void *sig_return, struct ksignal *ksig,
> > +                       struct pt_regs *regs, sigset_t *set)
> > +{
> > +     struct rt_sigframe __user *frame;
> > +     int err = 0;
> > +
> > +     frame = get_sigframe(ksig, regs, sizeof(*frame));
> > +     if (!access_ok(frame, sizeof(*frame)))
> > +             return -EFAULT;
> > +
> > +     /* Create siginfo.  */
> > +     err |= copy_siginfo_to_user(&frame->rs_info, &ksig->info);
> > +
> > +     /* Create the ucontext.  */
> > +     err |= __put_user(0, &frame->rs_uctx.uc_flags);
> > +     err |= __put_user(NULL, &frame->rs_uctx.uc_link);
> > +     err |= __save_altstack(&frame->rs_uctx.uc_stack, regs->regs[3]);
> > +     err |= setup_sigcontext(regs, &frame->rs_uctx.uc_mcontext);
> > +     err |= __copy_to_user(&frame->rs_uctx.uc_sigmask, set, sizeof(*set));
> > +
> > +     if (err)
> > +             return -EFAULT;
> > +
> > +     /*
> > +      * Arguments to signal handler:
> > +      *
> > +      *   a0 = signal number
> > +      *   a1 = 0 (should be cause)
> > +      *   a2 = pointer to ucontext
> > +      *
> > +      * $25 and c0_epc point to the signal handler, $29 points to
> > +      * the struct rt_sigframe.
> > +      */
> > +     regs->regs[4] = ksig->sig;
> > +     regs->regs[5] = (unsigned long) &frame->rs_info;
> > +     regs->regs[6] = (unsigned long) &frame->rs_uctx;
> > +     regs->regs[3] = (unsigned long) frame;
> > +     regs->regs[1] = (unsigned long) sig_return;
> > +     regs->csr_epc = (unsigned long) ksig->ka.sa.sa_handler;
> > +
> > +     DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
> > +            current->comm, current->pid,
> > +            frame, regs->csr_epc, regs->regs[1]);
> > +
> > +     return 0;
> > +}
> > +
> > +struct loongarch_abi loongarch_abi = {
> > +     .restart        = __NR_restart_syscall,
> > +#ifdef CONFIG_32BIT
> > +     .audit_arch     = AUDIT_ARCH_LOONGARCH32,
> > +#else
> > +     .audit_arch     = AUDIT_ARCH_LOONGARCH64,
> > +#endif
> > +
> > +     .off_sc_fpregs  = offsetof(struct sigcontext, sc_fpregs),
> > +     .off_sc_fcc     = offsetof(struct sigcontext, sc_fcc),
> > +     .off_sc_fcsr    = offsetof(struct sigcontext, sc_fcsr),
> > +     .off_sc_vcsr    = offsetof(struct sigcontext, sc_vcsr),
> > +     .off_sc_flags   = offsetof(struct sigcontext, sc_flags),
> > +
> > +     .vdso           = &vdso_info,
> > +};
> > +
> > +static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
> > +{
> > +     int ret;
> > +     sigset_t *oldset = sigmask_to_save();
> > +     struct loongarch_abi *abi = current->thread.abi;
> > +     void *vdso = current->mm->context.vdso;
> > +
> > +     /* Are we from a system call? */
> > +     if (regs->regs[0]) {
> > +             switch (regs->regs[4]) {
> > +             case -ERESTART_RESTARTBLOCK:
> > +             case -ERESTARTNOHAND:
> > +                     regs->regs[4] = -EINTR;
> > +                     break;
> > +             case -ERESTARTSYS:
> > +                     if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
> > +                             regs->regs[4] = -EINTR;
> > +                             break;
> > +                     }
> > +                     fallthrough;
> > +             case -ERESTARTNOINTR:
> > +                     regs->regs[4] = regs->orig_a0;
> > +                     regs->csr_epc -= 4;
> > +             }
> > +
> > +             regs->regs[0] = 0;      /* Don't deal with this again.  */
> > +     }
> > +
> > +     rseq_signal_deliver(ksig, regs);
> > +
> > +     ret = setup_rt_frame(vdso + abi->vdso->offset_sigreturn, ksig, regs, oldset);
> > +
> > +     signal_setup_done(ret, ksig, 0);
> > +}
> > +
> > +void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
> > +{
> > +     struct ksignal ksig;
> > +
> > +     if (has_signal && get_signal(&ksig)) {
> > +             /* Whee!  Actually deliver the signal.  */
> > +             handle_signal(&ksig, regs);
> > +             return;
> > +     }
> > +
> > +     /* Are we from a system call? */
> > +     if (regs->regs[0]) {
> > +             switch (regs->regs[4]) {
> > +             case -ERESTARTNOHAND:
> > +             case -ERESTARTSYS:
> > +             case -ERESTARTNOINTR:
> > +                     regs->regs[4] = regs->orig_a0;
> > +                     regs->csr_epc -= 4;
> > +                     break;
> > +
> > +             case -ERESTART_RESTARTBLOCK:
> > +                     regs->regs[4] = regs->orig_a0;
> > +                     regs->regs[11] = current->thread.abi->restart;
> > +                     regs->csr_epc -= 4;
> > +                     break;
> > +             }
> > +             regs->regs[0] = 0;      /* Don't deal with this again.  */
> > +     }
> > +
> > +     /*
> > +      * If there's no signal to deliver, we just put the saved sigmask
> > +      * back
> > +      */
> > +     restore_saved_sigmask();
> > +}
> > +
> > +static int signal_setup(void)
> > +{
> > +     if (cpu_has_fpu) {
> > +             save_fp_context = save_hw_fp_context;
> > +             restore_fp_context = restore_hw_fp_context;
> > +     } else {
> > +             save_fp_context = copy_fp_to_sigcontext;
> > +             restore_fp_context = copy_fp_from_sigcontext;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +arch_initcall(signal_setup);

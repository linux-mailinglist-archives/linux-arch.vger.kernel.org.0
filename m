Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7518D5277DF
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 15:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiEONsw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 09:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiEONsv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 09:48:51 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6FC266B;
        Sun, 15 May 2022 06:48:48 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id d22so12996155vsf.2;
        Sun, 15 May 2022 06:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJIUFYfU9Ytz69ypAqv3yVm1WuqKXBC0bY+J7Cc91g4=;
        b=dwLrUqO8uPVBD5Ug74BVGza++uNj3Kjcxv1xv6tlXiWDOaGm8oyUO9Px5Fr4LxDJST
         AFQa/CEvQ2+iNwgZgldLAJgYILjvoH5hFvMagk2r5pIijbL7lMnvxmw1K2rjucktjctk
         lMGN0xPLYNj86D8AS0hbe90dUcSC86tkklHvxPgbLIV83PD3scAnndiuutnu+LnngbzZ
         p2ef515Bcz5lSNX8MqxdHxktqwxvX4Mokua6w37j0uURci2jeNJhE/j/4/WntATrrXy3
         wiQcM9TtS6QwV0N48PZyw9kGFVyf+d97WauNXVeaNW3CO8kUgGF2l9h2tFTU51PKIMHP
         p6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJIUFYfU9Ytz69ypAqv3yVm1WuqKXBC0bY+J7Cc91g4=;
        b=GdMyxKQCA3pfXc0/QQF7DsPg5jAtm01pKymGGD/gNwYtzItONnA4c8FXF7pZqDfZSA
         Y2AD8BDkF4Hr3Endg6Y19/FEkkAb3webPyBcN7KqYHeGK0l1Z6wGwlNpeu5GTs638D6J
         5xkvMXctcD9FIsl8OB2JztteZ1X40RIA2Kbx7o36G+GF195KpmB+oKqS7DBGahXrU2r0
         Z/U9jAbbKmBP8RpMS7vsEF3ek/LAKqGvFwS2peLS9ptKUKEFyXFCbE8M31pTCY4SIRLB
         5VywDIIf+7QiT2C7ayuijRoHndoiExuUKHTCU89n4si2KtWqOsysC86SCpDtTajwZSmX
         w0zw==
X-Gm-Message-State: AOAM5317AFzecyfOLv2oB1t3Ozyn3KgljFtVJfbOLNkGO16TtFPOS9Hb
        LtgSkbNsgmS/rD+j9X2GnBDuP7DEO1jvf7EnCOs=
X-Google-Smtp-Source: ABdhPJxUQ4AyazpISJ8zKUmwedMTBKC4hRlFjk4pdZNIwTVfJ12HzTcutKsJI+snbWiVYtPeGCHAJdwqVq/GkU80l/Y=
X-Received: by 2002:a67:be0b:0:b0:32c:d82f:6723 with SMTP id
 x11-20020a67be0b000000b0032cd82f6723mr5272041vsq.67.1652622527289; Sun, 15
 May 2022 06:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-15-chenhuacai@loongson.cn> <ef37e578-d843-6a2f-2108-2a26dc54bece@xen0n.name>
In-Reply-To: <ef37e578-d843-6a2f-2108-2a26dc54bece@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 15 May 2022 21:48:36 +0800
Message-ID: <CAAhV-H7UwLJLiMtjkW0xxfsBBaCPXqkQ-d+ZW4rm+=igvVP6ew@mail.gmail.com>
Subject: Re: [PATCH V10 14/22] LoongArch: Add signal handling support
To:     WANG Xuerui <kernel@xen0n.name>
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
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Eric Biederman <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Sun, May 15, 2022 at 6:39 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> Hi,
>
> On 5/14/22 16:03, Huacai Chen wrote:
> > Add ucontext/sigcontext definition and signal handling support for
> > LoongArch.
> >
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/uapi/asm/sigcontext.h |  63 ++
> >   arch/loongarch/include/uapi/asm/signal.h     |  13 +
> >   arch/loongarch/include/uapi/asm/ucontext.h   |  35 ++
> >   arch/loongarch/kernel/signal.c               | 568 +++++++++++++++++++
> >   4 files changed, 679 insertions(+)
> >   create mode 100644 arch/loongarch/include/uapi/asm/sigcontext.h
> >   create mode 100644 arch/loongarch/include/uapi/asm/signal.h
> >   create mode 100644 arch/loongarch/include/uapi/asm/ucontext.h
> >   create mode 100644 arch/loongarch/kernel/signal.c
> >
> > diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
> > new file mode 100644
> > index 000000000000..efeb8b3f8236
> > --- /dev/null
> > +++ b/arch/loongarch/include/uapi/asm/sigcontext.h
> > @@ -0,0 +1,63 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +/*
> > + * Author: Hanlu Li <lihanlu@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _UAPI_ASM_SIGCONTEXT_H
> > +#define _UAPI_ASM_SIGCONTEXT_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/posix_types.h>
> > +
> > +/* FP context was used */
> > +#define USED_FP                      (1 << 0)
> > +/* Load/Store access flags for address error */
> > +#define ADRERR_RD            (1 << 30)
> > +#define ADRERR_WR            (1 << 31)
> I've searched GitHub globally, and my local glibc checkout, for usages
> of these 3 constants, and there seems to be none; please consider
> removing these if doable. We don't want cruft in uapi right from the
> beginning.
They will be used in our glibc, I promise.

> > +
> > +struct sigcontext {
> > +     __u64   sc_pc;
> > +     __u64   sc_regs[32];
> > +     __u32   sc_flags;
> > +     __u64   sc_extcontext[0] __attribute__((__aligned__(16)));
> > +};
> > +
> > +#define CONTEXT_INFO_ALIGN   16
> > +struct _ctxinfo {
> > +     __u32   magic;
> > +     __u32   size;
> > +     __u64   padding;        /* padding to 16 bytes */
> > +};
> > +
> > +/* FPU context */
> > +#define FPU_CTX_MAGIC                0x46505501
> > +#define FPU_CTX_ALIGN                8
> > +struct fpu_context {
> > +     __u64   regs[32];
> > +     __u64   fcc;
> > +     __u32   fcsr;
> > +};
> The 3 structs above should already see usage downstream (glibc and other
> low-level friends), so they probably shouldn't be touched by now. At
> least I can't see problems.
> > +
> > +/* LSX context */
> > +#define LSX_CTX_MAGIC                0x53580001
> > +#define LSX_CTX_ALIGN                16
> > +struct lsx_context {
> > +     __u64   regs[2*32];
> > +     __u64   fcc;
> > +     __u32   fcsr;
> > +     __u32   vcsr;
> > +};
> > +
> > +/* LASX context */
> > +#define LASX_CTX_MAGIC               0x41535801
> > +#define LASX_CTX_ALIGN               32
> > +struct lasx_context {
> > +     __u64   regs[4*32];
> > +     __u64   fcc;
> > +     __u32   fcsr;
> > +     __u32   vcsr;
> > +};
> Do we want to freeze the LSX/LASX layout this early, before any detail
> of said extension are published? We'll need to update kernel later
> anyway, so I'd recommend leaving them out for the initial bring-up.
Yes, they are freezed.

> > +
> > +#endif /* _UAPI_ASM_SIGCONTEXT_H */
> > diff --git a/arch/loongarch/include/uapi/asm/signal.h b/arch/loongarch/include/uapi/asm/signal.h
> > new file mode 100644
> > index 000000000000..992d965aa13f
> > --- /dev/null
> > +++ b/arch/loongarch/include/uapi/asm/signal.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _UAPI_ASM_SIGNAL_H
> > +#define _UAPI_ASM_SIGNAL_H
> > +
> > +#define MINSIGSTKSZ 4096
> > +#define SIGSTKSZ    16384
>
> I've checked this set of values is also the choice for arch/alpha and
> arch/sparc, and that the Loongson devs are aware of the LWN article [1]
> about x86's story around insufficient signal stack size. So I'd approve
> this.
Thanks.

>
> [1]: https://lwn.net/Articles/874846/
>
> > +
> > +#include <asm-generic/signal.h>
> > +
> > +#endif
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
> Document the other fields? ;-)
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
> This is in turn copied from arch/riscv (who got it from arch/arm64,
> thanks to both arches!), so we shouldn't be too bad future-proof-wise.
> But do we want an attribution to arch/riscv too, like they did for
> arch/arm64? (Stating that you referred to arch/riscv for inspiration.)
> > +
> > +#endif /* __LOONGARCH_UAPI_ASM_UCONTEXT_H */
> > diff --git a/arch/loongarch/kernel/signal.c b/arch/loongarch/kernel/signal.c
> > new file mode 100644
> > index 000000000000..489e169e1d13
> > --- /dev/null
> > +++ b/arch/loongarch/kernel/signal.c
> > @@ -0,0 +1,568 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Author: Hanlu Li <lihanlu@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
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
> > +#include <linux/compiler.h>
> > +#include <linux/syscalls.h>
> > +#include <linux/uaccess.h>
> > +
> > +#include <asm/asm.h>
> > +#include <asm/cacheflush.h>
> > +#include <asm/cpu-features.h>
> > +#include <asm/fpu.h>
> > +#include <asm/ucontext.h>
> > +#include <asm/vdso.h>
> > +
> > +#ifdef DEBUG_SIG
> > +#  define DEBUGP(fmt, args...) printk("%s: " fmt, __func__, ##args)
> > +#else
> > +#  define DEBUGP(fmt, args...)
> > +#endif
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
> > +struct rt_sigframe {
> > +     struct siginfo rs_info;
> > +     struct ucontext rs_uctx;
> > +};
> > +
> > +struct _ctx_layout {
> > +     struct _ctxinfo *addr;
> > +     unsigned int size;
> > +};
> > +
> > +struct extctx_layout {
> > +     unsigned long size;
> > +     unsigned int flags;
> > +     struct _ctx_layout fpu;
> > +     struct _ctx_layout lsx;
> > +     struct _ctx_layout lasx;
> > +     struct _ctx_layout end;
> > +};
> > +
> > +static void __user *get_ctx_through_ctxinfo(struct _ctxinfo *info)
> > +{
> > +     return (void __user *)((char *)info + sizeof(struct _ctxinfo));
> > +}
> > +
> > +/*
> > + * Thread saved context copy to/from a signal context presumed to be on the
> > + * user stack, and therefore accessed with appropriate macros from uaccess.h.
> > + */
> > +static int copy_fpu_to_sigcontext(struct fpu_context __user *ctx)
> > +{
> > +     int i;
> > +     int err = 0;
> > +     uint64_t __user *regs   = (uint64_t *)&ctx->regs;
> > +     uint64_t __user *fcc    = &ctx->fcc;
> > +     uint32_t __user *fcsr   = &ctx->fcsr;
> > +
> > +     for (i = 0; i < NUM_FPU_REGS; i++) {
> > +             err |=
> > +                 __put_user(get_fpr64(&current->thread.fpu.fpr[i], 0),
> > +                            &regs[i]);
> > +     }
> > +     err |= __put_user(current->thread.fpu.fcc, fcc);
> > +     err |= __put_user(current->thread.fpu.fcsr, fcsr);
> > +
> > +     return err;
> > +}
> > +
> > +static int copy_fpu_from_sigcontext(struct fpu_context __user *ctx)
> > +{
> > +     int i;
> > +     int err = 0;
> > +     u64 fpr_val;
> > +     uint64_t __user *regs   = (uint64_t *)&ctx->regs;
> > +     uint64_t __user *fcc    = &ctx->fcc;
> > +     uint32_t __user *fcsr   = &ctx->fcsr;
> > +
> > +     for (i = 0; i < NUM_FPU_REGS; i++) {
> > +             err |= __get_user(fpr_val, &regs[i]);
> > +             set_fpr64(&current->thread.fpu.fpr[i], 0, fpr_val);
> > +     }
> > +     err |= __get_user(current->thread.fpu.fcc, fcc);
> > +     err |= __get_user(current->thread.fpu.fcsr, fcsr);
> > +
> > +     return err;
> > +}
> > +
> > +/*
> > + * Wrappers for the assembly _{save,restore}_fp_context functions.
> > + */
> > +static int save_hw_fpu_context(struct fpu_context __user *ctx)
> > +{
> > +     uint64_t __user *regs   = (uint64_t *)&ctx->regs;
> > +     uint64_t __user *fcc    = &ctx->fcc;
> > +     uint32_t __user *fcsr   = &ctx->fcsr;
> > +
> > +     return _save_fp_context(regs, fcc, fcsr);
> > +}
> > +
> > +static int restore_hw_fpu_context(struct fpu_context __user *ctx)
> > +{
> > +     uint64_t __user *regs   = (uint64_t *)&ctx->regs;
> > +     uint64_t __user *fcc    = &ctx->fcc;
> > +     uint32_t __user *fcsr   = &ctx->fcsr;
> > +
> > +     return _restore_fp_context(regs, fcc, fcsr);
> > +}
> > +
> > +int fpcsr_pending(unsigned int __user *fpcsr)
> Is "fpcsr" just "fcsr"?
Yes, fcsr looks better.

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
> > +/*
> > + * Helper routines
> > + */
> > +static int protected_save_fpu_context(struct extctx_layout *extctx)
> > +{
> > +     int err = 0;
> > +     struct _ctxinfo __user *info = extctx->fpu.addr;
> > +     struct fpu_context __user *fpu_ctx = (struct fpu_context *)get_ctx_through_ctxinfo(info);
> > +     uint64_t __user *regs   = (uint64_t *)&fpu_ctx->regs;
> > +     uint64_t __user *fcc    = &fpu_ctx->fcc;
> > +     uint32_t __user *fcsr   = &fpu_ctx->fcsr;
> > +
> > +     while (1) {
> > +             lock_fpu_owner();
> > +             if (is_fpu_owner())
> > +                     err = save_hw_fpu_context(fpu_ctx);
> > +             else
> > +                     err = copy_fpu_to_sigcontext(fpu_ctx);
> > +             unlock_fpu_owner();
> > +
> > +             err |= __put_user(FPU_CTX_MAGIC, &info->magic);
> > +             err |= __put_user(extctx->fpu.size, &info->size);
> > +
> > +             if (likely(!err))
> > +                     break;
> > +             /* Touch the FPU context and try again */
> > +             err = __put_user(0, &regs[0]) |
> > +                     __put_user(0, &regs[31]) |
> > +                     __put_user(0, fcc) |
> > +                     __put_user(0, fcsr);
> > +             if (err)
> > +                     return err;     /* really bad sigcontext */
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > +static int protected_restore_fpu_context(struct extctx_layout *extctx)
> > +{
> > +     int err = 0, sig = 0, tmp __maybe_unused;
> > +     struct _ctxinfo __user *info = extctx->fpu.addr;
> > +     struct fpu_context __user *fpu_ctx = (struct fpu_context *)get_ctx_through_ctxinfo(info);
> > +     uint64_t __user *regs   = (uint64_t *)&fpu_ctx->regs;
> > +     uint64_t __user *fcc    = &fpu_ctx->fcc;
> > +     uint32_t __user *fcsr   = &fpu_ctx->fcsr;
> > +
> > +     err = sig = fpcsr_pending(fcsr);
> > +     if (err < 0)
> > +             return err;
> > +
> > +     while (1) {
> > +             lock_fpu_owner();
> > +             if (is_fpu_owner())
> > +                     err = restore_hw_fpu_context(fpu_ctx);
> > +             else
> > +                     err = copy_fpu_from_sigcontext(fpu_ctx);
> > +             unlock_fpu_owner();
> > +
> > +             if (likely(!err))
> > +                     break;
> > +             /* Touch the FPU context and try again */
> > +             err = __get_user(tmp, &regs[0]) |
> > +                     __get_user(tmp, &regs[31]) |
> > +                     __get_user(tmp, fcc) |
> > +                     __get_user(tmp, fcsr);
> > +             if (err)
> > +                     break;  /* really bad sigcontext */
> > +     }
> > +
> > +     return err ?: sig;
> > +}
> > +
> > +static int setup_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc,
> > +                         struct extctx_layout *extctx)
> > +{
> > +     int i, err = 0;
> > +     struct _ctxinfo __user *info;
> > +
> > +     err |= __put_user(regs->csr_era, &sc->sc_pc);
> > +     err |= __put_user(extctx->flags, &sc->sc_flags);
> > +
> > +     err |= __put_user(0, &sc->sc_regs[0]);
> > +     for (i = 1; i < 32; i++)
> > +             err |= __put_user(regs->regs[i], &sc->sc_regs[i]);
> > +
> > +     if (extctx->fpu.addr)
> > +             err |= protected_save_fpu_context(extctx);
> > +
> > +     /* Set the "end" magic */
> > +     info = (struct _ctxinfo *)extctx->end.addr;
> > +     err |= __put_user(0, &info->magic);
> > +     err |= __put_user(0, &info->size);
> > +
> > +     return err;
> > +}
> > +
> > +static int parse_extcontext(struct sigcontext __user *sc, struct extctx_layout *extctx)
> > +{
> > +     int err = 0;
> > +     unsigned int magic, size;
> > +     struct _ctxinfo __user *info = (struct _ctxinfo __user *)&sc->sc_extcontext;
> > +
> > +     while(1) {
> > +             err |= __get_user(magic, &info->magic);
> > +             err |= __get_user(size, &info->size);
> > +             if (err)
> > +                     return err;
> > +
> > +             switch (magic) {
> > +             case 0: /* END */
> > +                     goto done;
> > +
> > +             case FPU_CTX_MAGIC:
> > +                     if (size < (sizeof(struct _ctxinfo) +
> > +                                 sizeof(struct fpu_context)))
> > +                             goto invalid;
> > +                     extctx->fpu.addr = info;
> > +                     break;
> > +
> > +             default:
> > +                     goto invalid;
> > +             }
> > +
> > +             info = (struct _ctxinfo *)((char *)info + size);
> > +     }
> > +
> > +done:
> > +     return 0;
> > +
> > +invalid:
> > +     return -EINVAL;
> > +}
> > +
> > +static int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
> > +{
> > +     int i, err = 0;
> > +     struct extctx_layout extctx;
> > +
> > +     memset(&extctx, 0, sizeof(struct extctx_layout));
> > +
> > +     err = __get_user(extctx.flags, &sc->sc_flags);
> > +     if (err)
> > +             goto bad;
> > +
> > +     err = parse_extcontext(sc, &extctx);
> > +     if (err)
> > +             goto bad;
> > +
> > +     conditional_used_math(extctx.flags & USED_FP);
> > +
> > +     /*
> > +      * The signal handler may have used FPU; give it up if the program
> > +      * doesn't want it following sigreturn.
> > +      */
> > +     if (!(extctx.flags & USED_FP))
> > +             lose_fpu(0);
> > +
> > +     /* Always make any pending restarted system calls return -EINTR */
> > +     current->restart_block.fn = do_no_restart_syscall;
> > +
> > +     err |= __get_user(regs->csr_era, &sc->sc_pc);
> > +     for (i = 1; i < 32; i++)
> > +             err |= __get_user(regs->regs[i], &sc->sc_regs[i]);
> > +
> > +     if (extctx.fpu.addr)
> > +             err |= protected_restore_fpu_context(&extctx);
> > +
> > +bad:
> > +     return err;
> > +}
> > +
> > +static unsigned int handle_flags(void)
> > +{
> > +     unsigned int flags = 0;
> > +
> > +     flags |= used_math() ? USED_FP : 0;
> > +
> > +     switch (current->thread.error_code) {
> > +     case 1:
> > +             flags |= ADRERR_RD;
> > +             break;
> > +     case 2:
> > +             flags |= ADRERR_WR;
> > +             break;
> > +     }
> > +
> > +     return flags;
> > +}
> > +
> > +static unsigned long extframe_alloc(struct extctx_layout *extctx,
> > +                                 struct _ctx_layout *layout,
> > +                                 size_t size, unsigned int align, unsigned long base)
> > +{
> > +     unsigned long new_base = base - size;
> > +
> > +     new_base = round_down(new_base, (align < 16 ? 16 : align));
> > +     new_base -= sizeof(struct _ctxinfo);
> > +
> > +     layout->addr = (void *)new_base;
> > +     layout->size = (unsigned int)(base - new_base);
> > +     extctx->size += layout->size;
> > +
> > +     return new_base;
> > +}
> > +
> > +static unsigned long setup_extcontext(struct extctx_layout *extctx, unsigned long sp)
> > +{
> > +     unsigned long new_sp = sp;
> > +
> > +     memset(extctx, 0, sizeof(struct extctx_layout));
> > +
> > +     extctx->flags = handle_flags();
> > +
> > +     /* Grow down, alloc "end" context info first. */
> > +     new_sp -= sizeof(struct _ctxinfo);
> > +     extctx->end.addr = (void *)new_sp;
> > +     extctx->end.size = (unsigned int)sizeof(struct _ctxinfo);
> > +     extctx->size += extctx->end.size;
> > +
> > +     if (extctx->flags & USED_FP) {
> > +             if (cpu_has_fpu)
> > +                     new_sp = extframe_alloc(extctx, &extctx->fpu,
> > +                       sizeof(struct fpu_context), FPU_CTX_ALIGN, new_sp);
> > +     }
> > +
> > +     return new_sp;
> > +}
> > +
> > +void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
> > +                       struct extctx_layout *extctx)
> > +{
> > +     unsigned long sp;
> > +
> > +     /* Default to using normal stack */
> > +     sp = regs->regs[3];
> > +
> > +     /*
> > +      * If we are on the alternate signal stack and would overflow it, don't.
> > +      * Return an always-bogus address instead so we will die with SIGSEGV.
> > +      */
> > +     if (on_sig_stack(sp) &&
> > +         !likely(on_sig_stack(sp - sizeof(struct rt_sigframe))))
> > +             return (void __user __force *)(-1UL);
> > +
> > +     sp = sigsp(sp, ksig);
> > +     sp = round_down(sp, 16);
> > +     sp = setup_extcontext(extctx, sp);
> > +     sp -= sizeof(struct rt_sigframe);
> > +
> > +     if (!IS_ALIGNED(sp, 16))
> > +             BUG();
> > +
> > +     return (void __user *)sp;
> > +}
> > +
> > +/*
> > + * Atomically swap in the new signal mask, and wait for a signal.
> > + */
> > +
> > +asmlinkage long sys_rt_sigreturn(void)
> > +{
> > +     int sig;
> > +     sigset_t set;
> > +     struct pt_regs *regs;
> > +     struct rt_sigframe __user *frame;
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
> > +     regs->regs[0] = 0; /* No syscall restarting */
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
> > +     int err = 0;
> > +     struct extctx_layout extctx;
> > +     struct rt_sigframe __user *frame;
> > +
> > +     frame = get_sigframe(ksig, regs, &extctx);
> > +     if (!access_ok(frame, sizeof(*frame) + extctx.size))
> > +             return -EFAULT;
> > +
> > +     /* Create siginfo.  */
> > +     err |= copy_siginfo_to_user(&frame->rs_info, &ksig->info);
> > +
> > +     /* Create the ucontext.  */
> > +     err |= __put_user(0, &frame->rs_uctx.uc_flags);
> > +     err |= __put_user(NULL, &frame->rs_uctx.uc_link);
> > +     err |= __save_altstack(&frame->rs_uctx.uc_stack, regs->regs[3]);
> > +     err |= setup_sigcontext(regs, &frame->rs_uctx.uc_mcontext, &extctx);
> > +     err |= __copy_to_user(&frame->rs_uctx.uc_sigmask, set, sizeof(*set));
> > +
> > +     if (err)
> > +             return -EFAULT;
> > +
> > +     /*
> > +      * Arguments to signal handler:
> > +      *
> > +      *   a0 = signal number
> > +      *   a1 = pointer to siginfo
> > +      *   a2 = pointer to ucontext
> > +      *
> > +      * c0_era point to the signal handler, $r3 (sp) points to
> > +      * the struct rt_sigframe.
> > +      */
> > +     regs->regs[4] = ksig->sig;
> > +     regs->regs[5] = (unsigned long) &frame->rs_info;
> > +     regs->regs[6] = (unsigned long) &frame->rs_uctx;
> > +     regs->regs[3] = (unsigned long) frame;
> > +     regs->regs[1] = (unsigned long) sig_return;
> > +     regs->csr_era = (unsigned long) ksig->ka.sa.sa_handler;
> > +
> > +     DEBUGP("SIG deliver (%s:%d): sp=0x%p pc=0x%lx ra=0x%lx\n",
> > +            current->comm, current->pid,
> > +            frame, regs->csr_era, regs->regs[1]);
> > +
> > +     return 0;
> > +}
> > +
> > +static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
> > +{
> > +     int ret;
> > +     sigset_t *oldset = sigmask_to_save();
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
> > +                     regs->csr_era -= 4;
> > +             }
> > +
> > +             regs->regs[0] = 0;      /* Don't deal with this again.  */
> > +     }
> > +
> > +     rseq_signal_deliver(ksig, regs);
> > +
> > +     ret = setup_rt_frame(vdso + current->thread.vdso->offset_sigreturn, ksig, regs, oldset);
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
> > +                     regs->csr_era -= 4;
> > +                     break;
> > +
> > +             case -ERESTART_RESTARTBLOCK:
> > +                     regs->regs[4] = regs->orig_a0;
> > +                     regs->regs[11] = __NR_restart_syscall;
> > +                     regs->csr_era -= 4;
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
>
> This patch looks reasonably good, with the comments addressed (revised
> or replied in case you want to keep as-is):
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
Thanks for your review.

Huacai
>

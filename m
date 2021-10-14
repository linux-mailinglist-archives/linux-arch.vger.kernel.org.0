Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0902242D57E
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhJNI6D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 04:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhJNI6C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Oct 2021 04:58:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEA7C061570;
        Thu, 14 Oct 2021 01:55:58 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id om14so4211199pjb.5;
        Thu, 14 Oct 2021 01:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=THRnlUFtRl5vYcnMFF9o7XezZbEmtWWNz/WTffJCZww=;
        b=EShx8j66Mb1MfbirC3yEc5pAn7vD/rRMBp4DOxWAcBacIKTl4MllYVMuCGvthm6Dbn
         MvxJrjStlAjWsDqjUrTr5wQJR/IuzCP2tWBVSe9eCm939zm1Q70/A3adrzlthJD2IhIr
         WukORLaQO5xNiu0i4Rbov6QKp/zs8GEIhdgzJQKsjEMS5mKxrl38dYpQAnWiszvrdStK
         0GkHBgOmetLNCq0EjuzDsNBAxLOlfdPjs3UVo/+x5ZMWP2KpfVjDsgNsBt63SwXPIvlJ
         bloouReGDIQ/ZknAr2MjK2X+AWlIyE9VbV8ufHExJ2Xv2LkEbR3EROX+46mJepSXfV4D
         vaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THRnlUFtRl5vYcnMFF9o7XezZbEmtWWNz/WTffJCZww=;
        b=o8JrkZfyTnXIwLnrs45zFn57LY9Z5lD1XMLTwnyUjYOe//oWeNyCU43k3S5iJ0ElQ5
         qU1yzspm0OBUmR+cjtaqoQ15ORvV3tYpmCWx+KWhKxPe/hka4iY52GWQ6mvye7UKr/Ko
         rTF9Mnf8JrlTd3TF8XeXY7WjzzYn3mIWyeXQQwtnyxPzPo/ISHihgT4kB9/ZxmJW+PjW
         wI+NBrPj8+b2MVNws7/m+9EurHAhCh15lD6rBPgbhxLAye36CW45cIzCJUNVTQ24AVxI
         XkJ/rQ59W2ciJCLd3TSfhFgqb/dN3n/5vYvXDxi2j1Yh9YcVgr7S9z2uNAGn9Wv/9kLl
         knRQ==
X-Gm-Message-State: AOAM533AMuvIZmGPWaDXL1ADsfWi93Z+eTgTrIF7C+24Urlf1VieLTrt
        nDnBaKwOiwIevsuqdIfwCoJCmwYMb35bOLd6FXY=
X-Google-Smtp-Source: ABdhPJz+aL7WEeb9t/f+LAQZXCCS3MZ68QTEzm0tH2Pk2S9by/5WdIUOKmnKd16e+Bfxz3l4lERkjmZ8J5WcSYD5u1I=
X-Received: by 2002:a17:90a:a41:: with SMTP id o59mr19323943pjo.243.1634201757853;
 Thu, 14 Oct 2021 01:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634177547.git.chenfeiyang@loongson.cn> <31a97087b56c703606b8d871ac35d2192928fe6b.1634177547.git.chenfeiyang@loongson.cn>
 <ddfbb616-9df1-9a92-3171-d534bddbd3d1@xen0n.name>
In-Reply-To: <ddfbb616-9df1-9a92-3171-d534bddbd3d1@xen0n.name>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Thu, 14 Oct 2021 16:56:14 +0800
Message-ID: <CACWXhKmFdFgJHsc+5Cu6wcHaTHJiqTfgd=P0ehkiy4Xpqp1Q3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] MIPS: convert syscall to generic entry
To:     WANG Xuerui <i.kernel@xen0n.name>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        arnd@arndb.de, Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        chenhuacai@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Zhou Yanjie <zhouyu@wanyeetech.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        YunQiang Su <wzssyqa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 14 Oct 2021 at 16:37, WANG Xuerui <i.kernel@xen0n.name> wrote:
>
> Hi Feiyang,
>
> On 2021/10/14 16:32, Feiyang Chen wrote:
> > Convert MIPS syscall to use the generic entry infrastructure from
> > kernel/entry/*.
> >
> > There are a few special things on MIPS:
> >
> > - There is one type of syscall on MIPS32 (scall32-o32) and three types
> > of syscalls on MIPS64 (scall64-o32, scall64-n32 and scall64-n64). Now
> > convert to C code to handle different types of syscalls.
> >
> > - For some special syscalls (e.g. fork, clone, clone3 and sysmips),
> > save_static_function() wrapper is used to save static registers. Now
> > SAVE_STATIC is used in handle_sys before calling do_syscall(), so the
> > save_static_function() wrapper can be removed.
> >
> > - For sigreturn/rt_sigreturn and sysmips, inline assembly is used to
> > jump to syscall_exit directly for skipping setting the error flag and
> > restoring all registers. Now use regs->regs[27] to mark whether to
> > handle the error flag and restore all registers in handle_sys, so these
> > functions can return normally as other architecture.
> >
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > Reviewed-by: Huacai Chen <chenhuacai@kernel.org>
> > ---
> >  arch/mips/Kconfig                         |   1 +
> >  arch/mips/include/asm/entry-common.h      |  13 ++
> >  arch/mips/include/asm/ptrace.h            |   8 +-
> >  arch/mips/include/asm/sim.h               |  70 -------
> >  arch/mips/include/asm/syscall.h           |   5 +
> >  arch/mips/include/asm/thread_info.h       |  17 +-
> >  arch/mips/include/uapi/asm/ptrace.h       |   7 +-
> >  arch/mips/kernel/Makefile                 |  14 +-
> >  arch/mips/kernel/entry.S                  |  75 ++------
> >  arch/mips/kernel/linux32.c                |   1 -
> >  arch/mips/kernel/ptrace.c                 |  78 --------
> >  arch/mips/kernel/scall.S                  | 137 +++++++++++++
> >  arch/mips/kernel/scall32-o32.S            | 223 ----------------------
> >  arch/mips/kernel/scall64-n32.S            | 107 -----------
> >  arch/mips/kernel/scall64-n64.S            | 116 -----------
> >  arch/mips/kernel/scall64-o32.S            | 221 ---------------------
> >  arch/mips/kernel/signal.c                 |  37 ++--
> >  arch/mips/kernel/signal_n32.c             |  16 +-
> >  arch/mips/kernel/signal_o32.c             |  31 +--
> >  arch/mips/kernel/syscall.c                | 148 +++++++++++---
> >  arch/mips/kernel/syscalls/syscall_n32.tbl |   8 +-
> >  arch/mips/kernel/syscalls/syscall_n64.tbl |   8 +-
> >  arch/mips/kernel/syscalls/syscall_o32.tbl |   8 +-
> >  23 files changed, 354 insertions(+), 995 deletions(-)
> >  create mode 100644 arch/mips/include/asm/entry-common.h
> >  delete mode 100644 arch/mips/include/asm/sim.h
> >  create mode 100644 arch/mips/kernel/scall.S
> >  delete mode 100644 arch/mips/kernel/scall32-o32.S
> >  delete mode 100644 arch/mips/kernel/scall64-n32.S
> >  delete mode 100644 arch/mips/kernel/scall64-n64.S
> >  delete mode 100644 arch/mips/kernel/scall64-o32.S
> >
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 1291774a2fa5..debd125100ad 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -32,6 +32,7 @@ config MIPS
> >       select GENERIC_ATOMIC64 if !64BIT
> >       select GENERIC_CMOS_UPDATE
> >       select GENERIC_CPU_AUTOPROBE
> > +     select GENERIC_ENTRY
> >       select GENERIC_GETTIMEOFDAY
> >       select GENERIC_IOMAP
> >       select GENERIC_IRQ_PROBE
> > diff --git a/arch/mips/include/asm/entry-common.h b/arch/mips/include/asm/entry-common.h
> > new file mode 100644
> > index 000000000000..0fe2a098ded9
> > --- /dev/null
> > +++ b/arch/mips/include/asm/entry-common.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef ARCH_LOONGARCH_ENTRY_COMMON_H
> > +#define ARCH_LOONGARCH_ENTRY_COMMON_H
> Do you intend to say "MIPS"? ;-)

Hi, YunQiang, Xuerui,

Yes, I will fix it in the next version.

Thanks,
Feiyang

> > +
> > +#include <linux/sched.h>
> > +#include <linux/processor.h>
> > +
> > +static inline bool on_thread_stack(void)
> > +{
> > +     return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
> > +}
> > +
> > +#endif

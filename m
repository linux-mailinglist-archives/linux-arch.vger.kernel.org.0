Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C503EA340
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236656AbhHLLGD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhHLLGD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 07:06:03 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322FAC061765
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:05:38 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h18so6397067ilc.5
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAFM4aT86fS4YGd0kdfZQwovE8Fep+F94uf5suBU9mI=;
        b=Q6Rqzg2NqHAtLG6Q2JzlI8lQscgajUgHRDBGBUq03rcyBrXP7IHkT3YI3wZpAZMpoB
         TF8fcXYgRV72bmy9+ZY+AE4Q7jCl1uPX3uxh90pRHE0Dz6MdsZbIH87TQkMU3xPB9wRh
         jMcDZZTgUEYvu05wBqHU3S/lfyR7xpgUzl13F0q8hOKXtadp2IsHpx9ynGYDmDeqPh6b
         K7XKv/68+1L28RGAmEQ/8YsqaSd4jGUyoOMTdx9thCfii4i7KDburyZpXAQXBmi5Zwss
         Gaej872WQr96hlENz5/BL2tz5kO+HWkCVsXN7pFNwp5t/hLg8tA0xVibIF+lFqGnK4sw
         VOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAFM4aT86fS4YGd0kdfZQwovE8Fep+F94uf5suBU9mI=;
        b=Ix8VRI/suNi7uhPEwhwBe1dpxkNBLOfVnP4TgWmVN81D5beehFG+0UvjzDQVLBsOpB
         AAI+ymuFxr4T0iqnXgZGW/ncdb70VTkMU2/8rNd6FZtIztNk++vgTGoJBYAybMm0a3J3
         LTwmtM8QHWa5Jxp5fk51c1A67qAfJ1vwsdjbLK0alBmTOIz7IQtjwVWBNyHN12lonpy2
         tdNMJQv9WSHqPvb6j5vlfV1qr/S9M1lRD5P0dew12TXxvO9HbpIcnhXlm8vIwlQcaMxO
         C9DnAFQBjIVyceFy2i1ANPOsghrh+E4d+r5IYivfAMaVstEbLx7WuL6HVdjFOd4wR93P
         4LDw==
X-Gm-Message-State: AOAM533aMCrrbm3K6REBvR3hV9EcrKQ4Hupvm/003GMAxgkf/izFnZkn
        9d+FSX7I1bQA6jlRIhEuRronAUxIjF2bSFa/670=
X-Google-Smtp-Source: ABdhPJxpSdpCItosKJcn13YvPyxV1fkudP7tJE0ep+wwRtv6uSUL0F215p5QWwkfwJ9Qg55sQN43NaX1veZ3vjwcjPk=
X-Received: by 2002:a92:da0d:: with SMTP id z13mr2300201ilm.95.1628766337583;
 Thu, 12 Aug 2021 04:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
In-Reply-To: <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Aug 2021 19:05:25 +0800
Message-ID: <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com>
Subject: Re: [PATCH 04/19] LoongArch: Add common headers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Arnd,

On Tue, Jul 6, 2021 at 6:16 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
>  On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > This patch adds common headers for basic LoongArch support.
> >
>
> This patch is really too long to properly review, as it puts lots of
> unrelated headers
> into one commit. Please split it up into logical chunks, ideally
> together with the
> corresponding C files. Some obvious categories are:
>
> - memory management
> - atomics and locking
> - CPU register specifics
OK, thanks.

>
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/abi.h
> > @@ -0,0 +1,33 @@
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
> > +       int (* const setup_frame)(void *sig_return, struct ksignal *ksig,
> > +                                 struct pt_regs *regs, sigset_t *set);
> > +       int (* const setup_rt_frame)(void *sig_return, struct ksignal *ksig,
> > +                                    struct pt_regs *regs, sigset_t *set);
>
> I can see you copied this from mips, but I don't see why you would need it here.
> Can you just call the functions directly?
OK, thanks.

>
> > +/*
> > + * Return the bit position (0..63) of the most significant 1 bit in a word
> > + * Returns -1 if no 1 bit exists
> > + */
> > +static inline unsigned long __fls(unsigned long word)
> > +{
>
> Can you use the compiler builtins here? Since you know that you
> have a modern compiler, you can probably expect it to produce better
> output than the open-coded inline.
OK, we will use builtin functions.

>
> > diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
> > new file mode 100644
> > index 000000000000..aa9915a56f66
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/bootinfo.h
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_BOOTINFO_H
> > +#define _ASM_BOOTINFO_H
> > +
> > +#include <linux/types.h>
> > +#include <asm/setup.h>
> > +
> > +const char *get_system_type(void);
> > +
> > +extern void early_memblock_init(void);
> > +extern void detect_memory_region(phys_addr_t start, phys_addr_t sz_min,  phys_addr_t sz_max);
> > +
> > +extern void early_init(void);
> > +extern void platform_init(void);
> > +
> > +extern void free_init_pages(const char *what, unsigned long begin, unsigned long end);
> > +
> > +/*
> > + * Initial kernel command line, usually setup by fw_init_cmdline()
> > + */
> > +extern char arcs_cmdline[COMMAND_LINE_SIZE];
> > +
> > +/*
> > + * Registers a0, a1, a3 and a4 as passed to the kernel entry by firmware
> > + */
> > +extern unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
> > +
> > +extern unsigned long initrd_start, initrd_end;
> > +
> > +/*
> > + * Platform memory detection hook called by setup_arch
> > + */
> > +extern void plat_mem_setup(void);
>
> I think the platform specific options should all be removed and replaced
> with  a well-defined firmware interface, so remove get_system_type()/
> platform_init()/plat_mem_setup() etc.
OK, unneeded functions will be removed.

>
> > +
> > +static inline void check_bugs(void)
> > +{
> > +       unsigned int cpu = smp_processor_id();
> > +
> > +       cpu_data[cpu].udelay_val = loops_per_jiffy;
> > +}
>
> This needs a comment to explain what bug you are working around.
OK, there is "no bug" at present, just set the CPU0's udelay_val here.

>
> > diff --git a/arch/loongarch/include/asm/dma.h b/arch/loongarch/include/asm/dma.h
> > new file mode 100644
> > index 000000000000..a8a58dc93422
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/dma.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef __ASM_DMA_H
> > +#define __ASM_DMA_H
> > +
> > +#define MAX_DMA_ADDRESS        PAGE_OFFSET
> > +#define MAX_DMA32_PFN  (1UL << (32 - PAGE_SHIFT))
> > +
> > +extern int isa_dma_bridge_buggy;
> > +
> > +#endif
>
> Can you send a cleanup patch for this? I think we should get rid of the
> isa_dma_bridge_buggy variable for architectures that do not have a VIA
> VP2 style ISA bridge.
We doesn't need ISA, but isa_dma_bridge_buggy is needed in drivers/pci/pci.c

>
> > diff --git a/arch/loongarch/include/asm/dmi.h b/arch/loongarch/include/asm/dmi.h
> > new file mode 100644
> > index 000000000000..0fcfbba93363
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/dmi.h
> > @@ -0,0 +1,26 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_DMI_H
> > +#define _ASM_DMI_H
> > +
> > +#include <linux/io.h>
> > +#include <linux/memblock.h>
> > +
> > +#define dmi_early_remap                early_ioremap
> > +#define dmi_early_unmap                early_iounmap
> > +#define dmi_remap              dmi_ioremap
> > +#define dmi_unmap              dmi_iounmap
> > +#define dmi_alloc(l)           memblock_alloc_low(l, PAGE_SIZE)
> > +
> > +void __init __iomem *dmi_ioremap(u64 phys_addr, unsigned long size)
> > +{
> > +       return ((void *)TO_CAC(phys_addr));
> > +}
>
> This will cause a warning from sparse about a mismatched address space.
> Maybe check all of your sources with 'make C=1' to see what other warnings
> you missed.
OK, thanks.

>
> > diff --git a/arch/loongarch/include/asm/fw.h b/arch/loongarch/include/asm/fw.h
> > new file mode 100644
> > index 000000000000..8a0e8e7c625f
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/fw.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef __ASM_FW_H_
> > +#define __ASM_FW_H_
> > +
> > +#include <asm/bootinfo.h>
> > +
> > +extern int fw_argc;
> > +extern long *_fw_argv, *_fw_envp;
> > +
> > +#define fw_argv(index)         ((char *)(long)_fw_argv[(index)])
> > +#define fw_envp(index)         ((char *)(long)_fw_envp[(index)])
> > +
> > +extern void fw_init_cmdline(void);
> > +
> > +#endif /* __ASM_FW_H_ */
>
> You write that the system is booted using UEFI. Doesn't that mean you
> pass the command line in UEFI structures as well?
Unfortunately, we cannot discard cmdline completely. I have explained
in another mail.

>
> > +/*
> > + * Dummy values to fill the table in mmap.c
> > + * The real values will be generated at runtime
> > + * See setup_protection_map
> > + */
> > +#define __P000 __pgprot(0)
> > +#define __P001 __pgprot(0)
> > +#define __P010 __pgprot(0)
> > +#define __P011 __pgprot(0)
> > +#define __P100 __pgprot(0)
> > +#define __P101 __pgprot(0)
> > +#define __P110 __pgprot(0)
> > +#define __P111 __pgprot(0)
> > +
> > +#define __S000 __pgprot(0)
> > +#define __S001 __pgprot(0)
> > +#define __S010 __pgprot(0)
> > +#define __S011 __pgprot(0)
> > +#define __S100 __pgprot(0)
> > +#define __S101 __pgprot(0)
> > +#define __S110 __pgprot(0)
> > +#define __S111 __pgprot(0)
>
> Why does this have to be a runtime thing? If you only support one CPU
> implementation, are these not all constant?
OK, they should be constants.

>
> > +#ifdef CONFIG_64BIT
> > +#define TASK_SIZE32    0x80000000UL
>
> Why is the task size for compat tasks limited to 2GB? Shouldn't these
> be able to use the full 32-bit address space?
Because we use 2:2 to split user/kernel space.

>
> > +#ifdef CONFIG_VA_BITS_40
> > +#define TASK_SIZE64     (0x1UL << ((cpu_vabits > 40)?40:cpu_vabits))
> > +#endif
> > +#ifdef CONFIG_VA_BITS_48
> > +#define TASK_SIZE64     (0x1UL << ((cpu_vabits > 48)?48:cpu_vabits))
> > +#endif
>
> Why would the CPU have fewer VA bits than the page table layout allows?
PAGESIZE is configurable, so the range a PGD can cover is various, and
VA40/VA48 is not exactly 40bit/48bit, but 40bit/48bit in maximum.

>
> > diff --git a/arch/loongarch/include/asm/reg.h b/arch/loongarch/include/asm/reg.h
> > new file mode 100644
> > index 000000000000..8315e6fc8079
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/reg.h
> > @@ -0,0 +1,5 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#include <uapi/asm/reg.h>
>
> Empty files like this one should not be needed, since the uapi directory comes
> next in the search path.
OK, thanks.

>
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/spinlock.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_SPINLOCK_H
> > +#define _ASM_SPINLOCK_H
> > +
> > +#include <asm/processor.h>
> > +#include <asm/qspinlock.h>
> > +#include <asm/qrwlock.h>
> > +
> > +#endif /* _ASM_SPINLOCK_H */
>
> qspinlock is usually not ideal, unless you have large NUMA systems.
> As I see that the instruction set does not have the required 16-bit
> xchg() instruction that you emulate using a cmpxchg() loop, it seems
> likely that you cannot actually use qspinlock in a way that guarantees
> forward progress.
>
> We just had that discussion regarding risc-v qspinlock, see
> https://lore.kernel.org/linux-riscv/1616868399-82848-4-git-send-email-guoren@kernel.org/
> for Peter's explanations.
We have NUMA systems, so we need qspinlock. The xchg_small() copied
from MIPS has bugs, and we will fix that. This is discussed in other
mails.

>
> > +
> > +static inline cycles_t get_cycles(void)
> > +{
> > +       return drdtime();
> > +}
> > +
> > +static inline unsigned long random_get_entropy(void)
> > +{
> > +       return drdtime();
> > +}
> > +#endif /* __KERNEL__ */
>
> The second function here is not used since it's not a macro. Just remove
> it and use the identical default.
OK, thanks.

>
> > +/*
> > + * Subprogram calling convention
> > + */
> > +#define _LOONGARCH_SIM_ABILP32         1
> > +#define _LOONGARCH_SIM_ABILPX32                2
> > +#define _LOONGARCH_SIM_ABILP64         3
>
> What is the difference between ILP32 and ILPX32 here?
>
> What is the ILP64 support for, do you support both the regular LP64 and ILP64
> with 64-bit 'int'?
ABILP is ABI-LP, not AB-ILP. :). LP32 is native 32bit ABI, LP64 is
native 64bit ABI, and LPX32 something like MIPS N32/X86 X32 (not exist
in the near future).

>
>            Arnd

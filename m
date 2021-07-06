Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFAD3BCB05
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGFK5Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231391AbhGFK5P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 06:57:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3EF7619C6
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625568877;
        bh=a8XoYeL1ink1B4yW5DejXaFe5/RKEt2ZgIV/WyxsxDM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dCIHEwl4ZrNMq9cP+CzRek0UTQq4yMiqKE+lQ/qhnfMUBKh374vTgtLpAXYHyWf50
         ivvfYixILpNo+HUOiycFsw/ti2+4ySk1MyrFMGQm0kGDI9RBtho8aP4vymc+Fk/hqh
         DyxDl1DZRAgpC0vhummqyx+W3rgW5+YhkmiCgyTMeanJkpaAsFa40AWdURi+hpIe/b
         umpjQh3vbuOxjcRMTfRJbhmoJXfbtX6eExLW0FEpw7mDzuS6SQvtF778lajPsROhOr
         zqkYZN2CT+cKhC2g8nE2TSj/YVSWBJ2dURzRRXT4BDFdB6aLBnISQdRVChfX8I0Lc3
         PE+DKv9nZIlxA==
Received: by mail-wm1-f51.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso1930202wmj.4
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:54:36 -0700 (PDT)
X-Gm-Message-State: AOAM531SgRNAWUJiNAjG/t2D32GHM1MdZkXsRTv2R38SjQNKWxvLrLoo
        +xYSVCRjtlEh8Gc4pIP0O5lkEY/YwYgLi0nAjRg=
X-Google-Smtp-Source: ABdhPJztT8oYSrLyosVQWVyu2m5rdBaCbNAR7Urwu5T7484E1EUSqYPiVVV5P7Lcr4yAOXn+Kk8IghMwE2aL0fHWkQk=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr4136538wmb.142.1625568875479;
 Tue, 06 Jul 2021 03:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-5-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-5-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 12:54:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3a8RFN22peW7VZk5Tma8DLBbAHo5+cVFCoEWu7dc51LQ@mail.gmail.com>
Message-ID: <CAK8P3a3a8RFN22peW7VZk5Tma8DLBbAHo5+cVFCoEWu7dc51LQ@mail.gmail.com>
Subject: Re: [PATCH 04/19] LoongArch: Add common headers
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

 On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> This patch adds common headers for basic LoongArch support.
>

This patch is really too long to properly review, as it puts lots of
unrelated headers into one commit. Please split it up into logical
chunks, ideally together with the corresponding C files. Some obvious
categories are:

- memory management
- atomics and locking
- CPU register specifics

> --- /dev/null
> +++ b/arch/loongarch/include/asm/abi.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_ABI_H
> +#define _ASM_ABI_H
> +
> +#include <linux/signal_types.h>
> +
> +#include <asm/signal.h>
> +#include <asm/siginfo.h>
> +#include <asm/vdso.h>
> +
> +struct loongarch_abi {
> +       int (* const setup_frame)(void *sig_return, struct ksignal *ksig,
> +                                 struct pt_regs *regs, sigset_t *set);
> +       int (* const setup_rt_frame)(void *sig_return, struct ksignal *ksig,
> +                                    struct pt_regs *regs, sigset_t *set);

I can see you copied this from mips, but I don't see why you would need it here.
Can you just call the functions directly?

> +/*
> + * Return the bit position (0..63) of the most significant 1 bit in a word
> + * Returns -1 if no 1 bit exists
> + */
> +static inline unsigned long __fls(unsigned long word)
> +{

Can you use the compiler builtins here? Since you know that you
have a modern compiler, you can probably expect it to produce better
output than the open-coded inline.

> diff --git a/arch/loongarch/include/asm/bootinfo.h b/arch/loongarch/include/asm/bootinfo.h
> new file mode 100644
> index 000000000000..aa9915a56f66
> --- /dev/null
> +++ b/arch/loongarch/include/asm/bootinfo.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_BOOTINFO_H
> +#define _ASM_BOOTINFO_H
> +
> +#include <linux/types.h>
> +#include <asm/setup.h>
> +
> +const char *get_system_type(void);
> +
> +extern void early_memblock_init(void);
> +extern void detect_memory_region(phys_addr_t start, phys_addr_t sz_min,  phys_addr_t sz_max);
> +
> +extern void early_init(void);
> +extern void platform_init(void);
> +
> +extern void free_init_pages(const char *what, unsigned long begin, unsigned long end);
> +
> +/*
> + * Initial kernel command line, usually setup by fw_init_cmdline()
> + */
> +extern char arcs_cmdline[COMMAND_LINE_SIZE];
> +
> +/*
> + * Registers a0, a1, a3 and a4 as passed to the kernel entry by firmware
> + */
> +extern unsigned long fw_arg0, fw_arg1, fw_arg2, fw_arg3;
> +
> +extern unsigned long initrd_start, initrd_end;
> +
> +/*
> + * Platform memory detection hook called by setup_arch
> + */
> +extern void plat_mem_setup(void);

I think the platform specific options should all be removed and replaced
with  a well-defined firmware interface, so remove get_system_type()/
platform_init()/plat_mem_setup() etc.

> +
> +static inline void check_bugs(void)
> +{
> +       unsigned int cpu = smp_processor_id();
> +
> +       cpu_data[cpu].udelay_val = loops_per_jiffy;
> +}

This needs a comment to explain what bug you are working around.

> diff --git a/arch/loongarch/include/asm/dma.h b/arch/loongarch/include/asm/dma.h
> new file mode 100644
> index 000000000000..a8a58dc93422
> --- /dev/null
> +++ b/arch/loongarch/include/asm/dma.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_DMA_H
> +#define __ASM_DMA_H
> +
> +#define MAX_DMA_ADDRESS        PAGE_OFFSET
> +#define MAX_DMA32_PFN  (1UL << (32 - PAGE_SHIFT))
> +
> +extern int isa_dma_bridge_buggy;
> +
> +#endif

Can you send a cleanup patch for this? I think we should get rid of the
isa_dma_bridge_buggy variable for architectures that do not have a VIA
VP2 style ISA bridge.

> diff --git a/arch/loongarch/include/asm/dmi.h b/arch/loongarch/include/asm/dmi.h
> new file mode 100644
> index 000000000000..0fcfbba93363
> --- /dev/null
> +++ b/arch/loongarch/include/asm/dmi.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_DMI_H
> +#define _ASM_DMI_H
> +
> +#include <linux/io.h>
> +#include <linux/memblock.h>
> +
> +#define dmi_early_remap                early_ioremap
> +#define dmi_early_unmap                early_iounmap
> +#define dmi_remap              dmi_ioremap
> +#define dmi_unmap              dmi_iounmap
> +#define dmi_alloc(l)           memblock_alloc_low(l, PAGE_SIZE)
> +
> +void __init __iomem *dmi_ioremap(u64 phys_addr, unsigned long size)
> +{
> +       return ((void *)TO_CAC(phys_addr));
> +}

This will cause a warning from sparse about a mismatched address space.
Maybe check all of your sources with 'make C=1' to see what other warnings
you missed.

> diff --git a/arch/loongarch/include/asm/fw.h b/arch/loongarch/include/asm/fw.h
> new file mode 100644
> index 000000000000..8a0e8e7c625f
> --- /dev/null
> +++ b/arch/loongarch/include/asm/fw.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_FW_H_
> +#define __ASM_FW_H_
> +
> +#include <asm/bootinfo.h>
> +
> +extern int fw_argc;
> +extern long *_fw_argv, *_fw_envp;
> +
> +#define fw_argv(index)         ((char *)(long)_fw_argv[(index)])
> +#define fw_envp(index)         ((char *)(long)_fw_envp[(index)])
> +
> +extern void fw_init_cmdline(void);
> +
> +#endif /* __ASM_FW_H_ */

You write that the system is booted using UEFI. Doesn't that mean you
pass the command line in UEFI structures as well?

> +/*
> + * Dummy values to fill the table in mmap.c
> + * The real values will be generated at runtime
> + * See setup_protection_map
> + */
> +#define __P000 __pgprot(0)
> +#define __P001 __pgprot(0)
> +#define __P010 __pgprot(0)
> +#define __P011 __pgprot(0)
> +#define __P100 __pgprot(0)
> +#define __P101 __pgprot(0)
> +#define __P110 __pgprot(0)
> +#define __P111 __pgprot(0)
> +
> +#define __S000 __pgprot(0)
> +#define __S001 __pgprot(0)
> +#define __S010 __pgprot(0)
> +#define __S011 __pgprot(0)
> +#define __S100 __pgprot(0)
> +#define __S101 __pgprot(0)
> +#define __S110 __pgprot(0)
> +#define __S111 __pgprot(0)

Why does this have to be a runtime thing? If you only support one CPU
implementation, are these not all constant?

> +#ifdef CONFIG_64BIT
> +#define TASK_SIZE32    0x80000000UL

Why is the task size for compat tasks limited to 2GB? Shouldn't these
be able to use the full 32-bit address space?

> +#ifdef CONFIG_VA_BITS_40
> +#define TASK_SIZE64     (0x1UL << ((cpu_vabits > 40)?40:cpu_vabits))
> +#endif
> +#ifdef CONFIG_VA_BITS_48
> +#define TASK_SIZE64     (0x1UL << ((cpu_vabits > 48)?48:cpu_vabits))
> +#endif

Why would the CPU have fewer VA bits than the page table layout allows?

> diff --git a/arch/loongarch/include/asm/reg.h b/arch/loongarch/include/asm/reg.h
> new file mode 100644
> index 000000000000..8315e6fc8079
> --- /dev/null
> +++ b/arch/loongarch/include/asm/reg.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#include <uapi/asm/reg.h>

Empty files like this one should not be needed, since the uapi directory comes
next in the search path.

> --- /dev/null
> +++ b/arch/loongarch/include/asm/spinlock.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_SPINLOCK_H
> +#define _ASM_SPINLOCK_H
> +
> +#include <asm/processor.h>
> +#include <asm/qspinlock.h>
> +#include <asm/qrwlock.h>
> +
> +#endif /* _ASM_SPINLOCK_H */

qspinlock is usually not ideal, unless you have large NUMA systems.
As I see that the instruction set does not have the required 16-bit
xchg() instruction that you emulate using a cmpxchg() loop, it seems
likely that you cannot actually use qspinlock in a way that guarantees
forward progress.

We just had that discussion regarding risc-v qspinlock, see
https://lore.kernel.org/linux-riscv/1616868399-82848-4-git-send-email-guoren@kernel.org/
for Peter's explanations.

> +
> +static inline cycles_t get_cycles(void)
> +{
> +       return drdtime();
> +}
> +
> +static inline unsigned long random_get_entropy(void)
> +{
> +       return drdtime();
> +}
> +#endif /* __KERNEL__ */

The second function here is not used since it's not a macro. Just remove
it and use the identical default.

> +/*
> + * Subprogram calling convention
> + */
> +#define _LOONGARCH_SIM_ABILP32         1
> +#define _LOONGARCH_SIM_ABILPX32                2
> +#define _LOONGARCH_SIM_ABILP64         3

What is the difference between ILP32 and ILPX32 here?

What is the ILP64 support for, do you support both the regular LP64 and ILP64
with 64-bit 'int'?

           Arnd

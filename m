Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6787B3BC952
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhGFKTB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:19:01 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59629 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhGFKTB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:19:01 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MlO9r-1lKB682H1x-00lnx4 for <linux-arch@vger.kernel.org>; Tue, 06 Jul
 2021 12:16:21 +0200
Received: by mail-wr1-f49.google.com with SMTP id l5so8668043wrv.7
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:16:21 -0700 (PDT)
X-Gm-Message-State: AOAM5304HNJTdNKT4k4ppp600SgGsn7tJcMJVdzgnWOmBDD54iq7wcp6
        2U261Baq5oq4F4yp0rmyaCi0K2limESdG2+6a08=
X-Google-Smtp-Source: ABdhPJwQs8g+KLQdkLbgyvlmFgIu06RpJnD79xyk3AUa7A0R6GPrRkdfOeSfom4KWPA6s7Lnsx+nq+QoyW2a4YFqiSU=
X-Received: by 2002:adf:fd8e:: with SMTP id d14mr21694477wrr.361.1625566581157;
 Tue, 06 Jul 2021 03:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-5-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-5-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:16:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
Message-ID: <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:FBvyrSlLbsXNfDas/uSjkbuh64qmmuUYtqsIUuyKeRk2bolyMVc
 s3WjH+lLtqJfCreunB8wW8vwzwQnfMv/dNx2Rk0gcp74Y5iAsqK5WfteNXxz/6OyQlQnEVC
 7JopznZapwg7ejPSZCZkFBkNn/mci3d6fPpgd0sRAID2KNNnkg+bcC1zjv9GT01zoiWLV8p
 ttrmudsD3Vp2PbfEfhTqg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jQZI1dHY0M8=:3rTvuhPo2e4GjT7pkAXco2
 JkaUZYmWNOXYD4VagV4JHj5aAb8T8tJiVnqXDGbKlEFUbPFHZJrVT1hwRrjQy+ZIFcSTnL76+
 +DjqJQZ0v6vVntcL4DtGactsSkT2LscKqOR3tAnEkYvNb6yTApyBO5dyafhk+1KXJycEF6Ebn
 yBsbDNh6iNsTNMA7g76w+/MHIoF4+n0uKZt5EuSqZO/WpvtN9tdaVkTvLCarDx66vcztwFzFk
 T+xZ5sQMu1WLX/U+f/IwUJ2MQKngfFjcMHXc7R70PZeLTIFfi8MrgFtRs2JKK4xZnVVSDzO1E
 oUtTU2K8Z2uAHcSGsSm81WDJj1FVbxw8FTLjCkXouBQdgt7XkyJAVoA95y6v+AdUcWgXUMcD0
 FD3f4J3mrXXdvE/0hatKEwws4Kt+Ozo6u2nw4FcS1X7f07ra5gKH0F/uoztJwPSDrXgHqfO5r
 Ws4RIeBiESs3xKPgw9TfPLbv3G+A69dADNnBDBuWN/dhkr4BR3U0m9YrXwD9A65+8/KOODSYW
 yz6+bLpT3+lEfC52GdhNyCD1QgPmpSGxOP7sSz0uWL+6wfUDOEqqjdKAJA5t+CcCq6mu8UGU/
 BEA7PDzumxGphERITXtvJZOowyeyjZpcMybHxsvJzC6YO3LZXMk06YYdqS7mL5nZnoa4D/lY2
 uxqgcZODIXqDwbltcfllx577O572Yo+EEW7MaeQoNC1k/woK4cIO80+3IpqrWcIso+rDCPu6e
 wYnwPCzTW3QZ2GDlRBSzOXkBeN1gp4DdscQQ8hruDEvGUxCvf+faBSgSbSIlk1LFWxxPTkwqa
 SSh1HwM9cwl0HSGp1CJnMyC7NOMJu0HbR0EL+dk84tXGR1GuXnoQUbvBsgpWsGxm/aEUAAL+c
 XXu/0PTs/P8XVYIgcTIxXoq2kHJGudbutV2RuX5/gJWkQlSxg4jbqzTnexL9JoHXDxbUp+dBe
 OQuURMYI0JOfhwsi8Xm/YhwFJwQBB+IlNpf4Wr6yXG+EhqeiolhhF
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

 On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> This patch adds common headers for basic LoongArch support.
>

This patch is really too long to properly review, as it puts lots of
unrelated headers
into one commit. Please split it up into logical chunks, ideally
together with the
corresponding C files. Some obvious categories are:

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

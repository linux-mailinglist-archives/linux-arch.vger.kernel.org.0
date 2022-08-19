Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488D85998B5
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 11:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346896AbiHSJ3q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 05:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346238AbiHSJ3o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 05:29:44 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C58A0E1170;
        Fri, 19 Aug 2022 02:29:40 -0700 (PDT)
Received: from [192.168.20.136] (unknown [171.223.98.240])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_2v7V_9iCKAEAA--.20556S3;
        Fri, 19 Aug 2022 17:29:31 +0800 (CST)
Message-ID: <f9b12eed-a7a0-0f2b-4679-1f465e22cad6@loongson.cn>
Date:   Fri, 19 Aug 2022 17:29:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/9] LoongArch/ftrace: Add basic support
Content-Language: en-US
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20220819081403.7143-1-zhangqing@loongson.cn>
 <20220819081403.7143-2-zhangqing@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
In-Reply-To: <20220819081403.7143-2-zhangqing@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Dx_2v7V_9iCKAEAA--.20556S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JFyDWr1xCryfJF4fWw4fuFg_yoWfWFy8pF
        9ayFs7Gr4xGF4fKryS9r15Zrn8Ars3Wry2ga90qryFyFnFqrsxuw1IyryqqFZ7t3ykG3yI
        gFyfWr4akF4Yq37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUeLvtDUUUU
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Qing

On 2022/8/19 16:13, Qing Zhang wrote:

> This patch contains basic ftrace support for LoongArch.
> Specifically, function tracer (HAVE_FUNCTION_TRACER), function graph
> tracer (HAVE_FUNCTION_GRAPH_TRACER) are implemented following the
> instructions in Documentation/trace/ftrace-design.txt.
>
> Use `-pg` makes stub like a child function `void _mcount(void *ra)`.
> Thus, it can be seen store RA and open stack before `call _mcount`.
> Find `open stack` at first, and then find `store RA`
>
> Note that the functions in both inst.c and time.c should not be
> hooked with the compiler's -pg option: to prevent infinite self-
> referencing for the former, and to ignore early setup stuff for the
> latter.
>
> Co-developed-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>   arch/loongarch/Kconfig              |  2 +
>   arch/loongarch/Makefile             |  5 ++
>   arch/loongarch/include/asm/ftrace.h | 18 ++++++
>   arch/loongarch/kernel/Makefile      |  8 +++
>   arch/loongarch/kernel/ftrace.c      | 74 +++++++++++++++++++++++
>   arch/loongarch/kernel/mcount.S      | 94 +++++++++++++++++++++++++++++
>   6 files changed, 201 insertions(+)
>   create mode 100644 arch/loongarch/include/asm/ftrace.h
>   create mode 100644 arch/loongarch/kernel/ftrace.c
>   create mode 100644 arch/loongarch/kernel/mcount.S
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 4abc9a28aba4..703a2c3a8e0d 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -84,6 +84,8 @@ config LOONGARCH
>   	select HAVE_DMA_CONTIGUOUS
>   	select HAVE_EXIT_THREAD
>   	select HAVE_FAST_GUP
> +        select HAVE_FUNCTION_GRAPH_TRACER
> +        select HAVE_FUNCTION_TRACER
>   	select HAVE_GENERIC_VDSO
>   	select HAVE_IOREMAP_PROT
>   	select HAVE_IRQ_EXIT_ON_IRQ_STACK
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index ec3de6191276..44f11a2937e9 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -29,6 +29,11 @@ ifneq ($(SUBARCH),$(ARCH))
>     endif
>   endif
>   
> +ifdef CONFIG_DYNAMIC_FTRACE
> +  KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> +  CC_FLAGS_FTRACE := -fpatchable-function-entry=2
> +endif
> +

It seems this patch adds non-dynamic ftrace, this code should not
appear here.
BTW is it really necessary for non-dynamic ftrace? I do not use it
directly and frequently, IMHO, non-dynamic can be completely

replaced dynamic?


>   ifdef CONFIG_64BIT
>   ld-emul			= $(64bit-emul)
>   cflags-y		+= -mabi=lp64s
> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
> new file mode 100644
> index 000000000000..6a3e76234618
> --- /dev/null
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef _ASM_LOONGARCH_FTRACE_H
> +#define _ASM_LOONGARCH_FTRACE_H
> +
> +#ifdef CONFIG_FUNCTION_TRACER
> +#define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
> +
> +#ifndef __ASSEMBLY__
> +extern void _mcount(void);
> +#define mcount _mcount
> +
> +#endif /* __ASSEMBLY__ */
> +#endif /* CONFIG_FUNCTION_TRACER */
> +#endif /* _ASM_LOONGARCH_FTRACE_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index e5be17009fe8..0a745d24d3e5 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -14,6 +14,14 @@ obj-$(CONFIG_EFI) 		+= efi.o
>   
>   obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
>   
> +ifdef CONFIG_FUNCTION_TRACER
> +    obj-y += mcount.o ftrace.o
> +    CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
> +  CFLAGS_REMOVE_inst.o = $(CC_FLAGS_FTRACE)
> +  CFLAGS_REMOVE_time.o = $(CC_FLAGS_FTRACE)
> +  CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
> +endif
> +
>   obj-$(CONFIG_MODULES)		+= module.o module-sections.o
>   obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>   
> diff --git a/arch/loongarch/kernel/ftrace.c b/arch/loongarch/kernel/ftrace.c
> new file mode 100644
> index 000000000000..c8ddc5f11f32
> --- /dev/null
> +++ b/arch/loongarch/kernel/ftrace.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/uaccess.h>
> +#include <linux/init.h>
> +#include <linux/ftrace.h>
> +#include <linux/syscalls.h>
> +
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/cacheflush.h>
> +#include <asm/inst.h>
> +#include <asm/loongarch.h>
> +#include <asm/syscall.h>
> +#include <asm/unistd.h>
> +
> +#include <asm-generic/sections.h>
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +
> +/*
> + * As `call _mcount` follows LoongArch psABI, ra-saved operation and
> + * stack operation can be found before this insn.
> + */
> +
> +static int ftrace_get_parent_ra_addr(unsigned long insn_addr, int *ra_off)
> +{
> +	union loongarch_instruction *insn;
> +	int limit = 32;
> +
> +	insn = (union loongarch_instruction *)insn_addr;
> +
> +	do {
> +		insn--;
> +		limit--;
> +
> +		if (is_ra_save_ins(insn))
> +			*ra_off = -((1 << 12) - insn->reg2i12_format.immediate);
> +
> +	} while (!is_stack_alloc_ins(insn) && limit);
> +
> +	if (!limit)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +void prepare_ftrace_return(unsigned long self_addr,
> +		unsigned long callsite_sp, unsigned long old)
> +{
> +	int ra_off;
> +	unsigned long return_hooker = (unsigned long)&return_to_handler;
> +
> +	if (unlikely(ftrace_graph_is_dead()))
> +		return;
> +
> +	if (unlikely(atomic_read(&current->tracing_graph_pause)))
> +		return;
> +
> +	if (ftrace_get_parent_ra_addr(self_addr, &ra_off))
> +		goto out;
> +
> +	if (!function_graph_enter(old, self_addr, 0, NULL))
> +		*(unsigned long *)(callsite_sp + ra_off) = return_hooker;
> +
> +	return;
> +
> +out:
> +	ftrace_graph_stop();
> +	WARN_ON(1);
> +}
> +#endif	/* CONFIG_FUNCTION_GRAPH_TRACER */
> diff --git a/arch/loongarch/kernel/mcount.S b/arch/loongarch/kernel/mcount.S
> new file mode 100644
> index 000000000000..f1c1cc1a629e
> --- /dev/null
> +++ b/arch/loongarch/kernel/mcount.S
> @@ -0,0 +1,94 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * LoongArch specific _mcount support
> + *
> + * Copyright (C) 2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <asm/export.h>
> +#include <asm/regdef.h>
> +#include <asm/stackframe.h>
> +#include <asm/ftrace.h>
> +
> +	.text
> +
> +#define MCOUNT_STACK_SIZE	(2 * SZREG)
> +#define MCOUNT_S0_OFFSET	(0)
> +#define MCOUNT_RA_OFFSET	(SZREG)
> +
> +	.macro MCOUNT_SAVE_REGS
> +	PTR_ADDI sp, sp, -MCOUNT_STACK_SIZE
> +	PTR_S	s0, sp, MCOUNT_S0_OFFSET
> +	PTR_S	ra, sp, MCOUNT_RA_OFFSET
> +	move	s0, a0
> +	.endm
> +
> +	.macro MCOUNT_RESTORE_REGS
> +	move	a0, s0
> +	PTR_L	ra, sp, MCOUNT_RA_OFFSET
> +	PTR_L	s0, sp, MCOUNT_S0_OFFSET
> +	PTR_ADDI sp, sp, MCOUNT_STACK_SIZE
> +	.endm
> +
> +
> +SYM_FUNC_START(_mcount)
> +	la	t1, ftrace_stub
> +	la	t2, ftrace_trace_function	/* Prepare t2 for (1) */

'la.pcrel' is preferred here while 'la' should be deprecated.


> +	PTR_L	t2, t2, 0
> +	beq	t1, t2, fgraph_trace
> +
> +	MCOUNT_SAVE_REGS
> +
> +	move	a0, ra				/* arg0: self return address */
> +	move	a1, s0				/* arg1: parent's return address */
> +	jirl	ra, t2, 0			/* (1) call *ftrace_trace_function */
> +
> +	MCOUNT_RESTORE_REGS
> +
> +fgraph_trace:
> +#ifdef	CONFIG_FUNCTION_GRAPH_TRACER
> +	la	t1, ftrace_stub
> +	la	t3, ftrace_graph_return
> +	PTR_L	t3, t3, 0
> +	bne	t1, t3, ftrace_graph_caller
> +	la	t1, ftrace_graph_entry_stub
> +	la	t3, ftrace_graph_entry
> +	PTR_L	t3, t3, 0
> +	bne	t1, t3, ftrace_graph_caller
> +#endif
> +
> +	.globl ftrace_stub
> +ftrace_stub:
> +	jirl	zero, ra, 0
> +SYM_FUNC_END(_mcount)
> +EXPORT_SYMBOL(_mcount)
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +SYM_FUNC_START(ftrace_graph_caller)
> +	MCOUNT_SAVE_REGS
> +
> +	PTR_ADDI	a0, ra, -4			/* arg0: Callsite self return addr */
> +	PTR_ADDI	a1, sp, MCOUNT_STACK_SIZE	/* arg1: Callsite sp */
> +	move	a2, s0					/* arg2: Callsite parent ra */
> +	bl	prepare_ftrace_return
> +
> +	MCOUNT_RESTORE_REGS
> +	jirl	zero, ra, 0
We know Xuerui had done a lot works to keep asm code normalize.
So I think we should replace 'jirl zero,ra,0' with 'jr ra'. The basic

rule is use assembly macro as possible, I think.


Thanks,

Jinyang


> +SYM_FUNC_END(ftrace_graph_caller)
> +
> +SYM_FUNC_START(return_to_handler)
> +	PTR_ADDI sp, sp, -2 * SZREG
> +	PTR_S	a0, sp, 0
> +	PTR_S	a1, sp, SZREG
> +
> +	bl	ftrace_return_to_handler
> +
> +	/* restore the real parent address: a0 -> ra */
> +	move	ra, a0
> +
> +	PTR_L	a0, sp, 0
> +	PTR_L	a1, sp, SZREG
> +	PTR_ADDI	sp, sp, 2 * SZREG
> +	jirl	zero, ra, 0
> +SYM_FUNC_END(return_to_handler)
> +#endif /* CONFIG_FUNCTION_GRAPH_TRACER */


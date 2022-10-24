Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2415660ADB7
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbiJXOaj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 10:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbiJXO3D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 10:29:03 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CCA7D73D7;
        Mon, 24 Oct 2022 06:02:38 -0700 (PDT)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8Cxq9hQilZj9SMCAA--.8400S3;
        Mon, 24 Oct 2022 20:51:28 +0800 (CST)
Received: from [10.136.12.12] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLuJOilZjVGUEAA--.17007S3;
        Mon, 24 Oct 2022 20:51:28 +0800 (CST)
Subject: Re: [PATCH 1/2] LoongArch: Add alternative runtime patching mechanism
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Jun Yi <yijun@loongson.cn>
References: <20221024070438.306820-1-chenhuacai@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <adac75f5-e49e-0f63-c106-08c24050137f@loongson.cn>
Date:   Mon, 24 Oct 2022 20:51:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20221024070438.306820-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxLuJOilZjVGUEAA--.17007S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvAXoWfXw4UWr43Xw4fCw45Cw18Grg_yoW5JrW3Zo
        WSya1DKr1xJr42kFsrJas7ZFWjvanaqr4kA3y7Z398AFn7J34jk3W7Ka1Yq3W7tws5KrZ8
        G34Ig393Jay7AFn3n29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
        CTnIWIevJa73UjIFyTuYvjxU2MKZDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Huacai,


On 2022/10/24 下午3:04, Huacai Chen wrote:
> Introduce the "alternative" mechanism from ARM64 and x86 for LoongArch
> to apply runtime patching. The main purpose of this patch is to provide
> a framework. In future we can use this mechanism (i.e., the ALTERNATIVE
> and ALTERNATIVE_2 macros) to optimize hotspot functions according to cpu
> features.
>
> Signed-off-by: Jun Yi <yijun@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/alternative-asm.h |  82 ++++++
>   arch/loongarch/include/asm/alternative.h     | 176 ++++++++++++
>   arch/loongarch/include/asm/bugs.h            |  15 ++
>   arch/loongarch/include/asm/inst.h            |  10 +
>   arch/loongarch/kernel/Makefile               |   2 +-
>   arch/loongarch/kernel/alternative.c          | 266 +++++++++++++++++++
>   arch/loongarch/kernel/module.c               |  16 ++
>   arch/loongarch/kernel/setup.c                |   7 +
>   arch/loongarch/kernel/vmlinux.lds.S          |  12 +
>   9 files changed, 585 insertions(+), 1 deletion(-)
>   create mode 100644 arch/loongarch/include/asm/alternative-asm.h
>   create mode 100644 arch/loongarch/include/asm/alternative.h
>   create mode 100644 arch/loongarch/include/asm/bugs.h
>   create mode 100644 arch/loongarch/kernel/alternative.c
>
> diff --git a/arch/loongarch/include/asm/alternative-asm.h b/arch/loongarch/include/asm/alternative-asm.h
> new file mode 100644
> index 000000000000..f0f32ace29b1
> --- /dev/null
> +++ b/arch/loongarch/include/asm/alternative-asm.h
> @@ -0,0 +1,82 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ALTERNATIVE_ASM_H
> +#define _ASM_ALTERNATIVE_ASM_H
> +
> +#ifdef __ASSEMBLY__
> +
> +#include <asm/asm.h>
> +
> +/*
> + * Issue one struct alt_instr descriptor entry (need to put it into
> + * the section .altinstructions, see below). This entry contains
> + * enough information for the alternatives patching code to patch an
> + * instruction. See apply_alternatives().
> + */
> +.macro altinstruction_entry orig alt feature orig_len alt_len
> +	.long \orig - .
> +	.long \alt - .
> +	.2byte \feature
> +	.byte \orig_len
> +	.byte \alt_len
I tried '.byte 256' and gas warned but still finished compiling.
  " warning: value 0x0000000000000100 truncated to 0x0000000000000000 "
How about add '.if .error .endif' here to check the length.
> +.endm
> +
> +/*
> + * Define an alternative between two instructions. If @feature is
> + * present, early code in apply_alternatives() replaces @oldinstr with
> + * @newinstr. ".fill" directive takes care of proper instruction padding
> + * in case @newinstr is longer than @oldinstr.
> + */
> +.macro ALTERNATIVE oldinstr, newinstr, feature
> +140 :
> +	\oldinstr
> +141 :
> +	.fill - (((144f-143f)-(141b-140b)) > 0) * ((144f-143f)-(141b-140b)) / 4, 4, 0x03400000
> +142 :
> +
> +	.pushsection .altinstructions, "a"
> +	altinstruction_entry 140b, 143f, \feature, 142b-140b, 144f-143f
> +	.popsection
> +
> +	.subsection 1
> +143 :
> +	\newinstr
> +144 :
> +	.previous
> +.endm
> +
> +#define old_len			(141b-140b)
> +#define new_len1		(144f-143f)
> +#define new_len2		(145f-144f)
> +
> +#define alt_max_short(a, b)	((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
> +
> +/*
> + * Same as ALTERNATIVE macro above but for two alternatives. If CPU
> + * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
> + * @feature2, it replaces @oldinstr with @feature2.
> + */
> +.macro ALTERNATIVE_2 oldinstr, newinstr1, feature1, newinstr2, feature2
> +140 :
> +	\oldinstr
> +141 :
> +	.fill - ((alt_max_short(new_len1, new_len2) - (old_len)) > 0) * \
> +		(alt_max_short(new_len1, new_len2) - (old_len)) / 4, 4, 0x03400000
> +142 :
> +
> +	.pushsection .altinstructions, "a"
> +	altinstruction_entry 140b, 143f, \feature1, 142b-140b, 144f-143f, 142b-141b
> +	altinstruction_entry 140b, 144f, \feature2, 142b-140b, 145f-144f, 142b-141b
> +	.popsection
> +
> +	.subsection 1
> +143 :
> +	\newinstr1
> +144 :
> +	\newinstr2
> +145 :
> +	.previous
> +.endm
> +
> +#endif  /*  __ASSEMBLY__  */
> +
> +#endif /* _ASM_ALTERNATIVE_ASM_H */
> diff --git a/arch/loongarch/include/asm/alternative.h b/arch/loongarch/include/asm/alternative.h
> new file mode 100644
> index 000000000000..b4fe66c7067e
> --- /dev/null
> +++ b/arch/loongarch/include/asm/alternative.h
> @@ -0,0 +1,176 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ALTERNATIVE_H
> +#define _ASM_ALTERNATIVE_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/types.h>
> +#include <linux/stddef.h>
> +#include <linux/stringify.h>
> +#include <asm/asm.h>
> +
> +struct alt_instr {
> +	s32 instr_offset;	/* offset to original instruction */
> +	s32 replace_offset;	/* offset to replacement instruction */
> +	u16 feature;		/* feature bit set for replacement */
> +	u8  instrlen;		/* length of original instruction */
> +	u8  replacementlen;	/* length of new instruction */
> +} __packed;
> +
> +/*
> + * Debug flag that can be tested to see whether alternative
> + * instructions were patched in already:
> + */
> +extern int alternatives_patched;
> +extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
> +
> +extern void alternative_instructions(void);
> +extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
> +
> +#define b_replacement(num)	"664"#num
> +#define e_replacement(num)	"665"#num
> +
> +#define alt_end_marker		"663"
> +#define alt_slen		"662b-661b"
> +#define alt_total_slen		alt_end_marker"b-661b"
> +#define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
> +
> +#define __OLDINSTR(oldinstr, num)					\
> +	"661:\n\t" oldinstr "\n662:\n"					\
> +	".fill -(((" alt_rlen(num) ")-(" alt_slen ")) > 0) * "		\
> +		"((" alt_rlen(num) ")-(" alt_slen ")) / 4, 4, 0x03400000\n"
> +
> +#define OLDINSTR(oldinstr, num)						\
> +	__OLDINSTR(oldinstr, num)					\
> +	alt_end_marker ":\n"
> +
> +#define alt_max_short(a, b)	"((" a ") ^ (((" a ") ^ (" b ")) & -(-((" a ") < (" b ")))))"
> +
> +/*
> + * Pad the second replacement alternative with additional NOPs if it is
> + * additionally longer than the first replacement alternative.
> + */
> +#define OLDINSTR_2(oldinstr, num1, num2) \
> +	"661:\n\t" oldinstr "\n662:\n"								\
> +	".fill -((" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")) > 0) * "	\
> +		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")) / 4, "	\
> +		"4, 0x03400000\n"	\
> +	alt_end_marker ":\n"
> +
> +#define ALTINSTR_ENTRY(feature, num)					      \
> +	" .long 661b - .\n"				/* label           */ \
> +	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
> +	" .2byte " __stringify(feature) "\n"		/* feature bit     */ \
> +	" .byte " alt_total_slen "\n"			/* source len      */ \
> +	" .byte " alt_rlen(num) "\n"			/* replacement len */
> +
> +#define ALTINSTR_REPLACEMENT(newinstr, feature, num)	/* replacement */     \
> +	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n\t"
> +
> +/* alternative assembly primitive: */
> +#define ALTERNATIVE(oldinstr, newinstr, feature)			\
> +	OLDINSTR(oldinstr, 1)						\
> +	".pushsection .altinstructions,\"a\"\n"				\
> +	ALTINSTR_ENTRY(feature, 1)					\
> +	".popsection\n"							\
> +	".subsection 1\n" \
> +	ALTINSTR_REPLACEMENT(newinstr, feature, 1)			\
> +	".previous\n"
> +
> +#define ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2)\
> +	OLDINSTR_2(oldinstr, 1, 2)					\
> +	".pushsection .altinstructions,\"a\"\n"				\
> +	ALTINSTR_ENTRY(feature1, 1)					\
> +	ALTINSTR_ENTRY(feature2, 2)					\
> +	".popsection\n"							\
> +	".subsection 1\n" \
> +	ALTINSTR_REPLACEMENT(newinstr1, feature1, 1)			\
> +	ALTINSTR_REPLACEMENT(newinstr2, feature2, 2)			\
> +	".previous\n"
> +
> +/*
> + * Alternative instructions for different CPU types or capabilities.
> + *
> + * This allows to use optimized instructions even on generic binary
> + * kernels.
> + *
> + * length of oldinstr must be longer or equal the length of newinstr
> + * It can be padded with nops as needed.
> + *
> + * For non barrier like inlines please define new variants
> + * without volatile and memory clobber.
> + */
> +#define alternative(oldinstr, newinstr, feature)			\
> +	(asm volatile (ALTERNATIVE(oldinstr, newinstr, feature) : : : "memory"))
> +
> +#define alternative_2(oldinstr, newinstr1, feature1, newinstr2, feature2) \
> +	(asm volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1, newinstr2, feature2) ::: "memory"))
> +
> +/*
> + * Alternative inline assembly with input.
> + *
> + * Pecularities:
> + * No memory clobber here.
> + * Argument numbers start with 1.
> + * Best is to use constraints that are fixed size (like (%1) ... "r")
> + * If you use variable sized constraints like "m" or "g" in the
> + * replacement make sure to pad to the worst case length.
> + * Leaving an unused argument 0 to keep API compatibility.
> + */
> +#define alternative_input(oldinstr, newinstr, feature, input...)	\
> +	(asm volatile (ALTERNATIVE(oldinstr, newinstr, feature)		\
> +		: : "i" (0), ## input))
> +
> +/*
> + * This is similar to alternative_input. But it has two features and
> + * respective instructions.
> + *
> + * If CPU has feature2, newinstr2 is used.
> + * Otherwise, if CPU has feature1, newinstr1 is used.
> + * Otherwise, oldinstr is used.
> + */
> +#define alternative_input_2(oldinstr, newinstr1, feature1, newinstr2,	     \
> +			   feature2, input...)				     \
> +	(asm volatile(ALTERNATIVE_2(oldinstr, newinstr1, feature1,	     \
> +		newinstr2, feature2)					     \
> +		: : "i" (0), ## input))
> +
> +/* Like alternative_input, but with a single output argument */
> +#define alternative_io(oldinstr, newinstr, feature, output, input...)	\
> +	(asm volatile (ALTERNATIVE(oldinstr, newinstr, feature)		\
> +		: output : "i" (0), ## input))
> +
> +/* Like alternative_io, but for replacing a direct call with another one. */
> +#define alternative_call(oldfunc, newfunc, feature, output, input...)	\
> +	(asm volatile (ALTERNATIVE("call %P[old]", "call %P[new]", feature) \

Not 'call' but 'bl'? And IMHO it is better to separate these patches
to several patches and convenient for code review. Such as this patch,
the 'ALTERNATIVE_2' and 'C inline assembly' is not used in [patch2/2],
these features can be added after [patch2/2] or in the future.


> +		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input))
> +
> +/*
> + * Like alternative_call, but there are two features and respective functions.
> + * If CPU has feature2, function2 is used.
> + * Otherwise, if CPU has feature1, function1 is used.
> + * Otherwise, old function is used.
> + */
> +#define alternative_call_2(oldfunc, newfunc1, feature1, newfunc2, feature2,   \
> +			   output, input...)				      \
> +	(asm volatile (ALTERNATIVE_2("call %P[old]", "call %P[new1]", feature1,\
> +		"call %P[new2]", feature2)				      \
> +		: output, ASM_CALL_CONSTRAINT				      \
> +		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
> +		  [new2] "i" (newfunc2), ## input))
> +
> +/*
> + * use this macro(s) if you need more than one output parameter
> + * in alternative_io
> + */
> +#define ASM_OUTPUT2(a...) a
> +
> +/*
> + * use this macro if you need clobbers but no inputs in
> + * alternative_{input,io,call}()
> + */
> +#define ASM_NO_INPUT_CLOBBER(clbr...) "i" (0) : clbr
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ASM_ALTERNATIVE_H */
> diff --git a/arch/loongarch/include/asm/bugs.h b/arch/loongarch/include/asm/bugs.h
> new file mode 100644
> index 000000000000..651fffe1f743
> --- /dev/null
> +++ b/arch/loongarch/include/asm/bugs.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This is included by init/main.c to check for architecture-dependent bugs.
> + *
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_BUGS_H
> +#define _ASM_BUGS_H
> +
> +#include <asm/cpu.h>
> +#include <asm/cpu-info.h>
> +
> +extern void check_bugs(void);
> +
> +#endif /* _ASM_BUGS_H */
> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index 889d6c9fc2b6..bd4c116aa73d 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -8,6 +8,7 @@
>   #include <linux/types.h>
>   #include <asm/asm.h>
>   
> +#define INSN_NOP		0x03400000
>   #define INSN_BREAK		0x002a0000
>   
>   #define ADDR_IMMMASK_LU52ID	0xFFF0000000000000
> @@ -28,6 +29,7 @@ enum reg0i26_op {
>   enum reg1i20_op {
>   	lu12iw_op	= 0x0a,
>   	lu32id_op	= 0x0b,
> +	pcaddi_op	= 0x0c,
>   	pcaddu12i_op	= 0x0e,
>   	pcaddu18i_op	= 0x0f,
>   };
> @@ -35,6 +37,8 @@ enum reg1i20_op {
>   enum reg1i21_op {
>   	beqz_op		= 0x10,
>   	bnez_op		= 0x11,
> +	bceqz_op	= 0x12,
> +	bcnez_op	= 0x12,
>   };
>   
>   enum reg2_op {
> @@ -315,6 +319,12 @@ static inline bool is_imm_negative(unsigned long val, unsigned int bit)
>   	return val & (1UL << (bit - 1));
>   }
>   
> +static inline bool is_pc_ins(union loongarch_instruction *ip)
> +{
> +	return ip->reg1i20_format.opcode >= pcaddi_op &&
> +			ip->reg1i20_format.opcode <= pcaddu18i_op;
> +}
> +
>   static inline bool is_branch_ins(union loongarch_instruction *ip)
>   {
>   	return ip->reg1i21_format.opcode >= beqz_op &&
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
> index 2ad2555b53ea..86744531b100 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -8,7 +8,7 @@ extra-y		:= vmlinux.lds
>   obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
>   		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
>   		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
> -		   unaligned.o
> +		   alternative.o unaligned.o
>   
>   obj-$(CONFIG_ACPI)		+= acpi.o
>   obj-$(CONFIG_EFI) 		+= efi.o
> diff --git a/arch/loongarch/kernel/alternative.c b/arch/loongarch/kernel/alternative.c
> new file mode 100644
> index 000000000000..43434150b853
> --- /dev/null
> +++ b/arch/loongarch/kernel/alternative.c
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <asm/alternative.h>
> +#include <asm/cacheflush.h>
> +#include <asm/inst.h>
> +#include <asm/sections.h>
> +
> +int __read_mostly alternatives_patched;
> +
> +EXPORT_SYMBOL_GPL(alternatives_patched);
> +
> +#define MAX_PATCH_SIZE (((u8)(-1)) / LOONGARCH_INSN_SIZE)
> +
> +static int __initdata_or_module debug_alternative;
> +
> +static int __init debug_alt(char *str)
> +{
> +	debug_alternative = 1;
> +	return 1;
> +}
> +__setup("debug-alternative", debug_alt);
> +
> +#define DPRINTK(fmt, args...)						\
> +do {									\
> +	if (debug_alternative)						\
> +		printk(KERN_DEBUG "%s: " fmt "\n", __func__, ##args);	\
> +} while (0)
> +
> +#define DUMP_WORDS(buf, count, fmt, args...)				\
> +do {									\
> +	if (unlikely(debug_alternative)) {				\
> +		int _j;							\
> +		union loongarch_instruction *_buf = buf;		\
> +									\
> +		if (!(count))						\
> +			break;						\
> +									\
> +		printk(KERN_DEBUG fmt, ##args);				\
> +		for (_j = 0; _j < count - 1; _j++)			\
> +			printk(KERN_CONT "<%08x> ", _buf[_j].word);	\
> +		printk(KERN_CONT "<%08x>\n", _buf[_j].word);		\
> +	}								\
> +} while (0)
> +
> +#define __SIGNEX(X, SIDX) ((X) >= (1 << SIDX) ? ~((1 << SIDX) - 1) | (X) : (X))
> +#define SIGNEX16(X) __SIGNEX(((unsigned long)(X)), 15)
> +#define SIGNEX20(X) __SIGNEX(((unsigned long)(X)), 19)
> +#define SIGNEX21(X) __SIGNEX(((unsigned long)(X)), 20)
> +#define SIGNEX26(X) __SIGNEX(((unsigned long)(X)), 25)
> +
> +static inline unsigned long bs_dest_16(unsigned long now, unsigned int si)
> +{
> +	return now + (SIGNEX16(si) << 2);
> +}
> +
> +static inline unsigned long bs_dest_21(unsigned long now, unsigned int h, unsigned int l)
> +{
> +	return now + (SIGNEX21(h << 16 | l) << 2);
> +}
> +
> +static inline unsigned long bs_dest_26(unsigned long now, unsigned int h, unsigned int l)
> +{
> +	return now + (SIGNEX26(h << 16 | l) << 2);
> +}
> +
> +/* Use this to add nops to a buffer, then text_poke the whole buffer. */
> +static void __init_or_module add_nops(union loongarch_instruction *insn, int count)
> +{
> +	while (count--) {
> +		insn->word = INSN_NOP;
> +		insn++;
> +	}
> +}
> +
> +/* Is the jump addr in local .altinstructions */
> +static inline bool in_alt_jump(unsigned long jump, void *start, void *end)
> +{
> +	return jump >= (unsigned long)start && jump < (unsigned long)end;
> +}
> +
> +static void __init_or_module recompute_jump(union loongarch_instruction *buf,
> +		union loongarch_instruction *dest, union loongarch_instruction *src,
> +		void *start, void *end)
> +{
> +	unsigned int si, si_l, si_h;
> +	unsigned long cur_pc, jump_addr, pc;
> +	long offset;
> +
> +	cur_pc = (unsigned long)src;
> +	pc = (unsigned long)dest;
> +
> +	si_l = src->reg0i26_format.immediate_l;
> +	si_h = src->reg0i26_format.immediate_h;
> +	switch (src->reg0i26_format.opcode) {
> +	case b_op:
> +	case bl_op:
> +		jump_addr = bs_dest_26(cur_pc, si_h, si_l);
> +		if (in_alt_jump(jump_addr, start, end))
> +			return;
> +		offset = jump_addr - pc;
> +		BUG_ON(offset < -SZ_128M || offset >= SZ_128M);
> +		offset >>= 2;
> +		buf->reg0i26_format.immediate_h = offset >> 16;
> +		buf->reg0i26_format.immediate_l = offset;
> +		return;
> +	}
> +
> +	si_l = src->reg1i21_format.immediate_l;
> +	si_h = src->reg1i21_format.immediate_h;
> +	switch (src->reg1i21_format.opcode) {
> +	case beqz_op:
> +	case bnez_op:
> +	case bceqz_op:
> +		jump_addr = bs_dest_21(cur_pc, si_h, si_l);
> +		if (in_alt_jump(jump_addr, start, end))
> +			return;
> +		offset = jump_addr - pc;
> +		BUG_ON(offset < -SZ_4M || offset >= SZ_4M);
> +		offset >>= 2;
> +		buf->reg1i21_format.immediate_h = offset >> 16;
> +		buf->reg1i21_format.immediate_l = offset;
> +		return;
> +	}
> +
> +	si = src->reg2i16_format.immediate;
> +	switch (src->reg2i16_format.opcode) {
> +	case beq_op:
> +	case bne_op:
> +	case blt_op:
> +	case bge_op:
> +	case bltu_op:
> +	case bgeu_op:
> +		jump_addr = bs_dest_16(cur_pc, si);
> +		if (in_alt_jump(jump_addr, start, end))
> +			return;
> +		offset = jump_addr - pc;
> +		BUG_ON(offset < -SZ_128K || offset >= SZ_128K);
> +		offset >>= 2;
> +                buf->reg2i16_format.immediate = offset;

code indent should use tabs where possible


> +		return;
> +	}
> +}
> +
> +static int __init_or_module copy_alt_insns(union loongarch_instruction *buf,
> +	union loongarch_instruction *dest, union loongarch_instruction *src, int nr)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr; i++) {
> +		buf[i].word = src[i].word;
> +
> +		if (is_branch_ins(&src[i]) &&
> +		    src[i].reg2i16_format.opcode != jirl_op) {
> +			recompute_jump(&buf[i], &dest[i], &src[i], src, src + nr);
> +		} else if (is_pc_ins(&src[i])) {
> +			pr_err("Not support pcrel instruction at present!");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * text_poke_early - Update instructions on a live kernel at boot time
> + *
> + * When you use this code to patch more than one byte of an instruction
> + * you need to make sure that other CPUs cannot execute this code in parallel.
> + * Also no thread must be currently preempted in the middle of these
> + * instructions. And on the local CPU you need to be protected again NMI or MCE
> + * handlers seeing an inconsistent instruction while you patch.
> + */
> +static void *__init_or_module text_poke_early(union loongarch_instruction *insn,
> +			      union loongarch_instruction *buf, unsigned int nr)
> +{
> +	int i;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +
> +	for (i = 0; i < nr; i++)
> +		insn[i].word = buf[i].word;
> +
> +	local_irq_restore(flags);
> +
> +	wbflush();
> +	flush_icache_range((unsigned long)insn, (unsigned long)(insn + nr));

nr * LOONGARCH_INSN_SIZE


Thanks,

Jinyang


> +
> +	return insn;
> +}
> +
> +/*
> + * Replace instructions with better alternatives for this CPU type. This runs
> + * before SMP is initialized to avoid SMP problems with self modifying code.
> + * This implies that asymmetric systems where APs have less capabilities than
> + * the boot processor are not handled. Tough. Make sure you disable such
> + * features by hand.
> + */
> +void __init_or_module apply_alternatives(struct alt_instr *start, struct alt_instr *end)
> +{
> +	struct alt_instr *a;
> +	unsigned int nr_instr, nr_repl, nr_insnbuf;
> +	union loongarch_instruction *instr, *replacement;
> +	union loongarch_instruction insnbuf[MAX_PATCH_SIZE];
> +
> +	DPRINTK("alt table %px, -> %px", start, end);
> +	/*
> +	 * The scan order should be from start to end. A later scanned
> +	 * alternative code can overwrite previously scanned alternative code.
> +	 * Some kernel functions (e.g. memcpy, memset, etc) use this order to
> +	 * patch code.
> +	 *
> +	 * So be careful if you want to change the scan order to any other
> +	 * order.
> +	 */
> +	for (a = start; a < end; a++) {
> +		nr_insnbuf = 0;
> +
> +		instr = (void *)&a->instr_offset + a->instr_offset;
> +		replacement = (void *)&a->replace_offset + a->replace_offset;
> +
> +		BUG_ON(a->instrlen > sizeof(insnbuf));
> +		BUG_ON(a->instrlen & 0x3);
> +		BUG_ON(a->replacementlen & 0x3);
> +
> +		nr_instr = a->instrlen / LOONGARCH_INSN_SIZE;
> +		nr_repl = a->replacementlen / LOONGARCH_INSN_SIZE;
> +
> +		if (!cpu_has(a->feature)) {
> +			DPRINTK("feat not exist: %d, old: (%px len: %d), repl: (%px, len: %d)",
> +				a->feature, instr, a->instrlen,
> +				replacement, a->replacementlen);
> +
> +			continue;
> +		}
> +
> +		DPRINTK("feat: %d, old: (%px len: %d), repl: (%px, len: %d)",
> +			a->feature, instr, a->instrlen,
> +			replacement, a->replacementlen);
> +
> +		DUMP_WORDS(instr, nr_instr, "%px: old_insn: ", instr);
> +		DUMP_WORDS(replacement, nr_repl, "%px: rpl_insn: ", replacement);
> +
> +		copy_alt_insns(insnbuf, instr, replacement, nr_repl);
> +		nr_insnbuf = nr_repl;
> +
> +		if (nr_instr > nr_repl) {
> +			add_nops(insnbuf + nr_repl, nr_instr - nr_repl);
> +			nr_insnbuf += nr_instr - nr_repl;
> +		}
> +		DUMP_WORDS(insnbuf, nr_insnbuf, "%px: final_insn: ", instr);
> +
> +		text_poke_early(instr, insnbuf, nr_insnbuf);
> +	}
> +}
> +
> +void __init alternative_instructions(void)
> +{
> +	apply_alternatives(__alt_instructions, __alt_instructions_end);
> +
> +	alternatives_patched = 1;
> +}
> diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
> index 097595b2fc14..669e750917a3 100644
> --- a/arch/loongarch/kernel/module.c
> +++ b/arch/loongarch/kernel/module.c
> @@ -17,6 +17,7 @@
>   #include <linux/fs.h>
>   #include <linux/string.h>
>   #include <linux/kernel.h>
> +#include <asm/alternative.h>
>   
>   static int rela_stack_push(s64 stack_value, s64 *rela_stack, size_t *rela_stack_top)
>   {
> @@ -456,3 +457,18 @@ void *module_alloc(unsigned long size)
>   	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
>   			GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE, __builtin_return_address(0));
>   }
> +
> +int module_finalize(const Elf_Ehdr *hdr,
> +		    const Elf_Shdr *sechdrs,
> +		    struct module *mod)
> +{
> +	const Elf_Shdr *s, *se;
> +	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
> +
> +	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++) {
> +		if (!strcmp(".altinstructions", secstrs + s->sh_name))
> +			apply_alternatives((void *)s->sh_addr, (void *)s->sh_addr + s->sh_size);
> +	}
> +
> +	return 0;
> +}
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index 1eb63fa9bc81..96b6cb5db004 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -31,7 +31,9 @@
>   #include <linux/swiotlb.h>
>   
>   #include <asm/addrspace.h>
> +#include <asm/alternative.h>
>   #include <asm/bootinfo.h>
> +#include <asm/bugs.h>
>   #include <asm/cache.h>
>   #include <asm/cpu.h>
>   #include <asm/dma.h>
> @@ -80,6 +82,11 @@ const char *get_system_type(void)
>   	return "generic-loongson-machine";
>   }
>   
> +void __init check_bugs(void)
> +{
> +	alternative_instructions();
> +}
> +
>   static const char *dmi_string_parse(const struct dmi_header *dm, u8 s)
>   {
>   	const u8 *bp = ((u8 *) dm) + dm->length;
> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
> index efecda0c2361..733b16e8d55d 100644
> --- a/arch/loongarch/kernel/vmlinux.lds.S
> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> @@ -54,6 +54,18 @@ SECTIONS
>   	. = ALIGN(PECOFF_SEGMENT_ALIGN);
>   	_etext = .;
>   
> +	/*
> +	 * struct alt_inst entries. From the header (alternative.h):
> +	 * "Alternative instructions for different CPU types or capabilities"
> +	 * Think locking instructions on spinlocks.
> +	 */
> +	. = ALIGN(4);
> +	.altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
> +		__alt_instructions = .;
> +		*(.altinstructions)
> +		__alt_instructions_end = .;
> +	}
> +
>   	.got : ALIGN(16) { *(.got) }
>   	.plt : ALIGN(16) { *(.plt) }
>   	.got.plt : ALIGN(16) { *(.got.plt) }


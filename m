Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A94459F103
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2019 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfH0RAS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Aug 2019 13:00:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35744 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbfH0RAS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Aug 2019 13:00:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so13034027pgv.2;
        Tue, 27 Aug 2019 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:cc:to:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hDd6iw4bLUDQFc0kTFBFimM6kogglYtS9D/zlMO40jQ=;
        b=fecYKUMcr2lWhczaKZ6WWGGUNipPtgLln9yhVlj8ZZ/D52ZAcIf3EBIyCuRDxGReLa
         Rr/z0S+YdJntl2XNI4yVvb0AzrwVp1b1OBTycuUpOqRaSufOXCRfnZr+BoaMRDQlAy6u
         0kodVct3Z3HfvoujH+qLSpkGRMSDEa4rd+Mu4GzUecBSt97h7pVlx58YHV0QSirmSXIy
         +M3i4UvZgwxt5sagj2JHIFH40IRtw35bkSJr7QJInRZKCXp1XNo9pR3oPRAJWmMXHyBI
         2Auo+li3yEvivUPoKaC26GdgQB0UmInv4xganhdjMlrt6MZ7Y/IYa0OQcEbSmo99hd+W
         1WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:cc:to:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hDd6iw4bLUDQFc0kTFBFimM6kogglYtS9D/zlMO40jQ=;
        b=r81aKnLOSYutQfLkW6h/8faCh5/lT7wqBWP5lPjPSDa4CklXf71QhewgMTfjqEgb/a
         BrTtaRrL8aTzwGVI3M8yfXqhqtOdDodBUWOLL5gTsOUbldhi7fAWCl9fB1ng80Q2jovO
         05Ku9KC5lyujSc7O/0VtCg4BLzTWiiBOA8fMXb6aYn7oIkZxsDriv7kVlN6mOMP7tZvg
         hrbInAVMooBWsEUnfUT+WrYI2S/qwIoStrOxsyqL13iNe1t4FyUra3uCOC1ka0Mldahw
         VP6GakcSY7SiSH4Chz8sCh4EIxdrcatGyELwcmFU9tkUHtnIJv4w5e1bkMHP9E888QXt
         GnTA==
X-Gm-Message-State: APjAAAXfeV5VMS9NeLTGaYl9pvjMfqxxd0nO6bif5yoW76WmoNufnzNw
        MuqKpGW6vm7qwrEQvN246m8=
X-Google-Smtp-Source: APXvYqwOvVFXtXcMKjZHGBmNGRuamvgd5totRbEqTgHdmzrlFgmoal0d2leX5iNbhmpltTka/HzI1g==
X-Received: by 2002:a63:7e1d:: with SMTP id z29mr22269630pgc.346.1566925217121;
        Tue, 27 Aug 2019 10:00:17 -0700 (PDT)
Received: from ?IPv6:2601:641:c100:83a0:7543:d89b:60ad:490f? ([2601:641:c100:83a0:7543:d89b:60ad:490f])
        by smtp.gmail.com with ESMTPSA id 97sm2894116pjz.12.2019.08.27.10.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 10:00:16 -0700 (PDT)
Subject: Re: [PATCH v2] ARC: ARCv2: jump label: implement jump label patching
References: <20190718132011.3363-1-Eugeniy.Paltsev@synopsys.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.COM>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
From:   Vineet Gupta <vineetg76@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 mQINBFEffBMBEADIXSn0fEQcM8GPYFZyvBrY8456hGplRnLLFimPi/BBGFA24IR+B/Vh/EFk
 B5LAyKuPEEbR3WSVB1x7TovwEErPWKmhHFbyugdCKDv7qWVj7pOB+vqycTG3i16eixB69row
 lDkZ2RQyy1i/wOtHt8Kr69V9aMOIVIlBNjx5vNOjxfOLux3C0SRl1veA8sdkoSACY3McOqJ8
 zR8q1mZDRHCfz+aNxgmVIVFN2JY29zBNOeCzNL1b6ndjU73whH/1hd9YMx2Sp149T8MBpkuQ
 cFYUPYm8Mn0dQ5PHAide+D3iKCHMupX0ux1Y6g7Ym9jhVtxq3OdUI5I5vsED7NgV9c8++baM
 7j7ext5v0l8UeulHfj4LglTaJIvwbUrCGgtyS9haKlUHbmey/af1j0sTrGxZs1ky1cTX7yeF
 nSYs12GRiVZkh/Pf3nRLkjV+kH++ZtR1GZLqwamiYZhAHjo1Vzyl50JT9EuX07/XTyq/Bx6E
 dcJWr79ZphJ+mR2HrMdvZo3VSpXEgjROpYlD4GKUApFxW6RrZkvMzuR2bqi48FThXKhFXJBd
 JiTfiO8tpXaHg/yh/V9vNQqdu7KmZIuZ0EdeZHoXe+8lxoNyQPcPSj7LcmE6gONJR8ZqAzyk
 F5voeRIy005ZmJJ3VOH3Gw6Gz49LVy7Kz72yo1IPHZJNpSV5xwARAQABtCpWaW5lZXQgR3Vw
 dGEgKGFsaWFzKSA8dmd1cHRhQHN5bm9wc3lzLmNvbT6JAj4EEwECACgCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheABQJbBYpwBQkLx0HcAAoJEGnX8d3iisJeChAQAMR2UVbJyydOv3aV
 jmqP47gVFq4Qml1weP5z6czl1I8n37bIhdW0/lV2Zll+yU1YGpMgdDTHiDqnGWi4pJeu4+c5
 xsI/VqkH6WWXpfruhDsbJ3IJQ46//jb79ogjm6VVeGlOOYxx/G/RUUXZ12+CMPQo7Bv+Jb+t
 NJnYXYMND2Dlr2TiRahFeeQo8uFbeEdJGDsSIbkOV0jzrYUAPeBwdN8N0eOB19KUgPqPAC4W
 HCg2LJ/o6/BImN7bhEFDFu7gTT0nqFVZNXlOw4UcGGpM3dq/qu8ZgRE0turY9SsjKsJYKvg4
 djAaOh7H9NJK72JOjUhXY/sMBwW5vnNwFyXCB5t4ZcNxStoxrMtyf35synJVinFy6wCzH3eJ
 XYNfFsv4gjF3l9VYmGEJeI8JG/ljYQVjsQxcrU1lf8lfARuNkleUL8Y3rtxn6eZVtAlJE8q2
 hBgu/RUj79BKnWEPFmxfKsaj8of+5wubTkP0I5tXh0akKZlVwQ3lbDdHxznejcVCwyjXBSny
 d0+qKIXX1eMh0/5sDYM06/B34rQyq9HZVVPRHdvsfwCU0s3G+5Fai02mK68okr8TECOzqZtG
 cuQmkAeegdY70Bpzfbwxo45WWQq8dSRURA7KDeY5LutMphQPIP2syqgIaiEatHgwetyVCOt6
 tf3ClCidHNaGky9KcNSQ
Message-ID: <b7515cf7-c21c-19aa-ced6-96ddfccc580c@gmail.com>
Date:   Tue, 27 Aug 2019 10:00:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190718132011.3363-1-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/18/19 6:20 AM, Eugeniy Paltsev wrote:
> Implement jump label patching for ARC. Jump labels provide
> an interface to generate dynamic branches using
> self-modifying code.
> 
> This allows us to implement conditional branches where
> changing branch direction is expensive but branch selection
> is basically 'free'
> 
> This implementation uses 32-bit NOP and BRANCH instructions
> which forced to be aligned by 4 to guarantee that they don't
> cross L1 I$ cache fetch block and can be update atomically.

I've discussed this with hardware folks, and it seems fetch block size is
irrelevant. We need to make sure this doesn't straddle cache line.

Please respin !

Thx,
-Vineet

> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
> Changes v1->v2:
>  * Patched instruction should not cross L1 I$ fetch block boundary and
>    not only L1 I$ line. Fix comments and asserts in code.
>  * Other small comments fix and code cleanup.
> 
>  arch/arc/Kconfig                  |   8 ++
>  arch/arc/include/asm/cache.h      |  11 ++
>  arch/arc/include/asm/jump_label.h |  71 +++++++++++++
>  arch/arc/kernel/Makefile          |   1 +
>  arch/arc/kernel/jump_label.c      | 167 ++++++++++++++++++++++++++++++
>  5 files changed, 258 insertions(+)
>  create mode 100644 arch/arc/include/asm/jump_label.h
>  create mode 100644 arch/arc/kernel/jump_label.c
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 1c8137e7247b..f9657c86c3e1 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -44,6 +44,7 @@ config ARC
>  	select OF_EARLY_FLATTREE
>  	select PCI_SYSCALL if PCI
>  	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING
> +	select HAVE_ARCH_JUMP_LABEL if ISA_ARCV2 && !CPU_ENDIAN_BE32
>  
>  config ARCH_HAS_CACHE_LINE_SIZE
>  	def_bool y
> @@ -523,6 +524,13 @@ config ARC_DW2_UNWIND
>  config ARC_DBG_TLB_PARANOIA
>  	bool "Paranoia Checks in Low Level TLB Handlers"
>  
> +config ARC_DBG_JUMP_LABEL
> +	bool "Paranoid checks in Static Keys (jump labels) code"
> +	depends on JUMP_LABEL
> +	select STATIC_KEYS_SELFTEST
> +	help
> +	  Enable paranoid checks and self-test of both ARC-specific and generic
> +	  part of static keys (jump labels) related code.
>  endif
>  
>  config ARC_BUILTIN_DTB_NAME
> diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
> index 918804c7c1a4..46d4f673609a 100644
> --- a/arch/arc/include/asm/cache.h
> +++ b/arch/arc/include/asm/cache.h
> @@ -16,6 +16,11 @@
>  #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
>  #define CACHE_LINE_MASK		(~(L1_CACHE_BYTES - 1))
>  
> +#ifdef CONFIG_ISA_ARCV2
> +/* instruction_fetch_block_width is same for all ARCv2 */
> +#define I_CACHE_FETCH_BLOCK_WIDTH	16
> +#endif
> +
>  /*
>   * ARC700 doesn't cache any access in top 1G (0xc000_0000 to 0xFFFF_FFFF)
>   * Ideal for wiring memory mapped peripherals as we don't need to do
> @@ -25,6 +30,12 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <linux/build_bug.h>
> +
> +#ifdef CONFIG_ISA_ARCV2
> +static_assert(I_CACHE_FETCH_BLOCK_WIDTH <= L1_CACHE_BYTES);
> +#endif
> +
>  /* Uncached access macros */
>  #define arc_read_uncached_32(ptr)	\
>  ({					\
> diff --git a/arch/arc/include/asm/jump_label.h b/arch/arc/include/asm/jump_label.h
> new file mode 100644
> index 000000000000..0de7833b2071
> --- /dev/null
> +++ b/arch/arc/include/asm/jump_label.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARC_JUMP_LABEL_H
> +#define _ASM_ARC_JUMP_LABEL_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/types.h>
> +
> +#define JUMP_LABEL_NOP_SIZE 4
> +
> +/*
> + * NOTE about '.balign 4':
> + *
> + * To make atomic update of patched instruction available we need to guarantee
> + * that this instruction doesn't cross L1 I$ fetch block boundary (it's
> + * smaller than L1 I$ line size).
> + *
> + * As of today we simply align instruction which can be patched by 4 byte using
> + * ".balign 4" directive. In that case patched instruction is aligned with one
> + * 16-bit NOP_S if this is required.
> + * However 'align by 4' directive is much stricter than it actually required.
> + * It's enough that our 32-bit instruction don't cross L1 I$ fetch block
> + * boundary which can be achieved by using ".bundle_align_mode" directive.
> + * That will save us from adding useless NOP_S padding in most of the cases.
> + *
> + * TODO: switch to ".bundle_align_mode" directive using whin it will be
> + * supported by ARC toolchain.
> + */
> +
> +static __always_inline bool arch_static_branch(struct static_key *key,
> +					       bool branch)
> +{
> +	asm_volatile_goto(".balign 4			\n"
> +		 "1:					\n"
> +		 "nop					\n"
> +		 ".pushsection __jump_table, \"aw\"	\n"
> +		 ".word 1b, %l[l_yes], %c0		\n"
> +		 ".popsection				\n"
> +		 : : "i" (&((char *)key)[branch]) : : l_yes);
> +
> +	return false;
> +l_yes:
> +	return true;
> +}
> +
> +static __always_inline bool arch_static_branch_jump(struct static_key *key,
> +						    bool branch)
> +{
> +	asm_volatile_goto(".balign 4			\n"
> +		 "1:					\n"
> +		 "b %l[l_yes]				\n"
> +		 ".pushsection __jump_table, \"aw\"	\n"
> +		 ".word 1b, %l[l_yes], %c0		\n"
> +		 ".popsection				\n"
> +		 : : "i" (&((char *)key)[branch]) : : l_yes);
> +
> +	return false;
> +l_yes:
> +	return true;
> +}
> +
> +typedef u32 jump_label_t;
> +
> +struct jump_entry {
> +	jump_label_t code;
> +	jump_label_t target;
> +	jump_label_t key;
> +};
> +
> +#endif  /* __ASSEMBLY__ */
> +#endif
> diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile
> index de6251132310..e784f5396dda 100644
> --- a/arch/arc/kernel/Makefile
> +++ b/arch/arc/kernel/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_ARC_EMUL_UNALIGNED) 	+= unaligned.o
>  obj-$(CONFIG_KGDB)			+= kgdb.o
>  obj-$(CONFIG_ARC_METAWARE_HLINK)	+= arc_hostlink.o
>  obj-$(CONFIG_PERF_EVENTS)		+= perf_event.o
> +obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
>  
>  obj-$(CONFIG_ARC_FPU_SAVE_RESTORE)	+= fpu.o
>  CFLAGS_fpu.o   += -mdpfp
> diff --git a/arch/arc/kernel/jump_label.c b/arch/arc/kernel/jump_label.c
> new file mode 100644
> index 000000000000..9755895c312f
> --- /dev/null
> +++ b/arch/arc/kernel/jump_label.c
> @@ -0,0 +1,167 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/kernel.h>
> +#include <linux/jump_label.h>
> +
> +#include "asm/cacheflush.h"
> +
> +#define JUMPLABEL_ERR	"ARC: jump_label: ERROR: "
> +
> +/* Halt system on fatal error to make debug easier */
> +#define arc_jl_fatal(format...)						\
> +({									\
> +	pr_err(JUMPLABEL_ERR format);					\
> +	BUG();								\
> +})
> +
> +static inline u32 arc_gen_nop(void)
> +{
> +	/* 1x 32bit NOP in middle endian */
> +	return 0x7000264a;
> +}
> +
> +static inline bool cross_l1_ifetch_block(void *addr, int len)
> +{
> +	unsigned long a = (unsigned long)addr;
> +	unsigned long ifetch_blk_shift = __fls(I_CACHE_FETCH_BLOCK_WIDTH);
> +
> +	return (a >> ifetch_blk_shift) != ((a + len - 1) >> ifetch_blk_shift);
> +}
> +
> +/*
> + * ARCv2 'Branch unconditionally' instruction:
> + * 00000ssssssssss1SSSSSSSSSSNRtttt
> + * s S[n:0] lower bits signed immediate (number is bitfield size)
> + * S S[m:n+1] upper bits signed immediate (number is bitfield size)
> + * t S[24:21] upper bits signed immediate (branch unconditionally far)
> + * N N <.d> delay slot mode
> + * R R Reserved
> + */
> +static inline u32 arc_gen_branch(jump_label_t pc, jump_label_t target)
> +{
> +	u32 instruction_l, instruction_r;
> +	u32 pcl = pc & GENMASK(31, 2);
> +	u32 u_offset = target - pcl;
> +	u32 s, S, t;
> +
> +	/*
> +	 * Offset in 32-bit branch instruction must to fit into s25.
> +	 * Something is terribly broken if we get such huge offset within one
> +	 * function.
> +	 */
> +	if ((s32)u_offset < -16777216 || (s32)u_offset > 16777214)
> +		arc_jl_fatal("gen branch with offset (%d) not fit in s25",
> +			     (s32)u_offset);
> +
> +	/*
> +	 * All instructions are aligned by 2 bytes so we should never get offset
> +	 * here which is not 2 bytes aligned.
> +	 */
> +	if (u_offset & 0x1)
> +		arc_jl_fatal("gen branch with offset (%d) unaligned to 2 bytes",
> +			     (s32)u_offset);
> +
> +	s = (u_offset >> 1)  & GENMASK(9, 0);
> +	S = (u_offset >> 11) & GENMASK(9, 0);
> +	t = (u_offset >> 21) & GENMASK(3, 0);
> +
> +	/* 00000ssssssssss1 */
> +	instruction_l = (s << 1) | 0x1;
> +	/* SSSSSSSSSSNRtttt */
> +	instruction_r = (S << 6) | t;
> +
> +	return (instruction_r << 16) | (instruction_l & GENMASK(15, 0));
> +}
> +
> +void arch_jump_label_transform(struct jump_entry *entry,
> +			       enum jump_label_type type)
> +{
> +	jump_label_t *instr_addr = (jump_label_t *)entry->code;
> +	u32 instr;
> +
> +	/*
> +	 * Atomic update of patched instruction is only available if this
> +	 * instruction doesn't cross L1 I$ fetch block boundary (it's smaller
> +	 * than L1 I$ line size). You can read about the way we achieve this in
> +	 * arc/include/asm/jump_label.h
> +	 */
> +	if (cross_l1_ifetch_block(instr_addr, JUMP_LABEL_NOP_SIZE))
> +		arc_jl_fatal("instruction (addr %px) cross L1 cache fetch block",
> +			     instr_addr);
> +
> +	if (type == JUMP_LABEL_JMP)
> +		instr = arc_gen_branch(entry->code, entry->target);
> +	else
> +		instr = arc_gen_nop();
> +
> +	WRITE_ONCE(*instr_addr, instr);
> +	flush_icache_range(entry->code, entry->code + JUMP_LABEL_NOP_SIZE);
> +}
> +
> +void arch_jump_label_transform_static(struct jump_entry *entry,
> +				      enum jump_label_type type)
> +{
> +	/*
> +	 * We use only one NOP type (1x, 4 byte) in arch_static_branch, so
> +	 * there's no need to patch an identical NOP over the top of it here.
> +	 * The generic code calls 'arch_jump_label_transform' if the NOP needs
> +	 * to be replaced by a branch, so 'arch_jump_label_transform_static' is
> +	 * never called with type other than JUMP_LABEL_NOP.
> +	 */
> +	BUG_ON(type != JUMP_LABEL_NOP);
> +}
> +
> +#ifdef CONFIG_ARC_DBG_JUMP_LABEL
> +#define SELFTEST_MSG	"ARC: instruction generation self-test: "
> +
> +struct arc_gen_branch_testdata {
> +	jump_label_t pc;
> +	jump_label_t target_address;
> +	u32 expected_instr;
> +};
> +
> +static __init int branch_gen_test(struct arc_gen_branch_testdata *test_data)
> +{
> +	u32 instr_got;
> +
> +	instr_got = arc_gen_branch(test_data->pc, test_data->target_address);
> +	if (instr_got == test_data->expected_instr)
> +		return 0;
> +
> +	pr_err(SELFTEST_MSG "FAIL:\n arc_gen_branch(0x%08x, 0x%08x) != 0x%08x, got 0x%08x\n",
> +	       test_data->pc, test_data->target_address,
> +	       test_data->expected_instr, instr_got);
> +
> +	return -EFAULT;
> +}
> +
> +static __init int instr_gen_test(void)
> +{
> +	int i;
> +
> +	struct arc_gen_branch_testdata test_data[] = {
> +		{0x90007548, 0x90007514, 0xffcf07cd}, /* tiny (-52) offs */
> +		{0x9000c9c0, 0x9000c782, 0xffcf05c3}, /* tiny (-574) offs */
> +		{0x9000cc1c, 0x9000c782, 0xffcf0367}, /* tiny (-1178) offs */
> +		{0x9009dce0, 0x9009d106, 0xff8f0427}, /* small (-3034) offs */
> +		{0x9000f5de, 0x90007d30, 0xfc0f0755}, /* big  (-30892) offs */
> +		{0x900a2444, 0x90035f64, 0xc9cf0321}, /* huge (-443616) offs */
> +		{0x90007514, 0x9000752c, 0x00000019}, /* tiny (+24) offs */
> +		{0x9001a578, 0x9001a77a, 0x00000203}, /* tiny (+514) offs */
> +		{0x90031ed8, 0x90032634, 0x0000075d}, /* tiny (+1884) offs */
> +		{0x9008c7f2, 0x9008d3f0, 0x00400401}, /* small (+3072) offs */
> +		{0x9000bb38, 0x9003b340, 0x17c00009}, /* big  (+194568) offs */
> +		{0x90008f44, 0x90578d80, 0xb7c2063d}  /* huge (+5701180) offs */
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(test_data); i++)
> +		if (branch_gen_test(&test_data[i]))
> +			return -EFAULT;
> +
> +	pr_info(SELFTEST_MSG "OK\n");
> +
> +	return 0;
> +}
> +early_initcall(instr_gen_test);
> +
> +#endif /* CONFIG_ARC_DBG_JUMP_LABEL */
> 

